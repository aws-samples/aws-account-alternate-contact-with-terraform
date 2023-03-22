resource "aws_iam_role" "alternate_contact_role" {
  name                = var.alternate_contact_role
  managed_policy_arns = [aws_iam_policy.account_management_policy.arn]
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_policy" "account_management_policy" {
  name   = var.alternate_contact_policy
  policy = data.aws_iam_policy_document.account_management_policy.json

  tags = var.tags
}

resource "aws_lambda_function" "alternate_contact_lambda" {
  #checkov:skip=CKV_AWS_50:Disabled Xray tracing
  #checkov:skip=CKV_AWS_116
  #checkov:skip=CKV_AWS_117
  #checkov:skip=CKV_AWS_173
  filename                       = "${path.module}/lambda/alternate-contact.zip"
  function_name                  = var.lambda_function_name
  role                           = aws_iam_role.alternate_contact_role.arn
  reserved_concurrent_executions = var.reserved_concurrent_executions
  handler                        = "alternate-contact.lambda_handler"
  runtime                        = "python3.9"
  timeout                        = "180"      # Experience show it takes about 21 seconds

  tags = var.tags
  environment {
    variables = {
      security_alternate_contact = var.security_alternate_contact
      billing_alternate_contact = var.billing_alternate_contact
      operations_alternate_contact = var.operations_alternate_contact
      management_account_id = var.management_account_id
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_run" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alternate_contact_lambda.function_name
  principal     = "events.amazonaws.com"
}

# fix to run lambda during apply only
# https://github.com/hashicorp/terraform-provider-aws/issues/4746
data "aws_lambda_invocation" "run" {
  count         = var.invoke_lambda ? 1 : 0
  function_name = aws_lambda_function.alternate_contact_lambda.function_name
  input         = <<JSON
{
  "APPLY_DATE": "${formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())}"
}
JSON
}

resource "aws_cloudwatch_log_group" "alternate_contact_loggroup" {
  #checkov:skip=CKV_AWS_158:Using default CloudWatch encryption
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_group_retention

  tags = var.tags
}

resource "aws_cloudwatch_event_bus" "aws_alternate_contact_bus" {
  name = var.aws_alternate_contact_bus

  tags = var.tags
}

resource "aws_cloudwatch_event_bus_policy" "aws_alternate_contact_bus" {
  policy         = data.aws_iam_policy_document.aws_alternate_contact_bus.json
  event_bus_name = aws_cloudwatch_event_bus.aws_alternate_contact_bus.name
}

resource "aws_cloudwatch_event_rule" "event_rule_cross_account" {
  name           = var.event_rule_name
  description    = var.event_rule_description
  event_bus_name = aws_cloudwatch_event_bus.aws_alternate_contact_bus.name

  tags          = var.tags
  event_pattern = <<EOF
{
  "detail": {
    "eventName" : ["CreateAccountResult"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "aws_alternate_contact_lambda" {
  depends_on = [
    aws_cloudwatch_event_rule.event_rule_cross_account
  ]
  rule           = aws_cloudwatch_event_rule.event_rule_cross_account.name
  target_id      = "SendToAWSLambda"
  arn            = aws_lambda_function.alternate_contact_lambda.arn
  event_bus_name = aws_cloudwatch_event_bus.aws_alternate_contact_bus.name
}

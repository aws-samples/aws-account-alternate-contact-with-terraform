resource "aws_cloudwatch_event_rule" "event_rule_cross_account" {
  name        = var.event_rule_name
  description = var.event_rule_description

  tags          = var.tags
  event_pattern = <<EOF
{
  "detail": {
    "eventName" : ["CreateAccountResult"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "cross_account_bus" {
  rule      = aws_cloudwatch_event_rule.event_rule_cross_account.name
  target_id = "SendToEventBus"
  arn       = var.delegated_account_event_bus
  role_arn  = aws_iam_role.event_bus_role.arn
}

resource "aws_iam_role" "event_bus_role" {
  name                = var.event_bus_role
  managed_policy_arns = [aws_iam_policy.event_bus_policy.arn]
  assume_role_policy  = data.aws_iam_policy_document.events_assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_policy" "event_bus_policy" {
  name   = var.event_bus_policy
  policy = data.aws_iam_policy_document.event_bus_policy.json

  tags = var.tags
}
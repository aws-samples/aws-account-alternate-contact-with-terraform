data "aws_organizations_organization" "account_info" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda/alternate-contact.zip"
  source_file = "${path.module}/lambda/alternate-contact.py"
}

# AWS Account Management and Lambda Permissions
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    sid     = "AllowLambdaSTSAssume"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "account_management_policy" {
  #checkov:skip=CKV_AWS_111:Permission is constrained with a PrincipalOrgID condition
  statement {
    sid    = "AllowAccountMgmt"
    effect = "Allow"
    actions = [
      "account:GetAlternateContact",
      "account:PutAlternateContact",
      "account:DeleteAlternateContact",
      "organizations:ListAccounts",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values = [
        "${data.aws_organizations_organization.account_info.id}"
      ]
    }
  }

  statement {
    sid    = "AllowLambdaDefaultPermissions"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:StartQuery",
      "logs:PutMetricFilter",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:PutMetricData",
      "cloudwatch:PutDashboard",
      "cloudwatch:GetDashboard",
      "cloudwatch:EnableAlarmActions",
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values = [
        "${data.aws_organizations_organization.account_info.id}"
      ]
    }
  }
}

data "aws_iam_policy_document" "aws_alternate_contact_bus" {
  statement {
    sid    = "ManagementAccountAccess"
    effect = "Allow"
    actions = [
      "events:PutEvents",
    ]
    resources = [
      "${aws_cloudwatch_event_bus.aws_alternate_contact_bus.arn}"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.management_account_id}:root"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values = [
        "${data.aws_organizations_organization.account_info.id}"
      ]
    }
  }
}
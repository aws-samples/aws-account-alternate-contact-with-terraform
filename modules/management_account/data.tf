data "aws_organizations_organization" "account_info" {}

data "aws_iam_policy_document" "events_assume_role_policy" {
  statement {
    sid     = "AllowEventsSTSAssume"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "event_bus_policy" {
  statement {
    sid    = "AllowCrossAcctBus"
    effect = "Allow"
    actions = [
      "events:PutEvents",
    ]
    resources = [
      "${var.delegated_account_event_bus}"
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
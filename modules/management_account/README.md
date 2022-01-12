# `aws-account-alternate-contact-with-terraform/management_account`

## Description

This Terraform module implements an AWS IAM role and Amazon EventBridge rule attached to the account's default EventBridge event bus. The EventBridge rule consists of a cross-account event trigger that invokes the Lambda function in your delegated account when a new account is added to your AWS Organizations.


## Resources

| Name                            | Type         |
| ---------                       |----          |
| aws_iam_role                    | Resource     |
| aws_iam_policy                  | Resource     |
| aws_cloudwatch_event_rule       | Resource     |
| aws_cloudwatch_event_target     | Resource     |


## Input variables

All variable details can be found in the [variables.tf](./variables.tf) file.

| Variable Name               | Description                                                                      | Type         |  Default                      | Required |
| -------------               | -----------                                                                      | --------     | -----                         |--------  |
| `delegated_account_event_bus`| The ARN of the delegated account event bus                                      | `string`     |                               | Yes      |
| `event_rule_name`           | The name of the EventBridge Rule to trigger the AWS Lambda function              | `string`     | aws-alternate-contact-rule    | Yes      |
| `event_rule_description`    | The description of the EventBridge rule     | `string`     | EventBridge rule to trigger the alternate contact Lambda function  | No       |
| `event_bus_role`            | The name of the EvetBridge IAM role                                   | `string`     |aws-eventbridge-alternate-contact-role    | Yes      |
| `event_bus_policy`          | The name of the EvetBridge IAM policy                                 | `string`     | aws-eventbridge-alternate-contact-policy | Yes      |
| `tags`                      | A map of tags to assign to the resource                                          | `map(string)`|                               | No       |


## Outputs

All output details can be found in [tf-aws-alternate-contact/delegated_account/outputs.tf](outputs.tf).

| Variable Name               | Description                                                             |
| -------------               | -----------                                                             |
| `event_rule_cross_account`  | The Amazon Resource Name (ARN) of the EventBridge rule                  |
| `event_bus_role`            | The Amazon Resource Name (ARN) specifying the event bus IAM role        |

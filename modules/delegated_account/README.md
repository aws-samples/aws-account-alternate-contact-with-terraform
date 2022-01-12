# `aws-account-alternate-contact-with-terraform/delegated_account`


## Description

This Terraform module implements a custom Amazon EventBridge event bus, EventBridge Rule, AWS IAM roles, and AWS Lambda function to programmatically configure your alternate contact. The Lambda function obtains a list of accounts in your AWS Organizations and configures the alternate contact across all accounts using the Lambda environment variables supplied as input to the module. You can invoke the Lambda function by setting the `invoke_lambda` variable as `true`.

By default, this module creates a deployment package and uses it to create or update a Lambda Function or Lambda Layer.


## Resources

| Name                            | Type         |
| ---------                       |----          |
| aws_iam_role                    | Resource     |
| aws_iam_policy                  | Resource     |
| aws_lambda_function             | Resource     |
| aws_lambda_permission           | Resource     |
| aws_cloudwatch_log_group        | Resource     |
| aws_cloudwatch_event_bus        | Resource     |
| aws_cloudwatch_event_bus_policy | Resource     |
| aws_cloudwatch_event_rule       | Resource     |
| aws_cloudwatch_event_target     | Resource     |


## Input variables

All variable details can be found in the [variables.tf](./variables.tf) file.

| Variable Name               | Description                                                                      | Type         |  Default                      | Required |
| -------------               | -----------                                                                      | --------     | -----                         |--------  |
| `management_account_id`     | The account ID of the AWS Organizations Management account.                      | `string`     |                               | Yes      |
| `alternate_contact_type`    | The alternate contact details. Valid values are: SECURITY, BILLING, OPERATIONS   | `map(string)`| {}                            | Yes      |
| `alternate_contact_role`    | The AWS IAM role name that will be given to the AWS Lambda execution role        | `string`     | aws-alternate-contact-iam-role   | Yes   |
| `alternate_contact_policy`  | The name that will be given to the Lambda execution IAM policy                   | `string`     | aws-alternate-contact-iam-policy | Yes   |
| `lambda_function_name`      | The name of the AWS Lambda function                                              | `string`     | aws-alternate-contact         | Yes      |
| `log_group_retention`       | The number of days you want to retain log events in the specified log group      | `number`     | 60                            | No       |
| `reserved_concurrent_executions` | The amount of reserved concurrent executions for this Lambda Function       | `number`     | -1                            | No       |
| `event_rule_name`           | The name of the EventBridge Rule to trigger the AWS Lambda function              | `string`     | aws-alternate-contact-rule    | Yes      |
| `event_rule_description`    | The description of the EventBridge rule     | `string`     | EventBridge rule to trigger the alternate contact Lambda function  | No       |
| `aws_alternate_contact_bus` | The name of the custom event bus                                                 | `string`     | aws-alternate-contact         | Yes      |
| `invoke_lambda`             | Controls if Lambda function should be invoked                                    | `bool`       |                               | No       |
| `tags`                      | A map of tags to assign to the resource                                          | `map(string)`|                               | No       |


## Outputs

All output details can be found in [aws-account-alternate-contact-with-terraform/delegated_account/outputs.tf](outputs.tf).

| Variable Name             | Description                                                             |
| -------------             | -----------                                                             |
| `delegated_account_bus`   | The ARN of the custom event bus in the delegated account                |
| `event_rule_cross_account`| The Amazon Resource Name (ARN) of the EventBridge rule                  |
| `alternate_contact_role`  | The Amazon Resource Name (ARN) specifying the Lambda IAM role           |
| `aws_lambda_function`     | The Amazon Resource Name (ARN) identifying the Lambda Function          |

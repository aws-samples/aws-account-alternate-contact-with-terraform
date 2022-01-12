variable "management_account_id" {
  type        = string
  description = "The account ID of the AWS Organizations Management account"
}

variable "alternate_contact_type" {
  type        = map(string)
  description = "The alternate contact details. Valid values for ALT_CONTACT_TYPE are: SECURITY, BILLING, OPERATIONS"
  default     = {}
}

variable "alternate_contact_role" {
  type        = string
  description = "The AWS IAM role name that will be given to the AWS Lambda execution role."
  default     = "aws-alternate-contact-iam-role"
}

variable "alternate_contact_policy" {
  type        = string
  description = "The name that will be given to the Lambda execution IAM policy."
  default     = "aws-alternate-contact-iam-policy"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the AWS Lambda function"
  default     = "aws-alternate-contact"
}

variable "log_group_retention" {
  type        = number
  description = <<-EOT
  The number of days you want to retain log events in the specified log group. 
  Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0
  If you select 0, the events in the log group are always retained and never expire.
  EOT
  default     = 60
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda Function. A value of 0 disables Lambda Function from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  type        = number
  default     = -1
}

variable "event_rule_name" {
  type        = string
  description = "The name of the EventBridge Rule to trigger the AWS Lambda function"
  default     = "aws-alternate-contact-rule"
}

variable "event_rule_description" {
  type        = string
  description = "The description of the EventBridge rule"
  default     = "EventBridge rule to trigger the alternate contact Lambda function"
}

variable "aws_alternate_contact_bus" {
  type        = string
  description = "The name of the custom event bus"
  default     = "aws-alternate-contact"
}

variable "invoke_lambda" {
  description = "Controls if Lambda function should be invoked"
  type        = bool
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
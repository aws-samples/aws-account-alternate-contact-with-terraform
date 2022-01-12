variable "delegated_account_event_bus" {
  type        = string
  description = "The ARN of the delegated account event bus"
}

variable "event_rule_name" {
  type        = string
  description = "The name of the EventBridge Rule to trigger the cross-account target"
  default     = "aws-alternate-contact-rule"
}

variable "event_rule_description" {
  type        = string
  description = "The description of the EventBridge rule"
  default     = "Triggers a cross-account event bus in the delegated AWS Account Management  account"
}

variable "event_bus_role" {
  type        = string
  description = "The name of the EvetBridge IAM role"
  default     = "aws-eventbridge-alternate-contact-role"
}

variable "event_bus_policy" {
  type        = string
  description = "The name of the EvetBridge IAM policy"
  default     = "aws-eventbridge-alternate-contact-policy"
}

variable "tags" {
  description = "A map of tags to assign to the resource "
  type        = map(string)
}
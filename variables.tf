variable "region" {
  type        = string
  description = "The home AWS Region of the AWS Organizations management account"
}

variable "management_account_id" {
  type        = string
  description = "The account ID of the AWS Organizations Management account"
}

variable "alternate_contact_type" {
  type        = map(string)
  description = "A map of string that highlights the alternate contact details. Valid values for ALT_CONTACT_TYPE are: SECURITY, BILLING, OPERATIONS"
}

variable "invoke_lambda" {
  description = "Controls if Lambda function should be invoked"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
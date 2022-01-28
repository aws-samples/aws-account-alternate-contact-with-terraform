variable "region" {
  type        = string
  description = "The home AWS Region of the AWS Organizations management account"
}

variable "management_account_id" {
  type        = string
  description = "The account ID of the AWS Organizations Management account"
}

variable "security_alternate_contact" {
  type        = string
  description = "The security alternate contact details. Example: CONTACT_TYPE=SECURITY; EMAIL_ADDRESS=john@example.com; CONTACT_NAME=John Bob; PHONE_NUMBER=1234567890; CONTACT_TITLE=Risk Manager"
  default     = ""
}

variable "billing_alternate_contact" {
  type        = string
  description = "The billing alternate contact details. Example: CONTACT_TYPE=BILLING; EMAIL_ADDRESS=alice@example.com; CONTACT_NAME=Alice Doe; PHONE_NUMBER=1234567890; CONTACT_TITLE=Finance Manager"
  default     = ""
}

variable "operations_alternate_contact" {
  type        = string
  description = "The operations alternate contact details. Example: CONTACT_TYPE=OPERATIONS; EMAIL_ADDRESS=bob@example.com; CONTACT_NAME=Bob Smith; PHONE_NUMBER=1234567890; CONTACT_TITLE=Operations Manager"
  default     = ""
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

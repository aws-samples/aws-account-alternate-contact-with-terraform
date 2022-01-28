output "delegated_account_event_bus" {
  value       = module.delegated_admin_account.delegated_account_bus
  description = "The ARN of the custom event bus in the delegated account"
}

output "delegated_account_event_rule" {
  value       = module.delegated_admin_account.event_rule_cross_account
  description = "The Amazon Resource Name (ARN) of the EventBridge rule in the delegated account"
}

output "delegated_account_lambda_function" {
  value       = module.delegated_admin_account.aws_lambda_function
  description = "The Amazon Resource Name (ARN) identifying the Lambda Function in the delegated account"
}

output "management_account_event_bus_role" {
  value       = module.management_account.event_bus_role
  description = "The Amazon Resource Name (ARN) specifying the event bus IAM role in the management account"
}

output "event_rule_cross_account" {
  value       = aws_cloudwatch_event_rule.event_rule_cross_account.arn
  description = "The Amazon Resource Name (ARN) of the EventBridge rule"
}

output "event_bus_role" {
  value       = aws_iam_role.event_bus_role.arn
  description = "The Amazon Resource Name (ARN) specifying the event bus IAM role"
}
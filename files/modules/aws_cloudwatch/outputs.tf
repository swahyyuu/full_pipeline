output "start_event_rule_arn" {
  description = "Amazon Resource Name of event rule for start"
  value       = aws_cloudwatch_event_rule.start.arn
}

output "stop_event_rule_arn" {
  description = "Amazon Resource Name of event rule for stop"
  value       = aws_cloudwatch_event_rule.stop.arn
}

output "start_lambda_func_arn" {
  description = "Amazon Resource Name of lambda function for start"
  value       = aws_lambda_function.start.arn
}

output "stop_lambda_func_arn" {
  description = "Amazon Resource Name of lambda function for stop"
  value       = aws_lambda_function.stop.arn
}

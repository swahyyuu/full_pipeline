output "lambda_role_arn" {
  description = "Amazon Resource Name (ARN) of Lambda role"
  value       = aws_iam_role.lambda.arn
}

resource "aws_lambda_function" "start" {
  s3_bucket     = var.bucket_name
  s3_key        = var.start_lambda
  function_name = "terraform_start_instance"
  role          = var.role_arn
  handler       = var.start_handler
  description   = "Lambda function to start instance in specific time"

  runtime = var.runtime
  timeout = 300
}

resource "aws_lambda_permission" "allow_start_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.start_event_rule_arn
}

resource "aws_lambda_function" "stop" {
  s3_bucket     = var.bucket_name
  s3_key        = var.stop_lambda
  function_name = "terraform_stop_instance"
  role          = var.role_arn
  handler       = var.stop_handler
  description   = "Lambda function to start instance in specific time"

  runtime = var.runtime
  timeout = 300
}

resource "aws_lambda_permission" "allow_stop_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.stop_event_rule_arn
}

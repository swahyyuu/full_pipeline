resource "aws_cloudwatch_event_rule" "start" {
  name                = "terra_start_instance"
  description         = "Trigger Ec2 instance to start"
  schedule_expression = "cron(0 14 * * ? *)"
}


resource "aws_cloudwatch_event_target" "start" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.start.name
  arn       = var.start_arn
}

resource "aws_cloudwatch_event_rule" "stop" {
  name                = "terra_stop_instance"
  description         = "Trigger Ec2 instance to stop"
  schedule_expression = "cron(15 14 * * ? *)"
}

resource "aws_cloudwatch_event_target" "stop" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.stop.name
  arn       = var.stop_arn
}

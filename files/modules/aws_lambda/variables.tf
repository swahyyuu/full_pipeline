variable "start_lambda" {
  type        = string
  description = "File within s3 bucket to start instance"
}

variable "stop_lambda" {
  type        = string
  description = "File within s3 bucket to stop instance"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name of s3"
}

variable "start_handler" {
  type        = string
  description = "function name of lambda handler for start"
  default     = "lambda_start.lambda_handler"
}

variable "stop_handler" {
  type        = string
  description = "function name of lambda handler for stop"
  default     = "lambda_stop.lambda_handler"
}

variable "runtime" {
  type        = string
  description = "Runtime which used to run lambda script"
  default     = "python3.8"
}

variable "role_arn" {
  type        = string
  description = "Amazon Resource Name of IAM Role"
}

variable "start_event_rule_arn" {
  type        = string
  description = "Amazon Resource Name of Event Rule for start"
}

variable "stop_event_rule_arn" {
  type        = string
  description = "Amazon Resource Name of Event Rule for stop"
}

output "bucket_name" {
  description = "Bucket Name"
  value       = aws_s3_bucket.bucket.bucket
}

output "start_lambda" {
  description = "File to start instance for lambda function"
  value       = data.aws_s3_object.start_lambda.key
}

output "stop_lambda" {
  description = "File to stop instance for lambda function"
  value       = data.aws_s3_object.stop_lambda.key
}


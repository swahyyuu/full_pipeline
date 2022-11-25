output "vpc_id" {
  description = "value of VPC Id"
  value       = module.aws_terra_vpc.vpc_id
}

output "instance_id" {
  description = "Instance Id"
  value       = module.aws_terra_instance.instance_id
}

output "instance_public_id" {
  description = "Instance Public Id"
  value       = module.aws_terra_instance.instance_public_id
}

output "start_lambda_function_arn" {
  description = "Amazon Resource Name of lambda function for start"
  value       = module.aws_terra_lambda.start_lambda_func_arn
}

output "stop_lambda_function_arn" {
  description = "Amazon Resource Name of lambda function for start"
  value       = module.aws_terra_lambda.stop_lambda_func_arn
}

output "lambda_role_arn" {
  description = "Amazon Resource Name of lambda iam role"
  value       = module.aws_terra_iam.lambda_role_arn
}

output "account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "arn" {
  description = "AWS Account ARN"
  value       = data.aws_caller_identity.current.arn
}

output "user_id" {
  description = "AWS User Account ID"
  value       = data.aws_caller_identity.current.user_id
}

output "kms_key" {
  description = "Key Id for KMS"
  value       = module.aws_terra_kms.aws_kms_key
}

output "kms_key_alias_name" {
  description = "Alias name of the key"
  value       = module.aws_terra_kms.kms_key_alias_name
}

output "bucket_name" {
  description = "Bucket Name"
  value       = module.aws_terra_bucket.bucket_name
}
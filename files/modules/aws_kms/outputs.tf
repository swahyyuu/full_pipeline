output "kms_key_id" {
  description = "Key Id for KMS"
  value       = aws_kms_alias.kms_alias.target_key_id
}

output "kms_key_arn" {
  description = "ARN for KMS"
  value       = aws_kms_key.key_bucket.arn
}

output "kms_key_alias_name" {
  description = "Alias name of the key"
  value       = aws_kms_alias.kms_alias.name
}

output "aws_kms_key" {
  description = "Key Id for KMS"
  value       = aws_kms_key.key_bucket.id
}

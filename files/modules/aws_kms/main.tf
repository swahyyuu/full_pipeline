resource "aws_kms_key" "key_bucket" {
  description             = "KMS for encrypt S3 bucket"
  tags                    = var.tags
  deletion_window_in_days = var.kms_deletion_window_days
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/${lower(var.kms_key_alias)}"
  target_key_id = aws_kms_key.key_bucket.key_id
}

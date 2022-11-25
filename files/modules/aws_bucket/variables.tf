variable "s3_bucket_name" {
  type        = string
  description = "A global unique name of s3 bucket name"
  default     = "minithor-s3-terra-bucket-is-so-unique"
}

variable "tags" {
  type = map(string)
  default = {
    "Purpose"    = "Terra-demo",
    "CostCenter" = "infra"
  }
}

variable "kms_key_id" {
  type        = string
  description = "Key Id for KMS"
}

variable "identity_arn" {
  type        = string
  description = "Current user identity for arn"
}

variable "dir_path" {
  type        = string
  description = "Directory which the file stored"
  default     = "modules/python_files/"
}

variable "upload_files" {
  type        = list(string)
  description = "Name of the Files"
  default     = ["lambda_start.zip", "lambda_stop.zip"]
}

variable "kms_key_arn" {
  type        = string
  description = "ARN for KMS"
}

variable "start_file" {
  type        = string
  description = "File name of lambda python for start instance"
  default     = "lambda_start.zip"
}

variable "stop_file" {
  type        = string
  description = "File name of lambda python for stop instance"
  default     = "lambda_stop.zip"
}
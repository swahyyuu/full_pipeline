data "aws_caller_identity" "current" {}

module "aws_terra_vpc" {
  source = "./modules/aws_vpc"
}

module "aws_terra_instance" {
  source     = "./modules/aws_instance"
  vpc_id     = module.aws_terra_vpc.vpc_id
  subnet_id  = module.aws_terra_vpc.subnet_id
  account_id = data.aws_caller_identity.current.account_id
  
  timeouts {
    create = "10m"
  }
}

module "aws_terra_iam" {
  source         = "./modules/aws_iam"
  s3_bucket_name = module.aws_terra_bucket.bucket_name
}

module "aws_terra_lambda" {
  source = "./modules/aws_lambda"
  depends_on = [
    module.aws_terra_bucket
  ]
  role_arn             = module.aws_terra_iam.lambda_role_arn
  start_event_rule_arn = module.aws_terra_cloudwatch.start_event_rule_arn
  stop_event_rule_arn  = module.aws_terra_cloudwatch.stop_event_rule_arn
  start_lambda         = module.aws_terra_bucket.start_lambda
  stop_lambda          = module.aws_terra_bucket.stop_lambda
  bucket_name          = module.aws_terra_bucket.bucket_name
}

module "aws_terra_cloudwatch" {
  source    = "./modules/aws_cloudwatch"
  start_arn = module.aws_terra_lambda.start_lambda_func_arn
  stop_arn  = module.aws_terra_lambda.stop_lambda_func_arn
}

module "aws_terra_kms" {
  source = "./modules/aws_kms"
}

module "aws_terra_bucket" {
  source       = "./modules/aws_bucket"
  kms_key_id   = module.aws_terra_kms.kms_key_id
  identity_arn = data.aws_caller_identity.current.arn
  kms_key_arn  = module.aws_terra_kms.kms_key_arn
}

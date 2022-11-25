resource "aws_s3_bucket" "bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_ssc" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id = "rule-1-logs"

    filter {
      prefix = "logs/"
    }
    status = "Enabled"

    expiration {
      days = 7
    }
  }
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<POLICY
{
    "Version" : "2012-10-17",
    "Id" : "Policy13112022",
    "Statement" : [
      {
        "Sid" : "Stmt131120221",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "${var.identity_arn}"
        },
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::${var.s3_bucket_name}"
      },
      {
        "Sid" : "Stmt131120222",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "${var.identity_arn}"
        },
        "Action" : [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  }  
POLICY
}

resource "aws_s3_object" "object" {
  for_each = fileset("${path.root}/${var.dir_path}", "*.zip")

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "${path.root}/${var.dir_path}/${each.value}"

  etag = filemd5("${path.root}/${var.dir_path}/${each.value}")
}

data "aws_s3_objects" "my_bucket" {
  bucket = aws_s3_bucket.bucket.bucket
}

data "aws_s3_object" "start_lambda" {
  depends_on = [
    aws_s3_object.object
  ]

  bucket = "${aws_s3_bucket.bucket.bucket}"
  key    = var.start_file
}

data "aws_s3_object" "stop_lambda" {
  depends_on = [
    aws_s3_object.object
  ]
   
  bucket = "${aws_s3_bucket.bucket.bucket}"
  key    = var.stop_file
}

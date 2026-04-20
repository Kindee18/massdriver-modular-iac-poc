# [AWS] Modular Storage for Enterprise Landing Zone
# Implements 'Encryption-by-Default' Golden Path.

variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "environment" {
  description = "prod, staging, dev"
  type        = string
}

resource "aws_s3_bucket" "secure_storage" {
  bucket = "${var.bucket_name_prefix}-${var.environment}-${random_string.id.result}"

  tags = {
    Compliance = "NIST-800-53"
    Tier       = "Storage"
  }
}

# Enforcement: Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.secure_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enforcement: Private Access Only
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.secure_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "random_string" "id" {
  length  = 6
  special = false
  upper   = false
}

output "bucket_arn" {
  value = aws_s3_bucket.secure_storage.arn
}

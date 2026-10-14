
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "employee_files" {
  bucket = var.bucket_name

  tags = {
    Project     = "CloudTech"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "employee_files" {
  bucket = aws_s3_bucket.employee_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "employee_files" {
  bucket = aws_s3_bucket.employee_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "employee_files" {
  bucket = aws_s3_bucket.employee_files.id

  versioning_configuration {
    status = "Enabled"
  }
}

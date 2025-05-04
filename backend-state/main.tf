terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

//S3 bucket
resource "aws_s3_bucket" "shurafa_backend_state" {
  bucket = "collaborative-code-editor-backend-state"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "shurafa_backend_state_versioning" {
  bucket = aws_s3_bucket.shurafa_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "shurafa_backend_state_encryption" {
  bucket = aws_s3_bucket.shurafa_backend_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

//Locking - Dynamo DB

resource "aws_dynamodb_table" "shurafa_backend_lock" {
  name         = "CollaborativeCodeEditorProject_locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
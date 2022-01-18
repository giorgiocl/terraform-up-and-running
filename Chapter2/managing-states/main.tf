provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = "terraform-state-bucket-gcampoverde"

  #Prevent accidental deletion of this S3 Bucket
  # lifecycle {
  #   prevent_destroy = true
  # }

  #Enable versioning so we can view the full revision history of our state files 
  versioning {
    enabled = true
  }
  #Enable server side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}

# To use this configuration you need to run the init command followig the next:
# $terraform init
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-gcampoverde"
    key    = "example/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true


  }
}

#To use this configuration you nees to run the init command following the next:
# $ terraform init -backend-config=backend.hcl
# terraform {
#   backend "s3"{

#       key = "example/terraform.tfstate"

#   }
# }

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 Bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the Dynamo Table"
}


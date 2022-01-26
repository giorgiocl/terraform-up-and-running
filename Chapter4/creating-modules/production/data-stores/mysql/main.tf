provider "aws" {
  region = "us-east-2"
}

# To use this configuration you need to run the init command followig the next:
# $terraform init
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-gc593"
    key    = "production/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true


  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running-gc593"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "admin"
  skip_final_snapshot = "true"


  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "mysql-master-password-production"
}

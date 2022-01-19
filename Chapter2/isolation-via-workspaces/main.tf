provider "aws" {
  region = "us-east-2"
}

 resource "aws_instance" "example" {
   ami = "ami-0c55b159cbfafe1f0"
   instance_type = terraform.workspace == "default" ? "t2.micro" : "t2.medium"
 }

# To use this configuration you need to run the init command followig the next:
# $terraform init

terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-gc593"
    key    = "workspaces-examples/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true


  }
}
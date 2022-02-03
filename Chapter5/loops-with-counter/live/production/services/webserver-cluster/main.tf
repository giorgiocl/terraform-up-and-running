provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  //source = "github.com/giorgiocl/terraform-up-and-running-modules//modules/services/webserver-cluster?ref=v.0.0.1"
  source = "/Users/lageovanny.campoverde/Documents/Training/Terraform-Uo-and-Running/Practices-Modules/modules/services/webserver-cluster"

  cluster_name           = "webservers-production"
  db_remote_state_bucket = "terraform-state-bucket-gc593"
  db_remote_state_key    = "production/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.medium"
  min_size      = 3
  max_size      = 5
  enable_autoscalling = true

  

  custom_tags = {
    Owner = "gcampoverde"
    DeployedBy = "terraforms"
  }

}


output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "Load Balancer DNS Name"

}
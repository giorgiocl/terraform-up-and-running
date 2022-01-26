provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "github.com/giorgiocl/terraform-up-and-running-modules//modules/services/webserver-cluster?ref=v.0.0.1"

  cluster_name           = "webservers-production"
  db_remote_state_bucket = "terraform-state-bucket-gc593"
  db_remote_state_key    = "production/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.medium"
  min_size      = 3
  max_size      = 5

}
resource "aws_autoscaling_schedule" "scale_out_during_bussiness_hours" {
  scheduled_action_name = "scale-out-during-bussiness-hours"
  min_size              = 3
  max_size              = 5
  desired_capacity      = 5
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name

}
resource "aws_autoscaling_schedule" "scale_in_at_the_nights" {
  scheduled_action_name = "scale-in-at-the-nights"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name

}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "Load Balancer DNS Name"

}
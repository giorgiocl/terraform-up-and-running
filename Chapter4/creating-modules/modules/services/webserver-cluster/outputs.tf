output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"

}

output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "Autoscaling Group Name"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the security group attached to the load balancer"

}
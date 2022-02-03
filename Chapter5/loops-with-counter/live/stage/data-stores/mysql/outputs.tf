output "address" {
  value       = aws_db_instance.example.address
  description = "MySQL Database Address"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "MySQL Database Port"

}
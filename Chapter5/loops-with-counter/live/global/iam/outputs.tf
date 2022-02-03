# output "neo_arn" {
#   value       = aws_iam_user.example[0].arn
#   description = "ARN for user NEO"
# }

# output "all_arn" {
#   value       = aws_iam_user.example[*].arn
#     description = "The ARNs for all users"
# }


output "all_names" {
  value       = aws_iam_user.example
  description = "All user names created with for_loop function"
}

output "all_arn" {
  value       = values(aws_iam_user.example)[*].arn
  description = "All user names created with for_loop function"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]

}

output "short_upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]

}

output "bios" {
  value = [ for name,role in var.hero_thousand_faces : "${name} is ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces: upper(name) => upper(role)}
}

output "for_directive" {
  value = <<EOF
  %{~ for name in var.user_names }
    ${name}
  %{~ endfor }
  EOF
}
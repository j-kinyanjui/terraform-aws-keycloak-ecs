output "app_iam_instance_profile_name" {
  value = aws_iam_instance_profile.app.name
}

output "ecs_iam_role_name" {
  value = aws_iam_role.ecs_service_role.arn
}

output "ecs_service_iam_role_policy" {
  value = aws_iam_role.ecs_service_role.id
}

output "ecs_password_policy_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

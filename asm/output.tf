output "keycloak_admin_password" {
  value = data.aws_secretsmanager_secret_version.keycloak-admin.arn
  sensitive = true
}

output "rds_username" {
  value = data.aws_secretsmanager_secret_version.rdskeycloakuser.arn
  sensitive = true
}
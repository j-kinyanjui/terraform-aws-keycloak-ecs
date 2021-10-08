output "keycloak_admin_password" {
  value = data.aws_secretsmanager_secret_version.keycloak-admin.secret_string
  sensitive = true
}

output "rds_username" {
  value = data.aws_secretsmanager_secret_version.rdskeycloakuser.secret_string
  sensitive = true
}
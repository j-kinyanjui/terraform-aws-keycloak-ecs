data "aws_secretsmanager_secret_version" "keycloak-admin" {
  secret_id = var.keycloak-admin-username
}

data "aws_secretsmanager_secret_version" "rdskeycloakuser" {
  secret_id = var.rds_username
}

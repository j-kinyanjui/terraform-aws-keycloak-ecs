variable "ecs_desired_instances" {
  description = "The desired number of instances for ECS"
  default     = "1"
}

variable "keycloak_container_name" {
  description = "The name of the ECS container"
  default     = "keycloak"
}

variable "docker_image_url" {
  description = "The URL of the Docker image"
  default     = "jboss/keycloak:13.0.1"
}

variable "keycloak_container_port" {
  description = "The Docker container port"
  default     = 8080
}

variable "postgres_container_port" {
  description = "The Docker container port"
  default     = 5432
}

variable "docker_host_port" {
  description = "The Docker host port"
  default     = 0
}

variable "rds_username" {
  description = "The username for the RDS account"
  default     = "<rds-username>"
}

variable "rds_password" {
  description = "The password for the RDS account"
  default     = "<rds-password>"
}

variable "database_name" {
  description = "Name of the database"
  default     = "keycloakdb"
}

variable "database_hostname" {
  default = "postgres"
}

variable "ecs_cluster_name" {}

variable "ecs_task_family" {
  description = "The ECS task family name"
  default     = "keycloak_task_family"
}

variable "keycloak_admin_username" {
  description = "KeyCloak Admin Username"
}

variable "keycloak_admin_password" {
  description = "KeyCloak Admin Password"
}

variable "app_log_group_name" {}

variable "aws_region" {}

variable "ecs_iam_role_name" {}

variable "alb_target_group_arn" {}

variable "ecs_service_iam_role_policy" {}

variable "alb_listener_front_end" {}

variable "proxy_address_forwarding" {
  default = true
}

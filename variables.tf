variable "aws_region" {
  description = "The AWS region for creating the infrastructure"
  default     = "eu-central-1"
}

variable "key_name" {
  description = "Key name"
  default     = "<key-name>"
}

variable "ecs_cluster_name" {
  default = "ecs_cluster"
}

variable "ecs_log_level" {
  description = "The ECS log level"
  default     = "info"
}

/*variable "admin_cidr_ingress" {
  description = "Admin IP for admin access"
  default     = "<ip range>"
}*/

variable "keycloak_admin_username" {
  description = "Keycloak username"
  default     = "<user-name>"
}

variable "keycloak_admin_password" {
  description = "Keycloak login"
  default     = "<user-pass>"
}

variable "public_dns_name" {
  description = "public DNS Name"
  default     = "<public-dns>"
}

variable "zone_name" {
  description = "Route 53 zone name"
  default     = "<zone-name>"
}
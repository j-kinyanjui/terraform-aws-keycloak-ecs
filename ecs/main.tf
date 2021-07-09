resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

data "template_file" "task_definition" {
  template = file("${path.module}/templates/task-definition.tpl")

  vars = {
    container_name           = var.keycloak_container_name
    log_group_region         = var.aws_region
    log_group_name           = var.app_log_group_name
    keycloak_container_port  = var.keycloak_container_port
    postgres_container_port  = var.postgres_container_port
    host_port                = var.docker_host_port
    keycloak_admin_username  = var.keycloak_admin_username
    keycloak_admin_password  = var.keycloak_admin_password
    database_hostname        = var.database_hostname
    database_port            = var.postgres_container_port
    database_name            = var.rds_name
    rds_username             = var.rds_username
    rds_password             = var.rds_password
    proxy_address_forwarding = var.proxy_address_forwarding
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = var.ecs_task_family
  container_definitions = data.template_file.task_definition.rendered
}

resource "aws_ecs_service" "main" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.ecs_desired_instances
  iam_role        = var.ecs_iam_role_name

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.keycloak_container_name
    container_port   = var.keycloak_container_port
  }

  depends_on = [
    var.alb_listener_front_end,
    var.ecs_service_iam_role_policy
  ]
}

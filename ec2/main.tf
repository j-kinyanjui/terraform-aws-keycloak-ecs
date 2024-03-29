data "aws_ami" "aws-ecs-optimized" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_autoscaling_group" "app" {
  name                 = var.autoscaling_group_name
  vpc_zone_identifier  = var.vpc_zone_identifier
  min_size             = var.autoscaling_min_size
  max_size             = var.autoscaling_max_size
  desired_capacity     = var.autoscaling_desired_size
  launch_configuration = aws_launch_configuration.app.name
}

resource "aws_launch_configuration" "app" {
  security_groups = [var.instance_sg_id]

  //key_name                    = var.key_name
  image_id                    = data.aws_ami.aws-ecs-optimized.id
  instance_type               = var.instance_type
  iam_instance_profile        = var.app_iam_instance_profile_name
  associate_public_ip_address = true
  user_data                   = templatefile(
    "ec2/templates/ecs-userdata.tpl", {
    aws_region         = var.aws_region
    ecs_cluster_name   = var.ecs_cluster_name
    ecs_log_level      = var.ecs_log_level
    ecs_agent_version  = "latest"
    ecs_log_group_name = var.ecs_log_group_name
  })

  lifecycle {
    create_before_destroy = true
  }
}

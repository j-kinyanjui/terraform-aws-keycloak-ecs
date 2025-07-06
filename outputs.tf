output "alb_public_dns" {
  value = module.alb.alb_dns_name
}

output "public_dns_name" {
  value = format("%s/%s", var.public_dns_name, "auth")
}

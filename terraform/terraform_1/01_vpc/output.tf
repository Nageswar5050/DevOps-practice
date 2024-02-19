output "az_list" {
  value = local.az
}

output "nat_ami_id" {
  value = data.aws_ami.nat_ami.id
}

output "frontend_subnet_id" {
  value = local.frontend_subnet_id
}

output "backend_subnet_id" {
  value = local.backend_subnet_id
}

output "databse_subnet_id" {
  value = local.database_subnet_id
}
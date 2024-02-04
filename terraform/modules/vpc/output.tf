output "main_vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "main_igw_id" {
  value = aws_internet_gateway.main_igw.id
}

output "main_az_list" {
  value = local.az_list
}

output "main_frontend_subnet_id" {
  value = local.frontend_subnet_id
}

output "main_backend_subnet_id" {
  value = local.backend_subnet_id
}

output "main_database_subnet_id" {
  value = local.database_subnet_id
}

output "main_ngw_id" {
  value = aws_nat_gateway.main_ngw.id
}

output "main_eip_id" {
  value = aws_eip.main_eip.id
}
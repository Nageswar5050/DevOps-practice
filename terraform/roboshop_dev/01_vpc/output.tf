output "vpc_id" {
  value = module.roboshop_vpc.main_vpc_id
}

output "igw_id" {
  value = module.roboshop_vpc.main_igw
}

output "az_list" {
  value = module.roboshop_vpc.main_az_list
}

output "frontend_subnet_id" {
  value = module.roboshop_vpc.main_frontend_subnet_id
}

output "backend_subnet_id" {
  value = module.roboshop_vpc.main_backend_subnet_id
}

output "database_subnet_id" {
  value = module.roboshop_vpc.main_database_subnet_id
}
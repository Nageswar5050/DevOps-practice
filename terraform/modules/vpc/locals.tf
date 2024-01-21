locals {
  az_list            = slice(data.aws_availability_zones.main_az_list.names, 0, 2)
  frontend_subnet_id = join(",", aws_subnet.main_frontend_subnet[*].id)
  backend_subnet_id  = join(",", aws_subnet.main_backend_subnet[*].id)
  database_subnet_id = join(",", aws_subnet.main_database_subnet[*].id)
}
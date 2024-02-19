locals {
  az = slice(data.aws_availability_zones.az_list.names,0,2)
  frontend_subnet_id = join(",", aws_subnet.main_frontend[*].id)
  backend_subnet_id = join(",", aws_subnet.main_backend[*].id)
  database_subnet_id = join(",", aws_subnet.main_database[*].id)
}
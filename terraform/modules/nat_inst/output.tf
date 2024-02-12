output "main_backend_route_table_id" {
  value = aws_route.main_backend_route_table_route.id
}

output "main_database_route_table_id" {
  value = aws_route.main_database_route_table_route.id
}
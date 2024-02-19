# resource "aws_instance" "main_nat_inst" {
#   ami = data.aws_ami.main_nat_inst_ami.id
#   instance_type = var.instance_type
#   subnet_id = data.aws_ssm_parameter.main_database_subnet_id
#   user_data = 
# }

resource "aws_route" "main_database_route_table_route" {
  route_table_id = data.aws_ssm_parameter.main_database_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_instance.main_nat_inst.id
}

resource "aws_route" "main_backend_route_table_route" {
  route_table_id = data.aws_ssm_parameter.main_backend_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_instance.main_nat_inst.id
}
module "roboshop_nat_inst" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.main_nat_inst_ami.id
  user_data              = file("instance_file.sh")
  subnet_id              = element(split(",", data.aws_ssm_parameter.frontend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 12)]
  tags = {
    Name = "${var.project_name}-${var.environment}-nat_instance"
  }
}

resource "aws_route" "main_database_route_table_route" {
  route_table_id = data.aws_ssm_parameter.main_database_route_table_id.value
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = module.roboshop_nat_inst.primary_network_interface_id
}

resource "aws_route" "main_backend_route_table_route" {
  route_table_id = data.aws_ssm_parameter.main_backend_route_table_id.value
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = module.roboshop_nat_inst.primary_network_interface_id
}
resource "aws_instance" "nat_instance" {
  ami = data.aws_ami.nat_ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main_frontend[0].id
  source_dest_check = false
  tags = {
    Name = "NAT Instance"
  }
}

resource "aws_route" "backend_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.backend_rt.id
  network_interface_id = aws_instance.nat_instance.primary_network_interface_id
}

resource "aws_route" "database_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.database_rt.id
  network_interface_id = aws_instance.nat_instance.primary_network_interface_id
}
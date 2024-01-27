module "roboshop_vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  user_data              = file("openvpn.sh")
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.frontend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 11)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[11]}"
  }
}
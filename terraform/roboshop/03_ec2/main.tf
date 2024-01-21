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

module "roboshop_mongo" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.database_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 0)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[0]}"
  }
}

module "roboshop_mysql" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.database_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 1)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[1]}"
  }
}

module "roboshop_redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.database_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 2)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[2]}"
  }
}

module "roboshop_rabbitmq" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.database_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 3)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[3]}"
  }
}

module "roboshop_catalogue" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 4)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[4]}"
  }
}

module "roboshop_user" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 5)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[5]}"
  }
}

module "roboshop_cart" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 6)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[6]}"
  }
}

module "roboshop_payment" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 7)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[7]}"
  }
}

module "roboshop_shipping" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 8)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[8]}"
  }
}

module "roboshop_dispatch" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 9)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[9]}"
  }
}

module "roboshop_web" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.frontend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 10)]
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[10]}"
  }
}

module "roboshop_ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  user_data              = file("ec2_provision.sh")
  subnet_id              = element(split(",", data.aws_ssm_parameter.frontend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 11)]
  tags = {
    Name = "${var.project_name}-${var.environment}-ansible"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.domain_name

  records = [
    {
      name    = "mongo"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_mongo.private_ip}",
      ]
    },
    {
      name    = "redis"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_redis.private_ip}",
      ]
    },
    {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_mysql.private_ip}",
      ]
    },
    {
      name    = "rabbitmq"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_rabbitmq.private_ip}",
      ]
    },
    {
      name    = "catalogue"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_catalogue.private_ip}",
      ]
    },
    {
      name    = "user"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_user.private_ip}",
      ]
    },
    {
      name    = "cart"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_cart.private_ip}",
      ]
    },
    {
      name    = "shipping"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_shipping.private_ip}",
      ]
    },
    {
      name    = "payment"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_payment.private_ip}",
      ]
    },
    {
      name    = "web"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_web.public_ip}",
      ]
    },
    {
      name    = "dispatch"
      type    = "A"
      ttl     = 1
      records = [
        "${module.roboshop_dispatch.private_ip}",
      ]
    },
  ]
}
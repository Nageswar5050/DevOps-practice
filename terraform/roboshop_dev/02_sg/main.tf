module "roboshop_sg" {
  source         = "../../modules/sg"
  instance_names = var.instance_names
  sg_description = var.sg_description
  project_name   = var.project_name
  environment    = var.environment
  common_tags    = var.common_tags
}

resource "aws_security_group_rule" "vpn_rules_in" {
  security_group_id = module.roboshop_sg.sg_id[11]
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_alb_internrt" {
  security_group_id = module.roboshop_sg.sg_id[13]
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongo_vpn" {
  description              = "mondodb is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[0]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "redis_vpn" {
  description              = "redis is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[2]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "mysql_vpn" {
  description              = "mysql is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[1]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "rabbitmq_vpn" {
  description              = "rabbitmq is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[3]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "catalogue_vpn" {
  description              = "catalogue is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[4]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "user_vpn" {
  description              = "user is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[5]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "cart_vpn" {
  description              = "cart is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[6]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "payment_vpn" {
  description              = "payment is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[7]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "shipping_vpn" {
  description              = "shipping is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[8]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "dispatch_vpn" {
  description              = "dispatch is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[9]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "web_vpn" {
  description              = "web is accepting requests from vpn port 22 (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[11]
  security_group_id        = module.roboshop_sg.sg_id[10]
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "alb_web" {
  description              = "alb is accepting requests from web (because from vpn only we should connect to all internal instances)"
  source_security_group_id = module.roboshop_sg.sg_id[10]
  security_group_id        = module.roboshop_sg.sg_id[12]
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "mongo_catalogue" {
  description              = "mondodb is accepting requests from catalogue port 27017 (because we have to load schema from mongoshell)"
  source_security_group_id = module.roboshop_sg.sg_id[4]
  security_group_id        = module.roboshop_sg.sg_id[0]
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "mongo_user" {
  description              = "mondodb is accepting requests from user port 27017 (because we have to load schema from mongoshell)"
  source_security_group_id = module.roboshop_sg.sg_id[5]
  security_group_id        = module.roboshop_sg.sg_id[0]
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "redis_user" {
  description              = "redis is accepting requests from user port 6379"
  source_security_group_id = module.roboshop_sg.sg_id[5]
  security_group_id        = module.roboshop_sg.sg_id[2]
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "redis_cart" {
  description              = "redis is accepting requests from cart port 6379"
  source_security_group_id = module.roboshop_sg.sg_id[6]
  security_group_id        = module.roboshop_sg.sg_id[2]
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "mysql_shipping" {
  description              = "mysql is accepting requests from shipping port 3306"
  source_security_group_id = module.roboshop_sg.sg_id[8]
  security_group_id        = module.roboshop_sg.sg_id[1]
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  description              = "rabbitmq is accepting requests from payment port 5672"
  source_security_group_id = module.roboshop_sg.sg_id[7]
  security_group_id        = module.roboshop_sg.sg_id[3]
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "catalogue_alb" {
  description              = "catalogue is accepting requests from alb port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[12]
  security_group_id        = module.roboshop_sg.sg_id[4]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "catalogue_cart" {
  description              = "catalogue is accepting requests from cart port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[6]
  security_group_id        = module.roboshop_sg.sg_id[4]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "user_alb" {
  description              = "user is accepting requests from alb port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[12]
  security_group_id        = module.roboshop_sg.sg_id[5]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "user_payment" {
  description              = "user is accepting requests from payment port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[7]
  security_group_id        = module.roboshop_sg.sg_id[5]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "cart_alb" {
  description              = "cart is accepting requests from alb port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[12]
  security_group_id        = module.roboshop_sg.sg_id[6]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "cart_shipping" {
  description              = "cart is accepting requests from shipping port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[8]
  security_group_id        = module.roboshop_sg.sg_id[6]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "cart_payment" {
  description              = "cart is accepting requests from payment port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[7]
  security_group_id        = module.roboshop_sg.sg_id[6]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "shipping_alb" {
  description              = "shipping is accepting requests from alb port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[12]
  security_group_id        = module.roboshop_sg.sg_id[8]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "payment_alb" {
  description              = "payment is accepting requests from alb port 8080"
  source_security_group_id = module.roboshop_sg.sg_id[12]
  security_group_id        = module.roboshop_sg.sg_id[7]
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "alb_web_alb" {
  description       = "alb is accepting requests from web_alb"
  security_group_id = module.roboshop_sg.sg_id[12]
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.roboshop_sg.sg_id[13]
}

resource "aws_security_group_rule" "alb_vpn" {
  description       = "alb is accepting requests from internet port 80"
  security_group_id = module.roboshop_sg.sg_id[12]
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.roboshop_sg.sg_id[11]
}

resource "aws_security_group_rule" "web_interner" {
  description       = "alb is accepting requests from internet port 80"
  security_group_id = module.roboshop_sg.sg_id[10]
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
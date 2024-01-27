resource "aws_lb_target_group" "catalogue_tg" {
  name     = "${var.project_name}-${var.environment}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.roboshop_vpc.value

  health_check {
    path = "/health"
    port = 8080
    healthy_threshold = 2
    unhealthy_threshold = 3
    timeout = 5
    interval = 10
    matcher = "200-299"  # has to be HTTP 200 or fails
  }
}

module "roboshop_catalogue" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ami_id.id
  subnet_id              = element(split(",", data.aws_ssm_parameter.backend_subnet_id.value), 0)
  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 4)]
  #iam_instance_profile = ""
  tags = {
    Name = "${var.project_name}-${var.environment}-${var.instance_names[4]}-ami"
  }
}

resource "null_resource" "catalogue_ami_null" {
  triggers = {
    instance_id = module.roboshop_catalogue.id
  }

  connection {
    host = module.roboshop_catalogue.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue dev"
     ]
  }
}

resource "aws_ec2_instance_state" "stop" {
  instance_id = module.roboshop_catalogue.id
  state       = "stopped"
  depends_on = [ null_resource.catalogue_ami_null ]
}

resource "aws_ami_from_instance" "catalogue_ami" {
  name               = "${var.project_name}-${var.environment}-${var.tags.Component}-${local.current_date}"
  source_instance_id = module.roboshop_catalogue.id
  depends_on = [ aws_ec2_instance_state.stop ]
}

resource "null_resource" "terminate_instance" {
  triggers = {
    instance_id = module.roboshop_catalogue.id
  }

  connection {
    host = module.roboshop_catalogue.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance_ids ${module.roboshop_catalogue.id}"
  }

  depends_on = [ aws_ami_from_instance.catalogue_ami ]
}

resource "aws_launch_template" "catalogue_launch_template" {
  name = "${var.project_name}-${var.environment}"

  image_id = aws_ami_from_instance.catalogue_ami.id

  instance_type = "t2.micro"

  vpc_security_group_ids = [element(split(",", data.aws_ssm_parameter.sg_id.value), 4)]
}

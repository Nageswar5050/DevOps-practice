resource "aws_instance" "main" {
  instance_type = "t2.micro"
  ami = data.aws_ami.ami_id.id
  count = length(var.instance_names)
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  type = list(any)
  default = [
    "Ansible_master",
    "mongo",
    "mysql",
    "redis",
    "rabbitmq",
    "catalogue",
    "user",
    "cart",
    "payment",
    "shipping",
    "dispatch",
    "web"
  ]
}

output "instance_public_ips" {
  value = aws_instance.main[*].public_ip
}

output "instance_private_ips" {
  value = aws_instance.main[*].private_ip
}
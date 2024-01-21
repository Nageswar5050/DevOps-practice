resource "aws_instance" "ec2" {
  ami = var.ami_id
  for_each = {
    mongo = "t2.micro"
    mysql =  "t2.micro"
    web = "t3.micro"
  }
  instance_type = each.value
  tags = {
    Name = each.key
  }
}
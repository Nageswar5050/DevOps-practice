resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
  tags = merge(
    "${var.common_tags}",
    "${var.vpc_tags}",
    {
      Name = "${var.project_name}-${var.environment}"
    }
  )
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    "${var.common_tags}",
    "${var.vpc_tags}",
    {
      Name = "${var.project_name}-${var.environment}"
    }
  )
}

resource "aws_subnet" "main_frontend_subnet" {
  count                   = length("${var.frontend_subnet_cidr}")
  cidr_block              = var.frontend_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = local.az_list[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    "${var.common_tags}",
    "${var.subnet_tags}",
    {
      Name = "${var.project_name}-${var.environment}-frontend-${local.az_list[count.index]}"
    }
  )
}

resource "aws_subnet" "main_database_subnet" {
  count             = length("${var.database_subnet_cidr}")
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = local.az_list[count.index]
  cidr_block        = var.database_subnet_cidr[count.index]
  tags = merge(
    "${var.common_tags}",
    "${var.subnet_tags}",
    {
      Name = "${var.project_name}-${var.environment}-database-${local.az_list[count.index]}"
    }
  )
}

resource "aws_subnet" "main_backend_subnet" {
  count             = length("${var.backend_subnet_cidr}")
  cidr_block        = var.backend_subnet_cidr[count.index]
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = local.az_list[count.index]
  tags = merge(
    "${var.common_tags}",
    "${var.subnet_tags}",
    {
      Name = "${var.project_name}-${var.environment}-backend-${local.az_list[count.index]}"
    }
  )
}

resource "aws_eip" "main_eip" {
  domain = "vpc"
  tags = merge(
    "${var.common_tags}",
    "${var.eip_tags}",
    {
        Name = "${var.project_name}-${var.environment}"
    }
  )
}

resource "aws_nat_gateway" "main_ngw" {
  allocation_id = aws_eip.main_eip.id
  subnet_id = aws_subnet.main_frontend_subnet[0].id
  tags = merge(
    "${var.common_tags}",
    "${var.ngw_tags}",
    {
        Name = "${var.project_name}-${var.environment}"
    }
  )
}

resource "aws_route_table" "main_frontend_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    "${var.common_tags}",
    "${var.rt_tags}",
    {
      Name = "${var.project_name}-${var.environment}-frontend"
    }
  )
}

resource "aws_route_table" "main_backend_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    "${var.common_tags}",
    "${var.rt_tags}",
    {
      Name = "${var.project_name}-${var.environment}-backend"
    }
  )
}

resource "aws_route_table" "main_database_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    "${var.common_tags}",
    "${var.rt_tags}",
    {
      Name = "${var.project_name}-${var.environment}-database"
    }
  )
}

resource "aws_route_table_association" "main_frontend_subnet_rta" {
  count          = length(var.frontend_subnet_cidr)
  subnet_id      = aws_subnet.main_frontend_subnet[count.index].id
  route_table_id = aws_route_table.main_frontend_subnet_rt.id
}

resource "aws_route_table_association" "main_backend_subnet_rta" {
  count          = length(var.backend_subnet_cidr)
  subnet_id      = aws_subnet.main_backend_subnet[count.index].id
  route_table_id = aws_route_table.main_backend_subnet_rt.id
}

resource "aws_route_table_association" "main_database_subnet_rta" {
  count          = length(var.database_subnet_cidr)
  subnet_id      = aws_subnet.main_database_subnet[count.index].id
  route_table_id = aws_route_table.main_database_subnet_rt.id
}

resource "aws_route" "main_frontend_subnet_route" {
  route_table_id         = aws_route_table.main_frontend_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

# resource "aws_instance" "main_ninst" {
#   ami = "ami-0780b09c119334593"
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.main_frontend_subnet[0].id
# }

resource "aws_route" "main_database_subnet_route" {
  route_table_id = aws_route_table.main_database_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.main_ngw.id
}

resource "aws_route" "main_backend_subnet_route" {
  route_table_id = aws_route_table.main_backend_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.main_ngw.id
}
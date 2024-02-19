resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = merge(
    "${var.common_tags}",
    "${var.vpc_tags}"
  )
}

resource "aws_subnet" "main_frontend" {
  vpc_id = aws_vpc.main.id
  availability_zone = local.az[count.index]
  map_public_ip_on_launch = true 
  count = 2
  cidr_block = var.frontend_subnet_cidr[count.index]
  tags = merge("${var.common_tags}",
    "${var.frontend_subnet_tags}",
    {
        Name = "frontend-${local.az[count.index]}"
    }
    )
}

resource "aws_subnet" "main_backend" {
  vpc_id = aws_vpc.main.id
  availability_zone = local.az[count.index]
  count = 2
  cidr_block = var.backend_subnet_cidr[count.index]
  tags = merge("${var.common_tags}",
    "${var.backend_subnet_tags}",
    {
        Name = "backend-${local.az[count.index]}"
    }
    )
}

resource "aws_subnet" "main_database" {
  vpc_id = aws_vpc.main.id
  count = 2
  availability_zone = local.az[count.index]
  cidr_block = var.database_subnet_cidr[count.index]
  tags = merge("${var.common_tags}",
    "${var.database_subnet_tags}",
    {
        Name = "database-${local.az[count.index]}"
    }
    )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge("${var.common_tags}",
    "${var.igw_tags}"
    )
}

resource "aws_route_table" "frontend_rt" {
  vpc_id = aws_vpc.main.id
  tags = merge("${var.common_tags}",
    "${var.frontend_rt_tags}"
    )
}

resource "aws_route_table" "backend_rt" {
  vpc_id = aws_vpc.main.id
  tags = merge("${var.common_tags}",
    "${var.backend_rt_tags}"
    )
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id
  tags = merge("${var.common_tags}",
    "${var.database_rt_tags}"
    )
}

resource "aws_route_table_association" "frontend_rta" {
  count = 2
  subnet_id = aws_subnet.main_frontend[count.index].id
  route_table_id = aws_route_table.frontend_rt.id
}

resource "aws_route_table_association" "backend_rta" {
    count = 2
  subnet_id = aws_subnet.main_backend[count.index].id
  route_table_id = aws_route_table.backend_rt.id
}

resource "aws_route_table_association" "database_rta" {
    count = 2
  subnet_id = aws_subnet.main_database[count.index].id
  route_table_id = aws_route_table.database_rt.id
}

resource "aws_route" "frontend_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
  route_table_id = aws_route_table.frontend_rt.id
}
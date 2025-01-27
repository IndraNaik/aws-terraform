resource "aws_vpc" "tf-vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = "test"
    Name        = "${var.environment}-${var.platform}-vpc"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_default_security_group" "esg_sg" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "${var.environment}-${var.platform}-sg"
  }
}

resource "aws_subnet" "private" {
  for_each = {
    for subnet in local.private_nested_config : subnet.name => subnet
  }

  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = var.az[index(local.private_nested_config, each.value)]
  map_public_ip_on_launch = false

  tags = {
    Environment                       = "test"
    Name                              = each.value.name
    "kubernetes.io/role/internal-elb" = 1
    Resource    = "EC2"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "public" {
  for_each = {
    for subnet in local.public_nested_config : subnet.name => subnet
  }

  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = var.az[index(local.public_nested_config, each.value)]
  map_public_ip_on_launch = true

  tags = {
    Environment              = "test"
    Name                     = each.value.name
    "kubernetes.io/role/elb" = 1
    Resource    = "ELB"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_eip" "nat" {
  for_each = {
    for subnet in local.public_nested_config : subnet.name => subnet
  }

  # vpc = true
  domain = "vpc"

  tags = {
    Environment = "test"
    Name        = "eip-${each.value.name}"
  }
}


resource "aws_eip" "eip-nat" {
  # vpc = true
  domain = "vpc"
  tags = {
    Name        = "${var.environment}-${var.platform}-natip"
    Environment = "${var.environment}"
    Resource    = "NAT Gateway"
  }
}


resource "aws_nat_gateway" "nat-gw" {
  for_each = {
    for subnet in local.public_nested_config : subnet.name => subnet
  }

  allocation_id = aws_eip.nat[each.value.name].id
  subnet_id     = aws_subnet.public[each.value.name].id

  tags = {
    Environment = "test"
    Name        = "nat-${each.value.name}"
  }
}

resource "aws_route_table" "private" {
  for_each = {
    for subnet in local.public_nested_config : subnet.name => subnet
  }

  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw[each.value.name].id
  }

  tags = {
    Environment = "test"
    Name        = "${var.environment}-${each.value.name}-rt"
  }
}

resource "aws_route_table_association" "private" {

  for_each = {
    for subnet in local.private_nested_config : subnet.name => subnet
  }

  subnet_id      = aws_subnet.private[each.value.name].id
  route_table_id = aws_route_table.private[each.value.associated_public_subnet].id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Environment = "test"
    Name        = "${var.environment}-${var.platform}-igw-security"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Environment = "core"
    Name        = "${var.environment}-${var.platform}-public-security-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = {
    for subnet in local.public_nested_config : subnet.name => subnet
  }

  subnet_id      = aws_subnet.public[each.value.name].id
  route_table_id = aws_route_table.public.id
}
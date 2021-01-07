resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example"
  }
}

resource "aws_subnet" "example" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  vpc_id            = aws_vpc.example.id

  map_public_ip_on_launch = true

  tags = {
    Name = "example"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example"
  }
}

resource "aws_route" "example" {
  gateway_id             = aws_internet_gateway.example.id
  route_table_id         = aws_route_table.example.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

resource "aws_security_group" "example" {
  vpc_id = aws_vpc.example.id
  name   = "example"

  tags = {
    Name = "example"
  }
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.example.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "in_icmp" {
  security_group_id = aws_security_group.example.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.example.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}


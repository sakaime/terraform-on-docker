data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.amazon_linux.image_id
  vpc_security_group_ids = [aws_security_group.example.id]
  subnet_id              = aws_subnet.example.id
  key_name               = aws_key_pair.key_pair.id
  instance_type          = "t2.micro"

  tags = {
    Name = "example"
  }
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true
}
resource "aws_key_pair" "deployer" {
  key_name   = "terra-automate-key"
  public_key = file("terra-automate-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_user_to_connect" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity"
  }
}

resource "aws_instance" "testinstance" {
 # count           = 2 #meta argument
  for_each = tomap({
    Test-Instance-1 = "t2.micro",
    Test-Instance-2 = "t2.micro"
  }
  )
  depends_on = [ aws_default_security_group.tf-test_sg, aws_key_pair.deployer ]
  ami             = var.ami_id
  instance_type   = each.value
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_user_to_connect.name]
  tags = {
    Name = each.key
  }
  root_block_device {
    volume_size = var.env == "tf-test" ? 20 : var.ec2_default_root_storage_size 
    volume_type = "gp3"
  }
}
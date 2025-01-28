provider "aws" {
  region = "us-east-1"
  profile = "terraform"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "tf-practice-instance"

  instance_type          = "t2.micro"
  key_name               = "personal"
  monitoring             = true
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = "subnet-xxxxxxxxxxxxxxxxx"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "tf-Instance"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name}"
  description = "Security group for tf EC2 instance"
  vpc_id      =  "vpc-xxxxxxxxxxxxxxxxx"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp","http-22-tcp"]
  egress_rules        = ["all-all"]
}


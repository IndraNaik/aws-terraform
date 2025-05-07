resource "aws_default_vpc" "default" {

}

resource "aws_instance" "jenkins-instance" {
# count = 2
for_each = tomap({

    Jenkins-Master = "t3.medium"
    Jenkins-Slave  = "t2.medium"
})

    ami             = var.ami_id
    instance_type   = each.value
    key_name        = aws_key_pair.jenkins_key_pair.key_name
    security_groups = [ aws_security_group.jenkins_security_group.name ]
    depends_on      = [ aws_security_group.jenkins_security_group, aws_key_pair.jenkins_key_pair ]
    monitoring      = true 
    user_data       = each.key == "Jenkins-Master" ? file("jenkins.sh") : each.key == "Jenkins-Slave" ? file("java-install.sh") : null
    tags = {
        name        = each.key
        description = var.description
        env         = var.env
    }
  
  root_block_device{
    volume_size = var.env == "test" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = "Jenkins-key"
  public_key = file("Jenkins-key.pub")
}

resource "aws_security_group" "jenkins_security_group" {
    name        = "allow TLS"
    description = "This is for jenkins security group"
    vpc_id      = aws_default_vpc.default.id

    ingress {
        description = "port 22 allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description  = "port 8080 allow for Jenkins"
        from_port    = 8080
        to_port      = 8080
        protocol     = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
    }

    egress {

        description  = "allow all outgoing traffic"
        from_port    = 0
        to_port      = 0
        protocol     = -1
        cidr_blocks  = ["0.0.0.0/0"]
    }

    tags = {
        name        = var.name
        description = var.description
        env         = var.env
    }
}
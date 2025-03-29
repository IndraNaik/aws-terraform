variable "name" {
  type    = string
  default = "tf-ec2-sg"
}

variable "private_network_config" {
  type = map(object({
    cidr_block               = string
    associated_public_subnet = string
  }))

  default = {
    "private-tf-1" = {
      cidr_block               = "192.170.0.0/23"
      associated_public_subnet = "public-tf-1"
    },
    "private-tf-2" = {
      cidr_block               = "192.170.2.0/23"
      associated_public_subnet = "public-tf-2"
    }
  }
}

locals {
  private_nested_config = flatten([
    for name, config in var.private_network_config : [
      {
        name                     = name
        cidr_block               = config.cidr_block
        associated_public_subnet = config.associated_public_subnet
      }
    ]
  ])
}

variable "public_network_config" {
  type = map(object({
    cidr_block = string
  }))

  default = {
    "public-tf-1" = {
      cidr_block = "192.170.8.0/23"
    },
    "public-tf-2" = {
      cidr_block = "192.170.10.0/23"
    }
  }
}

locals {
  public_nested_config = flatten([
    for name, config in var.public_network_config : [
      {
        name       = name
        cidr_block = config.cidr_block
      }
    ]
  ])
}

variable "authorized_source_ranges" {
  type        = string
  description = "Addresses or CIDR blocks which are allowed to connect to the tf IP address. The default behavior is to allow anyone (0.0.0.0/0) access. You should restrict access to external IPs that need to access the tf cluster."
  default     = "0.0.0.0/0"
}


variable "az" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "environment" {
  type    = string
  default = "test"
}

variable "platform" {
  type    = string
  default = "tf"
}

variable "vpc_cidr_block" {
  type    = string
  default = "192.170.0.0/16"

}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "rds_user" {
  type    = string
  default = "abcd"
}

variable "rds_password" {
  type    = string
  default = "abcd"
}

variable "docdb_name" {
  type    = string
  default = "tf-test-doc-db"
}

variable "docdb_user" {
  type    = string
  default = "abcd"
}

variable "docdb_password" {
  type    = string
  default = "abcd"
}

variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-east-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-085f9c64a9b75eed5"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.large"
}
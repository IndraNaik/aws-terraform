variable "ami_id" {

description = "This is AMI ID for EC2 Instance"
default     = "ami-085f9c64a9b75eed5"
  
}

variable "name" {
  
  type    = string
  default = "Jenkins"
}

variable "description" {
  
  type    = string
  default = "This is for Jenkins instance"
}

variable "env" {
  
  type    = string
  default = "test"
}

variable "sg_description" {
  
  type    = string
  default = "This is for Jenkins instance security group"
}

variable "ec2_default_root_storage_size" {

    type    = number
    default = 10
  
}
output "ec2_instance_for_each_public_ip" {
  description = "Public ip of Jenkins instance"
  value = [
    for k in aws_instance.jenkins-instance: k.public_ip
  ]
}

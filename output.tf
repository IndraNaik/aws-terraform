output "VPC" {
  description = "VPC Status"
  value       = aws_vpc.tf-vpc.arn
}

output "DocumentDB" {
  description = "DocumentDB Cluster Status"
  value       = aws_docdb_cluster.docdb.cluster_resource_id
}

output "EC2" {
  description = "EC2 Status"
  value       = aws_instance.testinstance.instance_state
}

output "RDS" {
  description = "RDS Status"
  value       = aws_db_instance.tf-test-db.resource_id
}

output "S3" {
  description = "S3 Status"
  value       = aws_s3_bucket.repo_bucket_3.acceleration_status
}

output "EKS" {
  description = "EKS Cluster Status"
  value       = aws_eks_cluster.tf_test_cluster.endpoint
}


// This is for count output
output "ec2_instance_private_ip" {
  value = aws_instance.testinstance[*].private_ip
}

output "ec2_instance_public_ip" {
  value = aws_instance.testinstance[*].public_ip
}

// This is for_each output
output "ec2_instance_for_each_public_ip" {
  value = [
    for k in aws_instance.testinstance :  k.public_ip
  ]
}
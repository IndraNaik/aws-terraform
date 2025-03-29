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
  value       = ec2_instance
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




# AWS Terraform Infrastructure

This repository contains Terraform scripts for provisioning and managing AWS infrastructure, including VPC, EC2 instances, EKS clusters, S3 buckets, RDS, and DocumentDB.

## Features

- **VPC:** Custom VPC setup with public and private subnets.
- **EC2 Instances:** Configurations for launching virtual machines.
- **Amazon S3:** Securely provisioned S3 buckets for storage.
- **Amazon RDS:** Relational Database Service configuration.
- **Amazon DocumentDB:** NoSQL database cluster provisioning.
- **Amazon EKS:** Managed Kubernetes cluster and node group setup.
- **Outputs:** Automatically retrieves essential information (e.g., endpoints, IDs).

## File Structure

- **`docdb.tf`**: Terraform configurations for provisioning Amazon DocumentDB clusters.
- **`ec2.tf`**: EC2 instance configuration and related resources.
- **`eks-cluster.tf`**: EKS cluster setup script.
- **`eks-nodegroup.tf`**: EKS node group setup script.
- **`output.tf`**: Outputs generated after successful provisioning.
- **`provider.tf`**: AWS provider configuration.
- **`rds.tf`**: Amazon RDS configuration for relational databases.
- **`s3.tf`**: Amazon S3 bucket provisioning.
- **`variables.tf`**: Input variables for customization.
- **`vpc.tf`**: VPC configuration with subnets, route tables, and internet gateways.
- **`terraform.tfstate`** and **`terraform.tfstate.backup`**: State files for tracking infrastructure resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) 1.0 or higher
- AWS CLI configured with appropriate credentials
- AWS IAM user with the necessary permissions

## Usage

### Clone the Repository

```bash
git clone https://github.com/IndraNaik/aws-terraform.git
cd aws-terraform

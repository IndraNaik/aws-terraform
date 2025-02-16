# 🌍 AWS Terraform Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-AWS-blueviolet?style=for-the-badge&logo=terraform) ![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazon-aws)

This repository contains Terraform scripts for provisioning and managing AWS infrastructure components such as VPC, EC2 instances, EKS clusters, S3 buckets, RDS, and DocumentDB.

## 🚀 Features

- ✅ **VPC** - Custom Virtual Private Cloud with public and private subnets.
- ✅ **EC2 Instances** - Configurations for launching and managing virtual machines.
- ✅ **Amazon S3** - Secure provisioning of S3 buckets for storage.
- ✅ **Amazon RDS** - Relational Database Service setup for structured data.
- ✅ **Amazon DocumentDB** - NoSQL database cluster provisioning.
- ✅ **Amazon EKS** - Managed Kubernetes cluster with node group configurations.
- ✅ **Outputs** - Automatically retrieves essential resource details (e.g., endpoints, instance IDs).

## 📂 File Structure

```
aws-terraform/
│-- 📄 docdb.tf         # Amazon DocumentDB cluster configuration
│-- 📄 ec2.tf           # EC2 instance setup and related resources
│-- 📄 eks-cluster.tf   # EKS cluster provisioning
│-- 📄 eks-nodegroup.tf # EKS node group configuration
│-- 📄 output.tf        # Outputs generated after provisioning
│-- 📄 provider.tf      # AWS provider configuration
│-- 📄 rds.tf           # Amazon RDS setup
│-- 📄 s3.tf            # Amazon S3 bucket provisioning
│-- 📄 variables.tf     # Input variables for customization
│-- 📄 vpc.tf           # VPC setup with subnets, routes, and gateways
│-- 🗂 terraform.tfstate # State file for tracking infrastructure resources
│-- 🗂 terraform.tfstate.backup # Backup of the state file
```

## ⚙️ Prerequisites

Ensure you have the following installed and configured before using this repository:

- 📌 [Terraform](https://www.terraform.io/downloads) (Version 1.0 or higher)
- 📌 [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- 📌 An AWS IAM user with sufficient permissions to manage infrastructure

## 🛠️ Usage

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/IndraNaik/aws-terraform.git
cd aws-terraform
```

### 2️⃣ Initialize Terraform

```bash
terraform init
```

### 3️⃣ Plan the Deployment

```bash
terraform plan
```

### 4️⃣ Apply the Configuration

```bash
terraform apply -auto-approve
```

### 5️⃣ Destroy Resources (Optional)

If you need to tear down the infrastructure, run:

```bash
terraform destroy -auto-approve
```

## 🔹 Notes

- ⚠️ Ensure your AWS credentials are correctly set up using `aws configure`.
- ⚠️ Modify `variables.tf` to customize parameters as per your needs.
- ⚠️ Use `terraform output` to retrieve key resource information after deployment.

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

📌 For any issues or improvements, feel free to raise a pull request or open an issue in the repository. 🚀


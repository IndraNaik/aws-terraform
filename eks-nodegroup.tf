resource "aws_eks_node_group" "On-demand" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-on-demand-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.private : s.id]

  labels = {
    "type" = "On-demand"
  }

  instance_types = ["m5a.xlarge"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly
  ]

  tags = {
    Environment                                                     = "${var.environment}-${var.platform}"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.tf_test_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = "true"
  }
}



resource "aws_eks_node_group" "Ondemand-memory" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-Ondemand-memory-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.private : s.id]

  labels = {
    "type" = "Ondemand-memory"
  }

  instance_types = ["m5a.xlarge"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment                                                     = "${var.environment}-${var.platform}"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.tf_test_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = "true"
  }
}


resource "aws_eks_node_group" "spot-cpu" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-spot-cpu-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.private : s.id]
  capacity_type   = "SPOT"

  labels = {
    "type" = "spot-cpu"
  }

  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment                                                     = "${var.environment}-${var.platform}"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.tf_test_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = "true"

  }
}


resource "aws_eks_node_group" "spot-memory" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-spot-memory-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.private : s.id]
  capacity_type   = "SPOT"

  labels = {
    "type" = "spot-memory"
  }

  instance_types = ["m5a.xlarge"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment                                                     = "${var.environment}-${var.platform}"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.tf_test_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = "true"
  }
}


resource "aws_eks_node_group" "Ondemand-cpu" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-ondemamd-cpu-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.private : s.id]

  labels = {
    "type" = "Ondemand-cpu"
  }

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment                                                     = "${var.environment}-${var.platform}"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.tf_test_cluster.name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                             = "true"
  }
}


/* resource "aws_eks_node_group" "Virtual-Volunteering" {
  cluster_name    = aws_eks_cluster.tf_test_cluster.name
  node_group_name = "${var.environment}-Virtual-Volunteering-node"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids      = [for s in aws_subnet.public : s.id]

  labels          = {
    "type" = "Virtual-Volunteering"
  }

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Environment = "${var.environment}-${var.platform}"
  }
} */


resource "aws_iam_role" "node-group" {
  name = "us-prod-eks-node-group-role-tf_test"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "node-group-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group.name
}

resource "aws_iam_role_policy_attachment" "node-group-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group.name
}

resource "aws_iam_role_policy_attachment" "node-group-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group.name
}

resource "aws_iam_role_policy" "node-group-ClusterAutoscalerPolicy" {
  name = "eks-cluster-auto-scaler"
  role = aws_iam_role.node-group.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "node-group-AmazonEKS_EBS_CSI_DriverPolicy" {
  name = "AmazonEKS_EBS_CSI_Driver_Policy"
  role = aws_iam_role.node-group.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteSnapshot",
          "ec2:DeleteTags",
          "ec2:DeleteVolume",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications",
          "ec2:DetachVolume",
          "ec2:ModifyVolume"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

/* resource "aws_iam_role" "ebs-csi-controller" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": aws_iam_openid_connect_provider.openid.arn
                },
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringEquals": {
                        "${replace(aws_iam_openid_connect_provider.openid.url, "https://", "")}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
                    }
                }
            }
        ]
    })
} */

resource "aws_security_group" "eks_nodes" {
  name        = "${var.environment}-${var.platform}-cluster/ClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = aws_vpc.tf_test_vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_eks_cluster.tf_test_cluster.vpc_config[0].cluster_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-${var.platform}-cluster/ClusterSharedNodeSecurityGroup"
    Environment = "us-prod"
  }
}
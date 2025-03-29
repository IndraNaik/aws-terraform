resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = var.docdb_name
  engine                  = "docdb"
  master_username         = var.docdb_user
  master_password         = var.docdb_password
  vpc_security_group_ids  = [aws_security_group.docdb_sg.id]
  backup_retention_period = 7
  preferred_backup_window = "07:00-07:30"
  deletion_protection     = true
  skip_final_snapshot     = true
  storage_encrypted       = true
  db_subnet_group_name    = aws_docdb_subnet_group.subnet_group.name
  tags = {
    Name = "${var.environment}-${var.platform}-docdb-cluster"
  }
}

resource "aws_security_group" "docdb_sg" {
  name_prefix = "${var.environment}-${var.platform}-docdb-sg"
  vpc_id      = aws_vpc.tf-vpc.id
  description = "DocumentDB security group"

  ingress {
    description = "Allow DocumentDB traffic from the VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["192.170.0.0/16"]
  }

  ingress {
    description     = "Allow traffic from Bastion host security group"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = ["sg-011261f20dbd36cf1"]
  }

  tags = {
    Name = "${var.environment}-${var.platform}-docdb-sg"
  }
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "docdb-cluster-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
  availability_zone  = "us-east-2a"
  tags = {
    Name = "${var.environment}-${var.platform}-docdb-instance-${count.index}"
  }
}

resource "aws_docdb_cluster_parameter_group" "docdb_parameter_group" {
  family      = "docdb5.0"
  name        = "${var.environment}-${var.platform}-docdb-parameter-group"
  description = "DocumentDB cluster parameter group"

  parameter {
    name  = "tls"
    value = "enabled"
  }
  tags = {
    Name = "${var.environment}-${var.platform}-docdb-parameter-group"
  }
}

resource "aws_docdb_subnet_group" "subnet_group" {
  name        = "${var.environment}-${var.platform}-docdb-subnet-group"
  description = "Subnet group for DocumentDB instance"
  subnet_ids  = [for s in aws_subnet.private : s.id]
  tags = {
    Name = "${var.environment}-${var.platform}-docdb-subnet-group"
  }
}

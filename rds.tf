locals {
  db_name_0       = "tf-test-db" != null ? null : "prod-replica-db-0"
  db_name_1        = "tf-test-db" != null ? null : "prode-replica-db-1"
}

resource "aws_db_parameter_group" "rds_pg" {
  name        = "prod-p3-main-parameter-group"
  family      = "mysql5.7"
  description = "Parameter group for RDS"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }
}

# MySql database 1
resource "aws_db_instance" "tf-test-db" {
  engine                  = "mysql"
  engine_version          = "5.7.38"
  instance_class          = "db.t3.large"
  allocated_storage       = 20
  max_allocated_storage   = 200
  publicly_accessible     = false
  storage_type            = "gp2"
  identifier              = "${var.environment}-${var.platform}-db-1"
  db_name                 = "tf-test-db"
  username                = var.rds_user
  password                = var.rds_password
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_sg.id]
  availability_zone       = "us-east-1a"
  storage_encrypted       = true
  skip_final_snapshot     = true
  performance_insights_enabled = true

  # Additional configuration
  parameter_group_name    = aws_db_parameter_group.rds_pg.id

  # Database authentication
  iam_database_authentication_enabled = false

  #backup
  backup_retention_period             = 7
  backup_window                       = "03:00-04:00"
  final_snapshot_identifier           = "tf-test-db-final-snapshot-75654" 
  delete_automated_backups            = true

  # Maintenance
  auto_minor_version_upgrade          = true
  maintenance_window                  = "Sat:00:00-Sat:02:00"

  # Deletion protection
  deletion_protection                 = true

  tags = {
    Environment = "${var.environment}-${var.platform}"
  } 
}

#MySql Database 2
resource "aws_db_instance" "tf-test-db-2" {
  engine                  = "mysql"
  engine_version          = "5.7.38"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  max_allocated_storage   = 200
  storage_type            = "gp2"
  db_name                 = "heimdall_db"
  username                = var.rds_user
  password                = var.rds_password
  identifier              = "${var.environment}-${var.platform}-db-2"
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_sg.id]
  publicly_accessible     = false
  storage_encrypted       = true
  skip_final_snapshot     = true
  availability_zone       = "us-east-1b"
  performance_insights_enabled = true

  # Additional configuration
  parameter_group_name    = aws_db_parameter_group.rds_pg.id

  #backup
  backup_retention_period             = 7
  backup_window                       = "03:00-04:00"
  final_snapshot_identifier           = "tf-test-db-2-final-snapshot-34654" 
  delete_automated_backups            = true
   
  # Deletion protection
  deletion_protection                 = true

  tags = {
    Environment = "${var.environment}-${var.platform}"
  }

}

#database Security Groups
resource "aws_security_group" "database_sg" {
  name_prefix = "${var.environment}-${var.platform}-database-sg"
  vpc_id = aws_vpc.tf-vpc.id
  description = "RDS security group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["192.170.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.platform}-db-sg"
  }
}

#database Subnet group
resource "aws_db_subnet_group" "subnet_group" {
  name        = "${var.environment}-${var.platform}-database-subnet_g"
  description = "Subnet group for RDS instances"

  subnet_ids = [for s in aws_subnet.private : s.id]

  tags = {
    Name = "${var.environment}-${var.platform}-database-subnet_g"
  }
}
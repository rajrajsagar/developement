# ------------------------------------------------------------------- #
# Use this project to provision his creates an AWS Elastic File System (EFS) environment that deliberately breaks standard enterprise cloud compliance checks (like Checkov's CKV_AWS_184 and CKV_AWS_15 rules)
# AUTHOR: ADAM M | +91-9739110917 | www.wezvatech.in
# DUMMY CHECKIN DATE: Sep-15-2026
# ------------------------------------------------------------------- #

provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# KMS Customer Managed Key (CMK) for EFS encryption — required by CKV_AWS_184
resource "aws_kms_key" "efs_cmk" {
  description             = "CMK for wezvatech-sandbox-efs encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name        = "wezvatech-sandbox-efs-cmk"
    Environment = "Dev"
  }
}

# ✅ Fixed: EFS encryption enabled with a customer-managed KMS key (CKV_AWS_42, CKV_AWS_184)
resource "aws_efs_file_system" "demo_efs" {
  creation_token = "wezvatech-aiops-demo"
  encrypted      = true
  kms_key_id     = aws_kms_key.efs_cmk.arn

  tags = {
    Name        = "wezvatech-sandbox-efs"
    Environment = "Dev"
  }
}

# ✅ Fixed: Backup policy enabled
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.demo_efs.id

  backup_policy {
    status = "ENABLED"
  }
}


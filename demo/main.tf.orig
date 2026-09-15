# ------------------------------------------------------------------- #
# Use this project to provision his creates an AWS Elastic File System (EFS) environment that deliberately breaks standard enterprise cloud compliance checks (like Checkov's CKV_AWS_184 and CKV_AWS_15 rules)
# AUTHOR: ADAM M | +91-9739110917 | www.wezvatech.in
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

# ❌ Violation 1: EFS File System deployed without encryption enabled
resource "aws_efs_file_system" "demo_efs" {
  creation_token = "wezvatech-aiops-demo"
  encrypted      = false # Explicit policy violation (Should be true)

  tags = {
    Name        = "wezvatech-sandbox-efs"
    Environment = "Dev"
  }
}

# ❌ Violation 2: Backup policy is explicitly disabled
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.demo_efs.id

  backup_policy {
    status = "DISABLED" # Explicit policy violation (Should be ENABLED)
  }
}


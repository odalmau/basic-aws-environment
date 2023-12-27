terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.6.6"
}

# Configure AWS providers

# Default US East (N. Virginia) AWS Provider
provider "aws" {
  region = "us-east-1"
}

# EU West (London) AWS Provider
provider "aws" {
  alias  = "uk"
  region = "eu-west-2"
}

# AP South East (Sidney) AWS Provider
provider "aws" {
  alias  = "au"
  region = "ap-southeast-2"
}

# Deploy S3 Bucket in the US region
module "us-web-app-s3" {
  source = "./modules/web-app-s3"

  bucket_name_prefix = var.app_name
}

# Deploy EC2 Instance in the US region
module "us-web-app-ec2" {
  source = "./modules/web-app-ec2"

  app_name             = var.app_name
  vpc_cidr             = var.us_vpc_cidr
  public_subnet_cidr   = var.us_public_subnet_cidr
  ami_name             = var.windows_ami_name
  instance_type        = var.windows_instance_type
  instance_volume_size = var.windows_instance_volume_size
  bucket_name          = module.us-web-app-s3.bucket_name
}

# Deploy EC2 Instance in the UK region
module "uk-web-app-ec2" {
  source = "./modules/web-app-ec2"

  providers = {
    aws = aws.uk
  }
  app_name             = var.app_name
  vpc_cidr             = var.uk_vpc_cidr
  public_subnet_cidr   = var.uk_public_subnet_cidr
  ami_name             = var.windows_ami_name
  instance_type        = var.windows_instance_type
  instance_volume_size = var.windows_instance_volume_size
  bucket_name          = module.us-web-app-s3.bucket_name
}

# Deploy EC2 Instance in the AU region
module "au-web-app-ec2" {
  source = "./modules/web-app-ec2"

  providers = {
    aws = aws.au
  }
  app_name             = var.app_name
  vpc_cidr             = var.au_vpc_cidr
  public_subnet_cidr   = var.au_public_subnet_cidr
  ami_name             = var.windows_ami_name
  instance_type        = var.windows_instance_type
  instance_volume_size = var.windows_instance_volume_size
  bucket_name          = module.us-web-app-s3.bucket_name
}
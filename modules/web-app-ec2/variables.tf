variable "app_name" {
  description = "App name"
  type        = string
  default     = "web-app"
}

variable "vpc_cidr" {
  description = "CIDR range of the VPC"
  type        = string
  default     = "10.0.0.0/26"
}

variable "public_subnet_cidr" {
  description = "CIDR range of the public subnet"
  type        = string
  default     = "10.0.0.0/27"
}

variable "ami_name" {
  description = "AMI name of the instance"
  type        = string
  default     = "Microsoft Windows Server 2022 Base"
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_volume_size" {
  description = "Size of the instance root volume in gibibytes"
  type        = number
  default     = 10
}

variable "bucket_name" {
  description = "Name of the S3 bucket to grant RW access to the EC2 instances"
  type        = string
}

variable "app_name" {
  description = "App name"
  type        = string
}

variable "us_vpc_cidr" {
  description = "CIDR range of the US VPC"
  type        = string
}

variable "uk_vpc_cidr" {
  description = "CIDR range of the UK VPC"
  type        = string
}

variable "au_vpc_cidr" {
  description = "CIDR range of the AU VPC"
  type        = string
}

variable "us_public_subnet_cidr" {
  description = "CIDR range of the US public subnet"
  type        = string
}

variable "uk_public_subnet_cidr" {
  description = "CIDR range of the UK public subnet"
  type        = string
}

variable "au_public_subnet_cidr" {
  description = "CIDR range of the AU public subnet"
  type        = string
}

variable "windows_ami_name" {
  description = "AMI name of the instance"
  type        = string
}

variable "windows_instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "windows_instance_volume_size" {
  description = "Size of the instance root volume in gibibytes"
  type        = number
  default     = 10
}

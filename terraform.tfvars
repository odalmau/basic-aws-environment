# Application Definition 
app_name = "web-app"

# Network
us_vpc_cidr           = "10.0.0.0/26"
uk_vpc_cidr           = "10.1.0.0/26"
au_vpc_cidr           = "10.2.0.0/26"
us_public_subnet_cidr = "10.0.0.0/27"
uk_public_subnet_cidr = "10.1.0.0/27"
au_public_subnet_cidr = "10.2.0.0/27"

# Windows EC2 instances
windows_ami_name             = "Windows_Server-2022-English-Core-Base-*"
windows_instance_type        = "t2.micro"
windows_instance_volume_size = 10
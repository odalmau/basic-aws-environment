# EC2 KEY PAIR
resource "tls_private_key" "web_instance" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "web_instance" {
  key_name   = "${var.app_name}-instance-${terraform.workspace}"
  public_key = tls_private_key.web_instance.public_key_openssh
}

# EC2 INSTANCE
data "aws_ami" "web_instance" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

resource "aws_instance" "web_instance" {
  ami                    = data.aws_ami.web_instance.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.web_instance.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.web_instance.name

  root_block_device {
    volume_size           = var.instance_volume_size
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "${var.app_name}-instance-${terraform.workspace}"
    Environment = terraform.workspace
  }
}

# S3 BUCKET
resource "aws_s3_bucket" "website_bucket" {
  bucket_prefix = "${var.bucket_name_prefix}-${terraform.workspace}-"

  tags = {
    Environment = terraform.workspace
  }
}
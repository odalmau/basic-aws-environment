data "aws_region" "current" {}

# IAM INSTANCE PROFILE
resource "aws_iam_instance_profile" "web_instance" {
  name = "${var.app_name}-instance-profile-${terraform.workspace}-${data.aws_region.current.name}"
  role = aws_iam_role.s3_access.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM ROLE
resource "aws_iam_role" "s3_access" {
  name               = "${var.app_name}-role-${terraform.workspace}-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM POLICY
data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Describe*",
      "s3-object-lambda:Get*",
      "s3-object-lambda:List*",
      "s3-object-lambda:Get*",
      "s3:Put*",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
      "arn:aws:s3:::${var.bucket_name}"
    ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "${var.app_name}-policy-${terraform.workspace}-${data.aws_region.current.name}"
  description = "IAM policy to grant RW access to S3 bucket"
  policy      = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.s3_access.name
  policy_arn = aws_iam_policy.s3_access.arn
}
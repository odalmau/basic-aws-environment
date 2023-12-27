# Basic AWS environment for a web application

### Overview

This repository contains Terraform code to deploy a basic AWS web application. It will be deployed across three different regions (Australia (AU), United Kingdom (UK), and United States (US)) and will consist of the following resources:
- 1 EC2 Instance per region
- S3 bucket in the US region

The EC2 instances will be hosting a website that is accessible from the public Internet. Also, the EC2 instances will have RW access to the S3 bucket.

2 separate environments will be deployed: Testing and Production.

### Design decisions

- Terraform:
    - [Terraform workspaces](https://developer.hashicorp.com/terraform/cli/workspaces) will be used to handle the 2 different environments (Testing and Production).
    - Multiple [Terraform AWS providers](https://developer.hashicorp.com/terraform/language/providers/configuration) will be used to deploy resources across different AWS regions.
    - 2 Terraform modules will be used to make it easier to handle resources dependencies:
      - [web-app-ec2](./modules/web-app-ec2): will create the network and compute resources.
      - [web-app-s3](./modules/web-app-s3): will create the S3 bucket.
- AWS:
    - Each VPC will be using a different CIDR range. This is to allow VPC peering in the future, if needed.
    - Public subnets will be created so the EC2 instances are accessible from the public Internet.
    - The EC2 instances will have an instance profile attached that grants them RW access to the S3 bucket.
    - The S3 bucket and its objects won't be publicly available.

### Configuration

The default values being used can be found [here](./terraform.tfvars). Make sure you update them as needed before deploying the web application.

### Terraform backend

The Terraform backend used by default is the [local](https://developer.hashicorp.com/terraform/language/settings/backends/local).

Using an [S3 backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3) is encouraged for deploying the production environment. Bellow, an example of the configuration that needs to be added:

```
terraform {
  backend "s3" {
    bucket = "terraform-backend-prod"
    key    = "web-app"
    region = "us-east-1"
  }
}
```

### Deploy

Create a Terraform workspace for each environment:
```
terraform workspace new production
terraform workspace new testing
```

Select Terraform workspace:
```
terraform workspace select production
```
or
```
terraform workspace select testing
```
*Note: Make sure you are using the right Terraform workspace before proceeding.*

Initialize Terraform working directory:
```
terraform init
```

Generate execution plan:
```
terraform plan
```

Build infrastructure:
```
terraform apply
```

*Note: Review the resources that are about to be created in the Terraform output before proceeding.*

Destroy infrastructure:
```
terraform destroy
```


### CI/CD

A basic GitHub Actions workflow has been prepared [here](./.github/workflows/terraform.yml) to perform the following actions:

1. Check Terraform code format.
2. On pull request events, it will run `terraform init`, `terraform fmt`, `terraform plan` and `terraform apply` in the TESTING environment. Also, a execution plan for the PRODUCTION environment will be generated.
3. On push events to the "main" branch, it will run `terraform init`, `terraform fmt`, `terraform plan` and `terraform apply` in the PRODUCTION environment.

*Note: The provided workflow has not been tested in order to avoid incurring any AWS expenses. The apply steps are disabled and the workflow disabled.*

*Note: The provided workflow assumes an S3 backend is being used and expects AWS credentials to be available as GitHub secrets.*

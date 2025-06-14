
# DevOps Interview Task 2025

## Objective

Create an AWS infrastructure consisting of the following components:

- **AWS API Gateway:** To act as the entry point for requests  
- **AWS S3 Bucket:** To store data  
- **AWS Lambda Function:** To process requests and interact with the S3 bucket  
- **Private VPC:** To host the Lambda function securely 

---

## Instructions

### Step 1: Clone the Repository

To get started, clone the repository to your local machine:

```bash
git clone git@github.com:shaunmarshall/terraform-api-gateway.git
cd terraform-api-gateway
```

### Step 2: Configure AWS Credentials

By default, the Terraform configuration will use the AWS API keys stored in the following file:

```
$HOME/.aws/credentials
```

Alternatively, you can manually add your `access_key` and `secret_key` to the `provider.tf` file.

---

### Step 3: Initialize Terraform

Run the following command to initialize the Terraform environment:

```bash
terraform init
```

### Step 4: Apply the Terraform Configuration

To deploy the infrastructure, apply the Terraform code with the following command:

```bash
terraform apply --auto-approve
```

This will automatically approve the changes and apply them to your AWS environment.

---

## Uploading a Photo to S3

To upload a sample photo to your S3 bucket, use the script below. Ensure the photo is placed in the `photo` directory:

```bash
./upload_photo.sh
```

This script will upload a photo (e.g., a sample cat photo) to the S3 bucket as specified in the Terraform configuration.

---

## GitHub Actions Workflow

For continuous integration and deployment automation, I’ve created a `deploy.yaml` workflow file. This file automates the deployment process, including the application of the Terraform configuration. 

I’ve also removed sensitive `secret_key` values from GitHub Secrets for security reasons. You can check the successful run of the GitHub Actions workflow here:

[GitHub Actions Workflow Run](https://github.com/shaunmarshall/terraform-api-gateway/actions/runs/15651254229)

---

## Notes

- Be sure to review and adjust your AWS credentials file if needed before running Terraform commands.
- The `upload_photo.sh` script assumes you have a valid photo placed in the `photo` directory.
- GitHub Actions automates the entire process, ensuring smooth and secure deployment.

---

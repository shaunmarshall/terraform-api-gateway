
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

### Step 3: Update Varaibles files

- **Add Your Public IP address in CIDR format (1.2.3.4/32) to the `allowed_ips` variable**
- Update `aws_region` variable to own prefered region
- Change `bucket_name` if required
- Change `private_subnet_cidrs` if required

---


### Step 4: Initialize Terraform

Run the following command to initialize the Terraform environment:

```bash
terraform init
```

### Step 5: Apply the Terraform Configuration

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

## Manual Steps to upload a phote
1. Encode the photo file
```bash
base64 -i ./photo/cat.jpeg > data.b64

```
2. Get the API Key - required to authenticate with the API Gateway
```bash
API_KEY="$(aws apigateway get-api-keys \
     --include-value --region eu-west-1  \
     --query "items[?name=='upload-api-key'].value" \
     --output text)"
```

3. Create the Payload json file
```bash
cat > payload.json <<EOF
{"filename":"cat.jpeg","data":"$(< data.b64)"}
EOF
```

4. Run Curl command to POST the photo to s3
```bash
curl -X POST \
     -H "Content-Type: application/json" \
     -H "x-api-key: ${API_KEY}" \
     --data-binary @payload.json \
     "$(terraform output -raw api_endpoint)"
```



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

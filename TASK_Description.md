# DevOps Interview Task 2025

## DevOps Interview  
**Technical Task:** Save sent picture to S3 bucket  

---

## Objectives

Create an AWS infrastructure consisting of the following components:

- **AWS API Gateway:** To act as the entry point for requests  
- **AWS S3 Bucket:** To store data  
- **AWS Lambda Function:** To process requests and interact with the S3 bucket  
- **Private VPC:** To host the Lambda function securely  

---

## Requirements

- The Lambda function must be deployed within a private Virtual Private Cloud (VPC)  
- The API Gateway should trigger the Lambda function upon receiving requests  
- The Lambda function should have the necessary permissions to read and write data to the S3 bucket  
- All AWS resources must be deployed using the **Terraform** tool  

---

## Expected Outcome

A functional AWS infrastructure that allows interaction with an S3 bucket through an API endpoint, with the processing logic running in a Lambda function within a private VPC.

- Brief documentation describing the solution and how to use it  
- Access to code used for resource creation  

---

## Evaluation Criteria

- Proper setup and configuration of VPC, API Gateway, Lambda, and S3  
- Security considerations, particularly regarding access control and VPC configuration  
- Functionality of the Lambda function to interact with the S3 bucket  
- Deployment process and automation (if used)  

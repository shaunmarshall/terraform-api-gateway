variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "AWS Bucket Name"
  type        = string
  default     = "photos-store"
}

variable "allowed_ips" {
  description = "List of allowed source IPs for API access (CIDR format)"
  type        = list(string)
  default     = ["82.43.64.101/32"]
}

variable "availability_zones" {
  description = "List of AZs for subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.9"
}

variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

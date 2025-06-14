output "api_endpoint" {
  depends_on  = [ aws_api_gateway_stage.prod ]
  description = "URL to POST images to"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/upload"
}

output "s3_bucket" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.images.bucket
}

output "lambda_function_name" {
  description = "Deployed Lambda function"
  value       = aws_lambda_function.uploader.function_name
}

output "vpc_id" {
  description = "VPC ID where Lambda runs"
  value       = aws_vpc.main.id
}

# Package & create Lambda
resource "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "uploader" {
  filename         = archive_file.lambda_zip.output_path
  function_name    = "image-uploader"
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  source_code_hash = archive_file.lambda_zip.output_base64sha256

  vpc_config {
    subnet_ids         = [for s in aws_subnet.private : s.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = { BUCKET = aws_s3_bucket.images.bucket }
  }
}

# Lambda SG: allow outbound only
resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  description = "Allow Lambda outbound"
  vpc_id      = aws_vpc.main.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

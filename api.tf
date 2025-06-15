# API Gateway REST Method and Integration

resource "aws_api_gateway_rest_api" "api" {
  name        = "image-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  description = "API Gateway to upload images"
}

resource "aws_api_gateway_resource" "upload" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "upload"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.upload.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true        # ← require API key
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.upload.id
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.uploader.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.uploader.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
        aws_api_gateway_method.post,
        aws_api_gateway_integration.lambda
      ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  triggers = { redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api)) }
}

resource "aws_api_gateway_stage" "dev" {
  depends_on    = [
      aws_wafv2_web_acl.api_acl
  ]
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
  stage_name    = "dev"
}

resource "aws_api_gateway_api_key" "upload_api_key" {
  name        = "upload-api-key"
  description = "API key for image upload"
  enabled     = true
}

resource "aws_api_gateway_usage_plan" "upload_plan" {
  name        = "upload-usage-plan"
  description = "Usage plan for upload API"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.dev.stage_name
  }

  throttle_settings {
    burst_limit = 100
    rate_limit  = 50
  }

  quota_settings {
    limit  = 10000
    period = "MONTH"
  }
}

resource "aws_api_gateway_usage_plan_key" "upload_plan_key" {
  key_id        = aws_api_gateway_api_key.upload_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.upload_plan.id
}


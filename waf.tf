# WAF v2 and ACL 

resource "aws_wafv2_ip_set" "api_ips" {
  name              = "api-allowed-ips"
  description       = "Allowed source IPs for API Gateway"
  scope             = "REGIONAL"
  ip_address_version = "IPV4"
  addresses         = var.allowed_ips
}


resource "aws_wafv2_web_acl" "api_acl" {
  name        = "api-gateway-acl"
  description = "WAF ACL to protect API Gateway"
  scope       = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "AllowListedIPs"
    priority = 1
    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.api_ips.arn
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "AllowListedIPs"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "apiGatewayWebACL"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "api_assoc" {
  resource_arn = "arn:aws:apigateway:${var.aws_region}::/restapis/${aws_api_gateway_rest_api.api.id}/stages/${aws_api_gateway_stage.dev.stage_name}"
  web_acl_arn  = aws_wafv2_web_acl.api_acl.arn
}
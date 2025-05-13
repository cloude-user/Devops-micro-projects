# Resource for the API Gateway
resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "myresource" #  the path for your resource (e.g., /myresource)
}

# GET Method
resource "aws_api_gateway_method" "api_method_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE" #  "NONE", "AWS_IAM", "CUSTOM", "COGNITO_USER_POOLS"
}

# POST Method
resource "aws_api_gateway_method" "api_method_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "POST"
  authorization = "NONE" #  "NONE", "AWS_IAM", "CUSTOM", "COGNITO_USER_POOLS"
}

# GET Integration with Lambda
resource "aws_api_gateway_integration" "api_integration_get" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.api_method_get.http_method
  type                    = "AWS_PROXY" # Use AWS_PROXY for Lambda integration
  integration_http_method = "POST" # Lambda function is always invoked with POST
  uri                     = aws_lambda_function.api_gateway_lambda.invoke_arn
  credentials             = aws_iam_role.api_gateway_role.arn # Use the IAM role
}

# POST Integration with Lambda
resource "aws_api_gateway_integration" "api_integration_post" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.api_method_post.http_method
  type                    = "AWS_PROXY" # Use AWS_PROXY for Lambda integration
  integration_http_method = "POST" # Lambda function is always invoked with POST
  uri                     = aws_lambda_function.api_gateway_lambda.invoke_arn
  credentials             = aws_iam_role.api_gateway_role.arn # Use the IAM role
}

# Deploy the API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod" #  the stage name (e.g., prod, dev)

  depends_on = [
    aws_api_gateway_integration.api_integration_get,
    aws_api_gateway_integration.api_integration_post,
  ]
}

# Permission for API Gateway to invoke the Lambda function.  This is the event trigger.
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_gateway_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*" # Allow all stages and methods
}

# Output the API Gateway endpoint
output "api_gateway_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}${aws_api_gateway_resource.api_resource.path}"
}

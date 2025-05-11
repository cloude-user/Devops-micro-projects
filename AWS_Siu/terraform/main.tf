resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 10

#   filename         = "lambda_function_payload.zip" # Should exist at runtime
#   source_code_hash = filebase64sha256("lambda_function_payload.zip")

  environment {
    variables = {
        "name"="siuu"
    }
  }
}
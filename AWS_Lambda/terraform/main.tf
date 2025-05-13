resource "aws_lambda_function" "sample_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 10

  filename         = "../src/app.zip" # Should exist at runtime
  source_code_hash = filebase64sha256("../src/app.zip")

  environment {
    variables = {
        "name"="siuu"
    }
  }
}

resource "aws_lambda_event_source_mapping" "lambda_evt_source_mapping" {
  function_name = sample_lambda
  
}
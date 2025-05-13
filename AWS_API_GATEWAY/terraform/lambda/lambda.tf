resource "aws_lambda_function" "api_gateway_lambda" {
  function_name    = "api_gateway_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler" #  .  
  runtime          = "python3.12" 
  timeout          = 30 # Adjust as needed

  #  code.  For simplicity, we'll use a zip archive from a local file.
  #  In a real-world scenario, you'd likely use a build process to create this zip.
  filename         = "main.zip" #  filename
  source_code_hash = filebase64sha256("main.zip")

  environment {
    variables = {
      "MESSAGE" = "Hello from Lambda!"
    }
  }
}
# Criação da função Lambda
resource "aws_lambda_function" "lambda_trigger" {
  function_name    = "s3-to-sqs-function"
  filename         = "${path.module}/src.zip"
  # role             = aws_iam_role.lambda_role.arn
  role             = var.lambda_role_lab
  
  # handler          = "${path.module}src/lambda_trigger_function.lambda_handler"
  handler          = "src.lambda_trigger_function.lambda_handler"
  runtime          = "python3.9"          # Runtime da função
  source_code_hash = filebase64sha256("${path.module}/src.zip")
  
  environment {
    variables = {
      BUCKET_NAME          = var.pizzaria_bucket_name
      URL_SQS_PREPARACAO   = var.url_sqs_preparacao
      URL_SQS_PRONTO       = var.url_sqs_pronto
    }
  }
}

resource "aws_lambda_function" "lambda_insert_dynamo" {
  function_name    = "lambda_insert_dynamo"
  filename         = "${path.module}/src.zip"
  role             = var.lambda_role_lab
  
  handler          = "src.lambda_insert_dynamo.lambda_handler"
  runtime          = "python3.9"
  
  source_code_hash = filebase64sha256("${path.module}/src.zip")
  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }
}

# Criação da função Lambda
resource "aws_lambda_function" "lambda_trigger" {
  function_name    = "s3-to-sqs-function"
  filename         = "${path.module}/src.zip"
  # role             = aws_iam_role.lambda_role.arn
  role             = role_lab
  
  handler          = "${path.module}src/lambda_trigger_function.lambda_handler"
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

# resource "aws_lambda_function" "lambda_fila_preparacao" {
#   function_name    = "lambda_fila_preparacao"
#   filename         = "${path.module}/src.zip"
#   role             = aws_iam_role.lambda_role.arn
  
#   handler          = "${path.module}src/lambda_fila_preparacao.lambda_handler"
#   runtime          = "python3.9"          # Runtime da função
#   source_code_hash = filebase64sha256("${path.module}/src.zip")

# }


# resource "aws_lambda_function" "lambda_fila_pronto" {
#   function_name    = "lambda_fila_pronto"
#   filename         = "${path.module}/src.zip"
#   role             = aws_iam_role.lambda_role.arn
  
#   handler          = "${path.module}src/lambda_fila_pronto.lambda_handler"
#   runtime          = "python3.9"          # Runtime da função
#   source_code_hash = filebase64sha256("${path.module}/src.zip")

# }


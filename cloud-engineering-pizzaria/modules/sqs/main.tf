resource "aws_sqs_queue" "sqs_preparacao" {
  name                      = "sqs_preparacao"
  visibility_timeout_seconds = 30
  delay_seconds             = 0
  message_retention_seconds = var.message_retention_seconds
}

resource "aws_sqs_queue" "sqs_pronto" {
  name                      = "sqs_pronto"
  visibility_timeout_seconds = 30
  delay_seconds             = 0
  message_retention_seconds = var.message_retention_seconds
}

resource "aws_lambda_event_source_mapping" "sqs_preparacao_to_lambda" {
  event_source_arn = aws_sqs_queue.sqs_preparacao.arn
  function_name    = var.lambda_insert_dynamo_arn
  batch_size       = 10
  enabled          = true
}

resource "aws_lambda_event_source_mapping" "sqs_pronto_to_lambda" {
  event_source_arn = aws_sqs_queue.sqs_pronto.arn
  function_name    = var.lambda_insert_dynamo_arn
  batch_size       = 10
  enabled          = true
}
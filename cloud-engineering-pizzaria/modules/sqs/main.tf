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
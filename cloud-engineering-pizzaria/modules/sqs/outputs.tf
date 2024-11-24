output "url_sqs_preparacao" {
  value       = aws_sqs_queue.sqs_preparacao.id
  description = "URL da fila"
}

output "url_sqs_pronto" {
  value       = aws_sqs_queue.sqs_pronto.id
  description = "URL da fila"
}
output "lambda_trigger_arn" {
  description = "ARN da função Lambda acionada pelo trigger s3"
  value       = aws_lambda_function.lambda_trigger.arn
}
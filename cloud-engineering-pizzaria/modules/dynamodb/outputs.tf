output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = aws_dynamodb_table.dynamo_pedidos.name
}
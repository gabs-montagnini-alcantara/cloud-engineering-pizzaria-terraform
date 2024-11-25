resource "aws_dynamodb_table" "dynamo_pedidos" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = var.partition_key["name"]

  range_key = var.sort_key["name"]

  attribute {
    name = var.partition_key["name"]
    type = var.partition_key["type"]
  }

  attribute {
    name = var.sort_key["name"]
    type = var.sort_key["type"]
  }
  
  lifecycle {
    prevent_destroy = false
  }
  
}
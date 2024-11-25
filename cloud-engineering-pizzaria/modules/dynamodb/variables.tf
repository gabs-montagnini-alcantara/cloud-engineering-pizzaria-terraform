variable "table_name" {
  description = "Nome da tabela do DynamoDB"
  type        = string
}

variable "partition_key" {
  description = "Chave de partição da tabela"
  type        = map(string)
}

variable "sort_key" {
  description = "Chave de pesquisa (opcional)"
  type        = map(string)
}


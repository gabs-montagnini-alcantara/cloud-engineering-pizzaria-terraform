variable "turma" {
  description = "Identificador da turma"
  type        = string
}

variable "lambda_role_name" {
  description = "lambda_role_name"
  type        = string
  default = ""
}

variable "lambda_role_lab" {
  description = "lambda_role_lab"
  type        = string
}

variable "lambda_iam_policy_name" {
  description = "lambda_iam_policy_name"
  type        = string
  default = ""
}

variable "pizzaria_bucket_id" {
  description = "Identificador do id do bucket"
  type        = string
}

variable "pizzaria_bucket_name" {
  description = "Identificador do nome do bucket"
  type        = string
}

variable "pizzaria_bucket_arn" {
  description = "Identificador do arn do bucket"
  type        = string
}

variable "url_sqs_preparacao" {
  description = "identificador url fila"
  type        = string
}

variable "url_sqs_pronto" {
  description = "identificador url fila"
  type        = string
}

variable "dynamodb_table_name" {
  description = "nome da tabela do dynamodb"
  type        = string
}


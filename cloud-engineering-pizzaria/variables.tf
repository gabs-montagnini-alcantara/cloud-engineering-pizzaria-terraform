variable "turma" {
  description = "Identificador da turma"
  type        = string
}

variable "nome_bucket" {
  description = "Identificador do nome do bucket"
  type        = string
}

variable "lambda_role_name" {
  description = "lambda_role_name"
  type        = string
  default = ""
}

variable "lambda_iam_policy_name" {
  description = "lambda_iam_policy_name"
  type        = string
  default = ""
}
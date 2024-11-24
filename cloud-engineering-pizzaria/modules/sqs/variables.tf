variable "lambda_trigger_arn" {
  description = "Identificador do lambda_trigger_arn"
  type        = string
}


variable "message_retention_seconds" {
  description = "retencao"
  type        = number
  default     = 10000 
}

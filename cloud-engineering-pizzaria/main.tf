provider "aws" {
  region = "us-east-1"
}


data "aws_caller_identity" "current" {}

locals {
    id_conta = data.aws_caller_identity.current.account_id
}

module "s3" {
  source      = "./modules/s3"
  turma       = var.turma
  nome_bucket = "${var.turma}-${local.id_conta}-${var.nome_bucket}"
  lambda_trigger_arn = module.lambda.lambda_trigger_arn
}


module "lambda" {
  source                    = "./modules/lambda"
  turma                     = var.turma
  lambda_role_name          = var.lambda_role_name
  # lambda_role_lab           = "arn:aws:iam::${id_conta}:role/LabRole"
  lambda_iam_policy_name    = var.lambda_iam_policy_name
  pizzaria_bucket_id        = module.s3.pizzaria_bucket_id
  pizzaria_bucket_arn       = module.s3.pizzaria_bucket_arn
  pizzaria_bucket_name      = module.s3.pizzaria_bucket_name
  url_sqs_preparacao        = module.sqs.url_sqs_preparacao
  url_sqs_pronto            = module.sqs.url_sqs_pronto
  # sqs_em_preparacao   = module.sqs.sqs_em_preparacao
  # sqs_pronto          = module.sqs.sqs_pronto
  # dynamodb_table_arn  = module.dynamodb.table_arn
}

module "sqs" {
  source              = "./modules/sqs"
  lambda_trigger_arn  = module.lambda.lambda_trigger_arn
}

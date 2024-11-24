
resource "aws_s3_bucket" "pizzaria_bucket" {
    bucket = var.nome_bucket
    force_destroy = true
}

resource "aws_s3_object" "preparacao_placeholder" {
    bucket = aws_s3_bucket.pizzaria_bucket.id
    key    = "em-preparacao/"
    content = "" 
}

resource "aws_s3_object" "feito_placeholder" {
    bucket = aws_s3_bucket.pizzaria_bucket.id
    key    = "pronto/"
    content = "" 
}

resource "aws_s3_bucket_notification" "s3_notification" {
    bucket = aws_s3_bucket.pizzaria_bucket.id

    lambda_function {
        lambda_function_arn = var.lambda_trigger_arn
        events              = ["s3:ObjectCreated:*"]
        filter_prefix       = "em-preparacao/"
    }

    lambda_function {
        lambda_function_arn = var.lambda_trigger_arn
        events              = ["s3:ObjectCreated:*"]
        filter_prefix       = "pronto/"
    }
}
# resource "aws_iam_role" "lambda_role" {
#   name = var.lambda_role_name

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "revoke_keys_role_policy" {
#   name = var.lambda_iam_policy_name
#   role = aws_iam_role.lambda_role.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# # Política para enviar mensagens para as filas SQS
# resource "aws_iam_role_policy" "sqs_send_message_policy" {
#   name = "lambda-sqs-send-policy"
#   role = aws_iam_role.lambda_role.id

#   policy = jsonencode({
#     Version   = "2012-10-17"
#     Statement = [
#       {
#         Action   = "sqs:SendMessage"
#         Effect   = "Allow"
#         Resource = [
#           var.url_sqs_preparacao,
#           var.url_sqs_pronto
#         ]
#       }
#     ]
#   })
# }



resource "aws_lambda_permission" "trigger_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.pizzaria_bucket_arn
}






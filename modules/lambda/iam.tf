# IAM
#
# This should be the way to create a role for the lambda function, it's
# commented out due to Academy limitations.
#
# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
# 
#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
# 
#     actions = ["sts:AssumeRole"]
#   }
# }
# 
# resource "aws_iam_role" "role" {
#   name               = "${var.lambda_name}-exec"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

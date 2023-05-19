# IAM
#
# This should be the way to create a role for the lambda function, it's
# commented out due to Academy limitations.
#
data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    effect = "Allow"
    sid = "DynamoDBIndexAndStreamAccess"
    actions = [
        "dynamodb:GetShardIterator",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:ListStreams"
    ]
    resources = var.role_arn
  }
    statement {
    effect = "Allow"
    sid = "DynamoDBTableAccess"
    actions = [
       "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
                "dynamodb:ConditionCheckItem",
                "dynamodb:PutItem",
                "dynamodb:DescribeTable",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:Scan",
                "dynamodb:Query",
                "dynamodb:UpdateItem"
    ]
    resources = var.role_arn
  }
}



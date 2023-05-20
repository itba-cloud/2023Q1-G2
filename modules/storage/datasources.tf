data "aws_iam_policy_document" "this" {

  statement {
    sid     = "SetAndGetObject"
    effect  = "Allow"
    actions = ["s3:*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_s3_bucket.this.arn,"${aws_s3_bucket.this.arn}/*"]
  }
}
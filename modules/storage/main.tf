module "site_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  bucket_prefix = var.name_prefix
  force_destroy = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_object" "object" {
  for_each = { for file in local.file_with_mime : "${file.file_name}.${file.mime}" => file }

  bucket = module.site_bucket.s3_bucket_id
  key    = each.value.file_name

  source       = "${var.resources}/${each.value.file_name}"
  etag         = filemd5("${var.resources}/${each.value.file_name}")
  content_type = each.value.mime

  acl = "public-read"
}

resource "aws_s3_bucket_ownership_controls" "site_bucket" {
  bucket = module.site_bucket.s3_bucket_id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "site_bucket" {
  bucket = module.site_bucket.s3_bucket_id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "site_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.site_bucket,
    aws_s3_bucket_public_access_block.site_bucket,
  ]

  bucket = module.site_bucket.s3_bucket_id
  acl    = "public-read"
}

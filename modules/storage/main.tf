
resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  object_lock_enabled = false

 
  tags = {
    Name = var.bucket_tag
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
    count = var.public_read_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id

  block_public_acls   = false
  block_public_policy = false
}
# resource "aws_s3_bucket_policy" "this" {
#   count = var.public_read_policy ? 1 : 0

#   bucket = aws_s3_bucket.this.id
#   policy = data.aws_iam_policy_document.this.json
# }

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.index_file != null || var.redirect_hostname != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  # index_document = var.index_document
  # redirect_all_requests_to = var.redirect_hostname
  dynamic "index_document" {
    for_each = var.index_file != null ? [1] : []
    # count = var.index_file != null ? 1: 0
    content {
      suffix = var.index_file
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = var.redirect_hostname != null ? [1] : []
    content {
      host_name = var.redirect_hostname
    }
  }


}

# resource "aws_s3_bucket_acl" "this" {
#   bucket = aws_s3_bucket.this.id
#   acl    = var.bucket_acl
# }

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "this" {
  for_each = try(var.objects, {}) #{ for object, key in var.objects: object => key if try(var.objects, {}) != {} }

  bucket        = aws_s3_bucket.this.id
  key           = try(each.value.rendered, replace(each.value.filename, "html/", ""))     # remote path
  source        = try(each.value.rendered, format("../resources/%s", each.value.filename)) # where is the file located
  content_type  = each.value.content_type
  storage_class = try(each.value.tier, "STANDARD")
}
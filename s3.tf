# S3 bucket
resource "random_id" "bucket_postfix" {
  byte_length = 4
}

resource "aws_s3_bucket" "images" {
  bucket = "${ var.bucket_name }-${random_id.bucket_postfix.hex}"
  acl    = "private"
  versioning { enabled = false }
  tags = { Name = "photo-upload-bucket" }
}
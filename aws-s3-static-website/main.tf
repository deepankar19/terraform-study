
resource "random_id" "random" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.bucket_prefix}-${random_id.random.hex}"

  tags = {
    Name        = "${var.bucket_prefix}-${random_id.random.hex}"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-bucket-access-block" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3-bucket-access-policy" {
  bucket = aws_s3_bucket.s3-bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.s3-bucket.id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "s3-website-config" {
  bucket = aws_s3_bucket.s3-bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_instance" "web" {
  ami           = var.ami-image
  instance_type = var.instance-type

  tags = {
    Name = "Demo Ec2 instance"
  }
}

resource "aws_s3_object" "bucket-data" {
  for_each = fileset("${path.module}/website", "**/*")

  bucket       = aws_s3_bucket.s3-bucket.bucket
  key          = each.value
  source       = "${path.module}/website/${each.value}"
  acl          = "public-read"
  content_type = "text/html"
}

# Configure backend using the dynamic bucket name
# terraform {
#   backend "s3" {
#     bucket = aws_s3_bucket.s3-bucket.bucket
#     key    = "backend.tfstate"
#     region = "ap-south-1"
#   }
# }
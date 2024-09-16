resource "random_id" "random" {
 byte_length = 8
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.s3-bucket.bucket
    source = "./test.txt"
    key = "mydata.txt"
}
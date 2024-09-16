output "instance-public-ip" {
  value = aws_instance.web.public_ip
}

output "instance-id" {
  value = aws_instance.web.id
}

output "s3-bucket-name" {
  value = aws_s3_bucket.s3-bucket.bucket
}
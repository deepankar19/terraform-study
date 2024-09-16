output "website_url" {
  value = aws_s3_bucket_website_configuration.s3-website-config.website_endpoint
}


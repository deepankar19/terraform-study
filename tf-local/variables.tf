variable "region" {
  description = "this is variable were region value is added"
  type        = string
  default     = "ap-south-1"
}

variable "ami-image" {
  default = "ami-0e53db6fd757e38c7"
}

variable "aws-instance-type" {
  default = "t2.micro"
}
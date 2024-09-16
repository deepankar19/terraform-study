variable "region" {
  description = "az region"
  type        = string
  default     = "ap-south-1"
}

# variable "aws_ami_image" {
#   type        = string
#   description = "amazom linux 2023"
#   default     = "ami-0e53db6fd757e38c7"
# }

# variable "aws_instance_type" {
#   type        = string
#   description = "ec2 family instance of type "
#   default     = "t2.micro"
# }

variable "project_name" {
  type    = string
  default = "xxxx-multi-env-91524"
}

# variable "ec2_config" {
#   type = list(object({
#     ami           = string
#     instance_type = string
#   }))
# }

#for_each used only with map,set

variable "ec2_map" {
  #key=value (object{ami, instance_type})
  type = map(object({
    ami           = string
    instance_type = string
  }))
}
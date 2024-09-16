variable "region" {
  description = "az regions"
  default     = "ap-south-1"
}

variable "aws_instance_type" {
  description = "What type of instance you want to create"
  type        = string
  validation {
    condition     = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t2.nano"
    error_message = "Only t2 micro and t2 nano are allowed"
  }
}

variable "ami-image" {
  description = "amazom linux 2023"
  default     = "ami-0e53db6fd757e38c7"
}

variable "root_block_config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 20
    v_type = "gp2"
  }
}

variable "additional_tags" {
  type = map(string) #expecting  key=value format
  default = {}
}


#by cmd 
#terraform plan -var='root_block_config={v_size=50,v_type="gp3"}'
#terraform apply -var='root_block_config={v_size=50,v_type="gp3"}' --auto-approve
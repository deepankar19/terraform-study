variable "vpc_config" {
  description = "Required CIDR and Name of VPC from user"
  type = object({
    cidr_block = string
    name       = string
  })
}
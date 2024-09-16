variable "vpc_config" {
  description = "Required CIDR and Name of VPC from user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format-${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "CIDR and AZ for subnets"
  type = map(object({
    cidr_block = string
    azs = string
    public = optional(bool, false)
  }))
  validation {
condition = alltrue([for subconfig in var.subnet_config : can(cidrnetmask(subconfig.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}
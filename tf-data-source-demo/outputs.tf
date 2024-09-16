output "security_group" {
  value = data.aws_security_group.data-sgp.id
}

output "vpc_id" {
  value = data.aws_vpc.data-vpc.id
}

output "subnet_id" {
  value = data.aws_subnet.data-subnet.id
}

output "caller_identity" {
  value = data.aws_caller_identity.current.id
}

# output "account_id" {
#   value = data.aws_caller_identity.current.account_id
# }

# output "caller_arn" {
#   value = data.aws_caller_identity.current.arn
# }

# output "caller_user" {
#   value = data.aws_caller_identity.current.user_id
# }
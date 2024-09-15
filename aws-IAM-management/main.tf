terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  user_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([for user in local.user_data : [for role in user.roles : {
    username = user.username
    role     = role
  }]])
}

output "user_op" {
  value = {
    #username = local.user_data
    role = local.user_role_pair
  }
}

resource "aws_iam_user" "iam_users" {
  for_each = toset(local.user_data[*].username)
  name     = each.value
}

#Password creation
resource "aws_iam_user_login_profile" "iam_profiles" {
  for_each        = aws_iam_user.iam_users
  user            = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

#Attaching permission, policies
resource "aws_iam_user_policy_attachment" "user_policy_attach" {
  for_each = {
    for pair in local.user_role_pair :
    "${pair.username}-${pair.role}" => pair
  }
  #baburoa-EC2Access = {username = baburoa, role = ec2access}
  #baburoa-s3READAccess = {username = baburoa, role = s3readaccess}

  user       = aws_iam_user.iam_users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}

resource "aws_iam_access_key" "iam_access_key" {
  for_each        = aws_iam_user.iam_users
  user            = each.value.name
}

# Output the IAM user's access key and secret key
# output "iam_user_access_keys" {
#   value = {
#     for username, user in aws_iam_access_key.iam_access_key : username => {
#       access_key = user.id
#       secret_key = user.secret
#     }
#   }
#   sensitive = false
# }
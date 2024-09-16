terraform {}

locals {
  value = "hello world"
}

# variable "num_list" {
#     type = list(number)
#   default = [23, 35, 67, 90, 72, 54, 89, 10, 4, 8]
# }

variable "string_list" {
  type    = list(string)
  default = ["serv1", "serv2", "serv3", "serv1"]
}

output "func_op" {
  value = {
    low_val           = lower(local.value)
    upp_val           = upper(local.value)
    starwith_check    = startswith(local.value, "hello")
    split_value       = split(" ", local.value)
    min_val           = min(23, 35, 67, 90, 72, 54, 89, 10, 4, 8)
    max_list          = max(23, 35, 67, 90, 72, 54, 89, 10, 4, 8)
    absolute_val      = abs(-15)
    len_list          = length(var.string_list)
    join_list         = join(":", var.string_list)
    contains_list     = contains(var.string_list, "server")
    contains_data     = contains(var.string_list, "serv1")
    dupli_remove_data = toset(var.string_list)

  }
}
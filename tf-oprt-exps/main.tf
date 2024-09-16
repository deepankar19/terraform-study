terraform {}


#number list
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5, 6]
}

#Object list of person
variable "person_list" {
  type = list(object({
    fname  = string
    lname  = string
    age    = number
    mobile = number
  }))
  default = [{
    fname  = "Raju"
    lname  = "Rastogi"
    age    = 26
    mobile = 9630997847
    }, {
    fname  = "Arjun"
    lname  = "Dixit"
    age    = 30
    mobile = 6325984056
    }, {
    fname  = "Sheela"
    lname  = "khan"
    age    = 25
    mobile = 8457129632
  }]

  validation {
    condition     = alltrue([for person in var.person_list : length(tostring(person.mobile)) == 10])
    error_message = "Each 'mobile' number must be exactly 10 digits long."
  }
}

variable "map_list" {
  type = map(number)
  default = {
    "iphone"               = 1
    "macbook-air"          = 2
    "Royal-enfied-shotgun" = 3
    "proche-911"           = 4
    "Rolex-1986"           = 5
    "monalica"             = 6
  }
}

#Calaculation
locals {
  mul = 2 * 2
  add = 12 + 4
  sub = 26 - 2
  div = 78 / 2
  eq  = 2 != 3

  #double the list
  double = [for num in var.num_list : num * 2]
  #odd no.only
  odd = [for num in var.num_list : num if num % 2 != 0]
  #even no. only
  even = [for num in var.num_list : num if num % 2 == 0]
  #to get only fname from person list
  fname = [for person in var.person_list : person.fname]
  #to get key pair from map_list
  fav = [for key, value in var.map_list : key]

   double_map = {for key, value in var.map_list : key => value * 20 }
}

output "Calaculation_op" {
  value = {
    add    = local.add
    mul    = local.mul
    sub    = local.sub
    div    = local.div
    double = local.double
    odd    = local.odd
    even   = local.even
    fname  = local.fname
    fav    = local.fav
    double_map_info = local.double_map
  }
}

output "logical-op" {
  value = {
    equal = local.eq
  }
}
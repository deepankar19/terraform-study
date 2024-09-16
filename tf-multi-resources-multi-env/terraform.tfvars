# ec2_config = [{
#   ami           = "ami-0522ab6e1ddcc7055" #ubuntu
#   instance_type = "t2.micro"
#   }, {
#   ami           = "ami-0e53db6fd757e38c7" #amazon linux
#   instance_type = "t2.micro"
# }]

ec2_map = {
  "ubuntu" = {
    ami           = "ami-0522ab6e1ddcc7055" #ubuntu
    instance_type = "t2.micro"
  },
  "amazon-linux" = {
    ami           = "ami-0e53db6fd757e38c7" #amazon linux
    instance_type = "t2.micro"
  }
}
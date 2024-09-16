module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"


  name = "instance-jack"
   
  ami                    = "ami-0e53db6fd757e38c7"
  instance_type          = "t2.micro"
  key_name               = "heydevops"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name        = "Module-Project"
    Terraform   = "true"
    Environment = "dev"
  }
}  

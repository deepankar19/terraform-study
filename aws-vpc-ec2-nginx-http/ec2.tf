resource "aws_instance" "nginx-server" {
  ami                         = var.ami-image
  instance_type               = var.instance-type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF    
  tags = {
    Name = "NginxServer"
  }
}
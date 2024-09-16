resource "aws_instance" "my-ec2-server" {
  ami           = var.ami-image
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.root_block_config.v_size
    volume_type           = var.root_block_config.v_type
  }

  tags = merge(var.additional_tags,{
    Name = "SampleServer+"
  })
}
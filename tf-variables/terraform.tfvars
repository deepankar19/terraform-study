aws_instance_type = "t2.micro"

root_block_config = {
    v_size = 30
    v_type = "gp3"
}

additional_tags = {
  DEPT = "QA"
  PROJECT = "Enviorment_variable_xe91524"
}
resource "aws_launch_template" "launchtemplate-schaffnerkelian" {
  name = "launchtemplate-schaffnerkelian"
  image_id = "ami-012ba92271e91512d"
  instance_type = "t2.micro"
  key_name = "launchtemplate-schaffnerkelian"
  network_interfaces {
    device_index = 0
    associate_public_ip_address = true
  }
  security_group_names = ["sg-04891020a5d7968f5"]
  user_data = <<-EOF
                #!/bin/bash
                cd /home/ubuntu/app/
                sudo docker compose up --build -d
                EOF
}

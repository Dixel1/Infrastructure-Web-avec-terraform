#ressource "aws_launch_template" "launchTemplate-schaffnerkelian" {
 # name = "launchTemplate-schaffnerkelian"
  #image_id = "ami-0c55b159cbfafe1f0"
#  instance_type = "t2.micro"
 # key_name = "launchTemplate-schaffnerkelian"
  #network_interfaces {
#    device_index = 0
 #   associate_public_ip_address = true
  #}
#  security_group_names = ["sg-04891020a5d7968f5"]
 # user_data = <<-EOF
  #              #!/bin/bash
   #             cd /home/ubuntu/app/
    #            sudo docker compose up --build -d
     #           EOF
#}
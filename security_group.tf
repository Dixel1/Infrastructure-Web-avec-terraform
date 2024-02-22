# create a a security group rule that gives inbound access to the loadbalancer
resource "aws_security_group" "sglb-schaffnerkelian" {
  name        = "sglb-schaffnerkelian"
  description = "Allow inbound access to the loadbalancer"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# create a security group rule that provides inbound ssh access from the internet
resource "aws_security_group" "sgssh-schaffnerkelian" {
  name        = "sgssh-schaffnerkelian"
  description = "Allow inbound SSH access from the internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create a security group from the internet to EC2 port 80 
resource "aws_security_group" "sghttp-schaffnerkelian" {
  name        = "sghttp-schaffnerkelian"
  description = "Allow inbound HTTP access from the internet"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
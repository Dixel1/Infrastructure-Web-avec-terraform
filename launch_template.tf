resource "aws_launch_template" "launchtemplate-schaffnerkelian" {
  name          = "launchtemplateschaffnerkelian"
  image_id      = "ami-012ba92271e91512d"
  instance_type = "t2.micro"
  #key_name      = aws_key_pair.deployer-key-schaffnerkelian.key_name
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = ["sg-04891020a5d7968f5", aws_security_group.sglb-schaffnerkelian.id, aws_security_group.sgssh-schaffnerkelian.id]
  }
  user_data = filebase64("user_data.sh")
  placement {
    availability_zone = "eu-west-1a"
  }
}

resource "aws_key_pair" "deployer-key-schaffnerkelian" {
  key_name   = "deployer-key-schaffnerkelian"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRCa4+uW8BoBOiYFzhkdg4cE6906IlY5aWCX3OsebN4rta9m6Uz3e07UUNXZny3FC1F3e5sVrCwZb3ZGXVvSSDthKizmRKlGmjF/qXySK9wOizxKLo6mPfcZkBUv9cqEuMlss7cR+tLlAhTrLYZywgWzuJdGNqmUm8wGd2u8anBlwbasLH5vbjkETtMvPK6ObQJRVhB1SccnWoHg67TzHp5TtCnmms151F/6O3to6L0wZNCpGC4P0WBMbGZWfd2pp+GOmHlgj9QOrITudR+TWMPUswWQhwEZglvAhKctrG8fbiwMezBjVZn1n/mo9GnzaD7LTc7BdN043t18n2cgt/zBoFAAjqA4U+SOi2igmbP5RNSjLq0ynT24hC3xxJn1rTjsJynJOnhUnNm1ffzQM8oicT/uU1vXhPTqIwGZT9mladjWYq7yQXh7tJiMNSrBgAGc7cL8s30ADM2hnCi61o3usOPv6mdpN/aOWJAYsl24II8h4KbtzLz5RAc496eus= schaf@DESKTOP-AEJ9M2Q"
}
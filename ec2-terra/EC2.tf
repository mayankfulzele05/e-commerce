#key pair (login)

resource "aws_key_pair" "deployer" {
  key_name   = "key"
  public_key = file("key.pub")
}

#VPC , security group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.default.id #interpolation 

  #inbound rules 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}

#ec2 instance

resource "aws_instance" "my_instance" {
  for_each = tomap({
    vm1 = "t3.small"
  })
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value 
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")

  root_block_device { #configure storage
    volume_size = var.env == "prod" ? 20 : var.aws_instance_type
    volume_type = "gp3"
  }
  tags = {
    Name = each.key # mayank-vm this was there before
    
  }
}





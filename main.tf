provider "aws" {
  region  = "eu-central-1"
  //profile = "production"
}

resource "aws_security_group" "security-group-ec1-d-vault" {
  name = "security-group-ec1-d-vault"
  description = "security group for vault"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.81.0.0/16"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

missing a role

resource "aws_instance" "vault" {
  ami = "ami-1e339e71"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.security-group-ec1-d-vault.id}"]
  
  tags {
    Name = "vault"
    Owner = "ops"
  }
}
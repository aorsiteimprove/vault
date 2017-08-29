provider "aws" {
  region  = "eu-central-1"
  //profile = "production"
}

resource "aws_security_group" "security-group-ec1-d-vault" {
  name = "security-group-ec1-d-vault"
  description = "security group for vault"
  vpc_id = "vpc-48267f20"

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

resource "aws_iam_instance_profile" "vault-profile" {
  name  = "vault-profile"
  role = "${aws_iam_role.ops-vault.name}"
}

resource "aws_iam_role" "ops-vault" {
  name = "ops-vault2"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_instance" "vault" {
  ami = "ami-1e339e71"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.security-group-ec1-d-vault.id}"]
  subnet_id = "subnet-52628139"
  iam_instance_profile = "${aws_iam_instance_profile.vault-profile.name}"
  
  key_name = "aor-siteimprove"

  tags {
    Name = "vault"
    Owner = "ops"
  }
}

output "private ip" {
  value = "${aws_instance.vault.private_ip}"
}
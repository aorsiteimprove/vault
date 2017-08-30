provider "aws" {
  region  = "eu-central-1"
  //profile = "production"
}

data "template_file" "vault-inventory" {
	template = <<EOF

[vault]
$${vault_ip} ansible_ssh_private_key_file=~/.ssh/aor-siteimprove.pem

[vault:vars]
vault_version=$${vault_version}
EOF

	vars {
    vault_version="0.8.1"
    vault_ip="${aws_instance.vault.private_ip}"
	}
}

resource "null_resource" "vault-init" {
	triggers {
		template = "${data.template_file.vault-inventory.rendered}"
	}

	provisioner "local-exec" {
		command = <<EOF
echo "${data.template_file.vault-inventory.rendered}" > vault.inv
EOF
	}
}

resource "aws_security_group" "security-group-ec1-d-vault" {
  name = "security-group-ec1-d-vault"
  description = "security group for vault"
  vpc_id = "${var.vpc_id}"

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
  subnet_id = "${var.subnet_id}"
  iam_instance_profile = "${aws_iam_instance_profile.vault-profile.name}"
  
  key_name = "${var.key_name}"

  tags {
    Name = "vault"
    Owner = "${var.owner}"
  }
}

output "private ip" {
  value = "${aws_instance.vault.private_ip}"
}
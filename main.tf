provider "aws" {
  region = var.aws_region
}

data "aws_security_group" "existing_allow_ssh_http" {
  filter {
    name   = "group-name"
    values = ["allow_ssh_http"]
  }
}

resource "aws_security_group" "allow_ssh_http" {
  count = length(data.aws_security_group.existing_allow_ssh_http.id) == 0 ? 1 : 0

  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my-instance" {
  ami           = "ami-0b6e9ccdaffb5503f"
  instance_type = "t3.micro"
  security_groups = [length(data.aws_security_group.existing_allow_ssh_http.id) > 0 ? data.aws_security_group.existing_allow_ssh_http.id : aws_security_group.allow_ssh_http[0].id]
  key_name      = var.key_name

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo docker pull olehkhomenko/lab_1:latest
                sudo docker run -d -p 80:80 olehkhomenko/lab_1:latest
                sudo docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 60
              EOF

  tags = {
    Name = "Lab2"
  }
}

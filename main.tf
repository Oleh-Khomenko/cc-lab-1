provider "aws" {
  region = var.aws_region
}

data "aws_security_group" "existing_launch_wizard" {
  filter {
    name   = "group-name"
    values = ["launch-wizard-2"]
  }
}

resource "aws_instance" "my-instance" {
  ami           = "ami-0b6e9ccdaffb5503f"
  instance_type = "t3.micro"
  security_groups = [data.aws_security_group.existing_launch_wizard.id]
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

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "my-instance" {
  ami           = "ami-0b6e9ccdaffb5503f"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0b5bfb0241e132fca"]
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

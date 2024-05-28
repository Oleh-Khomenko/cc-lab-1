provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "my-instance" {
  ami           = "ami-01dad638e8f31ab9a"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0b5bfb0241e132fca"]
  key_name      = var.key_name

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
                docker pull olehkhomenko/lab_1:latest
                docker run -d -p 80:80 olehkhomenko/lab_1:latest
                docker run -d --name watchtower --privileged -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 60
              EOF

  tags = {
    Name = "Lab2"
  }
}

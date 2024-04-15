# run docker on aws instance
docker run -d -p 80:80 olehkhomenko/lab_1:latest
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 60

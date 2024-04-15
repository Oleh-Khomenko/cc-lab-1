# Watchtower
FROM containrrr/watchtower:arm64v8-latest

# Nginx
FROM nginx:latest

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./html /usr/share/nginx/html

EXPOSE 80
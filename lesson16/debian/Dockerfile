# syntax=docker/dockerfile:1
FROM  debian:11
RUN apt update && apt install nginx -y
RUN \
  mkdir -p /opt/www && \
  chown -R www-data:www-data /opt/www
COPY nginx/index.html /opt/www/index.html
COPY nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
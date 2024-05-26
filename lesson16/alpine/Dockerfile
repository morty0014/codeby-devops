# syntax=docker/dockerfile:1
FROM alpine:latest
RUN apk update && apk add nginx
RUN \
  mkdir -p /opt/www && \
  chown -R nginx:nginx /opt/www
RUN echo '<!DOCTYPE html><html lang="en"><head><meta charset="utf-8" /><title>HTML5</title></head><body>Server Nginx-Docker-Alpine is online</body></html>' > /opt/www/index.html
COPY nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
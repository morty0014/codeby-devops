# syntax=docker/dockerfile:1
FROM node:16-alpine AS build
WORKDIR /app
COPY app/package*.json ./
RUN npm install
COPY app/. .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
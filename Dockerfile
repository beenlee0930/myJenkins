FROM node:16.13.2 as build-stage
MAINTAINER jueon.jang@lotte.net
 
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
 
# production stage
FROM nginx:latest as production-stage
RUN apt-get update && apt-get install -y vim
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

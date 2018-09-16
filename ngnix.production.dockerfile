### Stage 1
FROM node:latest as node
LABEL author="Sebastián Guevara"
WORKDIR /app
COPY package.json package.json
RUN npm i
COPY . .
RUN npm run build

### Stage 2
FROM nginx:alpine
VOLUME var/cache/nginx
COPY --from=node /app/dist/demoApp /usr/share/nginx/html
COPY ./.docker/nginx.conf /etc/nginx/conf.d/default.conf

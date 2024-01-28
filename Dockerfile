FROM node:18-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html

# Docker build command for creating image from Dockerfile
# docker build -t swich313:frontend_prod .
# Docker run command for prod mode
#         localhost:8080 80 -> nginx default port
# docker run -p 8080:80 -t swich313:frontend_prod

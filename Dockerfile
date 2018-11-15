FROM resin/raspberrypi3-alpine-node:8.11.4 as builder
WORKDIR /npm-build
COPY . /npm-build
RUN npm install . && \
    npm run all

FROM lsioarmhf/nginx-armhf
COPY --from=builder /npm-build/dist/ /config/www/
EXPOSE 9000 80

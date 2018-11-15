FROM resin/raspberrypi3-alpine-node:8.11.4 as builder
WORKDIR /npm-build
COPY . /npm-build
RUN npm install . && \
    npm run all

FROM nginx:1.15.2-alpine
COPY --from=builder /npm-build/dist/ /usr/share/nginx/html/

ARG NODE_IMAGE_VERSION=10-alpine

# Create base image
FROM node:${NODE_IMAGE_VERSION} as base
RUN apk add --no-cache tini python make g++ supervisor
COPY . /npm-build
# Install process engine
FROM base as process_engine
WORKDIR /npm-build

RUN npm install . && \
    npm run all

FROM lsioarmhf/nginx-armhf
COPY --from=builder /npm-build/dist/ /config/www/
EXPOSE 9000 80

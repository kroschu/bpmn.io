ARG NODE_IMAGE_VERSION=10-alpine

# Create base image
FROM yobasystems/alpine-nodejs:${NODE_IMAGE_VERSION} as base
RUN apk add --no-cache tini python make g++ supervisor
WORKDIR /npm-build
COPY . /npm-build
# Install process engine
FROM base as process_engine

RUN npm install . && \
    npm run all

WORKDIR /npm-build/dist/
EXPOSE 9000 80

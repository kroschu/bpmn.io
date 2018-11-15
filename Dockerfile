ARG NODE_IMAGE_VERSION=arm32v7-min

# Create base image
FROM yobasystems/alpine-nodejs:${NODE_IMAGE_VERSION} as base
WORKDIR /npm-build
COPY . /npm-build
# Install process engine
FROM base as process_engine

RUN npm install . && \
    npm run all

WORKDIR /npm-build/dist/
CMD [ "npm", "start", "--", "--host=0.0.0.0", "--port=9000" ]

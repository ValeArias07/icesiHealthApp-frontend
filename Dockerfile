FROM node:14-alpine

RUN apk update

# Install bash
RUN apk add bash

# Download and install git
RUN apk add git

# Set workdir
WORKDIR /usr

ARG REPOSITORY
# Clone repo
RUN git clone $REPOSITORY

# Set workdir
WORKDIR /usr/icesiHealthApp-frontend/

RUN git log
# Add env vars
ARG ARG_PORT
ARG ARG_API_URL
ENV API_URL $ARG_API_URL
ENV PORT $ARG_PORT
EXPOSE $PORT

# Update npm version and install dependencies
RUN npm install -g npm@8.5.1

# Install dependencies
RUN npm install --include=dev


# Remove node_modules
RUN rm -rf node_modules

# Install express and cors
RUN npm install express@4.18.2
RUN npm install cors@2.8.5

# Entrypoint
CMD ["node", "app.js"]

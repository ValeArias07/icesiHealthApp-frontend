FROM node:14-alpine

RUN apk update

# Install bash
RUN apk add bash

# Download and install git
RUN apk add git

# Set workdir
WORKDIR /usr

# Clone repo
RUN git clone https://github.com/ValeArias07/icesiHealthApp-frontend

# Set workdir
WORKDIR /usr/icesiHealthApp-frontend/

# Add env vars
ENV PORT 3000
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

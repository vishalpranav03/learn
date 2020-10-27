FROM node:buster-slim

ARG snyk_auth_token

ENV SNYK_TOKEN=${snyk_auth_token}

# Create app directory
WORKDIR /usr/src/app

## Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"

RUN chmod -R +x ./snyk

RUN ./snyk test

EXPOSE 8080
CMD [ "node", "server.js" ]

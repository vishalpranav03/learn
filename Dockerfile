FROM node:4.6

ARG snyk_auth_token

ENV SNYK_TOKEN=${snyk_auth_token}

COPY package*.json ./

RUN npm install

COPY . .

RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"

RUN chmod -R +x ./snyk

RUN ./snyk test

EXPOSE 3000

CMD ["node", "index.js"]

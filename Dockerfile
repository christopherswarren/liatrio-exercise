FROM node:alpine as build

RUN apk add dumb-init

WORKDIR /app
COPY src ./src/
COPY test ./test/
COPY package.json package-lock.json ./
RUN npm ci && \
  npm test

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

CMD ["npm", "start"]
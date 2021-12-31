FROM node:17.3.0-alpine3.14 as build

WORKDIR /app

COPY package.json package-lock.json webpack.config.js /app/
COPY src /app/src/
COPY test /app/test/
RUN npm install --production --ignore-optional && \
    cp -R node_modules prod_node_modules && \
    npm install && \
    npm test && \
    ./node_modules/.bin/webpack --mode production

FROM alpine:3.15.0 as release

RUN apk add --no-cache nodejs

WORKDIR /app

COPY --from=build /app/prod_node_modules node_modules
COPY --from=build /app/dist .

EXPOSE 8080
CMD [ "node", "server.js" ]
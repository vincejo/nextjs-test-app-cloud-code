FROM node:10.13-alpine

ENV NODE_ENV production

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src/app && cp -a /tmp/node_modules /src/app

WORKDIR /src/app
ADD . .

RUN npm run build

EXPOSE 8080
EXPOSE 9229

# /usr/local/bin/node is a workaround for:
#   https://github.com/GoogleContainerTools/container-debug-support/issues/44
#   https://github.com/GoogleContainerTools/container-debug-support/issues/45
ENTRYPOINT ["/usr/local/bin/node", "./node_modules/.bin/next", "dev", "-p", "8080"]
FROM node:10.13-alpine

ENV NODE_ENV production

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src/app && cp -a /tmp/node_modules /src/app

WORKDIR /src/app
ADD . .

RUN npm run build

EXPOSE 8080
# expose node.js' debugging port
EXPOSE 9229

# run in dev mode for debugging.
CMD npm run dev
# ENTRYPOINT ["node", "./node_modules/.bin/next", "dev", "-p", "8080"]
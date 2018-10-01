FROM node:10.11-alpine
COPY bin/server /server
COPY public /public
ENTRYPOINT /server

FROM node:14-alpine as base

WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 3401
CMD node server.js
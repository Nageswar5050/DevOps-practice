FROM node:18
EXPOSE 8080
ENV MONGO=true
WORKDIR /opt/server
COPY package.json .
COPY server.js .
RUN npm install
CMD ["node", "server.js"]
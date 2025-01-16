FROM node:20.9.0

WORKDIR /home/node/app
# USER node

# COPY package*.json ./
# COPY --chown=node:node . .
COPY . .
RUN npm install

EXPOSE 8080
CMD [ "node", "./app1.js" ]

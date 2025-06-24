FROM node:14-alpine

WORKDIR /app

# COPY server.js .
# COPY index.html .
# COPY images ./images
# COPY package.json .

# Short version of the above COPY commands
COPY . .

RUN npm install

EXPOSE 3000

CMD ["node", "server.js"]

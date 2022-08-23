FROM node:14

WORkDIR /app

COPY package*.json ./

RUN npm install

COPY . .

CMD ["node", "app2.js"]

EXPOSE 9091
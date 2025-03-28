FROM node:18-alpine

WORKDIR /app

# Copie uniquement ce qui est nécessaire pour faire tourner l'app
COPY .next ./.next
COPY public ./public
COPY package.json ./
COPY node_modules ./node_modules
COPY next.config.js ./next.config.js

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npx", "next", "start"]
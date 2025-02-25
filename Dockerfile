FROM node:lts AS builder
WORKDIR /home/node/app
COPY package.json package-lock.json ./
RUN npm ci --verbose
COPY . .
RUN npm run build --configuration=production

# Use Nginx to serve the Angular app
FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

# Copy built Angular files
COPY --from=builder /home/node/app/dist/front/browser /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

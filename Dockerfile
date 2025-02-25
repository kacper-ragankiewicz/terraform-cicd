FROM node:lts

# Set working directory
WORKDIR /home/node/app

# Copy package.json and install dependencies
COPY --chown=node:node package.json package-lock.json ./
RUN npm ci --quiet

# Copy the remaining project files
COPY --chown=node:node . .

# Set user to non-root for security
USER node

# Expose the Angular default port
EXPOSE 4200

# Start the application
CMD ["npm", "start"]

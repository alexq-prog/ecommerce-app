# Use Node.js LTS version
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY . .

RUN npm run build

# Stage 2: serve with Nginx
FROM nginx:alpine

# Remove default nginx page
# RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy React build to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html


# Expose port (Cloud Run will set PORT env var)
EXPOSE 8080

# Set PORT environment variable (Cloud Run will override this)
# react-scripts start respects the PORT environment variable
ENV PORT=8080

ENV HOST=0.0.0.0

# Start the application using npm start
# Cloud Run will set the PORT environment variable automatically
# CMD ["npm", "start"]

CMD ["nginx", "-g", "daemon off;"]
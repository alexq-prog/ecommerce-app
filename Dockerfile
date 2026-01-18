# Use Node.js LTS version
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application files
COPY . .

# Expose port (Cloud Run will set PORT env var)
EXPOSE 8080

# Set PORT environment variable (Cloud Run will override this)
# react-scripts start respects the PORT environment variable
ENV PORT=8080

# Start the application using npm start
# Cloud Run will set the PORT environment variable automatically
CMD ["npm", "start"]

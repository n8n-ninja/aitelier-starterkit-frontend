# ---- Step 1: Build the Next.js application ----
    FROM node:18-alpine AS builder

    # Set working directory inside the container
    WORKDIR /app
    
    # Copy package files and install dependencies
    COPY package.json package-lock.json* ./
    RUN npm install
    
    # Copy the rest of the application code
    COPY . .
    
    # Build the Next.js application (both client and server)
    RUN npm run build
    
    # ---- Step 2: Create a minimal production image ----
    FROM node:18-alpine
    
    # Set working directory inside the final container
    WORKDIR /app
    
    # Copy only necessary files from builder
    COPY --from=builder /app/package.json ./
    COPY --from=builder /app/.next ./.next
    COPY --from=builder /app/public ./public
    COPY --from=builder /app/node_modules ./node_modules
    COPY --from=builder /app/next.config.ts ./next.config.ts
    
    # Set environment variables for production
    ENV NODE_ENV=production
    
    # Expose port 3000 for Next.js
    EXPOSE 3000
    
    # Start the Next.js application
    CMD ["npm", "start"]
    
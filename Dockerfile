# Stage 1: Build the Node.js application
FROM node:14-alpine AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package.json ./

# Install dependencies
RUN npm config set registry https://registry.npmjs.org/ && npm install

# Copy the application source code (from your host folder structure)
COPY . .

# (Optional) Run the build step if needed (remove this if there's no build step)
# RUN npm run build

# Stage 2: Runtime
FROM node:14-alpine AS runtime

# Set the working directory
WORKDIR /usr/src/app

# Copy the built application from the previous stage
COPY --from=build /usr/src/app /usr/src/app

# Expose the port your app runs on
EXPOSE 8080

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set environment variables
ENV NODE_ENV=production

# Start the application
CMD ["node", "application.js"]

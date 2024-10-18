#Dockerfile
# Stage 1: Build the Node.js application
FROM node:14-alpine AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Define the proxy URL as an environment variable (only if needed)
# ENV PROXY_URL=http://your-proxy:8080
#ENV NO_PROXY=localhost,127.0.0.1
#ENV NO_PROXY=http://localhost:8080
#ENV HTTP_PROXY=http://localhost
#ENV HTTPS_PROXY=http://localhost

# Set the proxy configuration for npm (only if needed)
# RUN npm config set proxy ${PROXY_URL} \
#     && npm config set https-proxy ${PROXY_URL}
#RUN npm config set proxy ${NO_PROXY} \
#    && npm config set https-proxy ${NO_PROXY}
#RUN npm config set proxy ${HTTP_PROXY} \
#    && npm config set https-proxy ${HTTPS_PROXY}

# Copy package.json and package-lock.json to the working directory
COPY package.json ./
#COPY package.json package-lock.json ./

# Install dependencies
#RUN npm install
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

# Set environment variables
ENV NODE_ENV=production

# Start the application
CMD ["node", "application.js"]

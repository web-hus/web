# Use Node.js for building the React app
FROM node:18-alpine as build

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the source code
COPY . .

# Build the React app
RUN npm run build

# Use Node.js for serving the built app
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Install a lightweight static file server (e.g., 'serve')
RUN npm install -g serve

# Copy the built app from the previous stage
COPY --from=build /app/build ./build

# Expose the port where the app will run
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "build", "-l", "3000"]

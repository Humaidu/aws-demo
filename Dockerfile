FROM node:18 as build

WORKDIR /app
COPY package*.json ./

#Install dependencies
RUN npm install

#Copy Source code to /app
COPY . .

#Build Angular App
RUN npm Build

#Using multi-stage for nginx webserver
FROM nginx:alpine

# Copy built Angular app from the previous build stage
COPY --from=build /app/dist/aws_demo_angular/ /usr/share/nginx/html

# Expose port 80 to serve the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


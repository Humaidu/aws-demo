FROM node:18 as build

WORKDIR /app
COPY package*.json ./

#Install dependencies
RUN npm install

#Copy Source code to /app
COPY . .

#Build Angular App
RUN npm run build

#Using multi-stage for nginx webserver
FROM nginx:1.27.2-alpine-slim


# Set the working directory inside the Nginx container
WORKDIR /usr/share/nginx/html

RUN chown -R nginx:nginx /var/run/nginx.pid

# Remove existing files in /var/www/html (Nginx default serving directory)
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from the previous build stage
COPY --from=build /app/dist/aws_demo_angular/ /usr/share/nginx/html

# Expose port 80 to serve the app
EXPOSE 80

# Restart Nginx after copying the new files
CMD ["nginx", "-s", "reload"] && ["nginx", "-g", "daemon off;"]


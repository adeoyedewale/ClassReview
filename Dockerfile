FROM node:alpine

RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/

# Create a directory for the app
RUN mkdir -p /usr/src/backend
RUN mkdir -p /usr/src/frontend

# Copy the source code of the app
COPY backend /usr/src/backend
COPY frontend /usr/src/frontend

# Set the working directory
WORKDIR /usr/src/backend

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the app
# RUN npm run build

# Expose the port
EXPOSE 8080

# Start the application
#CMD ["npm", "ci" ]
#CMD [ "npm", "start" ]

#set the working directory 
WORKDIR /usr/src/frontend

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the app
RUN npm run build

# Expose the port
EXPOSE 3000

# Start the application
#CMD ["npm", "ci"]
#CMD [ "npm", "start" ]
CMD ["/usr/bin/supervisord"]

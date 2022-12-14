# First stage builds the application
FROM registry.redhat.io/ubi8/nodejs-14 as builder

# Add application sources
COPY pack*.json $HOME
# Install the dependencies
#RUN npm install 
RUN npm install -g
COPY server.js $HOME


# Second stage copies the application to the minimal image
FROM registry.redhat.io/ubi8/nodejs-14-minimal

# Copy the application source and build artifacts from the builder image to this one
COPY --from=builder $HOME $HOME

# Run script uses standard ways to run the application
EXPOSE 8080
USER 1001
CMD [ "node", "server.js" ]

# If you use mac m1 => "add --platform linux/amd64"


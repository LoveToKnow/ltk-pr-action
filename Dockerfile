# Container image that runs your code
FROM node:14-alpine

# Install tools needed
RUN apk add --no-cache \
            jq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY .npmrc.ci /.npmrc.ci

# make the script executable 
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

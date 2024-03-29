# Container image that runs your code
# FROM alpine:3.10
# RUN apk add --update docker openrc
# RUN rc-update add docker boot
FROM jekyll/jekyll:3.8.5

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

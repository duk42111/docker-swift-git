# Set ubuntu version
FROM ubuntu:14.04

# Set environment vars
ENV SWIFT_VERSION 2.2-SNAPSHOT-2016-02-08-a
ENV SWIFT_PLATFORM ubuntu14.04
ENV SWIFT_PLATFORM_FOLDER ubuntu1404

# Update to latest packages
RUN apt-get update && apt-get upgrade -y

# Install dependencies
RUN apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libicu52 rsync libxml2 git && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

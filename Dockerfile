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
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Install swift    
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - \
 && wget https://swift.org/builds/$SWIFT_PLATFORM_FOLDER/swift-$SWIFT_VERSION/swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz \
 && wget https://swift.org/builds/$SWIFT_PLATFORM_FOLDER/swift-$SWIFT_VERSION/swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig \
 && gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift \
 && gpg --verify swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig \
 && tar xzf swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz \
 && rm swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz \
 && rm swift-$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz.sig \
 && rsync -a -v --ignore-existing swift-$SWIFT_VERSION-$SWIFT_PLATFORM/usr/ /usr \
 && rm -rf swift-$SWIFT_VERSION-$SWIFT_PLATFORM

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Show Swift Version
RUN swift --version

# Install git
RUN apt-get install -y git

# Add git commands to allow container updating
ADD ./pull /usr/bin/pull
RUN chmod 755 /usr/bin/pull

# Setup Volume
VOLUME ["/usr/share/swift"]

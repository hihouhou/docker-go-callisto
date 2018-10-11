#
# Go-callisto Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV GOROOT /usr/local/go
ENV GOPATH /opt/go-callisto
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
ENV GO_CALLISTO_VERSION 1.1.0

# Update & install packages for go-callisto dep
RUN apt-get update && \
    apt-get install -y wget git make build-essential

# Get go
RUN wget https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz && \
    tar -xvf go1.10.linux-amd64.tar.gz && \
    mv go /usr/local

# Get go-callisto from github
RUN mkdir /opt/go-callisto && \
    cd /opt/go-callisto && \
    wget https://api.github.com/repos/EthereumCommonwealth/go-callisto/tarball/${GO_CALLISTO_VERSION} -O ${GO_CALLISTO_VERSION}.tar.gz && \
    tar xf  ${GO_CALLISTO_VERSION}.tar.gz --strip-components=1

# Install hugo
WORKDIR /opt/go-callisto
RUN make all && mv build/bin/* /usr/local/bin/

CMD geth $OPTIONS

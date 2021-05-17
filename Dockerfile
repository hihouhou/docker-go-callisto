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
ENV GO_CALLISTO_VERSION 1.3
ENV GO_VERSION 1.12

# Update & install packages for go-callisto dep
RUN apt-get update && \
    apt-get install -y wget git make build-essential

WORKDIR /opt/go-callisto

RUN wget https://github.com/EthereumCommonwealth/go-callisto/releases/download/1.2/geth-linux-amd64 && \
    chmod +x geth-linux-amd64

CMD ./geth-linux-amd64 $OPTIONS

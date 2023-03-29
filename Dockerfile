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
ENV GO_CALLISTO_VERSION 1.10.13
ENV GO_VERSION 1.18.3

# Update & install packages for go-callisto dep
RUN apt-get update && \
    apt-get install -y wget git make build-essential curl jq

WORKDIR /opt/go-callisto

RUN groupadd -r callisto && useradd -u 1000 -ms /bin/bash -g callisto callisto && chown -R callisto: /opt/go-callisto

USER callisto

RUN cd /opt/go-callisto && \
    wget https://github.com/EthereumCommonwealth/go-callisto/releases/download/${GO_CALLISTO_VERSION}/geth-linux-amd64 && \
    chmod +x geth-linux-amd64

CMD ./geth-linux-amd64 $OPTIONS

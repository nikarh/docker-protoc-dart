FROM google/dart:2.12-dev

RUN apt-get update && \
    apt-get -y install unzip

ENV PUB_CACHE=/pub-cache

ARG PROTOC_VERSION="3.14.0"
ARG PLATFORM="linux"
ARG ARCH="x86_64"
ENV BASE_URL="https://github.com/protocolbuffers/protobuf/releases/download"
ENV PROTOC_URL="${BASE_URL}/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-${PLATFORM}-${ARCH}.zip"

RUN curl -sSL -o /tmp/protoc_temp.zip ${PROTOC_URL} && \
    unzip /tmp/protoc_temp.zip -d /usr/local && \
    rm /tmp/protoc_temp.zip && \
    chmod +x /usr/local/bin/* && \
    pub global activate protoc_plugin 20.0.0-nullsafety.1

ENV PATH /pub-cache/bin:$PATH
ENV PROTO_DIR /usr/local/include

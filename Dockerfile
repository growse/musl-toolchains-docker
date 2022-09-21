# syntax=docker/dockerfile:1
FROM debian:bullseye as musltools

LABEL org.opencontainers.image.authors="github@growse.com"

RUN --mount=type=cache,target=/var/cache/apt apt-get update && apt-get install --no-install-recommends -y curl unzip build-essential ca-certificates

LABEL org.opencontainers.image.title="growse/musl-toolchains"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/growse/musl-toolchains"
LABEL org.opencontainers.image.source="https://github.com/growse/musl-toolchains-docker"

ARG BUILD_DATE
LABEL org.opencontainers.image.created=$BUILD_DATE

ARG VCS_REF
LABEL org.opencontainers.image.revision=$VCS_REF


RUN mkdir /musl-toolchains
WORKDIR /musl-toolchains

ARG MUSL_VERSION
ARG ZLIB_VERSION

RUN curl -L -O http://more.musl.cc/${MUSL_VERSION}/x86_64-linux-musl/x86_64-linux-musl-native.tgz && tar -zxvf x86_64-linux-musl-native.tgz && rm x86_64-linux-musl-native.tgz
RUN curl -L -o zlib.zip https://github.com/madler/zlib/archive/refs/tags/v${ZLIB_VERSION}.zip && unzip zlib.zip && rm zlib.zip

WORKDIR /musl-toolchains/zlib-${ZLIB_VERSION}
ENV CC=/musl-toolchains/x86_64-linux-musl-native/bin/gcc
RUN ./configure --prefix=/musl-toolchains/x86_64-linux-musl-native --static && make && make install
RUN rm -rf /musl-toolchains/zlib-*

FROM alpine:3.16
COPY --from=musltools /musl-toolchains /musl-toolchains

FROM ubuntu:18.04
LABEL maintainer="Leo Sun <leosunsl@outlook.com>"
LABEL Description="Image for building and debugging arm-embedded projects from git"
WORKDIR /work

ARG gcc_release=12.3.rel1
ARG gcc_variant=arm-none-eabi
ARG arch=x86_64

LABEL GCC_RELEASE=$gcc_release
ADD . /work

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      git \
      bzip2 \
      wget && \
    apt-get clean

RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu/${gcc_release}/binrel/arm-gnu-toolchain-${gcc_release}-${arch}-${gcc_variant}.tar.xz | tar -xJ

ENV PATH "/work/arm-gnu-toolchain-${gcc_release}-${arch}-${gcc_variant}/bin:$PATH"


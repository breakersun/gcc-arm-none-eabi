FROM ubuntu:18.04
LABEL maintainer="Leo Sun <leosunsl@outlook.com>"
LABEL Description="Image for building and debugging arm-embedded projects from git"
WORKDIR /work

ARG gcc_release=7-2018q2
ARG gcc_full_release=7-2018-q2-update
ARG gcc_variant=arm-none-eabi

LABEL GCC_RELEASE=$gcc_release
LABEL GCC_FULL_RELEASE=$gcc_full_release
ADD . /work

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      git \
      bzip2 \
      wget && \
    apt-get clean

RUN wget -qO https://developer.arm.com/-/media/Files/downloads/gnu-rm/${gcc_release}/gcc-${gcc_variant}-${gcc_full_release}-linux.tar.bz2 | tar -xj

ENV PATH "/work/gcc-${gcc_variant}-${gcc_full_release}/bin:$PATH"


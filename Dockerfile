FROM ubuntu:18.04
LABEL maintainer="Leo Sun <leosunsl@outlook.com>"
LABEL Description="Image for building and debugging arm-embedded projects from git"
WORKDIR /work

ARG gcc_release=5_4-2016q3
ARG gcc_full_release=5_4-2016q3
ARG gcc_variant=arm-none-eabi
ARG date_stamp=20160926

LABEL GCC_RELEASE=$gcc_release
LABEL GCC_FULL_RELEASE=$gcc_full_release
ADD . /work

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      git \
      bzip2 \
      curl && \
    apt-get clean

# GCC ARM toolchain 2016q3
RUN curl -L -o /opt/gcc-arm-none-eabi-5.tar.bz2 https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 2>/dev/null && \
    tar xjf /opt/gcc-arm-none-eabi-5.tar.bz2 -C /opt && \
    rm /opt/gcc-arm-none-eabi-5.tar.bz2 && \
    ln -s /opt/gcc-arm-none-eabi-5_4-2016q3 /opt/gcc-arm-none-eabi-5
ENV PATH="${PATH}:/opt/gcc-arm-none-eabi-5/bin"


FROM frolvlad/alpine-glibc:alpine-3.8

ARG gcc_release=7-2018q2
ARG gcc_full_release=7-2018-q2-update
ARG gcc_variant=arm-none-eabi

LABEL GCC_RELEASE=$gcc_release
LABEL GCC_FULL_RELEASE=$gcc_full_release

ENV PATH="/opt/gcc-installation/bin:${PATH}"

RUN mkdir /opt/

RUN cd /opt/ && \
\
	(if [ ! -f gcc-install.tar.bz2 ]; then \
		apk update && \
		apk add ca-certificates wget && \
		update-ca-certificates && \
		wget -qO gcc-install.tar.bz2 "https://developer.arm.com/-/media/Files/downloads/gnu-rm/${gcc_release}/gcc-${gcc_variant}-${gcc_full_release}-linux.tar.bz2"; \
	fi) && \
\
	echo "Extracting files..." && \
	tar -xjf gcc-install.tar.bz2 && \
	rm -f gcc-install.tar.bz2 && \
	mv gcc-*/ gcc-installation/ && \
	echo "Cleaning up..." && \
	cd gcc-installation && \
	rm -rf share && \
	./bin/${gcc_variant}-gcc --version

FROM gcc:9.4.0 as builder
ARG NPROC
RUN apt-get update && apt-get install -y wget make cpio rsync bc file && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://buildroot.org/downloads/buildroot-2021.02.4.tar.gz && \
    tar zxf buildroot-2021.02.4.tar.gz && rm -rf buildroot-2021.02.4.tar.gz
WORKDIR /buildroot-2021.02.4
COPY .config .
RUN make -j $NPROC sdk && mv -f /buildroot-2021.02.4/output/host /sdk/ && \
    /sdk/relocate-sdk.sh


FROM ubuntu:21.04
COPY --from=builder /sdk/ /sdk/
ENTRYPOINT ["/sdk/bin/arm-linux-g++"]

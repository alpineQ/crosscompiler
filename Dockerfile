FROM debian:bullseye-slim as builder
RUN apt-get update && apt-get install -y wget make python3 \
    cpio rsync bc file gcc g++ patch unzip bzip2 perl && \
    wget https://buildroot.org/downloads/buildroot-2021.02.4.tar.gz -O buildroot.tar.gz && \
    tar zxf buildroot.tar.gz && rm -rf buildroot.tar.gz
WORKDIR /buildroot-2021.02.4
COPY .config .
ARG NPROC
RUN make -j $NPROC sdk && mv -f /buildroot-2021.02.4/output/host /sdk/ && \
    /sdk/relocate-sdk.sh

FROM debian:bullseye-slim
COPY --from=builder /sdk/ /sdk/
ENTRYPOINT ["/sdk/bin/arm-linux-g++"]

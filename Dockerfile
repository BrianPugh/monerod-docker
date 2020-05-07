FROM ubuntu:latest

# Confirm on your own that version/hash is correct
ENV MONERO_VERSION 0.15.0.5
ENV MONERO_HASH 6cae57cdfc89d85c612980c6a71a0483bbfc1b0f56bbb30e87e933e7ba6fc7e7 

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root
RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v${MONERO_VERSION}.tar.bz2 -O &&\
    echo ${MONERO_HASH} monero-linux-x64-v${MONERO_VERSION}.tar.bz2 | sha256sum --check &&\
    tar -xjvf monero-linux-x64-v${MONERO_VERSION}.tar.bz2 && \
    rm monero-linux-x64-v${MONERO_VERSION}.tar.bz2 && \
    mv ./monero-x86_64-linux-gnu-v${MONERO_VERSION}/* . && \
    rmdir monero-x86_64-linux-gnu-v${MONERO_VERSION}

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]

FROM ubuntu:latest

# Confirm on your own that version/hash is correct
ENV MONERO_VERSION 0.12.3.0
ENV MONERO_HASH 72fe937aa2832a0079767914c27671436768ff3c486597c3353a8567d9547487 

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root
RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v${MONERO_VERSION}.tar.bz2 -O &&\
    echo ${MONERO_HASH} monero-linux-x64-v${MONERO_VERSION}.tar.bz2 | sha256sum --check &&\
    tar -xjvf monero-linux-x64-v${MONERO_VERSION}.tar.bz2 && \
    rm monero-linux-x64-v${MONERO_VERSION}.tar.bz2 && \
    cp ./monero-v${MONERO_VERSION}/monerod . && \
    rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]

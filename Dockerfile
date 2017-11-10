# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM alpine:latest

ENV MONERO_VERSION 0.11.1.0

RUN apk update && apk add curl bzip2

WORKDIR /root
RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v${MONERO_VERSION}.tar.bz2 -O &&\
  tar -xjvf monero-linux-x64-v${MONERO_VERSION}.tar.bz2 &&\
  rm monero-linux-x64-v${MONERO_VERSION}.tar.bz2 &&\
  cp ./monero-v${MONERO_VERSION}/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]

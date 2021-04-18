FROM debian:buster-slim AS downloader
ARG VERSION=0.21.0

RUN apt update && apt install -y curl gpg
COPY download_binary.sh .
RUN bash download_binary.sh $VERSION


FROM debian:buster-slim
# Add user and setup directories for monerod
RUN useradd -ms /bin/bash bitcoin \
    && mkdir -p /home/bitcoin/.bitcoin \
    && chown -R bitcoin:bitcoin /home/bitcoin/.bitcoin
USER bitcoin

# Switch to home directory and install newly built monerod binary
WORKDIR /home/bitcoin

COPY --chown=bitcoin:bitcoin --from=downloader /usr/local/bin/bitcoind /usr/local/bin/bitcoind

# Expose p2p and restricted RPC ports
EXPOSE 8332
EXPOSE 8333

ENTRYPOINT ["bitcoind"]

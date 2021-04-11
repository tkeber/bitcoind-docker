FROM debian:buster-slim
ARG BINARY=bitcoind.0.21.0-arm-linux-gnueabihf

# Add user and setup directories for monerod
RUN useradd -ms /bin/bash bitcoin && mkdir -p /home/bitcoin/.bitcoin \
    && chown -R bitcoin:bitcoin /home/bitcoin/.bitcoin
USER bitcoin

# Switch to home directory and install newly built monerod binary
WORKDIR /home/bitcoin
COPY --chown=bitcoin:bitcoin $BINARY /usr/local/bin/bitcoind

# Expose p2p and restricted RPC ports
EXPOSE 8332
EXPOSE 8333

ENTRYPOINT ["bitcoind"]

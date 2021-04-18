#!/usr/bin/env bash
set -x
version=$1
architecture=`uname -m`

case $architecture in
aarch64)
  archive="bitcoin-${version}-aarch64-linux-gnu.tar.gz"
  ;;
armv7l)
  archive="bitcoin-${version}-arm-linux-gnueabihf.tar.gz"
  ;;
x86_64)
  archive="bitcoin-${version}-x86_64-linux-gnu.tar.gz"
esac

dir="https://bitcoincore.org/bin/bitcoin-core-${version}/"

gpg --import laanwj-releases.asc 


curl -sko "SHA256SUMS.asc" "$dir/SHA256SUMS.asc"
curl -sko "$archive" "$dir/$archive"

gpg --verify SHA256SUMS.asc

sha256sum --ignore-missing --check SHA256SUMS.asc

tar xvfz "$archive" "bitcoin-$version/bin/bitcoind"
mv "bitcoin-$version/bin/bitcoind" "/usr/local/bin/bitcoind"
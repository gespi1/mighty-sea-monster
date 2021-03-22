#!/bin/bash
set -e
echo "Checking image SHA" > /dev/stdout

# in this case, the source of truth comes from the docker image itself
# there was a checksum done on the litecoin binary to verify the authenticity of the litecoin binary
# original Dockerfile for image: https://github.com/uphold/docker-litecoin-core/blob/0.18.1/0.18/Dockerfile
#
# as a DevOps what we really want to verify is if the uphold/litecoin-core image is authentic
#
# verifying image authenticity with by pulling the digest from hub.docker.hub using reg and comparing to the digest locally
DOCKERHUB_DIGEST=`reg digest uphold/litecoin-core:${LITECOIN_VERSION}`
LOCAL_DIGEST=`docker inspect uphold/litecoin-core:${LITECOIN_VERSION} | grep "uphold/litecoin-core" | grep sha | cut -d \@ -f 2` 
LOCAL_DIGEST=${LOCAL_DIGEST::-1} # must have at least bash version 4.2 or this string manipulation won't work

if [[ "$DOCKERHUB_DIGEST" != "$LOCAL_DIGEST" ]]; then 
  printf "SHAs didnt match\nhub.docker.com ${DOCKERHUB_DIGEST}\nlocal digest ${LOCAL_DIGEST}" > /dev/stdout
  exit 1
else 
  echo "SHAs match!" > /dev/stdout
fi

######## took entry point from https://github.com/uphold/docker-litecoin-core/blob/0.18.1/0.18/docker-entrypoint.sh
if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for litecoind"

  set -- litecoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "litecoind" ]; then
  mkdir -p "$LITECOIN_DATA"
  chmod 770 "$LITECOIN_DATA" || echo "Could not chmod $LITECOIN_DATA (may not have appropriate permissions)"
  chown -R litecoin "$LITECOIN_DATA" || echo "Could not chown $LITECOIN_DATA (may not have appropriate permissions)"

  echo "$0: setting data directory to $LITECOIN_DATA"

  set -- "$@" -datadir="$LITECOIN_DATA"
fi

if [ "$(id -u)" = "0" ] && ([ "$1" = "litecoind" ] || [ "$1" = "litecoin-cli" ] || [ "$1" = "litecoin-tx" ]); then
  set -- gosu litecoin "$@"
fi

exec "$@"
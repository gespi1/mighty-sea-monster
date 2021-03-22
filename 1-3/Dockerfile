# searched around for litecoin images on hub.docker.com
FROM uphold/litecoin-core:0.18.1

# installing Docker based on this install guide: https://devopscube.com/run-docker-in-docker/
RUN apt-get update \
    && curl -sSL https://get.docker.com/ | sh +x

# going to grab the image SHA from dockerhub using 'reg' tool; link below
# https://github.com/genuinetools/reg
#
# following 'reg' installation guide for amd64 linux `https://github.com/genuinetools/reg/releases`
RUN export REG_SHA256="ade837fc5224acd8c34732bf54a94f579b47851cc6a7fd5899a98386b782e228" \ 
    && curl -s -fSL "https://github.com/genuinetools/reg/releases/download/v0.16.1/reg-linux-amd64" -o "/usr/local/bin/reg" \
	&& echo "${REG_SHA256}  /usr/local/bin/reg" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/reg"


# see kraken-test/1-3/entrypoint.sh for more info
COPY entrypoint.sh /entrypoint.sh
RUN chown $(whoami): /entrypoint.sh && chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]








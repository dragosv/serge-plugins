FROM debian:stretch AS builder

RUN  apt-get update \
  && apt-get install -y curl wget jq \
  && mkdir /mojito \
  && cd /mojito \
  && wget $(curl -s https://api.github.com/repos/box/mojito/releases/latest | jq -r ".assets[] | select(.name | test(\"mojito-cli\")) | .browser_download_url") -O mojito-cli.jar

FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge
COPY --from=builder /mojito /tmp

RUN apt-get -y install openjdk-8-jre \
    && mkdir /etc/mojito \
    && mkdir /etc/mojito/cli \
    && cp /tmp/mojito-cli.jar /etc/mojito/cli \
    && printf '#!/bin/sh\njava -Dspring.config.location=/etc/mojito/cli/ -jar /etc/mojito/cli/mojito-cli.jar "$@"' > /usr/bin/mojito \
    && chmod +x /usr/bin/mojito \
    && mojito -v
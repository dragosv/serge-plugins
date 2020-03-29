FROM debian:buster AS builder

RUN  apt-get update \
  && apt-get install -y curl wget jq \
  && mkdir /mojito \
  && cd /mojito \
  && wget $(curl -s https://api.github.com/repos/box/mojito/releases/latest | jq -r ".assets[] | select(.name | test(\"mojito-cli\")) | .browser_download_url") -O mojito-cli.jar

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/mojito.pm /serge/lib/Serge/Sync/Plugin/TranslationService/mojito.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/mojito/. /serge/t/data/plugins/mojito

COPY --from=builder /mojito /tmp

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/mojito.pm Serge::Sync::Plugin::TranslationService::mojito \
    && apt-get install -y wget software-properties-common \
    && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update && apt-get -y install adoptopenjdk-8-hotspot \
    && mkdir /etc/mojito \
    && mkdir /etc/mojito/cli \
    && cp /tmp/mojito-cli.jar /etc/mojito/cli \
    && printf '#!/bin/sh\njava -Dspring.config.location=/etc/mojito/cli/ -jar /etc/mojito/cli/mojito-cli.jar "$@"' > /usr/bin/mojito \
    && chmod +x /usr/bin/mojito \
    && mojito -v

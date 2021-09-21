FROM debian:buster AS builder

RUN  apt-get update \
  && apt-get install -y curl wget jq \
  && mkdir /phrase \
  && cd /phrase \
  && wget $(curl -s https://api.github.com/repos/phrase/phrase-cli/releases/latest | jq -r ".assets[] | select(.name | test(\"phrase_linux_amd64\")) | .browser_download_url") -O phrase

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/phrase.pm /serge/lib/Serge/Sync/Plugin/TranslationService/phrase.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/phrase/. /serge/t/data/plugins/phrase

COPY --from=builder /phrase /tmp

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/phrase.pm Serge::Sync::Plugin::TranslationService::phrase \
    && cp /tmp/phrase /usr/local/bin \
    && chmod +x /usr/local/bin/phrase


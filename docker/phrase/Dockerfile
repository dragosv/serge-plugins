FROM debian:stretch AS builder

RUN  apt-get update \
  && apt-get install -y curl wget jq \
  && mkdir /phrase \
  && cd /phrase \
  && wget $(curl -s https://api.github.com/repos/phrase/phraseapp-client/releases/latest | jq -r ".assets[] | select(.name | test(\"linux_amd64\")) | .browser_download_url") -O phraseapp

FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge
COPY --from=builder /phrase /tmp

RUN cp /tmp/phraseapp /usr/local/bin \
    && chmod +x /usr/local/bin/phraseapp
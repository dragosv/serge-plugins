FROM debian:buster

RUN  apt-get update \
  && apt-get install -y wget \
  && mkdir /lokalise \
  && cd /lokalise \
  && wget https://github.com/lokalise/lokalise-cli-2-go/releases/latest/download/lokalise2_linux_x86_64.tar.gz -O lokalise2.tgz \
  && tar zxvf lokalise2.tgz

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/lokalise.pm /serge/lib/Serge/Sync/Plugin/TranslationService/lokalise.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/lokalise/. /serge/t/data/plugins/lokalise

COPY --from=0 /lokalise /tmp

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/lokalise.pm Serge::Sync::Plugin::TranslationService::lokalise \
    && cp /tmp/lokalise2 /usr/local/bin \
    && chmod +x /usr/local/bin/lokalise2 \
    && lokalise2 --version
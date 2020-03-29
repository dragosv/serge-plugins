FROM debian:buster

RUN  apt-get update \
  && apt-get install -y wget \
  && mkdir /lokalise \
  && cd /lokalise \
  && wget https://s3-eu-west-1.amazonaws.com/lokalise-assets/cli/lokalise-0.721-linux-amd64.tgz -O lokalise.tgz \
  && tar zxvf lokalise.tgz

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
    && cp /tmp/lokalise /usr/local/bin \
    && chmod +x /usr/local/bin/lokalise \
    && lokalise --version
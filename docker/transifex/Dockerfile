FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/transifex.pm /serge/lib/Serge/Sync/Plugin/TranslationService/transifex.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/transifex/. /serge/t/data/plugins/transifex

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/transifex.pm Serge::Sync::Plugin::TranslationService::transifex \
    && apt-get -y install python3-pip git \
    && pip3 install transifex-client \
    && tx --version

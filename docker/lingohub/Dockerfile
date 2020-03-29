FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/lingohub.pm /serge/lib/Serge/Sync/Plugin/TranslationService/lingohub.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/lingohub/. /serge/t/data/plugins/lingohub

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/lingohub.pm Serge::Sync::Plugin::TranslationService::lingohub \
    && apt-get -y install ruby-full \
    && apt-get -y install build-essential bison openssl curl libgmp3-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool \
    && gem install lingohub \
    && lingohub version

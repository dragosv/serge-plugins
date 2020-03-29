FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/weblate.pm /serge/lib/Serge/Sync/Plugin/TranslationService/weblate.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/weblate/. /serge/t/data/plugins/weblate

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/weblate.pm Serge::Sync::Plugin::TranslationService::weblate \
    && apt-get -y install python3-pip git \
    && cd /tmp \
    && git clone https://github.com/WeblateOrg/wlc.git \
    && pip3 install -e /tmp/wlc \
    && wlc --version

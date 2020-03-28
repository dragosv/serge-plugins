FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/locize.pm /serge/lib/Serge/Sync/Plugin/TranslationService/locize.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/locize/. /serge/t/data/plugins/locize

RUN apt-get -y install curl software-properties-common aptitude\
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs \
    && aptitude install -y npm \
    && npm install -g locize-cli \
    && locize --version

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/crowdin.pm /serge/lib/Serge/Sync/Plugin/TranslationService/crowdin.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/crowdin/. /serge/t/data/plugins/crowdin

RUN cpan -j /serge/lib/Serge/Sync/Plugin/TranslationService/crowdin.pm Serge::Sync::Plugin::TranslationService::crowdin \
    && apt-get install -y wget software-properties-common \
    && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update && apt-get -y install adoptopenjdk-8-hotspot \
    && cd /tmp \
    && wget https://artifacts.crowdin.com/repo/deb/crowdin.deb -O crowdin.deb \
    && dpkg -i crowdin.deb \
    && crowdin --version

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY lib/Serge/Sync/Plugin/TranslationService/zanata.pm /serge/lib/Serge/Sync/Plugin/TranslationService/zanata.pm
COPY t/plugins.t /serge/t/plugins.t
COPY t/compile.t /serge/t/compile.t
COPY t/lib/. /serge/t/lib
COPY t/data/plugins/zanata/. /serge/t/data/plugins/zanata
    
RUN apt-get install -y wget software-properties-common maven unzip\
    && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update && apt-get -y install adoptopenjdk-8-hotspot \
    && mkdir /etc/zanata \
    && mkdir /etc/zanata/cli \
    && cd /tmp \
    && wget https://search.maven.org/remotecontent?filepath=org/zanata/zanata-cli/4.6.2/zanata-cli-4.6.2-dist.zip -O zanata-cli-dist.zip \
    && unzip zanata-cli-dist.zip -d /tmp \
    && cp -a /tmp/zanata-cli-4.6.2/. /etc/zanata/cli/ \
    && chmod +x /etc/zanata/cli/bin/zanata-cli \
    && export PATH="/etc/zanata/cli/bin:$PATH" \
    && zanata-cli --version
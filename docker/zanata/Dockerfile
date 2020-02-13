FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge

RUN apt-get -y install openjdk-8-jre maven wget unzip\
    && mkdir /etc/zanata \
    && mkdir /etc/zanata/cli \
    && cd /tmp \
    && wget https://search.maven.org/remotecontent?filepath=org/zanata/zanata-cli/4.6.2/zanata-cli-4.6.2-dist.zip -O zanata-cli-dist.zip \
    && unzip zanata-cli-dist.zip -d /tmp \
    && cp -a /tmp/zanata-cli-4.6.2/. /etc/zanata/cli/ \
    && chmod +x /etc/zanata/cli/bin/zanata-cli \
    && export PATH="/etc/zanata/cli/bin:$PATH" \
    && zanata-cli --version
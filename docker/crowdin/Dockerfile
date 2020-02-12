FROM debian:stretch

RUN  apt-get update \
  && apt-get install -y wget \
  && mkdir /crowdin \
  && cd /crowdin \
  && wget https://artifacts.crowdin.com/repo/deb/crowdin.deb -O crowdin.deb

FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge
COPY --from=0 /crowdin /tmp

RUN apt-get -y install openjdk-8-jre \
    && cd /tmp \
    && dpkg -i crowdin.deb \
    && crowdin --version

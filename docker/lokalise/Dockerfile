FROM debian:stretch

RUN  apt-get update \
  && apt-get install -y wget \
  && mkdir /lokalise \
  && cd /lokalise \
  && wget https://s3-eu-west-1.amazonaws.com/lokalise-assets/cli/lokalise-0.721-linux-amd64.tgz -O lokalise.tgz \
  && tar zxvf lokalise.tgz

FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge
COPY --from=0 /lokalise /tmp

RUN cp /tmp/lokalise /usr/local/bin \
    && chmod +x /usr/local/bin/lokalise \
    && lokalise --version

FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge

RUN apt-get -y install python3-pip git \
    && cd /tmp \
    && git clone https://github.com/WeblateOrg/wlc.git \
    && pip3 install -e /tmp/wlc \
    && wlc --version
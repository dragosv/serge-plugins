FROM dragosvr/serge:buster

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge

RUN apt-get -y install python3-pip \
    && pip3 install wlc \
    && wlc --version
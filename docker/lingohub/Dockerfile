FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge

RUN apt-get -y install ruby-full

RUN apt-get -y install build-essential bison openssl curl libgmp3-dev \
    && apt-get -y install git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool

RUN gem install lingohub
FROM dragosvr/serge

LABEL maintainers="Dragos Varovici <dvarovici.work@gmail.com>"
LABEL git_sha1="${GIT_SHA1}"

COPY . /serge

RUN apt-get -y install curl \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get install -y nodejs \
    && apt-get install -y npm \
    && npm install -g locize-cli
[Serge](https://serge.io/) Plugins
============

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Build Status](https://img.shields.io/travis/dragosv/serge-plugins/master.svg?label=linux+build)](https://travis-ci.org/dragosv/serge-plugins)
[![Build status](https://ci.appveyor.com/api/projects/status/tb6j1owidqvdfx90/branch/master?svg=true&passingText=windows%20build%20passing&failingText=windows%20build%20failing&pendingText=windows%20build%20pending)](https://ci.appveyor.com/project/dragosv/serge-plugins/branch/master) [![codecov](https://codecov.io/gh/dragosv/serge-plugins/branch/master/graph/badge.svg)](https://codecov.io/gh/dragosv/serge-plugins)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=shields)](http://makeapullrequest.com)
[![Join the chat at https://gitter.im/serge-plugins/Lobby](https://badges.gitter.im/serge-plugins/Lobby.svg)](https://gitter.im/serge-plugins/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![License: Perl](https://img.shields.io/badge/License-Perl-0298c3.svg)](https://dev.perl.org/licenses/)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins?ref=badge_shield)

Plugins allowing integration between [Serge](https://serge.io/) (Free, Open Source Solution for Continuous Localization) and various Translation Software (Open Source and Commercial). 

* [Crowdin](https://crowdin.com/) [![Crowdin](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-crowdin.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::crowdin) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-crowdin/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-crowdin)
* [LingoHub](https://www.lingohub.com/) [![LingoHub](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-lingohub.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::lingohub) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-lingohub/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-lingohub)
* [Locize](https://locize.com) [![Locize](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-locize.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::locize) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-locize/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-locize)
* [Lokalise](https://lokalise.co) [![Lokalise](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-lokalise.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::lokalise) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-lokalise/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-lokalise)
* [Mojito (Open Source)](http://www.mojito.global/) [![Mojito](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-mojito.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::mojito) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-mojito/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-mojito)
* [Phrase](https://phrase.com/) [![Phrase](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-phrase.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::phrase) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-phrase/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-phrase)
* [Transifex](https://www.transifex.com/) [![Transifex](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-transifex.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::transifex) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-transifex/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-transifex)
* [Weblate (Open Source)](http://weblate.org/) [![Weblate](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-weblate.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::weblate) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-weblate/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-weblate)
* [Zanata (Open Source)](http://zanata.org/) [![Zanata](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-zanata.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::zanata) [![Docker Status](https://badgen.net/docker/size/dragosvr/serge-zanata/latest/amd64?icon=docker&label=docker&url)](https://hub.docker.com/repository/docker/dragosvr/serge-zanata)

These plugins are supplementing the built-in Serge translation software plugins, [Pootle (Open Source)](https://pootle.translatehouse.org/) and [Zing (Open Source)](https://evernote.github.io/zing/).

## Installation

If you want to install and use the plugins then just install it via cpanm. 

```
cpanm install Serge::Sync::Plugin::TranslationService::plugin
```
## Docker

Alternatively docker can be used to run the plugins. 

```
docker run -v /var/serge/data:/data -it dragosvr/serge-plugin command /data/configs/config1.serge
```
where command is a Serge command (sync, pull, push, pull-ts, push-ts, localize)
## Development setup

If you want to develop a feature, or contribute code in some way, you need a development setup. This is done by cloning
the repo into a local directory.

```
git clone https://github.com/dragosv/serge-plugins.git
cd serge-plugins
```

With carton you can install all the dependencies needed in a local environment, so you can play around with dependencies without
affecting the system libraries. The cpanfile is used to track the dependencies needed.

```
cpan App::cpanminus
cpanm install Carton
carton install
```

Once the development environment is set-up, in order to run the tests, make should be used

```
make test
```

## Organization

lib/Serge/Sync/Plugin/TranslationService: Contains translation services plugins.

## Dependencies

Dependencies are versioned in a cpanfile. If you have carton, just execute 'carton install' in the main directory, and all dependencies
will be pulled in automatically into a local library path. After that use 'carton exec ...' to execute your scripts.

If you add a dependency, just add it to the cpanfile file. There are three sections:

 - the general section is for dependencies that are needed only in runtime
 - the test section is for dependencies needed to run the test suite
 - the develop section is for dependencies needed for developers

carton install installs all dependencies in all sections (after all, we're in developer mode here) 

## Packaging

Packaging is managed with Dist::Zilla.

## License

[Perl 5 License](../LICENSE)

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins?ref=badge_large)

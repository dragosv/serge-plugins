[Serge](https://serge.io/) Plugins
============

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Build Status](https://img.shields.io/travis/dragosv/serge-plugins/master.svg?label=linux+build)](https://travis-ci.org/dragosv/serge-plugins)
[![Build status](https://ci.appveyor.com/api/projects/status/tb6j1owidqvdfx90/branch/master?svg=true&passingText=windows%20build%20passing&failingText=windows%20build%20failing&pendingText=windows%20build%20pending)](https://ci.appveyor.com/project/dragosv/serge-plugins/branch/master) [![codecov](https://codecov.io/gh/dragosv/serge-plugins/branch/master/graph/badge.svg)](https://codecov.io/gh/dragosv/serge-plugins)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=shields)](http://makeapullrequest.com)
[![Join the chat at https://gitter.im/serge-plugins/Lobby](https://badges.gitter.im/serge-plugins/Lobby.svg)](https://gitter.im/serge-plugins/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![License: Perl](https://img.shields.io/badge/License-Perl-0298c3.svg)](https://dev.perl.org/licenses/)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins?ref=badge_shield)

Plugins allowing integration between [Serge](https://serge.io/) (Free, Open Source Solution for Continuous Localization) and various Translation Software (Open Source and Commercial).

[Crowdin](https://crowdin.com/) [![Crowdin](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-crowdin.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::crowdin)
[LingoHub](https://www.lingohub.com/) [![LingoHub](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-lingohub.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::lingohub)
[Lokalise](https://lokalise.co) [![Lokalise](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-lokalise.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::lokalise)
[Mojito (Open Source)](http://www.mojito.global/) [![Mojito](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-mojito.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::mojito)
[PhraseApp](https://phraseapp.com/) [![PhraseApp](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-phraseapp.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::phraseapp)
[Transifex](https://www.transifex.com/) [![Transifex](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-transifex.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::transifex)
[Zanata (Open Source)](http://zanata.org/) [![Zanata](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-zanata.svg)](https://metacpan.org/pod/Serge::Sync::Plugin::TranslationService::zanata)

These plugins are supplementing the built-in Serge translation software plugin, [Pootle (Open Source)](https://pootle.translatehouse.org/).

## Installation

If you want to install and use the plugins then just install it via cpanm. 

```
cpanm install Serge::Sync::Plugin::TranslationService::plugin

```

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
cpanm install Carton
carton install
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

[Perl 5 License](./LICENSE)

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fdragosv%2Fserge-plugins?ref=badge_large)
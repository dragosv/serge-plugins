Serge Plugins
============

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Build Status](https://travis-ci.org/dragosv/serge-plugins.svg?branch=master)](https://travis-ci.org/dragosv/serge-plugins)
[![Join the chat at https://gitter.im/serge-plugins/Lobby](https://badges.gitter.im/serge-plugins/Lobby.svg)](https://gitter.im/serge-plugins/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![License: Perl](https://img.shields.io/badge/License-Perl-0298c3.svg)](https://dev.perl.org/licenses/)

Plugins allowing integration between [Serge](https://serge.io/) (Free, Open Source Solution for Continous Localization) and various Translation Software (Open Source and Paid)

[Mojito](http://www.mojito.global/) [![Mojito](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-mojito.svg)](https://metacpan.org/release/Serge-Sync-Plugin-TranslationService-mojito)

[Zanata](http://zanata.org/) [![Zanata](https://img.shields.io/cpan/v/Serge-Sync-Plugin-TranslationService-zanata.svg)](https://metacpan.org/release/Serge-Sync-Plugin-TranslationService-zanata)
 	

Installation
============

If you want to install and use the plugins then just install it via cpanm. 

```
cpanm Serge::Sync::Plugin::TranslationService::plugin

```

Development setup
============

If you want to develop a feature, or contribute code in some way, you need a development setup. This is done by cloning
the repo into a local directory.

```
git clone https://github.com/dragosv/serge-plugins.git
cd serge-plugins
```

With carton you can install all the dependencies needed in a local environment, so you can play around with dependencies without
affecting the system libraries. The cpanfile is used to track the dependencies needed.

```
carton install
```

Organization
============

lib/Serge/Sync/Plugin/TranslationService: Contains translation services plugins.

Dependencies
============

Dependencies are versioned in a cpanfile. If you have carton, just execute 'carton install' in the sdk directory, and all dependencies
will be pulled in automatically into a local library path. After that use 'carton exec ...' to execute your scripts.

If you add a dependency, just add it to the cpanfile file. There are three sections:

 - the general section is for dependencies that are needed only in runtime
 - the test section is for dependencies needed to run the test suite
 - the develop section is for dependencies needed for developers

carton install installs all dependencies in all sections (after all, we're in developer mode here) 

Packaging
============

Packaging is managed with Dist::Zilla.




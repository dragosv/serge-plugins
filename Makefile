test:
	carton exec build-bin/dzil-plugins.pl -c test

build:
	carton exec build-bin/dzil-plugins.pl -c build

release:
    carton exec build-bin/github-release.pl
	carton exec build-bin/dzil-plugins.pl -c release


test:
	perl build-bin/dzil-plugins.pl -c test

build:
	perl build-bin/dzil-plugins.pl -c build

release:
	perl build-bin/github-release.pl \
	perl build-bin/dzil-plugins.pl -c release


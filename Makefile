test:
	carton exec perl build-bin/dzil-plugins.pl test

build:
	carton exec perl build-bin/dzil-plugins.pl build

release:
	carton exec perl build-bin/dzil-plugins.pl release


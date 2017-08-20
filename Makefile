.POSIX:
.SUFFIXES:

all: public/index.html public/cv/index.html public/contact/index.html
clean:
	rm -rf bin/ public/index.html public/cv public/contact src/*.ibc
public/index.html: bin/generator
	bin/generator index > $@
public/cv/index.html: bin/generator public/cv
	bin/generator cv > $@
public/contact/index.html: bin/generator public/contact
	bin/generator contact > $@
bin/generator: bin
	idris \
	--sourcepath src \
	--idrispath src \
	--output $@ \
	src/Main.idr
bin public/cv public/contact:
	-mkdir $@
serve: all
	cd public && python -m SimpleHTTPServer

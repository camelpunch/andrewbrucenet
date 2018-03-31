.POSIX:
.SUFFIXES:

all: public/index.html public/contact/index.html public/cv.pdf
clean:
	rm -rf \
		bin/generator \
		public/index.html \
		public/cv* \
		public/contact \
		src/*.ibc \
		vendor/site/*.ibc
public/index.html: bin/generator
	bin/generator index > $@
public/cv/index.html: bin/generator public/cv
	bin/generator cv > $@
public/cv.pdf: public/cv/index.html
	bin/generate-cv-pdf $@
public/contact/index.html: bin/generator public/contact
	bin/generator contact > $@
bin/generator: bin src/*.idr vendor/site/Site.ibc
	idris \
	--idrispath vendor/site \
	--sourcepath src \
	--idrispath src \
	--output $@ \
	src/Main.idr
vendor/site/Site.ibc:
	cd vendor/site && idris --build site.ipkg
bin public/cv public/contact:
	-mkdir $@
serve: all
	cd public && python -m SimpleHTTPServer
deploy: all
	rsync \
		--recursive \
		--delete \
		public/ \
		web:/var/www/www.andrewbruce.net/

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
bin/server: bin src/*.idr packages
	idris \
		--codegen node \
		--package site \
		--package webserver \
		--sourcepath src \
		--idrispath src \
		--output $@ \
		src/Main.idr
.PHONY: packages
packages:
	idris --listlibs | grep -q site \
	|| (cd vendor/site && idris \
		--install site.ipkg)
	idris --listlibs | grep -q webserver \
	|| (cd vendor/idris-web-server && idris \
		--install webserver.ipkg)
bin public/cv public/contact:
	-mkdir $@
serve: all
	cd public && python -m SimpleHTTPServer

.PHONY: IMAGE
IMAGE: all
	[ "x$$(git status --porcelain)" = x ]
	echo eu.gcr.io/code-supply/andrewbruce-net:$$(git rev-parse --short HEAD) > $@
build: all IMAGE
	docker build . -t $$(cat IMAGE)
push: build
	docker push $$(cat IMAGE)
rendered_k8s_manifests.yaml: IMAGE k8s/daemon-set.yaml k8s/service.yaml k8s/ingress.yaml
	cat k8s/*.yaml | IMAGE=$$(cat IMAGE) envsubst > $@
deploy: rendered_k8s_manifests.yaml
	kubectl --context=code-supply-production apply -f $<

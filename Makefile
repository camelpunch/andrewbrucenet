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

.PHONY: IMAGE
IMAGE: all
	[ "x$$(git status --porcelain)" = x ]
	echo eu.gcr.io/code-supply/andrewbruce-net:$$(git rev-parse --short HEAD) > $@
build: all IMAGE
	docker build . -t $$(cat IMAGE)
push: build
	docker push $$(cat IMAGE)
rendered_k8s_manifests.yaml: IMAGE k8s/deployment.yaml k8s/service.yaml k8s/ingress.yaml
	cat k8s/*.yaml | IMAGE=$$(cat IMAGE) envsubst > $@
deploy: rendered_k8s_manifests.yaml
	kubectl --context=code-supply-production apply -f $<

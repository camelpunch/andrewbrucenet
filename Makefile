.POSIX:
.SUFFIXES:

public/cv.pdf: bin/server
	bin/generate-cv-pdf $@
public/key.asc:
	gpg \
		--export \
		--armor \
		F6F6E949990C4DD41E79D22C2D501B260861257F \
		> $@
bin/server: bin src/*.idr .packages
	touch public/cv.pdf
	idris \
		--codegen node \
		--package mrk \
		--package webserver \
		--sourcepath src \
		--idrispath src \
		--output $@ \
		src/Main.idr
clean:
	rm -rf \
		bin/server \
		src/*.ibc
.packages: vendor
	cd vendor/mrk && idris --install mrk.ipkg
	cd vendor/idris-web-server && idris --install webserver.ipkg
	touch .packages

.PHONY: IMAGE
IMAGE: bin/server
	[ "x$$(git status --porcelain)" = x ]
	echo eu.gcr.io/code-supply/andrewbruce-net:$$(git rev-parse --short HEAD) > $@
build: bin/server IMAGE
	docker build . -t $$(cat IMAGE)
push: build
	docker push $$(cat IMAGE)
rendered_k8s_manifests.yaml: IMAGE k8s/deployment.yaml k8s/service.yaml k8s/virtual-service.yaml
	cat k8s/*.yaml | IMAGE=$$(cat IMAGE) envsubst > $@
deploy: rendered_k8s_manifests.yaml
	kubectl --context=code-supply-production apply -f $<

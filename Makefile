pages := index cv contact

vpath $(pages) := public
vpath generator := bin

all: $(pages)

$(pages): generator public
	bin/generator $@ > public/$@

clean:
	rm -rf bin/ public/ src/*.ibc

generator: bin
	idris \
	--sourcepath src \
	--idrispath src \
	--output bin/$@ \
	src/Main.idr

bin public:
	mkdir $@

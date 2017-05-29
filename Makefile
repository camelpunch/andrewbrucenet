pages := index cv contact

vpath $(pages) := public
vpath generator := bin

all: $(pages)

$(pages): generator public
	bin/generator $@ > public/$@

clean:
	rm -rf bin/ public/

generator: bin
	idris -i src src/Main.idr -o bin/$@

bin public:
	mkdir $@

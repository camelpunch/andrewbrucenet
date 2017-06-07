pages := index.html cv/index.html contact/index.html
dirs := cv contact

vpath generator := bin
vpath % := public

all: $(pages)

$(pages): generator $(dirs)
	bin/generator $(subst index.html,index,$(subst /index.html,,$@)) > public/$@

clean:
	rm -rf bin/ public/ src/*.ibc

generator: bin
	idris \
	--sourcepath src \
	--idrispath src \
	--output bin/$@ \
	src/Main.idr

$(dirs): public
	mkdir public/$@

bin public:
	mkdir $@

serve: $(pages)
	cd public && python -m SimpleHTTPServer

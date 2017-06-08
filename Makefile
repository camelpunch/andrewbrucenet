pages := index.html cv/index.html contact/index.html
objects := Site.idr Main.idr CV.idr Contact.idr
dirs := cv contact

vpath generator := bin
vpath %.idr := src
vpath % := public

all: $(pages)

$(pages): generator $(dirs) $(objects)
	bin/generator $(subst index.html,index,$(subst /index.html,,$@)) > public/$@

clean:
	rm -rf bin/ $(addprefix public/,$(pages)) src/*.ibc

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

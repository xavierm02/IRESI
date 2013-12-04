.PHONY: all graph run pdf

all: pdf

%.byte: %.ml
	(cd $(@D); ocamlbuild -r $(@F))

%.pdf: %.tex
	(cd $(@D); pdflatex $(@F:.pdf=.tex))

output:
	mkdir output

src/graph.byte src/main.byte: $(shell find . -type f -name '*.ml')

output/graph-1.data output/graph-2.data output/graph-3.data: output

output/graph-1.data: src/graph.byte
	ocamlrun src/graph.byte 1 > output/graph-1.data

output/graph-2.data: src/graph.byte
	ocamlrun src/graph.byte 2 > output/graph-2.data

output/graph-3.data: src/graph.byte
	ocamlrun src/graph.byte 3 > output/graph-3.data

output/graph-1.png output/graph-2.png output/graph-3.png: src/plotter output/graph-1.data output/graph-2.data output/graph-3.data
	gnuplot src/plotter

rapport/rapport.pdf: output/graph-1.png output/graph-2.png output/graph-3.png

graph: output/graph-1.png output/graph-2.png output/graph-3.png

run: src/main.byte
	ocamlrun src/main.byte

pdf: rapport/rapport.pdf

clean:
	(cd src; ocamlbuild -r -clean)
	rm -rf output
	rm rapport/rapport.pdf rapport/rapport.aux rapport/rapport.log

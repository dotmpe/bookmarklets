URL='/project/x-translit/bookmarklet/'
DIR=/home/berend/htdocs/dist/
LST='./SOURCE'

SRC= $(shell cat $(LST))

V= $(SRC:%.js=%.version)
CHK= $(SRC:%.js=%.md5sum)
BM= $(SRC:%.js=%.bm.js)
BM_RST= $(SRC:%.js=%.bm.rst)
DSCR= $(SRC:%.js=%.rst)

#RST = $(shell find ./ -iname "*.rst") 
XHT= $(DSCR:%.rst=%.xhtml)
#XHT:= $(RST:%.rst=%.xhtml)
#XHT:= $(BM_RST:%.rst=%.xhtml)

DU_GEN = --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_HTML = --no-compact-lists --link-stylesheet --stylesheet=/style/default --footnote-references=superscript --cloak-email-addresses 

.PHONY: def clean bm pub dist

def:
	@echo "bookmarklet makefile"
	@echo ""
	@echo "source-list: $(LST)"
	@echo "dist-dir: $(DIR)"
	@echo "project-url: $(URL)"
	@echo ""
	@echo "targets:"
	@echo "	bm: make all bookmarklets in $(LST)"
	@echo "	dist: make all and cp to $(DIR)"

clean:
	-rm $(BM_RST) $(BM) $(CHK) $(XHT)

bm: $(BM_RST)

pub: bm $(CHK) $(V)

dist: pub
	@(for f in $(V);do \
	 	name=$${f%.version};\
	 	version=`cat $$f|tr -d '\n'`;\
		rename "s/^$$name/$$name.$$version/" $$name.{bm.js,md5sum};\
		mv $$name.$$version.{bm.js,md5sum} $(DIR);\
		echo "$(URL)$$name" > $(DIR)$$name.$$version.url;\
		echo "* $$name.$$version published";\
	done);

# Targets
%.version: %.bm.js
	@echo `cat $@| xargs expr 1 + ` > $@;
	@echo "* $^ version: "`cat $@`

%.md5sum: %.bm.js
	@md5sum $< > $@
	@echo "* $^ md5sum> $@"

%.bm.js: %.js
	@js2bm $< > $@
	@echo "* $^ js2bm> $@"
	@echo "  chars/bytes: "`wc -c -m < $@`

%.bm.rst: %.bm.js
	@echo -n ".. _"$*"-bm: " > $@
	@cat $< >> $@
	@echo "* $^ -> $@"
	
# Extra target for bookmarklet reference dependency
%.xhtml: %.rst %.bm.rst 
	@rst2html $(DU_GEN) $(DU_READ) $(DU_HTML) $< $@
	@mv $@ $@.tmp1
	@sed -e 's/<p>\[\([0-9]*\)\.\]<\/p>/<a id="page-\1" class="pagebreak"><\/a>/g' $@.tmp1 > $@.tmp2
	@sed -e 's/\[\([0-9]*\)\.\]/<a id="page-\1" class="pagebreak"><\/a>/g' $@.tmp2 > $@
	@rm $@.tmp1 $@.tmp2
	@-tidy -q -m -wrap 0 -asxhtml -utf8 -i $@
	@echo "* $^ -> $@"

# Dependencies
%.rst: %.bm.rst

.PHONY: bm
doc: $(RST)
bm: $(BM) 

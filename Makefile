# Bookmarklet/Scriptlet makefile
#
# Non recursive [#]_ 
# .. [#] http://www.xs4all.nl/~evbergen/nonrecursive-make.html
URL='/project/bookmarklet/'
#DIR=/home/berend/htdocs/dist/

# Global vars (used by Makefile targets)
SRC     :=
DEP     :=
TRGT    :=
CLN     :=

# Flags
DU_GEN= --traceback --no-generator --no-footnote-backlinks --date -i utf-8 -o utf-8
DU_HTML= --no-compact-lists --link-stylesheet --stylesheet=docutils.bm.css --footnote-references=superscript --cloak-email-addresses

# Bin
bzr         =bzr
js-bm       =js2bm
tidy-xhtml  =tidy -q -wrap 0 -asxhtml -utf8 -i
rst-xhtml   =rst2html $(DU_GEN) $(DU_READ) $(DU_HTML)
rst-dep     =~/project/scrow/bin/bash/rst-dep.sh


### Bash output strings
c0=\x1b[0;0m
# err color, red
c1=\x1b[31m
c8=\x1b[1;31m
# ok color, green
c2=\x1b[32m
# running, orange
c3=\x1b[0;33m
#  l-blue
c4=\x1b[1;34m
#  purple
c5=\x1b[35m
# 
c6=\x1b[36m
# pale white
c7=\x1b[0;37m
# hard white
c9=\x1b[1;37m

## Make output strings
mk_trgt=$(c3)[$(c7)$@$(c3)]$(c0)
mk_rule=$(c4)<$(c7)$*$(c4)>$(c0) 
mk_src=$(c4)<$(c7)$<$(c4)>$(c0) 
mk_srcs=$(c4)<$(c7)$^$(c4)>$(c0) 
mk_upd=$(c4)<$(c7)$?$(c4)>$(c0)


# Default target
.PHONY: default
default: build


# Include specific rules and set SRC, DEP, TRGT and CLN variables.
dir         := .
include     $(dir)/Rules.mk
# Include more dependency rules for targets.
include 	$(DEP)

# Default targets
.PHONY: help build clean dep clean-dep dist all

help:
	@echo -e "$(mk_trgt) $(c9)Scriptlets Makefile$(c0)"
	@echo "Usage: make [help|build|clean|dep|clean-dep|dist|all|<distname>|<packname>]"
	@echo "Where distname is the name of a javascript filename with embedded version number."
	@echo "dist-dir: $(DIR)"
	@echo "project-url: $(URL)"
	@echo ""
	@echo "targets:$(TRGT)"
	@echo "	bm: make all bookmarklets in $(LST)"
	@echo "	dist: make all and cp to dist-dir"

stat: status    
status:
	@echo -e "$(mk_trgt) $(c9)Unpublished scripts$(c0):"
	@JS_SRC=`echo $(SRC) |sed 's/\ /\n/g'| grep -e '\.[0-9]*\.js'`; \
			bzr stat $$JS_SRC;
	@echo -e "$(mk_trgt) At branch revision $(c9)`bzr revno`$(c0)."


build: $(TRGT) 
	@echo -e "$(mk_trgt) $(c9)Done.$(c0)"

clean:
	@echo -e "$(mk_trgt) $(c9)cleaning$(c0) $(c4)<$(c7)$(CLN)$(c4)>$(c0)"
	@-rm $(CLN);\
	 if test $$? -gt 0; then echo ""; fi; # put xtra line if err-msgs

dep: $(DEP)
	@echo -e "$(mk_trgt) $(c9)Done.$(c0)"

clean-dep:
	@echo -e "$(mk_trgt) $(c9)cleaning$(c0) $(c4)<$(c7)$(DEP)$(c4)>$(c0)"
	@-rm $(DEP);\
	 if test $$? -gt 0; then echo ""; fi; # put xtra line if err-msgs

pack: $(DIST)
	@echo -e "$(mk_trgt) $(c9)Done.$(c0)"

dist: pack 
	@echo -e "$(mk_trgt) $(c9)Done.$(c0)"

all: build dist

# :vim:set noexpandtab:

# Bookmarklet/Scriptlet makefile
#
URL='/project/bookmarklet/'
#DIR=/home/berend/htdocs/dist/

MK_ROOT := ~/project/mkdoc/
MK_SHARE := $(MK_ROOT)usr/share/mkdoc/

# Provide shared make vars and rules
include             $(MK_SHARE)Core/Main.mk
include             $(MK_SHARE)docutils/Main.mk
include             $(MK_SHARE)bookmarklet/Main.mk

# Bin
bzr         =bzr
tidy-xhtml  =tidy -q -wrap 0 -asxhtml -utf8 -i
#js2bm                 = php ../../../tools/soffa.compress_js.php 
#rst2xhtml             = ../../../tools/rst2html.sh 

DIR                 := .
ROOT                := $(realpath .)
BUILD               := $(DIR)/.build

# Include specific rules and set SRC, DEP, TRGT and CLN variables.
include             $(DIR)/Rules.mk

# Now set some standard targets
include             $(MK_SHARE)Core/Rules.default.mk

# Default targets
#.PHONY: help build clean dep clean-dep dist all

#help:
#	@echo -e "$(mk_trgt) $(c9)Scriptlets Makefile$(c0)"
#	@echo "Usage: make [help|build|clean|dep|clean-dep|dist|all|<distname>|<packname>]"
#	@echo "Where distname is the name of a javascript filename with embedded version number."
#	@echo "dist-dir: $(DIR)"
#	@echo "project-url: $(URL)"
#	@echo ""
#	@echo "targets:$(TRGT)"
#	@echo "	bm: make all bookmarklets in $(LST)"
#	@echo "	dist: make all and cp to dist-dir"
#
#stat: status
#status:
#	@echo -e " $(mk_trgt)  $(c9)Unpublished scripts$(c0):"
#	@JS_SRC=`echo $(SRC) |sed 's/\ /\n/g'| grep -e '\.[0-9]*\.js'`; \
#			bzr stat $$JS_SRC;
#	@echo -e " $(mk_trgt)  At branch revision $(c9)`bzr revno`$(c0)."
#
#
#build: $(TRGT)
#	@echo -e " $(mk_trgt)  $(c9)Done.$(c0)"
#
#clean:
#	@echo -e " $(mk_trgt)  $(c9)removing$(c0)  $(c4)<$(c7)$(CLN)$(c4)>$(c0)"
#	@-rm $(CLN);\
#	 if test $$? -gt 0; then echo ""; fi; # put xtra line if err-msgs
#
#dep: $(DEP)
#	@echo -e " $(mk_trgt)  $(c9)Done.$(c0)"
#
#clean-dep:
#	@echo -e " $(mk_trgt)  $(c9)removing$(c0)  $(c4)<$(c7)$(DEP)$(c4)>$(c0)"
#	@-rm $(DEP);\
#	 if test $$? -gt 0; then echo ""; fi; # put xtra line if err-msgs
#
#pack: $(DIST)
#	@echo -e " $(mk_trgt)  $(c9)Done$(c0)."
#
#dist: pack
#	@echo -e " $(mk_trgt)  $(c9)Done$(c0)."
#
#all: build dist

# :vim:set noexpandtab:

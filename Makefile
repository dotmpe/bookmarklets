# Bookmarklet/Scriptlet makefile

MK_DIR             := ~/project/mkdoc/
MK_SHARE           := $(MK_DIR)usr/share/mkdoc/

include               $(MK_DIR)Makefile




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

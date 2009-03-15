dirstack_$(sp)	:= $d
d 				:= $(dir)


# Local Variables
SCRIPTLETS_$d:=bugmenot-popup same-domain-policy\
           dlcs-post ijs minuscul-us popup\
           source-chart.mpe tstyle rscript\
           web-archive

BM_REF_$d:=$(SCRIPTLETS_$d:%=$d/%.urlref)

BM_V_$d :=$(BM_REF_$d:%.urlref=%.version)
BM_MK_$d :=$(BM_REF_$d:%.urlref=%.dmk)

RST_$d  :=$(BM_REF_$d:%.urlref=%.rst)
XHT_$d  :=$(RST_$d:%.rst=%.xhtml)

#BM_SRC_$d           := $(SRC_$d:%=%.js)
#BM_RST_$d       := $(SRC_$d:%=%.bm.rst)


# Global vars
SRC     :=$(SRC) $(SCRIPTLETS_$d:%=$d/%.js) $(RST_$d)
TRGT    :=$(TRGT) $(XHT_$d) $(BM_V_$d)\
	 $(BM_MK_$d)
DEP     :=$(XHT_$d:%=%.dep.mk)
#DIST            := $(DIST) \
                    $(SRC_$d:$d/%.js=$D/%.url) \
                    $(SRC_$d:$d/%.js=$D/%.bm.js)
CLN     :=$(CLN) $(BM_REF_$d) $(XHT_$d) $(RST_$d:%.rst=%.bm.rst)


include $(BM_MK_$d)

### Rules

%.js: %.*.js
	@echo -e "$(mk_trgt) $(c9)Updating$(c0) $(mk_upd)"
	@#bzr ci

$d/%.urlref: $d/%.js
	@$(js-bm) $< > $@
	@echo -e "$(mk_trgt) $(c9)<-$(c0) $(mk_srcs)"
	@echo "  chars: "`wc -c < $@`

$d/%.version: $d/%.*.js
	@echo -e "$(mk_trgt) $(c9)getting latest revision$(c0) $(mk_upd)"
	@ls $(<D)/$*.*.js | while read f; do \
        v=`echo "$$f"|sed 's/^.*\.\([0-9]\+\)\.js$$/\1/'`;  \
		if test ! -s $@; then \
            echo $$v > $@; \
        else if test `cat $@` -lt $$v; then \
            echo $$v > $@; \
		fi; fi; done; 
	@touch $@

$d/%.dmk: $d/%.version Rules.mk
	@echo -e "$(mk_trgt) $(c9)building dynamic makefile because$(c0) $(mk_upd)"
	@echo 'SRC:=$$(SRC) $(@D)/$*.'`cat $<`".js" > $@

$d/%.xhtml.dep.mk: $d/%.rst
	@echo -e "$(mk_trgt) $(c9)building dependecy makefile because$(c0) $(mk_upd)"
	@if test -e $@; then rm $@; fi;
	@b=$(@D)/$*; \
	 d=$(<D)/$*; \
	 $(rst-dep) $< | \
		while read f; do \
			echo "$$b.xhtml: $$f" >> $@; \
		done; \
        echo "$@: $$b.version" >> $@;\
        v=`cat $$b.version`; \
		echo "$$b.$$v.urlref: $$d.$$v.js" >> $@;  \
		echo "$$b.$$v.bm.rst: $$b.$$v.urlref" >> $@;  
#		echo "$$b.xhtml: $$b.$$v.bm.rst $@" >> $@;  \

$d/%.bm.rst: $d/%.urlref
	@echo -n ".. _"$*".bm: " > $@
	@cat $< >> $@
	@echo >> $@
	@echo -e "$(mk_trgt) $(c9)<-$(c0) $(mk_srcs)"

$d/%.xhtml: $d/%.rst
	@echo -e "$(mk_trgt) $(c9)building from$(c0) $(mk_srcs)"
	@$(rst-xhtml) $< $@.tmp
	@-$(tidy-xhtml) $@.tmp > $@; \
	 if test $$? -gt 0; then echo ""; fi; # put xtra line if err-msgs
	@rm $@.tmp
	@echo -e "$(mk_trgt) $(c9)done.$(c0)"


d 				:= $(dirstack_$(sp))
sp				:= $(basename $(sp))
# :vim:set noexpandtab

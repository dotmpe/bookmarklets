## Dirstack
SP                  := $(SP).x
D_$(SP)             := $d
d                   := $(DIR)

MK                  += $d/Rules.mk


## Local Variables

SCRIPTLETS_$d       := bugmenot-popup same-domain-policy\
                       dlcs-post ijs minuscul-us popup\
                       source-chart.mpe toggle-style rscript\
                       web-archive outline
#mpe-toggle_width

# local vars/target sets
BM_V_$d             := $(SCRIPTLETS_$d:%=$(BUILD)/%.versions)
BM_JS_SRC_$d        := $(wildcard $(SCRIPTLETS_$d:%=$d/%.[0-9]*.js))
BM_REF_$d           := $(BM_JS_SRC_$d:$d/%.js=$(BUILD)/%.urlref)
BM_RST_$d           := $(BM_JS_SRC_$d:$d/%.js=$(BUILD)/%.bm.rst) 
BM_RST_SRC_$d       := $(SCRIPTLETS_$d:%=$d/%.rst)
RST_SRC_$d          := $d/main.rst $(BM_RST_SRC_$d)
XHT_$d              := $(BUILD)/main.xhtml \
                       $(BM_RST_SRC_$d:$d/%.rst=$(BUILD)/%.xhtml) 
# FIXME: arguh, somehow sets of entire build again.. :
# SYMLINK_$d          := $(SCRIPTLETS_$d:%=$d/%.latest.js)
DMK_$d              += $(XHT_$d:%.xhtml=%.include.mk) \
                       $(SCRIPTLETS_$d:%=$(BUILD)/%.bm.mk)
# recollections:
TRGT_$d             += $(BM_RST_$d) $(BM_REF_$d) $(XHT_$d) $(SYMLINK_$d) \
					   $d/.htaccess

# XXX: A bit imprecise, May be convenient or not..
#$(DMK_$d): $d/Rules.mk
#$(TRGT_$d): $d/Rules.mk
#$(BM_V_$d): $d/Rules.mk

## Set to globals

SRC                 += $(RST_$d) $(BM_JS_SRC_$d) $(BM_RST_SRC_$d)
DEP                 += $(BM_V_$d) 
TRGT                += $(TRGT_$d)
CLN                 += $(TRGT_$d)
DMK                 += $(DMK_$d)


### Rules

#$d/%.[0-9]*.js: $d/%.js
#	@$(ll) file_target "$@" "Moving source from" "$<"
#	@if [ -f "$<" ]; then mv $< $(@D)/$*.0.js; fi
#	@$(ll) file_ok $@ "Copied source"

$d/%.latest.js: $d/%.[0-9]*.js $d/.build/%.versions
	@# XXX: rule gets always executed? $(ll) file_target "$@" "Symlinking because" "$^"
	@LATEST=`tail -1 $(BUILD)/$*.versions`;\
		cd $(@D) ;\
		if test -L "$*.latest.js"; then \
			CURRENT=`readlink $@`; \
			if test "$$CURRENT" = "$*.$$LATEST.js"; then \
				touch $*.latest.js;\
			else rm -rf $*.latest.js; fi; \
		else \
			if test -e $*.latest.js; then\
				$(ll) error $@ "File exists"; fi; fi; \
		if test ! -L "$*.latest.js"; then \
			$(ll) file_target "$@" "Symlinking too because" "$^"; \
			ln -s $*.$$LATEST.js $*.latest.js; fi;

# See build/%.bm.mk
#$(BUILD)/%.[0-9]*.urlref: $d/%.[0-9]*.js
define build-bm
	@$(ll) file_target "$@" "Building BM from" "$^"
    @$(ee) "javascript:void((function(){" > $<.tmp
    @cat $< >> $<.tmp
    @$(ee) "})())" >> $<.tmp
	@$(js2bm) $<.tmp > $@
	@rm $<.tmp
	@$(ll) header2 Bytes "`wc -c < $@`"
	@$(ll) file_ok $@ Done
endef

# See build/%.bm.mk
#$(BUILD)/%.bm.[0-9]*.rst: $(BUILD)/%.[0-9]*.urlref
define build-bm-rst
	@$(ll) file_target $@ "because" "$^"
	@$(ee) -n ".. _"$*".bm: " > $@
	@cat $< >> $@
	@$(ee) >> $@
	@$(ll) file_ok $@ Done
endef

#$(BUILD)/%.version: $d/%.[0-9]*.js
#	@$(ll) file_target $@ "Writing latest version for" "$?"
#	@ls $(<D)/$*.*.js | while read f; do \
#        v=`$(ee) "$$f"|sed 's/^.*\.\([0-9]\+\)\.js$$/\1/'`;  \
#		if test ! -s $@; then \
#            $(ee) $$v > $@; \
#        else if test `cat $@` -lt $$v; then \
#            $(ee) $$v > $@; \
#		fi; fi; done;
#	@$(ll) file_ok $@ Done

#	$d/Rules.mk
$(BUILD)/%.versions: $d/%.[0-9]*.js
	@$(ll) file_target $@ "Updating because" "$?"
	@for f in $^; \
		do v=`$(ee) "$$f"|sed 's/^.*\.\([0-9]\+\)\.js$$/\1/'`; \
		$(ee) $$v >> $@.tmp; done;
	@cat $@.tmp | sort -u > $@
	@rm $@.tmp
	@$(ll) file_ok $@ Done

#	$d/Rules.mk
$(BUILD)/%.bm.mk: $(BUILD)/%.versions 
	@$(ll) file_target $@ "Updating Makefile dependencies because" "$?"
	@if test -e $@; then rm $@; touch $@; fi
	@VERSIONS='';\
	 B="$(ROOT)/$(@D)";\
	 B="$(@D)";\
	 S=$${B%".build"}$*;\
	 for v in `cat $$B/$*.versions`; do \
	 	$(ee) "$$B/$*.$$v.urlref: $$S.$$v.js" >> $@; \
	 	$(ee) "\t\$$(build-bm)\n" >> $@; \
	 	$(ee) "$$B/%.bm.rst: $$B/%.urlref" >> $@; \
	 	$(ee) "\t\$$(build-bm-rst)\n" >> $@; \
	 	VERSIONS="$$VERSIONS $$B/$*.$$v.bm.rst"; \
	 done; \
	 $(ee) "$$B/$*.versions: $$S.[0-9]*.js\n" >> $@;\
	 $(ee) "$$B/$*.bm.rst: $$VERSIONS" >> $@;\
	 $(ee) "\t@\$$(ll) file_target \$$@ \"Concatenating from\" \"\$$^\"" >> $@; \
	 $(ee) "\t@cat \$$^ > \$$@" >> $@; \
	 $(ee) "\t@\$$(ll) file_ok \$$@ Done" >> $@; 

$(BUILD)/%.include.mk: $d/%.rst 
	@$(ll) file_target $@ "Updating rSt dependencies because" "$?"
	@if test -e $@; then rm $@; fi
	@touch $@
	@for f in $$($(call rst-dep,$<,-)); do\
		$(ee) "$(BUILD)/$*.xhtml: $$f" >> $@; \
	done; 

$(BUILD)/%.xhtml: $d/%.rst
	@$(ll) file_target $@ "Building from" "$<"
	@$(rst-xhtml) $< $@.tmp
	@-$(tidy-xhtml) $@.tmp > $@; \
	 if test $$? -gt 0; then $(ee) ""; fi; # put xtra line if err-msgs
	@rm $@.tmp
	@$(ll) file_ok $@ Done

$d/.htaccess: $(XHT_$d)
	@$(ll) file_target "$@" "Building from" "$^"
	@if test -e $@; then rm $@; touch $@; fi
	@echo "RewriteEngine on" >> $@
	@for f in $^; do \
		R=`basename $$f .xhtml`;\
		$(ll) file_target "$@" "Writing rules for $$R";\
		$(ee) "RewriteCond %{REQUEST_FILENAME} !-f" >> $@; \
		$(ee) "RewriteCond %{REQUEST_FILENAME}.rst -f" >> $@; \
		$(ee) "RewriteCond %{REQUEST_URI} ^.*$$R$$" >> $@; \
		$(ee) "#RewriteCond .build/$$R.xhtml -f" >> $@; \
		$(ee) "RewriteCond %{DOCUMENT_ROOT}/bookmarklet/.build/$$R.xhtml -f" >> $@; \
		$(ee) "RewriteRule (.+) /bookmarklet/.build/$$R.xhtml [L]" >> $@;\
		$(ee) >> $@; done
	@$(ll) file_ok $@ Done
	

d 				:= $(D_$(SP))
SP				:= $(basename $(SP))
# :vim:noet:

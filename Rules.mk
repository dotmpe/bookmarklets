include                $(MK_SHARE)Core/Main.dirstack.mk

MK                  += $/Rules.mk
BUILD_$d            := $/.build/

## Local Variables

SCRIPTLETS_$d       := bugmenot-popup same-domain-policy \
                       dlcs-post ijs minuscul-us popup \
                       source-chart.mpe toggle-style rscript \
                       web-archive outline \
                       google-detect-language google-translate \
                       mpe-toggle_width

KWDS_$d             := $d/KEYWORDS
DEP_$d              := $d/KEYWORDS

PACK_$d             := dotmpe.project.bookmarklet
#PACK_HREF           := http://dotmpe.com/project/bookmarklet
#PACK_REV_$d         := $(shell bzr revno 2> /dev/null)
PACK_REV_$d         := $(shell git show . | grep '^commit'|sed 's/^commit //' | sed 's/^\([a-f0-9]\{9\}\).*$$/\1../')
PACK_TIME_$d        := $(shell date -u +%s)

# local vars/target sets
#BM_V_$d             := $(SCRIPTLETS_$d:%=$(BUILD_$d)%.versions)
BM_RST_SRC_$d       := $(SCRIPTLETS_$d:%=$d/%.rst)
RST_SRC_$d          := $/main.rst $(BM_RST_SRC_$d)
XHT_$d              := $(BUILD_$d)main.xhtml \
                       $(BM_RST_SRC_$d:$/%.rst=$(BUILD_$d)%.xhtml) 
BM_JS_SRC_$d        := $(wildcard $(SCRIPTLETS_$d:%=$d/%.[0-9]*.js))
BM_REF_$d           := $(BM_JS_SRC_$d:$/%.js=$(BUILD_$d)%.bm.uriref)
BM_RST_$d           := $(BM_JS_SRC_$d:$/%.js=$(BUILD_$d)%.bm.rst) 
# FIXME: arguh, somehow sets of entire build again.. :
# SYMLINK_$d          := $(SCRIPTLETS_$d:%=$d/%.latest.js)

# FIXME: not sure if all deps are working, test edit of *.js and *.rst
DMK_$d              += $(RST_SRC_$d:$/%.rst=$(BUILD_$d)%.include.mk) 
#DMK_$d              += $(BUILD_$d)Rules.bm.mk
#DMK_$d              += $(SCRIPTLETS_$d:%=$(BUILD_$d)%.bm.mk)
# recollections:
TRGT_$d             += \
				$(XHT_$d) $(SYMLINK_$d) \
				$(SCRIPTLETS_$d:%=$(BUILD_$d)%.bm.rst) \
				$d/.htaccess 


## Set to globals

SRC                 += $(BM_JS_SRC_$d) $(BM_RST_SRC_$d)
DEP                 += $(KWDS_$d) $(BM_V_$d) $(BM_REF_$d) $(BM_RST_$d)  
TRGT                += $(TRGT_$d)
CLN                 += $(TRGT_$d)
DMK                 += $(DMK_$d)


### Rules

#$(BUILD)%.bm.uriref: $(BM_JS_SRC_$d)

#$(BUILD)%.xhtml: %.rst $(BUILD)%.bm.rst

$(DMK_$d): DIR := $d
$(DMK_$d): $(KWDS_$d) $d/Rules.mk

$(BM_V_$d): DIR := $d
#$(BM_V_$d): $d/Rules.mk

$(XHT_$d): DIR := $d
#$(XHT_$d): $d/Rules.mk
#$(BUILD)$d/%.xhtml: $(BUILD)$d/%.bm.rst

echo := $(shell which echo)

$(KWDS_$d): DIR := $d
$(KWDS_$d):  $d/Rules.mk
	@$(ll) file_target "$@" "Building tagfile because" "$?"
	@$(reset-target)
	@echo '$(PACK_$(DIR)):package	$(PACK_$(DIR))' > $@
	@echo '$(PACK_$(DIR)):revision	$(PACK_REV_$(DIR))' >> $@
	@echo '$(PACK_$(DIR)):timestamp	$(PACK_TIME_$(DIR))' >> $@
	@echo 'MK_BUILD	$(BUILD_$(DIR))' >> $@
	@$(ll) file_OK $@


$(BM_V_$d): DIR := $d
# FIXME not in Darwin bash? $(BUILD_$d)%.versions: $/%.[0-9]*.js
$(BUILD_$d)%.versions: $/%.*.js
	@$(ll) file_target $@ "Updating because" "$?"
	@$(reset-target)
	@for f in $(<D)/$*.*.js; do \
		v=`echo "$$f"|sed 's/^.*\.\([0-9]\+\)\.js$$/\1/'`; \
		echo $$v >> $@.tmp; done;
	@cat $@.tmp | sort -u > $@
	@rm $@.tmp
	@$(ll) file_ok $@ Done


$(DMK_$d): DIR := $d

# FIXME not in Darwin bash? $(BUILD_$d)%.bm.rst: $(BUILD_$d)%.[0-9]*.bm.rst
$(BUILD_$d)%.bm.rst: $(BUILD_$d)%.*.bm.rst
	@$(ll) file_target "$@" because "$?"
	@[ -n "$(wildcard $^)" ] && { cat $(wildcard $^) > $@; } || \
		{ echo "Missing sources $<"; exit 2; }
	@$(ll) file_ok "$@" "<-" "$^"


#$(BUILD_$d)Rules.bm.mk: $(BM_V_$d)
#	@$(ll) file_target "$@" because "$?"
#	@$(reset-target)
#	@for V in $$(cat $(@D)/*.versions | sort -u); do\
#		echo $(BUILD)$(DIR)/%.$$V.bm.uriref: $(DIR)/%.$$V.js >> $@;\
#		echo %.$$V.bm.rst: %.$$V.bm.uriref >> $@;\
#		done;

%.bm.mk: %.versions 
	@$(ll) file_target $@ "Updating Makefile dependencies because" "$?"
	@$(reset-target)
	@VERSIONS='';\
	 SRC="$*";\
	 BUILDPATH="$(@D)/";\
	 NAME="$${SRC##$$BUILDPATH}";\
	 SRCPATH=$(DIR)/;\
	 for v in `cat $$BUILDPATH/$$NAME.versions`; do \
	   echo -e ".SECONDARY: $$BUILDPATH$$NAME.$$v.bm.uriref\n" >> $@; \
	   echo -e ".SECONDARY: $$BUILDPATH$$NAME.$$v.bm.rst\n" >> $@; \
	   VERSIONS="$$VERSIONS $$BUILDPATH$$NAME.$$v.bm.rst"; \
	 done; \
	 echo -e "$$BUILDPATH$$NAME.bm.rst: $$VERSIONS" >> $@;\
	 echo -e "\t@\$$(ll) file_target \$$@ \"Because\" \"\$$?\"" >> $@; \
	 echo -e "\t@\$$(ll) file_target \$$@ \"Concatenating from\" \"\$$^\"" >> $@; \
	 echo -e "\t@cat \$$^ > \$$@" >> $@; \
	 echo -e "\t@\$$(ll) file_ok \$$@ Done" >> $@
	 @#echo -e "$$BUILDPATH$$NAME.$$v.bm.uriref: $$SRCPATH$$NAME.$$v.js\n" >> $@; \
	 #echo -e "$$BUILDPATH$$NAME.$$v.bm.rst: $$BUILDPATH$$NAME.$$v.bm.uriref\n" >> $@; \
	 #  echo -e "$$BUILDPATH$$NAME.$$v.bm.uriref: $$SRCPATH$$NAME.$$v.js\n" >> $@; \
	 # echo -e "$$BUILDPATH$$NAME.$$v.bm.rst: $$BUILDPATH$$NAME.$$v.bm.uriref\n" >> $@; 
	@#echo -e "\t@\$$(build-bm)\n" >> $@; \
	 #echo -e "$$BUILDPATH%.bm.rst: $$BUILDPATH%.uriref" >> $@; \
	 #	echo -e "\t@\$$(build-bm-rst)\n" >> $@; \
	 #echo -e "$$BUILDPATH$$NAME.versions: $$SRCPATH$$NAME.[0-9]*.js\n" >> $@;
	@$(ll) file_ok $@ Done


$d/.htaccess: DIR := $d

$d/.htaccess: $(XHT_$d) 
	@#$(ll) file_target "$@" "Building from" "$^"
	@$(ll) file_target "$@" "Building because" "$?"
	@$(reset-target)
	@echo "RewriteEngine on" >> $@
	@for f in $^; do \
		R=`basename $$f .xhtml`;\
		$(ll) file_target "$@" "Writing rules for $$R";\
		$(ee) "RewriteCond %{REQUEST_FILENAME} !-f" >> $@; \
		$(ee) "RewriteCond %{REQUEST_FILENAME}.rst -f" >> $@; \
		$(ee) "RewriteCond %{REQUEST_URI} ^.*$$R$$" >> $@; \
		$(ee) "#RewriteCond .build/$$R.xhtml -f" >> $@; \
		$(ee) "RewriteRule (.+) .build/$$R.xhtml [L]" >> $@;\
		$(ee) >> $@; done
	@$(ll) file_ok $@ Done
	

$d/%.latest.js: $d/%.*.js $d/.build/%.versions
	@$(ll) file_target $@ "Symlinking $* because" "$?"
	@# XXX: rule gets always executed? $(ll) file_target "$@" "Symlinking because" "$^"
	@echo $(BUILD_$(DIR))
	@LATEST=`tail -1 $(BUILD_$(DIR))$*.versions`;\
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


$(BUILD_$d)%.include.mk: $/%.rst 
	@$(ll) file_target $@ "Creating XHTML dependencies for $* from" "$<"
	@$(reset-target)
	@$(mk-rst-include-deps)
	@$(ll) file_ok $@ "Done, run because" "$?"

$(BUILD_$d)%.bm.uriref: $/%.js
	@$(build-bm)
	@$(ll) file_ok $@ "Done, run because" "$?"



## Debug
#$(info BM_JS_SRC_$d, $(BM_JS_SRC_$d))
#$(info BM_REF_$d, $(BM_REF_$d))
#$(info BM_RST_$d, $(BM_RST_$d))

#      ------------ -- 
include                $(MK_SHARE)Core/Main.dirstack-pop.mk
# vim:noet:

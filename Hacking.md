
# Intro
Private repo made public, once upon a time..
Nice small project with specific focus, to try some project management scripting
on. Testing, packaging, publishing.


# Roadmap
## 0.2
## 0.1.1
## Dev
- Nothing specific at the moment.


# Tasks and Bugs


# Project Tooling

- Std. Package/Travis/GIT setup but nothing automatic but build and testing.

- Test bookmarklets at Travis? 
- Maybe setup GH pages for project, ie. serve with Jekyll.
- Could fairly easily setup Sitefile test at Travis.
  Bookmarklets was one of the earier test repos for sitefile.
  Still has some specific wishlists, see
  ```
  Sitefile.yaml:7:# TODO $name: 'du:**.rst'
  ```

- Key build artefact is currently KEYWORDS. See about some setup for
  Jekyll/Sitefile etc.
  ```
  bugmenot-popup.rst11:.. FIXME Sitefile does not support @MK_BUILDbugmenot-popup.bm.rst
  dlcs-post.rst29:.. FIXME @MK_BUILDdlcs-post.bm.rst
  google-detect-language.rst13:.. FIXME @MK_BUILD/google-detect-language.bm.rst
  google-translate.rst12:XXX: does not detect language of source or choose preferred output language.
  google-translate.rst17:.. FIXME: @MK_BUILDgoogle-translate.bm.rst
  ijs.rst6:.. FIXME: @MK_BUILDijs.1.bm.rst
  ```

- TODO: Review Rules.mk
  ```
  Rules.mk33:# FIXME: arguh, somehow sets of entire build again.. :
  Rules.mk36:# FIXME: not sure if all deps are working, test edit of *.js and *.rst
  Rules.mk86:# FIXME not in Darwin bash? $(BUILD_$d)%.versions: $/%.[0-9]*.js
  Rules.mk100:# FIXME not in Darwin bash? $(BUILD_$d)%.bm.rst: $(BUILD_$d)%.[0-9]*.bm.rst

  Rules.mk166:	@# XXX: rule gets always executed? $(ll) file_target "$@" "Symlinking because" "$^"
  ```

## Known Issues

- The GitHub "ReadMe" view or linked rendered rst pages  will not do either
  includes, or javascript URLs.



dlcs Post Bookmarklet
=====================
:source: `dlcs-post.latest.js`_
:bookmarklet: `dlcs-post.3.bm`_
 
A simple bookmarklet to save an URL to del.icio.us

Overview
_________

This is a slightly modified version of the standard post-via-
popup-bookmarklet available at del.icio.us [1]_.

- Looks for and adds the URL fragment ID to the 'description' field.
- Uses the currently selected text to fill 'notes'.

Issues
-------
Does not function on some sites.
  Not this scripts fault. **Quickfix**: turn off browser javascript support, reload the offending page, turn on javascript again and try the bookmarklet.
  Proper fix: poke in source code and annoy webmaster to find out whats happening first.

----

.. [1] 'post page to popup with type-ahead' 
      (http://del.icio.us/help/morebuttons)
.. _dlcs-post.latest.js: ./dlcs-post.latest.js
.. include:: .build/dlcs-post.bm.rst

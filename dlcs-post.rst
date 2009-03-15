dlcs-post
=========
:source: `dlcs-post.js`_
:bookmarklet: `dlcs-post.3.bm`_

This started out as a normal popup with support for selected text:
most or all of it is used in the extended description field.

It also adds the fragment ID to the title. Both are passed using GET query
parameters to the delicious bookmark post form, and are only used for new posts.

Problems
--------
Does not function on some sites.
  Not this scripts fault. **Quickfix**: turn off browser javascript support, reload the offending page, turn on javascript again and try the bookmarklet.
  Proper fix: poke in source code and annoy webmaster to find out whats happening first.


.. _dlcs-post.js: ./dlcs-post.js

.. include:: ./dlcs-post.3.bm.rst


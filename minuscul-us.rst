===========
minuscul.us
===========

:created: April/May 2006
:subject: web, html, tools, bookmarklets, javascript
:creator: `Berend van Berkum`_, berend@dotmpe.com
:license: MIT_
:Bookmarklet: minuscul-us.1.bm_
:Source:  Source_

A bookmark aid that finds and displays all the anchors in an HTML document.
This so to easily find the URL for a specific fragment of the page. Not
all pages provide the needed anchor ID's or names, but it works nicely for
most text-oriented pages, fora and other sites that use comments, papers
and eg. Wikipedia.

Bugs
----
- Does not work (correctly) on some sites that already
  deploy javascripts (eg. delicious).


Overview
--------

.. figure:: minuscul-us,screenshot.png
   :target: ./minuscul-us,screenshot?width=auto

   minuscul.us running in Gnome's web browser `Epiphany`_ .

The bookmarklet displays all fragments in a drop-down select list floating
in the top-right corner. It also makes all the fragments visible and clickable.
Subsequent bookmarklet clicks will toggle the visibility of the drop-down
list. Reload the page to get rid of all of it. Since it is a bookmarklet
it's nicely portable as any URL. The length (about 1800 characters) should
cause no problem with most browsers. [1]_

Changelog
---------
v1
    First version, approx 1800 characters.

    FIXME: static doc artefact::

      javascript:void((function(){E%20=%20function(s){return%20document.createElement(s)};T%20=%20function(s){return%20document.createTextNode(s)};G%20=%20function(s){return%20document.getElementsByTagName(s)};I%20=%20function(s){return%20document.getElementById(s)};fr%20=%20I('minusculus_floater');if%20(fr){fr.style.visibility=fr.style.visibility=='hidden'?'visible':'hidden';return;}style%20=%20'background-color:whitesmoke;opacity:.90;border:1px%20solid%20silver;color:darkslategray;';res_uri%20=%20document.location.href;if%20(res_uri.indexOf('#')){u%20=%20res_uri.split('#');res_uri%20=%20u[0];cur_frag%20=%20u[1];}else%20cur_frag%20=%20null;A%20=%20G('a');fs%20=%20[];for(var%20x=0;A[x];x++){ID%20=%20(A[x].id%20!=%20'')%20?%20A[x].id%20:%20null;if%20(!ID)%20ID%20=%20(A[x].name%20!=%20'')%20?%20A[x].name%20:%20null;if%20(!ID)%20continue;A[x].setAttribute('style','padding:.2em%20.6em%20.2em%200;'+style);A[x].setAttribute('href','#'+ID);frag_id%20=%20E('span');frag_id.setAttribute('style','color:cornflowerblue;margin:.3em;font-size:.7em;');frag_id.appendChild(T('#'+ID));A[x].appendChild(frag_id);fs.push(ID);}if%20(fs.length==0)%20return%20alert('No%20fragments%20found.');opt%20=%20E('option');st%20=%20E('select');for%20(var%20x%20in%20fs){o%20=%20opt.cloneNode(opt);o.appendChild(T(fs[x]));o.setAttribute('value','#'+fs[x]);if%20(fs[x]%20==%20cur_frag)%20o.selected%20=%20true;st.appendChild(o);}st.onchange%20=%20function(evt){document.location.href=evt.target.value};te%20=%20E('a');te.appendChild(T('minuscul.us'));te.href%20=%20'http:%2F%2Fdotmpe.com%2Fproject%2Fjavascript%2Fbookmarklet%2Fminuscul-us';te.setAttribute('style','color:peru;font-weight:bold;font-size:0.9em;text-decoration:none;display:block;');fr%20=%20E('div');fr.setAttribute('id','minusculus_floater');fr.appendChild(te);fr.appendChild(T('Found%20'+st.childNodes.length+'%20fragments.'));fr.appendChild(E('br'));fr.appendChild(st);fr.setAttribute('style','position:fixed;top:.5em;right:.5em;z-index:5;padding:.5em%20.6em;'+style);body%20=%20G('body')[0];body.insertBefore(fr,body.firstChild);})())



----

.. [1] http://www.squarefree.com/bookmarklets/browsers.html
.. _Epiphany: http://www.gnome.org/projects/epiphany/

.. _Source: minuscul-us.1.js
.. _MIT: http://www.opensource.org/licenses/mit-license
.. _Berend van Berkum: http://dotmpe.com/


.. include:: .build/minuscul-us.1.bm.rst


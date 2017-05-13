/**
 * minuscul.us
 * A bookmark aid for HTML pages that displays all fragments identifiers.
 *
 * Copyright (c) 2006 Berend van Berkum <berend : dotmpe : com>
 *
 * Finds all fragments in a document. Make them visible and display a
 * floating select list in the top-right corner. Clicking the
 * bookmarklet again toggles the visibility of the 'floater'.
 *
 * Version 0.1
 * Created for the Gecko engine, tested with Gecko 1.7
 *
 * License: MIT (use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell but leave the above copyright. Thanks).
 * See: http://www.opensource.org/licenses/mit-license
 *
 * For more information and the compressed, single-line bookmarklet
 * of this code:
 * http://dotmpe.com/project/javascript/bookmarklet/minusculus
 *
 */

E = function(s){return document.createElement(s)};
T = function(s){return document.createTextNode(s)};
G = function(s){return document.getElementsByTagName(s)};
I = function(s){return document.getElementById(s)};

/* Toggle visibility of existing floater if its there */
fr = I('minusculus_floater');
if (fr) {fr.style.visibility=fr.style.visibility=='hidden'?'visible':'hidden';return;}

/* Common style rules */
style = 'background-color:whitesmoke;opacity:.90;border:1px solid silver;color:darkslategray;';

/* Split current fragment identifier from URL if it's there */
res_uri = document.location.href;
if (res_uri.indexOf('#')) {
	u = res_uri.split('#');
	res_uri = u[0];
	cur_frag = u[1];
}
else cur_frag = null;

/* Get a list of all anchors with a name or id and make them clickable (add href) */
A = G('a');
fs = [];
for(var x=0;A[x];x++){

	ID = (A[x].id != '') ? A[x].id : null;
	if (!ID)
		ID = (A[x].name != '') ? A[x].name : null;

	if (!ID)
		continue;

	A[x].setAttribute('style', 'padding:.2em .6em .2em 0;'+style);
	A[x].setAttribute('href', '#'+ID);
	frag_id = E('span');
	frag_id.setAttribute('style', 'color:cornflowerblue;margin:.3em;font-size:.7em;');
	frag_id.appendChild(T('#'+ID));
	A[x].appendChild(frag_id);

	fs.push(ID);
}
/* Abort if needed */
if (fs.length==0) return alert('No fragments found.');

/* Create a select list of all the fragments */
opt = E('option');
st = E('select');

for (var x in fs) {
	o = opt.cloneNode(opt);
	o.appendChild(T(fs[x]));
	o.setAttribute('value', '#'+fs[x]);
	if (fs[x] == cur_frag) o.selected = true;

	st.appendChild(o);
}
st.onchange = function(evt){document.location.href=evt.target.value};

/* Shameless self-promotion */
te = E('a');
te.appendChild(T('minuscul.us'));
te.href = 'http://dotmpe.com/project/javascript/bookmarklet/minuscul-us';
te.setAttribute('style','color:peru;font-weight:bold;font-size:0.9em;text-decoration:none;display:block;');

/* Assemble the 'floater' and add it to the page */
fr = E('div');
fr.setAttribute('id','minusculus_floater');
fr.appendChild(te);
fr.appendChild(T('Found '+st.childNodes.length+' fragments.'));
fr.appendChild(E('br'));
fr.appendChild(st);
fr.setAttribute('style','position:fixed;top:.5em;right:.5em;z-index:5;padding:.5em .6em;'+style);

body = G('body')[0];
body.insertBefore(fr, body.firstChild);

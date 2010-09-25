/**
 * mpe-toggle_width
 * Stylesheet switcher for dotmpe.com
 *
 * Copyright (c) 2006 Berend van Berkum <berend : dotmpe : com>
 * 
 * Version 0.1, tested with Gecko 1.7
 * 
 * License: Public Domain, warranty void
 *
 * For more information and the compressed, single-line bookmarklet
 * of this code: 
 * http://dotmpe.com/project/javascript/bookmarklet/mpe-toggle_width
 * 
 */

javascript:void((function(){
	E = function(s){return document.createElement(s)};
	T = function(s){return document.createTextNode(s)};
	G = function(s){return document.getElementsByTagName(s)};
	I = function(s){return document.getElementById(s)};
	S = function(){
		ss = [];
		ls = G('link');
		for (var i=0;ls[i];i++) {
			if (ls[i].rel == 'stylesheet')
				ss.push(ls[i]);
		}
		return ss;
	};
	 
	/* Look for stylesheet */
	styles = S();
	link=null;	
	i=0;
		
	for (i=0;styles[i];i++)
		if (styles[i].href == '/style/autowidth')
			link = styles[i];

	if (!link) {
		/* Create link to auto-width stylesheet */
		link = E('link');
		link.rel = 'stylesheet';
		link.id = 'autowidth_link';
		link.type = 'text/css';
		link.href = '/style/autowidth';
		link.disabled = false;
		head = G('head')[0];
		head.appendChild(link);
	}

	
	else
		link.disabled = (link.disabled) ? false : true;
	
		
})())

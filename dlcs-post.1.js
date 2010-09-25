/**
 * dlcs_post_bm
 * A bookmarklet to save an URL as bookmark to del.icio.us
 *
 * Public Domain 
 *
 * This is a slightly 'enhanced' version of the standard post-via-
 * popup-bookmarklet available at del.icio.us [1].
 *
 *  - Looks for and adds the URL fragment ID to the 'title' property.
 *  - Uses the currently selected text to fill 'notes'.
 *
 * Version 0.1, tested with Gecko 1.7
 * 
 * For more information and the compressed, single-line bookmarklet
 * of this code: 
 * http://dotmpe.com/project/javascript/bookmarklet/dlcs_post
 *
 * [1] 'post page to popup with type-ahead' 
 *     (http://del.icio.us/help/morebuttons)
 */

javascript:void((function(){

	/* Location */
	l = document.location.href;
	
	/* Title */
	tit = document.title;	
	if (l.indexOf('#')>0) { 
		u = l.split('#');
		tit += ' # '+ u[1];
	}

	/* Selected Text */
	txt = '';
	
	if (window.getSelection)
		txt = window.getSelection();
		
	else if (document.getSelection)
		txt = document.getSelection();
		
	else if (document.selection)
		txt = document.selection.createRange().text;
		
	/* Popup */	
	url = 'http://del.icio.us/mpe?v=4&noui&jump=close'
		+'&url=' +encodeURIComponent(l)
		+'&title=' +encodeURIComponent(tit)
		+'&notes=' +encodeURIComponent(txt);
		
	open(url,'delicious','toolbar=no,width=700,height=400');

})())

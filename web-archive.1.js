/**
 * Web Archive
 * ============
 * Lookup the currently displayed document in the Internet Archive's `Wayback Machine`_.
 *
 */
//javascript:void((function(){
	url = 'http://web.archive.org/web/*/' + document.location.href;
	document.location.href = url;
//})())

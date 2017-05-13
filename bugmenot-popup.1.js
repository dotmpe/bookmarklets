/**
 * BugMeNot Popup
 * Pops up a new window with BugMeNot account details for the
 * site your viewing.
 *
 * Public Domain
 *
 * Version 0.1, tested with Gecko 1.7
 *
 * For more information and the compressed, single-line bookmarklet
 * of this code:
 * http://dotmpe.com/project/javascript/bookmarklet/bugmenot_popup
 *
 */
url = 'http://www.bugmenot.com/view/' + document.location.href;
open(url,'BugMeNot','toolbar=no,width=600,height=400');

/**
 * del.icio.us post bookmarklet
 * Version 2
 *
 * Changelog:
 * 2. Updated to del.icio.us/save?v=4
 */
void((
	function () {
		l=document.location.href;
        d=document.title;
        if(l.indexOf('#')>0){
            d+='%20#%20'+l.split('#')[1]}
// selecting html using javascript:
// http://www.webreference.com/js/column12/index.html
        e='';
        if(window.getSelection){
            e=window.getSelection()}
        else if(document.getSelection){
// NS4
            e=document.getSelection()}
        else if(document.selection){
// IE4
            e=document.selection.createRange().text}

        u='http://del.icio.us/save?v=5&url='+encodeURIComponent(l)+'&title='+encodeURIComponent(d)+'&notes='+encodeURIComponent(e);
        f=function(){
            if(!window.open(u+'&noui=1&jump=doclose','deliciousuiv5','location=yes,links=no,scrollbars=no,toolbar=no,width=550,height=550'))
                location.href=u+'jump=yes'};
        if(/Firefox/.test(navigator.userAgent)){setTimeout(f,0)}
        else{f()}
    }
)())

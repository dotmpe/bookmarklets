/**
 */
javascript:void((function () {

    W=window;
    W.d=document;
    D=function(){return W.d.documentElement};
    _=null;
    Y=true;
    E=function(s){return W.d.createElement(s)};
    Tn=function(s){return W.d.createTextNode(s)};
    B=function(d){return gt('body',d)[0]};
    np=function(n)/*node-parent*/{return n.parentNode};
    lc=function(n){return n.lastChild};
    atr=function(n,v)/*set-attrs*/{
        for(vk in v)n.setAttribute(vk,v[vk])};
    gt=function(s,n)/*get-els-by-tag-name*/{
        var n=n?n:D();return n.getElementsByTagName(s)};
    gb=function(n,c)/*grab/append-child(element,child)*/{
        n.appendChild(c);
        return n};
    pn=function(p,n,b)/*put/prepend-node(parent,node(s),?before)*/{
        b=b?b:p.firstChild;
        p.insertBefore(n,b);
        return p};
    at=function(n,k,h)/*attach-event-handler*/{
        if(n.addEventListener)n.addEventListener(''+k,h,false);
        else if(n.attachEvent)n.attachEvent('on'+k,h);
        else{on='on'+k;atr(n,{on:h})}};

    var hd=gt('head')[0];

    var fm=E('form');
    atr(fm,{'action':'#','method':'get','style':'width:100%;padding:.2em .2em .5em .2em;'});
    pn(B(),gb(fm,E('input')));
    at(fm,'submit',function(){
        var url=fm.firstChild.value;
        W.d.location=url;
        return false});

    //var scr=E('script');
    //scr.setAttribute('type', 'text/javascript');
    //scr.setAttribute('src', 'http://dotmpe.com/2009/01/dotmpe-v4/script/mpe.js');
    //head.appendChild(scr);

})())

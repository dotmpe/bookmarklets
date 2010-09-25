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
    ga=function(o)/*get-array*/{
        var s=[];
        var l=o.length;
        for(var i=0;i<l;i++)
            s[i]=o[i];
        return s};
    rn=function(n,d)/*remove-node(node,W.d)*/{d=d?d:np(n);return d.removeChild(n)};
    drop=function(p,ns)/*remove-nodes(parent-node,node-array)*/{
        var ns=ns?ns:ga(p.childNodes);
        if(ns)
            for(var r in ns){
                rn(ns[r],p)}return ns};

    var hd=gt('head')[0];

    var uri=W.d.location;
    W.d.location='#';

    //drop(W.d);
    drop(hd);
    drop(B());
    //grab(W.d,E('html'));
    //grab(W.d.documentElement,E('body'));


    var w=W.innerWidth-35;

    var f=E('iframe');
    atr(f,{'src':uri,'style':'-moz-border-radius:3px;margin:0;width:'+w+'px;height:'+(W.innerHeight-50)+'px;'});
    gb(f,Tn(' '));

    var fm=E('form');
    atr(fm,{'action':'#','method':'get','style':'width:'+w+'px;'});
    gb(B(),gb(fm,E('input')));
    atr(fm.firstChild,{'style':'width:'+w+'px;margin:0;','value':uri});
    at(fm,'submit',function(){
        var url=fm.firstChild.value;
        atr(f,{'src':url});
        //W.d.location=url;
        return false});

    gb(B(),f);

    //var scr=E('script');
    //scr.setAttribute('type', 'text/javascript');
    //scr.setAttribute('src', 'http://dotmpe.com/2009/01/dotmpe-v4/script/mpe.js');
    //head.appendChild(scr);

})())

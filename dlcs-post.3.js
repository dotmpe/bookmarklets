/**
 * del.icio.us post popup bookmarklet
 * With,
 * - text selection for notes, and fragment ID to title copy.
 *
 * Changelog:
 * 2. Updated to del.icio.us/save?v=4
 * 3. To v=5/deliciousuiv5, 

 */
void((
	function () {

/*globals*/
W=window;
W.d=document;
D=function(){return W.d.documentElement};
_=null;
Y=true;
fn1=function(x){return x};
/*types-util*/
jsi=function(o,c){return o instanceof c};
jst=function(o,c){return typeof o==c};
tArr=function(o){return jsi(o,Array)};
tStr=function(o){return jst(o,"string")};
/* array-util */
map=function(f,a,t)/* map( function, array, this-ref )
	Apply function to each item and return array of identical length. 
*/{
	var s=[];
	var l=a.length;
	for(var i=0;i<l;i++)
		s[i]=f.call(t,a[i],i,a);
	return s};
red=function(f,a,v,h,r)/* reduce( func, arr, initial-val, this-pter, reverse )
	Iteratively reduce each item to a single value and return; 
*/{
	var s=v;
	var l=a.length;
	for(var i=0;i<l;i++)
		s=f.call(h,s,a[i],i,a);
	return s};
gf=function(f,a)/* get-if( function, array ) */{
	var r=[];map(function(i){if(f(i))this.push(i)},a,r);return r};
af=function(v,a)/* array-find-all( value, array )*/{
	/** Return array with each matching item. */
	return gf(function(x){
		if(v==x)return x},a)};
ga=function(o)/*get-array*/{
	return map(fn1,o)};
zip=function(s1,s2)/*combine-array*/{
	var d1=s1.length;
	var d2=s2.length;
	var mn=d1<d2?d1:d2;
	var rs={};
	for(var i=0;i<mn;i++){
		rs[s1[i]]=s2[i]};
	return rs};
El=function(s){return W.d.createElement(s)};
Tn=function(s){return W.d.createTextNode(s)};
B=function(d){return gt('body',d)[0]};
np=function(n)/*node-parent*/{return n.parentNode};
lc=function(n){return n.lastChild};
atr=function(n,v)/*set-attrs*/{
	for(vk in v)n.setAttribute(vk,v[vk])};
rn=function(n,d)/*remove-node(node,W.d)*/{d=d?d:np(n);return d.removeChild(n)};
pn=function(p,n,b)/*put/prepend-node(parent,node(s),?before)*/{
	if(!tArr(n))n=[n];
	b=b?b:p.firstChild;
	map(function(i){p.insertBefore(i,b)},n);
	return p};
gt=function(s,n)/*get-els-by-tag-name*/{
	var n=n?n:D();return n.getElementsByTagName(s)};
gs=function()/*selected-text*/{
    var t=_;
	if(W.getSelection)
		t=W.getSelection();
	else if(W.d.getSelection)/* NS4 */
		t=W.d.getSelection();
	else if(W.d.selection)/* IE4 */
		t=W.d.selection.creatRange().text;
	return t};
at=function(n,k,h)/*attach-event-handler*/{
	if(n.addEventListener)n.addEventListener(''+k,h,false);
	else if(n.attachEvent)n.attachEvent('on'+k,h);
	else{on='on'+k;atr(n,{on:h})}};
gb=function(n,c)/*grab/append-child(element,child)*/{
	if(!tArr(c))c=[c];
	map(function(i){n.appendChild(i)},c);
	return n};
drop=function(p,ns)/*remove-nodes(parent-node,node-array)*/{
	var ns=ns?ns:ga(p.childNodes);
	if(ns)
		for(var r in ns){
			rn(ns[r],p)}return ns};
/* markup utils */
pt=function(p,d)/* path-to( tree-path, in-doc ) : Node
*/{
	d=d?d:D();
	p=tArr(p)?p:map(Number,p.split('.'));n=_;
	while(p.length){
        var x=p.shift() ;
		d=d.childNodes[x];
	}
	return d};
tp=function(n)/* tree-path( for-node ) : Enum<Int>
	Return the path from root to node.
*/{
	var t=[];
	var p=n.parentNode;
	while(p){
		t.unshift(ga(p.childNodes).indexOf(n));
		n=p;p=p.parentNode}
	return t};
m=function()/* generate-element( tag, *attr )( content, *values ) */{
	var ats=gf(tStr,arguments);
	var t=ats.shift();
	return function _l(){
		rgs=ga(arguments);
		c=rgs.splice(0,1)[0];
		e=El(t);
		if(c)gb(e,tStr(c)?Tn(c):c);
		if(rgs)
			atr(e,zip(ats,rgs));
		return e}};
/* HTML nodes */
A=m('a','href','rel');
//Di=m('div','id');
Sp=m('span','class');
Dc=m('div','class');
Ds=m('div','style');

var txt=''+gs();
var url=W.d.location.href;
var doc=W.d.title;

var opts='location=yes,links=no,scrollbars=no,toolbar=no,width=550,height=550';
//var w=window.open(url,'dlcs-post v3',opts);

at(W.d,'click',function(e){
    var path=tp(e.target).join('.');
    alert([pt(path,W.d),path,e.target,e.target.tagName]);
    return false;
});
w=_;
at(w,'load',function(){
    var h=W.innerHeight/9;
    var h1=h*3;
    var h2=W.innerHeight-h1;

    var childNodes=drop(w.document.body);
    var wrap1=pn(w.document.body,Ds(_,'background-color:#eef;')).firstChild;
    gb(w.document.body,gb(Ds(_,'width:100%;overflow:scroll;'),childNodes));

    L=function()/* debug-log */{
        if(!L.o){
            L.o=gb(w.document.body,Dc(_,'log')).lastChild}
        gb(L.o,Dc(Tn(L.l+'. '+ga(arguments)),'line'));
        L.l+=1};
    L.l=0;

    L(url);
    if(url.indexOf('#')>0){
        doc+='%20#%20'+url.split('#')[1]
    }
    L(doc);
    L(txt);
    var u='http://del.icio.us/save?v=5&url='+encodeURIComponent(url)+'&title='+encodeURIComponent(doc)+'&notes='+encodeURIComponent(txt);
    L(u);
    
    IFe=m('iframe','name','width','height','src');
    var f=gb(wrap1,IFe(_,'deliciousuiv5','100%',u)).firstChild;

});

function openPostForm(u){
        f=function(){
            if(!window.open(u+'&noui=1&jump=doclose','deliciousuiv5',opts))
                location.href=u+'jump=yes'};
        if(/Firefox/.test(navigator.userAgent)){setTimeout(f,0)}
        else{f()}
        }
}
)())

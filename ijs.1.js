/**
 * IJs - 'interactive' javascript
 *
 * ijs, a simple javascript console in javascriptlet/bookmarklet form.
 * Enables interactive inspection of window web documents in JavaScript enabled
 * user agents.
 *
 * Inspiration:
 * http://mochikit.com/examples/view-source/view-source.html#interpreter/interpreter.js
 */
  style="input{width:auto}.console,.itp{font-family:mono;}.ijs{background-color:#dec;opacity:.9;border:.1em solid #888;color:#233;max-width:46em;}.floater{font-size:0.6em;position:fixed;top:.5em;right:.5em;z-index:5;padding:.5em .6em;}";
	E=function(s){return document.createElement(s)};
	T=function(s){return document.createTextNode(s)};
	G=function(s){return document.getElementsByTagName(s)};
	I=function(s){return document.getElementById(s)};
	A=function(n,a,v){n.setAttribute(a,v);return n};
	grab=function(n,c){n.appendChild(c);return n};
	put=function(n,c,b){if(!b)b=n.firstChild;n.insertBefore(c,b);return n};
	repl=function(n,r){n.parentNode.replaceChild(r,n);return n};
	doc=function(){return document.documentElement};
	np=function(n)/*node-parent*/{return n.parentNode};
	rn=function(n,d)/*remove-node(node,document)*/{d=d?d:np(n);return d.removeChild(n)};
	drop=function(p,ns)/*remove-nodes(parent,nodes)*/{for(nn in ns)rn(nn,p);return p;};
//    cmds=['clear','dir','grab','put','repl','E[lement]','T[extNode]','[G]etTags','[I]ds','Set[A]trribute'];
    dir=function(o){p=I('ijs-console');r='';for(a in o)r+=a+'\n';return r};
//    clear=function(){p=I('ijs-console');
//        pcn=p.childNodes;
//        for (i=0;i<pcn.length;i++)rn(pcn[i],p)};
    help=function(){
        cm='';
//        for(n in cmds){
//cm+='<a href="javascript:'+escape('window.ijs.csl.eval(\"'+cmds[n]+'();\");')+'"><strong>'+cmds[n]+'</strong>()</a> ';
//        }
        h=E('div');
        h.innerHTML='<a href="http://dotmpe.com/project/bookmarklet/ijs" title="Visit homepage">ijs</a>. '+cm;
        return h;
    };
	_kh=function(e){
		if(!e)e=event;
        csl=I('ijs-console');
		c=e.keyCode;
        cl=e.target.value;
		if(c==13)/*enter*/{
            rs=csl.eval(cl);
            if(rs){
                csl.log(rs);
                e.target.value=''}
            return true}
        else if(c==40)/*down*/{
            csl.ci+=1;
            if(csl.ci==csl.history.length){
                e.target.value='';
                csl.ci=csl.history.length-1;
            }else{
                e.target.value=csl.history[csl.ci]}}
        else if(c==38)/*up*/{
//            if(cl!=csl.history[csl.history-1])csl.history.push(cl);
            csl.ci-=1;
            if(csl.ci==-1)
                csl.ci=0;
            e.target.value=csl.history[csl.ci]
        }
    };
    /* Main */
	if(window.ijs)
		{window.ijs.style.visibility=window.ijs.style.visibility=='hidden'?'visible':'hidden';return}
	else{
        head=G('head')[0];
        grab(head,grab(E('style'),T(style)));
        /*scriptlet floater in page body*/
        ijs=A(A(E('div'),'class','ijs floater'),'id','ijs-floater');
        _log=function(p,t)/*generate-log-line*/{return grab(A(grab(E('div'),T(p)),'class','ijs line'),t)};
        /*ConSoLe keeps all entered lines and result objects*/
        csl=A(A(E('div'),'class','ijs console'),'id','ijs-console');
        csl.history=[];
        csl.ci=0;
        csl.eval=function(cl){
            try{
                v=eval(cl);
                grab(csl,_log('>>> ',T(cl)));
                csl.history.push(cl);
                csl.ci=csl.history.length;
                return v
            }
            catch(e){
                grab(csl,_log('-!- ',T(cl+': '+e)))
            }
        };
        csl.log=function(v){
//            if(v.nodeType){
//            if(v.innerHTML!=null&&(v.parentNode||v.nodeType==9)){
//            if(v.hasAttribute&&v.hasAttribute('innerHTML'))
//                v=T(String(v.innerHTML));
//            }
//            else
                v=T(String(v));
            grab(csl,_log('<<< ',v))
        };
        grab(ijs,csl);
        ijs.csl=csl;
        /*InTerPreter handles evaluating and logging to console*/
        itp=A(E('input'),'class','ijs itp');
        itp.onkeydown=_kh;
        grab(ijs,itp);
//        itp.focus();

        ijs.itp=itp;
        body=G('body')[0];
        put(body,ijs);
        window.ijs=ijs};
//})())

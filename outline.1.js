/**
 * Outline
 * Generates outlines from HTML documents.
 *
 */
javascript:void((function(){

	E=function(s) {return document.getElementsByTagName(s);};
	C=function(s) {return document.createElement(s);};
	T=function(s) {return document.createTextNode(s);};

	Array.prototype.find = function (s) {

		for(var i=0;i < this.length; i++)
			if(this[i] == s) return true;
			return false;
	};
	
	/* Common style rules */
	style = 'background-color:whitesmoke;opacity:.85;border:1px solid silver;color:darkslategray;';

	function reapFromDOM(obj, findE, outObj, lvl) {
		
		var ref = C('a');
		ref.setAttribute('style', 'color:cornflowerblue;margin:.3em;'+style);
		
		for (var i=0; i<obj.childNodes.length; i++) {
			var childObj = obj.childNodes[i];
			
			if (findE.find(childObj.tagName)) {
				/* Insert Backref */
				a = ref.cloneNode(ref);
				a.appendChild(T(' ('+childObj.tagName+') '));
				obj.insertBefore(a, childObj);
				
				/* Put element in outbox */
				/*c = obj.removeChild(childObj);*/
				  outObj.appendChild (childObj);
			}
			
			reapFromDOM(childObj, findE, outObj, lvl + 1);
		}
	};

	var box = C('div');
	box.setAttribute('style','position:fixed;top:.5em;right:.5em;z-index:5;font-size:50%;width:32em;padding:.5em .6em;'+style);
	var body = E('body')[0];

	body.insertBefore (box, body.firstChild);

	/* Get all h1,h2,h3,h4,h5,h5 */
	var hdrs = ['h1','h2','h3','h4','h5','h6'];
	reapFromDOM (body, hdrs, box, 0);

})())

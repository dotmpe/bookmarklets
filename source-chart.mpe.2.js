/**
 * Add stylesheet
 */
void((function(){
	E = function(s){return document.createElement(s)};
	T = function(s){return document.createTextNode(s)};
	N = function(s){return document.getElementsByTagName(s)};
	I = function(s){return document.getElementById(s)};

    id = 'source-chart.mpe';
    s = I(id);
    if (s == null) {
        h = N('head')[0];

        s = E('link');
        s.setAttribute('rel', 'stylesheet');
        s.setAttribute('type', 'text/css');
        s.setAttribute('href', 'http://dotmpe.com/style/source-chart.css');
        s.setAttribute('title', 'Document source structure (dotmpe)');
        s.setAttribute('id', id);
        h.appendChild(s);
    }
    else {
        sdisabled = s.disabled; 
        s.disabled = !sdisabled;
    }
})())

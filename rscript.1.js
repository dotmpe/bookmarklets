javascript:void((
	function () {
		function E(n) {return document.getElementsByTagName(n)};
		scripts = E('script');
		if (scripts.length>0) {
			for (i=0; i<scripts.length; i++)
				document.removeChild(scripts[i]);
		};
	}
)())

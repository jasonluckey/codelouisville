//random color javascript
 
 function random_color() { 
 var color = '#'; 
 var letters = ['e2620d','f4b342','a2e23b','3ae2c3','e231b9','c993bc','4286f4','f27f52']; 
 color += letters[Math.floor(Math.random() * letters.length)]; 
  document.body.style.background = color; 
}

//popup a pic

function popup(mylink, windowname) { 
	if (! window.focus)return true; 
	var href; 
	if (typeof(mylink) == 'string') href=mylink; 
	else href=mylink.href; 
	window.open(href, windowname, 'width=300,height=250,scrollbars=yes'); 
	return false; 
}
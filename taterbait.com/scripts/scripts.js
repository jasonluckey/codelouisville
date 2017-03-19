//random color javascript
 
 function random_color() { 
 var div = document.getElementById('colorChange');
 var color = '#'; 
 var letters = ['e2620d','f4b342','a2e23b','3ae2c3','e231b9','c993bc','4286f4','f27f52']; 
 color += letters[Math.floor(Math.random() * letters.length)]; 
 div.style.background = color;
  
};

//popup a pic

function popup(mylink, windowname) { 
	if (! window.focus)return true; 
	var href; 
	if (typeof(mylink) == 'string') href=mylink; 
	else href=mylink.href; 
	window.open(href, windowname, 'width=300,height=250,scrollbars=yes'); 
	return false; 
};

// table stuff

var proxy = 'https://cors-anywhere.herokuapp.com/';
var myUrl = 'https://www.1988trip.xyz/data.json';
var finalUrl = proxy + myUrl;

$.ajax({
 url: finalUrl,
  dataType: 'json',
    success : function(data) 
    { console.log(data);
        for (var i=0; i<data.length; i++) {
            var row = $('<tr><td>' + data[i].OneThing+ '</td><td>' + data[i].AnotherThing + '</td><td>' + data[i].OneMore + '</td><td>' + data[i].LastThing + '</td></tr>');
            $('#myTable').append(row); }
    }
});

// NavBar

$(document).ready(function(){
	$('.toggle').click(function(){
		$('#nav').toggleClass('open');
		$('.container').toggleClass('menu-open');
	});
});
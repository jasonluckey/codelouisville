//random color javascript
 
 function ran_col() { //function name
 var color = '#'; // hexadecimal starting symbol
 var letters = ['e2620d','f4b342','a2e23b','3ae2c3','e231b9','c993bc','4286f4','f27f52']; //Set colors here
 color += letters[Math.floor(Math.random() * letters.length)]; //put it all together
  document.body.style.background = color; //make the magic happen
}


//popup a pic

$(document).ready(function() {

	$('.magnific').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		image: {
			verticalFit: false
		}
	});

});

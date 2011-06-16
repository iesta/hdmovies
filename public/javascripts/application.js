$(document).ready(function() {
	// we catch 'f' and 's' keypresses only of no input nor textarea selected
	$('body').keypress(function(event) {
		if ( event.target.nodeName.toLowerCase() !== 'input' && event.target.nodeName.toLowerCase() !== 'textarea' && (event.which == '102' || event.which == '70' || event.which == '115' || event.which == '83')) {
			event.preventDefault();
			$('#s').val('').select();
		}
	});
	
	// some fun with the background :-)
	/*
	var i = 1;
	var rotateBg = setInterval(function(){
	    $('body').css( 'background', "url(/images/bg/sky-" + (i++) + ".jpg)" );
//	    i++;
		if(i>10) { i = 1 };
	}, 15000);
	*/
});
$(document).ready(function() {
	// we catch 'f' and 's' keypresses only of no activeElement
	$('body').keypress(function(event) {
		if ($(document.activeElement) && (event.which == '102' || event.which == '70' || event.which == '115' || event.which == '83')) {
			event.preventDefault();
			$('#s').val('').select();
		}
	});
});
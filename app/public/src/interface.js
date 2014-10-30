$(document).ready(function() {

	$('.sign_in').hide();
	$('.sign_up').hide();
	$('#sign_in_button').on('click', function() {
		$('.sign_in').toggle();
		$('.sign_up').hide();
	});

	$('#sign_up_button').on('click', function() {
		$('.sign_up').toggle();
		$('.sign_in').hide();
	});

});
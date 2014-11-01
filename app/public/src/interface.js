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

$.getJSON('/api/peeps', function(peepData) {
		var source = $('#peeps').html();
		var template = Handlebars.compile(source);
		var peepList = $.each(peepData, function(count, listOfAllPeeps) {})

			$.each(peepList, function(count, individualPeep) {
				console.log(individualPeep)
				$('#peeps-holder').append(template(individualPeep));
			});
});



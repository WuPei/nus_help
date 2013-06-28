// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(function() {
	if ($('title').html() == "NUS HELP" && $('.pagination').length) {
		if ($('.pagination').length) {
			$(window).scroll(function() {
				var url = $('.pagination').find('li.next_page >a').attr('href');
				if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
					$('.pagination').text("See More Helps...");
					$.getScript(url);
				};
			});
		};
	});
}
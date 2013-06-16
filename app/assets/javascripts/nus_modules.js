(function($) {
	$(function() {
		var autoOpts = {
			minLength: 3,
			autoFocus: true,
			source: $('#search').data('autocomplete-source')		
		};
		$('#search').autocomplete(autoOpts)
	});
})(jQuery);

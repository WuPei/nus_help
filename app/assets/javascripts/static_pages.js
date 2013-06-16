// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

(function($) {
	$(function() {
		var pickerOpts = {
			dateFormat: "d MM yy"
		};
		var autoOpts = {
			minLength: 3,
			autoFocus: true,
			source: $('#micropost_module_code').data('autocomplete-source')		
		};
		$("#micropost_deadline").datepicker(pickerOpts)
		$('#micropost_module_code').autocomplete(autoOpts)
	});
})(jQuery);

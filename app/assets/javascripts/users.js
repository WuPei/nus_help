(function($) {
  $(function() {
    $('#btn_create_user').click(function(e){
      e.preventDefault();
      $('#create_user_form').submit();
    });
    $('#create_user_form').submit(function(e){
    	$('#btn_create_user').attr('disabled', 'disabled');
    });
  });
})(jQuery);
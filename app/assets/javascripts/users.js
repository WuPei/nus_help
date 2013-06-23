(function($) {
  $(function() {
    $('.button_submit').click(function(e){
      e.preventDefault();
      $('#create_user').submit();
    });
    $('#create_user').submit(function(e){
    	$('#btn_create_user').attr('disabled', 'disabled');
    });
  });
})(jQuery);
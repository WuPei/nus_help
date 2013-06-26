
function updateUI(){
  $(".needToolTip").tooltip();
  $(".unfollow").click(function(evt,ui){
      // TODO: update DB that module has been unfollowed.
    $(evt.target).parent().hide(200);
  });
}

$(function(){
  updateUI();
});


$(function() {
    // Date Picker setup
  var pickerOpts = {
    dateFormat: "d MM yy"
  };
  $("#micropost_deadline").datepicker(pickerOpts)

 // Auto Complete for the date
  var autoOpts = {
    minLength: 3,
    autoFocus: true,
    source: $('#micropost_module_code').data('autocomplete-source')		
  };
  $('#micropost_module_code').autocomplete(autoOpts)
});

$(function(){
  $('#tabs').tab();
    $('.open_add_thanks').click(function(){
      var id = $(this).data('id');
      $('.modal-body #rec_id').val(id);
    })
});


$(function() {
  $tags = $(".module-tags");

  $(function() {
    var autoOpts = {
      minLength: 3,
      autoFocus: true,
      source: $('#searchm').data('autocomplete-source'),
      select: function(evt,ui){
        // Create a such item
        $closeTag = $("<a></a>"); $closeTag.html("x"); $closeTag.addClass("close needToolTip unfollow"); 
        $closeTag.attr("title","Unfollow");
        $mInfo = $("<a></a>"); $mInfo.html(ui.item.value);
        $mTag = $("<span></span>"); $mTag.addClass("module-tag needToolTip");
        $mTag.attr("title","Module Title Stub");
        
        $mInfo.appendTo($mTag); $closeTag.appendTo($mTag);
        $mTag.appendTo($tags);

        // TODO: callback to update DB that module has been followed
        
        // Clear the box
        evt.preventDefault(); $(evt.target).val("");
        updateUI();
      }
    };
    $('#searchm').autocomplete(autoOpts)
  });
});


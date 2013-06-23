// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.ui.datepicker
//= require turbolinks
//= require bootstrap
//= require jquery-fileupload/basic
//= require_tree .


//= require jquery.ui.tooltip
//= require jquery.ui.autocomplete
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

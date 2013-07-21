//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery-fileupload/basic
//= require jquery.ui.tooltip
//= require bootstrap
//= require jquery.ui.all
//= require_tree .

function updateUI(){
  $(".needToolTip").tooltip();
  $(".unfollow").click(function(evt,ui){
      // TODO: update DB that module has been unfollowed.
    console.log(evt)
    $m_code = evt.currentTarget.parentElement.innerText;
    $m_code = $m_code.substring(0,$m_code.indexOf('\n')-1);
    $.ajax({
      type : "POST",
      url : "module_followings_delete",
      data:JSON.stringify({
        mode : "module",
        mod_id: $m_code,
      }),
      contentType: 'application/json',
      success : function(response) {
        console.log("success");
      },
      error : function(response) {
        console.log("not");
      }
    }); 

    $(evt.target).parent().hide(200);
  });
}

$(function(){
  updateUI();
});

$(function() {
  $('#new_micropost').submit(function(e){
    $('#post_submit').attr('disabled', 'disabled');
  });
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
      // minLength: 3, // NO need the minLength
      autoFocus: true,
      source: $('#searchm').data('autocomplete-source'),
      select: function(evt,ui){
        // Create a such item
        $closeTag = $("<a></a>"); $closeTag.html("x"); $closeTag.addClass("close needToolTip unfollow"); 
        $closeTag.attr("title","Unfollow");
        $mInfo = $("<a></a>"); $mInfo.html(ui.item.value);
        
        var flag = true;
        var mod_list = $tags[0].children;
        for (var i=0; i<mod_list.length; i++){
          var text = mod_list[i].textContent;
          if ($mInfo.html().trim()+'x' == text.trim())
               flag = false;
        }
        if (flag) {
          $mTag = $("<span></span>"); $mTag.addClass("module-tag");
          $mTag.attr("title","Module Title Stub");
          $mInfo.appendTo($mTag); $closeTag.appendTo($mTag);
          $mTag.appendTo($tags);
        }
        
        $.ajax({
          type : "POST",
          url : "module_followings",
          data:JSON.stringify({
            mod_id: $mInfo.html(),
            mode : "module",
          }),
          contentType: 'application/json',
          success : function(response) {
            console.log("success");
          },
          error : function(response) {
            console.log("not");
          }
        }); 
        // Clear the box
        evt.preventDefault(); $(evt.target).val("");
        updateUI();
      }
    }
    $('#searchm').autocomplete(autoOpts)
  });
});


// Used by the sidebar
$(function(){
  $sidebar = $("#sidebar-right-main");
  $sidebarctrl = $("#sidebar-arrow");
  var width = $sidebar.css("width");
  $sidebar.css("width","0px");
  $sidebar.attr("isO",0);// default to close
  $sidebarctrl.html("<i class='icon-chevron-left'></i>");

  var bumpout = function(){
    console.log($sidebar);
    console.log("Width = " + width);
    if($sidebar.attr("isO") == "1"){
      // Do sidebar close
      $sidebar.animate({
        width:"0px"
      },100);
      $sidebar.attr("isO","0");
      $sidebarctrl.html("<i class='icon-chevron-left'></i>");
    } else{
      // Do Sidebar open
      $sidebar.animate({
        width: width
      },100);
      $sidebar.attr("isO","1");
      $sidebarctrl.html("<i class='icon-chevron-right'></i>");

    }
  }
  $("#sidebar-right-ctrl").click(bumpout);
});

$(function(){
  $('.click_count').click(function(){
    //add 1 for module table click
    console.log(11111)
    var url = "post_click"
    var post_id = $(this).data('id');
    var uid = $(this).data('uid');
    
    console.log(url);
    $.ajax({
      type : "POST",
      url : url,
      data:JSON.stringify({
        post_id: post_id,
      }),
      contentType: 'application/json',
      success : function(response) {
        console.log("success");
      },
      error : function(response) {
        console.log("not");
      }
    }); 
  });
});

$(function(){
  $('.click_notification').click(function(){
    var url="/notification_click"
    var notification_id =$(this).data('id');
    $.ajax({
      type : "POST",
      url : url,
      dataType:"json",
      data: JSON.stringify({
        activity_id: notification_id
      }),
      contentType: 'application/json',
      success : function(response) {
        console.log("success");
        window.location.assign(location.href);
      },
      error : function(response) {
        console.log("fail");
      }
    });
  });
});

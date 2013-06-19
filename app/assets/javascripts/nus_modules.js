$(function() {
  $tags = $(".module-tags");
        console.log($tags);
	$(function() {
		var autoOpts = {
			minLength: 3,
			autoFocus: true,
			source: $('#search').data('autocomplete-source'),
      select: function(evt,ui){
        // Create a such item
        $closeTag = $("<a></a>"); $closeTag.html("x"); $closeTag.addClass("close needToolTip unfollow"); 
        $closeTag.attr("title","Unfollow");
        $mInfo = $("<a></a>"); $mInfo.html(ui.item.value);
        $mTag = $("<span></span>"); $mTag.addClass("module-tag needToolTip");
        $mTag.attr("title","Module Title Stub");
        
        $mInfo.appendTo($mTag); $closeTag.appendTo($mTag);
        $mTag.appendTo($tags);
        console.log($tags);

        // TODO: callback to update DB that module has been followed
        
        // Clear the box
        console.log(evt);
        evt.preventDefault(); $(evt.target).val("");
        updateUI();
      }
		};
		$('#search').autocomplete(autoOpts)
	});
});

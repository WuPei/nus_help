//= require jquery.Jcrop

function update_crop(coords){
  var rx = 100/coords.w;
  var ry = 100/coords.h;

/*
  $("#preview").css(
    width: Math.round(rx * <%= %>
  );
*/
  
  $("#crop_x").val(coords.x);
  $("#crop_y").val(coords.y);
  $("#crop_w").val(coords.w);
  $("#crop_h").val(coords.h);
}

$(function(){
  $("#cropbox").Jcrop({
    onChange: update_crop,
    setSelect: [0, 0, 180, 180],
    aspectRatio: 1,
    minSize: [180,180]
  });
});


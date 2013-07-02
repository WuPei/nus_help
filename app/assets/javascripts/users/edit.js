//= require jquery.Jcrop

$(function(){
  console.log('clicked');
  $img = $("#cropbox");
  console.log($img);

  var sW = $img.width(),
      sH = $img.height(),
      img = $img[0],
      nW = img.naturalWidth,
      nH = img.naturalHeight,
      rW = nW / sW, // Width Ratio
      rH = nH / sH; // Height Ratio
  var prev = $('#preview');
  prev.attr("width",sW);
  prev.attr("height",sH);

  function update_crop(coords){
    $("#crop_x").val(coords.x * rW);
    $("#crop_y").val(coords.y * rH);
    $("#crop_w").val(coords.w * rW);
    $("#crop_h").val(coords.h * rH);

    prev.css({
      marginLeft: '-' + Math.round(coords.x) + 'px',
      marginTop: '-' + Math.round(coords.y) + 'px'
    });
  }

  $img.Jcrop({
    onChange: update_crop,
    setSelect: [0, 0, 180, 180],
    aspectRatio: 1,
    minSize: [180/rW,180/rH]
  });

});


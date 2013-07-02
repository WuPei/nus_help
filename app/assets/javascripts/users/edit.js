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

  function update_crop(coords){
    var aH = coords.h * rH;
    var aW = coords.w * rW;
    var aX = coords.x * rW;
    var aY = coords.y * rH;
    $("#crop_x").val(aX);
    $("#crop_y").val(aY);
    $("#crop_w").val(aW);
    $("#crop_h").val(aH);
    
    // coords.h is the # of pixels on the screen
    // (aH = coords.h * rH) is the actual # of pixels
    // This is the pic to be shown in the preview part
    // Height of preview part is 180px, needs to show that total # of px
    //    Thus: 180 / aH = pH / nH,  where iH is the height of image in preview
    //    (idea: (show pixel / actual pixel) is constant)
    // Thus pH = 180 / aH * nH = (180 / aH) * nH, where (180 / aH) begin the ratio
    var rpH = 180 / aH,  rpW = 180 / aW,
        pH = rpH * nH,   pW = rpW * nW, pX = rpW * aX, pY = rpH * aY;
    var ppW = Math.round(pW);
    console.log("pH = " + pH + ", ppW = " + ppW);
    prev.css({
      width:  ppW + "px",
      height: Math.round(pH) + "px",
      marginLeft: "-" + Math.round(pX) + 'px',
      marginTop: '-' + Math.round(pY) + 'px'
    });
    console.log(prev.css("width"));
    console.log(prev.css("height"));
  }

  $img.Jcrop({
    onChange: update_crop,
    setSelect: [0, 0, 180, 180],
    aspectRatio: 1,
    minSize: [180/rW,180/rH]
  });
});


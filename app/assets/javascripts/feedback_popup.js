$(function(){
  var fbCtrl = $("#feedback-popup-ctrl"),
      fbCont = $("#feedback-popup-content");

  // save current height
  function fbShow(){
    fbCont.animate({height:fbH});
    fbCont.attr("isO",1);
  }
  function fbHide(){
    fbCont.animate({height:0});
    fbCont.attr("isO","");
  }

  function fbToggle(){
    if(fbCont.attr("isO") == "1"){
      fbHide();
    } else{
      fbShow();
    }
  }

  var fbH = fbCont.height(); fbCont.height(0);
  fbCtrl.click(fbToggle);
});

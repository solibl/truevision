$( document ).ready(function() {
  $("#login-button").click(function () {
    $("#login-button").fadeOut("slow", function () {
      $("#login-container").fadeIn();
      TweenMax.from("#login-container", 0.4, { scale: 0, ease: Sine.easeInOut });
      TweenMax.to("#login-container", 0.4, { scale: 1, ease: Sine.easeInOut });
    });
  });

  $(".close-btn").click(function () {
    TweenMax.from("#login-container", 0.4, { scale: 1, ease: Sine.easeInOut });
    TweenMax.to("#login-container", 0.4, {
      left: "0px",
      scale: 0,
      ease: Sine.easeInOut
    });
    $("#login-container").fadeOut(800, function () {
      $("#login-button").fadeIn(800);
    });
  });
});
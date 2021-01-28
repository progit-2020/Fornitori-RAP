$elem = jQuery.root.find("%s");
if ($elem.length) {
  posErr = %d;
  $elem.validator({
    format: "%s",
    //'  invalidEmpty: false,
    correct: function(f,v) {
      $(f).siblings(".invalidFormatTip").remove();
    },
    error: function(f,v,err) {
      $(f).siblings(".invalidFormatTip").remove();
      $(f).after("<div class=\"invalidFormatTip\">" + err.message + "<\/div>");
    }
  });
  posErr = %d;
}
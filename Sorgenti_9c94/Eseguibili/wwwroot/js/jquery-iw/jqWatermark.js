try {
  /*#debug#
  var start = new Date().getTime();
  //#debug*/ 
  var comp = "%s";
  $elem = jQuery.root.find("#" + comp);
  posErr = 1;
  if ($elem.length) {
    posErr = 2;
    $elem.Watermark("%s");
  }

  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqWatermark [" + comp + "] - impostazione: " + (end - start) + " ms"); } catch(errore) {}
  //#debug*/ 
}
catch(e) {
  try { console.log("jqWatermark[" + comp + "]: " + e.message); } catch(err) {}
};
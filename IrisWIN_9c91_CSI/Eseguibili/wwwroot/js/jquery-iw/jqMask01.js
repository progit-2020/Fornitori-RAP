/**
  jqMask01.js

  Impostazioni specifiche per IrisWeb

  Utilizzato per formattazione e controllo di valori:
  - orari
*/
try {
  /*#debug#
  var start = new Date().getTime(); 
  //#debug#*/

  // valori orari
  posErr = 10;
  $elem = jQuery.root.find(".input_hour_hhmm");
  if ($elem.length) {
    $elem
      .mask("99.99")
      .validator({
        format: "time",
        correct: function(f,v) { validatorOk(f,v); },
        error: function(f,v,err) { validatorErr(f,v,err); }
      });
 }
  posErr = 11;
  $elem = jQuery.root.find(".input_hour_hhhmm");
  if ($elem.length) {
    $elem.mask("999.99");
  }
  posErr = 12;
  $elem = jQuery.root.find(".input_hour_hhhhmm");
  if ($elem.length) {
    $elem.mask("9999.99");
  }
  $elem = jQuery.root.find(".input_hour_hhhhmm2");
  if ($elem.length) {
    $elem.each(function(i,e)
      {
        if (!$(this).is('[readonly]'))
        {
          $(this).autoNumeric(HOUR_NUMBER_9999);
      }});
  }
  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqMask - impostazione edit mask irisweb: " + (end - start) + " ms"); } catch(errore) {}
  //#debug#*/
}
catch (err) {
  gestioneErrori(err.message + "|" + "jqMask" + "|" + posErr,"",0);
}
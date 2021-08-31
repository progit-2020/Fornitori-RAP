/**
  jqMask02.js

  Impostazioni specifiche per IrisCloud 

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
    $elem.each(function(i,e) 
      { 
        if (!$(this).is('[readonly]')) 
        { 
          $(this).autoNumeric(HOUR_NUMBER_99);
        }}); 
  }
  posErr = 11;
  $elem = jQuery.root.find(".input_hour_hhhmm");
  if ($elem.length) {
    $elem.each(function(i,e) 
      { 
        if (!$(this).is('[readonly]')) 
        { 
          $(this).autoNumeric(HOUR_NUMBER_999);
        }}); 
  }
  posErr = 12;
  $elem = jQuery.root.find(".input_hour_hhhhmm");
  if ($elem.length) {
    $elem.each(function(i,e) 
      { 
        if (!$(this).is('[readonly]')) 
        { 
          $(this).autoNumeric(HOUR_NUMBER_9999);
      }}); 
  }
  posErr = 13;
  $elem = jQuery.root.find(".input_hour_of_day");
  if ($elem.length) {
    $elem.each(function(i,e) 
      { 
        if (!$(this).is('[readonly]')) 
        { 
          $(this).autoNumeric(HOUR_OF_DAY_NUMBER)
                 .validator({
                    format: "time",
                    correct: function(f,v) { validatorOk(f,v); },
                    error: function(f,v,err) { validatorErr(f,v,err); }
                  });
        }}); 
  }
  
  posErr = 14;
  $elem = jQuery.root.find(".input_hour_hhmmss");
  if ($elem.length) {
    $elem.each(function(i,e) 
      { 
        if (!$(this).is('[readonly]')) 
        { 
          $(this).autoNumeric(HOUR_HHMMSS)
                 .validator({
                    format: "time_hhmmss",
                    correct: function(f,v) { validatorOk(f,v); },
                    error: function(f,v,err) { validatorErr(f,v,err); }
                  });
        }}); 
  }

  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqMask - impostazione edit mask iriscloud: " + (end - start) + " ms"); } catch(errore) {}
  //#debug#*/
}
catch (err) {
  gestioneErrori(err.message + "|" + "jqMask" + "|" + posErr,"",0);
}

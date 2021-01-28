/* jqCalendario */
try {
  var start = new Date().getTime();
  posErr = 0;

  // imposta datepicker formato dd/mm/yyyy
  $elem = jQuery.root.find(".input_data_dmy");
  if ($elem.length) {
    posErr = 1;
    $elem.datepicker(pickerOpts);
    posErr = 2;
  }

  // imposta datepicker formato mm/yyyy
  $elem = jQuery.root.find(".input_data_my");
  if ($elem.length) {
    posErr = 3;
    $elem.datepicker(pickerOptsMese);
    posErr = 4;
  }
  var end = new Date().getTime();

  /*#debug#
  try { console.log("jqCalendario - impostazione datepicker: " + (end - start) + " ms"); } catch(errore) {}
  #debug*/

  // gestione automatica del periodo dal - al
  // v. 1
  // utilizzare solo per elementi allo stesso livello del DOM (siblings)
  /*
  start = new Date().getTime();
  posErr = 10; 
  $elem = jQuery.root.find(".input_data_dmy.dal"); 
  posErr = 11; 
  if ($elem.length) {
    posErr = 12; 
    $elem.each(function(i) { 
      posErr = 15; 
      //'alert("[" + i + "] dal = " + $(this).attr("id"));
      // cerca l'input con la data fine
      var inputAl = $(this).nextAll(".input_data_dmy.al").eq(0); 
      posErr = 16; 
      if (inputAl != null) { 
        //'alert("[" + i + "] al = " + $(inputAl).attr("id"));
        posErr = 17; 
        var oldDate = $(this).val(); 
        // evento onSelect della data inizio: imposta i parametri della data fine
        $(this).datepicker("option", "onSelect", function( selectedDate ) {
          posErr = 18; 
          // se la data fine è vuota la imposta uguale alla data inizio
          var al = $(inputAl).val(); 
          if ((al == "") || (al == "__/__/____")) {
            $(inputAl).val(selectedDate);
          }
          $(inputAl).datepicker("option", "minDate", selectedDate);
        });
        $(this).val(oldDate); // server per ripristinare la data che altrimenti viene cancellata 
      }
    });
  }
  end = new Date().getTime();
  try { console.log("jqCalendario - periodo dal/al: " + (end - start) + " ms"); } catch(errore) {} 
  */

  // gestione automatica del periodo dal - al
  // versione 2: elementi con id fisso
  start = new Date().getTime();
  posErr = 20;
  var contaDalAl = 0;
  var $inputDal = jQuery.root.find("#EDTDAL");
  if ($inputDal.length) {
    posErr = 21;
    contaDalAl = $inputDal.length;
    var $inputAl = jQuery.root.find("#EDTAL");
    if ($inputAl.length) {
      posErr = 25;
      var oldDate = $inputDal.val(); 
      // evento onSelect della data inizio: imposta i parametri della data fine
      $inputDal.datepicker("option", "onSelect", function( selectedDate ) {
        posErr = 26; 
        // se la data fine è vuota la imposta uguale alla data inizio
        var al = $inputAl.val(); 
        if ((al == "") || (al == "__/__/____")) {
          posErr = 27;
          $inputAl.val(selectedDate);
        }
        posErr = 28;
        $inputAl.datepicker("option", "minDate", selectedDate);
      });
      $inputDal.val(oldDate); // serve per ripristinare la data che altrimenti viene cancellata 
    }
  }
  posErr = 30;
  var contaPeriodoDalAl = 0;
  var $inputPeriodoDal = jQuery.root.find("#EDTPERIODODAL");
  if ($inputPeriodoDal.length) {
    posErr = 21;
    contaPeriodoDalAl = $inputPeriodoDal.length;
    var $inputPeriodoAl = jQuery.root.find("#EDTPERIODOAL");
    if ($inputPeriodoAl.length) {
      posErr = 30;
      var oldDate = $inputPeriodoDal.val(); 
      $inputPeriodoDal.datepicker("option", "onSelect", function( selectedDate ) {
        posErr = 31; 
        var al = $inputPeriodoAl.val(); 
        if ((al == "") || (al == "__/__/____")) {
          posErr = 33;
          $inputPeriodoAl.val(selectedDate);
        }
        posErr = 34;
        $inputPeriodoAl.datepicker("option", "minDate", selectedDate);
      });
      $inputPeriodoDal.val(oldDate);
    }
  }
  end = new Date().getTime();
  /*#debug#
  try { console.log("jqCalendario - periodo dal/al: " + (end - start) + " ms (EDTDAL/AL: " + contaDalAl + ", EDTPERIODODAL/AL: " + contaPeriodoDalAl + ")"); } catch(errore) {} 
  #debug#*/

  // automatizza gestione periodo dal - al 
  // versione 3
  // utilizzabile per elementi non allo stesso livello del DOM (es in due tabelle diverse) 
  /*
  var start = new Date().getTime();
  posErr = 20; 
  $elem = jQuery.root.find(".input_data_dmy.al1,.input_data_dmy.al2"); 
  posErr = 21; 
  if ($elem.length) {
    $elem.focus(function() { 
      var inputDal = $(this).hasClass("al1")?$(".input_data_dmy.dal1"):$(".input_data_dmy.dal2");
      if (inputDal != null) {
        try {
          var al = $(this).val();
          if ((al == "") || (al == ''__/__/____'')) {
            var dal = $(inputDal).val(); 
            var d = Date.parse(dal); 
            if (d != null) { 
              $(this).val(dal);
            }
          }
        }
        catch(err) { 
        }
      }
    });
    posErr = 22; 
  }

  var end = new Date().getTime();
  try { console.log("jqCalendario - tempo esecuzione v2: " + (end - start)); } catch(errore) {}
  */
}
catch (err) {
  gestioneErrori(err.message + "|" + "jqCalendario" + "|" + posErr,"",0);
}

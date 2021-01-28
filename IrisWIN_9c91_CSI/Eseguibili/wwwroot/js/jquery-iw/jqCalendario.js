/* jqCalendario */
try {
  /*#debug#
  var start = new Date().getTime();
  //#debug*/ 
  posErr = 0;

  $( ".input_data_dmy" ).each(function( index ) {
    posErr = 1;
    var rdOnly=$(this).attr('readonly');
    if(!rdOnly)
      $(this).datepicker(pickerOpts);
    posErr = 2;
  });

  // imposta datepicker formato mm/yyyy
	$(".input_data_my").each(function( index ) {
    posErr = 7;
    var rdOnly=$(this).attr('readonly');
    if(!rdOnly)
      $(this).datepicker({
     		changeMonth: true,
     		changeYear: true,
     		dateFormat: 'mm/yy',
      	showButtonPanel: true,
        closeText: 'OK',
     		onClose: function(s,dp) {
        	var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        	var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        	if (iYear == 1899) {
            $(this).datepicker('setDate', null);
            }
          else {
        	  $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
        	  }
        	$(".ui-datepicker-calendar").hide();
        	$(this).change();
        	$(".ui-datepicker-calendar").hide();
     		},
     		beforeShow: function() {
       	if ((selDate = $(this).val()).length > 0) 
       	{
          var iYear = selDate.substring(selDate.length - 4, selDate.length);
          var iMonth = selDate.substring(0, 2);          
          $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth-1, 1));
          $(this).datepicker('setDate', new Date(iYear, iMonth-1, 1));
          $(".ui-datepicker-calendar").hide();
          return true;
       	}
    	}
  	});    
  });
    
  $('.input_data_my').keyup(function() {
      if( $(this).val().length == 7 ) 
      {  
        var _date = $(this).val();
        var iYear = _date.substring(_date.length - 4, _date.length);
        var iMonth = _date.substring(0, 2);
        $(this).datepicker('setDate', new Date(iYear, iMonth-1, 1));
      }
      /*Alberto: al momento non applicato. 
        Serve per annullare la data quando si lascia l'input vuoto evitando che vada a riassegnare la data del plugin
      if( $(this).val().length == 0) {
      	$(this).datepicker('setDate', new Date(1899, 11, 30));
      } 
      */
      $(".ui-datepicker-calendar").hide();
  });
  
  $(".input_data_my").click(function () {
  	  $(this).focus();      
  });
  
  $(".input_data_my").focus(function () {
  	  $(".ui-datepicker-calendar").detach();
      $(".ui-datepicker-calendar").hide();
      $("#ui-datepicker-div").position({
          //my: "center top",
          //at: "center bottom",
          my: "left top",
          at: "left bottom",
          of: $(this)
      });
  });
    
  posErr = 6;
  
  
  
  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqCalendario - impostazione datepicker: " + (end - start) + " ms"); } catch(errore) {}
  //#debug*/

  // gestione automatica del periodo dal - al con nomi di campi standard
  // i componenti input di inizio periodo sono identificati con css class "input_data_dmy dal"
  // i componenti di fine periodo sono identificati tra gli input con css class "input_data_dmy al"
  // sostituendo i pattern del nome di inizio periodo quali:
  // - DAL    -> AL
  // - DADATA -> ADATA
  // - DA     -> A
  // es. EDTDAL -> EDTAL
  /*#debug#
  start = new Date().getTime();
  //#debug*/
  
  posErr = 20;
  var contaDalAl = 0;

  // per ogni input inizio periodo valuta se esiste il corrispondente input di fine periodo
  jQuery.root.find(".input_data_dmy.dal").each(function() {
    // incrementa contatore
    contaDalAl++;

    // determina il nome del componente input di fine periodo
    posErr = 21;
    var nomeDal = $(this).attr("id").toUpperCase();
    var nomeAl = "";
    if (nomeDal.indexOf("DAL") >= 0) {
      nomeAl = nomeDal.replace("DAL", "AL");
    }
    else if (nomeDal.indexOf("DATADA") >= 0) {
      nomeAl = nomeDal.replace("DATADA","DATAA");
    }
    else if (nomeDal.indexOf("DADATA") >= 0) {
      nomeAl = nomeDal.replace("DADATA","ADATA");
    }
    else {
      nomeAl = nomeDal.replace("DA","A");
    }

    // estrae l'input di fine periodo corrispondente
    posErr = 22;
    var $inputAl = jQuery.root.find("#" + nomeAl + ".input_data_dmy.al");
    if ($inputAl.length) {
      posErr = 23;
      // salva la data di inizio originale
      var oldDate = $(this).val();

      // evento onSelect della data di inizio periodo: 
      // selezionando una data imposta i parametri della data fine
      $(this).datepicker("option", "onSelect", function(selectedDate) {
        posErr = 25; 

        // se la data fine è vuota la imposta uguale alla data inizio
        var al = $inputAl.val(); 
        if ((al == "") || (al == "__/__/____")) {
          posErr = 27;
          $inputAl.val(selectedDate);
        }
        posErr = 28;
        $inputAl.datepicker("option", "minDate", selectedDate);
      });

      // ripristina la data di inizio originale (che altrimenti viene cancellata)
      $(this).val(oldDate);
    }
  });

  /*#debug#
  end = new Date().getTime();
  try { console.log("jqCalendario - periodo dal/al: " + (end - start) + " ms (" + contaDalAl + " elementi)"); } catch(errore) {} 
  //#debug#*/

  // supporto al mousewheel sulle date
  /*#debug#
  start = new Date().getTime();
  //#debug*/
  /*
  jQuery.root.find(".input_data_dmy").bind("mousewheel", function(event, delta) {
    // determina incremento / decremento in base al valore di delta
    var deltaInc = delta > 0 ? 1 : -1;

    // incrementa o decrementa la data
    try {
      var d = Date.parse(this.value); 
      d.setDate(d.getDate() + deltaInc);
      this.value = d.toString('dd/MM/yyyy');

      // mantiene coerente la data sul datepicker
      $(this).datepicker('setDate',d);
    }
    catch (err) {}

    event.preventDefault();
    event.stopPropagation();
  });
  */

  /*#debug#
  end = new Date().getTime();
  //try { console.log("jqCalendario - supporto mouswheel su date: " + (end - start) + " ms"); } catch(errore) {} 
  //#debug#*/
}
catch (err) {
  gestioneErrori(err.message + "|" + "jqCalendario" + "|" + posErr,"",0);
}

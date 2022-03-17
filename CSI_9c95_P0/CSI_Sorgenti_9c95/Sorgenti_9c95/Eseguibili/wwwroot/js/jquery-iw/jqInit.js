/**
  jqInit 
*/

// variabili per debug
var posTag = "";
var posErr = 0;

// salva l'elemento radice nella proprietà root di jquery
jQuery.root = jQuery(document);


try {  
  // eliminazione del title ripetuto su tag <a> e <img> uno interno all'altro
  /*posTag = "img[title!='''']";
  var $elem = jQuery.root.find("img[title!='''']");
  if ($elem.length) {
    $elem.parent("a").attr("title","");
  }*/
  
  // rimozione dei div vuoti all'interno delle tabelle di navigazione (per una migliore presentazione grafica)
  posTag = "div.grigliaDatiNav";
  $elem = jQuery.root.find("div.grigliaDatiNav");
  if ($elem.length) {
    $elem.filter(function() { // filtra i div vuoti a meno di spazi
      return $.trim($(this).text()) == ""
    })
    .remove();
  }

  // inserimento del tag <thead> mancante nelle table
  // garantisce la correttezza sintattica delle tabelle per utilizzo di altri plugin  
  posTag = "div.grigliaDati > div.grid[summary] > table";
  var $elem = jQuery.root.find("div.grigliaDati > div.grid[summary] > table");
  if ($elem.length) {
    $elem.each(function(i,e) {
      var aggiungiTHead = true;
      // Sulle TmeIWGrid IW genera un tag <head> vuoto. Lo rimuoviamo se esiste.	  
	  $elemTHead=$(e).children("thead");
	  if ($elemTHead.length > 0){
		if ($($elemTHead[0]).children().length == 0)
          $elemTHead.remove();
	    else // se il tag non è vuoto è stato aggiunto volontariamente, in tal caso non aggiungiamo nulla.
		  aggiungiTHead = false;
	  }
	  if (aggiungiTHead){
	    $fr = $(e).find("tr:first");
		if ($fr) {
		  $(e).prepend(
		    $("<thead><\/thead>").append($fr.remove())
		  );		  
		}
	  }
    });
  }

  // taborder automatico
  posTag = ":input, :radio, :checkbox, a, div";
  jQuery.root.find(":input, :radio, :checkbox, a, div").each(function(i,e) {
    $(e).removeAttr("tabindex");
  });
  posTag = ":input:visible, :radio:visible, :checkbox:visible, a:visible";
  jQuery.root.find(":input:visible, :radio:visible, :checkbox:visible, a:visible").not('.noTabOrder').each(function(i,e) {
    $(e).attr("tabindex", i + 1);
  });

  posTag = ":input[readonly]";
  $elem = jQuery.root.find(":input[readonly]")
  if ($elem.length) { 
    $elem.each(function(i,e) { if ($(this).hasClass("noDisabled")) $(this).removeAttr("disabled"); }); 
   };
/*
  posTag = "select";
  $elem = jQuery.root.find("select")
  if ($elem.length) {
    $elem.each(function(i,e) { if ($(this).hasClass("noDisabled")){ $(this).removeAttr("disabled");  $(this).on('focus mousedown', function(e) { if ($.browser.webkit||$.browser.msie) { e.preventDefault(); }else{ this.blur(); window.focus();} });  }});
   };
*/
  // impostazioni calendario - italiano
  posTag = "datepicker.regional['it']";
  $.datepicker.regional['it'] = {
    closeText: 'Chiudi',
    prevText: '&#x3c;&#x3c; Mese prec.',
    nextText: 'Mese succ. &#x3e;&#x3e;',
    currentText: 'Oggi',
    monthNames: ['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'],
    monthNamesShort: ['Gen','Feb','Mar','Apr','Mag','Giu','Lug','Ago','Set','Ott','Nov','Dic'],
    dayNames: ['Domenica','Luned&#236','Marted&#236','Mercoled&#236','Gioved&#236','Venerd&#236','Sabato'],
    dayNamesShort: ['Dom','Lun','Mar','Mer','Gio','Ven','Sab'],
    dayNamesMin: ['Do','Lu','Ma','Me','Gi','Ve','Sa'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };

  // impostazioni calendario - inglese
  posTag = "datepicker.regional['en-GB']";
  $.datepicker.regional['en-GB'] = {
    closeText: 'Done',
    prevText: '&#x3c;&#x3c; Prev',
    nextText: 'Next &#x3e;&#x3e;',
    currentText: 'Today',
    monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
    monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
    dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
    dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
    dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
    weekHeader: 'Wk',
    dateFormat: 'dd/mm/yy',
    firstDay: 7,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };

}
catch (err) {
  gestioneErrori(err.message + "|" + "jqInit" + "|" + posTag,"",0);
}

/* jqAccordion */
try {
  $elem = jQuery.root.find(".accordion"); 
  if ($elem.length) { 
    $elem.accordion();
  }

  $elem = jQuery.root.find(".accordion_saveState"); 
  if ($elem.length) {
    $elem.each(function(i,e) {
      var cName = "medp" + e.id + "_idx";
      $(e).accordion({
        heightStyle: "content",
        clearStyle: true,
        collapsible: true,
        activate: function (event, ui) {
          /* -1 se nessuno aperto, oppure >=0 */
          $.cookie(cName, ui.newHeader.index(), { expires: 2, path: "/" });
        },
        active: ($.cookie(cName) == null) ? 0 : ($.cookie(cName) == "-1") ? false : parseInt($.cookie(cName))
      });
    });
  }
}
catch (err) { 
  gestioneErrori(err.message + "|" + "jqAccordion" + "|0","",0); 
}


/* jqAutocomplete */
try {
  posErr = 0; 
  $elem = jQuery.root.find("select.combobox:not([disabled])"); 
  posErr = 1; 
  if ($elem.length) { 
    posErr = 2; 
    $elem.wrap("<div class=\"ui-widget\"><\/div>").combobox(); 
    posErr = 3; 
  } 
} 
catch (err) { 
  gestioneErrori(err.message + "|" + "jqAutocomplete" + "|" + posErr,"",0); 
}
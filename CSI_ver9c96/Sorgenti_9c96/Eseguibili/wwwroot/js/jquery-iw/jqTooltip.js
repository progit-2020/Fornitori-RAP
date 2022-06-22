/* jqTooltip */
try { 
  /*#debug#
  var start = new Date().getTime(); 
  //#debug#*/

  // generico
  posTag = ".tooltipHtml";
  $elem = jQuery.root.find(".tooltipHtml"); 
  if ($elem.length) { 
    posErr = 2;
    $elem.tooltip({ 
      //relative: true,              // posizione relativa all'elemento parent (true dà problemi con i message dialog!!!)
      effect: "fade",                // effetto "fade"
      fadeOutSpeed: 100,             // dissolvenza simile al default del browser
      predelay: 200,                 // ms prima della visualizzazione
      delay: 0                       // nessun ritardo sul mouseout
    }).dynamic({                     // comportamento dinamico
      left: { direction: "left" }, 
      right: { direction: "right" } 
    });
  } 
  /*#debug#
  var end = new Date().getTime(); 
  try { console.log("jqTooltip - generico: " + (end - start) + " ms"); } catch(errore) {} 
  //#debug#*/
  
  // immagini accesso rapido
  /*#debug#
  start = new Date().getTime(); 
  //#debug#*/
  posTag = "#int_sez3 img";
  $elem = jQuery.root.find("#int_sez3 img"); 
  if ($elem.length) { 
    posErr = 11;
    $elem.tooltip({
      tipClass: "tooltip_icone",
      position: "bottom center",
      offset: [10, 0],
      effect: "fade",                  // effetto "fade"
      fadeOutSpeed: 100,               // dissolvenza simile al default del browser
      predelay: 100,                   // ms prima della visualizzazione
      delay: 0                         // nessun ritardo sul mouseout
    });
  }
  /*#debug#
  end = new Date().getTime(); 
  try { console.log("jqTooltip - immagini: " + (end - start) + " ms"); } catch(errore) {} 
  //#debug#*/
  
  // history
  /*#debug#
  start = new Date().getTime(); 
  //#debug#*/
  posTag = ".tooltipHistory";
  $elem = jQuery.root.find(".tooltipHistory"); 
  if ($elem.length) { 
    posErr = 11;
    $elem.tooltip({
      tipClass: "tooltip_history",
      position: "bottom center",
      offset: [15, 30],
      effect: "toggle",
      fadeOutSpeed: 0,
      predelay: 0,
      delay: 0
    });
  }
  /*#debug#
  end = new Date().getTime(); 
  try { console.log("jqTooltip - history: " + (end - start) + " ms"); } catch(errore) {} 
  //#debug#*/
  
  // login
  /*#debug#
  start = new Date().getTime(); 
  //#debug#*/
  posTag = "#login";
  $elem = jQuery.root.find("#login"); 
  if ($elem.length) { 
    posErr = 21;
    $elem.tooltip({
      tip: "#loginTooltip",
      position: "bottom center",
      offset: [5, 0],
      effect: "fade",
      fadeOutSpeed: 100,
      predelay: 200,
      delay: 0
    });
  }
  /*#debug#
  end = new Date().getTime(); 
  try { console.log("jqTooltip - login: " + (end - start) + " ms"); } catch(errore) {} 
  //#debug#*/
} 
catch (err) {
  gestioneErrori(err.message + "|" + "jqTooltip" + "|" + posTag,"",0);
}

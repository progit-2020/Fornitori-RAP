/* jqContextMenu */
try {
  /*#debug#
  var start = new Date().getTime();
  //#debug#*/
  var comp = "%s";
  $elem = jQuery.root.find("#" + comp);
  posErr = 1;
  if ($elem.length) {
    posErr = 2;
    $elem.contextMenu({
      menu: "%s"
    },
    function(action, el, pos) {
      // 1. versione con submit
      //SubmitClick("lnkContextMenu", action + "&" + $(el).attr("id"), true);
      // 2. versione async
      ShowBusy(true); // in caso di compiti lunghi visualizza la gif di attesa
      executeAjaxEvent("&azione=" + action + "&sender=" + $(el).attr("id"), null,"%s.OnContextMenuJs",false,null,false);
      return true;
    });
    posErr = 2;
  }
  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqContextMenu[" + comp + "] - impostazione: " + (end - start) + " ms"); } catch(errore) {}
  //#debug#*/
}
catch(e) {
  try { console.log("jqContextMenu[" + comp + "]: " + e.message); } catch(err) {}
}
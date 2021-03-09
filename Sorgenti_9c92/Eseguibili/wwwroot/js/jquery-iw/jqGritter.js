try {
  /*#debug#
  var start = new Date().getTime();
  //#debug*/ 

  $.gritter.add({
    title: "%s",
    text: "%s",
    image: "%s",
    sticky: %s,
    time: "%d",
    class_name: "%s"
  });

  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqGritter - impostazione: " + (end - start) + " ms"); } catch(errore) {}
  //#debug*/ 
}
catch(e) {
  try { console.log("jqGritter: " + e.message); } catch(err) {}
};
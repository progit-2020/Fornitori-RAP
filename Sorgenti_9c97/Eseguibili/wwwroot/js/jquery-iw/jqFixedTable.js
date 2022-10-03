/* jqFixedTable */
/*
if GetBrowser is TInternetExplorer then
            Code:=Format('var h%s = "100%%"; ',[NomeComp])
          else
            Code:=Format('var h%s = $("#%s").outerHeight(); ' +
                         'h%s = h%s * 1.15 + 15; ',
                         [NomeComp,NomeComp,NomeComp,NomeComp]);
*/
try {
  /*#debug#
  var start = new Date().getTime();
  //#debug#*/
  var comp = "%s";

  $("#TBL" + comp).fixedHeaderTable({
    height: $("#" + comp).outerHeight() * 1.15 + 15,
    // width: "100%",
    fixedColumns: %d
    //altClass: 'odd'
    //,themeClass: 'fancyTable'
  });

  
  $("#TBL%s").fixedTable({
    width: $("#" + comp).outerWidth(),
    height: $("#" + comp).outerHeight() * 1.15 + 15,
    fixedColumns: %d,
    classHeader: "fixedHead",
    classFooter: "fixedFoot",
    classColumn: "fixedColumn",
    fixedColumnWidth: 200,
    outerId: "TBL" + comp,
    Contentbackcolor: "#FFFFFF",
    Contenthovercolor: "#99CCFF",
    fixedColumnbackcolor:"#187BAF",
    fixedColumnhovercolor:"#99CCFF"
  });
  
  /*#debug#
  var end = new Date().getTime();
  try { console.log("jqFixedTable[" + comp + "] - impostazione: " + (end - start) + " ms"); } catch(errore) {}
  //#debug#*/
}
catch(e) { ' +
  try { console.log("jqFixedTable[" + comp + "]: " + e.message); } catch(err) {}
}
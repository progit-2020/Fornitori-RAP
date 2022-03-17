function IsAnnoBisestile(intYear) {
  if (intYear % 100 == 0) {
    if (intYear % 400 == 0) { 
      return true; 
    }
  }
  else {
    if ((intYear % 4) == 0) { 
      return true; 
    }
  }
  return false;
}

function trim(str) {
  //return str.replace(/^\s+|\s+$/g,"");
  // la replace sottostante considera anche gli spazi &nbsp;
  return str.replace(/(^[\s\xA0]+|[\s\xA0]+$)/g, '');
}

function checkKeyCode(objEvent) {
  var cod;
  if (window.event) {
    // IE
    cod = objEvent.keyCode;
  } else if(objEvent.which) {
    // Netscape/Firefox/Opera
    cod = objEvent.which;
  }
  return cod;
}

//Opzioni calendario jQuery
/*
  defaultDate:     ["+nn"]
                   ["-nn"]
                   ["+2"]

  minDate:         ["+nn"]
                   ["-nn"]
                   ["+5"]

  showOtherMonths: [true]
                   [false]

  showAnim:   ["fadeIn"]
              [""]

  dateFormat: 
    Formato della data
    Valori ammessi:  ["dd/mm/yy"] 
                     ["mm/yy"] 

  constrainInput
    Obbliga l'utente a digitare la data nel formato definito in "dateFormat"
    Valori ammessi:  [true]
                     [false]

  changeMonth
    Consente aggiunta di combobox per selezione mese
    Valori ammessi:  [true]
                     [false]

  changeYear
    Consente aggiunta di combobox per selezione anno
    Valori ammessi:  [true]
                     [false]
*/

var pickerOpts = {
  showOtherMonths: true,
  showAnim: "",
  changeMonth: false,
  changeYear: false
};

var pickerOptsMese = {
  showOtherMonths: false,
  dateFormat: "mm/yy",
  showAnim: "",
  changeMonth: false,
  changeYear: false
};

function gestioneErrori(msg,url,lineNum) { 
  // gestione generica del messaggio: visualizzazione di un alert
  var msgErr = "Attenzione: si e verificato un errore nella pagina.\r\n\r\n";

  // stringa di errore nel formato:
  //   [testo_errore | nome_funzione | checkpoint numerico ]
  // oppure semplicemente
  //   [testo_errore]
  var errArr = msg.split("|");
  if (errArr.length != 3) {
    // errore normale
    var msgL = msg.toLowerCase();

    // array associativo per gestione errori noti
    // sintassi
    //   "messaggio" : "livello_eccezione"
    // valori
    //   messaggio         = parte del testo del messaggio da considerare (in minuscolo!)
    //   livello_eccezione = 0: silenziosa
    //                       1: messaggio di alert
    var arrMsg = { 
      "iwrelease is not a function" : "0",                          // IW: causa sconosciuta
      "impossibile spostare lo stato attivo sul controllo" : "0",   // IE: se ActiveControl è nascosto / inesistente dà errore
      "ieeventhandlers[...].length" : "0",                          // IE: causa sconosciuta (commistione script jquery - calendario forse)
      "metodo non supportato": "1"                                  // IE: causa sconosciuta
      //"'elements' è nullo o non è un oggetto": "0"                  //
    }

    // ciclo su messaggi dell'array per gestione specifica
    for (var key in arrMsg) {
      if (msgL.indexOf(key) >= 0) {
        var azione = arrMsg[key];
        if (azione == "0") {
          // errore silenzioso
          return true;
        }
        else if (azione == "1") {
          // messaggio di alert
          msgErr += "Errore: " + msg + "\r\n";
          alert(msgErr);
          return true;
        }
      }
    }

    // rilancia l'eccezione
    throw msg;
  }
  else {
    // errore generato con sintassi specifica
    msgErr += "Funzione: " + errArr[1] + "\r\n";
    msgErr += "Errore: " + errArr[0] + "\r\n";
    msgErr += "Posizione: " + errArr[2] + "\r\n";
    //msgErr += "URL: " + url + "\r\n";
    //msgErr += "Linea: " + lineNum + "\r\n";
  }

  // alert del messaggio
  msgErr += "\r\nFare click su OK per continuare.\r\n";
  alert(msgErr);

  // richiama funzione delphi per salvare messaggio su db
  // non utilizzato per bug intraweb (access violation con combinazioni di componenti)
  try {
    executeAjaxEvent("&err=" + msg,null,"OnJsErroreJs",false,null,false);
  }
  catch(err) {
  }
  return true;
}

function preloadImgFisse() {
  if (document.images) {
    // oggetto immagine
    var imageObj = new Image();

    // imposta array di immagini da precaricare
    var images = new Array();
    var i = 0;
    images[i++]="img/logo_irisweb.png";
    images[i++]="img/chiudi.png";
    images[i++]="img/chiudi_sel.png";
    images[i++]="img/error.png";
    images[i++]="img/information.png";
    images[i++]="img/warning.png";
    images[i++]="img/btnPrimo.png";
    images[i++]="img/btnPrimo_Disabled.png";
    images[i++]="img/btnPrecedente.png";
    images[i++]="img/btnPrecedente_Disabled.png";
    images[i++]="img/btnSuccessivo.png";
    images[i++]="img/btnSuccessivo_Disabled.png";
    images[i++]="img/btnUltimo.png";
    images[i++]="img/btnUltimo_Disabled.png";
    images[i++]="img/btnInserisci2.png";
    images[i++]="img/btnModifica2.png";
    images[i++]="img/btnElimina2.png";
    images[i++]="img/btnConferma2.png";
    images[i++]="img/btnAnnulla2.png";
    images[i++]="img/btnStampa22.png";
    images[i++]="img/btnSalvaFloppy2.png";
    images[i++]="img/btnDefinisci2.png";
    images[i++]="img/btnRevoca2.png";
    images[i++]="img/btnCancPeriodo.png";
    images[i++]="img/btnAggiorna2.png";
    images[i++]="img/btnSchedaAnagrafica2.png";
    images[i++]="img/btnCambiaDatoGriglia.png";
    images[i++]="img/btnCopia2.png";
    images[i++]="img/btnConteggi2.png";
    images[i++]="img/btnElenco2.png";
    images[i++]="img/btnElenco2Highlight.png";
    images[i++]="img/btnAttachment2.png";
    images[i++]="img/btnAttachment2Highlight.png";
    images[i++]="img/btnAttachment2Obblig.png";
    images[i++]="img/btnAccedi2.png";
    images[i++]="img/btnC700SelezioneAnagrafe2.png";
    images[i++]="img/mail-icon.png";
    images[i++]="img/mail-icon-ok.png";
    // selezione anagrafica
    images[i++]="img/btnApri.png";
    images[i++]="img/btnSalva.png";
    images[i++]="img/btnElimina.png";
    images[i++]="img/btnEseguiSelezione.png";
    images[i++]="img/btnAnnota.png";
    images[i++]="img/btnElimina.png";
    images[i++]="img/btnAnnullaSelezione.png";
    // icone file
    images[i++]="img/ico_oth.png";
    images[i++]="img/ico_avi.png";
    images[i++]="img/ico_bmp.png";
    images[i++]="img/ico_doc.png";
    images[i++]="img/ico_gif.png";
    images[i++]="img/ico_html.png";
    images[i++]="img/ico_jpg.png";
    images[i++]="img/ico_pdf.png";
    images[i++]="img/ico_ppt.png";
    images[i++]="img/ico_txt.png";
    images[i++]="img/ico_xls.png";
    images[i++]="img/ico_zip.png";
    // icone treeview
    images[i++]="img/folder_closed.png";
    images[i++]="img/folder_open.png";

    // preloading
    for (i = 0; i < images.length; i++) {
      imageObj.src = images[i];
    }
  }
}

// precarica le immagini legate a iriscloud presenti in (quasi) tutte le form
function preloadImgFisse_IrisCloud() {
  if (document.images) {
    // oggetto immagine
    var imageObj = new Image();

    // imposta array di immagini da precaricare
    var images = new Array();
    var i = 0;
    // C700
    images[i++]="img/logo_iriscloud.png";
    images[i++]="img/btnC700SelezioneAnagrafe.png";
    images[i++]="img/btnC700SelezioneAnagrafe_Disabled.png";
    images[i++]="img/btnC700Aggiorna.png";
    images[i++]="img/btnC700Aggiorna_Disabled.png";
    images[i++]="img/btnC700Cerca.png";
    images[i++]="img/btnC700Cerca_Disabled.png";
    images[i++]="img/btnC700Primo.png";
    images[i++]="img/btnC700Primo_Disabled.png";
    images[i++]="img/btnC700Precedente.png";
    images[i++]="img/btnC700Precedente_Disabled.png";
    images[i++]="img/btnC700Successivo.png";
    images[i++]="img/btnC700Successivo_Disabled.png";
    images[i++]="img/btnC700Ultimo.png";
    images[i++]="img/btnC700Ultimo_Disabled.png";

    // preloading
    for (i = 0; i < images.length; i++) {
      imageObj.src = images[i];
    }
  }
}

function preloadImgVar(images) {
  if (document.images) {
    var i = 0;
    var imageArray = new Array();
    imageArray = images.split(',');
    var imageObj = new Image();
    for (i = 0; i <= imageArray.length - 1; i++) {
      //document.write('<img src="' + imageArray[i] + '" />'); // debug
      imageObj.src = imageArray[i];
    }
  }
}

function onscrollWR010()
//registra lo scroll attuale della pagina nei campi previsti per questa gestione
{
  var scrolltop = document.getElementById("HIDDEN_WR010SCROLLTOP");
  var scrollleft = document.getElementById("HIDDEN_WR010SCROLLLEFT");
  scrollleft.value = window.pageXOffset;
  scrolltop.value = window.pageYOffset;
}

function onscrollDivWR010(div,namescrolltop,namescrollleft)
//registra lo scroll attuale del div nei campi indicati dal chiamante
{
  var scrolltop = document.getElementById(namescrolltop);
  var scrollleft = document.getElementById(namescrollleft);
  scrolltop.value = div.scrollTop;
  scrollleft.value = div.scrollLeft;
}

function mostraDialogErrore(messaggioErrore, dettagliErrore, onCloseCallback, rispostaRemota){
  $("#txtAppError").html(messaggioErrore);
  $("#lblAppErrorDetails").html("Dettagli errore");
  $("#txtAppErrorDetails").text("");  
  
  var pulsantiDialog = [];  
  if (dettagliErrore){
	$("#txtAppErrorDetails").text(dettagliErrore);
	pulsantiDialog.push({
      id: "btn-dettagli",
      text: "Dettagli",
      "class": "pulsante", // per bug di YUI Compressor
      click: function() {
        $("#bugReport").toggle();
      }
    });   
  }  
  pulsantiDialog.push({
	text: "OK",
	"class": "pulsante", // per bug di YUI Compressor
	click: function() {
	  $(this).dialog("close");
	  $("#txtAppError").html("");
	  $("#lblAppErrorDetails").html("");
	  $("#txtAppErrorDetails").html("");	  
	  if (onCloseCallback){
	    onCloseCallback(rispostaRemota);
	  }
	}
  });

  $("#dlgAppError").dialog({
    modal: true,
    height: "auto",
	width: 400,
	closeOnEscape: false,
	open: function(event, ui) {                              
	  $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
	}, 
	buttons: pulsantiDialog
  });
    
}

function medpunload(){	 	
	data = "GAppID="+GAppID;
	url = GURLBase+"MEDPendsession";
	if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )){ //IF IE > 10    
		if(window.XMLHttpRequest){
		var xmlhttp = new XMLHttpRequest();
		}else{
		var xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		};
		if(xmlhttp != null){
		xmlhttp.open("POST", url, false);
		xmlhttp.send(data);
		};		      
	}else{ //ALTRI BROWSER
		navigator.sendBeacon(url, data);
	}		
}
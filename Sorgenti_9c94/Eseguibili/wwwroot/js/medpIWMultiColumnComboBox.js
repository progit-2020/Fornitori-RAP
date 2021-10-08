function MEShowLookUp(event,obj)
{
  obj.DoSubmit = false;
  var isIE = navigator.appName.indexOf("Microsoft") != -1;
  var key;
  if (event == null) 
    key = null; 
  else
  {
    if (isIE) {key = event.keyCode;} else {key = event.which;}
    obj.ItemIndex = -1;
    obj.SelectedRow = -1;
  }
  
  if ( ((key == 40) || (key == 38) || (key == 13) || (key == 33) || (key == 34) || (key == 35) || (key == 36))) {
  }
  else {
    MEHighLightSelected(obj);     
  }
}

function MEDocMouseUp(obj) 
{
  if (obj.DoHide == 0) 
  {
    document.getElementById(obj.ID + "popup").scrollTop = 0;
    document.getElementById(obj.ID + "checklist").style.display = "none";
    document.onmouseup = "";
  } 
  else {
    obj.DoHide = 0;
  }  
}


function MEHidediv(obj) 
{
  document.getElementById(obj.ID + "popup").scrollTop = 0;
  document.getElementById(obj.ID + "checklist").style.display  = "none";    
  MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);
  obj.HighLightedRow = -1;
}

function MEShowdiv(obj) 
{
  var tbl = document.getElementById(obj.ID +"tbl");
  var checklist = document.getElementById(obj.ID +"checklist");

  tbl.style.borderCollapse = "collapse";
  
  if (checklist.style.display == "none")
  {
    if (parseInt(obj.HighLightedRow) != -1)
      MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);

    checklist.style.display = "";

    MEHighLightSelected(obj);
    MEGetPositionDiv(obj);

    var myInput = document.getElementById(obj.ID);
    if (!myInput.disabled) 
      myInput.focus();
  }
}

function MEGetPositionDiv(obj) 
{
  var elemTx=document.getElementById(obj.ID);
  var txWidth=elemTx.offsetWidth; 
  var txHeight=elemTx.offsetHeight; 
  var tdiv=txHeight;
  var ldiv=0;
  var chWidth=0;
  var chHeight=0;
  var corrL=0;
  var corrT=0;
  do { 
    ldiv += (elemTx.offsetLeft - elemTx.scrollLeft);
    tdiv += (elemTx.offsetTop - elemTx.scrollTop);
    corrL = elemTx.scrollLeft;
    corrT = elemTx.scrollTop; 
  } 
  while ((elemTx = elemTx.offsetParent)); 
  //Chrome restituisce scrolltop anche dell ultimo elemento della catena mentre gli altri browser no
  //percio aggiungo ultimo valore sottratto
  ldiv += corrL;
  tdiv += corrT;

  var elemTx = document.getElementById(obj.ID);
  var elemBt = document.getElementById(obj.ID + "button");
  var elemCh = document.getElementById(obj.ID + "checklist");
  //bisogna subito fare appendchild altrimenti chHeight non considera max-height impostata
  document.body.appendChild(elemCh); 
  elemCh.style.left=ldiv+ "px";  
  elemCh.style.top=tdiv + "px"; 
  //determina min-width del div contenente gli elementi: larghezza(input + button) - un fattore di correzione
  var tmpMinWidth = (elemTx.offsetWidth + elemBt.offsetWidth - 6);
  tmpMinWidth = (tmpMinWidth < 0) ? 0 : tmpMinWidth;
  elemCh.style.minWidth = tmpMinWidth + "px"; 

  if (elemCh.style.display == "") 
  {
    chWidth=elemCh.offsetWidth;
    chHeight=elemCh.offsetHeight;
  } 
  else {
    elemCh.style.display = ""; 
    chWidth=elemCh.offsetWidth; 
    chHeight=elemCh.offsetHeight;
    elemCh.style.display = "none"; 
  } 


  if ( ( ldiv + chWidth) > document.body.clientWidth && ldiv > chWidth) 
  { 
  	ldiv=ldiv-(chWidth-txWidth); 
  } 
  if ( ( tdiv + chHeight) > document.body.clientHeight && tdiv > chHeight) 
  { 
  	tdiv=tdiv-(chHeight+txHeight); 
  } 
  elemCh.style.left=ldiv+ "px";  
  elemCh.style.top=tdiv + "px"; 

}

function MEShowUnHighLighted(idx,obj)
{

  el = document.getElementById(obj.ID + "R" + idx);
  if (el != null) el.className="medpMCRowUnSelected";
  if (idx == parseInt(obj.HighLightedRow)) obj.HighLightedRow = -1;
}

function MEShowHighLighted(idx,obj)
{
  if (parseInt(obj.HighLightedRow) != -1)
    MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);

  el = document.getElementById(obj.ID + "R" + idx);
  if (el != null) 
  {
    obj.HighLightedRow = parseInt(idx);
    el.className="medpMCRowSelected";
  }
  MEShowdiv(obj);
}

//reperisce itemIndex dell'elemento in base al valore digitato. 
//verifica per stringa parziale sulla colonna di lookup
function MEItemIndexHighLight(obj,key,Col)
{
 var count = obj.RCount;
 var i = 0;
 var high = count-1;
 var ItemIndex = -1;
 var valRow;
 while(i <= high)
 {
   valRow = document.getElementById(obj.ID +"R" + i + "C" + Col);
 	 var vr = valRow.textContent || valRow.innerText;
   //if (key.toUpperCase() == vr.toUpperCase().substring(0,key.length))
   if (obj.DoCase)
     {
       //Controllo lookup case sensitive
       if (key == vr.substring(0,key.length))
         {
           ItemIndex = i;
           break;
         }
     }
   else
     {
       //Controllo lookup NO case sensitive
       if (key.toUpperCase() == vr.toUpperCase().substring(0,key.length))
         {
           ItemIndex = i;
           break;
         }
     }
  i++;
 }
 return ItemIndex;
}

function MEDoChange(obj, val)
{
  if (obj.PostedText != val ) 
  {
    obj.PostedText = val;   
  
    AddChangedControl(obj.ID);

    if (obj.OnChange) 
    {
      return SubmitClickConfirm(obj.ID, obj.ItemIndex, true,'');
    }
    else if (obj.OnAsyncChange) 
    {
      processAjaxEvent("onChange", obj.IWCLName, obj.ID + '.' + 'DoAsyncChange' , true, null, true);
    }
  }
}

function MEChangeEditValue(obj,index)
{
 obj.usedKeyb= false;

  if (index != -1) 
  {
    var fullid = obj.ID + "R" + index + "C" + obj.CodeColumn;
    
    var newval = document.getElementById(fullid).textContent || document.getElementById(fullid).innerText;

    document.getElementById(obj.ID).value = newval;
    obj.ItemIndex = index;

    document.getElementById(obj.ID + "_INPUT").value = index + "~" + newval;
    MEHidediv(obj);

    //se cambio testo e poi seleziono da lista si scatenano eventi change i input e changeEditValue
    // salvo il valore postato e non rieseguo se il valore uguale
    MEDoChange(obj,newval);   
  }
}
//se digitato un valore presente nella lista, imposta itemindex correttamente. verifica per codice esatto
function MEItemIndexText(obj,key,Col)
{
 var count = obj.RCount;
 var i = 0;
 var high = count-1;
 var ItemIndex = -1;
 var valRow;
 while(i <= high)
 {
   valRow = document.getElementById(obj.ID +"R" + i + "C" + Col);
 	 var vr = valRow.textContent || valRow.innerText;
   if (key.toUpperCase() == vr.toUpperCase())
   {
     ItemIndex = i;
     break;
   } 
  i++;
 }
 return ItemIndex;
}

function MEBlur(obj) 
{
  if (obj.DelayBlur){
    setTimeout(function(){METextChange(obj)},100);  
  }
  else
  {
    METextChange(obj);
  }
}

function METextChange(obj)
{
  if (obj.UsedKeyb) 
  {
    obj.UsedKeyb = false;
    var ctrl = document.getElementById(obj.ID);
    var i = MEItemIndexText(obj,ctrl.value,obj.CodeColumn); 
    if ( i == -1 && obj.LookupColumn != obj.CodeColumn) 
    {
      i = MEItemIndexText(obj,ctrl.value,obj.LookupColumn); 
    }
    obj.ItemIndex=i;
    var valRow='';	
    if (obj.ItemIndex != -1)
    {
      valRow = document.getElementById(obj.ID +"R" + i + "C" + obj.CodeColumn).textContent || document.getElementById(obj.ID +"R" + i + "C" + obj.CodeColumn).innerText;
      ctrl.value = valRow;	
    }
    else
    { 
      //se consento elemento non in lista accetto valore. altrimenti reset del valore inserito	
      if (obj.CustomElement) 
      {
	valRow = ctrl.value;	
      }		
      else
      {			
	valRow = '';
	ctrl.value = '';        
      }
    }  
    document.getElementById(obj.ID + "_INPUT").value = obj.ItemIndex+ "~" + valRow;

    MEDoChange(obj,ctrl.value);
  }   
}

function MESelectHighLighted(obj) 
{
  MEChangeEditValue(obj,parseInt(obj.HighLightedRow));
  obj.DoSubmit = true;
}

function MEKeypress(obj,event) 
{
  if (obj.Editable)
  {
    return MENoenter(obj,event);
  }	
  else
  {
    return false;
  }
}

function MEKeyup(event,LookupAfterChars,obj)
{
  if (obj.Editable)
  {
    var ctrl = document.getElementById(obj.ID);
    if(ctrl.value.length >= LookupAfterChars) 
    {
	MEShowLookUp(event,obj);
    }
  }
}

function MENoenter(obj,event) 
{
  var isIE = navigator.appName.indexOf("Microsoft") != -1;
  if (isIE) {key = event.keyCode;} else {key = event.which;}
  if (!obj.DoSubmit) 
    return !(event && key == 13); 
}

function MEKeyDown(event,obj)
{
  if (obj.Editable)
  {
    //verificare se si pu o usare al posto AddChangedControl
   if (!containsName(obj.ID)) 
   {
     window.ChangedControls += obj.ID + ",";
   }

   var isIE = navigator.appName.indexOf("Microsoft") != -1;
   obj.UsedKeyb = true;
   var key;
   if (isIE) {key = event.keyCode;} else {key = event.which;}

   if ((key == 40) || (key == 38) || (key == 13) || (key == 33) || (key == 34) || (key == 35) || (key == 36)) 
   {
     if (key == 40) {MEHighLightNext(obj,"");}               // down key
     else if (key == 38) {MEHighLightPrevious(obj,"");}      // up key
     else if (key == 33) {MEHighLightPrevious(obj,"pgup");} // pgup key
     else if (key == 34) {MEHighLightNext(obj,"pgdn");}   // pgdn key
     else if (key == 35) {MEHighLightNext(obj,"end");}    // end key
     else if (key == 36) {MEHighLightPrevious(obj,"home");}// home key
     else if (key == 13) {MESelectHighLighted(obj);}             // Enter key
   }
  }
}

function MEResetdoc(obj)
{
 obj.DoHide = 1; 
}

function MEHighLightNext(obj, special) 
{
  if (parseInt(obj.HighLightedRow) != -1)
  {
    elRow = document.getElementById(obj.ID +"R" + obj.HighLightedRow);
    rIndex = parseInt(obj.HighLightedRow);
    if (rIndex <= obj.RCount-1)
    {
      nexIndex = rIndex + 1;
      if (special == "pgdn")
        nexIndex = rIndex + 10;
      if ( (nexIndex > obj.RCount-1) || (special == "end") )
        nexIndex = obj.RCount-1;
      nexRow = obj.ID + "R" + nexIndex;
      elRow = document.getElementById(nexRow);
      while ((nexIndex <= obj.RCount) && (elRow.style.display != ""))
      {
        nexIndex = nexIndex + 1;
        nexRow = obj.ID  + "R" + nexIndex;
        elRow = document.getElementById(nexRow);
      }
      if ((nexIndex <= obj.RCount) && (elRow.style.display == ""))
      {
        MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);
        MEShowHighLighted(nexIndex,obj);

        var cell = document.getElementById(obj.ID+"popup");

        nexRow = obj.ID  + "R" + obj.HighLightedRow;
        elRow = document.getElementById(nexRow);

        if ( (obj.popupHeight + parseInt(cell.scrollTop) ) < (parseInt(elRow.offsetTop) + parseInt(elRow.offsetHeight)))
        {
          var rowh = parseInt(elRow.offsetHeight);
          if (special == "pgdn")
            rowh = rowh*10;
          cell.scrollTop = parseInt(cell.scrollTop) + rowh;
        }

        if (special == "end")
          cell.scrollTop = cell.scrollHeight;

      }
    }
  }
  else
  {
    MEHighLightSelected(obj);
  }
}

function MEHighLightPrevious(obj, special) 
{
  if (parseInt(obj.HighLightedRow) != -1)
  {
    elRow = document.getElementById(obj.ID + "R" + obj.HighLightedRow);
    var rIndex = parseInt(obj.HighLightedRow);
    if (rIndex > 0)
    {
      prevIndex = rIndex - 1;
      if (special == "pgup")
        prevIndex = rIndex - 10;
      if ( (prevIndex < 0) || (special == "home") )
        prevIndex = 0;
      prevRow = obj.ID + "R" + prevIndex;
      elRow = document.getElementById(prevRow);
      while ((prevIndex >= 1) && (elRow.style.display != ""))
      {
      	prevIndex = prevIndex - 1;
        prevRow = obj.ID + "R" + prevIndex;
        elRow = document.getElementById(prevRow);
      }
      if ((prevIndex >= 0) && (elRow.style.display == ""))
      {
        MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);
        MEShowHighLighted(prevIndex ,obj);

        var cell = document.getElementById(obj.ID+"popup");
        if (cell.scrollTop > parseInt(elRow.offsetTop))
        {
          var rowh = parseInt(elRow.offsetHeight);
          if (special == "pgup")
            rowh = rowh*10;
          cell.scrollTop = parseInt(cell.scrollTop) - rowh;

          if (cell.scrollTop < (elRow.offsetHeight*2))
            cell.scrollTop = 0;
        }

        if (special == "home")
          cell.scrollTop = 0;
      }
    }
  }

}

function MEHighLightSelected(obj)
{
  var editor = document.getElementById(obj.ID);
  var keyval = editor.value;
  if (obj.DoCase == false)
    keyval = keyval.toUpperCase();

  if ( (obj.ItemIndex >= 0) && (! obj.UsedKeyb))
    i = parseInt(obj.ItemIndex);
  else
  {
    i = MEItemIndexHighLight(obj,keyval,obj.CodeColumn); 
    if ( i == -1 && obj.LookupColumn != obj.CodeColumn) 
    {
      i = MEItemIndexHighLight(obj,keyval,obj.LookupColumn); 
    }
  }
  
  if (i != -1)
  {
    MEShowHighLighted(i ,obj);

    var elRow = document.getElementById(obj.ID + "R" + obj.HighLightedRow );
    var cell = document.getElementById(obj.ID + "popup");

    var rowh = parseInt(elRow.offsetTop);
    cell.scrollTop = rowh;
  }
  else
  {
    if (parseInt(obj.HighLightedRow) != -1)
      MEShowUnHighLighted(parseInt(obj.HighLightedRow),obj);
    MEShowdiv(obj);
  }
}
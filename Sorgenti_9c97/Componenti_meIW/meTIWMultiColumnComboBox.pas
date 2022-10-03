unit meTIWMultiColumnComboBox;

interface

uses
  SysUtils, IWCompEdit,Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl,  IWMultiColumnComboBox,
  IWHTMLTag, IWXMLTag, IWMarkupLanguageTag, IWColor, Graphics,
  Forms, Windows, IWTypes, IWCompButton,
  IWCompLabel, IWCompCheckbox, IWCompExtCtrls, IWCompListbox,
  IWCompRectangle, IWTMSBase, IWTMSImg, IWForm,Menus,IWRenderContext,IWScriptEvents;

type
  TmeTIWMultiColumnComboBox = class(TTIWMultiColumnComboBox)
  private
    FContextMenu: TPopupMenu;
    FAutoResetItems: Boolean;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    procedure HookEvents(AContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
    function RenderAsync(AContext: TIWBaseHTMLComponentContext): TIWXMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property medpAutoResetItems: Boolean read FAutoResetItems write FAutoResetItems;
  end;

implementation

uses
  ImgList, ShellAPI, CommCtrl,
  IWApplication, IWServerControllerBase,IWResourceStrings,
  IWAppForm, TypInfo
  , IWStrings, IW.Common.System
(*
  {$ELSE}
  , SWStrings, SWSystem
  {$ENDIF}
*)
  ;


constructor TmeTIWMultiColumnComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RenderSize:=False;
  Font.Enabled:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
  end;
  DropDownDisplay:=ddOnFocus;
  LookupMethod:=lmSelect;
  Css:='medpMultiColCmb';
  NonEditableAsLabel:=False;
  FAutoResetItems:=True;
end;

function TmeTIWMultiColumnComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeTIWMultiColumnComboBox.HookEvents(AContext: TIWPageContext40;
  AScriptEvents: TIWScriptEvents);
begin
  inherited;
  AScriptEvents.HookEvent('OnChange', HTMLName+'TextChange(); return true;');
end;

procedure TmeTIWMultiColumnComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

//{$IFDEF TMSIW6}
(*
function TmeTIWMultiColumnComboBox.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText:string;
  Index1:Integer;
  Index2:Integer;
  Temp, Part1, Part2, Part3:string;

  function addToShowDiv():string;
  begin

//Aggiunta gestione scrollLeft e scrollTop per region con scrollbar. IN TESTING
    Result:='function ' + HTMLName + 'showdiv(obj) { '+ #13#10 +
             ' var ldiv; var tdiv; var elemTx; var elemCh; var chWidth; var txWidth; var txHeight; var chHeight; ' + #13#10 +
             ' elemTx=document.getElementById("'+HTMLName+'"); ' + #13#10+
             ' txWidth=elemTx.offsetWidth; txHeight=elemTx.offsetHeight; tdiv=txHeight; ' + #13#10 +
             ' ldiv=elemTx.offsetLeft; ' + #13#10 +
             ' do { ldiv += (elemTx.offsetLeft-elemTx.scrollLeft ); tdiv += (elemTx.offsetTop - elemTx.scrollTop); } ' +#13#10 +
             ' while ((elemTx = elemTx.offsetParent)); ' + #13#10 +
             ' elemCh=document.getElementById("'+HTMLName+'checklist"); ' + #13#10 +
             ' if (elemCh.style.display == "") {' +
             ' chWidth=elemCh.offsetWidth;' +
             ' } ' +
             ' else {' +
             ' elemCh.style.display = ""; ' +
             ' chWidth=elemCh.offsetWidth; ' +
             ' chHeight=elemCh.offsetHeight; ' +
             ' elemCh.style.display = "none"; ' +
             '} '+ #13#10 +
             ' if ( ( ldiv + chWidth) > document.body.clientWidth && ldiv > chWidth) { ldiv=ldiv-(chWidth-txWidth); } '+ #13#10 +
             ' if ( ( tdiv + chHeight) > document.body.clientHeight && tdiv > chHeight) { tdiv=tdiv-(chHeight+txHeight); } '+ #13#10 +
             ' elemCh.style.left=ldiv+ "px";  elemCh.style.top=tdiv + "px"; '+ #13#10 +
             ' document.body.appendChild(elemCh); ';


  end;

begin

  Result:=inherited;

  HTMLText:=Result.Contents[0].Render;
  {*Caratto 1/8/2012
    il div di drop down non si posiziona correttamente nei frame.
    aggiunto come figlio di document e fatto in modo che compaia verso sx
    o in alto nel caso l'elenco elementi sforasse le dimensioni del document
  *}
   HTMLText:=Stringreplace(HTMLText,'function ' + HTMLName + 'showdiv(obj) {',addToShowDiv,[rfReplaceAll]);
  {*Caratto 2/8/2012
  Il Pulsante del dropdown non ha un id html. lo devo impostare perchè serve nel
  renderAsync poichè non cambia lo stato di enabled dei componenti negli eventi asincroni
  *}
  HTMLText:=Stringreplace(HTMLText,'<BUTTON', '<BUTTON id="'+ HTMLName + 'button"',[rfReplaceAll]);
  Index1:=Pos('id="' + HTMLName +'popup"',HTMLText);
  Temp:=Copy(HTMLText,Index1,Length(HTMLText) - Index1);
  Index2:=Pos('<table width="100%" style',Temp) + Index1;

  Part1:=Copy(HTMLText,0,Index1 - 1);
  Part2:=Copy(HTMLText,Index1,Index2 - Index1);

  //Part2:=Stringreplace(Part2,'style="overflow:auto;','style="overflow:auto;display:block;',[rfReplaceAll]);
  Part2:=Stringreplace(Part2,'style="overflow:auto;','style="overflow-x:scroll;overflow-y:auto;display:block;',[rfReplaceAll]);
  if PopUpHeight > 0 then
    Part2:=Stringreplace(Part2,'height:'+inttostr(PopUpHeight)+'px;','height:'+inttostr(PopUpHeight)+'em;',[rfReplaceAll]);
  if PopUpWidth > 0 then
    Part2:=Stringreplace(Part2,'width:'+inttostr(PopUpWidth)+'px;','width:'+inttostr(PopUpWidth)+'em;',[rfReplaceAll]);

  Part3:=Copy(HTMLText,Index2, Length(HTMLText));

  TIWTextElement(Result.Contents[0]).Text:=Part1 + Part2 + Part3;

end;
*)

(*
function TmeTIWMultiColumnComboBox.RenderAsync(AContext: TIWBaseHTMLComponentContext): TIWXMLTag;
var
  Disab : String;
begin
  //Caratto 4/10/2012
  //  Se la multicolumn è in una region non visibile viene richiamato comunque il render Async
  //  Esiste un bug per cui testa if (htmlname obj) ma l'oggetto non è definito e va in errore javascript.
  //  Ridefinisco la variabile in caso sia undefined


  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(' var '+ HTMLName +'obj =  typeof '+HTMLName +'obj === "undefined" ? null : ' + HTMLname +'obj; ' +#13#10);

  Result:=inherited;

  //Caratto 2/8/2012
  //  non cambia lo stato di enabled dei componenti negli eventi asincroni.
  //aggiunto abilitazione/disabilitazione della text e del pulsante

  if (Self.Enabled) and not (Self.ReadOnly) then
    Disab:='false'
  else
    Disab:='true';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA (' var el=document.getElementById("'+HTMLName+'"); if (el) {el.disabled='+ Disab +';} var elb=document.getElementById("'+HTMLName+'button"); if (elb) {elb.disabled='+ Disab +';} ');
end;
*)
function TmeTIWMultiColumnComboBox.RenderAsync(
  AContext: TIWBaseHTMLComponentContext): TIWXMLTag;
var
  js, htmlres, rowval,disab: string;
  r, c, i: integer;
  gborder, backcolor, forecolor, rowtitle,  itemText, itemValue,buttonClass: string;
begin
  Result := TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', 'TTIWMULTICOLUMNCOMBOBOX');
    RenderAsyncCommonProperties( AContext, Result );

    gborder := '0';
    if ShowGridBorder then
      gborder := '1';
    //CARATTO 26/11/2012 eliminazione style
//  htmlres := htmlres + '<table width=\"100%\" style=\"color:'+HTMLClr(PopUpFont.Color)+';font-family:'+PopUpFont.FontName+';font-size:'+IntToStr(PopUpFont.Size)+';cursor:default;\" id=\"'+ HTMLName +'tbl\" cellspacing=\"0\" cellpadding=\"2\" border=\"'+gborder+'\" >';
    htmlres := htmlres + '<table width=\"100%\" id=\"'+ HTMLName +'tbl\" cellspacing=\"0\" cellpadding=\"2\" border=\"'+gborder+'\" >';
    if ColumnTitles.Visible then
      begin
        backcolor := '';
        forecolor := '';
       //CARATTO 26/11/2012 eliminazione style
//      style := '';

        if (ColumnTitles.BackColor <> clNone) then
          backcolor := HTMLClr(ColumnTitles.BackColor);

        if (ColumnTitles.Font.Color <> clNone) then
          forecolor := HTMLClr(ColumnTitles.Font.Color);
        //CARATTO 26/11/2012 eliminazione style
        //style := 'style=\"background-color:'+backcolor+';color:'+forecolor+';font-size:'+IntToStr(ColumnTitles.Font.Size)+';font-family:'+ColumnTitles.Font.FontName+';\"';
        //htmlres := htmlres + '<TR '+style+'>';
        htmlres := htmlres + '<TR>';

        for i:=0 to ColCount-1 do
        begin
          rowtitle := '';
          if ColumnTitles.Titles.Count > i then
            rowTitle := ColumnTitles.Titles[i];
          htmlres := htmlres + '<TD>'+rowtitle+'&nbsp;</TD>';
        end;

        htmlres := htmlres + '</TR>';

      end;

    for r:=0 to Items.Count-1 do
    begin
      rowval := EmptyStr;
      if Items[r].RowData.Count <> 0 then
        rowval := Items[r].RowData[0];

      htmlres := htmlres + '<span id=\"val'+ HTMLName +'RowNo'+inttostr(r)+'\" style=\"visiblity:hidden;display:none;\">'+rowval+'</span>';

      htmlres := htmlres + '<tr id=\"'+ HTMLName +'RowNo'+inttostr(r)+'\" value=\"'+rowval
        //CARATTO 12/12/2012 Cambiato id del componente text
//        +'\" onmouseup = \"'+HTMLName+'ChangeEditValue('''+ HTMLName +'_TEXT'','''
        +'\" onmouseup = \"'+HTMLName+'ChangeEditValue('''+ HTMLName +''','''
        + HTMLName +'RowNo'+inttostr(r) +''','+ inttostr(r)+ ')\" onmousemove = \"CCShowHighLighted('''
        + HTMLName +'RowNo'+inttostr(r) +''','+HTMLName+'obj,'+IntToStr(ColCount - 1)
        +')\" onmouseout = \"CCShowUnHighLighted('''+ HTMLName +'RowNo'+inttostr(r) +''','
        +IntToStr(ColCount - 1)+','+HTMLName+'obj)\">';

      for c:=0 to ColCount-1 do
      begin
        htmlres := htmlres + '<td>';
        if c < Items[r].RowData.Count then
          htmlres := htmlres + '' + StringReplace(Items[r].RowData[c], '"', '&quot;', [rfReplaceAll]) + '&nbsp;'
        else
          htmlres := htmlres + '&nbsp;';
        htmlres := htmlres + '</td>';
      end;
        htmlres := htmlres + '</tr>';
      end;

      //NoMatchingItems
      if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
      begin
        htmlres := htmlres + '<tr id=\"' + HTMLName + 'RowNo' +  IntToStr(Items.Count)  + '\" style=\"display:none;\" >';
        htmlres := htmlres + '<td nowrap colspan='+IntToStr(ColCount)+'>';
        htmlres := htmlres + NoMatchingItems;
        htmlres := htmlres + '</td>';
        htmlres := htmlres + '</tr>';
      end;
      //end NoMatchingItems

      htmlres := htmlres + '</table>';
    //CARATTO modifica test undefined
    js :=
      '<![CDATA['
      + 'var lookup = document.getElementById("' + HTMLName + 'popup");'#13
      + 'if (lookup)'#13
      + '  lookup.innerHTML = "' + htmlres + '";'#13
      + 'if (!(typeof '+HTMLName +'obj === "undefined"))'
      + '{'#13
      + '  ' + HTMLName+'obj.ItemIndex = '+ IntToStr(ItemIndex) +';'#13
      + '  ' + HTMLName+'obj.RCount = '+ IntToStr(Items.Count) +';'#13
      + HTMLName+'obj.Item = new Array();'#13;

        for i := 1 to Items.Count do
        begin

          if (Items[i-1].RowData.Count > 0) then
            ItemText := Items[i-1].RowData[0]
          else
            ItemText := '';

//          if not CaseSensitiveLookUp then
//            ItemText := UpperCase (pchar(ItemText));

          js := js + HTMLName+'obj.Item['+HTMLName+'obj.Item.length] = "' + ItemText + '";'#13;
        end;

//      itemValue := EmptyStr;
      itemValue := Text;
      if (ItemIndex >=0) and (ItemIndex < Items.Count) then
        itemValue := Items[ItemIndex].RowData[0];

      if (Self.Enabled) and not (Self.ReadOnly) then
      begin
        Disab:='false';
        buttonclass:='medpMultiColComboButton';
      end
      else
      begin
        Disab:='true';
        buttonclass:='medpMultiColComboButton_disabled';
      end;

      js := js
      + '}'#13
      //CARATTO 12/12/2012
      + 'var hi = FindElem("' + HTMLName + '_INPUT");'#13
//      + 'var hi = document.getElementById("' + HTMLName + '");'#13
      + 'if (hi)'#13
      + '  hi.value = "'+ IntToStr(ItemIndex) + '~' + itemValue + '";'#13
      //CARATTO 12/12/2012 Cambiato id del componente text
//      + 'var el = document.getElementById("' + HTMLName + '_TEXT");'#13
       + 'var el = document.getElementById("' + HTMLName + '");'#13

      + 'if (el){'#13
      + '  el.value = "' + itemValue + '";'#13
      //make sure quotes instead of &quot; are displayed in the edit box
      + '  el.value = el.value.replace(/&quot;/g, ''"'');'#13
      //CARATTO 26/11/2012 eliminazione style
      //+ '  el.style.width = "' + IntToStr(Width - 20) + 'px"'#13
      //CARATTO Disabilitazione anche in aync
      + '  el.disabled='+ Disab + '; '+#13
      + '  var elb=document.getElementById("'+HTMLName+'button"); '#13
      + '  if (elb != null) {elb.disabled='+ Disab +'; elb.class="' + buttonclass + '";} '#13
      + '}'#13
      +']]>';

    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(js);

  except
    FreeAndNil(Result);
  end;
end;

function TmeTIWMultiColumnComboBox.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  htmlres: string;
  r, c: Integer;
  gradient, {fontstyle,} S, rowval, buttonval: string;

  backcolor: string;
  forecolor: string;
  //CARATTO 26/11/2012 eliminazione style
  //style: string;
  rowtitle: string;
  i : integer;
  gborder: string;
  InitText: string;
  ajaxcall, submitclick: string;

   function MakeAlign(AAlignment: TAlignment):string;
   begin
     Result := '';
     case AAlignment of
     taRightJustify: Result := ' style=text-align:right;';
     taCenter: Result := ' style=text-align:center;';
     end;
   end;

   function MakeScript: string;
   var
     LScript: TStringList;
     i: integer;
     ItemText: string;
   begin
     LScript := TStringList.Create;
     with LScript do
     begin
       Add('<Script Language="JavaScript">');
       Add('var '+HTMLName+'dohide = 0;');
       Add('var '+HTMLName+'dosubmit = true;');

       Add('var '+HTMLName+'obj = new Object();');
       Add(HTMLName+'obj.ID = "'+HTMLName+'";');
       Add(HTMLName+'obj.popupHeight = '+ IntToStr(PopUpHeight) +';');
       Add(HTMLName+'obj.HighLightedRow = "";');
       Add(HTMLName+'obj.DivStartLeft = 0;');
       Add(HTMLName+'obj.DivStartTop = 0;');
       Add(HTMLName+'obj.DivEndLeft = 0;');
       Add(HTMLName+'obj.DivEndTop = 0;');
       Add(HTMLName+'obj.ClrSel = "'+ HTMLClr(SelectionColor)+'"');
       Add(HTMLName+'obj.ClrTextSel = "'+ HTMLClr(SelectionTextColor)+'"');
       Add(HTMLName+'obj.CCount = '+IntToStr(ColCount - 1));
       Add(HTMLName+'obj.RCount = '+IntToStr(items.Count));
       Add(HTMLName+'obj.ForeColor = "'+ HTMLClr(PopUpFont.Color)+'"');
       Add(HTMLName+'obj.PopUpColor = "'+ HTMLClr(PopUpColor)+'"');
       Add(HTMLName+'obj.SelectedRow = -1;');
       Add(HTMLName+'obj.ItemIndex = '+ IntToStr(ItemIndex) +';');
       Add(HTMLName+'obj.ItemSel = false;');
       Add(HTMLName+'obj.UsedKeyb = false;');

       Add(HTMLName+'obj.Item = new Array();');

        for i := 1 to Items.Count do
        begin

          if (Items[i-1].RowData.Count > 0) then
            ItemText := Items[i-1].RowData[0]
          else
            ItemText := '';

//          if not CaseSensitiveLookUp then
//            ItemText := StrUpper(pchar(ItemText));
//              ItemText := UpperCase(pchar(ItemText));

           Add(HTMLName+'obj.Item['+HTMLName+'obj.Item.length] = "' + ItemText + '";');
        end;

       Add('function '+HTMLName+'showdivonclick() {');

       if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
         Add('document.getElementById("'+HTMLName+'RowNo" + '+HTMLName+'obj.RCount).style.display = "none";');

//       if LookupMethod = lmFilter then
//        Add(' CCDisplayAllRows('+IntToStr(FComboRows.Count)+',"'+HTMLName+'");');

       //Add(' '+HTMLName+'showdiv('+HTMLName+'obj);');

       //Add(' var itemHeight = parseInt(document.getElementById("'+HTMLName+'tbl").offsetHeight);');
       //Add(' if ( (itemHeight < parseInt('+IntToStr(PopUpHeight)+')) && (itemHeight > 0) ){ ');
       //Add('   document.getElementById("'+HTMLName+'popup").style.height = itemHeight;');
       //Add('   document.getElementById("'+HTMLName+'popup").style.overflow = "";');
       //Add(' } else {');
       //Add('   document.getElementById("'+HTMLName+'popup").style.height = parseInt("'+IntToStr(PopUpHeight)+'");');
       //Add('   document.getElementById("'+HTMLName+'popup").style.overflow = "auto";');
       //Add(' }');

        Add(
        '  if ('+HTMLName+'obj.HighLightedRow == "")'#13
        +   HTMLName+'ShowLookUp(null);'#13
        + ' document.getElementById("'+HTMLName+'checklist").style.display = "none";'#13
        +   HTMLName+'showdiv('+HTMLName+'obj);');

       Add('}');

       Add('function '+HTMLName+'showdiv(obj) {');

       Add(' document.getElementById("'+ HTMLName +'tbl").style.borderCollapse = "collapse";');

       //Moved after display = "";
       //Add(' CCgetPositionDiv(document.getElementById("'+HTMLName+'checklist"),'+HTMLName+'obj);');

       Add(' if (document.getElementById("'+HTMLName+'checklist").style.display == "none"){');
       Add('   if (obj.HighLightedRow !="")');
       Add('     CCShowUnHighLighted(obj.HighLightedRow,'+HTMLName+'obj.CCount,obj);');


      if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
      begin
        //CARATTO 12/12/2012 Cambiato id del componente text
//        Add('if ( ('+HTMLName+'obj.SelectedRow == -1) && (document.getElementById("'+HTMLName+'_TEXT").value.length > 0) )');
        Add('if ( ('+HTMLName+'obj.SelectedRow == -1) && (document.getElementById("'+HTMLName+'").value.length > 0) )');
        Add('  document.getElementById("'+HTMLName+'RowNo" + '+HTMLName+'obj.RCount).style.display = "";');
      end;

       Add('  document.getElementById("'+HTMLName+'checklist").style.display = "";');

       if CaseSensitiveLookup then
         Add('   CCHighLightSelected("'+HTMLName+'",obj,true);')
       else
         Add('   CCHighLightSelected("'+HTMLName+'",obj,false);');
       //CARATTO Modifica js per posizionamento checklist
       Add(' CCgetPositionDiv("'+HTMLName+'",'+HTMLName+'obj);');

       Add('   document.onmouseup = '+HTMLName+'docMouseUp;');
//       Add('   CCshowWindowedObjects(false,'+HTMLName+'obj.DivStartLeft,'+HTMLName+'obj.DivStartTop,'+HTMLName+'obj.DivEndLeft,'+HTMLName+'obj.DivEndTop);');
        //CARATTO 12/12/2012 Cambiato id del componente text
//        Add('   var myInput = document.getElementById("'+HTMLName+'_TEXT");');
          Add('   var myInput = document.getElementById("'+HTMLName+'");');
       Add('   if (!myInput.disabled)');
       Add('     myInput.focus();');
       Add(' }else {');
       Add('   document.getElementById("'+HTMLName+'popup").scrollTop = 0;');
       Add('   document.getElementById("'+HTMLName+'checklist").style.display = "none";');
//       Add('   CCshowWindowedObjects(true,'+HTMLName+'obj.DivStartLeft,'+HTMLName+'obj.DivStartTop,'+HTMLName+'obj.DivEndLeft,'+HTMLName+'obj.DivEndTop);');
       Add(' }');
       Add('}');

       Add('function '+HTMLName+'docMouseUp() {');
       Add(' if ('+ HTMLName +'dohide == 0) {');
       Add('   document.getElementById("'+HTMLName+'popup").scrollTop = 0;');
       Add('   document.getElementById("'+HTMLName+'checklist").style.display = "none";');
//       Add('   CCshowWindowedObjects(true,'+HTMLName+'obj.DivStartLeft,'+HTMLName+'obj.DivStartTop,'+HTMLName+'obj.DivEndLeft,'+HTMLName+'obj.DivEndTop);');
       Add('   document.onmouseup = "";');
       Add(' } else {');
       Add('   '+ HTMLName +'dohide = 0; ');
       Add(' }');
       Add('}');

       Add('function '+HTMLName+'resetdoc(){');
       Add(' '+ HTMLName +'dohide = 1; ');
       Add('}');

       Add('function ' + HTMLName + 'Focus(ctrl,event) {');
//       Add(HTMLName+'obj.ItemSel = "true";');

//       if (DropDownDisplay = ddOnFocus) then
//         Add(HTMLName+'ShowLookUp(event);');

//      if FFocusColor <> FColor then
        //CARATTO 26/11/2012 eliminazione style
        //Add(' ctrl.style.backgroundColor = '#39+HTMLClr(FFocusColor)+#39'');

       if SelectAll then
       begin
         Add(' var isIE = navigator.appName.indexOf("Microsoft") != -1;');
         Add(' if (isIE){');
         Add('   var rNew = ctrl.createTextRange();');
         Add('   rNew.moveStart('#39'character'#39', 0) ;');
         Add('   rNew.select();');
         Add(' }');
       end;

       Add('}');

       Add('function ' + HTMLName + 'Blur(ctrl,obj) {');
//       Add('if (ctrl.value == "")');
       //CARATTO 01/03/2013 controlla se valore nella textbox è nella lista. se si,imposta correttamente itemindex
       Add(' CCItemIndexText(obj,ctrl.value);');
       //CARATTO 12/12/2012
       Add('    FindElem(''' + HTMLName + '_INPUT'').value = obj.ItemIndex+ "~" + ctrl.value;');
//       Add('    document.getElementById(''' + HTMLName + ''').value = "-1~" + ctrl.value;');
       Add('  obj.ItemSel = false;');

//      if (BGColor <> clNone) then
        //CARATTO 26/11/2012 eliminazione style
       //Add(' ctrl.style.backgroundColor = "'+HTMLClr(Color)+'"');
       Add('}');

       if Assigned(Self.OnChange) then
         submitclick := 'return SubmitClick('#39+HTMLName+#39', index, '#39'false'#39');'#13;

       if Assigned(Self.OnAsyncChange) then
       begin
          ajaxcall := 'processAjaxEvent(''onChange'', '
            + HTMLControlImplementation.IWCLName
            + ',''' + HTMLName + '.' + 'DoAsyncChange' + ''','
            + 'true' + ', null, '
            + 'true' + ');';

         GGetWebApplicationThreadVar.RegisterCallBack(HTMLName+'.DoAsyncChange', DoAsyncChange);

         submitclick := '';
       end;

       Add('function '+HTMLName+'ChangeEditValue(EDId,id,index){');
       Add(' if (id!="") {');
       Add('  var fullid = "val" + id;');
       Add('  newval = document.getElementById(fullid).innerHTML;');
       Add('  document.getElementById(EDId).value = newval;');
//       Add('  FindElem(''' + HTMLName + ''').value = newval; ');

       Add( HTMLName+'docMouseUp();');
       Add( HTMLName+'obj.ItemIndex = index;');

       //ATTENZIONE NON SPOSTARE usa ajaxcall e submitclick impostati prima
       //CARATTO 12/12/2012 Cambiato id del componente text
       Add(' FindElem(''' + HTMLName + '_INPUT'').value = index + "~" + FindElem(''' + HTMLName + ''').value;');
//       Add(' document.getElementById(''' + HTMLName + ''').value = index + "~" + newval; ');
       Add(ajaxcall);
       Add(submitclick);
       Add(' }');
       Add('}');

       //Caratto 11/12/2012 -ini- Evento su change della text

       Add('function '+HTMLName+'TextChange(){');
//       Add('var el = document.getElementById("'+HTMLName+'_TEXT"); ');
       Add('var el = document.getElementById("'+HTMLName+'"); ');
       Add(HTMLName + 'Blur(el,'+HTMLName+'obj);');
       //Caratto 21/02/2013 nel caso di change con post deve essere definita la variabile index poichè usata  nella stringa submitclick
       Add('var index = '+HTMLName+'obj.ItemIndex;');
       Add(ajaxcall);
       Add(submitclick);
       Add('}');
       //Caratto 11/12/2012 -fine-

       Add('function '+HTMLName+'SelectHighLighted(obj) {');
       //CARATTO 12/12/2012 Cambiato id del componente text
//       Add('    '+HTMLName+'ChangeEditValue("'+ HTMLName+'_TEXT",obj.HighLightedRow, obj.HighLightedRow.substr(obj.HighLightedRow.indexOf("RowNo")+5));');
       Add('    '+HTMLName+'ChangeEditValue("'+ HTMLName+'",obj.HighLightedRow, obj.HighLightedRow.substr(obj.HighLightedRow.indexOf("RowNo")+5));');
       Add('  '+HTMLName+'dosubmit = true;');
       Add('}');


       Add('function '+HTMLName+'noenter(event) {');
       Add(' var isIE = navigator.appName.indexOf("Microsoft") != -1;');
       Add(' if (isIE) {key = event.keyCode;} else {key = event.which;}');
       Add(' if (! '+HTMLName+'dosubmit) ');
       Add('  return !(event && key == 13); ');
       Add('}');

       Add('function '+HTMLName+'ShowLookUp(event){');

       //if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
       //begin
         //Add('if ('+HTMLName+'obj.SelectedRow == -1)');
         //Add('  document.getElementById("'+HTMLName+'RowNo'+ IntToStr(FComboRows.Count) +'").style.display = "none";');
       //end;

       Add(' '+HTMLName+'dosubmit = false;');
       Add(' var isIE = navigator.appName.indexOf("Microsoft") != -1;');
       Add(' var key;');
       Add(' if (event == null) '#13
            + ' key = null; '#13
            + ' else');
       Add(' if (isIE) {key = event.keyCode;} else {key = event.which;}');
       Add('   displayRowCount = 0;');

      if DropDownDisplay <> ddOnFocus then
        Add('if ((key == 9) || (key == 0) || (key == 13)) return;');

       Add(' if ( ((key == 40) || (key == 38) || (key == 13) || (key == 33) || (key == 34) || (key == 35) || (key == 36))'
       + ' && (document.getElementById("'+HTMLName+'checklist").style.display != "none") ) {');
       Add(' }');
       Add(' else {');

      if LookupMethod = lmFilter then
       Add('  CCDisplayAllRows('+HTMLName+'obj.RCount,"'+HTMLName+'");');
       //CARATTO 12/12/2012 Cambiato id del componente text
//       Add('  var editor = document.getElementById("'+HTMLName+'_TEXT");');
         Add('  var editor = document.getElementById("'+HTMLName+'");');
       Add('  if (editor.value.length > 0) {');
       Add('   SelectedRow = -1;');

     if LookupMethod <> lmSelectSorted then
     begin
       Add('   for (i=0;i<'+HTMLName+'obj.RCount;i++){');
       Add('    RowID = "'+ HTMLName +'RowNo" + i;');
       Add('    valRow = document.getElementById("val"+RowID);');
       Add('    elRow = document.getElementById(RowID);');

       if not CaseSensitiveLookUp then
         Add('   if ( (valRow.innerHTML.substr(0,editor.value.length).toUpperCase()) != (editor.value.toUpperCase()) ) {')
       else
         Add('   if ( valRow.innerHTML.substr(0,editor.value.length) != editor.value ) {');

       if LookupMethod = lmFilter then
         Add('     elRow.style.display = "none";');

       Add('    }else {');
       Add('     displayRowCount++;');
       Add('     if (displayRowCount ==1)');
       Add('       SelectedRow=RowID;');

       if LookupMethod = lmFilter then
         Add('     elRow.style.display = ""; ');

       Add('     }');
       Add('    }');

    end
    else
    begin

        Add('   keyval = editor.value;');
        if not CaseSensitiveLookUp then
          Add('   keyval = editor.value.toUpperCase();');

        Add(
          ' SelectedRow = CCBinary('+HTMLName+'obj,keyval);'#13
          + 'if (SelectedRow != -1)'#13
          + '{'#13
          + ' SelectedRow = "" + SelectedRow;'#13
          + ' if (SelectedRow.indexOf(".") >= 0)'#13
          + '  SelectedRow = SelectedRow.substring(0,SelectedRow.indexOf("."));'#13
          + ' displayRowCount = 1;'#13
          + ' SelectedRow = "'+ HTMLName +'RowNo" + SelectedRow;'#13
          + '}'#13
          );
     end;

     Add(HTMLName+'obj.SelectedRow = SelectedRow;');

      if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
      begin
        Add('  if (document.getElementById("'+HTMLName+'checklist").style.display == "none"){');
        Add(     HTMLName+'showdiv('+HTMLName+'obj);');
        Add('  }');

        Add('if ('+HTMLName+'obj.SelectedRow == -1)');
        Add('  document.getElementById("'+HTMLName+'RowNo" + '+ HTMLName +'obj.RCount).style.display = "";');
        Add('else');
        Add('  document.getElementById("'+HTMLName+'RowNo" + '+ HTMLName +'obj.RCount).style.display = "none";');

      end
      else
      begin

       Add('   if ((document.getElementById("'+HTMLName+'checklist").style.display == "none") && (displayRowCount >0)){');
       Add(       HTMLName+'showdiv('+HTMLName+'obj);');
       Add('   }');
       Add('   else if (displayRowCount <=0) {');
       Add('     if (document.getElementById("'+HTMLName+'checklist").style.display != "none")');
			 Add(       HTMLName+'showdiv('+HTMLName+'obj);');
       Add('   }');

       end;

      if LookupMethod = lmFilter then
       Add('  CCNormalAllRows('+HTMLName+'obj.RCount,"'+HTMLName+'");');

       Add('  if (SelectedRow != -1){');
       Add('    CCShowHighLighted(SelectedRow,'+HTMLName+'obj,'+HTMLName+'obj.CCount);');

      if LookupMethod <> lmFilter then
        Add('     document.getElementById("'+HTMLName+'popup").scrollTop = document.getElementById(SelectedRow).offsetTop;');

       Add('    }');
       Add('  }');
       Add('  else '+HTMLName+'showdiv('+HTMLName+'obj);');

       Add(' }');
       Add('}');

       Add('function '+HTMLName+'KeyDown(event,obj){'
        + '   if (!containsName("' + HTMLName + '")) {'#13
        + ' 	 window.ChangedControls += "' + HTMLName + '" + ",";'#13
        + '   }'#13);

       Add(' var isIE = navigator.appName.indexOf("Microsoft") != -1;');
       Add(' ' + HTMLName + 'obj.UsedKeyb = true;');
       Add(' var key;');
       Add(' if (isIE) {key = event.keyCode;} else {key = event.which;}');
       Add('   displayRowCount = 0;');

       Add(' if ((key == 40) || (key == 38) || (key == 13) || (key == 33) || (key == 34) || (key == 35) || (key == 36)) {');
       Add('  if (key == 40) {');      // down key
       Add('    CCHighLightNext("'+HTMLName+'",'+HTMLName+'obj);');
       Add('  }');
       Add('  if (key == 38) {');      // up key
       Add('    CCHighLightPrevious("'+HTMLName+'",'+HTMLName+'obj);');
       Add('  }');
       Add('  if (key == 33) {');      // pgup key
       Add('    CCHighLightPrevious("'+HTMLName+'",'+HTMLName+'obj,"pgup");');
       Add('  }');
       Add('  if (key == 34) {');      // pgdn key
       Add('    CCHighLightNext("'+HTMLName+'",'+HTMLName+'obj,"pgdn");');
       Add('  }');
       Add('  if (key == 35) {');      // end key
       Add('    CCHighLightNext("'+HTMLName+'",'+HTMLName+'obj,"end");');
       Add('  }');
       Add('  if (key == 36) {');      // home key
       Add('    CCHighLightPrevious("'+HTMLName+'",'+HTMLName+'obj,"home");');
       Add('  }');
       Add('  if (key == 13) {');     // Enter key
       Add('    '+HTMLName+'SelectHighLighted('+HTMLName+'obj);');
       Add('    obj.ItemSel = true;');
       Add('  }');
       Add(' }');
       Add(' else ');
       Add(' {');
       Add('    obj.ItemSel = false;');
       Add(' }');
       Add('}');

       Add('</script>');
    end;
    Result := LScript.Text;
    LScript.Free;
  end;

  function StripCRLF(s:string): string;
  begin
    while pos(#13,s) > 0 do
      delete(s,pos(#13,s),1);
    while pos(#10,s) > 0 do
      delete(s,pos(#10,s),1);
    Result := s;
  end;

begin

  gradient := GradientStyle(PopupColor, PopupColor, PopupColorTo, clNone, PopUpColorGradientDirection, AContext, true);


  (*tempdario
     {$IFNDEF TMSIW9}
     if (Font.CSSStyle = '') then
     {$ENDIF}
     begin
       fontstyle := ' ' + Font.FontToStringStyle(GGetWebApplicationThreadVar.Browser) + ' ';
     end;
*)

  InitText := Text;
  //InitText := EmptyStr;
  if (ItemIndex >=0) and (ItemIndex < Items.Count) then
    InitText := Items[ItemIndex].RowData[0];

 if DropDownImageURL <> EmptyStr then
  begin
    buttonval := '<img src="' + DropDownImageURL + '" '
       +IIF(Editable and not ReadOnly,' onclick="'+HTMLName+'showdivonclick()"', '') + '>';
  end
  else if DropDownImage.Empty then
  begin

    //{$IFDEF DELPHI_UNICODE}

    //{$ELSE}
//    if (GGetWebApplicationThreadVar.Browser = brIE) then
//    if (IsBrowserIe(AContext)) then
//      buttonval := '<font face="webdings">6</font>'
//    else
//      buttonval := '<span style=''font-size:7pt;''>&#9660;</span>';
    //{$ENDIF}
    //CARATTO 25/02/2013 cambiata gestione button
//    buttonval := '<BUTTON id="'+ HTMLName + 'button" '+IIF(Enabled and not Readonly,'','disabled ')+'onclick="'+HTMLName+'showdivonclick()"'
     buttonval := '<input type="button" id="'+ HTMLName + 'button" '+IIF(Enabled and not Readonly,'class="medpMultiColComboButton"',' class="medpMultiColComboButton_disabled" disabled ')+'onclick="'+HTMLName+'showdivonclick()"/>';
//     + '<div style=" font-size:9pt;margin:0px;padding:0px;border:0px;margin-top:-0.2em;margin-right:-0.1em;">'
//     + buttonval + '</div>'
     //     + buttonval + '</div></BUTTON>'
  end
  else
  begin
    if DropDownImage.IsGIF then
      buttonval := TIWServerControllerBase.NewCacheFile('gif', true)
    else
      buttonval := TIWServerControllerBase.NewCacheFile('jpg', true);

    DropDownImage.SaveToFile(buttonval);

    buttonval := '<img src="' + GetCacheDir(Self) + ExtractFilename(buttonval)+ '" '
       +IIF(Editable, ' onclick="'+HTMLName+'showdivonclick()"', '') + '>';
  end;

  htmlres := '' +
     MakeScript;
     //+ '<style>.testmystyle {font-family:"Verdana";font-size:15pt}</style>'#13;

     if DropDownImageURL <> EmptyStr then
       htmlres := htmlres + '<table cellspacing="0" cellpadding="0" border="0"><tr><td>';

     htmlres := htmlres
     + '<input ' + IIF(Editable and Enabled,'','disabled ') + 'type="'
     + IIF(FPasswordPrompt, 'password', 'text') + '" name="' + HTMLName +'_TEXT"'
     {$IFNDEF TMSIW9}
//     + ' class="'+font.CSSStyle+'"'
     {$ENDIF}
//     + ' id="' + HTMLName +'_TEXT"'
     //CARATTO 12/12/2012 Cambiato id del componente text
     + ' id="' + HTMLName +'"'
     + IIF(MaxLength > 0, ' maxlength=' + IntToStr(MaxLength))
     //CARATTO 26/11/2012 eliminazione style
//     + ' style="width:'+inttostr(width-20)+'px;'
//     + fontstyle
     //HTML5 Doctype Fix
(*
     + '-moz-box-sizing: border-box;'
     + '-webkit-box-sizing: border-box;'
     + 'box-sizing: border-box;'
*)
     //CARATTO 26/11/2012 eliminazione style
//     + IIF(Flat, ' border-style:solid;border-width:'+inttostr(BorderWidth)+ 'px;border-color:'+HTMLClr(BorderColor)+';')
//     + IIF(Color <> clNone, ' background-color:'+HTMLClr(Color)+';')
//     + '"'
     + IIF(ReadOnly, ' readonly', '')
     + ' value="' + InitText + '"'
     + ' onKeyPress="return '+HTMLName+'noenter(event);"'
     + IIF((DropDownDisplay <> ddManual) and not ReadOnly and Editable and Enabled, ' onKeyUp="if(this.value.length >= '+ IntToStr(LookupAfterChars)+')'+HTMLName+'ShowLookUp(event)"', '')
     + IIF(DropDownDisplay = ddOnFocus, ' onClick="'+HTMLName+'ShowLookUp(event)"', '')
		 + ' onFocus="'+HTMLName+'obj.ItemSel = ''true'';"'
     + ' onBlur="'+HTMLName+'Blur(this,'+HTMLName+'obj);'+HTMLName+'docMouseUp();"'
		 + ' onKeyDown="'+HTMLName+'KeyDown(event,'+HTMLName+'obj)"'
     + ' autocomplete="off"'
     //Caratto 11/12/2012 Evento su change della text
//     + ' onchange="'+HTMLName+'TextChange()" '
     + IIF(FAlignment <> taLeftJustify,MakeAlign(FAlignment))
     + ' onFocus="'+HTMLName+'Focus(this,event);"'
     //Caratto-inzio 11/12/2012 aggiunto evento textchange
// + iif(FFocusColor <> FColor,' this.style.backgroundColor = '#39+HTMLClr(FocusColor)+#39';','')
     + '>';

     if DropDownImageURL <> EmptyStr then
       htmlres := htmlres + '</td><td>';

     htmlres := htmlres + buttonval;

     if DropDownImageURL <> EmptyStr then
       htmlres := htmlres + '</td></tr></table>'
     else
       htmlres := htmlres + '<br>';

     htmlres := htmlres
     + '<div'
     {$IFNDEF TMSIW9}
//tempdario     + ' class="'+font.CSSStyle+'"'
     {$ENDIF}
     +' onMouseDown="'+HTMLName+'resetdoc();" id="'+HTMLName
     + 'checklist" style="z-index:1000;display:none; position:absolute; '+gradient
     + 'border-color:gray;border-width:1px;border-bottom:2px outset black;border-right:2px outset black;border-style:solid;padding:0px;'
     //+ ' width:'+IntToStr(PopUpWidth)+'px;'
     //+ IIF(PopUpWidth > 0, ' width:'+IntToStr(PopUpWidth)+'px;', '')
     //+ IIF(PopUpHeight > 0, ' height:'+IntToStr(PopUpHeight)+'px;overflow:auto;', '')
     //CARATTO 26/11/2012 eliminazione style
     // + fontstyle
     + '">';

    //ColWidth := Width div FColCount;
    //CARATTO cambiato stile
    S:= 'overflow-x:scroll;overflow-y:auto;display:block;';

    if PopUpHeight > 0 then
    begin
        //CARATTO cambiato da px a em
      if (IsBrowserIe(AContext)) then
        S:= S + 'height:'+inttostr(PopUpHeight)+'em;'
      else
        S:= S + 'max-height:'+inttostr(PopUpHeight)+'em;';
    end;

    if PopUpWidth > 0 then
      S:= S + 'width:'+inttostr(PopUpWidth)+'em;';

    if S <>'' then
      S:= 'style="'+S+'"';

    htmlres := htmlres + '<div id="'+HTMLName+'popup" '+S+'>';

    gborder := '0';
    if ShowGridBorder then
      gborder := '1';
    //CARATTO 26/11/2012 eliminazione style
    //htmlres := htmlres + '<table width="100%" style="color:'+HTMLClr(PopUpFont.Color)+';font-family:'+PopUpFont.FontName+';font-size:'+IntToStr(PopUpFont.Size)+'pt;cursor:default;" id="'+ HTMLName +'tbl" cellspacing="0" cellpadding="2" border="'+gborder+'" >'#13;
    htmlres := htmlres + '<table width="100%" id="'+ HTMLName +'tbl" cellspacing="0" cellpadding="2" border="'+gborder+'" >'#13;
    if ColumnTitles.Visible then
      begin
        backcolor := '';
        forecolor := '';
        //CARATTO 26/11/2012 eliminazione style
        //style := '';

        if (ColumnTitles.BackColor <> clNone) then
          backcolor := HTMLClr(ColumnTitles.BackColor);

        if (ColumnTitles.Font.Color <> clNone) then
          forecolor := HTMLClr(ColumnTitles.Font.Color);
      //CARATTO 26/11/2012 eliminazione style
      //style := 'style="background-color:'+backcolor+';color:'+forecolor+';font-size:'+IntToStr(ColumnTitles.Font.Size)+';font-family:'+ColumnTitles.Font.FontName+';"';
      //htmlres := htmlres + '<TR '+style+'>';
      htmlres := htmlres + '<TR>';

        for i:=0 to ColCount-1 do
        begin
          rowtitle := '';
          if ColumnTitles.Titles.Count > i then
            rowTitle := ColumnTitles.Titles[i];
          htmlres := htmlres + '<TD>'+rowtitle+'&nbsp;</TD>';
        end;

        htmlres := htmlres + '</TR>';

      end;

    for r:=0 to items.Count-1 do
    begin
      rowval := EmptyStr;
      if items[r].RowData.Count <> 0 then
        rowval := items[r].RowData[0];

      htmlres := htmlres + '<span id="val'+ HTMLName +'RowNo'+inttostr(r)+'" style="visiblity:hidden;display:none;">'+rowval+'</span>';
      //CARATTO 12/12/2012 Cambiato id del componente text
//      htmlres := htmlres + '<tr id="'+ HTMLName +'RowNo'+inttostr(r)+'" value="'+rowval+'" onmouseup = "'+HTMLName+'ChangeEditValue('''+ HTMLName +'_TEXT'','''+ HTMLName +'RowNo'+inttostr(r) +''','+ inttostr(r)+ ')" onmousemove = "CCShowHighLighted('''+ HTMLName +'RowNo'+inttostr(r) +''','+HTMLName+'obj,'+IntToStr(ColCount - 1)+')" onmouseout = "CCShowUnHighLighted('''+ HTMLName +'RowNo'+inttostr(r) +''','+IntToStr(ColCount - 1)+','+HTMLName+'obj)">'#13;
        htmlres := htmlres + '<tr id="'+ HTMLName +'RowNo'+inttostr(r)+'" value="'+rowval+'" onmouseup = "'+HTMLName+'ChangeEditValue('''+ HTMLName +''','''+ HTMLName +'RowNo'+inttostr(r) +''','+ inttostr(r)+ ')" onmousemove = "CCShowHighLighted('''+ HTMLName +'RowNo'+inttostr(r) +''','+HTMLName+'obj,'+IntToStr(ColCount - 1)+')" onmouseout = "CCShowUnHighLighted('''+ HTMLName +'RowNo'+inttostr(r) +''','+IntToStr(ColCount - 1)+','+HTMLName+'obj)">'#13;

      for c:=0 to ColCount-1 do
      begin
//        htmlres := htmlres + '<td width="'+inttostr(ColWidth)+'">'#13;
        htmlres := htmlres + '<td>'#13;
        if c < items[r].RowData.Count then
          //htmlres := htmlres + '<font class="'+font.CSSStyle+'" '+S+'>' + FComboRows[r].RowData[c] + '&nbsp;</font>'
          htmlres := htmlres + '' + items[r].RowData[c] + '&nbsp;'
        else
          //htmlres := htmlres + '<font class="'+font.CSSStyle+'" '+S+'>&nbsp;</font>';
          htmlres := htmlres + '&nbsp;';
        htmlres := htmlres + '</td>'#13;
      end;
      htmlres := htmlres + '</tr>'#13;
    end;

      //NoMatchingItems
      if ( (LookupMethod = lmFilter) and (NoMatchingItems <> EmptyStr) ) then
      begin
        htmlres := htmlres + '<tr id="' + HTMLName + 'RowNo' +  IntToStr(items.Count)  + '" style="display:none;" >';
        htmlres := htmlres + '<td nowrap colspan='+IntToStr(ColCount)+'>';
        htmlres := htmlres + NoMatchingItems;
        htmlres := htmlres + '</td>';
        htmlres := htmlres + '</tr>';
      end;
      //end NoMatchingItems

    htmlres := htmlres + '</table>';
    htmlres := htmlres + '</div>';

    htmlres := htmlres
      + '</div>'#13
  //    + ' </td>'#13
  //    + ' </tr></table>';
    + '';
(*tempdario
    if FIsExpanded then
    begin
      FIsExpanded := false;
      htmlres := htmlres + '<script>'+HTMLName+'showdivonclick();</script>';
    end;

    if FSetFocus then
    begin
      FSetFocus := false;
//      htmlres := htmlres + '<script>document.getElementById("' + HTMLName + '_TEXT").focus()</script>';
      htmlres := htmlres + '<script>var el = document.getElementById("' + HTMLName + '");'
      + 'if (el){'
      + '  if (!el.disabled)'
      + '    el.focus();'
      + '}'
      + '</script>';
    end;
*)
    if SupportsInput and Required then
    begin
        TIWComponent40Context(AContext).AddValidation('getSubmitForm().' + HTMLName + '.value.length==0'
         , Format(RSValidationRequeredField, [FriendlyName]));
    end;

  Result := TIWHTMLTag.CreateTag('DIV');
  Result.AddStringParam('id',HTMLName+'DIV');
  Result.Contents.AddText(htmlres);

  with Result.Contents.AddTag('INPUT') do
  begin
    AddStringParam('TYPE','hidden');
    AddStringParam('NAME',HTMLName+'');
    //CARATTO 12/12/2012
    AddStringParam('ID',HTMLName+'_INPUT');
//    AddStringParam('ID',HTMLName);
    AddStringParam('VALUE', IntToStr(ItemIndex) + '~' + Text);
  end;

end;

end.


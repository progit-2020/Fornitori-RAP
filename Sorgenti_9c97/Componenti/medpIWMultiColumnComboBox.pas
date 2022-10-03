unit medpIWMultiColumnComboBox;

interface
uses
  Windows, SysUtils, StrUtils, Classes,
  IWCompEdit,IWRenderContext,IWHTMLTag,IWXMLTag,Menus,IWScriptEvents,
  IWApplication,IW.Common.System,
  IW.Browser.InternetExplorer;

type
  TMedpIWMultiColumnComboBoxEvent = procedure(Sender: TObject; Index: integer) of object;
  TMedpAsyncIWMultiColumnComboBoxEvent = procedure (Sender: TObject; EventParams: TStringList; Index: Integer; Value: string) of object;

  TMedpIWMultiColumnComboBox = class;

  TMedpIWColumnTitles = class(TPersistent)
  private
    FTitles: TStrings;
    FVisible: boolean;
    procedure SetTitles(const Value: TStrings);
    procedure SetVisible(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Titles: TStrings read FTitles write SetTitles;
    property Visible: boolean read FVisible write SetVisible;
  end;

  TMedpIWComboRow = class(TCollectionItem)
  private
    FVisible: Boolean;
    FRowData: TStringList;
    procedure SetRowData(const Value: TStringList);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property RowData : TStringList read FRowData write SetRowData;
  end;

  TMedpIWComboRows = class(TCollection)
  private
    FOwner: TMedpIWMultiColumnComboBox;
    function GetItem(Index: Integer): TMedpIWComboRow;
    procedure SetItem(Index: Integer; const Value: TMedpIWComboRow);
  public
    constructor Create(AOwner: TMedpIWMultiColumnComboBox);
    function Add: TMedpIWComboRow;
    procedure Clear;
    property Items[Index: Integer]: TMedpIWComboRow read GetItem write SetItem; default;
  end;

  TMedpIWMultiColumnComboBox = class(TIWCustomEdit)
  private
    FPopUpHeight: Integer;
    FPopUpWidth: Integer;
    FLookupAfterChars: Integer;
    FText: string;
    FColCount: Integer;
    FComboRows: TMedpIWComboRows;
    FCaseSensitiveLookUp: Boolean;
    FCustomElement: Boolean;
    FColumnTitles: TMedpIWColumnTitles;
    FColumnSeparator: char;
    FItemIndexl: Integer;
    FOnChange: TMedpIWMultiColumnComboBoxEvent;
    FOnAsyncChange: TMedpAsyncIWMultiColumnComboBoxEvent;
    FContextMenu: TPopupMenu;
    FAutoResetItems: Boolean;
    FCssInputText: String;
    FCssPopup: String;
    FLookupColumn,FCodeColumn: Integer;
    FRefreshList: boolean;
    isIE9: boolean;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);

    procedure SetColcount(const Value: integer);
    procedure SetItemIndex(const Value: integer);

    procedure SetColumnTitles(const Value: TMedpIWColumnTitles);
    procedure SetText(const Value: string);

  protected
    procedure SetValue(const value:string); override;
    procedure Submit(const AValue:string); override;
    function get_ShouldRenderTabOrder: Boolean; override;
    procedure DoAsyncChange(AParams: TStringList);
    function GetHTMLTable(async: boolean): String;
  public
    medpTag: TObject;
    procedure RefreshData;
    procedure IWPaint; override;
    procedure LoadItems(list: TStringList);
    function get_HasTabOrder: boolean; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddRow(a: string): string;
  published
    property Enabled;
    property LookupAfterChars: Integer read FLookupAfterChars write FLookupAfterChars default 0;
    property PopUpHeight: Integer read FPopUpHeight write FPopUpHeight;
    property PopUpWidth: Integer read FPopUpWidth write FPopUpWidth;
    property Text: string read FText write SetText;
    property ColCount: integer read FColCount write SetColCount;
    property Items: TMedpIWComboRows read FComboRows write FComboRows;
    property CaseSensitiveLookUp: Boolean read FCaseSensitiveLookUp write FCaseSensitiveLookUp default false;
    property CustomElement: Boolean read FCustomElement write FCustomElement default false;
    property ColumnTitles: TMedpIWColumnTitles read FColumnTitles write SetColumnTitles;
    property ColumnSeparator: char read FColumnSeparator write FColumnSeparator default ';';
    property ItemIndex: integer read FItemIndexl write SetItemIndex default -1;
    property OnChange: TMedpIWMultiColumnComboBoxEvent read FOnChange write FOnChange;
    property OnAsyncChange: TMedpAsyncIWMultiColumnComboBoxEvent read FOnAsyncChange write FOnAsyncChange;
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property medpAutoResetItems: Boolean read FAutoResetItems write FAutoResetItems;
    property CssInputText:String read FCssInputText write FCssInputText;
    property CssPopup: String read FCssPopup write FCssPopup;
    property LookupColumn:Integer read FLookupColumn write FLookupColumn;
    property CodeColumn:Integer read FCodeColumn write FCodeColumn;
  end;

implementation

{ TTComboRow }
constructor TMedpIWComboRow.Create(Collection: TCollection);
begin
  inherited;
  FVisible:=True;
  FRowData:=TStringList.Create;
end;

procedure TMedpIWComboRow.SetRowData(const Value: TStringList);
begin
  FRowData.Assign(Value);
end;

destructor TMedpIWComboRow.Destroy;
begin
  FRowData.Free;
  inherited;
end;

{ TTComboRows }
procedure TMedpIWComboRows.Clear;
begin
  inherited Clear;
  FOwner.Invalidate;
  FOwner.FRefreshList:=True;
end;

constructor TMedpIWComboRows.Create(AOwner: TMedpIWMultiColumnComboBox);
begin
  FOwner:=AOwner;
  inherited Create(TMedpIWComboRow);
end;

function TMedpIWComboRows.GetItem(Index: Integer): TMedpIWComboRow;
begin
  Result:=TMedpIWComboRow(inherited Items[Index]);
end;

function TMedpIWComboRows.Add: TMedpIWComboRow;
begin
  Result:=TMedpIWComboRow(inherited Add);
  FOwner.Invalidate;
  FOwner.FRefreshList:=True;
end;

procedure TMedpIWComboRows.SetItem(Index: Integer; const Value: TMedpIWComboRow);
begin
  inherited Items[Index]:=Value;
  FOwner.FRefreshList:=True;
end;

{ TTIWColumnTitles }

constructor TMedpIWColumnTitles.Create;
begin
  FTitles:=TStringList.Create;
  FVisible:=False;
end;

destructor TMedpIWColumnTitles.Destroy;
begin
  FTitles.Free;
  inherited;
end;

procedure TMedpIWColumnTitles.Assign(Source: TPersistent);
begin
  if not (Source is TMedpIWColumnTitles) then
    raise Exception.Create('Cannot assign Source to TTIWColumnTitles');

  with Source as TMedpIWColumnTitles do
  begin
    FTitles:=Titles;
    FVisible:=Visible;
  end;
end;

procedure TMedpIWColumnTitles.SetTitles(const Value: TStrings);
begin
  FTitles.Assign(Value);
end;

procedure TMedpIWColumnTitles.SetVisible(const Value: boolean);
begin
  FVisible:=Value;
end;

{ TTIWMultiColumnComboBox }
procedure TMedpIWMultiColumnComboBox.DoAsyncChange(AParams: TStringList);
begin
  if Assigned(OnAsyncChange) then
    OnAsyncChange(Self, AParams, ItemIndex, Text);
end;

constructor TMedpIWMultiColumnComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FNeedsFormTag:=True;
  FComboRows:=TMedpIWComboRows.Create(self);
  FText:='';
  FLookupAfterChars:=0;
  FCaseSensitiveLookUp:=false;
  FCustomElement:=false;
  FPopUpHeight:=15;
  FPopUpWidth:=0;

  FColumnTitles:=TMedpIWColumnTitles.Create;
  FColumnSeparator:=';';

  FItemIndexl:= -1;

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
    { DONE : TEST IW 15 }
    RenderBorder:=False;
  end;
  Css:='medpMultiColumnCombo';
  CssInputText:='medpMultiColumnComboBoxInput';
  CssPopup:='';
  NonEditableAsLabel:=False;
  FAutoResetItems:=True;
  LookupColumn:=0;

  FRefreshList:=True;
  if not (csDesigning in Self.ComponentState) then
  begin
    // Da eseguire solo a run time
    isIE9:=False;
    if (GGetWebApplicationThreadVar.Browser is TInternetExplorer) and
      (GGetWebApplicationThreadVar.Browser.MajorVersion = 9) then
    isIE9:=True;
  end;
end;

destructor TMedpIWMultiColumnComboBox.Destroy;
begin
  FComboRows.Free;
  FColumnTitles.Free;
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited;
end;

function TMedpIWMultiColumnComboBox.AddRow(a: string): string;
var
  su: string;
  ttr: TMedpIWComboRow;
  i: Integer;
begin
  ttr:=FComboRows.Add;
  i:=0;
  while (pos(ColumnSeparator,a) > 0) do
  begin
    su := copy(a,1,pos(ColumnSeparator,a) - 1);
    //SE l'elemento che si sta aggiungendo è = al text, imposto itemindex correttamente
    if i = FCodeColumn then
      if IfThen(FCaseSensitiveLookUp,su,UpperCase(su)) = FText then
        FItemIndexl:=FComboRows.Count-1;

    ttr.RowData.Add(StringReplace(su, '"', '&quot;', [rfReplaceAll]));
    delete(a,1,pos(ColumnSeparator,a));
    i:=i+1;
  end;

  //SE l'elemento che si sta aggiungendo è = al text, imposto itemindex correttamente
  if i = FCodeColumn then
    if IfThen(FCaseSensitiveLookUp,a,UpperCase(a)) = FText then
      FItemIndexl:=FComboRows.Count-1;
  ttr.RowData.Add(StringReplace(a, '"', '&quot;', [rfReplaceAll]));

  Invalidate;
end;

procedure TMedpIWMultiColumnComboBox.SetValue(const value:string);
var
  vp: integer;
  varvalue : string;
begin
  varvalue:=value;

  if Length(value) > 0 then
  begin
    vp:=Pos('~', varvalue);

    if vp > 0 then
    begin
      Delete(varvalue,vp,Length(varvalue) - vp + 1);
      ItemIndex:=StrToInt(varvalue);
      inherited SetValue(varvalue);
    end;

    if (ItemIndex = -1) then
    begin
      varvalue:=value;
      Delete(varvalue,1,3);
      Text:=varvalue;
    end;
  end;
end;

procedure TMedpIWMultiColumnComboBox.Submit(const AValue: string);
begin
  inherited;

  if Assigned(FOnChange) then
    FOnChange(Self,StrToInt(AValue));
end;

procedure TMedpIWMultiColumnComboBox.SetColCount(const Value: Integer);
begin
  if (Value > 1) then
    FColCount:=Value
  else
    FColCount:=1;
  Invalidate;
end;

procedure TMedpIWMultiColumnComboBox.SetItemIndex(const Value: integer);
begin
  if FItemIndexl <> Value  then
    Invalidate; //forza render async

  FItemIndexl:=Value;
  if not isDesignMode then
    if (FItemIndexl >=0) and (FItemIndexl < Items.Count) then
      FText:=Items[FItemIndexl].RowData[FCodeColumn];
end;

procedure TMedpIWMultiColumnComboBox.SetText(const Value: string);
var
  i: Integer;
begin
  if FText <> Value  then
    Invalidate; //forza render async

  FText:=Value;
  //reperisco itemIndex corretto
  if not isDesignMode then
  begin
    FItemIndexl:=-1;
    if Items.Count > 0 then
      for i:=0 to Items.Count - 1 do
        //if UpperCase(Items[i].RowData[FCodeColumn]) = UpperCase(FText) then
        if IfThen(FCaseSensitiveLookup,Items[i].RowData[FCodeColumn],Items[i].RowData[FCodeColumn].ToUpper) = IfThen(FCaseSensitiveLookup,FText,FText.ToUpper) then
        begin
          if FItemIndexl <> i then
          begin
            FItemIndexl:=i;
            Invalidate;
          end;
          Break;
        end;
  end;

end;

procedure TMedpIWMultiColumnComboBox.SetColumnTitles(const Value: TMedpIWColumnTitles);
begin
  FColumnTitles.Assign(Value);
  Invalidate;
end;


function TMedpIWMultiColumnComboBox.get_HasTabOrder: boolean;
begin
  Result:=true;
end;

function TMedpIWMultiColumnComboBox.get_ShouldRenderTabOrder: Boolean;
begin
  Result:=false;
end;


procedure TMedpIWMultiColumnComboBox.IWPaint;
var
  R : TRect;
begin
  with Canvas do
  begin
    Rectangle(4,4,Width,20);
    r := Rect(Width - 18,4,Width,20);
    DrawFrameControl(Handle,r, DFC_SCROLL,DFCS_SCROLLCOMBOBOX );
  end;

end;

procedure TMedpIWMultiColumnComboBox.LoadItems(list: TStringList);
var i:Integer;
begin
  for i := 0 to List.Count - 1 do
    AddRow(list[i]);
end;

function TMedpIWMultiColumnComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

//Attenzione non aggiungere #13 alla stringa altrimenti in render async vi sono problemi
function TMedpIWMultiColumnComboBox.GetHTMLTable(async: boolean): String;
var
  r, c: Integer;
  quote,st: String;
  function DoubleQuotes(val:String) : String;
  begin
    Result:=quote + val + quote;
  end;
begin
  if async then
   quote:='\"'
  else
   quote:='"';

  //Caratto 15/05/2014
  //bug IE9 con div e max-height. il div si ingrandisce muovendo il mouse sulla tendina
  //Se larghezza popup non impostata devo mettere margin-right a table per evitare scroll su overflow-x
  st:='';
  if (IsIE9) and
     (PopUpHeight > 0 ) and
     (PopUpWidth = 0) then
  begin
    st:='style="margin-right:1.5em !important"; ';
  end;

  Result:= '<table ' + st + 'id='+DoubleQuotes(HTMLName +'tbl')+' class='+DoubleQuotes('medpMultiColumnComboTable')+' >';
    (* todo intestazioni colonne
    if ColumnTitles.Visible then
      begin
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
    *)
  for r:=0 to items.Count-1 do
  begin
    Result:=Result + '<tr id='+DoubleQuotes(HTMLName +'R'+inttostr(r))+' onmouseup = '+DoubleQuotes('MEChangeEditValue('+ HTMLName +'obj,' + IntToStr(r) + ')')+' onmousemove ='+DoubleQuotes(HTMLName+'obj.DelayBlur=true;MEShowHighLighted('+ inttostr(r) +','+HTMLName+'obj)') +' onmouseout = '+DoubleQuotes(HTMLName+'obj.DelayBlur=false;MEShowUnHighLighted('+ inttostr(r) +','+HTMLName+'obj)')+'>';
//    Result:=Result + '<tr id='+DoubleQuotes(HTMLName +'R'+inttostr(r))+' onmouseup = '+DoubleQuotes('MEChangeEditValue('+ HTMLName +'obj,' + IntToStr(r) + ')')+' onmousemove ='+DoubleQuotes('MEShowHighLighted('+ inttostr(r) +','+HTMLName+'obj)') +'>';
    for c:=0 to ColCount-1 do
    begin
      Result:=Result
             + '<td id='+DoubleQuotes(HTMLName +'R'+inttostr(r)+'C'+ IntToStr(c))+'>'
             // correzione 23.04.2014.ini
             // escape di apici e doppi apici - escape non necessario nell'innerhtml
             // + items[r].RowData[c]
             // v1. soluzione che fa escape dei caratteri
             //     è la funzione utilizzata da intraweb normalmente
             + TextToHTML(items[r].RowData[c])
             // v2. soluzione che aggiunge il backslash ad apici e doppi apici
             //     anche se la teoria sembra a favore di questa soluzione, in realtà
             //     non è sufficiente perché alcuni caratteri danno fastidio
             //+ items[r].RowData[c].Replace('''','\''',[rfReplaceAll]).Replace('"','\"',[rfReplaceAll])
             // correzione 23.04.2014.fine
             + '</td>';
    end;
    Result:=Result + '</tr>';
  end;
  Result:=Result + '</table>'
end;

procedure TMedpIWMultiColumnComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TMedpIWMultiColumnComboBox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  js, htmlres, disab, itemValue,buttonClass: string;
begin
  Result := TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', 'TTIWMULTICOLUMNCOMBOBOX');
    RenderAsyncCommonProperties( AContext, Result );

    ItemValue:=Text;
    if (ItemIndex >=0) and (ItemIndex < Items.Count) then
      ItemValue:=Items[ItemIndex].RowData[FCodeColumn]
    else
      ItemIndex:=-1;

    if (FRefreshList) then
      htmlres:=GetHTMLTable(True);

    js:='<![CDATA[';
    js:=js + '$("#' + HTMLName+'DIV").removeClass().addClass("' + css + '"); ' + #13#10;

    if FRefreshList then
    begin
      js:=js+ 'var lookup = document.getElementById("' + HTMLName + 'popup");' + #13#10
        + 'if (lookup)' + #13#10
        + '  lookup.innerHTML = "' + htmlres + '";' + #13#10
    end;

    js:=js+ 'if (!(typeof '+HTMLName +'obj === "undefined"))'
      + '{'#13
      +  HTMLName+'obj.ItemIndex = '+ IntToStr(ItemIndex) +';'#13
      +  HTMLName+'obj.RCount = '+ IntToStr(Items.Count) +';'#13
      +  HTMLName+'obj.Editable = '+ iif(not ReadOnly and Editable and Enabled,'true','false') +';' + #13
      +  HTMLName+'obj.PostedText = "' + Text+ '";' + #13;


    if (Self.Enabled) and not (Self.ReadOnly) then
    begin
      Disab:='false';
      buttonclass:='medpMultiColumnComboBoxButton noTabOrder';
    end
    else
    begin
      Disab:='true';
      buttonclass:='medpMultiColumnComboBoxButton_disabled noTabOrder';
    end;

    js := js
      + '}'#13
      + 'var hi = FindElem("' + HTMLName + '_INPUT");'#13
      + 'if (hi)'#13
      + '  hi.value = "'+ IntToStr(ItemIndex) + '~' + itemValue + '";'#13
      + 'var el = document.getElementById("' + HTMLName + '");'#13
      + 'if (el){'#13
      + '  el.value = "' + itemValue + '";'#13
      //make sure quotes instead of &quot; are displayed in the edit box
      + '  el.value = el.value.replace(/&quot;/g, ''"'');'#13
      + '  el.disabled='+ Disab + '; '+#13
      + '  var elb=document.getElementById("'+HTMLName+'button"); '#13
      + '  if (elb != null) {elb.disabled='+ Disab +'; elb.className="' + buttonclass + '";} '#13
      + '}'#13
      +']]>';

    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(js);
    FRefreshList:=False;
  except
    FreeAndNil(Result);
  end;
end;

function TMedpIWMultiColumnComboBox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  htmlres,InitText,S: string;
   function MakeJavascriptObject: string;
   begin
     Result:='<Script Language="JavaScript">' + #13#10 +
             'var '+HTMLName+'obj = new Object();' + #13#10 +
             HTMLName+'obj.ID = "'+HTMLName+'";' + #13#10 +
             HTMLName+'obj.popupHeight = '+ IntToStr(PopUpHeight) +';' + #13#10 +
             HTMLName+'obj.HighLightedRow = -1;' + #13#10 +
             HTMLName+'obj.CCount = '+IntToStr(ColCount - 1) +';' + #13#10 +
             HTMLName+'obj.RCount = '+IntToStr(items.Count) + ';' + #13#10 +
             HTMLName+'obj.ItemIndex = '+ IntToStr(ItemIndex) +';' + #13#10 +
             HTMLName+'obj.UsedKeyb = false;' + #13#10 +
             HTMLName+'obj.DoCase = '+ iif(FCaseSensitiveLookUp,'true','false') + ';' + #13#10 +
             HTMLName+'obj.CodeColumn = '+ IntToStr(FCodeColumn) +';' + #13#10 +
             HTMLName+'obj.LookupColumn = '+ IntToStr(FLookupColumn) +';' + #13#10 +
             HTMLName+'obj.OnChange = '+ iif(Assigned(Self.OnChange),'true','false') +';' + #13#10 +
             HTMLName+'obj.OnAsyncChange = '+ iif(Assigned(Self.OnAsyncChange),'true','false') +';' + #13#10 +
             HTMLName+'obj.IWCLName = "'+ HTMLControlImplementation.IWCLName +'";' + #13#10 +
             HTMLName+'obj.PostedText = "' + Self.Text+ '";' + #13#10 +
             HTMLName+'obj.DoHide = 0;' + #13#10 +
             HTMLName+'obj.DoSubmit = true;' + #13#10 +
             HTMLName+'obj.DelayBlur = false;' + #13#10 +
             HTMLName+'obj.CustomElement = '+ iif(FCustomElement,'true','false') + ';' + #13#10 +
             HTMLName+'obj.Editable = '+ iif(not ReadOnly and Editable and Enabled,'true','false') + ';' + #13#10 +

             '</script>';
    if Assigned(Self.OnAsyncChange) then
      Acontext.WebApplication.RegisterCallBack(HTMLName+'.DoAsyncChange', DoAsyncChange);
  end;

begin
  InitText:=Text;
  if (ItemIndex >=0) and (ItemIndex < Items.Count) then
    InitText:=Items[ItemIndex].RowData[FCodeColumn];

  //input
  htmlres:=MakeJavascriptObject
     + '<input ' + IIF(Editable and Enabled,'','disabled ') + 'type="text" name="' + HTMLName +'_TEXT"'
     + ' class="'+ cssInputText +'" id="' + HTMLName +'"'
     + IIF(MaxLength > 0, ' maxlength=' + IntToStr(MaxLength))
     + IIF(ReadOnly, ' readonly', '')
     + ' value="' + InitText + '"'
     + ' onKeyPress="return MEKeypress(' + HTMLName +'obj,event);"'
     + ' onKeyUp="MEKeyup(event,' + IntToStr(LookupAfterChars)+','+HTMLName+'obj);" '
     + ' onBlur="MEBlur(' + HTMLName+ 'obj);MEDocMouseUp('+HTMLName+'obj);"'
		 + ' onKeyDown="MEKeyDown(event,'+HTMLName+'obj)"'
     + ' autocomplete="off" />';
  //pulsante
  htmlres:=htmlres
          + '<input type="button" id="'+ HTMLName + 'button" '+IIF(Enabled and not Readonly,'class="medpMultiColumnComboBoxButton noTabOrder"',' class="medpMultiColumnComboBoxButton_disabled noTabOrder" disabled ')+' onclick="MEShowLookUp(null,' + HTMLName + 'obj)"/>'
          + '<br>';

  //checklist
  htmlres:=htmlres
         + '<div id="'+HTMLName+'checklist" class="medpMultiColumnComboBoxChecklist" style="display:none" onMouseDown="MEResetdoc('+HTMLName+'obj);">';

  //Caratto 15/05/2014
  //bug IE9 con div e max-height. il div si ingrandisce muovendo il mouse sulla tendina
  //Se larghezza impostata devo mettere overflow-x a scroll perchè con atuo genera bug

  S:='';
  if PopUpHeight > 0 then
    S:='max-height:'+inttostr(PopUpHeight)+'em;';

  if PopUpWidth > 0 then
  begin
    S:=S + 'width:'+inttostr(PopUpWidth)+'em;';
    if isIE9 then
      S:=S + 'overflow-x:scroll !important;';
  end;

  if S <>'' then
    S:='style="'+S+'"';
  //popup
  htmlres:=htmlres
       + '<div id="'+HTMLName+'popup" class="medpMultiColumnComboBoxPopup ' + FCssPopup + '" ' + S + '>'
       + getHTMLTable(false)
       + '</div>'   //popup
       + '</div>';  //checklist

  FRefreshList:=False;
  Result:=TIWHTMLTag.CreateTag('DIV');
  Result.AddStringParam('id',HTMLName+'DIV');
  Result.Contents.AddText(htmlres);

  with Result.Contents.AddTag('INPUT') do
  begin
    AddStringParam('TYPE','hidden');
    AddStringParam('NAME',HTMLName+'');
    AddStringParam('ID',HTMLName+'_INPUT');
    AddStringParam('VALUE', IntToStr(ItemIndex) + '~' + Text);
  end;
end;

procedure TMedpIWMultiColumnComboBox.RefreshData;
begin
  //serve per forzare il settaggio di itemIndex
  Text:=Text;
  //se itemindex = -1 vuol dire che l'elemento sul quale ero posizionato è stato cancellato
  if (ItemIndex = -1) and (CustomElement = False) then
  begin
    Text:='';
    if Assigned(OnAsyncChange) then
      OnAsyncChange(Self, nil, ItemIndex, Text);
    if Assigned(OnChange) then
        FOnChange(Self,ItemIndex);
  end;
end;

end.

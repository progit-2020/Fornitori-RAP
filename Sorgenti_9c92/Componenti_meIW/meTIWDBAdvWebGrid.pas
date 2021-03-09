unit meTIWDBAdvWebGrid;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWWebGrid, IWDBAdvWebGrid,IWRenderContext,IWHTMLTag,IWXMLTag,
  IWTMSBase,IWMarkupLanguageTag,IW.Common.System,Graphics,IWColor;

type
  TmeTIWDBAdvWebGrid = class(TTIWDBAdvWebGrid)
  private
    { Private declarations }
  protected
    function FixController(HTMLText : String) :String;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
    function RenderAsync(AContext: TIWBaseHTMLComponentContext): TIWXMLTag; override;
    function getColumnIndex(Campo: String): Integer;
  published
    { Published declarations }
  end;

implementation

uses IWApplication;

{ TmeTIWDBAdvWebGrid }

constructor TmeTIWDBAdvWebGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AsyncPaging:=True;
  with Bands do
  begin
    Active:=true;
    PrimaryColor:=clWebWHITE;
    SecondaryColor:=clWebWHITE;
  end;
  with Controller do
  begin
    Font.Enabled:=false;
    ImgFirstURL:='img/btnPrimo.png';
    ImgLastURL:='img/btnUltimo.png';
    ImgNextURL:='img/btnSuccessivo.png';
    ImgPrevUrl:='img/btnPrecedente.png';
    IndicatorFormat:='medpPagerFormat';
    IndicatorType:=itPageNr;
    Pager:=cpPrevNextFirstLast;
    PagerType:=cptImage;
    Position:=cpTop;
    ShowPagersAlways:=True;
    RowCountSelect:=False;
    ShowFind:=False;
    TextFirst:='Prima';
    TextLast:='Ultima';
    TextNext:='Successiva';
    TextPrev:='Precedente';
  end;
  css:='grid';
  RenderStyleTag:=False;
  Font.Enabled:=False;
  RowCount:=20;
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
end;

function TmeTIWDBAdvWebGrid.FixController(HTMLText: String):String;
var sclickfirst,sclickprev,sclicknext,sclicklast,ctrltext:String;
    IWHTMLTag:TIWHTMLTag;
    Part1,Part2,Temp,UpperHTMLText,PageIndicator:String;
    Index1,Index2:Integer;
begin
  Result:=HTMLText;

  PageIndicator:='<span id="pagNum'+HTMLName +'" class="contatorePg">Pagina %d di %d</span>'+
                 '<span id="recNum'+HTMLName+'" style="float:right;" class="contatoreRec align_right">Record %d - %d di %d</span>';


  HTMLText:=Stringreplace(HTMLText,'medpPagerFormat',Format(PageIndicator,[(RowOffset div RowCount) + 1, ((RowTot - 1) div RowCount) + 1,RowOffset + 1,RowOffset+RowCount, RowTot]) ,[rfReplaceAll]);
  Result:=HTMLText;

  //Caratto 11/09/2012. BUG tms nel caso di paginazione con image e showPagersAlways
  //non fa vedere sempre tutti i pulsanti. Segnalato TMS.
  if (Controller.PagerType = cptImage) and
     (Controller.Pager = cpPrevNextFirstLast) and
     (Controller.ShowPagersAlways) then
  begin
    UpperHTMLText:=UpperCase(HTMLText);
    //SE NON CI SONO SPAN (PULSANTI PAGINAZIONE) ESCO
//    if (Pos(UpperCase('<span'),UpperHTMLText) = 0 ) then exit;

    //se sono sulla prima pagina e ci sono altre pagine. (aggiungo first e previous che mancano)
    if (RowOffset = 0) and ((RowOffset + RowCount) < RowTot) then
    begin
      //FIRST
      sclickfirst := SubmitCall('First');
      if AsyncPaging then
        sclickfirst:='"processAjaxEvent(''onFirstPage'', '
                      + HTMLControlImplementation.IWCLName
                      + ',''' + HTMLName + '.' + 'DoAsyncFirstPage' + ''','
                      + 'true' + ', null, '
                      + 'true' + ');"';

      ctrltext:='<span onclick=' + sclickfirst + ' '+ IIF(Controller.HintFirst = '', 'title="' + Controller.TextFirst + '"', 'title="' + Controller.HintFirst + '"')+'>';

      if Controller.ImgFirstURL <> EmptyStr then
      begin
        IWHTMLTag:=ImageHTML(Controller.ImgFirstURL, 0, 0, False, '');
        ctrltext:=ctrltext + IWHTMLTag.Render;
        IWHTMLTag.Free;
      end
      else
        ctrltext:=ctrltext + OutputPic('GRFIRST', Controller.ImgFirst, False, Controller.HintFirst);

      ctrltext:=ctrltext + '</span>';
      //PREV
      sclickprev := SubmitCall('Prev');
      if AsyncPaging then
        sclickprev:='"processAjaxEvent(''onPrevPage'', '
                    + HTMLControlImplementation.IWCLName
                    + ',''' + HTMLName + '.' + 'DoAsyncPrevPage' + ''','
                    + 'true' + ', null, '
                    + 'true' + ');"';
      ctrltext:=ctrltext + '<span onclick=' + sclickprev + ' '+ IIF(Controller.HintPrev = '', 'title="' + Controller.TextPrev + '"', 'title="' + Controller.HintPrev + '"')+'>';

      if Controller.ImgPrevURL <> EmptyStr then
      begin
        IWHTMLTag:=ImageHTML(Controller.ImgPrevURL, 0, 0, False, '');
        ctrltext:=ctrltext + IWHTMLTag.Render;
        IWHTMLTag.Free;
      end
      else
        ctrltext:=ctrltext + OutputPic('GRPREV', Controller.ImgPrev, False, Controller.HintPrev);

      ctrltext:=ctrltext + '</span>';

      //aggiunta degli span al codice html
      Index1:=Pos(UpperCase('TD id="' + HTMLNAME + 'CTRLT'+ '"'),UpperHTMLText);

      Temp:=Copy(UpperHTMLText,Index1,Length(UpperHTMLText) - Index1);
      Index2:=Pos(UpperCase('<span'),Temp) + Index1;
      //nel caso di async non esiste td + htmlname. devo aggiungere 1 per corretto spezzettamento stringa
      if (Index1 = 0) then Index2:=Index2+1;

      Part1:=Copy(HTMLText,0,Index2 - 2);
      Part2:=Copy(HTMLText,Index2-1,Length(HTMLText));
      Result:=Part1 + ctrltext + Part2;
    end
    else if ((RowOffset + RowCount) >= RowTot) and (RowOffset > 0) then //se sono sull'ultima pagina mancano next e last
    begin
      //NEXT
      sclicknext := SubmitCall('Next');

      if AsyncPaging then
        sclicknext:='"processAjaxEvent(''onNextPage'', '
                      + HTMLControlImplementation.IWCLName
                      + ',''' + HTMLName + '.' + 'DoAsyncNextPage' + ''','
                      + 'true' + ', null, '
                      + 'true' + ');"';

      ctrltext:='<span onclick=' + sclicknext  + ' '+ IIF(Controller.HintNext = '', 'title="' + Controller.TextNext + '"', 'title="' + Controller.HintNext + '"')+'>';

      if Controller.ImgNextURL <> EmptyStr then
      begin
        IWHTMLTag:=ImageHTML(Controller.ImgNextURL, 0, 0, False, '');
        ctrltext:=ctrltext + IWHTMLTag.Render;
        IWHTMLTag.Free;
      end
      else
        ctrltext:=ctrltext + OutputPic('GRNEXT', Controller.ImgNext, False, Controller.HintNext);

      ctrltext:=ctrltext + '</span>';

      //LAST
      sclicklast := SubmitCall('Last');
      if AsyncPaging then
        sclicklast:='"processAjaxEvent(''onLastPage'', '
                      + HTMLControlImplementation.IWCLName
                      + ',''' + HTMLName + '.' + 'DoAsyncLastPage' + ''','
                      + 'true' + ', null, '
                      + 'true' + ');"';

      ctrltext:=ctrltext + '<span onclick=' + sclicklast + ' '+ IIF(Controller.HintLast = '', 'title="' + Controller.TextLast + '"', 'title="' + Controller.HintLast + '"')+'>';

      if Controller.ImgLastURL <> EmptyStr then
      begin
        IWHTMLTag:=ImageHTML(Controller.ImgLastURL, 0, 0, False, '');
        ctrltext:=ctrltext + IWHTMLTag.Render;
        IWHTMLTag.Free;
      end
      else
        ctrltext:=ctrltext + OutputPic('GRLAST', Controller.ImgLast, False, Controller.HintLast);

      ctrltext:=ctrltext + '</span>';

      //aggiunta degli span al codice html
      Index1:=Pos(UpperCase('TD id="' + HTMLNAME + 'CTRLT'+ '"'),UpperHTMLText);
      Temp:=Copy(UpperHTMLText,Index1,Length(UpperHTMLText) - Index1);
      //span di first
      Index2:=Pos(UpperCase('</span'),Temp) + Index1;
      //nel caso di async non esiste td + htmlname. devo aggiungere 1 per corretto spezzettamento stringa
      if (Index1 = 0) then Index2:=Index2+1;
      //span di prev
      Temp:=Copy(UpperHTMLText,Index2,Length(UpperHTMLText) - Index2);
      Index1:=Pos(UpperCase('</span'),Temp) + Index2;

      //DEVO AGGIUNGERE 7 (lunghezza di </span>)
      Index1:=Index1+7;

      Part1:=Copy(HTMLText,0,Index1 - 2);
      Part2:=Copy(HTMLText,Index1-1,Length(HTMLText));
      Result:=Part1 + ctrltext + Part2;
    end;
  end;
end;

function TmeTIWDBAdvWebGrid.getColumnIndex(Campo: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Columns.Count - 1 do
    if UpperCase(Columns[i].DataField) = UpperCase(Campo) then
    begin
      Result:=i;
      Break;
    end;
end;

function TmeTIWDBAdvWebGrid.RenderAsync(
  AContext: TIWBaseHTMLComponentContext): TIWXMLTag;
var FAsyncSetCtrl : String;
begin
  Result :=inherited;

 //Async Controller Update
  FAsyncSetCtrl := GetController(IsBrowserIE(AContext),true,true);
  FAsyncSetCtrl:=FixController(FAsyncSetCtrl);
  FAsyncSetCtrl := StringReplace(FAsyncSetCtrl, '"', '\"', [rfReplaceAll]);
  if FAsyncSetCtrl <> EmptyStr then
  begin
    FAsyncSetCtrl := '<![CDATA[GASetCtrl(' + HTMLName + 'Obj, "' + FAsyncSetCtrl + '");]]>';
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(FAsyncSetCtrl);
    FAsyncSetCtrl := EmptyStr;
  end;
end;

function TmeTIWDBAdvWebGrid.RenderHTML( AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText,Part1,Part2,Temp,UpperHTMLText,FOrigCtrl,FNewCtrl   : String;
  i,Index1,Index2  : Integer;
begin
  Result:=inherited;
  HTMLText:=Result.Contents[0].Render;
  FOrigCtrl:=GetController(IsBrowserIE(AContext),False,true);
  FNewCtrl:=FixController(FOrigCtrl);
  HTMLText:=StringReplace(HTMLText, FOrigCtrl, FNewCtrl, [rfReplaceAll]);

  //usata per rendere case insensitive le ricerche
  UpperHTMLText:=UpperCase(HTMLText);
  (*Caratto 11/09/2012
    Settaggio class riga_intestazione per gli headers delle colonne
  *)
  for I := 1 to Columns.Count do
  begin
    //cerco id colonna e sostituisco tutto con class del css
    Index1:=Pos(UpperCase('id="' + IDS + 'CH'+ IntToStr(i) + '"'),UpperHTMLText);
    Temp:=Copy(UpperHTMLText,Index1,Length(UpperHTMLText) - Index1);
    Index2:=Pos('>',Temp) + Index1;

    Part1:=Copy(HTMLText,0,Index1 - 1);
    Part2:=Copy(HTMLText,Index2-1,Length(HTMLText));
    HTMLText:=Part1 + ' id="'+ IDS + 'CH'+ IntToStr(i)+ '" class="riga_intestazione" ' + Part2;
    UpperHTMLText:=UpperCase(HTMLText);
  end;

//  HTMLText:=FixController(HTMLText);
  TIWTextElement(Result.Contents[0]).Text:=HTMLText;
end;

end.

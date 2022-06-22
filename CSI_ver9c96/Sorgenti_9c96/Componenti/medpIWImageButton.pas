unit medpIWImageButton;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,IWApplication,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWTypes, IW.Common.Strings,
  IWRenderContext,IWHTMLTag, IWXMLTag,meIWImageFile,IWUtils,IWGlobal,IWScriptEvents;

  type
    TmedpIWImageButton = class(TmeIWImageFile) //eredita da meIWImageFile per ereditare la proprieta DownloadButton
    private
      FCaption: String;
      FDown: Boolean;
      function  GetDown: Boolean;
      procedure SetDown(const PValue: Boolean);
    protected
      function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
      procedure HookEvents(AContext: TIWPageContext40; AScriptEvents: TIWScriptEvents); override;
    public
      constructor Create(AOwner: TComponent); override;
      function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    published
      property Caption:String read FCaption write FCaption;
      property Down: Boolean read GetDown write SetDown default False;
  end;

implementation

constructor TmedpIWImageButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Enabled:=False;
  RenderSize:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
	{ DONE : TEST IW 15 OK }
    RenderBorder:=False;
  end;

  UseSize:=False;
end;

function TmedpIWImageButton.GetDown: Boolean;
begin
  Result:=FDown;
end;

procedure TmedpIWImageButton.SetDown(const PValue: Boolean);
begin
  FDown:=PValue;
  {
  if FDown then
  begin
    // pulsante premuto
  end
  else
  begin
    // pulsante non premuto
  end;
  }
end;

procedure TmedpIWImageButton.HookEvents(AContext: TIWPageContext40;
  AScriptEvents: TIWScriptEvents);
var
  sClick: String;
  SaveDownloadButton: Boolean;
begin
//  if (Enabled) and (HasOnClick) then
  if HasOnClick then
   begin
    if not IsDesignMode then
    begin
      //la hookEvent deve essere fatta anche se disabilitato perchè se un evento async abilita il
      //componente, questo non avrebbe l'evento click;
      //per evitare che venga fatto subimit quando componente disabilitato aggiungo test sulla classe nell'evento javascript
      sClick:='if ($("#'+HTMLName+'_DIV").hasClass("pulsante_img_disabled")) { return false; } ' +
              'else { ';
      if FDownloadButton then
        sClick:= sClick + ' ReleaseLock(); GActivateLock=false; ';

      sClick:=sClick + AScriptEvents.Values['OnClick'];
      sClick:=sClick + ' ' + SubmitHandler; //aggiungo submitclickConfirm sull'evento onClick
      sClick:=sClick + '}';
      AScriptEvents.HookEvent('OnClick', sClick);
    end;
  end;
  //in inherited duplicazione codice per FDownloadButton ed errore in IE
  //devo comunque richiamare inherited per poter associare correttamente tutti gli eventi
  SaveDownloadButton:=FDownloadButton;
  FDownloadButton:=False;
  inherited;
  FDownloadButton:=SaveDownloadButton;
end;

function TmedpIWImageButton.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  Js,
  FSrc,
  sEnab,
  sDisab,
  sPressed: String;
begin
  Result:=TIWXMLTag.CreateTag('control');
  try
    Result.AddStringParam('id', HTMLName);
    Result.AddStringParam('type', 'TmedpIWImageButton');

    RenderAsyncCommonProperties( AContext, Result );

    //cambio classe div per pulsante abilitato / disabilitato
    if Self.Enabled then
    begin
      sEnab:='true';
      sDisab:='false';
    end
    else
    begin
      sEnab:='false';
      sDisab:='true';
    end;
    Js:='$("#'+HTMLName+'_DIV").toggleClass("pulsante_img",' + sEnab + '); '+
        '$("#'+HTMLName+'_DIV").toggleClass("pulsante_img_disabled",' + sDisab + '); ';

    // cambio classe div per pulsante premuto / non premuto
    if Self.Down then
      sPressed:='true'
    else
      sPressed:='false';
    Js:=Js + '$("#'+HTMLName+'_DIV").toggleClass("pressed",' + sPressed +  '); ';

    //cambio caption
    Js:=Js + '$("#'+HTMLName+'_SPAN").html("'+ FCaption +'"); ';

    //cambio immagine
    if IsLibrary then
      FSrc:=ImageFile.Location(IWStringReplace(GGetWebApplicationThreadVar.InternalURLBase, '/$', '') + '/')
    else
      FSrc:=ImageFile.Location(gSC.URLBase);

    Js:=Js + '$("#'+HTMLName+'_IMG").attr("src","'+ FSrc +'"); ';

    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Js);
  except
    raise;
  end;
end;

function TmedpIWImageButton.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  FSrc,
  ClassAttr: String;
  FTagIMG,
  FTagSPAN,
  FTagDIV,FTagInnerDIV: TIWHTMLTag;
begin

  //tag DIV di IMG e SPAN ( il tag IMG nel render considera anche lo SPAN)
  FTagDIV:=TIWHTMLTag.CreateTag('DIV');
  FTagDIV.AddStringParam('NAME', HTMLName);
  FTagDIV.AddStringParam('ID', HTMLName);

  FTagInnerDIV:=TIWHTMLTag.CreateTag('DIV');
  FTagInnerDIV.AddStringParam('ID', HTMLName+'_DIV');

  // prepara attributo class
  ClassAttr:='';
  // proprietà Enabled: pulsante abilitato / disabilitato
  if not Enabled then
    ClassAttr:=ClassAttr + ' pulsante_img_disabled'
  else
    ClassAttr:=ClassAttr + ' pulsante_img';
  // proprietà Down: pulsante premuto
  if Down then
    ClassAttr:=ClassAttr + ' pressed';

  ClassAttr:=Trim(ClassAttr);
  FTagInnerDIV.AddStringParam('CLASS',ClassAttr);

  if IsLibrary then
    FSrc:=ImageFile.Location(IWStringReplace(GGetWebApplicationThreadVar.InternalURLBase, '/$', '') + '/')
  else
    FSrc:=ImageFile.Location(gSC.URLBase);
  //tag IMG
  FTagIMG:=TIWHTMLTag.CreateTag('IMG');
  FTagIMG.AddStringParam('SRC', FSrc);
  FTagIMG.AddStringParam('ID', HTMLName+'_IMG');
  FTagIMG.AddStringParam('ALT', AltText);
  //tag SPAN fratello di img
  FTagSPAN:=TIWHTMLTag.CreateTag('SPAN');
  FTagSPAN.AddStringParam('ID', HTMLName+'_SPAN');
  FTagSPAN.AddStringParam('CLASS', 'intestazione');
  FTagSPAN.Contents.AddText(FCaption);
  FTagIMG.Contents.AddTagAsObject(FTagSPAN, false);

  FTagInnerDIV.Contents.AddTagAsObject(FTagIMG, false);
  FTagDIV.Contents.AddTagAsObject(FTagInnerDIV, false);
  Result:=FTagDIV;
end;

end.

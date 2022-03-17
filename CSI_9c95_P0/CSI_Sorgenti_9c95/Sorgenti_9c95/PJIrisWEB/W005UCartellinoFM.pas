unit W005UCartellinoFM;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWAppForm, IWApplication,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  DB, DBClient,
  A000UInterfaccia, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  W005UCartellino, IWCompJQueryWidget, meIWButton, C180FunzioniGenerali;

type
  TW005FCartellinoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    btnChiudi: TmeIWButton;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    dsrRiep: TDataSource;
    cdsRiep: TClientDataSet;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    W005FCartellino: TW005FCartellino;
    WFormParent: TR010FPaginaWeb;
  public
    Progressivo: Integer;
    Dal,Al: TDateTime;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TW005FCartellinoFM.IWFrameRegionCreate(Sender: TObject);
const
  FUNZIONE = 'W018DettaglioGG.IWFrameRegionCreate';
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  WFormParent:=(Self.Parent as TR010FPaginaWeb);
  WFormParent.Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW005FCartellinoFM.Visualizza;
var
  Titolo,Periodo: String;
const
  FUNZIONE = 'W018DettaglioGG.Visualizza';
begin
  WFormParent.Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  W005FCartellino:=TW005FCartellino.Create(GGetWebApplicationThreadVar,False);
  WFormParent.Log('Traccia',FUNZIONE + ': W005FCartellino creato');
  with W005FCartellino do
  begin
    SetParam('PROGRESSIVO',Progressivo);
    SetParam('DAL',Dal);
    SetParam('AL',Al);
    SetParam('SINGOLO',False);
    bDettaglioGG:=True;
    chkConteggi.Checked:=True;
    try
      if not InizializzaAccesso then
      begin
        btnChiudiClick(nil);
        Exit;
      end;
      grdRiepilogoSaldi.Parent:=IWFrameRegion;
      lblRiepilogoSaldiCaption.Parent:=IWFrameRegion;
      grdCartellino.Parent:=IWFrameRegion;
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(E.Message,ESCLAMA);
        btnChiudiClick(nil);
        Exit;
      end;
    end;
    if Dal = Al  then
      Periodo:=Format('del %s',[FormatDateTime('dd/mm/yyyy',Dal)])
    else
      Periodo:=Format('dal %s al %s',[FormatDateTime('dd/mm/yyyy',Dal),FormatDateTime('dd/mm/yyyy',Al)]);
    Titolo:=Format('Dettaglio giornaliero %s - %s %s',[Periodo,selAnagrafeW.FieldByName('COGNOME').AsString,selAnagrafeW.FieldByName('NOME').AsString]);
  end;
  WFormParent.VisualizzajQMessaggio(jQVisFrame,770,-1,EM2PIXEL * 10,Titolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
  WFormParent.Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW005FCartellinoFM.btnChiudiClick(Sender: TObject);
const
  FUNZIONE = 'W018DettaglioGG.btnChiudiClick';
begin
  WFormParent.Log('Traccia',FUNZIONE + ': inizio');
  W005FCartellino.ClosePage;
  WFormParent.Log('Traccia',FUNZIONE + ': fine (prima della Free)');
  Free;
end;

end.

unit W032UMotivazioneFM;

interface

uses
  W032URichiestaMissioniDM, R010UPaginaWeb,
  A000UCostanti, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  SysUtils, Classes, Controls, Forms, IWApplication, IWAppForm, IWTypes,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meIWButton,
  IWCompJQueryWidget;

type
  TW032FMotivazioneFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    edtMotivazione: TmeIWEdit;
    jQMotivazioni: TIWJQueryWidget;
    lblMotivazione: TmeIWLabel;
    lblErrore: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
  public
    W032DM: TW032FRichiestaMissioniDM;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia,
     W032URichiestaMissioni; // evita circular unit reference

procedure TW032FMotivazioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TW032FMotivazioneFM.Visualizza;
var
  Titolo,
  Motivazioni,
  Code: String;
begin
  // carica lista motivazioni annullamento
  Motivazioni:='';
  with W032DM.selT106 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      Motivazioni:=Motivazioni + '''' + AggiungiApice(FieldByName('DESCRIZIONE').AsString) + ''',';
      if FieldByName('CODICE_DEFAULT').AsString = 'S' then
        edtMotivazione.Text:=AggiungiApice(FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;

  // gestione jquery ui autocomplete
  if jQMotivazioni.Enabled then
  begin
    jQMotivazioni.OnReady.Clear;
    if Motivazioni <> '' then
    begin
      Code:='' +
        'var elementi = [' + Copy(Motivazioni,1,Length(Motivazioni) - 1) + ']; ' + CRLF +
        '$("#' + edtMotivazione.HTMLName +'").autocomplete({ ' + CRLF +
        '  source: elementi ' + CRLF +
        '}); ';
      jQMotivazioni.OnReady.Add(Code);
    end;
  end;

  Titolo:='Conferma annullamento missione';
  (Self.Owner as TR010FPaginaWeb).VisualizzajQMessaggio(jQVisFrame,350,-1,EM2PIXEL * 10,Titolo,'#' + Name,False,True);
end;

procedure TW032FMotivazioneFM.btnConfermaClick(Sender: TObject);
var
  Motiv: String;
begin
  Motiv:=Trim(edtMotivazione.Text);
  if Motiv = '' then
  begin
    lblErrore.Caption:='L''indicazione della motivazione è obbligatoria!';
    Exit;
  end;
  try
    (Self.Owner as TW032FRichiestaMissioni).ConfermaAnnullaMissione(Motiv);
  finally
    Free;
  end;
end;

procedure TW032FMotivazioneFM.btnAnnullaClick(Sender: TObject);
begin
  Free;
end;

end.

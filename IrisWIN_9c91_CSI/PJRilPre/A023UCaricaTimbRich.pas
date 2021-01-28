unit A023UCaricaTimbRich;

interface

uses
  A023UTimbratureMW,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, StdCtrls, Buttons,
  ExtCtrls, ActnList, ImgList, DB, ComCtrls, ToolWin,
  OracleData, Oracle, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, A023UTimbrature, A083UMsgElaborazioni,
  C012UVisualizzaTesto, C180FunzioniGenerali,
  C700USelezioneAnagrafe, R001UGESTTAB, R600Anomalie, System.Actions, Vcl.Mask,
  System.ImageList;

type
  TA023FCaricaTimbRich = class(TR001FGestTab)
    Panel2: TPanel;
    btnImporta: TBitBtn;
    btnVisualizzaLog: TBitBtn;
    dGrdAssenze: TDBGrid;
    PopupMenu1: TPopupMenu;
    Importatimbraturacorrente: TMenuItem;
    ProgressBar1: TProgressBar;
    rgpModalita: TRadioGroup;
    grpPeriodo: TGroupBox;
    lblPeriodoDal: TLabel;
    lblPeriodoAl: TLabel;
    edtPeriodoDal: TMaskEdit;
    edtPeriodoAl: TMaskEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnVisualizzaLogClick(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    A023MW: TA023FTimbratureMW;
    procedure AggiornaFiltroPeriodo;
    procedure AggiornaProgresso;
  public
    ControlliOK: Boolean;
  end;

var
  A023FCaricaTimbRich: TA023FCaricaTimbRich;
  procedure OpenA023CaricaTimbRich;

implementation

uses A023UTimbratureDtM1;

{$R *.dfm}

procedure OpenA023CaricaTimbRich;
begin
  try
    A023FCaricaTimbRich:=TA023FCaricaTimbRich.Create(nil);
    A023FCaricaTimbRich.ShowModal;
  finally
    FreeAndNil(A023FCaricaTimbRich);
  end;
end;

procedure TA023FCaricaTimbRich.FormCreate(Sender: TObject);
begin
  inherited;
  A023MW:=TA023FTimbratureMW.Create(Self);
end;

procedure TA023FCaricaTimbRich.FormShow(Sender: TObject);
begin
  inherited;

  DButton.DataSet:=A023MW.selT105;

  // imposta dataset
  A023MW.selT105.Close;
  A023MW.selT105.ClearVariables;
  C700MergeSelAnagrafe(A023MW.selT105,False);
  C700MergeSettaPeriodo(A023MW.selT105,Parametri.DataLavoro,Parametri.DataLavoro);
  A023MW.selT105.SetVariable('AZIENDA',Parametri.Azienda);
  A023MW.selT105.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  A023MW.selT105.SetVariable('FILTRO_RICHIESTE',null);
  // A023MW.selT105.Open;
  rgpModalitaClick(nil);
end;

procedure TA023FCaricaTimbRich.rgpModalitaClick(Sender: TObject);
var
  LElab: String;
begin
  if rgpModalita.ItemIndex = 0 then
  begin
    // richieste nuove: cancella periodo
    edtPeriodoDal.Clear;
    edtPeriodoAl.Clear;
  end
  else
  begin
    // richieste già elaborate: imposta default per periodo
    if edtPeriodoDal.Text = '  /  /    ' then
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',Date);
    if edtPeriodoAl.Text = '  /  /    ' then
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',Date);
  end;

  LElab:=IfThen(rgpModalita.ItemIndex = 0,'N','E');
  R180SetVariable(A023MW.selT105,'FILTRO_MODALITA',Format('AND T105.ELABORATO = ''%s''',[LElab]));
  AggiornaFiltroPeriodo;
  A023MW.selT105.Open;
  AggiornaProgresso;
end;

procedure TA023FCaricaTimbRich.actRefreshExecute(Sender: TObject);
var
  LID: String;
begin
  AggiornaFiltroPeriodo;

  if A023MW.selT105.Active then
    inherited
  else
  begin
    LID:=A023MW.selT105.RowID;
    A023MW.selT105.Open;
    AggiornaProgresso;
     if LID <> '' then
       A023MW.selT105.Locate('RowID',LID,[]);
  end;
end;

procedure TA023FCaricaTimbRich.AggiornaFiltroPeriodo;
var
  LPeriodoDal: TDateTime;
  LPeriodoAl: TDateTime;
  LPeriodo: String;
  function IsDataNulla(const PData: String): Boolean;
  begin
    Result:=(Trim(PData) = '') or (PData = '  /  /    ');
  end;
begin
  // periodo richieste
  if IsDataNulla(edtPeriodoDal.Text) and IsDataNulla(edtPeriodoAl.Text) then
  begin
    // periodo vuoto
    LPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtPeriodoDal.Text,LPeriodoDal) then
      raise Exception.Create('Data di inizio periodo non valida!');
    if not TryStrToDate(edtPeriodoAl.Text,LPeriodoAl) then
      raise Exception.Create('Data di fine periodo non valida!');
    if LPeriodoDal > LPeriodoAl then
      raise Exception.Create('Il periodo indicato non è valido!');
    if LPeriodoDal = LPeriodoAl then
      LPeriodo:=Format('AND T105.DATA = TO_DATE(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',LPeriodoDal)])
    else
      LPeriodo:=Format('AND T105.DATA BETWEEN TO_DATE(''%s'',''dd/mm/yyyy'') AND TO_DATE(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',LPeriodoDal),FormatDateTime('dd/mm/yyyy',LPeriodoAl)]);
  end;

  R180SetVariable(A023MW.selT105,'FILTRO_PERIODO',LPeriodo);
end;

procedure TA023FCaricaTimbRich.AggiornaProgresso;
begin
  NumRecords;
  Self.Repaint;
end;

procedure TA023FCaricaTimbRich.btnImportaClick(Sender: TObject);
var
  Singola,Ok: Boolean;
  Errore,Msg: String;
  NumScartate: Integer;
begin
  if A023MW.selT105.RecordCount = 0 then
  begin
    R180MessageBox('Nessuna richiesta da importare',INFORMA);
    Exit;
  end;

  // determina se l'importazione è singola oppure massiva
  Singola:=Sender <> btnImporta;
  if not Singola then
  begin
    // importazione completa
    if R180MessageBox(A000MSG_A023_DLG_IMPORTA_RICH,DOMANDA) <> mrYes then
      Exit;
  end;

  // avvio elaborazione
  Screen.Cursor:=crHourGlass;

  // acquisizione delle richieste di giustificativo su cartellino
  Errore:='';
  NumScartate:=0;
  Ok:=True;

  try
    RegistraMsg.IniziaMessaggio('A023');
    A023MW.InizializzaAcquisizioneWeb(Singola);
    if Not Singola then
    begin
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=A023MW.selT105.RecordCount;
    end;

    while not A023MW.selT105.Eof do
    begin
      A023MW.ImportaRichiesta;

      if A023MW.Elaborato = 'E' then
        Ok:=False;

      if Singola then
      begin
        Break;
      end
      else
      begin
        ProgressBar1.Position:=ProgressBar1.Position + 1;
        A023MW.selT105.Next;
      end;
    end;
    A023MW.selT105.Refresh;
  finally
    if Not Singola then
      ProgressBar1.Position:=0;
    A023MW.FinalizzaAcquisizioneWeb;
  end;

  // riapre il dataset delle richieste
  A023MW.selT105.Close;
  A023MW.selT105.Open;
  AggiornaProgresso;

  // fine elaborazione
  Screen.Cursor:=crDefault;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:='Elaborazione terminata correttamente'
    else
      Msg:='Elaborazione terminata con avvertimenti:'#13#10 + Errore;

    if NumScartate > 0 then
    begin
      Msg:=Msg + #13#10'Alcune richieste non sono state considerate'#13#10'perché sono state già importate in precedenza';
    end;
    R180MessageBox(Msg,INFORMA);
  end
  else
  begin
    // anomalie durante elaborazione
    if R180MessageBox('Elaborazione terminata con errori.'#13#10'Si desidera visualizzarli?',DOMANDA) = mrYes then
      btnVisualizzaLogClick(nil);
  end;
end;

procedure TA023FCaricaTimbRich.btnVisualizzaLogClick(Sender: TObject);
begin
  inherited;
  A023FTimbrature.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A023','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  A023FTimbrature.frmSelAnagrafe.RipristinaC00SelAnagrafe(A023FTimbratureDtM1.A023FTimbratureMW);
end;

procedure TA023FCaricaTimbRich.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A023MW);
  inherited;
end;

end.

unit A147URepVincoliIndividuali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, A083UMsgElaborazioni,
  Grids, DBGrids, DBCtrls, StdCtrls, Buttons, Mask, ExtCtrls,
  SelAnagrafe, C700USelezioneAnagrafe, A003UDataLavoroBis, C013UCheckList, C180FunzioniGenerali,
  Oracle, OracleData, StrUtils, System.Actions;

type
  TA147FRepVincoliIndividuali = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblPenalizzazione: TLabel;
    Label6: TLabel;
    dedtDecorrenza: TDBEdit;
    dedtScadenza: TDBEdit;
    btnDecorrenza: TBitBtn;
    btnScadenza: TBitBtn;
    dedtTurni: TDBEdit;
    dgrdQuoteIndividuali: TDBGrid;
    drgpDisponibile: TDBRadioGroup;
    drgpBloccaPianif: TDBRadioGroup;
    cmbGiorno: TComboBox;
    btnTurni: TBitBtn;
    PopupMenu1: TPopupMenu;
    mnuDividi: TMenuItem;
    CustomActionList: TActionList;
    CustomImageList: TImageList;
    actInsTuttiDipSel: TAction;
    actCancTuttiDipSel: TAction;
    actVisualizzaAnomalie: TAction;
    mnuInsTuttiDipSel: TMenuItem;
    mnuCancTuttiDipSel: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnScadenzaClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure btnTurniClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure mnuDividiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actInserisciTuttiDipSelExecute(Sender: TObject);
    procedure actCancellaTuttiDipSelExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A147FRepVincoliIndividuali: TA147FRepVincoliIndividuali;

  procedure OpenA147RepVincoliIndividuali(Prog:LongInt;Tipologia:String);

implementation

uses A147URepVincoliIndividualiDtM, A147URepVincoliIndividualiMW;

{$R *.dfm}

procedure OpenA147RepVincoliIndividuali(Prog:LongInt;Tipologia:String);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if Tipologia = 'REPERIB' then
    case A000GetInibizioni('Funzione','OpenA147RepVincoliIndividuali') of
      'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
          end;
      'R':SolaLettura:=True;
    end
  else
    case A000GetInibizioni('Funzione','OpenA147GuardiaVincoliIndividuali') of
      'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
  A147FRepVincoliIndividuali:=TA147FRepVincoliIndividuali.Create(nil);
  with A147FRepVincoliIndividuali do
  try
    A147FRepVincoliIndividualiDtM:=TA147FRepVincoliIndividualiDtM.Create(nil);
    with A147FRepVincoliIndividualiDtM.A147MW do
      CodTipologia:=IfThen(Tipologia = 'REPERIB','R','G');
    C700Progressivo:=Prog;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A147FRepVincoliIndividualiDtM);
    Free;
  end;
end;

procedure TA147FRepVincoliIndividuali.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A147FRepVincoliIndividualiDtM.selT385;
  inherited;
end;

procedure TA147FRepVincoliIndividuali.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA147FRepVincoliIndividuali.FormShow(Sender: TObject);
begin
  inherited;
  with A147FRepVincoliIndividualiDtM.A147MW do
    A147FRepVincoliIndividuali.Caption:='<A147> Vincoli pianificazione ' + IfThen(CodTipologia = 'R','reperibilità','guardia');
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A147FRepVincoliIndividualiDtM.A147MW,SessioneOracle,StatusBar,2,True);
  R180SetComboItemsValues(cmbGiorno.Items,A147FRepVincoliIndividualiDtM.A147MW.D_Giorno,'V');
end;

procedure TA147FRepVincoliIndividuali.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA147FRepVincoliIndividuali.TInserClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA147FRepVincoliIndividuali.actCancellaTuttiDipSelExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A147_DLG_CANC_SELEZ,mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    A147FRepVincoliIndividualiDtM.A147MW.AgisciTuttiDipSel(taCancella);
    ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  end;
end;

procedure TA147FRepVincoliIndividuali.actInserisciTuttiDipSelExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A147_DLG_INS_SELEZ,mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    A147FRepVincoliIndividualiDtM.A147MW.AgisciTuttiDipSel(taInserisci);
    if RegistraMsg.ContieneTipoA then
    begin
      if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
       actVisualizzaAnomalieExecute(nil);
    end
    else
      ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  end;
end;

procedure TA147FRepVincoliIndividuali.actVisualizzaAnomalieExecute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A147','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A147FRepVincoliIndividualiDtM.A147MW);
end;

procedure TA147FRepVincoliIndividuali.btnDecorrenzaClick(Sender: TObject);
begin
  inherited;
  with A147FRepVincoliIndividualiDtM do
  begin
    if selT385.FieldByName('DECORRENZA').IsNull then
      selT385.FieldByName('DECORRENZA').AsDateTime:=Parametri.DataLavoro;
    selT385.FieldByName('DECORRENZA').AsDateTime:=DataOut(selT385.FieldByName('DECORRENZA').AsDateTime,'Data decorrenza','G');
  end;
end;

procedure TA147FRepVincoliIndividuali.btnScadenzaClick(Sender: TObject);
begin
  inherited;
  with A147FRepVincoliIndividualiDtM do
  begin
    if selT385.FieldByName('DECORRENZA_FINE').IsNull then
      selT385.FieldByName('DECORRENZA_FINE').AsDateTime:=Parametri.DataLavoro;
    selT385.FieldByName('DECORRENZA_FINE').AsDateTime:=DataOut(selT385.FieldByName('DECORRENZA_FINE').AsDateTime,'Data scadenza','G');
  end;
end;

procedure TA147FRepVincoliIndividuali.btnTurniClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    with A147FRepVincoliIndividualiDtM.A147MW.selT350 do
    begin
      Close;
      SetVariable('TIPO',A147FRepVincoliIndividualiDtM.A147MW.CodTipologia);
      Open;
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    R180PutCheckList(dedtTurni.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      A147FRepVincoliIndividualiDtM.selT385.FieldBYName('TURNI').AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA147FRepVincoliIndividuali.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    A147FRepVincoliIndividualiDtM.A147MW.SettaProgressivo;
    NumRecords;
  end;
end;

procedure TA147FRepVincoliIndividuali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnDecorrenza.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnScadenza.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbGiorno.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnTurni.Enabled:=DButton.State in [dsEdit,dsInsert];
  mnuDividi.Enabled:=(DButton.State = dsBrowse) and not SolaLettura;
  actInsTuttiDipSel.Enabled:=(DButton.State = dsBrowse) and not SolaLettura and (DButton.DataSet.RecordCount > 0);
  actCancTuttiDipSel.Enabled:=(DButton.State = dsBrowse) and not SolaLettura and (DButton.DataSet.RecordCount > 0);
end;

procedure TA147FRepVincoliIndividuali.mnuDividiClick(Sender: TObject);
begin
  inherited;
  with A147FRepVincoliIndividualiDtM do
    A147MW.DividiPeriodo(DataOut(selT385.FieldByName('DECORRENZA').AsDateTime,'Nuova decorrenza','G',True));
end;

end.

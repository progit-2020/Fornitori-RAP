unit A082UCdCPercent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, DBCtrls, Buttons, ExtCtrls, ComCtrls, ActnList,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData, StrUtils,
  A005UTabelle,A115UDatiLiberiStoricizzati,

  C005UDatiAnagrafici, C700USelezioneAnagrafe,
  C180FunzioniGenerali, R004UGestStorico, SelAnagrafe, Variants, DBGrids, Grids,
  ImgList, ToolWin, Mask, A000UMessaggi, System.Actions;

type
  TA082FCdcPercent = class(TR004FGestStorico)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrdCdcPercent: TDBGrid;
    btnRipristino: TButton;
    MemoControlli: TMemo;
    Splitter1: TSplitter;
    pmnNuovoElemento: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    btnCopia: TBitBtn;
    actCopiaSuAltriDip: TAction;
    procedure frmSelAnagrafebtnRicercaClick(Sender: TObject);
    procedure frmSelAnagrafebtnPrimoClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnRipristinoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure actCopiaSuAltriDipExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    DoStateChange, messaggio:boolean;//DoAfterPost,
    lstErrori:TStringList;
    procedure Controlli;
    procedure AbiltaCopiaCDC;
  end;

var
  A082FCdcPercent: TA082FCdcPercent;

procedure OpenA082CdcPercent(Prog:LongInt);

implementation

uses A082UCdcPercentDtM;

{$R *.DFM}

procedure OpenA082CdcPercent(Prog:LongInt);
begin
  if not A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,nil) then
  begin
    ShowMessage(A000MSG_A082_ERR_NO_CDC);
    exit;
  end;
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA082CdcPercent') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  A082FCdcPercent:=TA082FCdcPercent.Create(nil);
  C700Progressivo:=Prog;
  A082FCdcPercentDtM:=TA082FCdcPercentDtM.Create(nil);
  try
    Screen.Cursor:=crDefault;
    A082FCdcPercent.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A082FCdcPercent.Free;
    A082FCdcPercentDtM.Free;
  end;
end;

procedure TA082FCdcPercent.FormCreate(Sender: TObject);
begin
  inherited;
  lstErrori:=TStringList.Create;
  C700Progressivo:=0;
end;

procedure TA082FCdcPercent.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(lstErrori);
end;

procedure TA082FCdcPercent.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  inherited;
  try
    C005DataVisualizzazione:=A082FCdcPercentDtM.selT433.FieldByName('DECORRENZA').AsDateTime;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA082FCdcPercent.Nuovoelemento1Click(Sender: TObject);
var
  Tabella,Codice,Storico:String;
begin
  inherited;
  A000GetTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,Tabella,Codice,Storico);
  if Copy(Tabella,1,4) = 'I501' then
  begin
    if Storico = 'S' then
      OpenA115DatiLiberiStoricizzati(Parametri.CampiRiferimento.C13_CdcPercentualizzati,A082FCdcPercentDtM.selT433.FieldByName('CODICE').AsString)
    else
      OpenA005Tabelle(Parametri.CampiRiferimento.C13_CdcPercentualizzati,A082FCdcPercentDtM.selT433.FieldByName('CODICE').AsString);
    A082FCdcPercentDtM.CaricamentoDati(A082FCdcPercentDtM.A082FCdcPercentMW.selCdcPercent,'CODICE',Parametri.CampiRiferimento.C13_CdcPercentualizzati,A082FCdcPercentDtM.LungTipoQuota);
  end;
end;

procedure TA082FCdcPercent.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  DoStateChange:=False;
  Controlli;
  inherited;
  try
    C700Datalavoro:=A082FCdcPercentDtM.selT433.FieldByName('DECORRENZA').AsDateTime;
  except
    C700Datalavoro:=Parametri.DataLavoro;
  end;
  if C700Datalavoro = 0 then
    C700Datalavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA082FCdcPercent.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,3,True);
  frmSelAnagrafe.NumRecords;
  MemoControlli.Clear;
  btnRipristino.Enabled:=False;
  DoStateChange:=True;
  messaggio:=True;
end;

procedure TA082FCdcPercent.CambiaProgressivo;
begin
  with A082FCdcPercentDtM do
  begin
    selT433.Close;
    selT433.SetVariable('Progressivo',C700Progressivo);
    selT433.Open;
    GetDateDecorrenza;
    NumRecords;
  end;
  A082FCdcPercentDtM.A082FCdcPercentMW.cdsT433.EmptyDataSet;
  A082FCdcPercentDtM.A082FCdcPercentMW.SituazioneModificata:=False;
  Messaggio:=False;
  Controlli;
  Messaggio:=True;
end;

procedure TA082FCdcPercent.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  A082FCdcPercentDtM.A082FCdcPercentMW.ElaboraPeriodi;
  actRefresh.Execute;
end;

procedure TA082FCdcPercent.Controlli;
var
  Anomalie: String;
begin
  //Controllo giorno per giorno
  if C700Progressivo = 0 then
    exit;
  MemoControlli.Clear;
  lstErrori.Clear;
  Anomalie:=A082FCdcPercentDtM.A082FCdcPercentMW.Controlli;
  DoStateChange:=Anomalie <> '';
  btnRipristino.Enabled:=(Anomalie <> '') and (A082FCdcPercentDtM.A082FCdcPercentMW.cdsT433.RecordCount > 0);
  AbiltaCopiaCDC;
  if Anomalie <> '' then
  begin
    lstErrori.Add('Attenzione! Sono state rilevate le seguenti anomalie.');
    lstErrori.Add('');
    lstErrori.Add(Anomalie);
    MemoControlli.Lines.Assign(A082FCdcPercent.lstErrori);
    if messaggio then
    begin
      if A082FCdcPercentDtM.A082FCdcPercentMW.SituazioneModificata then
        R180MessageBox(Format(A000MSG_A082_ERR_FMT_ANOMALIE_PENDING,[IfThen(A082FCdcPercentDtM.A082FCdcPercentMW.cdsT433.RecordCount > 0,A000MSG_A082_ERR_FMT_ANOMALIE_PENDING2)]),ERRORE)
      else
        exit;
    end;
    messaggio:=True;
    abort;
  end
  else
    A082FCdcPercentDtM.CaricamentocdsT433;
end;

procedure TA082FCdcPercent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Controlli;
end;

procedure TA082FCdcPercent.AbiltaCopiaCDC;
var
  MyRowID:String;
begin
  actCopiaSuAltriDip.Enabled:=False;
  if SolaLettura or (C700SelAnagrafe.RecordCount <= 1) or (MemoControlli.Lines.Count > 0) then
    Exit;
  with A082FCdcPercentDtM do
  begin
    MyRowID:=selT433.RowId;
    selT433.DisableControls;
    selT433.First;
    while Not selT433.Eof do
    begin
      if (selT433.FieldByName('DECORRENZA').AsDateTime <= Parametri.DataLavoro) and
         (selT433.FieldByName('DECORRENZA_FINE').AsDateTime >= Parametri.DataLavoro) then
        actCopiaSuAltriDip.Enabled:=True;
      selT433.Next;
    end;
    selT433.SearchRecord('ROWID',MyRowID,[srFromBeginning]);
    selT433.EnableControls;
  end;
end;

procedure TA082FCdcPercent.actCopiaSuAltriDipExecute(Sender: TObject);
var
  ProgOrig:Integer;
begin
  inherited;
  if R180MessageBox(Format(A000MSG_A082_DLG_FMT_COPIA,[C700SelAnagrafe.FieldByName('COGNOME').AsString,
                                                       C700SelAnagrafe.FieldByName('NOME').AsString,
                                                       DateToStr(Parametri.DataLavoro)])
                    ,DOMANDA) = mrNo then
    Exit;
  ProgOrig:=C700Progressivo;
  try
    C700SelAnagrafe.First;
    while Not C700SelAnagrafe.Eof do
    begin
      A082FCdcPercentDtM.A082FCdcPercentMW.CopiaMassivaCDC(ProgOrig,C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,C700DataLavoro);
      C700SelAnagrafe.Next;
    end;
    R180MessageBox(A000MSG_MSG_OPERAZIONE_COMPLETATA,INFORMA);
  except
    on e:exception do
      R180MessageBox(Format(A000MSG_ERR_FMT_ERRORE,[e.Message]),ESCLAMA);
  end;
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',ProgOrig,[srFromBeginning]);
end;

procedure TA082FCdcPercent.btnRipristinoClick(Sender: TObject);
begin
  inherited;
  if C700Progressivo <> 0 then
    if MessageDlg(A000MSG_A082_DLG_RIPRISTINO,mtConfirmation,[mbYes,mbNo],0) = mrYes then
      //Ripristino la vecchia situazione
      with A082FCdcPercentDtM do
      begin
        selT433.DisableControls;
        A082FCdcPercentMW.CancellaT433(C700Progressivo);
        InterfacciaR004.StoricizzazioneInCorso:=True;
        A082FCdcPercentMW.Ripristina;
        InterfacciaR004.StoricizzazioneInCorso:=False;
        A082FCdcPercentDtM.AfterPost(selT433);
        selT433.Close;
        selT433.Open;
        selT433.EnableControls;
      end;
end;

procedure TA082FCdcPercent.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if DoStateChange then
    btnRipristino.Enabled:=not(DButton.State in [dsEdit, dsInsert]) and (A082FCdcPercentDtM.A082FCdcPercentMW.Controlli <> '') and (A082FCdcPercentDtM.A082FCdcPercentMW.cdsT433.RecordCount > 0);
end;

procedure TA082FCdcPercent.frmSelAnagrafebtnPrimoClick(Sender: TObject);
begin
  Controlli;
  inherited;
  frmSelAnagrafe.btnBrowseClick(Sender);
end;

procedure TA082FCdcPercent.frmSelAnagrafebtnRicercaClick(Sender: TObject);
begin
  Controlli;
  inherited;
  frmSelAnagrafe.btnRicercaClick(Sender);
end;

end.

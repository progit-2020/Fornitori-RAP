unit A112UInvioMessaggi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, Db, ImgList, ActnList, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  C700USelezioneAnagrafe, SelAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, A003UDataLavoroBis, A111UParMessaggi, Mask, Spin, StrUtils,
  OracleData, Grids, DBGrids, R110UCreazioneFileMessaggi, C004UParamForm, A000UMessaggi,
  Variants, C012UVisualizzaTesto, A083UMsgElaborazioni, System.Actions, A112UInvioMessaggiMW;

type
  TA112FInvioMessaggi = class(TForm)
    StatusBar: TStatusBar;
    pmnuDatiAnagrafici: TPopupMenu;
    R003Datianagrafici: TMenuItem;
    ActionList1: TActionList;
    actVisualizzaFile: TAction;
    actEsci: TAction;
    actEseguiInvio: TAction;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    VisualizzaFile: TMenuItem;
    VisualizzaFile1: TMenuItem;
    EseguiInvio: TMenuItem;
    N4: TMenuItem;
    Esci: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    btnEsci: TBitBtn;
    btnEsegui: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    btnAnomalie: TBitBtn;
    VisualizzaAnomalie1: TMenuItem;
    N1: TMenuItem;
    actAnomalie: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    lblDataMessaggio: TLabel;
    lblOraMessaggio: TLabel;
    lblDataConsuntivo: TLabel;
    lblDataScadenza: TLabel;
    lblNumeroRipetizioni: TLabel;
    lblParametri: TLabel;
    lblNomeFile: TLabel;
    sbtNomeFile: TSpeedButton;
    sbtDataMessaggio: TSpeedButton;
    sbtDataConsuntivo: TSpeedButton;
    sbtDataScadenza: TSpeedButton;
    edtNomeFile: TEdit;
    rgpFileEsistente: TRadioGroup;
    dCmbParametri: TDBLookupComboBox;
    dtpOraMessaggio: TDateTimePicker;
    edtNumeroRipetizioni: TSpinEdit;
    edtDataMessaggio: TMaskEdit;
    edtDataConsuntivo: TMaskEdit;
    edtDataScadenza: TMaskEdit;
    dGrdDati: TDBGrid;
    pmnParametri: TPopupMenu;
    NuovoElemento1: TMenuItem;
    dGrdRisultati: TDBGrid;
    actVisualizzaBatch: TAction;
    VisualizzaBatch: TMenuItem;
    N2: TMenuItem;
    rgpMsgEsistente: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure sbtDataMessaggioClick(Sender: TObject);
    procedure sbtDataConsuntivoClick(Sender: TObject);
    procedure sbtDataScadenzaClick(Sender: TObject);
    procedure dCmbParametriCloseUp(Sender: TObject);
    procedure dCmbParametriKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbParametriKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure sbtNomeFileClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure VisualizzaFile1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure EsciClick(Sender: TObject);
    procedure actVisualizzaBatchExecute(Sender: TObject);
  private
    { Private declarations }
    A112MW: TA112FInvioMessaggiMW;
    procedure AssegnaPickList(Tipo:String);
    procedure evtRichiesta(Msg,Chiave:String);
    procedure evtInforma(Msg:String);
  public
    { Public declarations }
  end;

var
  A112FInvioMessaggi: TA112FInvioMessaggi;

procedure OpenA112InvioMessaggi(Progressivo:Integer);

implementation

{$R *.DFM}

procedure OpenA112InvioMessaggi(Progressivo:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA112InvioMessaggi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A112FInvioMessaggi:=TA112FInvioMessaggi.Create(nil);
  with A112FInvioMessaggi do
  try
    C700Progressivo:=Progressivo;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Free;
  end;
end;

procedure TA112FInvioMessaggi.FormCreate(Sender: TObject);
begin
  A112MW:=TA112FInvioMessaggiMW.Create(Self);
  inherited;
  A112MW.Chiamante:='A112';
  A112MW.AssegnaPickList:=AssegnaPickList;
  A112MW.evtRichiesta:=evtRichiesta;
  A112MW.evtInforma:=evtInforma;
end;

procedure TA112FInvioMessaggi.FormShow(Sender: TObject);
begin
  dCmbParametri.ListSource:=A112MW.dsrT291;
  dGrdDati.DataSource:=A112MW.dsrC292;
  dGrdRisultati.DataSource:=A112MW.dsrT295;

  PageControl1.ActivePage:=TabSheet1;
  edtDataMessaggio.Text:=DateToStr(Now);
  dtpOraMessaggio.Time:=Now;
  dCmbParametri.KeyValue:=A112MW.selT291.FieldByName('CODICE').AsString;
  // Inizializzazione selezione anagrafica
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700TuttiCampi;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A112MW,SessioneOracle,StatusBar,0,False);
  // Reperimento ultima parametrizzazione usata dall'utente
  CreaC004(SessioneOracle,'A112',Parametri.ProgOper);
  dCmbParametri.KeyValue:=C004FParamForm.GetParametro('PARAMETRI',dCmbParametri.KeyValue);
  VisualizzaBatch.Checked:=C004FParamForm.GetParametro('VIS_BATCH','S') = 'N';
  dCmbParametriCloseUp(nil);
  actVisualizzaBatchExecute(nil);
end;

procedure TA112FInvioMessaggi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // salvataggio ultima parametrizzazione usata dall'utente
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('PARAMETRI',VarToStr(dCmbParametri.KeyValue));
  C004FParamForm.PutParametro('VIS_BATCH',IfThen(VisualizzaBatch.Checked,'S','N'));
  FreeAndNil(C004FParamForm);
  try SessioneOracle.Commit; except end;
end;

procedure TA112FInvioMessaggi.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA112FInvioMessaggi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
  PageControl1Change(nil);
end;

procedure TA112FInvioMessaggi.PageControl1Change(Sender: TObject);
begin
  if (PageControl1.ActivePage = TabSheet2) or (A112MW.INIZ) then
    A112MW.RefreshT295(StrToDateTime(edtDataMessaggio.Text));
end;

procedure TA112FInvioMessaggi.sbtDataMessaggioClick(Sender: TObject);
begin
  edtDataMessaggio.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataMessaggio.Text),'Data Messaggio','G'));
end;

procedure TA112FInvioMessaggi.sbtDataConsuntivoClick(Sender: TObject);
begin
  edtDataConsuntivo.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtDataConsuntivo.Text),'Mese Consuntivo','M'));
end;

procedure TA112FInvioMessaggi.sbtDataScadenzaClick(Sender: TObject);
begin
  edtDataScadenza.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataScadenza.Text),'Data Scadenza Messaggio','G'));
end;

procedure TA112FInvioMessaggi.dCmbParametriCloseUp(Sender: TObject);
begin
  btnAnomalie.Enabled:=False;
  with A112MW do
  begin
    rgpMsgEsistente.Enabled:=selT291.FieldByName('REGISTRA_MSG').AsString = 'S';
    sbtNomeFile.Enabled:=selT291.FieldByName('TIPO_FILE').AsString = 'A';
    if selT291.FieldByName('NUM_MMIND_CONS').AsInteger = -1 then
    begin
      QSelect.Close;
      QSelect.Sql.Clear;
      QSelect.Sql.Add('SELECT MAX(DATA) DATACONS FROM T070_SCHEDARIEPIL');
      QSelect.Open;
      edtDataConsuntivo.Text:=FormatDateTime('mm/yyyy',QSelect.Fields[0].AsDateTime);
    end
    else
      edtDataConsuntivo.Text:=FormatDateTime('mm/yyyy',R180InizioMese(R180AddMesi(Date,-selT291.FieldByName('NUM_MMIND_CONS').AsInteger)));
    edtDataScadenza.Text:=DateToStr(Now + selT291.FieldByName('NUM_GGVAL_MSG').AsInteger);
    edtNumeroRipetizioni.Text:=selT291.FieldByName('NUM_RIPET_MSG').AsString;
    if selT291.FieldByName('TIPO_REGISTRAZIONE').AsString = 'R' then
      rgpFileEsistente.ItemIndex:=1
    else
      rgpFileEsistente.ItemIndex:=0;
    // costruzione nome file con data file
    edtNomeFile.Text:=R180NomeFileDatato(selT291.FieldByName('NOME_FILE').AsString,selT291.FieldByName('DATA_FILE').AsString,StrToDate(edtDataMessaggio.Text));
    // costruzione filtro anagrafiche
    C700FSelezioneAnagrafe.cmbSelezione.Text:=selT291.FieldByName('FILTRO_ANAGR').AsString;
    if selT291.FieldByName('FILTRO_ANAGR').AsString <> '' then
    begin
      C700FSelezioneAnagrafe.actApriSelezioneExecute(C700FSelezioneAnagrafe.actConferma);
      C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    end;
    frmSelAnagrafe.NumRecords;
    selT292.Close;
    selT292.SetVariable('CODICE_PARM',selT291.FieldByName('CODICE').AsString);
    selT292.Open;
    CaricaTabellaTemp(C004FParamForm.GetParametro('PARAMETRI',''));
  end;
end;

procedure TA112FInvioMessaggi.dCmbParametriKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA112FInvioMessaggi.dCmbParametriKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
    dCmbParametriCloseUp(Sender);
end;

procedure TA112FInvioMessaggi.NuovoElemento1Click(Sender: TObject);
begin
{Richiamo parametrizzazione invio messaggi}
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA111ParMessaggi(A112MW.selT291.FieldByName('Codice').AsString);
  C700DatiSelezionati:=C700CampiBase + ',T430TERMINALI,T430PASSENZE';
  C700Creazione(SessioneOracle);
  C700OldProgressivo:=-1;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A112MW);
  with A112MW.selT291 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA112FInvioMessaggi.sbtNomeFileClick(Sender: TObject);
begin
  with A112MW do
  begin
    SaveDialog1.Title:='Scelta nome file di scarico';
    if not(selT291.FieldByName('Nome_File').IsNull) then
      SaveDialog1.FileName:=selT291.FieldByName('Nome_File').Value;
    if SaveDialog1.Execute then
      selT291.FieldByName('Nome_File').Value:=SaveDialog1.FileName;
    edtNomeFile.Text:=selT291.FieldByName('Nome_File').AsString;
  end;
  dCmbParametriCloseUp(nil);
end;

procedure TA112FInvioMessaggi.btnEseguiClick(Sender: TObject);
var Elaborazione:Boolean;
begin
  try
    Screen.Cursor:=crHourGlass;
    with A112MW do
    begin
      DHMess:=StrToDateTime(edtDataMessaggio.Text + TimeToStr(dtpOraMessaggio.Time));
      DMess:=StrToDateTime(edtDataMessaggio.Text);
      HMess:=dtpOraMessaggio.DateTime;
      DCons:=StrToDateTime('01/' + edtDataConsuntivo.Text);
      DScad:=StrToDateTime(edtDataScadenza.Text);
      NRip:=edtNumeroRipetizioni.Text;
      Param:=dCmbParametri.KeyValue + ' - ' + dCmbParametri.Text;
      NomeFileParam:=edtNomeFile.Text;
      iFileEsistente:=rgpFileEsistente.ItemIndex;
      MantieniMsg:=rgpMsgEsistente.ItemIndex = 0;
      PreparaInviaMessaggi;
      InviaMessaggi;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA112FInvioMessaggi.VisualizzaFile1Click(Sender: TObject);
var lstFile:TStringList;
begin
  if A112MW.selT291.FieldByName('TIPO_FILE').AsString = 'O' then
  begin
    lstFile:=A112MW.LeggiMessaggiDaTabella(EdtNomeFile.Text);
    try
      OpenC012VisualizzaTesto('<A112> File di Invio Messaggi','',lstFile);
    finally
      lstFile.Free;
    end;
  end
  else
  begin
    if FileExists(edtNomeFile.Text) then
      OpenC012VisualizzaTesto('<A112> File di Invio Messaggi',EdtNomeFile.Text,nil)
    else
      raise exception.Create(A000MSG_ERR_FILE_INESISTENTE);
  end;
end;

procedure TA112FInvioMessaggi.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A112','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A112MW);
end;

procedure TA112FInvioMessaggi.EsciClick(Sender: TObject);
begin
  Close;
end;

procedure TA112FInvioMessaggi.actVisualizzaBatchExecute(Sender: TObject);
var Codice:String;
begin
  with A112MW.selT291 do
  begin
    Codice:=FieldByName('CODICE').AsString;
    VisualizzaBatch.Checked:=not VisualizzaBatch.Checked;
    Filter:=IfThen(VisualizzaBatch.Checked,'','DEFAULT_FILE=''N''');
    Filtered:=not VisualizzaBatch.Checked;
    SearchRecord('CODICE',Codice,[srFromBeginning]);
    dcmbParametri.KeyValue:=FieldByName('CODICE').AsString;
    dCmbParametriCloseUp(Sender);
  end;
end;

procedure TA112FInvioMessaggi.AssegnaPickList(Tipo:String);
var i:Integer;
begin
  with dGrdDati,A112MW do
    for i:=0 to Columns.Count - 1 do
    begin
      Columns[i].PickList.Clear;
      if Tipo = 'VL' then
      begin
        if Columns[i].FieldName = 'VALORE_DEFAULT' then
          Columns[i].PickList.Assign(PLDefaultVal)
        else if (Columns[i].FieldName = 'CODICE_DATO') then
          Columns[i].PickList.Assign(PLCodDato);
      end;
    end;
end;

procedure TA112FInvioMessaggi.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort
  else if Chiave = 'EsisteMessaggio' then
    A112MW.sSkippa:='N';
end;

procedure TA112FInvioMessaggi.evtInforma(Msg:String);
begin
  btnAnomalie.Enabled:=True;
  R180MessageBox(Msg,INFORMA);
end;

end.

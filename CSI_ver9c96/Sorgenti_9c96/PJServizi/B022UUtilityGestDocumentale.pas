unit B022UUtilityGestDocumentale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, Menus, Math, checklst, A000USessione, A000UInterfaccia,
  C700USelezioneAnagrafe, C180FunzioniGenerali, ExtCtrls, SelAnagrafe, Grids, DBGrids,
  OracleData, A000UMessaggi, A083UMsgElaborazioni, B022UUtilityGestDocumentaleMW, C021UDocumentiManagerDM,
  System.Actions, Vcl.ActnList, Vcl.Mask, A000Versione, Data.DB,
  System.ImageList, Vcl.ImgList, System.StrUtils, Winapi.ShellAPI, WinAPI.WinSvc,
  Vcl.DBCtrls,System.Generics.Collections, A000UCostanti, ClipBrd;

type
  TB022FUtilityGestDocumentale = class(TForm)
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    pnlElaborazione: TPanel;
    btnEsegui: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    dbgT960: TDBGrid;
    pnlFiltri: TPanel;
    chkPathStorage: TCheckListBox;
    actlst: TActionList;
    actApplicaFiltri: TAction;
    actTestServizio: TAction;
    lblPathAllegati: TLabel;
    edtNuovoPath: TEdit;
    lblNuovoPathStorage: TLabel;
    edtPathAzienda: TEdit;
    lblURLServizio: TLabel;
    edtURLServizio: TEdit;
    btnTestServizio: TButton;
    rgpElaborazione: TRadioGroup;
    btnTestAccessoNuovoPath: TButton;
    actTestAccessoNuovoPath: TAction;
    pnlPeriodo: TPanel;
    lblPeriodoDal: TLabel;
    lblPeriodoAl: TLabel;
    btnApplicaFiltri: TButton;
    edtPeriodoDal: TMaskEdit;
    edtPeriodoAl: TMaskEdit;
    actEsegui: TAction;
    actAnomalie: TAction;
    chkFiltroAnagrafe: TCheckBox;
    btnAccessoPathAzienda: TButton;
    actTestAccessoPathAzienda: TAction;
    PageControl: TPageControl;
    tsConfigurazione: TTabSheet;
    tsSpostaDocumenti: TTabSheet;
    tsImportaDaFS: TTabSheet;
    pnlConfStato: TPanel;
    lblConfLabelStato: TLabel;
    lblConfStatoServ: TLabel;
    grpConfAzioni: TGroupBox;
    btnConfAvvia: TBitBtn;
    btnConfArresta: TBitBtn;
    btnConfInstalla: TBitBtn;
    btnConfDisinstalla: TBitBtn;
    ImageList: TImageList;
    grpConfConfAziendale: TGroupBox;
    lblConfURL: TLabel;
    edtConfURL: TEdit;
    lblConfPath: TLabel;
    rgpConfPathDB: TRadioButton;
    rgpConfPathFS: TRadioButton;
    edtConfPathFS: TEdit;
    btnConfAggiorna: TBitBtn;
    btnConfSalva: TButton;
    pnlImpImposta: TPanel;
    lblmpPath: TLabel;
    edtImpPath: TEdit;
    btnImpPathBrowse: TButton;
    lblImpFiltro: TLabel;
    edtImpFiltro: TEdit;
    lblImpFormato: TLabel;
    lblImpTipologia: TLabel;
    lblImpRiferitiAl: TLabel;
    lblImpRiferiti: TLabel;
    lblImpNote: TLabel;
    chkImpVisualIrisWeb: TCheckBox;
    pnlImpDocDaImportare: TPanel;
    pnlImpComandi: TPanel;
    grpImpDocDaImportare: TGroupBox;
    btnImpAnalizza: TButton;
    chkImpDocDaImportare: TCheckListBox;
    prgImp: TProgressBar;
    btnImpEsegui: TBitBtn;
    btnImpAnomalie: TBitBtn;
    memNote: TMemo;
    dcmbImpTipologia: TDBLookupComboBox;
    edtImpPeriodoDal: TMaskEdit;
    edtImpPeriodoAl: TMaskEdit;
    lblFilesSelezionati: TLabel;
    lblDimensioneTotale: TLabel;
    lblImpFilesSelezionati: TLabel;
    lblImpDimensTotale: TLabel;
    lblImpStato: TLabel;
    lblImpUfficio: TLabel;
    dcmbImpUfficio: TDBLookupComboBox;
    lblConfStatoRisp: TLabel;
    grpConfConfServizio: TGroupBox;
    lblConfServPorta: TLabel;
    btnConfServSalva: TButton;
    lblConfInfoAz: TLabel;
    lblConfInfoServ: TLabel;
    edtConfServPorta: TMaskEdit;
    lblConfStatoHelp: TLabel;
    lblConfInfoAzioniPerm: TLabel;
    lblConfInfoConfServPerm: TLabel;
    lblConfInfoParamAzPerm: TLabel;
    lblImpSeparatore: TLabel;
    edtImpSeparatore: TEdit;
    lblImpNomeFile: TLabel;
    edtImpNomeFile: TEdit;
    Label3: TLabel;
    lblImpNomeFileOut: TLabel;
    Panel1: TPanel;
    rgpImpNomeFileOutOrig: TRadioButton;
    rgpImpNomeFileOutPred: TRadioButton;
    rgpImpNomeFileOutTag: TRadioButton;
    edtImpNomeFileOutPred: TEdit;
    grpImpDocIgnorati: TGroupBox;
    lstImpDocIgnorati: TListBox;
    Splitter1: TSplitter;
    pmnImpDocDaImportare: TPopupMenu;
    Action1: TAction;
    Deselezionatutto1: TMenuItem;
    Action2: TAction;
    Selezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnImpFileIgnorati: TPopupMenu;
    Copianegliappunti1: TMenuItem;
    lblImpNomeFileExt: TLabel;
    rgpImpAzioneDocTip: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actTestServizioExecute(Sender: TObject);
    procedure actApplicaFiltriExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actTestAccessoNuovoPathExecute(Sender: TObject);
    procedure rgpElaborazioneClick(Sender: TObject);
    procedure actEseguiExecute(Sender: TObject);
    procedure actAnomalieExecute(Sender: TObject);
    procedure actTestAccessoPathAziendaExecute(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;var Resize: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure OnRgpConfPathClick(Sender: TObject);
    procedure btnConfSalvaClick(Sender: TObject);
    procedure btnConfAggiornaClick(Sender: TObject);
    procedure btnConfInstallaClick(Sender: TObject);
    procedure btnConfDisinstallaClick(Sender: TObject);
    procedure btnConfAvviaClick(Sender: TObject);
    procedure btnConfArrestaClick(Sender: TObject);
    procedure btnImpPathBrowseClick(Sender: TObject);
    procedure OnEdtImpPeriodoExit(Sender: TObject);
    procedure btnImpAnalizzaClick(Sender: TObject);
    procedure chkImpDocDaImportareClickCheck(Sender: TObject);
    procedure btnImpEseguiClick(Sender: TObject);
    procedure chkFiltroAnagrafeClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnConfServSalvaClick(Sender: TObject);
    procedure OnRgpImpNomeFileOutClick(Sender: TObject);
    procedure OnEdtImpFormatiChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copianegliappunti1Click(Sender: TObject);
    procedure edtImpPathChange(Sender: TObject);
    procedure edtImpFiltroChange(Sender: TObject);
  private
    DesignHeight, DesignWidth, LastHeight, LastWidth: Integer;
    BloccaResize,AggiornaLastSize,LastChkFiltroAnagrafeVal,AggiornaLastChkFiltroAnagrafeVal,
      BloccaPageControlChange: Boolean;
    RisultatoRicerca:TB022RisultatoSearch;
    UtenteAdmin:Boolean;
    DATA_VUOTA:String; // Lo uso come costante
    procedure ValorizzaListaPathStorage;
    procedure AvanzamentoProgressBar;
    procedure DBtoFS;
    procedure FStoDB;
    procedure FStoFS;
    procedure LeggiParametriConf;
    procedure ToggleControlliConfAziend;
    procedure ToggleControlliConfServ;
    procedure ImpostaLabelSelezioneFile;
    procedure ResetRicerca;
  public
    ParametriSolaLettura:Boolean;
end;

const
  B021_SERVICE_EXENAME:String = 'B021PIRISRESTSVC_SRV.EXE';
  B021_SERVICE_DISPLAY_NAME:String = 'B021FIRISRESTSVC';
  B021_SERVICE_NAME:String = 'B021FServerContainer';
  B021_SERVER_DEFAULT_PORT:Integer = 8081;

var
  B022FUtilityGestDocumentale: TB022FUtilityGestDocumentale;

procedure OpenB022UtilityGestDocumentale(Prog:Integer);

implementation

uses B022UUtilityGestDocumentaleDM;

{$R *.DFM}

procedure OpenB022UtilityGestDocumentale(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenB022UtilityGestDocumentale') of
    'N','R':begin
            SolaLettura:=SolaLetturaOriginale;
            ShowMessage('Funzione non abilitata!');
            Exit;
            end;
  end;
  B022FUtilityGestDocumentaleDM:=TB022FUtilityGestDocumentaleDM.Create(nil);
  B022FUtilityGestDocumentale:=TB022FUtilityGestDocumentale.Create(nil);
  try
    C700Progressivo:=Prog;
    B022FUtilityGestDocumentale.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(B022FUtilityGestDocumentaleDM);
    FreeAndNil(B022FUtilityGestDocumentale);
  end;
end;

procedure TB022FUtilityGestDocumentale.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=not BloccaResize;
end;

procedure TB022FUtilityGestDocumentale.FormCreate(Sender: TObject);
begin
  UtenteAdmin:=R180IsUserAnAdmin;
  DATA_VUOTA:='  ' + FormatSettings.DateSeparator + '  ' + FormatSettings.DateSeparator + '    ';
  // inizializzazione procedure of object
  B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.ProgressBar:=nil;
  PageControl.ActivePageIndex:=0;
  BloccaResize:=(PageControl.ActivePageIndex = 0);
  AggiornaLastSize:=(PageControl.ActivePageIndex <> 0);
  AggiornaLastChkFiltroAnagrafeVal:=True;
  DesignHeight:=Height;
  DesignWidth:=Width;
  LastHeight:=DesignHeight;
  LastWidth:=DesignWidth;
  LastChkFiltroAnagrafeVal:=False;
  BloccaPageControlChange:=False;

  RisultatoRicerca:=nil;
  // Per determinare se l'utente ha le autorizzazioni per modificare i parametri
  // aziendali valutiamo i permessi su A008
  ParametriSolaLettura:=(A000GetInibizioni('Funzione','OpenA008Operatori') <> 'S');
  btnConfSalva.Enabled:=not ParametriSolaLettura;
  lblConfInfoParamAzPerm.Visible:=ParametriSolaLettura;
  // Le azioni relative al servizio possono essere eseguite solo se l'utente è amministratore
  btnConfInstalla.Enabled:=UtenteAdmin;
  btnConfDisinstalla.Enabled:=UtenteAdmin;
  btnConfAvvia.Enabled:=UtenteAdmin;
  btnConfArresta.Enabled:=UtenteAdmin;
  lblConfInfoAzioniPerm.Visible:=not UtenteAdmin;
  lblImpStato.Caption:='';
end;

procedure TB022FUtilityGestDocumentale.FormResize(Sender: TObject);
begin
  if AggiornaLastSize then
  begin
    LastHeight:=Height;
    LastWidth:=Width;
  end;
end;

procedure TB022FUtilityGestDocumentale.FormShow(Sender: TObject);
begin
  // controllo versione database (spostato da DataModuleCreate con aggiunta di Application.Terminate
  if (Parametri.VersioneDB <> '') and (VersionePA <> Parametri.VersioneDB) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Parametri.VersioneDB,VersionePA]) + #13 +
                 'E'' necessario allineare la propria postazione di lavoro alla versione del database.' + #13 +
                 'Se il problema persiste contattare l''amministratore di sistema.');
    Parametri.Azienda:='';
    Application.Terminate;
  end;

  //C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME'; commentato così i dati di login vengono pre-compilati
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase + ', T430INIZIO, T430FINE, T030.CODFISCALE';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW, SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  frmSelAnagrafe.SelezionePeriodica:=False;

  // inizializzazione edit
  edtPathAzienda.Text:=Parametri.CampiRiferimento.C90_PathAllegati;
  edtURLServizio.Text:=Parametri.CampiRiferimento.C30_WebSrv_B021_URL;
  edtPeriodoDal.Text:=B022FUtilityGestDocumentaleDM.selDataCreazioneMinMax.FieldByName('MIN').AsString;
  edtPeriodoAl.Text:=B022FUtilityGestDocumentaleDM.selDataCreazioneMinMax.FieldByName('MAX').AsString;

  // button per il test sul path storage aziendale se diverso da 'DB'
  actTestAccessoPathAzienda.Visible:=edtPathAzienda.Text <> 'DB';

  //apertura dataset con zero filtri
  actApplicaFiltriExecute(nil);

  //assegnamento procedure of object
  B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.ProgressBar:=AvanzamentoProgressBar;

  LeggiParametriConf;
  ToggleControlliConfAziend;
  ToggleControlliConfServ;

  // Valori default per tipologia documento e ufficio
  dcmbImpTipologia.KeyValue:=B022FUtilityGestDocumentaleDM.CodTipologiaDefault;
  dcmbImpUfficio.KeyValue:=B022FUtilityGestDocumentaleDM.CodUfficioDefault;

  PageControl.OnChange(nil);

  OnRgpImpNomeFileOutClick(nil);
end;

procedure TB022FUtilityGestDocumentale.DBtoFS;
var
  Scelta: Integer;
begin
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 non è in funzione');
    // oppure raise Exception fa la stessa cosa (se però l'applicazione è chiamata, il chiamante deve gestire l'eccezione
    Exit;
  end;
  if edtNuovoPath.Text <> '' then
  begin
    Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                        edtNuovoPath.Text + '" (File system)' + CRLF +
                        'Procedere?', mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(edtNuovoPath.Text) then
      B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, edtNuovoPath.Text)
    else
    begin
      ShowMessage('Non è possibile spostare file nella nuova area di storage');
      Exit;
    end;
  end
  else
  begin
    if Parametri.CampiRiferimento.C90_PathAllegati = 'DB' then
    begin
      ShowMessage('Il campo "Area di storage dove registrare gli allegati" è impostato come "DB" (Database), operazione annullata');
      Exit;
    end
    else
    begin
      Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                          Parametri.CampiRiferimento.C90_PathAllegati + '" (File system)' + CRLF +
                          'Procedere?', mtWarning, mbOKCancel,0);
      if not (Scelta = mrOk) then
        Exit;
      if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(Parametri.CampiRiferimento.C90_PathAllegati) then
        B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, Parametri.CampiRiferimento.C90_PathAllegati)
      else
      begin
        ShowMessage('Non è possibile spostare file nella nuova area di storage');
        Exit;
      end
    end;
  end;
  if RegistraMsg.ContieneTipoA then
    ShowMessage('Elaborazione terminata con anomalie')
  else
    ShowMessage('Elaborazione terminata senza anomalie')
end;

procedure TB022FUtilityGestDocumentale.Deselezionatutto1Click(Sender: TObject);
begin
  chkImpDocDaImportare.CheckAll(cbUnchecked);
end;

procedure TB022FUtilityGestDocumentale.edtImpFiltroChange(Sender: TObject);
begin
  ResetRicerca;
end;

procedure TB022FUtilityGestDocumentale.edtImpPathChange(Sender: TObject);
begin
  ResetRicerca;
end;

procedure TB022FUtilityGestDocumentale.OnEdtImpFormatiChange(
  Sender: TObject);
begin
  ResetRicerca;
end;

procedure TB022FUtilityGestDocumentale.OnEdtImpPeriodoExit(Sender: TObject);
var
  StrInput,Separatore:String;
  DataAppoggio:TDate;
begin
  try
    StrInput:=(Sender as TMaskEdit).Text;
    if StrInput <> DATA_VUOTA then
      DataAppoggio:=StrToDate(StrInput);
  except
    on E:EConvertError do
      raise Exception.Create('Data non valida.');
  end;
end;

procedure TB022FUtilityGestDocumentale.FStoDB;
var
  Scelta: Integer;
begin
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 non è in funzione');
    Exit;
  end;
  if Parametri.CampiRiferimento.C90_PathAllegati <> 'DB' then
  begin
    Scelta:=MessageDlg('Si vuole spostare i files sul Database, ma attualmente il campo "Area di storage dove registrare gli allegati"' +
                        'indica un''area del File system.' + CRLF +
                        'E'' importante verificare che sul Database ci sia spazio sufficiente.' + CRLF +
                        'Si vuole procedere comunque?',
                        mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "DB" (Database)' + CRLF +
                        'Procedere?', mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, 'DB')
  end
  else
  begin
    Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                          Parametri.CampiRiferimento.C90_PathAllegati + '" (Dabatase)' + CRLF +
                          'Procedere?', mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, Parametri.CampiRiferimento.C90_PathAllegati);
  end;
  if RegistraMsg.ContieneTipoA then
    ShowMessage('Elaborazione terminata con anomalie')
  else
    ShowMessage('Elaborazione terminata senza anomalie')
end;

procedure TB022FUtilityGestDocumentale.FStoFS;
var
  Scelta: Integer;
begin
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 non è in funzione');
    Exit;
  end;
  if edtNuovoPath.Text <> '' then
  begin
    Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                          edtNuovoPath.Text + '" (File system)' + CRLF +
                          'Procedere?', mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(edtNuovoPath.Text) then
      B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, edtNuovoPath.Text)
    else
    begin
      ShowMessage('Non è possibile spostare file nella nuova area di storage');
      Exit;
    end;
  end
  else
  begin
    if Parametri.CampiRiferimento.C90_PathAllegati = 'DB' then
    begin
      ShowMessage('Il campo "Area di storage dove registrare gli allegati" è impostato come "DB" (Database), operazione annullata');
      Exit;
    end
    else
    begin
      Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                          Parametri.CampiRiferimento.C90_PathAllegati + '" (File system)' + CRLF +
                          'Procedere?', mtWarning, mbOKCancel,0);
      if not (Scelta = mrOk) then
        Exit;
      if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(Parametri.CampiRiferimento.C90_PathAllegati) then
        B022FUtilityGestDocumentaleDM.ElaborazioneRecords(rgpElaborazione.ItemIndex, Parametri.CampiRiferimento.C90_PathAllegati)
      else
      begin
        ShowMessage('Non è possibile spostare file nella nuova area di storage');
        Exit;
      end
    end;
  end;
  if RegistraMsg.ContieneTipoA then
    ShowMessage('Elaborazione terminata con anomalie')
  else
    ShowMessage('Elaborazione terminata senza anomalie')
end;

procedure TB022FUtilityGestDocumentale.PageControlChange(Sender: TObject);
begin
  BloccaResize:=False;
  AggiornaLastSize:=False;
  AggiornaLastChkFiltroAnagrafeVal:=False;
  if PageControl.ActivePageIndex = 0 then
  begin
    Height:=DesignHeight;
    Width:=DesignWidth;
    BloccaResize:=True;
  end
  else
  begin
    Height:=LastHeight;
    Width:=LastWidth;
    AggiornaLastSize:=True;
  end;
  if PageControl.ActivePageIndex = 1 then
  begin
    chkFiltroAnagrafe.Enabled:=True;
    chkFiltroAnagrafe.Checked:=LastChkFiltroAnagrafeVal;
  end
  else
  begin
    chkFiltroAnagrafe.Enabled:=False;
    chkFiltroAnagrafe.Checked:=True;
  end;
  AggiornaLastChkFiltroAnagrafeVal:=True;
end;

procedure TB022FUtilityGestDocumentale.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=not BloccaPageControlChange;
end;

procedure TB022FUtilityGestDocumentale.OnRgpConfPathClick(Sender: TObject);
begin
  ToggleControlliConfAziend;
end;

procedure TB022FUtilityGestDocumentale.rgpElaborazioneClick(Sender: TObject);
begin
  btnEsegui.Enabled:=rgpElaborazione.ItemIndex >= 0;
end;

procedure TB022FUtilityGestDocumentale.Selezionatutto1Click(Sender: TObject);
begin
  chkImpDocDaImportare.CheckAll(cbChecked);
end;

procedure TB022FUtilityGestDocumentale.OnRgpImpNomeFileOutClick(
  Sender: TObject);
begin
  edtImpNomeFileOutPred.Enabled:=rgpImpNomeFileOutPred.Checked;
  edtImpNomeFileOutPred.Color:=IfThen(edtImpNomeFileOutPred.Enabled,clWindow,clBtnFace);
  ResetRicerca;
end;

procedure TB022FUtilityGestDocumentale.ValorizzaListaPathStorage;
var
  i: Integer;
  Esiste: Boolean;
begin
  Esiste:=False;

  // valorizzazione checklistbox con i path storage (aggiungendo i path che già non ci sono)
  B022FUtilityGestDocumentaleDM.selT960PathStorage.Close;
  B022FUtilityGestDocumentaleDM.selT960PathStorage.Open;
  while not B022FUtilityGestDocumentaleDM.selT960PathStorage.Eof do
  begin
    for i:=0 to chkPathStorage.Items.Count - 1 do
    begin
      if B022FUtilityGestDocumentaleDM.selT960PathStorage.FieldByName('PATH_STORAGE').AsString = chkPathStorage.Items[i] then
      begin
        Esiste:=True;
        Continue;
      end;
    end;
    if not Esiste then
    begin
      chkPathStorage.Items.Add(B022FUtilityGestDocumentaleDM.selT960PathStorage.FieldByName('PATH_STORAGE').AsString);
      Esiste:=False;
    end;
    B022FUtilityGestDocumentaleDM.selT960PathStorage.Next;
  end;
end;

procedure TB022FUtilityGestDocumentale.actAnomalieExecute(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'B022','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TB022FUtilityGestDocumentale.actApplicaFiltriExecute(Sender: TObject);
var
  PathStorage: TStringList;
  i: Integer;
  PeriodoDal, PeriodoAl: TDateTime;
  DimensioneTotale: Integer;
begin
  try
    // recupero delle righe checkate del path storage
    PathStorage:=TStringList.Create;
    for i:=0 to chkPathStorage.Items.Count - 1 do
    begin
      if chkPathStorage.Checked[i] then
        PathStorage.Add('''' + chkPathStorage.Items[i] + '''');
    end;

    // periodo dal-al
    if not TryStrToDate(edtPeriodoDal.Text, PeriodoDal) then
      raise Exception.Create('La data di inizio non è valida');
    if not TryStrToDate(edtPeriodoAl.Text, PeriodoAl) then
      raise Exception.Create('La data di fine non è valida');

    // applicazione del filtro
    B022FUtilityGestDocumentaleDM.ApplicaFiltri(chkFiltroAnagrafe.Checked, PathStorage.CommaText, PeriodoDal, PeriodoAl);

    // inserimento numero di record nella status bar
    DimensioneTotale:=0;

    try
      dbgT960.DataSource.DataSet.DisableControls;
      dbgT960.DataSource.DataSet.First;
      while not dbgT960.DataSource.DataSet.Eof do
      begin
        DimensioneTotale:=DimensioneTotale + dbgT960.DataSource.DataSet.FieldByName('DIMENSIONE').AsInteger;
        dbgT960.DataSource.DataSet.Next;
      end;
    finally
      dbgT960.DataSource.DataSet.First;
      dbgT960.DataSource.DataSet.EnableControls;
    end;
    lblFilesSelezionati.Caption:='Files selezionati: ' + IntToStr(dbgT960.DataSource.DataSet.RecordCount);
    lblDimensioneTotale.Caption:='Dimensione totale: ' + R180GetFileSizeStr(DimensioneTotale);

    // aggiornamento dei path storage
    ValorizzaListaPathStorage;
  finally
    FreeAndNil(PathStorage);
  end;
end;

procedure TB022FUtilityGestDocumentale.actEseguiExecute(Sender: TObject);
begin
  if dbgT960.DataSource.DataSet.RecordCount = 0 then
    ShowMessage('Non ci sono file da elaborare')
  else
  begin
    ProgressBar.Max:=dbgT960.DataSource.DataSet.RecordCount;
    if rgpElaborazione.ItemIndex = 0 then
      DBtoFS
    else if rgpElaborazione.ItemIndex = 1 then
      FStoDB
    else if rgpElaborazione.ItemIndex = 2 then
      FStoFS;

    // operazioni di fine elaborazione
    ValorizzaListaPathStorage;
    ProgressBar.Position:=ProgressBar.Min;
    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoI or RegistraMsg.ContieneTipoA;
  end;
end;

procedure TB022FUtilityGestDocumentale.actTestAccessoNuovoPathExecute(Sender: TObject);
begin
  if edtNuovoPath.Text = '' then
  begin
    ShowMessage('Non hai inserito la nuova area di storage');
    Exit;
  end;
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 per la gestione degli allegati non è in funzione');
    Exit;
  end;
  if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(edtNuovoPath.Text) then
    ShowMessage('È possibile accedere all''area di storage indicata')
  else
    ShowMessage('Non è possibile accedere all''area di storage indicata')
end;

procedure TB022FUtilityGestDocumentale.actTestAccessoPathAziendaExecute(Sender: TObject);
begin
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 per la gestione degli allegati non è in funzione');
    Exit;
  end;
  if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(Parametri.CampiRiferimento.C90_PathAllegati) then
    ShowMessage('È possibile accedere all''area di storage predefinita')
  else
    ShowMessage('Non è possibile accedere all''area di storage predefinita')
end;

procedure TB022FUtilityGestDocumentale.actTestServizioExecute(Sender: TObject);
begin
  if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
    ShowMessage('Il servizio B021 per la gestione degli allegati è in funzione')
  else
    ShowMessage('Il servizio B021 per la gestione degli allegati non è in funzione');
end;

procedure TB022FUtilityGestDocumentale.AvanzamentoProgressBar;
begin
  // avanzamento di una unità rispetto alla totalità dei record da elaborare
  ProgressBar.StepIt;
  Application.ProcessMessages;
end;

procedure TB022FUtilityGestDocumentale.btnConfAggiornaClick(Sender: TObject);
var
  StatoServizio:T180StatoServizio;
begin
  lblConfStatoServ.Font.Color:=clBlack;
  lblConfStatoServ.Caption:='Attendere...';
  lblConfStatoRisp.Font.Color:=clBlack;
  lblConfStatoRisp.Caption:='';
  Screen.Cursor:=crHourGlass;
  btnConfAggiorna.Enabled:=False;
  Application.ProcessMessages;
  try
    try
      StatoServizio:=R180GetServiceStatus(B021_SERVICE_NAME);
      if StatoServizio.EsitoQuery = 0 then
      begin
        if StatoServizio.CurrentState = SERVICE_RUNNING then
        begin
          lblConfStatoServ.Font.Color:=clGreen;
          lblConfStatoServ.Caption:='In esecuzione';
        end
        else if StatoServizio.CurrentState = SERVICE_STOPPED then
        begin
          lblConfStatoServ.Font.Color:=clRed;
          lblConfStatoServ.Caption:='Arrestato';
        end
        else
        begin
          lblConfStatoServ.Font.Color:=clRed;
          lblConfStatoServ.Caption:=StatoServizio.DescrizioneCurrentState;
        end;
      end
      else if (StatoServizio.EsitoQuery = 2) and (StatoServizio.Errore = ERROR_SERVICE_DOES_NOT_EXIST) then
      begin
        lblConfStatoServ.Caption:='Non installato';
      end
      else
      begin
          lblConfStatoServ.Font.Color:=clBlack;
          lblConfStatoServ.Caption:=StatoServizio.DescrizioneErrore;
      end;
    except
      on E:Exception do
      begin
        lblConfStatoServ.Font.Color:=clBlack;
        lblConfStatoServ.Caption:=e.Message;
      end;
    end;

    if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
    begin
      lblConfStatoRisp.Font.Color:=clGreen;
      lblConfStatoRisp.Caption:='Il servizio risponde alle chiamate';
    end
    else
    begin
      lblConfStatoRisp.Font.Color:=clRed;
      lblConfStatoRisp.Caption:='Nessuna risposta dall''URL specificato';
    end;
  finally
    Screen.Cursor:=crDefault;
    btnConfAggiorna.Enabled:=True;
  end;
end;

procedure TB022FUtilityGestDocumentale.btnConfArrestaClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('STOP ' + B021_SERVICE_DISPLAY_NAME),nil,SW_SHOWNORMAL);
end;

procedure TB022FUtilityGestDocumentale.btnConfAvviaClick(Sender: TObject);
begin
  ShellExecute(0,'open', PChar('NET'),PChar('START ' + B021_SERVICE_DISPLAY_NAME),nil,SW_SHOWNORMAL);
end;

procedure TB022FUtilityGestDocumentale.btnConfDisinstallaClick(Sender: TObject);
begin
  R180SyncProcessExec(ExtractFilePath(Application.ExeName) + B021_SERVICE_EXENAME,'','/UNINSTALL');
  ToggleControlliConfServ;
end;

procedure TB022FUtilityGestDocumentale.btnConfInstallaClick(Sender: TObject);
begin
  R180SyncProcessExec(ExtractFilePath(Application.ExeName) + B021_SERVICE_EXENAME,'','/INSTALL');
  ToggleControlliConfServ;
end;

procedure TB022FUtilityGestDocumentale.btnConfSalvaClick(Sender: TObject);
var
  TempStr:String;
begin
  // Salvo su DB le nuove impostazioni
  B022FUtilityGestDocumentaleDM.SalvaParametroI091(B022FUtilityGestDocumentaleDM.PARAM_URL_B021,
                                                   Trim(edtConfURL.Text));

  TempStr:=IfThen(rgpConfPathDB.Checked,'DB',edtConfPathFS.Text);
  B022FUtilityGestDocumentaleDM.SalvaParametroI091(B022FUtilityGestDocumentaleDM.PARAM_PATH_ALLEGATI,
                                                   TempStr);
  // Aggiorno i parametri in memoria
  Parametri.CampiRiferimento.C30_WebSrv_B021_URL:=edtConfURL.Text;
  Parametri.CampiRiferimento.C90_PathAllegati:=TempStr;

  edtPathAzienda.Text:=Parametri.CampiRiferimento.C90_PathAllegati;
  edtURLServizio.Text:=Parametri.CampiRiferimento.C30_WebSrv_B021_URL;

  // Distruggo e ricreo il DM C021, in modo che rilegga l'URL del servizio
  // dai parametri aziendali
  FreeAndNil(B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM);
  B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM:=
    TC021FDocumentiManagerDM.Create(B022FUtilityGestDocumentaleDM);

  R180MessageBox('Impostazioni salvate.',INFORMA,'Configurazione aziendale','');
end;

procedure TB022FUtilityGestDocumentale.btnImpAnalizzaClick(Sender: TObject);
var
  i:Integer;
  SearchConfig:TB022DocumentiSearchConfig;
begin
  if RisultatoRicerca <> nil then
    FreeAndNil(RisultatoRicerca);
  SearchConfig:=TB022DocumentiSearchConfig.Create;
  try
    SearchConfig.Separatore:=edtImpSeparatore.Text;
    SearchConfig.FormatoNomeFile:=Trim(edtImpNomeFile.Text);
    if rgpImpNomeFileOutOrig.Checked then
    begin
      SearchConfig.TipoNomeFileOutput:=tnfoOriginale;
    end
    else if rgpImpNomeFileOutPred.Checked then
    begin
      if Trim(edtImpNomeFileOutPred.Text) = '' then
        raise Exception.Create('Specificare il nome di file di destinazione predefinito');
      SearchConfig.TipoNomeFileOutput:=tnfoPredefinito;
      SearchConfig.NomeFileOutputPredef:=Trim(edtImpNomeFileOutPred.Text);
    end
    else
      SearchConfig.TipoNomeFileOutput:=tnfoTagNomeFile;
    SearchConfig.PreparaIndiciTag;
    if (SearchConfig.TipoNomeFileOutput = tnfoTagNomeFile) and (not SearchConfig.IndiciTag.ContainsKey(TAG_NOME_DEL_FILE)) then
      raise Exception.Create('Il formato nome del file non contiene il tag ' + TAG_NOME_DEL_FILE);

    RisultatoRicerca:=B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.
                      AnalizzaDocumentiImport(Trim(edtImpPath.Text),Trim(edtImpFiltro.Text),
                                              C700SelAnagrafe,SearchConfig);
    chkImpDocDaImportare.Items.Clear;
    lstImpDocIgnorati.Clear;
    for i:=0 to RisultatoRicerca.ListaDocumenti.Count - 1 do
    begin
      chkImpDocDaImportare.Items.Add(RisultatoRicerca.ListaDocumenti[i].NomeFile);
    end;
    for i:=0 to RisultatoRicerca.ListaFileIgnorati.Count - 1 do
    begin
      lstImpDocIgnorati.Items.Add(RisultatoRicerca.ListaFileIgnorati[i]);
    end;

    chkImpDocDaImportare.CheckAll(cbChecked);
    chkImpDocDaImportare.OnClickCheck(nil);
  finally
    FreeAndNil(SearchConfig);
  end;
end;

procedure TB022FUtilityGestDocumentale.btnImpEseguiClick(Sender: TObject);
var
  i,NumFile:Integer;
  ConfigImport:TB022DocumentiImportConfig;
  B022MW:TB022FUtilityGestDocumentaleMW;
  DataInizio,DataFine:TDateTime;
  DataInizioStr,DataFineStr:String;
  SplittedArray:array of String;
  DimMB:Double;
begin
  B022MW:=B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW;
  NumFile:=0;
  for i:=0 to chkImpDocDaImportare.Count - 1 do
  begin
    if chkImpDocDaImportare.Checked[i] then
      Inc(NumFile);
  end;
  if NumFile = 0 then
    Exit;

  // Se il path dello storage è su file system verifico che il servizio B021 risponda

  if (Parametri.CampiRiferimento.C90_PathAllegati <> 'DB') and (not B022MW.C021DM.TestWebService) then
    raise Exception.Create('Nessuna risposta dal servizio B021.');

  // Verifico la validità delle impostazioni
  if ((edtImpPeriodoDal.Text = DATA_VUOTA) and (edtImpPeriodoAl.Text <> DATA_VUOTA)) or
     ((edtImpPeriodoDal.Text <> DATA_VUOTA) and (edtImpPeriodoAl.Text = DATA_VUOTA)) then
    raise Exception.Create('Entrambe le date di riferimento devono essere valorizzate oppure vuote.');
  // A questo punto i casi sono: o ho valorizzato entrambe le date oppure nessuna.
  DataInizioStr:='NULL';
  DataFineStr:='NULL';
  if (edtImpPeriodoDal.Text <> DATA_VUOTA) and (edtImpPeriodoAl.Text <> DATA_VUOTA) then
  begin
    DataInizio:=StrToDate(edtImpPeriodoDal.Text); // Prendo solo la parte intera
    DataFine:=StrToDate(edtImpPeriodoAl.Text);
    if (DataInizio <> DATE_NULL) or
       (DataFine <> DATE_NULL) then
    begin
      // data inizio periodo
      // controlla validità nel range convenzionale
      if (DataInizio < DATE_MIN) or (DataInizio > DATE_MAX) then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO));
      // data fine periodo
      // controlla validità nel range convenzionale
      if (DataFine < DATE_MIN) or (DataFine > DATE_MAX) then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO));
      // controlla consecutività periodo
      if DataInizio > DataFine then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
      DataInizioStr:=edtImpPeriodoDal.Text;
      DataFineStr:=edtImpPeriodoAl.Text;
    end;
  end;

  if R180MessageBox('Importare ' + IntToStr(NumFile) + ' file?',DOMANDA,'Importa') = mrYes then
  begin
    // Se è attiva la sovrascrittura chiediamo conferma prima di proseguire
    if rgpImpAzioneDocTip.ItemIndex = 1 then
    begin
      if MessageDlg('È stato scelto di sovrascrivere i documenti esistenti della tipologia ' + dcmbImpTipologia.Text + '.' + CRLF +
                    'Tali documenti saranno cancellati se è presente un file da importare per il dipendente e non potranno essere recuperati.' + CRLF +
                    'Proseguire con l''importazione?',mtWarning,[mbYes,mbNo],-1,mbNo) = mrNo then
        Exit;
    end;
    prgImp.Max:=NumFile;
    prgImp.Position:=0;
    BloccaPageControlChange:=True;
    for i:=0 to pnlImpImposta.ControlCount - 1 do
    begin
      if pnlImpImposta.Controls[i] <> lblImpStato then
        pnlImpImposta.Controls[i].Enabled:=False;
    end;
    prgImp.Enabled:=True;
    Screen.Cursor:=crHourGlass;
    ConfigImport:=TB022DocumentiImportConfig.Create;
    try
      ConfigImport.Tipologia:=dcmbImpTipologia.KeyValue;
      ConfigImport.Sovrascrivi:=(rgpImpAzioneDocTip.ItemIndex = 1);
      ConfigImport.UfficioRiferimento:=dcmbImpUfficio.KeyValue;
      ConfigImport.PeriodoDal:=DataInizioStr;
      ConfigImport.PeriodoAl:=DataFineStr;
      ConfigImport.Note:=memNote.Lines.Text;
      ConfigImport.AccessoPortale:=IfThen(chkImpVisualIrisWeb.Checked,'S','N');
      try
        RegistraMsg.IniziaMessaggio('B022');
        for i:=0 to chkImpDocDaImportare.Items.Count - 1 do
        begin
          if chkImpDocDaImportare.Checked[i] then
          begin
            // Gli indici corrispondono
            lblImpStato.Caption:='Importazione di ' + RisultatoRicerca.ListaDocumenti.Items[i].NomeFile + '...';
            Application.ProcessMessages;
            // Verifico che la dimensione del file non ecceda i limiti
            // controllo dimensione file
            DimMB:=RisultatoRicerca.ListaDocumenti.Items[i].DimensioneByte / BYTES_MB;
            if DimMB > B022FUtilityGestDocumentaleDM.IterMaxDimAllegatoMB then
            begin
              RegistraMsg.InserisciMessaggio('A', 'Il file ' + RisultatoRicerca.ListaDocumenti.Items[i].NomeFile + ' supera la dimensione massima e non è stato importato',
                                             Parametri.Azienda, RisultatoRicerca.ListaDocumenti.Items[i].Progressivo);
            end
            else
              B022MW.ImportaDocumento(RisultatoRicerca.ListaDocumenti.Items[i],ConfigImport);
            prgImp.StepIt;
            Application.ProcessMessages;
          end;
        end;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format('Errore durante l''importazione di %s: %s',[RisultatoRicerca.ListaDocumenti.Items[i].NomeFile,E.Message]),
                                         Parametri.Azienda, RisultatoRicerca.ListaDocumenti.Items[i].Progressivo);
        end;
      end;
    finally
      for i:=0 to pnlImpImposta.ControlCount - 1 do
        pnlImpImposta.Controls[i].Enabled:=True;
      Screen.Cursor:=crDefault;
      lblImpStato.Caption:='';
      BloccaPageControlChange:=False;
      btnImpAnomalie.Enabled:=RegistraMsg.ContieneTipoI or RegistraMsg.ContieneTipoA;
      FreeAndNil(ConfigImport);
      if not RegistraMsg.ContieneTipoA then
        ShowMessage('Importazione terminata correttamente.')
      else
        ShowMessage('Si sono verificate anomalie durante l''importazione.');
    end;
  end;
end;

procedure TB022FUtilityGestDocumentale.btnImpPathBrowseClick(Sender: TObject);
var
  OpenDialog:TOpenDialog;
  FileOpenDialog:TFileOpenDialog;
begin
  if Win32MajorVersion >= 6 then  // Vista+
  begin
    FileOpenDialog:=TFileOpenDialog.Create(Self);
    try
      FileOpenDialog.Options:=[fdoPickFolders];
      if FileOpenDialog.Execute then
      begin
        ResetRicerca;
        edtImpPath.Text:=FileOpenDialog.FileName;
      end;
    finally
      FileOpenDialog.Free;
    end;
  end
  else
  begin
    OpenDialog:=TOpenDialog.Create(Self);
    OpenDialog.FileName:='path_documenti';
    try
      if OpenDialog.Execute then
      begin
        ResetRicerca;
        edtImpPath.Text:=ExtractFileDir(OpenDialog.FileName);
      end;
    finally
      OpenDialog.Free;
    end;
  end;
end;

procedure TB022FUtilityGestDocumentale.btnConfServSalvaClick(Sender: TObject);
var
  PortaAscolto:Integer;
begin
  try
    PortaAscolto:=StrToInt(Trim(edtConfServPorta.Text));
  except
    on Exc:EConvertError do
      raise Exception.Create('Numero di porta non valido.');

  end;
  if (PortaAscolto > 0) and (PortaAscolto < 65536) then
  begin
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B021','PORT',IntToStr(PortaAscolto));
    R180MessageBox('Impostazioni salvate. E'' necessario riavviare il servizio per rendere effettive le modifiche.',INFORMA,'Configurazione servizio','');
  end
  else
  begin
    raise Exception.Create('Numero di porta non valido (deve essere compreso tra 1 e 65535).');
  end;
end;

procedure TB022FUtilityGestDocumentale.LeggiParametriConf;
var
  TempStr:String;
begin
  // parametri rest service da I091
  edtConfURL.Text:=B022FUtilityGestDocumentaleDM.LeggiParametroI091(B022FUtilityGestDocumentaleDM.PARAM_URL_B021);
  TempStr:=B022FUtilityGestDocumentaleDM.LeggiParametroI091(B022FUtilityGestDocumentaleDM.PARAM_PATH_ALLEGATI);
  if (TempStr = 'DB') or (TempStr = '') then
  begin
    rgpConfPathDB.Checked:=True;
    edtConfPathFS.Text:='';
  end
  else
  begin
    rgpConfPathFS.Checked:=True;
    edtConfPathFS.Text:=TempStr;
  end;
  // porta di ascolto servizio
  edtConfServPorta.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','PORT','');
end;

procedure TB022FUtilityGestDocumentale.ToggleControlliConfAziend;
begin
  if not ParametriSolaLettura then
  begin
    edtConfPathFS.Enabled:=rgpConfPathFS.Checked;
    edtConfPathFS.Color:=IfThen(edtConfPathFS.Enabled,clWindow,clBtnFace);
  end
  else
  begin
    edtConfURL.Enabled:=False;
    edtConfURL.Color:=clBtnFace;
    rgpConfPathDB.Enabled:=False;
    rgpConfPathFS.Enabled:=False;
    edtConfPathFS.Enabled:=False;
    edtConfPathFS.Color:=clBtnFace;
  end;
end;

procedure TB022FUtilityGestDocumentale.ToggleControlliConfServ;
var
  ServizioInstallato:Boolean;
  InfoServizio:T180StatoServizio;
begin
  InfoServizio:=R180GetServiceStatus(B021_SERVICE_NAME);
  ServizioInstallato:=(InfoServizio.EsitoQuery = 0); // Se EsitoQuery = 0 siamo comunque riusciti ad eseguire QueryServiceStatus()
  edtConfServPorta.Enabled:=UtenteAdmin and ServizioInstallato;
  if edtConfServPorta.Enabled then
    edtConfServPorta.Color:=clWindow
  else
    edtConfServPorta.Color:=clBtnFace;
  btnConfServSalva.Enabled:=UtenteAdmin and ServizioInstallato;
  lblConfInfoConfServPerm.Visible:=not UtenteAdmin;
end;

procedure TB022FUtilityGestDocumentale.chkFiltroAnagrafeClick(Sender: TObject);
begin
  if AggiornaLastChkFiltroAnagrafeVal then
    LastChkFiltroAnagrafeVal:=chkFiltroAnagrafe.Checked;
end;

procedure TB022FUtilityGestDocumentale.chkImpDocDaImportareClickCheck(
  Sender: TObject);
begin
  ImpostaLabelSelezioneFile;
end;

procedure TB022FUtilityGestDocumentale.Copianegliappunti1Click(Sender: TObject);
var
  i:Integer;
  TestoCopiato:String;
begin
  TestoCopiato:='';
  for i:=0 to lstImpDocIgnorati.Items.Count - 1 do
  begin
    if i > 0 then
      TestoCopiato:=TestoCopiato + CRLF;
    TestoCopiato:=TestoCopiato + lstImpDocIgnorati.Items[i];
  end;
  Clipboard.Clear;
  Clipboard.AsText:=TestoCopiato;
end;

procedure TB022FUtilityGestDocumentale.ImpostaLabelSelezioneFile;
var
  i,NumFileSelezionati,DimensioneTotale:Integer;
begin
  NumFileSelezionati:=0;
  DimensioneTotale:=0;
  btnImpEsegui.Enabled:=False;
  for i:=0 to chkImpDocDaImportare.Items.Count - 1 do
  begin
    btnImpEsegui.Enabled:=True;
    if chkImpDocDaImportare.Checked[i] then
    begin
      inc(NumFileSelezionati);
      DimensioneTotale:=DimensioneTotale + RisultatoRicerca.ListaDocumenti[i].DimensioneByte;
    end;
  end;
  lblImpFilesSelezionati.Caption:='Files selezionati: ' + IntToStr(NumFileSelezionati);
  lblImpDimensTotale.Caption:='Dimensione totale ' + R180GetFileSizeStr(DimensioneTotale);
end;

procedure TB022FUtilityGestDocumentale.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to chkImpDocDaImportare.Count - 1 do
    chkImpDocDaImportare.Checked[i]:=not chkImpDocDaImportare.Checked[i];
end;

procedure TB022FUtilityGestDocumentale.ResetRicerca;
begin
  if RisultatoRicerca <> nil then
    FreeAndNil(RisultatoRicerca);
  chkImpDocDaImportare.Clear;
  lstImpDocIgnorati.Clear;
  ImpostaLabelSelezioneFile;
end;

procedure TB022FUtilityGestDocumentale.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  // distruzione procedure of object
  B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.ProgressBar:=nil;
  if RisultatoRicerca <> nil then
    FreeAndNil(RisultatoRicerca);
end;


end.

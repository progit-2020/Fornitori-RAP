unit WA058UTabelloneTurniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget, StrUtils, Math, DBXJSON,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, OracleData, Data.DB, Datasnap.DBClient,
  IWContainerLayout, IW.Browser.InternetExplorer, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWApplication,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, meIWRegion,
  IWCompButton, meIWButton, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompCheckbox, meIWCheckBox,
  meIWRadioGroup, medpIWMultiColumnComboBox, IWCompLabel, meIWLabel, IWCompEdit, Datasnap.Win.MConnect, Vcl.Menus,
  meIWEdit, meIWGrid, medpIWTabControl, medpIWMessageDlg,A000UInterfaccia, A000UMessaggi, A000UCostanti, A000USessione, meIWComboBox,
  C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A058UPianifTurniDtm1,
  WA058UDettaglioTurnoFM, WA058UCopiaPianificazioneFM, WC021URiepilogoAssenzeFM,
  IWHTMLControls, meIWLink, ActiveX, IWRenderContext, System.JSON;

const
  IDX_ORARIO = 0;
  IDX_TURNO1 = 1;
  IDX_EU1 = 2;
  IDX_MODIFICA = 3;
  IDX_TURNO2 = 4;
  IDX_EU2 = 5;
  IDX_ASSENZA1 = 6;
  IDX_ASSENZA2 = 7;
  //Griglia in browse
  IDX_LBL_BROWSE = 0;

type
  TWA058Dip = procedure (Dal,Al: TDateTime) of Object;

  TWA058FTabelloneTurniFM = class(TWR200FBaseFM)
    WA058TabelloneRG: TmeIWRegion;
    WA058ParametriRG: TmeIWRegion;
    edtDataDa: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    lblSquadra: TmeIWLabel;
    cmbSquadra: TMedpIWMultiColumnComboBox;
    cmbProfili: TMedpIWMultiColumnComboBox;
    lblCopiaAss: TmeIWLabel;
    rgpTipo: TmeIWRadioGroup;
    btnGeneraPDF: TmedpIWImageButton;
    btnVisualizzaPianif: TmeIWButton;
    btnEsegui: TmedpIWImageButton;
    LblDescrSquadra: TmeIWLabel;
    LblDescrProfilo: TmeIWLabel;
    lblTipo: TmeIWLabel;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    TemplateTabelloneRG: TIWTemplateProcessorHTML;
    grdTabControl: TmedpIWTabControl;
    cdsLista: TClientDataSet;
    cdsListaPag: TClientDataSet;
    DLista: TDataSource;
    grdTabellone: TmedpIWDBGrid;
    chkVisSaldiOre: TmeIWCheckBox;
    chkVisRiposi: TmeIWCheckBox;
    chkVisTotTurni: TmeIWCheckBox;
    lblDatiOpzionali: TmeIWLabel;
    DCOMConnection: TDCOMConnection;
    pmnAzioni: TPopupMenu;
    ModificaItem: TMenuItem;
    InsCancGiustifItem: TMenuItem;
    VisComAassenzaItem: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    chkVisRigaTurni: TmeIWCheckBox;
    chkVisBadge: TmeIWCheckBox;
    chkVisTabSint: TmeIWCheckBox;
    pmnAzioni2: TPopupMenu;
    MenuItem2: TMenuItem;
    lnkProfilo: TmeIWLink;
    btnSalva: TmeIWButton;
    btnCancella: TmeIWButton;
    btnOperativa: TmeIWButton;
    chkIniCorr: TmeIWCheckBox;
    PianificazioneReperibilit1: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure rgpTipoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdTabelloneAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbSquadraAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure grdTabelloneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkVisTotTurniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure CopiaPianifItemClick(Sender: TObject);
    procedure InsCancGiustifItemClick(Sender: TObject);
    procedure VisComAassenzaItemClick(Sender: TObject);
    procedure btnOperativaClick(Sender: TObject);
    procedure lnkProfiloClick(Sender: TObject);
    procedure PianificazioneReperibilit1Click(Sender: TObject);
    procedure ModificaItemClick(Sender: TObject);
  private
    Dal,Al:TDateTime;
    C004DM:TC004FParamForm;
    WA058FDettaglioTurnoFM: TWA058FDettaglioTurnoFM;
    WA058FCopiaPianificazioneFM: TWA058FCopiaPianificazioneFM;
    FNComp: String;
    StileCella1,StileCella2,ColoreCella: String;
    TempColore: String;
    procedure CaricaComboBox;
    procedure AggiornaLabel;
    procedure ElaboraTabellone;
    procedure ElaboraTabellone_2;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CaricaLista(Crea: Boolean);
    procedure CreaComponentiRiga(R: Integer);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure ResultShowTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultElabTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultRendiOperativa(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultCancellaTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CancellaTabellone;
    procedure ResultRegistraTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure RegistraTabellone;	
    function GetModificato: boolean;
    function CreateJSonString: String;
    function SalvaSuLista(Righa: integer): boolean;
    function DimLungHTML(S: String; D: Integer): String;
    function RetFriendlyName(Comp:TComponent):string;
    procedure VisualizzaRiepilogo;
    procedure OnModificaRapida(Sender: TObject);
  public
    A058DM: TA058FPianifTurniDtm1;
    WA058SelAnagrafe: TOracleDataSet;
    WA058SolaLettura: Boolean;
    AggiornaDipendentiDisponibili: TWA058Dip;
    A058Operazione: String;
    const
      NRIGHEBLOCCATE = 1;
      NCOLONNEBLOCCATE = 6;
    function ModificheInCorso: String;
    function GetTurni(InDato, InOrario, InT1: String; InData: TDate): String;
    procedure Inizializza;
    procedure ListaToCds;
    procedure Abilitazioni;
    procedure VisualizzaGriglia;
    procedure RefreshTabellone;
    procedure ElaboraStampa;
    procedure WA058TrasformaComponenti(FN:String;Crea:boolean = True);
    procedure ReleaseOggetti; override;
  end;

implementation

uses WR010UBase {$IFDEF WEBPJ}, WR100UBase, System.TypInfo {$ELSE},W008UGiustificativi, W004UReperibilita,
  System.TypInfo{$ENDIF};

{$R *.dfm}

procedure TWA058FTabelloneTurniFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FNComp:='';
  C004DM:=CreaC004(SessioneOracle,'WA058',Parametri.ProgOper,False);
  A058DM:=TA058FPianifTurniDtm1.Create(Self);
  grdTabControl.AggiungiTab('Pianificazione',WA058ParametriRG);
  grdTabControl.AggiungiTab('Tabellone',WA058TabelloneRG);
  grdTabControl.ActiveTab:=WA058ParametriRG;
end;

procedure TWA058FTabelloneTurniFM.ReleaseOggetti;
begin
  PutParametriFunzione;
  FreeAndNil(C004DM);
  inherited;
end;

function TWA058FTabelloneTurniFM.RetFriendlyName(Comp:TComponent):string;
var
  PropInfo:PPropInfo;
begin
  Result:='';
  PropInfo:=GetPropInfo(Comp.ClassInfo, 'FriendlyName');
  if Assigned(PropInfo) then
    Result:=GetStrProp(Comp,'FriendlyName');
end;

procedure TWA058FTabelloneTurniFM.Inizializza;
begin
  grdTabellone.medpPaginazione:=False;
  grdTabellone.medpDataSet:=cdsLista;
  grdTabellone.RigheIntestazione:=NRIGHEBLOCCATE;
  CaricaComboBox;
  btnEsegui.Enabled:=Not WA058SolaLettura and ((Parametri.A058_PianifOperativa = 'S') or (Parametri.A058_PianifNonOperativa = 'S'));
  A058DM.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  A058DM.DataFine:=R180FineMese(Parametri.DataLavoro);
  GetParametriFunzione;
  A058DM.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  A058DM.DataFine:=R180FineMese(Parametri.DataLavoro);
  A058DM.selAnagrafeA058:=WA058SelAnagrafe;
  AggiornaLabel;
  cmbSquadraAsyncChange(nil,nil,0,'');
  btnSalva.Visible:=False;
  btnCancella.Visible:=False;
  btnOperativa.Visible:=False;
end;

procedure TWA058FTabelloneTurniFM.CaricaComboBox;
begin
  with A058DM.Q600 do
  begin
    First;
    while not Eof do
    begin
      cmbSquadra.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  with A058DM.selT082 do
  begin
    First;
    while not Eof do
    begin
      cmbProfili.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.AggiornaLabel;
begin
  LblDescrSquadra.Caption:='';
  LblDescrProfilo.Caption:='';
  if Trim(cmbSquadra.Text) <> '' then
    LblDescrSquadra.Caption:=VarToStr(A058DM.Q600.Lookup('CODICE',Trim(cmbSquadra.Text),'DESCRIZIONE'));
  if Trim(cmbProfili.Text) <> '' then
    LblDescrProfilo.Caption:=VarToStr(A058DM.selT082.Lookup('CODICE',Trim(cmbProfili.Text),'DESCRIZIONE'));
end;

procedure TWA058FTabelloneTurniFM.CancellaTabellone;
var
  i:integer;
begin
  //Scorro Vista (elenco dipendenti)
  for i:=0 to A058DM.Vista.Count - 1 do
    A058DM.CancellaPianificazione(A058DM.Vista[i].Prog);
  CaricaLista(False);
  ListaToCds;
  VisualizzaGriglia;
end;

procedure TWA058FTabelloneTurniFM.ResultCancellaTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    CancellaTabellone;
end;

procedure TWA058FTabelloneTurniFM.btnCancellaClick(Sender: TObject);
var
  MsgCanc:string;
begin
  inherited;
  RegistraMsg.IniziaMessaggio('A058');
  MsgCanc:='';
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    MsgCanc:=A000MSG_A058_DLG_CANC_PIANIF_PROG
  else
    MsgCanc:=A000MSG_A058_DLG_CANC_PIANIF;
  MsgBox.WebMessageDlg(MsgCanc,mtConfirmation,[mbYes, mbNo],ResultCancellaTabellone,'');
end;

procedure TWA058FTabelloneTurniFM.btnEseguiClick(Sender: TObject);
var
  CodProfPianif:String;
begin
  try
    CodProfPianif:=cmbProfili.Text;
    if CodProfPianif = '' then
      raise Exception.Create(A000MSG_A058_ERR_PROFILO_MANCANTE);
    if Not A058DM.selT082.SearchRecord('CODICE',CodProfPianif,[srFromBeginning]) then
      raise Exception.Create(A000MSG_A058_ERR_PROFILO_ERRATO);
    Dal:=StrToDate(edtDataDa.Text);
    Al:=StrToDate(edtDataA.Text);
    if Al < Dal then
      raise Exception.Create(A000MSG_A058_ERR_PERIODO);
    if R180Anno(Dal) <> R180Anno(Al) then
      raise Exception.Create(A000MSG_A058_ERR_PERIODO_DATE);
  except
    on E:Exception do
      raise Exception.Create(E.Message);
  end;
  if Assigned(AggiornaDipendentiDisponibili) then
    AggiornaDipendentiDisponibili(Dal,Al);

  A058DM.NuovaPianif:=Sender = btnEsegui;
  if GetModificato then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_MODIFICHE_NON_SALVATE,mtConfirmation,[mbYes, mbNo],ResultShowTabellone,'');
    Abort;
  end
  else
    ElaboraTabellone_2;
end;

procedure TWA058FTabelloneTurniFM.btnGeneraPDFClick(Sender: TObject);
begin
  if Wa058selAnagrafe.RecordCount = 0 then
    raise Exception.create(A000MSG_ERR_NO_DIP);  
  if Trim(cmbProfili.Text) = '' then    
    raise Exception.Create(A000MSG_A058_ERR_PROFILO_MANCANTE);
  (*Su A058 non c'è il controllo della squadra
  if Trim(cmbSquadra.Text) = '' then
    raise Exception.Create(A000MSG_A058_ERR_SQUADRA_MANCANTE);*)
  if (Trim(edtDataDa.Text) = '') or (Trim(edtDataA.Text) = '')
    or(StrToDateTime(edtDataDa.Text) > StrToDateTime(edtDataA.Text)) then
    raise Exception.Create(A000MSG_A058_ERR_PERIODO);

  {$IFDEF WEBPJ}
    //IrisCloud
    (Self.Parent as TWR100FBase).StartElaborazioneServer(btnGeneraPDF.HTMLName);
  {$ELSE}
    //IrisWeb
    ElaboraStampa;
    (Self.Parent as TWR010FBase).VisualizzaFileWeb;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.btnOperativaClick(Sender: TObject);
var
  i:Integer;
begin
  if GetModificato then
    raise exception.Create(A000MSG_A058_ERR_REGISTRA_MODIFICHE);
  if not MsgBox.KeyExists('BTNOPERATIVA') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_RENDI_OPERATIVA,mtConfirmation,[mbYes, mbNo],ResultRendiOperativa,'BTNOPERATIVA');
    Abort;
  end;
  MsgBox.ClearKeys;
  with A058DM do
  begin
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
      RendiOperativa(i);
  end;
end;

procedure TWA058FTabelloneTurniFM.ResultRendiOperativa(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    btnOperativaClick(btnOperativa)
  else
    MsgBox.ClearKeys;
end;

procedure TWA058FTabelloneTurniFM.ElaboraStampa;
var
  DettaglioLog:OleVariant;
  DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  with (Self.Parent as TWR010FBase) do
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJSonString;

    //Necessario per IrisWeb
    if Assigned(AggiornaDipendentiDisponibili) then
      AggiornaDipendentiDisponibili(Dal,Al);

    if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection.Connected then
      DCOMConnection.Connected:=True;
    try
      DCOMConnection.AppServer.PrintA058(WA058selAnagrafe.SubstitutedSQL,
                                         DCOMNomeFile,
                                         Parametri.Operatore,
                                         Parametri.Azienda,
                                         WR000DM.selAnagrafe.Session.LogonDataBase,
                                         DatiUtente,
                                         DettaglioLog);
    finally
      DCOMConnection.Connected:=False;
    end;
  end;
end;

function TWA058FTabelloneTurniFM.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  C190Comp2JsonString(edtDataDa,json);
  C190Comp2JsonString(edtDataA,json);
  C190Comp2JsonString(rgpTipo,json);
  C190Comp2JsonString(cmbSquadra,json,'dcmbsquadra');
  C190Comp2JsonString(cmbProfili,json,'dcmbProfili');  
  Result:=json.ToString;
end;

procedure TWA058FTabelloneTurniFM.RegistraTabellone;
var
  i, j:Integer;
begin
  inherited;
  with A058DM do
  begin
    //Scorro Vista (elenco dipendenti)
    A058DM.GeneraIniCorr:=chkIniCorr.Checked;
    for i:=0 to Vista.Count - 1 do
      EseguiPianificazione(i);
    {Una volta registrata la pianificazione imposto TUTTI i flag modificato = false}
    for i:=0 to Vista.Count - 1 do
      for j:=0 to Vista[i].Giorni.Count - 1 do
        Vista[i].Giorni[j].Modificato:=False;
    NuovaPianif:=False;
    PckTurno.CopiaTurnazione;
  end;
  btnSalva.Visible:=False;
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.ResultRegistraTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    RegistraTabellone;
end;

procedure TWA058FTabelloneTurniFM.btnSalvaClick(Sender: TObject);
begin
  inherited;
  if (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and (A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A058_DLG_REG_PIANIF,mtConfirmation,[mbYes, mbNo],ResultRegistraTabellone,'');
    Exit;
  end;
  RegistraTabellone;
end;

procedure TWA058FTabelloneTurniFM.ResultShowTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    ElaboraTabellone_2;
end;

procedure TWA058FTabelloneTurniFM.ElaboraTabellone_2;
var s:String;
    i:Integer;
begin
  with A058DM do
  begin
    if ColoreCella <> '' then
      TempColore:=ColoreCella;
    if NuovaPianif then
      ColoreCella:=' bg_verde_pastello'
    else
      ColoreCella:=' bg_giallo_pastello';

    if NuovaPianif then
    begin
      //Primo scorrimento per verificare se esiste già una pianificazione
      S:='';
      i:=0;
      WA058SelAnagrafe.First;
      while not WA058SelAnagrafe.Eof do
      begin
        LeggiPianificazione(WA058SelAnagrafe.FieldByName('Progressivo').AsInteger,DataInizio,DataFine,False);
        if ((selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (Q080Gest.RecordCount > 0)) or
           ((selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (Q081Gest.RecordCount > 0)) then
        begin
          inc(i);
          if i > 20 then
          begin
            S:=S + 'ecc...' + CRLF;
            Break;
          end
          else
            S:=S + Format('%-8s %s %s',[WA058SelAnagrafe.FieldByName('MATRICOLA').AsString,WA058SelAnagrafe.FieldByName('COGNOME').AsString,WA058SelAnagrafe.FieldByName('NOME').AsString]) + CRLF;
        end;
        WA058SelAnagrafe.Next;
      end;

      if S <> '' then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A058_DLG_FMT_PIANIF_ESISTENTE,[S]),mtConfirmation,[mbYes, mbNo],ResultElabTabellone,'');
       Abort;
      end;
    end;
    ElaboraTabellone;
  end;
end;

procedure TWA058FTabelloneTurniFM.ResultElabTabellone(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    ElaboraTabellone
  else if TempColore <> '' then
    ColoreCella:=TempColore;
end;

procedure TWA058FTabelloneTurniFM.ElaboraTabellone;
begin
  try
    if (Self.Owner is TWR010FBase) then
    with (Self.Owner as TWR010FBase) do
    begin
      lstScrollBar[ScrollBarIndexOf('divtable')].Top:=0;
      lstScrollBar[ScrollBarIndexOf('divtable')].Top:=0;
    end;
    CaricaLista(A058DM.NuovaPianif);
    ListaToCds;
    VisualizzaGriglia;
    btnSalva.Visible:=(A058DM.Vista.Count >= 0) and A058DM.NuovaPianif;
    btnCancella.Visible:=(A058DM.Vista.Count >= 0);
    Abilitazioni;
    grdTabControl.ActiveTab:=WA058TabelloneRG;
  except
    on E:Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TWA058FTabelloneTurniFM.OnModificaRapida(Sender: TObject);
begin
  //Fix
end;

procedure TWA058FTabelloneTurniFM.VisualizzaGriglia;
var
  i,j:Integer;
  GGDate:TDate;
  strDDate: String;
begin
  if cdsLista.RecordCount > 0 then
  begin
    if StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1) <= 0 then
      grdTabellone.medpPaginazione:=False
    else
    begin
    (*Se si volesse la paginazione di default si è costretti a fare questa asegnazione
      grdTabellone.RighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);*)
    grdTabellone.medpPaginazione:=True;
    grdTabellone.medpRighePagina:=StrToInt(Parametri.CampiRiferimento.C90_WebRighePag);
    end;
  end;
  grdTabellone.medpCreaCDS;
  grdTabellone.medpEliminaColonne;
  grdTabellone.medpAggiungiColonna('DBG_COMANDI','','',nil);
  for i:=0 to cdsLista.FieldDefs.Count - 1 do
    if cdsLista.FieldDefs[i].Name = 'NOMINATIVO' then
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Nominativo','',nil)
    else if cdsLista.FieldDefs[i].Name = 'BADGE' then
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Badge','',nil)
    else if cdsLista.FieldDefs[i].Name = 'TOTTURNIDIP' then
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Tot.turni','',nil)
    else if cdsLista.FieldDefs[i].Name = 'SITUAZIONE_ORE' then
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Situazione ore','',nil)
    else if cdsLista.FieldDefs[i].Name = 'RIP_FES_TLAV' then
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Rip./Fest.Lav.','',nil)
    else if i >= NCOLONNEBLOCCATE - 1 then
    begin
      strDDate:=DateToStr(A058DM.DataInizio + i - NCOLONNEBLOCCATE + 1);
      if chkVisTabSint.Checked then
        strDDate:=FormatDateTime('dd/mm/yy',StrToDateTime(strDDate));
      strDDate:=strDDate + ' <br> ' + copy(R180NomeGiorno(StrToDateTime(strDDate)),1,3);
      grdTabellone.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,strDDate,'',nil);
      GGDate:=A058DM.DataInizio + i - NCOLONNEBLOCCATE + 1;
      with A058DM do
      begin
        if Vista.Count > 0 then
        begin
          GetCalend.SetVariable('PROG',Vista[0].Prog);
          GetCalend.SetVariable('D',GGDate);
          GetCalend.Execute;
        end;
        if (DayOfWeek(GGDate) = 1) or (VarToStr(GetCalend.GetVariable('F')) = 'S') then
          grdTabellone.medpColonna(cdsLista.FieldDefs[i].Name).Title.Css:='font_rosso';
      end;
    end;
  grdTabellone.medpColonna('TOTTURNIDIP').Visible:=chkVisTotTurni.Checked;
  grdTabellone.medpColonna('SITUAZIONE_ORE').Visible:=chkVisSaldiOre.Checked;
  grdTabellone.medpColonna('RIP_FES_TLAV').Visible:=chkVisRiposi.Checked;
  grdTabellone.medpColonna('BADGE').Visible:=chkVisBadge.Checked;
  grdTabellone.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdTabellone.medpInizializzaCompGriglia;
  if not WA058SolaLettura then
  begin
    grdTabellone.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','MODIFICA','null','','S');
    grdTabellone.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','ANNULLA','null','','S');
    grdTabellone.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','CONFERMA','null','','D');
  end;
  for j:=NCOLONNEBLOCCATE to grdTabellone.Columns.Count - 1 do
    grdTabellone.medpPreparaComponenteGenerico('R',j,IDX_LBL_BROWSE,DBG_LBL,'5','2','','','S');
  grdTabellone.medpCaricaCDS;

  for i:=NRIGHEBLOCCATE to grdTabellone.medpRighePagina + NRIGHEBLOCCATE - 1 do
    for j:=NCOLONNEBLOCCATE to grdTabellone.Columns.Count - 1 do
    begin
      (grdTabellone.medpCompCella(i,j,IDX_LBL_BROWSE) as TmeIWLabel).RawText:=True;
      (grdTabellone.medpCompCella(i,j,IDX_LBL_BROWSE) as TmeIWLabel).Tag:=j - NCOLONNEBLOCCATE;
      if not WA058SolaLettura then
        (grdTabellone.medpCompCella(i,j,IDX_LBL_BROWSE) as TmeIWLabel).medpContextMenu:=pmnAzioni;
    end;
end;

procedure TWA058FTabelloneTurniFM.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsListaPag.Locate('DBG_ROWID',AValue,[]);
end;

procedure TWA058FTabelloneTurniFM.ListaToCds;
var
  i, j:integer;
  sDep, sDep2, CellTurn, StrTurnoDet:String;
begin
  with A058DM do
  begin
    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('BADGE',ftString,100,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,100,False);
    cdsLista.FieldDefs.Add('TOTTURNIDIP',ftString,100,False);
    cdsLista.FieldDefs.Add('SITUAZIONE_ORE',ftString,100,False);
    cdsLista.FieldDefs.Add('RIP_FES_TLAV',ftString,100,False);
    {Creazione conlonne CDataSet(per lo più giorni del periodo)}
    for i := 0 to Trunc(DataFine - DataInizio) do
      cdsLista.FieldDefs.Add('GG' + IntToStr(i),ftString,300,False);
    cdsLista.CreateDataSet;
    for i:=0 to Vista.Count - 1 do
    begin
      cdsLista.Append;
      cdsLista.FieldByName('BADGE').AsString:=IntToStr(Vista[i].Badge);
      cdsLista.FieldByName('NOMINATIVO').AsString:=Vista[i].Cognome + ' ' + Vista[i].Nome + '</br>' +
                                                   '(' + Vista[i].Giorni[0].Squadra +
                                                   ifThen(Vista[i].Giorni[0].Oper <> '',' - ' + Vista[i].Giorni[0].Oper,'') + ')';
      cdsLista.FieldByName('SITUAZIONE_ORE').AsString:=DimLungHTML('Deb.con. ',9) + R180MinutiOre(Vista[i].Debito) + '</br>' +
                                                       DimLungHTML('Pianif. ',9) + R180MinutiOre(Vista[i].Assegnato) + '</br>' +
                                                       DimLungHTML('Scost. ',9) + R180MinutiOre(Vista[i].Assegnato - Vista[i].Debito);
      cdsLista.FieldByName('TOTTURNIDIP').AsString:='1T° ' + IntToStr(Vista[i].TotaleTurniMese.Turno1) + '</br>' +
                                                    '2T° ' + IntToStr(Vista[i].TotaleTurniMese.Turno2) + '</br>' +
                                                    '3T° ' + IntToStr(Vista[i].TotaleTurniMese.Turno3) + '</br>' +
                                                    '4T° ' + IntToStr(Vista[i].TotaleTurniMese.Turno4);
      sDep:= FormatDateTime('mm/yy',DataInizio - 1);
      if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
        sDep2:= '12/' + Copy(IntToStr(R180Anno(DataInizio) - 2),3,2)
      else
        sDep2:= '12/' + Copy(IntToStr(R180Anno(DataInizio) - 1),3,2);
      cdsLista.FieldByName('RIP_FES_TLAV').AsString:='Riposi: ' + IntToStr(Vista[i].RiposiPrec) + '</br>' +
                                                     'F.l. ' + sDep + ': ' + IntToStr(Vista[i].FestiviLavMesePrec) + '</br>' +
                                                     'F.l. ' + sDep2 + ': ' + IntToStr(Vista[i].FestiviLavAnnoPrec);
      for j:=0 to Trunc(DataFine - DataInizio) do
      begin
        if Vista[i].Giorni[j].Modificato then
          CellTurn:='<span class="align_top font_rosso">'
         else
          CellTurn:='<span class="align_top">';

        StrTurnoDet:='';
        if not chkVisTabSint.Checked then
          StrTurnoDet:=R180DimLung(Vista[i].Giorni[j].Ora,5);

        CellTurn:=CellTurn + Vista[i].Giorni[j].T1 + Vista[i].Giorni[j].T1EU +
                  Vista[i].Giorni[j].SiglaT1 + Vista[i].Giorni[j].T2 +
                  Vista[i].Giorni[j].T2EU + Vista[i].Giorni[j].SiglaT2 +
                  StrTurnoDet + '</span>';

        CellTurn:=CellTurn + '</br>';
        //Se non sono presenti assenze non inserisci tag <span>, ma </br>&nbsp;
        if (Trim(Vista[i].Giorni[j].Ass1) <> '') or (Trim(Vista[i].Giorni[j].Ass2) <> '') then
        begin
          if (Trim(Vista[i].Giorni[j].Ass1) <> '') then
            CellTurn:=CellTurn + '<span' + IfThen(Vista[i].Giorni[j].Modificato,' class="font_rosso" ','') +
                               '>' + Vista[i].Giorni[j].Ass1 + '</span>';
          if (Trim(Vista[i].Giorni[j].Ass2) <> '') then
            CellTurn:=CellTurn + '&nbsp;&nbsp;<span' + IfThen(Vista[i].Giorni[j].Modificato,' class="font_rosso" ','') +
                               '>' + Vista[i].Giorni[j].Ass2 + '</span>';
        end
        else
          CellTurn:=CellTurn + '&nbsp;';
        if Vista[i].Giorni[j].TurnRep <> '' then
          CellTurn:=CellTurn + '<div class="font_giallo bg_blu font_piccolo">R(' + Vista[i].Giorni[j].OraInizioRep + '-' + Vista[i].Giorni[j].OraFineRep + ') </div>'
        else
          CellTurn:=CellTurn + '</br>&nbsp;';
        cdsLista.FieldByName('GG' + IntToStr(j)).AsString:=CellTurn;
      end;
      cdsLista.Post;
    end;
    cdsLista.Open;
  end;
end;

procedure TWA058FTabelloneTurniFM.lnkProfiloClick(Sender: TObject);
begin
  inherited;
  {$IFDEF WEBPJ}
    //IrisCloud link a WA174
    (Self.Parent as TWR100FBase).AccediForm(213,'CODICE=' + cmbProfili.Text);
    A058DM.AssenzeOperative:=A058DM.selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
  {$ENDIF}
end;

function TWA058FTabelloneTurniFM.DimLungHTML(S:String; D:Integer):String;
var
  i,L:Integer;
begin
  if D = 0 then
    D:=S.Length;
  Result:=Copy(S,1,D);
  L:=Length(Result);
  for i:=L to D - 1 do
    Result:=Result + '&nbsp;';
end;

procedure TWA058FTabelloneTurniFM.CaricaLista(Crea:Boolean);
begin
  with A058DM do
  begin
    TipoPianif:=0;
    DataInizio:=StrToDate(edtDataDa.Text);
    DataFine:=StrToDate(edtDataA.Text);
    if DataInizio > DataFine then
      raise Exception.Create(A000MSG_A058_ERR_PERIODO);
    if WA058SelAnagrafe.RecordCount <= 0 then
      raise Exception.Create(A000MSG_ERR_NO_DIP);
    selT620.Close;
    selT620.SetVariable('DATAA',DataFine);
    selT620.Open;
    R502ProDtM.PeriodoConteggi(DataInizio,DataFine);
    R502ProDtM.Conteggi('APERTURA',0,DataInizio);
    ConteggiaDebito:=True;
    WA058SelAnagrafe.Close;
    ForzaOrdC700;
    WA058SelAnagrafe.Open;
    WA058SelAnagrafe.SQL.Text:=SalvaSQLOriginale;
    PulisciVista;
    WA058SelAnagrafe.First;
    while Not WA058SelAnagrafe.Eof do
    begin
      if Not AssenzeOperative then
      begin
        if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        begin
          SovrascriviT041.SetVariable('PROGRESSIVO',WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          SovrascriviT041.SetVariable('DATADA',DataInizio);
          SovrascriviT041.SetVariable('DATAA',DataFine);
          SovrascriviT041.Execute;
        end
        else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        begin
          InserisciT041.SetVariable('PROGRESSIVO',WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          InserisciT041.SetVariable('DATADA',DataInizio);
          InserisciT041.SetVariable('DATAA',DataFine);
          InserisciT041.Execute;
        end;
        InserisciT041.Session.Commit;
      end;
      if Not A058DM.NuovaPianif then
        LeggiPianificazione(WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataInizio,DataFine)
      else
        PianificaDipendente(WA058SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      if Vista.Count > 0 then
        DebitoDipendente(Vista.Count - 1,0,Trunc(DataFine - DataInizio));
      WA058SelAnagrafe.Next;
    end;
  end;
end;

function TWA058FTabelloneTurniFM.GetModificato:boolean;
var
  i, j:Integer;
begin
  Result:=False;
  with A058DM do
    for i:=0 to Vista.Count - 1 do
      for j:=0 to Vista[i].Giorni.Count - 1 do
        if Vista[i].Giorni[j].Modificato then
        begin
          Result:=True;
          Exit;
        end;
end;

procedure TWA058FTabelloneTurniFM.chkVisTotTurniAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if grdTabellone.DataSource.DataSet.Active and ((grdTabellone.DataSource.DataSet.RecordCount - 1) > 0) then
    if Sender = chkVisTotTurni then
      grdTabellone.medpColonna('TOTTURNIDIP').Visible:=chkVisTotTurni.Checked
    else if Sender = chkVisSaldiOre then
      grdTabellone.medpColonna('SITUAZIONE_ORE').Visible:=chkVisSaldiOre.Checked
    else if Sender = chkVisRiposi then
      grdTabellone.medpColonna('RIP_FES_TLAV').Visible:=chkVisRiposi.Checked
    else if Sender = chkVisBadge then
      grdTabellone.medpColonna('BADGE').Visible:=chkVisBadge.Checked;
end;

procedure TWA058FTabelloneTurniFM.cmbAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  if Trim(cmbProfili.Text) <> '' then
    A058DM.selT082.SearchRecord('CODICE',cmbProfili.Text,[srFromBeginning]);
  AggiornaLabel;
  Abilitazioni;
  btnSalva.Visible:=False;
  btnCancella.Visible:=False;
  btnOperativa.Visible:=False;
end;

procedure TWA058FTabelloneTurniFM.cmbSquadraAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  if Trim(cmbSquadra.Text) <> '' then
  begin
    R180SetVariable(A058DM.Q600B,'CODSQUADRA',cmbSquadra.Text);
    A058DM.Q600B.Open;
  end;
  AggiornaLabel;
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.rgpTipoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.Abilitazioni;
var
  s:String;
begin
  with A058DM do
  begin
    A058DM.AssenzeOperative:=A058DM.selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';

    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
      lnkProfilo.Caption:='Profilo pianificazione - NON operativo:'
    else
      lnkProfilo.Caption:='Profilo pianificazione - operativo:';

    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      btnCancella.Enabled:=(Parametri.A058_PianifOperativa = 'S') and (A058Operazione <> 'M') and (not WA058SolaLettura);
      btnSalva.Enabled:=(Parametri.A058_PianifOperativa <> 'N') and (A058Operazione <> 'M') and (not WA058SolaLettura);
      btnEsegui.Enabled:=(Parametri.A058_PianifOperativa = 'S') and (A058Operazione <> 'M') and (not WA058SolaLettura);
    end
    else
    begin
      btnCancella.Enabled:=(Parametri.A058_PianifNonOperativa = 'S') and (A058Operazione <> 'M') and (not WA058SolaLettura);
      btnSalva.Enabled:=(Parametri.A058_PianifNonOperativa <> 'N') and (A058Operazione <> 'M') and (not WA058SolaLettura);
      btnEsegui.Enabled:=(Parametri.A058_PianifNonOperativa = 'S') and (A058Operazione <> 'M') and (not WA058SolaLettura);
      btnOperativa.Enabled:=(Parametri.A058_PianifOperativa <> 'N') and (Parametri.A058_PianifNonOperativa <> 'N');
    end;
    //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
    if not WA058SolaLettura then
    begin
      chkVisTotTurni.Enabled:=(A058Operazione <> 'M');
      chkVisSaldiOre.Enabled:=(A058Operazione <> 'M');
      chkVisRiposi.Enabled:=(A058Operazione <> 'M');
      chkVisRigaTurni.Enabled:=(A058Operazione <> 'M');
      chkVisTabSint.Enabled:=(A058Operazione <> 'M');
      chkVisBadge.Enabled:=(A058Operazione <> 'M');
      //PIANIFICAZIONE PROGRESSIVA
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        {22/10/2013 - sempre abilitata - valutazione parametrizzazione profili
        RgpTipo.Enabled:=A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N';
        22/10/2013 - sempre abilitata - valutazione parametrizzazione "GENERAZIONE"
        if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          //PROGRESSIVA OPERATIVA: posso solo generarne una nuova o VISUALIZZARE quella operativa
          BEsegui.Enabled:=Parametri.A058_PianifOperativa <> 'N'
        else
          //PROGRESSIVA NON OPERATIVA: posso solo visualizzare quella INIZIALE o CORRENTE per poi modificarle
          BEsegui.Enabled:=False;}
        rgpTipo.Visible:=True;
        if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and
           ((selT082.FieldByName('INIZIALE').AsString = 'S') or (selT082.FieldByName('CORRENTE').AsString = 'S')) then
        begin
          rgpTipo.Enabled:=True;
          lblTipo.Enabled:=True;
        end
        else
        begin
          rgpTipo.Enabled:=False;
          lblTipo.Enabled:=False;
        end;
        GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(s);

        RgpTipo.Enabled:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and (selT082.FieldByName('INIZIALE').AsString = 'S') and (selT082.FieldByName('CORRENTE').AsString = 'S');

        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
        begin
          s:='$("#' + chkIniCorr.HTMLName + '").addClass("invisibile"); ';
          chkIniCorr.Css:=chkIniCorr.Css + ' invisibile';
        end
        else
        begin
          s:='$("#' + chkIniCorr.HTMLName + '").removeClass("invisibile"); ';
          chkIniCorr.Css:=StringReplace(chkIniCorr.Css,' invisibile','',[rfReplaceAll]);
        end;
        GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(s);

        if Not RgpTipo.Enabled then
          if selT082.FieldByName('CORRENTE').AsString = 'S' then
            RgpTipo.ItemIndex:=1
          else if selT082.FieldByName('INIZIALE').AsString = 'S' then
            RgpTipo.ItemIndex:=0;
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          btnEsegui.Enabled:=Parametri.A058_PianifOperativa = 'S'
        else
          btnEsegui.Enabled:=(selT082.FieldByName('GENERAZIONE').AsString = 'S') and (RgpTipo.ItemIndex = 0);
      end
      else
      begin
        //PIANIFICAZIONE STANDARD - NON PROGRESSIVA
        RgpTipo.Visible:=False;
        chkIniCorr.Visible:=False;
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          btnEsegui.Enabled:=Parametri.A058_PianifOperativa <> 'N'
        else
          btnEsegui.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
      end;

      //PIANIFICAZIONE PROGRESSIVA
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        //PIANIFICAZIONE OPERATIVA
        if (RgpTipo.ItemIndex = 0) and (selT082.FieldByName('GENERAZIONE').AsString = 'N') or
           (RgpTipo.ItemIndex = 0) and (selT082.FieldByName('INIZIALE').AsString = 'N') or
           (RgpTipo.ItemIndex = 1) and (selT082.FieldByName('CORRENTE').AsString = 'N') then
        begin
          Btnsalva.Enabled:=False;
          btnCancella.Enabled:=False;
        end;
        BtnOperativa.Visible:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (rgpTipo.ItemIndex = 1);
      end;
    end;
    lblCopiaAss.Visible:=((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or AssenzeOperative) and
                         (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');

    lblCopiaAss.Visible:=((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or
                         A058DM.AssenzeOperative) and (A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');
    if AssenzeOperative then
      lblCopiaAss.Caption:='Gestione assenze: OPERATIVA'
    else
    begin
      lblCopiaAss.Caption:='Gestione assenze: NON OPERATIVA';
      if (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') and
         (lblCopiaAss.Caption <> '') then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + #13#10;
      if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Aggiungi assenze da modalità operativa'
      else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Sovrascrivi assenze da modalità operativa';
    end;

  end;
end;

procedure TWA058FTabelloneTurniFM.grdTabelloneAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  StrHTML:string;
begin
  if Not WA058SolaLettura then
    for i:=NRIGHEBLOCCATE to High(grdTabellone.medpCompGriglia) do
    begin
      StileCella1:=(grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,1].Css;  //Stile all.sinistra
      StileCella2:=(grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,2].Css;  //Stile all.destra
      (grdTabellone.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaClick;
      (grdTabellone.medpCompCella(i,0,0) as TmeIWImageFile).medpContextMenu:=pmnAzioni2;
      (grdTabellone.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,1].Css:='invisibile';
      (grdTabellone.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
      (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,2].Css:='invisibile';
    end;

  if (grdTabellone.DataSource.DataSet.FieldByName('DBG_ROWID').AsString = '*1') or
     (grdTabellone.DataSource.DataSet.Locate('DBG_ROWID','*1',[])) then
  begin
    grdTabellone.DataSource.DataSet.Edit;
    with A058DM do
      for i:=0 to Trunc(DataFine - DataInizio) do
      begin
        //Se turni assegnati sono minori del minimo coloro font di rosso
        StrHTML:='<div>' + DimLungHTML('MN',3) + ' ' + DimLungHTML('AS',3) + ' ' + DimLungHTML('MX',3) + '</div><div';
        //Turno 1
        if aTotaleTurni[i].Turno1 < GetLimitiMAX_MIN(Trunc(DataInizio + i),1).Min then
          StrHTML:=StrHTML + ' class="font_rosso"';
        StrHTML:=StrHTML + '>' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),1).Min),3) + ' ' + DimLungHTML(IntToStr(aTotaleTurni[i].Turno1),3) + ' ' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),1).Max),3);
        StrHTML:=StrHTML + '</div><div';
        //Turno 2
        if aTotaleTurni[i].Turno2 < GetLimitiMAX_MIN(Trunc(DataInizio + i),2).Min then
          StrHTML:=StrHTML + ' class="font_rosso"';
        StrHTML:=StrHTML + '>' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),2).Min),3) + ' ' + DimLungHTML(IntToStr(aTotaleTurni[i].Turno2),3) + ' ' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),2).Max),3);
        StrHTML:=StrHTML + '</div><div';
        //Turno 3
        if aTotaleTurni[i].Turno3 < GetLimitiMAX_MIN(Trunc(DataInizio + i),3).Min then
          StrHTML:=StrHTML + ' class="font_rosso"';
        StrHTML:=StrHTML + '>' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),3).Min),3) + ' ' + DimLungHTML(IntToStr(aTotaleTurni[i].Turno3),3) + ' ' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),3).Max),3);
        StrHTML:=StrHTML + '</div><div';
        //Turno 4
        if aTotaleTurni[i].Turno4 < GetLimitiMAX_MIN(Trunc(DataInizio + i),4).Min then
          StrHTML:=StrHTML + ' class="font_rosso"';
        StrHTML:=StrHTML + '>' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),4).Min),3) + ' ' + DimLungHTML(IntToStr(aTotaleTurni[i].Turno4),3) + ' ' + DimLungHTML(IntToStr(GetLimitiMAX_MIN(Trunc(DataInizio + i),4).Max),3);
        StrHTML:=StrHTML + '</div>';
        grdTabellone.DataSource.DataSet.FieldByName('GG' + IntToStr(i)).AsString:=StrHTML;
      end;
    grdTabellone.DataSource.DataSet.Post;
    grdTabellone.DataSource.DataSet.Next;
  end;
end;

procedure TWA058FTabelloneTurniFM.grdTabelloneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;

  function GetVistaCelle(InVal:String):String;
  var
    NumRiga:Integer;
  begin
    Result:='';
    NumRiga:=((Max(grdTabellone.medpGetCurrPag,1) - 1) * grdTabellone.medpRighePagina) + (ARow - 1 - NRIGHEBLOCCATE);
    with A058DM do
    begin
      if (ARow > NRIGHEBLOCCATE) and (NumColonna >= NCOLONNEBLOCCATE) then
        if LowerCase(InVal) = 't1' then
          Result:=Trim(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].T1)
        else if LowerCase(InVal) = 't2' then
          Result:=Trim(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].T2)
        else if  LowerCase(InVal) = 'ass1' then
          Result:=Trim(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].Ass1)
        else if  LowerCase(InVal) = 'ass2' then
          Result:=Trim(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].Ass2)
        else if  LowerCase(InVal) = 'ora' then
          Result:=Trim(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].Ora)
        else if LowerCase(InVal) = 'cognome' then
          Result:=Trim(Vista[NumRiga].Cognome)
        else if LowerCase(InVal) = 'nome' then
          Result:=Trim(Vista[NumRiga].Nome)
        else if LowerCase(InVal) = 'data' then
          Result:=DateToStr(Vista[NumRiga].Giorni[NumColonna - NCOLONNEBLOCCATE].Data);
    end;
  end;

begin
  inherited;
  ACell.RawText:=False;
  NumColonna:=grdTabellone.medpNumColonna(AColumn);
  ACell.Css:='fontcourier';

  if not grdTabellone.medpRenderCell(ACell, ARow, AColumn, True, True) then
    Exit;

  if (ARow = 0) and (NumColonna >= NCOLONNEBLOCCATE) then
    with A058DM do
    begin
      ACell.RawText:=True;
      GetCalend.SetVariable('PROG',Vista[0].Prog);
      GetCalend.SetVariable('D',Vista[0].Giorni[NumColonna - NCOLONNEBLOCCATE].Data);
      GetCalend.Execute;
      if (GetCalend.GetVariable('F') = 'S') or
         (DayOfWeek(Vista[0].Giorni[NumColonna - NCOLONNEBLOCCATE].Data) = 1) then
        ACell.Css:=ACell.Css + ' font_rosso';
    end;

  if (ARow = NRIGHEBLOCCATE) and (not chkVisRigaTurni.Checked) then
    ACell.Css:=ACell.Css + ' medpHide';

  if (ARow > NRIGHEBLOCCATE) and (NumColonna >= NCOLONNEBLOCCATE) and
     (((GetVistaCelle('T1') <> '') and (GetVistaCelle('T1') <> '0')) or
     ((GetVistaCelle('T2') <> '') and (GetVistaCelle('T2') <> '0'))) and
     (GetVistaCelle('Ass1') = '') and (GetVistaCelle('Ass2') = '') then
  ACell.Css:=ACell.Css + ColoreCella;

  //assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdTabellone.medpCompGriglia) + 1) and
     (grdTabellone.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabellone.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end
  else if (ARow > 0) and (NumColonna >= 0) then
  begin
    ACell.Text:=grdTabellone.medpValoreColonna(ARow - 1,grdTabellone.medpColonna(NumColonna).DataField);
    ACell.RawText:=True;
  end;
  //contenuto testuale delle celle formattato in html (RawText)
  if (ARow > NRIGHEBLOCCATE) and (NumColonna >= NCOLONNEBLOCCATE) then
    if grdTabellone.medpBrowse or ((ACell.Control is TmeIWGrid) and
       (TmeIWGrid(ACell.Control).FriendlyName <> grdTabellone.medpClientDataSet.FieldByName('DBG_ROWID').AsString)) then
    begin
      (grdTabellone.medpCompCella(ARow - 1,NumColonna,IDX_LBL_BROWSE) as TmeIWLabel).Caption:=
      grdTabellone.medpValoreColonna(ARow - 1,grdTabellone.medpColonna(NumColonna).DataField);
      (grdTabellone.medpCompCella(ARow - 1,NumColonna,IDX_LBL_BROWSE) as TmeIWLabel).RawText:=True;
    end;

  //Hint cella cognome nome (data)
  if (not GetVistaCelle('COGNOME').IsEmpty) or (not GetVistaCelle('NOME').IsEmpty) then
    ACell.Hint:=GetVistaCelle('COGNOME') + ' ' + GetVistaCelle('NOME') + ' (' + GetVistaCelle('DATA') + ')';
end;

procedure TWA058FTabelloneTurniFM.imgModificaClick(Sender: TObject);
var
  FN: String;
  r,c:integer;
begin
  if not(Sender is TmeIWImageFile) then
    Exit;
  if R180In(A058Operazione,['I','M']) then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(A058Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!','ERRORE');
    Exit;
  end;
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  A058Operazione:='M';
  Abilitazioni;
  // porta la riga in modifica: trasforma i componenti
  WA058TrasformaComponenti(FN, True);
  grdTabellone.medpBrowse:=False;
  //inibisco il popupmenu a tutte le label non in edit(in riga)
  for r:=NRIGHEBLOCCATE to grdTabellone.RecordCount - 1 do
    for c:=NCOLONNEBLOCCATE to grdTabellone.Columns.Count - 1 do
      if grdTabellone.medpCompGriglia[r].CompColonne[c] is TmeIWLabel then
        (grdTabellone.medpCompGriglia[r].CompColonne[c] as TmeIWLabel).medpContextMenu:=nil;

end;

procedure TWA058FTabelloneTurniFM.imgAnnullaClick(Sender: TObject);
var
  FN: String;
  i: Integer;
begin
  if not (Sender is TmeIWImageFile) then
    Exit;
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdTabellone.medpRigaDiCompGriglia(FN);
  DBGridColumnClick(Sender,TmeIWImageFile(Sender).FriendlyName);
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,0].Css:=StileCella1;
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,1].Css:='invisibile';
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,2].Css:='invisibile';
  A058OPerazione:='A';
  Abilitazioni;
  WA058TrasformaComponenti(FN, False);
  VisualizzaGriglia;
  grdTabellone.medpBrowse:=True;
end;

procedure TWA058FTabelloneTurniFM.imgConfermaClick(Sender: TObject);
var
  FN: String;
  i: Integer;
begin
  if not (Sender is TmeIWImageFile) then
    Exit;
  FN:=TmeIWImageFile(Sender).FriendlyName;
  i:=grdTabellone.medpRigaDiCompGriglia(FN);
  btnSalva.Visible:=SalvaSuLista(i);
  DBGridColumnClick(Sender,TmeIWImageFile(Sender).FriendlyName);
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,0].Css:=StileCella1;
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,1].Css:='invisibile';
  (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,2].Css:='invisibile';
  WA058TrasformaComponenti(FN, False);
  ListaToCds;
  VisualizzaGriglia;
  grdTabellone.medpBrowse:=True;
  A058OPerazione:='C';
  Abilitazioni;
end;

procedure TWA058FTabelloneTurniFM.WA058TrasformaComponenti(FN:String; Crea:Boolean = True);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdPianif
var DaTestoAControlli:Boolean;
    i,j,IVista:Integer;
    StrJScript:String;

  procedure CaricaTurni(ICmbIn:TIWCustomControl; Val:String);
  var
    y, r, c:integer;
    FiltroT021:String;
  begin
    with A058DM, (ICmbIn as TmeIWComboBox) do
    begin
      r:=grdTabellone.medpRigaDiCompGriglia(ICmbIn.FriendlyName);
      c:=ICmbIn.Tag;
      RequireSelection:=True;
      FiltroT021:='(CODICE = ''' + Vista[r - NRIGHEBLOCCATE].Giorni[c].Ora + ''')';
      if Vista[r - NRIGHEBLOCCATE].Giorni[c].Data > 0 then
      begin
        FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[r - NRIGHEBLOCCATE].Giorni[c].Data) + ' >= DECORRENZA)';
        FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[r - NRIGHEBLOCCATE].Giorni[c].Data) + ' <= DECORRENZA_FINE)';
      end;
      QT021.Filter:=FiltroT021;
      QT021.Filtered:=True;
      Items.Add('');
      for y:=0 to QT021.RecordCount do
        Items.Add(IntToStr(y));
      Val:=Trim(Val);
      if (Val = '') or R180In(Val,['A','M']) then
        ItemIndex:=0
      else
        try
          if StrToInt(Val) <= QT021.RecordCount then
            itemIndex:=StrToInt(Val) + 1;
        except
          ItemIndex:=0;
        end;
      //Css:=Css + ' width5chr';
      QT021.Filtered:=False;
    end;
  end;

begin
  // pre: not SolaLettura
  i:=grdTabellone.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=grdTabellone.medpCompGriglia[i].CompColonne[NCOLONNEBLOCCATE + 1] is TmeIWLabel;
  // immagine per cancellazione / annullamento operazione
  if Not Crea then
    DaTestoAControlli:=True;
  if DaTestoAControlli then
  begin
    (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,0].Css:='invisibile';
    (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,1].Css:=StileCella1;
    (grdTabellone.medpCompGriglia[i].CompColonne[0] as TIWGrid).Cell[0,2].Css:=StileCella2;
    if Crea then
      CreaComponentiRiga(i);
    with A058DM do
      for j:=0 to Trunc(DataFine - DataInizio) do
      begin
        iVista:=grdTabellone.medpOffset + i;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ORARIO) as TmeIWLabel).Caption:=Vista[IVista - NRIGHEBLOCCATE].Giorni[j].Ora;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ORARIO) as TmeIWLabel).Css:='width5chr';
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_TURNO1) as TmeIWComboBox).Tag:=j;
        CaricaTurni(grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_TURNO1),Vista[IVista - NRIGHEBLOCCATE].Giorni[j].T1);
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_EU1) as TmeIWEdit).Text:=Vista[IVista - NRIGHEBLOCCATE].Giorni[j].T1EU;
        //Construzione Javascript Controllo valori
        StrJScript:='if ((this.value != "E") && (this.value != "U") && (this.value != ""))';
        StrJScript:=StrJScript + '{alert("Attenzione! I valori devono essere E o U."); this.value="";}';
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_EU1) as TmeIWEdit).ScriptEvents.Values['onChange']:=StrJScript;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_TURNO2) as TmeIWComboBox).Tag:=j;
        CaricaTurni(grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_TURNO2),Vista[IVista - NRIGHEBLOCCATE].Giorni[j].T2);
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_EU2) as TmeIWEdit).Text:=Vista[IVista - NRIGHEBLOCCATE].Giorni[j].T2EU;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_EU2) as TmeIWEdit).ScriptEvents.Values['onChange']:=StrJScript;

        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ASSENZA1) as TmeIWLabel).Caption:=Vista[IVista - NRIGHEBLOCCATE].Giorni[j].Ass1;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ASSENZA1) as TmeIWLabel).Css:='width5chr';
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ASSENZA2) as TmeIWLabel).Caption:=Vista[IVista - NRIGHEBLOCCATE].Giorni[j].Ass2;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_ASSENZA2) as TmeIWLabel).Css:='width5chr';

        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_MODIFICA) as TmeIWImageFile).onClick:=ModificaItemClick;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_MODIFICA) as TmeIWImageFile).medpContextMenu:=pmnAzioni;
        (grdTabellone.medpCompCella(i,j + NCOLONNEBLOCCATE,IDX_MODIFICA) as TmeIWImageFile).Tag:=j;
      end;
  end
  else
  begin
    with A058DM do
    begin
      //orario
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_ORARIO]);
      //Turno 1
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_TURNO1]);
      //E/U Turno 1
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_EU1]);
      //Turno 2
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_TURNO2]);
      //E/U Turno 2
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_EU2]);
      //Ass1
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_ASSENZA1]);
      //Ass2
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_ASSENZA2]);
      //Link di modifica
      FreeAndNil(grdTabellone.medpCompGriglia[i].CompColonne[IDX_MODIFICA]);
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.CreaComponentiRiga(R:Integer);
var
  i:Integer;
begin
  with A058DM do
  begin
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_ORARIO,DBG_LBL,'5','2','Modello Orario','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_TURNO1,DBG_CMB,'3','','Numero Turno 1','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_EU1,DBG_EDT,'1','','E/U Turno 1','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_MODIFICA,DBG_IMG,'MODIFICA','MODIFICA','','','D');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_TURNO2,DBG_CMB,'3','','Numero Turno 2','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_EU2,DBG_EDT,'1','','E/U Turno 2','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_ASSENZA1,DBG_LBL,'5','2','Assenza 1','','S');
    grdTabellone.medpPreparaComponenteGenerico('C',0,IDX_ASSENZA2,DBG_LBL,'5','2','Assenza 2','','S');
    grdTabellone.Componenti[IDX_MODIFICA].Riga:=1;
    grdTabellone.Componenti[IDX_TURNO2].Riga:=1;
    grdTabellone.Componenti[IDX_EU2].Riga:=1;
    grdTabellone.Componenti[IDX_ASSENZA1].Riga:=2;
    grdTabellone.Componenti[IDX_ASSENZA2].Riga:=2;
    //La proprietà .GridInRiga va settata sull'ultima colonna della cella(altrimenti viene sovrascritta)
    grdTabellone.Componenti[High(grdTabellone.Componenti)].GridInRiga:=False;
    for i:=NCOLONNEBLOCCATE to grdTabellone.Columns.Count - 1 do
      grdTabellone.medpCreaComponenteGenerico(R,i,grdTabellone.Componenti);
  end;
end;

function TWA058FTabelloneTurniFM.SalvaSuLista(Righa:integer):boolean;
var
  day, RighaVista:Integer;
begin
  with A058DM do
  begin
    RighaVista:=Righa + grdTabellone.medpOffSet - NRIGHEBLOCCATE;
    Result:=False;
    for day:=0 to Trunc(DataFine - DataInizio) do
    begin
      if Vista[RighaVista].Giorni[day].Modificato then
        Result:=True;

      sNumTurno1:=Vista[RighaVista].Giorni[day].NumTurno1;
      sNumTurno2:=Vista[RighaVista].Giorni[day].NumTurno2;
      sT1EU:=Trim(Vista[RighaVista].Giorni[day].T1EU);
      sT2EU:=Trim(Vista[RighaVista].Giorni[day].T2EU);
      sAss1:=Trim(Vista[RighaVista].Giorni[day].Ass1);
      sAss2:=Trim(Vista[RighaVista].Giorni[day].Ass2);

      if (Trim(Vista[RighaVista].Giorni[day].T1) <> Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO1) as TmeIWComboBox).Text)) or
         (Trim(Vista[RighaVista].Giorni[day].T1EU) <> Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_EU1) as TmeIWEdit).Text)) then
      begin
        Vista[RighaVista].Giorni[day].T1:=IfThen(Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO1) as TmeIWComboBox).Text) = '','M',(grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO1) as TmeIWComboBox).Text);
        Vista[RighaVista].Giorni[day].SiglaT1:=GetTurni('SIGLATURNI',Vista[Righa - NRIGHEBLOCCATE].Giorni[day].Ora,
                                                                     Vista[Righa - NRIGHEBLOCCATE].Giorni[day].T1, DataInizio + day);
        Vista[RighaVista].Giorni[day].NumTurno1:=GetTurni('NUMTURNO',Vista[Righa - NRIGHEBLOCCATE].Giorni[day].Ora,
                                                                     Vista[Righa - NRIGHEBLOCCATE].Giorni[day].T1, DataInizio + day);
        Vista[RighaVista].Giorni[day].T1EU:=(grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_EU1) as TmeIWEdit).Text;
        Result:=True;
      end;
      if (Trim(Vista[RighaVista].Giorni[day].T2) <> Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO2) as TmeIWComboBox).Text)) or
         (Trim(Vista[RighaVista].Giorni[day].T2EU) <> Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_EU2) as TmeIWEdit).Text)) then
      begin
        Vista[RighaVista].Giorni[day].T2:=IfThen(Trim((grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO2) as TmeIWComboBox).Text) = '','M',(grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_TURNO2) as TmeIWComboBox).Text);
        Vista[RighaVista].Giorni[day].SiglaT2:=GetTurni('SIGLATURNI',Vista[Righa - NRIGHEBLOCCATE].Giorni[day].Ora,
                                                                     Vista[Righa - NRIGHEBLOCCATE].Giorni[day].T2, DataInizio + day);
        Vista[RighaVista].Giorni[day].NumTurno2:=GetTurni('NUMTURNO',Vista[Righa - NRIGHEBLOCCATE].Giorni[day].Ora,
                                                                     Vista[Righa - NRIGHEBLOCCATE].Giorni[day].T2, DataInizio + day);
        Vista[RighaVista].Giorni[day].T2EU:=(grdTabellone.medpCompCella(Righa,day + NCOLONNEBLOCCATE,IDX_EU2) as TmeIWEdit).Text;
        Result:=True;
      end;
      AggiornaContatoriTurni(RighaVista,day);
      ConteggiGiornalieri(DataInizio + Day,RighaVista,day);
      btnSalva.Visible:=Result;
    end;
  end;
end;

function TWA058FTabelloneTurniFM.GetTurni(InDato, InOrario, InT1:String;InData:TDate):String;
var
  i:Integer;
  FiltroT021:String;
begin
  with A058DM do
  begin
    InT1:=Trim(InT1);
    if (InT1 = '') or (InT1 = 'M') then
    begin
      Result:='';
      Exit;
    end
    else if InT1 = '0' then
    begin
      if InDato = 'SIGLATURNI' then
        Result:='(R)'
      else
        Result:='0';
      Exit;
    end;
    QT021.Filtered:=False;
    FiltroT021:='(CODICE = ''' + InOrario + ''')';
    if InData > 0 then
    begin
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(InData) + ' >= DECORRENZA)';
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(InData) + ' <= DECORRENZA_FINE)';
    end;
    QT021.Filter:=FiltroT021;
    QT021.Filtered:=True;
    QT021.First;
    i:=1;
    try
      while Not(QT021.Eof) and (i <> StrToInt(InT1)) do
      begin
        inc(i);
        QT021.Next;
      end;
      Result:=QT021.FieldByName(InDato).AsString;
      if InDato = 'SIGLATURNI' then
        Result:='(' + Result + ')';
    except
      Result:='';
    end;
  end;
end;

procedure TWA058FTabelloneTurniFM.GetParametriFunzione;
{Leggo i parametri della form}
begin
  with A058DM do
  begin
    DataInizio:=R180InizioMese(Parametri.DataLavoro);
    edtDataDa.Text:=DateToStr(DataInizio);
    DataFine:=R180FineMese(Parametri.DataLavoro);
    edtDataA.Text:=DateToStr(DataFine);
    cmbSquadra.Text:=C004DM.GetParametro('SQUADRA','');
    cmbProfili.Text:=C004DM.GetParametro('PROFILO','');
    RgpTipo.ItemIndex:=StrToInt(C004DM.GetParametro('TIPOPIANIFICAZIONE','0'));
    chkVisRigaTurni.Checked:=C004DM.GetParametro(UpperCase(chkVisRigaTurni.Name),'N') = 'S';
    chkVisBadge.Checked:=C004DM.GetParametro(UpperCase(chkVisBadge.Name),'N') = 'S';
    chkVisTabSint.Checked:=C004DM.GetParametro(UpperCase(chkVisTabSint.Name),'N') = 'S';
    chkVisTotTurni.Checked:=C004DM.GetParametro(UpperCase(chkVisTotTurni.Name),'N') = 'S';
    chkVisRiposi.Checked:=C004DM.GetParametro(UpperCase(chkVisRiposi.Name),'N') = 'S';
    chkVisSaldiOre.Checked:=C004DM.GetParametro(UpperCase(chkVisSaldiOre.Name),'N') = 'S';
    {AusT058.Edit;
    AusT058.FieldByName('CODICE').AsString:=C004DM.GetParametro('CODPROFILO','');
    AusT058.Post;}
    //selT082.SearchRecord('CODICE',AusT058.FieldByName('CODICE').AsString,[srFromBeginning]);
    selT082.SearchRecord('CODICE',cmbProfili.Text,[srFromBeginning]);
    Abilitazioni;
  end;
end;

procedure TWA058FTabelloneTurniFM.PianificazioneReperibilit1Click(
  Sender: TObject);
var
  Params, PCausale: String;
  Comp: TComponent;
  i, j:Integer;
  {$IFNDEF WEBPJ}W004: TW004FReperibilita;{$ENDIF}
begin
  inherited;
  if (A000GetInibizioni('Funzione','OpenA040PianifRep') = 'N') then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  FNComp:=RetFriendlyName(Comp);
  i:=grdTabellone.medpRigaDiCompGriglia(FNCOmp) + grdTabellone.medpOffSet;
  j:=Comp.Tag;

  PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1;
  if PCausale = '' then
      PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2;

  //Gestisco link a Giustificativi da Cloud/Web
  {$IFDEF WEBPJ}
    //IrisCloud
    Params:='PROGRESSIVO=' + IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog) + ParamDelimiter +
           'DATA=' + DateToStr(A058DM.DataInizio + j) + ParamDelimiter +
           'TIPOLOGIA=REPERIB';
    (Self.Parent as TWR100FBase).accediForm(16,Params,True);
  {$ELSE}
    //IrisWeb
    W004:=TW004FReperibilita.Create(GGetWebApplicationThreadVar);
    W004.SetParam('CHIAMANTE','W030');
    W004.SetParam('PROGRESSIVO',IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog));
    W004.SetParam('DAL',DateToStr(A058DM.DataInizio + j));
    W004.SetParam('AL',DateToStr(A058DM.DataFine + j));
    W004.OpenPage;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  with A058DM do
  begin
    C004DM.PutParametro('SQUADRA',VarToStr(cmbSquadra.Text));
    C004DM.PutParametro('PROFILO',VarToStr(cmbProfili.Text));
    C004DM.PutParametro('TIPOPIANIFICAZIONE',IntToStr(RgpTipo.ItemIndex));
    C004DM.PutParametro(UpperCase(UpperCase(chkVisTotTurni.Name)),IfThen(chkVisTotTurni.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisRiposi.Name),IfThen(chkVisRiposi.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisSaldiOre.Name),IfThen(chkVisSaldiOre.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisRigaTurni.Name),IfThen(chkVisRigaTurni.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisBadge.Name),IfThen(chkVisBadge.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(chkVisTabSint.Name),IfThen(chkVisTabSint.Checked,'S','N'));
    //C004DM.PutParametro('CODPROFILO',AusT058.FieldByName('CODICE').AsString);
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TWA058FTabelloneTurniFM.ModificaItemClick(Sender: TObject);
var
  i, j, k:Integer;
  FiltroT021, O:String;
  Comp: TComponent;

    procedure CaricaTurno(cmbIN:TmeIWComboBox;Val:String);
    var
      y:Integer;
    begin
      with A058DM do
      begin
        //Combox Turno1
        cmbIN.RequireSelection:=True;
        FiltroT021:='(CODICE = ''' + Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora + ''')';
        if Vista[i - NRIGHEBLOCCATE].Giorni[j].Data > 0 then
        begin
          FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[i - NRIGHEBLOCCATE].Giorni[j].Data) + ' >= DECORRENZA)';
          FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Vista[i - NRIGHEBLOCCATE].Giorni[j].Data) + ' <= DECORRENZA_FINE)';
        end;
        QT021.Filter:=FiltroT021;
        QT021.Filtered:=True;
        cmbIN.Items.Add('');
        for y:=0 to QT021.RecordCount do
          cmbIN.Items.Add(y.ToString);
        Val:=Val.Trim;
        if Val.IsEmpty or R180In(Val,['M','A']) then
          cmbIN.ItemIndex:=0
        else
          try
            if Val.ToInteger <= QT021.RecordCount then
              cmbIN.itemIndex:=StrToInt(Val) + 1;
          except
          end;
        cmbIN.Css:=cmbIN.Css + ' width5chrImp fontcourierImp';
        QT021.Filtered:=False;
      end;
    end;

    procedure CaricaTurnoEU(cmbIN:TmeIWComboBox;Val:String);
    begin
      cmbIN.Items.Add('');
      cmbIN.Items.Add('E');
      cmbIN.Items.Add('U');
      if Val = 'E' then
        cmbIN.ItemIndex:=1
      else if Val = 'U' then
        cmbIN.ItemIndex:=2
      else
        cmbIN.ItemIndex:=0;
      cmbIN.NonEditableAsLabel:=True;
      //Enabled:=not SolaLettura;
      cmbIN.Text:=Val;
      cmbIN.Css:=cmbIN.Css + ' width5chrImp fontcourierImp';
    end;

    procedure CaricaAssenze(cmbIN:TmeIWComboBox;Val:String);
    var y:Integer;
    begin
      with A058DM, cmbIN do
      begin
        Items.Add('');
        Q265.Filter:='TIPOCUMULO = ''H''';
        Q265.Filtered:=True;
        Q265.First;
        while not Q265.Eof do
        begin
          Items.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
          Q265.Next;
        end;
        NonEditableAsLabel:=False;
        //Enabled:=not SolaLettura;
        y:=0;
        while (y < Items.Count - 1) and
              (Trim(copy(Items[y],1,5)) <> Trim(Val)) do
          inc(y);
        ItemIndex:=0;
        if Trim(copy(Items[y],1,5)) = Trim(Val) then
          ItemIndex:=y;
        Css:=Css + ' width40chrImp fontcourierImp';
        Q265.Filtered:=False;
      end;
    end;

begin
  inherited;
  if (Parametri.A058_PianifOperativa = 'N') and (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and
     (((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('GENERAZIONE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 0) and (A058DM.selT082.FieldByName('INIZIALE').AsString = 'N')) or
     ((RgpTipo.ItemIndex = 1) and (A058DM.selT082.FieldByName('CORRENTE').AsString = 'N'))) then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;

  if Sender is TMenuItem then
    Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent
  else
    Comp:=Sender as TmeIWImageFile;

  WA058FDettaglioTurnoFM:=TWA058FDettaglioTurnoFM.Create(Self.Owner);
  WA058FDettaglioTurnoFM.A058DettDM:=A058DM;
  WA058FDettaglioTurnoFM.WA058TabFM:=Self;

  i:=grdTabellone.medpRigaDiCompGriglia(RetFriendlyName(Comp)) + grdTabellone.medpOffSet;
  j:=Comp.Tag;
  with WA058FDettaglioTurnoFM, A058DM do
  begin
    O:=Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora;
    if (not A000FiltroDizionario('MODELLI ORARIO',O)) and (not O.IsEmpty)  then
    begin
      Q020.Filtered:=False;
      cmbOrario.Enabled:=False;
    end
    else
    begin
      Q020.Filtered:=True;
      cmbOrario.Enabled:=True;
    end;

    cmbOrario.Items.Add('');
    Q020.First;
    while Not Q020.Eof do
    begiN
      cmbOrario.Items.Add(Format('%-5s %s',[Q020.FieldByName('CODICE').AsString, AggiungiApice(Q020.FieldByName('DESCRIZIONE').AsString)]));
      Q020.Next;
    end;
    k:=0;
    while (Trim(copy(cmbOrario.Items[k],1,5)) <> Vista[i - NRIGHEBLOCCATE].Giorni[j].Ora) and
          (k < cmbOrario.Items.Count - 1) do
      inc(k);
    cmbOrario.ItemIndex:=k;
    cmbOrario.NonEditableAsLabel:=False;
    cmbOrario.Css:=cmbOrario.Css + ' width40chrImp fontcourierImp';

    CaricaTurno(cmbTurno1,Vista[i - NRIGHEBLOCCATE].Giorni[j].T1);
    CaricaTurnoEU(cmbTurnoEU1,Vista[i - NRIGHEBLOCCATE].Giorni[j].T1EU);
    CaricaTurno(cmbTurno2,Vista[i - NRIGHEBLOCCATE].Giorni[j].T2);
    CaricaTurnoEU(cmbTurnoEU2,Vista[i - NRIGHEBLOCCATE].Giorni[j].T2EU);
    CaricaAssenze(cmbAss1,Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1);
    CaricaAssenze(cmbAss2,Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2);
    WA058FDettaglioTurnoFM.CaptionTitolo:=Vista[i - NRIGHEBLOCCATE].Cognome + ' ' + Vista[i - NRIGHEBLOCCATE].Nome +
                                          ' (' + DateToStr(Vista[i - NRIGHEBLOCCATE].Giorni[j].Data) + ')';
  end;
  WA058FDettaglioTurnoFM.IndDipendente:=i - NRIGHEBLOCCATE;
  WA058FDettaglioTurnoFM.IndGiorno:=j;
  WA058FDettaglioTurnoFM.FriendlyNameW030:=RetFriendlyName(Comp);
  WA058FDettaglioTurnoFM.VisualizzaScheda;
end;

procedure TWA058FTabelloneTurniFM.CopiaPianifItemClick(Sender: TObject);
var
  i:Integer;
  Comp: TComponent;
begin
  inherited;
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  i:=grdTabellone.medpRigaDiCompGriglia((Comp as TmeIWImageFile).FriendlyName) + grdTabellone.medpOffSet;
  WA058FCopiaPianificazioneFM:=TWA058FCopiaPianificazioneFM.Create(Self.Owner);
  WA058FCopiaPianificazioneFM.WA058SelAnagrafe:=WA058SelAnagrafe;
  with WA058FCopiaPianificazioneFM do
  begin
    A058DettDM:=A058DM;
    WA058TabFM:=Self;
    CurrProg:=IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog);
    FriendlyNameW030:=(Comp as TmeIWImageFile).FriendlyName;
    edtDataDa.Text:=DateToStr(A058DM.DataInizio);
    edtDataA.Text:=DateToStr(A058DM.DataFine);
    Visualizza;
  end;
end;

procedure TWA058FTabelloneTurniFM.InsCancGiustifItemClick(Sender: TObject);
var Params, PCausale: String;
    Comp: TComponent;
    i, j:Integer;
    {$IFNDEF WEBPJ}W008: TW008FGiustificativi;{$ENDIF}
begin
  if ((A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'N') or
     ((A058DM.selT082.fieldByName('MODALITA_LAVORO').AsString <> 'O') and not A058DM.AssenzeOperative)) then
  begin
    MsgBox.MessageBox(A000MSG_ERR_FUNZ_NON_ABILITATA,ERRORE);
    abort;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  FNComp:=RetFriendlyName(Comp);
  i:=grdTabellone.medpRigaDiCompGriglia(FNComp) + grdTabellone.medpOffSet;
  j:=Comp.Tag;

  PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1;
  if PCausale = '' then
      PCausale:=A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass2;

  //Gestisco link a Giustificativi da Cloud/Web
  {$IFDEF WEBPJ}
    //IrisCloud
    Params:='PROGRESSIVO=' + IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog) + ParamDelimiter +
           'DATA=' + DateToStr(A058DM.DataInizio + j) + ParamDelimiter +
           'CAUSALE=' + PCausale + ParamDelimiter +
           'CARTEL=S';
    (Self.Parent as TWR100FBase).accediForm(2,Params);
  {$ELSE}
    //IrisWeb
    if (A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'N') then
    begin
      W008:=TW008FGiustificativi.Create(GGetWebApplicationThreadVar);
      W008.SetParam('CHIAMANTE','W030');
      W008.SetParam('PROGRESSIVO',IntToStr(A058DM.Vista[i - NRIGHEBLOCCATE].Prog));
      W008.SetParam('DAL',DateToStr(A058DM.DataInizio + j));
      W008.SetParam('AL',DateToStr(A058DM.DataInizio + j));
      W008.OpenPage;
    end;
  {$ENDIF}
end;

procedure TWA058FTabelloneTurniFM.RefreshTabellone;
begin
  // Se arrivo dai giustificativi devo aggiornare il tabellone
  if FNComp <> '' then
  begin
    grdTabellone.medpBrowse:=True;
    A058OPerazione:='C';
    Abilitazioni;
    btnSalva.Visible:=True;
    FNComp:='';
    btnEseguiClick(btnVisualizzaPianif);
  end;
end;

procedure TWA058FTabelloneTurniFM.VisComAassenzaItemClick(Sender: TObject);
var
  WC021FRiepilogoAssenzeFM: TWC021FRiepilogoAssenzeFM;
  i,j:Integer;
  Comp: TComponent;
begin
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  i:=grdTabellone.medpRigaDiCompGriglia(RetFriendlyName(Comp)) + grdTabellone.medpOffSet;
  j:=Comp.Tag;

  if A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1 = '' then
  begin
    MsgBox.MessageBox('Nessun giustificativo di assenza trovato nel giorno corrente.',ESCLAMA);
    abort;
  end;

  WC021FRiepilogoAssenzeFM:=TWC021FRiepilogoAssenzeFM.Create(Self.Owner);
  WC021FRiepilogoAssenzeFM.VisualizzaFrame:=VisualizzaRiepilogo;
  WC021FRiepilogoAssenzeFM.CaricaDati(A058DM.Vista[i - NRIGHEBLOCCATE].Prog,
                                      A058DM.Vista[i - NRIGHEBLOCCATE].Giorni[j].Ass1,
                                      A058DM.DataInizio + j, 0);
end;

procedure TWA058FTabelloneTurniFM.VisualizzaRiepilogo;
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,770,-1,570, 'Riepilogo','#wc021_container',False,True);
end;

function TWA058FTabelloneTurniFM.ModificheInCorso: String;
begin
  Result:='';
  if GetModificato then
    Result:='Le modifiche apportate non sono state salvate! Uscire comunque?';
end;

end.

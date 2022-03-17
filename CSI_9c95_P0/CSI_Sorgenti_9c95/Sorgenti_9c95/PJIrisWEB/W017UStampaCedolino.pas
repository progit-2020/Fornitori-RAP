unit W017UStampaCedolino;

interface

uses
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton, IWCompCheckbox, Math, StrUtils,
  DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, RpCon, RpConDS, RpSystem, RpDefine,
  RpRave, RVCsStd, RVData, RvDirectDataView, RpRender, RpRenderPDF,
  RVClass, RVProj, RVCsData, Windows,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  A000UInterfaccia, A000USessione, A000UMessaggi, A000UCostanti,
  R010UPaginaWeb, R012UWebAnagrafico,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, RegistrazioneLog, P999UGenerale,
  IWVCLBaseContainer, IWContainer, Forms, IWVCLComponent, IWDBGrids,
  ActnList, IWCompGrids, IWCompExtCtrls,
  meIWLabel, meIWLink, meIWCheckBox, meIWButton, meIWEdit,
  W000UMessaggi, medpIWDBGrid, meIWImageFile;

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TCambi = record
    Valuta1:string;
    Valuta2:string;
    Cambio:real;
  end;

  TW017FStampaCedolino = class(TR012FWebAnagrafico)
    lblDataCedolinoDal: TmeIWLabel;
    edtDataCedolinoDal: TmeIWEdit;
    chkCumuloVociArretrate: TmeIWCheckBox;
    chkStampaOrigine: TmeIWCheckBox;
    cdsRiepilogo: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    cdsNote: TClientDataSet;
    btnDataCedolino: TmeIWButton;
    edtDataCedolinoAl: TmeIWEdit;
    lblDataCedolinoAl: TmeIWLabel;
    lblOpzioni: TmeIWLabel;
    dgrdCedolini: TmedpIWDBGrid;
    cdsP441: TClientDataSet;
    dsrP441: TDataSource;
    procedure btnDataCedolinoClick(Sender: TObject);
    procedure StampaCedolino;
    procedure dgrdCedoliniAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure imgStampaClick(Sender: TObject);
    procedure dgrdCedoliniRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    rvSystem:TRVSystem;
    rvDWRiepilogo,rvDWDettaglio,rvDWNote:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connRiepilogo,connDettaglio,connNote:TRVDataSetConnection;
    DataRetribuzione,DataCedolino,DataCumuloMax:TDateTime;
    IdCedolino:Integer;
    TitoloStampa,CittaStampa,CodFiscaleStampa,NcSedeServizio,NcUnitaOperativa,NcQualifica,NcDataInizio,NcPartitaIva:String;
    sPv_Cambi:array of TCambi;
    QueryCambio:TQueryCambio;
    procedure Dipendente(P:Integer);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure EsecuzioneStampa;
    procedure CreaClientDataset;
    procedure CaricaClientDataset;
    procedure ImpostaDataConsegna;
    procedure VerificaRicezionePdf;
  protected
    procedure OnCambiaProgressivo; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, IWGlobal, SyncObjs;

function TW017FStampaCedolino.InizializzaAccesso:Boolean;
begin
  Result:=True;
  lnkDipendente.Caption:='';
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  dgrdCedolini.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  dgrdCedolini.medpDataSet:=WR000DM.selP441;

  with WR000DM do
    selP500.Tag:=selP500.Tag + 1;

  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.P430RETRIB_MESE_PREC';
  GetDipendentiDisponibili(R180FineMese(Parametri.DataLavoro)); //Apro il selAnagrafeW
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  cmbDipendentiDisponibili.ItemIndex:=R180IndexOf(cmbDipendentiDisponibili.Items,selAnagrafeW.FieldByName('MATRICOLA').AsString,8);
  btnDataCedolinoClick(nil);
  OnCambiaProgressivo;
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select max(DATA_CEDOLINO) DATA_CEDOLINO from P441_CEDOLINO where CHIUSO = ''S'' and PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
    Open;
    if not FieldByName('DATA_CEDOLINO').IsNull then
    begin
      edtDataCedolinoDal.Text:=FormatDateTime('mm/yyyy',FieldByName('DATA_CEDOLINO').AsDateTime);
      edtDataCedolinoAl.Text:=FormatDateTime('mm/yyyy',FieldByName('DATA_CEDOLINO').AsDateTime);
    end
    else
    begin
      MessaggioStatus(ERRORE,A000TraduzioneStringhe(W000MSG_W017_MSG_NO_CEDOLINO_DISP));
      Exit;
    end;
    QueryCambio:=TQueryCambio.Create(nil);
    QueryCambio.Session:=SessioneOracle;
    btnDataCedolinoClick(nil);
    Close;
  end;
  if SolaLettura or (Parametri.WEBCedoliniFilePDF = 'S') then
  begin
    JavascriptBottom.Add('document.getElementById("grbOpzioni").className = "invisibile";');
    lblOpzioni.Visible:=False;
    chkCumuloVociArretrate.Visible:=False;
    chkStampaOrigine.Visible:=False;
  end;
end;

procedure TW017FStampaCedolino.DistruggiOggetti;
begin
  try FreeAndNil(QueryCambio); except end;
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try R180CloseDataSetTag0(WR000DM.selP500); except end;
  end;
end;

procedure TW017FStampaCedolino.OnCambiaProgressivo;
var M:String;
begin
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
    ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger
  else
    ParametriForm.Progressivo:=0;
  Dipendente(ParametriForm.Progressivo);
  btnDataCedolinoClick(nil);
end;

procedure TW017FStampaCedolino.Dipendente(P:Integer);
begin
  inherited;
  lnkDipendente.Caption:='';
  if not selAnagrafeW.SearchRecord('PROGRESSIVO',P,[srFromBeginning]) then
    selAnagrafeW.First;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  VisualizzaDipendenteCorrente;
end;

procedure TW017FStampaCedolino.VisualizzaDipendenteCorrente;
begin
  inherited;

  dgrdCedolini.medpBrowse:=True;
  dgrdCedolini.medpStato:=msBrowse;
  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  dgrdCedolini.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  dgrdCedolini.medpEliminaColonne;
  dgrdCedolini.medpAggiungiColonna('DBG_COMANDI','','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_CEDOLINO','Data cedolino','',nil);
  dgrdCedolini.medpAggiungiColonna('TIPO_CEDOLINO','Tipo cedolino','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_RETRIBUZIONE','Data retribuzione','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_EMISSIONE','Data emissione','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_CONSEGNA','Data consegna','',nil);
  dgrdCedolini.medpAggiungiColonna('ID_CEDOLINO','Id cedolino','',nil);

  dgrdCedolini.medpColonna('TIPO_CEDOLINO').Visible:=Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S';
  dgrdCedolini.medpColonna('DATA_CONSEGNA').Visible:=False;
  dgrdCedolini.medpColonna('ID_CEDOLINO').Visible:=False;

  dgrdCedolini.medpAggiungiRowClick('ID_CEDOLINO',DBGridColumnClick);
  dgrdCedolini.medpInizializzaCompGriglia;
  dgrdCedolini.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','STAMPA','Stampa','','');
  dgrdCedolini.medpCaricaCDS;
end;

procedure TW017FStampaCedolino.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  if (ASender is TmeIWImageFile) then
    IdCedolino:=cdsP441.Lookup('DBG_ROWID',AValue,'ID_CEDOLINO')
  else
    IdCedolino:=StrToIntDef(AValue,0);
  //Mi posiziono sull'anno giusto nella griglia
  cdsP441.Locate('ID_CEDOLINO',IntToStr(IdCedolino),[]);
  WR000DM.selP441.Locate('ID_CEDOLINO',IntToStr(IdCedolino),[]);
end;

procedure TW017FStampaCedolino.StampaCedolino;
var SQLText,Mat,TipoCedolino,NomeFileOrig,NomeFileTemp,PathPDF:String;
    Azione: Integer;
  procedure CalcoloCedolino;
  begin
    DataCumuloMax:=DataRetribuzione;
    if selAnagrafeW.FieldByName('P430RETRIB_MESE_PREC').AsString = 'S' then
      DataCumuloMax:=R180InizioMese(DataCumuloMax)-1;
    WR000DM.selP442.SetVariable('Data_Cumulo_Max',DataCumuloMax);
    WR000DM.selP442.Close;
    WR000DM.selP442.SetVariable('Progressivo',selAnagrafeW.FieldByName('Progressivo').AsInteger);
    WR000DM.selP442.Open;
    if WR000DM.selP442.RecordCount > 0 then
      CaricaClientDataSet;
  end;
  procedure CedolinoPDF;
  begin
    NomeFileOrig:=PathPDF + '\' + FormatDateTime('yyyymm',DataCedolino) + '\' + IntToStr(IdCedolino) + '.pdf';
    NomeFileTemp:=Mat + '_' + TipoCedolino + '_' + FormatDateTime('yyyymm',DataCedolino);
    if DataCedolino <> DataRetribuzione then
      NomeFileTemp:=NomeFileTemp + '_' + FormatDateTime('yyyymm',DataRetribuzione);
    if TipoCedolino = 'EX' then
      NomeFileTemp:=NomeFileTemp + '_' + FormatDateTime('yyyymmdd',WR000DM.selP441.FieldByName('DATA_EMISSIONE').AsDateTime);
    { TODO : TEST IW 15 }
    //NomeFileTemp:=gSC.UserCacheDir + NomeFileTemp + '.pdf';
    NomeFileTemp:=GGetWebApplicationThreadVar.UserCacheDir + NomeFileTemp + '.pdf';
    CopyFile(PChar(NomeFileOrig),PChar(NomeFileTemp),False);
    Azione:=0;
    if (Parametri.WebRichiestaConsegnaCed = 'S') and (WR000DM.selP441.FieldByName('DATA_CONSEGNA').AsString = '') then
    begin
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
        Azione:=1
      else
        Azione:=2;
    end;
    case Azione of
      0: VisualizzaFile(NomeFileTemp,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),nil,nil);
      1: VisualizzaFile(NomeFileTemp,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),ImpostaDataConsegna,nil);
      2: VisualizzaFile(NomeFileTemp,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),nil,VerificaRicezionePdf);
    end;
  end;
begin
  lblCommentoCorrente.Caption:='';
  with WR000DM.selP441 do
  begin
    if RecordCount = 0 then
      raise Exception.Create(A000TraduzioneStringhe(W000MSG_W017_MSG_NO_CEDOLINO_DISP));
    if Active then
    begin
      if UpperCase(FieldByName('TIPO_CEDOLINO').AsString) = 'NORMALE' then
        TipoCedolino:='NR'
      else if UpperCase(FieldByName('TIPO_CEDOLINO').AsString) = 'TREDICESIMA' then
        TipoCedolino:='TR'
      else
        TipoCedolino:='EX'
    end;
    try
      DataRetribuzione:=R180FineMese(StrToDate('01/' + FieldByName('DATA_RETRIBUZIONE').AsString));
    except
      raise Exception.Create(A000TraduzioneStringhe(W000MSG_W017_ERR_DATA_RETR_ERRATA));
    end;
    try
      DataCedolino:=R180FineMese(StrToDate('01/' + FieldByName('DATA_CEDOLINO').AsString));
    except
      raise Exception.Create(A000TraduzioneStringhe(W000MSG_W017_ERR_DATACEDOLINO_ERRATA));
    end;
  end;
  SQLText:=selAnagrafeW.SQL.Text;
  try
    //Ciclo sul range di dipendenti
    with WR000DM do
    begin
      TitoloStampa:='';
      CittaStampa:='';
      CodFiscaleStampa:='';
      selP500.Close;
      selP500.SetVariable('Anno', strtoint(FormatDateTime('yyyy',DataRetribuzione)));
      selP500.Open;
      if selP500.RecordCount > 0 then
      begin
        TitoloStampa:=selP500.fieldbyname('indirizzo').AsString;
        CittaStampa:=selP500.fieldbyname('cap').AsString + ' ' + selP500.fieldbyname('comune').AsString;
        CodFiscaleStampa:=selP500.fieldbyname('cod_fiscale').AsString;
        NcSedeServizio:=selP500.FieldByName('SEDE_SERVIZIO_CED').AsString;
        NcUnitaOperativa:=selP500.FieldByName('UNITA_OP_CED').AsString;
        NcQualifica:=selP500.FieldByName('QUALIFICA_CED').AsString;
        NcDataInizio:=selP500.FieldByName('DATA_INIZIO_CED').AsString;
        NcPartitaIva:=selP500.FieldByName('PIVA_CED').AsString;
        PathPDF:=selP500.FieldByName('PATH_FILEPDF_CED').AsString
      end
      else
      begin
        NcSedeServizio:='';
        NcUnitaOperativa:='';
        NcQualifica:='';
        NcDataInizio:='';
        NcPartitaIva:='';
        PathPDF:='';
      end;
      if Parametri.WEBCedoliniFilePDF <> 'S' then
      begin
        selP442.Close;
        selP442.ClearVariables;
        selP442.SQL.Clear;
        if chkCumuloVociArretrate.Checked then
          selP442.SQL.Add(selP442Cumulo.SQL.Text)
        else
          selP442.SQL.Add(selP442NonCumulo.SQL.Text);
        selP442.SetVariable('Progressivo',0);
        selP442.SetVariable('Data_Cedolino',DataCedolino);
        selP442.SetVariable('Data_Retribuzione',DataRetribuzione);
        selP442.SetVariable('Data_Emissione',selP441.FieldByName('DATA_EMISSIONE').AsString);
        //La data di emissione viene controllato solo per il cedolino Extra 27
        selP442.SetVariable('ControllaData','N');
        selP442.SetVariable('Tipo_Cedolino',TipoCedolino);
        if TipoCedolino = 'EX' then
          selP442.SetVariable('ControllaData','S');
        if chkStampaOrigine.Checked then
        begin
          selP442.SetVariable('CODICIDESCRIZIONI', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '') || RPAD(P442.ORIGINE,1,'' '') || '' '' || P442.ECCEZIONI) VOCE,' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE) DESCRIZIONE');
          selP442.SetVariable('CODICIDESCRIZIONIGRUPPO', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '') || RPAD(P442.ORIGINE,1,'' '') || '' '' || P442.ECCEZIONI),' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE)');
        end
        else
        begin
          selP442.SetVariable('CODICIDESCRIZIONI', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '')) VOCE,' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE) DESCRIZIONE');
          selP442.SetVariable('CODICIDESCRIZIONIGRUPPO', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '')),' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE)');
        end;
        CreaClientDataSet;
      end;
    end;
    selAnagrafeW.SetVariable('DATALAVORO',DataRetribuzione);
    selAnagrafeW.Close;
    selAnagrafeW.Open;
    //Posizionamento sulla matricola correntemente selezionata
    Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    if selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
    begin
      if Parametri.WEBCedoliniFilePDF = 'S' then
        CedolinoPDF
      else
      begin
        CalcoloCedolino;
        try
          EsecuzioneStampa;
        except
          on E:Exception do
            lblCommentoCorrente.Caption:=E.Message;
        end;
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
      end;
    end
    else
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ANAGRA_NON_DISPONIBILE));
      Abort;
    end;
  finally
    selAnagrafeW.CloseAll;
    selAnagrafeW.SQL.Text:=SQLText;
    selAnagrafeW.SetVariable('DATALAVORO',R180FineMese(Parametri.DataLavoro));
    selAnagrafeW.Open;
    selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  end;
end;

procedure TW017FStampaCedolino.CreaClientDataset;
begin
  with cdsRiepilogo do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Data',ftDate,0,False);
    FieldDefs.Add('Mese_Cedolino',ftString,20,False);
    FieldDefs.Add('Tipo_Cedolino',ftString,20,False);
    FieldDefs.Add('Matricola',ftString,8,False);
    FieldDefs.Add('Cognome_Nome',ftString,100,False);
    FieldDefs.Add('Data_Nascita',ftString,20,False);
    FieldDefs.Add('Sede_Servizio',ftString,100,False);
    FieldDefs.Add('Unita_Operativa',ftString,100,False);
    FieldDefs.Add('Inizio_Rapporto',ftString,20,False);
    FieldDefs.Add('Fine_Rapporto',ftString,20,False);
    FieldDefs.Add('Pos_Economica',ftString,100,False);
    FieldDefs.Add('Part_Time',ftString,10,False);
    FieldDefs.Add('Qualifica',ftString,100,False);
    FieldDefs.Add('Cod_Fiscale',ftString,16,False);
    FieldDefs.Add('Partita_Iva',ftString,11,False);
    FieldDefs.Add('PosizioneINAIL',ftString,15,False);
    FieldDefs.Add('Cambi_Valute',ftString,100,False);
    FieldDefs.Add('Modalita_Pagamento',ftString,100,False);
    FieldDefs.Add('Cod_Valuta_Stampa',ftString,10,False);
    FieldDefs.Add('Note',ftString,200,False);
    FieldDefs.Add('Tot_Competenze',ftString,20,False);
    FieldDefs.Add('Tot_Ritenute',ftString,20,False);
    FieldDefs.Add('Imponibile_Lordo',ftString,20,False);
    FieldDefs.Add('Ritenuta',ftString,20,False);
    FieldDefs.Add('Deduzioni',ftString,20,False);
    FieldDefs.Add('Detrazioni',ftString,20,False);
    FieldDefs.Add('Arrotondamento',ftString,20,False);
    FieldDefs.Add('Netto',ftString,20,False);
    IndexDefs.Clear;
    //IndexDefs.Add('Primario',('Gruppo;Nome;Badge;Matricola;Progressivo;Data;CodTurno'),[ixUnique]);
    //IndexName:='Primario';
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsDettaglio do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Cod_Voce',ftString,100,False);
    FieldDefs.Add('Desc_Voce',ftString,100,False);
    FieldDefs.Add('Cod_Valuta_Iniz',ftString,20,False);
    FieldDefs.Add('Importo_Valuta_Iniz',ftString,20,False);
    FieldDefs.Add('Quantita',ftString,20,False);
    FieldDefs.Add('DatoBase',ftString,20,False);
    FieldDefs.Add('Ritenute',ftString,20,False);
    FieldDefs.Add('Competenze',ftString,20,False);
    IndexDefs.Clear;
    //IndexDefs.Add('Primario',('Gruppo;Nome;Badge;Matricola;Progressivo;Data;CodTurno'),[ixUnique]);
    //IndexName:='Primario';
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsNote do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Note',ftString,236,False);
    IndexDefs.Clear;
    //IndexDefs.Add('Primario',('Gruppo;Nome;Badge;Matricola;Progressivo;Data;CodTurno'),[ixUnique]);
    //IndexName:='Primario';
    CreateDataSet;
    LogChanges:=False;
  end;
end;

procedure TW017FStampaCedolino.CaricaClientDataset;
const MaxCar = 40;
var Chiave,DescVoce,sDep,S:String;
    bPv_CalcolaProgressivi,bCambioTrovato:boolean;
    nPv_Detrazioni:Real;
    nPv_TotCompetenze,nPv_TotTrattenute,nPv_Netto:Real;
    nPv_DeduzioneNoTax:Real;
    i:Integer;
  function FormattaVoce(ImportoColonna:string; Importo:Real): string;
  begin
    Result:='';
    if ImportoColonna = 'R' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]))
    else if ImportoColonna = 'E' then
      Result:=Trim(Format('e%*.*n',[9,2,Importo]))
    else if ImportoColonna = 'C' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]))
    else if ImportoColonna = 'D' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]));
  end;
begin
  Chiave:=SelAnagrafeW.FieldByName('PROGRESSIVO').AsString;
  with WR000DM do
  begin
    //!!!!! Chiedere a Dario se è giusto inizializzarli per ogni dipendente
    nPv_Detrazioni:=0;
    nPv_DeduzioneNoTax:=0;
    bPv_CalcolaProgressivi:=True;
    //nPv_TotCompetenze:=0;
    //nPv_TotTrattenute:=0;
    //nPv_Netto:=0;
    SetLength(sPv_Cambi,0);
    //Popolo le modalità di pagamento
    selV430.Close;
    selV430.ClearVariables;
    selV430.SetVariable('Progressivo', SelAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selV430.SetVariable('DataRetrib', DataCumuloMax);
    selV430.SetVariable('DataCedolino', DataCedolino);
    //SACCO INIZIO: provo ad assegnare l'unità operativa
    //selV430.SetVariable('unioperselect', ', i501a.descrizione as descrunioper, i501b.descrizione as descrsedelav');
    //selV430.SetVariable('uniopertabella', ', i501centro_costo i501a');
    //selV430.SetVariable('unioperwhere', 'and i501a.codice(+) = t430.centro_costo');
    //selV430.SetVariable('uniopertabella', ', i501uo_azien i501a, i501sede_lav i501b');
    //selV430.SetVariable('unioperwhere', 'and i501a.codice(+) = t430.uo_azien and i501b.codice(+) = t430.sede_lav');
    //SACCO FINE: provo ad assegnare l'unità operativa
    S:='';
    if Trim(NcSedeServizio) <> '' then
      S:=S + ',' + Trim(NcSedeServizio) + ' descrsedelav';
    if Trim(NcUnitaOperativa) <> '' then
      S:=S + ',' + Trim(NcUnitaOperativa) + ' descrunioper';
    if Trim(NcQualifica) <> '' then
      S:=S + ',' + Trim(NcQualifica) + ' descrqualifica';
    if Trim(NcDataInizio) <> '' then
      S:=S + ',' + Trim(NcDataInizio) + ' descrdatainizio';
    if Trim(NcPartitaIva) <> '' then
      S:=S + ',' + Trim(NcPartitaIva) + ' descrpartitaiva';
    selV430.SetVariable('dati_P500', S);
    try
      selV430.Open;
    except
      raise exception.create('Dato anagrafico non trovato! Contattare l''amministratore del sistema!');
    end;
    //I dati di pagamento devono sempre essere presi alla data del cedolino
    R180SetVariable(selDatiPag,'Progressivo',SelAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selDatiPag,'Data_Cedolino',DataCedolino);
    selDatiPag.Open;
    cdsRiepilogo.Append;
    cdsRiepilogo.FieldByName('Chiave').AsString:=Chiave;
    cdsRiepilogo.FieldByName('Matricola').AsString:=SelAnagrafeW.FieldByName('MATRICOLA').AsString;
    cdsRiepilogo.FieldByName('Mese_Cedolino').AsString:=UpperCase(FormatDateTime('mmmm yyyy',DataRetribuzione));
    cdsRiepilogo.FieldByName('Tipo_Cedolino').AsString:=selP441.FieldByName('TIPO_CEDOLINO').AsString;
    cdsRiepilogo.FieldByName('Cognome_Nome').AsString:=SelAnagrafeW.FieldByName('COGNOME').AsString + ' ' + SelAnagrafeW.FieldByName('NOME').AsString;
    cdsRiepilogo.FieldByName('Data_Nascita').AsString:=SelAnagrafeW.FieldByName('DataNas').AsString;

    if selV430.RecordCount > 0 then
    begin
      if selV430.FindField('descrsedelav') <> nil then
        cdsRiepilogo.FieldByName('Sede_Servizio').AsString:=selV430.FieldByName('descrsedelav').AsString;
      if selV430.FindField('descrunioper') <> nil then
        cdsRiepilogo.FieldByName('Unita_Operativa').AsString:=selV430.FieldByName('descrunioper').AsString;
      if selV430.FindField('descrdatainizio') <> nil then
        cdsRiepilogo.FieldByName('Inizio_Rapporto').AsString:=selV430.FieldByName('descrdatainizio').AsString;
      cdsRiepilogo.FieldByName('Fine_Rapporto').AsString:=selV430.FieldByName('T430Fine').AsString;
      cdsRiepilogo.FieldByName('Pos_Economica').AsString:=selV430.fieldbyname('P430cod_posizione_economica').AsString;
      if (selV430.fieldbyname('p430perc_parttime').AsInteger <> 0) and (selV430.fieldbyname('p430perc_parttime').AsInteger <> 100) then
        cdsRiepilogo.FieldByName('Part_Time').AsString:=Format('%3.2f',[selV430.fieldbyname('p430perc_parttime').AsFloat]) + ' %';
      if selV430.FindField('descrqualifica') <> nil then
        cdsRiepilogo.FieldByName('Qualifica').AsString:=selV430.FieldByName('descrqualifica').AsString;
      cdsRiepilogo.FieldByName('Cod_Fiscale').AsString:=selV430.FieldByName('codfiscale').AsString;
      if selV430.FindField('descrpartitaiva') <> nil then
        cdsRiepilogo.FieldByName('Partita_Iva').AsString:=selV430.FieldByName('descrpartitaiva').AsString;
      cdsRiepilogo.FieldByName('PosizioneINAIL').AsString:=selV430.FieldByName('p092posizione_inail').AsString;
      if selP442.FieldByName('COD_PAGAMENTO').AsString = '1' then
      begin
        sDep:=selP442.FieldByName('DESC_PAGAMENTO').AsString + ' IBAN';
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=sDep ;
        //Calcolo i dati bancari dell'ordinante che sono uguali per tutti i dipendenti
        sDep:=selDatiPag.FieldByName('P430IBAN').AsString;
        (*sDep:=Format('%-2.2s',[selV430.FieldByName('COD_NAZIONE').AsString]);
        sDep:=sDep + '-' + Format('%-2.2s',[selV430.FieldByName('CIN_EUROPA').AsString]);
        sDep:=sDep + '-' + Format('%-1.1s',[selV430.FieldByName('CIN_ITALIA').AsString]);
        sDep:=sDep + '-' + Format('%-5.5s',[selV430.FieldByName('ABI').AsString]);
        sDep:=sDep + '-' + Format('%-5.5s',[selV430.FieldByName('CAB').AsString]);
        sDep:=sDep + '-' + Format('%-12.12s',[Copy(selV430.FieldByName('CONTO_CORRENTE').AsString,1,12)]);*)
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' ' + sDep);
        sDep:=trim(selDatiPag.FieldByName('P430D_COD_BANCA').AsString);
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' ' + sDep);
        sDep:=trim(selDatiPag.FieldByName('P430AGENZIA_BANCA').AsString);
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',' Agenzia ',' Branch ') + sDep);
      end
      else
      begin
        sDep:=trim(selP442.FieldByName('DESC_PAGAMENTO').AsString + ' ' + selDatiPag.FieldByName('P430D_COD_BANCA').AsString);
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=sDep;
        sDep:=trim(selDatiPag.FieldByName('P430AGENZIA_BANCA').AsString);
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' Agenzia ' + sDep;
        sDep:=trim(selDatiPag.FieldByName('P430CONTO_CORRENTE').AsString);
        if sDep <> '' then
          cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' C/C n. ' + sDep;
      end;
    end
    else
      cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(selP442.FieldByName('DESC_PAGAMENTO').AsString);
    cdsRiepilogo.FieldByName('COD_VALUTA_STAMPA').AsString:=selP442.fieldbyname('COD_VALUTA_STAMPA').AsString;
    //Gestione dei cambi (Valuta calcoli P441 --> Valuta netto P441)
    if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S')
    and (selP442.FieldByName('COD_VALUTA_BASE').AsString <> selP442.FieldByName('COD_VALUTA_STAMPA').AsString) then
    begin
      SetLength(sPv_Cambi,1);
      sPv_Cambi[0].Valuta1:=selP442.FieldByName('COD_VALUTA_BASE').AsString;
      sPv_Cambi[0].Valuta2:=selP442.FieldByName('COD_VALUTA_STAMPA').AsString;
      sPv_Cambi[0].Cambio:=QueryCambio.CambioValuta(sPv_Cambi[0].Valuta1,sPv_Cambi[0].Valuta2,selP442.FieldByName('DATA_CAMBIO_VALUTA').AsDateTime);
      if sPv_Cambi[0].Cambio <> 0 then
        cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:='1 ' + sPv_Cambi[0].Valuta1 + ' = ' + Trim(Format('%5.5f',[sPv_Cambi[0].Cambio])) + ' ' + sPv_Cambi[0].Valuta2;
    end;

    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleCompetenze.CodVoce,VFTotaleCompetenze.CodVoceSpeciale]),[srFromBeginning]) then
    begin
      nPv_TotCompetenze:=selP442.FieldByName('Importo').AsFloat;
      while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleCompetenze.CodVoce,VFTotaleCompetenze.CodVoceSpeciale]),[]) do
        nPv_TotCompetenze:=nPv_TotCompetenze + selP442.FieldByName('Importo').AsFloat;
      cdsRiepilogo.FieldByName('Tot_Competenze').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_TotCompetenze);
    end;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleRitenute.CodVoce,VFTotaleRitenute.CodVoceSpeciale]),[srFromBeginning]) then
    begin
      nPv_TotTrattenute:=selP442.FieldByName('Importo').AsFloat;
      while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleRitenute.CodVoce,VFTotaleRitenute.CodVoceSpeciale]),[]) do
        nPv_TotTrattenute:=nPv_TotTrattenute + selP442.FieldByName('Importo').AsFloat;
      cdsRiepilogo.FieldByName('Tot_Ritenute').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_TotTrattenute);
    end;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoce,VFTakeHome.CodVoce),IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoceSpeciale,VFTakeHome.CodVoceSpeciale)]),[srFromBeginning]) then
    begin
      nPv_Netto:=selP442.FieldByName('Importo').AsFloat;
      while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoce,VFTakeHome.CodVoce),IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoceSpeciale,VFTakeHome.CodVoceSpeciale)]),[]) do
        nPv_Netto:=nPv_Netto + selP442.FieldByName('Importo').AsFloat;
      cdsRiepilogo.FieldByName('Netto').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_Netto);
    end;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFImponibileIRPEFCong.CodVoce,VFImponibileIRPEFCong.CodVoceSpeciale]),[srFromBeginning]) then
    begin
      cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, selP442.FieldByName('Importo').AsFloat);
      if FormatDateTime('yyyy', selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) = FormatDateTime('yyyy',DataRetribuzione) then
        bPv_CalcolaProgressivi:=False;
    end;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDetrazioniIRPEFTotaliCong.CodVoce,VFDetrazioniIRPEFTotaliCong.CodVoceSpeciale]),[srFromBeginning]) then
    begin
      nPv_Detrazioni:=selP442.FieldByName('Importo').AsFloat;
      cdsRiepilogo.FieldByName('Detrazioni').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, selP442.FieldByName('Importo').AsFloat);
    end;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDeduzioneIRPEFNoTaxCong.CodVoce,VFDeduzioneIRPEFNoTaxCong.CodVoceSpeciale]),[srFromBeginning]) then
      nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442.FieldByName('Importo').AsFloat;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDeduzioneIRPEFFamCong.CodVoce,VFDeduzioneIRPEFFamCong.CodVoceSpeciale]),[srFromBeginning]) then
      nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442.FieldByName('Importo').AsFloat;
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFRitenutaIRPEFLordaCong.CodVoce,VFRitenutaIRPEFLordaCong.CodVoceSpeciale]),[srFromBeginning]) then
      cdsRiepilogo.FieldByName('Ritenuta').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, (selP442.FieldByName('Importo').AsFloat - nPv_Detrazioni));
    if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFArrotondamento.CodVoce,VFArrotondamento.CodVoceSpeciale]),[srFromBeginning]) then
      if selP442.FieldByName('Importo').AsFloat <> 0 then
        cdsRiepilogo.FieldByName('Arrotondamento').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, (selP442.FieldByName('Importo').AsFloat));

    if bPv_CalcolaProgressivi then
    begin
      cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:='';
      cdsRiepilogo.FieldByName('Ritenuta').AsString:='';
      cdsRiepilogo.FieldByName('Deduzioni').AsString:='';
      cdsRiepilogo.FieldByName('Detrazioni').AsString:='';
      nPv_DeduzioneNoTax:=0;
      selP442A.Close;
      selP442A.SetVariable('Cod_Voce', VFImponibileIRPEF.CodVoce);
      selP442A.SetVariable('CedolinoInStampa', selP442.FieldByName('ID_CEDOLINO').asInteger);
      selP442A.SetVariable('Progressivo', selP442.GetVariable('Progressivo'));
      selP442A.SetVariable('DataCedolinoInStampa', selP442.GetVariable('data_cedolino'));
      selP442A.SetVariable('DataRetribInStampa',DataRetribuzione);
      selP442A.Open;
      if selP442A.RecordCount > 0 then
        cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
      selP442A.Close;
      selP442A.SetVariable('Cod_Voce', VFRitenutaIRPEFNetta.CodVoce);
      selP442A.Open;
      if selP442A.RecordCount > 0 then
        cdsRiepilogo.FieldByName('Ritenuta').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
      selP442A.Close;
      selP442A.SetVariable('Cod_Voce', VFDetrazioniIRPEFTotali.CodVoce);
      selP442A.Open;
      if selP442A.RecordCount > 0 then
        cdsRiepilogo.FieldByName('Detrazioni').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
      selP442A.Close;
      selP442A.SetVariable('Cod_Voce', VFDeduzioneIRPEFNoTax.CodVoce);
      selP442A.Open;
      if selP442A.RecordCount > 0 then
        nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442A.FieldByName('IMPORTO').AsFloat;
      //La parte che segue è stata inserita da Andrea in data 28/01/2005
      selP442A.Close;
      selP442A.SetVariable('Cod_Voce', VFDeduzioneIRPEFFam.CodVoce);
      selP442A.Open;
      if selP442A.RecordCount > 0 then
        nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442A.FieldByName('IMPORTO').AsFloat;
    end;
    if nPv_DeduzioneNoTax > 0 then
      cdsRiepilogo.FieldByName('Deduzioni').AsString:=Trim(Format('%*.*n',[10,2,nPv_DeduzioneNoTax]));
    cdsRiepilogo.Post;

    //Popolo le note
    cdsNote.Append;
    cdsNote.FieldByName('CHIAVE').AsString:=Chiave;
    if chkCumuloVociArretrate.Checked then
    begin
      SelP441_Note.SetVariable('ID_CEDOLINO', selP442.FieldByName('ID_CEDOLINO').AsInteger);
      SelP441_Note.Open;
      cdsNote.FieldByName('Note').AsString:=trim(SelP441_Note.FieldByName('NOTE').AsString);
      SelP441_Note.Close;
    end
    else
      cdsNote.FieldByName('Note').AsString:=trim(selP442.FieldByName('NOTE').AsString);
    if Trim(cdsNote.FieldByName('Note').AsString) <> '' then
      cdsNote.Post
    else
      cdsNote.Cancel;
    //Dettaglio Voci
    selP442.First;
    while not selP442.Eof do
    begin
      if (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'S')
      or (    (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'D')
          and (selP442.FieldByName('IMPORTO').AsFloat <> 0)) then
      begin
        cdsDettaglio.Append;
        cdsDettaglio.FieldByName('CHIAVE').AsString:=Chiave;
        cdsDettaglio.FieldByName('Cod_Voce').AsString:=selP442.FieldByName('Voce').AsString;
        DescVoce:=selP442.FieldByName('Descrizione').AsString;
        if selP442.FieldByName('Stampa_Competenza').AsString = 'S' then
        begin
          if chkCumuloVociArretrate.Checked then
          begin
            if selP442.FieldByName('NumRec').AsInteger = 1 then
            begin
              if selP442.FieldByName('Data_Competenza_A').AsDateTime < DataRetribuzione then
              begin
                DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
                DescVoce:=DescVoce + FormatDateTime(' (mm/yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
              end
            end
            else
            begin
              DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
              DescVoce:=DescVoce + FormatDateTime('    (yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
            end
          end
          else
          begin
            if (selP442.FieldByName('Stampa_Competenza').AsString = 'S') and
               (FormatDateTime('mmyyyy',selP442.FieldByName('Data_Competenza_A').AsDateTime) <> FormatDateTime('mmyyyy',DataRetribuzione)) then
            begin
              DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
              DescVoce:=DescVoce + FormatDateTime(' (mm/yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
            end;
          end;
        end;
        cdsDettaglio.FieldByName('Desc_Voce').AsString:=DescVoce;
        cdsDettaglio.FieldByName('Cod_Valuta_Iniz').AsString:=selP442.FieldByName('Cod_Valuta_Iniz').AsString;
        if selP442.FieldByName('Importo_Valuta_Iniz').AsFloat <> 0 then
          cdsDettaglio.FieldByName('Importo_Valuta_Iniz').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo_Valuta_Iniz').AsFloat]));
        cdsDettaglio.FieldByName('Quantita').AsString:=Trim(selP442.FieldByName('Quantita').AsString);
        cdsDettaglio.FieldByName('DatoBase').AsString:=Trim(selP442.FieldByName('DatoBase').AsString);
        if selP442.FieldByName('Importo_Colonna').AsString = 'R' then
          cdsDettaglio.FieldByName('Ritenute').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]))
        else if selP442.FieldByName('Importo_Colonna').AsString = 'E' then
          cdsDettaglio.FieldByName('Ritenute').AsString:='e' + Trim(Format('%*.*n',[9,2,selP442.FieldByName('Importo').AsFloat]))
        else if selP442.FieldByName('Importo_Colonna').AsString = 'C' then
          cdsDettaglio.FieldByName('Competenze').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]))
        else if selP442.FieldByName('Importo_Colonna').AsString = 'D' then
          cdsDettaglio.FieldByName('DatoBase').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]));
        cdsDettaglio.Post;
        //Gestione dei cambi (Valuta P442 --> Valuta calcoli P441)
        if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S')
        and (   (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'S')
             or (    (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'D')
                 and (selP442.FieldByName('IMPORTO').AsFloat <> 0)))
        and not selP442.FieldByName('COD_VALUTA_INIZ').IsNull
        and (selP442.FieldByName('COD_VALUTA_INIZ').AsString <> selP442.FieldByName('COD_VALUTA_BASE').AsString) then
        begin
          bCambioTrovato:=False;
          for i:=0 to High(sPv_Cambi) do
            if (sPv_Cambi[i].Valuta1 = selP442.FieldByName('COD_VALUTA_INIZ').AsString)
            and (sPv_Cambi[i].Valuta2 = selP442.FieldByName('COD_VALUTA_BASE').AsString) then
            begin
              bCambioTrovato:=True;
              Break;
            end;
          if not bCambioTrovato then
          begin
            SetLength(sPv_Cambi,Length(sPv_Cambi) + 1);
            i:=High(sPv_Cambi);
            sPv_Cambi[i].Valuta1:=selP442.FieldByName('COD_VALUTA_INIZ').AsString;
            sPv_Cambi[i].Valuta2:=selP442.FieldByName('COD_VALUTA_BASE').AsString;
            sPv_Cambi[i].Cambio:=QueryCambio.CambioValuta(sPv_Cambi[i].Valuta1,sPv_Cambi[i].Valuta2,selP442.FieldByName('DATA_CAMBIO_VALUTA').AsDateTime);
            if sPv_Cambi[i].Cambio <> 0 then
            begin
              cdsRiepilogo.Edit;
              if cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString <> '' then
                cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:=cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString + '; ';
              cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:=cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString + '1 ' + sPv_Cambi[i].Valuta1 + ' = ' + Trim(Format('%5.5f',[sPv_Cambi[i].Cambio])) + ' ' + sPv_Cambi[i].Valuta2;
              cdsRiepilogo.Post;
            end;
          end;
        end;
      end;
      selP442.Next;
    end;
  end;
end;

procedure TW017FStampaCedolino.EsecuzioneStampa;
var rvComp:TRaveComponent;
    L:TStringList;
    NomeFile:String;
    dconnRiepilogo,dconnDettaglio,dconnNote:TRaveDataConnection;
    ODS:TOracleDataSet;
    Azione: Integer;
begin
  if Pos(INI_PAR_NO_STAMPACEDOLINO,W000ParConfig.ParametriAvanzati) > 0 then
    exit;
  try
    CSStampa.Enter;
    rvSystem:=TRVSystem.Create(Self);
    rvProject:=TRVProject.Create(Self);
    connRiepilogo:=TRVDataSetConnection.Create(Self);
    connDettaglio:=TRVDataSetConnection.Create(Self);
    connNote:=TRVDataSetConnection.Create(Self);
    rvRenderPDF:=TRvRenderPDF.Create(Self);
    L:=TStringList.Create;
    try
      rvProject.Engine:=RvSystem;
      rvRenderPDF.Active:=True;
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
        rvProject.ProjectFile:=gSC.ContentPath + 'report\W017StampaCedolinoInternazionale.rav'
      else
        rvProject.ProjectFile:=gSC.ContentPath + 'report\W017StampaCedolino.rav';
      connRiepilogo.Name:='connRiepilogo';
      connRiepilogo.DataSet:=cdsRiepilogo;
      connRiepilogo.RuntimeVisibility:=RpCon.rtNone;
      connDettaglio.Name:='connDettaglio';
      connDettaglio.DataSet:=cdsDettaglio;
      connDettaglio.RuntimeVisibility:=RpCon.rtNone;
      connNote.Name:='connNote';
      connNote.DataSet:=cdsNote;
      connNote.RuntimeVisibility:=RpCon.rtNone;
      rvProject.Open;
      rvProject.GetReportList(L,True);
      rvProject.SelectReport(L[0],True);
      rvDWRiepilogo:=(RVProject.ProjMan.FindRaveComponent('dwRiepilogo',nil) as TRaveDataView);
      rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
      rvDWNote:=(RVProject.ProjMan.FindRaveComponent('dwNote',nil) as TRaveDataView);
      //Impostazioni dei campi di Dettaglio
      dconnDettaglio:=CreateDataCon(connDettaglio);
      rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
      rvDWDettaglio.DataCon:=dconnDettaglio;
      CreateFields(rvDWDettaglio,nil,nil,True);
      //Impostazioni dei campi di Note
      dconnNote:=CreateDataCon(connNote);
      rvDWNote.ConnectionName:=dconnNote.Name;
      rvDWNote.DataCon:=dconnNote;
      CreateFields(rvDWNote,nil,nil,True);
      rvPage:=RVProject.ProjMan.FindRaveComponent('W017.Page',nil);
      //Impostazioni della banda bndTitolo
      rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
      (rvComp as TRaveBitmap).Height:=0;
      (rvComp as TRaveBitmap).Width:=0;
      try
        ODS:=TOracleDataSet.Create(nil);
        try
          ODS.Session:=SessioneOracle;
          ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
          ODS.Open;
          if ODS.RecordCount = 1 then
          begin
            (rvComp as TRaveBitmap).Image.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
            (rvComp as TRaveBitmap).Width:=1.2;
            if Parametri.RagioneSociale = 'A.O. "OSPEDALE L. SACCO"' then
            begin
              (rvComp as TRaveBitmap).Height:=0.896;
              rvComp:=RVProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
              (rvComp as TRaveContainerControl).Height:=1.06;
            end
            else
            begin
              (rvComp as TRaveBitmap).Height:=0.640;
              //(rvComp as TRaveBitmap).Width:=1.2;
              //qimgLogo.Picture.BitMap.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
            end;
          end;
          ODS.Close;
        finally
          FreeAndNil(ODS);
        end;
      except
      end;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
      (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
      //(rvComp as TRaveText).Text:=TitoloStampa;
      (rvComp as TRaveText).Text:=TitoloStampa + ' - ' + CittaStampa;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblCitta',rvPage);
      //(rvComp as TRaveText).Text:=CittaStampa;
      if CodFiscaleStampa <> '' then
        (rvComp as TRaveText).Text:='P.IVA/C.F. ' + CodFiscaleStampa
      else
        (rvComp as TRaveText).Text:='';
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
      begin
        rvComp:=RVProject.ProjMan.FindRaveComponent('lblCambiValute',rvPage);
        (rvComp as TRaveText).Text:='EXCHANGE RATES ' + UpperCase(FormatDateTime('mmmm yyyy',DataRetribuzione));
      end;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblCodFiscale',rvPage);
      // correzione per cedolino internazionale.ini - 25.06.2012
      if Assigned(rvComp) then
      begin
        (rvComp as TRaveText).Text:=IfThen(cdsRiepilogo.FieldByName('Partita_Iva').AsString = '','CODICE FISCALE','PARTITA IVA');
        rvComp:=RVProject.ProjMan.FindRaveComponent('dlblCodFiscale',rvPage);
        (rvComp as TRaveDataText).DataField:=IfThen(cdsRiepilogo.FieldByName('Partita_Iva').AsString = '','Cod_Fiscale','Partita_Iva');
      end;
      // correzione per cedolino internazionale.fine
      //Impostazioni dei campi di Riepilogo
      dconnRiepilogo:=CreateDataCon(connRiepilogo);
      rvDWRiepilogo.ConnectionName:=dconnRiepilogo.Name;
      rvDWRiepilogo.DataCon:=dconnRiepilogo;
      CreateFields(rvDWRiepilogo,nil,nil,True);
      //Generazione del file PDF
      rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
      rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
      rvSystem.DefaultDest:=rdFile;
      rvSystem.DoNativeOutput:=False;
      rvSystem.RenderObject:=RvRenderPDF;
      if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
      rvSystem.SystemFiler.StreamMode:=smTempFile
    else
      rvSystem.SystemFiler.StreamMode:=smMemory;
      NomeFile:=GetNomeFile('pdf');
      rvSystem.OutputFileName:=NomeFile;
      ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
      rvProject.Execute;
      if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
      begin
        Azione:=0;
        if (Parametri.WebRichiestaConsegnaCed = 'S') and (WR000DM.selP441.FieldByName('DATA_CONSEGNA').AsString = '') then
        begin
          if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
            Azione:=1
          else
            Azione:=2;
        end;
        case Azione of
          0: VisualizzaFile(NomeFile,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),nil,nil);
          1: VisualizzaFile(NomeFile,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),ImpostaDataConsegna,nil);
          2: VisualizzaFile(NomeFile,A000TraduzioneStringhe(W000MSG_W017_MSG_ANTEPRIMA_CEDOLINO),nil,VerificaRicezionePdf);
        end;
      end;
    finally
      try L.Free; except end;
      try rvProject.Close; except end;
      try FreeAndNil(dconnRiepilogo); except end;
      try FreeAndNil(dconnDettaglio); except end;
      try FreeAndNil(dconnNote); except end;
      try FreeAndNil(rvSystem); except end;
      try FreeAndNil(rvRenderPDF); except end;
      try FreeAndNil(rvProject); except end;
      try FreeAndNil(connRiepilogo); except end;
      try FreeAndNil(connDettaglio); except end;
      try FreeAndNil(connNote); except end;
      CSStampa.Leave;
    end;
  except
    on E: Exception do
      Log('Errore','EsecuzioneStampa',E);
  end;
end;

procedure TW017FStampaCedolino.VerificaRicezionePdf;
begin
  Messaggio(A000TraduzioneStringhe(A000MSG_MSG_CONFERMA),Format(A000TraduzioneStringhe(W000MSG_W017_PARAM_RICEZIONE_CEDOLINO),[WR000DM.selP441.FieldByName('TIPO_CEDOLINO').AsString,WR000DM.selP441.FieldByName('DATA_RETRIBUZIONE').AsString]),ImpostaDataConsegna,nil);
end;

procedure TW017FStampaCedolino.ImpostaDataConsegna;
begin
  with WR000DM do
  begin
    updP441.SetVariable('DATA_CONSEGNA',Trunc(R180Sysdate(SessioneOracle)));
    updP441.SetVariable('ID_CEDOLINO',IdCedolino);
    updP441.Execute;
    SessioneOracle.Commit;
    btnDataCedolinoClick(nil);
    selP441.SearchRecord('ID_CEDOLINO',IdCedolino,[srFromBeginning]);
  end;
end;

procedure TW017FStampaCedolino.btnDataCedolinoClick(Sender: TObject);
var Mat:String;
    CurrentProg: Integer;
begin
  inherited;
  if cmbDipendentiDisponibili.ItemIndex = -1 then
    exit;
  with WR000DM do
  begin
    selP441.Close;
    // 12.2.6
    //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8));
    Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    if selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
      selP441.SetVariable('PROGRESSIVO',selAnagrafeW.Lookup('MATRICOLA',Mat,'PROGRESSIVO'{'T430PROGRESSIVO'}))
    else
      selP441.SetVariable('PROGRESSIVO',0);
    try
      selP441.SetVariable('DATA_CEDOLINO1',R180FineMese(StrToDate('01/' + edtDataCedolinoDal.Text)));
    except
      selP441.SetVariable('DATA_CEDOLINO1',R180FineMese(Parametri.DataLavoro));
    end;
    try
      selP441.SetVariable('DATA_CEDOLINO2',R180FineMese(StrToDate('01/' + edtDataCedolinoAl.Text)));
    except
      selP441.SetVariable('DATA_CEDOLINO2',R180FineMese(Parametri.DataLavoro));
    end;
    selP441.SetVariable('WEB_CEDOLINI_GGEMISS',Parametri.WEBCedoliniGGEmiss);
    selP441.SetVariable('WEB_CEDOLINI_DATAMIN',Parametri.WEBCedoliniDataMin);
    selP441.SetVariable('WEB_CEDOLINI_MMPREC',Parametri.WEBCedoliniMMPrec);
    selP441.Open;
    selP441.Filtered:=Parametri.WEBCedoliniFilePDF = 'S';
    if selAnagrafeW.RecordCount > 0 then
      CurrentProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    Dipendente(CurrentProg);
  end;
end;

procedure TW017FStampaCedolino.dgrdCedoliniAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  inherited;
  //Righe dati
  for i:=0 to High(dgrdCedolini.medpCompGriglia) do
  begin
    DBGridColumnClick(nil,dgrdCedolini.medpValoreColonna(i,'ID_CEDOLINO'));
    // Associo l'evento OnClick all'icona di stampa
    if dgrdCedolini.medpCompGriglia[i].CompColonne[0] <> nil then
      (dgrdCedolini.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgStampaClick;
  end;
end;

procedure TW017FStampaCedolino.dgrdCedoliniRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna:Integer;
begin
  inherited;
  NumColonna:=dgrdCedolini.medpNumColonna(AColumn);
  if not dgrdCedolini.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0)
  and (dgrdCedolini.medpNumColonna(AColumn) <> dgrdCedolini.medpIndexColonna('DBG_COMANDI')) then
    ACell.Css:=ACell.Css + ' align_center';
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dgrdCedolini.medpCompGriglia) + 1) and (dgrdCedolini.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdCedolini.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW017FStampaCedolino.imgStampaClick(Sender: TObject);
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  StampaCedolino;
end;

procedure TW017FStampaCedolino.RefreshPage;
begin
  with WR000DM do
  begin
    selP500.Close;
    selP500.SetVariable('Anno',0);
    selP500.Open;
  end;
end;
end.
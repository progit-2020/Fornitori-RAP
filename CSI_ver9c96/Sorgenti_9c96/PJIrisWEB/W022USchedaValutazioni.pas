unit W022USchedaValutazioni;
{PUBDIST}

interface

uses
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl, IWApplication,
  IWCompEdit, IWCompButton, Math, StrUtils,
  DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, RegistrazioneLog, WC012UVisualizzaFileFM,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  A000UInterfaccia, A000USessione, A000UCostanti,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  W022USchedaValutazioniDtM, W022URiepilogoSchedeFM,
  IWVCLBaseContainer, IWContainer, Forms,
  IWVCLComponent, R012UWebAnagrafico, MConnect,
  IWDBGrids, ActnList, IWCompCheckbox, meIWCheckBox, meIWImageFile, meIWGrid,
  meIWLabel, IWCompGrids, IWCompExtCtrls, meIWLink, meIWEdit,
  meIWButton, medpIWDBGrid, IWCompJQueryWidget, meIWRadioGroup, WC501UMenuIrisWebFM;

const
  RegoleNonTrovate: String = 'Non disponibile: Regole non trovate';

type
  TW022FSchedaValutazioni = class(TR012FWebAnagrafico)
    DCOMConnection1: TDCOMConnection;
    btnApplicaAnno: TmeIWButton;
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    btnRiepilogoSchede: TmeIWButton;
    chkVisualizzaDipNonValutabili: TmeIWCheckBox;
    dgrdSchede: TmedpIWDBGrid;
    dsrSG710: TDataSource;
    cdsSG710: TClientDataSet;
    JQuery: TIWJQueryWidget;
    lblFrequenzaScheda: TmeIWLabel;
    rgpFrequenzaScheda: TmeIWRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkVisualizzaDipNonValutabiliClick(Sender: TObject);
    procedure btnApplicaAnnoClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgAccediClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure btnRiepilogoSchedeClick(Sender: TObject);
    procedure imgStampaClick(Sender: TObject);
    procedure imgCreaAutovalutazioneClick(Sender: TObject);
    procedure imgInformazioniClick(Sender: TObject);
    procedure dgrdSchedeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dgrdSchedeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpFrequenzaSchedaClick(Sender: TObject);
  private
    TipoValutazione,FiltroOld,OrderOld:String;
    SoloStampa,VisColObiettivi,VisColPRPV,VisColAllegati:Boolean;
    W022RiepilogoSchedeFM:TW022FRiepilogoSchedeFM;
    SenderTemp:TObject;
    procedure ImpostaCampiDaEstrarre;
    procedure EscludiDipendenti;
    procedure Dipendente(P:Integer);
    procedure PopolaGriglia;
    procedure CercaValutatoreSi;
    procedure CercaValutatoreNo;
    procedure Inserimento(CercaValutatore:Boolean);
    procedure VisualizzaStampa(NomeFile:String);
    procedure VerificaRicezionePdf;
    procedure ImpostaPresaVisioneSi;
    procedure ImpostaPresaVisioneNo;
    procedure ImpostaDataConsegna(Esito: String);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure OnCambiaProgressivo; override;
    procedure DistruggiOggetti; override;
  public
    W022DtM:TW022FSchedaValutazioniDtM;
    DataLavoro: TDateTime;
    sTipoVal: String;
    lstInibizioniOri: TStringList;
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses SyncObjs, W022UDettaglioValutazioni;

procedure TW022FSchedaValutazioni.IWAppFormCreate(Sender: TObject);
begin
  if WR000DM.SoloStampa then
  begin
    Tag:=443;
    Title:='(W022) Stampa scheda di valutazione';
  end
  else if WR000DM.TipoValutazione = 'V' then
  begin
    Tag:=423;
    Title:='(W022) Scheda di valutazione'
  end
  else
  begin
    Tag:=424;
    Title:='(W022) Scheda di autovalutazione';
  end;
  SoloStampa:=WR000DM.SoloStampa;
  TipoValutazione:=WR000DM.TipoValutazione;
  inherited;
end;

//procedure TW022FSchedaValutazioni.OpenPage;
function TW022FSchedaValutazioni.InizializzaAccesso:Boolean;
var
  S: String;
begin
  Result:=True;

  rgpFrequenzaScheda.Visible:=not SoloStampa and (Parametri.S710_SupervisoreValut = 'S');
  lblFrequenzaScheda.Visible:=rgpFrequenzaScheda.Visible;
  chkVisualizzaDipNonValutabili.Visible:=not SoloStampa and (TipoValutazione <> 'A');
  if TipoValutazione = 'A' then
    chkVisualizzaDipNonValutabili.Checked:=True;
  lblAnno.Visible:=not SoloStampa;
  edtAnno.Visible:=not SoloStampa;
  btnApplicaAnno.Visible:=not SoloStampa;
  btnRiepilogoSchede.Visible:=not SoloStampa;
  if SoloStampa then
    JQuery.OnReady.Add('$(''#' + 'grpTestata' + ''').hide(); ');

  W022DtM:=TW022FSchedaValutazioniDtM.Create(Self);
  W022DtM.SelAnagrafeW022:=selAnagrafeW;
  W022DtM.sTipoVal2:=TipoValutazione;
  W022DtM.SoloStampa2:=SoloStampa;
  ImpostaCampiDaEstrarre;
  edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro)-1);
  //Imposto l'anno di validità operazioni
  with W022DtM.selSG746 do
  begin
    Close;
    SetVariable('DATA',Parametri.DataLavoro);
    Open;
    while not Eof do
    begin
      if (Parametri.DataLavoro >= FieldByName('DATA_DA').AsDateTime)
      and (Parametri.DataLavoro <= FieldByName('DATA_A').AsDateTime) then
      begin
        edtAnno.Text:=IntToStr(R180Anno(FieldByName('DECORRENZA').AsDateTime));
        Break;
      end;
      Next;
    end;
  end;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  dgrdSchede.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  dgrdSchede.medpDataSet:=W022DtM.selQ710;

  if not SoloStampa then
  begin
    if Pos(':FILTRO_IN_SERVIZIO',selAnagrafeW.SQL.Text) > 0 then
    begin
      selAnagrafeW.SQL.Text:=StringReplace(selAnagrafeW.SQL.Text,':FILTRO_IN_SERVIZIO','AND V430.T430INIZIO <= :DATALAVORO AND NVL(V430.T430FINE,:DATALAVORO) >= TRUNC(:DATALAVORO,''YYYY'')',[rfReplaceAll]);
      selAnagrafeW.DeleteVariable('FILTRO_IN_SERVIZIO');
    end;
    FiltroOld:=VarToStr(selAnagrafeW.GetVariable('FILTRO'));
    if Pos('ORDER BY',FiltroOld) > 0 then
    begin
      OrderOld:=Copy(FiltroOld,Pos('ORDER BY',FiltroOld));
      FiltroOld:=Copy(FiltroOld,1,Pos('ORDER BY',FiltroOld) - 1);
    end
    else
      OrderOld:='ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';
    if Parametri.S710_SupervisoreValut <> 'S' then
    begin
      if TipoValutazione = 'A' then
        FiltroOld:=' AND (T030.PROGRESSIVO = ' + IntToStr(Parametri.ProgressivoOper) + ')'
      else
      begin
        S:=S + '  OR T030.PROGRESSIVO IN (SELECT /*+ UNNEST */ DISTINCT SG706A.PROGRESSIVO_VALUTATO' +
                                        ' FROM SG706_VALUTATORI_DIPENDENTE SG706A, T430_STORICO T430A' +
                                        ' WHERE SG706A.PROGRESSIVO = ' + IntToStr(Parametri.ProgressivoOper) +
                                        ' AND SG706A.PROGRESSIVO_VALUTATO = T430A.PROGRESSIVO' +
                                        ' AND :DATALAVORO BETWEEN T430A.DATADECORRENZA AND T430A.DATAFINE' +
                                        ' AND LEAST(:DATALAVORO,NVL(T430A.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN SG706A.DECORRENZA AND SG706A.DECORRENZA_FINE))' +
               ' AND T030.PROGRESSIVO <> ' + IntToStr(Parametri.ProgressivoOper) +
               ' AND T030.PROGRESSIVO NOT IN (SELECT /*+ UNNEST */ DISTINCT SG706A.PROGRESSIVO_VALUTATO' +
                                        ' FROM SG706_VALUTATORI_DIPENDENTE SG706A, T430_STORICO T430A' +
                                        ' WHERE SG706A.PROGRESSIVO <> ' + IntToStr(Parametri.ProgressivoOper) +
                                        ' AND SG706A.PROGRESSIVO_VALUTATO = T430A.PROGRESSIVO' +
                                        ' AND :DATALAVORO BETWEEN T430A.DATADECORRENZA AND T430A.DATAFINE' +
                                        ' AND LEAST(:DATALAVORO,NVL(T430A.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) BETWEEN SG706A.DECORRENZA AND SG706A.DECORRENZA_FINE)';
        FiltroOld:=StringReplace(WR000DM.FiltroRicerca,'/*VALUTATORE*/)',S,[rfReplaceAll]);
      end;
    end;
    selAnagrafeW.SetVariable('FILTRO',FiltroOld + ' ' + OrderOld);

    //Imposto l'anno di validità operazioni
    with W022DtM.selSG741 do
    begin
      Close;
      SetVariable('DATA',Parametri.DataLavoro);
      Open;
      while not Eof do
      begin
        if (FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S')
        and (Parametri.DataLavoro >= FieldByName('DATA_DA_OBIETTIVI').AsDateTime) then
        begin
          edtAnno.Text:=IntToStr(R180Anno(FieldByName('DECORRENZA').AsDateTime));
          Break;
        end;
        Next;
      end;
    end;
    // Inizializzazione C700 e frmSelAnagrafe
    DataLavoro:=EncodeDate(StrToInt(edtAnno.Text),12,31);
    W022DtM.DataLavoro2:=DataLavoro;
  end
  else
    DataLavoro:=Parametri.DataLavoro;

  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE';
  //Prendo i dipendenti nel FA al 31/12, in servizio almeno un giorno nell'anno e assegnati al valutatore (SG705/SG706)
  GetDipendentiDisponibili(DataLavoro);
  cmbDipendentiDisponibili.ItemIndex:=0;

  if not SoloStampa then
  begin
    FiltroOld:=VarToStr(selAnagrafeW.GetVariable('FILTRO'));
    if Pos('ORDER BY',FiltroOld) > 0 then
      FiltroOld:=Copy(FiltroOld,1,Pos('ORDER BY',FiltroOld) - 1);
    if Pos('/*#E.D.#*/',FiltroOld) > 0 then
      FiltroOld:=Copy(FiltroOld,1,Pos('/*#E.D.#*/',FiltroOld) - 1);
    //Ciclo sui dipendenti per vedere se escluderli
    EscludiDipendenti;
  end;

  //Mi posiziono sul dipendente, carico la griglia e mi posiziono sull'anno validità operazioni
  Dipendente(ParametriForm.Progressivo);
  DBGridColumnClick(nil,edtAnno.Text);
  btnRiepilogoSchede.Enabled:=selAnagrafeW.RecordCount > 0;
end;

procedure TW022FSchedaValutazioni.OnCambiaProgressivo;
var M:String;
begin
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
    ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger
  else
    ParametriForm.Progressivo:=0;
  Dipendente(ParametriForm.Progressivo);
  DBGridColumnClick(nil,edtAnno.Text);
end;

procedure TW022FSchedaValutazioni.IWAppFormRender(Sender: TObject);
var
  Data:String;
begin
  Data:=FormatDateTime('dd/mm/yyyy',W022DtM.selQ710.FieldByName('DATA').AsDateTime);
  //Serve a ricaricare i dipendenti dopo il cambio di valutatore
  if (W022DtM.Azione = 'M')
  and (W022DtM.ValutatoreNew <> '')
  and (W022DtM.ValutatoreOld <> W022DtM.ValutatoreNew)
  and (Parametri.S710_SupervisoreValut <> 'S') then
  begin
    MsgBox.MessageBox('La scheda di valutazione di ' + Format('%-s %s %s',[selAnagrafeW.FieldByName('MATRICOLA').AsString,selAnagrafeW.FieldByName('COGNOME').AsString,selAnagrafeW.FieldByName('NOME').AsString]) + ' è stata assegnata ad un altro ' + W022DtM.RecuperaEtichetta('VALUTATORE_C','L') + '; pertanto il ' + W022DtM.RecuperaEtichetta('VALUTATO_C','L') + ' potrebbe non essere più selezionabile dalla lista per l''anno ' + IntToStr(R180Anno(W022DtM.Q710.FieldByName('DATA').AsDateTime)) + '!',INFORMA);
    if W022DtM.cdsRegole.Locate('DATA;PROGRESSIVO',VarArrayOf([W022DtM.DataRif,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger]),[]) then
    begin
      W022DtM.cdsRegole.Edit;
      W022DtM.cdsRegole.FieldByName('STAMPA_ABILITATA').AsString:='';
      W022DtM.cdsRegole.FieldByName('STATO_ABILITATO').AsString:='';
      W022DtM.cdsRegole.FieldByName('PROGRESSIVO_VALUTATORE').AsString:='';
      W022DtM.cdsRegole.Post;
    end;
    btnApplicaAnnoClick(nil);
  end;
  inherited;//i MsgBox.MessageBox nel FormRender devono stare prima dell'inherited, altrimenti vengono visualizzati solo dopo aver forzato un F5
  W022DtM.Azione:='';
  W022DtM.ValutatoreOld:=W022DtM.ValutatoreNew;
  //Serve a rinfrescare la griglia dopo un intervento sulla scheda selezionata
  if W022DtM.Accesso = 'S' then
  begin
    Dipendente(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    W022DtM.Accesso:='N';
  end;
  DBGridColumnClick(nil,Data);
end;

procedure TW022FSchedaValutazioni.chkVisualizzaDipNonValutabiliClick(Sender: TObject);
begin
  inherited;
  btnApplicaAnnoClick(nil);
end;

procedure TW022FSchedaValutazioni.btnApplicaAnnoClick(Sender: TObject);
var
  DataApp: TDateTime;
  CurrentProg: Integer;
begin
  inherited;
  if Trim(edtAnno.Text) <> '' then
    try
      if rgpFrequenzaScheda.ItemIndex = 0 then
        DataApp:=EncodeDate(StrToInt(edtAnno.Text),12,31)
      else
        DataApp:=StrToDate(edtAnno.Text);
      DataLavoro:=DataApp;
      W022DtM.DataLavoro2:=DataLavoro;
    except
      MsgBox.MessageBox('Inserire un valore corretto in "' + lblAnno.Caption + '"!',ERRORE);
      Abort;
    end
  else
    Exit;
  if selAnagrafeW.RecordCount > 0 then
    CurrentProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  selAnagrafeW.SetVariable('FILTRO',FiltroOld + ' ' + OrderOld);
  selAnagrafeW.Close;
  GetDipendentiDisponibili(DataLavoro);
  cmbDipendentiDisponibili.ItemIndex:=0;
  EscludiDipendenti;
  Dipendente(CurrentProg);
  DBGridColumnClick(nil,edtAnno.Text);
  btnRiepilogoSchede.Enabled:=selAnagrafeW.RecordCount > 0;
end;

procedure TW022FSchedaValutazioni.ImpostaCampiDaEstrarre;
begin
  with W022DtM do
  begin
    //Ricavo i dati storici del dipendente
    CampiDaEstrarre:=IfThen(CampiDaEstrarre <> '',',' + CampiDaEstrarre + ',',',');
    if Pos(',' + 'T430INIZIO' + ',',',' + CampiDaEstrarre) = 0 then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430INIZIO' + ',';
    if Pos(',' + 'T430FINE' + ',',',' + CampiDaEstrarre) = 0 then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430FINE' + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniLiv1 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv1 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv1 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniLiv2 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv2 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv2 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniLiv3 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv3 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv3 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniLiv4 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv4 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniLiv4 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniPnt1 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1 + ',';
    CampiDaEstrarre:=Copy(CampiDaEstrarre,2,Length(CampiDaEstrarre)-2);
  end;
end;

procedure TW022FSchedaValutazioni.EscludiDipendenti;
var DipEsclusi:String;
  DataRifDip:TDateTime;
  Escluso:Boolean;
begin
  if chkVisualizzaDipNonValutabili.Checked then
    exit;
  //Escludo i dipendenti che non avrebbero scheda perché il tipo rapporto non è valutabile
  // o non ha coperto i giorni minimi o non ci sarebbero gli elementi valutabili, oppure
  //hanno la scheda perché soddisfano i requisiti ma l'ufficio ha indicato che non si può valutare.
  with W022DtM do
  begin
    if selAnagrafeW.RecordCount > 0 then
      selAnagrafeW.First;
    //Ciclo sui dipendenti estratti senza esclusione
    while not selAnagrafeW.Eof do
    begin
      QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,SelAnagrafeW.FieldByName('Progressivo').AsInteger,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
      //Per ogni dipendente prelevo la sua data di riferimento
      if  (not selAnagrafeW.FieldByName('T430FINE').IsNull)
      and (selAnagrafeW.FieldByName('T430FINE').AsDateTime < DataLavoro)
      and (selAnagrafeW.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(DataLavoro),1,1)) then
        DataRifDip:=selAnagrafeW.FieldByName('T430FINE').AsDateTime
      else
        DataRifDip:=DataLavoro;
      Q710.Close;
      Q710.SetVariable('PROGRESSIVO',SelAnagrafeW.FieldByName('Progressivo').AsInteger);
      Q710.SetVariable('TIPO_VALUTAZIONE',TipoValutazione);
      Q710.SetVariable('DATA',DataLavoro);
      Q710.SetVariable('VALUTATORE',IfThen(SoloStampa,'N','S'));
      Q710.Open;
      if Q710.RecordCount > 0 then
        Escluso:=(Q710.FieldByName('VALUTABILE').AsString = 'N') or (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRifDip,Q710.FieldByName('PROGRESSIVO').AsInteger]),'STAMPA_ABILITATA')) = 'N')
      else
        Escluso:=MotivoSchedaMancante(DataLavoro,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,TipoValutazione) <> 'Senza scheda';
      if Escluso then
        DipEsclusi:=DipEsclusi + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ',';
      selAnagrafeW.Next;
    end;
  end;
  if DipEsclusi <> '' then
  begin
    DipEsclusi:=' /*#E.D.#*/ AND (T030.PROGRESSIVO NOT IN (' + Copy(DipEsclusi,1,Length(DipEsclusi) - 1) + '))';
    selAnagrafeW.SetVariable('FILTRO',FiltroOld + DipEsclusi + ' ' + OrderOld);
    selAnagrafeW.Close;
    GetDipendentiDisponibili(DataLavoro);
  end;
  cmbDipendentiDisponibili.ItemIndex:=0;
end;

procedure TW022FSchedaValutazioni.Dipendente(P:Integer);
begin
  inherited;
  lnkDipendente.Caption:='';
  if not selAnagrafeW.SearchRecord('PROGRESSIVO',P,[srFromBeginning]) then
    selAnagrafeW.First;
  VisualizzaDipendenteCorrente;
end;

procedure TW022FSchedaValutazioni.VisualizzaDipendenteCorrente;
begin
  inherited;
  with W022DtM do
    QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,SelAnagrafeW.FieldByName('Progressivo').AsInteger,EncodeDate(1900,1,1),EncodeDate(3999,12,31));

  dgrdSchede.medpBrowse:=True;
  dgrdSchede.medpStato:=msBrowse;
  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  PopolaGriglia;
  dgrdSchede.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  dgrdSchede.medpEliminaColonne;
  dgrdSchede.medpAggiungiColonna('DBG_COMANDI','','',nil);
  dgrdSchede.medpAggiungiColonna('DBG_COMANDI2','','',nil);
  dgrdSchede.medpAggiungiColonna('DBG_ALLEGATI','','',nil);
  dgrdSchede.medpAggiungiColonna('DATA','Data scheda','',nil);
  dgrdSchede.medpAggiungiColonna('DATARIF','Data di riferimento','',nil);
  dgrdSchede.medpAggiungiColonna('D_DATA','Anno valutazione','',nil);
  dgrdSchede.medpAggiungiColonna('D_VALUTATORE','Valutatore','',nil);
  dgrdSchede.medpAggiungiColonna('STATO_SCHEDA','Stato','',nil);
  dgrdSchede.medpAggiungiColonna('PUNTEGGIO_FINALE_PESATO','Punteggio finale pesato','',nil);
  dgrdSchede.medpAggiungiColonna('PERIODO_OBIETTIVI','Periodo assegn. obiettivi','',nil);
  dgrdSchede.medpAggiungiColonna('OBIETTIVI_ACCETTATI','Obiettivi accettati','',nil);
  dgrdSchede.medpAggiungiColonna('PERIODO_COMPILAZIONE','Periodo compilazione','',nil);
  dgrdSchede.medpAggiungiColonna('PERIODO_RICHIESTA_VISIONE','Periodo richiesta presa visione','',nil);

  dgrdSchede.medpColonna('DBG_COMANDI').Visible:=not SoloStampa;
  dgrdSchede.medpColonna('DBG_ALLEGATI').Visible:=VisColAllegati;
  dgrdSchede.medpColonna('DATA').Visible:=False;
  dgrdSchede.medpColonna('DATARIF').Visible:=False;
  dgrdSchede.medpColonna('D_VALUTATORE').Visible:=TipoValutazione = 'V';
  dgrdSchede.medpColonna('PERIODO_OBIETTIVI').Visible:=VisColObiettivi;
  dgrdSchede.medpColonna('OBIETTIVI_ACCETTATI').Visible:=VisColObiettivi;
  dgrdSchede.medpColonna('PERIODO_RICHIESTA_VISIONE').Visible:=VisColPRPV;

  dgrdSchede.medpAggiungiRowClick('DATA',DBGridColumnClick);
  dgrdSchede.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    dgrdSchede.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','INSERISCI','null','','S');
    dgrdSchede.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','CANCELLA','null','null','S');
    dgrdSchede.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ACCEDI','Accedi','','D');
  end;
  dgrdSchede.medpPreparaComponenteGenerico('R',1,0,DBG_IMG,'','STAMPA','Stampa','','');
  dgrdSchede.medpPreparaComponenteGenerico('R',1,1,DBG_IMG,'','DUPLICA','Crea autovalutazione','','D');
  dgrdSchede.medpPreparaComponenteGenerico('R',2,0,DBG_IMG,'','ALLEGATI','Informazioni','','');
  dgrdSchede.medpCaricaCDS;
end;

procedure TW022FSchedaValutazioni.PopolaGriglia;
var AnnoMin,AnnoMax,AnnoRich,Anno:Integer;
  DataDaComp,DataAComp,DataScheda,DataDaRichiestaVisione,DataARichiestaVisione:TDateTime;
  //Interrompi:Boolean;
begin
  with W022DtM do
  begin
    if selQ710.Active then
      selQ710.EmptyDataSet
    else
      selQ710.CreateDataSet;

    VisColObiettivi:=False;
    VisColPRPV:=False;
    VisColAllegati:=False;
    //Evito di caricare la griglia se non ci sono dipendenti nell'elenco
    if selAnagrafeW.FieldByName('Progressivo').AsInteger = 0 then
      exit;
    //Prelevo il massimo range di anni da visualizzare nella griglia
    selPeriodoSchede.Close;
    selPeriodoSchede.Open;

    AnnoRich:=R180Anno(DataLavoro);
    AnnoMin:=IfThen(selPeriodoSchede.FieldByName('DATA_MIN').IsNull,AnnoRich,
                                                                    IfThen(SoloStampa,R180Anno(selPeriodoSchede.FieldByName('DATA_MIN').AsDateTime),
                                                                                      Min(R180Anno(selPeriodoSchede.FieldByName('DATA_MIN').AsDateTime),AnnoRich)));
    AnnoMax:=IfThen(selPeriodoSchede.FieldByName('DATA_MAX').IsNull,AnnoRich,
                                                                    IfThen(SoloStampa,R180Anno(selPeriodoSchede.FieldByName('DATA_MAX').AsDateTime),
                                                                                      Max(R180Anno(selPeriodoSchede.FieldByName('DATA_MAX').AsDateTime),AnnoRich)));
    //Ciclo su ogni anno
    Anno:=AnnoMax;
    while Anno >= AnnoMin do
    begin
      //Ciclo sulle schede esistenti + possibili nell'anno
      selSchedeAnno.Close;
      selSchedeAnno.SetVariable('DATA',EncodeDate(Anno,12,31));
      selSchedeAnno.SetVariable('PROGRESSIVO',SelAnagrafeW.FieldByName('Progressivo').AsInteger);
      selSchedeAnno.SetVariable('TIPO_VALUTAZIONE',TipoValutazione);
      selSchedeAnno.SetVariable('DATA_RICH',IfThen(SoloStampa,EncodeDate(Anno,12,31),DataLavoro));
      selSchedeAnno.Open;
      while not selSchedeAnno.Eof do
      begin
        DataScheda:=selSchedeAnno.FieldByName('DATA').AsDateTime;
        selQ710.Append;
        selQ710.FieldByName('DATA').AsDateTime:=DataScheda;
        //Apro la scheda di valutazione se esiste già
        Q710.Close;
        Q710.SetVariable('PROGRESSIVO',SelAnagrafeW.FieldByName('Progressivo').AsInteger);
        Q710.SetVariable('TIPO_VALUTAZIONE',TipoValutazione);
        Q710.SetVariable('DATA',DataScheda);
        Q710.SetVariable('VALUTATORE',IfThen(SoloStampa,'N','S'));
        Q710.Open;
        //Prendo i dati dalla scheda di valutazione se esiste già
        if Q710.RecordCount > 0 then
        begin
          selQ710.FieldByName('D_VALUTATORE').AsString:=Q710.FieldByName('D_VALUTATORE').AsString;
          selQ710.FieldByName('STATO_SCHEDA').AsString:=Q710.FieldByName('STATO_SCHEDA').AsString;
          if (Q710.FieldByName('VALUTABILE').AsString = 'S')
          and (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([DataRif,Q710.FieldByName('PROGRESSIVO').AsInteger]),'STAMPA_ABILITATA')) = 'S') then
          begin
            selQ710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsString:=Q710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsString;
            selQ710.FieldByName('OBIETTIVI_ACCETTATI').AsString:=Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString;
          end;
        end
        //Verifico il motivo per cui manca la scheda
        else
        begin
          selQ710.FieldByName('STATO_SCHEDA').AsString:=MotivoSchedaMancante(DataScheda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,TipoValutazione);
          if not SoloStampa
          and (Parametri.S710_SupervisoreValut = 'N')
          and (selQ710.FieldByName('STATO_SCHEDA').AsString = 'Senza scheda') then
          begin
            R180SetVariable(selT030,'PROGRESSIVO',Parametri.ProgressivoOper);
            selT030.Open;
            if selT030.RecordCount > 0 then
              selQ710.FieldByName('D_VALUTATORE').AsString:=Format('%-8s %s',[selT030.FieldByName('MATRICOLA').AsString,selT030.FieldByName('NOMINATIVO').AsString])
          end;
        end;
        selQ710.FieldByName('DATARIF').AsDateTime:=DataRif;
        selQ710.FieldByName('D_DATA').AsString:=IfThen(DataScheda <> EncodeDate(Anno,12,31),FormatDateTime('dd/mm/yyyy',DataScheda),IntToStr(Anno));
        //Regole prese in Q710AfterScroll o MotivoSchedaMancante
        if SoloStampa and (Trim(W022DtM.selSG741.FieldByName('PATH_INFORMAZIONI').AsString) <> '') then
          VisColAllegati:=True;
        if selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S' then
        begin
          selQ710.FieldByName('PERIODO_OBIETTIVI').AsString:=FormatDateTime('dd/mm/yyyy',selSG741.FieldByName('DATA_DA_OBIETTIVI').AsDateTime) + ' - ' + FormatDateTime('dd/mm/yyyy',selSG741.FieldByName('DATA_A_OBIETTIVI').AsDateTime);
          VisColObiettivi:=True;
        end;
        FPeriodoOKCompilazione(IfThen(Q710.RecordCount > 0,Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,1),TipoValutazione,DataDaComp,DataAComp);
        if (DataDaComp <> EncodeDate(1900,1,1)) or (DataAComp <> EncodeDate(1900,1,1)) then
          selQ710.FieldByName('PERIODO_COMPILAZIONE').AsString:=FormatDateTime('dd/mm/yyyy',DataDaComp) + ' - ' + FormatDateTime('dd/mm/yyyy',DataAComp);
        if SoloStampa
        and ((Parametri.WebRichiestaConsegnaVal = 'S') or (Parametri.S710_SupervisoreValut = 'S')) then
        begin
          DataDaRichiestaVisione:=0;
          DataARichiestaVisione:=0;
          if VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_DA_RICHIESTA_VISIONE')) <> '' then
          begin
            DataDaRichiestaVisione:=selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_DA_RICHIESTA_VISIONE');
            selQ710.FieldByName('PERIODO_RICHIESTA_VISIONE').AsString:=FormatDateTime('dd/mm/yyyy',DataDaRichiestaVisione);
            if DataDaRichiestaVisione > EncodeDate(1900,1,1) then
              VisColPRPV:=True;
          end;
          if VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_A_RICHIESTA_VISIONE')) <> '' then
          begin
            DataARichiestaVisione:=selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_A_RICHIESTA_VISIONE');
            selQ710.FieldByName('PERIODO_RICHIESTA_VISIONE').AsString:=selQ710.FieldByName('PERIODO_RICHIESTA_VISIONE').AsString + ' - ' + FormatDateTime('dd/mm/yyyy',DataARichiestaVisione);
            if DataARichiestaVisione < EncodeDate(3999,12,31) then
              VisColPRPV:=True;
          end;
          if (DataDaRichiestaVisione = EncodeDate(1900,1,1)) and (DataARichiestaVisione = EncodeDate(3999,12,31)) then
            selQ710.FieldByName('PERIODO_RICHIESTA_VISIONE').AsString:='sempre';
        end;
        selQ710.Post;
        selSchedeAnno.Next;
      end;
      dec(Anno);
    end;
    (*//Cancello i record vecchi inutili: eventuale feature, se verrà richiesta da qualcuno
    selQ710.Last;
    Interrompi:=False;
    while not selQ710.Bof and not Interrompi do
    begin
      if selQ710.FieldByName('STATO_SCHEDA').AsString = 'Non valutabile: Non in servizio' then
        selQ710.Delete
      else
        Interrompi:=True;
    end;*)
  end;
end;

procedure TW022FSchedaValutazioni.rgpFrequenzaSchedaClick(Sender: TObject);
begin
  inherited;
  lblAnno.Caption:=IfThen(rgpFrequenzaScheda.ItemIndex = 0,'Anno','Data') + ' valutazione:';
  edtAnno.Css:=IfThen(rgpFrequenzaScheda.ItemIndex = 0,'input5','input_data_dmy');
  edtAnno.Text:=FormatDateTime(IfThen(rgpFrequenzaScheda.ItemIndex = 0,'yyyy','dd/mm/yyyy'),DataLavoro);
end;

procedure TW022FSchedaValutazioni.imgInserisciClick(Sender: TObject);
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  SenderTemp:=Sender;
  if (Parametri.S710_SupervisoreValut = 'S')
  and (Parametri.S710_ModValutatore = 'S')
  and (TipoValutazione <> 'A') then
    Messaggio('Conferma','Si vuole impostare il ' + W022DtM.RecuperaEtichetta('VALUTATORE_C','L') + ' automaticamente? ' + CRLF +
                         'La ricerca potrebbe richiedere diversi minuti!',
                         CercaValutatoreSi,CercaValutatoreNo)
  else if Parametri.S710_SupervisoreValut = 'S' then
    CercaValutatoreSi
  else
    CercaValutatoreNo;
end;

procedure TW022FSchedaValutazioni.CercaValutatoreSi;
begin
  Inserimento(True);
end;

procedure TW022FSchedaValutazioni.CercaValutatoreNo;
begin
  Inserimento(False);
end;

procedure TW022FSchedaValutazioni.Inserimento(CercaValutatore:Boolean);
begin
  DBGridColumnClick(SenderTemp,(SenderTemp as TmeIWImageFile).FriendlyName);
  W022DtM.CercaValutatore:=CercaValutatore;
  W022DtM.AccettazioneObiettivi:='';
  W022DtM.Azione:='I';
  W022DtM.Q710.Insert;
  W022DtM.Q710.Post;
  W022DtM.InviaEMail('A',0);
  W022DtM.CalcolaTotali(True);
  imgAccediClick(SenderTemp);
end;

procedure TW022FSchedaValutazioni.imgAccediClick(Sender: TObject);
var
  W022: TW022FDettaglioValutazioni;
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  WR000DM.SoloStampa:=SoloStampa;
  WR000DM.TipoValutazione:=TipoValutazione;
  W022:=TW022FDettaglioValutazioni.Create(GGetWebApplicationThreadVar);
  W022.Tag:=Tag;

  with W022 do
  begin
    Abilitazione:=IfThen(SolaLettura,'R','S');
    W022DtM2:=W022DtM;
    dlblValutato.Caption:=Format('%-8s %s %s',[Self.selAnagrafeW.FieldByName('MATRICOLA').AsString,Self.selAnagrafeW.FieldByName('COGNOME').AsString,Self.selAnagrafeW.FieldByName('NOME').AsString]);
    OpenPage;
    lnkIstrVal.Visible:=Trim(W022DtM.selSG741.FieldByName('PATH_ISTRUZIONI').AsString) <> '';
  end;
end;

procedure TW022FSchedaValutazioni.imgCancellaClick(Sender: TObject);
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  W022DtM.Q710.Delete;
  W022DtM.Accesso:='S';
end;

procedure TW022FSchedaValutazioni.btnRiepilogoSchedeClick(Sender: TObject);
begin
  inherited;
  W022RiepilogoSchedeFM:=TW022FRiepilogoSchedeFM.Create(Self);
  W022RiepilogoSchedeFM.cdsRiepilogo:=W022DtM.cdsRiepilogoSchede;
  W022DtM.CaricaCDS;
  W022RiepilogoSchedeFM.Visualizza(DataLavoro);
end;

procedure TW022FSchedaValutazioni.imgStampaClick(Sender: TObject);
var
  W022: TW022FDettaglioValutazioni;
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  WR000DM.SoloStampa:=SoloStampa;
  WR000DM.TipoValutazione:=TipoValutazione;
  W022:=TW022FDettaglioValutazioni.Create(GGetWebApplicationThreadVar,False);

  with W022 do
  begin
    Abilitazione:=IfThen(SolaLettura,'R','S');
    W022DtM2:=W022DtM;
    if InizializzaAccesso then
      btnStampaClick(nil);
  end;
  VisualizzaStampa(W022.NomeFile);
  W022.ClosePage;
end;

procedure TW022FSchedaValutazioni.imgCreaAutovalutazioneClick(Sender: TObject);
var TmpMenu: TWC501FMenuIrisWebFM;
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  with W022DtM do
  begin
    selSG710.Close;
    selSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    selSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    selSG710.SetVariable('TIPO_VALUTAZIONE','A');
    selSG710.Open;
    //scheda di autovalutazione già esistente
    if selSG710.RecordCount > 0 then
      raise exception.Create('Scheda di autovalutazione già esistente!');
    insSG710auto.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    insSG710auto.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    insSG710auto.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    insSG710auto.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    insSG710auto.Execute;
    insSG711auto.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    insSG711auto.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    insSG711auto.SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    insSG711auto.SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    insSG711auto.Execute;
    SessioneOracle.Commit;
  end;
  TmpMenu:=(WMenuFM as TWC501FMenuIrisWebFM);
  TmpMenu.actExecute(TmpMenu.actSchedaAutovalutazioni);
  W022DtM.Accesso:='S';
end;

procedure TW022FSchedaValutazioni.imgInformazioniClick(Sender: TObject);
var
  URLDoc: String;
begin
  inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  URLDoc:=ExtractFileName(W022DtM.selSG741.FieldByName('PATH_INFORMAZIONI').AsString);
  VisualizzaFile(URLDoc,'Informazioni per il valutato',nil,nil,fdGlobal);
end;

procedure TW022FSchedaValutazioni.DBGridColumnClick(ASender: TObject; const AValue: string);
var DataScheda:TDateTime;
begin
  inherited;
  try
    if (ASender is TmeIWImageFile) then
      DataScheda:=cdsSG710.Lookup('DBG_ROWID',AValue,'DATA')
    else if Length(AValue) = 4 then
      DataScheda:=EncodeDate(StrToInt(AValue),12,31)
    else
      DataScheda:=StrToDate(AValue);
  except
    DataScheda:=0;
  end;
  //Mi posiziono sull'anno giusto nella griglia, e carico l'eventuale scheda collegata
  cdsSG710.Locate('DATA',DateToStr(DataScheda),[]);
  with W022DtM do
  begin
    selQ710.Locate('DATA',DataScheda,[]);
    Q710.Close;
    Q710.SetVariable('PROGRESSIVO',SelAnagrafeW.FieldByName('Progressivo').AsInteger);
    Q710.SetVariable('TIPO_VALUTAZIONE',TipoValutazione);
    Q710.SetVariable('DATA',DataScheda);
    Q710.SetVariable('VALUTATORE',IfThen(SoloStampa,'N','S'));
    Q710.Open;
  end;
end;

procedure TW022FSchedaValutazioni.dgrdSchedeAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var PeriodoOKCompilazione,PeriodoOKObiettivi,EsisteFaseAssegnazionePreventivaObiettivi,VisualizzazioneAnomala: Boolean;
    DataDaComp,DataAComp,DataScheda:TDateTime;
    i:Integer;
begin
  inherited;
  //Righe dati
  for i:=0 to High(dgrdSchede.medpCompGriglia) do
  begin
    //Apro la scheda
    DBGridColumnClick(nil,dgrdSchede.medpValoreColonna(i,'DATA'));
    with W022DtM do
    begin
      //Recupero le regole se la scheda non esiste
      if not SoloStampa
      and (Q710.RecordCount = 0) then
      begin
        try
          DataScheda:=StrToDate(dgrdSchede.medpValoreColonna(i,'DATA'))
        except
          DataScheda:=EncodeDate(3999,12,31);
        end;
        DataRif:=DataScheda;
        if QSGruppoValutatore.LocDatoStorico(DataScheda) then
          if  (not QSGruppoValutatore.FieldByName('T430FINE').IsNull)
          and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime < DataScheda)
          and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(DataScheda),1,1)) then
            DataRif:=QSGruppoValutatore.FieldByName('T430FINE').AsDateTime;
        RecuperaRegole(DataRif,SelAnagrafeW.FieldByName('Progressivo').AsInteger,'');
      end;
      PeriodoOKCompilazione:=FPeriodoOKCompilazione(IfThen(Q710.RecordCount > 0,Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,1),TipoValutazione,DataDaComp,DataAComp);
      EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
      PeriodoOKObiettivi:=FPeriodoOKObiettivi(EsisteFaseAssegnazionePreventivaObiettivi);
      VisualizzazioneAnomala:=(Parametri.S710_SupervisoreValut = 'N') and (Q710.RecordCount > 0) and (Q710.FieldByName('TIPO_VALUTAZIONE').AsString <> 'A') and R180InConcat(Q710.FieldByName('PROGRESSIVO').AsString,Q710.FieldByName('PROGRESSIVI_VALUTATORI').AsString);
      // Associo l'evento OnClick all'icona di stampa
      if dgrdSchede.medpCompGriglia[i].CompColonne[1] <> nil then
      begin
        (dgrdSchede.medpCompCella(i,1,0) as TmeIWImageFile).OnClick:=imgStampaClick;
        (dgrdSchede.medpCompCella(i,1,1) as TmeIWImageFile).OnClick:=imgCreaAutovalutazioneClick;
        //Condizioni che non permettono la stampa
        if VisualizzazioneAnomala
        or (Q710.RecordCount = 0)
        or (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([selQ710.FieldByName('DATARIF').AsDateTime,Q710.FieldByName('PROGRESSIVO').AsInteger]),'STAMPA_ABILITATA')) = 'N') then
          (dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,0].Css:='invisibile';
        //Condizioni che non permettono la duplicazione in autovalutazione
        if ((dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,0].Css = 'invisibile') //stampa invisibile
        or not SoloStampa //accesso da valutatore
        or ((Parametri.S710_SupervisoreValut = 'N') and (Q710.FieldByName('PROGRESSIVO').AsInteger <> Parametri.ProgressivoOper)) //schede altrui
        or (A000GetInibizioni('Tag','424') <> 'S') //autovalutazione non abilitata in scrittura nel profilo corrente
        or (VarToStr(selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'CREA_AUTOVALUTAZIONE')) = 'N') //duplicazione per autovalutazione non abilitata sullo stato corrente
        or not FPeriodoOKCompilazione(0,'A',DataDaComp,DataAComp) //sono esterno alla finestra temporale per la compilazione della scheda da creare
        then
          (dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,1].Css:='invisibile'
        else
        begin
          selSG710.Close;
          selSG710.SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
          selSG710.SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
          selSG710.SetVariable('TIPO_VALUTAZIONE','A');
          selSG710.Open;
          //scheda di autovalutazione già esistente
          if selSG710.RecordCount > 0 then
            (dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,1].Css:='invisibile'
          else
          begin
            selSG710.Close;
            selSG710.SetVariable('TIPO_VALUTAZIONE','V');
            selSG710.Open;
            //stato non consolidato (= scheda non chiusa e stato successivo non esiste)
            if (Q710.FieldByName('CHIUSO').AsString = 'N')
            and not (selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger > Q710.FieldByName('STATO_AVANZAMENTO').AsInteger) then
              (dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,1].Css:='invisibile';
          end;
        end;
      end;
      // Associo l'evento OnClick all'icona degli allegati
      if dgrdSchede.medpCompGriglia[i].CompColonne[2] <> nil then
      begin
        (dgrdSchede.medpCompCella(i,2,0) as TmeIWImageFile).OnClick:=imgInformazioniClick;
        //Condizioni che non permettono la visualizzazione degli allegati
        if (dgrdSchede.medpCompGriglia[i].CompColonne[1] = nil) //stampa inesistente
        or ((dgrdSchede.medpCompGriglia[i].CompColonne[1] as TmeIWGrid).Cell[0,0].Css = 'invisibile') //stampa invisibile
        or not SoloStampa //accesso da valutatore
        or (Trim(W022DtM.selSG741.FieldByName('PATH_INFORMAZIONI').AsString) = '')
        then
          (dgrdSchede.medpCompGriglia[i].CompColonne[2] as TmeIWGrid).Cell[0,0].Css:='invisibile'
      end;
      if not SolaLettura then
        // Associo l'evento OnClick all'icona dei comandi
        if dgrdSchede.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          (dgrdSchede.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
          (dgrdSchede.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgCancellaClick;
          (dgrdSchede.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAccediClick;
          //Condizioni che non permettono l'inserimento
          if (dgrdSchede.medpValoreColonna(i,'DATA') <> DateToStr(DataLavoro))
          or SoloStampa
          or (selQ710.RecordCount = 0)
          or (VarToStr(selQ710.Lookup('DATA',DataLavoro,'STATO_SCHEDA')) <> 'Senza scheda')
          or (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([selQ710.Lookup('DATA',DataLavoro,'DATARIF'),SelAnagrafeW.FieldByName('Progressivo').AsInteger]),'STATO_ABILITATO')) = 'N')
          or ((Parametri.ProgressivoOper = -1) and (Parametri.S710_SupervisoreValut = 'N'))
          or (EsisteFaseAssegnazionePreventivaObiettivi and not PeriodoOKObiettivi)
          or (not EsisteFaseAssegnazionePreventivaObiettivi and not PeriodoOKCompilazione)
          or ((TipoValutazione = 'A') and (VarToStr(selSG746.Lookup('CREA_AUTOVALUTAZIONE','S','CREA_AUTOVALUTAZIONE')) = 'S'))//sono nella funzione di autovalutazione e la scheda deve essere duplicata da quella di valutazione
          then
            (dgrdSchede.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
          //Condizioni che non permettono la cancellazione
          if SoloStampa
          or VisualizzazioneAnomala
          or (Q710.RecordCount = 0)
          or (Q710.FieldByName('CHIUSO').AsString <> 'N')
          or (Q710.FieldByName('STATO_AVANZAMENTO').AsInteger <> 1)
          or (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([selQ710.FieldByName('DATARIF').AsDateTime,Q710.FieldByName('PROGRESSIVO').AsInteger]),'STATO_ABILITATO')) = 'N')
          or (not Q710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull and (Parametri.S710_SupervisoreValut = 'N'))
          or (EsisteFaseAssegnazionePreventivaObiettivi and not PeriodoOKObiettivi)
          or (not EsisteFaseAssegnazionePreventivaObiettivi and not PeriodoOKCompilazione)
          then
            (dgrdSchede.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
          //Condizioni che non permettono l'accesso
          if SoloStampa
          or (Q710.RecordCount = 0)
          or (VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([selQ710.FieldByName('DATARIF').AsDateTime,Q710.FieldByName('PROGRESSIVO').AsInteger]),'STAMPA_ABILITATA')) = 'N') then
             (dgrdSchede.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
        end;
    end;
  end;
end;

procedure TW022FSchedaValutazioni.dgrdSchedeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna:Integer;
begin
  inherited;
  NumColonna:=dgrdSchede.medpNumColonna(AColumn);
  if not dgrdSchede.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if ARow = 0 then
  begin
    if dgrdSchede.medpNumColonna(AColumn) = dgrdSchede.medpIndexColonna('D_DATA') then
      ACell.Text:=W022DtM.RecuperaEtichetta('ANNO_VALUTAZIONE_C')
    else if dgrdSchede.medpNumColonna(AColumn) = dgrdSchede.medpIndexColonna('D_VALUTATORE') then
      ACell.Text:=W022DtM.RecuperaEtichetta('VALUTATORE_C')
    else if dgrdSchede.medpNumColonna(AColumn) = dgrdSchede.medpIndexColonna('PUNTEGGIO_FINALE_PESATO') then
      ACell.Text:=W022DtM.RecuperaEtichetta('PUNTEGGIO_FINALE_SCHEDA_C');
    if ACell.Text = '' then
      ACell.Text:=(dgrdSchede.Columns.Items[dgrdSchede.medpNumColonna(AColumn)] as TIWDBGridColumn).Title.Text;
  end;

  ACell.Wrap:=ARow <> 1;
  if (ARow > 0) and R180In(dgrdSchede.medpNumColonna(AColumn),[dgrdSchede.medpIndexColonna('D_DATA'),
                                                               dgrdSchede.medpIndexColonna('PUNTEGGIO_FINALE_PESATO'),
                                                               dgrdSchede.medpIndexColonna('PERIODO_OBIETTIVI'),
                                                               dgrdSchede.medpIndexColonna('OBIETTIVI_ACCETTATI'),
                                                               dgrdSchede.medpIndexColonna('PERIODO_COMPILAZIONE'),
                                                               dgrdSchede.medpIndexColonna('PERIODO_RICHIESTA_VISIONE')])
  then
    ACell.Css:=ACell.Css + ' align_center';
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dgrdSchede.medpCompGriglia) + 1) and (dgrdSchede.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdSchede.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW022FSchedaValutazioni.DistruggiOggetti;
begin
  FreeAndNil(W022DtM);
end;

procedure TW022FSchedaValutazioni.VisualizzaStampa(NomeFile:String);
begin
  if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
  begin
    with W022DtM,selSG745 do
    begin
      Close;
      SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
      SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
      SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
    end;
    //Chiedo conferma di presa visione quando:
    //1) sono nella funzione Stampa scheda di valutazione
    if SoloStampa
    //2) il mio utente è configurato per la richiesta di presa visione
    and (Parametri.WebRichiestaConsegnaVal = 'S')
    //3) mi trovo nel periodo di richiesta di presa visione
    and (Trunc(R180SysDate(SessioneOracle)) >= W022DtM.selSG746.Lookup('CODICE',W022DtM.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_DA_RICHIESTA_VISIONE'))
    and (Trunc(R180SysDate(SessioneOracle)) <= W022DtM.selSG746.Lookup('CODICE',W022DtM.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_A_RICHIESTA_VISIONE'))
    //4) non ho già confermato (esito = S) di aver preso visione
    and not W022DtM.selSG745.SearchRecord('TIPO_CONSEGNA;UTENTE;PROG_UTENTE;ESITO',
                                          VarArrayOf(['PV',
                                                      Parametri.Operatore,
                                                      Parametri.ProgressivoOper,
                                                      'S']),[srFromBeginning])
    and (   (Parametri.ProgressivoOper = -1)
         or not W022DtM.selSG745.SearchRecord('TIPO_CONSEGNA;PROG_UTENTE;ESITO',
                                              VarArrayOf(['PV',
                                                          Parametri.ProgressivoOper,
                                                          'S']),[srFromBeginning])) then
      VisualizzaFile(NomeFile,'Anteprima stampa valutazione',nil,VerificaRicezionePdf)
    else
      VisualizzaFile(NomeFile,'Anteprima stampa valutazione',nil,nil);
  end;
end;

procedure TW022FSchedaValutazioni.VerificaRicezionePdf;
begin
  Messaggio('Conferma','Si conferma di aver preso visione della scheda di valutazione ' +
                       IfThen(W022DtM.Q710.FieldByName('CHIUSO').AsString = 'S','definitiva ') +
                       'del ' + FormatDateTime('yyyy',W022DtM.Q710.FieldByName('DATA').AsDateTime) +
                       IfThen(W022DtM.Q710.FieldByName('CHIUSO').AsString <> 'S',' nello stato "' + VarToStr(W022DtM.selSG746.Lookup('CODICE',W022DtM.Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DESCRIZIONE')) + '"') +
                       '?',ImpostaPresaVisioneSi,ImpostaPresaVisioneNo);
end;

procedure TW022FSchedaValutazioni.ImpostaPresaVisioneSi;
begin
  ImpostaDataConsegna('S');
end;

procedure TW022FSchedaValutazioni.ImpostaPresaVisioneNo;
begin
  ImpostaDataConsegna('N');
end;

procedure TW022FSchedaValutazioni.ImpostaDataConsegna(Esito: String);
begin
  //Il selSG745 è già stato aperto in VisualizzaStampa
  //ma poi il FormRender richiama il DBGridColumnClick
  //che fa scattare il Q710CalcFields
  //che può modificare le variabili del selSG745,
  //quindi bisogna reimpostare le variabili e riaprire il dataset
  with W022DtM,selSG745 do
  begin
    Close;
    SetVariable('DATA',Q710.FieldByName('DATA').AsDateTime);
    SetVariable('PROGRESSIVO',Q710.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('TIPO_VALUTAZIONE',Q710.FieldByName('TIPO_VALUTAZIONE').AsString);
    SetVariable('STATO_AVANZAMENTO',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger);
    Open;
    if SearchRecord('TIPO_CONSEGNA;UTENTE;PROG_UTENTE;ESITO',
                    VarArrayOf(['PV',
                                Parametri.Operatore,
                                Parametri.ProgressivoOper,
                                'N']),[srFromBeginning]) then
      Delete;
    if Parametri.ProgressivoOper <> -1 then
      while SearchRecord('TIPO_CONSEGNA;PROG_UTENTE;ESITO',
                         VarArrayOf(['PV',
                                     Parametri.ProgressivoOper,
                                     'N']),[srFromBeginning]) do
        Delete;
    Insert;
    FieldByName('TIPO_CONSEGNA').AsString:='PV';
    FieldByName('DATA').AsDateTime:=Q710.FieldByName('DATA').AsDateTime;
    FieldByName('PROGRESSIVO').AsInteger:=Q710.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('TIPO_VALUTAZIONE').AsString:=Q710.FieldByName('TIPO_VALUTAZIONE').AsString;
    FieldByName('STATO_AVANZAMENTO').AsInteger:=Q710.FieldByName('STATO_AVANZAMENTO').AsInteger;
    FieldByName('UTENTE').AsString:=Parametri.Operatore;
    FieldByName('PROG_UTENTE').AsInteger:=Parametri.ProgressivoOper;
    FieldByName('DATA_CONSEGNA').AsDateTime:=R180Sysdate(SessioneOracle);
    FieldByName('ESITO').AsString:=Esito;
    Post;
  end;
  SessioneOracle.Commit;
end;

end.

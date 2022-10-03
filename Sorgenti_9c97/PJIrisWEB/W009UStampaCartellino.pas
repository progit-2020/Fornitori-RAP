unit W009UStampaCartellino;

interface

uses
  W009UStampaCartellinoDtm, W009UIterCartellinoDM,
  Bc22UGeneratoreCartelliniMW,
  C018UIterAutDM,C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  A000UInterfaccia, A000UCostanti, A000USessione,
  Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton, IWCompCheckbox, DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, StrUtils,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  IWVCLBaseContainer, IWContainer, Forms,
  IWVCLComponent, meIWComboBox, meIWLabel, meIWGrid,
  meIWButton, meIWEdit, meIWCheckBox, meIWImageFile, DBClient, IWDBGrids,
  medpIWMessageDlg, medpIWDBGrid, Math,
  IWCompGrids, IWCompExtCtrls, System.IOUtils,
  meIWLink, A000UMessaggi, W000UMessaggi, Menus, Generics.Collections;

type
  TParamDictionary = class(TDictionary<String,TStringList>)
  end;

  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  tRiepDati = record
    Titolo:String;
    Valore:String;
  end;

  tRiepDett = record
    Prog:Integer;
    Mese:TDateTime;
    RiepDati:array of tRiepDati;
    RiepPresTit:String;
    RiepPresVal:String;
    RiepAssTit:String;
    RiepAssVal:String;
  end;

  TW009FStampaCartellino = class(TR013FIterBase)
    lblParametrizzazione: TmeIWLabel;
    cmbParametrizzazione: TmeIWComboBox;
    lblElabDal: TmeIWLabel;
    lblElabAl: TmeIWLabel;
    btnAggiornamento: TmeIWButton;
    btnStampa: TmeIWButton;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    chkAutoGiustificazione: TmeIWCheckBox;
    chkAggiornamentoBuoniPasto: TmeIWCheckBox;
    chkAggiornamentoScheda: TmeIWCheckBox;
    chkAggiornamentoAccessiMensa: TmeIWCheckBox;
    dsrT860: TDataSource;
    cdsT860: TClientDataSet;
    chkVisRiepiloghi: TmeIWCheckBox;
    chkParametrizzazioniTipoCartellino: TmeIWCheckBox;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbParametrizzazioneChange(Sender: TObject);
    procedure chkVisRiepiloghiClick(Sender: TObject);
  private
    W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm;
    W009DM: TW009FIterCartellinoDM;
    CodiceT950,Modo,AnomalieBloccantiDesc: String;
    DataI,DataF:TDateTime;
    AnomalieBloccanti,CtrlRichScadute,ResAutTuttoOk,AggRiep: Boolean;
    Autorizza: TAutorizza;
    Bc22MW: TBc22FGeneratoreCartelliniMW;
    ElencoProgressiviFiltro: String;
    ParamDict: TParamDictionary;
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure ApriDataset;
    procedure CaricaRecordConteggi(const PInizio, PFine: TDateTime);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure Autorizzazione1;
    procedure AutorizzazioneOK;
    procedure imgStampaCartellinoClick(Sender: TObject);
    function  ControlliOk(var Err: String): Boolean;
    function  GetRichiestePendenti(var Elenco: String): Integer;
    function  ValidazioneCartellino(var ErrValid: String; var ErrBloccante: Boolean): Boolean;
    procedure OnConfermaValidazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure EseguiCartellini(const PParCartellino: String; var RNomeFile: String); //***
    procedure AvvisoValidazione;
    procedure EseguiStampa;
    procedure BloccoRiepiloghi(const PBlocca: Boolean; const PDataRiep: TDateTime);
    procedure VerificaAutorizzazioneAutomatica;
    procedure W009AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    procedure AggiornaRiepiloghi;
    procedure EliminaComponentiRiepilogo;
    procedure CreaComponentiRiepilogo;
    procedure AssociaParametrizzazioni;
    procedure FiltroSelAnagrafeW(DataSet: TDataSet; var Accept: Boolean);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    function  GetTuttiDipSelezionato: Boolean; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    lstRiepDett: Array of tRiepDett;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  IWApplication, IWGlobal, SyncObjs,
  R400UCartellinoDtM, WC012UVisualizzaFileFM;

function TW009FStampaCartellino.InizializzaAccesso:Boolean;
begin
  Result:=True;

  CambioDipendenteAsync:=(Tag = 405);

  chkVisRiepiloghi.Visible:=False;//Tag <> 405;
  if Tag <> 405 then
  begin
    Title:='(W009) Validazione cartellino';
    // funzione di validazione cartellini
    JavascriptBottom.Add('document.getElementById("iterT860").className = "";'); // rende visibile il riquadro di validazione
    if Iter = '' then
    begin
      // rilegge abilitazione maschera per tag <> 405
      SolaLettura:=A000GetInibizioni('Tag',IntToStr(Tag)) = 'R';

      Iter:=ITER_CARTELLINO;
      HelpKeyWord:='W009P1';
      C018.PreparaDataSetIter(W009DM.selT860,tiAutorizzazione);
      // imposta variabili dataset principale
      W009DM.selT860.SetVariable('AZIENDA',Parametri.Azienda);
      W009DM.selT860.SetVariable('DATALAVORO',Parametri.DataLavoro);

      // modifica caption per dipendente
      if Parametri.InibizioneIndividuale then
      begin
        C018.TipoRichiestaCaption[trDaAutorizzare]:='da validare';
        C018.TipoRichiestaCaption[trAutorizzate]:='validate';
        C018.TipoRichiestaCaption[trDaAutFinale]:='da autorizzare';
        C018.TipoRichiestaCaption[trAutFinale]:='autorizzate';
      end;

      // nasconde elementi di stampa cartellino
      lblElabDal.Visible:=False;
      edtDal.Visible:=False;
      lblElabAl.Visible:=False;
      edtAl.Visible:=False;
      chkAggiornamentoScheda.Visible:=False;
      chkAggiornamentoAccessiMensa.Visible:=False;
      chkAutoGiustificazione.Visible:=False;
      chkAggiornamentoBuoniPasto.Visible:=False;
      btnAggiornamento.Visible:=False;
      btnStampa.Visible:=False;

      // gestione tabella
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdRichieste.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
      grdRichieste.medpDataSet:=W009DM.selT860;
      grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

      if (WR000DM.Responsabile) and
         (not (Parametri.InibizioneIndividuale)) then // daniloc. 26.06.2012
      begin
        medpAutorizzaMultiplo:=True;
        OnAutorizzaTutto:=W009AutorizzaTutto;
      end;

      Bc22MW:=TBc22FGeneratoreCartelliniMW.Create(nil);
      Bc22MW.SessioneOracleBc22:=SessioneOracle;
    end;
  end;

  if Tag = 405 then
    GetDipendentiDisponibili(Parametri.DataLavoro)
  else
  begin
    GetDipendentiDisponibili(C018.Periodo.Fine);
    W009DM.selT860.ReadBuffer:=Min(1000,selAnagrafeW.RecordCount * 12); // 12 mesi max per dipendente
  end;
  if (Tag = 405) or WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end
  else
  begin
    selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW009FStampaCartellino.IWAppFormCreate(Sender: TObject);
var
  Dal,Al,LData:TDateTime;
begin
  inherited;
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE';

  // abilitazione dei checkbox
  chkAggiornamentoScheda.Visible:=not SolaLettura;
  chkAutoGiustificazione.Visible:=not SolaLettura;
  btnAggiornamento.Visible:=not SolaLettura;
  chkAggiornamentoBuoniPasto.Visible:=A000GetInibizioni('Funzione','OpenA074RiepilogoBuoni') = 'S';
  chkAggiornamentoAccessiMensa.Visible:=A000GetInibizioni('Funzione','OpenA049StampaPasti') = 'S';

  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',Al);

  ParamDict:=TParamDictionary.Create;

  // popola elenco parametrizzazioni di stampa
  cmbParametrizzazione.Items.Clear;
  WR000DM.Q950Lista.Open;
  while not WR000DM.Q950Lista.Eof do
  begin
    cmbParametrizzazione.Items.Add(Format('%-5s %s',[WR000DM.Q950Lista.FieldByName('CODICE').AsString,WR000DM.Q950Lista.FieldByName('DESCRIZIONE').AsString]));
    WR000DM.Q950Lista.Next;
  end;
  WR000DM.Q950Lista.CloseAll;
  cmbParametrizzazione.RequireSelection:=cmbParametrizzazione.Items.Count > 0;

  // verifica gestione parametrizzazioni su tipo cartellino
  // imposta data di riferimento per parametrizzazione cartellino
  if edtAl.Text = '' then
    LData:=Parametri.DataLavoro
  else if not TryStrToDate(edtAl.Text,LData) then
    LData:=Parametri.DataLavoro;
  // estrazione dei progressivi con le relative parametrizzazioni
  // PRE: è già filtrato in base al filtro dizionario
  WR000DM.selT025.Close;
  WR000DM.selT025.SetVariable('DATA',LData);
  WR000DM.selT025.Open;
  chkParametrizzazioniTipoCartellino.Visible:=WR000DM.selT025.RecordCount > 0;

  // nuovo datamodulo
  W009DM:=TW009FIterCartellinoDM.Create(Self);
  CtrlRichScadute:=True;
end;

procedure TW009FStampaCartellino.VisualizzaDipendenteCorrente;
var
  Fase: String;
  c: Integer;
  D,InizioCont,FineCont: TDateTime;
begin
  inherited;
  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  if Tag <> 405 then
  begin
    ParametriForm.Dal:=C018.Periodo.Inizio;
    ParametriForm.Al:=C018.Periodo.Fine;

    grdRichieste.medpStato:=msBrowse;
    // popolamento dataset: record presenti sul db + eventuali record calcolati
    Fase:='caricamento delle richieste di validazione cartellino';
    ApriDataset;
    // aggiunge record dei cartellini nuovi
    try
      // se richiesto effettua i conteggi per aggiungere i record
      // con i cartellini che possono essere oggetto di validazione
      // periodo: ultimi 12 mesi
      Fase:='elaborazione dei cartellini da autorizzare';
      D:=R180InizioMese(Date);
      //InizioCont:=R180AddMesi(D,-12);
      InizioCont:=Encodedate(2015,1,1);
      FineCont:=D - 1;
      CaricaRecordConteggi(InizioCont,FineCont);
    except
      on E: Exception do
      begin
        Log('Errore','Errore in fase di ' + Fase,E);
        MsgBox.TextIsHTML:=False;
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_ERR_ANOMALIA_GENERICA),[Fase,E.Message]),ESCLAMA);
      end;
    end;
    W009DM.selT860.Refresh;

    // effettua il controllo delle richieste scadute, al fine di autorizzarle automaticamente
    if CtrlRichScadute then
    begin
      VerificaAutorizzazioneAutomatica;
      CtrlRichScadute:=False;
    end;

    grdRichieste.medpCreaCDS;
    grdRichieste.medpEliminaColonne;
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpAggiungiColonna('MESE_CARTELLINO','Mese cartellino','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEPILOGHI','Riepiloghi','',nil);
    grdRichieste.medpColonna('CF_RIEPILOGHI').Visible:=Tag <> 405;
    //medpAggiungiColonna('DBG_COMANDI','Stampa','',nil); // spostata su
    if Parametri.InibizioneIndividuale then
    begin
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Validazione','',nil);
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE_FINALE','Autorizzazione','',nil);
      grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    end
    else
    begin
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    end;
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpInizializzaCompGriglia;
    // componenti
    if not SolaLettura then
    begin
      c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
      grdRichieste.medpPreparaComponenteGenerico('R',c,0,DBG_CHK,'',A000TraduzioneStringhe(A000MSG_MSG_SI),'','');
      grdRichieste.medpPreparaComponenteGenerico('R',c,1,DBG_CHK,'',A000TraduzioneStringhe(A000MSG_MSG_NO),'','');
      c:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      grdRichieste.medpPreparaComponenteGenerico('R',c,0,DBG_IMG,'','STAMPA',A000TraduzioneStringhe(A000MSG_W009_FMT_CARTELLINO_DI_MESE),'','');
    end;
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  end;
end;

procedure TW009FStampaCartellino.RefreshPage;
begin
  WR000DM.Responsabile:=True;
  if grdRichieste.medpStato = msBrowse then
    VisualizzaDipendenteCorrente;
end;

procedure TW009FStampaCartellino.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=True;
  inherited;
end;

procedure TW009FStampaCartellino.ApriDataset;
// apre il dataset delle richieste e i dataset di supporto per gli aggiornamenti
var
  FiltroAnag,FiltroPeriodo,FiltroVis,FiltroMaxLiv: String;
  RiapriDataset: Boolean;
begin
  // determina filtri
  FiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger.ToString);
  FiltroPeriodo:=C018.Periodo.Filtro;
  FiltroVis:=C018.FiltroRichieste;

  // TORINO_REGIONE - commessa 2014/248 SVILUPPO#2.ini
  // filtro richieste ultimo livello
  FiltroMaxLiv:=' and ((T850.TIPO_RICHIESTA is null) or (T851F_LIVELLO_AUTORIZZABILE(:AZIENDA,:PROFILO,:ITER,T850.COD_ITER,T850.ID) < I096F_ULTIMOLIV_OBB(T850.ITER,T850.COD_ITER))) ';
  FiltroVis:=FiltroVis + FiltroMaxLiv;
  // TORINO_REGIONE - commessa 2014/248 SVILUPPO#2.fine

  RiapriDataset:=(FiltroAnag <> VarToStr(W009DM.selT860.GetVariable('FILTRO_ANAG'))) or
                 (FiltroPeriodo <> VarToStr(W009DM.selT860.GetVariable('FILTRO_PERIODO'))) or
                 (FiltroVis <> VarToStr(W009DM.selT860.GetVariable('FILTRO_VISUALIZZAZIONE')));
  DebugClear;
  if (RiapriDataset) or (not W009DM.selT860.Active) then
  begin
    W009DM.selT860.Close;
    if W009DM.selT860.VariableIndex('FILTRO_ANAG') >= 0 then
      W009DM.selT860.SetVariable('FILTRO_ANAG',FiltroAnag);
    if W009DM.selT860.VariableIndex('FILTRO_PROGRESSIVI') >= 0 then
    begin
      FiltroAnag:='T030A.PROGRESSIVO in (' + ElencoProgressiviFiltro + ')';
      W009DM.selT860.SetVariable('FILTRO_PROGRESSIVI',FiltroAnag);
    end;
    W009DM.selT860.SetVariable('FILTRO_PERIODO',FiltroPeriodo);
    W009DM.selT860.SetVariable('FILTRO_VISUALIZZAZIONE',FiltroVis);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    W009DM.selT860.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    W009DM.selT860.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    R013Open(W009DM.selT860);
    AggRiep:=True;
    if chkVisRiepiloghi.Checked then
      AggiornaRiepiloghi;
  end
  else
  begin
    W009DM.selT860.Refresh;
  end;
end;

procedure TW009FStampaCartellino.CaricaRecordConteggi(const PInizio, PFine: TDateTime);
var
  D: TDateTime;
  Err,ErrDip, NoteFisse: String;
  LNew: Integer;
begin
  // imposta note fisse per richiesta
  NoteFisse:=A000TraduzioneStringhe(A000MSG_W009_CARTELLINO_PRONTO_VALIDAZIONE);

  WR000DM.selDatiBloccati.Close;

  // ciclo di stampa cartellini e corrispondenti inserimenti nel client dataset
  if TuttiDipSelezionato then
    selAnagrafeW.First;

  Err:='';
  W009DM.selT070.Close;
  W009DM.selT070.ClearVariables;
  W009DM.selT070.SetVariable('DATA1',PInizio);
  W009DM.selT070.SetVariable('DATA2',PFine);
  W009DM.selT860.OnCalcFields:=nil; // disattiva temporaneamente il calcfields
  while not selAnagrafeW.Eof do
  begin
    ErrDip:='';
    R180SetVariable(W009DM.selT070,'PROGRESSIVO',medpProgressivo);
    W009DM.selT070.Open;
    while not W009DM.selT070.Eof do
    begin
      D:=W009DM.selT070.FieldByName('DATA').AsDateTime;
      //if WR000DM.selDatiBloccati.DatoBloccato(medpProgressivo,D,'T860',True) then
      if W009DM.selT070.FieldByName('RIEPILOGO_T860').AsString = 'C' then
      begin
        W009DM.selT860.Append;
        W009DM.selT860.FieldByName('PROGRESSIVO').AsInteger:=medpProgressivo;
        W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime:=D;
        try
          // nota: non considera WarningRichiesta!
          LNew:=C018.InsRichiesta('',NoteFisse,'');
          if C018.MessaggioOperazione <> '' then
          begin
            W009DM.selT860.Cancel;
            raise Exception.Create(C018.MessaggioOperazione);
          end
          else
          begin
            // rende effettiva l'autorizzazione all'ultimo livello
            if LNew = C018.LivMaxObb then
              BloccoRiepiloghi(True, D);
            SessioneOracle.Commit;
          end;
        except
          on E:Exception do
          begin
            ErrDip:=Format('%s%s: %s%s',[ErrDip,FormatDateTime('mmmm yyyy',D),E.Message,CRLF]);
          end;
        end;
      end;
      W009DM.selT070.Next;
    end; // end ciclo T070

    // determina se proseguire con il dipendente successivo oppure terminare
    if TuttiDipSelezionato then
    begin
      if ErrDip <> '' then
        Err:=Format('%sNominativo: %s %s%s%s',[Err,selAnagrafeW.FieldByName('COGNOME').AsString,selAnagrafeW.FieldByName('NOME').AsString,CRLF,ErrDip]);
      selAnagrafeW.Next;
    end
    else
    begin
      Err:=ErrDip;
      Break;
    end;
  end; // end ciclo anagrafe
  W009DM.selT860.OnCalcFields:=W009DM.selT860CalcFields; // riattiva il calcfields

  // in caso di anomalie lancia un'eccezione che viene intercettata a livello superiore
  if Err <> '' then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_CARTELLINI_VALIDATI),[CRLF,Err]);
    raise Exception.Create(Err);
  end;
end;

procedure TW009FStampaCartellino.VerificaAutorizzazioneAutomatica;
// controlla le richieste attualmente visibili ed esegue un ciclo di
// autorizzazione automatica (nella condizione di aut. automatica dovrebbe esserci una scadenza)
// NOTA: le richieste nel dataset sono solo quelle "da autorizzare"
var
  Aut,MsgAut,ErrAut,Msg: String;
  LOld,LNew,ContaAut: Integer;
begin
  // inizializzazione variabili
  MsgAut:='';
  ErrAut:='';
  ContaAut:=0;
  Aut:=C018SI;

  // autorizzazione richieste scadute
  W009DM.selT860.First;
  while not W009DM.selT860.Eof do
  begin
    try
      if (W009DM.selT860.FieldByName('ID_REVOCA').IsNull) and
         (W009DM.selT860.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') then
      begin
        try
          C018.CodIter:=W009DM.selT860.FieldByName('COD_ITER').AsString;
          C018.Id:=W009DM.selT860.FieldByName('ID').AsInteger;
          // se la richiesta non è ancora autorizzata all'ultimo livello
          // inserisce le autorizzazioni automatiche necessarie
          LOld:=C018.LivMaxAut;
          if LOld < C018.LivMaxObb then
            try
              LNew:=C018.InsAutorizzazioniAutomatiche;
              if LNew > max(0,LOld) then
              begin
                inc(ContaAut);
                MsgAut:=Format('%s%s - %s%s',[MsgAut,W009DM.selT860.FieldByName('NOMINATIVO').AsString,FormatDateTime('mmmm yyyy',W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime),CRLF]);
                // rende effettiva l'autorizzazione all'ultimo livello
                if (LNew = C018.LivMaxObb) then
                  BloccoRiepiloghi(True,W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime);
              end;
              SessioneOracle.Commit;
            except
              on E: Exception do
                ErrAut:=Format('%s%s - %s: %s%s',[ErrAut,W009DM.selT860.FieldByName('NOMINATIVO').AsString,FormatDateTime('mmmm yyyy',W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime),E.Message,CRLF]);
            end;
        except
          // errore probabilmente dovuto a record modificato / cancellato da altro utente
        end;
      end;
    finally
      W009DM.selT860.Next;
    end;
  end;
  W009DM.selT860.Refresh;

  // prepara messaggio di conferma
  Msg:='';
  if ContaAut > 0 then
  begin
    if ContaAut = 1 then
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_RICHIESTA_AUTO),[CRLF,MsgAut])
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_RICHIESTA_AUTO2),[ContaAut,CRLF,MsgAut]);
  end;
  // errori di autorizzazione
  if ErrAut <> '' then
  begin
    if Msg <> '' then
      Msg:=Msg + CRLF;
    Msg:=Msg + IfThen(Msg <> '',CRLF) + Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_RICHIESTA_AUTO),[ErrAut]);
  end;
  if Msg <> '' then
    MsgBox.MessageBox(Msg,IfThen(ErrAut = '',INFORMA,ESCLAMA));
end;

procedure TW009FStampaCartellino.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i, idxStampa, idxAut, LivAut, d, idxRiep, x, maxComp: Integer;
  VisAutorizza,VisStampa: Boolean;
  Data: TDateTime;
  IWImg: TmeIWImageFile;
  StatoAllegati: TStatoAllegati;
begin
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      StatoAllegati:=C018.SetIconaAllegati(IWImg);
      if StatoAllegati.Visibilita = aVisibile then
        IWImg.OnClick:=imgAllegClick;
      if StatoAllegati.Condizione = aObbAssenti then
        TmeIWGrid(grdRichieste.medpCompGriglia[i].CompColonne[0]).Cell[0,0].Css:='invisibile';
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if not SolaLettura then
    begin
      // autorizzazione
      VisAutorizza:=(grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0);
      idxAut:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxAut]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxAut] <> nil then
        C018.SetValoriAut(grdRichieste,i,idxAut,0,1,chkAutorizzazioneClick);

      // anteprima cartellino
      VisStampa:=True;
      idxStampa:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      if not VisStampa then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxStampa]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxStampa] <> nil then
      begin
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).OnClick:=imgStampaCartellinoClick;
        Data:=StrToDate(grdRichieste.medpValoreColonna(i,'MESE_CARTELLINO'));
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).Hint:=Format((grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).Hint,[FormatDateTime('mmmm yyyy',Data)]);
      end;
    end;

    //Componenti colonna riepiloghi
    idxRiep:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
    if grdRichieste.medpCompGriglia[i].CompColonne[idxRiep] <> nil then
    begin
      maxComp:=(grdRichieste.medpCompGriglia[i].CompColonne[idxRiep] as TmeIWGrid).RowCount - 1;
      for d:=0 to High(lstRiepDett) do
        if (StrToIntDef(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'),0) = lstRiepDett[d].Prog)
        and (StrToDateTime(grdRichieste.medpValoreColonna(i,'MESE_CARTELLINO')) = lstRiepDett[d].Mese) then
        begin
          //Dati riepilogativi
          for x:=0 to High(lstRiepDett[d].RiepDati) do
          begin
            (grdRichieste.medpCompCella(i,idxRiep,x * 2) as TmeIWLabel).Caption:=lstRiepDett[d].RiepDati[x].Titolo;
            (grdRichieste.medpCompCella(i,idxRiep,(x * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepDati[x].Valore;
          end;
          //Riepilogo presenze
          (grdRichieste.medpCompCella(i,idxRiep,((maxComp - 1) * 2)) as TmeIWLabel).Caption:=lstRiepDett[d].RiepPresTit;
          (grdRichieste.medpCompCella(i,idxRiep,((maxComp - 1) * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepPresVal;
          //Riepilogo assenze
          (grdRichieste.medpCompCella(i,idxRiep,maxComp * 2) as TmeIWLabel).Caption:=lstRiepDett[d].RiepAssTit;
          (grdRichieste.medpCompCella(i,idxRiep,(maxComp * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepAssVal;
        end;
    end;
  end;
end;

procedure TW009FStampaCartellino.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W009DM.selT860.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE),INFORMA);
    Exit;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW009FStampaCartellino.imgAllegClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAllegClick';
begin
  Log('Traccia',FUNZIONE + ' - inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);

  if not W009DM.selT860.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE),INFORMA);
    Exit;
  end;
  VisualizzaAllegati(Sender);
  Log('Traccia',FUNZIONE + ' - fine');
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW009FStampaCartellino.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  NomeCampo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True,not InModificaTutti) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  if (NomeCampo = 'CF_RIEPILOGHI') and not chkVisRiepiloghi.Checked then
    ACell.Css:='invisibile';

  if ARow = 0 then
  begin
    // nessuna operazione
  end
  else
  begin
    // righe di dettaglio
    if ARow <= Length(grdRichieste.medpCompGriglia) then
    begin
      // assegnazione componenti
      if grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil then
      begin
        ACell.Text:='';
        ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      end;

      if ACell.Control = nil then
      begin
        ACell.Css:=ACell.Css + IfThen(NomeCampo <> 'CF_RIEPILOGHI',' align_center');
        if NomeCampo = 'D_AUTORIZZAZIONE' then
        begin
          // autorizzazione
          ACell.Css:=ACell.Css + ' font_grassetto';
        end;
      end;
    end;
  end;
end;

procedure TW009FStampaCartellino.DBGridColumnClick(ASender: TObject; const AValue: String);
var
  D: TDateTime;
begin
  if cdsT860.RecordCount = 0 then
    Exit;
  cdsT860.Locate('DBG_ROWID',AValue,[]);

  // posizionamento dataset
  W009DM.selT860.SearchRecord('ROWID',cdsT860.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);

  // imposta le date di riferimento per il cartellino
  D:=cdsT860.FieldByName('MESE_CARTELLINO').AsDateTime;
  edtDal.Text:=DateToStr(D);
  edtAl.Text:=DateToStr(R180FineMese(D));

  // dipendente
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT860.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
end;

procedure TW009FStampaCartellino.chkAutorizzazioneClick(Sender: TObject);
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_SI)) then
  begin
    // autorizzazione positiva: effettua validazione
    Autorizzazione1;
  end
  else
    AutorizzazioneOK;
end;

procedure TW009FStampaCartellino.chkVisRiepiloghiClick(Sender: TObject);
begin
  if chkVisRiepiloghi.Checked and AggRiep then
    AggiornaRiepiloghi;
end;

procedure TW009FStampaCartellino.AssociaParametrizzazioni;
// riconosco le parametrizzazioni usate sulla T025, alla data di fine elaborazione
// (se non specificata, si considera quella indicata sulla pagina),
// e per ciascuna i progressivi che la utilizzino
//  (vedi per es.R400.selT025)
var
  LCodT950, LParamCartDefault: String;
  LData: TDateTime;
  LProg: Integer;
  LstProg: TStringList;
  LPair: TPair<String,TStringList>;
begin
  // parametrizzazione di default se non associata al dipendente
  LParamCartDefault:=Trim(Copy(cmbParametrizzazione.Text,1,5));

  // svuota dizionario
  ParamDict.Clear;

  if chkParametrizzazioniTipoCartellino.Checked then
  begin
    // imposta data di riferimento per parametrizzazione cartellino
    if edtAl.Text = '' then
      LData:=Parametri.DataLavoro
    else if not TryStrToDate(edtAl.Text,LData) then
      LData:=Parametri.DataLavoro;

    // estrazione dei progressivi con le relative parametrizzazioni
    // PRE: è già filtrato in base al filtro dizionario
    R180SetVariable(WR000DM.selT025,'DATA',LData);
    WR000DM.selT025.Open;

    // per la stampa cartellino scorre i progressivi della selezione e li associa alle relative parametrizzazioni
    // per l'iter di validazione la stampa è comunque riferita al solo dipendente selezionato
    if (Tag = 405) and TuttiDipSelezionato then
      selAnagrafeW.First;
    while not selAnagrafeW.Eof do
    begin
      LProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

      // determina il codice di parametrizzazione stampa cartellino (su T950) associato al progressivo
      if WR000DM.selT025.SearchRecord('PROGRESSIVO',LProg,[srFromBeginning]) then
        LCodT950:=WR000DM.selT025.FieldByName('CODICE').AsString
      else
        LCodT950:=LParamCartDefault;

      // imposta info
      if ParamDict.ContainsKey(LCodT950) then
      begin
        // chiave esistente
        //   aggiorna il valore aggiungendo il progressivo corrente
        LPair:=ParamDict.ExtractPair(LCodT950);
        LPair.Value.Add(LProg.ToString);
        ParamDict.Add(LCodT950,LPair.Value);
      end
      else
      begin
        // nuova chiave con codice T950 associato al progressivo corrente
        LstProg:=TStringList.Create;
        LstProg.Add(LProg.ToString);
        ParamDict.Add(LCodT950,LstProg);
      end;

      // per la stampa cartellino salta al progressivo successivo
      // per l'iter di validazione, invece, termina subito
      if (Tag = 405) and TuttiDipSelezionato then
        selAnagrafeW.Next
      else
        Break;
    end;
    WR000DM.selT025.CloseAll;
  end
  else
  begin
    // crea un'unica chiave per la parametrizzazione selezionata
    // associata a tutti i progressivi (stringlist vuota)
    LstProg:=TStringList.Create;
    ParamDict.Add(LParamCartDefault,LstProg);
  end;
end;

procedure TW009FStampaCartellino.cmbParametrizzazioneChange(Sender: TObject);
begin
  AggRiep:=True;
  if chkVisRiepiloghi.Checked then
    AggiornaRiepiloghi;
end;

procedure TW009FStampaCartellino.AggiornaRiepiloghi;
var d,i,n,xx,yy:Integer;
    ListaSettaggi:TStringlist;
    sTit:String;
const
  NOME_PROC = 'AggiornaRiepiloghi';
begin
  if W009DM.selT860.RecordCount = 0 then
    exit;
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(Self);
  try
    CodiceT950:=Trim(Copy(cmbParametrizzazione.Text,1,5));
    // creazione datamodulo conteggi
    try
      W009FStampaCartellinoDtm.CreazioneR400(Self);
      Log('Traccia','R400 creato');
    except
      on E: Exception do
      begin
        Log('Errore','R400 non creato',E);
        raise;
      end;
    end;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Close;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.SetVariable('Codice',CodiceT950);
    W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Open;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=True;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=chkAggiornamentoScheda.Checked;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
    W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;

    ListaSettaggi:=TStringList.Create;
    with W009FStampaCartellinoDtM do
    begin
      try
        SetLength(R400FCartellinoDtM.VetDatiLiberiSQL,0);
        ListaSettaggi.Clear;
        R400FCartellinoDtM.selT951.Close;
        R400FCartellinoDtM.selT951.SetVariable('Codice',R400FCartellinoDtM.Q950Int.FieldByName('CODICE').AsString);
        R400FCartellinoDtM.selT951.Open;
        while not R400FCartellinoDtM.selT951.Eof do
        begin
          ListaSettaggi.Add(Trim(R400FCartellinoDtM.selT951.FieldByName('RIGA').AsString));
          R400FCartellinoDtM.selT951.Next;
        end;
        R400FCartellinoDtM.selT951.Close;

        cdsRiep.EmptyDataSet;
        //configurazione Riepilogo
        GetLabels(ListaSettaggi,'Riepilogo',nil,False);
      finally
        ListaSettaggi.Free;
      end;

      for i:=0 to High(lstRiepDett) do
        SetLength(lstRiepDett[i].RiepDati,0);
      SetLength(lstRiepDett,0);
      W009DM.selT860.First;
      while not W009DM.selT860.Eof do
      begin
        SetLength(lstRiepDett,Length(lstRiepDett) + 1);
        d:=High(lstRiepDett);
        lstRiepDett[d].Prog:=W009DM.selT860.FieldByName('PROGRESSIVO').AsInteger;
        lstRiepDett[d].Mese:=W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime;

        for xx:=1 to MaxRighe do for yy:=1 to MaxColonne do R400FCartellinoDtM.MatDettStampa[xx,yy]:='';
        for i:=1 to High(R400FCartellinoDtM.VetDomenica) do R400FCartellinoDtM.VetDomenica[i]:= -1;
        for xx:=Low(R400FCartellinoDtM.TotSett) to High(R400FCartellinoDtM.TotSett) do
        begin
          R400FCartellinoDtM.TotSett[xx].Data:=0;
          R400FCartellinoDtM.TotSett[xx].Debito:='';
          R400FCartellinoDtM.TotSett[xx].OreRese:='';
          R400FCartellinoDtM.TotSett[xx].Saldo:='';
        end;
        R400FCartellinoDtM.NumGiorniCartolina:=0;
        R400FCartellinoDtM.DipInser1:='si';
        if Parametri.WEBCartelliniChiusi = 'S' then
        begin
          R400FCartellinoDtM.selT070.Close;
          R400FCartellinoDtM.selT070.SetVariable('PROGRESSIVO',lstRiepDett[d].Prog);
          R400FCartellinoDtM.selT070.SetVariable('DATA',lstRiepDett[d].Mese);
          R400FCartellinoDtM.selT070.Open;
          if R400FCartellinoDtM.selT070.FieldByName('NUM').AsInteger = 0 then
            R400FCartellinoDtM.DipInser1:='no';
          R400FCartellinoDtM.selT070.Close;
        end;
        R400FCartellinoDtM.CreaClientDataSet(selAnagrafeW);
        if R400FCartellinoDtM.DipInser1 = 'si' then
        begin
          R400FCartellinoDtM.CartolinaDipendente(lstRiepDett[d].Prog,R180Anno(lstRiepDett[d].Mese),R180Mese(lstRiepDett[d].Mese),1,R180Giorno(R180FineMese(lstRiepDett[d].Mese)));
          if R400FCartellinoDtM.DipInser1 = 'si' then
          begin
            R400FCartellinoDtM.CaricaClientDataSet(lstRiepDett[d].Mese,R180FineMese(lstRiepDett[d].Mese));
            //Dati riepilogativi + Dato libero SQL (il 2000 Dato libero 2 è escluso)
            cdsRiep.First;
            while not cdsRiep.Eof do
            begin
              case cdsRiep.FieldByName('TAG').AsInteger of
                0..899,2001..2999://Dati riepilogativi + Dato libero SQL (il 2000 Dato libero 2 è escluso)
                begin
                  SetLength(lstRiepDett[d].RiepDati,Length(lstRiepDett[d].RiepDati) + 1);
                  n:=High(lstRiepDett[d].RiepDati);
                  if cdsRiep.FieldByName('TAG').AsInteger >= 2001 then
                  begin
                    sTit:=R400FCartellinoDtM.VetDatiLiberiSQL[cdsRiep.FieldByName('TAG').AsInteger - 2001].Dato;
                    sTit:=sTit + IfThen((Pos(': ',sTit) = 0) and (Copy(sTit,Length(sTit)) = ':'),' ');//Aggiungo la stringa " " se manca
                    sTit:=sTit + IfThen(Pos(': ',sTit) = 0,': ');//Aggiungo la stringa ": " se manca
                    lstRiepDett[d].RiepDati[n].Titolo:=Copy(sTit,1,Pos(': ',sTit) + 1);
                    lstRiepDett[d].RiepDati[n].Valore:=Copy(sTit,Pos(': ',sTit) + 2);
                  end
                  else
                  begin
                    sTit:=cdsRiep.FieldByName('CAPTION').AsString;
                    sTit:=sTit + IfThen(Copy(sTit,Length(sTit)) = ':',' ');//Aggiungo la stringa " " se manca
                    sTit:=sTit + IfThen(Copy(sTit,Length(sTit) - 1) <> ': ',': ');//Aggiungo la stringa ": " se manca
                    lstRiepDett[d].RiepDati[n].Titolo:=sTit;
                    lstRiepDett[d].RiepDati[n].Valore:=R400FCartellinoDtM.VetRiepStampa[cdsRiep.FieldByName('TAG').AsInteger];
                  end;
                  lstRiepDett[d].RiepDati[n].Titolo:=Copy(lstRiepDett[d].RiepDati[n].Titolo,1,Length(lstRiepDett[d].RiepDati[n].Titolo) - 2);
                end;
              end;
              cdsRiep.Next;
            end;
            //Riepilogo presenze
            R400FCartellinoDtM.cdsPresenze.First;
            while not R400FCartellinoDtM.cdsPresenze.Eof do
            begin
              lstRiepDett[d].RiepPresTit:=lstRiepDett[d].RiepPresTit + IfThen(lstRiepDett[d].RiepPresTit <> '',CRLF);
              lstRiepDett[d].RiepPresVal:=lstRiepDett[d].RiepPresVal + IfThen(lstRiepDett[d].RiepPresVal <> '',CRLF);
              cdsRiep.First;
              while not cdsRiep.Eof do
              begin
                case cdsRiep.FieldByName('TAG').AsInteger of
                  951..952://Codice, Descrizione presenze
                  begin
                    lstRiepDett[d].RiepPresTit:=lstRiepDett[d].RiepPresTit + cdsRiep.FieldByName('CAPTION').AsString + ' ' + R400FCartellinoDtM.cdsPresenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                  953..999://altri dati presenze
                  begin
                    lstRiepDett[d].RiepPresVal:=lstRiepDett[d].RiepPresVal + cdsRiep.FieldByName('CAPTION').AsString + ' ' + R400FCartellinoDtM.cdsPresenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                end;
                cdsRiep.Next;
              end;
              R400FCartellinoDtM.cdsPresenze.Next;
            end;
            lstRiepDett[d].RiepPresTit:=Trim(lstRiepDett[d].RiepPresTit);
            lstRiepDett[d].RiepPresVal:=Trim(lstRiepDett[d].RiepPresVal);
            //Riepilogo assenze
            R400FCartellinoDtM.cdsAssenze.First;
            while not R400FCartellinoDtM.cdsAssenze.Eof do
            begin
              lstRiepDett[d].RiepAssTit:=lstRiepDett[d].RiepAssTit + IfThen(lstRiepDett[d].RiepAssTit <> '',CRLF);
              lstRiepDett[d].RiepAssVal:=lstRiepDett[d].RiepAssVal + IfThen(lstRiepDett[d].RiepAssVal <> '',CRLF);
              cdsRiep.First;
              while not cdsRiep.Eof do
              begin
                case cdsRiep.FieldByName('TAG').AsInteger of
                  901,908://Codice, Descrizione assenze
                  begin
                    lstRiepDett[d].RiepAssTit:=lstRiepDett[d].RiepAssTit + cdsRiep.FieldByName('CAPTION').AsString + ' ' + R400FCartellinoDtM.cdsAssenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                  902..907,909..949://altri dati assenze
                  begin
                    lstRiepDett[d].RiepAssVal:=lstRiepDett[d].RiepAssVal + cdsRiep.FieldByName('CAPTION').AsString + ' ' + R400FCartellinoDtM.cdsAssenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                end;
                cdsRiep.Next;
              end;
              R400FCartellinoDtM.cdsAssenze.Next;
            end;
            lstRiepDett[d].RiepAssTit:=Trim(lstRiepDett[d].RiepAssTit);
            lstRiepDett[d].RiepAssVal:=Trim(lstRiepDett[d].RiepAssVal);
          end;
        end;
        W009DM.selT860.Next;
      end;
    end; // end with

    W009DM.selT860.Refresh;
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  finally
    // distruzione R400
    W009FStampaCartellinoDtm.DistruzioneR400;
    try W009FStampaCartellinoDtM.DistruggiLstRaveComp; except end;
    FreeAndNil(W009FStampaCartellinoDtm);
  end;
  AggRiep:=False;
end;

procedure TW009FStampaCartellino.EliminaComponentiRiepilogo;
var i,j,x:Integer;
    IWC:TIWCustomControl;
begin
  x:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    for j:=0 to High(grdRichieste.medpCompGriglia[i].CompColonne) do
    begin
      if j <> x then //Cancello solo i componenti della colonna dei riepiloghi
        Continue;
      if grdRichieste.medpCompGriglia[i].CompColonne[j] = nil then
        Continue;
      if grdRichieste.medpCompGriglia[i].CompColonne[j] is TmeIWGrid then
        C190PulisciIWGrid((grdRichieste.medpCompGriglia[i].CompColonne[j] as TmeIWGrid));
      IWC:=grdRichieste.medpCompGriglia[i].CompColonne[j];
      grdRichieste.medpCompGriglia[i].CompColonne[j]:=nil;
      FreeAndNil(IWC);
    end;
  end;
end;

procedure TW009FStampaCartellino.CreaComponentiRiepilogo;
var i,r,c,hDati:Integer;
begin
  if High(lstRiepDett) = -1 then
    exit;
  c:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
  //Dati riepilogativi
  hDati:=High(lstRiepDett[0].RiepDati);
  for i:=0 to hDati do
  begin
    grdRichieste.medpPreparaComponenteGenerico('C',0,i*2,DBG_LBL,'','','Nome dato','','S');
    grdRichieste.medpPreparaComponenteGenerico('C',0,i*2 + 1,DBG_LBL,'','','Valore dato','','S');
  end;
  //Riepilogo presenze
  inc(hdati);
  grdRichieste.medpPreparaComponenteGenerico('C',0,hdati*2,DBG_LBL,'','','Codice presenze','','S');
  grdRichieste.medpPreparaComponenteGenerico('C',0,hdati*2 + 1,DBG_LBL,'','','Riepilogo presenze','','S');
  //Riepilogo assenze
  inc(hdati);
  grdRichieste.medpPreparaComponenteGenerico('C',0,hdati*2,DBG_LBL,'','','Codice assenze','','S');
  grdRichieste.medpPreparaComponenteGenerico('C',0,hdati*2 + 1,DBG_LBL,'','','Riepilogo assenze','','S');
  //Posizionamento
  for i:=0 to hDati do
  begin
    grdRichieste.Componenti[i*2].Riga:=i;
    grdRichieste.Componenti[i*2 + 1].Riga:=i;
  end;
  //La proprietà .GridInRiga va settata sull'ultima colonna della cella(altrimenti viene sovrascritta)
  grdRichieste.Componenti[High(grdRichieste.Componenti)].GridInRiga:=False;
  for r:=0 to High(grdRichieste.medpCompGriglia) do
    grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
end;

procedure TW009FStampaCartellino.Autorizzazione1;
var
  ErrValid: String;
  ErrBloccante,
  BloccaAut: Boolean;
begin
  if not ValidazioneCartellino(ErrValid,ErrBloccante) then
  begin
    BloccaAut:=ErrBloccante or (not InAutorizzaTutti);
    if InAutorizzaTutti then
    begin
      ResAutTuttoOk:=False;
    end
    else
    begin
      if ErrBloccante then
      begin
        MsgBox.MessageBox(ErrValid,ESCLAMA);
        // refresh visualizzazione
        W009DM.selT860.Refresh;
        grdRichieste.medpCaricaCDS;

        EliminaComponentiRiepilogo;
        CreaComponentiRiepilogo;
        grdRichiesteAfterCaricaCDS(nil,'');
      end
      else
        MsgBox.WebMessageDlg(ErrValid,mtConfirmation,[mbYes,mbNo],OnConfermaValidazione,'');
    end;
  end
  else
    BloccaAut:=False;

  if not BloccaAut then
    AutorizzazioneOK;
end;

procedure TW009FStampaCartellino.AutorizzazioneOK;
var
  Aut,Resp: String;
begin
  Aut:='';
  Resp:='';
  // autorizzazione richiesta

  // verifica presenza record
  if not W009DM.selT860.SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
  begin
    if InAutorizzaTutti then
    begin
      ResAutTuttoOk:=False;
    end
    else
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
      Exit;
    end;
  end;
  // imposta i dati di autorizzazione
  Resp:=Parametri.Operatore;
  if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_SI)) then
    // autorizzazione SI
    Aut:=C018SI
  else if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_NO)) then
    // autorizzazione NO
    Aut:=C018NO
  else if not Autorizza.Checked then
    // autorizzazione non impostata
    Aut:='';
  // salva i dati di autorizzazione
  try
    C018.CodIter:=W009DM.selT860.FieldByName('COD_ITER').AsString;
    C018.Id:=W009DM.selT860.FieldByName('ID').AsInteger;
    C018.InsAutorizzazione(W009DM.selT860.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
    if C018.MessaggioOperazione <> '' then
      raise Exception.Create(C018.MessaggioOperazione)
    else
    begin
      // rende effettiva l'autorizzazione all'ultimo livello
      if W009DM.selT860.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger = C018.LivMaxObb then
        BloccoRiepiloghi(Aut = C018SI,W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime);
      SessioneOracle.Commit;
    end;
  except
    on E: Exception do
    begin
      if InAutorizzaTutti then
        ResAutTuttoOk:=False
      else
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_IMP_AUTORIZ_FALLITE),[E.Message]),ESCLAMA);
    end;
  end;
  if not InAutorizzaTutti then
    VisualizzaDipendenteCorrente;
end;

procedure TW009FStampaCartellino.W009AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione di tutte le richieste
// ancora da autorizzare visibili a video.
var
  D: TDateTime;
begin
  Log('Traccia','W009AutorizzaTutto - inizio');

  // inizializzazione variabili
  ResAutTuttoOk:=True;

  // autorizzazione richieste

  // niente refresh: autorizza solo ciò che è visualizzato nella pagina
  W009DM.selT860.First;
  while not W009DM.selT860.Eof do
  begin
    try
      try
        // validazione
        Autorizza.Rowid:=W009DM.selT860.RowId;
        Autorizza.Checked:=True;
        Autorizza.Caption:=A000TraduzioneStringhe(A000MSG_MSG_SI);

        // imposta date cartellino
        D:=W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime;
        edtDal.Text:=DateToStr(D);
        edtAl.Text:=DateToStr(R180FineMese(D));

        Autorizzazione1;
      except
        // errore probabilmente dovuto a record modificato / cancellato da altro utente
        on E:Exception do
          ResAutTuttoOk:=False;
      end;
    finally
      W009DM.selT860.Next;
    end;
  end;

  if not ResAutTuttoOk then
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_W009_ERR_RICH_NO_AUTORIZZATE);
  Log('Traccia','W009AutorizzaTutto - fine');
  Ok:=True;
end;

procedure TW009FStampaCartellino.imgStampaCartellinoClick(Sender: TObject);
// simula un click su "Stampa" per visualizzare anteprima del mese
// attualmente selezionato nella griglia
var
  FN: String;
  DV: TDatiVistaVT860;
  FileOk: Boolean;
  NomeFilePDF: String;
  PathFilePDF: String;
  NewPathFilePDF: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // TORINO_REGIONE - commessa 2014/243 VARIE#1.ini
  // valuta le due casistiche:
  // 1. se il pdf è già stato creato
  //    determina il nome del file e la posizione:
  //    se il file esiste lo copia nella directory cache dell'utente e lo visualizza
  //    altrimenti lo genera ex novo e lo visualizza normalmente
  // 2. altrimenti genera e visualizza il file normalmente
  FileOk:=False;
  if W009DM.selT860.FieldByName('ESISTE_PDF').AsString = 'S' then
  begin
    // imposta i dati per la sostituzione variabili nel nome file
    DV.Azienda:=Parametri.Azienda;
    DV.Progressivo:=W009DM.selT860.FieldByName('PROGRESSIVO').AsInteger;
    DV.Matricola:=W009DM.selT860.FieldByName('MATRICOLA').AsString;
    DV.MeseCartellino:=W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime;
    DV.ParamCartellino:=Trim(Copy(cmbParametrizzazione.Text,1,5));

    // determina il nome file vero e il path dove dovrebbe essere presente
    NomeFilePDF:=Bc22MW.GetNomeFilePdf(Parametri.CampiRiferimento.C90_W009FilePdf,DV);
    PathFilePDF:=IncludeTrailingPathDelimiter(Parametri.CampiRiferimento.C90_W009PathPdf) + NomeFilePDF;

    // se il file esiste, lo copia nella cartella cache dell'utente per visualizzarlo
    if TFile.Exists(PathFilePDF) then
    begin
      { TODO : TEST IW 15 }
      NewPathFilePDF:=gGetWebApplicationThreadVar.UserCacheDir + NomeFilePDF;
      try
        TFile.Copy(PathFilePDF,NewPathFilePDF,True);
        FileOk:=TFile.Exists(NewPathFilePDF);
      except
      end;
    end;
  end;

  if FileOk then
  begin
    // se i parametri avanzati lo consentono, visualizza il file
    if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
    begin
      VisualizzaFile(NomeFilePDF,Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_TITOLO_ANTEPRIMA),[Copy(cmbParametrizzazione.Text,7)]),nil,nil);
    end;
  end
  else
  // TORINO_REGIONE - commessa 2014/243 VARIE#1.fine
  begin
    btnAggiornamentoClick(btnStampa);
  end;
end;

function TW009FStampaCartellino.GetRichiestePendenti(var Elenco: String): Integer;
// verifica richieste web pendenti (non ancora autorizzate) per il mese in oggetto
var
  NumRich: Integer;
  DescIter: String;
  function GetDescIter(const PIter: String): String;
  var
    i: Integer;
  begin
    Result:=PIter;
    for i:=0 to High(A000IterAutorizzativi) do
    begin
      if PIter = A000IterAutorizzativi[i].Cod then
      begin
        Result:=A000IterAutorizzativi[i].Desc;
        Break;
      end;
    end;
  end;
begin
  Result:=0;
  Elenco:='';
  R180SetVariable(W009DM.selRichiestePendenti,'VISTAT325',IfThen(Parametri.CampiRiferimento.C90_W026Spezzoni = 'EU','VT325_RICHIESTESTR_GG_EU','VT325_RICHIESTESTR_GG'));
  R180SetVariable(W009DM.selRichiestePendenti,'PROGRESSIVO',medpProgressivo);
  R180SetVariable(W009DM.selRichiestePendenti,'DATA1',DataI);
  R180SetVariable(W009DM.selRichiestePendenti,'DATA2',DataF);
  W009DM.selRichiestePendenti.Open;
  W009DM.selRichiestePendenti.First;
  while not W009DM.selRichiestePendenti.Eof do
  begin
    NumRich:=W009DM.selRichiestePendenti.FieldByName('NUM_RICHIESTE').AsInteger;
    if NumRich > 0 then
    begin
      DescIter:=GetDescIter(W009DM.selRichiestePendenti.FieldByName('ITER').AsString);
      Elenco:=Elenco + Format('%s- %d richieste di %s',[CRLF,NumRich,DescIter]);
      Result:=Result + NumRich;
    end;
    W009DM.selRichiestePendenti.Next;
  end;
end;

function TW009FStampaCartellino.GetTuttiDipSelezionato: Boolean;
var
  LRecordCountTotale: Integer;
begin
  if selAnagrafeW.Filtered then
  begin
    // se il dataset è filtrato, la property Tag contiene il RecordCount
    // totale, filtro escluso
    LRecordCountTotale:=selAnagrafeW.Tag;
    Result:=(ElementoTuttiDip) and
            (selAnagrafeW.Active) and
            (LRecordCountTotale > 1) and
            (cmbDipendentiDisponibili.ItemIndex = 0);
  end
  else
  begin
    // comportamento standard
    Result:=inherited;
  end;
end;

function TW009FStampaCartellino.ValidazioneCartellino(var ErrValid: String; var ErrBloccante: Boolean): Boolean;
// effettua la validazione del cartellino del dipendente selezionato
var
  ElencoRich: String;
  LParamDefault: String;
begin
  Result:=False;
  ErrValid:='';
  ErrBloccante:=False;

  // cartellino in modalità validazione
  Modo:='V';
  AnomalieBloccanti:=False;
  if not ControlliOk(ErrValid) then
    Exit;

  //***.ini
  // ignora il flag di parametrizzazione da tipo cartellino e utilizza
  // la parametrizzazione correntemente selezionata
  LParamDefault:=Trim(Copy(cmbParametrizzazione.Text,1,5));
  ParamDict.Clear;
  ParamDict.Add(LParamDefault,TStringList.Create);

  // effettua una stampa cartellino per estrarre eventuali anomalie
  // se ci sono anomalie bloccanti non valida il cartellino
  EseguiCartellini(LParamDefault,ErrValid);
  //***.fine
  if AnomalieBloccanti then
  begin
    ErrValid:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_ANOMALIE_CARTELLINO),[FormatDateTime('mmmm yyyy',DataI),AnomalieBloccantiDesc]);
    ErrBloccante:=True;
    Exit;
  end;

  // verifica se ci sono richieste pendenti da segnalare
  ElencoRich:='';
  if GetRichiestePendenti(ElencoRich) > 0 then
  begin
    ErrValid:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_RICH_WEB_PENDENTI),[FormatDateTime('mmmm yyyy',DataI),ElencoRich]);
    ErrBloccante:=False;
    Exit;
  end;

  Result:=True;
end;

procedure TW009FStampaCartellino.OnConfermaValidazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta del messaggio modale di conferma validazione
begin
  if Res = mrYes then
    AutorizzazioneOK
  else
  begin
    W009DM.selT860.Refresh;
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  end;
end;

function TW009FStampaCartellino.ControlliOk(var Err: String): Boolean;
// verifica dei dati prima della stampa
begin
  Result:=False;
  if (Modo = 'A') and (not chkAggiornamentoScheda.Checked) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_W009_MSG_AGG_NON_ABILITATO);
    Exit;
  end;
  if not TryStrToDate(edtDal.Text,DataI) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
    ActiveControl:=edtDal;
    Exit;
  end;
  if not TryStrToDate(edtAl.Text,DataF) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
    ActiveControl:=edtAl;
    Exit;
  end;
  if DataF < DataI then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATE_STESSO_ANNO);
    Exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_STOP_CART_PRIMA_DEL),[DateToStr(Parametri.WEBCartelliniDataMin)]);
    Exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_STOP_CART_PRIMA_MESI),[Parametri.WEBCartelliniMMPrec]);
    Exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_STOP_CART_SUCC_MESI),[Parametri.WEBCartelliniMMSucc]);
    Exit;
  end;
  // controlli ok
  Err:='';
  Result:=True;
end;

//***.ini
procedure TW009FStampaCartellino.FiltroSelAnagrafeW(DataSet: TDataSet; var Accept: Boolean);
begin
  // PRE
  //   ElencoProgressivi è impostato in TW009FStampaCartellino.EseguiCartellini
  //   ElencoProgressivi <> ''
  Accept:=R180InConcat(DataSet.FieldByName('PROGRESSIVO').AsString,ElencoProgressiviFiltro);
end;
//***.fine

//***.ini
procedure TW009FStampaCartellino.EseguiCartellini(const PParCartellino: String; var RNomeFile: String);
var
  A,M,G,A2,M2,G2: Word;
  SQLText,MsgErr,Mat,S,LPeriodo,LNomeFile: String;
  iSQL:Integer;
  lst:TStringList;
const
  NOME_PROC = 'EseguiCartellini';
begin
  Log('Traccia',Format('%s - inizio',[NOME_PROC]));
  // inizializzazione variabili
  S:='';
  Mat:='';
  SQLText:='';
  //***.ini
  selAnagrafeW.Tag:=0;
  selAnagrafeW.Filtered:=False;
  selAnagrafeW.OnFilterRecord:=nil;
  //***.fine
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(Self);
  Log('Traccia',Format('%s: modo = [%s]',[NOME_PROC,Modo]));
  try //except
    try  //finally
      Log('Traccia',Format('%s: impostazioni datamodulo W009DtM',[NOME_PROC]));
      //***.ini
      ParamDict.TryGetValue(PParCartellino,lst);
      ElencoProgressiviFiltro:=lst.CommaText;
      lst.Free;
      if ElencoProgressiviFiltro <> '' then
      begin
        selAnagrafeW.Tag:=selAnagrafeW.RecordCount;
        selAnagrafeW.OnFilterRecord:=FiltroSelAnagrafeW;
        selAnagrafeW.Filtered:=True;
      end;
      //***.fine
      W009FStampaCartellinoDtm.selAnagrafeW:=selAnagrafeW;
      W009FStampaCartellinoDtm.CartelliniChiusi:=Parametri.WEBCartelliniChiusi = 'S';
      W009FStampaCartellinoDtm.Stampa:=Modo = 'S';
      W009FStampaCartellinoDtm.RegLog:=True;
      W009FStampaCartellinoDtm.RaveProjectFile:=gSC.ContentPath + 'report\W009StampaCartellino.rav';
      LNomeFile:=GetNomeFile('pdf');
      LNomeFile:=IncludeTrailingPathDelimiter(TPath.GetDirectoryName(LNomeFile)) +
                 TPath.GetFileName(LNomeFile).Replace(medpCodiceForm + '_',medpCodiceForm + '_' + PParCartellino + '_',[]);
      W009FStampaCartellinoDtm.NomeFile:=LNomeFile;
      W009FStampaCartellinoDtm.RaveOutputFileName:=W009FStampaCartellinoDtm.NomeFile;
      RNomeFile:=W009FStampaCartellinoDtm.NomeFile; //***
      MsgErr:='';
      SQLText:=selAnagrafeW.SQL.Text;
      //***CodiceT950:=Trim(Copy(cmbParametrizzazione.Text,1,5));
      DecodeDate(DataI,A,M,G);
      DecodeDate(DataF,A2,M2,G2);
      //Se le date differiscono di mese o di anno, allora i giorni vanno
      //da 1 all'ultimo del mese
      if (M <> M2) or (A <> A2) then
      begin
        G:=1;
        G2:=R180GiorniMese(DataF);
        DataI:=EncodeDate(A,M,G);
        DataF:=EncodeDate(A2,M2,G2);
        edtDal.Text:=DateToStr(DataI);
        edtAl.Text:=DateToStr(DataF);
      end;
      // creazione datamodulo conteggi
      try
        W009FStampaCartellinoDtm.CreazioneR400(Self);
        Log('Traccia',Format('%s: R400 creato',[NOME_PROC]));
      except
        on E: Exception do
        begin
          Log('Errore',Format('%s: R400 non creato',[NOME_PROC]),E);
          raise;
        end;
      end;
      // aggiornamento dei buoni pasto
      if chkAggiornamentoBuoniPasto.Checked then
      begin
        try
          W009FStampaCartellinoDtM.CreazioneR350;
          Log('Traccia',Format('%s: R350 creato',[NOME_PROC]));
        except
          on E: Exception do
          begin
            Log('Errore',Format('%s: R350 non creato',[NOME_PROC]),E);
            raise;
          end;
        end;
      end;
      // aggiornamento accessi mensa
      if chkAggiornamentoAccessiMensa.Checked then
      begin
        try
          W009FStampaCartellinoDtM.CreazioneR300(DataI,DataF);
          Log('Traccia',Format('%s: R300 creato',[NOME_PROC]));
        except
          on E: Exception do
          begin
            Log('Errore',Format('%s: R300 non creato',[NOME_PROC]),E);
            raise;
          end;
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Close;
      //***.ini
      //W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.SetVariable('Codice',CodiceT950);
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.SetVariable('Codice',PParCartellino);
      //***.fine
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Open;
      if (Modo = 'S') and (WR000DM.TipoUtente = 'Dipendente') then
      begin
        S:=W009FStampaCartellinoDtM.R400FCartellinoDtM.CheckValidazione2Parametrizzazione(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,DataI,DataF);
        if S <> '' then
        begin
          raise Exception.Create(S);
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=Modo = 'A';
      W009FStampaCartellinoDtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=chkAggiornamentoScheda.Checked;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
      selAnagrafeW.SetVariable('DATALAVORO',DataF);
      selAnagrafeW.Close;
      if (Modo = 'S') and (Pos(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione,SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',SelAnagrafeW.SQL.Text) = 0)) and
         (Trim(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione) <> '') then
      begin
        S:=SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        Log('Traccia',Format('%s: campi intestazione aggiunti: [%s]',[NOME_PROC,W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione]));
        selAnagrafeW.SQL.Text:=S;
      end;
      try
        selAnagrafeW.Open;
      except
        on E:Exception do
        begin
          Log('Errore',Format('%s: apertura selAnagrafeW: probabile campo intestazione non valido; elenco campi: [%s]',[NOME_PROC,W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione]));
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_W009_ERR_CAMPI_NON_VALIDI));
        end;
      end;
      if Modo = 'S' then
      begin
        Log('Traccia',Format('%s: impostazione stampa',[NOME_PROC]));
        lst:=TStringList.Create;
        try
          SetLength(W009FStampaCartellinoDtM.R400FCartellinoDtM.VetDatiLiberiSQL,0);
          W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.Close;
          W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.SetVariable('Codice',W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.FieldByName('CODICE').AsString);
          W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.Open;
          while not W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.Eof do
          begin
            lst.Add(Trim(W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.FieldByName('RIGA').AsString));
            W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.Next;
          end;
          W009FStampaCartellinoDtM.R400FCartellinoDtM.selT951.Close;
          W009FStampaCartellinoDtM.GetLabels(lst,'Riepilogo2001',nil);
          //Devo già avere l'elenco dei dati liberi 2001
          W009FStampaCartellinoDtM.R400FCartellinoDtM.CreaClientDataSet(selAnagrafeW);
        finally
          lst.Free;
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;
      // dicitura periodo per log
      if (R180Anno(DataI) = R180Anno(DataF)) and
         (R180Mese(DataI) = R180Mese(DataF)) and
         (DataI = R180InizioMese(DataI)) and
         (DataF = R180FineMese(DataF)) then
        LPeriodo:=Format('di %s',[R180NomeMeseAnno(DataI)])
      else
        LPeriodo:=Format('dal %s al %s',[DateToStr(DataI),DateToStr(DataF)]);
      // Gestione Stampa singola o per tutti i dipendenti
      if (Tag = 405) and TuttiDipSelezionato then
      begin
        // stampa per tutti i dipendenti
        selAnagrafeW.First;
        while not selAnagrafeW.Eof do
        begin
          Log('Traccia',Format('%s: calcolo cartellino %.4d/%.4d, matr. [%-8s] %s (param. %s)',
                               [NOME_PROC,
                                selAnagrafeW.RecNo,selAnagrafeW.RecordCount,
                                selAnagrafeW.FieldByName('MATRICOLA').AsString,
                                LPeriodo,PParCartellino{//***CodiceT950}]));
          //MsgErr:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2);
          MsgErr:=W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCartelliniWeb(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,
                                                                                   A,M,G,A2,M2,G2,
                                                                                   W009FStampaCartellinoDtM.CartelliniChiusi,
                                                                                   W009FStampaCartellinoDtM.Stampa,
                                                                                   W009FStampaCartellinoDtM.RegLog);
          selAnagrafeW.Next;
        end;
      end
      else
      begin
        // stampa singola
        //Posizionamento sulla matricola correntemente selezionata
        if Tag = 405 then
        begin
          // 12.2.6
          //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8))
          Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
        end
        else
          Mat:=cdsT860.FieldByName('MATRICOLA').AsString;
        if selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
        begin
          Log('Traccia',Format('%s: calcolo cartellino matr. [%-8s] %s (param. %s)',
                               [NOME_PROC,
                                selAnagrafeW.FieldByName('MATRICOLA').AsString,
                                LPeriodo,PParCartellino{//***CodiceT950}]));
          //MsgErr:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2);
          MsgErr:=W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCartelliniWeb(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,
                                                                                   A,M,G,A2,M2,G2,
                                                                                   W009FStampaCartellinoDtM.CartelliniChiusi,
                                                                                   W009FStampaCartellinoDtM.Stampa,
                                                                                   W009FStampaCartellinoDtM.RegLog);
          AnomalieBloccanti:=W009FStampaCartellinoDtM.R400FCartellinoDtM.AnomaliaBloccante;
          AnomalieBloccantiDesc:=W009FStampaCartellinoDtM.R400FCartellinoDtM.lstAnomalie.Text;
        end
        else
        begin
          GetDipendentiDisponibili(DataF);
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ANAGRA_NON_DISPONIBILE));
          Abort;
        end;
      end;
      if MsgErr <> '' then
        MsgBox.MessageBox(MsgErr,ERRORE);
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      Log('Traccia',Format('%s: aggiornamento: R400 Chiusura query completata',[NOME_PROC]));
      //Chiudo subito le query e le unit dei conteggi, salvo Q950Int e sel T004 che serve in stampa
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Open;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selT004.Open;
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      Log('Traccia',Format('%s: aggiornamento: R450 Chiusura query completata',[NOME_PROC]));
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      // se richiesto produce l'anteprima pdf
      if Modo = 'S' then
        EseguiStampa;
    finally
      Log('Traccia',Format('%s: chiusura stampa cartellini',[NOME_PROC]));
      // distruzione R400
      W009FStampaCartellinoDtm.DistruzioneR400;
      // riapre selezione anagrafica
      //***.ini
      selAnagrafeW.Tag:=0;
      selAnagrafeW.Filtered:=False;
      selAnagrafeW.OnFilterRecord:=nil;
      ElencoProgressiviFiltro:='';
      //***.fine
      selAnagrafeW.CloseAll;
      selAnagrafeW.SQL.Text:=SQLText;
      selAnagrafeW.Open;
      // riposizionamento sulla matricola correntemente selezionata
      if Tag = 405 then
      begin
        // 12.2.6
        //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8))
        Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
      end
      else
        Mat:=cdsT860.FieldByName('MATRICOLA').AsString;
      if not selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
        selAnagrafeW.First;
      try W009FStampaCartellinoDtM.DistruggiLstRaveComp; except end;
      FreeAndNil(W009FStampaCartellinoDtm);
      Log('Traccia',Format('%s - fine',[NOME_PROC]));
    end;
  except
    on E:Exception do
    begin
      if not (E is EAbort) then
      begin
        RNomeFile:='';
        Log('Errore',NOME_PROC,E);
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO),[E.Message]),ERRORE);
      end;
    end;
  end;
end;

procedure TW009FStampaCartellino.EseguiStampa;
// effettua l'anteprima pdf del cartellino a conteggi avvenuti
var
  S: String;
const
  NOME_PROC = 'EseguiStampa';
begin
  try
    if W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
    begin
      if Pos(INI_PAR_NO_STAMPACARTELLINO,W000ParConfig.ParametriAvanzati) = 0 then
      begin
        W009FStampaCartellinoDtM.W009CSStampa:=CSStampa;
        Log('Traccia',Format('%s: inizio stampa',[NOME_PROC]));
        S:=W009FStampaCartellinoDtM.EsecuzioneStampa;
        if S <> '' then
          raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_FILE_PDF_FALLITO),[S]));
        Log('Traccia',Format('%s: fine stampa',[NOME_PROC]));
        //***.ini
        // spostato in btnAggiornamentoClick
        {
        // visualizza pdf
        if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
        begin
          Log('Traccia',Format('%s: Apertura file pdf ''/Files/W009%s%s''',[NOME_PROC,gSC.UserCacheUrl,TPath.GetFileName(W009FStampaCartellinoDtm.NomeFile)]));
          VisualizzaFile(W009FStampaCartellinoDtm.NomeFile,Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_TITOLO_ANTEPRIMA),[Copy(cmbParametrizzazione.Text,7)]),AvvisoValidazione,nil);
        end;
        }
        //***.fine
      end;
    end
    else
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_NO_CART_DISPONIBILI),INFORMA);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,ESCLAMA);
      Log('Errore','Errore in fase di stampa',E);
    end;
  end;
end;

procedure TW009FStampaCartellino.AvvisoValidazione;
var
  Err,ElencoRich: String;
begin
  if (Tag <> 405) and (Modo = 'S') then
  begin
    // avvisa se ci sono anomalie bloccanti
    if AnomalieBloccanti then
    begin
      Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_ANOM_VALIDAZIONE),[FormatDateTime('mmmm yyyy',DataI),AnomalieBloccantiDesc]);
      GGetWebApplicationThreadVar.ShowMessage(Err);
      Exit;
    end;

    // verifica se ci sono richieste pendenti da segnalare
    ElencoRich:='';
    if GetRichiestePendenti(ElencoRich) > 0 then
    begin
      Err:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_RICH_PENDENTI),[FormatDateTime('mmmm yyyy',DataI),ElencoRich]);
      GGetWebApplicationThreadVar.ShowMessage(Err);
      Exit;
    end;
  end;
end;

procedure TW009FStampaCartellino.BloccoRiepiloghi(const PBlocca: Boolean; const PDataRiep: TDateTime);
// effettua il blocco / sblocco dei riepiloghi per il dipendente e il mese indicati
// PBlocca:   true per bloccare, False per sbloccare
// PDataRiep: data del mese da bloccare / sbloccare
var
  i: Integer;
  Riep: String;
  OQ: TOracleQuery;
  function ConsideraRiepilogo(const S: String): Boolean;
  begin
    //riepiloghi da NON considerare:
    Result:=(Riep = 'T071A') or
            (Riep = 'T071S') or
            (Riep = 'T074') or
            (Riep = 'T130') or
            (Riep = 'T131') or
            (Riep = 'T134') or
            (Riep = 'T264') or
            (Riep = 'T692') or
            (Riep = 'T762') or
            (Riep = 'T820') or
            (Riep = 'T825') or
            (Riep = 'T860') or
            (Riep = 'M040') or
            (Riep = 'CSI006');
    Result:=not Result;
  end;
begin
  if PBlocca then
    OQ:=W009DM.scrBloccaRiep
  else
    OQ:=W009DM.scrSbloccaRiep;
  OQ.SetVariable('PROGRESSIVO',medpProgressivo);
  OQ.SetVariable('DAL',PDataRiep);
  OQ.SetVariable('AL',PDataRiep);

  // blocco dei riepiloghi
  for i:=0 to High(lstRiepiloghi) do
  begin
    Riep:=Trim(Copy(lstRiepiloghi[i],1,6));
    if ConsideraRiepilogo(Riep) then
    begin
      OQ.SetVariable('RIEPILOGO',Riep);
      OQ.Execute;
    end;
    // commit immediatamente dopo il richiamo a questa procedura
  end;
end;

procedure TW009FStampaCartellino.btnAggiornamentoClick(Sender: TObject);
var
  LErr, LParam, LFile, LTitolo: String;
  LForzaNewWindow: Boolean;
  LstFile: TStringList;
  i: Integer;
const
  NOME_PROC = 'btnAggiornamentoClick';
begin
  // determina modalità
  if Sender = btnAggiornamento then
    Modo:='A'  // A = aggiornamento
  else if Sender = btnStampa then
    Modo:='S'  // S = stampa
  else
    Modo:='V'; // V = validazione

  // effettua controlli bloccanti
  if not ControlliOk(LErr) then
  begin
    MsgBox.MessageBox(LErr,INFORMA);
    Exit;
  end;

  //***.ini
  //EseguiCartellini;
  // associa le parametrizzazioni cartellino ai progressivi
  AssociaParametrizzazioni;

  // effettua l'operazione richiesta
  LstFile:=TStringList.Create;
  try
    // elaborazione cartellini separata per ogni parametrizzazione
    for LParam in ParamDict.Keys do
    begin
      LFile:='';
      EseguiCartellini(LParam,LFile);
      if (LFile <> '') and FileExists(LFile) then
        LstFile.Add(LFile);
    end;

    // in caso di stampa, visualizza i file
    if (Modo = 'S') and
       (Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0) then
    begin
      // se ci sono più file da visualizzare, esclude il parametro FILE_INLINE
      LForzaNewWindow:=(LstFile.Count > 1) and (Pos(INI_PAR_FILE_INLINE,W000ParConfig.ParametriAvanzati) > 0);

      // visualizza i file pdf
      for i:=0 to LstFile.Count - 1 do
      begin
        { DONE : TEST IW 15 }
//        Log('Traccia',Format('%s: Visualizzazione file pdf ''/Files/W009%s%s''',[NOME_PROC,gSC.UserCacheUrl,TPath.GetFileName(LstFile[i])]));
        Log('Traccia','%s: Apertura file pdf ''/Files/W009/' + TPath.GetFileName(LstFile[i]) + '''');
        LTitolo:=Format(A000TraduzioneStringhe(A000MSG_W009_PARAM_TITOLO_ANTEPRIMA),[LParam]);
        VisualizzaFile(LstFile[i],LTitolo,AvvisoValidazione,nil,fdUser,LForzaNewWindow);
      end;
    end;
  finally
    FreeAndNil(LstFile);
  end;
  //***.fine
end;

procedure TW009FStampaCartellino.DistruggiOggetti;
begin
  //***.ini
  if ParamDict <> nil then
    try FreeAndNil(ParamDict); except end;
  //***.fine
  try FreeAndNil(W009DM); except end;
  if Bc22MW <> nil then
    try FreeAndNil(Bc22MW); except end;

  inherited;
end;

end.

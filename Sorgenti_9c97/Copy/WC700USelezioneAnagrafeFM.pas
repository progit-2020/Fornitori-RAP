unit WC700USelezioneAnagrafeFM;

interface

uses
  SysUtils, Classes, Controls, Dialogs, Forms, Variants, C190FunzioniGeneraliWeb,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  DB, IWCompCheckbox, IWCompEdit,
  WR200UBaseFM, medpIWMessageDlg, meIWGrid, meIWEdit,
  ActnList, meIWComboBox, meIWImageFile, IWCompListbox, meIWListbox,
  meIWCheckBox, meIWRadioGroup, IWCompLabel, meIWLabel,
  IWDBGrids, medpIWDBGrid,   IWTypes,
  meIWMemo, IWCompExtCtrls, IWCompGrids, IWCompJQueryWidget,A000UInterfaccia,OracleData,
  IWTMSCheckList, meTIWCheckListBox,A000UCostanti, A000USessione,StrUtils,Oracle,C180FunzioniGenerali,QueryStorico,
  IWCompButton, meIWButton, A000UMessaggi, IWWebGrid, meTIWDBAdvWebGrid, IWCompMemo,
  IWDBAdvWebGrid,IWColor,IWFont,
  WC700USelezioneAnagrafeDM, Menus, IWApplication, System.Actions;

const C700TuttiCampi = 'T030.*,T480.CITTA,T480.PROVINCIA,V430.*';
      C700CampiBase = 'T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO';

type
  TWC700ModalResultEvent = procedure(Sender: TObject; Result: Boolean) of object;

  PSelezione = ^TSelezione;

  TSelezione = record
    DaValore,AValore,Valore:String;
    TotValori,SelValori:TStringList;
    Esistente:Boolean;
  end;

  TSelezioneFull = record
    NomeCampo,NomeLogico:String;
    Selezione:TSelezione;
  end;

  TC700SelAnagrafeBridge = record
    SQLCreato:String;
    Progressivo:Integer;
    SelezionePeriodica,
    SoloPersonaleInterno,
    SoloPersonaleInternoVal,
    AncheDipendentiCessati,
    AncheDipendentiCessatiVal:Boolean;
    SelezionePeriodicaVal:Integer;
  end;

  TWC700FSelezioneAnagrafeFM = class(TWR200FBaseFM)
    grdToolBar: TmeIWGrid;
    ActionList: TActionList;
    actEliminaSelezione: TAction;
    actAnnulla: TAction;
    actConferma: TAction;
    actlblSelezione: TAction;
    actcmbSelezione: TAction;
    actSalvaSelezione: TAction;
    actApriSelezione: TAction;
    actEseguiSelezione: TAction;
    actModificaSelezione: TAction;
    actAnnullaSelezione: TAction;
    lblPeriodoConsiderato: TmeIWLabel;
    rdgPeriodoConsiderato: TmeIWRadioGroup;
    lstAzienda: TmeIWListbox;
    chkDipendentiCessati: TmeIWCheckBox;
    chkPersonaleEsterno: TmeIWCheckBox;
    lblUguale: TmeIWLabel;
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    lblOppure: TmeIWLabel;
    JQAutoComplete: TIWJQueryWidget;
    edtUguale: TmeIWEdit;
    edtDa: TmeIWEdit;
    edtA: TmeIWEdit;
    lblOrdinamento: TmeIWLabel;
    lstOrdinamento: TmeIWListbox;
    chkgrpValori: TmeTIWCheckListBox;
    btnAggiungiOrdinamento: TmeIWButton;
    memModificaSelezione: TmeIWMemo;
    actConfermaSelezioneManuale: TAction;
    actAnnullaSelezioneManuale: TAction;
    grdAnteprima: TmedpIWDBGrid;
    pmnSelectionCheck: TPopupMenu;
    mnuSelezionaTutto: TMenuItem;
    mnuDeselezionaTutto: TMenuItem;
    mnuInvertiSelezione: TMenuItem;
    pmnRicerca: TPopupMenu;
    mnuRicercaCompleta: TMenuItem;
    meIWMemo1: TmeIWMemo;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure lstAziendaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure actAnnullaExecute(Sender: TObject);
    procedure lstAziendaAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure lstOrdinamentoAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnAggiungiOrdinamentoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure actAnnullaSelezioneExecute(Sender: TObject);
    procedure actEseguiSelezioneExecute(Sender: TObject);
    procedure actApriSelezioneExecute(Sender: TObject);
    procedure actSalvaSelezioneExecute(Sender: TObject);
    procedure actEliminaSelezioneExecute(Sender: TObject);
    procedure actModificaSelezioneExecute(Sender: TObject);
    procedure actConfermaSelezioneManualeExecute(Sender: TObject);
    procedure actAnnullaSelezioneManualeExecute(Sender: TObject);
    procedure grdAnteprimaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdAnteprimaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure mnuSelezionaTuttoClick(Sender: TObject);
    procedure mnuDeselezionaTuttoClick(Sender: TObject);
    procedure mnuInvertiSelezioneClick(Sender: TObject);
    procedure mnuRicercaCompletaClick(Sender: TObject);
    procedure chkDipendentiCessatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    itemAziendaSelected : Integer;
    Componenti,SaveComponenti:TList;
    FDataLavoro,FDataDal : TDateTime;
    FSelezionePeriodica,
    FPersonaleInterno,
    FPersonaleInternoVal,
    FDipendentiCessati,
    FDipendentiCessatiVal : Boolean;
    FSelezionePeriodicaVal: Integer;
    ListSQL :  TStringList;
    ListSQLPeriodico,
    CorpoSQL:TStringList;
    SaveSelAnagrafe, SaveSQLCreato : TStringList;
    SaveProgressivo : Integer;
    SaveSingoloDipendente : Boolean;
    SaveSelAnagrafeODS : TOracleDataSet;
    FDatiVisualizzati: String;
    FDatiSelezionati: String;
    FProgressivo: LongInt;
    FOpenSelAnagrafe: Boolean;
    SingoloDipendente : boolean;
    FCampiAnteprima: String;
    FSelAnagrafeBridge: TC700SelAnagrafeBridge;
    FNomeSelezioneCaricata: String;
    edtSelezione: TmeIWEdit;
    //function WC700DM:TWC700FSelezioneAnagrafeDM;
    procedure CreaToolBar;
    procedure imgNavBarClick(Sender: TObject);
    procedure PulisciListaComponenti(var List: Tlist);
    procedure LoadDaSelezione(index : Integer);
    procedure SalvaSuSelezione(index : Integer);
    procedure GetCheck(Source:TStringList);
    procedure PutCheck(Dest:TStringList);
    procedure QueryDinamica(Modo : Integer);
    procedure setDatiVisualizzati(val : String);
    procedure setDatiSelezionati(val : String);
    //procedure setDataLavoro(val: TDateTime);
    procedure setProgressivo(val: LongInt);
    procedure GenerazioneSelezione;
    procedure SetSelezionePeriodica (val : boolean);
    function C700CompletaDatiSelezionati() :String;
    function FormatoCampo(Campo: String): String;
    function FormatoValore(Campo:String; Valore:String; Tipo:TFieldType):String;
    function IsCampoCaseInsensitive(Campo: String): Boolean;
    function PrefissoTabella(Campo:String):String;
    function ValoriSelezionati(Campo:String; Lista:TStringList; Tipo:TFieldType):String;
    procedure CaricaListSelezioni;
    procedure ResultSovrascrivi(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SalvaSelezione;
    procedure ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ModificaSelezioneManuale(val : boolean);
    procedure SalvaSelAnagrafeBridge;
    procedure setSelezionePeriodicaVal(const Value: Integer);
    procedure setPersonaleInterno(const Value: Boolean);
    procedure setPersonaleInternoVal(const Value: Boolean);
    procedure setDipendiCessati(const Value: Boolean);
    procedure setDipendiCessatiVal(const Value: Boolean);
    procedure CopiaListaComp(var ListSorgente: TList;var ListDestinazione: TList);
    procedure imgSingoloDipendenteClick(Sender: TObject);
    procedure CaricaLstAzienda(Completa: boolean);
    procedure CreaSave;
    procedure SvuotaSelezione(Sender: TObject);
  public
    SQLCreato :  TStringList;
    ResultEvent: TWC700ModalResultEvent;
    WC700NavigatorBar:TmeIWGrid;
    WC700DM:TWC700FSelezioneAnagrafeDM;
    SelezioneFull:array of TSelezioneFull;
    procedure ImpostazioniCampiSelAnagrafe;
    property C700DataLavoro : TDateTime read FDataLavoro write FDataLavoro;
    property C700DataDal : TDateTime read FDataDal write FDataDal;
    property C700DatiVisualizzati : String read FDatiVisualizzati write setDatiVisualizzati;
    property C700DatiSelezionati : String read FDatiSelezionati write setDatiSelezionati;
    property C700Progressivo: LongInt read FProgressivo write setProgressivo;
    property C700OpenSelAnagrafe: Boolean read FOpenSelAnagrafe write FOpenSelAnagrafe;
    property C700SelezionePeriodica : Boolean read FSelezionePeriodica write setSelezionePeriodica;
    property C700SelezionePeriodicaVal : Integer read FSelezionePeriodicaVal write setSelezionePeriodicaVal;
    property C700PersonaleInterno : Boolean read FPersonaleInterno write setPersonaleInterno;
    property C700PersonaleInternoVal : Boolean read FPersonaleInternoVal write setPersonaleInternoVal;
    property C700DipendentiCessati : Boolean read FDipendentiCessati write setDipendiCessati;
    property C700DipendentiCessatiVal : Boolean read FDipendentiCessatiVal write setDipendiCessatiVal;
    property C700SelAnagrafeBridge: TC700SelAnagrafeBridge read FSelAnagrafeBridge;
    property C700NomeSelezioneCaricata: String read FNomeSelezioneCaricata;
    procedure Visualizza(const MinElementi:Integer = 0;const MaxElementi:Integer = 0);
    procedure C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
    function C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
    function C700SettaPeriodoSelAnagrafe(DataDal,DataLavoro:TDateTime): Boolean;
    procedure ApriSelezione(Selezione:String);
    procedure EreditaSelezione(SelAnagrafeBridge: TC700SelAnagrafeBridge);
    procedure CreaSelezioneTotale;
    procedure RipristinaSelezione;
    procedure PreparaListSQL;
    procedure ReleaseOggetti; override;
  end;

implementation

uses medpIWC700NavigatorBar, WR010UBase;

{$R *.dfm}

function TWC700FSelezioneAnagrafeFM.ValoriSelezionati(Campo: String;
  Lista: TStringList; Tipo: TFieldType): String;
{ Gestione della lista con i valori per la costruzione
  della sintassi CAMPO1 IN (VALORE1, VALORE2,...) OR CAMPO1 IS NULL }
var i:Integer;
    Nullo:Boolean;
begin
  Result:='';
  Nullo:=False;

  // gestione della lista di valori
  for i:=0 to Lista.Count - 1 do
  begin
    if FormatoValore(Campo,Lista[i],Tipo) = '''''' then
      Nullo:=True
    else
    begin
      if i > 0 then  Result:=Result + ',';
      Result:=Result + FormatoValore(Campo,Lista[i],Tipo);
    end;
  end;
  if Result <> '' then
    Result:=FormatoCampo(Campo) + ' IN (' + Result + ')';

  // gestione del valore null
  if Nullo then
  begin
    if Result <> '' then
      Result:='(' + Result + ' OR ' + Campo + ' IS NULL' + ')'
    else
      Result:=Campo + ' IS NULL';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaSave;
var i: Integer;
begin
  SaveSelAnagrafe:=TStringList.Create;
  SaveSQLCreato:=TStringList.Create;
  SaveSelAnagrafe.Assign(WC700DM.SelAnagrafe.SQL);
  SaveSQLCreato.Assign(SQLCreato);
  SaveSelAnagrafeODS:=TOracleDataSet.Create(nil);
  SaveSingoloDipendente:=SingoloDipendente;
  for i:=0 to WC700DM.SelAnagrafe.VariableCount - 1 do
  begin
    SaveSelAnagrafeODS.DeclareVariable(WC700DM.selAnagrafe.VariableName(i),WC700DM.selAnagrafe.VariableType(i));
    SaveSelAnagrafeODS.SetVariable(WC700DM.SelAnagrafe.VariableName(i),WC700DM.SelAnagrafe.GetVariable(i));
  end;

  SaveProgressivo:=WC700DM.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TWC700FSelezioneAnagrafeFM.ImpostazioniCampiSelAnagrafe;
begin
  with WC700DM.selAnagrafe do
  begin
    try FieldByName('T430BADGE').DisplayLabel:='BADGE'; except end;
    try FieldByName('T430INIZIO').DisplayLabel:='INIZIO'; except end;
    try FieldByName('T430FINE').DisplayLabel:='FINE'; except end;
    try FieldByName('COGNOME').DisplayWidth:=15; except end;
    try FieldByName('NOME').DisplayWidth:=15; except end;
    try FieldByName('T430INIZIO').DisplayWidth:=10; except end;
    try FieldByName('T430FINE').DisplayWidth:=10; except end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.Visualizza(const MinElementi:Integer; const MaxElementi:Integer);
var i : Integer;
    //column :TTIWDBWebGridColumn;
    ListCampiAnteprima:TStringList;
  progIniziale: Integer;
  bSetprogIniziale: Boolean;
begin
  Visible:=True; //Necessario perchè nel css impostato come display none; non togliere a meno di rimuovere l'impostazione dal css
  //salvataggio dati per annulla
  with WC700DM do
  begin
    CreaSave;
    (* Caratto 20/11/2012 spostato in SetProgressivo per poter gestire casistica di form con
       c700 che però partono senza nessun dipendente selezionato (es 082 da menu)

    if C700OpenSelAnagrafe then
    begin
      with TWR100FBase(Self.Owner).WC700DM.selAnagrafe do
      begin
        CloseAll;
        SQL.Assign(ListSQL);
        SQLCreato.Clear;
        if C700Progressivo >= 0 then
        begin
          SQL.Add('AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo));
          //Dario 28/8/2012. se è impostato un progressivo lo tengo come filtro anche in SQLCreato
          //Se è 0 lo imposto solo per avere l'anteprima vuota ma non devo considerarlo come filtro di selezione
          if C700Progressivo > 0 then
          begin
            if SQLCreato.Count > 0 then
              SQLCreato.Add('AND');
            SQLCreato.Add('T030.PROGRESSIVO = ' + IntToStr(C700Progressivo));
          end;
        end;
        if VariableIndex('C700DATADAL') >= 0 then
          DeleteVariable('C700DATADAL');
        if VariableIndex('C700FILTRO') >= 0 then
          DeleteVariable('C700FILTRO');
        if VariableIndex('DATALAVORO') < 0 then
          DeclareVariable('DATALAVORO',otDate);

        SetVariable('DATALAVORO',FDataLavoro);
        Open;
      end;
    end;
      *)
    CaricaListSelezioni;
    //CARATTO 15/01/2014 alberto: mantenere la selezione scelta. svuotare solo in creazione
    //edtSelezione.Text:='';
  end;

  ImpostazioniCampiSelAnagrafe;

  grdAnteprima.medpComandiCustom:=True;
  grdAnteprima.medpPaginazione:=True;

  grdAnteprima.medpRighePagina:=18;
  bSetprogIniziale:=False;
  if WC700DM.selAnagrafe.RecordCount > 0 then
  begin
    progIniziale:=WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    bSetprogIniziale:=True;
  end;
  grdAnteprima.medpAttivaGrid(WC700DM.selAnagrafe,False,False);
  if SingoloDipendente then
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ANNULLA','','','')
  else
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');

  //Caratto 02/04/2013 In seguito alla modifica inserita nella DBGrid ( per avere medpComandiEdit e medpComandiCustom)
  //bisogna richiamare esplicitamente medpCaricaCDS in caso di medpComandiCustom;
  grdAnteprima.medpCaricaCDS;
  //devo resettare i componenti creati in precedenza, perchè non sempre uguali

  if bSetprogIniziale then
  begin
    WC700DM.selAnagrafe.SearchRecord('PROGRESSIVO',progIniziale,[srFromBeginning]);
    grdAnteprima.medpAggiornaCDS(False);
  end;


  (* Caratto 18/12/2012 la griglia anteprima visualizza i campi definiti
  Per la Wa001 i campi selezionati sono tutti, ma la grid deve visualizzare solo quelli base
  *)
  ListCampiAnteprima:=TStringList.Create();
  try
    ListCampiAnteprima.CommaText:=FCampiAnteprima;
    //visibili solo le colonne prensenti nella stringlist
    for i:=0 to grdAnteprima.medpDataSet.FieldCount - 1 do
      grdAnteprima.medpColonna(grdAnteprima.medpDataSet.Fields[i].FieldName).Visible:=ListCampiAnteprima.IndexOf(grdAnteprima.medpDataSet.Fields[i].FieldName) > -1
  finally
    FreeAndNil(ListCampiAnteprima);
  end;

  ModificaSelezioneManuale(False);
  //Carico i dati attualmente selezionati
  LoadDaSelezione(itemAziendaSelected);
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,800,-1,500, 'Selezione anagrafiche','#wc700_container',False,True);
end;

procedure TWC700FSelezioneAnagrafeFM.actAnnullaExecute(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  SQLCreato.Assign(SaveSQLCreato);
  CopiaListaComp(SaveComponenti,Componenti);
  //SVUOTO elenco valori
  chkgrpValori.Items.Clear;
  with WC700DM do
  begin
    SelAnagrafe.SQL.Assign(SaveSelAnagrafe);
    SelAnagrafe.CloseAll;
    SelAnagrafe.DeleteVariables;
    for i:=0 to SaveSelAnagrafeODS.VariableCount - 1 do
    begin
      SelAnagrafe.DeclareVariable(SaveSelAnagrafeODS.VariableName(i),SaveSelAnagrafeODS.VariableType(i));
      SelAnagrafe.SetVariable(SaveSelAnagrafeODS.VariableName(i),SaveSelAnagrafeODS.GetVariable(i));
    end;
    SelAnagrafe.Open;
    SelAnagrafe.SearchRecord('PROGRESSIVO',SaveProgressivo,[srFromBeginning]);
  end;
  SingoloDipendente:=SaveSingoloDipendente;
  //cambio componente della grid per accesso successivo
  (* 05/04/2013 con modifica di caricaCDS esplicito viene fatto nella visualizza
  if SingoloDipendente then
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ANNULLA','','','')
  else
    grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');
  *)
  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,False);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  FreeAndNil(SaveSelAnagrafe);
  FreeAndNil(SaveSQLCreato);
  FreeAndNil(SaveSelAnagrafeODS);
  FreeAndNil(SaveSelAnagrafe);

  jQuery.OnReady.Clear;
  Visible:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.SvuotaSelezione(Sender: TObject);
var i : Integer;
begin
  SQLCreato.Clear;
  if Sender = actAnnullaSelezione then
  begin
    edtSelezione.Text:='';
    Singolodipendente:=False;
  end;

  lstOrdinamento.Items.Clear;
  edtDa.Text:='';
  edtA.Text:='';
  edtUguale.Text:='';
  for i:=0 to lstazienda.Items.Count - 1 do
  begin
    PSelezione(Componenti.Items[i]).Esistente:=False;
    PSelezione(Componenti.Items[i]).DaValore:='';
    PSelezione(Componenti.Items[i]).AValore:='';
    PSelezione(Componenti.Items[i]).Valore:='';
    PSelezione(Componenti.Items[i]).SelValori.Clear;
  end;
end;
procedure TWC700FSelezioneAnagrafeFM.actAnnullaSelezioneExecute(
  Sender: TObject);
begin
  inherited;

  SvuotaSelezione(Sender);
  actEseguiSelezioneExecute(actAnnullaSelezione);
end;

procedure TWC700FSelezioneAnagrafeFM.actAnnullaSelezioneManualeExecute(
  Sender: TObject);
begin
  inherited;
  ModificaSelezioneManuale(False);
end;

procedure TWC700FSelezioneAnagrafeFM.actApriSelezioneExecute(Sender: TObject);
var Trovato:Boolean;
begin
  inherited;
  FNomeSelezioneCaricata:='';
  with WC700DM.selT003Nome do
  begin
    Open;
    Filtered:=True;
    Trovato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;
  if not Trovato then
  begin
    MsgBox.MessageBox(A000MSG_C700_ERR_SELEZIONE_INESISTENTE,ERRORE);
    abort;
  end;

  actAnnullaSelezioneExecute(nil);
  with WC700DM.selT003 do
  begin
    Close;
    SetVariable('Nome',edtSelezione.Text);
    Open;
    SQLCreato.Clear;
    while not Eof do
    begin
      SQLCreato.Add(FieldByName('Riga').AsString);
      Next;
    end;
  end;
  actEseguiSelezioneExecute(nil);
  FNomeSelezioneCaricata:=Trim(edtSelezione.Text);
end;

procedure TWC700FSelezioneAnagrafeFM.actConfermaExecute(Sender: TObject);
var
  Prog: Integer;
begin
  inherited;
  Prog:=SaveProgressivo;
  if WC700DM.selAnagrafe.State <> dsInactive then
    Prog:=WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  //Salva i dati sulla struttura TSelezione
  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);

  //Imposto il flag  in modo da restituire le colonne volute
  if (SQLCreato.Count = 0) then
    GenerazioneSelezione;

  QueryDinamica(2);

  WC700DM.selAnagrafe.Open;

  if not WC700DM.selAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]) then
    WC700DM.selAnagrafe.First; //elemento non più presente in selAnagrafe. capita nel caso di modifica selezione e poi eredita

  SalvaSelAnagrafeBridge;

  ImpostazioniCampiSelAnagrafe;

  //if Sender = actConferma then
  begin
    CopiaListaComp(Componenti,SaveComponenti);
    //TWR100FBase(Self.Owner).WC700CambioProgressivo(nil);
    if Assigned(TmedpIWC700NavigatorBar(WC700NavigatorBar).AggiornaAnagr) then
      TmedpIWC700NavigatorBar(WC700NavigatorBar).AggiornaAnagr;
    if Assigned(TmedpIWC700NavigatorBar(WC700NavigatorBar).CambioProgressivoEvent) then
      TmedpIWC700NavigatorBar(WC700NavigatorBar).CambioProgressivoEvent(nil);
    if Assigned(ResultEvent) then
    try
      ResultEvent(Self,True);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
  end;
  jQuery.OnReady.Clear;
  Visible:=False;

  //Distruzione oggetti creati su visualizza. da fare anche su annulla
  FreeAndNil(SaveSelAnagrafe);
  FreeAndNil(SaveSQLCreato);
  FreeAndNil(SaveSelAnagrafeODS);
end;

procedure TWC700FSelezioneAnagrafeFM.actConfermaSelezioneManualeExecute(
  Sender: TObject);
begin
  inherited;
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(memModificaSelezione.Lines);
  SQLCreato.Assign(memModificaSelezione.Lines);
  actEseguiSelezioneExecute(nil);
  ModificaSelezioneManuale(False);
end;

procedure TWC700FSelezioneAnagrafeFM.actEliminaSelezioneExecute(Sender: TObject);
var Trovato:Boolean;
begin
  inherited;
  with WC700DM.selT003Nome do
  begin
    Open;
    Filtered:=True;
    Trovato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;
  if not Trovato then
    exit;
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultElimina,'');
  abort;
end;

procedure TWC700FSelezioneAnagrafeFM.actEseguiSelezioneExecute(Sender: TObject);
var
  S : String;
begin
  inherited;
  //Salva i dati sulla struttura TSelezione
  FNomeSelezioneCaricata:='';
  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);
  if Sender = actEseguiSelezione then
    SingoloDipendente:=false;

  if (SQLCreato.Count = 0) then
    GenerazioneSelezione;

  QueryDinamica(1);
  try
    with TOracleQuery.Create(nil) do
    try
      Session:=WC700DM.selAnagrafe.Session;
      begin
        Variables.Assign(WC700DM.selAnagrafe.Variables);
        SQL.Assign(WC700DM.selAnagrafe.SQL);
      end;
      Describe;
    finally
      Free;
    end;
  except
    SQLCreato.Clear;
    GenerazioneSelezione;
  end;
  //Alberto 16/06/2006: se si preme 'Annulla selezione' si esegue l'anteprima vuota
  if (Sender = actAnnullaSelezione) then
  begin
    S:=WC700DM.selAnagrafe.SQL.Text;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
    begin
      Insert(' AND T030.PROGRESSIVO = 0 ',S,Pos('ORDER BY',UpperCase(S)));
      WC700DM.selAnagrafe.SQL.Text:=S;
    end;
  end;

  WC700DM.selAnagrafe.Open;
  if Visible then //se non è visibile non aggiorno. es richiamo da WA023 per correzione
  begin
    if SingoloDipendente then
      grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ANNULLA','','','')
    else
      grdAnteprima.medpPreparaComponenteGenerico('WR102-R',grdAnteprima.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');
    grdAnteprima.medpAggiornaCDS(True);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.actModificaSelezioneExecute(Sender: TObject);
begin
  inherited;

  ModificaSelezioneManuale(True);

  if SQLCreato.Count = 0 then
    GenerazioneSelezione;

  memModificaSelezione.Lines.Assign(SQLCreato);
  (*
  if C700FSQL.ShowModal = mrOK then
  begin
    // split a 2000 caratteri per ogni riga di codice sql
    R180SplitLines(C700FSQL.Memo1.Lines);
    SQLCreato.Assign(C700FSQL.Memo1.Lines);
    actConfermaExecute(nil);
  end;
*)
end;

procedure TWC700FSelezioneAnagrafeFM.actSalvaSelezioneExecute(Sender: TObject);
var
  NewSelezione,Abilitato: Boolean;
begin
  inherited;
  if Trim(edtSelezione.Text) = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_C700_ERR_NO_SELEZIONE,mtError,[mbOK],nil,'');
    abort;
  end;

  if lstazienda.Items.Count > 0 then
    lstAziendaAsyncChange(nil,nil);

  if SQLCreato.Count = 0 then
    GenerazioneSelezione;

  NewSelezione:=False;
  with WC700DM.selT003Nome do
  begin
    Open;
    //Verifico esistenza in tutte le selezioni, indipendentemente dal filtro dizionario
    Filtered:=False;
    NewSelezione:=not SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    //Verifico esistenza nel proprio filtro dizionario
    Filtered:=True;
    Abilitato:=SearchRecord('NOME',Trim(edtSelezione.Text),[srFromBeginning]);
    Close;
  end;

  if not NewSelezione then
  begin
   if (Parametri.C700_SalvaSelezioni <> 'S') or (not Abilitato) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_C700_ERR_FMT_SEL_GIA_ESISTENTE,[edtSelezione.Text]),mtError,[mbOK],nil,'');
      abort;
    end
    else
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_C700_DLG_FMT_SEL_GIA_ESISTENTE,[edtSelezione.Text]),mtConfirmation,[mbYES,mbNO],ResultSovrascrivi,'');
      abort;
    end
  end;
  SalvaSelezione;
end;

procedure TWC700FSelezioneAnagrafeFM.btnAggiungiOrdinamentoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if (lstOrdinamento.Items.IndexOf(lstAzienda.Items[itemAziendaSelected]) = -1 )then
  begin
    lstOrdinamento.Items.Add(lstAzienda.Items[itemAziendaSelected]);
    if (lstOrdinamento.itemIndex = -1) then
      lstOrdinamento.itemIndex:=0;
  end;
  SQLCreato.Clear;
  edtSelezione.Text:='';
end;

function TWC700FSelezioneAnagrafeFM.C700CompletaDatiSelezionati: String;
var lstS,lstV:TStringList;
    i:Integer;
begin
  Result:=C700DatiSelezionati;
  if Result = C700TuttiCampi then
    exit;
  lstS:=TStringList.Create;
  lstV:=TStringList.Create;
  try
    lstS.CommaText:=StringReplace(UpperCase(C700DatiSelezionati),'T030.','',[rfReplaceAll]);
    lstV.CommaText:=UpperCase(C700DatiVisualizzati);
    for i:=0 to lstV.Count - 1 do
      if lstS.IndexOf(lstV[i]) = -1 then
      begin
        lstS.Add(lstV[i]);
        if Result <> '' then
          Result:=Result + ',';
        Result:=Result + lstV[i];
      end;
  finally
    lstS.Free;
    lstV.Free;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CaricaListSelezioni;
var Elementi : String;
begin
  with WC700DM do
  begin
    selT003Nome.Open;
    Elementi:='';
    while not selT003Nome.Eof do
    begin
      Elementi:=Elementi + '''' + C190EscapeJs(selT003Nome.FieldByName('NOME').AsString) + ''',';
      selT003Nome.Next;
    end;
    selT003Nome.Close;
  end;
  if Elementi <> '' then
  begin
    JQAutoComplete.OnReady.Text:=
           'var elementi = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' +
           '$("#' + edtSelezione.HTMLName + '").autocomplete({' + CRLF +
           '  source: elementi,' + CRLF +
           '  delay: 0,' + CRLF +
           '  minLength: 0' + CRLF +
           '}).focus(function(){ ' + CRLF +
           '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
           '}); ';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CopiaListaComp(var ListSorgente: TList ;var ListDestinazione: TList);
var
  P : PSelezione;
  i,j: Integer;
begin
  PulisciListaComponenti(ListDestinazione);
  for I:=0 to ListSorgente.Count - 1 do
  begin
    New(P);
    j:=ListDestinazione.Add(P);
    PSelezione(ListDestinazione.Items[j]).DaValore:=PSelezione(ListSorgente.Items[i]).DaValore;
    PSelezione(ListDestinazione.Items[j]).AValore:=PSelezione(ListSorgente.Items[i]).AValore;
    PSelezione(ListDestinazione.Items[j]).Valore:=PSelezione(ListSorgente.Items[i]).Valore;
    PSelezione(ListDestinazione.Items[j]).TotValori:=TStringList.Create;
    PSelezione(ListDestinazione.Items[j]).TotValori.Assign(PSelezione(ListSorgente.Items[i]).TotValori);
    PSelezione(ListDestinazione.Items[j]).SelValori:=TStringList.Create;
    PSelezione(ListDestinazione.Items[j]).SelValori.Assign(PSelezione(ListSorgente.Items[i]).SelValori);
    PSelezione(ListDestinazione.Items[j]).Esistente:=PSelezione(ListSorgente.Items[i]).Esistente;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaToolBar;
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdToolBar.RowCount:=1;
  grdToolBar.ColumnCount:=ActionList.ActionCount;

  if ActionList.ActionCount > 0 then
    PrecCategory:=TAction(ActionList.Actions[0]).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(ActionList.Actions[i]).Category  then
    begin
      grdToolBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdToolBar.ColumnCount:=grdToolBar.ColumnCount + 1;
      PrecCategory:=TAction(ActionList.Actions[i]).Category;
    end;

    grdToolBar.Cell[0,k].Text:='';
    if TAction(ActionList.Actions[i]) = actcmbSelezione then
    begin
      grdToolBar.Cell[0,k].Control:=TmeIWEdit.Create(Self);
      edtSelezione:=TmeIWEdit(grdToolBar.Cell[0,k].Control);
      //CARATTO 15/01/2014 alberto: mantenere la selezione scelta. svuotare solo in creazione
      edtSelezione.Text:='';
      edtSelezione.Tag:=i;
      edtSelezione.Name:='cmbSelezione';
      edtSelezione.Css:='width30chr';
    end
    else if TAction(ActionList.Actions[i]) = actlblSelezione then
    begin
      grdToolBar.Cell[0,k].Text:=' Selezione: ';
      grdToolBar.Cell[0,k].Css:='intestazione';
    end
    else
    begin
      grdToolBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      TmeIWImageFile(grdToolBar.Cell[0,k].Control).OnClick:=imgNavBarClick;
      TmeIWImageFile(grdToolBar.Cell[0,k].Control).Tag:=i;
    end;

    k:=k + 1;
  end;
  (*TWR100FBase(Self.Parent).*)C190AggiornaToolBar(grdToolBar, ActionList);
end;

function TWC700FSelezioneAnagrafeFM.FormatoCampo(Campo: String): String;
{ se il campo rientra nella lista di quelli da trattare come "case insensitive"
  utilizza il formato "UPPER(CAMPO)"
  altrimenti lascia il campo inalterato }
begin
  Result:=Campo;
  if IsCampoCaseInsensitive(Campo) then
    Result:='UPPER(' + Result + ')';
end;

function TWC700FSelezioneAnagrafeFM.FormatoValore(Campo, Valore: String;
  Tipo: TFieldType): String;
{Formatta il valore inserendo gli apici se stringa,
 e trasformando la data in dd/mm/yyyy
 Inoltre valuta se considerare il campo case insensitive, utilizzando il formato
 "UPPER(campo)" (ha senso solo per i campi di tipo string) }
begin
  if Valore = '' then
    Result:=''''''
  else
  case Tipo of
    ftString:
    begin
      Result:='''' + AggiungiApice(Valore) + '''';
      if IsCampoCaseInsensitive(Campo) then
        Result:='UPPER(' + Result + ')';
    end;
    ftTime:
      Result:='''' + AggiungiApice(Valore) + '''';
    ftDate,ftDateTime:
      Result:='''' + FormatDateTime('dd/mm/yyyy',StrToDate(Valore)) + '''';
    else
      Result:=Valore;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.GenerazioneSelezione;
var i,P : Integer;
    Da,A,Campo1,Valore,Oppure,Valore1,Valore2,VecchioMemo,Ordina : String;
begin
  //Memorizzo la vecchia selezione e tolgo la parte ORDER BY
  VecchioMemo:=SQLCreato.Text;
  i:=Pos('ORDER BY',VecchioMemo);
  if i > 0 then
    VecchioMemo:=Copy(VecchioMemo,1,i - 1);
  SQLCreato.Clear;
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    //Costruzione CAMPO1 >= ... AND CAMPO1 <= ...
    Da:='';
    A:='';
    Oppure:='';
    //Imposto il prefisso della tabella prima del campo
    Campo1:=PrefissoTabella(Parametri.ColonneStruttura.Values[lstAzienda.Items[i]]);
    Valore:=PSelezione(Componenti.Items[i]).Valore;
    Valore1:=PSelezione(Componenti.Items[i]).DaValore;
    Valore2:=PSelezione(Componenti.Items[i]).AValore;
    P:=Parametri.ColonneStruttura.IndexOfName(lstAzienda.Items[i]);
    if (Valore <>'') then
    begin
      //valore puntuale
      Da:=FormatoCampo(Campo1) + ' LIKE ' + FormatoValore(Campo1,Valore,TFieldType(StrToInt(Parametri.TipiStruttura[P])))
    end
    else if (Valore1 <> '') and (Valore2 <> '') then
    begin
      if Valore1 = Valore2 then
      begin
        if Pos('%',Valore1) = 0 then
          Da:=FormatoCampo(Campo1) + ' = ' + FormatoValore(Campo1,Valore1,TFieldType(StrToInt(Parametri.TipiStruttura[P])))
        else
          Da:=FormatoCampo(Campo1) + ' LIKE ' +  FormatoValore(Campo1,Valore1,TFieldType(StrToInt(Parametri.TipiStruttura[P])));
      end
      else
        Da:=Format('%s BETWEEN %s AND %s',[FormatoCampo(Campo1),FormatoValore(Campo1,Valore1,TFieldType(StrToint(Parametri.TipiStruttura[P]))),FormatoValore(Campo1,Valore2,TFieldType(StrToInt(Parametri.TipiStruttura[P])))])
    end
    else
    begin
      if Valore1 <> '' then
        Da:=FormatoCampo(Campo1) + ' >= ' + FormatoValore(Campo1,Valore1,TFieldType(StrToint(Parametri.TipiStruttura[P])));
      if Valore2 <> '' then
        A:=FormatoCampo(Campo1) + ' <= ' + FormatoValore(Campo1,Valore2,TFieldType(StrToint(Parametri.TipiStruttura[P])));
      if (Da <> '') and (A <> '') then
        Da:=Da + ' AND ';
      Da:=Da + A;
    end;
    if Da <> '' then Da:='(' + Da + ')';
    //Costruzione CAMPO1 IN (...)
    Oppure:=ValoriSelezionati(Campo1,PSelezione(Componenti.Items[i]).SelValori,TFieldType(StrToint(Parametri.TipiStruttura[P])));
    //if Oppure <> '' then Oppure:='(' + Oppure + ')';
    if (Da <> '') and (Oppure <> '') then
      Da:=Da + ' OR ';
    Da:=Da + Oppure;
    if Da <> '' then
    begin
      Da:='(' + Da + ')';
      if SQLCreato.Count > 0 then
        Da:=' AND ' + Da;
      SQLCreato.Add(Da);
    end;
  end;
  //Se è cambiata la selezione reimposto Esistente = False
  //per tutti i dati
  if VecchioMemo <> SQLCreato.Text then
  begin
    for i:=0 to lstAzienda.Items.Count - 1 do
    PSelezione(Componenti.Items[i]).Esistente:=False;
    chkgrpValori.Items.Clear; //svuoto eventuali elementi caricati
  end;
  Ordina:='';
  for i:=0 to lstOrdinamento.Items.Count - 1 do
    Ordina:=Ordina + ', ' + PrefissoTabella(Parametri.ColonneStruttura.Values[lstOrdinamento.Items[i]]);
  if lstOrdinamento.Items.IndexOf('COGNOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('COGNOME');
  if lstOrdinamento.Items.IndexOf('NOME') = -1 then
    Ordina:=Ordina + ', ' + PrefissoTabella('NOME');
  if Ordina <> '' then
    SQLCreato.Add('ORDER BY ' + Copy(Ordina,3,Length(Ordina)));
  // split a 2000 caratteri per ogni riga di codice sql
  R180SplitLines(SQLCreato);
end;

procedure TWC700FSelezioneAnagrafeFM.GetCheck(Source: TStringList);
{Leggo gli Items di Source e li Checko in CBValori}
var i,j:Integer;
begin
  //devo resettari i valori selezionati altrimenti la chkgrp li mantiene
  for i := 0 to chkgrpValori.Items.Count do
    chkgrpValori.Selected[i]:=False;

  for i:=0 to Source.Count - 1 do
  begin
    j:=chkgrpValori.Items.IndexOf(Source[i]);
    if j > -1 then
      chkgrpValori.Selected[j]:=True
    else
      chkgrpValori.Selected[j]:=False;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.grdAnteprimaAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r:=0 to High(grdAnteprima.medpCompGriglia) do
  if grdAnteprima.medpCompCella(r,grdAnteprima.medpIndexColonna('DBG_COMANDI'),0) <> nil then
  begin
    img:=(grdAnteprima.medpCompCella(r,grdAnteprima.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
(*
    if SingoloDipendente then
      img.ImageFile.FileName:=fileImgAnnulla
    else
      img.ImageFile.FileName:=fileImgConferma;
*)
    img.OnClick:=imgSingoloDipendenteClick;
    if SingoloDipendente then
      img.Hint:='Annulla singolo dipendente'
    else
      img.Hint:='Singolo dipendente';
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.grdAnteprimaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  DataInizioRap,
  DataFineRap: TDateTime;
  NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  if ARow = 0 then Exit;

  if grdAnteprima.medpClientDataset.RecNo <> ARow then
  begin
    grdAnteprima.medpClientDataset.First;
    grdAnteprima.medpClientDataset.MoveBy(ARow);
  end;


  with grdAnteprima.medpClientDataset do
  begin
    if (Active) and (RecordCount > 0) then
    begin
      DataInizioRap:=FieldByName('T430INIZIO').AsDateTime;
      if DataInizioRap = 0 then
        DataInizioRap:=EncodeDate(1899,12,30);
      DataFineRap:=FieldByName('T430FINE').AsDateTime;
      if DataFineRap = 0 then
        DataFineRap:=EncodeDate(3999,12,31);
      if ((rdgPeriodoConsiderato.ItemIndex = 0) and ((DataInizioRap > FDataLavoro) or (DataFineRap < FDataLavoro))) or
         ((rdgPeriodoConsiderato.ItemIndex = 1) and ((FDataLavoro < DataInizioRap) or (R180VarToDateTime((grdAnteprima.medpDataSet as TOracleDataset).GetVariable('C700DATADAL')) > DataFineRap))) then
        ACell.Css:=ACell.Css + ' font_rosso';
    end;
  end;

  NumColonna:=grdAnteprima.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdAnteprima.medpCompGriglia) + 1) and (grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    if ACell.Control is TmeIWImageFile then
      TmeIWImageFile(ACell.Control).Tag:=grdAnteprima.medpClientDataset.FieldByName('PROGRESSIVO').AsInteger;
  end;

end;

procedure TWC700FSelezioneAnagrafeFM.imgSingoloDipendenteClick(Sender: TObject);
var
 Progressivo: Integer;
begin
  inherited;
  Progressivo:=(Sender as TmeIWImageFile).Tag;

  SingoloDipendente:=not SingoloDipendente;

  if (SingoloDipendente)  then
  begin
    C700Progressivo:=Progressivo;
  end
  else
    C700Progressivo:=-1;
  actEseguiSelezioneExecute(nil);
end;

procedure TWC700FSelezioneAnagrafeFM.imgNavBarClick(Sender: TObject);
begin
  TAction(ActionList.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

function TWC700FSelezioneAnagrafeFM.IsCampoCaseInsensitive(
  Campo: String): Boolean;
{ Determina se un campo deve essere trattato in modo
  da non considerare differenza fra maiuscole e minuscole. }
//var
//  NomeCampo: String;
//  i: Integer;
begin
  // gestione commentata per il momento
  {
  i:=Pos('.',Campo);
  NomeCampo:=Copy(Campo,i + 1,Length(Campo) - i);
  Result:=(NomeCampo = 'COGNOME');
  }
  Result:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  lstOrdinamento.NoSelectionText:='';
  Componenti:=TList.Create;
  SaveComponenti:=TList.Create;
  CorpoSQL:=TStringList.Create;
  SQLCreato:=TStringList.Create;
  ListSQLPeriodico:=TStringList.Create;
  SingoloDipendente:=False;
  FCampiAnteprima:='MATRICOLA,COGNOME,NOME,T430BADGE,T430INIZIO,T430FINE,PROGRESSIVO';
  FNomeSelezioneCaricata:='';

  //inizializzazione. I valori verranno impostati tramite le property
  SingoloDipendente:=false;
  FDataLavoro:=Parametri.DataLavoro;
  FDatiVisualizzati:=Parametri.DatiC700;
  //setto tramite property
  C700DatiSelezionati:='';

  ListSQL:=TStringList.Create;
  PreparaListSQL;
  (* Massimo 13/12/2013 - spostato in 'PreparaListSQL' perchè è necessario ricreare le listeSQL anche dalla funzione
     menù 'Visualizza dipendenti cessati'.

  ListSQL.Text:=QVistaOracle;
  ListSQL.Insert(0,Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  //Leggo le inbizioni
  with Parametri.Inibizioni do
    if Count > 0 then
      if Strings[0] <> '' then
      begin
        ListSQL.Add('AND');
        for i:=0 to Count - 1 do
          ListSQL.Add(Strings[i]);
      end;

  ListSQLPeriodico.Clear;
  ListSQLPeriodico.Add(Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  ListSQLPeriodico.Add(QVistaOracle);
  ListSQLPeriodico.Add('AND T030.PROGRESSIVO IN (');
  // utilizzo hint "unnest" - daniloc. 22.11.2010
  // nota: la distinct è stata rimossa dopo alcune verifiche statistiche sui tempi di esecuzione
  //ListSQLPeriodico.Add('  SELECT DISTINCT PROGRESSIVO FROM');
  HintUnnest:='/*+ HintT030V430 UNNEST */';
  ListSQLPeriodico.Add(Format('  SELECT %s PROGRESSIVO FROM',[HintUnnest]));
  // utilizzo hint "unnest".fine
  S:=StringReplace(QVistaOracle,':DATALAVORO BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                                 ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                                 [rfIgnoreCase]);
  {P430}
  if Parametri.V430 = 'P430' then
    S:=StringReplace(S,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
  ListSQLPeriodico.Add(S);
  //Leggo le inibizioni
  with Parametri.Inibizioni do
    if Count > 0 then
      if Strings[0] <> '' then
      begin
        ListSQLPeriodico.Add('AND');
        for i:=0 to Count - 1 do
           ListSQLPeriodico.Add(Strings[i]);
      end;
  ListSQLPeriodico.Add(':C700FILTRO)');
  *)

  caricaLstAzienda(False);
 //Creo lista componenti salvataggio vecchi valori
  CopiaListaComp(Componenti,SaveComponenti);

  if lstAzienda.Items.Count > 0 then
  begin
    lstAzienda.itemIndex:=0;
    itemAziendaSelected:=lstAzienda.itemIndex;
  end;

  CreaToolBar;
end;

procedure TWC700FSelezioneAnagrafeFM.PreparaListSQL;
var i: Integer;
    S,HintUnnest : String;
begin
  ListSQL.Text:=QVistaOracle;
  ListSQL.Insert(0,Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  //Leggo le inbizioni
  with Parametri.Inibizioni do
    if Count > 0 then
      if Strings[0] <> '' then
      begin
        ListSQL.Add('AND');
        for i:=0 to Count - 1 do
          ListSQL.Add(Strings[i]);
      end;

  ListSQLPeriodico.Clear;
  ListSQLPeriodico.Add(Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
  ListSQLPeriodico.Add(QVistaOracle);
  ListSQLPeriodico.Add('AND T030.PROGRESSIVO IN (');
  // utilizzo hint "unnest" - daniloc. 22.11.2010
  // nota: la distinct è stata rimossa dopo alcune verifiche statistiche sui tempi di esecuzione
  //ListSQLPeriodico.Add('  SELECT DISTINCT PROGRESSIVO FROM');
  HintUnnest:='/*+ HintT030V430 UNNEST */';
  ListSQLPeriodico.Add(Format('  SELECT %s PROGRESSIVO FROM',[HintUnnest]));
  // utilizzo hint "unnest".fine
  S:=StringReplace(QVistaOracle,':DATALAVORO BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                                 ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                                 [rfIgnoreCase]);
  {P430}
  if Parametri.V430 = 'P430' then
    S:=StringReplace(S,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
  ListSQLPeriodico.Add(S);
  //Leggo le inibizioni
  with Parametri.Inibizioni do
    if Count > 0 then
      if Strings[0] <> '' then
      begin
        ListSQLPeriodico.Add('AND');
        for i:=0 to Count - 1 do
           ListSQLPeriodico.Add(Strings[i]);
      end;
  ListSQLPeriodico.Add(':C700FILTRO)');
end;

procedure TWC700FSelezioneAnagrafeFM.CaricaLstAzienda(Completa: boolean);
var
   j,i : Integer;
   P : PSelezione;
   S : String;
   SelezioneFullVuota: Boolean;
begin
  SelezioneFullVuota:=Length(SelezioneFull) = 0;
  PulisciListaComponenti(Componenti);
  lstAzienda.Items.Clear;
  lstAzienda.OnAsyncChange:=nil;
  with WR000DM.cdsI010 do
  begin
    First;
    while not Eof do
    begin
      if (Completa) or ((FieldByName('RICERCA').AsInteger <> RICERCA_NULL) and (FieldByName('RICERCA').AsInteger >= 0))   then
      begin
        S:=FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
           (FieldByName('ACCESSO').AsString = 'S' ) then
        begin
          lstAzienda.Items.Add(FieldByName('NOME_LOGICO').AsString);
          New(P);
          j:=Componenti.Add(P);
          PSelezione(Componenti.Items[j]).DaValore:='';
          PSelezione(Componenti.Items[j]).AValore:='';
          PSelezione(Componenti.Items[j]).Valore:='';
          PSelezione(Componenti.Items[j]).TotValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).SelValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).Esistente:=False;
        end;
      end;
      //Ricerca completa
      if SelezioneFullVuota then
      begin
        SetLength(SelezioneFull,Length(SelezioneFull) + 1);
        j:=High(SelezioneFull);
        SelezioneFull[j].NomeCampo:=FieldByName('NOME_CAMPO').AsString;
        SelezioneFull[j].NomeLogico:=FieldByName('NOME_LOGICO').AsString;
        SelezioneFull[j].Selezione.DaValore:='';
        SelezioneFull[j].Selezione.AValore:='';
        SelezioneFull[j].Selezione.Valore:='';
        SelezioneFull[j].Selezione.TotValori:=TStringList.Create;
        SelezioneFull[j].Selezione.SelValori:=TStringList.Create;
        SelezioneFull[j].Selezione.Esistente:=False;
      end;
      WR000DM.cdsI010.Next;
    end;
  end;
  lstAzienda.OnAsyncChange:=lstAziendaAsyncChange;
end;

procedure TWC700FSelezioneAnagrafeFM.chkDipendentiCessatiAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  FDipendentiCessatiVal:=chkDipendentiCessati.Checked;
end;

procedure TWC700FSelezioneAnagrafeFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  //sul render perchè posso cambiare data lavoro da una form all'altra
  if rdgPeriodoConsiderato.Enabled then
    lblPeriodoConsiderato.Caption:='Periodo considerato'
  else
    lblPeriodoConsiderato.Caption:='Periodo considerato (' + DateToStr(C700DataLavoro) + ')';

  rdgPeriodoConsiderato.Items[0]:='al ' + FormatDateTime('dd/mm/yyyy',FDataLavoro);
  rdgPeriodoConsiderato.Items[1]:='dal ' + FormatDateTime('dd/mm/yyyy',FDataDal) + ' al ' + FormatDateTime('dd/mm/yyyy',FDataLavoro);
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSelAnagrafeBridge;
begin
  //OldC700SelAnagrafeBridge:=C700SelAnagrafeBridge;
  FSelAnagrafeBridge.SQLCreato:=SQLCreato.Text;
  FSelAnagrafeBridge.Progressivo:=C700Progressivo;
  FSelAnagrafeBridge.SelezionePeriodica:=FSelezionePeriodica;
  FSelAnagrafeBridge.SelezionePeriodicaVal:=rdgPeriodoConsiderato.ItemIndex;
  FSelAnagrafeBridge.SoloPersonaleInterno:=FPersonaleInterno;
  FSelAnagrafeBridge.SoloPersonaleInternoVal:=chkPersonaleEsterno.Checked;
  FSelAnagrafeBridge.AncheDipendentiCessati:=FDipendentiCessati;
  FSelAnagrafeBridge.AncheDipendentiCessatiVal:=chkDipendentiCessati.Checked;
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSelezione;
var i: Integer;
begin
  with WC700DM do
  begin
    delT003.SetVariable('Nome',edtSelezione.Text);
    delT003.Execute;

    insT003.SetVariable('Nome',edtSelezione.Text);
    for i:=0 to SQLCreato.Count - 1 do
    begin
      if Trim(SQLCreato[i]) <> '' then
      begin
        insT003.SetVariable('Posizione',i);
        insT003.SetVariable('Riga',Trim(SQLCreato[i]));
        insT003.Execute;
      end;
    end;
    insT003.Session.Commit;
    A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE','',edtSelezione.Text);
  end;
  CaricaListSelezioni;

  MsgBox.WebMessageDlg(A000MSG_MSG_SALVATAGGIO_AVVENUTO,mtInformation,[mbOK],nil,'');
end;

procedure TWC700FSelezioneAnagrafeFM.SalvaSuSelezione(index: Integer);
var
 OldValore,
 OldDa,
 OldA,
 OldIn: String;
begin
  OldValore:=PSelezione(Componenti.Items[index]).Valore;
  OldDa:=PSelezione(Componenti.Items[index]).DaValore;
  OldA:=PSelezione(Componenti.Items[index]).AValore;
  OldIn:=PSelezione(Componenti.Items[index]).SelValori.Text;

  PSelezione(Componenti.Items[index]).Valore:=edtUguale.Text;
  PSelezione(Componenti.Items[index]).DaValore:=edtDa.Text;
  PSelezione(Componenti.Items[index]).AValore:=edtA.Text;
  chkgrpValori.Items.Clear;
  if PSelezione(Componenti.Items[index]).Esistente then
  begin
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[index]).TotValori);
    PutCheck(PSelezione(Componenti.Items[index]).SelValori);
  end;

  if (OldValore <> PSelezione(Componenti.Items[index]).Valore) or
     (OldDa <> PSelezione(Componenti.Items[index]).DAValore ) or
     (OldA <> PSelezione(Componenti.Items[index]).AValore) or
     (OldIn <> PSelezione(Componenti.Items[index]).SelValori.Text) then
  begin
    SQLCreato.Clear;
    edtSelezione.Text:='';
  end;
end;


{
procedure TWC700FSelezioneAnagrafeFM.setDataLavoro(val: TDateTime);
begin
  FDataLavoro:=val;
end;
}

procedure TWC700FSelezioneAnagrafeFM.setDatiSelezionati(val: String);
begin
  FDatiSelezionati:=val;
  if FDatiSelezionati = '' then
      FDatiSelezionati:=C700CampiBase;

  FDatiSelezionati:=C700CompletaDatiSelezionati;
end;

procedure TWC700FSelezioneAnagrafeFM.setDatiVisualizzati(val: String);
begin
  FDatiVisualizzati:=val;
  if FDatiVisualizzati = 'MATRICOLA,T430BADGE,COGNOME,NOME' then
    FDatiVisualizzati:=Parametri.DatiC700;
end;

procedure TWC700FSelezioneAnagrafeFM.setProgressivo(val: LongInt);
begin
  FProgressivo:=val;
  with WC700DM.selAnagrafe do
  begin
    CloseAll;
    SQL.Assign(ListSQL);
    SQLCreato.Clear;
    if C700Progressivo >= 0 then
    begin
      SQL.Add('AND T030.PROGRESSIVO = ' + IntToStr(FProgressivo));
      //Dario 28/8/2012. se è impostato un progressivo lo tengo come filtro anche in SQLCreato
      //Se è 0 lo imposto solo per avere l'anteprima vuota ma non devo considerarlo come filtro di selezione
      //Caratto 20/03/2013 non salvare progressivo =0 perchè altrimenti partendo con selezione vuota
      //bisogna prima fare annulla selezione e poi confermare
      if FProgressivo > 0 then
      begin
        if SQLCreato.Count > 0 then
          SQLCreato.Add('AND');
        SQLCreato.Add('T030.PROGRESSIVO = ' + IntToStr(FProgressivo));
      end;
     if VariableIndex('C700DATADAL') >= 0 then
        DeleteVariable('C700DATADAL');
      if VariableIndex('C700FILTRO') >= 0 then
        DeleteVariable('C700FILTRO');
      if VariableIndex('DATALAVORO') < 0 then
        DeclareVariable('DATALAVORO',otDate);

      SetVariable('DATALAVORO',FDataLavoro);
      Open;
    end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.LoadDaSelezione(index: Integer);
begin
  edtUguale.Text:=PSelezione(Componenti.Items[index]).Valore;
  edtDa.Text:=PSelezione(Componenti.Items[index]).DaValore;
  edtA.Text:=PSelezione(Componenti.Items[index]).AValore;
  chkgrpValori.Items.Clear;
  if PSelezione(Componenti.Items[index]).Esistente then
  begin
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[index]).TotValori);
    GetCheck(PSelezione(Componenti.Items[index]).SelValori);
  end;
  chkgrpValori.AsyncUpdate;
end;


procedure TWC700FSelezioneAnagrafeFM.lstAziendaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  //Salvo dati elemento selezionato precedentemente
  SalvaSuSelezione(itemAziendaSelected);

  //carico dati elemento selezionato attualmente
  itemAziendaSelected:=lstAzienda.itemIndex;
  LoadDaSelezione(itemAziendaSelected);
end;

procedure TWC700FSelezioneAnagrafeFM.lstAziendaAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var s: String;
begin
  inherited;
  if lstAzienda.ItemIndex = -1 then exit;
  //salva dati in caso di cambiamento elemento selezionato
  if (itemAziendaSelected <> lstAzienda.ItemIndex) then
    lstAziendaAsyncChange(nil,nil);

  if not PSelezione(Componenti.Items[itemAziendaSelected]).Esistente then
  begin
    //Costruisco la query per estrarre la colonna richiesta
    with WC700DM.selDistinct do
    begin
      Close;
      QueryDinamica(0);
      Open;
      try
        Open;
      except
        GenerazioneSelezione;
        QueryDinamica(0);
        Open;
      end;
      //Riempo la lista con i dati della tabella
      PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.Clear;
      PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.BeginUpdate;
      while not Eof do
      begin
        //BUG TMS in async errore con ""
        //workaround - ini
        s:=StringReplace(Fields[0].AsString, '"', '&quot;', [rfReplaceAll]);
        //workaround - fine
        PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.Add(s);
        Next;
      end;
    end;

    PSelezione(Componenti.Items[itemAziendaSelected]).TotValori.EndUpdate;
    chkgrpValori.Items.Assign(PSelezione(Componenti.Items[itemAziendaSelected]).TotValori);
    PSelezione(Componenti.Items[itemAziendaSelected]).Esistente:=True;
    GetCheck(PSelezione(Componenti.Items[itemAziendaSelected]).SelValori);
  end;

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('ShowBusy(false);');
end;

procedure TWC700FSelezioneAnagrafeFM.lstOrdinamentoAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  lstOrdinamento.Items.Delete(lstOrdinamento.ItemIndex);
  SQLCreato.Clear;
  edtSelezione.Text:='';
end;

procedure TWC700FSelezioneAnagrafeFM.mnuDeselezionaTuttoClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=False;
end;

procedure TWC700FSelezioneAnagrafeFM.mnuInvertiSelezioneClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=not chkgrpValori.Selected[i];
end;

procedure TWC700FSelezioneAnagrafeFM.mnuRicercaCompletaClick(Sender: TObject);
var
  i,j: Integer;
  SelectedItem: String;
  ItemFound: Boolean;

begin
  //salvo selezione corrente e campo corrente
  SalvaSuSelezione(itemAziendaSelected);
  SelectedItem:=lstAzienda.Items[itemAziendaSelected];
  ItemFOund:=False;

  //Salvo le precedenti selezioni <> da null in una lista temporanea
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    j:=0;
    while (j <= High(SelezioneFull) - 1) and (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) do
      inc(j);
    if (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) then
      j:= -1;

    if j >= 0 then
    begin
      SelezioneFull[j].Selezione.DaValore:=PSelezione(Componenti.Items[i]).DaValore;
      SelezioneFull[j].Selezione.AValore:=PSelezione(Componenti.Items[i]).AValore;
      SelezioneFull[j].Selezione.Valore:=PSelezione(Componenti.Items[i]).Valore;
      SelezioneFull[j].Selezione.TotValori.Assign(PSelezione(Componenti.Items[i]).TotValori);
      SelezioneFull[j].Selezione.SelValori.Assign(PSelezione(Componenti.Items[i]).SelValori);
      SelezioneFull[j].Selezione.Esistente:=PSelezione(Componenti.Items[i]).Esistente;
    end;
  end;
  //================================================================

  mnuRicercaCompleta.Checked:=not mnuRicercaCompleta.Checked;
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    if mnuRicercaCompleta.Checked then
      mnuRicercaCompleta.Caption:='Ricerca semplice'
    else
      mnuRicercaCompleta.Caption:='Ricerca completa';
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteasCData('$("#' + pmnRicerca.Name + ' a[href=#' + mnuRicercaCompleta.Name + ']").html("' + mnuRicercaCompleta.Caption + '")');
  end;

  CaricaLstAzienda(mnuRicercaCompleta.Checked);

  //Riassegnazione valori precedentemente impostati
  lstAzienda.OnAsyncChange:=nil;
  for i:=0 to lstAzienda.Items.Count - 1 do
  begin
    j:=0;
    while (j <= High(SelezioneFull) - 1) and (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) do
      inc(j);
    if (SelezioneFull[j].NomeLogico <> lstAzienda.Items[i]) then
      j:= -1;

    if j >= 0 then
    begin
      PSelezione(Componenti.Items[i]).DaValore:=SelezioneFull[j].Selezione.DaValore;
      PSelezione(Componenti.Items[i]).AValore:=SelezioneFull[j].Selezione.AValore;
      PSelezione(Componenti.Items[i]).TotValori.Assign(SelezioneFull[j].Selezione.TotValori);
      PSelezione(Componenti.Items[i]).SelValori.Assign(SelezioneFull[j].Selezione.SelValori);
      PSelezione(Componenti.Items[i]).Esistente:=SelezioneFull[j].Selezione.Esistente;
    end;

    if lstAzienda.Items[i] = SelectedItem then
    begin
      lstAzienda.ItemIndex:=i;
      itemAziendaSelected:=i;
      ItemFound:=True; //da completa a normale l'item selezionato potrebbe non più esistere
    end;
  end;
  if not ItemFound then
  begin
    lstAzienda.ItemIndex:=0;
    itemAziendaSelected:=0;
  end;

  lstAzienda.OnAsyncChange:=lstAziendaAsyncChange;
end;

procedure TWC700FSelezioneAnagrafeFM.mnuSelezionaTuttoClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to chkgrpValori.Items.Count - 1 do
     chkgrpValori.Selected[i]:=True;
end;

procedure TWC700FSelezioneAnagrafeFM.ModificaSelezioneManuale(val: boolean);
begin
  memModificaSelezione.Visible:=val;
  actConfermaSelezioneManuale.Enabled:=val;
  actAnnullaSelezioneManuale.Enabled:=val;
  actConferma.Enabled:=not val;
  actAnnulla.Enabled:=not val;
  actcmbSelezione.Enabled:=not val;
  actSalvaSelezione.Enabled:=not val;
  actApriSelezione.Enabled:=not val;
  actEliminaSelezione.Enabled:=not val;
  actEseguiSelezione.Enabled:=not val;
  actAnnullaSelezione.Enabled:=not val;
  actModificaSelezione.Enabled:=not val;

  if val then
    memModificaSelezione.SetFocus;

  (WC700NavigatorBar as TmedpIWC700NavigatorBar).AggiornaToolBar(grdToolBar, ActionList);
  //(*TWR100FBase(Self.Parent).*)C190AggiornaToolBar(grdToolBar, ActionList);

  lstAzienda.enabled:=not val;

  if val then
  begin
    rdgPeriodoConsiderato.Enabled:=False;
    chkDipendentiCessati.Enabled:=False;
    chkPersonaleEsterno.Enabled:=False;
  end
  else
  begin
    //non posso settare enabled a true, ma devo verificare se consentiti da property
    rdgPeriodoConsiderato.Enabled:=FSelezionePeriodica;
    chkDipendentiCessati.Enabled:=FDipendentiCessati;
    chkPersonaleEsterno.Enabled:=not FPersonaleInterno;
  end;

  btnAggiungiOrdinamento.Enabled:=not val;
  edtUguale.Enabled:=not val;
  edtDa.Enabled:=not val;
  edtA.Enabled:=not val;
  chkgrpValori.Enabled:=not val;
  mnuSelezionaTutto.Enabled:=not val;
  mnuDeselezionaTutto.Enabled:=not val;
  mnuInvertiSelezione.Enabled:=not val;
  lstOrdinamento.Enabled:=not val;
  grdAnteprima.Visible:=not val;
end;

function TWC700FSelezioneAnagrafeFM.PrefissoTabella(Campo: String): String;
{Cerca la tabella di cui fa parte Campo tra T030,T480,V430}
begin
  Result:=AliasTabella(Campo) + '.' + Campo;
end;

procedure TWC700FSelezioneAnagrafeFM.PulisciListaComponenti(var List: Tlist);
var i:Integer;
begin
  for i:=List.Count - 1 downto 0 do
  begin
    PSelezione(List.Items[i]).TotValori.Free;
    PSelezione(List.Items[i]).SelValori.Free;
    Dispose(PSelezione(List.Items[i]));
    List.Delete(i);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.PutCheck(Dest: TStringList);
{Salvo gli Items Checkati in SelValori}
var i:Integer;
begin
  Dest.Clear;
  for i:=0 to chkgrpValori.Items.Count - 1 do
    if chkgrpValori.Selected[i] then
      Dest.Add(chkgrpValori.Items[i]);
end;

procedure TWC700FSelezioneAnagrafeFM.QueryDinamica(Modo: Integer);
var Q : TOracleDataSet;
    S : String;
    i : Integer;
    Filtro,OrderBy:String;

  function GetHintT030V430:String;
  begin
    Result:=IfThen(chkDipendentiCessati.Checked,Parametri.CampiRiferimento.C26_HintT030V430,Parametri.CampiRiferimento.C26_HintT030V430_NC);
  end;
  function GetHintT030V430NoTag:String;
  begin
    Result:=StringReplace(StringReplace(GetHintT030V430,'/*+','',[]),'*/','',[]);
  end;

begin
  CorpoSQL.Clear;
  //Colonne restituite dalla select
  case Modo of
    0:begin
        S:='DISTINCT ' + Parametri.ColonneStruttura.Values[lstAzienda.Items[itemAziendaSelected]];  //Selezione di una colonna specifica
        Q:=WC700DM.selDistinct;
      end;
    1:begin
        S:='MATRICOLA,COGNOME,NOME,T430BADGE,T430INIZIO,T430FINE,PROGRESSIVO';//Dati anagrafici di base
        Q:=WC700DM.selAnagrafe;
      end;
    2:begin
        S:=C700DatiSelezionati;    //Dati anagrafici richiesti
        Q:=WC700DM.selAnagrafe;
      end;
  end;
  with Q do
  begin
    CloseAll;
    //Gestione Query periodica
    if rdgPeriodoConsiderato.Enabled and (rdgPeriodoConsiderato.ItemIndex = 1) then
    begin
      SQL.Assign(ListSQLPeriodico);
      SQL.Delete(0);
      SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430,S]));
      SQL.Text:=StringReplace(SQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      CorpoSQL.Assign(ListSQLPeriodico);
      CorpoSQL.Delete(0);
      CorpoSQL.Text:=StringReplace(CorpoSQL.Text,'HintT030V430',GetHintT030V430NoTag,[rfIgnoreCase,rfReplaceAll]);
      Filtro:='';
      OrderBy:='';
      //Filtro sui soli dipendenti in servizio
      if  (not chkDipendentiCessati.Checked) then
        //Filtro:=Filtro + 'AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO))' + #13#10;
        Filtro:=Filtro + 'AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO)' + #13#10;
      //Alberto: solo personale interno
      if (not chkPersonaleEsterno.Visible) or (not chkPersonaleEsterno.Checked) then
        Filtro:=Filtro + 'AND T030.TIPO_PERSONALE = ''I''' + #13#10;

      if Singolodipendente then
        Filtro:=Filtro + 'AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo) + #13#10;

      with SQLCreato do
        for i:=0 to Count - 1 do
          if Pos('ORDER BY',Strings[i]) = 0 then
          begin
            if i = 0 then
              Filtro:=Filtro + 'AND' + #13#10;
            Filtro:=Filtro + Strings[i] + #13#10;
          end
          else if Modo > 0 then
            OrderBy:=OrderBy + Strings[i] + #13#10
          else Break;
      if Modo = 0 then
        OrderBy:='ORDER BY ' + Parametri.ColonneStruttura.Values[lstAzienda.Items[lstAzienda.ItemIndex]];
      if OrderBy <> '' then
        SQL.Add(OrderBy);
      DeleteVariables;
      DeclareVariable('DATALAVORO',otDate);
      DeclareVariable('C700DATADAL',otDate);
      DeclareVariable('C700FILTRO',otSubst);
      SetVariable('DATALAVORO',FDataLavoro);
      SetVariable('C700DATADAL',FDataDal);
      SetVariable('C700FILTRO',Filtro);
      exit;
    end;

    SQL.Assign(ListSQL);
    SQL.Delete(0);
    SQL.Insert(0,Format('SELECT %s %s FROM',[GetHintT030V430,S]));
    CorpoSQL.Assign(ListSQL);
    CorpoSQL.Delete(0);

    //Filtro sui soli dipendenti in servizio
    if (not chkDipendentiCessati.Checked) then
    begin
      //S:='AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO))';
      S:='AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    //Alberto: solo personale interno
    if (not chkPersonaleEsterno.Visible) or (not chkPersonaleEsterno.Checked) then
    begin
      S:='AND T030.TIPO_PERSONALE = ''I''';
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    if Singolodipendente then
    begin
      S:='AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo);
      SQL.Add(S);
      CorpoSQL.Add(S);
    end;
    with SQLCreato do
      for i:=0 to Count - 1 do
        if Pos('ORDER BY',UpperCase(Trim(Strings[i]))) <> 1 then
        begin
          if i = 0 then
          begin
            SQL.Add('AND');
            CorpoSQL.Add('AND');
          end;
          SQL.Add(Strings[i]);
          CorpoSQL.Add(Strings[i]);
        end
        else if Modo > 0 then SQL.Add(Strings[i])
        else Break;
    if Modo = 0 then
      SQL.Add('ORDER BY ' + Parametri.ColonneStruttura.Values[lstAzienda.items[itemAziendaSelected]]);
    DeleteVariables;
    DeclareVariable('DATALAVORO',otDate);
    SetVariable('DATALAVORO',FDataLavoro);
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.ReleaseOggetti;
var i: Integer;
begin
  PulisciListaComponenti(Componenti);
  PulisciListaComponenti(SaveComponenti);
  Componenti.Free;
  FreeAndNil(SaveComponenti);
  ListSQL.Free;
  SQLCreato.Free;
  CorpoSQL.Free;
  ListSQLPeriodico.Free;
  //Caratto 03/10/2014 gli oggetti per il salvataggio della selezione iniziale
  //vengono correttamente distrutti su conferma e annulla.
  //In caso il frame venga laciato aperto e chiuso il browser, devono essere distrutti anche qui
  if SaveSelAnagrafe <> nil then
    FreeAndNil(SaveSelAnagrafe);

  if SaveSQLCreato <> nil then
    FreeAndNil(SaveSQLCreato);

  if SaveSelAnagrafeODS <> nil then
  FreeAndNil(SaveSelAnagrafeODS);

  for i:=low(SelezioneFull) to High(SelezioneFull) do
  begin
    FreeAndNil(SelezioneFull[i].Selezione.TotValori);
    FreeAndNil(SelezioneFull[i].Selezione.SelValori);
  end;
  SetLength(SelezioneFull,0);

end;

procedure TWC700FSelezioneAnagrafeFM.ResultElimina(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
      begin
        with WC700DM.delT003 do
        begin
          SetVariable('Nome',edtSelezione.Text);
          Execute;
          Session.Commit;
        end;
        A000AggiornaFiltroDizionario('SELEZIONI ANAGRAFICHE',edtSelezione.Text,'');
        edtSelezione.Text:='';
        CaricaListSelezioni;
      end;
    mrNo:  exit;
  end;

end;

procedure TWC700FSelezioneAnagrafeFM.ResultSovrascrivi(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: SalvaSelezione;
    mrNo:  exit;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.EreditaSelezione(SelAnagrafeBridge: TC700SelAnagrafeBridge);
begin
  if SelAnagrafeBridge.SQLCreato = '' then
    exit;
  C700SelezionePeriodica:=SelAnagrafeBridge.SelezionePeriodica;
  C700SelezionePeriodicaVal:=SelAnagrafeBridge.SelezionePeriodicaVal;
  C700PersonaleInterno:=SelAnagrafeBridge.SoloPersonaleInterno;
  C700PersonaleInternoVal:=SelAnagrafeBridge.SoloPersonaleInternoVal;
  C700DipendentiCessati:=SelAnagrafeBridge.AncheDipendentiCessati;
  C700DipendentiCessatiVal:=SelAnagrafeBridge.AncheDipendentiCessatiVal;

 // C700Progressivo:=0;
  SQLCreato.Text:=SelAnagrafeBridge.SQLCreato;
  actConfermaExecute(actConferma);
end;

procedure TWC700FSelezioneAnagrafeFM.C700MergeSelAnagrafe(ODS:TComponent; RicreaVariabili:Boolean = False);
{ODS deve essere un OracleDataSet o OracleQuery con il parametro C700SelAnagrafe di tipo Substitution;
 Viene rimpiazzato il parametro :C700SelAnagrafe con il testo SQL di C700Selanagrafe
 dalla FROM alla ORDER BY escluse.
 Le variabili di ODS vengono integrate con quelle di C700SelAnagrafe (DataLavoro, C700DataDal) cancellando quelle già esistenti o meno a seconda di RicreaVariabili
 Esempio di utilizzo:
 -Subquery-
 ...AND tabella.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)
 -Join-
 SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe //la WHERE è già inserita
 AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2
 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO
 }
var i:Integer;
    S:String;
begin
  if Trim(CorpoSQL.Text) = '' then
  begin
    //Prima volta che si richiama la procedura
    //C700FSelezioneAnagrafe.QueryDinamica(1);
    QueryDinamica(2);
    WC700DM.SelAnagrafe.Open;
  end;
  //Alberto 12/04/2007: gestisco a parte le variabili di tipo Substitution
  S:=CorpoSQL.Text;
  with WC700DM do
    for i:=0 to selAnagrafe.VariableCount - 1 do
      if selAnagrafe.VariableType(i) = otSubst then
        S:=StringReplace(S,selAnagrafe.VariableName(i),selAnagrafe.GetVariable(selAnagrafe.VariableName(i)),[rfIgnoreCase]);

  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery....
    if TOracleQuery(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    TOracleQuery(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleQuery(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700Filtro');
    if TOracleQuery(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleQuery(ODS).DeleteVariable('C700DataDal');
    if RicreaVariabili then
    begin
      TOracleQuery(ODS).DeleteVariables;
      TOracleQuery(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    with WC700DM do
      for i:=0 to selAnagrafe.VariableCount - 1 do
      begin
        if (TOracleQuery(ODS).VariableIndex(selAnagrafe.VariableName(i)) = -1) and
           (selAnagrafe.VariableType(i) <> otSubst) then
        begin
          TOracleQuery(ODS).DeclareVariable(selAnagrafe.VariableName(i),selAnagrafe.VariableType(i));
          TOracleQuery(ODS).SetVariable(selAnagrafe.VariableName(i),selAnagrafe.GetVariable(i));
        end;
      end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('C700SelAnagrafe') = -1 then
      exit;
    TOracleDataSet(ODS).SetVariable('C700SelAnagrafe',S);
    if TOracleDataSet(ODS).VariableIndex('C700Filtro') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700Filtro');
    if TOracleDataSet(ODS).VariableIndex('C700DataDal') >= 0 then
      TOracleDataSet(ODS).DeleteVariable('C700DataDal');
    if RicreaVariabili then
    begin
      TOracleDataSet(ODS).DeleteVariables;
      TOracleDataSet(ODS).DeclareVariable('C700SelAnagrafe',otSubst);
    end;
    with WC700DM do
      //Si riportano tutte le variabili non subst di C700, settandone sempre i valori
      for i:=0 to selAnagrafe.VariableCount - 1 do
      begin
        if (SelAnagrafe.VariableType(i) <> otSubst) then
        begin
          if (TOracleDataSet(ODS).VariableIndex(selAnagrafe.VariableName(i)) = -1) then
            TOracleDataSet(ODS).DeclareVariable(selAnagrafe.VariableName(i),selAnagrafe.VariableType(i));
          TOracleDataSet(ODS).SetVariable(selAnagrafe.VariableName(i),selAnagrafe.GetVariable(i));
        end;
      end;
  end;
end;

function TWC700FSelezioneAnagrafeFM.C700MergeSettaPeriodo(ODS:TComponent; DataDal,DataLavoro:TDateTime):Boolean;
{ODS deve essere un OracleDataSet o OracleQuery}
begin
  Result:=False;
  if ODS is TOracleQuery then
  begin
    //Se ODS è OracleQuery...
    if TOracleQuery(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleQuery(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleQuery(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleQuery(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleQuery(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleQuery(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end
  else
  begin
    //Se ODS è OracleDataSet...
    if TOracleDataSet(ODS).VariableIndex('DATALAVORO') >= 0 then
      if TOracleDataSet(ODS).GetVariable('DATALAVORO') <> DataLavoro then
      begin
        TOracleDataSet(ODS).SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if TOracleDataSet(ODS).VariableIndex('C700DATADAL') >= 0 then
      if TOracleDataSet(ODS).GetVariable('C700DATADAL') <> DataDal then
      begin
        TOracleDataSet(ODS).SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end;
end;

function TWC700FSelezioneAnagrafeFM.C700SettaPeriodoSelAnagrafe(DataDal,
  DataLavoro: TDateTime): Boolean;
begin
  with WC700DM do
  begin
    Result:=False;
    if SelAnagrafe.VariableIndex('DATALAVORO') >= 0 then
      if SelAnagrafe.GetVariable('DATALAVORO') <> DataLavoro then
      begin
        SelAnagrafe.SetVariable('DATALAVORO',DataLavoro);
        Result:=True;
      end;
    if SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
      if SelAnagrafe.GetVariable('C700DATADAL') <> DataDal then
      begin
        SelAnagrafe.SetVariable('C700DATADAL',DataDal);
        Result:=True;
      end;
  end;
end;

procedure TWC700FSelezioneAnagrafeFM.ApriSelezione(Selezione:String);
begin
  edtSelezione.Text:=Selezione;
  actApriSelezioneExecute(actApriSelezione);
end;

procedure TWC700FSelezioneAnagrafeFM.SetSelezionePeriodica(val: boolean);
begin
  FSelezionePeriodica:=val;
  rdgPeriodoConsiderato.Enabled:=FSelezionePeriodica;
  if (FSelezionePeriodica) then
    rdgPeriodoConsiderato.ItemIndex:=0;
end;

procedure TWC700FSelezioneAnagrafeFM.setSelezionePeriodicaVal(const Value: Integer);
begin
  FSelezionePeriodicaVal:=Value;
  if (FSelezionePeriodica) then
    rdgPeriodoConsiderato.ItemIndex:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.setPersonaleInterno(const Value: Boolean);
begin
  FPersonaleInterno:=Value;
  chkPersonaleEsterno.Enabled:=not FPersonaleInterno;
end;

procedure TWC700FSelezioneAnagrafeFM.setPersonaleInternoVal(  const Value: Boolean);
begin
  FPersonaleInternoVal:=Value;
  chkPersonaleEsterno.Checked:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.setDipendiCessati(const Value: Boolean);
begin
  FDipendentiCessati:=Value;
  chkDipendentiCessati.Enabled:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.setDipendiCessatiVal(const Value: Boolean);
begin
  FDipendentiCessatiVal:=Value;
  chkDipendentiCessati.Checked:=Value;
end;

procedure TWC700FSelezioneAnagrafeFM.CreaSelezioneTotale;
begin
  CreaSave;
  CopiaListaComp(Componenti,SaveComponenti);
  SvuotaSelezione(actAnnullaSelezione);
  actEseguiSelezioneExecute(nil);
end;

procedure TWC700FSelezioneAnagrafeFM.RipristinaSelezione;
begin
  actAnnullaExecute(nil);
end;

end.

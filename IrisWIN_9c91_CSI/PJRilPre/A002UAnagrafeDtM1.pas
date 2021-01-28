unit A002UAnagrafeDtM1;

interface

uses
  Windows,Messages,SysUtils,StrUtils,Classes,Graphics,Controls,Forms,Dialogs, ComCtrls,
  StdCtrls, DBCtrls, QueryStorico, A002UAnagrafeVista, A002UAnagrafeVistaPadre,
  A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, C700USelezioneAnagrafe, L021Call,
  RegistrazioneLog, OracleData, Oracle, USelI010,
  (*Midaslib,*)Db, Variants, Math, A002UAnagrafeMW, A000UMessaggi, A099UUtilityDBMW;

const DataFine = '31/12/3999';
      DataBase = '01/01/1900';
      NumTabelle = 15;
      //{$I L000ParametriClienti}
type
  //Informazioni sui dati liberi
  DatoLibero = record
    NomeTabella:String;
    Storico:String;
    Query:TOracleDataSet;
    Sorgente:TDataSource;
    IntCampo:TLabel;
    LCampo:TDBText;
    ECampo:TDBLookupComboBox;
    ECampo2:TDBEdit;
  end;
  //Contiene i nomi delle tabelle individuali per la cancellazione del dipendente
  TTabIndividuali = record
    N,P:String
  end;
  //Contiene l'elenco dei campi della QVista con DisplayLabel, DispalyWidth, Visible
  TQVistaFields = record
    FieldName,DisplayLabel:String;
    DisplayWidth,Index:Word;
    Visible:Boolean;
  end;

  TA002FAnagrafeDtM1 = class(TDataModule)
    D030: TDataSource;
    D480: TDataSource;
    D430: TDataSource;
    DQVista: TDataSource;
    T480: TOracleDataSet;
    OperSQL: TOracleQuery;
    Q030Count: TOracleQuery;
    Q034: TOracleDataSet;
    InsQ034: TOracleQuery;
    QVista: TOracleDataSet;
    Q030: TOracleDataSet;
    Q030MATRICOLA: TStringField;
    Q030PROGRESSIVO: TFloatField;
    Q030COGNOME: TStringField;
    Q030NOME: TStringField;
    Q030SESSO: TStringField;
    Q030DATANAS: TDateTimeField;
    Q030COMUNENAS: TStringField;
    Q030CAPNAS: TStringField;
    Q030CODFISCALE: TStringField;
    Q030INIZIOSERVIZIO: TDateTimeField;
    Q030DescComune: TStringField;
    Q030D_Cap: TStringField;
    Q030NomeCognome: TStringField;
    Q030D_CodCatastale: TStringField;
    Q430: TOracleDataSet;
    Q430DATADECORRENZA: TDateTimeField;
    Q430DATAFINE: TDateTimeField;
    Q430EDBADGE: TStringField;
    Q430INDIRIZZO: TStringField;
    Q430COMUNE: TStringField;
    Q430CAP: TStringField;
    Q430TELEFONO: TStringField;
    Q430INIZIO: TDateTimeField;
    Q430FINE: TDateTimeField;
    Q430SQUADRA: TStringField;
    Q430TIPOOPE: TStringField;
    Q430TERMINALI: TStringField;
    Q430CAUSSTRAORD: TStringField;
    Q430STRAORDE: TStringField;
    Q430STRAORDU: TStringField;
    Q430STRAORDEU: TStringField;
    Q430CONTRATTO: TStringField;
    Q430ORARIO: TStringField;
    Q430HTEORICHE: TStringField;
    Q430PERSELASTICO: TStringField;
    Q430TGESTIONE: TStringField;
    Q430PLUSORA: TStringField;
    Q430CALENDARIO: TStringField;
    Q430IPRESENZA: TStringField;
    Q430PORARIO: TStringField;
    Q430PASSENZE: TStringField;
    Q430ABCAUSALE1: TStringField;
    Q430ABPRESENZA1: TStringField;
    Q430TIPORAPPORTO: TStringField;
    Q430PARTTIME: TStringField;
    Q430STRAORDEU2: TStringField;
    Q430D_Comune: TStringField;
    Q430D_Cap: TStringField;
    Q430D_Provincia: TStringField;
    Q430D_Squadra: TStringField;
    Q430D_Contratto: TStringField;
    Q430D_TIPOCART: TStringField;
    Q430D_PlusOra: TStringField;
    Q430D_Calendario: TStringField;
    Q430D_IPresenza: TStringField;
    Q430D_POrario: TStringField;
    Q430D_PAssenze: TStringField;
    Q430D_TipoRapporto: TStringField;
    Q430D_PartTime: TStringField;
    Q430PROGRESSIVO: TFloatField;
    Q430BADGE: TFloatField;
    Q430B: TOracleDataSet;
    Q430BDATADECORRENZA2: TDateTimeField;
    Q430BDATAFINE2: TDateTimeField;
    Q430BEDBADGE2: TStringField;
    Q430BINDIRIZZO2: TStringField;
    Q430BCOMUNE2: TStringField;
    Q430BCAP2: TStringField;
    Q430BTELEFONO2: TStringField;
    Q430BINIZIO2: TDateTimeField;
    Q430BFINE2: TDateTimeField;
    Q430BSQUADRA2: TStringField;
    Q430BTIPOOPE2: TStringField;
    Q430BTERMINALI2: TStringField;
    Q430BCAUSSTRAORD2: TStringField;
    Q430BSTRAORDE2: TStringField;
    Q430BSTRAORDU2: TStringField;
    Q430BSTRAORDEU3: TStringField;
    Q430BCONTRATTO2: TStringField;
    Q430BORARIO2: TStringField;
    Q430BHTEORICHE2: TStringField;
    Q430BPERSELASTICO2: TStringField;
    Q430BTGESTIONE2: TStringField;
    Q430BPLUSORA2: TStringField;
    Q430BCALENDARIO2: TStringField;
    Q430BIPRESENZA2: TStringField;
    Q430BPORARIO2: TStringField;
    Q430BPASSENZE2: TStringField;
    Q430BABCAUSALE12: TStringField;
    Q430BABPRESENZA12: TStringField;
    Q430BTIPORAPPORTO2: TStringField;
    Q430BPARTTIME2: TStringField;
    Q430BSTRAORDEU22: TStringField;
    Q430BPROGRESSIVO: TFloatField;
    Q430BBADGE: TFloatField;
    T480CODICE: TStringField;
    T480CITTA: TStringField;
    T480CAP: TStringField;
    T480PROVINCIA: TStringField;
    T480CODCATASTALE: TStringField;
    InsQ033: TOracleQuery;
    Q033B: TOracleDataSet;
    Q033BTOP: TFloatField;
    Q033BLFT: TFloatField;
    Q033BCAPTION: TStringField;
    Q033BACCESSO: TStringField;
    Q033BNOMEPAGINA: TStringField;
    Q033BCAMPODB: TStringField;
    Q033: TOracleDataSet;
    sel070: TOracleDataSet;
    selT033: TOracleDataSet;
    Q030D_ProvinciaNas: TStringField;
    selaT033: TOracleDataSet;
    Q030RAPPORTI_UNITI: TStringField;
    selT432: TOracleDataSet;
    Q033BROWNUM: TFloatField;
    updDec: TOracleQuery;
    Q430DOCENTE: TStringField;
    Q030TIPO_PERSONALE: TStringField;
    Q430QUALIFICAMINIST: TStringField;
    Q430TIPO_LOCALITA_DIST_LAVORO: TStringField;
    Q430COD_LOCALITA_DIST_LAVORO: TStringField;
    Q430D_QUALIFICAMINIST: TStringField;
    Q430D_COD_LOCALITA_DIST_LAVORO: TStringField;
    selLocalita: TOracleDataSet;
    DselLocalita: TDataSource;
    Q430BDOCENTE: TStringField;
    Q430BQUALIFICAMINIST: TStringField;
    Q430BTIPO_LOCALITA_DIST_LAVORO: TStringField;
    Q430BCOD_LOCALITA_DIST_LAVORO: TStringField;
    selP430: TOracleDataSet;
    Q430INIZIO_IND_MAT: TDateTimeField;
    Q430FINE_IND_MAT: TDateTimeField;
    Q430BINIZIO_IND_MAT: TDateTimeField;
    Q430BFINE_IND_MAT: TDateTimeField;
    selI050: TOracleDataSet;
    Q430MEDICINA_LEGALE: TStringField;
    Q430D_MEDICINA_LEGALE: TStringField;
    Q430BMEDICINA_LEGALE: TStringField;
    Q030I060EMAIL: TStringField;
    Q430INDIRIZZO_DOM_BASE: TStringField;
    Q430COMUNE_DOM_BASE: TStringField;
    Q430CAP_DOM_BASE: TStringField;
    Q430D_COMUNE_DOM_BASE: TStringField;
    Q430D_CAP_DOM_BASE: TStringField;
    Q430D_PROVINCIA_DOM_BASE: TStringField;
    Q430BINDIRIZZO_DOM_BASE: TStringField;
    Q430BCOMUNE_DOM_BASE: TStringField;
    Q430BCAP_DOM_BASE: TStringField;
    procedure Q030NewRecord(DataSet: TDataSet);
    procedure Q030AfterInsert(DataSet: TDataSet);
    procedure Q030AfterCancel(DataSet: TDataSet);
    procedure Q030BeforePost(DataSet: TDataSet);
    procedure T430DataFineGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure D030StateChange(Sender: TObject);
    procedure A002FAnagrafeDtM1Create(Sender: TObject);
    procedure Q030CalcFields(DataSet: TDataSet);
    procedure Q430StringField27Validate(Sender: TField);
    procedure Q430BFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure A002FAnagrafeDtM1Destroy(Sender: TObject);
    procedure Q030AfterDelete(DataSet: TDataSet);
    procedure Q030AfterPost(DataSet: TDataSet);
    procedure Q010AfterOpen(DataSet: TDataSet);
    procedure Q030BeforeInsert(DataSet: TDataSet);
    procedure Q030BeforeEdit(DataSet: TDataSet);
    procedure Q430AfterFetchRecord(Sender: TOracleDataSet;
      FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
    procedure D430DataChange(Sender: TObject; Field: TField);
    procedure QVistaAfterScroll(DataSet: TDataSet);
    procedure Q430BeforeInsert(DataSet: TDataSet);
    procedure Q430AfterInsert(DataSet: TDataSet);
    procedure Q430BeforeEdit(DataSet: TDataSet);
    procedure Q430AfterOpen(DataSet: TDataSet);
    procedure Q430AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    CreazioneDataModule,IntegrazioneOut,AllineaCessazione,EseguiRelazioni:Boolean;
    OldInizio,OldFine,OldDataFine:TDateTime;
    ModificaStoricizzata:String;
    NomiTabelle:array of String;
    RelFiltrate:Boolean;
    procedure settaListSource;
    procedure EliminaB005B007;
    procedure CreaDatiLiberi;
    procedure Relaziona(Prog:LongInt; DataLav:TDateTime);
    procedure InizializzaDatiLiberi;
    (*
    procedure CostruisciV430;
    procedure PreparaIndiciV430Materializzata;
    procedure CreaIndiciV430Materializzata;
    *)
    procedure AggiornamentoStoriciPrecSucc(Data:TDateTime; Tipo:String);
    procedure DistruggiDatiLiberi;
    procedure AggiornaCdCPercentualizzati;
  public
    { Public declarations }
    A002FAnagrafeMW:TA002FAnagrafeMW;
    TuttoStorico:(tsTutto,tsPrima,tsDopo); {tipo di filtro su archivio T430_Storico}
    Inserimento,StoricizzazioneInCorso:Boolean; {True:inserisco nuovi storici False:storicizzo dati}
    Decor:TDateTime; {Contiene la decorrenza del dato}
    ProgOperDM,OrderString,SelectString:String;
    ListSQL,ListaAssenze,ListaPresenze:TStringList;
    DatiLiberi: array of DatoLibero;
    QVistaFields:array of TQVistaFields;
    AbilAnagra:(aaReadWrite,aaReadOnly,aaNone);
    QI010:TselI010;
    OldTipoRapporto,NewTipoRapporto:String;
    procedure RinfrescaQueryDescrizioni(DataDec: TDateTime);
    procedure CaricaGriglia;
    procedure EsegueVista;
    procedure QueryAnagrafeStorico;
    procedure OrdinaAnagrafe(Campo:String);
    procedure CercaAnagrafe;
    procedure RicostruisciAnagrafico;
    procedure AperturaDatabase;
    procedure ActiveDatiLiberi(Active:Boolean);
    procedure GetIntegrazione;
    procedure ChiamaStorico(Prog:Integer; Data:TDateTime);
    procedure CaricaTVAzienda(Completa:Boolean);
    procedure GetColonneStruttura(CreaCampi:Boolean);
    procedure GetDateDecorrenza;
    procedure RegistraQVistaFields;
    procedure ApplicaQVistaFields;
    procedure RefreshLookupCache(ds:TDataSet);
    procedure RefreshFiltro(Sender: TField);
    procedure AllineaDataFine;
  end;

const
  TabIndividuali:array [0..14] of TTabIndividuali =
        ((N:'T012_CALENDINDIVID';P:'PROGRESSIVO'),
         (N:'T040_GIUSTIFICATIVI';P:'PROGRESSIVO'),
         (N:'T070_SCHEDARIEPIL';P:'PROGRESSIVO'),
         (N:'T071_SCHEDAFASCE';P:'PROGRESSIVO'),
         (N:'T072_SCHEDAINDPRES';P:'PROGRESSIVO'),
         (N:'T073_SCHEDACAUSPRES';P:'PROGRESSIVO'),
         (N:'T074_CAUSPRESFASCE';P:'PROGRESSIVO'),
         (N:'T080_PIANIFORARI';P:'PROGRESSIVO'),
         (N:'T090_PLUSORAINDIV';P:'PROGRESSIVO'),
         (N:'T100_TIMBRATURE';P:'PROGRESSIVO'),
         (N:'T130_RESIDANNOPREC';P:'PROGRESSIVO'),
         (N:'T131_RESIDUIFASCE';P:'PROGRESSIVO'),
         (N:'T263_PROFASSIND';P:'PROGRESSIVO'),
         (N:'T264_RESIDASSANN';P:'PROGRESSIVO'),
         (N:'T430_STORICO';P:'PROGRESSIVO'));

var
  A002FAnagrafeDtM1: TA002FAnagrafeDtM1;

implementation

uses A002UAnagrafeGest, C001URicerca, A002UBadgeMsg, A002ULayout;

{$R *.DFM}

procedure TA002FAnagrafeDtM1.A002FAnagrafeDtM1Create(Sender: TObject);
{Apertura degli archivi, imposto Operatore Occupato}
var i:Integer;
begin

  EliminaB005B007;
  DataBaseDrv:=dbOracle;
  SolaLetturaOriginale:=True;
  EseguiRelazioni:=True;
  OldDataFine:=-1;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  A000ParamDBOracle(SessioneOracle);
  if VersioneDimostrativa then
    with A002FAnagrafeDtM1.Q030Count do
    begin
      Execute;
      if Field(0) > 40 then
      begin
        ShowMessage('Questa è una versione dimostrativa: ' + #13 + 'è stato superato il numero di dipendenti disponibili!');
        Application.Terminate;
        exit;
      end;
    end;

  if FALSE THEN
  BEGIN
  if (Parametri.VersioneDB <> '') and (Parametri.VersionePJ <> Parametri.VersioneDB) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Parametri.VersioneDB,Parametri.VersionePJ]) + #13 +
                 'E'' necessario allineare la propria postazione di lavoro alla versione del database.' + #13 +
                 'Se il problema persiste contattare l''amministratore di sistema.');
    Application.Terminate;
    exit;
  end;
  selI050.SetVariable('NOME',ScriptSQLPA);
  selI050.Open;
  if (Parametri.VersioneDB <> '') and (Parametri.BuildPJ <> '0') and (UpperCase(selI050.FieldByName('NOME').AsString) <> UpperCase(ScriptSQLPA)) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione in uso richiede l''esecuzione dello script ''%s''',[ScriptSQLPA]) + #13 +
                 'Contattare l''amministratore di sistema per aggiornare correttamente il database.');
    if (Parametri.Azienda <> 'TESTR') and (Parametri.Operatore <> 'SYSMAN') and (Parametri.Operatore <> 'MONDOEDP') then
    begin
      Application.Terminate;
      exit;
    end;
  end;
  selI050.Close;
  END;

  RegistraLog.SettaProprieta('A','','A002',nil,True);
  RegistraLog.InserisciDato('APPLICATIVO','',UpperCase(ExtractFileName(Application.ExeName)));
  RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
  RegistraLog.InserisciDato('TIPO','','ACCESSO');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;

  //Alberto 16/04/2013: verifica esistenza V430
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Text:='select T430PROGRESSIVO from V430_STORICO where T430PROGRESSIVO = -1';
    try
      Open;
    except
      with TA099FUtilityDBMW.Create(nil) do
      try
        CostruisciV430;
      finally
        Free;
      end;
    end;
    Close;
  finally
    Free;
  end;

  if FALSE THEN
  BEGIN
  if Parametri.VersioneDB <> '' then
  begin
    if StrToIntDef(Parametri.BuildPJ,0) > StrToIntDef(Parametri.BuildDB,0) then
    begin
      if Parametri.Operatore <> 'MONDOEDP' then
        with TOracleQuery.Create(nil) do
        try
          Session:=SessioneOracle;
          SQL.Add('UPDATE MONDOEDP.I090_ENTI SET PATCHDB = ' + Parametri.BuildPJ + ' WHERE AZIENDA = ''' + Parametri.Azienda + '''');
          try
            Execute;
            SessioneOracle.Commit;
          except
          end;
        finally
          Free;
        end;
    end
    else if StrToIntDef(Parametri.BuildPJ,0) < StrToIntDef(Parametri.BuildDB,0) then
      ShowMessage('Attenzione! Si sta utilizzando una patch non aggiornata,' + #13 +
                   'potrebbero verificarsi comportamenti inattesi.' + #13 +
                   'Contattare l''amministratore dell''applicativo.');
  end;
  END;

  //Imposto le inibizioni sulle funzioni
  A002FAnagrafeVista.InibizioniFunzioni;
  ProgOperDM:=IntToStr(Parametri.ProgOper);
  SetLength(NomiTabelle,NumTabelle + 1);
  NomiTabelle[1]:='T480_COMUNI';
  NomiTabelle[2]:='T600_SQUADRE';
  NomiTabelle[3]:='T200_CONTRATTI';
  NomiTabelle[4]:='T060_PLUSORARIO';
  NomiTabelle[5]:='T010_CALENDIMPOSTAZ';
  NomiTabelle[6]:='T163_CODICIINDENNITA';
  NomiTabelle[7]:='T220_PROFILIORARI';
  NomiTabelle[8]:='T261_DESCPROFASS';
  NomiTabelle[9]:='T265_CAUASSENZE';
  NomiTabelle[10]:='T270_RAGGRPRESENZE';
  NomiTabelle[11]:='T025_CONTMENSILI';
  NomiTabelle[12]:='T450_TIPORAPPORTO';
  NomiTabelle[13]:='T460_PARTTIME';
  NomiTabelle[14]:='T470_QUALIFICAMINIST';
  NomiTabelle[15]:='T485_MEDICINELEGALI';
  CreazioneDataModule:=True;
  //OrderString:='';
  //SelectString:='';
  //SelectString:='AND PROGRESSIVO = 0';
  A002FAnagrafeMW:=TA002FAnagrafeMW.Create(Self);
  A002FAnagrafeMW.selT030_Funzioni:=Q030;
  A002FAnagrafeMW.selT430_Funzioni:=Q430;
  A002FAnagrafeMW.selT430OldValues.SetDataSet(Q430);

  ListSQL:=TStringList.Create;
  ListaAssenze:=TStringList.Create;
  ListaPresenze:=TStringList.Create;
  with A002FAnagrafeVista do
  begin
    Azienda:=Parametri.Azienda;
    Operatore:=Parametri.Operatore;
    Caption:=Caption + Format(' %s %s (%s)',[Azienda,Operatore,Parametri.Database]);
    if VersioneDimostrativa then
      Caption:=Caption + ' - VERSIONE DIMOSTRATIVA'
    else
      Caption:=Caption + ' - ' + Parametri.RagioneSociale;
    A002FAnagrafeGest.Caption:='<A002> Scheda anagrafica';
    R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
    selT432.Open;
    if not selT432.FieldByName('DATA').IsNull then
    begin
      Parametri.DataLavoro:=selT432.FieldByName('DATA').AsDateTime;
      DataLavoro:=Parametri.DataLavoro;
      StatusBar.Panels[2].Text:='Data di lavoro:' + FormatDateTime('dd/mm/yyyy',DataLavoro);
    end;
    selT432.Close;
  end;
  //Imposto layout della scheda anagrafica
  selaT033.Open;
  //A000GetLayout(A000SessioneIrisWIN); //Alberto: Già letto su A001UPasswordDtM1
  //Controllo inibizione su anagrafico
  QI010:=TselI010.Create(Self);
  QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','RICERCA,NOME_LOGICO');
  if Parametri.CampiRiferimento.C26_HintT030V430 <> '' then
    QVista.SQL.Text:=StringReplace(QVista.SQL.Text,'SELECT T030.*',Format('SELECT %s T030.*',[Parametri.CampiRiferimento.C26_HintT030V430]),[rfIgnoreCase]);
  AperturaDatabase;
  if AbilAnagra <> aaNone then
  begin
    //AperturaDatabase;
    //QI010:=TselI010.Create(Self);
    //QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','RICERCA,NOME_LOGICO');
    //SetVariable('APPLICAZIONE',Parametri.Applicazione);
    EsegueVista;
  end;
  with A002FAnagrafeMW.selT265 do
    while not Eof do
    begin
      ListaAssenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  with A002FAnagrafeMW.selT270 do
    while not Eof do
    begin
      ListaPresenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  settaListSource;
end;

procedure TA002FAnagrafeDtM1.settaListSource;
begin
  A002FAnagrafeGest.ECalendario.ListSource:=A002FAnagrafeMW.dsrT010;
  A002FAnagrafeGest.EPOrario.ListSource:=A002FAnagrafeMW.dsrT220;
  A002FAnagrafeGest.EPAssenze.ListSource:=A002FAnagrafeMW.dsrT261;
  A002FAnagrafeGest.ETipoCart.ListSource:=A002FAnagrafeMW.dsrT025;
  A002FAnagrafeGest.ESquadra.ListSource:=A002FAnagrafeMW.dsrT600;
  A002FAnagrafeGest.dcmbMedicinaLegale.ListSource:=A002FAnagrafeMW.dsrT485;
  A002FAnagrafeGest.dcmbQualificaMinisteriale.ListSource:=A002FAnagrafeMW.dsrT470;
  A002FAnagrafeGest.EParttime.ListSource:=A002FAnagrafeMW.dsrT460;
  A002FAnagrafeGest.ETipoRapp.ListSource:=A002FAnagrafeMW.dsrT450;
  A002FAnagrafeGest.EContratto.ListSource:=A002FAnagrafeMW.dsrT200;
  A002FAnagrafeGest.EIPresenza.ListSource:=A002FAnagrafeMW.dsrT163;
  A002FAnagrafeGest.EPlusOra.ListSource:=A002FAnagrafeMW.dsrT060;
end;

procedure TA002FAnagrafeDtM1.EliminaB005B007;
{Eliminazione del B005 ante-23/09/2010 e del B007 per evitare accessi non consentiti}
var F:TSearchRec;
begin
  try
    if FindFirst('B005PAggIris.exe',faAnyFile,F) = 0 then
    begin
      if F.TimeStamp <= EncodeDate(2010,9,23) then
        DeleteFile('B005PAggIris.exe');
    end;
    FindClose(F);
  except
  end;
  try
    if FindFirst('B007PManipolazioneDati.exe',faAnyFile,F) = 0 then
      DeleteFile('B007PManipolazioneDati.exe');
    FindClose(F);
  except
  end;
end;

procedure TA002FAnagrafeDtM1.AperturaDatabase;
{Stabilisco la connessione col database e apro le tabelle richieste}
begin

  with A002FAnagrafeMW do
  begin
    selT010.Open;
    selT025.Open;
    selT060.Open;
    selT163.Open;
    selT200.Open;
    selT220.Open;
    selT261.Open;
    selT265.Open;
    selT270.Open;
    selT450.Open;
    selT460.Open;
    selT470.Open;
    selT485.Open;
    selT600.Open;
    selT033_campoDecode.Close;
    selT033_campoDecode.SetVariable('Nome',Parametri.Layout);
    selT033_campoDecode.Open;
    selI030.Open;
    selI035.Open;
    RefreshVSQLAppoggio;

  end;

  T480.Open;

  SelLocalita.Open;

end;


procedure TA002FAnagrafeDtM1.RefreshLookupCache(ds:TDataSet);
var i:Integer;
begin
  for i:=0 to Q030.FieldCount - 1 do
    if (Q030.Fields[i].FieldKind = fkLookup) and (Q030.Fields[i].LookupDataSet = ds) then
      Q030.Fields[i].RefreshLookupList;
  for i:=0 to Q430.FieldCount - 1 do
    if (Q430.Fields[i].FieldKind = fkLookup) and (Q430.Fields[i].LookupDataSet = ds) then
      Q430.Fields[i].RefreshLookupList;
end;

procedure TA002FAnagrafeDtM1.EsegueVista;
{Crea gli eventuali controlli dei campi liberi
 Esegue la Query per estrarre i dati Anagrafici + Storici con descrizioni}
begin
  {Eseguo la creazione dati liberi solo una volta all'inizio
  dell'esecuzione}
  if CreazioneDataModule then
    CreaDatiLiberi;
  //Creo Vista dei dati anagrafici
  //QueryAnagrafeStorico;
end;

procedure TA002FAnagrafeDtM1.GetIntegrazione;
begin
end;

procedure TA002FAnagrafeDtM1.RicostruisciAnagrafico;
begin
  Screen.Cursor:=crHourGlass;
  try
    CreazioneDataModule:=True;
    InizializzaDatiLiberi;
    CreaDatiLiberi;
    try
      //A099FUtilityDBMW.CostruisciV430;
    except
      on E:Exception do
        raise Exception.Create('Creazione V430_STORICO fallita!' + #13#10 + E.Message);
    end;
    if AbilAnagra <> aaNone then
    begin
      A002FLayout.Inizializza;
      QueryAnagrafeStorico;
      A002FLayout.Attivazione;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA002FAnagrafeDtM1.InizializzaDatiLiberi;
{Dealloca le risorse utilizzate per i dati liberi}
begin
  QVista.CloseAll;
  Q030.CloseAll;
  Q430.CloseAll;
  Q430B.CloseAll;
  AperturaDatabase;
  DistruggiDatiLiberi;
end;

procedure TA002FAnagrafeDtM1.DistruggiDatiLiberi;
var i:Integer;
begin
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    with DatiLiberi[i] do
      if Assigned(IntCampo) then
        try
        IntCampo.Free;
        if ECampo = nil then
          begin
          Q430.FieldByName(ECampo2.DataField).Free;
          Q430B.FieldByName(ECampo2.DataField).Free;
          ECampo2.Free;
          end
        else
          begin
          Q430.FieldByName(ECampo.DataField).Free;
          Q430B.FieldByName(ECampo.DataField).Free;
          Q430.FieldByName(LCampo.DataField).Free;
          ECampo.Free;
          LCampo.Free;
          Query.Close;
          end;
        NomeTabella:='';
        Query.Free;
        Sorgente.Free;
        except
          R180AppendFile('IrisWIN.log','IntCampo.Free ' + IntToStr(i));
        end;
  SetLength(DatiLiberi,0);
end;

procedure TA002FAnagrafeDtM1.CreaDatiLiberi;
{Scorro I500 e creo Query e DataSource corrispondenti per
ciascun dato;
creo i campi persistenti del dato Codice e della descrizione (Lookup)
Creo i componenti visuali Label,DBLookupComboBox e DBText}
var NomeCampo:String;
    NDatiLiberi,Dimensione,Offset,PLeft:Word;
    Parente:TTabSheet;
begin
  //Creo i campi persistenti sia per Q430 che Q430B
  //(per visualizzazione storici)
  Q430.FieldDefs.Update;
  Q430B.FieldDefs.Update;
  SetLength(DatiLiberi,0);
  with A002FAnagrafeMW.selI500 do
  begin
    NDatiLiberi:=0;
    Close;
    Open;
    if RecordCount = 0 then exit;
    First;
    while not Eof do
      begin
      Inc(NDatiLiberi);
      SetLength(NomiTabelle,NumTabelle + NDatiLiberi + 1);
      SetLength(A002FAnagrafeVista.Storico,NumStorici + NDatiLiberi + 1);
      SetLength(DatiLiberi,NDatiLiberi + 1);
      // Appoggio momentaneamente i dati sulla 3° videata di dati fissi
      Parente:=A002FAnagrafeGest.TabSheet3;
      Offset:=8;
      Dimensione:=0;
      PLeft:=Parente.Width div 2;
      NomeCampo:=FieldByName('NomeCampo').AsString;
      //Se è un dato tabellare costruisco la query associata
      if FieldByName('Tabella').AsString = 'S' then
        with DatiLiberi[NDatiLiberi] do
          begin
          {Creo Query associata al dato libero}
          NomeTabella:='I501'+NomeCampo;
          Storico:=FieldByName('STORICO').AsString;
          Query:=TOracleDataSet.Create(nil);
          Query.Name:='Q501'+NomeCampo;
          Query.Session:=SessioneOracle;
          Query.ReadBuffer:=100;
          Query.AfterOpen:=Q010AfterOpen;
          Query.OnFilterRecord:=nil;
          Query.Filtered:=False;
          Query.SQL.Clear;
          Query.DeleteVariables;
          //Se il dato libero è storicizzato filtro max di data decorrenza
          if FieldByName('STORICO').AsString = 'S' then
          begin
            Query.SQL.Add('select * from ' + NomeTabella + ' T1 where :DATA between DECORRENZA and DECORRENZA_FINE');
            //Query.SQL.Add('SELECT * FROM ' + NomeTabella + ' T1 WHERE DECORRENZA = ');
            //Query.SQL.Add('(SELECT MAX(DECORRENZA) FROM ' + NomeTabella + ' WHERE CODICE = T1.CODICE AND DECORRENZA <= :Data)');
            Query.SQL.Add(' order by CODICE');
            Query.DeclareVariable('Data',otDate);
            Query.SetVariable('Data',Parametri.DataLavoro);
          end
          else
            Query.SQL.Add('select * from ' + NomeTabella + ' order by CODICE');
          Query.Open;
          //Creo data source associato alla tabella
          Sorgente:=TDataSource.Create(nil);
          Sorgente.Name:='D501'+NomeCampo;
          Sorgente.DataSet:=Query;
          end
      else
        DatiLiberi[NDatiLiberi].Query:=nil;
      //Creo il campo persistente associato al dato libero con indice = al progressivo dato libero
      if FieldByName('Formato').AsString = 'S' then
      begin
        with TStringField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          Size:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          //if (FieldByName('Riferimento').AsString = 'S') or (FieldByName('Riferimento').AsString = 'L') then //Lorena 17/05/2005
          //  OnValidate:=CampiCollegati;
          //Required:=DatiLiberi[NDatiLiberi].Storico = 'S';
        end;
        //Creo lo stesso campo anche per Q430B
        with TStringField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Size:=FieldByName('Lunghezza').AsInteger;
          Dimensione:=Size;
          DataSet:=Q430B;
        end;
      end
      else if FieldByName('Formato').AsString = 'D' then
      begin
        with TDateTimeField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          DisplayFormat:='dd/mm/yyyy';
          EditMask:='!00/00/0000;1;_';
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          //Required:=DatiLiberi[NDatiLiberi].Storico = 'S';
        end;
        //Creo lo stesso campo anche per Q430B
        with TDateTimeField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Dimensione:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430B;
        end;
      end
      else if FieldByName('Formato').AsString = 'N' then
      begin
        with TFloatField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430.Name + FieldName;
          DataSet:=Q430;
          Index:=NumStorici + 2 + NDatiLiberi;
          //Required:=DatiLiberi[NDatiLiberi].Storico = 'S';
        end;
        //Creo lo stesso campo anche per Q430B
        with TFloatField.Create(nil) do
        begin
          FieldName:=NomeCampo;
          Name:=Q430B.Name + FieldName;
          Dimensione:=FieldByName('Lunghezza').AsInteger;
          DataSet:=Q430B;
        end;
      end;
      //Se è un dato tabellare creo il campo di Lookup
      if FieldByName('Tabella').AsString = 'S' then
        with TStringField.Create(nil) do
          begin
          FieldName:='D_'+NomeCampo;
          Name:=Q430.Name + FieldName;
          Size:=FieldByName('LUNG_DESC').AsInteger;
          Index:=Q430.FieldCount - 1;
          LookUp:=True;
          LookupDataSet:=DatiLiberi[NDatiLiberi].Query;
          LookupKeyFields:='Codice';
          LookupResultField:='Descrizione';
          KeyFields:=NomeCampo;
          Tag:=NumTabelle + NDatiLiberi;
          NomiTabelle[Tag]:=DatiLiberi[NDatiLiberi].NomeTabella;
          DataSet:=Q430;
          end;
      Q430.FieldDefs.Update;
      with DatiLiberi[NDatiLiberi] do
        begin
        {Creo Label di intestazione}
        IntCampo:=TLabel.Create(nil);
        IntCampo.Parent:=Parente;
        IntCampo.Caption:=NomeCampo;
        IntCampo.AutoSize:=True;
        IntCampo.Left:=PLeft;
        IntCampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 6;
        IntCampo.Visible:=True;
        IntCampo.ParentFont:=False;
        IntCampo.Font.Color:=clBlue;
        if FieldByName('Tabella').AsString = 'S' then
          //Se campo tabellare creo LookupComboBox e DBText
          begin
          ECampo:=TDBLookupComboBox.Create(nil);
          ECampo.Parent:=Parente;
          ECampo.Height:=21;
          ECampo.Width:=Dimensione * ECampo.Font.Size + 25;
          ECampo.Left:=PLeft;
          ECampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
          ECampo.DataSource:=D430;
          ECampo.DataField:=NomeCampo;
          ECampo.ListSource:=DatiLiberi[NDatiLiberi].Sorgente;
          ECampo.ListField:='Codice;Descrizione';
          ECampo.KeyField:='Codice';
          ECampo.DropDownWidth:=FieldByName('LUNG_DESC').AsInteger * ECampo.Font.Size + 25;
          if FieldByName('LUNG_DESC').AsInteger > 100 then
            ECampo.BiDiMode:=bdRightToLeftNoAlign;
          ECampo.PopupMenu:=A002FAnagrafeGest.PopupMenu1;
          ECampo.Tag:=100+NDatiLiberi;
          ECampo.Visible:=True;
          ECampo.ParentFont:=True;
          ECampo.ShowHint:=True;
          ECampo.OnKeyDown:=A002FAnagrafeGest.dcmbKeyDown;
          //Creo DBText per descrizione codice}
          LCampo:=TDBText.Create(nil);
          LCampo.Parent:=Parente;
          LCampo.Height:=13;
          LCampo.Width:=LCampo.Canvas.TextWidth(StringReplace(Format('%*s',[FieldByName('LUNG_DESC').AsInteger,' ']),' ','M',[rfReplaceAll]));//170;
          LCampo.Left:=ECampo.Left + ECampo.Width + 2;
          LCampo.Top:=(NDatiLiberi - Offset - 1) * 36 + 23;
          LCampo.DataSource:=D430;
          LCampo.DataField:='D_'+NomeCampo;
          LCampo.Visible:=True;
          LCampo.ParentFont:=True;
          ECampo2:=nil;
          end
        else
          //Se campo NON tabellare creo DBEdit
          begin
          ECampo2:=TDBEdit.Create(nil);
          ECampo2.Parent:=Parente;
          ECampo2.Height:=21;
          ECampo2.Width:=Dimensione * ECampo2.Font.Size + 8;
          ECampo2.Left:=PLeft;
          ECampo2.Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
          ECampo2.DataSource:=D430;
          ECampo2.DataField:=NomeCampo;
          ECampo2.PopupMenu:=A002FAnagrafeGest.PopupMenu1;
          ECampo2.Tag:=100+NDatiLiberi;
          ECampo2.Visible:=True;
          ECampo2.ParentFont:=True;
          LCampo:=nil;
          ECampo:=nil;
          end;
        {Inserisco il dato nella lista dati storici}
        with A002FAnagrafeVista.Storico[NumStorici+NDatiLiberi] do
          begin
          if LCampo = nil then
            CampoInput:=ECampo2
          else
            CampoInput:=ECampo;
          end;
        end;
      Next;
      end;
    A002FAnagrafeVista.NumDatiLiberi:=NDatiLiberi;
  end;
end;

(*procedure TA002FAnagrafeDtM1.CampiCollegati(Sender: TField);
{Procedura di collegamento dati liberi alla loro validazione}
var i,Ind:Integer;
    Campo,Tabella:String;
begin
  Campo:=Sender.FieldName;
  Tabella:='I501' + Campo;
  Ind:=Sender.Index - 2 - NumStorici;
  with DatiLiberi[Ind].Query do
    begin
    Locate('Codice',Sender.AsString,[]);
    for i:=0 to FieldCount - 1 do
      if (Fields[i].FieldName <> 'CODICE') and (Fields[i].FieldName <> 'DESCRIZIONE') and
         (Fields[i].FieldName <> 'PROGRESSIVOQM') and (Fields[i].FieldName <> 'DECORRENZA') and
         (Fields[i].FieldName <> 'DECORRENZA_FINE') then
        begin
        try
          Q430.FieldByName(Fields[i].FieldName).AsString:=Fields[i].AsString;
        except
        end;
        end;
    end;
end;*)

procedure TA002FAnagrafeDtM1.RefreshFiltro(Sender: TField);
var i:Integer;
    SqlRelazione,SqlOriginale:String;
begin
  RelFiltrate:=False;
  if (A002FLayout = nil){ or (Not selI030.Active)} then
    exit;
  D430.OnDataChange:=nil;
  if Q430.FieldByName('DATAFINE').AsDateTime <> OldDataFine then
  begin
    A002FAnagrafeMW.selI030.Filtered:=False;
    A002FAnagrafeMW.selI030.Filtered:=True;
    OldDataFine:=Q430.FieldByName('DATAFINE').AsDateTime;
  end;
  with A002FLayout do
    for i:=0 to High(Layout) do
    begin
      if Layout[i].LinkComp[1] = nil then
      begin
        if Layout[i].LinkComp[0] is TDBRadioGroup then
        begin
          if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBRadioGroup(Layout[i].LinkComp[0]).Field.FieldName,'S']),[srFromBeginning]) then
          begin
            TDBRadioGroup(Layout[i].LinkComp[0]).Field.ReadOnly:=True;
            TDBRadioGroup(Layout[i].LinkComp[0]).Color:=cl3DLight;
          end
          else
          begin
            TDBRadioGroup(Layout[i].LinkComp[0]).Field.ReadOnly:=Layout[i].Accesso = 'R';
            TDBRadioGroup(Layout[i].LinkComp[0]).Color:=clBtnFace;
          end;
        end
        else if Layout[i].LinkComp[0] is TDBCheckBox then
        begin
          if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBCheckBox(Layout[i].LinkComp[0]).Field.FieldName,'S']),[srFromBeginning]) then
          begin
            TDBCheckBox(Layout[i].LinkComp[0]).Field.ReadOnly:=True;
            TDBCheckBox(Layout[i].LinkComp[0]).Color:=cl3DLight;
          end
          else
          begin
            TDBCheckBox(Layout[i].LinkComp[0]).Field.ReadOnly:=Layout[i].Accesso = 'R';
            TDBCheckBox(Layout[i].LinkComp[0]).Color:=clBtnFace;
          end;
        end;
      end
      else
      begin
        if Layout[i].LinkComp[1] is TDBEdit then
        begin
          if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBEdit(Layout[i].LinkComp[1]).Field.FieldName,'S']),[srFromBeginning]) then
          begin
            TDBEdit(Layout[i].LinkComp[1]).Field.ReadOnly:=True;
            TDBEdit(Layout[i].LinkComp[1]).Color:=cl3DLight;
          end
          else
          begin
            TDBEdit(Layout[i].LinkComp[1]).Field.ReadOnly:=Layout[i].Accesso = 'R';
            TDBEdit(Layout[i].LinkComp[1]).Color:=clWindow;
          end;
        end
        else if Layout[i].LinkComp[1] is TDBLookupComboBox then
        begin
          if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName,'S']),[srFromBeginning]) then
          begin
            TDBLookupComboBox(Layout[i].LinkComp[1]).Field.ReadOnly:=True;
            TDBLookupComboBox(Layout[i].LinkComp[1]).ReadOnly:=True;
            TDBLookupComboBox(Layout[i].LinkComp[1]).Color:=cl3DLight;
          end
          else
          begin
            TDBLookupComboBox(Layout[i].LinkComp[1]).Field.ReadOnly:=Layout[i].Accesso = 'R';
            TDBLookupComboBox(Layout[i].LinkComp[1]).ReadOnly:=Layout[i].Accesso = 'R';
            TDBLookupComboBox(Layout[i].LinkComp[1]).Color:=clWindow;
          end;
        end;
      end;
      if not (Layout[i].LinkComp[2] = nil) then
        if Layout[i].LinkComp[2] is TDBEdit then
        begin
          if A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([TDBEdit(Layout[i].LinkComp[2]).Field.FieldName,'S']),[srFromBeginning]) then
          begin
            TDBEdit(Layout[i].LinkComp[2]).Field.ReadOnly:=True;
            TDBEdit(Layout[i].LinkComp[2]).Color:=cl3DLight;
          end
          else
          begin
            TDBEdit(Layout[i].LinkComp[2]).Field.ReadOnly:=Layout[i].Accesso = 'R';
            TDBEdit(Layout[i].LinkComp[2]).Color:=clWindow;
          end;
        end;
    end;
  if EseguiRelazioni then
  begin
    //Scorrimento su selI030 ordinato per ORDINE
   A002FAnagrafeMW.selI030.First;
    while not A002FAnagrafeMW.selI030.Eof do
    begin
      if A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'F' then
      begin
        RelFiltrate:=True;
        with A002FLayout do
          for i:=0 to High(Layout) do
            if (Layout[i].LinkComp[1] is TDBLookupComboBox) and
               (TDBLookupComboBox(Layout[i].LinkComp[1]).Field.FieldName = A002FAnagrafeMW.selI030.FieldByName('COLONNA').AsString) then
            begin
              SqlRelazione:=A002FAnagrafeMW.CreaSQLRelazione((TOracleDataSet(TDBLookupComboBox(Layout[i].LinkComp[1]).ListSource.Dataset).VariableIndex('DATA') >= 0));
              if Trim(SqlRelazione) <> '' then
              begin
                with TOracleDataSet(TDBLookupComboBox(Layout[i].LinkComp[1]).ListSource.Dataset) do
                  if Trim(SqlRelazione) <> Trim(Sql.Text) then
                  begin
                    Close;
                    SqlOriginale:=Sql.Text;
                    Sql.Text:=SqlRelazione;
                    try
                      if VariableIndex('DATA') >= 0 then
                        SetVariable('DATA',Q430.FieldByName('DATAFINE').AsDateTime);
                      Open;
                    except
                      Sql.Text:=SqlOriginale;
                      Open;
                    end;
                  end;
              end;
              Break;
            end;
      end
      else if ((A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'S') or (A002FAnagrafeMW.selI030.FieldByName('TIPO').AsString = 'L')) and
               (Q430.State in [dsEdit,dsInsert]) and
               (A002FAnagrafeMW.selI030.FieldByName('TABELLA').AsString = A002FAnagrafeMW.selI030.FieldByName('TAB_ORIGINE').AsString) then
      begin
        A002FAnagrafeMW.ImpostaValoreRelazione;
      end;
      A002FAnagrafeMW.selI030.Next;
    end;
  end;
  //selI030.Filtered:=False;
  D430.OnDataChange:=D430DataChange;
end;


(*
procedure TA002FAnagrafeDtM1.CostruisciV430;
var i,IDQ,IDCA,IDC,IDT,IDJ:SmallInt;
    Campo,CampoPos,Alias,AliasPos:String;
    Q430Campi,CampiAlias,Campi,Tabelle,Join:array [0..20] of String;
    Suf:Char;
  function NonEsisteInArray(S:String; A:array of String):Boolean;
  var i:Integer;
  begin
    Result:=True;
    for i:=0 to High(A) do
     if Pos(S,A[i] + ',') > 0 then
     begin
       Result:=False;
       Break;
     end;
  end;
{Costruisco la frase SQL per costruire la vista dei dati storici sulla base della struttura di Q430}
begin
  A002FAnagrafeMW.selI500.Open;
  IDCA:=0;
  IDC:=0;
  IDT:=0;
  IDQ:=0;
  IDJ:=0;
  for i:=0 to High(Q430Campi) do
  begin
    Q430Campi[i]:='';
    CampiAlias[i]:='';
    Campi[i]:='';
    Tabelle[i]:='';
    Join[i]:='';
  end;
  for i:=0 to Q430.FieldCount - 1 do
    with Q430.Fields[i] do
    begin
      if (Lookup) and (Tag = 0) then Continue;
      if Length(CampiAlias[IDCA]) > 800 then Inc(IDCA);
      CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430' + FieldName;
      if (not Lookup) and (not Calculated) then
      begin
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if (Parametri.V430 = 'P430') and (UpperCase(FieldName) = 'DATADECORRENZA') then
          Campo:='NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if (Parametri.V430 = 'P430') and (UpperCase(FieldName) = 'DATAFINE') then
          Campo:='NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campo:='T430.' + FieldName;
        if Length(Q430Campi[IDQ]) > 800 then Inc(IDQ);
        Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo; //View//
        //Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo + ' T430' + FieldName; //MatView//
      end;
      if Lookup then
      begin
        //,Tabella.Campo
        Suf:='A';
        repeat
          Alias:=LookupDataSet.Name + Suf;  //Alias = Table.Name + A,B,C...
          Campo:=Alias + '.' + LookupResultField;
          Suf:=Succ(Suf);
          CampoPos:=',' + Campo + ',';
        until NonEsisteInArray(CampoPos,Campi);
              {(Pos(CampoPos,Campi[0] + ',') = 0) and (Pos(CampoPos,Campi[1] + ',') = 0) and (Pos(CampoPos,Campi[2] + ',') = 0) and
              (Pos(CampoPos,Campi[3] + ',') = 0) and (Pos(CampoPos,Campi[4] + ',') = 0);}
        if Length(Campi[IDC]) > 800 then Inc(IDC);
        Campi[IDC]:=Campi[IDC] + ',' + Campo; //View//
        //Campi[IDC]:=Campi[IDC] + ',' + Campo + ' T430' + FieldName; //MatView//
        AliasPos:=' ' + Alias + ',';
        if NonEsisteInArray(AliasPos,Tabelle) then
           {(Pos(AliasPos,Tabelle[0] + ',') = 0) and (Pos(AliasPos,Tabelle[1] + ',') = 0) and
           (Pos(AliasPos,Tabelle[2] + ',') = 0) and (Pos(AliasPos,Tabelle[3] + ',') = 0) and (Pos(AliasPos,Tabelle[4] + ',') = 0) then}
        begin
          if Length(Tabelle[IDT]) > 780 then Inc(IDT);
          //FROM .... Tabella Alias
          Tabelle[IDT]:=Tabelle[IDT] + ',' + NomiTabelle[Tag] + ' ' + Alias;
          if Length(Join[IDJ]) > 800 then Inc(IDJ);
          //WHERE .... T430.Campo = Tabella.Campo(+) - Sintassi Oracle
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          //Testo se il campo di T430 è tra quelli storici
          if A002FAnagrafeMW.selI500.SearchRecord('NOMECAMPO;STORICO',VarArrayOf([KeyFields,'S']),[srFromBeginning]) then
          begin
            //Nel caso di dato libero storicizzato nella query della vista deve essere considerata anche la data di decorrenza
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
            Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
            //Join[IDJ]:=Join[IDJ] + ' AND ' + Alias + '.DECORRENZA = (SELECT MAX(DECORRENZA) FROM I501' + UpperCase(KeyFields);
            //Join[IDJ]:=Join[IDJ] + ' WHERE ' + LookupKeyFields + ' = ' + Alias + '.' + LookupKeyFields + ' AND DECORRENZA <= T430.DATAFINE)';
          end
          else if (UpperCase(KeyFields) = 'PORARIO') or (UpperCase(KeyFields) = 'QUALIFICAMINIST') then
          begin
            //Nel caso di profilo orario nella query della vista deve essere considerata anche la data di decorrenza
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
            Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
          end
          else
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
        end;
      end;
    end;
  {P430} //Anagrafico stipendiale
  if Parametri.V430 = 'P430' then
  begin
    with selColsP430 do
    begin
      Open;
      while not Eof do
      begin
        if Length(CampiAlias[IDCA]) > 800 then inc(IDCA);
        if Length(Campi[IDC]) > 800 then inc(IDC);
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430' + FieldByName('COLUMN_NAME').AsString;
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA' then
          Campi[IDC]:=Campi[IDC] + ',NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA_FINE' then
          Campi[IDC]:=Campi[IDC] + ',NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campi[IDC]:=Campi[IDC] + ',P430.' + FieldByName('COLUMN_NAME').AsString; //View//
          //Campi[IDC]:=Campi[IDC] + ' P430' + FieldByName('COLUMN_NAME').AsString; //MatView//
        if FieldByName('TABELLA').AsString <> '' then
        begin
          Alias:=Copy(FieldByName('TABELLA').AsString,1,Pos('_',FieldByName('TABELLA').AsString) - 1);
          if Alias = '' then
            Alias:=FieldByName('TABELLA').AsString;
          CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430D_' + FieldByName('COLUMN_NAME').AsString;
          Campi[IDC]:=Campi[IDC] + ',' + Alias + '.DESCRIZIONE'; //View//
          //Campi[IDC]:=Campi[IDC] + ' P430D_' + FieldByName('COLUMN_NAME').AsString; //MatView//
          if Alias = 'P010' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430ABI_BANCA,P430CAB_BANCA,P430AGENZIA_BANCA,P430IBAN';
            //{ //View//
            Campi[IDC]:=Campi[IDC] + ',P010.ABI,P010.CAB,P010.AGENZIA,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0'')';
            // }
            { //MatView//
            Campi[IDC]:=Campi[IDC] + ',P010.ABI P430ABI_BANCA,P010.CAB P430CAB_BANCA,P010.AGENZIA P430AGENZIA_BANCA,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0'') P430IBAN';
            }
          end
          else if Alias = 'P040' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430FRAZIONE_PARTTIME,P430PERC_PARTTIME';
            Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1),NVL(P040.PERCENTUALE,100)'; //View//
            //Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1) P430FRAZIONE_PARTTIME,NVL(P040.PERCENTUALE,100) P430PERC_PARTTIME'; //MatView//
          end
          else if Alias = 'P240' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430TFR';
            Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'')'; //View//
            //Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'') P430TFR'; //MatView//
          end;
          if Length(Tabelle[IDT]) > 800 then inc(IDT);
          Tabelle[IDT]:=Tabelle[IDT] + ',' + FieldByName('TABELLA').AsString + ' ' + StringReplace(Alias,FieldByName('TABELLA').AsString,'',[]);
          if Length(Join[IDJ]) > 800 then Inc(IDJ);
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          Join[IDJ]:=Join[IDJ] + 'P430.' + FieldByName('COLUMN_NAME').AsString + '=' + Alias + '.' + FieldByName('COLONNA_TABELLA').AsString + '(+)';
          if Alias = 'P240' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.COD_CONTRATTO = P240.COD_CONTRATTO(+)';
          if FieldByName('DECORRENZA').AsString = 'S' then
          begin
//            Join[IDJ]:=Join[IDJ] + ' AND P430.PROGRESSIVO = ' + Alias + '.PROGRESSIVO(+)';
//            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA = ' + Alias + '.DECORRENZA(+)';
            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
          end;
        end;
        Next;
      end;
      Close;
    end;
  {P430}end;
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('drop table V430_STORICO');
    try
      Execute;
    except
    end;
    //CREATE VIEW V430_STORICO (Col1,Col2,Col3,...)
    SQL.Clear;

    { //View//
    SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');
    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(Q430Campi) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');
    }

    //AS SELECT T430.Col1, T430.Col2, T430.Col3, ...
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO_VIEW (')
    else
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');

    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(Q430Campi) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');

    SQL.Add('AS SELECT');
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('/*+ ordered */');
    SQL.Add(Copy(Q430Campi[0],2,Length(Q430Campi[0])));
    for i:=1 to High(Q430Campi) do
      if Q430Campi[i] <> '' then
        SQL.Add(Q430Campi[i]);
    // Tab1.Col1, Tab2.Col2, Tab3.Col3, ...
    SQL.Add(Campi[0]);
    for i:=1 to High(Q430Campi) do
      if Campi[i] <> '' then
        SQL.Add(Campi[i]);
    //FROM T430_STORICO T430 LEFT JOIN Tab1 Alias1 LEFT JOIN Tab2 Alias2 ...
    SQL.Add('FROM T430_Storico T430');
    {P430}if Parametri.V430 = 'P430' then SQL.Add(',P430_ANAGRAFICO P430');
    SQL.Add(Tabelle[0]);
    for i:=1 to High(Q430Campi) do
      if Tabelle[i] <> '' then
        SQL.Add(Tabelle[i]);
    //WHERE
    SQL.Add('WHERE');
    SQL.Add(Join[0]);
    for i:=1 to High(Q430Campi) do
    begin
      if Join[i] <> '' then
        SQL.Add(Join[i]);
    end;
    {P430}if Parametri.V430 = 'P430' then
    begin
      SQL.Add('AND P430.PROGRESSIVO(+) = T430.PROGRESSIVO');
      SQL.Add('AND P430.DECORRENZA(+) <= T430.DATAFINE AND P430.DECORRENZA_FINE(+) >= T430.DATADECORRENZA');
    end;{P430}
    try
      Execute;
      if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      begin
        SQL.Clear;
        SQL.Add('drop view V430_STORICO');
        try
          Execute;
        except
        end;
        PreparaIndiciV430Materializzata;
        SQL.Clear;
        SQL.Add('drop table V430_STORICO');
        try
          Execute;
        except
        end;
        SQL.Clear;
        SQL.Add('create table V430_STORICO tablespace ' + IfThen(Parametri.TSAusiliario = '',Parametri.TSLavoro, Parametri.TSAusiliario) + ' as select * from V430_STORICO_VIEW');
        Execute;
        CreaIndiciV430Materializzata;
      end;
      //SessioneOracle.Commit;
    except
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.PreparaIndiciV430Materializzata;
var
  OldIndx, CampiIndx:String;
  Unico:Boolean;
  procedure CreaIndice(Nome:String; Unico:Boolean; LCampi:String);
  begin
    with scrIndV430 do
    begin
      Lines.Add('DROP INDEX ' + Nome + ';');
      Lines.Add('CREATE ');
      if Unico then
        Lines.Add('UNIQUE ');
      Lines.Add('INDEX ' + OldIndx + ' ON V430_STORICO (' + CampiIndx + ') NOPARALLEL TABLESPACE ' + Parametri.TSIndici + ';');
    end;
  end;
begin
  OldIndx:='';
  CampiIndx:='';
  Unico:=False;
  scrIndV430.Lines.Clear;
  with selIndV430 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      if OldIndx <> FieldByName('INDEX_NAME').AsString then
      begin
        if OldIndx <> '' then
          CreaIndice(OldIndx,Unico,CampiIndx);
        OldIndx:=FieldByName('INDEX_NAME').AsString;
        Unico:=FieldByName('UNIQUENESS').AsString = 'UNIQUE';
        CampiIndx:='';
      end;
      if CampiIndx <> '' then
        CampiIndx:=CampiIndx + ',';
      CampiIndx:=CampiIndx + FieldByName('COLUMN_NAME').AsString;
      Next;
    end;
    Close;
  end;
  if OldIndx <> '' then
    CreaIndice(OldIndx,Unico,CampiIndx);
end;

procedure TA002FAnagrafeDtM1.CreaIndiciV430Materializzata;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('create index V430_PROGRESSIVO on V430_STORICO (T430PROGRESSIVO) tablespace ' + Parametri.TSIndici);
    Execute;
  end;
  if scrIndV430.Lines.Count > 0  then
    scrIndV430.Execute;
end;
*)

procedure TA002FAnagrafeDtM1.QueryAnagrafeStorico;
{QVista contiene l'unione dei dati anagrafici base (Q030) con
i dati storici validi (T430)
Struttura Sql:
(Dati_anagrafici LEFT JOIN Dati_ComuneNasc.)
       INNER JOIN dati_storici contenuti nella vista V430_Storico)
  WHERE Inibizioni_Operatore }
begin
  with QVista do
    begin
    DisableControls;
    (*Sql.Text:=QVistaOracle;
    Sql.Insert(0,Format('SELECT %s FROM',[C700TuttiCampi]));
    //Leggo le inibizioni
    with Parametri.Inibizioni do
      if Count > 0 then
        if Trim(Text) <> '' then
        begin
          Sql.Add('AND (');
          for i:=0 to Count - 1 do
            Sql.Add(Strings[i]);
          Sql.Add(')');
        end;
    Sql.Add(':FILTROCESSATI');
    ListSQL.Assign(SQL);
    //Non leggo nessun dipendente all'inizio
    if SelectString = '' then
      SQL.Add('AND PROGRESSIVO = 0')
    else
      SQL.Add(SelectString);
    //Imposto eventuale ordinamento
    if Trim(OrderString)<>''  then
      Sql.Add(OrderString);
    //Imposto la data di lavoro per i dati storici
    SetVariable('DataLavoro',A002FAnagrafeVista.DataLavoro);
    SetVariable('FILTROCESSATI',Null);
    FieldDefs.Update;                               *)
    //Creo i campi persistenti se non ci sono ancora
    if CreazioneDataModule then
    begin
      C700MergeSelAnagrafe(QVista,False);
      C700MergeSettaPeriodo(QVista,A002FAnagrafeVista.DataLavoro,A002FAnagrafeVista.DataLavoro);
      QVista.SetVariable('ORDERBY',A002FAnagrafeVista.frmSelAnagrafe.GetC700SelAnagrafeOrderBy);
      QVista.Open;
      CreazioneDataModule:=False;
      QI010.Open;
      GetColonneStruttura(True);
      if AbilAnagra <> aaNone then
      begin
        CaricaTVAzienda(False);
        //Routine per rendere visibili i campi e ordinarli
        CaricaGriglia;
      end;
      QI010.Close;
    end;
    (*try
      Open;
    except
      raise Exception.Create('Non sono disponibili dipendenti con i parametri correnti!');
    end;*)
    QVista.FieldByName('PROGRESSIVO').Visible:=False;
    QVista.FieldByName('T430PROGRESSIVO').Visible:=False;
    QVista.FieldByName('T430DATADECORRENZA').Visible:=False;
    QVista.FieldByName('T430DATAFINE').Visible:=False;
    QVista.First;
    QVista.EnableControls;
    end;
    RegistraQVistaFields;
end;

procedure TA002FAnagrafeDtM1.RegistraQVistaFields;
var i:Integer;
begin
  SetLength(QVistaFields,QVista.Fields.Count);
  for i:=0 to QVista.Fields.Count - 1 do
  begin
    QVistaFields[i].FieldName:=QVista.Fields[i].FieldName;
    QVistaFields[i].DisplayLabel:=QVista.Fields[i].DisplayLabel;
    QVistaFields[i].DisplayWidth:=QVista.Fields[i].DisplayWidth;
    QVistaFields[i].Visible:=QVista.Fields[i].Visible;
    QVistaFields[i].Index:=QVista.Fields[i].Index;
  end;
end;

procedure TA002FAnagrafeDtM1.ApplicaQVistaFields;
var i:Integer;
begin
  for i:=0 to High(QVistaFields) do
  begin
    QVista.FieldByName(QVistaFields[i].FieldName).DisplayLabel:=QVistaFields[i].DisplayLabel;
    QVista.FieldByName(QVistaFields[i].FieldName).DisplayWidth:=QVistaFields[i].DisplayWidth;
    QVista.FieldByName(QVistaFields[i].FieldName).Visible:=QVistaFields[i].Visible;
    QVista.FieldByName(QVistaFields[i].FieldName).Index:=QVistaFields[i].Index;
  end;
end;

procedure TA002FAnagrafeDtM1.GetColonneStruttura(CreaCampi:Boolean);
var i:Integer;
begin
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  for i:=0 to QVista.FieldDefs.Count - 1 do
  begin
    //if CreaCampi then
    //  QVista.FieldDefs[i].CreateField(QVista);
    Parametri.ColonneStruttura.Add(Format('%s=%s',[VarToStr(QI010.Lookup('NOME_CAMPO',QVista.FieldDefs[i].Name,'NOME_LOGICO')),QVista.FieldDefs[i].Name]));
    Parametri.TipiStruttura.Add(IntToStr(Ord(QVista.FieldDefs[i].DataType)));
  end;
end;

procedure TA002FAnagrafeDtM1.CaricaTVAzienda(Completa:Boolean);
var Nodo:TTreeNode;
    S:String;
begin
  A002FAnagrafeVista.TVAzienda.Items.BeginUpdate;
  A002FAnagrafeVista.TVAzienda.Items.Clear;
  with QI010 do
  begin
    Open;
    First;
    while not Eof do
    begin
      if Completa or ((not FieldByName('RICERCA').IsNull) and (FieldByName('RICERCA').AsInteger >= 0)) then
      begin
        S:=FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or (A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',VarArrayOf([S]),[srFromBeginning])) then
        begin
          Nodo:=A002FAnagrafeVista.TVAzienda.Items.Add(nil,FieldByName('NOME_LOGICO').AsString);
          A002FAnagrafeVista.TVAzienda.Items.AddChild(Nodo,'Valori');
        end;
      end;
      Next;
    end;
    Close;
  end;
  A002FAnagrafeVista.TVAzienda.Items.EndUpdate;
end;

procedure TA002FAnagrafeDtM1.QVistaAfterScroll(DataSet: TDataSet);
begin
  with A002FAnagrafeVista do
  begin
    StatusBar.Panels[1].Text:=Format('Anagr. %d/%d',[QVista.RecNo,QVista.RecordCount]);
    A002FAnagrafeGest.StatusBar.Panels[1].Text:=Format('Anagr. %d/%d',[QVista.RecNo,QVista.RecordCount]);
    StatusBar.Repaint;
    Relaziona(QVista.FieldByName('PROGRESSIVO').AsInteger,DataLavoro);
    GetDateDecorrenza;
  end;
end;

procedure TA002FAnagrafeDtM1.RinfrescaQueryDescrizioni(DataDec: TDateTime);
//Per i dati liberi storicizzati imposto la data e rieseguo la query
var
  i: Integer;
begin
  //Ciclo sui dati liberi considerando solo quelli storicizzati
  if DataDec <> A002FAnagrafeMW.selT220.GetVariable('Data') then
  begin
    for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    begin
      if DatiLiberi[i].Storico = 'S' then
      begin
        //Opero sulla query legata al dato libero storicizzato
        DatiLiberi[i].Query.Close;
        //Setto la data e rieseguo la query
        DatiLiberi[i].Query.SetVariable('Data',DataDec);
        DatiLiberi[i].Query.Open;
      end;
    end;
    with A002FAnagrafeMW do
    begin
      selT220.Close;
      selT220.SetVariable('Data',DataDec);
      selT220.Open;
      selT470.Close;
      selT470.SetVariable('Data',DataDec);
      selT470.Open;
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.CaricaGriglia;
{Carica le Impostazioni della griglia}
var Nome:string;
begin
  //Carico la descrizione dei campi in I010
  with QI010 do
  begin
    Open;
    First;
    while not Eof do
    begin
      Nome:=FieldByName('NOME_CAMPO').AsString;
      if Copy(Nome,1,6) = 'T430D_' then
        Nome:=Copy(Nome,7,Length(Nome) - 6)
      else if Copy(Nome,1,4) = 'T430' then
        Nome:=Copy(Nome,5,Length(Nome) - 4);
      try
        QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).DisplayLabel:=FieldByName('NOME_LOGICO').AsString;
        if A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',VarArrayOf([Nome]),[srFromBeginning]) then
          QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).Visible:=True
        else
          QVista.FieldByName(FieldByName('NOME_CAMPO').AsString).Visible:=False;
      except
      end;
      Next;
    end;
    Close;
  end;
  //Carico i dati registrati in T034_LayoutGriglia
  Q034.Close;
  Q034.SetVariable('Operatore',StrToInt(ProgOperDM));
  Q034.Open;
  try
    while not Q034.Eof do
    begin
      Nome:=Q034['NomeCampo'];
      if QVista.FindField(Nome) <> nil then
      begin
        QVista.FieldByName(Nome).Index:=Q034['Posizione'];
        if QVista.FieldByName(Nome).Visible then
          QVista.FieldByName(Nome).Visible:=Q034['Visible']='S';
        QVista.FieldByName(Nome).DisplayLabel:=Q034['Label'];
        QVista.FieldByName(Nome).DisplayWidth:=Min(Q034['Lunghezza'],1000); // limitato a 1000 caratteri
      end;
      Q034.Next;
    end
  except
  end;
  Q034.Close;
end;

procedure TA002FAnagrafeDtM1.ChiamaStorico(Prog:Integer; Data:TDateTime);
begin
  if Data >= StrToDate(DataFine) then
    exit;
  Relaziona(Prog,Data);
  if Q430.RecordCount = 0 then
    Relaziona(Prog,Data + 1);
  with A002FAnagrafeGest.cmbDateDecorrenza do
    ItemIndex:=Items.IndexOf(Q430DataDecorrenza.AsString);
end;

procedure TA002FAnagrafeDtM1.Relaziona(Prog:LongInt; DataLav:TDateTime);
{Aggiorna il collegamento tra QVista e Q030/Q430 tramite progressivo}
begin
  with Q030 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    Open;
  end;
  with Q430 do
  begin
    Close;
    SetVariable('DataLav',DataLav);
    SetVariable('Progressivo',Prog);
    Open;
    //Alberto 16/03/2009: se ci sono relazioni filtrate, è necessario fare il refresh per le descrizioni dei dblookupcombobox
    if RelFiltrate then
      Refresh;
  end;
end;

procedure TA002FAnagrafeDtM1.GetDateDecorrenza;
begin
  with A002FAnagrafeMW do
  begin
    //selDateDecorrenza.SetVariable('Progressivo',QVista.FieldByName('PROGRESSIVO').AsInteger);
    selT430_Decorrenze.SetVariable('Progressivo',Q030.FieldByName('PROGRESSIVO').AsInteger);
    selT430_Decorrenze.Close;
    selT430_Decorrenze.Open;
    with A002FAnagrafeGest.cmbDateDecorrenza do
    begin
      Items.Clear;
      while not selT430_Decorrenze.Eof do
      begin
        Items.Add(selT430_Decorrenze.FieldByName('DataDecorrenza').AsString);
        selT430_Decorrenze.Next;
      end;
      ItemIndex:=Items.IndexOf(Q430DataDecorrenza.AsString);
      selT430_Decorrenze.Close;
    end;
  end;
end;

procedure TA002FAnagrafeDtM1.OrdinaAnagrafe(Campo:String);
{Aggiunge la clausola ORDER BY alla Query QVISTA}
begin
(*  OrderString:=' ORDER BY ' + Campo;
  with QVista do
  begin
    Close;
    SQL.Assign(ListSQL);
    if SelectString <> '' then
      SQL.Add(SelectString);
    SQL.Add(OrderString);
    Open;
  end;*)
end;

procedure TA002FAnagrafeDtM1.Q030AfterInsert(DataSet: TDataSet);
{Riflette l'operazione su Q430}
begin
  if Q030.State = dsInsert then
    Q430.Append
  else
    Q430.Edit;
end;

procedure TA002FAnagrafeDtM1.Q030BeforePost(DataSet: TDataSet);
{Controlla se le modifiche richiedono la data di decorrenza, controlla
se la data e' valida}
var Q030Modified,Q430Modified,Storicizza,StoriciModificati,AggiornaStoriciSucc,AggiornaStoriciPrec:Boolean;
    DataLog,ModStor,CF,Msg:String;
    A,M,G,i:Word;
    DI,PrimaDecorrenza,tmpDataDecorrenza:TDateTime;
    lstBadgeUsato: TStringList;
begin
  OldTipoRapporto:=VarToStr(A002FAnagrafeMW.selT430OldValues.FieldByName('TipoRapporto').Value);
  if Q030.State = dsInsert then
    OldTipoRapporto:='';
  NewTipoRapporto:=Q430.FieldByName('TipoRapporto').AsString;
  if QueryPK1.EsisteChiave('T030_ANAGRAFICO',Q030.RowID,Q030.State,['MATRICOLA'],[Q030Matricola.AsString]) then
    raise Exception.Create('Matricola già esistente!');
  if (Parametri.ModPersonaleEsterno = 'N') and (Q030.FieldByName('TIPO_PERSONALE').AsString = 'E') then
    raise Exception.Create('Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!');
  Q030.FieldByName('MATRICOLA').AsString:=Trim(Q030.FieldByName('MATRICOLA').AsString);
  Q030.FieldByName('COGNOME').AsString:=Trim(Q030.FieldByName('COGNOME').AsString);

  CF:=A002FAnagrafeMW.VerificaCFCambiato(Q030.FieldByName('D_CodCatastale').AsString);
  if CF <> '' then
    if MessageDlg(Format(A000MSG_A002_DLG_FMT_CF_CAMBIATO,[CF]),mtConfirmation,[mbYes,mbNo],0) = mrYes then
      Q030.FieldByName('CodFiscale').AsString:=CF;

  {--CONTROLLO CODFISC--}
  Msg:=A002FAnagrafeMW.VerificaCFUsato;
  if Msg <> '' then
    if R180MessageBox(Format(A000MSG_A002_DLG_FMT_CF_USATO,[Msg]),'DOMANDA') = mrNo then
    Abort;

  {if QueryPK1.EsisteChiave('T030_ANAGRAFICO',Q030.RowID,Q030.State,['MATRICOLA'],[Q030Matricola.AsString]) then
    raise Exception.Create('Cod Fiscale già esistente!');}
  {---------------------}
  Q030Modified:=Q030.Modified;
  Q430Modified:=Q430.Modified;
  IntegrazioneOut:=False;
  ModStor:='N';
  Inserimento:=DataSet.State = dsInsert;
  Storicizza:=Inserimento or
              (StoricizzazioneInCorso and Q430Modified);
             //(A002FAnagrafeGest.FlagSto.Checked and Q430Modified);
  AllineaCessazione:=False;
  A002FAnagrafeGest.PageControl1.SetFocus;
  StoriciModificati:=False;
  AggiornaStoriciSucc:=False;
  AggiornaStoriciPrec:=False;
  try
    //DI:=StrToDateTime(A002FAnagrafeGest.Decorrenza.Text)
    DI:=Q430.FieldByName('DATADECORRENZA').AsDateTime;
  except
    raise Exception.Create('E'' richiesta una data di decorrenza valida per registrare i dati storici');
  end;
  if (DI < EncodeDate(1900,01,01)) or (DI > EncodeDate(3999,12,31)) then
    raise Exception.Create('La data di decorrenza deve essere compresa tra il 1900 ed il 3999.');
  if (not Inserimento) and (Storicizza or (A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value <> StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]))) then
    PrimaDecorrenza:=StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0])
  else
    PrimaDecorrenza:=Q430.FieldByName('DataDecorrenza').AsDateTime;
  if (not Q430.FieldByName('INIZIO').IsNull) and (Q430.FieldByName('INIZIO').AsDateTime <> A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value) then
  begin
    if Q430.FieldByName('INIZIO').AsDateTime < PrimaDecorrenza then
      raise Exception.Create(Format(A000MSG_A002_ERR_FMT_INIZIO_ANTE,[Q430.FieldByName('INIZIO').AsString,DateToStr(PrimaDecorrenza)]));
  end;
  if not Inserimento then
    if Storicizza then
    begin //Controllo che la data di decorrenza sia compresa nel periodo storico corrente, con l'eccezione del primo periodo storico in cui è possibile storicizzare ad una data precedente
      if ((DI < A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value)) then
        if (PrimaDecorrenza < A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value) then
          raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(DI)]));
    end
    else
    begin
      if A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value <> StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]) then
      begin //Controllo che la data di decorrenza non sia successiva alla fine del periodo storico corrente
            //e non sia precedente al periodo storico precedente
        if ((DI <= StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[A002FAnagrafeGest.cmbDateDecorrenza.ItemIndex - 1])) or (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value)) then
          raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(DI)]));
      end
      else //Controllo che la prima decorrenza non sia successiva alla fine del periodo storico corrente
      begin
        if (DI > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value) then
          raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_PER,[DateToStr(DI)]));
        //Se è già stata impostata la data di inizio rapporto...
        if not Q430.FieldByName('INIZIO').IsNull then
        begin

          if A002FAnagrafeMW.CountAnagraficheStipendiali(Q030.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(1900,01,01),EncodeDate(3999,12,31)) > 0 then
          begin
            //Se il dipendente ha già almeno un'anagrafica stipendiale, controllo che la decorrenza non sia maggiore del 1° giorno del mese di inizio rapporto
            if DI > R180InizioMese(Q430.FieldByName('INIZIO').AsDateTime) then
              raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_STIP,[DateToStr(DI),DateToStr(R180InizioMese(Q430.FieldByName('INIZIO').AsDateTime))]));
          end
          else
          begin
            //Se il dipendente non ha alcuna anagrafica stipendiale, controllo che la decorrenza non sia maggiore dell'inizio rapporto
            if DI > Q430.FieldByName('INIZIO').AsDateTime then
              raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMA_ASSUNZ,[DateToStr(DI),DateToStr(Q430.FieldByName('INIZIO').AsDateTime)]));
          end;
        end;
        //Se sto posticipando la decorrenza...
        if A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value < DI then
        begin
          //...verifico che non esistano periodi storici stipendiali nel periodo di traslazione della decorrenza
          if A002FAnagrafeMW.CountAnagraficheStipendiali(Q030.FieldByName('PROGRESSIVO').AsInteger,A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value + 1,DI) > 0 then
            raise Exception.Create(Format(A000MSG_A002_ERR_FMT_DEL_STIPENDIALI,[DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_OLD')),DateToStr(A002FAnagrafeMW.selP430_Count.GetVariable('DATA_NEW'))]));
        end;
        //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
        A002FAnagrafeMW.AggiornaDecorrenzaStipendiale(DI);
      end;
    end;

  if (not Inserimento) and (Storicizza or (Q430Modified and (Q430.FieldByName('DATAFINE').AsDateTime <> StrToDate(DataFine)))) and A002FAnagrafeGest.chkStoriciSucc.Checked then
    AggiornaStoriciSucc:=True;
  if (not Inserimento) and (Storicizza or (Q430Modified)) and A002FAnagrafeGest.chkStoriciPrec.Checked then
    AggiornaStoriciPrec:=True;

  //if (not Inserimento) and (Storicizza or (Q430Modified and (Q430DataFine.AsDateTime <> StrToDate(DataFine)))) then
  //if MessageDlg('Si desidera modificare anche i movimenti storici successivi ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  if Q430.FieldByName('INIZIO_IND_MAT').IsNull xor Q430.FieldByName('FINE_IND_MAT').IsNull then
    Raise Exception.Create(A000MSG_A002_ERR_MATERNITA_VALOR);
  if Q430.FieldByName('INIZIO_IND_MAT').AsDateTime > Q430.FieldByName('FINE_IND_MAT').AsDateTime then
    Raise Exception.Create(A000MSG_A002_ERR_DATE_MATERNITA);
  if ((A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO_IND_MAT').Value <> Q430.FieldByName('INIZIO_IND_MAT').Value) or
     (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE_IND_MAT').Value <> Q430.FieldByName('FINE_IND_MAT').Value) or
     (A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value <> Q430.FieldByName('INIZIO').Value) or
     (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE').Value <> Q430.FieldByName('FINE').Value)) then
  begin
    if (Not Q430.FieldByName('INIZIO_IND_MAT').IsNull) and (Not Q430.FieldByName('FINE_IND_MAT').IsNull) then
    begin
      {Controllo che non avvengano intersezioni tra periodi d'indennità maternità}
      Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiIndMat;
      if Msg <> '' then
      begin
        Msg:=Format(A000MSG_A002_ERR_FMT_INT_MAT,[Msg]);
        Raise Exception.Create(Msg);
      end;

      {Controllo che non avvengano intersezioni tra peridi di rapporto e periodi di maturazione
       indennità maternità}
      Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiRappIndMat;
      if Msg <> '' then
      begin
        Msg:=Format(A000MSG_A002_ERR_FMT_INT_MAT_RAPP,[Msg]);
        Raise Exception.Create(Msg);
      end;
    end;

    A002FAnagrafeMW.AggiornaPeriodoIndMat;
  end;

  if (not Q430.FieldByName('FINE').IsNull) and (Q430.FieldByName('INIZIO').AsDateTime > Q430.FieldByName('FINE').AsDateTime) then
    if MessageDlg(A000MSG_A002_DLG_DATA_ASSUNZ_POST,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      Abort;
  if (not Inserimento) and (Q430Modified and (Q430.FieldByName('DATAFINE').AsDateTime <> StrToDate(DataFine))) and (not AggiornaStoriciSucc) then
    if MessageDlg('Esistono delle storicizzazioni successive ma le modifiche verranno applicate solo sulla decorrenza corrente. Confermare?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      Abort;
  if (not Inserimento) and (not Storicizza) and (Q430.FieldByName('DataDecorrenza').Value <> A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) then
    if MessageDlg(A000MSG_A002_DLG_MODIFICA_DECOR,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      Abort;
  //Controllo che il badge assegnato non sia già utilizzato da altri dipendenti
  if A002FAnagrafeGest.cmbDateDecorrenza.Items.Count = 0 then
    tmpDataDecorrenza:=DATE_NULL
  else
    tmpDataDecorrenza:=StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]);
  lstBadgeUsato:=A002FAnagrafeMW.VerificaBadge(Inserimento,Storicizza,tmpDataDecorrenza,AggiornaStoriciPrec,AggiornaStoriciSucc);
  if lstBadgeUsato <> nil then
  begin
    //Ho trovato altre occorrenze di questo badge
    A002FBadgeMsg:=TA002FBadgeMsg.Create(nil);
    try
      A002FBadgeMsg.Caption:='<A002> Badge già esistente';
      A002FBadgeMsg.pnlData.Visible:=False;
      with A002FBadgeMsg.Memo1 do
      begin
        Lines.Add('Attenzione!');
        Lines.Add('Il badge risulta essere assegnato a:');
        for I:=0 to lstBadgeUsato.Count - 1 do
          Lines.Add(lstBadgeUsato[i]);
      end;
      A002FBadgeMsg.ShowModal;
      Abort;
    finally
      A002FBadgeMsg.Release;
      FreeAndNil(lstBadgeUsato);
    end;
  end;
  //Verifica non sia Badge servizio
  if not A002FAnagrafeMW.VerificaBadgeServizio then
    raise Exception.Create(A000MSG_A002_ERR_BADGE_SERVIZIO);

  (*
  //Filtri sul dizionario
  A002FAnagrafeMW.FiltroDizionarioBeforePost('CALENDARIO','CALENDARI','Calendario');
  A002FAnagrafeMW.FiltroDizionarioBeforePost('IPRESENZA','PROFILI INDENNITA','Profilo Indennità');
  A002FAnagrafeMW.FiltroDizionarioBeforePost('PORARIO','PROFILI ORARIO','Profilo Orario');
  A002FAnagrafeMW.FiltroDizionarioBeforePost('PASSENZE','PROFILI ASSENZA','Profilo Assenze');
  *)

  //Modifica senza storicizzazione
  if not Storicizza then
  begin
    begin
      if AggiornaStoriciSucc or AggiornaStoriciPrec then
      begin
        StoriciModificati:=True;
        if AggiornaStoriciPrec then
          AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataDecorrenza').AsDateTime,'P');
        if AggiornaStoriciSucc then
          AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataFine').AsDateTime,'S');
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
        RegistraLog.RegistraOperazione;
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
      end;
    end;
    if not StoriciModificati then
    begin
      DataLog:=FormatDateTime('dd/mm/yyyy',Q430DataFine.AsDateTime);
      if DataLog = DataFine then
        DataLog:='Corrente';
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
      RegistraLog.RegistraOperazione;
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
    end;
    A002FAnagrafeMW.AggiornaFine('N');
    AggiornaCdCPercentualizzati;
    Q430.Post;
    exit;
  end;
  try
    //Decor:=StrToDateTime(A002FAnagrafeGest.Decorrenza.Text);
    Decor:=Q430.FieldByName('DATADECORRENZA').AsDateTime;
  except
    raise Exception.Create('E'' richiesta una data di decorrenza valida per registrare i dati storici');
  end;
  if (Decor < EncodeDate(1900,01,01)) or (Decor > EncodeDate(3999,12,31)) then
    raise Exception.Create('La data di decorrenza deve essere compresa tra il 1900 ed il 3999.');
  //Inserimento di un nuovo dipendente
  if Inserimento then
    begin
    with Q430 do
      begin
      //Incremento il progressivo interno

      Q030['Progressivo']:=A002FAnagrafeMw.NuovoProgressivo;
      if FieldByName('Inizio').IsNull then
        //Se non ho la data di assunzione uso la data di decorrenza
        begin
        //S:='Poichè non è specificata la data di assunzione, i dati storici decorreranno dalla data decorrenza specificata: ' +
        //   A002FAnagrafeGest.Decorrenza.Text + #13 + 'Confermare l''inserimento ?';
        //Se non confermo, annullo l'operazione
        //if MessageDlg(S,mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        //  Abort;
        FieldByName('DataDecorrenza').AsDateTime:=Decor;
        end
      else
        //Setto data decorrenza = al giorno di assunzione
        begin
        DecodeDate(FieldByName('Inizio').AsDateTime,A,M,G);
        //Alberto 05/07/2006: la prima data di decorrenza non è più vincolata al primo del mese
        FieldByName('DataDecorrenza').AsDateTime:=EncodeDate(A,M,G);
        //FieldByName('DataDecorrenza').AsDateTime:=EncodeDate(A,M,1);
        end;
      FieldByName('DataFine').AsDateTime:=StrToDateTime(DataFine);
      FieldByName('Progressivo').AsInteger:=Q030.FieldByName('Progressivo').AsInteger;
      Post;
      RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
      RegistraLog.RegistraOperazione;
      RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
      end;
    end
  else
    //Modifica con storicizzazione
    with Q430B do
      begin
      //Aggiorno i dati storici solo di questo dipendente
      Filtered:=False;
      Close;
      SetVariable('Prog',Q030.FieldByName('Progressivo').AsInteger);
      Open;
      if Locate('DataDecorrenza',Decor,[]) then
        raise Exception.Create('Esiste già una situazione storica con questa data di decorrenza!');
      TuttoStorico:=tsPrima;
      Filtered:=True;
      if RecordCount > 0 then
        begin
        //Se si sovrappone a una storicizzazione già esistente
        //aggiorno la data fine di quest'ultima
        First;
        Edit;
        FieldByName('DataFine').AsDateTime:=Decor - 1;
        Post;
        end;
      //Se ci sono delle storicizzazioni posteriori imposto la data
      //di fine alla data di decorrenza successiva - 1
      TuttoStorico:=tsDopo;
      Filtered:=False;
      Filtered:=True;
      Q430.FieldByName('DataDecorrenza').AsDateTime:=Decor;
      if RecordCount > 0 then
        begin
        First;
        Q430.FieldByName('DataFine').AsDateTime:=FieldByName('DataDecorrenza').AsDateTime - 1;
        end
      else
        Q430.FieldByName('DataFine').AsDateTime:=StrToDateTime(DataFine);
      Filtered:=False;
      if Q430Modified then
        if AggiornaStoriciSucc or AggiornaStoriciPrec then
        begin
          StoriciModificati:=True;
          if AggiornaStoriciSucc then
            AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataFine').AsDateTime,'S');
          if AggiornaStoriciPrec then
            AggiornamentoStoriciPrecSucc(Q430.FieldByName('DataDecorrenza').AsDateTime,'P');
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
          RegistraLog.RegistraOperazione;
          RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
        end;
      if not StoriciModificati then
        begin
        DataLog:=FormatDateTime('dd/mm/yyyy',Q430DataFine.AsDateTime);
        if DataLog = DataFine then
          DataLog:='Corrente';
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q030{DataSet}),Copy(Self.Name,1,4),Q030,True);
        RegistraLog.RegistraOperazione;
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Q430{DataSet}),Copy(Self.Name,1,4),Q430,False);
        end;
      if (Q430.State = dsEdit) and (Q430Fine.AsDateTime <> OldFine) then
        with A002FAnagrafeMW.updFine do
        begin
          ClearVariables;
          SetVariable('PROGRESSIVO',Q430Progressivo.AsInteger);
          SetVariable('RIGAID',Q430.RowID);
          SetVariable('STORICIZZA','S');
          SetVariable('INIZIO',Q430Inizio.AsDateTime);
          if not Q430Fine.IsNull then
            SetVariable('FINE',Q430Fine.AsDateTime);
          AllineaCessazione:=True;
          //in questo caso (storicizzazione), l'esecuzione di updFine avviene nell'AfterPost
        end;
      AggiornaCdCPercentualizzati;
      Append;
      for i:=0 to FieldCount - 1 do
        if (UpperCase(Fields[i].FieldName) = 'DATADECORRENZA') or
           (UpperCase(Fields[i].FieldName) = 'DATAFINE') then
          Fields[i].Value:=Q430.FieldByName(Fields[i].FieldName).Value
        else
          Fields[i].Value:=A002FAnagrafeMW.selT430OldValues.FieldByName(Fields[i].FieldName).Value;
      Post;
      //Salvo le modifiche storicizzate per rieseguirle dopo, in modo da far scattare il trigger per ADS (DEPOSITO_VARIAZIONI_SETTORE)
      AggiornamentoStoriciPrecSucc(Q430B.FieldByName('DataDecorrenza').AsDateTime,'=');
      ModificaStoricizzata:=OperSQL.SQL.Text;
      OperSQL.SQL.Clear;
      Q430.Cancel;
      end;
end;

procedure TA002FAnagrafeDtM1.AggiornamentoStoriciPrecSucc(Data:TDateTime; Tipo:String);
var i:Integer;
    U,V:String;
    IIM,FIM:Boolean;
begin
  U:='';
  IIM:=False;
  FIM:=False;
  for i:=0 to Q430.FieldDefs.Count - 1 do
    begin
    if (UpperCase(Q430.FieldDefs[i].Name) = 'DATADECORRENZA') or (UpperCase(Q430.FieldDefs[i].Name) = 'DATAFINE') then Continue;
    if Copy(UpperCase(Q430.FieldDefs[i].Name),1,10) = 'ABPRESENZA' then
      if Copy(UpperCase(Q430.FieldDefs[i].Name),11,1) <> '1' then Continue;
    if Copy(UpperCase(Q430.FieldDefs[i].Name),1,9) = 'ABCAUSALE' then
      if Copy(UpperCase(Q430.FieldDefs[i].Name),10,1) <> '1' then Continue;
    if (Q430.FieldByName(Q430.FieldDefs[i].Name).Value <> A002FAnagrafeMW.selT430OldValues.FieldByName(Q430.FieldDefs[i].Name).Value) then
      begin
      if U <> '' then U:=U + ',';
      if Q430.FieldDefs[i].DataType = ftDateTime then
        begin
        if Q430.FieldByName(Q430.FieldDefs[i].Name).IsNull then
          V:='NULL'
        else
          V:=FormatDateTime('dd/mm/yyyy',Q430.FieldByName(Q430.FieldDefs[i].Name).AsDateTime);
        end
      else
        V:=Q430.FieldByName(Q430.FieldDefs[i].Name).AsString;
      if not((Q430.FieldDefs[i].DataType = ftDateTime) and (Q430.FieldByName(Q430.FieldDefs[i].Name).IsNull)) then
        V:='''' + AggiungiApice(V) + '''';
      U:=U + Q430.FieldDefs[i].Name + '=' + V;
      if Q430.FieldDefs[i].Name = 'INIZIO_IND_MAT' then
        IIM:=True;
      if Q430.FieldDefs[i].Name = 'FINE_IND_MAT' then
        FIM:=True;
      end;
    end;
  if U = '' then exit;
  if (IIM and not FIM) or (not IIM and FIM) then
  begin
    if Q430.FieldByName(IfThen(IIM,'FINE_IND_MAT','INIZIO_IND_MAT')).IsNull then
      V:='NULL'
    else
      V:='''' + FormatDateTime('dd/mm/yyyy',Q430.FieldByName(IfThen(IIM,'FINE_IND_MAT','INIZIO_IND_MAT')).AsDateTime) + '''';
    U:=U + IfThen(IIM,',FINE_IND_MAT',',FINE_IND_MAT') + ' = ' + V;
  end;
  with OperSQL do
    begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE T430_Storico SET');
    SQL.Add(U);
    if Tipo = 'S' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA > ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]))
    else if Tipo = 'P' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA < ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]))
    else if Tipo = '=' then
      SQL.Add(Format('WHERE PROGRESSIVO = %s AND DATADECORRENZA = ''%s''',[Q430.FieldByName('Progressivo').AsString,FormatDateTime('dd/mm/yyyy',Data)]));
    if Tipo <> '=' then
      Execute;
    end;
end;

procedure TA002FAnagrafeDtM1.Q030AfterPost(DataSet: TDataSet);
{Applico la cache di modifica}
var D,Istante:TDateTime;
  Inserimento:Boolean;
  TR,sTmp:String;
begin
  if Q430B.Active and Q430B.UpdatesPending then
    D:=Q430B.FieldByName('DATADECORRENZA').AsDateTime
  else
    D:=Q430DataDecorrenza.AsDateTime;
  Inserimento:=Q030.UpdateStatus = usInserted;
  SessioneOracle.ApplyUpdates([Q030,Q430],True);
  if Q430B.Active and Q430B.UpdatesPending then
  begin
    Istante:=Now;
    A002FAnagrafeMW.NoTrigger(Istante,'S');
    //Inserisce la nuova decorrenza ma ancora con i vecchi valori
    SessioneOracle.ApplyUpdates([Q430B],False);
    Q430B.CancelUpdates;
    A002FAnagrafeMW.NoTrigger(Istante,'N');
    //Applica le modifiche storicizzate sulla nuova decorrenza
    if ModificaStoricizzata <> '' then
    begin
      OperSQL.SQL.Text:=ModificaStoricizzata;
      OperSQL.Execute;
    end;
  end;
  AllineaDataFine;
  if AllineaCessazione then
  begin
    A002FAnagrafeMW.updFine.Execute;
    AllineaCessazione:=False;
  end;

  A002FAnagrafeMW.UpdT430Mat.SetVariable('PROGRESSIVO',Q030.FieldByName('PROGRESSIVO').AsInteger);
  A002FAnagrafeMW.UpdT430Mat.Execute;

  if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
    R180MessageBox(A000MSG_A002_ERR_DIP_IN_USO ,ERRORE);

  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  //RegistraLog.RegistraOperazione; -> spostato prima della commit
  GetDateDecorrenza;
  if (OldTipoRapporto <> '')
  and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',OldTipoRapporto,'TIPO')) = 'R')
  and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO')) <> 'R') then
  begin
    TR:=VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO'));
    ShowMessage(Format(A000MSG_A002_ERR_FMT_CAMBIO_RAPP,[IfThen(TR = 'S','Supplente',IfThen(TR = 'I','Incaricato',IfThen(TR = 'P','Prova',IfThen(TR = 'A','Altro','nessuno'))))]));
  end;
  if not A002FAnagrafeMW.VerificaInizioRapportoInterseca(sTmp) then
      ShowMessage(Format(A000MSG_A002_ERR_FMT_RAPP_INTERSECA,[sTmp]));

  if not A002FAnagrafeMW.VerificaPeriodiInvertiti(sTmp) then
      ShowMessage(Format(A000MSG_A002_ERR_FMT_PERIODI_INV,[sTmp]));

  if not A002FAnagrafeMW.VerificaDatePeriodi(sTmp) then
      ShowMessage(Format(A000MSG_A002_ERR_FMT_DATE_INCONGR,[sTmp]));

  ChiamaStorico(Q030Progressivo.AsInteger, D);
  if Inserimento then
    A002FAnagrafeVistaPadre.ResettaTVAzienda;
end;

procedure TA002FAnagrafeDtM1.AllineaDataFine;
var NomeTab,Chiave:String;
begin
  NomeTab:='T430_STORICO';
  Chiave:='PROGRESSIVO = t.PROGRESSIVO';
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    SQL.Add('  update T430_STORICO t set');
    SQL.Add('    DATAFINE = (select min(DATADECORRENZA) - 1 from T430_STORICO where');
    SQL.Add('                      PROGRESSIVO = t.PROGRESSIVO and');
    SQL.Add('                       DATADECORRENZA > t.DATADECORRENZA)');
    SQL.Add('  where PROGRESSIVO = ' + Q030.FieldByName('PROGRESSIVO').AsString + ' and');
    SQL.Add('    DATADECORRENZA < (select max(DATADECORRENZA) from T430_STORICO');
      SQL.Add('                  where PROGRESSIVO = t.PROGRESSIVO');
    SQL.Add('                  );');
    SQL.Add('  update T430_STORICO t set');
    SQL.Add('    DATAFINE = TO_DATE(''31123999'',''DDMMYYYY'')');
    SQL.Add('  where PROGRESSIVO = ' + Q030.FieldByName('PROGRESSIVO').AsString + ' and');
    SQL.Add('    DATADECORRENZA = (select max(DATADECORRENZA) from T430_STORICO');
    SQL.Add('                  where PROGRESSIVO = t.PROGRESSIVO');
    SQL.Add('                  );');
    SQL.Add('end;');
    try
      Execute;
      SessioneOracle.Commit;
    except
    end;
  finally
    Free;
  end;
end;


procedure TA002FAnagrafeDtM1.Q030AfterCancel(DataSet: TDataSet);
{Annulla le operazioni anche su T430 e reimposta i controlli sulla
modalita' scorrimento}
begin
  Q430.Cancel;
  SessioneOracle.CancelUpdates([Q030]);
  Q430.CancelUpdates;
end;

procedure TA002FAnagrafeDtM1.Q030AfterDelete(DataSet: TDataSet);
{Applico la cache di cancellazione}
begin
  SessioneOracle.ApplyUpdates([Q030],True);
  SessioneOracle.Commit;
end;

procedure TA002FAnagrafeDtM1.Q430BeforeEdit(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selI030.Refresh;
  A002FAnagrafeMW.selI035.Refresh;
end;

procedure TA002FAnagrafeDtM1.Q430BeforeInsert(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selI030.Refresh;
  A002FAnagrafeMW.selI035.Refresh;
  EseguiRelazioni:=False;
  Q430.DisableControls;
end;

procedure TA002FAnagrafeDtM1.Q430BFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
{Filtra i dati storici: tsTutto visualizza tutti i dati del dipendente
                        tsPrima visualizza la storia con una certa data compresa fra data inizio e data fine
                        tsDopo visualizza la storia dopo una certa data}
begin
  case TuttoStorico of
    tsPrima:Accept:=(Q430B.FieldByName('DataDecorrenza').AsDateTime < Decor) and
                    (Q430B.FieldByName('DataFine').AsDateTime >= Decor);
    tsDopo: Accept:=Q430B.FieldByName('DataDecorrenza').AsDateTime > Decor;
    tsTutto:Accept:=True;
  end;
end;

procedure TA002FAnagrafeDtM1.Q430AfterFetchRecord(Sender: TOracleDataSet;
  FilterAccept: Boolean; var Action: TAfterFetchRecordAction);
//Per i dati liberi storicizzati imposto la data e rieseguo la query
begin
  //RinfrescaQueryDescrizioni(Q430.FieldByName('DATADECORRENZA').NewValue);
  RinfrescaQueryDescrizioni(Q430.FieldByName('DATAFINE').NewValue);
  //RefreshFiltro(nil);
end;

procedure TA002FAnagrafeDtM1.Q430AfterInsert(DataSet: TDataSet);
begin
  EseguiRelazioni:=True;
  Q430.EnableControls;
end;

procedure TA002FAnagrafeDtM1.Q430AfterOpen(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selT430OldValues.CreaStruttura;
end;

procedure TA002FAnagrafeDtM1.Q430AfterScroll(DataSet: TDataSet);
begin
  A002FAnagrafeMW.selT430OldValues.Aggiorna;
end;

procedure TA002FAnagrafeDtM1.T430DataFineGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
{Non visualizza la data finale se il dato e' corrente (data = 31/12/9999)}
begin
  Text:=FormatDateTime('dd/mm/yyyy',Sender.AsDateTime);
  if Sender.AsDateTime = 0 then Text:='';
  if Text = DataFine then Text:='Corrente';
end;

procedure TA002FAnagrafeDtM1.D030StateChange(Sender: TObject);
{Imposta lo stato dei bottoni in risposta al cambiamento
di stato di Q030_Anagrafe}
var Browse:Boolean;
begin
  Browse:=not (Q030.State in [dsInsert, dsEdit]);
  with A002FAnagrafeGest do
  begin
    Chiudi1.Enabled:=Browse;
    actRicerca.Enabled:=Browse;
    actPrimo.Enabled:=Browse;
    actPrecedente.Enabled:=Browse;
    actSuccessivo.Enabled:=Browse;
    actUltimo.Enabled:=Browse;
    actInserisci.Enabled:=Browse and (Parametri.InserimentoMatricole = 'S') and (AbilAnagra = aaReadWrite);
    actModifica.Enabled:=Browse and (AbilAnagra = aaReadWrite);
    actCancella.Enabled:=Browse and (AbilAnagra = aaReadWrite) and (Parametri.EliminaStorici = 'S');
    actConferma.Enabled:=not Browse;
    actAnnulla.Enabled:=not Browse;
    actGomma.Enabled:=not Browse;
    //Panel3.Visible:=not Browse;
    actStoricoPrecedente.Enabled:=Browse;
    actStoricoSuccessivo.Enabled:=Browse;
    cmbDateDecorrenza.Enabled:=Browse;
    try
      btnStoricizza.Enabled:=Browse and (AbilAnagra = aaReadWrite) and Q430.Active and (Q430.RecordCount > 0);
    except
      btnStoricizza.Enabled:=False;
    end;
    if Browse then
      StoricizzazioneInCorso:=False;
    chkStoriciPrec.Enabled:=Q030.State = dsEdit;
    chkStoriciSucc.Enabled:=Q030.State = dsEdit;
    dedtDecorrenza.ReadOnly:=(Parametri.Storicizzazione = 'N') and (Q030.State <> dsInsert);
    chkStoriciPrec.Checked:=False;
    chkStoriciSucc.Checked:=False;
  end;
end;

procedure TA002FAnagrafeDtM1.Q030CalcFields(DataSet: TDataSet);
var EMail1,EMail2:String;
begin
  with Q030 do
  begin
    //Costruisco NomeCognome
    FieldByName('NomeCognome').AsString:=FieldByName('Nome').AsString + ' ' + FieldByName('Cognome').AsString;
    //Costruisco I060EMail
    R180SetVariable(A002FAnagrafeMW.selI060,'Azienda',Parametri.Azienda);
    R180SetVariable(A002FAnagrafeMW.selI060,'Matricola',FieldByName('Matricola').AsString);
    A002FAnagrafeMW.selI060.Open;
    A002FAnagrafeMW.selI060.First;
    while not A002FAnagrafeMW.selI060.Eof do //potrebbero esserci più account per la stessa matricola
    begin
      EMail1:=Trim(A002FAnagrafeMW.selI060.FieldByName('EMAIL').AsString) + ';';
      while Pos(';',EMail1) > 0 do //potrebbero esserci più email per lo stesso account
      begin
        EMail2:=Trim(Copy(EMail1,1,Pos(';',EMail1) - 1));
        if (EMail2 <> '')
        and (Pos(';' + EMail2 + ';',';' + FieldByName('I060EMail').AsString) = 0) then
          FieldByName('I060EMail').AsString:=FieldByName('I060EMail').AsString + EMail2 + ';';
        EMail1:=Copy(EMail1,Pos(';',EMail1) + 1);
      end;
      A002FAnagrafeMW.selI060.Next;
    end;
    FieldByName('I060EMail').AsString:=Copy(FieldByName('I060EMail').AsString,1,Length(FieldByName('I060EMail').AsString) - 1);
    FieldByName('I060EMail').AsString:=StringReplace(FieldByName('I060EMail').AsString,';','; ',[rfReplaceAll]);
  end;
end;

procedure TA002FAnagrafeDtM1.Q430StringField27Validate(Sender: TField);
{Controllo che i minuti siano minori di 60}
begin
  {
  Minuti:=StrToInt(Copy(Sender.AsString,4,2));
  if Minuti > 59 then
    Raise Exception.Create('I minuti devono essere minori di 60!');
  }
  OreMinutiValidate(Sender.AsString);
end;

procedure TA002FAnagrafeDtM1.CercaAnagrafe;
{Crea la form di ricerca e si posiziona sul record}
var i:Integer;
    ElencoCampi:String;
    Valori,Campi:TStringList;
    Pippo:Variant;
begin
  Valori:=TStringList.Create;
  Campi:=TStringList.Create;
  ElencoCampi:='';
  C001FRicerca:=TC001FRicerca.Create(Application);
  with C001FRicerca,A002FAnagrafeDtm1.QVista do
    try
      chkFiltro.Visible:=False;
      Grid.RowCount:=FieldCount + 1;
      for i:=0 to FieldCount - 1 do
        if not((Fields[i].Calculated) or (Fields[i].Lookup)) then
        begin
          Campi.Add(Fields[i].FieldName);
          Grid.Cells[0,i+1]:=Fields[i].DisplayLabel;
        end;
      Grid.RowCount:=Campi.Count + 1;
      if ShowModal = mrOk then
      begin
        for i:=1 to Grid.RowCount - 1 do
          if Trim(Grid.Cells[1,i]) <> '' then
          begin
            ElencoCampi:=ElencoCampi + ';' + Campi[i-1];
            Valori.Add(Trim(Grid.Cells[1,i]));
          end;
        if Valori.Count > 0 then
        begin
          Pippo:=VarArrayCreate([0,Valori.Count - 1],VarVariant);
          for i:=0 to Valori.Count - 1 do
            Pippo[i]:=Valori[i];
          if Valori.Count > 1 then
            Locate(Copy(ElencoCampi,2,1000),Pippo,[loCaseInsensitive, loPartialKey])
          else
            Locate(Copy(ElencoCampi,2,1000),Valori[0],[loCaseInsensitive, loPartialKey])
          end;
        end;
    finally
      Release;
    end;
end;

procedure TA002FAnagrafeDtM1.ActiveDatiLiberi(Active:Boolean);
{Attivo/Disattivo le query dei dati liberi}
var i:Word;
begin
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    if DatiLiberi[i].Query <> nil then
      DatiLiberi[i].Query.Active:=Active;
end;

procedure TA002FAnagrafeDtM1.A002FAnagrafeDtM1Destroy(Sender: TObject);
{Tolgo l'occupazione all'operatore}
begin
  FreeAndNil(A002FAnagrafeMW);

  (*if IntegrazioneFTP and (I002FModifOut <> nil) then
    FreeAndNil(I002FModifOut);*)
  with OperSQL do
    begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET OCCUPATO = ''N'' WHERE PROGRESSIVO = ' + ProgOperDM);
    try
      Execute;
    except
    end;
    end;
  with selT432 do
  try
    R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
    Open;
    First;
    if Parametri.DataLavoro <> Date then
    begin
      Edit;
      FieldByName('UTENTE').AsString:=Parametri.Operatore;
      FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
      Post;
    end
    else if not Eof then
      Delete;
    Close;
  except
  end;
  RegistraLog.SettaProprieta('A','','A002',nil,True);
  RegistraLog.InserisciDato('APPLICATIVO','',UpperCase(ExtractFileName(Application.ExeName)));
  RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
  RegistraLog.InserisciDato('TIPO','','USCITA');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  try SessioneOracle.Commit; except end;
  ListSQL.Free;
  ListaAssenze.Free;
  ListaPresenze.Free;
  QI010.Free;
  DistruggiDatiLiberi;
  SetLength(NomiTabelle,0);
  SessioneOracle.LogOff;
end;

procedure TA002FAnagrafeDtM1.Q010AfterOpen(DataSet: TDataSet);
begin
  DataSet.Fields[0].DisplayWidth:=Trunc(DataSet.Fields[0].Size * 1.5) + 1;
end;

procedure TA002FAnagrafeDtM1.Q030BeforeEdit(DataSet: TDataSet);
begin
  if (Parametri.ModPersonaleEsterno = 'N') and (Q030.FieldByName('TIPO_PERSONALE').AsString = 'E') then
    raise Exception.Create('Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!');
  OldInizio:=Q430Inizio.AsDateTime;
  OldFine:=Q430Fine.AsDateTime;
end;

procedure TA002FAnagrafeDtM1.Q030BeforeInsert(DataSet: TDataSet);
begin
  if Parametri.InserimentoMatricole <> 'S' then
    Abort;
  if VersioneDimostrativa then
  begin
    Q030Count.Execute;
    if Q030Count.Field(0) > 40 then
      raise Exception.Create('Questa è una versione dimostrativa: ' + #13 + 'è stato superato il numero di dipendenti disponibili!');
  end;
end;

procedure TA002FAnagrafeDtM1.D430DataChange(Sender: TObject;
  Field: TField);
{Per i dati liberi con descrizione imposto Hint}
var i: Integer;
begin
  //Ciclo sui dati liberi considerando solo quelli con la query per la descrizione
  for i:=1 to A002FAnagrafeVista.NumDatiLiberi do
    if DatiLiberi[i].Query <> nil then
    begin
      DatiLiberi[i].ECampo.Hint:=DatiLiberi[i].Query.FieldByName('DESCRIZIONE').AsString;
    end;
  //Imposto Hint = descrizione anche per il campo TIPORAPPORTO perchè la descrizione è molto lunga
  A002FAnagrafeGest.ETipoRapp.Hint:=Q430.FieldByName('D_TIPORAPPORTO').AsString;
  if (Field = nil) or ((Field.FieldKind = fkData) and (D430.State <> dsBrowse)) then
    RefreshFiltro(nil);
end;

procedure TA002FAnagrafeDtM1.Q030NewRecord(DataSet: TDataSet);
begin
  if (Parametri.DefTipoPersonale = 'E') and (Parametri.ModPersonaleEsterno = 'S') then
    Q030.FieldByName('TIPO_PERSONALE').AsString:='E'
  else
    Q030.FieldByName('TIPO_PERSONALE').AsString:='I';
end;

procedure TA002FAnagrafeDtM1.AggiornaCdCPercentualizzati;
var
  DataDecMod:TDateTime;
  Automatismo,ApriCdcPerc:Boolean;
  Risposta:Integer;

begin
  Automatismo:=False; //passato alla funzione per referenza
  if not A002FAnagrafeMW.VerificaCdCPercentualizzati(A002FAnagrafeGest.chkStoriciPrec.Checked,A002FAnagrafeGest.chkStoriciSucc.Checked, StrToDate(A002FAnagrafeGest.cmbDateDecorrenza.Items[0]), DataDecMod,Automatismo) then
  begin
    ApriCdcPerc:=False;
    //Chiedo se intervenire sui centri di costo, manualmente o automaticamente
    if not Automatismo then
      ApriCdcPerc:=R180MessageBox(A000MSG_A002_DLG_CDC_MANUALE,'DOMANDA') = mrYes
    else
    begin
      Risposta:=R180MessageBox(A000MSG_A002_DLG_CDC_AUTOMATICO,'DOMANDA_ESCI');
      //Se l'intervento è automatico, elimino le percentualizzazioni successive al giorno prima dell'intero periodo modificato sulla T430
      if Risposta = mrYes then
      begin
        A002FAnagrafeMW.updT433.SetVariable('PROGRESSIVO',Q430Progressivo.AsInteger);
        A002FAnagrafeMW.updT433.SetVariable('DATADECORRENZA_MOD',DataDecMod);
        A002FAnagrafeMW.updT433.Execute;
      end;
      ApriCdcPerc:=Risposta = mrNo;
    end;
    //Se l'intervento è manuale, apro la maschera dei centri di costo percentualizzati
    if ApriCdcPerc then
      A002FAnagrafeVistaPadre.actCdcPercentExecute(A002FAnagrafeVistaPadre.actCdcPercent);
  end;
end;

end.

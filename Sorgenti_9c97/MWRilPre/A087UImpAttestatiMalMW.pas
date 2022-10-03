unit A087UImpAttestatiMalMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle, ActiveX,
  xmldom, XMLIntf, msxmldom, XMLDoc, DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, A004UGiustifAssPresMW, C180FunzioniGenerali,
  IOUtils, A000UMessaggi, QueryStorico, Generics.Collections;

type
  TA087Evt = procedure of object;
  TA087Abil = procedure(Abilita:Boolean) of object;
  TA087Check = function :Boolean of object;
  TA087GetParam = function :String of object;

  {* Dichiarazione tipi *}
  TChain = record
    OnlyChain, ChainCod, ChainCod133:String;
  end;

  TRecAttestato = record
    Tipo_Elemento, ID_Certificato:string;
    Anomalia:boolean;
  end;

  TSwapAttestato = record
    ID_Certificato:string;
    Indice, Ordine:Integer;
  end;

  TListaCausali = record
    NomeCausale, TipoCausale:string;
  end;

  {* Dichiarazione oggetti *}
  TA087EditCertificato = class
  private
    EditFile, EditRecord:Boolean;
    selT048Old:TOracleDataSet;
    updT048, delT048:TOracleQuery;
    vIDCertificatoNew:string;
    procedure IniSelT048Old;
    procedure IniUpdT048;
    procedure IniDelT048;
  public
    procedure T048Post;
    procedure OpenSelT048Old(IDCertificatoOld,IDCertificatoNew:string);
    procedure SetCampo(Nome, Valore:string); overload;
    procedure SetCampo(Nome:string; Valore:TDateTime); overload;
    procedure DelCertificatoTemp(ID:string);
    constructor create;
    destructor destroy; override;
  end;

  TA087InfoCertificati = class
  private
    T265F_GetCatena:TOracleQuery;
    selAllCausProfilo:TOracleDataSet;
    ListaCausali:TStringList;
    procedure Ini_T265F_GetCatena;
    procedure Ini_selAllCausProfilo;
    procedure GetLista;
    procedure AddRecCaus(MyCaus:string);
  public
    constructor Create; overload;
    constructor Create(OSession:TOracleSession); overload;
    destructor  Destroy; override;
    function EsisteCausale(MyCaus:string):Boolean;
    function GetCatenaCaus(causale:string):TChain;
  end;

  TA087FImpAttestatiMalMW = class(TR005FDataModuleMW)
    selEsenzioni: TOracleQuery;
    selT040_del: TOracleDataSet;
    selT048: TOracleDataSet;
    selT030: TOracleDataSet;
    InsT048: TOracleQuery;
    delT048: TOracleQuery;
    selT040: TOracleDataSet;
    delT040: TOracleQuery;
    updT048: TOracleQuery;
    selT048ContinuaMal: TOracleQuery;
    selT480: TOracleDataSet;
    XMLDoc: TXMLDocument;
    dscLookT265: TDataSource;
    dscT265_All: TDataSource;
    selT265_All: TOracleDataSet;
    dscT265: TDataSource;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    selT265TIPOCUMULO: TStringField;
    cdsLookT265: TClientDataSet;
    cdsLookT265CODICE: TStringField;
    cdsLookT265D_CODICE: TStringField;
    cdsLookT265CODICE_ALL: TStringField;
    cdsLookT265D_CODICE_ALL: TStringField;
    cdsLookT265CODICE_RICOVERO: TStringField;
    cdsLookT265DESC_RICOVERO: TStringField;
    cdsLookT265CODICE_POSTRIC: TStringField;
    cdsLookT265DESC_POSTRIC: TStringField;
    cdsLookT265CODICE_TSALVAVITA: TStringField;
    cdsLookT265DESC_TSALVAVITA: TStringField;
    cdsLookT265CODICE_SERVIZIO: TStringField;
    cdsLookT265DESC_SERVIZIO: TStringField;
    CDtsTemp: TClientDataSet;
    selT269: TOracleDataSet;
    dtsT269: TDataSource;
    selT269CODICE: TStringField;
    selT269FILTRO: TStringField;
    selT269CAUS_INSERIMENTO: TStringField;
    selT269CAUS_PROVVISORIA: TStringField;
    selT269CAUS_RICOVERO: TStringField;
    selT269CAUS_POSTRICOVERO: TStringField;
    selT269CAUS_SALVAVITA: TStringField;
    selT269CAUS_SERVIZIO: TStringField;
    selT269POSTRICOVERO_AUTO: TStringField;
    GetPostRicovero: TOracleQuery;
    selT269CAUS_PATGRAVI: TStringField;
    selT048CancMan: TOracleDataSet;
    selT048CancManCOGNOME: TStringField;
    selT048CancManNOME: TStringField;
    selT048CancManID_CERTIFICATO: TStringField;
    selT048CancManDATA_INIZIO_MAL: TDateTimeField;
    selT048CancManDATA_FINE_MAL: TDateTimeField;
    selT048CancManTIPO_ELEMENTO: TStringField;
    selT048CancManTIPO_CERTIFICATO: TStringField;
    selT048CancManTIPO_RICOVERO: TStringField;
    selT048CancManAGEVOLAZIONI: TStringField;
    selT048CancManCAUSALE_MALATTIA: TStringField;
    selT048CancManTIPO_GESTIONE: TStringField;
    selT048CancManDESCRIZIONE: TStringField;
    selT048CancManPROGRESSIVO: TFloatField;
    ScriptIDPrecedente: TOracleQuery;
    updT040: TOracleQuery;
    selT048CancManDATA_RILASCIO: TDateTimeField;
    selT048CancManDATA_CONSEGNA: TDateTimeField;
    selT048CancManCAUSA_MALATTIA: TStringField;
    selT048CancManDescTCertificato: TStringField;
    selT048CancManDescTRicovero: TStringField;
    selT048CancManDescAgevolazioni: TStringField;
    selT048CancManDescCausaMal: TStringField;
    CDtsTXTFile: TClientDataSet;
    CDtsTXTFileMATRICOLA: TStringField;
    CDtsTXTFileANNO_INIZIO: TStringField;
    CDtsTXTFileMESE_INIZIO: TStringField;
    CDtsTXTFileGIORNO_INIZIO: TStringField;
    CDtsTXTFileANNO_FINE: TStringField;
    CDtsTXTFileMESE_FINE: TStringField;
    CDtsTXTFileGIORNO_FINE: TStringField;
    CDtsTXTFileCAUSALE_MAL: TStringField;
    CDtsTXTFileNPROTOCOLLO: TStringField;
    CDtsTXTFileTIPO_FRUIZIONE: TStringField;
    CDtsTXTFileTIPO_REGISTRAZIONE: TStringField;
    CDtsTXTFileNOTE: TStringField;
    CDtsTXTFileID_FILETXT: TStringField;
    updT048NoteNProt: TOracleQuery;
    ScriptContaGGPrecedenti: TOracleQuery;
    selT048CancManID_CERTIFICATO2: TStringField;
    selT048CancManCOGNOME_REP: TStringField;
    selT048CancManVIA_REP: TStringField;
    selT048CancManCAP_REP: TStringField;
    selT048CancManCODCATASTALE_REP: TStringField;
    selT048CancManPROV_REP: TStringField;
    selT048CancManCIVICO_REP: TStringField;
    selT048CancManNOTE: TStringField;
    selT048CancManDescTGestione: TStringField;
    selT269CAUS_GRAVIDANZA: TStringField;
    selT048CancManID_CERTFICATO_RETT: TStringField;
    selT048CancManDescIdCertificatoRett: TStringField;
    selCertificatiRett: TOracleDataSet;
    selT269STATO_CAUSA_MALATTIA: TStringField;
    selDatoAnagrafico: TOracleDataSet;
    selT265DettCAssenza: TOracleDataSet;
    selT048Info: TOracleDataSet;
    selT048InfoDATA_INIZIO_MAL: TDateTimeField;
    selT048InfoDATA_FINE_MAL: TDateTimeField;
    selT048InfoTIPO_CERTIFICATO: TStringField;
    selT048InfoD_TIPO_CERTIFICATO: TStringField;
    selT048InfoDATA_RILASCIO: TDateTimeField;
    selT048InfoID_CERTIFICATO: TStringField;
    selT048InfoCOGNOME_REP: TStringField;
    selT048InfoVIA_REP: TStringField;
    selT048InfoCIVICO_REP: TStringField;
    selT048InfoCAP_REP: TStringField;
    selT048InfoCODCATASTALE_REP: TStringField;
    selT048InfoPROV_REP: TStringField;
    selT048InfoMATRICOLA_INPS: TStringField;
    selT048InfoCOD_SEDE_INPDAP: TStringField;
    selT048InfoGIORNATALAVORATA: TStringField;
    selT048InfoTRAUMA: TStringField;
    selT048InfoTIPO_RICOVERO: TStringField;
    selT048InfoD_TIPO_RICOVERO: TStringField;
    selT048InfoAGEVOLAZIONI: TStringField;
    selT048InfoD_AGEVOLAZIONI: TStringField;
    selT048InfoPROGRESSIVO: TFloatField;
    selT048InfoTIPO_ELEMENTO: TStringField;
    selT048InfoCOGNOME: TStringField;
    selT048InfoDATA_REGISTRAZIONE: TDateTimeField;
    selT048InfoOPERATORE: TStringField;
    selT048InfoCAUSALE_MAL: TStringField;
    selT048InfoCOD_FISCALE_AZIENDA: TStringField;
    selT048InfoCOD_FISCALE_MED: TStringField;
    selT048InfoCOGNOME_MED: TStringField;
    selT048InfoNOME_MED: TStringField;
    selT048InfoCOD_REGIONE: TStringField;
    selT048InfoCOD_ASL: TStringField;
    selT048InfoCOD_FISCALE: TStringField;
    selT048InfoNOME: TStringField;
    selT048InfoSESSO: TStringField;
    selT048InfoDATA_NAS: TDateTimeField;
    selT048InfoCODCATASTALE_NAS: TStringField;
    selT048InfoPROV_NAS: TStringField;
    selT048InfoVIA_DOM: TStringField;
    selT048InfoCAP_DOM: TStringField;
    selT048InfoCODCATASTALE_DOM: TStringField;
    selT048InfoPROV_DOM: TStringField;
    selT048InfoCOD_DIAGNOSI: TStringField;
    selT048InfoTESTO_DIAGNOSI: TStringField;
    selT048InfoID_CERTIFICATO_RETT: TStringField;
    selT048InfoELABORATO: TStringField;
    selT048InfoCIVICO_DOM: TStringField;
    selT048InfoRUOLOMEDICO: TStringField;
    selT048InfoCODSTRUTTURA_MED: TStringField;
    selT048InfoDATA_FINEPOSTRIC: TDateTimeField;
    selT048InfoCAUSALE_POSTRIC: TStringField;
    selT048InfoDATA_CONSEGNA: TDateTimeField;
    selT048InfoCAUSA_MALATTIA: TStringField;
    selT048InfoTIPO_GESTIONE: TStringField;
    selT048InfoNUM_PROTOCOLLO: TStringField;
    selT048InfoNOTE: TStringField;
    selT048InfoTIPO_REGISTRAZIONE: TStringField;
    selT048InfoID_FILETXT: TStringField;
    selT048InfoID_FILEXML: TFloatField;
    procedure cdsLookT265D_CODICE_ALLValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDtsTempFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT048CancManCalcFields(DataSet: TDataSet);
  private
    vetCertifAnomalie: TStringList;
    vetCertifAcquisiti: TStringList;
    GestContinuazione:TA087InfoCertificati;
    procedure SortCertificati;
    procedure EstraiXML(NodoIN:IXMLNodeList;NPrev:String);
    procedure CreaAnomalia(TestoAnomalia:String;Prog:integer = 0;ID_Certificato:string = '');
    procedure InizializzaCDataSet(NodoIn:IXMLNodeList; NPrev:String);
    procedure PulisciR600;
    function ControlloPeriodiRapporto: boolean;
    function ConvData(DataIn:Variant): TDateTime;
    function ConvBool(BoolIn:Variant): String;
    function GetProfilo(MyProgr:integer):Boolean;
    function getCausaleDaProfilo(MyProgr:integer):string;
    function GetCampo(CDts: String): Variant;
    //Property
    procedure setNumProtocollo(val:string);
    function getNumProtocollo:string;
    procedure setCausaleMal(val:string);
    function getCausaleMal:string;
    procedure setIDCertificato(val:string);
    function getIDCertificato:string;
    procedure setProgressivo(val:integer);
    function getProgressivo:integer;
    procedure setDataInizioMal(val:TDateTime);
    function getDataInizioMal:TDateTime;
    procedure setDataFineMal(val:TDateTime);
    function getDataFineMal:TDateTime;
    procedure setDataInizioMalStr(val:string);
    function getDataInizioMalStr:string;
    procedure setDataFineMalStr(val:string);
    function getDataFineMalStr:string;
    procedure setTipoElemento(val:string);
    function getTipoElemento:string;
    procedure setTipoRicovero(val:string);
    function getTipoRicovero:string;
    procedure setTipoGestione(val:string);
    function getTipoGestione:string;
    procedure setTipoCertificato(val:string);
    function getTipoCertificato:string;
    procedure setTipoRegistrazione(val:string);
    function getTipoRegistrazione:string;
    procedure setAgevolazioni(val:string);
    function getAgevolazioni:string;
    procedure setDataConsegnaStr(val:string);
    function getDataConsegnaStr:string;
    procedure setDataRilascioStr(val:string);
    function getDataRilascioStr:string;
    procedure setCausaMalattia(val:string);
    function getCausaMalattia:string;
    procedure setNote(val:string);
    function getNote:string;
    procedure setRepVia(val:string);
    function getRepVia:string;
    procedure setRepCognome(val:string);
    function getRepCognome:string;
    procedure setRepCAP(val:string);
    function getRepCAP:string;
    procedure setRepCodCatastale(val:string);
    function getRepCodCatastale:string;
    procedure setRepProv(val:string);
    function getRepProv:string;
  public
    A004MW: TA004FGiustifAssPresMW;
    BloccoAnomalia, DipInclusi:Boolean;
    StatoOperazione:string;
    VetAttestato:array of TRecAttestato;
    evtAnomalieChecked: TA087Check;
    evtIsValidChkEsenzione: TA087Check;
    evtInserimentoChecked: TA087Check;
    evtGetPathFile: TA087GetParam;
    evtInitProgressBar: TA087Evt;
    evtProgressBarStepIt: TA087Evt;
    evtInitProgressBarTXT: TA087Evt;
    evtProgressBarStepItTXT: TA087Evt;
    evtAbilCmbCausaleAll: TA087Abil;
    IDCertificatoModificato:String;
    procedure InsDipT040;
    procedure InsDipT048;
    function InsDipTXT:Boolean;
    procedure OpenSelT048CancMan;
    procedure ElaboraDipendente(CurrDip: Integer);
    procedure InizializzaR600;
    procedure LeggiFileXML(RegAnom:Boolean);
    function LeggiFileTXT(FilePath:string):string;
    //function GetCampo(CDts: String): Variant;
    function ColoraCella: TColor;
    function TestFiltroProfili:Boolean;
    function getCausaMalDaAnagrafico(MyProg:integer; MyDataIni,MyDataFine:TDateTime):string;
    procedure TestNumProtocollo(NumProtocollo:string);
    function IDIsRett(ID:string):Boolean;
    //Inserimento manuale periodo
    property Progressivo:integer read getProgressivo write setProgressivo;
    property CausaleMal:string read getCausaleMal write setCausaleMal;
    property NumProtocollo:string read getNumProtocollo write setNumProtocollo;
    property IDCertificato:string read getIDCertificato write setIDCertificato;
    property DataInizioMal:TDateTime read getDataInizioMal write setDataInizioMal;
    property DataFineMal:TDateTime read getDataFineMal write setDataFineMal;
    property DataInizioMalStr:string read getDataInizioMalStr write setDataInizioMalStr;
    property DataFineMalStr:string read getDataFineMalStr write setDataFineMalStr;
    property TipoElemento:string read getTipoElemento write setTipoElemento;
    property TipoRicovero:string read getTipoRicovero write setTipoRicovero;
    property TipoGestione:string read getTipoGestione write setTipoGestione;
    property TipoCertificato:string read getTipoCertificato write setTipoCertificato;
    property TipoRegistrazione:string read getTipoRegistrazione write setTipoRegistrazione;
    property Agevolazioni:string read getAgevolazioni write setAgevolazioni;
    property DataConsegnaStr:string read getDataConsegnaStr write setDataConsegnaStr;
    property DataRilascioStr:string read getDataRilascioStr write setDataRilascioStr;
    property CausaMalattia:string read getCausaMalattia write setCausaMalattia;
    property Note:string read getNote write setNote;
    property RepVia:string read getRepVia write setRepVia;
    property RepCognome:string read getRepCognome write setRepCognome;
    property RepCodCatastale:string read getRepCodCatastale write setRepCodCatastale;
    property RepCAP:string read getRepCAP write setRepCAP;
    property RepProv:string read getRepProv write setRepProv;
    procedure setNumProtocolloRett(val:string);
    function AgevolazioniCodToDesc(Codice:string):String;
    function T048FileTXTToT048:boolean;
    function ContaGiorniConsegutivi:integer;
    function T048InserisciPerido:boolean;
    function T048CancellaPerido(ID:string):boolean;
  end;

implementation

{$R *.dfm}

{Implementazione classe TA087EditCertificato}

constructor TA087EditCertificato.create;
begin
  IniSelT048Old;
  IniUpdT048;
  IniDelT048;
end;

destructor TA087EditCertificato.destroy;
begin
  FreeAndNil(selT048Old);
  FreeAndNil(updT048);
  FreeAndNil(delT048);
end;

procedure TA087EditCertificato.IniSelT048Old;
begin
  {Estraggo i valori attuali presenti su tabella T048, per confrontarli
   su setValore con i nuovi dati in input}
  selT048Old:=TOracleDataSet.Create(nil);
  with selT048Old do
  begin
    Session:=SessioneOracle;
    SQL.Add('select T048.ID_FILETXT, T048.PROGRESSIVO, T048.DATA_FINE_MAL, T048.TIPO_CERTIFICATO,');
    SQL.Add('       T048.CAUSALE_MAL, T048.CAUSA_MALATTIA, T048.AGEVOLAZIONI, T048.NUM_PROTOCOLLO,');
    SQL.Add('       T048.NOTE, T048.DATA_RILASCIO, T048.DATA_CONSEGNA, T048.COGNOME_REP,');
    SQL.Add('       T048.VIA_REP, T048.CODCATASTALE_REP, T048.PROV_REP, T048.CAP_REP, T048.TIPO_GESTIONE,');
    SQL.Add('       T048.DATA_REGISTRAZIONE');
    SQL.Add('  from T048_ATTESTATIINPS T048');
    SQL.Add(' where (:ID_CERTIFICATO_OLD is not null and');
    SQL.Add('       (T048.ID_CERTIFICATO = :ID_CERTIFICATO_OLD))');
    SQL.Add('    or (:ID_CERTIFICATO_OLD is null and');
    SQL.Add('       (T048.ID_FILETXT =');
    SQL.Add('       (select ID_FILETXT');
    SQL.Add('          from T048_ATTESTATIINPS');
    SQL.Add('         where ID_CERTIFICATO = :ID_CERTIFICATO_NEW)) and');
    SQL.Add('       (T048.ID_CERTIFICATO <> :ID_CERTIFICATO_NEW))');
    DeclareVariable('ID_CERTIFICATO_NEW',otString);
    DeclareVariable('ID_CERTIFICATO_OLD',otString);
  end;
end;

procedure TA087EditCertificato.IniDelT048;
begin
  delT048:=TOracleQuery.Create(nil);
  delT048.Session:=SessioneOracle;
  delT048.SQL.Add('delete');
  delT048.SQL.Add('  from T048_ATTESTATIINPS T048');
  delT048.SQL.Add(' where T048.ID_CERTIFICATO = :ID_CERTIFICATO');
  delT048.DeclareVariable('ID_CERTIFICATO',otString);
end;

procedure TA087EditCertificato.IniUpdT048;
begin
  updT048:=TOracleQuery.Create(nil);
  updT048.Session:=SessioneOracle;
end;

procedure TA087EditCertificato.OpenSelT048Old(IDCertificatoOld,IDCertificatoNew:string);
begin
  vIDCertificatoNew:=IDCertificatoNew;
  EditFile:=IDCertificatoOLD.Trim.IsEmpty;//Se ID Certificato OLD è la modifica è da file altrimenti è manuale
  EditRecord:=False;
  updT048.SQL.Clear;
  updT048.ClearVariables;
  updT048.DeleteVariables;
  updT048.SQL.Add('update T048_ATTESTATIINPS T048 set');
  selT048Old.SetVariable('ID_CERTIFICATO_NEW',IDCertificatoNew);
  selT048Old.SetVariable('ID_CERTIFICATO_OLD',IDCertificatoOld);
  selT048Old.Open;
  if selT048Old.RecordCount <= 0 then
    raise Exception.Create(Format('ID certificato "%s" non trovato.',[IDCertificatoNew]));
end;

procedure TA087EditCertificato.SetCampo(Nome, Valore:string);
var
  SQLStr:string;
begin
  SQLStr:='';
  if (not Valore.IsEmpty or not EditFile) and
     (selT048Old.FieldByName(Nome).AsString <> Valore) then
  begin
    EditRecord:=True;
    if updT048.SQL.Count > 1 then
      SQLStr:=SQLStr + ', ';
    SQLStr:=SQLStr + 'T048.' + Nome + ' = :' + Nome;
    updT048.SQL.Add(SQLStr);
    updT048.DeclareAndSet(Nome,otString,Valore);
  end;
end;

procedure TA087EditCertificato.SetCampo(Nome:string; Valore:TDateTime);
var
  SQLStr:string;
begin
  SQLStr:='';
  if ((Valore <> DATE_NULL) or not EditFile) and
     (selT048Old.FieldByName(Nome).AsDateTime <> Valore) then
  begin
    EditRecord:=True;
    if updT048.SQL.Count > 1 then
      SQLStr:=SQLStr + ', ';
    SQLStr:=SQLStr + 'T048.' + Nome + ' = :' + Nome;
    updT048.SQL.Add(SQLStr);
    if Valore <> DATE_NULL then
      updT048.DeclareAndSet(Nome,otDate,Valore)
    else
      updT048.DeclareAndSet(Nome,otDate,NULL);
  end;
end;

procedure TA087EditCertificato.DelCertificatoTemp(ID:string);
begin
  delT048.ClearVariables;
  delT048.SetVariable('ID_CERTIFICATO',ID);
  delT048.Execute;
end;

procedure TA087EditCertificato.T048Post;
begin
  try
    if EditRecord then
    begin
      if EditFile then
      begin
        updT048.SQL.Add('where T048.PROGRESSIVO = :PROGRESSIVO');
        updT048.SQL.Add('  and T048.ID_FILETXT = :ID_FILETXT');
        updT048.SQL.Add('  and T048.TIPO_REGISTRAZIONE in (''N'',''M'')');
        updT048.DeclareAndSet('ID_FILETXT',otString,selT048Old.FieldByName('ID_FILETXT').AsString);
      end
      else
      begin
        updT048.SQL.Add('where T048.PROGRESSIVO = :PROGRESSIVO');
        updT048.SQL.Add('  and T048.ID_CERTIFICATO = :ID_CERTIFICATO_OLD');
        updT048.DeclareAndSet('ID_CERTIFICATO_OLD',otString,VarToStr(selT048Old.GetVariable('ID_CERTIFICATO_OLD')));
      end;
      updT048.DeclareAndSet('PROGRESSIVO',otInteger,selT048Old.FieldByName('PROGRESSIVO').AsInteger);
      if DebugHook <> 0 then
        updT048.Debug:=True;
      updT048.Execute;
    end;
  finally
    DelCertificatoTemp(vIDCertificatoNew);
  end;
end;

{-------------------------------------------}

{Implementazione classe TA087ContinuazioneCertificati}

constructor TA087InfoCertificati.Create;
begin
  ListaCausali:=TStringList.Create;
  T265F_GetCatena:=TOracleQuery.Create(nil);
  selAllCausProfilo:=TOracleDataSet.Create(nil);
  T265F_GetCatena.Session:=SessioneOracle;
  selAllCausProfilo.Session:=SessioneOracle;
  GetLista;
end;

constructor TA087InfoCertificati.Create(OSession:TOracleSession);
begin
  ListaCausali:=TStringList.Create;
  T265F_GetCatena:=TOracleQuery.Create(nil);
  selAllCausProfilo:=TOracleDataSet.Create(nil);
  T265F_GetCatena.Session:=OSession;
  selAllCausProfilo.Session:=OSession;
  GetLista;
end;

destructor TA087InfoCertificati.Destroy;
begin
  FreeAndNil(ListaCausali);
  FreeAndNil(T265F_GetCatena);
  FreeAndNil(selAllCausProfilo);
  inherited;
end;

procedure TA087InfoCertificati.Ini_T265F_GetCatena;
begin
  T265F_GetCatena.SQL.Clear;
  T265F_GetCatena.DeleteVariables;
  with T265F_GetCatena.SQL do
  begin
    Add('declare');
    Add(' S varchar2(2000);');
    Add('begin');
    Add(' T265F_GETCATENA(:C, :CHAIN, :CHAIN_L133, :C_CONSIDERATE);');
    Add(' select CODCAU1||decode(CODCAU1,'''','''','','')||CODCAU2 into :CCOD');
    Add('   from T265_CAUASSENZE');
    Add('  where CODICE = :C;');
    Add(' exception');
    Add('   when NO_DATA_FOUND then');
    Add('     null;');
    Add('end;');
  end;
  T265F_GetCatena.DeclareVariable('C',otString);
  T265F_GetCatena.DeclareVariable('CHAIN',otString);
  T265F_GetCatena.DeclareVariable('CHAIN_L133',otString);
  T265F_GetCatena.DeclareVariable('C_CONSIDERATE',otString);
  T265F_GetCatena.DeclareVariable('CCOD',otString);
end;

procedure TA087InfoCertificati.Ini_selAllCausProfilo;
begin
  selAllCausProfilo.SQL.Clear;
  with selAllCausProfilo.SQL do
  begin
    Add('select T269.*');
    Add('  from T269_RELAZIONI_ATTESTATIINPS T269');
    Add(' order by decode(T269.FILTRO,null,1,0), T269.CODICE');
  end;
end;

function TA087InfoCertificati.EsisteCausale(MyCaus:string):Boolean;
begin
  Result:=ListaCausali.IndexOf(MyCaus) >= 0;
end;

procedure TA087InfoCertificati.AddRecCaus(MyCaus:string);
begin
  if MyCaus.Trim.IsEmpty then
    Exit;
  if not EsisteCausale(MyCaus) then
    ListaCausali.Add(MyCaus);
end;

procedure TA087InfoCertificati.GetLista;
var
  MyCaus:TListaCausali;
begin
  Ini_selAllCausProfilo;
  selAllCausProfilo.Open;
  ListaCausali.Clear;
  while Not selAllCausProfilo.Eof do
  begin
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_INSERIMENTO').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_RICOVERO').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_POSTRICOVERO').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_SALVAVITA').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_SERVIZIO').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_PATGRAVI').AsString);
    AddRecCaus(selAllCausProfilo.FieldByName('CAUS_GRAVIDANZA').AsString);
    selAllCausProfilo.Next;
  end;
end;

function TA087InfoCertificati.GetCatenaCaus(Causale:string):TChain;
begin
  Ini_T265F_GetCatena;
  T265F_GetCatena.ClearVariables;
  T265F_GetCatena.SetVariable('C',Causale);
  T265F_GetCatena.Execute;
  Result.OnlyChain:=VarToStr(T265F_GetCatena.GetVariable('CHAIN'));
  if not VarToStr(T265F_GetCatena.GetVariable('CCOD')).IsEmpty then
    Result.ChainCod:=Result.OnlyChain + ',' + VarToStr(T265F_GetCatena.GetVariable('CCOD'));
  if not VarToStr(T265F_GetCatena.GetVariable('CHAIN_L133')).IsEmpty then
    Result.ChainCod133:=Result.ChainCod + ',' + VarToStr(T265F_GetCatena.GetVariable('CHAIN_L133'));
end;
{====================================================}

{Implementazione classe TInserimentoPeriodo}

procedure TA087FImpAttestatiMalMW.setRepProv(val:string);
begin
  InsT048.SetVariable('PROV_REP',val);
end;

function TA087FImpAttestatiMalMW.getRepProv:string;
begin
  Result:=InsT048.GetVariable('PROV_REP');
end;

function TA087FImpAttestatiMalMW.IDIsRett(ID:string):Boolean;
begin
  Result:=selCertificatiRett.SearchRecord('ID_CERTIFICATO',selT048CancMan.FieldByName('ID_CERTIFICATO').AsString,[srFromBeginning]);
end;

procedure TA087FImpAttestatiMalMW.setNumProtocolloRett(val:string);
begin
  if val.trim = ''then
    Exit;
  with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('declare');
      SQL.Add('  NUM_REC integer;');
      SQL.Add('begin');
      SQL.Add('  :RESULT:='''';');
      SQL.Add('  :ID_CERTIFICATO:='''';');
      //Test per verificare se il certificato è già stato rettificato
      SQL.Add('  select count(*) into NUM_REC');
      SQL.Add('    from T048_ATTESTATIINPS T048_1, T048_ATTESTATIINPS T048_2');
      SQL.Add('   where T048_1.NUM_PROTOCOLLO = :NUM_PROTOCOLLO');
      SQL.Add('     and T048_1.PROGRESSIVO = :PROGRESSIVO');
      SQL.Add('     and T048_1.ID_CERTIFICATO = T048_2.ID_CERTIFICATO_RETT;');
      SQL.Add('  if NUM_REC > 0 then');
      SQL.Add('    :RESULT:=''Numero protocollo "''||:NUM_PROTOCOLLO||''" già rettificato.'';');
      SQL.Add('    return;');
      SQL.Add('  end if;');
      //Test su esistenza numero di protocollo da rettificare
      SQL.Add('  select count(*) into NUM_REC');
      SQL.Add('    from T048_ATTESTATIINPS T048');
      SQL.Add('   where T048.NUM_PROTOCOLLO = :NUM_PROTOCOLLO;');
      SQL.Add('  if NUM_REC <= 0 then');
      SQL.Add('    :RESULT:=''Numero protocollo "''||:NUM_PROTOCOLLO||''" da rettificare non trovato.'';');
      SQL.Add('    return;');
      SQL.Add('  elsif NUM_REC > 1 then');
      SQL.Add('    :RESULT:=''Numero protocollo "''||:NUM_PROTOCOLLO||''" da rettificare associato a più periodi d''''assenza.'';');
      SQL.Add('    return;');
      SQL.Add('  end if;');
      SQL.Add('  select T048.ID_CERTIFICATO into :ID_CERTIFICATO');
      SQL.Add('    from T048_ATTESTATIINPS T048');
      SQL.Add('   where T048.NUM_PROTOCOLLO = :NUM_PROTOCOLLO;');
      SQL.Add('end;');
      DeclareVariable('RESULT',otString);
      DeclareVariable('ID_CERTIFICATO',otString);
      DeclareAndSet('PROGRESSIVO',otInteger,Progressivo);
      DeclareAndSet('NUM_PROTOCOLLO',otString,val);
      Execute;
      if not VarToStr(GetVariable('RESULT')).IsEmpty then
        raise Exception.Create(VarToStr(GetVariable('RESULT')));
      InsT048.SetVariable('ID_CERTIFICATO_RETT',VarToStr(GetVariable('ID_CERTIFICATO')));
    finally
      Free;
    end;
end;

procedure TA087FImpAttestatiMalMW.setRepCodCatastale(val:string);
begin
  InsT048.SetVariable('CODCATASTALE_REP',val);
end;

function TA087FImpAttestatiMalMW.getRepCodCatastale:string;
begin
  Result:=InsT048.GetVariable('CODCATASTALE_REP');
end;

procedure TA087FImpAttestatiMalMW.setRepCAP(val:string);
begin
  InsT048.SetVariable('CAP_REP',val);
end;

function TA087FImpAttestatiMalMW.getRepCAP:string;
begin
  Result:=InsT048.GetVariable('CAP_REP');
end;

procedure TA087FImpAttestatiMalMW.setRepCognome(val:string);
begin
  InsT048.SetVariable('COGNOME_REP',val);
end;

function TA087FImpAttestatiMalMW.GetRepCognome:string;
begin
  Result:=InsT048.GetVariable('COGNOME_REP');
end;

procedure TA087FImpAttestatiMalMW.setRepVia(val:string);
begin
  InsT048.SetVariable('VIA_REP',Val);
end;

function TA087FImpAttestatiMalMW.getRepVia:string;
begin
  Result:=InsT048.GetVariable('VIA_REP');
end;

procedure TA087FImpAttestatiMalMW.setNote(val:string);
begin
  InsT048.SetVariable('NOTE',val);
end;

function TA087FImpAttestatiMalMW.getNote:string;
begin
  Result:=VarToStr(InsT048.GetVariable('NOTE'));
end;

function TA087FImpAttestatiMalMW.getCausaleDaProfilo(MyProgr:integer):string;
begin
  Result:='';
  GetProfilo(MyProgr);
  Result:=selT269.FieldByName('CAUS_INSERIMENTO').AsString;
  if VarToStr(InsT048.GetVariable('TIPO_RICOVERO')) <> '' then
    Result:=selT269.FieldByName('CAUS_RICOVERO').AsString;
  if VarToStr(InsT048.GetVariable('AGEVOLAZIONI')) = 'T' then
    Result:=selT269.FieldByName('CAUS_SALVAVITA').AsString;
  if CausaMalattia = 'G' then
    Result:=selT269.FieldByName('CAUS_GRAVIDANZA').AsString
  else if CausaMalattia = 'S' then
    Result:=selT269.FieldByName('CAUS_PATGRAVI').AsString
  else if TipoElemento = 'D' then
    Result:=selT269.FieldByName('CAUS_POSTRICOVERO').AsString;
  if Result.IsEmpty then
    raise Exception.Create(A000MSG_A087_MSG_NO_CAUS_ASSOCIATA);
end;

procedure TA087FImpAttestatiMalMW.setProgressivo(val:integer);
begin
  if not TestFiltroProfili then
    raise Exception.Create(A000MSG_A087_MSG_NO_PROFILI_ABILITATI);
  insT048.SetVariable('PROGRESSIVO',val);
end;

function TA087FImpAttestatiMalMW.getProgressivo:integer;
begin
  if insT048.GetVariable('PROGRESSIVO') <> null then
    Result:=insT048.GetVariable('PROGRESSIVO')
  else
    Result:=0;
end;

procedure TA087FImpAttestatiMalMW.setCausaleMal(val:string);
begin
  InsT048.SetVariable('CAUSALE_MAL',val);
end;

function TA087FImpAttestatiMalMW.getCausaleMal:string;
begin
  Result:=VarToStr(InsT048.GetVariable('CAUSALE_MAL'));
end;

procedure TA087FImpAttestatiMalMW.setNumProtocollo(val:string);
begin
  InsT048.SetVariable('NUM_PROTOCOLLO',Copy(val.Trim.Replace(' ','',[rfReplaceAll]),1,10));
end;

function TA087FImpAttestatiMalMW.getNumProtocollo:string;
begin
  Result:=VarToStr(InsT048.GetVariable('NUM_PROTOCOLLO'));
end;

procedure TA087FImpAttestatiMalMW.setIDCertificato(val:string);
var
  MyOQry:TOracleQuery;
begin
  if val.Trim.IsEmpty then
  begin
    MyOQry:=TOracleQuery.Create(nil);
    try
      MyOQry.Session:=SessioneOracle;
      with MyOQry do
      begin
        Session:=SessioneOracle;
        SQL.Add('declare');
        SQL.Add('begin');
        SQL.Add('  :IDCERTIFICATO:=''A''||lpad(to_char(T048_IDCERTIFICATO.nextval),9,''0'');');
        SQL.Add('end;');
        DeclareVariable('IDCERTIFICATO',otString);
        Execute;
        insT048.SetVariable('ID_CERTIFICATO',GetVariable('IDCERTIFICATO'));
      end;
    finally
      FreeAndNil(MyOQry);
    end;
  end
  else
    InsT048.SetVariable('ID_CERTIFICATO',val);
end;

function TA087FImpAttestatiMalMW.getIDCertificato;
begin
  Result:=InsT048.GetVariable('ID_CERTIFICATO');
end;

procedure TA087FImpAttestatiMalMW.setDataInizioMal(val:TDateTime);
begin
  if val = DATE_NULL then
    insT048.SetVariable('DATA_INIZIO_MAL',null)
  else
    insT048.SetVariable('DATA_INIZIO_MAL',val);
end;

function TA087FImpAttestatiMalMW.getDataInizioMal;
begin
  if insT048.GetVariable('DATA_INIZIO_MAL') = null then
    Result:=DATE_NULL
  else
    Result:=insT048.GetVariable('DATA_INIZIO_MAL');
end;

procedure TA087FImpAttestatiMalMW.setDataFineMal(val:TDateTime);
begin
  if val = DATE_NULL then
    insT048.SetVariable('DATA_FINE_MAL',null)
  else
    insT048.SetVariable('DATA_FINE_MAL',val);
end;

function TA087FImpAttestatiMalMW.getDataFineMal:TDateTime;
begin
  if insT048.GetVariable('DATA_FINE_MAL') = null then
    Result:=DATE_NULL
  else
    Result:=insT048.GetVariable('DATA_FINE_MAL');
end;

procedure TA087FImpAttestatiMalMW.setDataInizioMalStr(val:string);
var
  MyData:TDateTime;
begin
  if not TryStrToDateTime(val,MyData) then
    raise Exception.Create(A000MSG_A087_MSG_DATA_INI_NON_VALIDA);
  insT048.SetVariable('DATA_INIZIO_MAL',MyData);
end;

function TA087FImpAttestatiMalMW.getDataInizioMalStr:string;
begin
  Result:=DateToStr(insT048.GetVariable('DATA_INIZIO_MAL'));
end;

procedure TA087FImpAttestatiMalMW.setDataFineMalStr(val:string);
var
  MyData:TDateTime;
begin
  if not TryStrToDateTime(val,MyData) then
    raise Exception.Create(A000MSG_A087_MSG_DATA_FINE_NON_VALIDA);
  insT048.SetVariable('DATA_FINE_MAL',MyData);
end;

function TA087FImpAttestatiMalMW.getDataFineMalStr:string;
begin
  Result:=DateToStr(insT048.GetVariable('DATA_FINE_MAL'));
end;

procedure TA087FImpAttestatiMalMW.setTipoElemento(val:string);
begin
  InsT048.SetVariable('TIPO_ELEMENTO',val);
end;

function TA087FImpAttestatiMalMW.getTipoElemento:string;
begin
  Result:=VarToStr(InsT048.GetVariable('TIPO_ELEMENTO'));
end;

procedure TA087FImpAttestatiMalMW.setTipoRicovero(val:string);
begin
  InsT048.SetVariable('TIPO_RICOVERO',val);
end;

function TA087FImpAttestatiMalMW.getTipoRicovero:string;
begin
  Result:=InsT048.GetVariable('TIPO_RICOVERO');
end;

procedure TA087FImpAttestatiMalMW.setTipoGestione(val:string);
begin
  InsT048.SetVariable('TIPO_GESTIONE',val);
end;

function TA087FImpAttestatiMalMW.getTipoGestione:string;
begin
  Result:=InsT048.GetVariable('TIPO_GESTIONE');
end;

procedure TA087FImpAttestatiMalMW.setTipoCertificato(val:string);
begin
  InsT048.SetVariable('TIPO_CERTIFICATO',val);
end;

function TA087FImpAttestatiMalMW.getTipoCertificato:string;
begin
  Result:=InsT048.GetVariable('TIPO_CERTIFICATO');
end;

procedure TA087FImpAttestatiMalMW.setTipoRegistrazione(val:string);
begin
  InsT048.SetVariable('TIPO_REGISTRAZIONE',val);
end;

function TA087FImpAttestatiMalMW.getTipoRegistrazione:string;
begin
  Result:=InsT048.GetVariable('TIPO_REGISTRAZIONE');
end;

procedure TA087FImpAttestatiMalMW.setAgevolazioni(val:string);
begin
  InsT048.SetVariable('AGEVOLAZIONI',val);
end;

function TA087FImpAttestatiMalMW.getAgevolazioni:string;
begin
  Result:=InsT048.GetVariable('AGEVOLAZIONI');
end;

procedure TA087FImpAttestatiMalMW.setDataConsegnaStr(val:string);
var
  MyData:TDateTime;
begin
  if val.Trim <> '/  /' then
  begin
    if not TryStrToDateTime(val,MyData) then
      raise Exception.Create(A000MSG_A087_ERR_CONSEGNA_NON_VALIDA);
    insT048.SetVariable('DATA_CONSEGNA',MyData);
  end
  else
    insT048.SetVariable('DATA_CONSEGNA',null);
end;

function TA087FImpAttestatiMalMW.getDataConsegnaStr:string;
begin
  Result:=DateToStr(InsT048.GetVariable('DATA_CONSEGNA'));
end;

procedure TA087FImpAttestatiMalMW.setDataRilascioStr(val:string);
var
  MyData:TDateTime;
begin
  if val.Trim <> '/  /' then
  begin
    if not TryStrToDateTime(val,MyData) then
      raise Exception.Create(A000MSG_A087_ERR_RILASCIO_NON_VALIDO);
    insT048.SetVariable('DATA_RILASCIO',MyData);
  end
  else
    insT048.SetVariable('DATA_RILASCIO',null);
end;

function TA087FImpAttestatiMalMW.getDataRilascioStr:string;
begin
  Result:=DateToStr(InsT048.GetVariable('DATA_RILASCIO'));
end;

procedure TA087FImpAttestatiMalMW.selT048CancManCalcFields(DataSet: TDataSet);
begin
  inherited;
  with selT048CancMan do
  begin
    if FieldByName('TIPO_CERTIFICATO').AsString = 'I' then
      FieldByName('DescTCertificato').AsString:='Inserimento'
    else if FieldByName('TIPO_CERTIFICATO').AsString = 'C' then
      FieldByName('DescTCertificato').AsString:='Continuazione'
    else if FieldByName('TIPO_CERTIFICATO').AsString = 'R' then
      FieldByName('DescTCertificato').AsString:='Ricaduta';

    if FieldByName('TIPO_RICOVERO').AsString = 'R' then
      FieldByName('DescTRicovero').AsString:='Ricovero'
    else if FieldByName('TIPO_RICOVERO').AsString = 'H' then
      FieldByName('DescTRicovero').AsString:='Day hospital'
    else if FieldByName('TIPO_ELEMENTO').AsString = 'D' then
      FieldByName('DescTRicovero').AsString:='Post - Ricovero';

    if FieldByName('AGEVOLAZIONI').AsString = 'T' then
      FieldByName('DescAgevolazioni').AsString:='Terapia salva vita'
    else if FieldByName('AGEVOLAZIONI').AsString = 'C' then
      FieldByName('DescAgevolazioni').AsString:='Causa di servizio'
    else if FieldByName('AGEVOLAZIONI').AsString = 'I' then
      FieldByName('DescAgevolazioni').AsString:='Invalidità riconosciuta';

    if FieldByName('CAUSA_MALATTIA').AsString = 'G' then
      FieldByName('DescCausaMal').AsString:='Gravidanza'
    else if FieldByName('CAUSA_MALATTIA').AsString = 'S' then
      FieldByName('DescCausaMal').AsString:='Sclerosi e patologie docum.';

    if FieldByName('TIPO_GESTIONE').AsString = 'M' then
      FieldByName('DescTGestione').AsString:='Certificato Medico'
    else if FieldByName('TIPO_GESTIONE').AsString = 'E' then
      FieldByName('DescTGestione').AsString:='E-mail'
    else if FieldByName('TIPO_GESTIONE').AsString = 'T' then
      FieldByName('DescTGestione').AsString:='Telefonata '
    else if FieldByName('TIPO_GESTIONE').AsString = 'W' then
      FieldByName('DescTGestione').AsString:='APP';

    if not FieldByName('ID_CERTIFICATO_RETT').IsNull then
      FieldByName('DescIdCertificatoRett').AsString:=VarToStr(Lookup('ID_CERTIFICATO',FieldByName('ID_CERTIFICATO_RETT').asString,'NUM_PROTOCOLLO'));
  end;
end;

procedure TA087FImpAttestatiMalMW.setCausaMalattia(val:string);
begin
  insT048.SetVariable('CAUSA_MALATTIA',val);
end;

function TA087FImpAttestatiMalMW.getCausaMalattia:string;
begin
  Result:=VarToStr(InsT048.GetVariable('CAUSA_MALATTIA'));
end;

function TA087FImpAttestatiMalMW.ContaGiorniConsegutivi:integer;
begin
  with ScriptContaGGPrecedenti do
  begin
    if DataFineMal - DataInizioMal < 3 then
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',DataInizioMal);
      SetVariable('CAUSALE_MAL',getCausaleDaProfilo(Progressivo));
      Execute;
      Result:=GetVariable('NGGCONSEC');
    end
    else
      Result:=trunc(DataFineMal - DataInizioMal);
  end;
end;

function TA087FImpAttestatiMalMW.T048InserisciPerido:boolean;
begin
  SetLength(VetAttestato,0);
  if insT048.GetVariable('PROGRESSIVO') = 0 then
    raise Exception.Create(A000MSG_A087_MSG_NO_DIP_SELEZIONATI);
  insT048.SetVariable('DATA_REGISTRAZIONE',R180SysDate(SessioneOracle));
  insT048.SetVariable('OPERATORE',Parametri.Operatore);
  CausaleMal:=getCausaleDaProfilo(Progressivo);
  insT048.Execute;
  SetLength(VetAttestato,1);
  VetAttestato[0].Tipo_Elemento:=VarToStr(InsT048.GetVariable('TIPO_ELEMENTO'));
  VetAttestato[0].ID_Certificato:=VarToStr(InsT048.GetVariable('ID_CERTIFICATO'));
  VetAttestato[0].Anomalia:=False;
  {Inserisco all'interno dell'array il certificato per farlo elaborare dalla procedure
  Elabora Dipendete}
  ElaboraDipendente(0);
  IDCertificatoModificato:='';
  if not VetAttestato[0].Anomalia then
    SessioneOracle.Commit
  else
    SessioneOracle.Rollback;
  Result:=not VetAttestato[0].Anomalia;
end;

function TA087FImpAttestatiMalMW.T048CancellaPerido(ID:string):boolean;
var
  updT048:TOracleQuery;
begin
  Result:=False;
  SetLength(VetAttestato,0);
  if insT048.GetVariable('PROGRESSIVO') = null then
    raise Exception.Create(A000MSG_A087_MSG_NO_DIP_SELEZIONATI);

  updT048:=TOracleQuery.Create(Self);
  try
    with updT048 do
    begin
      Session:=SessioneOracle;
      SQL.Add('insert into T048_ATTESTATIINPS(ID_CERTIFICATO,TIPO_ELEMENTO,DATA_REGISTRAZIONE,OPERATORE,CAUSALE_MAL,PROGRESSIVO,TIPO_GESTIONE)');
      SQL.Add('values(:ID_CERTIFICATO,''C'',sysdate,:OPERATORE,:CAUSALE_MAL,:PROGRESSIVO,''M'')');
      DeclareVariable('ID_CERTIFICATO',otString);
      DeclareVariable('OPERATORE',otString);
      DeclareVariable('CAUSALE_MAL',otString);
      DeclareVariable('PROGRESSIVO',otInteger);
      SetVariable('ID_CERTIFICATO',ID);
      SetVariable('OPERATORE',Parametri.Operatore);
      SetVariable('CAUSALE_MAL','*');
      SetVariable('PROGRESSIVO',InsT048.GetVariable('PROGRESSIVO'));
      Execute;
    end;
    SetLength(VetAttestato,1);
    VetAttestato[0].Tipo_Elemento:='C';
    VetAttestato[0].ID_Certificato:=ID;
    VetAttestato[0].Anomalia:=False;
    ElaboraDipendente(0);
    if not VetAttestato[0].Anomalia then
    begin
      with updT048 do
      begin
        Session:=SessioneOracle;
        SQL.Clear;
        DeleteVariables;
        SQL.Add('delete');
        SQL.Add('  from T048_ATTESTATIINPS T048');
        SQL.Add(' where T048.ID_CERTIFICATO = :ID_CERTIFICATO');
        DeclareVariable('ID_CERTIFICATO',otString);
        SetVariable('ID_CERTIFICATO',ID);
        Execute;
      end;
      SessioneOracle.Commit;
      Result:=True;
    end
    else
    begin
      SessioneOracle.Rollback;
      Result:=False;
    end;
  finally
    FreeAndNil(updT048);
  end;
end;

{==========================================}

procedure TA087FImpAttestatiMalMW.DataModuleCreate(Sender: TObject);
begin
  if not SessioneOracle.Connected then
  begin
    {$IFNDEF IRISWEB}
    if Password(Application.Name) = -1 then
      Application.Terminate;
    A000ParamDBOracle(SessioneOracle);
    {$ENDIF}
  end;
  inherited;
  vetCertifAnomalie:=TStringList.Create;
  vetCertifAcquisiti:=TStringList.Create;

  GestContinuazione:=TA087InfoCertificati.Create(SessioneOracle);
  IDCertificatoModificato:='';

  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  with A004MW do
  begin
    chkNuovoPeriodo:=False;
    GestioneSingolaDM:=True;
    AnomalieInterattive:=False;
    EseguiCommit:=False;
    R600DtM1.VisualizzaAnomalie:=False;
    Chiamante:='A087';
  end;
  selT269.Open;
  selT480.Open;
  //selT265.Open;
  //selT265_All.Open;
  selCertificatiRett.Open;
  OpenSelT048CancMan;
  cdsLookT265.CreateDataSet;
end;

function TA087FImpAttestatiMalMW.LeggiFileTXT(FilePath:string):string;
var
  MyString:string;

  procedure ElaboraRiga(InString:string);
  begin
    with CDtsTXTFile do
      try
        if Not(State in [dsInsert, dsEdit]) then
          Append;
        FieldByName('MATRICOLA').AsString:=Copy(InString,1,10);
        FieldByName('ANNO_INIZIO').AsString:=Copy(InString,11,4);
        FieldByName('MESE_INIZIO').AsString:=Copy(InString,15,2);
        FieldByName('GIORNO_INIZIO').AsString:=Copy(InString,17,2);
        FieldByName('ANNO_FINE').AsString:=Copy(InString,19,4);
        FieldByName('MESE_FINE').AsString:=Copy(InString,23,2);
        FieldByName('GIORNO_FINE').AsString:=Copy(InString,25,2);
        FieldByName('CAUSALE_MAL').AsString:=Copy(InString,27,4);
        FieldByName('NPROTOCOLLO').AsString:=Copy(InString,31,100);
        FieldByName('TIPO_FRUIZIONE').AsString:=Copy(InString,131,1);
        FieldByName('TIPO_REGISTRAZIONE').AsString:=Copy(InString,132,1);
        FieldByName('NOTE').AsString:=Copy(InString,133,512);
        FieldByName('ID_FILETXT').AsString:=Copy(InString,645,14);
        Post;
      except
        on E:exception do
          raise Exception.Create(E.Message);
      end;
  end;

begin
  Result:='';
  try
    CDtsTXTFile.Close;
    CDtsTXTFile.CreateDataSet;
    CDtsTXTFile.Open;
    CDtsTXTFile.DisableControls;
    for MyString in TFile.ReadAllLines(FilePath) do
      ElaboraRiga(MyString);
    CDtsTXTFile.First;
    CDtsTXTFile.EnableControls;
  except
    on E:exception do
      Result:=e.Message;
  end;
end;

function TA087FImpAttestatiMalMW.getCausaMalDaAnagrafico(MyProg:integer; MyDataIni,MyDataFine:TDateTime):string;
var
  CampoT430:string;
begin
  Result:='';
  if not GetProfilo(MyProg) then
    raise Exception.Create('Profilo dipendente non trovato.');
  //Se campo STATO_CAUSA_MALATTIA è nullo salto controllo
  if not selT269.FieldByName('STATO_CAUSA_MALATTIA').IsNull then
  begin
    CampoT430:='T430' + selT269.FieldByName('STATO_CAUSA_MALATTIA').AsString;
    //Controllo se il dato libero esiste su V430
    R180SetVariable(selDatoAnagrafico,'T269DATO_LIBERO',CampoT430);
    selDatoAnagrafico.Open;
    //------------------------------------------
    if selDatoAnagrafico.RecordCount > 0 then
    begin
      with TQueryStorico.Create(nil) do
        try
          Session:=SessioneOracle;
          GetDatiStorici(CampoT430,MyProg,MyDataIni,MyDataFine);
          Result:=FieldByName(CampoT430).AsString;
          if not R180In(Result,['S','G']) then
            Result:='';
        finally
          Free;
        end;
    end
    else
      raise Exception.Create(Format('Il dato anagrafico %s per il profilo %s è inesistente.',[selT269.FieldByName('STATO_CAUSA_MALATTIA').AsString,
                                                                                              selT269.FieldByName('CODICE').AsString]));
  end;
end;

function TA087FImpAttestatiMalMW.T048FileTXTToT048:boolean;

type
  TRetGetIdModifica = record
    IDFileTXT:string;
    DataInizioMal:TDateTime;
  end;

var
  MyTReg:string;
  MyRecTxt:TRetGetIdModifica;

  function MatricolaToProgressivo(MatricolaIN:string):integer;
  var
    i:integer;
    AusMatricola:string;
  begin
    Result:=-1;
    //Pulisco gli zeri a sx
    AusMatricola:='';
    i:=0;
    while (i <= MatricolaIN.Length - 1) and
          ((MatricolaIN.Substring(i,1) = '0') or (MatricolaIN.Substring(i,1) = ' ')) do
      inc(i);
    AusMatricola:=MatricolaIN.Substring(i,MatricolaIN.Length);

    with TOracleQuery.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select T030.PROGRESSIVO');
        SQL.Add('  from T030_ANAGRAFICO T030');
        SQL.Add(' where T030.MATRICOLA = :MATRICOLA');
        DeclareVariable('MATRICOLA',otString);
        SetVariable('MATRICOLA',AusMatricola);
        Execute;
        if RowCount <= 0 then
          raise Exception.Create(A000MSG_A087_MSG_MATRICOLA_NON_TROVATA);
        Result:=FieldAsInteger(FieldIndex('PROGRESSIVO'));
      finally
        Free;
      end;
  end;

  function CreaToData(sYYYY,sMM,sGG:string):TDateTime;
  var
    nYYYY, nMM, nGG:word;
  begin
    Result:=DATE_NULL;
    if sYYYY.IsEmpty and sMM.IsEmpty and sGG.IsEmpty then
      Exit;
    try
      nYYYY:=sYYYY.ToInteger;
      nMM:=sMM.ToInteger;
      nGG:=sGG.ToInteger;
    if not TryEncodeDate(nYYYY,nMM,nGG,Result) then
      Abort;
    except
      on e:exception do
        raise Exception.Create(A000MSG_A087_ERR_CONVERSIONE_DATA);
    end;
  end;

  procedure TestID_FILETXT(Progressivo:integer; IDFileTXT:String);
  var
    Msg:string;
  begin
    Msg:='';
    with TOracleQuery.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select count(*) as NUM_ID');
        SQL.Add('  from T048_ATTESTATIINPS T048');
        SQL.Add(' where T048.PROGRESSIVO = :PROGRESSIVO');
        SQL.Add('   and T048.ID_FILETXT = :ID_FILETXT');
        SQL.Add('   and T048.TIPO_REGISTRAZIONE = ''N''');
        DeclareAndSet('PROGRESSIVO',otInteger,Progressivo);
        DeclareAndSet('ID_FILETXT',otString,IDFileTXT);
        Execute;
        if FieldAsInteger('NUM_ID') > 0 then
          Msg:=Format(A000MSG_A087_MSG_TIMESTAMP_GIA_INSERITO,[DateToStr(DataInizioMal), DateToStr(DataFineMal)]);
      finally
        Free;
      end;
    if not Msg.IsEmpty then
      raise Exception.Create(Msg);
  end;

  function GetIdModifica(inProgr:integer;inDataMal:TDateTime;inCausale,ID_FileTXT:string):TRetGetIdModifica;
  begin
    Result.IDFileTXT:='';
    Result.DataInizioMal:=DATE_NULL;
    with TOracleQuery.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Add('    select T048.ID_FILETXT, T048.DATA_INIZIO_MAL');
        SQL.Add('      from T048_ATTESTATIINPS T048');
        SQL.Add('     where T048.TIPO_GESTIONE = ''W''');
        SQL.Add('       and (:ID_FILETXT = ID_FILETXT and T048.TIPO_REGISTRAZIONE in (''N'',''M''))');
        SQL.Add('        or (T048.PROGRESSIVO = :PROGRESSIVO');
        SQL.Add('            and :DATA_INIZIO_MAL between T048.DATA_INIZIO_MAL and T048.DATA_FINE_MAL');
        SQL.Add('            and T048.CAUSALE_MAL = :CAUSALE_MAL');
        SQL.Add('            and T048.TIPO_REGISTRAZIONE in (''N'',''M'',''T''))');
        DeclareVariable('PROGRESSIVO',otInteger);
        DeclareVariable('DATA_INIZIO_MAL',otDate);
        DeclareVariable('CAUSALE_MAL',otString);
        DeclareVariable('ID_FILETXT',otString);
        SetVariable('PROGRESSIVO',inProgr);
        SetVariable('DATA_INIZIO_MAL',inDataMal);
        SetVariable('CAUSALE_MAL',inCausale);
        SetVariable('ID_FILETXT',ID_FileTXT);
        Execute;
        if RowCount > 0 then
        begin
          Result.IDFileTXT:=FieldAsString('ID_FILETXT');
          Result.DataInizioMal:=FieldAsDate('DATA_INIZIO_MAL');
        end;
      finally
        Free;
      end;
  end;

  function TestDataInizioIntersecante(inProgr:integer; inDataMal:TDateTime; inCausale:string):TDateTime;
  begin
    Result:=DATE_NULL;
    with TOracleQuery.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Add('select T048.DATA_INIZIO_MAL');
        SQL.Add('  from T048_ATTESTATIINPS T048');
        SQL.Add(' where T048.PROGRESSIVO = :PROGRESSIVO');
        SQL.Add('   and :DATA_INIZIO_MAL between T048.DATA_INIZIO_MAL and T048.DATA_FINE_MAL')
      finally
        Free;
      end;
  end;

begin
  Result:=False;
  if not CDtsTXTFile.Active or (CDtsTXTFile.RecordCount <= 0) then
    raise Exception.Create(A000MSG_A087_MSG_CDTSTXTFILE_CHIUSO);
  SetLength(VetAttestato,0);
  CDtsTXTFile.DisableControls;
  CDtsTXTFile.First;
  while not CDtsTXTFile.Eof do
  begin
    try
      InsT048.ClearVariables;
      Progressivo:=MatricolaToProgressivo(CDtsTXTFile.FieldByName('MATRICOLA').AsString);
      DataInizioMal:=CreaToData(CDtsTXTFile.FieldByName('ANNO_INIZIO').AsString,
                                CDtsTXTFile.FieldByName('MESE_INIZIO').AsString,
                                CDtsTXTFile.FieldByName('GIORNO_INIZIO').AsString);
      DataFineMal:=CreaToData(CDtsTXTFile.FieldByName('ANNO_FINE').AsString,
                              CDtsTXTFile.FieldByName('MESE_FINE').AsString,
                              CDtsTXTFile.FieldByName('GIORNO_FINE').AsString);
      if CDtsTXTFile.FieldByName('TIPO_REGISTRAZIONE').AsString = 'N' then
        TestID_FILETXT(Progressivo, CDtsTXTFile.FieldByName('ID_FILETXT').AsString);
      CausaMalattia:=getCausaMalDaAnagrafico(Progressivo,DataInizioMal,DataFineMal);
      CausaleMal:=getCausaleDaProfilo(Progressivo);//Se assegnata a '' la causale viene selezionata da profilo dipendente
      MyRecTxt:=GetIdModifica(Progressivo,DataInizioMal,CausaleMal,CDtsTXTFile.FieldByName('ID_FILETXT').AsString);
      MyTReg:='N';
      if not MyRecTxt.IDFileTXT.IsEmpty then
      begin
        MyTReg:='T';
        DataInizioMal:=MyRecTxt.DataInizioMal;
      end
      else
      begin
        if CDtsTXTFile.FieldByName('TIPO_REGISTRAZIONE').AsString = 'M' then
          {Test necessario nel caso in cui il record da modificare sia stato precedentemente modificato
           se modificato l'ID non esiste più perchè riassegnato dalla precedente modifica}
          raise Exception.Create('ID periodo "' + CDtsTXTFile.FieldByName('ID_FILETXT').AsString + '" da modificare non trovato.')
        else
          MyRecTxt.IDFileTXT:=CDtsTXTFile.FieldByName('ID_FILETXT').AsString;
      end;
      TipoRegistrazione:=MyTReg;
      InsT048.SetVariable('ID_FILETXT',MyRecTxt.IDFileTXT);
      TipoElemento:='I';
      TipoCertificato:='I';
      IDCertificato:='';
      if trim(CDtsTXTFile.FieldByName('NPROTOCOLLO').AsString).Length  > 10 then
        RegistraMsg.InserisciMessaggio('A','Lunghezza del Numero di protocollo maggiore di 10 caratteri.');
      NumProtocollo:=CDtsTXTFile.FieldByName('NPROTOCOLLO').AsString;
      TipoGestione:='W';
      Note:=CDtsTXTFile.FieldByName('NOTE').AsString;
      InsT048.SetVariable('DATA_REGISTRAZIONE',R180SysDate(SessioneOracle));
      InsT048.SetVariable('OPERATORE',Parametri.Operatore);
      InsT048.Execute;
      SetLength(VetAttestato,Length(VetAttestato) + 1);
      with VetAttestato[High(VetAttestato)] do
      begin
        VetAttestato[High(VetAttestato)].Tipo_Elemento:='I';
        VetAttestato[High(VetAttestato)].ID_Certificato:=IDCertificato;
        VetAttestato[High(VetAttestato)].Anomalia:=False;
      end;
    except
      on e:exception do
      begin
        RegistraMsg.InserisciMessaggio('A',e.Message,Parametri.Azienda,Progressivo);
        Result:=True;
      end;
    end;
    CDtsTXTFile.Next;
  end;
  CDtsTXTFile.First;
  CDtsTXTFile.EnableControls;
  SessioneOracle.Commit;
end;

function TA087FImpAttestatiMalMW.InsDipTXT:boolean;
var
  i:integer;
begin
  Result:=T048FileTXTToT048;
  if Assigned(evtInitProgressBarTXT) then
    evtInitProgressBarTXT;
  for i:=Low(VetAttestato) to High(VetAttestato) do
  begin
    ElaboraDipendente(i);
    if VetAttestato[i].Anomalia then
      Result:=True;
    if Assigned(evtProgressBarStepItTXT) then
      evtProgressBarStepItTXT;
  end;
  SessioneOracle.Commit;
  if Assigned(evtInitProgressBarTXT) then
    evtInitProgressBarTXT;
end;

procedure TA087FImpAttestatiMalMW.OpenSelT048CancMan;
begin
  selT048CancMan.DeleteVariables;
  selT048CancMan.DeclareVariable('C700SelAnagrafe',otSubst);
  selT048CancMan.SetVariable('C700SelAnagrafe','T030_ANAGRAFICO T030 where T030.PROGRESSIVO = -10000');
  selT048CancMan.Open;
  selT048CancMan.FieldByName('PROGRESSIVO').Visible:=False;
end;

procedure TA087FImpAttestatiMalMW.TestNumProtocollo(NumProtocollo:string);
begin
  with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('begin');
      SQL.Add('  select count(*) into :NUM_REC');
      SQL.Add('    from T048_ATTESTATIINPS T048');
      SQL.Add('   where T048.NUM_PROTOCOLLO = :NUM_PROTOCOLLO');
      SQL.Add('     and T048.ID_CERTIFICATO <> :ID_CERTIFICATO;');
      SQL.Add('end;');
      DeclareVariable('NUM_REC',otInteger);
      DeclareAndSet('NUM_PROTOCOLLO',otString,NumProtocollo);
      if StatoOperazione = 'M' then
        DeclareAndSet('ID_CERTIFICATO',otString,IDCertificatoModificato)
      else
        DeclareAndSet('ID_CERTIFICATO',otString,IDCertificato);
      Execute;
      if GetVariable('NUM_REC') > 0 then
        raise Exception.Create('Numero protocollo "' + NumProtocollo + '" già inserito!');
    finally
      Free;
    end;
end;

function TA087FImpAttestatiMalMW.TestFiltroProfili:Boolean;
//Se false non ci sono profili abilitati
begin
  Result:=False;
  selT269.DisableControls;
  try
    selT269.First;
    while (Not selT269.Eof) and (Not Result) do
    begin
      if copy(trim(selT269.FieldByName('FILTRO').AsString),1,6) <> '(1<>1)' then
        Result:=True;
      selT269.Next;
    end;
  finally
    selT269.EnableControls;
  end;
end;

procedure TA087FImpAttestatiMalMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(GestContinuazione);
  FreeAndNil(A004MW.R600DtM1);
  FreeAndNil(A004MW);
  FreeAndNil(vetCertifAnomalie);
  FreeAndNil(vetCertifAcquisiti);
  SetLength(VetAttestato,0);
end;

procedure TA087FImpAttestatiMalMW.CDtsTempFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  if DipInclusi then
    Accept:=SelAnagrafe.SearchRecord('CODFISCALE',DataSet.FieldByName('codicefiscale_lavoratore').AsString,[srFromBeginning])
  else
    Accept:=Not SelAnagrafe.SearchRecord('CODFISCALE',DataSet.FieldByName('codicefiscale_lavoratore').AsString,[srFromBeginning]);
end;

function TA087FImpAttestatiMalMW.ColoraCella:TColor;
var
  i:integer;
  ID_Certificato, Tipo_Elemento:String;
begin
  ID_Certificato:='';
  if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'attestato' then
  begin
    ID_Certificato:=VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO'));
    Tipo_Elemento:='I';
  end
  else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'annullamento' then
  begin
    ID_Certificato:=VarToStr(GetCampo('IDCERTIFICATO_ANNULLAMENTO'));
    Tipo_Elemento:='C';
  end
  else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'ricovero' then
  begin
    ID_Certificato:=VarToStr(GetCampo('IDINIZIORICOVERO_RICOVERO'));
    Tipo_Elemento:='R';
  end
  else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'dimissioni' then
  begin
    ID_Certificato:=VarToStr(GetCampo('IDDIMISSIONI_DIMISSIONI'));
    Tipo_Elemento:='D';
  end;

  Result:=clWhite;
  if vetCertifAnomalie.IndexOf(ID_Certificato) <> -1 then
    Result:=clRed
  else if vetCertifAcquisiti.IndexOf(ID_Certificato) <> -1 then
    Result:=clGray
  else if Length(VetAttestato) > 0 then
  begin
    if Trim(ID_Certificato).isEmpty then
      Result:=clRed
    else
      for i:=low(VetAttestato) to High(VetAttestato) do
        if (VetAttestato[i].ID_Certificato = ID_Certificato) and
           (VetAttestato[i].Tipo_Elemento = Tipo_Elemento) and
           VetAttestato[i].Anomalia then
        begin
          Result:=clRed;
          Break;
        end;
  end
  else
    Result:=clNone;
end;

procedure TA087FImpAttestatiMalMW.CreaAnomalia(TestoAnomalia:String;Prog:integer = 0;ID_Certificato:string = '');
{                     ******************  LEGGERE  PRIMA DI USARE  ******************
 Se utilizzato all'interno della precedure insDipT040 si deve valororizzare il parametro ID_certificato, poichè
 lo scorrimento dei certificati è completamente svincolato dal dataset CDtsTemp}
begin
  if ID_Certificato.IsEmpty then
  begin
    if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'attestato' then
      ID_Certificato:=VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO'))
    else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'annullamento' then
      ID_Certificato:=VarToStr(GetCampo('IDCERTIFICATO_ANNULLAMENTO'))
    else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'ricovero' then
      ID_Certificato:=VarToStr(GetCampo('IDINIZIORICOVERO_RICOVERO'))
    else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'dimissioni' then
      ID_Certificato:=VarToStr(GetCampo('IDDIMISSIONI_DIMISSIONI'));
  end;

  //Massimo: Creo lista di certificati che provocano un anomalia. Verrà poi usata nel 'ColoraCella'
  if pos('ORA-00001',TestoAnomalia) <= 0 then
  begin
    BloccoAnomalia:=True;
    vetCertifAnomalie.Add(ID_Certificato);
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_BLOCCANTE,[TestoAnomalia]),Parametri.Azienda,Prog);
  end
  else
  begin
    vetCertifAcquisiti.Add(ID_Certificato);
    if pos('T047',TestoAnomalia) <= 0  then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[
                                         copy(TestoAnomalia,1,pos('ORA-00001',TestoAnomalia) - 1) +
                                         'Certificato numero ' + ID_Certificato + ' già acquisito']),Parametri.Azienda,Prog)
    else
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[
                                         copy(TestoAnomalia,1,pos('ORA-00001',TestoAnomalia) - 1) +
                                         'visita fiscale già acquisita.']),Parametri.Azienda,Prog);
  end;
end;

procedure TA087FImpAttestatiMalMW.cdsLookT265D_CODICE_ALLValidate(Sender: TField);
begin
  inherited;
  if Assigned(evtAbilCmbCausaleAll) then
    evtAbilCmbCausaleAll(cdsLookT265.FieldByName('CODICE_ALL').Value <> null);
end;

function TA087FImpAttestatiMalMW.ConvBool(BoolIn:Variant):String;
begin
  Result:='N';
  if Not VarIsNull(BoolIn) and (LowerCase(Trim(BoolIn)) = 'true') then
    Result:='S';
end;

function TA087FImpAttestatiMalMW.GetProfilo(MyProgr:integer):Boolean;
var
  MySQL:String;
begin
  Result:=False;
  selT269.First;
  while Not selT269.Eof do
  begin
    if selT269.FieldByName('FILTRO').IsNull then
    begin
      Result:=True;
      Break;
    end;
    MySQL:=selT269.FieldByName('FILTRO').AsString;
    with TOracleDataSet.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select ''x'' from :C700SelAnagrafe and T030.PROGRESSIVO = :MyDip and (:FILTRO)');
        DeclareVariable('C700SelAnagrafe',otSubst);
        DeclareVariable('FILTRO',otSubst);
        DeclareVariable('MyDip',otInteger);
        DeclareVariable('DataLavoro',otDate);
        SetVariable('FILTRO',MySQL);
        SetVariable('C700SelAnagrafe',QVistaOracle);
        SetVariable('MyDip',MyProgr);
        SetVariable('DataLavoro',Date);
        try
          Open;
          if RecordCount > 0 then
          begin
            Result:=True;
            Break;
          end;
        except
          on e:exception do
            CreaAnomalia(Format(A000MSG_A087_ERR_ESECUZIONE_QUERY,[selT269.FieldByName('CODICE').AsString,e.Message]));
        end;
      finally
        Free;
      end;
    selT269.Next;
  end;
end;

function TA087FImpAttestatiMalMW.ControlloPeriodiRapporto:Boolean;
var
  Trova: Integer;
begin
  Result:=False;
  selT030.Close;
  selT030.SetVariable('DATAIN',ConvData(GetCampo('DATAINIZIO_ATTESTATO')));
  selT030.SetVariable('CODFISC',VarToStr(GetCampo('CODICEFISCALE_LAVORATORE')));
  selT030.Open;
  if selT030.RecordCount <= 0 then
  begin
    CreaAnomalia(Format(A000MSG_A087_MSG_CODFISCALE_NON_TROVATO,[VarToStr(GetCampo('CODICEFISCALE_LAVORATORE'))]));
    Result:=True;
  end
  else
  begin
    Trova:=0;
    while Not selT030.Eof do
    begin
      if selT030.FieldByName('IN_SERVIZIO').AsString = 'S' then
        inc(Trova);
      selT030.Next;
    end;
    if Trova = 0 then
    begin
      CreaAnomalia(Format(A000MSG_A087_MSG_DIP_NON_SERVIZIO,[DateToStr(ConvData(GetCampo('DATAINIZIO_ATTESTATO')))]),selT030.FieldByName('PROGRESSIVO').AsInteger);
      Result:=True;
    end;
    if Trova > 1 then
    begin
      CreaAnomalia(Format(A000MSG_A087_MSG_CODFISCALE_DOPPIO,[VarToStr(GetCampo('CODICEFISCALE_LAVORATORE')),DateToStr(ConvData(GetCampo('DATAINIZIO_ATTESTATO')))]));
      Result:=True;
    end;
    selT030.SearchRecord('IN_SERVIZIO','S',[srFromBeginning]);
    if not GetProfilo(selT030.FieldByName('PROGRESSIVO').AsInteger) then
    begin
      CreaAnomalia(A000MSG_A087_MSG_DIP_NON_ASSOCIATO,selT030.FieldByName('PROGRESSIVO').AsInteger);
      Result:=True;
    end;
  end;
end;

function TA087FImpAttestatiMalMW.ConvData(DataIn:Variant):TDateTime;
//Conversione data Stringa YYYY-MM-DD a formato data
//se data = DD/MM/YYYY fa solo la conversione var to date
var
  Str:String;
  AAAA, MM, GG:integer;
begin
  Result:=0;
  if Not VarIsNull(DataIn) then
    try
      if pos('-',VarToStr(DataIn)) > 0 then
      begin
        Str:=VarToStr(DataIn);
        AAAA:=StrToInt(Copy(Str,1,pos('-',Str) - 1));
        Delete(Str,1,pos('-',Str));
        MM:=StrToInt(Copy(Str,1,Pos('-',Str) - 1));
        Delete(Str,1,pos('-',Str));
        GG:=StrToInt(Str);
        Result:=EncodeDate(AAAA,MM,GG);
      end
      else
        Result:=R180VarToDateTime(DataIn);
    except
      Result:=0;
    end;
end;

function TA087FImpAttestatiMalMW.GetCampo(CDts:String):Variant;
//Cerca il campo all'interno del ClientDataSet se presente restituisci il valore
//altrimenti null
var
  i:integer;
begin
  Result:=null;
  for i:=0 to CDtsTemp.FieldDefs.Count - 1 do
    if UpperCase(CDtsTemp.Fields[i].FieldName) = UpperCase(CDts) then
    begin
      Result:=CDtsTemp.Fields[i].Value;
      Break;
    end;
end;

procedure TA087FImpAttestatiMalMW.SortCertificati;
var
  TempIndice, OrdAttestato, i:Integer;
  SwapCertificato:array of TSwapAttestato;
begin
  {Controllo se il campo IDCERTIFICATO_ATTESTATO è esistente: se non è esistente siamo nel caso in cui
   il file è composto da soli certificati di annullamento}
  //if GetCampo('IDCERTIFICATO_ATTESTATO') = null then
  if CDtsTemp.FindField('IDCERTIFICATO_ATTESTATO') = nil then
    Exit;
  CDtsTemp.DisableControls;
  CDtsTemp.IndexName:='';
  CDtsTemp.First;
  SetLength(SwapCertificato,0);
  while Not CDtsTemp.Eof do
  begin
    if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'annullamento' then
    begin
      SetLength(SwapCertificato,Length(SwapCertificato) + 1);
      SwapCertificato[High(SwapCertificato)].ID_Certificato:=VarToStr(GetCampo('idCertificato_annullamento'));
      SwapCertificato[High(SwapCertificato)].Indice:=CDtsTemp.FieldByName('INDICE').AsInteger;
      SwapCertificato[High(SwapCertificato)].Ordine:=CDtsTemp.FieldByName('ORDINE').AsInteger;
    end;
    CDtsTemp.Next;
  end;

  TempIndice:=1;
  for i:=Low(SwapCertificato) to High(SwapCertificato) do
    if Not CDtsTemp.Locate('IDCERTIFICATO_ATTESTATO',SwapCertificato[i].ID_Certificato,[]) then
    begin
      {Certificati di annullamento di cui non è stato trovato il certificato da annullare sul
       medesimo file vengono spostati all'inizio dell'acquisizione, l'ordine assegnato sarà negativo}
      CDtsTemp.Locate('INDICE',SwapCertificato[i].Indice,[]);
      CDtsTemp.Edit;
      CDtsTemp.FieldByName('ORDINE').AsInteger:=-1 * TempIndice;
      CDtsTemp.Post;
      inc(TempIndice);
    end
    else
    begin
      {Certificati di annullamento di cui è stato trovato il certificato da annullare sul
       medesimo file vengono spostati immediatamente dopo il certificato da annullare.}
      OrdAttestato:=CDtsTemp.FieldByName('ORDINE').AsInteger;
      CDtsTemp.Locate('INDICE',SwapCertificato[i].Indice,[]);
      CDtsTemp.Edit;
      CDtsTemp.FieldByName('ORDINE').AsInteger:=OrdAttestato + 1;
      CDtsTemp.Post;
    end;
  SetLength(SwapCertificato,0);
  CDtsTemp.IndexName:='Indice1';
  CDtsTemp.First;
  CDtsTemp.EnableControls;
end;

procedure TA087FImpAttestatiMalMW.InizializzaCDataSet(NodoIn:IXMLNodeList;NPrev:String);
//I campi sono creati con "nome campo"_"tag padre"
//es: codFiscAzienda_attestato
//    codiceFiscale_medico
var
  i,j:integer;
  Esci:Boolean;
begin
  for i:=0 to NodoIn.Count - 1 do
    if NodoIn.Get(i).IsTextElement then
    begin
      Esci:=False;
      for j:=0 to CDtsTemp.FieldDefs.Count - 1 do
        if CDtsTemp.FieldDefs[j].Name = NodoIn.Get(i).LocalName + '_' + NPrev then
          Esci:=True;
      if Esci then
        Continue;
      CDtsTemp.FieldDefs.Add(NodoIn.Get(i).LocalName + '_' + NPrev,ftString,80,False);
    end
    else
      InizializzaCDataSet(NodoIn.Get(i).ChildNodes,NodoIn.Get(i).LocalName);
end;

function TA087FImpAttestatiMalMW.AgevolazioniCodToDesc(Codice:string):String;
begin
  Result:='';
  if Codice = 'T'  then
    Result:='Terapia salvavita'
  else if Codice = 'C'  then
    Result:='Causa di servizio'
  else if Codice = 'I'  then
    Result:='Invalidita'' riconosciuta';
end;

procedure TA087FImpAttestatiMalMW.LeggiFileXML(RegAnom:Boolean);
//Lettura del file XML e creazione/Valorizzazione del Client DataSet
//contenete l'estratto del file
var
  i:Integer;

  procedure CreaCampoAss(NomeCampo:String);
  var
    j:Integer;
    Trovato:Boolean;
  begin
    Trovato:=False;
    for j := 0 to CDtsTemp.FieldDefs.Count - 1 do
      if Trim(UpperCase(CDtsTemp.FieldDefs[j].Name)) = Trim(UpperCase(NomeCampo)) then
        Trovato:=True;
    if Not Trovato then
    begin
      CDtsTemp.Close;
      CDtsTemp.FieldDefs.Add(NomeCampo,ftString,80,False);
    end;
  end;

  procedure VisCampo(NomeCampo,LabelCampo:String;Posiz:Integer);
  begin
    CDtsTemp.FieldByName(NomeCampo).Visible:=True;
    CDtsTemp.FieldByName(NomeCampo).Index:=Posiz;
    CDtsTemp.FieldByName(NomeCampo).DisplayLabel:=LabelCampo;
  end;

  procedure ValCampoGenerico(NomeCampo:String);
  var
    j:integer;
  begin
    NomeCampo:=LowerCase(NomeCampo);
    for j:=0 to CDtsTemp.FieldCount - 1 do
      if pos(NomeCampo,LowerCase(CDtsTemp.Fields[j].FieldName)) > 0 then
      begin
        if LowerCase(Trim(CDtsTemp.Fields[j].AsString)) = 'true' then
          CDtsTemp.FieldByName(NomeCampo).AsString:='S'
        else if LowerCase(Trim(CDtsTemp.Fields[j].AsString)) = 'false' then
          CDtsTemp.FieldByName(NomeCampo).AsString:='N'
        else
          CDtsTemp.FieldByName(NomeCampo).AsString:=CDtsTemp.Fields[j].AsString;
      end;
  end;

begin
  try
    XMLDoc.XML.LoadFromFile(evtGetPathFile);
    if XMLDoc.XML.Count > 0 then
    begin
      //Elimino eventuali spazzi bianchi in testa e in coda al file
      XMLDoc.XML[0]:=TrimLeft(XMLDoc.XML[0]);
      XMLDoc.XML[XMLDoc.XML.Count - 1]:=TrimRight(XMLDoc.XML[XMLDoc.XML.Count - 1]);
    end
    else
      raise Exception.Create('File vuoto.');
    if (not IsLibrary)(*(GGetWebApplicationThreadVar.AppURLBase = '')*) then
      CoInitialize(nil);
    XMLDoc.Active:=True;
    XMLDoc.Encoding:='ISO-8859-1';
    //Definizione struttura DataSet
    CDtsTemp.Close;
    CDtsTemp.FieldDefs.Clear;
    InizializzaCDataSet(XMLDoc.ChildNodes,'');
    //Utilizzato per valutazione operazione annullamento/attestato
    CDtsTemp.FieldDefs.Add('TIPO_OPERAZIONE',ftString,12,False);
    CDtsTemp.FieldDefs.Add('PREVIEW_TIPOCERTIFICATO',ftString,30,False);
    CDtsTemp.FieldDefs.Add('PREVIEW_TIPOPERIODO',ftString,30,False);
    CDtsTemp.FieldDefs.Add('PREVIEW_DIFFDATE',ftString,30,False);
    CDtsTemp.FieldDefs.Add('INDICE',ftInteger,0,False);
    CDtsTemp.FieldDefs.Add('ORDINE',ftInteger,0,False);
    //Controllo sui campi visibili: se non esistono li creo
    CreaCampoAss('cognome_lavoratore');
    CreaCampoAss('nome_lavoratore');
    CreaCampoAss('codicefiscale_lavoratore');
    CreaCampoAss('datainizio_attestato');
    CreaCampoAss('datafine_attestato');
    CreaCampoAss('datarilascio_attestato');
    CreaCampoAss('idcertificato_attestato');
    CreaCampoAss('cognome_reperibilita');
    CreaCampoAss('via_indirizzo');
    CreaCampoAss('civico_indirizzo');
    CreaCampoAss('cap_indirizzo');
    CreaCampoAss('comune_indirizzo');
    CreaCampoAss('provincia_indirizzo');
    CreaCampoAss('matricolainps');
    CreaCampoAss('codsede');
    CreaCampoAss('giornatalavorata');
    CreaCampoAss('trauma');
    CreaCampoAss('tiporicovero');
    CreaCampoAss('agevolazioni');
    CDtsTemp.CreateDataSet;
    //Ridefinisco le caption dei campi visibili
    for i := 0 to CDtsTemp.FieldCount - 1 do
    begin
      CDtsTemp.Fields[i].DisplayWidth:=20;
      CDtsTemp.Fields[i].Visible:=False;
    end;
    VisCampo('cognome_lavoratore','Cognome',0);
    VisCampo('nome_lavoratore','Nome',1);
    VisCampo('codicefiscale_lavoratore','Codice fiscale',2);
    VisCampo('datainizio_attestato','Data inizio malattia',3);
    VisCampo('datafine_attestato','Data fine malattia',4);
    VisCampo('PREVIEW_TIPOCERTIFICATO','Tipo certificato',5);
    VisCampo('datarilascio_attestato','Data rilascio',6);
    VisCampo('PREVIEW_TIPOPERIODO','Tipo periodo',7);
    VisCampo('PREVIEW_DIFFDATE','Diff. rilascio e inizio mal.',8);
    VisCampo('idcertificato_attestato','ID certificato',9);
    VisCampo('cognome_reperibilita','Cognome rep.',10);
    VisCampo('via_indirizzo','Via rep.',11);
    VisCampo('civico_indirizzo','N.civico rep.',12);
    VisCampo('cap_indirizzo','CAP rep.',13);
    VisCampo('comune_indirizzo','Comune rep.',14);
    VisCampo('provincia_indirizzo','Provincia rep.',15);
    VisCampo('matricolainps','Matricola INPS',16);
    VisCampo('codsede','Codice sede',17);
    VisCampo('giornatalavorata','Giornata lavorata',18);
    VisCampo('trauma','Trauma',19);
    VisCampo('tiporicovero','Tipo ricovero',20);
    VisCampo('agevolazioni','Agevolazioni',21);

    //Creazione Indice di Ordinamento
    CDtsTemp.IndexDefs.Clear;
    with CDtsTemp.IndexDefs.AddIndexDef do
    begin
      Name:='Indice1';
      Fields:='ORDINE';
      Options:=[];
    end;
    CDtsTemp.Open;
    //Caricamento dati DataSet
    EstraiXML(XMLDoc.ChildNodes,'');
    if CDtsTemp.State in [dsEdit,dsInsert] then
      CDtsTemp.Post;
    CDtsTemp.Open;

    CDtsTemp.First;
    while Not CDtsTemp.Eof do
    begin
      CDtsTemp.Edit;
      ValCampoGenerico('matricolainps');
      ValCampoGenerico('codSede');
      ValCampoGenerico('giornatalavorata');
      ValCampoGenerico('trauma');
      ValCampoGenerico('tiporicovero');
      if (VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'attestato') then
      begin
        {Inserimento}
        {Rettifica}
        {Annullamento}
        if VarIsNull(GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO')) then
          CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Inserimento'
        else if VarToStr(GetCampo('TIPOCERTIFICATO_ATTESTATO')) <> 'A' then
          CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Rettifica'
        else
          CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Annullamento';
        if VarToStr(GetCampo('TIPOCERTIFICATO_ATTESTATO')) = 'I' then
          CDtsTemp.FieldByName('PREVIEW_TIPOPERIODO').AsString:='Inizio'
        else if VarToStr(GetCampo('TIPOCERTIFICATO_ATTESTATO')) = 'C' then
          CDtsTemp.FieldByName('PREVIEW_TIPOPERIODO').AsString:='Continuazione'
        else if VarToStr(GetCampo('TIPOCERTIFICATO_ATTESTATO')) = 'R' then
          CDtsTemp.FieldByName('PREVIEW_TIPOPERIODO').AsString:='Ricaduta';
        if GetCampo('DATAINIZIO_ATTESTATO') = GetCampo('DATARILASCIO_ATTESTATO') then
          CDtsTemp.FieldByName('PREVIEW_DIFFDATE').AsString:='No'
        else
          CDtsTemp.FieldByName('PREVIEW_DIFFDATE').AsString:='Si';
        {*Agevolazioni*}
        CDtsTemp.FieldByName('AGEVOLAZIONI').AsString:=AgevolazioniCodToDesc(VarToStr(GetCampo('AGEVOLAZIONI_ATTESTATO')));
      end
      else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'annullamento' then
      begin
        {Annullamento}
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Annullamento';
        selT048.Close;
        selT048.SetVariable('ID_CERTIFICATO',GetCampo('idCertificato_annullamento'));
        selT048.SetVariable('TELEMENTO','I');
        selT048.Open;

        CDtsTemp.FieldByName('cognome_lavoratore').Value:=selT048.FieldByName('COGNOME').Value;
        CDtsTemp.FieldByName('nome_lavoratore').Value:=selT048.FieldByName('NOME').Value;
        CDtsTemp.FieldByName('codicefiscale_lavoratore').Value:=selT048.FieldByName('CODFISCALE').Value;
        CDtsTemp.FieldByName('datainizio_attestato').Value:=selT048.FieldByName('DATA_INIZIO_MAL').Value;
        CDtsTemp.FieldByName('datafine_attestato').Value:=selT048.FieldByName('DATA_FINE_MAL').Value;
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').Visible:=True;
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').DisplayLabel:='Tipo certificato';
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').Index:=5;
      end
      else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'ricovero' then
      begin
        {Ricovero}
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Ricovero';
        CDtsTemp.FieldByName('datainizio_attestato').AsDateTime:=ConvData(CDtsTemp.FieldByName('dataricovero_ricovero').Value);
        CDtsTemp.FieldByName('datafine_attestato').AsDateTime:=ConvData(CDtsTemp.FieldByName('dataricovero_ricovero').Value);
        CDtsTemp.FieldByName('idcertificato_attestato').Value:=CDtsTemp.FieldByName('idinizioricovero_ricovero').Value;
      end
      else if VarToStr(GetCampo('TIPO_OPERAZIONE')) = 'dimissioni' then
      begin
        {Dimissioni}
        CDtsTemp.FieldByName('PREVIEW_TIPOCERTIFICATO').AsString:='Dimissioni';
        CDtsTemp.FieldByName('datainizio_attestato').AsDateTime:=ConvData(GetCampo('dataricovero_dimissioni'));
        CDtsTemp.FieldByName('datafine_attestato').AsDateTime:=ConvData(GetCampo('datadimissioni_dimissioni'));
        CDtsTemp.FieldByName('idcertificato_attestato').Value:=CDtsTemp.FieldByName('iddimissioni_dimissioni').Value;
        {*Agevolazioni*}
        CDtsTemp.FieldByName('AGEVOLAZIONI').AsString:=AgevolazioniCodToDesc(VarToStr(GetCampo('AGEVOLAZIONI_DIMISSIONI')));
      end;
      if Not CDtsTemp.FieldByName('datainizio_attestato').IsNull  then
        CDtsTemp.FieldByName('datainizio_attestato').AsDateTime:=ConvData(CDtsTemp.FieldByName('datainizio_attestato').Value);
      if Not CDtsTemp.FieldByName('datafine_attestato').IsNull  then
        CDtsTemp.FieldByName('datafine_attestato').AsDateTime:=ConvData(CDtsTemp.FieldByName('datafine_attestato').Value);
      if Not CDtsTemp.FieldByName('datarilascio_attestato').IsNull  then
        CDtsTemp.FieldByName('datarilascio_attestato').AsDateTime:=ConvData(CDtsTemp.FieldByName('datarilascio_attestato').Value);

      CDtsTemp.Post;
      CDtsTemp.Next;
    end;
    if RegAnom then
      RegistraMsg.InserisciMessaggio('I','File ''' + ExtractFileName(evtGetPathFile) + ''' letto correttamente.');
    SortCertificati;
  except
    on E:Exception do
    begin
      CDtsTemp.Close;
      if RegAnom then
      begin
        BloccoAnomalia:=True;
        RegistraMsg.InserisciMessaggio('A','Errore "' + E.Message + '" nella lettura del file "' + ExtractFileName(evtGetPathFile) + '".');
      end
      else
        raise;
    end;
  end;
end;

procedure TA087FImpAttestatiMalMW.EstraiXML(NodoIN:IXMLNodeList;NPrev:String);
var
  i:Integer;
begin
  for i := 0 to NodoIN.Count - 1 do
  begin
    if R180In(NodoIN.Get(i).LocalName,['attestato','annullamento','dimissioni','ricovero']) and
      (LowerCase(NPrev) = 'listaattestati') then
    begin
      if CDtsTemp.State in [dsEdit,dsInsert] then
        CDtsTemp.Post;
      CDtsTemp.Append;
      CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString:=NodoIN.Get(i).LocalName;
      CDtsTemp.FieldByName('INDICE').AsInteger:=CDtsTemp.RecordCount;
      CDtsTemp.FieldByName('ORDINE').AsInteger:=CDtsTemp.RecordCount * 2;
    end;
    if NodoIN.Get(i).IsTextElement then
      CDtsTemp.FieldByName(NodoIN.Get(i).LocalName + '_' + NPrev).AsString:=NodoIN.Get(i).Text
    else
      EstraiXML(NodoIN.Get(i).ChildNodes,NodoIN.Get(i).LocalName);
  end;
end;

procedure TA087FImpAttestatiMalMW.InsDipT040;
var
  i:Integer;
begin
  if Assigned(evtInitProgressBar) then
    evtInitProgressBar;

  InizializzaR600;
  for i:=Low(VetAttestato) to High(VetAttestato) do
  begin
    ElaboraDipendente(i);
    if Assigned(evtProgressBarStepIt) then
      evtProgressBarStepIt;
  end;

  PulisciR600;
end;

procedure TA087FImpAttestatiMalMW.InizializzaR600;
begin
  A004MW.R600DtM1.AnomalieBloccanti:=True;
  A004MW.R600DtM1.VisualizzaAnomalie:=False;
  A004MW.R600DtM1.AnomalieNonBloccanti:='1';
end;

procedure TA087FImpAttestatiMalMW.PulisciR600;
begin
  A004MW.R600DtM1.AnomalieBloccanti:=False;
  A004MW.R600DtM1.VisualizzaAnomalie:=True;
end;

procedure TA087FImpAttestatiMalMW.ElaboraDipendente(CurrDip: Integer);
var
  j:Integer;
  LogMsg, CausaleMalattia,
  CatenaDimissioni,CatenaPostRic,
  TempCaus:String;

  function CancellaGiustificativoA087(Prog:integer;DataIn:TDate;Causale:String):boolean;
  var
    k:Integer;
  begin
    Result:=False;
    with A004MW do
    begin
      Var_DaData:=DateToStr(DataIn);
      Var_AData:=Var_DaData;
      Var_Causale:=Causale;
      Var_Progressivo:=Prog;
      Var_TipoGiust:=0;
      Var_TipoGiust_Count:=4;
      Q040.Close;
      Q040.SetVariable('PROGRESSIVO',Prog);
      Q040.Open;
      Q265.SearchRecord('CODICE',Var_Causale,[srFromBeginning]);
      DataInizio:=StrToDate(Var_DaData);
      DataFine:=StrToDate(Var_AData);
      try
        CancellaGiustif(False,False);
      except
        on E:exception do
        begin
          CreaAnomalia(LogMsg + ' ' + E.Message,Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          Result:=True;
          Exit;
        end;
      end;
      for k:=0 to R600DtM1.ListAnomalie.Count - 1 do
      begin
        CreaAnomalia(R600DtM1.ListAnomalie[k],Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
        Result:=True;
        Exit;
      end;
      for k:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[R600DtM1.ListAnomalieNonBloccanti[k]]),Parametri.Azienda,Var_Progressivo);
    end;
  end;

  function CancellaCausaliSostitutive(InProg:integer;InDataDa,InDataA:TDate;InCausale:String):Boolean;
  begin
    Result:=False;
    selT040_del.Close;
    selT040_del.SetVariable('INPROG',InProg);
    selT040_del.SetVariable('INDATADA',InDataDa);
    selT040_del.SetVariable('INDATAA',InDataA);
    selT040_del.SetVariable('INCAUSALE',InCausale);
    selT040_del.Open;
    if selT040_del.RecordCount > 0 then
      while Not selT040_del.Eof do
      begin
        if CancellaGiustificativoA087(selT040_del.FieldByName('PROGRESSIVO').AsInteger,
                                      selT040_del.FieldByName('DATA').AsDateTime,
                                      selT040_del.FieldByName('CAUSALE').AsString) then
          Result:=True;
        selT040_del.Next;
      end;
  end;

  procedure CancellaCertificato(IdCertificato:String);
  begin
    with A004MW do
    begin
      //annullamento
      selT040.Close;
      selT040.SetVariable('ID',IdCertificato);
      selT040.Open;
      {Se si tratta di un inserimento manuale o per certificazione telefonica, anche se non trovo i gg causalizzati
       non segnalo anomalia così da poter cancellare il record su T048}
      if (selT040.RecordCount <= 0) and not R180In(selT048.FieldByName('TIPO_GESTIONE').AsString,['M','T','E']) then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_CAUS_NON_TROVATE,[selT048.FieldByName('ID_CERTIFICATO').AsString]),
                     selT048.FieldByName('PROGRESSIVO').AsInteger, VetAttestato[CurrDip].ID_Certificato);
        VetAttestato[CurrDip].Anomalia:=True;
        exit;
      end;

      while not selT040.Eof do
      begin
        VetAttestato[CurrDip].Anomalia:=CancellaGiustificativoA087(selT040.FieldByName('PROGRESSIVO').AsInteger,
                                                                   selT040.FieldByName('DATA').AsDateTime,
                                                                   selT040.FieldByName('CAUSALE').AsString);
        selT040.Next;
      end;
    end;
  end;

  procedure CancellaCertificatoAlternativo;
  begin
    with TOracleDataSet.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Clear;
        SQL.Add('select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE');
        SQL.Add('  from T040_GIUSTIFICATIVI T040');
        SQL.Add(' where T040.DATA between :DATADA and :DATAA');
        SQL.Add('   and T040.ID_CERTIFICATO = :ID_CERTIFICATO');
        SQL.Add(' order by T040.DATA');
        DeclareVariable('ID_CERTIFICATO',otInteger);
        DeclareVariable('DATADA',otDate);
        DeclareVariable('DATAA',otDate);
        SetVariable('DATADA',selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime);
        SetVariable('DATAA',selT048.FieldByName('DATA_FINE_MAL').AsDateTime);
        SetVariable('ID_CERTIFICATO',selT048.FieldByName('ID_CERTIFICATO_RETT').AsString);
        Open;
        while not Eof do
        begin
          VetAttestato[CurrDip].Anomalia:=CancellaGiustificativoA087(FieldByName('PROGRESSIVO').AsInteger,
                                                               FieldByName('DATA').AsDateTime,
                                                               FieldByName('CAUSALE').AsString);
          Next;
        end;
      finally
        Free;
      end;
  end;

  procedure InserisciCertificato(Causale:String;DataInizioMalattia, DataFineMalattia:TDateTime;IDAlternativo:string = '');
  var
    ChainCausali, T047Tipo_Esenzione, T047Operatore:String;
    T047Data_Esenzione:TDateTime;
    IDInserimento:string;
  begin
    with A004MW do
    begin
      //procedo con l'inserimento del giustificativo
      //Se certificato di continuazione malattia sposto la data di inizio malattia
      try
        {DataSet per estrarre dati di dettaglio su causale assenza}
        R180SetVariable(selT265DettCAssenza,'CODICE',Causale);
        selT265DettCAssenza.Open;

        IDInserimento:=selT048.FieldByName('ID_CERTIFICATO').AsString;
        if not IDAlternativo.IsEmpty then
          IDInserimento:=IDAlternativo;
        //Solo inserimento manuale TORINO_CSI copro i giorni non lavorativi se a cavallo periodo di malattia
        if R180In(selT048.FieldByName('TIPO_GESTIONE').AsString, ['W','T','E']) or
           ((selT048.FieldByName('TIPO_GESTIONE').AsString = 'M') and (selT048.FieldByName('TIPO_CERTIFICATO').AsString = 'C')) or
           (selT265DettCAssenza.FieldByName('COPRI_GGNONLAV').AsString = 'E') then
        begin
          ScriptIDPrecedente.ClearVariables;
          ScriptIDPrecedente.SetVariable('ID_CERTIFICATOIN',IDInserimento);
          ScriptIDPrecedente.Execute;
          if ScriptIDPrecedente.GetVariable('DATAOUT') <> null then
            DataInizioMalattia:=R180VarToDateTime(ScriptIDPrecedente.GetVariable('DATAOUT'));
        end;

        if selT048.FieldByName('TIPO_CERTIFICATO').AsString = 'C' then
        begin
          chkNuovoPeriodo:=False;
          TipoCertificatoINPS:='C';
          ChainCausali:=GestContinuazione.GetCatenaCaus(Causale).ChainCod133;
          {!L'ordine non è casuale!}
          {Elimino se presente nella catena di causali, la causale mal temporanea, se presente
          compromette il calcolo dalla nuova data inizio perido}
          {1}
          ChainCausali:=StringReplace(ChainCausali,',' + selT269.FieldByName('CAUS_PROVVISORIA').AsString + ',',',',[rfReplaceAll]);
          ChainCausali:=StringReplace('|' + ChainCausali,'|' + selT269.FieldByName('CAUS_PROVVISORIA').AsString + ',','',[rfReplaceAll]);
          ChainCausali:=StringReplace(ChainCausali + '|',',' + selT269.FieldByName('CAUS_PROVVISORIA').AsString + '|','',[rfReplaceAll]);
          ChainCausali:='''' + StringReplace(ChainCausali,',',''',''',[rfReplaceAll]) + '''';

          selT048ContinuaMal.ClearVariables;
          selT048ContinuaMal.SetVariable('PROGRESSIVO', selT048.FieldByName('PROGRESSIVO').AsInteger);
          selT048ContinuaMal.SetVariable('DATA_INIZIO_MAL', DataInizioMalattia);
          selT048ContinuaMal.SetVariable('DATA_FINE_MAL', DataFineMalattia);
          selT048ContinuaMal.SetVariable('CHAIN_CAUSALI', ChainCausali);
          selT048ContinuaMal.SetVariable('ID_CERTIFICATO', IDInserimento);
          selT048ContinuaMal.Execute;
          if (selT048ContinuaMal.GetVariable('NUOVA_DATA_INIZIO_MAL') <> null) then
            DataInizioMalattia:=R180VarToDateTime(selT048ContinuaMal.GetVariable('NUOVA_DATA_INIZIO_MAL'));
        end
        else
        begin
          TipoCertificatoINPS:='I';
          {R180SetVariable(selT265DettCAssenza,'CODICE',selT269.FieldByName('CAUS_INSERIMENTO').AsString);
          selT265DettCAssenza.Open;}
          if selT265DettCAssenza.FieldByName('TIPOCUMULO').AsString = 'O' then
            chkNuovoPeriodo:=True;
        end;
        {*-- Ricerca e salvataggio eventuali esenzione su T047 --*}
        if evtIsValidChkEsenzione and (selT048.FieldByName('TIPO_GESTIONE').AsString = 'A') then
        begin
          selEsenzioni.SQL.Clear;
          selEsenzioni.DeleteVariables;
          selEsenzioni.SQL.Add('select T047.TIPO_ESENZIONE, T047.DATA_ESENZIONE, T047.OPERATORE');
          selEsenzioni.SQL.Add('  from T047_VISITEFISCALI T047');
          selEsenzioni.SQL.Add(' where T047.TIPO_EVENTO = ''01''');
          selEsenzioni.SQL.Add('   and T047.PROGRESSIVO = :PROGRESSIVO');
          selEsenzioni.SQL.Add('   and T047.DATA_INIZIO_ASSENZA = :DATA_INIZIO_ASSENZA');
          selEsenzioni.SQL.Add('   and T047.OPERAZIONE = ''I''');
          selEsenzioni.DeclareAndSet('PROGRESSIVO',otInteger,selT048.FieldByName('PROGRESSIVO').AsInteger);
          selEsenzioni.DeclareAndSet('DATA_INIZIO_ASSENZA',otDate,selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime);
          selEsenzioni.Execute;
          if selEsenzioni.RowCount > 0 then
          begin
            T047Tipo_Esenzione:=selEsenzioni.FieldAsString('TIPO_ESENZIONE');
            T047Data_Esenzione:=selEsenzioni.FieldAsDate('DATA_ESENZIONE');
            T047Operatore:=selEsenzioni.FieldAsString('OPERATORE');
          end;
        end;
        {*-- End --*}
        {Elimino se presenti eventuali causali inserite provvisoriamente}
        if Not selT269.FieldByName('CAUS_PROVVISORIA').IsNull then
          CancellaCausaliSostitutive(selT048.FieldByName('PROGRESSIVO').AsInteger,
                                     DataInizioMalattia,
                                     DataFineMalattia,
                                     selT269.FieldByName('CAUS_PROVVISORIA').AsString);

        Var_DaData:=DateToStr(DataInizioMalattia);
        Var_AData:=DateToStr(DataFineMalattia);
        Var_Causale:=Causale;
        Var_Progressivo:=selT048.FieldByName('PROGRESSIVO').AsInteger;

        Giustif.Causale:=Causale;
        Giustif.Inserimento:=True;
        Giustif.Modo:='I';
        Giustif.DaOre:='  .  ';
        Giustif.AOre:='  .  ';

        Q265.SearchRecord('CODICE',Var_Causale,[srFromBeginning]);
        DataInizio:=DataInizioMalattia;
        DataFine:=DataFineMalattia;
        DataInizioOrig:=selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime;

        if DataInizio > DataFine then
          raise Exception.Create(A000MSG_A087_MSG_PERIDO_GIA_INSERITO);

        {Se il certificati è dì Manuale o tramite Telefono abilito la gestione interattiva
        delle anomalie}
        if R180In(selT048.FieldByName('TIPO_GESTIONE').AsString, ['M','T','E']) or
           ((StatoOperazione = 'M') and (selT048.FieldByName('TIPO_GESTIONE').AsString = 'W')) then
        begin
          R600DtM1.VisualizzaAnomalie:=True;
          InserisciGiustif(False,IDInserimento);
          {Se è stato coperto un periodo di malattia a cavallo di ven - lun - TORINO_CSI}
          if ScriptIDPrecedente.GetVariable('DATAOUT') <> null then
          begin
            updT040.SetVariable('PROGRESSIVO',selT048.FieldByName('PROGRESSIVO').AsString);
            updT040.SetVariable('DATA_INIZIO',DataInizioMalattia);
            updT040.SetVariable('DATA_FINE',selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime - 1);
            updT040.SetVariable('NEWID',VarToStr(ScriptIDPrecedente.GetVariable('ID_CERTIFICATOOUT')));
            updT040.SetVariable('OLDID',IDInserimento);
            updT040.Execute;
          end;
        end
        else
        begin
          R600DtM1.VisualizzaAnomalie:=False;
          InserisciGiustif(False,IDInserimento);
        end;
        {*-- Ripristino eventuali esenzione su T047 se flag mantieni esenzioni è flaggato--*}
        if evtIsValidChkEsenzione and (selT048.FieldByName('TIPO_GESTIONE').AsString = 'A') then
        begin
          if selEsenzioni.RowCount > 0 then
          begin
            selEsenzioni.SQL.Clear;
            selEsenzioni.DeleteVariables;
            selEsenzioni.SQL.Add('update T047_VISITEFISCALI T047');
            selEsenzioni.SQL.Add('   set T047.TIPO_ESENZIONE = :TIPO_ESENZIONE,');
            selEsenzioni.SQL.Add('       T047.DATA_ESENZIONE = :DATA_ESENZIONE,');
            selEsenzioni.SQL.Add('       T047.OPERATORE = :OPERATORE');
            selEsenzioni.SQL.Add(' where T047.TIPO_EVENTO = ''01''');
            selEsenzioni.SQL.Add('   and T047.PROGRESSIVO = :PROGRESSIVO');
            selEsenzioni.SQL.Add('   and T047.DATA_INIZIO_ASSENZA = :DATA_INIZIO_ASSENZA');
            selEsenzioni.SQL.Add('   and T047.OPERAZIONE = ''I''');
            selEsenzioni.DeclareAndSet('TIPO_ESENZIONE',otString,T047Tipo_Esenzione);
            selEsenzioni.DeclareAndSet('DATA_ESENZIONE',otDate,T047Data_Esenzione);
            selEsenzioni.DeclareAndSet('OPERATORE',otString,T047Operatore);
            selEsenzioni.DeclareAndSet('PROGRESSIVO',otInteger,selT048.FieldByName('PROGRESSIVO').AsInteger);
            selEsenzioni.DeclareAndSet('DATA_INIZIO_ASSENZA',otDate,selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime);
            selEsenzioni.Execute;
          end;
        end;
        {*-- End --*}
      except
        on E:Exception do
        begin
          CreaAnomalia(LogMsg + ' ' + E.Message,Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          VetAttestato[CurrDip].Anomalia:=True;
          Exit;
        end;
      end;
    end;
  end;

  //Utilizza "CancellaCertificato" e "InserisciCertificato"
  function RidefinizionePeriodoFileTXT(IDCertificato:string):string;
  begin
    Result:='';
    with TOracleDataSet.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Add('select T048_OLD.ID_CERTIFICATO, T048_NEW.CAUSALE_MAL, T048_NEW.DATA_INIZIO_MAL,');
        SQL.Add('       T048_NEW.DATA_FINE_MAL, T048_NEW.PROGRESSIVO');
        SQL.Add('  from T048_ATTESTATIINPS T048_NEW, T048_ATTESTATIINPS T048_OLD');
        SQL.Add(' where ((:ID_CERTIFICATO_OLD is not null and :ID_CERTIFICATO_OLD = T048_OLD.ID_CERTIFICATO)');
        SQL.Add('     or (:ID_CERTIFICATO_OLD is null and T048_NEW.ID_FILETXT = T048_OLD.ID_FILETXT))');
        SQL.Add('   and nvl(T048_OLD.TIPO_REGISTRAZIONE,''N'') <> ''T''');
        SQL.Add('   and T048_NEW.TIPO_REGISTRAZIONE = ''T''');
        //Viene presa in considerazione la modifica del perido
        //se viene cambiata la -->data_fine<-- o la -->causale_malattia<--
        SQL.Add('   and (T048_NEW.DATA_FINE_MAL <> T048_OLD.DATA_FINE_MAL');
        SQL.Add('    or T048_NEW.CAUSALE_MAL <> T048_OLD.CAUSALE_MAL');
        SQL.Add('    or T048_NEW.TIPO_CERTIFICATO <> T048_OLD.TIPO_CERTIFICATO)');
        SQL.Add('   and T048_NEW.ID_CERTIFICATO = :ID_CERTIFICATO');
        DeclareAndSet('ID_CERTIFICATO',otString,IDCertificato);
        DeclareAndSet('ID_CERTIFICATO_OLD',otString,IDCertificatoModificato);
        Open;
        if RecordCount > 0 then
        begin
          CancellaCertificato(FieldByName('ID_CERTIFICATO').AsString);
          InserisciCertificato(FieldByName('CAUSALE_MAL').AsString,
                               FieldByName('DATA_INIZIO_MAL').AsDateTime,
                               FieldByName('DATA_FINE_MAL').AsDateTime,
                               FieldByName('ID_CERTIFICATO').AsString);
        end;
      finally
        Free;
      end;
  end;

begin
  selT048.Close;
  selT048.ClearVariables;
  selT048.SetVariable('ID_CERTIFICATO',VetAttestato[CurrDip].ID_Certificato);
  selT048.SetVariable('TELEMENTO',VetAttestato[CurrDip].Tipo_Elemento);
  selT048.Open;
  LogMsg:='Periodo: ' + selT048.FieldByName('DATA_INIZIO_MAL').AsString + ' - ' + selT048.FieldByName('DATA_FINE_MAL').AsString;
  with A004MW do
  begin
    Var_Gestione:=0;
    Var_TipoGiust:=0;
    Var_TipoGiust_Count:=4;
    Var_DaOre:='  .  ';
    Var_AOre:='  .  ';
    Var_NumGG:=0;
    Var_TipoCaus:=1;
    Var_Familiari:='';
    //Campi relativi alla reperibilità per le visite fiscali
    if not selT048.FieldByName('CODCATASTALE_REP').IsNull then
    begin
      Self.selT480.SearchRecord('CODCATASTALE',selT048.FieldByName('CODCATASTALE_REP').AsString,[srFromBeginning]);
      RecapitoAlternativo.CodComune:=Self.selT480.FieldByName('CODICE').AsString;
      RecapitoAlternativo.Indirizzo:=TrimRight(selT048.FieldByName('VIA_REP').AsString) + ' ' + selT048.FieldByName('CIVICO_REP').AsString;
      RecapitoAlternativo.Cap:=selT048.FieldByName('CAP_REP').AsString;
      RecapitoAlternativo.Telefono:='';
      RecapitoAlternativo.MedLegale:='';
    end
    else
    begin
      Self.selT480.SearchRecord('CODCATASTALE',selT048.FieldByName('CODCATASTALE_DOM').AsString,[srFromBeginning]);
      RecapitoAlternativo.CodComune:=Self.selT480.FieldByName('CODICE').AsString;
      RecapitoAlternativo.Indirizzo:=TrimRight(selT048.FieldByName('VIA_DOM').AsString) + ' ' + selT048.FieldByName('CIVICO_DOM').AsString;
      RecapitoAlternativo.Cap:=selT048.FieldByName('CAP_DOM').AsString;
      RecapitoAlternativo.Telefono:='';
      RecapitoAlternativo.MedLegale:='';
    end;
    Q040.Close;
    Q040.SetVariable('PROGRESSIVO',selT048.FieldByName('PROGRESSIVO').AsInteger);
    Q040.Open;
    ListAnomalieCompleta.Clear;
    R600DtM1.ListAnomalieNonBloccanti.Clear;
  end;
  if R180In(selT048.FieldByName('TIPO_REGISTRAZIONE').AsString,['N','']) then
  begin
    with A004MW do
    begin
      if (selT048.FieldByName('TIPO_ELEMENTO').AsString = 'I') and selT048.FieldByName('ID_CERTIFICATO_RETT').IsNull then
      begin
        //Inserimento;
        {Se certificato continuazione, recupero causale precedentemente utilizzata}
        CausaleMalattia:=selT048.FieldByName('CAUSALE_MAL').AsString;
        {Se si tratta di un certficato di terapia salva-vita non lo considero come post-ricovero}
        if (selT269.FieldByName('POSTRICOVERO_AUTO').AsString = 'S') and (selT048.FieldByName('AGEVOLAZIONI').AsString <> 'T') then
        begin
          {Verifico se nel priodo precedente all'attuale certificato sono presenti certificati di dimissioni o post ricovero}
          //Leggere le catene di CAUS_RICOVERO e CAUS_POSTRICOVERO e confrontare la causale restituita con le catene complete
          CatenaDimissioni:=GestContinuazione.GetCatenaCaus(selT269.FieldByName('CAUS_RICOVERO').AsString).OnlyChain;
          CatenaPostRic:=GestContinuazione.GetCatenaCaus(selT269.FieldByName('CAUS_POSTRICOVERO').AsString).OnlyChain;
          GetPostRicovero.SetVariable('INPROGR',selT048.FieldByName('PROGRESSIVO').AsInteger);
          GetPostRicovero.SetVariable('INDATA',selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime);
          GetPostRicovero.Execute;
          TempCaus:=VarToStr(GetPostRicovero.GetVariable('OUTCAUSALE'));
          if ((Not TempCaus.IsEmpty) and R180InConcat(TempCaus,CatenaDimissioni)) or
             ((Not TempCaus.IsEmpty) and R180InConcat(TempCaus,CatenaPostRic)) then
          begin
            CausaleMalattia:=selT269.FieldByName('CAUS_POSTRICOVERO').AsString;
            {Aggiorno la causale di malattia su tabella T048}
            with TOracleQuery.Create(nil) do
              try
                Session:=SessioneOracle;
                SQL.Add('update T048_ATTESTATIINPS T048');
                SQL.Add('   set T048.CAUSALE_MAL = :CAUS_POSTRICOVERO');
                SQL.Add(' where T048.ID_CERTIFICATO = :ID_CERTIFICATO');
                DeclareVariable('CAUS_POSTRICOVERO',otString);
                DeclareVariable('ID_CERTIFICATO',otString);
                SetVariable('CAUS_POSTRICOVERO',CausaleMalattia);
                SetVariable('ID_CERTIFICATO',selT048.FieldByName('ID_CERTIFICATO').AsString);
                Execute;
              finally
                Free;
              end;
          end;
        end;
        InserisciCertificato(CausaleMalattia, selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime, selT048.FieldByName('DATA_FINE_MAL').AsDateTime);
        for j:=0 to ListAnomalieCompleta.Count - 1 do
        begin
          CreaAnomalia(ListAnomalieCompleta[j],Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          VetAttestato[CurrDip].Anomalia:=True;
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[R600DtM1.ListAnomalieNonBloccanti[j]]),Parametri.Azienda,Var_Progressivo);
        if (ListAnomalieCompleta.Count = 0) and (R600DtM1.ListAnomalieNonBloccanti.Count = 0) then
          RegistraMsg.InserisciMessaggio('I',LogMsg + ' ' +  A000MSG_A087_MSG_PERIODO_INSERITO,Parametri.Azienda,Var_Progressivo);
      end
      else if R180In(selT048.FieldByName('TIPO_ELEMENTO').AsString,['C','A']) then
      begin
        //Annullamento
        with A004MW do
        begin
          if selT048.FieldByName('TIPO_ELEMENTO').AsString = 'A' then
            CancellaCertificatoAlternativo
          else
            CancellaCertificato(selT048.FieldByName('ID_CERTIFICATO').AsString);
          if not VetAttestato[CurrDip].Anomalia then
            RegistraMsg.InserisciMessaggio('I',LogMsg + A000MSG_A087_MSG_PERIODO_ANNUNLLATO,Parametri.Azienda,Var_Progressivo);
          selT040.Close;
        end;
      end
      else if (selT048.FieldByName('TIPO_ELEMENTO').AsString = 'I') and
           Not selT048.FieldByName('ID_CERTIFICATO_RETT').IsNull then
      begin
        //Rettifica
        CancellaCertificato(selT048.FieldByName('ID_CERTIFICATO_RETT').AsString);
        if selT040.RecordCount <= 0 then
          CreaAnomalia(LogMsg + ' ' +  Format(A000MSG_A087_MSG_CAUS_NON_TROVATE,[selT048.FieldByName('ID_CERTIFICATO').AsString]),
                       Var_Progressivo, VetAttestato[CurrDip].ID_Certificato);
        InserisciCertificato(selT048.FieldByName('CAUSALE_MAL').AsString,
                             selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime,
                             selT048.FieldByName('DATA_FINE_MAL').AsDateTime);
        for j:=0 to ListAnomalieCompleta.Count - 1 do
        begin
          CreaAnomalia(ListAnomalieCompleta[j],Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          VetAttestato[CurrDip].Anomalia:=True;
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[R600DtM1.ListAnomalieNonBloccanti[j]]),Parametri.Azienda,Var_Progressivo);
        if (ListAnomalieCompleta.Count = 0) and (R600DtM1.ListAnomalieNonBloccanti.Count = 0) then
          RegistraMsg.InserisciMessaggio('I',LogMsg + A000MSG_A087_MSG_GIUSTIF_RETT,Parametri.Azienda,Var_Progressivo);
        selT040.Close;
      end
      else if selT048.FieldByName('TIPO_ELEMENTO').AsString = 'R' then
      begin
        //Ricovero
        InserisciCertificato(selT048.FieldByName('CAUSALE_MAL').AsString,
                             selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime,
                             selT048.FieldByName('DATA_FINE_MAL').AsDateTime);
        for j:=0 to ListAnomalieCompleta.Count - 1 do
        begin
          CreaAnomalia(ListAnomalieCompleta[j],Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          VetAttestato[CurrDip].Anomalia:=True;
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A', Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[R600DtM1.ListAnomalieNonBloccanti[j]]),Parametri.Azienda,Var_Progressivo);
        if (ListAnomalieCompleta.Count = 0) and (R600DtM1.ListAnomalieNonBloccanti.Count = 0) then
          RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A087_MSG_GIUSTIF_INSERITO,[LogMsg]),Parametri.Azienda,Var_Progressivo);
      end
      else if selT048.FieldByName('TIPO_ELEMENTO').AsString = 'D' then
      begin
        {Dimissioni}
        if selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime <= selT048.FieldByName('DATA_FINE_MAL').AsDateTime then
          InserisciCertificato(selT048.FieldByName('CAUSALE_MAL').AsString,
                               selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime,
                               selT048.FieldByName('DATA_FINE_MAL').AsDateTime)
        else
        begin
          {Se DATA_INIZIO_MAL è > di DATA_FINE_MAL le dimissioni avvengono nello stesso giorno del ricovero.
           Registro solo il dato su T048(correggendo le date DATA_INIZIO_MAL - 1), ma evito inserimento su T040}
          with TOracleQuery.Create(Self) do
            try
              Session:=SessioneOracle;
              SQL.Add('update T048_ATTESTATIINPS T048');
              SQL.Add('   set T048.DATA_INIZIO_MAL = T048.DATA_INIZIO_MAL - 1');
              SQL.Add(' where T048.ID_CERTIFICATO = :ID_CERTIFICATO');
              DeclareVariable('ID_CERTIFICATO',otString);
              SetVariable('ID_CERTIFICATO',selT048.FieldByName('ID_CERTIFICATO').AsString);
              Execute;
            finally
              Free;
            end;
        end;
        //Gestione post-ricovero
        if selT048.FieldByName('DATA_FINEPOSTRIC').AsDateTime > selT048.FieldByName('DATA_FINE_MAL').AsDateTime then
          InserisciCertificato(selT048.FieldByName('CAUSALE_POSTRIC').AsString,
                               selT048.FieldByName('DATA_FINE_MAL').AsDateTime + 1,
                               selT048.FieldByName('DATA_FINEPOSTRIC').AsDateTime);
        for j:=0 to ListAnomalieCompleta.Count - 1 do
        begin
          CreaAnomalia(ListAnomalieCompleta[j],Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
          VetAttestato[CurrDip].Anomalia:=True;
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[R600DtM1.ListAnomalieNonBloccanti[j]]),Parametri.Azienda,Var_Progressivo);
        if (ListAnomalieCompleta.Count = 0) and (R600DtM1.ListAnomalieNonBloccanti.Count = 0) then
          RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A087_MSG_GIUSTIF_INSERITO,[LogMsg]),Parametri.Azienda,Var_Progressivo);
      end;
    end;
  end
  //TORINO_CSI
  else if selT048.FieldByName('TIPO_REGISTRAZIONE').AsString = 'T' then
  begin
    {Gestione modifica periodo}
    RidefinizionePeriodoFileTXT(selT048.FieldByName('ID_CERTIFICATO').AsString);
    for j:=0 to A004MW.ListAnomalieCompleta.Count - 1 do
    begin
      CreaAnomalia(A004MW.ListAnomalieCompleta[j],A004MW.Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
      VetAttestato[CurrDip].Anomalia:=True;
    end;
    for j:=0 to A004MW.R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE,[A004MW.R600DtM1.ListAnomalieNonBloccanti[j]]),Parametri.Azienda,A004MW.Var_Progressivo);
    {Script ORACLE per modifica dati su tabella T048, se si è verificata un anomalia precedente}
    if not VetAttestato[CurrDip].Anomalia then
    begin
      with TA087EditCertificato.create do
      begin
        try
          OpenSelT048Old(IDCertificatoModificato,selT048.FieldByName('ID_CERTIFICATO').AsString);
          SetCampo('NUM_PROTOCOLLO', selT048.FieldByName('NUM_PROTOCOLLO').AsString);
          SetCampo('TIPO_GESTIONE', selT048.FieldByName('TIPO_GESTIONE').AsString);
          SetCampo('DATA_REGISTRAZIONE', R180SysDate(SessioneOracle));
          SetCampo('DATA_FINE_MAL', selT048.FieldByName('DATA_FINE_MAL').AsDateTime);
          SetCampo('DATA_RILASCIO', selT048.FieldByName('DATA_RILASCIO').AsDateTime);
          SetCampo('DATA_CONSEGNA', selT048.FieldByName('DATA_CONSEGNA').AsDateTime);
          SetCampo('TIPO_CERTIFICATO', selT048.FieldByName('TIPO_CERTIFICATO').AsString);
          SetCampo('CAUSALE_MAL', selT048.FieldByName('CAUSALE_MAL').AsString);
          SetCampo('CAUSA_MALATTIA', selT048.FieldByName('CAUSA_MALATTIA').AsString);
          SetCampo('AGEVOLAZIONI', selT048.FieldByName('AGEVOLAZIONI').AsString);
          SetCampo('NOTE', selT048.FieldByName('NOTE').AsString);
          SetCampo('COGNOME_REP', selT048.FieldByName('COGNOME_REP').AsString);
          SetCampo('VIA_REP', selT048.FieldByName('VIA_REP').AsString);
          SetCampo('CODCATASTALE_REP', selT048.FieldByName('CODCATASTALE_REP').AsString);
          SetCampo('PROV_REP', selT048.FieldByName('PROV_REP').AsString);
          SetCampo('CAP_REP', selT048.FieldByName('CAP_REP').AsString);
          T048Post;
        except
          on e:exception do
          begin
            CreaAnomalia(e.Message,A004MW.Var_Progressivo,VetAttestato[CurrDip].ID_Certificato);
            VetAttestato[CurrDip].Anomalia:=True;
          end;
        end;
        Free;
      end;
    end;
    if not VetAttestato[CurrDip].Anomalia then
      RegistraMsg.InserisciMessaggio('I',Format('%s modificato correttamente',[LogMsg]),Parametri.Azienda,
                                     selT048.FieldByName('PROGRESSIVO').AsInteger);
  end;

  if Not VetAttestato[CurrDip].Anomalia then
  begin
    updT048.SetVariable('IDCERTIFICATO',VetAttestato[CurrDip].ID_Certificato);
    updT048.SetVariable('TELEMENTO',VetAttestato[CurrDip].Tipo_Elemento);
    updT048.Execute;
  end
  else
  begin
    if evtInserimentoChecked then
      //Registrazione attestati: annullo ultimo attestato con rollback
      SessioneOracle.Rollback
    else if VetAttestato[CurrDip].Tipo_Elemento <> 'C' then
    begin
      //Solo controllo: annullo ultimo attestato cancellando esplicitamente la T040
      delT040.SetVariable('ID_CERTIFICATO',VetAttestato[CurrDip].ID_Certificato);
      delT040.Execute;
    end;
    //Cancello attestato appena inserito
    delT048.SetVariable('ID',VetAttestato[CurrDip].ID_Certificato);
    delT048.SetVariable('TIPO',VetAttestato[CurrDip].Tipo_Elemento);
    delT048.Execute;
  end;

  if evtInserimentoChecked then
    SessioneOracle.Commit;
  Application.ProcessMessages;
end;

procedure TA087FImpAttestatiMalMW.InsDipT048;
var
  InizioMal, FineMal:TDatetime;
  LogMsg:String;

  procedure InsAttestato;
  begin
    SetLength(VetAttestato,Length(VetAttestato) + 1);
    VetAttestato[High(VetAttestato)].ID_Certificato:=VarToStr(InsT048.GetVariable('ID_CERTIFICATO'));
    VetAttestato[High(VetAttestato)].Tipo_Elemento:=VarToStr(InsT048.GetVariable('TIPO_ELEMENTO'));
    VetAttestato[High(VetAttestato)].Anomalia:=False;
  end;

  function InsRicovero:Boolean;
  begin
    Result:=True;
    if selT269.FieldByName('CAUS_RICOVERO').IsNull then
    begin
      CreaAnomalia(A000MSG_A087_MSG_CAUS_RIC_NON_INS);
      CDtsTemp.Next;
      Result:=False;
      Exit;
    end;

    if ControlloPeriodiRapporto then
    begin
      CDtsTemp.Next;
      Result:=False;
      Exit;
    end;

    LogMsg:='Periodo: ' + VarToStr(GetCampo('DATARICOVERO_RICOVERO'));
    try
      InsT048.SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
      InsT048.SetVariable('ID_CERTIFICATO',GetCampo('IDINIZIORICOVERO_RICOVERO'));
      InsT048.SetVariable('TIPO_ELEMENTO','R');
      InsT048.SetVariable('COD_FISCALE_AZIENDA',GetCampo('CODFISCAZIENDA_RICOVERO'));
      InsT048.SetVariable('CAUSALE_MAL',selT269.FieldByName('CAUS_RICOVERO').AsString);
      InsT048.SetVariable('MATRICOLA_INPS',GetCampo('MATRICOLAINPS_RICOVERO'));
      InsT048.SetVariable('COD_SEDE_INPDAP',GetCampo('CODSEDE_RICOVERO'));
      InsT048.SetVariable('COD_FISCALE_MED',GetCampo('CODICEFISCALE_OPERATORE'));
      InsT048.SetVariable('COGNOME_MED',GetCampo('COGNOME_OPERATORE'));
      InsT048.SetVariable('NOME_MED',GetCampo('NOME_OPERATORE'));
      InsT048.SetVariable('COD_REGIONE',GetCampo('CODICEREGIONE_OPERATORE'));
      InsT048.SetVariable('COD_ASL',GetCampo('CODICEASL_OPERATORE'));
      InsT048.SetVariable('CODSTRUTTURA_MED',GetCampo('CODICESTRUTTURA_OPERATORE'));
      InsT048.SetVariable('COD_FISCALE',GetCampo('CODICEFISCALE_LAVORATORE'));
      InsT048.SetVariable('COGNOME',GetCampo('COGNOME_LAVORATORE'));
      InsT048.SetVariable('NOME',GetCampo('NOME_LAVORATORE'));
      InsT048.SetVariable('SESSO',GetCampo('SESSO_LAVORATORE'));
      InsT048.SetVariable('DATA_NAS',ConvData(GetCampo('DATANASCITA_LAVORATORE')));
      InsT048.SetVariable('CODCATASTALE_NAS',GetCampo('COMUNENASCITA_LAVORATORE'));
      InsT048.SetVariable('PROV_NAS',GetCampo('PROVINCIANASCITA_LAVORATORE'));
      InsT048.SetVariable('VIA_DOM',GetCampo('VIA_RESIDENZA'));
      InsT048.SetVariable('CIVICO_DOM',GetCampo('CIVICO_RESIDENZA'));
      InsT048.SetVariable('CAP_DOM',GetCampo('CAP_RESIDENZA'));
      if Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_RESIDENZA'),[srFromBeginning]) then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Result:=False;
        Exit;
      end;
      InsT048.SetVariable('CODCATASTALE_DOM',GetCampo('COMUNE_RESIDENZA'));
      InsT048.SetVariable('PROV_DOM',GetCampo('PROVINCIA_RESIDENZA'));
      InsT048.SetVariable('DATA_INIZIO_MAL',ConvData(GetCampo('DATARICOVERO_RICOVERO')));
      InsT048.SetVariable('DATA_FINE_MAL',ConvData(GetCampo('DATARICOVERO_RICOVERO')));
      InsT048.SetVariable('GIORNATALAVORATA',ConvBool(GetCampo('GIORNATALAVORATA_RICOVERO')));
      InsT048.Execute;
      InsAttestato;
      RegistraMsg.InserisciMessaggio('I',LogMsg + A000MSG_A087_MSG_PERIODO_INSERITO,Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
    except
    on E:Exception do
      begin
        CreaAnomalia(LogMsg + ' ' + E.Message,selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Result:=False;
        Exit;
      end;
    end;
  end;

  function InsDimissioni:Boolean;
  begin
    Result:=True;
    if ControlloPeriodiRapporto then
    begin
      CDtsTemp.Next;
      Result:=False;
      Exit;
    end;

    selT048.Close;
    selT048.SetVariable('ID_CERTIFICATO',GetCampo('IDINIZIORICOVERO_DIMISSIONI'));
    selT048.SetVariable('TELEMENTO','R');
    selT048.Open;
    if selT048.RecordCount = 0 then
    begin
      CreaAnomalia('Certificato "' + VarToStr(GetCampo('IDINIZIORICOVERO_DIMISSIONI')) + '" di ricovero inesistente.',
                                              selT030.FieldByName('PROGRESSIVO').AsInteger);
      CDtsTemp.Next;
      Result:=False;
      Exit;
    end;

    LogMsg:='Periodo: ' + VarToStr(GetCampo('DATARICOVERO_DIMISSIONI')) + ' - ' + VarToStr(GetCampo('DATADIMISSIONI_DIMISSIONI'));
    try
      InsT048.SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
      InsT048.SetVariable('ID_CERTIFICATO',GetCampo('IDDIMISSIONI_DIMISSIONI'));
      InsT048.SetVariable('TIPO_ELEMENTO','D');
      InsT048.SetVariable('COD_FISCALE_AZIENDA',GetCampo('CODFISCAZIENDA_DIMISSIONI'));
      InsT048.SetVariable('CAUSALE_MAL',selT048.FieldByName('CAUSALE_MAL').AsString);
      InsT048.SetVariable('CAUSALE_POSTRIC',selT269.FieldByName('CAUS_POSTRICOVERO').AsString);
      InsT048.SetVariable('MATRICOLA_INPS',GetCampo('MATRICOLAINPS_DIMISSIONI'));
      InsT048.SetVariable('COD_SEDE_INPDAP',GetCampo('CODSEDE_DIMISSIONI'));
      InsT048.SetVariable('COD_FISCALE_MED',GetCampo('CODICEFISCALE_MEDICO'));
      InsT048.SetVariable('COGNOME_MED',GetCampo('COGNOME_MEDICO'));
      InsT048.SetVariable('NOME_MED',GetCampo('NOME_MEDICO'));
      InsT048.SetVariable('COD_REGIONE',GetCampo('CODICEREGIONE_MEDICO'));
      InsT048.SetVariable('COD_ASL',GetCampo('CODICEASL_MEDICO'));
      InsT048.SetVariable('CODSTRUTTURA_MED',GetCampo('CODICESTRUTTURA_MEDICO'));
      InsT048.SetVariable('COD_FISCALE',GetCampo('CODICEFISCALE_LAVORATORE'));
      InsT048.SetVariable('ID_CERTIFICATO_RETT',GetCampo('IDINIZIORICOVERO_RICOVERO'));
      InsT048.SetVariable('COGNOME',GetCampo('COGNOME_LAVORATORE'));
      InsT048.SetVariable('NOME',GetCampo('NOME_LAVORATORE'));
      InsT048.SetVariable('SESSO',GetCampo('SESSO_LAVORATORE'));
      InsT048.SetVariable('DATA_NAS',ConvData(GetCampo('DATANASCITA_LAVORATORE')));
      InsT048.SetVariable('CODCATASTALE_NAS',GetCampo('COMUNENASCITA_LAVORATORE'));
      InsT048.SetVariable('PROV_NAS',GetCampo('PROVINCIANASCITA_LAVORATORE'));
      InsT048.SetVariable('VIA_DOM',GetCampo('VIA_RESIDENZA'));
      InsT048.SetVariable('CIVICO_DOM',GetCampo('CIVICO_RESIDENZA'));
      InsT048.SetVariable('CAP_DOM',GetCampo('CAP_RESIDENZA'));
      if Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_RESIDENZA'),[srFromBeginning]) then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Result:=False;
        Exit;
      end;
      InsT048.SetVariable('CODCATASTALE_DOM',GetCampo('COMUNE_RESIDENZA'));
      InsT048.SetVariable('PROV_DOM',GetCampo('PROVINCIA_RESIDENZA'));
      InsT048.SetVariable('COGNOME_REP',GetCampo('COGNOME_REPERIBILITA'));
      InsT048.SetVariable('VIA_REP',GetCampo('VIA_INDIRIZZO'));
      InsT048.SetVariable('CIVICO_REP',GetCampo('CIVICO_INDIRIZZO'));
      InsT048.SetVariable('CAP_REP',GetCampo('CAP_INDIRIZZO'));
      if (VarToStr(GetCampo('COMUNE_INDIRIZZO')) <> '') and Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_INDIRIZZO'),[srFromBeginning]) then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_REP_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Result:=False;
        Exit;
      end;
      InsT048.SetVariable('CODCATASTALE_REP',GetCampo('COMUNE_INDIRIZZO'));
      InsT048.SetVariable('PROV_REP',GetCampo('PROVINCIA_INDIRIZZO'));
      if ConvData(GetCampo('DATARICOVERO_DIMISSIONI')) = selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime then
        InsT048.SetVariable('DATA_INIZIO_MAL',ConvData(GetCampo('DATARICOVERO_DIMISSIONI')) + 1)
      else if ConvData(GetCampo('DATARICOVERO_DIMISSIONI')) > selT048.FieldByName('DATA_INIZIO_MAL').AsDateTime then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A087_ERR_DIMISSIONI_1,[LogMsg,VarToStr(GetCampo('IDDIMISSIONI_DIMISSIONI'))]), Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
        InsT048.SetVariable('DATA_INIZIO_MAL',ConvData(GetCampo('DATARICOVERO_DIMISSIONI')));
      end;
      InsT048.SetVariable('DATA_FINE_MAL',ConvData(GetCampo('DATADIMISSIONI_DIMISSIONI')));
      InsT048.SetVariable('DATA_FINEPOSTRIC',ConvData(GetCampo('DATAFINE_DIMISSIONI')));
      InsT048.SetVariable('TIPO_CERTIFICATO',GetCampo('TIPOCERTIFICATO_DIMISSIONI'));
      InsT048.SetVariable('TIPO_RICOVERO',GetCampo('TIPORICOVERO_DIMISSIONI'));
      InsT048.SetVariable('GIORNATALAVORATA',ConvBool(VarToStr(GetCampo('GIORNATALAVORATA_DIMISSIONI'))));
      InsT048.SetVariable('TRAUMA',ConvBool(VarToStr(GetCampo('TRAUMA_DIMISSIONI'))));
      InsT048.SetVariable('AGEVOLAZIONI',GetCampo('AGEVOLAZIONI_DIMISSIONI'));
      InsT048.Execute;
      InsAttestato;
      RegistraMsg.InserisciMessaggio('I',LogMsg + ' periodo inserito correttamente',Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
    except
      on E:Exception do
      begin
        CreaAnomalia(LogMsg + ' ' + E.Message,selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Result:=False;
        Exit;
      end;
    end;
  end;

begin
  CDtsTemp.First;
  vetCertifAnomalie.Clear;
  vetCertifAcquisiti.Clear;
  SetLength(VetAttestato,0);
  while Not CDtsTemp.Eof do
  begin
    InizioMal:=ConvData(GetCampo('DATAINIZIO_ATTESTATO'));
    FineMal:=ConvData(GetCampo('DATAFINE_ATTESTATO'));
    //Controlli effettuati solo se TIPO_OPERAZIONE = 'ATTESTATO'
    if (UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'ATTESTATO') and
       (UpperCase(CDtsTemp.FieldByName('TIPOCERTIFICATO_ATTESTATO').AsString) <> 'A') then
    begin
      if InizioMal = 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_CERT_DATA_INIZIO,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO')),VarToStr(GetCampo('DATAINIZIO_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;
      if FineMal = 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_CERT_DATA_FINE,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO')),VarToStr(GetCampo('DATAFINE_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;
      if FineMal < InizioMal then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_ID_INIZIO_MAGG_FINE,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;
    end;

    InsT048.ClearVariables;
    InsT048.SetVariable('DATA_REGISTRAZIONE',R180SysDate(SessioneOracle));
    InsT048.SetVariable('OPERATORE',Parametri.Operatore);
    InsT048.SetVariable('TIPO_GESTIONE','A');
    if (UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'ATTESTATO') and
       (GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO') = NULL) then
    begin
      {Inserimento}
      if InizioMal = 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_CERT_DATA_INIZIO,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO')),VarToStr(GetCampo('DATAINIZIO_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;
      if FineMal = 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_CERT_DATA_FINE,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO')),VarToStr(GetCampo('DATAFINE_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;
      if FineMal < InizioMal then
      begin
        CreaAnomalia(Format(A000MSG_A087_ERR_ID_INIZIO_MAGG_FINE,[VarToStr(GetCampo('IDCERTIFICATO_ATTESTATO'))]));
        CDtsTemp.Next;
        Continue;
      end;

      if ControlloPeriodiRapporto then
      begin
        CDtsTemp.Next;
        Continue;
      end;

      LogMsg:='Periodo: ' + VarToStr(GetCampo('DATAINIZIO_ATTESTATO')) + ' - ' + VarToStr(GetCampo('DATAFINE_ATTESTATO'));
      try
        InsT048.SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
        InsT048.SetVariable('ID_CERTIFICATO',GetCampo('IDCERTIFICATO_ATTESTATO'));
        InsT048.SetVariable('TIPO_ELEMENTO','I');
        InsT048.SetVariable('COD_FISCALE_AZIENDA',GetCampo('CODFISCAZIENDA_ATTESTATO'));
        if VarToStr(GetCampo('AGEVOLAZIONI_ATTESTATO')) = 'T' then
          if Not selT269.FieldByName('CAUS_SALVAVITA').isNull then
            InsT048.SetVariable('CAUSALE_MAL',selT269.FieldByName('CAUS_SALVAVITA').AsString)
          else
          begin
            CreaAnomalia(Format(A000MSG_A087_ERR_CAUS_SV_NON_SELEZIONATA,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
            CDtsTemp.Next;
            Continue;
          end
        else if VarToStr(GetCampo('AGEVOLAZIONI_ATTESTATO')) = 'C' then
          if Not selT269.FieldByName('CAUS_SERVIZIO').isNull then
            InsT048.SetVariable('CAUSALE_MAL',selT269.FieldByName('CAUS_SERVIZIO').AsString)
          else
          begin
            CreaAnomalia(Format(A000MSG_A087_ERR_CAUS_SRV_NON_SEL,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
            CDtsTemp.Next;
            Continue;
          end
        else
          InsT048.SetVariable('CAUSALE_MAL',selT269.FieldByName('CAUS_INSERIMENTO').AsString);
        InsT048.SetVariable('MATRICOLA_INPS',GetCampo('MATRICOLAINPS_ATTESTATO'));
        InsT048.SetVariable('COD_SEDE_INPDAP',GetCampo('CODSEDE_ATTESTATO'));
        InsT048.SetVariable('COD_FISCALE_MED',GetCampo('CODICEFISCALE_MEDICO'));
        InsT048.SetVariable('COGNOME_MED',GetCampo('COGNOME_MEDICO'));
        InsT048.SetVariable('NOME_MED',GetCampo('NOME_MEDICO'));
        InsT048.SetVariable('COD_REGIONE',GetCampo('CODICEREGIONE_MEDICO'));
        InsT048.SetVariable('COD_ASL',GetCampo('CODICEASL_MEDICO'));
        InsT048.SetVariable('CODSTRUTTURA_MED',GetCampo('CODICESTRUTTURA_MEDICO'));
        InsT048.SetVariable('COD_FISCALE',GetCampo('CODICEFISCALE_LAVORATORE'));
        InsT048.SetVariable('COGNOME',GetCampo('COGNOME_LAVORATORE'));
        InsT048.SetVariable('NOME',GetCampo('NOME_LAVORATORE'));
        InsT048.SetVariable('SESSO',GetCampo('SESSO_LAVORATORE'));
        InsT048.SetVariable('DATA_NAS',ConvData(GetCampo('DATANASCITA_LAVORATORE')));
        InsT048.SetVariable('CODCATASTALE_NAS',GetCampo('COMUNENASCITA_LAVORATORE'));
        InsT048.SetVariable('PROV_NAS',GetCampo('PROVINCIANASCITA_LAVORATORE'));
        InsT048.SetVariable('VIA_DOM',GetCampo('VIA_RESIDENZA'));
        InsT048.SetVariable('CIVICO_DOM',GetCampo('CIVICO_RESIDENZA'));
        InsT048.SetVariable('CAP_DOM',GetCampo('CAP_RESIDENZA'));
        if Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_RESIDENZA'),[srFromBeginning]) then
        begin
          CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
        InsT048.SetVariable('CODCATASTALE_DOM',GetCampo('COMUNE_RESIDENZA'));
        InsT048.SetVariable('PROV_DOM',GetCampo('PROVINCIA_RESIDENZA'));
        InsT048.SetVariable('COGNOME_REP',GetCampo('COGNOME_REPERIBILITA'));
        InsT048.SetVariable('VIA_REP',GetCampo('VIA_INDIRIZZO'));
        InsT048.SetVariable('CIVICO_REP',GetCampo('CIVICO_INDIRIZZO'));
        InsT048.SetVariable('CAP_REP',GetCampo('CAP_INDIRIZZO'));
        if (VarToStr(GetCampo('COMUNE_INDIRIZZO')) <> '') and Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_INDIRIZZO'),[srFromBeginning]) then
        begin
          CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_REP_NON_TROVATO,[LogMsg]), selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
        InsT048.SetVariable('CODCATASTALE_REP',GetCampo('COMUNE_INDIRIZZO'));
        InsT048.SetVariable('PROV_REP',GetCampo('PROVINCIA_INDIRIZZO'));
        InsT048.SetVariable('DATA_RILASCIO',ConvData(GetCampo('DATARILASCIO_ATTESTATO')));
        InsT048.SetVariable('DATA_INIZIO_MAL',ConvData(GetCampo('DATAINIZIO_ATTESTATO')));
        InsT048.SetVariable('DATA_FINE_MAL',ConvData(GetCampo('DATAFINE_ATTESTATO')));
        InsT048.SetVariable('COD_DIAGNOSI',GetCampo('CODICEDIAGNOSI_ATTESTATO'));
        InsT048.SetVariable('TESTO_DIAGNOSI',GetCampo('TESTODIAGNOSI_ATTESTATO'));
        InsT048.SetVariable('TIPO_CERTIFICATO',GetCampo('TIPOCERTIFICATO_ATTESTATO'));
        InsT048.SetVariable('RUOLOMEDICO',GetCampo('RUOLOMEDICO_ATTESTATO'));
        {Controllo se ruolo è professionista privato}
        if UpperCase(VarToStr(GetCampo('RUOLOMEDICO_ATTESTATO'))) = 'P' then
        begin
          if (ConvData(GetCampo('DATAFINE_ATTESTATO')) - ConvData(GetCampo('DATAINIZIO_ATTESTATO'))) > 10 then
            RegistraMsg.InserisciMessaggio('A',A000MSG_A087_MSG_PERIODO_MAG_10GG,Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
        end;
        {-------------------------------------------}
        InsT048.SetVariable('GIORNATALAVORATA',ConvBool(GetCampo('GIORNATALAVORATA_ATTESTATO')));
        InsT048.SetVariable('TRAUMA',ConvBool(GetCampo('TRAUMA_ATTESTATO')));
        InsT048.SetVariable('AGEVOLAZIONI',GetCampo('AGEVOLAZIONI_ATTESTATO'));
        InsT048.SetVariable('ID_CERTIFICATO_RETT',GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO'));
        InsT048.Execute;
        InsAttestato;
        RegistraMsg.InserisciMessaggio('I',LogMsg + A000MSG_A087_MSG_PERIODO_INSERITO,Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
      except
        on E:Exception do
        begin
          CreaAnomalia(LogMsg + ' ' + E.Message,selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
      end;
    end
    else if UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'ANNULLAMENTO' then
    begin
      {Cancellazione}
      selT048.Close;
      selT048.SetVariable('ID_CERTIFICATO',GetCampo('IDCERTIFICATO_ANNULLAMENTO'));
      selT048.SetVariable('TELEMENTO','I');
      selT048.Open;
      if selT048.RecordCount <= 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_ID_ANNULL_NON_TROVATO,[VarToStr(GetCampo('IDCERTIFICATO_ANNULLAMENTO'))]));
        CDtsTemp.Next;
        Continue;
      end;

      LogMsg:='Periodo: ' + selT048.FieldByName('DATA_INIZIO_MAL').AsString + ' - ' + selT048.FieldByName('DATA_FINE_MAL').AsString;
      try
        InsT048.SetVariable('PROGRESSIVO',selT048.FieldByName('PROGRESSIVO').AsInteger);
        InsT048.SetVariable('CAUSALE_MAL',selT048.FieldByName('CAUSALE_MAL').AsString);
        InsT048.SetVariable('TIPO_ELEMENTO','C');
        InsT048.SetVariable('ID_CERTIFICATO',GetCampo('IDCERTIFICATO_ANNULLAMENTO'));
        InsT048.SetVariable('MATRICOLA_INPS',GetCampo('MATRICOLAINPS_ANNULLAMENTO'));
        InsT048.SetVariable('COD_SEDE_INPDAP',GetCampo('CODSEDE_ANNULLAMENTO'));
        InsT048.SetVariable('COD_FISCALE_AZIENDA',GetCampo('CODFISCAZIENDA_ANNULLAMENTO'));
        InsT048.SetVariable('TIPO_CERTIFICATO',GetCampo('TIPOCERTIFICATO_ATTESTATO'));
        InsT048.Execute;
        InsAttestato;
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A087_MSG_PERIODO_ANNULLATO,[LogMsg]),Parametri.Azienda,selT048.FieldByName('PROGRESSIVO').AsInteger);
      except
        on E:Exception do
        begin
          CreaAnomalia(LogMsg + ' ' + E.Message,selT048.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
      end;
    end
    else if (UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'ATTESTATO') and
            (GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO') <> NULL) then
    begin
      {Rettifica}
      selT048.Close;
      selT048.SetVariable('ID_CERTIFICATO',GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO'));
      selT048.SetVariable('TELEMENTO','I');
      selT048.Open;

      if ControlloPeriodiRapporto then
      begin
        CDtsTemp.Next;
        Continue;
      end;

      if selT048.RecordCount <= 0 then
      begin
        CreaAnomalia(Format(A000MSG_A087_MSG_ID_RETT_NON_TROVATO,[VarToStr(GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO'))]),
                     selT030.FieldByName('PROGRESSIVO').AsInteger);
        CDtsTemp.Next;
        Continue;
      end;

      LogMsg:='Periodo: ' + selT048.FieldByName('DATA_INIZIO_MAL').AsString + ' - ' + selT048.FieldByName('DATA_FINE_MAL').AsString;
      try
        InsT048.SetVariable('ID_CERTIFICATO',GetCampo('IDCERTIFICATO_ATTESTATO'));
        InsT048.SetVariable('PROGRESSIVO',selT048.FieldByName('PROGRESSIVO').AsInteger);
        if VarToStr(GetCampo('TIPOCERTIFICATO_ATTESTATO')) = 'A' then
          InsT048.SetVariable('TIPO_ELEMENTO','A')
        else
          InsT048.SetVariable('TIPO_ELEMENTO','I');
        InsT048.SetVariable('ID_CERTIFICATO_RETT',GetCampo('IDCERTIFICATORETTIFICATO_ATTESTATO'));
        if VarToStr(GetCampo('AGEVOLAZIONI_ATTESTATO')) = 'T' then
          if Not selT269.FieldByName('CAUS_SALVAVITA').IsNull then
            InsT048.SetVariable('CAUSALE_MAL',selT269.FieldByName('CAUS_SALVAVITA').AsString)
          else
          begin
            CreaAnomalia(Format(A000MSG_A087_ERR_CAUS_SV_NON_SELEZIONATA,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
            CDtsTemp.Next;
            Continue;
          end
        else if VarToStr(GetCampo('AGEVOLAZIONI_ATTESTATO')) = 'C' then
          if Not selT269.FieldByName('CAUS_SERVIZIO').isNull then
            InsT048.SetVariable('CAUSALE_MAL', selT269.FieldByName('CAUS_SERVIZIO').AsString)
          else
          begin
            CreaAnomalia(Format(A000MSG_A087_ERR_CAUS_SRV_NON_SEL,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
            CDtsTemp.Next;
            Continue;
          end
        else
          InsT048.SetVariable('CAUSALE_MAL', selT269.FieldByName('CAUS_INSERIMENTO').AsString);
        InsT048.SetVariable('COD_FISCALE_AZIENDA',GetCampo('CODFISCAZIENDA_ATTESTATO'));
        InsT048.SetVariable('MATRICOLA_INPS',GetCampo('MATRICOLAINPS_ATTESTATO'));
        InsT048.SetVariable('COD_SEDE_INPDAP',GetCampo('CODSEDE_ATTESTATO'));
        InsT048.SetVariable('COD_FISCALE_MED',GetCampo('CODICEFISCALE_MEDICO'));
        InsT048.SetVariable('COGNOME_MED',GetCampo('COGNOME_MEDICO'));
        InsT048.SetVariable('NOME_MED',GetCampo('NOME_MEDICO'));
        InsT048.SetVariable('COD_REGIONE',GetCampo('CODICEREGIONE_MEDICO'));
        InsT048.SetVariable('COD_ASL',GetCampo('CODICEASL_MEDICO'));
        InsT048.SetVariable('CODSTRUTTURA_MED',GetCampo('CODICESTRUTTURA_MEDICO'));
        InsT048.SetVariable('COD_FISCALE',GetCampo('CODICEFISCALE_LAVORATORE'));
        InsT048.SetVariable('COGNOME',GetCampo('COGNOME_LAVORATORE'));
        InsT048.SetVariable('NOME',GetCampo('NOME_LAVORATORE'));
        InsT048.SetVariable('SESSO',GetCampo('SESSO_LAVORATORE'));
        InsT048.SetVariable('DATA_NAS',ConvData(GetCampo('DATANASCITA_LAVORATORE')));
        InsT048.SetVariable('CODCATASTALE_NAS',GetCampo('COMUNENASCITA_LAVORATORE'));
        InsT048.SetVariable('PROV_NAS',GetCampo('PROVINCIANASCITA_LAVORATORE'));
        InsT048.SetVariable('VIA_DOM',GetCampo('VIA_RESIDENZA'));
        InsT048.SetVariable('CAP_DOM',GetCampo('CAP_RESIDENZA'));
        InsT048.SetVariable('CIVICO_DOM',GetCampo('CIVICO_RESIDENZA'));
        if Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_RESIDENZA'),[srFromBeginning]) then
        begin
          CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
        InsT048.SetVariable('CODCATASTALE_DOM',GetCampo('COMUNE_RESIDENZA'));
        InsT048.SetVariable('PROV_DOM',GetCampo('PROVINCIA_RESIDENZA'));
        InsT048.SetVariable('COGNOME_REP',GetCampo('COGNOME_REPERIBILITA'));
        InsT048.SetVariable('PROV_REP',GetCampo('PROVINCIA_INDIRIZZO'));
        InsT048.SetVariable('VIA_REP',GetCampo('VIA_INDIRIZZO'));
        InsT048.SetVariable('CIVICO_REP',GetCampo('CIVICO_INDIRIZZO'));
        InsT048.SetVariable('CAP_REP',GetCampo('CAP_INDIRIZZO'));
        if Not selT480.SearchRecord('CODCATASTALE',GetCampo('COMUNE_INDIRIZZO'),[srFromBeginning]) then
        begin
          CreaAnomalia(Format(A000MSG_A087_MSG_COMUNE_REP_NON_TROVATO,[LogMsg]),selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
        InsT048.SetVariable('CODCATASTALE_REP',GetCampo('COMUNE_INDIRIZZO'));
        InsT048.SetVariable('DATA_RILASCIO',ConvData(GetCampo('DATARILASCIO_ATTESTATO')));
        InsT048.SetVariable('DATA_INIZIO_MAL',ConvData(GetCampo('DATAINIZIO_ATTESTATO')));
        InsT048.SetVariable('DATA_FINE_MAL',ConvData(GetCampo('DATAFINE_ATTESTATO')));
        InsT048.SetVariable('COD_DIAGNOSI',GetCampo('CODICEDIAGNOSI_ATTESTATO'));
        InsT048.SetVariable('TESTO_DIAGNOSI',GetCampo('TESTODIAGNOSI_ATTESTATO'));
        InsT048.SetVariable('RUOLOMEDICO',GetCampo('RUOLOMEDICO_ATTESTATO'));
        InsT048.SetVariable('GIORNATALAVORATA',ConvBool(GetCampo('GIORNATALAVORATA_ATTESTATO')));
        InsT048.SetVariable('TRAUMA',ConvBool(GetCampo('TRAUMA_ATTESTATO')));
        InsT048.SetVariable('AGEVOLAZIONI',GetCampo('AGEVOLAZIONI_ATTESTATO'));
        InsT048.SetVariable('TIPO_CERTIFICATO',GetCampo('TIPOCERTIFICATO_ATTESTATO'));
        InsT048.Execute;
        InsAttestato;
        RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A087_MSG_PERIODO_RETTIFICATO,[LogMsg]),Parametri.Azienda,selT030.FieldByName('PROGRESSIVO').AsInteger);
      except
        on E:Exception do
        begin
          CreaAnomalia(LogMsg + ' ' + E.Message,selT030.FieldByName('PROGRESSIVO').AsInteger);
          CDtsTemp.Next;
          Continue;
        end;
      end;
    end
    else if UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'RICOVERO' then
    begin
      {Ricovero}
      if Not InsRicovero then
        Continue;
    end
    else if UpperCase(CDtsTemp.FieldByName('TIPO_OPERAZIONE').AsString) = 'DIMISSIONI' then
    begin
      {Dimissioni}
      if Not InsDimissioni then
        Continue;
    end;
    CDtsTemp.Next;
    SessioneOracle.Commit;
  end;
end;

end.

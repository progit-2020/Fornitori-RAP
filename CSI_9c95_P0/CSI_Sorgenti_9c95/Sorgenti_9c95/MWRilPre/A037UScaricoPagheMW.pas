unit A037UScaricoPagheMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle, A000UInterfaccia, USelI010,
  QueryStorico, C180FunzioniGenerali, A000UCostanti, Rp502Pro, R500Lin, R450, R600,
  A000UMessaggi;

type
  TProcControllo = function(Voce: String):Boolean of object;

  TAssenzeMese = record
    Causale:String;
    GG:Currency;
    MG,Min:Word;
    FiniRetr:Byte;
  end;

  TMalattiaCSI = record
    VocePaghe:String;
    GG:Currency;
  end;

  TRec = record
    Mese:Integer;
    Anno:Integer;
    CodicePaghe:String;
    LstCodiciPaghe:string;
    CodiceInterno:String;
    Interfaccia:String;
    Valore,Importo:Currency;
    Misura:String;
    MisuraInterna:String;
    Dal:TDateTime;
    Al:TDateTime;
    Dalle:TDateTime;
    Alle:TDateTime;
    Riferimento:TDateTime;
    DataOper:TDateTime;
  end;

  TA037FScaricoPagheMW = class(TR005FDataModuleMW)
    selT191: TOracleDataSet;
    selT191CODICE: TStringField;
    selT191DESCRIZIONE: TStringField;
    selT191DEFAULTENTE: TStringField;
    selT191TABELLAENTE: TStringField;
    selT191CAMPOENTE: TStringField;
    selT191NOMEFILE: TStringField;
    selT191DATAFILE: TStringField;
    selT191TIPOFILE: TStringField;
    selT191FORMATOORE: TStringField;
    selT191PRECISIONE: TStringField;
    selT191USERPAGHE: TStringField;
    selT191SALVATAGGIO_AUTOMATICO: TStringField;
    selT191SEPARATOREDECIMALI: TStringField;
    selT191MESEANNO: TStringField;
    selT191TIPODATA_FILE: TStringField;
    selT191RICREAZIONE_AUTOMATICA: TStringField;
    dsrT191: TDataSource;
    selCodiciScaricoT196: TOracleDataSet;
    selT196: TOracleDataSet;
    selCountCodiciT196: TOracleDataSet;
    selT193Filtro: TOracleDataSet;
    selT199: TOracleDataSet;
    selMaxDataCassa: TOracleDataSet;
    selT710: TOracleDataSet;
    selT192: TOracleDataSet;
    QDrop: TOracleQuery;
    QIns: TOracleQuery;
    QDel: TOracleQuery;
    selT190: TOracleDataSet;
    selT042: TOracleDataSet;
    selT070: TOracleDataSet;
    selT070INDTURNONUM: TFloatField;
    selT070INDTURNOORE: TFloatField;
    selT070FESTIVINTERA: TFloatField;
    selT070FESTIVRIDOTTA: TFloatField;
    selT070OREASSENZE: TStringField;
    selT070DEBITOORARIO: TStringField;
    selT070DATA: TDateTimeField;
    selT070ADDEBITOPAGHE: TStringField;
    selT070TURNI1: TFloatField;
    selT070TURNI2: TFloatField;
    selT070TURNI3: TFloatField;
    selT070TURNI4: TFloatField;
    selT070ORE_INAIL: TStringField;
    selT070RIPOSI_NONFRUITI: TIntegerField;
    selT070ORECOMP_LIQUIDATE: TFloatField;
    QOreLavFasce: TOracleDataSet;
    QOreLavFasceORELAVORATE: TStringField;
    QOreLavFascePORE_LAV: TStringField;
    QOreLavFasceORE1ASSEST: TStringField;
    QOreLavFasceORE2ASSEST: TStringField;
    QOreLavFasceDATA: TDateTimeField;
    QOreLavFasceMAGGIORAZIONE: TFloatField;
    QOreLavFasceLIQUIDNELMESE: TStringField;
    QOreLavFascePSTR_NEL_MESE: TStringField;
    QOreLavFasceOREINDTURNO: TStringField;
    QOreLavFascePIND_TUR: TStringField;
    QAssestCausali1: TOracleDataSet;
    QAssestCausali1CAUSALE1MINASS: TStringField;
    QAssestCausali1VOCEPAGHE1: TStringField;
    QAssestCausali1VOCEPAGHE2: TStringField;
    QAssestCausali1VOCEPAGHE3: TStringField;
    QAssestCausali1VOCEPAGHE4: TStringField;
    QAssestCausali1DATA: TDateTimeField;
    QAssestCausali2: TOracleDataSet;
    QAssestCausali2CAUSALE2MINASS: TStringField;
    QAssestCausali2VOCEPAGHE1: TStringField;
    QAssestCausali2VOCEPAGHE2: TStringField;
    QAssestCausali2VOCEPAGHE3: TStringField;
    QAssestCausali2VOCEPAGHE4: TStringField;
    QAssestCausali2DATA: TDateTimeField;
    selT134: TOracleDataSet;
    selT074: TOracleDataSet;
    selT074CAUSALE: TStringField;
    selT074OREPRESENZA: TFloatField;
    selT074LIQUIDATO: TFloatField;
    selT074VOCEPAGHE1: TStringField;
    selT074VOCEPAGHE2: TStringField;
    selT074VOCEPAGHE3: TStringField;
    selT074VOCEPAGHE4: TStringField;
    selT074VOCEPAGHELIQ1: TStringField;
    selT074VOCEPAGHELIQ2: TStringField;
    selT074VOCEPAGHELIQ3: TStringField;
    selT074VOCEPAGHELIQ4: TStringField;
    selT074DATA: TDateTimeField;
    selT074ABBATTE_BUDGET: TStringField;
    QIndPresenza: TOracleDataSet;
    QIndPresenzaINDPRES: TStringField;
    QIndPresenzaDATA: TDateTimeField;
    QIndPresenzaVOCEPAGHE: TStringField;
    QNumPasti: TOracleDataSet;
    QBuoniMensa: TOracleDataSet;
    selT690: TOracleDataSet;
    selT762: TOracleDataSet;
    selT076: TOracleDataSet;
    QDatiReper: TOracleDataSet;
    QDatiReperTURNIINTERI: TFloatField;
    QDatiReperTURNIORE: TStringField;
    QDatiReperOREMAGG: TStringField;
    QDatiReperORENONMAGG: TStringField;
    QDatiReperDATA: TDateTimeField;
    QDatiReperGETTONE_CHIAMATA: TIntegerField;
    QDatiReperTUNRNI_OLTREMAX: TIntegerField;
    QDatiReperVP_TURNO: TStringField;
    QDatiReperVP_ORE: TStringField;
    QDatiReperVP_MAGGIORATE: TStringField;
    QDatiReperVP_NONMAGGIORATE: TStringField;
    QDatiReperVP_GETTONE_CHIAMATA: TStringField;
    QDatiReperVP_TURNI_OLTREMAX: TStringField;
    selM040: TOracleDataSet;
    selM050: TOracleDataSet;
    selM052: TOracleDataSet;
    selT040CumuloT: TOracleDataSet;
    selM060: TOracleDataSet;
    selT193: TOracleDataSet;
    selT765: TOracleDataSet;
    Del195PA: TOracleQuery;
    Ins195: TOracleQuery;
    selT195: TOracleDataSet;
    selValore: TOracleQuery;
    selT265: TOracleDataSet;
    selT200: TOracleDataSet;
    selT210: TOracleDataSet;
    UpdM040: TOracleQuery;
    selT195DataCassa: TOracleDataSet;
    selT430: TOracleDataSet;
    OperSQL: TOracleDataSet;
    delT195Cassa: TOracleQuery;
    delT196: TOracleQuery;
    RipristinoVociPaghe: TOracleQuery;
    QSelect: TOracleDataSet;
    selUSR_GetRidEveMal: TOracleDataSet;
    selUSR_GetRidEveMal1: TOracleDataSet;
    T193F_VOCE_SCARICABILE: TOracleQuery;
    T195F_VOCE_GETVALORE: TOracleQuery;
    selT193Extra: TOracleDataSet;
    QIndFunzione: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT070FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    Segno:Boolean;
    DatiAnagrafici:String;
    InterfacceUsate:String;
    CurrCodInt:Integer;
    NumRecord:Integer;
    TotOreLav:LongInt;
    SaldoMese:Integer;
    VettPos :array[1..50] of integer;
    VettLung:array[1..50] of integer;
    VettDef :array[1..50] of String;
    VettTipo:array[1..50] of String;
    VettNome:array[1..50] of String;
    VettCI:array [1..1000] of TRec;
    SelI010:TselI010;
    selDatiAnagrafici:TQueryStorico;
    R502ProDtM1:TR502ProDtM1;
    R450DtM1:TR450DtM1;
    R600DtM1:TR600DtM1;
    tab_giustificativi_vuoto:t_tgiustificdipmese;
    AssenzeMese: array[1..50] of TAssenzeMese;
    MalattiaCSI: array[1..5] of TMalattiaCSI;
    FlagAsse1,FlagAsse2,n_rpassemes:Byte;
    CodiceInterfaccia:String;
    function StrInc(Value: String): String;
    procedure GestisciAssenze(DataCassa: TDateTime);
    procedure ConteggiAssenze(D:TDateTime);
    procedure RiepilogoAssenze(xx: Integer);
    procedure ScorriQueryOreLavFasce(SalvaValore: Boolean; DataCassa: TDateTime);
    procedure ScorriQueryOreIndTurno(DataCassa: TDateTime);
    procedure GestisciBancaOre(DataCassa: TDateTime);
    procedure ScorriCodiciInterni(bDipInSer, bScaricaTrasferte: boolean;CurrMM,CurrAA:Word;DataCassa: TDateTime);
    procedure IntegraCodiciPagheExtra(MM,AA:Word; DataCassa:TDateTime);
    function GetSaldoMese: Integer;
    procedure GestisciSaldoMese(SenzaAssenze: Boolean;DataCassa: TDateTime);
    procedure GestisciBancaOreLiquidata(DataCassa: TDateTime);
    procedure GestisciStrFasce(DataCassa: TDateTime);
    function LeggiCodiceInterfaccia(Progressivo: Integer; Data: TDateTime): String;
    procedure GestisciAddebitoPaghe(DataCassa: TDateTime);
    procedure GestisciPermessiNonRecuperati(DataCassa: TDateTime);
    procedure GestisciFestivitaNonGodute(DataCassa: TDateTime);
    procedure GestisciTotOreLavorate(DataCassa: TDateTime);
    procedure GestisciOreReseInail(DataCassa: TDateTime);
    procedure GestisciNumPasti(DataCassa: TDateTime);
    procedure GestisciTurnoOre(DataCassa: TDateTime);
    procedure GestisciTurnoNum(DataCassa: TDateTime);
    procedure GestisciFestivIntera(DataCassa: TDateTime);
    procedure GestisciFestivRidotta(DataCassa: TDateTime);
    procedure GestisciIndennitaPresenza(DataCassa: TDateTime);
    procedure GestisciIndennitaFunzione(DataCassa: TDateTime);
    procedure GestisciOreCausalizzateLiquidate(DataCassa: TDateTime);
    procedure GestisciAssestCausali(DataCassa: TDateTime);
    procedure ScorriQueryAssestCausali1(DataCassa: TDateTime);
    procedure GestisciLiqOreAnniPrec(DataCassa: TDateTime);
    procedure ScorriQueryAssestCausali2(DataCassa: TDateTime);
    procedure GestisciBuoniMensa(DataCassa: TDateTime);
    procedure GestisciTicket(DataCassa: TDateTime);
    procedure GestisciBuoniTicketAcq(Campo: String;DataCassa: TDateTime);
    procedure GestisciOreCausalizzate(DataCassa: TDateTime);
    procedure GestisciOreCausalizzateABlocchi(DataCassa: TDateTime);
    procedure GestisciDatiReper(Campo: String;DataCassa: TDateTime);
    procedure GestisciTurni(T: String;DataCassa: TDateTime);
    procedure GestisciMissioni(C: String;DataCassa: TDateTime);
    procedure GestisciIndennitaKmMissioni(DataCassa: TDateTime);
    procedure GestisciRimborsoSpese(C: String;DataCassa: TDateTime);
    procedure GestisciAnticipi(Prog: Integer;DataCassa: TDateTime);
    procedure GestisciIncentivi(DataCassa: TDateTime);
    function LeggiCodPaghe(ValueIn: String; var FieldValue: String): Boolean;
    procedure LiquidaMissioni(Prog: Integer; data1, data2, data3: TDate;
      ora: String);
    procedure ScorriMesi(Data,DataIndietro: TDateTime;DipInSer:TDipendenteInServizio;CurrMM,CurrAA:Word;DataCassa: TDateTime);
    procedure GetValore(P, I: Integer;AggiornaT195:Boolean;Conguagli:Boolean;DataCassa: TDateTime);
    function ApplicaFormulaValore(Valore: Currency; Formula: String;DataCassa: TDateTime): Currency;
    function AggiungiZeri(S: String; L: Word): String;
    function FormattaValore(Valore: String; Lung: Word): String;
    function ApriQuery(Prog: Integer; DataIndietro, Data: TDateTime): String;
    procedure AddAnomalia(Matricola, Badge, Cogn, Nome, Mess: String; Prog: Integer);
    procedure ApriQueryIntPaghe(Codice: String);
    procedure GetValoriEsistenti(P: Integer; Interfacce: String;Data,DataIndietro,DataCassa:TDateTime);
//Caratto Obsoleto    procedure EliminaSingolaVoce(P, I: Integer; DataCassa: TDateTime);
    procedure InizializzaVettore(Data, DataFile: TDateTime;CurrMM,CurrAA:Word);
    function EsisteElemento(ACorr, MCorr, AnnoDal, MeseDal: Integer; CodPaghe,
      Misura: String; Range: Integer): Integer;
    procedure SalvaValoreGenerico(CI, CodPaghe: String; Valore: Currency;
      Misura: String; AnnoDal, MeseDal: Word;DataCassa:TDateTime);
    procedure SalvaOreLavorateFasce(CI, CodPaghe: String; OreLavo: Integer;
      Misura: String; First: Boolean; DataCassa: TDateTime);
    procedure GestisciPeriodiAssenze(CurrMM,CurrAA:Word;DataCassa: TDateTime);
    procedure AggiungiVociPrecedenti(DataCassa: TDateTime);
    function TrasformaCodPaghe(Cod, F, Interfaccia: String; AnnoRif, MeseRif: Integer): String;
    function VerificaTrasferte(nProgressivo: integer; dDataInizio, dDataFine: TDateTime): boolean;
    function FormattaDalleAlle(H: TDateTime; F: String; L: Integer): String;
    procedure EliminaVociEsistenti(P: Integer;Data,DataIndietro,DataCassa: TDateTime;FileSeq,Aggiungi: Boolean);
    function FormattaData(F: String; D: TDateTime): String;
    function FormattaOre(M: Integer): String;
    function VoceScaricabile(DataCassa:TDateTime; CodVoce:String; CodVoceCedolino:String = ''): Boolean;
    function GetValPers(DataCassa:TDateTime; CodVoceOrig,CodVoce:String; Valore:Currency): Currency;
  public
    VociStraordinario: array of String;
    ACorr, MCorr:Word;
    //assegnare subito dopo creazione MW
    VoceAbilitata,VoceDisabilitata: TProcControllo;
    function GetNomeFile(DataScarico, DataFile: TDateTime): String;
    function VerificaEsisteImporto: Boolean;
    function DisponibilitaBilancio: Boolean;
    function ApriFileSequenziale(NomeFile:String;Aggiungi:Boolean; var F: TextFile): Boolean;
    function VerificaTabella(Nome:String; Ricrea:Boolean): String;
    function ImpostaTabella(Nome: String;Ricrea: Boolean): Boolean;
    function LeggiParametri: Integer;
    function MessaggioEliminaDataCassa: String;
    function MessaggioRipristina: String;
    function MessaggioSalvataggio: String;
    procedure EliminaUltimaDataCassa;
    procedure ElaboraDipendente(Data, DataFile, DataIndietro,DataCassa:TDateTime;CurrMM,CurrAA:Word; DipInSer:TDipendenteInServizio; AggiornaT195,Conguagli,EsisteImporto,FileSeq,Aggiungi: Boolean; var F: TextFile);
    procedure InizializzaConteggi;
    procedure DistruggiConteggi;
    procedure EliminaFiltroScaricoPaghe(Nome: String);
    procedure SalvaFiltroScaricoPaghe(Nome:String;lstCodiciInterni,lstFiltroVoci: TStringList);
    procedure SalvataggioScarico;
    function LeggiScaricoDaTabella(Nome: String): TStringList;
  end;

implementation

{$R *.dfm}

function TA037FScaricoPagheMW.ApriFileSequenziale(NomeFile:String;Aggiungi:Boolean; var F: TextFile): Boolean;
begin
  Result:=True;
  AssignFile(F,NomeFile);
  try
    if FileExists(NomeFile) and (Aggiungi) then
      Append(F)
    else
      Rewrite(F);
  except
    Result:=False;
  end;
  with selT192 do
  begin
    Close;
    SetVariable('CODICE',selT191.FieldByName('Codice').AsString);
    Open;
  end;
end;

procedure TA037FScaricoPagheMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //VociStraordinario:=VarArrayOf(['032','034','060','160','230']);
  SetLength(VociStraordinario,2);
  VociStraordinario[0]:='060';
  VociStraordinario[1]:='160';
  selT190.Open;
  selT191.Open;
  selT199.Open;
  selT210.Open;
  selT265.Open;
  R600DtM1:=nil;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO,NOME_CAMPO');
end;

procedure TA037FScaricoPagheMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selT191.Close;
  selT199.Close;
  FreeAndNil(selI010);
end;

function TA037FScaricoPagheMW.DisponibilitaBilancio: Boolean;
begin
  with selT710 do
  begin
    Close;
    Open;
    if RecordCount > 0 then
      Result:=False
    else
      Result:=True;
  end;
end;

procedure TA037FScaricoPagheMW.DistruggiConteggi;
begin
  FreeAndNil(R502ProDtM1);
  FreeAndNil(R450DtM1);
  if R600DtM1 <> nil then
    FreeAndNil(R600DtM1);
end;

function TA037FScaricoPagheMW.VerificaEsisteImporto: Boolean;
var
  i: Integer;
begin
Result:=False;
  for i:=1 to High(VettPos) do
  begin
    if VettTipo[i] = 'G' then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TA037FScaricoPagheMW.GetNomeFile(DataScarico, DataFile: TDateTime):String;
var
 Path,FN,Nome1,Nome2:String;
 DataNomeFile: TDateTime;
begin
  Nome1:=selT191.FieldByName('NomeFile').AsString;
  Nome2:=selT191.FieldByName('DataFile').AsString;
  if Trim(Nome2) = '' then
  begin
    Result:=Nome1;
    exit;
  end;
  Path:=ExtractFilePath(Nome1);
  FN:=ExtractFileName(Nome1);
  if selT191.FieldByName('TIPODATA_FILE').AsString = 'S' then
    DataNomeFile:=DataScarico
  else
    DataNomeFile:=DataFile;
  if pos('.',FN) <> 0 then
    Insert(FormatDateTime(Nome2,DataNomeFile),FN,pos('.',FN))
  else
    FN:=FN + FormatDateTime(Nome2,DataNomeFile);
  Result:=Path + FN;
end;

function TA037FScaricoPagheMW.ImpostaTabella(Nome:String; Ricrea: Boolean):Boolean;
var S,C,CCodPaghe,CMatricola,CDal,FDal,Ora:String;
    L:TStringList;
    i,LMatricola:Integer;
    Creazione:Boolean;
begin
  Result:=True;
  L:=TStringList.Create;
  CMatricola:='';
  CDal:='';
  CCodPaghe:='';
  LMatricola:=0;
  if Ricrea then
  begin
    if SelT191.FieldByName('Salvataggio_Automatico').AsString = 'S' then
    //Salvataggio tabella precedente datata con SYSDATE e GRANT allo user paghe
    begin
      QDrop.SQL.Clear;
      QDrop.SQL.Add('SELECT TO_CHAR(SYSDATE,''_YYYYMMDD_HH24MI'') FROM DUAL');
      QDrop.Execute;
      Ora:=QDrop.FieldAsString(0);
      QDrop.SQL.Clear;
      QDrop.SQL.Add('CREATE TABLE ' + Nome + Ora);
      QDrop.SQL.Add('AS SELECT * FROM ' + Nome);
      try
        QDrop.Execute;
      except
      end;
      QDrop.SQL.Clear;
      QDrop.SQL.Add('GRANT ALL ON ' + Nome + Ora + ' TO ' + selT191.FieldByName('USERPAGHE').AsString + ' WITH GRANT OPTION');
      try
        QDrop.Execute;
      except
      end;
    end;
    QDrop.SQL.Clear;
    if selT191.FieldByName('Ricreazione_Automatica').AsString = 'S' then
      QDrop.SQL.Add('DROP TABLE ' + Nome)
    else
      QDrop.SQL.Add('DELETE FROM ' + Nome);
    try
      QDrop.Execute;
      Creazione:=selT191.FieldByName('Ricreazione_Automatica').AsString = 'S';
    except
      Creazione:=selT191.FieldByName('Ricreazione_Automatica').AsString = 'N';
    end;
    SessioneOracle.Commit;
  end;
  selT192.SetVariable('CODICE',selT191.FieldByName('Codice').AsString);
  selT192.Close;
  selT192.Open;
  with QDrop do
  begin
    C:='';
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + Nome + '(');
    while not selT192.Eof do
    begin
      S:='';
      if SQL.Count > 1 then
      begin
        S:=S + ',';
        C:=C + ',';
      end;
      S:=S + selT192.FieldByName('NOME').AsString +' VARCHAR2(' + selT192.FieldByName('LUNG').AsString + ')';
      C:=C + ':' + selT192.FieldByName('NOME').AsString;
      SQL.Add(S);
      L.Add(selT192.FieldByName('NOME').AsString);
      if selT192.FieldByName('TIPO').AsString = '3' then
      begin
        CMatricola:=selT192.FieldByName('NOME').AsString;
        LMatricola:=selT192.FieldByName('LUNG').AsInteger;
      end;
      if selT192.FieldByName('TIPO').AsString = '6' then
        CCodPaghe:=selT192.FieldByName('NOME').AsString;
      if selT192.FieldByName('TIPO').AsString = 'C' then
      begin
        CDal:=selT192.FieldByName('NOME').AsString;
        FDal:=StringReplace(StringReplace(StringReplace(selT192.FieldByName('DEF').AsString,'31','dd',[]),'01','dd',[]),'FR','dd',[]);
      end;
      selT192.Next;
    end;
    SQL.Add(') TABLESPACE ' + Parametri.TSAusiliario);
    SQL.Add('STORAGE (PCTINCREASE 0 INITIAL 512K NEXT 512K) NOPARALLEL');
    if Creazione then
    try
      Execute;
    except
      Result:=not Ricrea;
    end;
    if Result and (Trim(selT191.FieldByName('USERPAGHE').AsString) <> '') then
    begin
      SQL.Clear;
      SQL.Add('GRANT ALL ON ' + Nome + ' TO ' + selT191.FieldByName('USERPAGHE').AsString + ' WITH GRANT OPTION');
      try
        Execute;
      except
      end;
    end;
  end;
  with QIns do
  begin
    DeleteVariables;
    SQL.Clear;
    SQL.Add(Format('INSERT INTO %s (%s) VALUES (%s)',[Nome,StringReplace(C,':','',[rfReplaceAll]),C]));
    for i:=0 to L.Count - 1 do
      DeclareVariable(L[i],otString);
  end;
  with QDel do
  begin
    DeleteVariables;
    SQL.Clear;
    if (CMatricola <> '') and (CDal <> '') and (CCodPaghe <> '') then
    begin
      if (VarToStr(selT192.Lookup('NOME','CHIUSO','DEF')) = 'NO') and (VarToStr(SelT192.Lookup('TIPO','8','NOME')) <> '') then
      begin
        SQL.Add('BEGIN');
        SQL.Add(Format('DELETE FROM %s WHERE %s = LPAD(:Matricola,%d,''0'')',[Nome,CMatricola,LMatricola]));
        SQL.Add(Format('AND TRUNC(TO_DATE(%s,''%s''),''mm'') = :Dal',[CDal,FDal]));
        SQL.Add(Format('AND %s = :CodicePaghe',[CCodPaghe]));
        SQL.Add('AND CHIUSO = ''NO'';');
        SQL.Add(Format('UPDATE %s SET CHIUSO = ''NO'', %s = ''0'' WHERE %s = LPAD(:Matricola,%d,''0'')',[Nome,VarToStr(selT192.Lookup('TIPO','8','NOME')),CMatricola,LMatricola]));
        SQL.Add(Format('AND TRUNC(TO_DATE(%s,''%s''),''mm'') = :Dal',[CDal,FDal]));
        SQL.Add(Format('AND %s = :CodicePaghe',[CCodPaghe]));
        SQL.Add('AND CHIUSO = ''SI'';');
        SQL.Add('END;');
      end
      else
      begin
        SQL.Add(Format('DELETE FROM %s WHERE %s = LPAD(:Matricola,%d,''0'')',[Nome,CMatricola,LMatricola]));
        SQL.Add(Format('AND TRUNC(TO_DATE(%s,''%s''),''mm'') = :Dal',[CDal,FDal]));
        SQL.Add(Format('AND %s = :CodicePaghe',[CCodPaghe]));
      end;
      DeclareVariable('Matricola',otString);
      DeclareVariable('Dal',otDate);
      DeclareVariable('CodicePaghe',otString);
    end;
  end;
end;

function TA037FScaricoPagheMW.VerificaTabella(Nome:String; Ricrea: Boolean): String;
begin
  Result:='';
  if Ricrea then
  begin
    QDrop.SQL.Clear;
    QDrop.SQL.Add('SELECT COUNT(*) FROM ' + Nome);
    try
      QDrop.Execute;
      if QDrop.FieldAsInteger(0) > 0 then
      begin
        Result:='Attenzione!' + #13 + 'Verranno persi i dati correnti!' + #13 + 'Attualmente sono presenti ' + QDrop.FieldAsString(0) + ' movimenti.';
        if SelT191.FieldByName('Salvataggio_Automatico').AsString = 'S' then
          Result:=Result + #13#10 + 'I dati correnti verranno salvati in una nuova tabella.';
        Result:=Result + #13#10 + #13#10 + 'Confermare la ricreazione della tabella?';
      end;
    except
    end;
  end;
end;

function TA037FScaricoPagheMW.LeggiParametri:Integer;
var i:Integer;
    C:String;
begin
  Result:=0;
  for i:=1 to High(VettPos) do
  begin
    VettPos[i]:=0;
    VettLung[i]:=0;
    VettDef[i]:='';
    VettTipo[i]:='';
    VettNome[i]:='';
  end;
  Segno:=False;
  DatiAnagrafici:='';
  with selT192 do
  begin
    First;
    i:=0;
    while not Eof do
    begin
      inc(i);
      VettPos[i]:=FieldByName('POS').AsInteger;
      VettLung[i]:=FieldByName('LUNG').AsInteger;
      VettDef[i]:=FieldByName('DEF').AsString;
      VettTipo[i]:=FieldByName('TIPO').AsString;
      VettNome[i]:=FieldByName('NOME').AsString;
      if VettTipo[i] = '7' then
        Segno:=True;
      if (VettTipo[i] = 'H') and (Trim(VettDef[i]) <> '') then
      begin
        C:=VarToStr(selI010.Lookup('NOME_LOGICO',VettDef[i],'NOME_CAMPO'));
        if (C <> '') and (AliasTabella(C) = 'V430') then
        begin
          if DatiAnagrafici <> '' then
            DatiAnagrafici:=DatiAnagrafici + ',';
          DatiAnagrafici:=DatiAnagrafici + C;
        end;
      end;
      Result:=VettLung[i] + VettPos[i] - 1;
      Next;
    end;
  end;
end;
function TA037FScaricoPagheMW.LeggiScaricoDaTabella(Nome: String): TStringList;
var i,W:Integer;
    S:String;
begin
  Result:=TStringList.Create;
  Result.Clear;
  with QSelect do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + Nome);
    try
      Open;
    except
      Abort;
    end;
    while not Eof do
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
      begin
        W:=Fields[i].DisplayWidth;
        if W > 15 then W:=15;
        S:=S + Format('%-*s ',[W,Fields[i].AsString]);
      end;
      Result.Add(S);
      Next;
    end;
    Close;
  end;
end;

procedure TA037FScaricoPagheMW.selT070FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  try
    if (ACorr = 0) or (MCorr = 0) then
      Accept:=False
    else
      Accept:=DataSet.FieldByName('Data').AsDateTime = EncodeDate(ACorr,MCorr,1);
  except
    Accept:=False;
  end;

end;

function TA037FScaricoPagheMW.FormattaValore(Valore:String; Lung:Word):String;
{Gestione campo valore: includo tutti gli zeri non significativi e
 a seconda dell'opzione si può:
 - togliere il punto decimale o meno
 - avere una precizione di 2 o 3 cifre dei decimali}
var P:Word;
    S1,S2,NZ:String;
begin
  if (Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,Valore) = 0) and (Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator,Valore) > 0) then
    Valore[Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator,Valore)]:={$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator;
  if Segno then
    try
      Valore:=FloatToStr(Abs(StrToFloat(Valore)));
    except
    end;
  if selT191.FieldByName('PRECISIONE').AsString = '0' then
    NZ:='00'   //Precisione in centesimi
  else if selT191.FieldByName('PRECISIONE').AsString = '1' then
    NZ:='000'  //Precisione in millesimi
  else         //Scrittura del valore così com'è
    begin
    S1:=AggiungiZeri(FloatToStr(Abs(StrToFloat(Valore))),Lung);
    Result:=Copy(S1,Length(S1) - Lung + 1,Lung);
    if StrToFloat(Valore) < 0 then
      Result[1]:='-';
    Result:=StringReplace(Result,{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,selT191.FieldByName('SeparatoreDecimali').AsString,[rfReplaceAll]);
    exit;
    end;
  Result:=Valore;
  P:=Pos('.',Valore);
  if P = 0 then
    P:=Pos(',',Valore);
  if P = 0 then
    begin
    S1:=FloatToStr(Abs(StrToFloat(Valore)));
    S2:=NZ;
    end
  else
    begin
    if StrToFloat(Valore) < 0 then
      //Eliminazione del segno '-'
      S1:=Copy(Valore,2,P - 2)
    else
      S1:=Copy(Valore,1,P - 1);
    S2:=Copy(Valore,P + 1,Length(NZ));
    S2:=Copy(S2 + NZ,1,Length(NZ));
    end;
  S1:='0000000000' + S1 + S2;
  Result:=Copy(S1,Length(S1) - Lung + 1,Lung);
  if StrToFloat(Valore) < 0 then
    Result[1]:='-';
  Result:=StringReplace(Result,{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,selT191.FieldByName('SeparatoreDecimali').AsString,[rfReplaceAll]);
end;

function TA037FScaricoPagheMW.AggiungiZeri(S:String; L:Word):String;
var i:Integer;
begin
  Result:=S;
  for i:=Length(S) + 1 to L do
    Result:='0' + Result;
end;

function TA037FScaricoPagheMW.ApriQuery(Prog:Integer;DataIndietro,Data:TDateTime):String;
begin
  Result:='';
  if DatiAnagrafici <> '' then
  begin
    if selDatiAnagrafici = nil then
    begin
      selDatiAnagrafici:=TQueryStorico.Create(nil);
      selDatiAnagrafici.Session:=SessioneOracle;
    end;
    try
      selDatiAnagrafici.GetDatiStorici(DatiAnagrafici,Prog,DataIndietro,R180FineMese(Data));
    except
      Result:=Result + 'V430';
      AddAnomalia(SelAnagrafe.FieldByName('Matricola').AsString,
                  SelAnagrafe.FieldByName('T430Badge').AsString,
                  SelAnagrafe.FieldByName('Cognome').AsString,
                  SelAnagrafe.FieldByName('Nome').AsString,
                  VettAnom[16],
                  SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
  end;
  selT190.Filtered:=False;
  //Periodi assenza
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['180','S']),[srFromBeginning]) then
  try
    SelT042.Close;
    SelT042.SetVariable('Progressivo',Prog);
    SelT042.SetVariable('Data1',R180InizioMese(Data));
    SelT042.Open;
  except
    // Anomalia:'Dati scheda non disponibili'.
    Result:=Result + 'Q042';
    AddAnomalia(SelAnagrafe.FieldByName('Matricola').AsString,
                SelAnagrafe.FieldByName('T430Badge').AsString,
                SelAnagrafe.FieldByName('Cognome').AsString,
                SelAnagrafe.FieldByName('Nome').AsString,
                VettAnom[6],
                SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  //Scheda riepilogativa
  selT070.Close;
  selT070.SetVariable('Progressivo',Prog);
  selT070.SetVariable('Data1',DataIndietro);
  selT070.SetVariable('Data2',Data);
  try
    selT070.Open;
  except
    // Anomalia:'Dati scheda non disponibili'.
    Result:=Result + 'Q070';
    AddAnomalia(SelAnagrafe.FieldByName('Matricola').AsString,
                SelAnagrafe.FieldByName('T430Badge').AsString,
                SelAnagrafe.FieldByName('Cognome').AsString,
                SelAnagrafe.FieldByName('Nome').AsString,
                VettAnom[6],
                SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  //Ore in fasce
  QOreLavFasce.Close;
  QOreLavFasce.SetVariable('Progressivo',Prog);
  QOreLavFasce.SetVariable('Data1',DataIndietro);
  QOreLavFasce.SetVariable('Data2',Data);
  try
    QOreLavFasce.Open;
  except
    Result:=Result + 'QOreLavFasce';
  end;
  //Causali di assestamento
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['200','S']),[srFromBeginning]) then
  try
    //Causale1
    QAssestCausali1.Close;
    QAssestCausali1.SetVariable('Progressivo',Prog);
    QAssestCausali1.SetVariable('Data1',DataIndietro);
    QAssestCausali1.SetVariable('Data2',Data);
    QAssestCausali1.Open;
    //Causale2
    QAssestCausali2.Close;
    QAssestCausali2.SetVariable('Progressivo',Prog);
    QAssestCausali2.SetVariable('Data1',DataIndietro);
    QAssestCausali2.SetVariable('Data2',Data);
    QAssestCausali2.Open;
  except
    Result:=Result + 'QAssestCausali';
  end;
  //Ore liquidate da anni precedenti
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['205','S']),[srFromBeginning]) then
  try
    selT134.Close;
    selT134.SetVariable('Progressivo',Prog);
    selT134.SetVariable('Data1',DataIndietro);
    selT134.SetVariable('Data2',R180FineMese(Data));
    selT134.Open;
  except
    Result:=Result + 'selT134';
  end;
  //Ore causalizzate
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['160','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['230','S']),[srFromBeginning]) then
  try
    selT074.Close;
    selT074.SetVariable('Progressivo',Prog);
    selT074.SetVariable('Data1',DataIndietro);
    selT074.SetVariable('Data2',Data);
    selT074.Open;
  except
    Result:=Result + 'selT074';
  end;
  //Indennità di presenza
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['150','S']),[srFromBeginning]) then
  try
    QIndPresenza.Close;
    QIndPresenza.SetVariable('Progressivo',Prog);
    QIndPresenza.SetVariable('Data1',DataIndietro);
    QIndPresenza.SetVariable('Data2',Data);
    QIndPresenza.Open;
  except
    Result:=Result + 'QIndPresenza';
  end;
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['155','S']),[srFromBeginning]) then
  try
    QIndFunzione.Close;
    QIndFunzione.SetVariable('Progressivo',Prog);
    QIndFunzione.SetVariable('Data1',DataIndietro);
    QIndFunzione.SetVariable('Data2',R180FineMese(Data));
    QIndFunzione.Open;
  except
    Result:=Result + 'QIndFunzione';
  end;
  //Numero pasti
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['100','S']),[srFromBeginning]) then
  try
    QNumPasti.Close;
    QNumPasti.SetVariable('Progressivo',Prog);
    QNumPasti.SetVariable('Data1',DataIndietro);
    QNumPasti.SetVariable('Data2',Data);
    if Parametri.CampiRiferimento.C18_AccessiMensa <> '' then
      QNumPasti.SetVariable('C18_AccessiMensa','T430.' + Parametri.CampiRiferimento.C18_AccessiMensa)
    else
      QNumPasti.SetVariable('C18_AccessiMensa','''<UNICA>''');
    QNumPasti.Open;
  except
    Result:=Result + 'QNumPasti';
  end;
  //Buoni mensa - Ticket
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['210','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['220','S']),[srFromBeginning]) then
  try
    QBuoniMensa.Close;
    QBuoniMensa.SetVariable('Progressivo',Prog);
    QBuoniMensa.SetVariable('Data1',DataIndietro);
    QBuoniMensa.SetVariable('Data2',Data);
    QBuoniMensa.Open;
  except
    Result:=Result + 'QBuoniMensa';
  end;
  //Buoni mensa - Ticket Acquistati
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['215','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['225','S']),[srFromBeginning]) then
  try
    selT690.Close;
    selT690.SetVariable('Progressivo',Prog);
    selT690.SetVariable('Data1',DataIndietro);
    selT690.SetVariable('Data2',R180FineMese(Data));
    selT690.Open;
  except
    Result:=Result + 'selT690';
  end;
  //Incentivi
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['240','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['242','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['244','S']),[srFromBeginning]) then
  try
    selT762.Close;
    selT762.SetVariable('Progressivo',Prog);
    selT762.SetVariable('Data1',DataIndietro);
    selT762.SetVariable('Data2',Data);
    selT762.SetVariable('TipoImporto','''1'',''2'',''3'',''4'',''99'',''100'',''5''');
    selT762.Open;
  except
    Result:=Result + 'selT762';
  end;
  //Ore causalizzate a blocchi
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['250','S']),[srFromBeginning]) then
  try
    selT076.Close;
    selT076.SetVariable('Progressivo',Prog);
    selT076.SetVariable('Data1',DataIndietro);
    selT076.SetVariable('Data2',Data);
    selT076.Open;
  except
    Result:=Result + 'Q076';
  end;
  //Turni di reperibilità
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['260','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['270','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['280','S']),[srFromBeginning]) or
     selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['290','S']),[srFromBeginning]) then
  try
    QDatiReper.Close;
    QDatiReper.SetVariable('Progressivo',Prog);
    QDatiReper.SetVariable('Data1',DataIndietro);
    QDatiReper.SetVariable('Data2',Data);
    QDatiReper.Open;
  except
    Result:=Result + 'QDatiReper';
  end;
  //Missioni/Formazioni
  if Parametri.CampiRiferimento.C8_Missione <> '' then
  begin
    if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['400','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['402','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['404','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['406','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['410','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['412','S']),[srFromBeginning]) then
    try
      selM040.Close;
      selM040.SetVariable('C8_MISSIONE',Parametri.CampiRiferimento.C8_Missione);
      selM040.SetVariable('Progressivo',Prog);
      selM040.SetVariable('Data1',DataIndietro);
      selM040.SetVariable('Data2',Data);
      selM040.Open;
    except
      Result:=Result + 'selM040';
    end;
    //Rimborsi missioni
    if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['424','S']),[srFromBeginning]) or
       selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['426','S']),[srFromBeginning]) then
    try
      selM050.Close;
      selM050.SetVariable('Progressivo',Prog);
      selM050.SetVariable('Data1',DataIndietro);
      selM050.SetVariable('Data2',Data);
      selM050.SetVariable('C8_MISSIONE',Parametri.CampiRiferimento.C8_Missione);
      selM050.Open;
    except
      Result:=Result + 'selM050';
    end;
    //Indennità kilometriche missioni
    if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['408','S']),[srFromBeginning]) then
    try
      selM052.Close;
      selM052.SetVariable('Progressivo',Prog);
      selM052.SetVariable('Data1',DataIndietro);
      selM052.SetVariable('Data2',Data);
      selM052.SetVariable('C8_MISSIONE',Parametri.CampiRiferimento.C8_Missione);
      selM052.Open;
    except
      Result:=Result + 'selM052';
    end;
  end;
  //Permessi non recuperati
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['082','S']),[srFromBeginning]) then
  try
    selT040CumuloT.Close;
    selT040CumuloT.SetVariable('Progressivo',Prog);
    selT040CumuloT.SetVariable('Data1',DataIndietro);
    selT040CumuloT.SetVariable('Data2',R180FineMese(Data));
    selT040CumuloT.Open;
  except
    Result:=Result + 'selT040CumuloT';
  end;

  //Anticipi Missioni
  if selT190.SearchRecord('CODINTERNO;FLAG',VarArrayOf(['428','S']),[srFromBeginning]) then
  begin
    try
      selM060.Close;
      selM060.SetVariable('DATADA',R180InizioMese(DataIndietro));
      selM060.SetVAriable('DATAA',R180FineMese(Data));
      selM060.SetVariable('PROGRESSIVO',Prog);
      selM060.SetVariable('C8_MISSIONE', Parametri.CampiRiferimento.C8_Missione);
      selM060.Open;
    except
      Result:=Result + 'selM060';
    end;
  end;
end;

procedure TA037FScaricoPagheMW.AddAnomalia(Matricola,Badge,Cogn,Nome,Mess:String; Prog: Integer);
begin
  Nome:=Cogn + ' ' + Nome;
  //ListaAnomalie.Add(Format('%-8s %-8s %-40s %s',[Matricola,Badge,Nome,Mess]));
  RegistraMsg.InserisciMessaggio('A',Format('%-8s %-8s %-40s %s',[Matricola,Badge,Nome,Mess]),'',Prog);
end;

procedure TA037FScaricoPagheMW.ApriQueryIntPaghe(Codice:String);
begin
  selT190.Filtered:=False;
  selT190.Filter:='CODICE = ''' + Codice + '''';
  selT190.Filtered:=True;
  selT193.Close;
  selT193.SetVariable('COD_INTERFACCIA',Codice);
  selT193.SetVariable('DECORRENZA',R180FineMese(EncodeDate(ACorr,MCorr,1)));
  selT193.Open;
  selT193Extra.Close;
  selT193Extra.SetVariable('COD_INTERFACCIA',Codice);
  selT193Extra.SetVariable('DECORRENZA',R180FineMese(EncodeDate(ACorr,MCorr,1)));
end;


function TA037FScaricoPagheMW.VoceScaricabile(DataCassa:TDateTime;CodVoce:String; CodVoceCedolino:String = ''): Boolean;
//Verifica se la voce è scaricabile rispetto a periodo di validità e stato per scarico
begin
  Result:=True;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    with T193F_VOCE_SCARICABILE do
    begin
      SetVariable('P_PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('P_DATA_COMP',EncodeDate(ACorr,MCorr,1));
      SetVariable('P_DATA_CASSA',DataCassa);
      SetVariable('P_INTERFACCIA',CodiceInterfaccia);
      SetVariable('P_VOCE',CodVoce);
      SetVariable('P_VOCE_CEDOLINO',CodVoceCedolino);
      Execute;
      Result:=VarToStr(GetVariable('RESULT')) <> 'N';
    end;
  end;
end;

function TA037FScaricoPagheMW.GetValPers(DataCassa:TDateTime; CodVoceOrig,CodVoce:String; Valore:Currency): Currency;
//Legge valore personalizzato che ridefinisce eventualmente il dato calcolato dai cntegi standard
begin
  Result:=Valore;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    with T195F_VOCE_GETVALORE do
    begin
      SetVariable('P_PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('P_DATA_COMP',EncodeDate(ACorr,MCorr,1));
      SetVariable('P_INTERFACCIA',CodiceInterfaccia);
      SetVariable('P_VOCE_ORIG',CodVoceOrig);
      SetVariable('P_VOCE',CodVoce);
      SetVariable('P_VALORE',Valore);
      Execute;
      if GetVariable('RESULT') <> null then
        Result:=GetVariable('RESULT');
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GetValore(P,I:LongInt;AggiornaT195:Boolean;Conguagli:Boolean;DataCassa: TDateTime);
var ValorePrec,ValoreSalvato,ImportoPrec,ImportoSalvato:Currency;
begin
  //Non considero i periodi di assenza
  if AggiornaT195 and ((VettCI[I].CodiceInterno = '180') or (VettCI[I].CodiceInterno = 'CANCELLA')) then
  begin
    //Cancellazione vecchio movimento
    Del195PA.SetVariable('Progressivo',P);
    Del195PA.SetVariable('DataRif',EncodeDate(VettCI[I].Anno,VettCI[I].Mese,1));
    Del195PA.SetVariable('VocePaghe',VettCI[I].CodicePaghe);
    Del195PA.SetVariable('Dal',VettCI[I].Dal);
    if VettCI[I].CodiceInterno = '180' then
      Del195PA.SetVariable('Operazione','I')
    else
      Del195PA.SetVariable('Operazione','C');
    Del195PA.Execute;
    //Inserimento nuovo movimento
    Ins195.SetVariable('Progressivo',P);
    Ins195.SetVariable('DataRif',EncodeDate(VettCI[I].Anno,VettCI[I].Mese,1));
    Ins195.SetVariable('VocePaghe',VettCI[I].CodicePaghe);
    Ins195.SetVariable('Valore',VettCI[I].Valore);
    Ins195.SetVariable('Importo',0);
    Ins195.SetVariable('UM',VettCI[I].MisuraInterna);
    Ins195.SetVariable('Dal',VettCI[i].Dal);
    Ins195.SetVariable('Al',VettCI[i].Al);
    Ins195.SetVariable('Data_Cassa',DataCassa);
    if VettCI[I].CodiceInterno = '180' then
    begin
      Ins195.SetVariable('Operazione','I');
      Ins195.SetVariable('Cod_Interno',VettCI[I].CodiceInterno);
    end
    else
    begin
      Ins195.SetVariable('Operazione','C');
      Ins195.SetVariable('Cod_Interno','180')
    end;
    Ins195.Execute;
    //SessioneOracle.Commit;
    exit;
  end;
  ValorePrec:=0;
  ImportoPrec:=0;
  if VettCI[I].CodicePaghe = '' then
    VettCI[I].CodicePaghe:=' ';
  if selT195.SearchRecord('DataRif;Dal;VocePaghe',VarArrayOf([VettCI[I].Riferimento,VettCI[I].Dal,VettCI[I].CodicePaghe]),[srFromBeginning]) then
    repeat
      ValorePrec:=ValorePrec + selT195.FieldByName('Valore').AsFloat;
      ImportoPrec:=ImportoPrec + selT195.FieldByName('Importo').AsFloat;
    until not selT195.SearchRecord('DataRif;Dal;VocePaghe',VarArrayOf([VettCI[I].Riferimento,VettCI[I].Dal,VettCI[I].CodicePaghe]),[]);
  //Per gestire il pregresso dove Importo non è ancora stato valorizzato
  if (VettCI[I].Valore <> 0) and (VettCI[I].Importo <> 0) and (ValorePrec <> 0) and (ImportoPrec = 0) then
    ImportoPrec:=ValorePrec * (VettCI[I].Importo / VettCI[I].Valore);
  ValoreSalvato:=VettCI[I].Valore - ValorePrec;
  ImportoSalvato:=VettCI[I].Importo - ImportoPrec;
  if Conguagli then
  begin
    VettCI[I].Valore:=ValoreSalvato;
    VettCI[I].Importo:=ImportoSalvato;
  end;
  if AggiornaT195 and ((ValoreSalvato <> 0) or (ImportoSalvato <> 0)) then
  begin
    //Inserimento nuovo movimento
    Ins195.ClearVariables;
    Ins195.SetVariable('Progressivo',P);
    Ins195.SetVariable('DataRif',VettCI[I].Riferimento);
    Ins195.SetVariable('VocePaghe',VettCI[I].CodicePaghe);
    Ins195.SetVariable('Valore',ValoreSalvato);
    Ins195.SetVariable('Importo',ImportoSalvato);
    Ins195.SetVariable('UM',VettCI[I].MisuraInterna);
    Ins195.SetVariable('Dal',VettCI[I].Dal);
//    Ins195.SetVariable('Dal',VettCI[I].Riferimento);
    Ins195.SetVariable('Operazione','I');
    Ins195.SetVariable('Cod_Interno',VettCI[I].CodiceInterno);
    Ins195.SetVariable('Data_Cassa',DataCassa);
    try
      Ins195.Execute;
    except
      on E:Exception do
        if Pos('ORA-00001',E.Message) > 0 then
          AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                      SelAnagrafe.FieldByName('T430BADGE').AsString,
                      SelAnagrafe.FieldByName('COGNOME').AsString,
                      SelAnagrafe.FieldByName('NOME').AsString,
                      'Voce paghe: ' + VettCI[I].CodicePaghe +
                      ' del ' + DateToStr(VettCI[I].Riferimento) +
                      ' - Verificare i filtri sui codici interni e sulle voci paghe - ' +
                      E.Message,
                      SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
         else
           raise;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GetValoriEsistenti(P:LongInt; Interfacce:String;Data,DataIndietro,DataCassa:TDateTime);
{Lettura dei valori esistenti scaricati con data cassa precedente all'attuale}
begin
  with selT195 do
  begin
    Close;
    SetVariable('Progressivo',P);
    SetVariable('Interfacce',Interfacce);
    SetVariable('Data1',DataIndietro);
    SetVariable('Data2',Data);
    SetVariable('Data_Cassa',DataCassa);
    Open;
  end;
end;

(* Caratto Obsoleto
procedure TA037FScaricoPagheMW.EliminaSingolaVoce(P,I:Integer;DataCassa:TDateTime);
{Usato solo per la stampa Rep/Straord di Arpa Piemonte}
begin
  Del195.SetVariable('Progressivo',P);
  Del195.SetVariable('DataRif',VettCI[I].Riferimento);
  Del195.SetVariable('Data_Cassa',DataCassa);
  Del195.SetVariable('VocePaghe',VettCI[I].CodicePaghe);
  Del195.Execute;
end;
*)
function TA037FScaricoPagheMW.ApplicaFormulaValore(Valore:Currency; Formula: String;DataCassa: TDateTime): Currency;
{ Applica la formula indicata al valore dato.
  La formula deve essere una espressione sql che può contenere la variabile :VALORE }
begin
  Result:=Valore;
  // se la formula è nulla, restituisce il valore senza modificarlo
  if Formula = '' then
    Exit;

  selValore.DeleteVariables;
  if Pos(':VALORE',UpperCase(Formula)) > 0 then
  begin
    selValore.DeclareVariable('VALORE',otFloat);
    selValore.SetVariable('VALORE',Valore)
  end;
  if Pos(':CODICE',UpperCase(Formula)) > 0 then
  begin
    selValore.DeclareVariable('CODICE',otString);
    selValore.SetVariable('CODICE',VettCI[NumRecord].CodicePaghe);
  end;
  if Pos(':PROGRESSIVO',UpperCase(Formula)) > 0 then
  begin
    selValore.DeclareVariable('PROGRESSIVO',otInteger);
    selValore.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  if Pos(':DATA_COMPETENZA',UpperCase(Formula)) > 0 then
  begin
    selValore.DeclareVariable('DATA_COMPETENZA',otDate);
    selValore.SetVariable('DATA_COMPETENZA',VettCI[NumRecord].Riferimento);
  end;
  if Pos(':DATA_CASSA',UpperCase(Formula)) > 0 then
  begin
    selValore.DeclareVariable('DATA_CASSA',otDate);
    selValore.SetVariable('DATA_CASSA',DataCassa);
  end;

  selValore.SQL.Text:='select ' + Formula + ' from dual';
  try
    selValore.Execute;
    // verifica che la formula estragga un solo valore
    if (selValore.FieldCount > 1) then
    begin
      // formula non corretta (più valori estratti)
      AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                  SelAnagrafe.FieldByName('T430BADGE').AsString,
                  SelAnagrafe.FieldByName('COGNOME').AsString,
                  SelAnagrafe.FieldByName('NOME').AsString,
                  'Voce paghe "' + VettCI[NumRecord].CodicePaghe + '": la formula di calcolo estrae n. '
                  + IntToStr(selValore.FieldCount) + ' valori invece di 1! Formula: ['+
                  Formula + '] - Valore: [' + FloatToStr(Valore) + ']',
                  SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      Abort;
    end;
    Result:=StrToFloatDef(VarToStr(selValore.Field(0)),0);
  except
    on E:Exception do
    begin
      // formula non corretta
      AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                  SelAnagrafe.FieldByName('T430BADGE').AsString,
                  SelAnagrafe.FieldByName('COGNOME').AsString,
                  SelAnagrafe.FieldByName('NOME').AsString,
                  'Voce paghe "' + VettCI[NumRecord].CodicePaghe + '": formula di calcolo valore non corretta! Formula: ['+
                  Formula + '] - Valore: [' + FloatToStr(Valore) + ']. Errore: ' + E.Message,
                  SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      Abort;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.InizializzaConteggi;
begin
  NumRecord:=0;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R450DtM1:=TR450DtM1.Create(nil);
end;

procedure TA037FScaricoPagheMW.InizializzaVettore(Data, DataFile: TDateTime; CurrMM,CurrAA:Word);
var I:Integer;
begin
  for I:=1 to High(VettCI) do
  begin
    VettCI[I].Mese:=0;
    VettCI[I].Anno:=0;
    VettCI[I].CodicePaghe:='';
    VettCI[I].CodiceInterno:='';
    VettCI[I].Interfaccia:='';
    VettCI[I].Valore:=0;
    VettCI[I].Importo:=0;
    VettCI[I].Misura:='';
    VettCI[I].Dal:=Data;
    VettCI[I].Al:=EncodeDate(CurrAA,CurrMM,R180GiorniMese(Data));
    VettCI[I].Dalle:=0;
    VettCI[I].Alle:=0;
    VettCI[I].Riferimento:=Data;
    VettCI[I].DataOper:=DataFile;
  end;
end;

function TA037FScaricoPagheMW.EsisteElemento(ACorr,MCorr,AnnoDal,MeseDal:Integer; CodPaghe,Misura:String; Range:Integer):Integer;
var I:Integer;
begin
  Result:=-1; // elemento inesistente
  for I:=1 to Range do
    //Alberto: 23/01/2007 cambiato il test, considerando anche ACorr e MCorr
    if (VettCI[I].Anno = ACorr) and (VettCI[I].Mese = MCorr) and
       (VettCI[I].Dal = EncodeDate(AnnoDal,MeseDal,1)) and
       (VettCI[I].CodicePaghe = CodPaghe) and (VettCI[I].MisuraInterna = Misura) then
    begin
      Result:=I;
      Break;
    end;
end;

procedure TA037FScaricoPagheMW.SalvaValoreGenerico(CI,CodPaghe:String; Valore:Currency; Misura:String; AnnoDal,MeseDal:Word;DataCassa:TDateTime);
var
  App:Integer;
  Arr:Real;
  ValPers:Currency;
  CodPagheOrig:String;
begin
  CodPagheOrig:=CodPaghe;
  if AnnoDal = 0 then
  begin
    AnnoDal:=ACorr;
    MeseDal:=MCorr;
  end;
  //Verifica se la voce è abilitata nel periodo
  with selT193 do
  begin
    if SearchRecord('VOCE_PAGHE',CodPaghe,[srFromBeginning]) then
    begin
      if (EncodeDate(AnnoDal,MeseDal,1) < FieldByName('DAL').AsDateTime) or
         (EncodeDate(AnnoDal,MeseDal,1) > FieldByName('AL').AsDateTime) or
          not VoceScaricabile(DataCassa,CodPaghe) then
        Exit
      else
        CodPaghe:=FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
    end
    else
      Exit;
  end;
  //Norman 25/10/2006
  if VoceDisabilitata(CodPaghe) then
    CodPaghe:='';
  if Trim(CodPaghe) = '' then
    exit;
  App:=EsisteElemento(ACorr, MCorr, AnnoDal,MeseDal,CodPaghe,Misura,NumRecord);
  if App = -1 then   // non esiste nel vettore e quindi lo inserisco.
  begin
    inc(NumRecord);
    VettCI[NumRecord].Anno:=ACorr;
    VettCI[NumRecord].Mese:=MCorr;
    //Se SalvaValore è già stato richiamato da BancaOreLiqud trovo già nel vettore il
    //codice paghe associato a 12-2004 con data riferimento 12-2004 altrimenti viene
    //inizializzata la data di riferimento a 04-2005
    //VettCI[NumRecord].Riferimento:=EncodeDate(AnnoDal,MeseDal,1);
    VettCI[NumRecord].Riferimento:=EncodeDate(ACorr,MCorr,1);
    VettCI[NumRecord].Dal:=EncodeDate(AnnoDal,MeseDal,1);
    VettCI[NumRecord].Al:=EncodeDate(AnnoDal,MeseDal,R180GiorniMese(VettCI[NumRecord].Dal));
    VettCI[NumRecord].CodiceInterno:=CI;
    VettCI[NumRecord].CodicePaghe:=CodPaghe;
    VettCI[NumRecord].LstCodiciPaghe:='';
    VettCI[NumRecord].Valore:=0;
    VettCI[NumRecord].Importo:=0;
    VettCI[NumRecord].MisuraInterna:=Misura;
    VettCI[NumRecord].Misura:=Misura;
    VettCI[NumRecord].Interfaccia:=VarToStr(selT193.GetVariable('COD_INTERFACCIA'));
    App:=NumRecord;
  end;
  // verifico se esiste funzione personalizzata che può cambiare il valore
  ValPers:=GetValPers(DataCassa,CodPagheOrig,CodPaghe,Valore);
  if ValPers <> Valore then
    Valore:=ValPers;
  // se è presente una formula nella parametrizzazione, calcola il valore in base a questa
  if not selT193.FieldByName('FORMULA').IsNull then
    Valore:=ApplicaFormulaValore(Valore,selT193.FieldByName('FORMULA').AsString,DataCassa);
  // se presente, applica l'arrotondamento
  Arr:=selT193.FieldByName('ARROTONDAMENTO').AsFloat;
  if Arr <> 0 then
  begin
    if Arr > 0 then
      Valore:=R180Arrotonda(Valore,Arr,'D')
    else
      Valore:=R180Arrotonda(Valore,Abs(Arr),'E');
  end;
  VettCI[App].Valore:=VettCI[App].Valore + Valore;
  if (VettCI[App].CodiceInterno = '242') and (VettCI[App].MisuraInterna = 'H') then
    VettCI[App].Importo:=VettCI[App].Importo + selT762.Lookup('DATA;TIPOIMPORTO',VarArrayOf([EncodeDate(VettCI[App].Anno,VettCI[App].Mese,01),'5']),'IMPORTO'); //Importo = Importo orario
  if selT193.FieldByName('SPOSTA_VALIMP').AsString = 'S' then
  begin
    if (VettCI[App].MisuraInterna = 'H') or (VettCI[App].MisuraInterna = 'N') then
      VettCI[App].MisuraInterna:='V'
    else
      if VettCI[App].MisuraInterna = 'V' then
        VettCI[App].MisuraInterna:='N'
  end;
  VettCI[App].LstCodiciPaghe:=VettCI[App].LstCodiciPaghe + ',' + CodPagheOrig;
end;

procedure TA037FScaricoPagheMW.SalvaFiltroScaricoPaghe(Nome:String;lstCodiciInterni,lstFiltroVoci: TStringList);
var
  i: Integer;
begin
  for i:=0 to lstCodiciInterni.Count - 1 do
  begin
    selT196.Insert;
    selT196.FieldByName('CODICE').AsString:=Nome;
    selT196.FieldByName('TIPO').AsString:='I';
    selT196.FieldByName('CODVOCE').AsString:=lstCodiciInterni[i];
    try
      selT196.Post
    except
      selT196.Cancel;
    end;
  end;

  for i:=0 to lstFiltroVoci.Count - 1 do
  begin
    try
      selT196.Insert;
      selT196.FieldByName('CODICE').AsString:=Nome;
      selT196.FieldByName('TIPO').AsString:='V';
      selT196.FieldByName('CODVOCE').AsString:=lstFiltroVoci[i];
      selT196.Post;
    except
      selT196.Cancel;
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TA037FScaricoPagheMW.SalvaOreLavorateFasce(CI:String;CodPaghe:String;OreLavo:Integer;Misura:String;First:Boolean;DataCassa:TDateTime);
var App:Integer;
    Arr:Real;
    ValPers:Currency;
    CodPagheOrig,Prec:String;
begin
  CodPagheOrig:=CodPaghe;
  //Verifica se la voce è abilitata nel periodo
  with selT193 do
    if SearchRecord('VOCE_PAGHE',CodPaghe,[srFromBeginning]) then
    begin
      if (EncodeDate(ACorr,MCorr,1) < FieldByName('DAL').AsDateTime) or
         (EncodeDate(ACorr,MCorr,1) > FieldByName('AL').AsDateTime) or
          not VoceScaricabile(DataCassa,CodPaghe) then
        exit
      else
        CodPaghe:=FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
    end
    else
      exit;
  //Norman 25/10/2006
  if VoceDisabilitata(CodPaghe) then
    exit;
  App:=EsisteElemento(ACorr,MCorr,ACorr,MCorr,CodPaghe,Misura,NumRecord);
  if  App = -1 then   // non esiste nel vettore e quindi lo inserisco.
  begin
    inc(NumRecord);
    if First then
    begin
      VettCI[NumRecord].CodiceInterno:=CI;
      Prec:=CI;
    end
    else
    begin
      Prec:=StrInc(Prec);
      VettCI[NumRecord].CodiceInterno:=Prec;
    end;
    VettCI[NumRecord].Anno:=ACorr;
    VettCI[NumRecord].Mese:=MCorr;
    VettCI[NumRecord].CodicePaghe:=CodPaghe;
    VettCI[NumRecord].Valore:=0;
    VettCI[NumRecord].Importo:=0;
    VettCI[NumRecord].MisuraInterna:=Misura;
    //Nando 21/10/2005
    VettCI[NumRecord].Misura:=Misura;
    //Alberto 15/12/2005
    VettCI[NumRecord].Interfaccia:=VarToStr(selT193.GetVariable('COD_INTERFACCIA'));
    VettCI[NumRecord].Riferimento:=EncodeDate(ACorr,MCorr,1);
    VettCI[NumRecord].Dal:=VettCI[NumRecord].Riferimento;
    VettCI[NumRecord].Al:=R180FineMese(VettCI[NumRecord].Dal);
    App:=NumRecord;
  end;
  // verifico se esiste funzione personalizzata che può cambiare il valore
  ValPers:=GetValPers(DataCassa,CodPagheOrig,CodPaghe,OreLavo);
  if ValPers <> OreLavo then
    OreLavo:=Trunc(ValPers);
  Arr:=selT193.FieldByName('ARROTONDAMENTO').AsFloat;
  if Arr <> 0 then
    if Arr > 0 then
      OreLavo:=Trunc(R180Arrotonda(OreLavo,Arr,'D'))
    else
      OreLavo:=Trunc(R180Arrotonda(OreLavo,Abs(Arr),'E'));
  VettCI[App].Valore:=VettCI[App].Valore+OreLavo;
end;

function TA037FScaricoPagheMW.StrInc(Value:String):String;
var X,Code:Integer;
    S:String;
begin
  S:=Value;
  val(Value,X,Code);
  if Code = 0 then
  begin                // incremento il valore della stringa
    X:=X + 1;            //salvando gli zeri non significativi....
    S:=format('%3.3d',[X]);
  end;
  Result:=S;
end;

procedure TA037FScaricoPagheMW.GestisciPeriodiAssenze(CurrMM,CurrAA:Word;DataCassa: TDateTime);
begin
  if (CurrAA <> ACorr) or (CurrMM <> MCorr) then
    exit;
  with selT042 do
    begin
    while not Eof do
      begin
      //Verifica se la voce è abilitata nel periodo
      if not selT193.SearchRecord('VOCE_PAGHE',FieldByName('VOCEPAGHE').AsString,[srFromBeginning]) then
      begin
        Next;
        Continue;
      end;
      if (FieldByName('DAL').AsDateTime < selT193.FieldByName('DAL').AsDateTime) or
         (FieldByName('AL').AsDateTime > selT193.FieldByName('AL').AsDateTime) or
          not VoceScaricabile(DataCassa,'',FieldByName('VOCEPAGHE').AsString) then
      begin
        Next;
        Continue;
      end;
      //Salvataggio su VettCI
      inc(NumRecord);
      VettCI[NumRecord].Anno:=CurrAA;
      VettCI[NumRecord].Mese:=CurrMM;
      if FieldByName('OPERAZIONE').AsString = 'C' then
        //Personalizzazione per ADS: i movimenti di cancellazione sono identificati da CANCELLA
        VettCI[NumRecord].CodiceInterno:='CANCELLA'
      else
        VettCI[NumRecord].CodiceInterno:=VettConst[CurrCodInt].CodInt;
      VettCI[NumRecord].CodicePaghe:=selT193.FieldByName('VOCE_PAGHE_CEDOLINO').AsString;//FieldByName('VOCEPAGHE').AsString;
      VettCI[NumRecord].MisuraInterna:=VettConst[CurrCodInt].Misura;
      VettCI[NumRecord].Misura:=VettConst[CurrCodInt].Misura;
      VettCI[NumRecord].Dal:=FieldByName('DAL').AsDateTime;
      VettCI[NumRecord].Al:=FieldByName('AL').AsDateTime;
      VettCI[NumRecord].Dalle:=FieldByName('DAORE').AsDateTime;
      VettCI[NumRecord].Alle:=FieldByName('AORE').AsDateTime;
      VettCI[NumRecord].Valore:=FieldByName('AL').AsDateTime - FieldByName('DAL').AsDateTime + 1;
      //Alberto 15/12/2005
      VettCI[NumRecord].Interfaccia:=VarToStr(selT193.GetVariable('COD_INTERFACCIA'));
      if not FieldByName('DAORE').IsNull then
        begin
        if not FieldByName('AORE').IsNull then
          VettCI[NumRecord].Valore:=R180OreMinuti(VettCI[NumRecord].Alle) - R180OreMinuti(VettCI[NumRecord].Dalle)
        else
          VettCI[NumRecord].Valore:=R180OreMinuti(VettCI[NumRecord].Dalle);
        end;
      VettCI[NumRecord].Riferimento:=VettCI[NumRecord].Dal;
      Next;
      end;
    Close;
    end;
end;

procedure TA037FScaricoPagheMW.AggiungiVociPrecedenti(DataCassa: TDateTime);
{Con la gestione conguagli e la considerazione delle voci non più scaricate,
si ricercano tutte le voci già scaricate per passarne la differenza in negativo}
var i:Integer;
    Esiste:Boolean;
    A,M,G:Word;
    Interfaccia:String;
begin
  with selT195 do
  begin
    First;
    while not Eof do
    begin
      Esiste:=False;
      if not FieldByName('UM').IsNull then
      begin
        for i:=1 to NumRecord do
          if (VettCI[i].CodicePaghe = FieldByName('VocePaghe').AsString) and
             (R180InizioMese(VettCI[i].Riferimento) = R180Iniziomese(FieldByName('DataRif').AsDateTime)) and
             (R180InizioMese(VettCI[i].Dal) = R180Iniziomese(FieldByName('Dal').AsDateTime)) then
          begin
            Esiste:=True;
            Break;
          end;
        //Norman 25/10/2006: VoceDisabilitata verifica se la voce è stata flaggata nel filtro voci
        if (not Esiste) and VoceAbilitata(FieldByName('Cod_Interno').AsString) and not VoceDisabilitata(FieldByName('VocePaghe').AsString) then
        begin
          //Alberto 15/12/2005: Verifica se la voce è abilitata nel periodo
          Interfaccia:=LeggiCodiceInterfaccia(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(FieldByName('DataRif').AsDateTime));
          //if VarToStr(GetVariable('COD_INTERFACCIA')) <> VettCI[NumRecord].Interfaccia then
          if (VarToStr(selT193.GetVariable('COD_INTERFACCIA')) <> Interfaccia) or
             (selT193.GetVariable('DECORRENZA') <> R180FineMese(FieldByName('DataRif').AsDateTime)) then
          begin
            selT193.Close;
            selT193.SetVariable('COD_INTERFACCIA',Interfaccia);
            selT193.SetVariable('DECORRENZA',R180FineMese(FieldByName('DataRif').AsDateTime));
            selT193.Open;
          end;
          //if A037FScaricoPagheDtM1.selT193.SearchRecord('VOCE_PAGHE',FieldByName('VocePaghe').AsString,[srFromBeginning]) then
          if selT193.SearchRecord('VOCE_PAGHE_CEDOLINO',FieldByName('VocePaghe').AsString,[srFromBeginning]) then
            Esiste:=(FieldByName('Dal').AsDateTime < selT193.FieldByName('DAL').AsDateTime) or
                    (FieldByName('Dal').AsDateTime > selT193.FieldByName('AL').AsDateTime) or
                     not VoceScaricabile(DataCassa,'',FieldByName('VocePaghe').AsString);
          if not Esiste then
          begin
            DecodeDate(FieldByName('DataRif').AsDateTime,A,M,G);
            inc(NumRecord);
            VettCI[NumRecord].Anno:=A;
            VettCI[NumRecord].Mese:=M;
            VettCI[NumRecord].Riferimento:=FieldByName('DataRif').AsDateTime;
            VettCI[NumRecord].Dal:=R180InizioMese(FieldByName('Dal').AsDateTime);
            VettCI[NumRecord].Al:=R180FineMese(FieldByName('DataRif').AsDateTime);
            VettCI[NumRecord].CodiceInterno:=FieldByName('Cod_Interno').AsString;
            VettCI[NumRecord].CodicePaghe:=FieldByName('VocePaghe').AsString;
            VettCI[NumRecord].Valore:=0;
            VettCI[NumRecord].Importo:=0;
            VettCI[NumRecord].MisuraInterna:=FieldByName('UM').AsString;
            //Nando 27/02/2006
            VettCI[NumRecord].Misura:=FieldByName('UM').AsString;
            VettCI[NumRecord].Interfaccia:=Interfaccia;
          end;
        end;
      end;
      Next;
    end;
  end;
end;

function TA037FScaricoPagheMW.LeggiCodiceInterfaccia(Progressivo:Integer;Data:TDateTime):String;
var QSInterfaccia:TQueryStorico;
begin
  if Parametri.CampiRiferimento.C9_ScaricoPaghe = '' then
    Result:='<INTERFACCIA UNICA>'
  else
  begin
    QSInterfaccia:=TQueryStorico.Create(nil);
    QSInterfaccia.Session:=SessioneOracle;
    QSInterfaccia.GetDatiStorici('T430' + Parametri.CampiRiferimento.C9_ScaricoPaghe,Progressivo,Data,Data);
    if QSInterfaccia.LocDatoStorico(Data) then
      Result:=QSInterfaccia.FieldByName('T430' + Parametri.CampiRiferimento.C9_ScaricoPaghe).AsString
    else
      Result:='';
    QSInterfaccia.Free;
  end;
end;

function TA037FScaricoPagheMW.TrasformaCodPaghe(Cod,F,Interfaccia:String; AnnoRif,MeseRif: Integer):String;
{Trasformazione del codice paghe a seconda che il valore sia una Ritenuta o un Pagamento
 - vecchio CSI, RealTime(Brescia)}
var S1,S2:String;
    p,p1,p2,LungCod:Integer;
begin
  Result:=Cod;
  F:=Copy(F,2,Length(F));
  {il default deve contenere -DECODE, il nuovo codice viene letto da T193}
  if F = 'DECODE' then
  begin
    //Alberto 15/12/2005
    with selT193 do
    begin
      if VarToStr(GetVariable('COD_INTERFACCIA')) <> Interfaccia then
      begin
        Close;
        SetVariable('COD_INTERFACCIA',Interfaccia);
        Open;
      end;

      // verifica abilitazione voce nel mese-anno di riferimento.ini - daniloc 02.07.2010
      //Result:=VarToStr(A037FScaricoPagheDtM1.selT193.Lookup('VOCE_PAGHE_CEDOLINO',Cod,'VOCE_PAGHE_NEGATIVA'));

      // estrae il primo record per cui l'abilitazione nel periodo è verificata
      // (coerentemente dovrebbe essere anche l'unico record)
      if SearchRecord('VOCE_PAGHE_CEDOLINO',Cod,[srFromBeginning]) then
      repeat
        if (EncodeDate(AnnoRif,MeseRif,1) >= FieldByName('DAL').AsDateTime) and
           (EncodeDate(AnnoRif,MeseRif,1) <= FieldByName('AL').AsDateTime) then
        begin
          Result:=FieldByName('VOCE_PAGHE_NEGATIVA').AsString;
          Break;
        end;
      until not SearchRecord('VOCE_PAGHE_CEDOLINO',Cod,[]);
      // verifica abilitazione voce nel mese-anno di riferimento.fine

      Exit;
    end;
  end;
  {il default deve contenere una delle  seguenti stringhe:
  -<X/Y>vvv Sostituisce la prima parte con X o Y
  -vvv<X/Y> Sostituisce l'ultima parte con X o Y
  -<X>vvv Aggiunge X se non esiste o toglie X se esiste (in testa al codice)
  -vvv<X> Aggiunge X se non esiste o toglie X se esiste (alla fine del codice)}
  p1:=Pos('<',F);
  p2:=Pos('>',F);
  if (p1 = 0) or (p2 = 0) or (p1 > p2) then exit;
  p:=Pos('/',F);
  if p = 0 then
    p:=p2;
  S1:=Copy(F,p1 + 1,p - p1 - 1);  //Prima stringa
  S2:=Copy(F,p + 1,p2 - p - 1);  //Seconda stringa
  if p1 = 1 then
  begin
    //Sostituzione della testa del codice
    LungCod:=Length(F) - p2;
    Result:=Copy(Cod,Length(Cod) - LungCod + 1,LungCod);  //Parte fissa del codice
    if Copy(Cod,1,Length(Cod) - LungCod) = S1 then
      Result:=S2 + Result
    else if Copy(Cod,1,Length(Cod) - LungCod) = S2 then
      Result:=S1 + Result
    else
      Result:=Cod;
  end
  else if p2 = Length(F) then
  begin
    //Sostituzione della fine del codice
    LungCod:=p1 - 1;
    Result:=Copy(Cod,1,LungCod);  //Parte fissa del codice
    if Copy(Cod,LungCod + 1,Length(Cod)) = S1 then
      Result:=Result + S2
    else if Copy(Cod,LungCod + 1,Length(Cod)) = S2 then
      Result:=Result + S1
    else
      Result:=Cod;
  end;
end;

function TA037FScaricoPagheMW.VerificaTrasferte(nProgressivo:integer;dDataInizio:TDateTime;dDataFine:TDateTime):boolean;
begin
  Result:=False;
  if Parametri.CampiRiferimento.C8_Missione = '' then
    exit;
  //Verifico se sono presenti missioni, con mese scarico compreso tra le date dDataInizio e dDataFine, riferite al dipendente nProgressivo
  selM040.Close;
  selM040.SetVariable('C8_MISSIONE',Parametri.CampiRiferimento.C8_Missione);
  selM040.SetVariable('Progressivo',nProgressivo);
  selM040.SetVariable('Data1',dDataInizio);
  selM040.SetVariable('Data2',dDataFine);
  selM040.Open;
  if selM040.RecordCount > 0 then
    Result:=True;
end;

procedure TA037FScaricoPagheMW.GestisciAssenze(DataCassa: TDateTime);
var i:Byte;
    PercRetrib,ValoreGG,ValoreHH:Currency;
    CodPaghe,UMScarico,UMisura:String;
    xx,yy:Integer;
    BM:TBookmark;
    D:TDateTime;
    iEvRid:Integer;
    bRegEvRid:boolean;
begin
  bRegEvRid:=True;
  for xx:=Low(AssenzeMese) to High(AssenzeMese) do
  begin
    AssenzeMese[xx].Causale:='';
    AssenzeMese[xx].FiniRetr:=0;
    AssenzeMese[xx].GG:=0;
    AssenzeMese[xx].MG:=0;
    AssenzeMese[xx].Min:=0;
  end;
  for xx:=Low(MalattiaCSI) to High(MalattiaCSI) do
  begin
    MalattiaCSI[xx].VocePaghe:='';
    MalattiaCSI[xx].GG:=0;
  end;
  FlagAsse1:=0;
  FlagAsse2:=0;
  n_rpassemes:=0;

  //Fare scorrimento su tutto il mese senza ottimizzazione!
  D:=EncodeDate(ACorr,MCorr,1);
  while R180InizioMese(D) = EncodeDate(ACorr,MCorr,1) do
  begin
    ConteggiAssenze(D);
    if FlagAsse1 = 2 then
      Break;
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    begin
      //selUSR_GetRidEveMal.Close;
      selUSR_GetRidEveMal.Open;
      if selUSR_GetRidEveMal.FieldByName('ESISTEPROC').AsInteger > 0 then
      begin
        selUSR_GetRidEveMal1.Close;
        selUSR_GetRidEveMal1.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selUSR_GetRidEveMal1.SetVariable('Data',D);
        selUSR_GetRidEveMal1.Open;
        iEvRid:=0;
        if not selUSR_GetRidEveMal1.FieldByName('NUMEVENTO_RID').IsNull then
          iEvRid:=selUSR_GetRidEveMal1.FieldByName('NUMEVENTO_RID').AsInteger;
        if iEvRid > 0 then
        begin
          if MalattiaCSI[1].VocePaghe = '' then
          begin
            MalattiaCSI[1].VocePaghe:=selUSR_GetRidEveMal1.FieldByName('VOCEPAGHE2').AsString;
            MalattiaCSI[2].VocePaghe:=selUSR_GetRidEveMal1.FieldByName('VOCEPAGHE3').AsString;
            MalattiaCSI[3].VocePaghe:=selUSR_GetRidEveMal1.FieldByName('VOCEPAGHE4').AsString;
            MalattiaCSI[4].VocePaghe:=selUSR_GetRidEveMal1.FieldByName('VOCEPAGHE5').AsString;
            MalattiaCSI[5].VocePaghe:=selUSR_GetRidEveMal1.FieldByName('VOCEPAGHE6').AsString;
          end;
          MalattiaCSI[iEvRid].GG:=MalattiaCSI[iEvRid].GG + 1;
        end;
      end;
    end;
    D:=D + 1;
  end;

  for i:=1 to n_rpassemes do
  begin
    CodPaghe:=VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'VOCEPAGHE'));
    try
      PercRetrib:=StrToFloat(VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'RETRIBUZIONE1')))/100;
    except
      PercRetrib:=1;
    end;
    if CodPaghe <> '' then
    begin
      ValoreGG:=0;
      ValoreHH:=0;
      UMScarico:=VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'UM_SCARICOPAGHE'));
      if UMScarico = 'F' then
      begin
        //Gestione standard
        if AssenzeMese[i].GG > 0 (*or (AssenzeMese[i].MG > 0)*) then
          //Unità di misura = Giorni
          ValoreGG:=AssenzeMese[i].GG;
        if AssenzeMese[i].Min > 0 then
          //Unità di misura = Ore
          ValoreHH:=AssenzeMese[i].Min;
      end
      else
      begin
        if UMScarico = 'O' then
          UMisura:='O'
        else if UMScarico = 'G' then
          UMisura:='G'
        else if UMScarico ='C' then
          UMisura:=VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'UMISURA'));
        if UMisura = 'G' then
          ValoreGG:=AssenzeMese[i].GG
        else
          ValoreHH:=AssenzeMese[i].Min;
      end;
      if VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'SCARICOPAGHE_UM_PROP')) = 'S' then
      begin
        ValoreGG:=ValoreGG * PercRetrib;
        ValoreHH:=ValoreHH * PercRetrib;
      end;
      if ValoreGG > 0 then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,ValoreGG,'N',0,0,DataCassa);
      if ValoreHH > 0 then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,ValoreHH,'H',0,0,DataCassa);
      if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and bRegEvRid then
      begin
        if (MalattiaCSI[1].VocePaghe <> '') and (MalattiaCSI[1].VocePaghe = VarToStr(selT265.Lookup('CODICE',AssenzeMese[i].Causale,'VOCEPAGHE2'))) then
        begin
          bRegEvRid:=False;
          for xx:=Low(MalattiaCSI) to High(MalattiaCSI) do
          begin
            SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,MalattiaCSI[xx].VocePaghe,MalattiaCSI[xx].GG,'N',0,0,DataCassa);
          end;
        end;
      end;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.ConteggiAssenze(D:TDateTime);
var i:Byte;
begin
  with R502ProDtM1 do
  begin
    Conteggi('Cartolina',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,D);
    if Blocca <> 0 then
    begin
      flagasse2:=2;
      flagasse1:=2;
    end
    else
      for i:=1 to n_riepasse do
        if selT265.SearchRecord('CODICE',triepgiusasse[i].tcausasse,[srFromBeginning]) then
          RiepilogoAssenze(i);
  end;
end;

procedure TA037FScaricoPagheMW.RiepilogoAssenze(xx:Integer);
var i:Byte;
    Trovato:Boolean;
    minass,FruizMin,FruizArr:Integer;
    UMisura:String;
begin
  with R502ProDtM1 do
  begin
    Trovato:=False;
    for i:=1 to n_rpassemes do
      if AssenzeMese[i].Causale = triepgiusasse[xx].tcausasse then
      begin
        Trovato:=True;
        Break;
      end;
    if not Trovato then
    begin
      inc(n_rpassemes);
      i:=n_rpassemes;
      AssenzeMese[i].Causale:=triepgiusasse[xx].tcausasse;
      AssenzeMese[i].FiniRetr:=triepgiusasse[xx].tfiniretr;
    end;
    UMisura:='';
    if VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'UM_SCARICOPAGHE')) = 'G' then
      UMisura:='G'
    else if VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'UM_SCARICOPAGHE')) = 'O' then
      UMisura:='O'
    else if VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'UM_SCARICOPAGHE')) = 'C' then
      UMisura:=VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'UMISURA'));

    minass:=0;
    if Umisura = 'G' then
    begin
      //Fruizioni a giorni
      if ValStrT265[triepgiusasse[xx].tcausasse,'SCARICOPAGHE_FRUIZ_GG'] = 'S' then
        AssenzeMese[i].GG:=AssenzeMese[i].GG + triepgiusasse[xx].tggasse + (triepgiusasse[xx].tmezggasse/2);
      //Fruizioni ad ore
      if ValStrT265[triepgiusasse[xx].tcausasse,'SCARICOPAGHE_FRUIZ_ORE'] = 'S' then
      begin
        if debitocl > 0 then
          AssenzeMese[i].GG:=AssenzeMese[i].GG + (triepgiusasse[xx].tminasse / debitocl)
        else if (minmonteore > 0) and (giornlav > 0) and (gglav = 'si') then
          AssenzeMese[i].GG:=AssenzeMese[i].GG + (triepgiusasse[xx].tminasse / (minmonteore div giornlav));
      end;
    end
    else if Umisura = 'O' then
      minass:=triepgiusasse[xx].tminresoPaghe    //per TO_CSI tiene conto di minimo e arrotondamento a livello di singola fruizione
    else
    begin
      //Gestione standard
      //Fruizioni ad ore
      if ValStrT265[triepgiusasse[xx].tcausasse,'SCARICOPAGHE_FRUIZ_ORE'] = 'S' then
        minass:=triepgiusasse[xx].tminfruitoPaghe; //per TO_CSI tiene conto di minimo e arrotondamento a livello di singola fruizione
      //Fruizioni a giorni
      if ValStrT265[triepgiusasse[xx].tcausasse,'SCARICOPAGHE_FRUIZ_GG'] = 'S' then
      begin
        AssenzeMese[i].GG:=AssenzeMese[i].GG + triepgiusasse[xx].tggasse + (triepgiusasse[xx].tmezggasse/2);
        AssenzeMese[i].MG:=AssenzeMese[i].MG + triepgiusasse[xx].tmezggasse;
      end;
    end;
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    //Per TORINO_CSI gestire ancora il minimo che può essere definito sulla causale capo-catena
    begin
    end
    else
    //Per TORINO_CSI l'arrotondamento viene già gestito nella Rp502 a livello di singola fruizione
    begin
      if (minass > 0) and (VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'FRUIZCOMPETENZE_ARR')) = 'S') then
      begin
        FruizArr:=R180OreMinutiExt(VarToStr(selT265.Lookup('CODICE',triepgiusasse[xx].tcausasse,'FRUIZ_ARR')));
        if FruizArr > 1 then
          minass:=Trunc(R180Arrotonda(minass,FruizArr,'E'))
        else if FruizArr < -1 then
          minass:=Trunc(R180Arrotonda(minass,abs(FruizArr),'D'));
      end;
    end;
    inc(AssenzeMese[i].Min,minass);
  end;
end;

procedure TA037FScaricoPagheMW.ScorriQueryOreLavFasce(SalvaValore:Boolean; DataCassa: TDateTime);
var Primo:Boolean;
    OreLav:Integer;
begin
  QOreLavFasce.First;
  Primo:=True;
  while not(QOreLavFasce.EOF) do
  begin
    if not(QOreLavFascePOre_Lav.IsNull) then
    begin
      if (Primo) and (selT200.FieldByName('ORE_LAVFASCE_CONASS').AsString = 'N') then
        OreLav:=R180OreMinutiExt(QOreLavFasceOreLavorate.AsString) -
                R180OreMinutiExt(selT070OreAssenze.AsString)
      else
        OreLav:=R180OreMinutiExt(QOreLavFasceOreLavorate.AsString);
      TotOreLav:=TotOreLav + OreLav;
      if SalvaValore then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,Trim(QOreLavFascePOre_Lav.AsString),OreLav,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      Primo:=False;
    end;
    QOreLavFasce.Next;
  end;
end;

procedure TA037FScaricoPagheMW.ScorriQueryOreIndTurno(DataCassa: TDateTime);
begin
  QOreLavFasce.First;
  while not(QOreLavFasce.EOF) do
  begin
    if Trim(QOreLavFascePInd_Tur.AsString) <> '' then
      SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,Trim(QOreLavFascePInd_Tur.AsString),
                          R180OreMinutiExt(QOreLavFasceOreIndTurno.AsString),VettConst[CurrCodInt].Misura,0,0,DataCassa);

    QOreLavFasce.Next;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciBancaOre(DataCassa: TDateTime);
var i:Integer;
begin
  //Alberto 26/01/2006: i conteggi vengono già richiamati da ScorriCodiciInterni
  if R450DtM1.ttrovscheda[MCorr] = 0 then
    exit;
  for i:=1 to R450DtM1.NFasceMese do
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                        VarToStr(selT210.Lookup('Codice',R450DtM1.tFasce[i],'PORE_COMP')),
                        R450DtM1.tbancaore[i],VettConst[CurrCodInt].Misura,0,0,DataCassa)
end;

procedure TA037FScaricoPagheMW.ScorriCodiciInterni(bDipInSer,bScaricaTrasferte:boolean;CurrMM,CurrAA:Word;DataCassa: TDateTime);
var I:Integer;
begin
  for i:=0 to ComponentCount - 1 do
    if Components[i] is TOracleDataSet then
      if (Components[i] as TOracleDataSet).Filtered then
      begin
        (Components[i] as TOracleDataSet).Filtered:=False;
        (Components[i] as TOracleDataSet).Filtered:=True;
      end;
  selT070.First;
  SaldoMese:=GetSaldoMese;
  //Alberto 24/01/2006: richiamo i conteggi mensili che servono per la banca ore (30/04/2009 e per le ore causalizzate che rientrano in banca ore)
  //if (not bScaricaSoloTrasferte) and VoceAbilitata('032') then
  if bDipInSer and (VoceAbilitata('032') or VoceAbilitata('230')) then
    R450DtM1.ConteggiMese('Generico',ACorr,MCorr,selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  for I:=1 to High(VettConst) do
  begin
    CurrCodInt:=I;
    TotOreLav:=0;
    if bDipInSer then  //Se devo passare tutti i dati
    try
      if (VettConst[I].CodInt = '010') and (VoceAbilitata(VettConst[I].CodInt)) and (SaldoMese < 0) then
        //saldo mese negativo
        GestisciSaldoMese(False,DataCassa)
      else if (VettConst[I].CodInt = '020') and (VoceAbilitata(VettConst[I].CodInt)) and (SaldoMese > 0) then
        //saldo mese positivo
        GestisciSaldoMese(False,DataCassa)
      else if (VettConst[I].CodInt = '022') and (VoceAbilitata(VettConst[I].CodInt)) and (SaldoMese > 0) then
        //saldo mese positivo senza assenze
        GestisciSaldoMese(True,DataCassa)
      else if (VettConst[I].CodInt = '030') and (VoceAbilitata(VettConst[I].CodInt)) then
        //ore lavorate in fasce
        ScorriQueryOreLavFasce(True,DataCassa)
      else if (VettConst[I].CodInt = '032') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Banca ore in fasce
        GestisciBancaOre(DataCassa)
      else if (VettConst[I].CodInt = '034') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Banca ore liquidata
        GestisciBancaOreLiquidata(DataCassa)
      else if (VettConst[I].CodInt = '040') and (VoceAbilitata(VettConst[I].CodInt)) then
        //ore ind.turno in fasce
        ScorriQueryOreIndTurno(DataCassa)
      else if (VettConst[I].CodInt = '060') and (VoceAbilitata(VettConst[I].CodInt)) then
        //ore straordinario in fasce
        GestisciStrFasce(DataCassa)
      else if (VettConst[I].CodInt = '080') and (VoceAbilitata(VettConst[I].CodInt)) then
        //recupero debito
        GestisciAddebitoPaghe(DataCassa)
      else if (VettConst[I].CodInt = '082') and (VoceAbilitata(VettConst[I].CodInt)) then
        //recupero debito
        GestisciPermessiNonRecuperati(DataCassa)
      else if (VettConst[I].CodInt = '190') and (VoceAbilitata(VettConst[I].CodInt)) then
        //riposi non fruiti
        GestisciFestivitaNonGodute(DataCassa)
      else if (VettConst[I].CodInt = '090') and (VoceAbilitata(VettConst[I].CodInt)) then
        //totale ore lavorate
        GestisciTotOreLavorate(DataCassa)
      else if (VettConst[I].CodInt = '092') and (VoceAbilitata(VettConst[I].CodInt)) then
        //totale ore lavorate
        GestisciOreReseInail(DataCassa)
      else if (VettConst[I].CodInt = '100') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Numero pasti del mese
        GestisciNumPasti(DataCassa)
      else if (VettConst[I].CodInt = '110') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità notturna in ore
        GestisciTurnoOre(DataCassa)
      else if (VettConst[I].CodInt = '120') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità notturna in numero
        GestisciTurnoNum(DataCassa)
      else if (VettConst[I].CodInt = '130') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità festiva intera
        GestisciFestivIntera(DataCassa)
      else if (VettConst[I].CodInt = '140') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità festiva ridotta
        GestisciFestivRidotta(DataCassa)
      else if (VettConst[I].CodInt = '150') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità di presenza
        GestisciIndennitaPresenza(DataCassa)
      else if (VettConst[I].CodInt = '155') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Indennità di funzione
        GestisciIndennitaFunzione(DataCassa)
      else if (VettConst[I].CodInt = '160') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ore causalizzate liquidate
        GestisciOreCausalizzateLiquidate(DataCassa)
      else if (VettConst[I].CodInt = '170') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Giustificativi assenze
        GestisciAssenze(DataCassa)
      else if (VettConst[I].CodInt = '180') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Periodi di assenza
        GestisciPeriodiAssenze(CurrMM,CurrAA,DataCassa)
      else if (VettConst[I].CodInt = '200') and (VoceAbilitata(VettConst[I].CodInt)) then
        //totale minuti assestamento
        GestisciAssestCausali(DataCassa)
      else if (VettConst[I].CodInt = '205') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Liquidazione ore anni precedenti
        GestisciLiqOreAnniPrec (DataCassa)
      else if (VettConst[I].CodInt = '210') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Buoni mensa del mese
        GestisciBuoniMensa(DataCassa)
      else if (VettConst[I].CodInt = '220') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ticket restaurant
        GestisciTicket(DataCassa)
      else if (VettConst[I].CodInt = '215') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Buoni mensa acquistati nel mese
        GestisciBuoniTicketAcq('BuoniPasto',DataCassa)
      else if (VettConst[I].CodInt = '225') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ticket restaurant acquistati nel mese
        GestisciBuoniTicketAcq('Ticket',DataCassa)
      else if (VettConst[I].CodInt = '230') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ore causalizzate
        GestisciOreCausalizzate(DataCassa)
      else if (VettConst[I].CodInt = '250') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ore Causalizzate a blocchi(AMGAS)
        GestisciOreCausalizzateABlocchi(DataCassa)
      else if (VettConst[I].CodInt = '260') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Turni interi di reperibilità
        GestisciDatiReper('TURNIINTERI',DataCassa)
      else if (VettConst[I].CodInt = '270') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Turni in ore di reperibilità
        GestisciDatiReper('TURNIORE',DataCassa)
      else if (VettConst[I].CodInt = '280') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ore maggiorate di reperibilità
        GestisciDatiReper('OREMAGG',DataCassa)
      else if (VettConst[I].CodInt = '290') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Ore non maggiorate di reperibilità
        GestisciDatiReper('ORENONMAGG',DataCassa)
      else if (VettConst[I].CodInt = '295') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Gettoni chiamata reperibilità
        GestisciDatiReper('GETTONE_CHIAMATA',DataCassa)
      else if (VettConst[I].CodInt = '297') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Gettoni chiamata reperibilità
        GestisciDatiReper('TURNI_OLTREMAX',DataCassa)
      else if (VettConst[I].CodInt = '300') and (VoceAbilitata(VettConst[I].CodInt)) then
        //1° turni
        GestisciTurni('Turni1',DataCassa)
      else if (VettConst[I].CodInt = '310') and (VoceAbilitata(VettConst[I].CodInt)) then
        //2° turni
        GestisciTurni('Turni2',DataCassa)
      else if (VettConst[I].CodInt = '320') and (VoceAbilitata(VettConst[I].CodInt)) then
        //3° turni
        GestisciTurni('Turni3',DataCassa)
      else if (VettConst[I].CodInt = '330') and (VoceAbilitata(VettConst[I].CodInt)) then
        //4° turni
        GestisciTurni('Turni4',DataCassa);
    except
      on E:Exception do
        AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                    SelAnagrafe.FieldByName('T430BADGE').AsString,
                    SelAnagrafe.FieldByName('COGNOME').AsString,
                    SelAnagrafe.FieldByName('NOME').AsString,
                    E.Message,
                    SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    //**************************** Inizio scarico i dati delle missioni ********************************
    if bDipInSer or bScaricaTrasferte then
    try
      if ((VettConst[I].CodInt = '400') or (VettConst[I].CodInt = '410')) and (VoceAbilitata(VettConst[I].CodInt)) then
        //Missioni ind.intera
        GestisciMissioni('IMPORTOINDINTERA',DataCassa)
      else if ((VettConst[I].CodInt = '402') or (VettConst[I].CodInt = '412')) and (VoceAbilitata(VettConst[I].CodInt)) then
        //Missioni ind.rid. hh
        GestisciMissioni('IMPORTOINDRIDOTTAH',DataCassa)
      else if (VettConst[I].CodInt = '404') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Missioni ind.rid. gg
        GestisciMissioni('IMPORTOINDRIDOTTAG',DataCassa)
      else if (VettConst[I].CodInt = '406') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Missioni ind.rid. hh e gg
        GestisciMissioni('IMPORTOINDRIDOTTAHG',DataCassa)
      else if (VettConst[I].CodInt = '408') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Missioni ind.km nel comune
        GestisciIndennitaKmMissioni(DataCassa)
      else if (VettConst[I].CodInt = '424') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Rimborsi spese
        GestisciRimborsoSpese('IMPORTORIMBORSOSPESE',DataCassa)
      else if (VettConst[I].CodInt = '426') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Rimborso spese ind.suppl.
        GestisciRimborsoSpese('IMPORTOINDENNITASUPPLEMENTARE',DataCassa)
      else if (VettConst[I].CodInt = '428') and (VoceAbilitata(VettConst[I].CodInt)) then
        //Anticipi missioni
        GestisciAnticipi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataCassa);
    except
      on E:Exception do
        AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                    SelAnagrafe.FieldByName('T430BADGE').AsString,
                    SelAnagrafe.FieldByName('COGNOME').AsString,
                    SelAnagrafe.FieldByName('NOME').AsString,
                    E.Message,
                    SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    //***************************** Fine scarico dati delle missioni ****************************************

    //**************************** Inizio scarico incentivi ********************************
    if bDipInSer then
      if ((VettConst[I].CodInt = '240') or (VettConst[I].CodInt = '242') or (VettConst[I].CodInt = '244')) and
         VoceAbilitata(VettConst[I].CodInt) then
      try
        //Incentivi
        GestisciIncentivi(DataCassa);
      except
        on E:Exception do
          AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                      SelAnagrafe.FieldByName('T430BADGE').AsString,
                      SelAnagrafe.FieldByName('COGNOME').AsString,
                      SelAnagrafe.FieldByName('NOME').AsString,
                      E.Message,
                      SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    //**************************** Fine scarico incentivi ********************************
  end;
end;

function TA037FScaricoPagheMW.GetSaldoMese:Integer;
begin
  Result:=0;
  QOreLavFasce.First;
  while not QOreLavFasce.Eof do
  begin
    Result:=Result + R180OreMinutiExt(QOreLavFasce.FieldByName('ORELAVORATE').AsString);
    QOreLavFasce.Next;
  end;
  Result:=Result - R180OreMinutiExt(selT070.FieldByName('DEBITOORARIO').AsString);
end;

procedure TA037FScaricoPagheMW.IntegraCodiciPagheExtra(MM,AA:Word; DataCassa:TDateTime);
var UMExtra,CIExtra:String;
{TORINO_CSI: Richiama SalvaValoreGenerico per le voci paghe non riepilogate precedentemente,
 per via del fatto che i dati della scheda riepilogativa sono riferiti al mese settimanale, mentre lo scarico deve riguardare il mese da calendario}
  function EsisteVoce(Voce:String):Boolean;
  var i:Integer;
      S:String;
  begin
    Result:=False;
    S:=Voce;
    for i:=1 to NumRecord do
      if (R180In(S,VettCI[i].LstCodiciPaghe.Split([',']))) and
         (VettCI[i].Anno = AA) and
         (VettCI[i].Mese = MM) then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  if not Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    exit;
  with selT193Extra do
  begin
    Open;
    First;
    while not Eof do
    begin
      if not EsisteVoce(FieldByName('VOCE_PAGHE').AsString) then
      begin
        UMExtra:=FieldByName('UNITA_MISURA').AsString;
        CIExtra:=FieldByName('COD_INTERNO').AsString;
        SalvaValoreGenerico(CIExtra,FieldByName('VOCE_PAGHE').AsString,0,UMExtra,0,0,DataCassa);
        //Se la voce appena inserita non è significativa, la annullo
        if (NumRecord > 0) and (VettCI[NumRecord].Valore = 0) then
          dec(NumRecord);
      end;
      Next;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciSaldoMese(SenzaAssenze:Boolean;DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if SenzaAssenze then
    Valore:=SaldoMese-R180OreMinutiExt(selT070OreAssenze.AsString)
  else
    Valore:=SaldoMese;
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) and
     ((not SenzaAssenze) or ((SenzaAssenze) and (Valore > 0))) then
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
end;

procedure TA037FScaricoPagheMW.GestisciBancaOreLiquidata(DataCassa: TDateTime);
var CodPaghe:String;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                        CodPaghe,
                        selT070OreComp_Liquidate.AsInteger,
                        VettConst[CurrCodInt].Misura,0,0,DataCassa);
end;

procedure TA037FScaricoPagheMW.GestisciStrFasce(DataCassa: TDateTime);
var CodPaghe :String;
    Valore:Currency;
begin
  with QOreLavFasce do
  begin
    First;
    while not(Eof) do
    begin
      CodPaghe:=FieldByName('Pstr_Nel_Mese').AsString;
      Valore:=R180OreMinutiExt(FieldByName('LiquidNelMese').AsString);
      if CodPaghe <> '' then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,
                            Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      Next;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciAddebitoPaghe(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=R180OreMinutiExt(selT070AddebitoPaghe.AsString);
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciPermessiNonRecuperati(DataCassa: TDateTime);
var Giustif:TGiustificativo;
    CodPaghe: String;
begin
  with selT040CumuloT do
  begin
    First;
    while not Eof do
    begin
      if R600DtM1 = nil then
        R600DtM1:=TR600DtM1.Create(nil);
      R600DtM1.ScaricoPaghe:=True;
      Giustif.Causale:=FieldByName('CODICE').AsString;
      Giustif.Modo:='I';
      R600DtM1.GetAssenze(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(ACorr,MCorr,1),EncodeDate(ACorr,MCorr,1),0,Giustif);
      if R600DtM1.ValResiduo > 0 then
      begin
        CodPaghe:=FieldByName('VOCEPAGHE').AsString;
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,R600DtM1.ValResiduo,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      end;
      Next;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciFestivitaNonGodute(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070Riposi_NonFruiti.Value;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciTotOreLavorate(DataCassa: TDateTime);
var CodPaghe:String;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    ScorriQueryOreLavFasce(False,DataCassa);
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,TotOreLav,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciOreReseInail(DataCassa: TDateTime);
var CodPaghe:String;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,R180OreMinutiExt(selT070.FieldByName('ORE_INAIL').AsString),VettConst[CurrCodInt].Misura,0,0,DataCassa);
end;

procedure TA037FScaricoPagheMW.GestisciNumPasti(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if QNumPasti.SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
    repeat
      //Pasti a tariffa convenzionata
      Valore:=QNumPasti.FieldByName('Pasti').AsInteger;
      if (QNumPasti.FieldByName('Causale').AsString = '*') or (QNumPasti.FieldByName('Causale_Anom').AsString <> 'S') then
        CodPaghe:=QNumPasti.FieldByName('VocePaghe_NoCaus1').AsString
      else
        CodPaghe:=QNumPasti.FieldByName('VocePaghe1').AsString;
      if CodPaghe <> '' then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      //Pasti a tariffa intera
      Valore:=QNumPasti.FieldByName('Pasti2').AsInteger;
      if (QNumPasti.FieldByName('Causale').AsString = '*') or (QNumPasti.FieldByName('Causale_Anom').AsString <> 'S') then
        CodPaghe:=QNumPasti.FieldByName('VocePaghe_NoCaus2').AsString
      else
        CodPaghe:=QNumPasti.FieldByName('VocePaghe2').AsString;
      if CodPaghe <> '' then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
    until not QNumPasti.SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]);
end;

procedure TA037FScaricoPagheMW.GestisciTurnoOre(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070IndTurnoOre.AsInteger;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciTurnoNum(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070IndTurnoNum.Value;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciFestivIntera(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070FestivIntera.Value;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciFestivRidotta(DataCassa: TDateTime);
var CodPaghe,CodPagheApp:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070FestivRidotta.Value;
    //Leggo il codice della festività intera
    if LeggiCodPaghe(VettConst[CurrCodInt - 1].CodInt,CodPagheApp) then
      //Se ha lo stesso codice dell'indennità intera divido il valore per 2
      if CodPaghe = CodPagheApp then
        Valore:=Valore / 2;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciIndennitaPresenza(DataCassa: TDateTime);
var Valore:Currency;
    DS,DSErr:String;
begin
  QIndPresenza.First;
  while not(QIndPresenza.EOF) do
  begin
    try
      Valore:=StrToFloat(QIndPresenzaIndPres.AsString);
    except
      DS:={$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator;
      DSErr:=IfThen(DS = ',','.',',');
      Valore:=StrToFloat(StringReplace(QIndPresenzaIndPres.AsString,DSErr,DS,[]));
    end;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,QIndPresenzaVocePaghe.AsString,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
    QIndPresenza.Next;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciIndennitaFunzione(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=StrToFloatDef(VarToStr(QIndFunzione.FieldByName('IndFunz').Value),0);
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciOreCausalizzateLiquidate(DataCassa: TDateTime);
var OldCausale,NomeCampo,ValoreCampo:String;
    I:Integer;
    Valore:Currency;
begin
  selT074.First;
  OldCausale:=selT074Causale.Value;
  while not(selT074.EOF) do
  begin
    if not(selT074Causale.IsNull) then
    begin
      I:=1;
      while (not(selT074.EOF)) and (selT074Causale.Value = OldCausale) and (I <= 4) do
      begin
        Valore:=selT074Liquidato.AsInteger;
        NomeCampo:='VOCEPAGHELIQ' + IntToStr(I);
        ValoreCampo:=selT074.FieldByName(NomeCampo).AsString;
        if ValoreCampo <> '' then
        begin
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                              ValoreCampo,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
        I:=I + 1;
        selT074.Next;
      end;
      OldCausale:=selT074Causale.Value;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciAssestCausali(DataCassa: TDateTime);
begin
  ScorriQueryAssestCausali1(DataCassa);
  ScorriQueryAssestCausali2(DataCassa);
end;

procedure TA037FScaricoPagheMW.ScorriQueryAssestCausali1(DataCassa: TDateTime);
var NomeCampo1,ValoreCampo1: String;
    Valore1: Currency;
    I:Integer;
begin
  QAssestCausali1.First;
  I:=1;
  QOreLavFasce.First;
  while(not(QOreLavFasce.EOF))and(I <= 4) do
  begin
    if not(QAssestCausali1Causale1MinAss.IsNull) then
    begin
      NomeCampo1:='VOCEPAGHE' + inttostr(I);
      ValoreCampo1:=QAssestCausali1.FieldByName(NomeCampo1).AsString;
      if ValoreCampo1 <> '' then
      begin
        if not(QOreLavFasceOre1Assest.IsNull) then
        begin
          Valore1:=R180OreMinutiExt(QOreLavFasceOre1Assest.Value);
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                              ValoreCampo1,Valore1,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
      end;
    end;
    I:=I + 1;
    QOreLavFasce.Next;
  end;
end;

procedure TA037FScaricoPagheMW.ScorriQueryAssestCausali2(DataCassa: TDateTime);
var NomeCampo2,ValoreCampo2:String;
    Valore2: Currency;
    I:Integer;
begin
  QAssestCausali2.First;
  I:=1;
  QOreLavFasce.First;
  while(not(QOreLavFasce.EOF))and(I <= 4) do
  begin
    if not(QAssestCausali2Causale2MinAss.IsNull) then
    begin
      NomeCampo2:='VOCEPAGHE' + inttostr(I);
      ValoreCampo2:=QAssestCausali2.FieldByName(NomeCampo2).AsString;
      if ValoreCampo2 <> '' then
      begin
        if not(QOreLavFasceOre2Assest.IsNull) then
        begin
          Valore2:=R180OreMinutiExt(QOreLavFasceOre2Assest.Value);
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                     ValoreCampo2,Valore2,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
      end;
    end;
    I:=I + 1;
    QOreLavFasce.Next;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciLiqOreAnniPrec(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
    bTrovato:boolean;
begin
  with selT134 do
  begin
    bTrovato:=False;
    if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
      bTrovato:=SearchRecord('Data',VarArrayOf([EncodeDate(ACorr,MCorr,1)]),[srFromBeginning]);
    while bTrovato do
    begin
      Valore:=FieldByName('LIQORE_ANNIPREC').AsInteger;
      SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,FieldByName('Anno').AsInteger,12,DataCassa);
      bTrovato:=SearchRecord('Data',VarArrayOf([EncodeDate(ACorr,MCorr,1)]),[srFromCurrent]);
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciBuoniMensa(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  with QBuoniMensa do
    if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
      if Locate('Data',EncodeDate(ACorr,MCorr,1),[]) then
      begin
        Valore:=FieldByName('BP').AsInteger;
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      end;
end;

procedure TA037FScaricoPagheMW.GestisciTicket(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  with QBuoniMensa do
    if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
      if Locate('Data',EncodeDate(ACorr,MCorr,1),[]) then
      begin
        Valore:=FieldByName('TK').AsInteger;
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      end;
end;

procedure TA037FScaricoPagheMW.GestisciBuoniTicketAcq(Campo:String;DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  with selT690 do
    if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
      if Locate('Data',R180FineMese(EncodeDate(ACorr,MCorr,1)),[]) then
      begin
        Valore:=FieldByName(Campo).AsInteger;
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      end;
end;

procedure TA037FScaricoPagheMW.GestisciOreCausalizzate(DataCassa: TDateTime);
var OldCausale,NomeCampo,ValoreCampo:String;
    I:Integer;
    Valore:Currency;
begin
  selT074.First;
  OldCausale:=selT074Causale.AsString;
  while not(selT074.EOF) do
  begin
    if not(selT074Causale.IsNull) then
    begin
      I:=1;
      while (not(selT074.EOF)) and (selT074Causale.AsString = OldCausale) and (I <= 4) do
      begin
        Valore:=selT074OrePresenza.AsInteger;
        NomeCampo:='VOCEPAGHE' + IntToStr(I);
        ValoreCampo:=selT074.FieldByName(NomeCampo).AsString;
        if ValoreCampo <> '' then
        begin
          if selT074.FieldByName('ABBATTE_BUDGET').AsString = 'B' then
            Valore:=R450DtM1.GetOreBOMese(selT074Causale.AsString,I);
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,
                              ValoreCampo,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
        I:=I + 1;
        selT074.Next;
      end;
      OldCausale:=selT074Causale.Value;
    end;
  end;
end;

procedure TA037FScaricoPagheMW.GestisciOreCausalizzateABlocchi(DataCassa: TDateTime);
begin
  with selT076 do
  begin
    if SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
      repeat
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,FieldByName('VOCEPAGHE').AsString,R180OreMinutiExt(FieldByName('ORE').AsString),VettConst[CurrCodInt].Misura,0,0,DataCassa);
      until not(SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]));
  end;
end;

procedure TA037FScaricoPagheMW.GestisciDatiReper(Campo:String;DataCassa: TDateTime);
var Valore:Integer;
    CodPaghe:String;
begin
  with QDatiReper do
    //if Locate('Data',EncodeDate(ACorr,MCorr,1),[]) then
    if SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
      repeat
        if Campo = 'TURNIINTERI' then
          CodPaghe:=FieldByName('VP_TURNO').AsString
        else if Campo = 'TURNIORE' then
          CodPaghe:=FieldByName('VP_ORE').AsString
        else if Campo = 'OREMAGG' then
          CodPaghe:=FieldByName('VP_MAGGIORATE').AsString
        else if Campo = 'ORENONMAGG' then
          CodPaghe:=FieldByName('VP_NONMAGGIORATE').AsString
        else if Campo = 'GETTONE_CHIAMATA' then
          CodPaghe:=FieldByName('VP_GETTONE_CHIAMATA').AsString
        else if Campo = 'TURNI_OLTREMAX' then
          CodPaghe:=FieldByName('VP_TURNI_OLTREMAX').AsString;
        if CodPaghe = '<SI>' then
          LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe)
        else if CodPaghe = '<NO>' then
          CodPaghe:='';
        if Trim(CodPaghe) <> '' then
        begin
          try
            if (Campo = 'TURNIINTERI') or (Campo = 'GETTONE_CHIAMATA') or
               (Campo = 'TURNI_OLTREMAX') then
              Valore:=FieldByName(Campo).AsInteger
            else
              Valore:=R180OreMinutiExt(FieldByName(Campo).AsString);
          except
            Valore:=0;
          end;
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
      until not SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]);
end;

procedure TA037FScaricoPagheMW.GestisciTurni(T:String;DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
begin
  if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
  begin
    Valore:=selT070.FieldByName(T).AsInteger;
    SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciMissioni(C:String;DataCassa: TDateTime);
var CodPaghe, CodInterno:String;
    Valore:Currency;
begin
  with selM040 do
  begin
    if not Active then
      exit;
    if SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
      repeat
        //=====================================================================
        //LIQUIDO MISSIONE E GLI ANTICIPI COLLEGATI AD ESSA TRAMITE ID MISSIONE
        //=====================================================================
        LiquidaMissioni(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                        FieldByName('DATA').AsDateTime,
                        FieldByName('MESECOMPETENZA').AsDateTime,
                        FieldByName('DATADA').AsDateTime,
                        FieldByName('ORADA').AsString);

        Valore:=FieldByName(C).AsFloat;
        if C = 'IMPORTOINDINTERA' then
          CodPaghe:=Trim(FieldByName('CODVOCEPAGHEINTERA').AsString)
        else if C = 'IMPORTOINDRIDOTTAH' then
          CodPaghe:=Trim(FieldByName('CODVOCEPAGHESUPHH').AsString)
        else if C = 'IMPORTOINDRIDOTTAG' then
          CodPaghe:=Trim(FieldByName('CODVOCEPAGHESUPGG').AsString)
        else if C = 'IMPORTOINDRIDOTTAHG' then
          CodPaghe:=Trim(FieldByName('CODVOCEPAGHESUPHHGG').AsString);

        CodInterno:=VettConst[CurrCodInt].CodInt;
        if (((CodInterno = '400') or (CodInterno = '402') or (CodInterno = '404') or
            (CodInterno = '406')) and (FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S')) then
          CodPaghe:='';
        if (((CodInterno = '410') or (CodInterno = '412')) and (FieldByName('IND_DA_TAB_TARIFFE').AsString = 'N')) then
          CodPaghe:='';

        if CodPaghe <> '' then
        begin
          //Se la regola dice di passare DATADAL, chiamare SalvaValoreGenerico valorizzando gli ultimi 2 parametri,
          //altrimenti fare come sempre
          if FieldByName('DATARIF_VOCEPAGHE').AsString = 'M' then
            SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,R180Anno(FieldByName('DATADA').AsDateTime),R180Mese(FieldByName('DATADA').AsDateTime),DataCassa)
          else
            SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
        end;
      until not SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciIndennitaKmMissioni(DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
    Misura:String;
begin
  with selM052 do
  begin
    if not Active then
      exit;
    if SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
    repeat
      LiquidaMissioni(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                      FieldByName('MESESCARICO').AsDateTime,
                      FieldByName('MESECOMPETENZA').AsDateTime,
                      FieldByName('DATADA').AsDateTime,
                      FieldByName('ORADA').AsString);
      CodPaghe:=FieldByName('CODVOCEPAGHE').AsString;
      Valore:=FieldByName('IMPORTOINDENNITA').AsFloat;
      Misura:=VettConst[CurrCodInt].Misura;
      if (Valore = 0) and (FieldByName('KMPERCORSI').AsFloat <> 0) then
      begin
        Misura:='N';
        Valore:=FieldByName('KMPERCORSI').AsFloat;
      end;
      if FieldByName('DATARIF_VOCEPAGHE').AsString = 'M' then
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,Misura,R180Anno(FieldByName('DATADA').AsDateTime),R180Mese(FieldByName('DATADA').AsDateTime),DataCassa)
      else
        SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,Misura,0,0,DataCassa);
    until not SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciRimborsoSpese(C:String;DataCassa: TDateTime);
var CodPaghe:String;
    Valore:Currency;
    OK:Boolean;
begin
  with selM050 do
  begin
    if not Active then
      exit;
    if SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[srFromBeginning]) then
    repeat
      OK:=False;
      LiquidaMissioni(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                      FieldByName('MESESCARICO').AsDateTime,
                      FieldByName('MESECOMPETENZA').AsDateTime,
                      FieldByName('DATADA').AsDateTime,
                      FieldByName('ORADA').AsString);
      if C = 'IMPORTORIMBORSOSPESE' then
      begin
        if (FieldByName('SCARICOPAGHE').AsString = 'S') and (not FieldByName('CODICEVOCEPAGHE').IsNull) then
        begin
          OK:=True;
          CodPaghe:=FieldByName('CODICEVOCEPAGHE').AsString;
        end;
      end
      else
      begin
        if (FieldByName('SCARICOPAGHEINDENNITASUPPL').AsString = 'S') and (not FieldByName('CODICEVOCEPAGHEINDENNITASUPPL').IsNull) then
        begin
          OK:=True;
          CodPaghe:=FieldByName('CODICEVOCEPAGHEINDENNITASUPPL').AsString;
        end;
      end;
      if OK then
      begin
        Valore:=FieldByName(C).AsFloat;
        if FieldByName('DATARIF_VOCEPAGHE').AsString = 'M' then
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,R180Anno(FieldByName('DATADA').AsDateTime),R180Mese(FieldByName('DATADA').AsDateTime),DataCassa)
        else
          SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
      end;
    until not SearchRecord('Data',EncodeDate(ACorr,MCorr,1),[]);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciAnticipi(Prog:Integer;DataCassa: TDateTime);
var Valore:Currency;
    CodPaghe:String;
begin
  if Not(LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe)) then
    Exit;

  if selM060.RecordCount <= 0 then
    Exit;

  if selM060.SearchRecord('ANNO_SCADENZA;MESE_SCADENZA',VarArrayOf([ACorr,MCorr]),[srFromBeginning]) then
  begin
    Valore:=0;
    repeat
      selM060.Edit;
      selM060.FieldByName('STATO').AsString:='R';
      if selM060.fieldByName('STATO').Value <> selM060.FieldByName('STATO').medpOldValue then
        selM060.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=R180FineMese(DataCassa);
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(selM060),NomeOwner,selM060,True);
      selM060.Post;
      RegistraLog.RegistraOperazione;
    if (selM060.FieldByName('IMPORTO').AsFloat <> 0) then
        Valore:=Valore + selM060.FieldByName('IMPORTO').AsFloat;
    until not selM060.SearchRecord('ANNO_SCADENZA;MESE_SCADENZA',VarArrayOf([ACorr,MCorr]),[]);
    if selM060.FieldByName('DATARIF_VOCEPAGHE').AsString = 'M' then
      SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,R180Anno(selM060.FieldByName('DATA_MISSIONE').AsDateTime),R180Mese(selM060.FieldByName('DATA_MISSIONE').AsDateTime),DataCassa)
    else
      SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
  end;
end;

procedure TA037FScaricoPagheMW.GestisciIncentivi(DataCassa: TDateTime);
var Valore:Currency;
    //UM,
    CodPaghe:String;
    DCorr:TDateTime;
begin
  DCorr:=EncodeDate(ACorr,MCorr,1);
  selT762.SearchRecord('Data',DCorr,[srFromBeginning]);
  selT765.Close;
  selT765.SetVariable('DATA1',DCorr);
  selT765.SetVariable('DATA2',R180FineMese(DCorr));
  selT765.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT765.Open;
  while (not selT762.Eof) and (selT762.FieldByName('Data').AsDateTime = DCorr) do
  begin
    CodPaghe:='';
    Valore:=0;
    //Incentivi
    if (VettConst[CurrCodInt].CodInt = '240') then
    begin
      Valore:=selT762.FieldByName('Importo').AsFloat;
      if selT762.FieldByName('TipoImporto').AsString = '1' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_INTERA'))
      else if selT762.FieldByName('TipoImporto').AsString = '2' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_PROPORZIONATA'))
      else if selT762.FieldByName('TipoImporto').AsString = '3' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_NETTA'))
      else if selT762.FieldByName('TipoImporto').AsString = '4' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_NETTARISP'))
      else if selT762.FieldByName('TipoImporto').AsString = '99' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_RISPARMIO'))
      else if selT762.FieldByName('TipoImporto').AsString = '100' then
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_NORISPARMIO'));
    end
    //Quota quantitativa
    else if (VettConst[CurrCodInt].CodInt = '242') then
    begin
      if selT762.FieldByName('TipoImporto').AsString = '5' then
      begin
        Valore:=selT762.FieldByName('Giorni_Ore').AsFloat;
        CodPaghe:=VarToStr(selT765.Lookup('CODICE',selT762.FieldByName('CODTIPOQUOTA').AsString,'VP_QUANTITATIVA'));
      end;
    end
    //Penalizzazioni
    else if (VettConst[CurrCodInt].CodInt = '244') then
    begin
      if selT762.FieldByName('CODTIPOQUOTA').AsString = '_' then
      begin
        CodPaghe:=VarToStr(selT765.Lookup('TIPOQUOTA','P','VP_NETTA'));
//          if LeggiCodPaghe(VettConst[CurrCodInt].CodInt,CodPaghe) then
         Valore:=selT762.FieldByName('Importo').AsFloat;
      end;
    end;
    if CodPaghe <> ''  then
      SalvaValoreGenerico(VettConst[CurrCodInt].CodInt,CodPaghe,Valore,VettConst[CurrCodInt].Misura,0,0,DataCassa);
    selT762.Next;
  end;
end;

function TA037FScaricoPagheMW.LeggiCodPaghe(ValueIn:String; var FieldValue:String):Boolean;
begin
  FieldValue:=VarToStr(selT190.Lookup('CodInterno',ValueIn,'Voce_Paghe'));
  Result:=Trim(FieldValue) <> '';
end;

procedure TA037FScaricoPagheMW.LiquidaMissioni(Prog:Integer;data1,data2,data3:TDate;ora:String);
begin
  UpdM040.SetVariable('PROGRESSIVO',Prog);
  UpdM040.SetVariable('MESESCARICO',data1);
  UpdM040.SetVariable('MESECOMPETENZA',data2);
  UpdM040.SetVariable('DATADA',data3);
  UpdM040.SetVariable('ORADA',ora);
  UpdM040.Execute;
end;

function TA037FScaricoPagheMW.MessaggioEliminaDataCassa: String;
var
  MinDataRif,MaxDataCassa,MaxDataRif:String;
  Count195:Word;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT MIN(DATARIF) DR1,MAX(DATARIF) DR2,MAX(DATA_CASSA) DC,COUNT(*) TOT FROM T195_VOCIVARIABILI WHERE DATA_CASSA = (SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI)');
    Open;
    MinDataRif:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DR1').AsDateTime));
    MaxDataRif:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DR2').AsDateTime));
    MaxDataCassa:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DC').AsDateTime));
    Count195:=FieldByName('TOT').AsInteger;
    Close;
    Result:=Format(A000MSG_A037_DLG_FMT_ELIMINA_CASSA,[MaxDataCassa,MinDataRif,MaxDataRif,Count195]);
  end;
end;

procedure TA037FScaricoPagheMW.ScorriMesi(Data,DataIndietro: TDateTime;DipInSer:TDipendenteInServizio;CurrMM,CurrAA:Word;DataCassa: TDateTime);
var A1,M1,A2,M2,G:Word;
    bTrasferte:boolean;
    bDipInSer:boolean;
begin
  DecodeDate(DataIndietro,A1,M1,G);
  DecodeDate(Data,A2,M2,G);
  InterfacceUsate:='NULL';
  //Apertura Query
  ApriQuery(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger, DataIndietro, Data);
  NumRecord:=0;
  while True do
    begin
    if (A1 > A2) or ((A1 = A2) and (M1 > M2)) then
      Break;
    ACorr:=A1;
    MCorr:=M1;
    CodiceInterfaccia:='';
    bTrasferte:=False;
    bDipInSer:=DipInSer.DipendenteInServizio(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(ACorr,MCorr,1),R180FineMese(EncodeDate(ACorr,MCorr,1)));
    if not bDipInSer then
    begin
      bTrasferte:=VerificaTrasferte(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(ACorr,MCorr,1),R180FineMese(EncodeDate(ACorr,MCorr,1)));
      //Verifico per i dipendenti dimessi, relativi ad un mese compreso nel periodo di scarico
    end;
    if bDipInSer or bTrasferte then
      CodiceInterfaccia:=LeggiCodiceInterfaccia(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(EncodeDate(ACorr,MCorr,1)));
    if CodiceInterfaccia <> '' then
    begin
      InterfacceUsate:=InterfacceUsate + ',''' + CodiceInterfaccia + '''';
      ApriQueryIntPaghe(CodiceInterfaccia);
      //Inizializzo i conteggi per questo progressivo
      R502ProDtM1.PeriodoConteggi(EncodeDate(ACorr,MCorr,1),R180FineMese(EncodeDate(ACorr,MCorr,1)));
      R502ProDtM1.Conteggi('APERTURA',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,EncodeDate(ACorr,MCorr,1));
      //Estraggo il flag per progressivo e mese riferimento che specifica se nelle ore lavorate in fasce bisogna conteggiare anche le ore rese da assenza
      with selT200 do
      begin
        Close;
        SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DATARIF',R180FineMese(EncodeDate(ACorr,MCorr,1)));
        Open;
      end;
      //Se il dipendente è in servizio, scarico tutti i dati
      //Se il dipendente non è in servizio, ma ha delle missioni che devono essere scaricate nel mese di scarico
      //  allora scarico solo i dati relativi alle trasferte (bTrasferte=True).
      ScorriCodiciInterni(bDipInSer,bTrasferte,CurrMM,CurrAA,DataCassa);
      //TORINO_CSI: aggiunta codici non scaricati in precedenza
      IntegraCodiciPagheExtra(MCorr,ACorr,DataCassa);
    end;
    inc(M1);
    if M1 > 12 then
    begin
      inc(A1);
      M1:=1;
    end;
  end;
end;

function TA037FScaricoPagheMW.FormattaDalleAlle(H:TDateTime; F:String; L:Integer):String;
begin
  if LowerCase(F) = 'm' then
    Result:=AggiungiZeri(IntToStr(R180OreMinuti(H)),L)
  else if Trim(F) = '' then
    Result:=FormatDateTime('hhnn',H)
  else
    Result:=FormatDateTime(F,H);
end;

procedure TA037FScaricoPagheMW.ElaboraDipendente(Data, DataFile,DataIndietro,DataCassa:TDateTime;CurrMM,CurrAA:Word; DipInSer:TDipendenteInServizio;AggiornaT195,Conguagli,EsisteImporto,FileSeq,Aggiungi: Boolean; var F: TextFile);
var
  Apri:Boolean;
  i,j: Integer;
  S,C,Valore: String;
begin
  InizializzaVettore(Data, DataFile,CurrMM,CurrAA);

  try
    ScorriMesi(Data,DataIndietro,DipInSer,CurrMM,CurrAA,DataCassa);
    GetValoriEsistenti(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,InterfacceUsate,Data,DataIndietro,DataCassa);
    AggiungiVociPrecedenti(DataCassa);
    if AggiornaT195 then
    begin
      EliminaVociEsistenti(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger, Data, DataIndietro, DataCassa,FileSeq,Aggiungi);
      if NumRecord > 0 then
      begin
        RegistraLog.SettaProprieta('I','T195_VOCIVARIABILI',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger));
        RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataIndietro),DateToStr(Data)]));
        RegistraLog.RegistraOperazione;
      end;
    end;
    RegistraMsg.InserisciMessaggio('I',Format('Scarico paghe - Periodo: %s - %s Data cassa: %s Voci scaricate: %d',[DateToStr(DataIndietro),DateToStr(Data),DateToStr(DataCassa),NumRecord]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);

    Apri:=True; //<-- La prima volta deve sempre controllare, anche se non sono cambiate le variabili
    for I:=1 to NumRecord do
    begin
      if VettCI[I].CodiceInterno <> '' then
        GetValore(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,I,AggiornaT195,Conguagli,DataCassa);
      //I periodi di assenza (sia inseriti che cancellati) hanno VALORE = 0
      //ma devono essere elaborati lo stesso
      if (VettCI[I].Valore = 0) and (VettCI[I].Importo = 0) and (VettCI[I].CodiceInterno <> '180') and (VettCI[I].CodiceInterno <> 'CANCELLA') then
        Continue;
      //Controllo se il dipendente è in servizio
      if R180SetVariable(selT430,'DATA',R180FineMese(VettCI[I].Riferimento)) then Apri:=True;
      if R180SetVariable(selT430,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger) then Apri:=True;
      if Apri then
      begin
        selT430.Open;
        while not selT430.Eof and (selT430.FieldByName('INIZIO').AsDateTime > R180FineMese(VettCI[I].Riferimento)) do
        begin
          selT430.SetVariable('DATA',selT430.FieldByName('DATADECORRENZA').AsDateTime - 1);
          selT430.Close;
          selT430.Open;
        end;
        Apri:=False;
      end;
      S:='';
      for j:=1 to High(VettPos) do
      begin
        if VettPos[j] = 0 then Break;
        if VettTipo[j] = '0' then       //FILLER
          Valore:=VettDef[j]
        else if VettTipo[j] = '1' then  //ENTE
          if VettCI[I].CodiceInterno = 'CANCELLA' then
            Valore:='CANCELLA'
          else
            Valore:=selT191.FieldByName('DefaultEnte').asString
        else if VettTipo[j] = '2' then  //DATA DI RIFERIMENTO DEL DATO
        begin
          (*//Se il CodiceInterno è compreso tra 400 e 426, usare VettCI[I].Dal invece di VettCI[I].Anno/Mese
            if ((VettCI[I].CodiceInterno = '400') or (VettCI[I].CodiceInterno = '402') or (VettCI[I].CodiceInterno = '404')
            or (VettCI[I].CodiceInterno = '406') or (VettCI[I].CodiceInterno = '408') or (VettCI[I].CodiceInterno = '424')
            or (VettCI[I].CodiceInterno = '426')) then
              Valore:=FormattaData(VettDef[j],VettCI[I].Dal)
            else*)
          try
            Valore:=FormattaData(VettDef[j],EncodeDate(VettCI[I].Anno,VettCI[I].Mese,01));
          except
            Valore:=FormattaData(VettDef[j],Data);
          end;
        end
        else if VettTipo[j] = '3' then  //MATRICOLA
          Valore:=Copy(AggiungiZeri(SelAnagrafe.FieldByName('MATRICOLA').AsString,VettLung[j]),1,VettLung[j])
        else if VettTipo[j] = '4' then  //BADGE
          Valore:=AggiungiZeri(SelAnagrafe.FieldByName('T430BADGE').AsString,VettLung[j])
        else if VettTipo[j] = '5' then  //COD.INTERNO
          Valore:=VettCI[I].CodiceInterno
        else if VettTipo[j] = '6' then  //VOCE PAGHE con gestione negativi per CSI
        begin
          Valore:=VettCI[I].CodicePaghe;
          if (VettCI[I].Valore < 0) and (R180CarattereDef(VettDef[j],1,#0) = '-') then
            Valore:=TrasformaCodPaghe(Valore,VettDef[j],VettCI[I].Interfaccia,VettCI[I].Anno,VettCI[I].Mese);
        end
        else if VettTipo[j] = '7' then  //SEGNO
          if VettCI[I].Valore < 0 then
          begin
            if pos(',', VettDef[j]) > 0 then
              Valore:=Copy(VettDef[j],Pos(',', VettDef[j]) + 1, Length(VettDef[j]))
            else if VettDef[j] = '' then
              Valore:='-';
          end
          else
          begin
            if Pos(',', VettDef[j]) > 0 then
              Valore:=Copy(VettDef[j],1,Pos(',',VettDef[j]) - 1)
            else if VettDef[j] <> '' then
              Valore:=VettDef[j]
            else
              Valore:='+';
          end
          else if VettTipo[j] = '8' then
          //QUANTITA'
          begin
            if (VettCI[I].MisuraInterna = 'V') and EsisteImporto then
              Valore:=FormattaValore('1',VettLung[j])  //Voce passata a Importo: Quantità = 1
            else
            begin
              if VettCI[I].MisuraInterna = 'H' then
                Valore:=FormattaValore(FormattaOre(trunc(VettCI[I].Valore)),VettLung[j])
              else
                Valore:=FormattaValore(FloatToStr(VettCI[I].Valore),VettLung[j]);
              if (VettDef[j] = 'ABS') and (Valore[1] = '-') then
                Valore[1]:='0';
            end
          end
          else if VettTipo[j] = 'G' then
          //IMPORTO
          begin
            if (VettCI[I].MisuraInterna = 'V') then
              Valore:=FormattaValore(FloatToStr(VettCI[I].Valore),VettLung[j])
            else
              if VettCI[I].CodiceInterno = '242' then  //Lorena 17/07/2009
                Valore:=FormattaValore(FloatToStr(VettCI[I].Importo),VettLung[j])//FormattaValore(VarToStr(selT762.Lookup('DATA;TIPOIMPORTO',VarArrayOf([EncodeDate(VettCI[I].Anno,VettCI[I].Mese,01),'5']),'IMPORTO')),VettLung[j]) //Importo = Importo orario
              else
                Valore:=FormattaValore('0',VettLung[j]); //Voce passata a Quantità: Importo = 0
            if (VettDef[j] = 'ABS') and (Valore[1] = '-') then
              Valore[1]:='0';
          end
          else if VettTipo[j] = '9' then  //UNITA' MISURA
            Valore:=VettCI[I].Misura
          else if VettTipo[j] = 'A' then  //DALLA DATA
            Valore:=FormattaData(VettDef[j],VettCI[I].Dal)
          else if VettTipo[j] = 'B' then  //ALLA DATA
            Valore:=FormattaData(VettDef[j],VettCI[I].Al)
          else if VettTipo[j] = 'C' then  //RIFERIMENTO
            Valore:=FormattaData(VettDef[j],VettCI[I].Riferimento)
          else if VettTipo[j] = 'D' then  //DALL'ORA
          begin
            Valore:=FormattaDalleAlle(VettCI[I].Dalle,VettDef[J],VettLung[J]);
            if (VettCI[I].Dalle = VettCI[I].Alle) and (VettCI[I].Dalle = 0) then
              Valore:='';
          end
          else if VettTipo[j] = 'E' then  //ALL'ORA
          begin
            Valore:=FormattaDalleAlle(VettCI[I].Alle,VettDef[J],VettLung[J]);
            if (VettCI[I].Dalle = VettCI[I].Alle) and (VettCI[I].Dalle = 0) then
              Valore:='';
          end
          else if VettTipo[j] = 'F' then  //DATA_AGG
            Valore:=FormattaData(VettDef[j],VettCI[I].DataOper)
          else if VettTipo[j] = 'H' then  //dati anagrafici
            try
              C:=VarToStr(selI010.Lookup('NOME_LOGICO',VettDef[j],'NOME_CAMPO'));
              if (selDatiAnagrafici <> nil) and (selDatiAnagrafici.FindField(C) <> nil) then
              begin
                if selDatiAnagrafici.LocDatoStorico(R180FineMese(VettCI[I].Riferimento)) then
                  Valore:=Copy(selDatiAnagrafici.FieldByName(C).AsString,1,VettLung[j]);
              end
              else
                Valore:=Copy(SelAnagrafe.FieldByName(C).AsString,1,VettLung[j]);
            except
              Valore:='';
            end;
        if FileSeq then
          S:=S + Format('%-*s',[VettLung[j],Valore])
        else
          QIns.SetVariable(VettNome[j],Valore);
      end;
      if FileSeq then
        writeln(F,S)
      else
        QIns.Execute;
    end;
  except
    on E: Exception do
      AddAnomalia(SelAnagrafe.FieldByName('MATRICOLA').AsString,
                  SelAnagrafe.FieldByName('T430BADGE').AsString,
                  SelAnagrafe.FieldByName('COGNOME').AsString,
                  SelAnagrafe.FieldByName('NOME').AsString,
                  E.Message,
                  SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  if FileSeq then
    SessioneOracle.Commit;
end;

procedure TA037FScaricoPagheMW.EliminaVociEsistenti(P:LongInt;Data,DataIndietro,DataCassa: TDateTime;FileSeq,Aggiungi: Boolean);
var S:String;
    i:Integer;
begin
  S:='';
  for i:=1 to High(VettConst) do
    if VoceAbilitata(VettConst[i].CodInt) then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + '''' + VettConst[i].CodInt + '''';
    end;
  if S <> '' then
  begin
    selT195DataCassa.SetVariable('Progressivo',P);
    selT195DataCassa.SetVariable('DataRif1',DataIndietro);
    selT195DataCassa.SetVariable('DataRif2',Data);
    selT195DataCassa.SetVariable('Data_Cassa',DataCassa);
    selT195DataCassa.SetVariable('Cod_Interno',S);
    selT195DataCassa.Close;
    selT195DataCassa.Open;
    while not selT195DataCassa.Eof do
    begin
      //Norman 27/10/2006: se VOCEPAGHE è selezionata nella lista filtro voce effettua la cancellazione
      //altrimenti salta al record successivo
      if not VoceDisabilitata(selT195DataCassa.FieldByName('VOCEPAGHE').AsString) then
      begin
        if (not FileSeq) and (Aggiungi) then
          if (QDel.VariableIndex('Matricola') >= 0) and (QDel.VariableIndex('Dal') >= 0) and (QDel.VariableIndex('CodicePaghe') >= 0) then
        begin
          QDel.SetVariable('Matricola',SelAnagrafe.FieldByName('MATRICOLA').AsString);
          QDel.SetVariable('Dal',selT195DataCassa.FieldByName('DATARIF').AsDateTime);
          QDel.SetVariable('CodicePaghe',selT195DataCassa.FieldByName('VOCEPAGHE').AsString);
          QDel.Execute;
        end;
        selT195DataCassa.Delete;
      end
      else
        selT195DataCassa.Next;
    end;
  end;
end;

function TA037FScaricoPagheMW.FormattaData(F:String; D:TDateTime):String;
begin
  if Pos('FR',F) > 0 then
    with selT430 do
(*      if Eof or (FieldByName('FINE').AsDateTime < R180InizioMese(D)) then
        D:=R180FineMese(D)
      else
        D:=selT430.FieldByName('FINE').AsDateTime;
*)
      if Eof or (FieldByName('FINE').AsDateTime < R180FineMese(D)) then
        D:=selT430.FieldByName('FINE').AsDateTime
      else
        D:=R180FineMese(D);
  if Pos('31',F) > 0 then
    D:=R180FineMese(D);
  F:=StringReplace(StringReplace(F,'31','dd',[rfReplaceAll]),'FR','dd',[rfReplaceAll]);
  Result:=FormatDateTime(F,D);
end;

function TA037FScaricoPagheMW.FormattaOre(M:LongInt):String;
begin
  if selT191.FieldByName('FormatoOre').AsString = '0' then
    Result:=R180Centesimi(M)
  else if selT191.FieldByName('FormatoOre').AsString = '1' then
    Result:=R180MinutiOre(M)
  else
    Result:=IntToStr(M);
end;

procedure TA037FScaricoPagheMW.EliminaFiltroScaricoPaghe(Nome: String);
begin
  delT196.SetVariable('CODICE',Nome);
  delT196.Execute;
  delT196.Session.Commit;
  if selT196.State <> dsInactive then
    selT196.Refresh;
end;

procedure TA037FScaricoPagheMW.EliminaUltimaDataCassa;
{Cancellazione delle voci con data_cassa = alla corrente per tutti i dipendenti indistintamente}
begin
  delT195Cassa.Execute;
  SessioneOracle.Commit;
end;

function TA037FScaricoPagheMW.MessaggioRipristina: String;
var
  MaxDataCassa,MaxDataRif:TDateTime;
  Count195: Integer;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(DATARIF) D,MAX(DATA_CASSA) DC,COUNT(*) TOT FROM T195_BACKUP');
    Open;
    MaxDataRif:=FieldByName('D').AsDateTime;
    MaxDataCassa:=FieldByName('DC').AsDateTime;
    Count195:=FieldByName('TOT').AsInteger;
    Close;
    Result:=Format(A000MSG_A037_DLG_FMT_RIPRISTINA,
                   [Count195,FormatDateTime('mmmm yyyy',MaxDataRif),FormatDateTime('mmmm yyyy',MaxDataCassa)]);
  end;
end;

function TA037FScaricoPagheMW.MessaggioSalvataggio: String;
var
  MaxDataCassa,MaxDataRif:TDateTime;
  Count195: Integer;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(DATARIF) D,MAX(DATA_CASSA) DC,COUNT(*) TOT FROM T195_VOCIVARIABILI');
    Open;
    MaxDataRif:=FieldByName('D').AsDateTime;
    MaxDataCassa:=FieldByName('DC').AsDateTime;
    Count195:=FieldByName('TOT').AsInteger;
    Close;
    Result:=Format(A000MSG_A037_DLG_FMT_SALVA_FILTRO,
                   [Count195,FormatDateTime('mmmm yyyy',MaxDataRif),FormatDateTime('mmmm yyyy',MaxDataCassa)]);
  end;
end;

procedure TA037FScaricoPagheMW.SalvataggioScarico;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('DROP TABLE T195_BACKUP');
    try
      ExecSQL;
    except
    end;
    SQL.Clear;
    SQL.Add('CREATE TABLE T195_BACKUP NOPARALLEL AS SELECT * FROM T195_VOCIVARIABILI');
    ExecSQL;
  end;
end;

end.

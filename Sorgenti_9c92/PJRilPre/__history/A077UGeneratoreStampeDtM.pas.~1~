unit A077UGeneratoreStampeDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R003UGENERATORESTAMPE, R003UGENERATORESTAMPEDTM, Oracle, Db, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe, C180FunzioniGenerali,
  (*Midaslib,*) Crtl, DBClient, Math, Variants, DateUtils,
  R100UCreditiFormativiDtM, A124UPermessiSindacaliDtM, R450, R500Lin, Rp502Pro, R600,
  R300UAccessiMensaDtM, R350UCalcoloBuoniDtM, A077UGeneratoreStampeMW;

type
  TLiquidabileFineAnno = record
    Progressivo:Integer;
    Anni:array of Word;
    Ore:array of Integer;
  end;

  TA077FGeneratoreStampeDtM = class(TR003FGeneratoreStampeDtM)
    selT072: TOracleDataSet;
    selM050: TOracleDataSet;
    selM040: TOracleDataSet;
    selT195: TOracleDataSet;
    selT340: TOracleDataSet;
    selVSG651: TOracleDataSet;
    selVT246: TOracleDataSet;
    selVT247: TOracleDataSet;
    selVT248: TOracleDataSet;
    selM052: TOracleDataSet;
    selT762: TOracleDataSet;
    selT763: TOracleDataSet;
    selM060: TOracleDataSet;
    selVSG402: TOracleDataSet;
    selVSG303: TOracleDataSet;
    selVT280: TOracleDataSet;
    selVT050T105: TOracleDataSet;
    selVT500: TOracleDataSet;
    selC20Incarichi: TOracleDataSet;
    selSG710: TOracleDataSet;
    selVSG308: TOracleDataSet;
    selVT134: TOracleDataSet;
    selVT850_T851: TOracleDataSet;
    selT050: TOracleDataSet;
    selT065: TOracleDataSet;
    selT085: TOracleDataSet;
    selT105: TOracleDataSet;
    selT755: TOracleDataSet;
    selCSI006: TOracleDataSet;
    procedure R003FGeneratoreStampeDtMCreate(Sender: TObject);
    procedure R003FGeneratoreStampeDtMDestroy(Sender: TObject);
  private
    QuantAssenze,QuantAssenzeQM,CompAssenze,ElencoPresenze:Boolean;
    R600DtM1:TR600DtM1;
    R502ProDtm1:TR502ProDtm1;
    R450DtM1:TR450DtM1;
    R100FCreditiFormativiDtM:TR100FCreditiFormativiDtM;
    R300DtM:TR300FAccessiMensaDtM;
    R350DtM:TR350FcalcoloBuoniDtM;
    LiquidabileFineAnno:TLiquidabileFineAnno;
    procedure SetVariabileDatoDalAl(DataSet:TOracleDataSet;R:Integer);
    procedure CostruisciselT072;
    procedure CostruisciselM050;
    procedure CostruisciselM060;
    procedure CostruisciselT195;
    procedure CostruisciselVSindacati;
    procedure CostruisciselVSG651;
    procedure GetIndPresenza;
    procedure GetRiepilogo(A1,M1,A2,M2:Word);
    procedure GetSchedaRiepilogativa(i:Integer; Dato,Key,KeyTot:String; Valido:Boolean);
    procedure GetDatiRiepilogativi(i:Integer; Dato,Key,KeyTot:String);
    function GetResiduoLiquidabileFineAnno(Anno:Integer):Integer;
    procedure GetRiepilogoPresenze(P:Integer;Dato:String);
    procedure GetAssenze;
    procedure GetConteggiGiornalieri;
    procedure GetMissioni;
    procedure GetMissioniRimborsi;
    procedure GetMissioniIndKM;
    procedure GetMissioniAnticipi;
    procedure GetVociPaghe;
    procedure GetIncentivi;
    procedure GetRischiPrescrizioni;
    procedure GetIncarichi;
    function GetTimbratureEffettive(Fmt:String):String;
    function GetTimbratureCont(Fmt:String):String;
    function GetTimbratureNom:String;
    function GetGiustificativi(Fmt:String):String;
    function GetAnomaliaBloccante:String;
    function GetScostamentoPositivo:String;
    function GetOreLiquidabili:String;
    function FormattaTimbratura(Timbratura,Causale,Rilevatore,Fmt:String):String;
    function FormattaGiustificativo(Codice,Fmt:String):String;
    function GetRiepilogoOreCausalizzate:String;
    function GetRiepilogoOreAssenza:String;
    function GetOreDiPresenzaCausalizzate(Fmt,Key,KeyTot:String):String;
    function GetOreCausABlocchi:String;
    function GetOreDiAssenzaGG(Fmt,Key,KeyTot,TipoOre:String):String;
    function GetOreReseInFascia(Fmt:String):String;
    function GetOreLiquidabiliInFascia(Fmt:String):String;
    function GetOreInFascia(Vettore:array of integer; Fmt:String):String;
    function GetLiberaProfessione:String;
    function GetPresenzaOreRese(i:Integer):String;
    function GetPresenzaOreReseFascia(i:Integer; Fmt:String):String;
    procedure GetTurniReperibilita;
    procedure GetCreditiFormativi;
    procedure GetIscrizioniSindacali;
    procedure GetPartecipazioniSindacali;
    procedure GetPermessiSindacali;
    procedure GetMessaggiWeb;
    procedure GetRichiesteWeb;
    procedure GetIterWeb;
    procedure GetCartaServizi;
    procedure GetValutazioni;
    procedure GetIncVerifiche;
    procedure GetVariazSaldiAnniPrec;
    procedure GetIndFunzione;
    { Private declarations }
  public
    { Public declarations }
    procedure CreateT920_1;
    procedure CreateT920_2;
    procedure CreateT920_4;
    procedure CreateT920_5;
    procedure CreateT920_6;
    procedure CreateT920_7;
    procedure CreateT920_8;
    procedure CreateT920_9;
    procedure CreateT920_10;
    //procedure CreateT920_11;
    //procedure CreateT920_12;
    //procedure CreateT920_13;
    procedure CreateT920_14;
    procedure CreateT920_15;
    procedure CreateT920_16;
    //procedure CreateT920_17;
    //procedure CreateT920_18;
    procedure CreateT920_22;
    procedure CreateT920_26;
    procedure CaricaT920; override;
    procedure Carica_chklstCorsiFormazione(Tutto:Boolean);
    function A077FGeneratoreStampeMW: TA077FGeneratoreStampeMW;
  end;

var
  A077FGeneratoreStampeDtM: TA077FGeneratoreStampeDtM;

implementation

uses A077UGeneratoreStampe;

{$R *.DFM}

procedure TA077FGeneratoreStampeDtM.R003FGeneratoreStampeDtMCreate(
  Sender: TObject);
var
  lst: TStringList;
  s: String;
begin
  if Parametri.Applicazione = '' then
    //Parametri.Applicazione:='STAGIU';
    Parametri.Applicazione:='RILPRE';
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  R003FGeneratoreStampeMW:=TA077FGeneratoreStampeMW.Create(Self);
  inherited;

  lst:=A077FGeneratoreStampeMW.getListAssenze;
  try
    for s in lst do
      A077FGeneratoreStampe.chklstAssenze.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  lst:=A077FGeneratoreStampeMW.getListPresenze;
  try
    for s in lst do
      A077FGeneratoreStampe.chklstPresenza.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  lst:=A077FGeneratoreStampeMW.getListIndPresenza;
  try
    for s in lst do
      A077FGeneratoreStampe.chklstIndPresenza.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  lst:=A077FGeneratoreStampeMW.getListRimborsi;
  try
    for s in lst do
      A077FGeneratoreStampe.chklstRimborsi.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  lst:=A077FGeneratoreStampeMW.getListVociPaghe;
  try
    for s in lst do
      A077FGeneratoreStampe.chklstVociPaghe.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  lst:=A077FGeneratoreStampeMW.getListOrgSindacali;
  try
    for s in lst do
    begin
      A077FGeneratoreStampe.chklstIscrizioniSindacali.Items.Add(s);
      A077FGeneratoreStampe.chklstPartecipazioniSindacali.Items.Add(s);
      A077FGeneratoreStampe.chklstPermessiSindacali.Items.Add(s);
    end;
  finally
    FreeAndNil(lst);
  end;

  Carica_chklstCorsiFormazione(True);
  lst:=A077FGeneratoreStampeMW.getListRecapitoSindacato;
  try
    for s in lst do
    begin
      A077FGeneratoreStampe.cmbRecapitoSindacato_11.Items.Add(s);
      A077FGeneratoreStampe.cmbRecapitoSindacato_12.Items.Add(s);
      A077FGeneratoreStampe.cmbRecapitoSindacato_13.Items.Add(s);
    end;
  finally
    FreeAndNil(lst);
  end;
end;

function TA077FGeneratoreStampeDtM.A077FGeneratoreStampeMW: TA077FGeneratoreStampeMW;
begin
  Result:=(R003FGeneratoreStampeMW as TA077FGeneratoreStampeMW);
end;

procedure TA077FGeneratoreStampeDtM.R003FGeneratoreStampeDtMDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(R003FGeneratoreStampeMW);
end;

procedure TA077FGeneratoreStampeDtM.SetVariabileDatoDalAl(DataSet:TOracleDataSet;R:Integer);
var S:String;
begin
  if DataSet.VariableIndex('DATO_DALAL') >= 0 then
  begin
    if R180In(R,[9,10,17]) then
      R180SetVariable(DataSet,'DATO_DALAL','MESESCARICO');
    S:=R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(R)].DatoDalAl;
    if R180In(S,['MT_MESESCARICO','MR_MESESCARICO','MK_MESESCARICO']) then
      R180SetVariable(DataSet,'DATO_DALAL','MESESCARICO')
    else if R180In(S,['MT_MESECOMPETENZA','MR_MESECOMPETENZA','MK_MESECOMPETENZA']) then
      R180SetVariable(DataSet,'DATO_DALAL','MESECOMPETENZA')
    else if R180In(S,['MT_DADATA','MR_DADATA','MK_DADATA']) then
      R180SetVariable(DataSet,'DATO_DALAL','DATADA');
  end;
end;

procedure TA077FGeneratoreStampeDtM.Carica_chklstCorsiFormazione(Tutto:Boolean);
var Anno:Integer;
    Save, s:String;
    Lst: TStringList;
begin
  Save:=R180GetCheckList(20,A077FGeneratoreStampe.chklstCorsiFormazione);
  A077FGeneratoreStampe.chklstCorsiFormazione.Clear;

  Anno:= IfThen(A077FGeneratoreStampe.DataF > 0, R180Anno(A077FGeneratoreStampe.DataF), R180Anno(Parametri.DataLavoro));

  Lst:=A077FGeneratoreStampeMW.getListCorsiFormazione(Tutto,Anno);
  try
    for s in Lst do
      A077FGeneratoreStampe.chklstCorsiFormazione.Items.Add(s);
  finally
    FreeAndNil(lst);
  end;

  R180PutCheckList(Save,20,A077FGeneratoreStampe.chklstCorsiFormazione);
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselT072;
{Impostazione della query delle indennità di presenza}
var S:String;
    i:Integer;
begin
  S:='';
  with A077FGeneratoreStampe.chklstIndPresenza do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
      begin
        if S <> '' then S:=S + ',';
        S:=S + '''' + Trim(Copy(Items[i],1,5)) + '''';
      end;
  with selT072 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROGRESSIVO,DATA DATAINDPRESENZA,TO_CHAR(DATA,''YYYY'') ANNOINDPRESENZA,CODINDPRES CODINDPRESENZA,DESCRIZIONE DESCINDPRESENZA,IMPORTO IMPORTOINDPRESENZA,INDPRES NUMEROINDPRESENZA,INDSUPP_RESTO RESTOINDPRESENZA,IMPORTO * INDPRES COSTOINDPRESENZA');
    SQL.Add('FROM T072_SCHEDAINDPRES,T162_INDENNITA');
    SQL.Add('WHERE CODINDPRES = CODICE AND');
    SQL.Add('PROGRESSIVO = :PROGRESSIVO AND');
    SQL.Add('DATA BETWEEN :DATA1 AND :DATA2');
    if S <> '' then
      SQL.Add(Format('AND CODINDPRES IN (%s)',[S]));
    SQL.Add('ORDER BY DATA,CODINDPRES,DESCRIZIONE,IMPORTO');
    SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselM050;
{Impostazione della query dei rimborsi}
var S:String;
    i:Integer;
begin
  S:='';
  with A077FGeneratoreStampe.chklstRimborsi do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
      begin
        if S <> '' then
          S:=S + ' OR ';
        S:=S + '(MR_CODICERIMBORSO = ''' + Trim(Copy(Items[i],1,5)) + ''')'; // CODICERIMBORSOSPESE
      end;
  with selM050 do
  begin
    Close;
    Filter:=S;
  end;
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselM060;
{Impostazione della query degli anticipi}
begin
  with selM060 do
  begin
    Close;
    //Filter:=S;
    SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselT195;
{Impostazione della query delle voci paghe}
var S:String;
    i:Integer;
begin
  S:='';
  with A077FGeneratoreStampe.chklstVociPaghe do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
      begin
        if S <> '' then S:=S + ',';
        S:=S + '''' + Trim(Copy(Items[i],1,10)) + '''';
      end;
  if S <> '' then
    S:='AND VOCEPAGHE IN (' + S + ')';
  with selT195 do
  begin
    Close;
    SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    SetVariable('VOCI',S);
  end;
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselVSindacati;
{Impostazione della query dei sindacati}
var S1,S2,S3:String;
    i:Integer;
begin
  S1:='';
  S2:='';
  S3:='';
  with A077FGeneratoreStampe do
  begin
    for i:=0 to chklstIscrizioniSindacali.Items.Count - 1 do
    begin
      if chklstIscrizioniSindacali.Checked[i] then
      begin
        if S1 <> '' then S1:=S1 + ',';
        S1:=S1 + '''' + Trim(Copy(chklstIscrizioniSindacali.Items[i],1,10)) + '''';
      end;
      if chklstPartecipazioniSindacali.Checked[i] then
      begin
        if S2 <> '' then S2:=S2 + ',';
        S2:=S2 + '''' + Trim(Copy(chklstPartecipazioniSindacali.Items[i],1,10)) + '''';
      end;
      if chklstPermessiSindacali.Checked[i] then
      begin
        if S3 <> '' then S3:=S3 + ',';
        S3:=S3 + '''' + Trim(Copy(chklstPermessiSindacali.Items[i],1,10)) + '''';
      end;
    end;
    if S1 <> '' then S1:='AND IS_SINDACATO IN (' + S1 + ')';
    if S2 <> '' then S2:='AND OS_SINDACATO IN (' + S2 + ')';
    if S3 <> '' then S3:='AND PS_SINDACATO IN (' + S3 + ')';
    with selVT246 do
    begin
      Close;
      ClearVariables;
      SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
      SetVariable('TIPO_RECAPITO',R180CarattereDef(cmbRecapitoSindacato_11.Text,1,#0));
      SetVariable('COD_SINDACATI',S1);
    end;
    with selVT247 do
    begin
      Close;
      ClearVariables;
      SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
      SetVariable('TIPO_RECAPITO',R180CarattereDef(cmbRecapitoSindacato_12.Text,1,#0));
      SetVariable('COD_SINDACATI',S2);
    end;
    with selVT248 do
    begin
      Close;
      ClearVariables;
      SetVariable('DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      SetVariable('DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
      SetVariable('TIPO_RECAPITO',R180CarattereDef(cmbRecapitoSindacato_13.Text,1,#0));
      SetVariable('COD_SINDACATI',S3);
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.CostruisciselVSG651;
{Impostazione della query delle voci paghe}
var S:String;
    i:Integer;
begin
  S:='';
  with A077FGeneratoreStampe.chklstCorsiFormazione do
    for i:=0 to Items.Count - 1 do
      if Checked[i] then
      begin
        if S <> '' then S:=S + ',';
        S:=S + '''' + Trim(Copy(Items[i],1,20)) + '''';
      end;
  if S <> '' then
    S:='AND CF_COD_CORSO||''#''||CF_EDIZIONE IN (' + S + ')';
  with selVSG651 do
  begin
    Close;
    SetVariable('DATA1',R003FGeneratoreStampeMW.DaData);
    SetVariable('DATA2',R003FGeneratoreStampeMW.AData);
    SetVariable('CORSI',S);
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_1;
{Indennità di presenza}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_1;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(20)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(20)',otString);
    //Tutti i dati sono mumerici interi tranne la descrizione e la data
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'CODINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'DESCINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'DATAINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'ANNOINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'IMPORTOINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'NUMEROINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'RESTOINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'COSTOINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 512K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_2;
{Causali di presenza}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_2;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(20)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(20)',otString);
    //Tutti i dati sono numerici interi tranne la descrizione e la data
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'CODICEPRESENZE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'DESCRIZIONEPRESENZE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'DATARIEPILOGOPRES' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'ANNORIEPILOGOPRES' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(12)',otInteger);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 512K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_4;
{Dati giornalieri}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_4;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(80)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(80)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'DATACONTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'ANNOCONTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'MESECONTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(2)',otInteger) else
        if D = 'SETTIMANACONTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RILEVATORIDELGIORNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'TIMBRATURECONTEGGIATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'TIMBRATURENOMINALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'TIMBRATUREDIMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'PASTOINTERO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PASTOCONVENZIONATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'BUONOPASTOMATURATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'GIUSTIFICATIVI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(255)',otString) else
        if D = 'GGVUOTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ESISTENZATIMBRATURE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ANOMALIABLOCCANTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(80)',otString) else
        if D = 'MODELLOORARIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'TURNINONPIANIFICATI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'TURNIPIANIFICATI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'TURNIRICONOSCIUTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'SIGLATURNI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'LIVELLOPIANIFICATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'INDENNITPIANIFICATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'DEBITOGG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'DEBITOCARTELLINO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'DEBITOSETTIMANALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'GIORNILAVORATIVI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'ECCEDENZACOMPENSABILE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREDAASSENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREDIPRESENZALORDE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERENDICONTABILI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'SCOSTAMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREMATURATEPERPAUSAMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'DETRAZIONEPAUSAMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESEFUORIFASCIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREESCLUSEDALLENORMALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREOBBLIGATORIERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREOBBLIGATORIECARENTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREFACOLTATIVERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREFACOLTATIVECARENTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CARENZAORARIACOPERTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'GGLAVORATIVO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'GGFESTIVO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'OREPERINDFESTIVA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'ORERESEDIMATTINA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'ORERESEDIPOMERIGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'RIENTROPOMERIDIANO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'BUONOOBBLDARIENTROPOM' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'BUONOSUPPLDARIENTROPOM' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'OREDIOGGIPERINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'OREDIIERIPERINDPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otString) else
        if D = 'PRIMATIMBRATURAINUSCITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'ULTIMATIMBRATURAINENTRATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'ESISTETIMBRATURAPRECEDENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'ESISTETIMBRATURASUCCESSIVA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'PAUSAMENSAGESTITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'TIPODETRPAUSAMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'INIZIOPAUSAMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'FINEPAUSAMENSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'OREDATIMBRATURE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'INDPRESDAASSENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'GGINSERVIZIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'GGLAVINSERVIZIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'SCOSTAMENTONEGATIVO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'SCOSTAMENTOPOSITIVO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ABBATTIMENTOANNOPREC' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ABBATTIMENTOANNOATT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'GGDIPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PRESENZAPOMERIDIANA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'INDPRESENZAMATURATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'INDFESTIVAMATURATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'SCAVALCOMEZZANOTTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'INDNOTTURNAMATURATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'FESTIVITANONGODUTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'TIMBRATUREEFFETTIVE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'ORELIQUIDABILI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'RIEPILOGOORECAUSALIZZATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'RIEPILOGOOREASSENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CAUSALIPRESENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(60)',otString) else
        if D = 'OREDIPRESENZACAUSALIZZATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORECAUSABLOCCHI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CAUSALIASSENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(60)',otString) else
        if D = 'OREDIASSENZACAUSALIZZATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREDIASSENZARESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESE1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESE2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESE3' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORERESE4' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORELIQUIDABILI1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORELIQUIDABILI2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORELIQUIDABILI3' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'ORELIQUIDABILI4' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREINDTURNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREINDTURNO1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREINDTURNO2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREINDTURNO3' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'OREINDTURNO4' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'TURNIREPERIBILITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(26)',otString) else
        if D = 'TURNIREPERIBLIVPIANIF' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'PROLUNGAMENTOINIBITO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTOINEINIBITO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTOINUINIBITO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTONONCAUSALIZZ' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTOINENONCAUSALIZZ' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTOINUNONCAUSALIZZ' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTOINUSCITANONCAUS' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'PROLUNGAMENTONONCONTEGGIATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'LIBERAPROFESSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(50)',otString) else
        if D = 'RILEVATORE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'RILEVATOREORERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'ASSENZACAUSALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'ASSENZADESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'ASSENZANOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'ASSENZADATAFAMILIARE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'ASSENZAUMFRUIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'ASSENZAORERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'ASSENZAOREVALENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'ASSENZAFRUIZCOMPETENZE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'ASSENZAGIORNATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'ASSENZAFRUIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'ASSENZATIPOMG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'PRESENZACAUSALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'PRESENZADESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'PRESENZAORERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'PRESENZAORERESE1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'PRESENZAORERESE2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'PRESENZAORERESE3' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'PRESENZAORERESE4' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'LIBERAPROFESSIONECAUSALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'LIBERAPROFESSIONEDESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'LIBERAPROFESSIONEOREPIANIF' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'LIBERAPROFESSIONEORERESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'ANOMALIEGGID' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(7)',otString) else
        if D = 'ANOMALIEGGLIVELLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(1)',otInteger) else
        if D = 'ANOMALIEGGNUMERO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(3)',otInteger) else
        if D = 'ANOMALIEGGDESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString)
        ;
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 1M)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_5;
{Dati mensili}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_5;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(20)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(20)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'DATARIEPILOGOMENSILE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'ANNORIEPILOGOMENSILE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'CAUSALEASSESTAMENTO1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CAUSALEASSESTAMENTO2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'DATADIVARIAZIONESALDOANNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'NOTEDIVARIAZIONESALDOANNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'INDPRESENZATOTALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'INDFESTIVEINTERE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'INDFESTIVERIDOTTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'FORNITURABUONIPASTOACQUISTATI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'BLOCCHETTIACQUISTATI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(200)',otString) else
        if D = 'NOTEMATURAZBUONIPASTOTICKET' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(10)',otInteger);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 512K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_6;
{Missioni/Trasferte}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_6;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(255)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(255)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'MT_MESESCARICO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MT_MESECOMPETENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MT_DADATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MT_ADATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MT_DAORA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MT_AORA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MT_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'MT_MISSIONEFORMAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MT_PARTENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(200)',otString) else
        if D = 'MT_DESTINAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(200)',otString) else
        if D = 'MT_DURATAGIORNI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_DURATAORE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'MT_INDENNITATIPO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'MT_INDENNITAAPPLICATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_ORECONTEGGIATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otInteger) else
        if D = 'MT_INDENNITAIMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_KMTOTALIIMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_KMTOTALIFATTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_MODIFICAMANUALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MT_STATOMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MT_RIMBORSITOTALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_COSTIRIMBORSITOTALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_INDSUPPLTOTALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_RIMBINDSUPPLTOTALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_IMPORTOTOTALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_COSTOTOTALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MT_NOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(240)',otString) else
        if D = 'MT_COMMESSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(80)',otString) else
        if D = 'MT_VOCEPAGHE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 128K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_7;
{Missioni: riepilogo}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_7;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        // nuovi dati 8.5.ini
        if D = 'MR_RICHIESTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MR_INDENNITAKM' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MR_STATOAUTORIZZAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MR_IDMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        // nuovi dati 8.5.fine
        if D = 'MR_MESESCARICO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MR_MESECOMPETENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MR_DADATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MR_DAORA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MR_CODICERIMBORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MR_DESCRIZIONERIMBORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'MR_ANTICIPO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        // nuovi dati 8.5.ini
        if D = 'MR_RIMBORSORICHIESTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else //***
        // nuovi dati 8.5.fine
        if D = 'MR_RIMBORSORICONOSCIUTO'{'MR_RIMBORSO'} then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else //***
        if D = 'MR_INDENNITASUPPL' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MR_COSTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        // nuovi dati 8.5.ini
        if D = 'MR_KMRICHIESTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MR_KMRICONOSCIUTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        // nuovi dati 8.5.fine
        if D = 'MR_VOCEPAGHE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'MR_TIPOMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'MR_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'MR_COMMESSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(80)',otString) else
        // nuovi dati 8.5.ini
        if D = 'MR_NOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString);
        // nuovi dati 8.5.fine
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_8;
{Voci paghe scaricate}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_8;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(40)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(40)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'VP_MESECOMPETENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VP_ANNOCOMPETENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'VP_MESECASSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VP_ANNOCASSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'VP_VOCEPAGHE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'VP_CODICE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'VP_DESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'VP_MISURA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VP_VALORE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VP_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_9;
{Turni di reperibilità}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_9;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(40)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(40)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'IR_DATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IR_ANNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'IR_VP_TURNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'IR_VP_SPEZZONI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'IR_VP_OREMAGGIORATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'IR_VP_ORENONMAGG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'IR_VP_TURNIOLTREMAX' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'IR_VP_GETTONECHIAMATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'REPERIBILITATURNI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'REPERIBILITASPEZZONI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if D = 'REPERIBILITAOREMAGGIORATE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if D = 'REPERIBILITAORENONMAGG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if D = 'REPERIBILITATURNIOLTREMAX' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'REPERIBILITAGETTONECHIAMATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger);

      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_10;
{Crediti formativi}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_10;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(200)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(200)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'CF_COD_CORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'CF_DECORRENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_TITOLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'CF_EDIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_NOTIFICATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_DEFINITIVO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_INIZIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_FINE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_DURATA_GG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_DURATA_HH' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(7)',otString) else
        if D = 'CF_NUMERO_DELIBERA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'CF_DATA_DELIBERA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_PROFILO_CREDITI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_D_PROFILO_CREDITI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_TIPO_CORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_D_TIPO_CORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_EVENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_CREDITI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_GG_MIN' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_HH_MIN' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(7)',otString) else
        if D = 'CF_MAX_PARTECIPANTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_MAX_ISCRITTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_LUOGO_CORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'CF_D_LUOGO_CORSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_METODO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'CF_D_METODO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_FLAG_INTERNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_NOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'CF_ENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'CF_D_ENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_TIPOLOGIA_ENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_D_TIPOLOGIA_ENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'CF_TIPO_AGGIORNAMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'CF_NUMERO_GIORNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(2)',otInteger) else
        if D = 'CF_D_NUMERO_GIORNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'CF_INIZIO_MATT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_FINE_MATT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_INIZIO_POM' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_FINE_POM' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'CF_TIPO_PARTECIPAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_ORE_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_ORE_DOCENZA_INT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_ORE_DOCENZA_EST' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_CREDITI_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_TIPO_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2)',otString) else
        if D = 'CF_ATTIVO_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_TARIFFA_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_NOTE_DOCENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'CF_DATA_PARTECIPAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_ORA_INIZIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4000)',otString) else
        if D = 'CF_ORA_FINE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4000)',otString) else
        if D = 'CF_DURATA_PARTECIPAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'CF_NOTE_PARTECIPAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(300)',otString) else
        if D = 'CF_ORIGINE_ISCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_STATO_ISCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_TIPO_RECORD' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'CF_DATA_ISCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_DATA_AUTORIZZAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_DATA_VALIDAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'CF_OPERATORE_ISCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(30)',otString) else
        if D = 'CF_OPERATORE_AUTORIZZAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(30)',otString) else
        if D = 'CF_OPERATORE_VALIDAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(30)',otString) else
        if D = 'CF_CREDITI_PARTECIPAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_COMPETENZE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_COMPETENZEMIN' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_COMPETENZEMAX' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_FRUITO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_RESIDUO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_RESIDUOMIN' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_RESIDUOMAX' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'CF_RESIDUOANNOPREC' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

(*procedure TA077FGeneratoreStampeDtM.CreateT920_11;
{Iscrizioni ai sindacati}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_11;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
    begin
    selCols.Close;
    selCols.SetVariable('TABELLA','VT246_ISCRIZIONISINDACATI');
    selCols.Open;
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(200)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(200)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if DatiStampa[i].F in [1,2] then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if DatiStampa[i].F = 3 then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if selCols.SearchRecord('COLUMN_NAME',D,[srFromBeginning]) then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(' + selCols.FieldByName('DATA_LENGTH').AsString + ')',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
    end;
end;*)

(*procedure TA077FGeneratoreStampeDtM.CreateT920_12;
{Organismi sindacali}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_12;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
    begin
    selCols.Close;
    selCols.SetVariable('TABELLA','VT247_PARTECIPAZIONISINDACALI');
    selCols.Open;
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(200)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(200)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if DatiStampa[i].F in [1,2] then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if DatiStampa[i].F = 3 then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if selCols.SearchRecord('COLUMN_NAME',D,[srFromBeginning]) then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(' + selCols.FieldByName('DATA_LENGTH').AsString + ')',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
    end;
end;*)

(*procedure TA077FGeneratoreStampeDtM.CreateT920_13;
{Permessi sindacali}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_13;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
    begin
    selCols.Close;
    selCols.SetVariable('TABELLA','VT248_PERMESSISINDACALI');
    selCols.Open;
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(200)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(200)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if DatiStampa[i].F in [1,2] then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(20)',otInteger) else
        if DatiStampa[i].F = 3 then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if selCols.SearchRecord('COLUMN_NAME',D,[srFromBeginning]) then
          AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(' + selCols.FieldByName('DATA_LENGTH').AsString + ')',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 128K NEXT 256K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
    end;
end;*)

procedure TA077FGeneratoreStampeDtM.CreateT920_14;
{Missioni: indennità km}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_14;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'MK_MESESCARICO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MK_MESECOMPETENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MK_DADATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MK_DAORA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MK_CODICE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MK_DESCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'MK_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MK_KMFATTI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MK_VOCEPAGHE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'MK_TIPOMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'MK_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'MK_COMMESSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(80)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_15;
{Incentivi}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_15;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(40)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(40)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and
         (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and
         (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'QI_DATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate)
        else if D = 'QI_TIPO_QUOTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString)
        else if D = 'QI_COD_TIPO_QUOTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString)
        else if D = 'QI_DESC_TIPO_QUOTA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString)
        else if D = 'QI_INCENTIVI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString)
        else if D = 'QI_VARINCENTIVI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString)
        else if D = 'QI_RISORSE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString)
        else if D = 'QI_VARRISORSE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString)
        else if D = 'QI_ABBATTIMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString)
        else if D = 'QI_TIPOABBATTIMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString)
        //else if D = 'QI_INCENTIVILORDI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
        else if D = 'QI_COD_TIPO_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString)
        else if D = 'QI_DESC_TIPO_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString)
        else if D = 'QI_RISPARMIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString)
        else if D = 'QI_GIORNI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);

      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_16;
{Missioni: anticipi}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_16;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'MA_CASSA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'MA_ANNOMOVIMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4)',otString) else
        if D = 'MA_CODICEVOCE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'MA_DATAIMPOSTAZIONESTATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MA_DATAMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MA_DATAMOVIMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'MA_FLAGTOTALIZZATORE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'MA_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MA_NOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'MA_NUMEROMOVIMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MA_QUANTIT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'MA_STATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString);
        if D = 'MA_ITALIAESTERO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString);
        if D = 'MA_NUMEROSOSPESO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

(*procedure TA077FGeneratoreStampeDtM.CreateT920_17;
{Rischi/Prescrizioni}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_17;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if D = 'RP_TIPO_RISCHIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'RP_D_TIPO_RISCHIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'RP_DATA_INIZIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_DATA_FINE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_TIPO_CESSAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'RP_D_TIPO_CESSAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'RP_NOTE_RISCHIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'RP_DATA_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_ESITO_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'RP_PERIODICITA_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(2)',otInteger) else
        if D = 'RP_DATA_PROX_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_NOTE_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'RP_DATA_PERIODO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_OGGETTO_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'RP_PRESCRIZIONE_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'RP_D_PRESCRIZIONE_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'RP_DATA_ESITO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'RP_D_ESITO_VISITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;*)

(*procedure TA077FGeneratoreStampeDtM.CreateT920_18;
{Incarichi}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=Ins920_18;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(DatiStampa) do
      if (Dati[DatiStampa[i].N].M = StrToInt(NumTab)) and (not Dati[DatiStampa[i].N].Calcolato) and (UpperCase(DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(DatiStampa[i].D);
        if D = 'IN_COD_UNITAORG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'IN_TIPOINC' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IN_D_TIPOINC' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'IN_CATEGORIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IN_TITOLO_POSIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'IN_DATA_AFFIDAMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_DATA_SCADENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_DATA_SOTTOSCRIZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_TIPO_ASSEGNAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(18)',otString) else
        if D = 'IN_MANSIONI_COMPETENZE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_MOTIVAZIONI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_OBIETTIVI_GENERALI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_RISORSE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_OSSERVAZIONI_DIRIGENTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_TIPOATTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(30)',otString) else
        if D = 'IN_NUMATTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'IN_DATAATTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_AUTORITA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(40)',otString) else
        if D = 'IN_DATAESEC' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_COMMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IN_D_COMMISSIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'IN_DATA_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IN_ESITO_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_GIUDIZIO_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_PROPOSTA_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_ARTICOLO_REVOCA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString) else
        if D = 'IN_ANNOTAZIONI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(2000)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;*)

procedure TA077FGeneratoreStampeDtM.CreateT920_22;
{Valutazioni}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_22;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    //CD920.SQL.Add('CREATE TABLE T920_' + Parametri.Operatore + NumTab + ' (');
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    //Ins920x.SQL.Add('INSERT INTO T920_' + Parametri.Operatore + NumTab);
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'VA_DATA_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_ANNO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'VA_DAL_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_AL_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_COD_TIPO_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DESC_TIPO_VALUTAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(15)',otString) else
        if D = 'VA_COD_REGOLA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'VA_DESC_REGOLA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'VA_STATO_AVANZAMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(2)',otInteger) else
        if D = 'VA_DIPENDENTE_VALUTABILE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_CHIUSO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DATA_CHIUSURA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_DESC_STATO_SCHEDA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(50)',otString) else
        if D = 'VA_DATA_COMPILAZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_PROGRESSIVI_VALUTATORI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(50)',otString) else
        if D = 'VA_DESC_VALUTATORI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_PUNTEGGIO_FINALE_PESATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VA_ESITO_VAL_INTERMEDIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DESC_ESITO_VAL_INTERMEDIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'VA_VALUTAZIONE_INTERMEDIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_STORIA_VAL_INTERMEDIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4000)',otString) else
        if D = 'VA_VALUTAZIONI_COMPLESSIVE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(4000)',otString) else
        if D = 'VA_OBIETTIVI_AZIONI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_PROPOSTE_FORMATIVE_1' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_PROPOSTE_FORMATIVE_2' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_PROPOSTE_FORMATIVE_3' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_PROPOSTE_FORMATIVE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_ACCETTAZIONE_VALUTATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DESC_ACCETTAZIONE_VALUTATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(13)',otString) else
        if D = 'VA_COMMENTI_VALUTATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_NOTE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString) else
        if D = 'VA_NUMERO_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(8)',otInteger) else
        if D = 'VA_ANNO_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(4)',otInteger) else
        if D = 'VA_DATA_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_COD_TIPO_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DESC_TIPO_PROTOCOLLO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(10)',otString) else
        if D = 'VA_PRESA_VISIONE_DIP' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_DATA_PRESA_VISIONE_DIP' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'VA_COD_AREA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'VA_DESC_AREA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(100)',otString) else
        if D = 'VA_PESO_AREA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'VA_COD_ELEMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'VA_DESC_ELEMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1000)',otString) else
        if D = 'VA_PESO_ELEMENTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VA_ELEMENTO_VALUTABILE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1)',otString) else
        if D = 'VA_PUNTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VA_COD_PUNTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(6)',otString) else
        if D = 'VA_PUNTEGGIO_PESATO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'VA_NOTE_PUNTEGGIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(500)',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CreateT920_26;
{Indennità di funzione}
var i:Integer;
    CreateTable,InsertList,InsertVal,D,NumTab:String;
    Ins920x:TOracleQuery;
begin
  Ins920x:=A077FGeneratoreStampeMW.Ins920_26;
  NumTab:=Copy(Ins920x.Name,Pos('_',Ins920x.Name) + 1,3);
  with A077FGeneratoreStampe do
  begin
    CreateTable:='';
    InsertList:='';
    InsertVal:='';
    CD920.DeleteVariables;
    CD920.SQL.Clear;
    CD920.SQL.Add('CREATE TABLE T920_' + ParametriOperatore + NumTab + ' (');
    Ins920x.DeleteVariables;
    Ins920x.SQL.Clear;
    Ins920x.SQL.Add('INSERT INTO T920_' + ParametriOperatore + NumTab);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'PROGRESSIVO' + NumTab,'NUMBER(8)',otInteger);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEY' + NumTab,'VARCHAR2(160)',otString);
    AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,'T920_KEYTOT' + NumTab,'VARCHAR2(160)',otString);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].M = StrToInt(NumTab)) and (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'PROGRESSIVO' + NumTab) then
      begin
        D:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D);
        if D = 'IF_DATA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'DATE',otDate) else
        if D = 'IF_TIMBRATURE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1000)',otString) else
        if D = 'IF_GIUSTIFICATIVI' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(1000)',otString) else
        if D = 'IF_ORARIO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IF_ORE_ASSENZA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IF_ORE_RESE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IF_CONTRATTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IF_FASCIA' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(5)',otString) else
        if D = 'IF_INDFUNZIONE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'VARCHAR2(20)',otString) else
        if D = 'IF_ORE_IND' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(12)',otInteger) else
        if D = 'IF_IMPORTO' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'IF_IMPORTO_ORE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'IF_DISAGIO_SERALE' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER(12)',otInteger) else
        if D = 'IF_MAG_SER' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'IF_IMPORTO_MAG' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString) else
        if D = 'IF_IMPORTO_TOT' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'NUMBER',otString);
      end;
    CD920.SQL.Add(CreateTable);
    CD920.SQL.Add(')TABLESPACE ' + Parametri.TSAusiliario);
    CD920.SQL.Add('PCTFREE 5 PCTUSED 80 /*STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)*/ NOPARALLEL');
    CD920.Execute;
    Ins920x.SQL.Add(Format('(%s)',[InsertList]));
    Ins920x.SQL.Add('VALUES');
    Ins920x.SQL.Add(Format('(%s)',[InsertVal]));
  end;
end;

procedure TA077FGeneratoreStampeDtM.CaricaT920;
{Vengono riconosciuti i dati da estrarre; il ciclo dei dipendenti richiama le routines
 apposite per ogni gruppo di dati riconosciuto. I dati vengono registrati in memoria}
var i:Integer;
    Riepilogo,Assenze,ConteggiGiornalieri,PermessiSindacali,
    CreditiFormativi:Boolean;
    SAnagra:String;
    A1,A2,M1,M2:Word;
begin
  Riepilogo:=False;
  Assenze:=False;
  QuantAssenze:=False;
  QuantAssenzeQM:=False;
  CompAssenze:=False;
  ConteggiGiornalieri:=False;
  PermessiSindacali:=False;
  CreditiFormativi:=False;
  SAnagra:='';
  with A077FGeneratoreStampe do
  begin
    R003FGeneratoreStampeMW.DaData:= DataI;
    R003FGeneratoreStampeMW.AData:= DataF;
    A1:=R180Anno(R003FGeneratoreStampeMW.DaData);
    M1:=R180Mese(R003FGeneratoreStampeMW.DaData);
    A2:=R180Anno(R003FGeneratoreStampeMW.AData);
    M2:=R180Mese(R003FGeneratoreStampeMW.AData);
    for i:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].R = 1) and
         (not R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[i].N].Calcolato) and
         (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'NUMORDINE') and
         (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'FINEPERIODOPROVA') and
         (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'METPERIODOPROVA') and
         (UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D) <> 'P430PERC_IRPEF_TASS_SEP') and
         (Copy(UpperCase(R003FGeneratoreStampeMW.DatiStampa[i].D),1,8) <> 'CDCPERC_') then
      begin
        if SAnagra <> '' then SAnagra:=SAnagra + ',';
        SAnagra:=SAnagra + R003FGeneratoreStampeMW.DatiStampa[i].D;
      end;
    if EsisteRoutine(2) or EsisteRoutine(3) or EsisteRoutine(5) then
      Riepilogo:=True;
    if EsisteRoutine(6) then
    begin
      Assenze:=True;
      QuantAssenze:=True;
    end;
    if EsisteRoutine(7) then
    begin
      Assenze:=True;
      CompAssenze:=True;
    end;
    if EsisteRoutine(19) then
    begin
      Assenze:=True;
      QuantAssenzeQM:=True;
    end;
    if EsisteRoutine(8) then
      ConteggiGiornalieri:=True;
    if EsisteRoutine(13) then
      CreditiFormativi:=True;
    if EsisteRoutine(15) then
      PermessiSindacali:=True;
    if Assenze then
    begin
      R600DtM1:=TR600DtM1.Create(Self);
      R600DtM1.TO_CSI_SaltaSettimanaCorrente:=False;
    end;
    if Riepilogo then
      R450DtM1:=TR450DtM1.Create(nil);
    if ConteggiGiornalieri then
    begin
      if Assenze then
        R502ProDtM1:=R600Dtm1.R502ProDtM1
      else
        R502ProDtM1:=TR502ProDtM1.Create(nil);
      if (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOINTERO') >= 0) or (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOCONVENZIONATO') >= 0) then
        R300DtM:=TR300FAccessiMensaDtM.Create(nil);
      if R003FGeneratoreStampeMW.EsisteDatoStampa('BUONOPASTOMATURATO') >= 0 then
      begin
        R350DtM:=TR350FCalcoloBuoniDtM.Create(nil);
        R350DtM.R502ProDtM1.PeriodoConteggi(R003FGeneratoreStampeMW.DaData,R003FGeneratoreStampeMW.AData);
      end;
    end;
    if PermessiSindacali then
      A124FPermessiSindacaliDtM:=TA124FPermessiSindacaliDtM.Create(nil);
    if CreditiFormativi then
      R100FCreditiFormativiDtM:=TR100FCreditiFormativiDtM.Create(nil);
    R003FGeneratoreStampeMW.DatiAnagrafici.Close;
    if SAnagra <> '' then
    begin
      if ((R003FGeneratoreStampeMW.EsisteDatoStampa('FINEPERIODOPROVA') >= 0) or (R003FGeneratoreStampeMW.EsisteDatoStampa('METPERIODOPROVA') >= 0)) and
         (Parametri.CampiRiferimento.C6_DurataProva <> '') then
        with TStringList.Create do
        try
          CommaText:=SAnagra;
          if IndexOf('T430' + Parametri.CampiRiferimento.C6_DurataProva) = -1 then
            SAnagra:=SAnagra + ',T430' + Parametri.CampiRiferimento.C6_DurataProva;
          if (Parametri.CampiRiferimento.C6_InizioProva <> '') and
             (IndexOf('T430' + Parametri.CampiRiferimento.C6_InizioProva) = -1) then
            SAnagra:=SAnagra + ',T430' + Parametri.CampiRiferimento.C6_InizioProva;
          CommaText:=SAnagra;
          if IndexOf('T430INIZIO') = -1 then
            SAnagra:=SAnagra + ',T430INIZIO';
        finally
          Free;
        end;
      CreaSQLAnagrafico(SAnagra);
    end;
    CostruisciselT072;
    CostruisciselM050;
    CostruisciselM060;
    CostruisciselT195;
    CostruisciselVSG651;
    CostruisciselVSindacati;
    //Verifico se sono richieste delle causali di presenza particolari
    ElencoPresenze:=False;
    for i:=0 to chklstPresenza.Items.Count - 1 do
      if chklstPresenza.Checked[i] then
      begin
        ElencoPresenze:=True;
        Break;
      end;
    C700SelAnagrafe.First;
    R003FGeneratoreStampeMW.InizializzaVariabili(True);
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    R003FGeneratoreStampe.Enabled:=False;
    try
    //Scorrimento dipendenti selezionati
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      R003FGeneratoreStampeMW.InizializzaVariabili(False);
      selT430.Close;
      selT430.SetVariable('PROGRESSIVO',C700Progressivo);
      selT430.Open;
      if not FiltraDipendentiInServizio then
      begin
        C700SelAnagrafe.Next;
        Continue;
      end;
      //Registro i dati del dipendente per eventuale gestione dei periodi storici.
      DipendenteCorrente.Progressivo:=C700Progressivo;
      DipendenteCorrente.Dal:=C700SelAnagrafe.FieldByName('T430DATADECORRENZA').AsDateTime;
      DipendenteCorrente.Al:=C700SelAnagrafe.FieldByName('T430DATAFINE').AsDateTime;
      if SAnagra <> '' then
        GetAnagrafico;
      if EsisteRoutine(4) then
        GetIndPresenza;
      if Riepilogo then
        GetRiepilogo(A1,M1,A2,M2);
      if Assenze then
        GetAssenze;
      if ConteggiGiornalieri then
        GetConteggiGiornalieri;
      if EsisteRoutine(9) then
        GetMissioni;
      if EsisteRoutine(10) then
        GetMissioniRimborsi;
      if EsisteRoutine(17) then
        GetMissioniIndKM;
      if EsisteRoutine(20) then
        GetMissioniAnticipi;
      if EsisteRoutine(11) then
        GetVociPaghe;
      if EsisteRoutine(12) then
        GetTurniReperibilita;
      if EsisteRoutine(13) then
        GetCreditiFormativi;
      if EsisteRoutine(14) then
        GetIscrizioniSindacali;
      if EsisteRoutine(15) then
        GetPartecipazioniSindacali;
      if EsisteRoutine(16) then
        GetPermessiSindacali;
      if EsisteRoutine(18) then
        GetIncentivi;
      if EsisteRoutine(21) then
        GetRischiPrescrizioni;
      if EsisteRoutine(22) then
        GetIncarichi;
      if EsisteRoutine(23) then
        GetMessaggiWeb;
      if EsisteRoutine(24) then
        GetRichiesteWeb;
      if EsisteRoutine(25) then
        GetCartaServizi;
      if EsisteRoutine(26) then
        GetValutazioni;
      if EsisteRoutine(27) then
        GetIncVerifiche;
      if EsisteRoutine(28) then
        GetVariazSaldiAnniPrec;
      if EsisteRoutine(29) then
        GetIterWeb;
      if EsisteRoutine(30) then
        GetIndFunzione;
      R003FGeneratoreStampeMW.InserisciT920(R003FGeneratoreStampe.DataF);
      C700SelAnagrafe.Next;
    end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      R003FGeneratoreStampe.Enabled:=True;  //disabilita la form
      frmSelAnagrafe.VisualizzaDipendente; //Rivisualizza il dipendente
      ProgressBar1.Position:=0;
    end;
  end;
  if R450DtM1 <> nil then
  begin
    R450DtM1.DeallocaQueryStampa;
    FreeAndNil(R450DtM1);
  end;
  if Assenze then
    FreeAndNil(R600DtM1);
  if ConteggiGiornalieri and (not Assenze) then
    FreeAndNil(R502ProDtM1);
  if ConteggiGiornalieri and (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOINTERO') >= 0) or (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOCONVENZIONATO') >= 0) then
    FreeAndNil(R300DtM);
  if ConteggiGiornalieri and (R003FGeneratoreStampeMW.EsisteDatoStampa('BUONOPASTOMATURATO') >= 0) then
    FreeAndNil(R350DtM);
  if CreditiFormativi then
    FreeAndNil(R100FCreditiFormativiDtM);
  if PermessiSindacali then
    FreeAndNil(A124FPermessiSindacaliDtM);
  R003FGeneratoreStampeMW.DatiAnagrafici.Close;
  R003FGeneratoreStampeMW.InizializzaVariabili(True);
end;

procedure TA077FGeneratoreStampeDtM.GetIndPresenza;
{Lettura dati con R = 4}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 4;
begin
  with selT072 do
  begin
    if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;
    SetVariable('PROGRESSIVO',C700Progressivo);
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      if (A077FGeneratoreStampe.GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[A077FGeneratoreStampe.GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
      begin
        DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[A077FGeneratoreStampe.GetIdxTabelleCollegate(RInterno)].Data[1]).AsDateTime;
        DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName(R003FGeneratoreStampeMW.TabelleCollegate[A077FGeneratoreStampe.GetIdxTabelleCollegate(RInterno)].Data[2]).AsDateTime;
      end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'DATAINDPRESENZA' then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(DatiStampa[i].D).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetRiepilogo(A1,M1,A2,M2:Word);
{Lettura dati con R =
  2: Dati riepilogativi letti da R450DtM1
  3: Dati riepilogativi letti da Tabelle
  5: Riepilogo Presenze}
var A,M,i:Word;
    kc:Integer;
    Dato,Key,KeyTot,KCNome,S:String;
    InServizio,DatiMensili,ConteggiMensili:Boolean;
const RInterno = 2;
begin
  ConteggiMensili:=False;
  DatiMensili:=False;
  with R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
      if Dati[DatiStampa[i].N].R in [2,5] then
        ConteggiMensili:=True
      else if Dati[DatiStampa[i].N].R = 3 then
        DatiMensili:=True;
  R450DtM1.DaData:=R003FGeneratoreStampeMW.DaData;
  R450DtM1.AData:=R003FGeneratoreStampeMW.AData;
  R450DtM1.Progress400:=C700Progressivo;
  LiquidabileFineAnno.Progressivo:=-1;
  SetLength(LiquidabileFineAnno.Anni,0);
  SetLength(LiquidabileFineAnno.Ore,0);
  if DatiMensili then
  begin
    //Calcolo dati leggendo direttamente dagli archivi
    R450DtM1.ParametrizzazioneQueryStampa(0);
    R450DtM1.ParametrizzazioneQueryStampa(1);
    R450DtM1.ParametrizzazioneQueryStampa(2);
    R450DtM1.ParametrizzazioneQueryStampa(3);
    R450DtM1.ParametrizzazioneQueryStampa(4);
    R450DtM1.ParametrizzazioneQueryStampa(5);
    R450DtM1.ParametrizzazioneQueryStampa(6);
  end;
  A:=A1;
  M:=M1;
  repeat
    try
      //Verifica che il dipendente sia in servizio
      InServizio:=False;
      with selT430 do
      begin
        First;
        while not Eof do
        begin
          if (R180FineMese(EncodeDate(A,M,1)) >= FieldByName('Inizio').AsDateTime) and
             (EncodeDate(A,M,1) <= FieldByName('Fine').AsDateTime) then
          begin
            InServizio:=True;
            Break;
          end;
          Next;
        end;
        if not InServizio and not DatiMensili then
          Abort;
      end;
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=EncodeDate(A,M,1);
          DipendenteCorrente.DettaglioPeriodicoAl:=EncodeDate(A,M,1);
        end;
      if not PeriodoStoricoValido(RInterno) then
        Abort;
      //Calcolo dati cumulativi mesi precedenti
      if ConteggiMensili then
      begin
        R450DtM1.ConteggiMese('Generico',A,M,C700Progressivo);
        if R450DtM1.ttrovscheda[M] <> 1 then
        begin
          R450DtM1.tdatiassestamen[1].tcauassest:='';
          R450DtM1.tdatiassestamen[2].tcauassest:='';
        end;
      end
      else
      begin
        //Imposto manualente il mese poichè viene usato dalle query di R450 per GetDatiRiepilogativi
        R450DtM1.anno400:=A;
        R450DtM1.mese400:=M;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[1] do
        for kc:=0 to High(KeyCumulo) do
        begin
          KCNome:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if KCNome = 'DATARIEPILOGOMENSILE' then
            S:=FormatDateTime('yyyymmdd',EncodeDate(R450DtM1.anno400,R450DtM1.mese400,1))
          else if KCNome = 'ANNORIEPILOGOMENSILE' then
            S:=IntToStr(R450DtM1.anno400)
          else if KCNome = 'CAUSALEASSESTAMENTO1' then
            S:=R450DtM1.tdatiassestamen[1].tcauassest
          else if KCNome = 'CAUSALEASSESTAMENTO2' then
            S:=R450DtM1.tdatiassestamen[2].tcauassest;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        //Calcolo dati desunti dalla scheda riepilogativa e calcolati quindi dalla R450
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R in [2,3,5] then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'DATARIEPILOGOMENSILE' then
              PutValore(i,DatiStampa[i].V,DateToStr(EncodeDate(R450DtM1.anno400,R450DtM1.mese400,1)),Key,KeyTot,3,True)
            else if Dato = 'ANNORIEPILOGOMENSILE' then
                PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.anno400),Key,KeyTot,0,True)
            else
              case R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].R of
                2:GetSchedaRiepilogativa(i,Dato,Key,KeyTot,R450DtM1.ttrovscheda[M] = 1);
                3:GetDatiRiepilogativi(i,Dato,Key,KeyTot);
                5:GetRiepilogoPresenze(i,Dato);
              end;
          end;
        except
        end;
    except
    end;
    if (A = A2) and (M = M2) then Break;
    inc(M);
    if M = 13 then
    begin
      inc(A);
      M:=1;
    end;
  until False;
end;

procedure TA077FGeneratoreStampeDtM.GetSchedaRiepilogativa(i:Integer; Dato,Key,KeyTot:String; Valido:Boolean);
{Lettura dati con R = 2}
begin
  with R003FGeneratoreStampeMW do
    if Dato = 'PROGRESSIVO5' then
     PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,Valido)
    else if Dato = 'DEBITOCONTRATTUALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debormes),Key,KeyTot,1,Valido)
    else if Dato = 'DEBITOAGGIUNTIVO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debpomes),Key,KeyTot,1,Valido)
    else if Dato = 'DEBITOAGGIUNTIVOANNUO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debpoanno),Key,KeyTot,0,Valido)
    else if Dato = 'DEBITOAGGIUNTIVORESIDUO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debpoannores),Key,KeyTot,0,Valido)
    else if Dato = 'DEBITOAGGIUNTIVORESOMESE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debpoeff),Key,KeyTot,1,Valido)
    else if Dato = 'DEBITOAGGIUNTIVORESOANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debpoanno - R450DtM1.debpoannores),Key,KeyTot,1,Valido)
    else if Dato = 'DEBITOMENSILE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.debtotmes),Key,KeyTot,1,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'ORERESEFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tminlavmes[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'ORERESETOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.totoreres),Key,KeyTot,1,Valido)
    else if Dato = 'ORERESEINAIL' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreReseInail),Key,KeyTot,1,Valido)
    else if Dato = 'CAUSALEASSESTAMENTO1' then
      PutValore(i,DatiStampa[i].V,R450DtM1.tdatiassestamen[1].tcauassest,Key,KeyTot,0,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'ASSESTAMENTO1FASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tdatiassestamen[1].tminassest[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'ASSESTAMENTO1TOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.Assestamento1Totale),Key,KeyTot,1,Valido)
    else if Dato = 'CAUSALEASSESTAMENTO2' then
      PutValore(i,DatiStampa[i].V,R450DtM1.tdatiassestamen[2].tcauassest,Key,KeyTot,0,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'ASSESTAMENTO2FASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tdatiassestamen[2].tminassest[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'ASSESTAMENTO2TOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.Assestamento2Totale),Key,KeyTot,1,Valido)
    else if Dato = 'ORERESEDAPRESENZA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.totoreres - R450DtM1.OreAssenze),Key,KeyTot,1,Valido)
    else if Dato = 'ORERESEDAPRESENZAFASCIA1' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tminlavmes[1] - R450DtM1.OreAssenze),Key,KeyTot,1,Valido)
    else if Dato = 'ORERESEDAASSENZA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreAssenze),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOMESENETTO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salmeseatt),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOMESELORDO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.totoreres - R450DtM1.debormes),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOMESELIQUIDATO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.totoreres - R450DtM1.debormes - R450DtM1.LiqNelMese),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOALMESEPRECEDENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salfmprec),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOALMESEPRECNETTO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salfmprecnetto),Key,KeyTot,1,Valido)
    else if Dato = 'SALDOANNOPRECEDENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.l13_sallav_min),Key,KeyTot,0,True)
    else if Dato = 'SALDOANNOCORRENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salannoatt - R450DtM1.l13_sallav_min),Key,KeyTot,0,True)
    else if Dato = 'SALDOANNOTOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salannoatt),Key,KeyTot,0,True)
    else if Dato = 'SALDOCOMPLESSIVONETTO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salannonetto),Key,KeyTot,0,True)
    else if Dato = 'COMPANNOPRECEDENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salcompannoprec),Key,KeyTot,0,True)
    else if Dato = 'LIQANNOPRECEDENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salliqannoprec),Key,KeyTot,0,True)
    else if Dato = 'COMPANNOCORRENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salcompannoatt),Key,KeyTot,0,True)
    else if Dato = 'LIQANNOCORRENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salliqannoatt),Key,KeyTot,0,True)
    else if Dato = 'COMPLIQANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salliqannoprec + R450DtM1.salcompannoprec),Key,KeyTot,0,True)
    else if Dato = 'COMPLIQANNOCORR' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salliqannoatt + R450DtM1.salcompannoatt),Key,KeyTot,0,True)
    else if Dato = 'COMPENSABILECOMPLESSIVO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salcompannoatt + R450DtM1.salcompannoprec),Key,KeyTot,0,True)
    else if Dato = 'SALDOANNOLIQUIDATO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.LiqOreAnniPrec),Key,KeyTot,0,True)
    else if Dato = 'VARIAZIONISALDOANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.VariazioneSaldo),Key,KeyTot,1,Valido)
    else if Dato = 'DATADIVARIAZIONESALDOANNO' then
      PutValore(i,DatiStampa[i].V,DateToStr(R450DtM1.DataVariazSaldiPrec),Key,KeyTot,0,Valido)
    else if Dato = 'NOTEDIVARIAZIONESALDOANNO' then
      PutValore(i,DatiStampa[i].V,R450DtM1.NoteVariazSaldiPrec,Key,KeyTot,0,Valido)
    else if Dato = 'RECUPEROANNOPRECEDENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.abbannopreceff),Key,KeyTot,1,Valido)
    else if Dato = 'RECUPEROANNOCORRENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.abbannoatteff),Key,KeyTot,1,Valido)
    else if Dato = 'DEBITOPOANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.DebPoAnno),Key,KeyTot,0,True)
    else if Dato = 'PORESO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.PoResoAnno),Key,KeyTot,0,True)
    else if Dato = 'SALDOPOANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.PoResoAnno - R450DtM1.DebPoAnno),Key,KeyTot,0,True)
    else if Copy(Dato,1,Length(Dato) - 1) = 'STRFATTOMESEFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tstrmese[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'STRFATTOMESETOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.StrFattoMeseTotale),Key,KeyTot,1,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'LIQUIDDALMESEFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tstrliqmm[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'LIQUIDDALMESETOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.LiqDalMese),Key,KeyTot,1,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'LIQUIDNELMESEFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tLiqNelMese[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'LIQUIDNELMESETOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.LiqNelMese),Key,KeyTot,1,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'STRFATTOANNOFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tstrannom[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,0,True and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'STRFATTOANNOTOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.StrFattoAnno),Key,KeyTot,0,True)
    else if Copy(Dato,1,Length(Dato) - 1) = 'LIQUIDNELLANNOFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tstrliq[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,0,True and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'LIQUIDNELLANNOTOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.LiqNellAnno),Key,KeyTot,0,True)
    else if Copy(Dato,1,Length(Dato) - 1) = 'STRDALIQUIDAREFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tstrannom[StrToInt(Copy(Dato,Length(Dato),1))] - R450DtM1.tstrliq[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,0,True and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'STRDALIQUIDARETOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.StrFattoAnno - R450DtM1.LiqNellAnno),Key,KeyTot,0,True)
    else if Dato = 'ECCCOMPNELMESE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.EccSoloCompMes),Key,KeyTot,1,Valido)
    else if Dato = 'ECCCOMPNELLANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.EccSoloCompAnno),Key,KeyTot,0,True)
    else if Dato = 'ECCCOMPRESIDUA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.EccSoloCompRes),Key,KeyTot,0,True)
    else if Dato = 'ECCCOMPMENSILERESIDUA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.CompensabileMensileNettoRiposi),Key,KeyTot,0,True)
    else if Dato = 'GIORNIDIPRESENZA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.GGPresenza),Key,KeyTot,1,Valido)
    else if Dato = 'GIORNIVUOTI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.GGVuoti),Key,KeyTot,1,Valido)
    else if Dato = 'PRIMITURNI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.PrimiTurni),Key,KeyTot,1,Valido)
    else if Dato = 'SECONDITURNI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.SecondiTurni),Key,KeyTot,1,Valido)
    else if Dato = 'TERZITURNI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TerziTurni),Key,KeyTot,1,Valido)
    else if Dato = 'QUARTITURNI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.QuartiTurni),Key,KeyTot,1,Valido)
    else if Dato = 'INDFESTIVEINTERE' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.FesIntMes),Key,KeyTot,1,Valido)
    else if Dato = 'INDFESTIVERIDOTTE' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.FesRidMes),Key,KeyTot,1,Valido)
    else if Dato = 'INDNOTTURNAGG' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.IndNotturnaGG),Key,KeyTot,1,Valido)
    else if Dato = 'INDNOTTURNAORE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.IndNotturnaOre),Key,KeyTot,1,Valido)
    else if Dato = 'INDFESTIVEINTERECALC' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.FesIntMes - R450DtM1.fesintmesVar),Key,KeyTot,1,Valido)
    else if Dato = 'INDFESTIVERIDOTTECALC' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.FesRidMes - R450DtM1.fesridmesVar),Key,KeyTot,1,Valido)
    else if Dato = 'INDNOTTURNAGGCALC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.IndNotturnaGG - R450DtM1.notggmesVar),Key,KeyTot,1,Valido)
    else if Dato = 'INDNOTTURNAORECALC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.IndNotturnaOre - R180OreMinutiExt(R450DtM1.notminmesVar)),Key,KeyTot,1,Valido)
    else if Dato = 'FESTIVINONGODUTI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.FestiviNonGoduti),Key,KeyTot,1,Valido)      
    else if Dato = 'OREADDEBITATEALLEPAGHE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.AddebitoPaghe),Key,KeyTot,1,Valido)
    else if Dato = 'ORECARENTIOLTRESALDONEGMIN' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.SaldoNegativoMinimoEcced),Key,KeyTot,1,Valido)
    else if Dato = 'OREOLTRESALDONEGMINRECUPERATE' then
      PutValore(i,DatiStampa[i].V,IntToStr(max(0,R450DtM1.RiepilogoPrecedente.SaldoNegativoMinimoEcced - R450DtM1.AddebitoPaghe)),Key,KeyTot,1,Valido)
    else if Dato = 'NEGATIVINONRECUPERATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.NegativiNonRecuperati),Key,KeyTot,1,Valido)
    else if Dato = 'OREPERSEPERIODICAMENTE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OrePersePeriodiche),Key,KeyTot,0,True)
    else if Dato = 'ORECOMPENSABILITRONCATE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreTroncate),Key,KeyTot,1,Valido)
    else if Dato = 'STRAORDMAXMENSILE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.StrAutMen),Key,KeyTot,1,True)
    else if Dato = 'ECCEDRESIDUAAUTORIZZATA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.EccResAutMen),Key,KeyTot,1,True)
    else if Dato = 'STRAORDMAXMENSILETEORICO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.StrAutMen_Teorico),Key,KeyTot,1,True)
    else if Dato = 'ECCEDRESIDUAAUTORIZZATATEORICA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.ResAutMen_Teorico),Key,KeyTot,1,True)
    else if Copy(Dato,1,Length(Dato) - 1) = 'OREINTURNOFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tmininturno[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'OREINTURNOTOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreInTurnoDelMese),Key,KeyTot,1,Valido)
    else if Dato = 'OREESCLUSECOMPENSABILI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreEsclComp),Key,KeyTot,1,Valido)
    else if Copy(Dato,1,Length(Dato) - 1) = 'BANCAOREFASCIA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.tbancaore[StrToInt(Copy(Dato,Length(Dato),1))]),Key,KeyTot,1,Valido and (R450DtM1.NFasceMese >= StrToInt(Copy(Dato,Length(Dato),1))))
    else if Dato = 'BANCAORETOTALE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreMese),Key,KeyTot,1,Valido)
    else if Dato = 'BANCAORELIQUIDATANELMESE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreCompLiquidate),Key,KeyTot,1,Valido)
    else if Dato = 'BANCAORELIQMESEVARIAZIONE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreLiqVar),Key,KeyTot,1,Valido)
    else if Dato = 'BANCAORELIQUIDATANELLANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreLiquidata),Key,KeyTot,0,True)
    else if Dato = 'BANCAORERECUPERATANELMESE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreCompRecuperate),Key,KeyTot,1,Valido)
    else if Dato = 'BANCAORERECUPERATANELLANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreRecuperata),Key,KeyTot,0,True)
    else if Dato = 'BANCAOREDELLANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreAnno),Key,KeyTot,0,True)
    else if Dato = 'BANCAORERESIDUA' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreResidua),Key,KeyTot,0,True)
    else if Dato = 'BANCAOREANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BancaOreResiduaPrec),Key,KeyTot,0,True)
    else if Dato = 'RIPOSICOMPENSATIVIMATURATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.ripcommes),Key,KeyTot,1,True)
    else if Dato = 'RIPOSICOMPENSATIVIABBATTUTI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.abbripcommes + R450DtM1.RipComLiqMes),Key,KeyTot,1,True)
    else if Dato = 'RIPOSICOMPENSATIVIRESIDUI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salripcom),Key,KeyTot,0,True)
    else if Dato = 'RIPOSICOMPENSATIVIDELMESE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salripcommes),Key,KeyTot,0,True)
    else if Dato = 'RIPOSICOMPENSATIVIMESEPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salripcomfmprec),Key,KeyTot,0,True)
    else if Dato = 'RIPOSINONFRUITIGG' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.RiposiNonFruitiGG),Key,KeyTot,0,True)
    else if Dato = 'RIPOSINONFRUITIORE' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.RiposiNonFruitiOre),Key,KeyTot,0,True);
end;

procedure TA077FGeneratoreStampeDtM.GetDatiRiepilogativi(i:Integer; Dato,Key,KeyTot:String);
{Lettura dati con R = 3}
var D:TDateTime;
begin
  D:=EncodeDate(R450DtM1.Anno400,R450DtM1.Mese400,1);
  //with A077FGeneratoreStampe do
  with R003FGeneratoreStampeMW do
  begin
    //Inizializzo i dati annuali per evitare che vengano cumulati se il periodo è di più mesi
    if (Dato = 'BUONIMATURATITOTALI') or
       (Dato = 'BUONIACQUISTATITOTALI') or
       (Dato = 'TICKETMATURATITOTALI') or
       (Dato = 'TICKETACQUISTATITOTALI') then
      PutValore(i,DatiStampa[i].V,'0',Key,KeyTot,0,True);
    if Dato = 'INDPRESENZATOTALI' then
      PutValore(i,DatiStampa[i].V,FloatToStr(R450DtM1.IndPresTotali),Key,KeyTot,1,True)
    else if Dato = 'RIENTRIPOMTEORICIDOVUTI' then
      PutValore(i,DatiStampa[i].V,R450DtM1.LeggiValoreT077('RIENTRIPOM_TEORICI',D),Key,KeyTot,1,True)
    else if Dato = 'RIENTRIPOMREALIDOVUTI' then
      PutValore(i,DatiStampa[i].V,R450DtM1.LeggiValoreT077('RIENTRIPOM_REALI',D),Key,KeyTot,1,True)
    else if Dato = 'RIENTRIPOMRESI' then
      PutValore(i,DatiStampa[i].V,R450DtM1.LeggiValoreT077('RIENTRIPOM_RESI',D),Key,KeyTot,1,True)
    else if Dato = 'SALDORIENTRIPOM' then
      PutValore(i,DatiStampa[i].V,R450DtM1.LeggiValoreT077('RIENTRIPOM_SALDO',D),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTOMATURATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaMaturati),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTOVARIATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaVariati),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTOACQUISTATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaAcquistati),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTORESIDUI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaAcquistati - R450DtM1.BuoniMensaMaturati - R450DtM1.BuoniMensaVariati),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTORECUPERATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaRecuperati),Key,KeyTot,1,True)
    else if Dato = 'BUONIPASTOANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniMensaAnnoPrec),Key,KeyTot,0,True)
    else if Dato = 'TICKETMATURATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketMaturati),Key,KeyTot,1,True)
    else if Dato = 'TICKETVARIATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketVariati),Key,KeyTot,1,True)
    else if Dato = 'TICKETACQUISTATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketAcquistati),Key,KeyTot,1,True)
    else if Dato = 'TICKETRESIDUI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketAcquistati - R450DtM1.TicketMaturati - R450DtM1.TicketVariati),Key,KeyTot,1,True)
    else if Dato = 'TICKETRECUPERATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketRecuperati),Key,KeyTot,1,True)
    else if Dato = 'TICKETANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.TicketAnnoPrec),Key,KeyTot,0,True)
    else if Dato = 'NUMEROPASTI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.NumeroPastiConv + R450DtM1.NumeroPastiInteri),Key,KeyTot,1,True)
    else if Dato = 'PASTICONVENZIONATI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.NumeroPastiConv),Key,KeyTot,1,True)
    else if Dato = 'PASTIINTERI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.NumeroPastiInteri),Key,KeyTot,1,True)
    else if Dato = 'RESIDUOOREANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.OreAnnoPrec),Key,KeyTot,0,True)
    else if Dato = 'RESIDUOECCCOMPANNOPREC' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.EccCompAnnoPrec),Key,KeyTot,0,True)
    else if Dato = 'RESIDUOLIQUIDABILEAFINEANNO' then
      PutValore(i,DatiStampa[i].V,IntToStr(GetResiduoLiquidabileFineAnno(R450DtM1.Anno400)),Key,KeyTot,0,True)
    else if Dato = 'BUONIMATURATITOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniPastoAnno['BUONI_MAT']),Key,KeyTot,0,True)
    else if Dato = 'BUONIACQUISTATITOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniPastoAnno['BUONI_ACQ']),Key,KeyTot,0,True)
    else if Dato = 'TICKETMATURATITOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniPastoAnno['TICKET_MAT']),Key,KeyTot,0,True)
    else if Dato = 'TICKETACQUISTATITOTALI' then
      PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.BuoniPastoAnno['TICKET_ACQ']),Key,KeyTot,0,True)
    else if Dato = 'NOTEMATURAZBUONIPASTOTICKET' then
      PutValore(i,DatiStampa[i].V,R450DtM1.NoteBuoniMensaTicket,Key,KeyTot,0,True)
    else if Dato = 'FORNITURABUONIPASTOACQUISTATI' then
      PutValore(i,DatiStampa[i].V,DateToStr(R450DtM1.FornituraBuoniTicketAcquistati),Key,KeyTot,0,True)
    else if Dato = 'BLOCCHETTIACQUISTATI' then
      PutValore(i,DatiStampa[i].V,R450DtM1.BlocchettiAcquistati,Key,KeyTot,0,True);
  end;
end;

function TA077FGeneratoreStampeDtM.GetResiduoLiquidabileFineAnno(Anno:Integer):Integer;
var R450DtM2:TR450DtM1;
    Saldo,A,M,i,app:Integer;
  function EsisteScheda:Boolean;
  var t:Byte;
  begin
    Result:=False;
    for t:=Low(R450DtM2.ttrovscheda) to High(R450DtM2.ttrovscheda) do
      if R450DtM2.ttrovscheda[t] = 1 then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  Result:=0;
  A:=R180Anno(R003FGeneratoreStampeMW.AData);
  M:=R180Mese(R003FGeneratoreStampeMW.AData);
  if LiquidabileFineAnno.Progressivo <> C700Progressivo then
  begin
    LiquidabileFineAnno.Progressivo:=C700Progressivo;
    R450DtM2:=TR450DtM1.Create(nil);
    try
      //Conteggi del mese corrente
      R450DtM2.ConteggiMese('Generico',A,M,C700Progressivo);
      if EsisteScheda then
      begin
        SetLength(LiquidabileFineAnno.Anni,2);
        SetLength(LiquidabileFineAnno.Ore,2);
        LiquidabileFineAnno.Anni[0]:=A;
        //Liquidabile disponibile nell'anno in corso

        // VERIFICARE
        {
        if R450DtM2.PALimiteSaldoAtt and (R450DtM2.PALimite <> '') and (R450DtM2.salliqannoatt > R180OreMinutiExt(R450DtM2.PALimite)) then  //Lorena 08/08/2008
          LiquidabileFineAnno.Ore[0]:=R180OreMinutiExt(R450DtM2.PALimite)
        else
          LiquidabileFineAnno.Ore[0]:=R450DtM2.salliqannoatt;
        }
        LiquidabileFineAnno.Ore[0]:=min(R450DtM2.salliqannoatt,min(R450DtM2.PALimite,R450DtM2.PALimiteSaldoAtt));
        // VERIFICARE.FINE
        LiquidabileFineAnno.Anni[1]:=A - 1;
        //Ore ancora disponibili relative agli anni precedenti
        LiquidabileFineAnno.Ore[1]:=Max(0,R450DtM2.salliqannoprec + R450DtM2.salcompannoprec);
        i:=0;
        while A > R180Anno(R003FGeneratoreStampeMW.DaData) do
        begin
          dec(A);
          inc(i);
          //Conteggi a fine anno precedente
          R450DtM2.ConteggiMese('Generico',A,12,C700Progressivo);
          if not EsisteScheda then
            Break
          else
          begin
            // VERIFICARE
            {
            Saldo:=R450DtM2.salliqannoatt;           //Lorena 08/08/2008
            if R450DtM2.PALimiteSaldoAtt and (R450DtM2.PALimite <> '') and (Saldo > R180OreMinutiExt(R450DtM2.PALimite)) then  //Lorena 08/08/2008
              Saldo:=R180OreMinutiExt(R450DtM2.PALimite);
            }
            Saldo:=min(R450DtM2.salliqannoatt,min(R450DtM2.PALimite,R450DtM2.PALimiteSaldoAtt));
            // VERIFICARE.FINE
            SetLength(LiquidabileFineAnno.Anni,i + 2);
            SetLength(LiquidabileFineAnno.Ore,i + 2);
            LiquidabileFineAnno.Anni[i + 1]:=A - 1;
            app:=LiquidabileFineAnno.Ore[i]; //Saldo totale effettivo per l'anno conteggiato (saldo precedente conteggiato prima)
//            LiquidabileFineAnno.Ore[i]:=Min(app,R450DtM2.salliqannoatt);  //Liquidabile autorizzabile
            LiquidabileFineAnno.Ore[i]:=Min(app,Saldo);  //Liquidabile autorizzabile
            //Calcolo disponibilità per l'anno precedente togliendo dal saldo totale il liquidabile autorizzato,
            //e considerando all'interno del risultato i saldi dell'anno precedente
            LiquidabileFineAnno.Ore[i + 1]:=Max(0,Min(app - LiquidabileFineAnno.Ore[i],R450DtM2.salliqannoprec + R450DtM2.salcompannoprec));
          end;
        end;
      end;
    finally
      R450DtM2.Free;
    end;
  end;
  for i:=0 to High(LiquidabileFineAnno.Anni) do
    if LiquidabileFineAnno.Anni[i] = Anno then
    begin
      Result:=LiquidabileFineAnno.Ore[i];
      Break;
    end;
end;

procedure TA077FGeneratoreStampeDtM.GetRiepilogoPresenze(P:Integer;Dato:String);
{Lettura dati con R = 5}
var i,k,kc,T,NF:Integer;
    Key,KeyTot,S,KCNome:String;
    Trov,PrimaCausale,CodiceInKey:Boolean;
begin
  PrimaCausale:=True;
  for k:=0 to High(R450DtM1.RiepPres) do
    with R450DtM1.RiepPres[k] do
    begin
      //Trov = True se la causale di presenza è significativa
      Trov:=CompensabileAnno <> 0;
      for i:=1 to R450DtM1.NFasceMese do
        if (OreRese[i] <> 0) or (Liquidato[i] <> 0) then
        begin
          Trov:=True;
          Break;
        end;
      //Trov = True se la causale è stata richiesta nell'elenco
      if Trov and ElencoPresenze then
      begin
        Trov:=False;
        with A077FGeneratoreStampe.chklstPresenza do
          for i:=0 to Items.Count - 1 do
            if Checked[i] and (Causale = Trim(Copy(Items[i],1,5))) then
            begin
              Trov:=True;
              Break;
            end;
      end;
      if not Trov then
        Continue;
      //Costruzione della chiave di cumulo e di totalizzazione
      CodiceInKey:=False;
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(5)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          KCNome:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if KCNome = 'CODICEPRESENZE' then
          begin
            S:=Causale;
            CodiceInKey:=True;
          end
          else if KCNome = 'DATARIEPILOGOPRES' then
            S:=FormatDateTime('yyyymmdd',EncodeDate(R450DtM1.anno400,R450DtM1.mese400,1))
          else if KCNome = 'ANNORIEPILOGOPRES' then
            S:=IntToStr(R450DtM1.anno400);
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      NF:=StrToIntDef(Copy(Dato,Length(Dato),1),0);
      //Reinizializzo i dati annuali a ogni mese, per permettere il cumulo su più causali
      if (PrimaCausale or CodiceInKey) and (
         (Dato = 'PRESCOMPANNUEREGISTRATE') or
         (Dato = 'PRESCOMPANNUEEFFETTIVE') or
         (Copy(Dato,1,Length(Dato) - 1) = 'PRESENZEANNUEFASCIA') or
         (Dato = 'PRESENZEANNUETOTALI') or
         (Copy(Dato,1,Length(Dato) - 1) = 'PRESLIQUIDABILIFASCIA') or
         (Dato = 'PRESLIQUIDABILITOTALI') or
         (Copy(Dato,1,Length(Dato) - 1) = 'PRESLIQUIDANNUEFASCIA') or
         (Dato = 'PRESLIQUIDANNUETOTALI') or
         (Copy(Dato,1,Length(Dato) - 1) = 'PRESRESIDUEFASCIA') or
         (Dato = 'PRESRESIDUETOTALI') or
         (Dato = 'PRESRECUPERATANELLANNO')
         ) then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,'0',Key,KeyTot,0,True);
      if Dato = 'PROGRESSIVO2' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
      else if Dato = 'CODICEPRESENZE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,Causale,Key,KeyTot,0,True)
      else if Dato = 'DESCRIZIONEPRESENZE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,VarToStr(R003FGeneratoreStampeMW.Q275.Lookup('CODICE',Causale,'DESCRIZIONE')),Key,KeyTot,0,True)
      else if Dato = 'DATARIEPILOGOPRES' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,DateToStr(EncodeDate(R450DtM1.anno400,R450DtM1.mese400,1)),Key,KeyTot,0,True)
      else if Dato = 'ANNORIEPILOGOPRES' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(R450DtM1.anno400),Key,KeyTot,0,True)
      else if Dato = 'PRESCOMPREGISTRATE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(CompensabileMese),Key,KeyTot,1,True)
      else if Dato = 'PRESCOMPEFFETTIVE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(CompensabileMeseEff),Key,KeyTot,1,True)
      else if Dato = 'PRESCOMPANNUEREGISTRATE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(CompensabileAnno),Key,KeyTot,1,True)
      else if Dato = 'PRESCOMPANNUEEFFETTIVE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(CompensabileAnnoEff),Key,KeyTot,1,True)
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESENZEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(OreReseMese[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESENZETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,OreReseMese[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESENZEANNUEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(OreRese[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESENZEANNUETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,OreRese[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESLIQUIDABILIFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(Liquidabile[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESLIQUIDABILITOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,Liquidabile[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESLIQUIDATEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(LiquidatoMese[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESLIQUIDATETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,LiquidatoMese[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESLIQUIDANNUEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(Liquidato[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESLIQUIDANNUETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,Liquidato[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESRESIDUEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(Residuo[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESRESIDUETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,Residuo[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESPERSEFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(Abbattimento[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESPERSETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,Abbattimento[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if (Copy(Dato,1,Length(Dato) - 1) = 'PRESBANCAOREFASCIA') then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(OreBOMese[NF]),Key,KeyTot,1,True)
      else if Dato = 'PRESBANCAORETOTALI' then
      begin
        T:=0;
        for i:=1 to R450DtM1.NFasceMese do
          inc(T,OreBOMese[i]);
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(T),Key,KeyTot,1,True);
      end
      else if Dato = 'PRESRECUPERATANELMESE' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(RecuperoMese),Key,KeyTot,1,True)
      else if Dato = 'PRESRECUPERATANELLANNO' then
        PutValore(P,R003FGeneratoreStampeMW.DatiStampa[P].V,IntToStr(RecuperoAnno),Key,KeyTot,1,True);
      PrimaCausale:=False;
    end;
end;

procedure TA077FGeneratoreStampeDtM.GetAssenze;
{Lettura dati con R = 6,7,19}
var i:Word;
    x:Integer;
    K,DescK,Dato:String;
    G:TGiustificativo;
    TipoCumulo:Byte;
  procedure RiepilogaAssenze(RifDataNas:Boolean; DataNas:TDateTime);
  var UM,Key,KeyTot,S:String;
      QAss,QAssQM,HRese:Real;
      kc,j:Integer;
      Dal,Al:TDateTime;
    function DecodeUM(V,UM:String):String;
    begin
      if UM = 'O' then
        Result:=IntToStr(R180OreMinutiExt(V))
      else
        try Result:=FloatToStr(StrToFloat(V)); except Result:='0'; end;
    end;
    function Ore2Giorni(V,UM:String):String;
    begin
      if UM = 'G' then
        try Result:=FloatToStr(StrToFloat(V)); except Result:='0'; end
      else
        //try Result:=Format('%.2f',[R180OreMinutiExt(V)/R600Dtm1.ValenzaGiornaliera]); except Result:='0'; end;
        try Result:=Format('%.2f',[R600Dtm1.TrasformaOre2Giorni(R180OreMinutiExt(V))]); except Result:='0'; end;
    end;
    function Minuti2Giorni(V,UM:String):String;
    begin
      if UM = 'G' then
        try Result:=FloatToStr(StrToFloat(V)); except Result:='0'; end
      else
        //try Result:=Format('%.2f',[StrToFloat(V)/R600Dtm1.ValenzaGiornaliera]); except Result:='0'; end;
        try Result:=Format('%.2f',[R600Dtm1.TrasformaOre2Giorni(StrToFloat(V))]); except Result:='0'; end;
    end;
  begin
    with A077FGeneratoreStampe do
    begin
      Dal:=R003FGeneratoreStampeMW.DaData;
      Al:=R003FGeneratoreStampeMW.AData;
      if dchkPeriodoStorico.Checked then
      begin
        Dal:=Max(Dal,DipendenteCorrente.Dal);
        Al:=Min(Al,Dipendentecorrente.Al);
      end;
      QAss:=0;
      HRese:=0;
      QAssQM:=0;
      UM:='';
      DescK:=Trim(Copy(chklstAssenze.Items[i],6,40));
      if QuantAssenze then
        R600DtM1.GetQuantitaAssenze(C700Progressivo,Dal,Al,DataNas,G,UM,QAss,HRese);
      if QuantAssenzeQM then
        R600DtM1.GetQuantitaAssenzeQualMin(C700Progressivo,Dal,Al,DataNas,G,QAssQM);
      if CompAssenze then
      begin
        R600DtM1.GetAssenze(C700Progressivo,Dal,Al,DataNas,G);
        UM:=R600DtM1.UMisura;
      end;
      if RifDataNas then
      begin
        K:=G.Causale + '*' + R600DtM1.RiferimentoDataNascita.IDFamiliare;
        DescK:=R600DtM1.RiferimentoDataNascita.IDFamiliare + '*' + DescK;
      end;
      if (R600DtM1.ValCompTot = 0) and (StrToFloat(DecodeUM(R600DtM1.GetFruitoTot,UM)) = 0) and (QAss = 0) and (HRese = 0) and (QAssQM = 0) then
        exit;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(6)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'CODICEASSENZE' then
            S:=K
          else if Dato = 'MISURAASSENZE' then
            S:=UM
          else if Dato = 'DATARIEPILOGOASS' then
            S:=FormatDateTime('yyyymmdd',Al)
          else if Dato = 'INIZIOPERIODOCUMULO' then
            S:=FormatDateTime('yyyymmdd',R600DtM1.ptInizioCumulo)
          else if Dato = 'FINEPERIODOCUMULO' then
            S:=FormatDateTime('yyyymmdd',R600DtM1.ptFineCumulo);
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      for j:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      try
        if R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[j].N].R in [6,7,19] then
        begin
          if R003FGeneratoreStampeMW.DatiStampa[j].V = nil then
            R003FGeneratoreStampeMW.DatiStampa[j].V:=TList.Create;
          Dato:=UpperCase(R003FGeneratoreStampeMW.DatiStampa[j].D);
          if Dato = 'PROGRESSIVO3' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
          else if Dato = 'CODICEASSENZE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,K,Key,KeyTot,0,True)
          else if Dato = 'DESCRIZIONEASSENZE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DescK,Key,KeyTot,0,True)
          else if Dato = 'DATARIEPILOGOASS' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DateToStr(Al),Key,KeyTot,0,True)
          else if Dato = 'INIZIOPERIODOCUMULO' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DateToStr(R600DtM1.ptInizioCumulo),Key,KeyTot,0,True)
          else if Dato = 'FINEPERIODOCUMULO' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DateToStr(R600DtM1.ptFineCumulo),Key,KeyTot,0,True)
          else if Dato = 'MISURAASSENZE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,UM,Key,KeyTot,0,True)
          else if Dato = 'VALENZAGIORNALIERA' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,IntToStr(R600DtM1.ValenzaGiornaliera),Key,KeyTot,0,True)
          else if Dato = 'ASSENZEDELMESE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,FloatToStr(QAss),Key,KeyTot,1,True)
          else if Dato = 'ASSENZEDAQUALMIN' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,FloatToStr(QAssQM),Key,KeyTot,1,True)
          else if Dato = 'COMPASSANNOPREC' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetCompPrec,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPASSANNOCORR' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetCompCorr,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPASSTOTALI' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetCompTot,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSFRUITEANNOPREC' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetFruitoPrec,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSFRUITEANNOCORR' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetFruitoCorr,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSENZEFRUITE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetFruitoTot,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSRESIDUEANNOPREC' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetResiduoPrec,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSRESIDUEANNOCORR' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetResiduoCorr,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSENZERESIDUE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetResiduo,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'RESAORARIA' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,FloatToStr(HRese),Key,KeyTot,1,True)
          else if Dato = 'COMPETENZEPARZIALI' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetCompParz,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'RESIDUOPARZIALE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetResiduoParz,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPETENZEDELPERIODO' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,FloatToStr(R600DtM1.CompetenzeDelPeriodo),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'ASSENZEDELMESEINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Minuti2Giorni(FloatToStr(QAss),UM),Key,KeyTot,1,True)
          else if Dato = 'COMPINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetCompTot,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPASSANNOPRECINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetCompPrec,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPASSANNOCORRINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetCompCorr,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'FRUITOINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetFruitoTot,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'RESIDINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetResiduo,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPETENZEPARZIALIINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetCompParz,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'COMPETENZEDELPERIODOINGG' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Minuti2Giorni(FloatToStr(R600DtM1.CompetenzeDelPeriodo),UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'DATAFAMILIARE' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,IfThen(RifDataNas,DateTimeToStr(DataNas),''),Key,KeyTot,TipoCumulo,True)
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
          else if Dato = 'COMPASSINDIVID' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,DecodeUM(R600DtM1.GetCompAssIndivid,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'FRUITOINGGINDIVID' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetFruitoGGIndivid,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'RESIDINGGINDIVID' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetResiduoGGIndivid,UM),Key,KeyTot,TipoCumulo,True)
          // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
          // csi.ini
          else if Dato = 'VARIAZFRUIZMESIINTERI' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetVariazioneFruizMMInteri,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'VARIAZFRUIZMESIINTERIINDIVID' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetVariazioneFruizMMInteriDip,UM),Key,KeyTot,TipoCumulo,True)
          else if Dato = 'VARIAZMAXINDIVID' then
            PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Ore2Giorni(R600DtM1.GetVariazioneMaxIndividuale,UM),Key,KeyTot,TipoCumulo,True);
          // csi.fine
        end;
      except
      end;
    end;
  end;
begin
  with A077FGeneratoreStampe do
  begin
    //Verifica se è necessario calcolare le competenze del periodo specificato (rateo)
    R600DtM1.CalcolaCompetenzeDelPeriodo:=False;
    for x:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
      if (R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeMW.DatiStampa[x].N].R in [6,7]) and (UpperCase(R003FGeneratoreStampeMW.DatiStampa[x].D) = 'COMPETENZEDELPERIODO') then
      begin
        R600DtM1.CalcolaCompetenzeDelPeriodo:=True;
        Break;
      end;
    if dchkPeriodoStorico.Checked then
      TipoCumulo:=0
    else
      TipoCumulo:=1;
    //Se si considerano i periodi storici, la lettura delle assenze è effettuata su ogni periodo storico
    for i:=0 to chklstAssenze.Items.Count - 1 do
      if chklstAssenze.Checked[i] then
      begin
        K:=Trim(Copy(chklstAssenze.Items[i],1,5));
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=K;
        if R180CarattereDef(VarToStr(R003FGeneratoreStampeMW.Q265.Lookup('Codice',K,'Cumulo_Familiari')),1,'N') in ['S','D'] then
          with R600DtM1.selT040DataNas do
          begin
            Close;
            SetVariable('Progressivo',C700Progressivo);
            SetVariable('Causale',G.Causale);
            SetVariable('Data1',EncodeDate(1900,1,1));
            if dchkPeriodoStorico.Checked then
              SetVariable('Data2',Min(R003FGeneratoreStampeMW.AData,DipendenteCorrente.Al))
            else
              SetVariable('Data2',R003FGeneratoreStampeMW.AData);
            Open;
            while not Eof do
            begin
              RiepilogaAssenze(True,FieldByName('DataNas').AsDateTime);
              Next;
            end;
          end
        else
          RiepilogaAssenze(False,Date);
      end;
    R600DtM1.CalcolaCompetenzeDelPeriodo:=False;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetConteggiGiornalieri;
{Lettura dati con R = 8}
var Inizio,Fine,DataCorr:TDateTime;
    iCiclo,HighCiclo,kc:Integer;
    Dato,Key,KeyTot,S:String;
    BuonoPastoMaturato:Integer;
const RInterno = 8;
  procedure PutDatiGiornalieri;
  var j:Integer;
    procedure PutPrimoValore(Dato:String; Valido:Boolean);
    //Inserisce il valore solo nella prima riga. Le restanti viene inserito valore nullo o 0
    begin
      if iCiclo > 1 then
        Dato:='';
      PutValore(j,R003FGeneratoreStampeMW.DatiStampa[j].V,Dato,Key,KeyTot,R003FGeneratoreStampeMW.DatiStampa[j].F,Valido)
    end;
  begin
    with R003FGeneratoreStampeMW,R502ProDtM1 do
      for j:=0 to High(R003FGeneratoreStampeMW.DatiStampa) do
        try
          if R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].R = RInterno then
          begin
            if DatiStampa[j].V = nil then
              DatiStampa[j].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[j].D);
            if Dato = 'PROGRESSIVO4' then
              PutValore(j,DatiStampa[j].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'DATACONTEGGIO' then
              PutValore(j,DatiStampa[j].V,DateToStr(datacon),Key,KeyTot,DatiStampa[j].F,True)
            else if Dato = 'ANNOCONTEGGIO' then
              PutValore(j,DatiStampa[j].V,FormatDateTime('yyyy',datacon),Key,KeyTot,DatiStampa[j].F,True)
            else if Dato = 'MESECONTEGGIO' then
              PutValore(j,DatiStampa[j].V,FormatDateTime('mm',datacon),Key,KeyTot,DatiStampa[j].F,True)
            else if Dato = 'SETTIMANACONTEGGIO' then
              PutValore(j,DatiStampa[j].V,DateToStr(datacon + 1 - DayOfTheWeek(datacon)),Key,KeyTot,DatiStampa[j].F,True)
            else if Dato = 'RILEVATORIDELGIORNO' then
            begin
              if iCiclo - 1 <= High(telencorilev) then
                PutValore(j,DatiStampa[j].V,telencorilev[iCiclo - 1],Key,KeyTot,DatiStampa[j].F,True)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'TIMBRATURECONTEGGIATE' then
              PutPrimoValore(GetTimbratureCont(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),blocca = 0)
            else if Dato = 'TIMBRATURENOMINALI' then
              PutPrimoValore(GetTimbratureNom,blocca = 0)
            else if Dato = 'TIMBRATUREDIMENSA' then
              PutPrimoValore(TimbratureDiMensa,True)
            else if Dato = 'PASTOINTERO' then
              PutPrimoValore(IntToStr(R300DtM.PastiInt),True)
            else if Dato = 'PASTOCONVENZIONATO' then
              PutPrimoValore(IntToStr(R300DtM.PastiCon),True)
            else if Dato = 'BUONOPASTOMATURATO' then
              PutPrimoValore(IntToStr(BuonoPastoMaturato),True)
            else if Dato = 'GIUSTIFICATIVI' then
              PutPrimoValore(GetGiustificativi(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),blocca = 0)
            else if Dato = 'GGVUOTO' then
              PutPrimoValore(IntToStr(ggvuoto),blocca = 0)
            else if Dato = 'ESISTENZATIMBRATURE' then
              PutPrimoValore(IntToStr(ggpresenza),blocca = 0)
            else if Dato = 'ANOMALIABLOCCANTE' then
              PutPrimoValore(GetAnomaliaBloccante,True)
            else if Dato = 'MODELLOORARIO' then
              PutPrimoValore(c_orario,blocca = 0)
            else if Dato = 'TURNINONPIANIFICATI' then
              PutPrimoValore(Format('%2s%2s',[IntToStr(n_turno1),IntToStr(n_turno2)]),blocca = 0)
            else if Dato = 'TURNIPIANIFICATI' then
              PutPrimoValore(Format('%2s%2s',[IntToStr(c_turni1),IntToStr(c_turni2)]),blocca = 0)
            else if Dato = 'TURNIRICONOSCIUTI' then
              PutPrimoValore(Format('%2s%2s',[Copy(IntToStr(r_turno1),1,2),Copy(IntToStr(r_turno2),1,2)]),blocca = 0)
            else if Dato = 'SIGLATURNI' then
              PutPrimoValore(s_turno1 + s_turno2,blocca = 0)
            else if Dato = 'LIVELLOPIANIFICATO' then
              PutPrimoValore(PianGGLivello,True)
            else if Dato = 'INDENNITPIANIFICATE' then
              PutPrimoValore(PianGGIndPresenza,True)
            else if Dato = 'DEBITOGG' then
              PutPrimoValore(IntToStr(debitogg),blocca = 0)
            else if Dato = 'DEBITOCARTELLINO' then
              PutPrimoValore(IntToStr(debitorp),blocca = 0)
            else if Dato = 'DEBITOSETTIMANALE' then
              PutPrimoValore(R180MinutiOre(minmonteore),blocca = 0)
            else if Dato = 'GIORNILAVORATIVI' then
              PutPrimoValore(IntToStr(giornlav),blocca = 0)
            else if Dato = 'ECCEDENZACOMPENSABILE' then
              PutPrimoValore(IntToStr(EccSoloCompGG),blocca = 0)
            else if Dato = 'OREDAASSENZA' then
              PutPrimoValore(IntToStr(minassenze),blocca = 0)
            else if Dato = 'OREDIPRESENZALORDE' then
              PutPrimoValore(IntToStr(minpresenzelorde),blocca = 0)
            else if Dato = 'ORERESE' then
              PutPrimoValore(IntToStr(totlav),blocca = 0)
            else if Dato = 'ORERENDICONTABILI' then
              PutPrimoValore(IntToStr(OreRendicontabili),blocca = 0)
            else if Dato = 'SCOSTAMENTO' then
              PutPrimoValore(IntToStr(scost),blocca = 0)
            else if Dato = 'OREMATURATEPERPAUSAMENSA' then
              PutPrimoValore(IntToStr(paumencont),blocca = 0)
            else if Dato = 'DETRAZIONEPAUSAMENSA' then
              PutPrimoValore(IntToStr(paumendet),blocca = 0)
            else if Dato = 'ORERESEFUORIFASCIA' then
              PutPrimoValore(IntToStr(strgiorn),blocca = 0)
            else if Dato = 'OREESCLUSEDALLENORMALI' then
              PutPrimoValore(IntToStr(minlavesc),blocca = 0)
            else if Dato = 'OREOBBLIGATORIERESE' then
              PutPrimoValore(IntToStr(PresenzaObbligatoria),blocca = 0)
            else if Dato = 'OREOBBLIGATORIECARENTI' then
              PutPrimoValore(IntToStr(CarenzaObbligatoria),blocca = 0)
            else if Dato = 'OREFACOLTATIVERESE' then
              PutPrimoValore(IntToStr(PresenzaFacoltativa),blocca = 0)
            else if Dato = 'OREFACOLTATIVECARENTI' then
              PutPrimoValore(IntToStr(CarenzaFacoltativa),blocca = 0)
            else if Dato = 'CARENZAORARIACOPERTA' then
              PutPrimoValore(IntToStr(CoperturaCarenza),blocca = 0)
            else if Dato = 'GGLAVORATIVO' then
              PutPrimoValore(gglav,not(blocca in [4,21]))
            else if Dato = 'GGFESTIVO' then
              PutPrimoValore(tipogg,not(blocca in [4,21]))
            else if Dato = 'OREPERINDFESTIVA' then
              PutPrimoValore(IntToStr(minlavfes),blocca = 0)
            else if Dato = 'ORERESEDIMATTINA' then
              PutPrimoValore(IntToStr(minlavmat),blocca = 0)
            else if Dato = 'ORERESEDIPOMERIGGIO' then
              PutPrimoValore(IntToStr(minlavpom),blocca = 0)
            else if Dato = 'RIENTROPOMERIDIANO' then
              PutPrimoValore(IntToStr(RientroPomeridiano.Obbl + RientroPomeridiano.Suppl),blocca = 0)
            else if Dato = 'BUONOOBBLDARIENTROPOM' then
              PutPrimoValore(IntToStr(RientroPomeridiano.BuonoPastoObbl),blocca = 0)
            else if Dato = 'BUONOSUPPLDARIENTROPOM' then
              PutPrimoValore(IntToStr(RientroPomeridiano.BuonoPastoSuppl),blocca = 0)
            else if Dato = 'OREDIOGGIPERINDPRESENZA' then
              PutPrimoValore(IntToStr(minlavpresoggi),blocca = 0)
            else if Dato = 'OREDIIERIPERINDPRESENZA' then
              PutPrimoValore(IntToStr(minlavpresieri),blocca = 0)
            else if Dato = 'PRIMATIMBRATURAINUSCITA' then
              PutPrimoValore(primat_u,blocca = 0)
            else if Dato = 'ULTIMATIMBRATURAINENTRATA' then
              PutPrimoValore(ultimt_e,blocca = 0)
            else if Dato = 'ESISTETIMBRATURAPRECEDENTE' then
              PutPrimoValore(estimbprec,blocca = 0)
            else if Dato = 'ESISTETIMBRATURASUCCESSIVA' then
              PutPrimoValore(estimbsucc,blocca = 0)
            else if Dato = 'PAUSAMENSAGESTITA' then
              PutPrimoValore(paumenges,blocca = 0)
            else if Dato = 'TIPODETRPAUSAMENSA' then
              PutPrimoValore(TipoDetPaumen,blocca = 0)
            else if Dato = 'INIZIOPAUSAMENSA' then
            begin
              if Length(TimbratureMensa) > 0 then
                PutPrimoValore(IntToStr(TimbratureMensa[0].I),blocca = 0)
              else
                PutPrimoValore('0',blocca = 0)
            end
            else if Dato = 'FINEPAUSAMENSA' then
            begin
              if Length(TimbratureMensa) > 0 then
                PutPrimoValore(IntToStr(TimbratureMensa[0].F),blocca = 0)
              else
                PutPrimoValore('0',blocca = 0)
            end
            else if Dato = 'OREDATIMBRATURE' then
              PutPrimoValore(IntToStr(totlav - minassenze),blocca = 0)
            else if Dato = 'INDPRESDAASSENZA' then
              PutPrimoValore(indpresdaass,blocca = 0)
            else if Dato = 'GGINSERVIZIO' then
              PutPrimoValore(IntToStr(gginser),blocca = 0)
            else if Dato = 'GGLAVINSERVIZIO' then
              PutPrimoValore(IntToStr(gglavser),blocca = 0)
            else if Dato = 'SCOSTAMENTONEGATIVO' then
              PutPrimoValore(IntToStr(scostneg),(blocca = 0) and (scost < 0))
            else if Dato = 'SCOSTAMENTOPOSITIVO' then
              PutPrimoValore(GetScostamentoPositivo,(blocca = 0) and (scost >= 0))
            else if Dato = 'ABBATTIMENTOANNOPREC' then
              PutPrimoValore(IntToStr(abbannoprec),blocca = 0)
            else if Dato = 'ABBATTIMENTOANNOATT' then
              PutPrimoValore(IntToStr(abbannoatt),blocca = 0)
            else if Dato = 'GGDIPRESENZA' then
              PutPrimoValore(IntToStr(ggpres),blocca = 0)
            else if Dato = 'PRESENZAPOMERIDIANA' then
              PutPrimoValore(IntToStr(ggpomer),blocca = 0)
            else if Dato = 'INDPRESENZAMATURATA' then
              PutPrimoValore(FloatToStr(tindennitapresenza[1].tindpres + tindennitapresenza[2].tindpres + tindennitapresenza[3].tindpres),blocca = 0)
            else if Dato = 'INDFESTIVAMATURATA' then
              PutPrimoValore(FloatToStr(indfesint + (indfesrid / 2)),blocca = 0)
            else if Dato = 'SCAVALCOMEZZANOTTE' then
              PutPrimoValore(IntToStr(indnotgg),blocca = 0)
            else if Dato = 'INDNOTTURNAMATURATA' then
              PutPrimoValore(IntToStr(indnotmin),blocca = 0)
            else if Dato = 'FESTIVITANONGODUTA' then
              PutPrimoValore(IntToStr(FestivoNonGoduto),blocca = 0)
            else if Dato = 'TIMBRATUREEFFETTIVE' then
              PutPrimoValore(GetTimbratureEffettive(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),True)
            else if Dato = 'ORELIQUIDABILI' then
              PutPrimoValore(GetOreLiquidabili,blocca = 0)
            else if Dato = 'RIEPILOGOORECAUSALIZZATE' then
              PutPrimoValore(GetRiepilogoOreCausalizzate,blocca = 0)
            else if Dato = 'RIEPILOGOOREASSENZA' then
              PutPrimoValore(GetRiepilogoOreAssenza,blocca = 0)
            else if Dato = 'OREDIPRESENZACAUSALIZZATE' then
              PutPrimoValore(GetOreDiPresenzaCausalizzate(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt,Key,KeyTot),blocca = 0)
            else if Dato = 'ORECAUSABLOCCHI' then
              PutPrimoValore(GetOreCausABlocchi,blocca = 0)
            else if Dato = 'OREDIASSENZACAUSALIZZATE' then
              PutPrimoValore(GetOreDiAssenzaGG(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt,Key,KeyTot,'VALASSE'),blocca = 0)
            else if Dato = 'OREDIASSENZARESE' then
              PutPrimoValore(GetOreDiAssenzaGG(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt,Key,KeyTot,'RESASSE'),blocca = 0)
            else if Dato = 'OREDIASSENZAPERCOMPETENZE' then
              PutPrimoValore(GetOreDiAssenzaGG(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt,Key,KeyTot,'COMPASSE'),blocca = 0)
            else if (Dato = 'ORERESE1') or (Dato = 'ORERESE2') or (Dato = 'ORERESE3') or (Dato = 'ORERESE4') then
              PutPrimoValore(GetOreReseInFascia(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),blocca = 0)
            else if (Dato = 'ORELIQUIDABILI1') or (Dato = 'ORELIQUIDABILI2') or
                    (Dato = 'ORELIQUIDABILI3') or (Dato = 'ORELIQUIDABILI4') then
              PutPrimoValore(GetOreLiquidabiliInFascia(R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),blocca = 0)
            else if Dato = 'OREINDTURNO' then
              PutPrimoValore(IntToStr(R180SommaArray(tindturfas)),blocca = 0)
            else if (Dato = 'OREINDTURNO1') or (Dato = 'OREINDTURNO2') or
                    (Dato = 'OREINDTURNO3') or (Dato = 'OREINDTURNO4') then
              PutPrimoValore(GetOreInFascia(tindturfas,R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),blocca = 0)
            else if Dato = 'TURNIREPERIBILITA' then
              PutPrimoValore(TurniExtraPianificati['C'],True)
            else if Dato = 'TURNIREPERIBLIVPIANIF' then
              PutPrimoValore(PianRepLivello,True)
            else if Dato = 'PROLUNGAMENTOINIBITO' then
              PutPrimoValore(IntToStr(ProlungamentoInibito['']),blocca = 0)
            else if Dato = 'PROLUNGAMENTOINEINIBITO' then
              PutPrimoValore(IntToStr(ProlungamentoInibito['E']),blocca = 0)
            else if Dato = 'PROLUNGAMENTOINUINIBITO' then
              PutPrimoValore(IntToStr(ProlungamentoInibito['U']),blocca = 0)
            else if Dato = 'PROLUNGAMENTONONCAUSALIZZ' then
              PutPrimoValore(IntToStr(ProlungamentoNonCausalizzato['']),blocca = 0)
            else if Dato = 'PROLUNGAMENTOINENONCAUSALIZZ' then
              PutPrimoValore(IntToStr(ProlungamentoNonCausalizzato['E']),blocca = 0)
            else if Dato = 'PROLUNGAMENTOINUNONCAUSALIZZ' then
              PutPrimoValore(IntToStr(ProlungamentoNonCausalizzato['U']),blocca = 0)
            else if Dato = 'PROLUNGAMENTOINUSCITANONCAUS' then
              PutPrimoValore(IntToStr(ProlungamentoNonCausUscita),blocca = 0)
            else if Dato = 'PROLUNGAMENTONONCONTEGGIATO' then
              PutPrimoValore(IntToStr(ProlungamentoInibito[''] + ProlungamentoNonCausalizzato['']),blocca = 0)
            else if Dato = 'LIBERAPROFESSIONE' then
              PutPrimoValore(GetLiberaProfessione,blocca = 0)
            else if Dato = 'RILEVATORE' then
            begin
              if iCiclo - 1 <= High(trieprilev) then
                PutValore(j,DatiStampa[j].V,trieprilev[iCiclo - 1].rilevatore,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'RILEVATOREORERESE' then
            begin
              if iCiclo - 1 <= High(trieprilev) then
                PutValore(j,DatiStampa[j].V,IntToStr(trieprilev[iCiclo - 1].tminprestot),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'ASSENZACAUSALE') then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,triepgiusasse[iCiclo].tcausasse,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'ASSENZADESCRIZIONE') then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,VarToStr(R003FGeneratoreStampeMW.Q265.Lookup('CODICE',triepgiusasse[iCiclo].tcausasse,'DESCRIZIONE')),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'ASSENZANOTE') then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,GetNoteGiustificativo(triepgiusasse[iCiclo]),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'ASSENZADATAFAMILIARE') then
            begin
              if iCiclo <= n_riepasse then
                //PutValore(j,DatiStampa[j].V,IfThen(DataFamiliare[triepgiusasse[iCiclo].tcausasse] = 0,'',DateTimeToStr(DataFamiliare[triepgiusasse[iCiclo].tcausasse])),Key,KeyTot,DatiStampa[j].F,blocca = 0)
                PutValore(j,DatiStampa[j].V,IfThen(triepgiusasse[iCiclo].DataFamiliare = 0,'',DateTimeToStr(triepgiusasse[iCiclo].DataFamiliare)),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'ASSENZAUMFRUIZIONE') then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,triepgiusasse[iCiclo].ttipofruiz,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);                
            end
            else if Dato = 'ASSENZAORERESE' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,IntToStr(triepgiusasse[iCiclo].tminresasse),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'ASSENZAOREVALENZA' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,IntToStr(triepgiusasse[iCiclo].tminvalasse),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'ASSENZAFRUIZCOMPETENZE' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,IntToStr(triepgiusasse[iCiclo].tminvalcompasse),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'ASSENZAGIORNATE' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,FloatTostr(triepgiusasse[iCiclo].tggasse + triepgiusasse[iCiclo].tmezggasse/2),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'ASSENZAFRUIZIONE' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,triepgiusasse[iCiclo].ttipofruiz,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'ASSENZATIPOMG' then
            begin
              if iCiclo <= n_riepasse then
                PutValore(j,DatiStampa[j].V,triepgiusasse[iCiclo].ttipomg,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'PRESENZACAUSALE' then
            begin
              if iCiclo <= n_rieppres then
                PutValore(j,DatiStampa[j].V,triepgiuspres[iCiclo].tcauspres,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'PRESENZADESCRIZIONE' then
            begin
              if iCiclo <= n_rieppres then
                PutValore(j,DatiStampa[j].V,VarToStr(R003FGeneratoreStampeMW.Q275.Lookup('CODICE',triepgiuspres[iCiclo].tcauspres,'DESCRIZIONE')),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'PRESENZAORERESE' then
            begin
              if iCiclo <= n_rieppres then
                PutValore(j,DatiStampa[j].V,GetPresenzaOreRese(iCiclo),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if (Dato = 'PRESENZAORERESE1') or (Dato = 'PRESENZAORERESE2') or (Dato = 'PRESENZAORERESE3') or (Dato = 'PRESENZAORERESE4') then
            begin
              if iCiclo <= n_rieppres then
                PutValore(j,DatiStampa[j].V,GetPresenzaOreReseFascia(iCiclo,R003FGeneratoreStampeMW.Dati[DatiStampa[j].N].Fmt),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,blocca = 0);
            end
            else if Dato = 'LIBERAPROFESSIONECAUSALE' then
            begin
              if iCiclo - 1 <= High(RiepLibProf) then
                PutValore(j,DatiStampa[j].V,RiepLibProf[iCiclo - 1].Causale,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'LIBERAPROFESSIONEDESCRIZIONE' then
            begin
              if iCiclo - 1 <= High(RiepLibProf) then
                PutValore(j,DatiStampa[j].V,RiepLibProf[iCiclo - 1].Descrizione,Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'LIBERAPROFESSIONEOREPIANIF' then
            begin
              if iCiclo - 1 <= High(RiepLibProf) then
                PutValore(j,DatiStampa[j].V,IntToStr(RiepLibProf[iCiclo - 1].OrePianificate),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'LIBERAPROFESSIONEORERESE' then
            begin
              if iCiclo - 1 <= High(RiepLibProf) then
                PutValore(j,DatiStampa[j].V,IntToStr(RiepLibProf[iCiclo - 1].OreRese),Key,KeyTot,DatiStampa[j].F,blocca = 0)
              else
                PutValore(j,DatiStampa[j].V,'0',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'ANOMALIEGGID' then
            begin
              if iCiclo <= lstAnomalieGG.Count then
                PutValore(j,DatiStampa[j].V,lstAnomalieGG[iCiclo - 1].ID,Key,KeyTot,DatiStampa[j].F,True)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'ANOMALIEGGLIVELLO' then
            begin
              if iCiclo <= lstAnomalieGG.Count then
                PutValore(j,DatiStampa[j].V,lstAnomalieGG[iCiclo - 1].Livello.ToString,Key,KeyTot,DatiStampa[j].F,True)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'ANOMALIEGGNUMERO' then
            begin
              if iCiclo <= lstAnomalieGG.Count then
                PutValore(j,DatiStampa[j].V,lstAnomalieGG[iCiclo - 1].Num.ToString,Key,KeyTot,DatiStampa[j].F,True)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            else if Dato = 'ANOMALIEGGDESCRIZIONE' then
            begin
              if iCiclo <= lstAnomalieGG.Count then
                PutValore(j,DatiStampa[j].V,lstAnomalieGG[iCiclo - 1].Descrizione,Key,KeyTot,DatiStampa[j].F,True)
              else
                PutValore(j,DatiStampa[j].V,'',Key,KeyTot,DatiStampa[j].F,True);
            end
            ;
          end;
        except
        end;
  end;
begin
  //Inizializzo i conteggi cambiando il progressivo: necessario se i conteggi vengono prima chiamati dalle assenze
  R502ProDtM1.QProgressivo:= -1;
  R502ProDtM1.ConsideraRichiesteWeb:=Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (Q910.FieldByName('CODICE').AsString <> 'SISPAC');
  R502ProDtM1.GiustDistFamiliari:=R003FGeneratoreStampeMW.EsisteDatoStampa('ASSENZADATAFAMILIARE') >= 0;
  R502ProDtM1.PeriodoConteggi(R003FGeneratoreStampeMW.DaData,R003FGeneratoreStampeMW.AData);
  if (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOINTERO') >= 0) or (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOCONVENZIONATO') >= 0) then
    R300DtM.SettaPeriodo(R003FGeneratoreStampeMW.DaData,R003FGeneratoreStampeMW.AData);
  if R003FGeneratoreStampeMW.EsisteDatoStampa('BUONOPASTOMATURATO') >= 0 then
    R350DtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,C700Progressivo,R180InizioMese(R003FGeneratoreStampeMW.DaData),R180FineMese(R003FGeneratoreStampeMW.AData));
  if not A077FGeneratoreStampe.dchkPeriodoStorico.Checked then
  begin
    Inizio:=R003FGeneratoreStampeMW.DaData;
    Fine:=R003FGeneratoreStampeMW.AData;
  end
  else
  begin
    Inizio:=Max(R003FGeneratoreStampeMW.DaData,DipendenteCorrente.Dal);
    Fine:=Min(R003FGeneratoreStampeMW.AData,DipendenteCorrente.Al);
  end;
  DataCorr:=Inizio;
  while DataCorr <= Fine do
  begin
    //Imposto il numero di sottodettagli a seconda di quanto specificato
    R502ProDtM1.Conteggi('Cartolina',C700Progressivo,DataCorr);
    if Parametri.ModuloInstallato['CONTEGGIO_PASTI'] and
       ((R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOINTERO') >= 0) or (R003FGeneratoreStampeMW.EsisteDatoStampa('PASTOCONVENZIONATO') >= 0)) then
      R300DtM.ConteggiaPasti(C700Progressivo,DataCorr);
    if Parametri.ModuloInstallato['BUONI_PASTO'] and
       (R003FGeneratoreStampeMW.EsisteDatoStampa('BUONOPASTOMATURATO') >= 0) then
      BuonoPastoMaturato:=R350DtM.GetMaturazioneGG(C700Progressivo,DataCorr);
    HighCiclo:=1;
    with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
      for kc:=0 to High(KeyCumulo) do
      begin
        Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
        if Dato = 'RILEVATORIDELGIORNO' then
          HighCiclo:=max(HighCiclo,Length(R502ProDtM1.telencorilev))
        else if Dato = 'RILEVATORE' then
          HighCiclo:=max(HighCiclo,Length(R502ProDtM1.trieprilev))
        else if Dato = 'PRESENZACAUSALE' then
          HighCiclo:=max(HighCiclo,R502ProDtM1.n_rieppres)
        else if Dato = 'ASSENZACAUSALE' then
          HighCiclo:=max(HighCiclo,R502ProDtM1.n_riepasse)
        else if Dato = 'LIBERAPROFESSIONECAUSALE' then
          HighCiclo:=max(HighCiclo,Length(R502ProDtM1.RiepLibProf))
        else if Dato = 'ANOMALIEGGID' then
          HighCiclo:=max(HighCiclo,R502ProDtM1.lstAnomalieGG.Count)
        ;
      end;
    if HighCiclo = 0 then
      HighCiclo:=1;

    //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
    with A077FGeneratoreStampe do
      if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
      begin
        DipendenteCorrente.DettaglioPeriodicoDal:=DataCorr;
        DipendenteCorrente.DettaglioPeriodicoAl:=DataCorr;
      end;
    if not PeriodoStoricoValido(RInterno) then
    begin
      DataCorr:=DataCorr + 1;
      Continue;
    end;

    //Ciclo del sottodettaglio
    for iCiclo:=1 to HighCiclo do
    begin
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          S:='';
          if Dato = 'DATACONTEGGIO' then
            S:=FormatDateTime('yyyymmdd',R502ProDtM1.datacon)
          else if Dato = 'ANNOCONTEGGIO' then
            S:=FormatDateTime('yyyy',R502ProDtM1.datacon)
          else if Dato = 'MESECONTEGGIO' then
            S:=FormatDateTime('mm',R502ProDtM1.datacon)
          else if Dato = 'SETTIMANACONTEGGIO' then
            S:=FormatDateTime('yyyymmdd',R502ProDtM1.datacon + 1 - DayOfTheWeek(R502ProDtM1.datacon))
          else if (Dato = 'RILEVATORIDELGIORNO') and (iCiclo - 1 <= High(R502ProDtM1.telencorilev)) then
            S:=R502ProDtM1.telencorilev[iCiclo - 1]
          else if Dato = 'GGLAVORATIVO' then
            S:=R502ProDtM1.gglav
          else if Dato = 'GGFESTIVO' then
            S:=R502ProDtM1.tipogg
          else if Dato = 'ANOMALIABLOCCANTE' then
            S:=GetAnomaliaBloccante
          else if Dato = 'MODELLOORARIO' then
            S:=R502ProDtM1.c_orario
          else if (Dato = 'RILEVATORE') and (iCiclo - 1 <= High(R502ProDtM1.trieprilev)) then
            S:=R502ProDtM1.trieprilev[iCiclo - 1].rilevatore
          else if (Dato = 'ASSENZACAUSALE') and (iCiclo <= R502ProDtM1.n_riepasse) then
            S:=R502ProDtM1.triepgiusasse[iCiclo].tcausasse
          else if (Dato = 'ASSENZADATAFAMILIARE') and (iCiclo <= R502ProDtM1.n_riepasse) then
            //S:=IfThen(R502ProDtM1.DataFamiliare[R502ProDtM1.triepgiusasse[iCiclo].tcausasse] = 0,'',DateTimeToStr(R502ProDtM1.DataFamiliare[R502ProDtM1.triepgiusasse[iCiclo].tcausasse]))
            S:=IfThen(R502ProDtM1.triepgiusasse[iCiclo].DataFamiliare = 0,'',DateTimeToStr(R502ProDtM1.triepgiusasse[iCiclo].DataFamiliare))
          else if (Dato = 'PRESENZACAUSALE') and (iCiclo <= R502ProDtM1.n_rieppres) then
            S:=R502ProDtM1.triepgiuspres[iCiclo].tcauspres
          else if (Dato = 'LIBERAPROFESSIONECAUSALE') and (iCiclo - 1 <= High(R502ProDtM1.RiepLibProf)) then
            S:=R502ProDtM1.RiepLibProf[iCiclo - 1].Causale
          else if (Dato = 'ANOMALIEGGID') and (iCiclo <= R502ProDtM1.lstAnomalieGG.Count) then
            S:=R502ProDtM1.lstAnomalieGG[iCiclo - 1].Id
          ;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      PutDatiGiornalieri;
    end;
    DataCorr:=DataCorr + 1;
  end;
end;

function TA077FGeneratoreStampeDtM.FormattaTimbratura(Timbratura,Causale,Rilevatore,Fmt:String):String;
{Formatta la timbratura in base a Fmt dove:
  T = Verso + Timbratura
  C = Causale (Partendo da destra)
  R = Rilevatore (Partendo da destra)
  S = Sigla causale (Partendo da destra)}
var i,j,L:Word;
    T,C,S,R:Boolean;
    Sigla:String;
begin
  Result:=Timbratura;
  if (Fmt = '') or (Fmt = 'T') then exit;
  Result:='';
  T:=False;
  C:=False;
  S:=False;
  R:=False;
  for i:=1 to Length(Fmt) do
  begin
    if (Fmt[i] in [' ','-','_','/','\','|',',','.',':',';','*','+']) then
      Result:=Result + Fmt[i];
    if (Fmt[i] = 'T') and (not T) then
    begin
      Result:=Result + Timbratura;
      T:=True;
    end;
    if (Fmt[i] = 'C') and (not C) then
    begin
      C:=True;
      L:=1;
      for j:=i + 1 to Length(Fmt) do
        if Fmt[j] = 'C' then
          inc(L);
      Result:=Result + Format('%-*s',[L,Copy(Causale,Length(Causale) - L + 1,L)]);
    end;
    if (Fmt[i] = 'R') and (not R) then
    begin
      R:=True;
      L:=1;
      for j:=i + 1 to Length(Fmt) do
        if Fmt[j] = 'R' then
          inc(L);
      Result:=Result + Format('%-*s',[L,Copy(Rilevatore,Length(Rilevatore) - L + 1,L)]);
    end;
    if (Fmt[i] = 'S') and (not S) then
    begin
      S:=True;
      L:=1;
      for j:=i + 1 to Length(Fmt) do
        if Fmt[j] = 'S' then
          inc(L);
      Sigla:=VarToStr(Q275U305.Lookup('CODICE',Causale,'SIGLA'));
      Result:=Result + Format('%-*s',[L,Copy(Sigla,Length(Sigla) - L + 1,L)]);
    end;
  end;
end;

function TA077FGeneratoreStampeDtM.GetTimbratureEffettive(Fmt:String):String;
{Timbrature lette da T100_TIMBRATURE}
var i:Integer;
    S:String;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=0 to High(TimbratureDelGiorno) do
      if TimbratureDelGiorno[i].tversotimb <> '' then
      begin
        if Result <> '' then
          Result:=Result + ' ';
        S:=TimbratureDelGiorno[i].tversotimb + R180MinutiOre(TimbratureDelGiorno[i].toratimb);
        Delete(S,Pos('.',S),1);
        Result:=Result + FormattaTimbratura(S,
                                            TimbratureDelGiorno[i].tcaustimb,
                                            TimbratureDelGiorno[i].trilevtimb,
                                            Fmt);
      end;
end;

function TA077FGeneratoreStampeDtM.GetTimbratureCont(Fmt:String):String;
{Timbrature elaborate e conteggiate da R502Pro}
var i:Integer;
    S:String;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=1 to n_timbrcon do
    begin
      if Result <> '' then
        Result:=Result + ' ';
      S:='E' + R180MinutiOre(ttimbraturecon[i].tminutic_e);
      Delete(S,Pos('.',S),1);
      Result:=Result + FormattaTimbratura(S,
                                          ttimbraturecon[i].tcaus,
                                          ttimbraturecon[i].trilev_e,
                                          Fmt);
      S:=' U' + R180MinutiOre(ttimbraturecon[i].tminutic_u);
      Delete(S,Pos('.',S),1);
      Result:=Result + FormattaTimbratura(S,
                                          ttimbraturecon[i].tcaus,
                                          ttimbraturecon[i].trilev_u,
                                          Fmt);
    end;
end;

function TA077FGeneratoreStampeDtM.GetTimbratureNom:String;
{Timbrature nominali del modello orario}
var i:Integer;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=1 to n_timbrnom do
    begin
      if Result <> '' then
        Result:=Result + ' ';
      Result:=Result + 'E' + R180MinutiOre(ttimbraturenom[i].tminutin_e) + ' U' + R180MinutiOre(ttimbraturenom[i].tminutin_u);
    end;
  while Pos('.',Result) > 0 do
    Delete(Result,Pos('.',Result),1);
end;

function TA077FGeneratoreStampeDtM.FormattaGiustificativo(Codice,Fmt:String):String;
{Formatta il giustificativo in base a Fmt dove
  Cxx = Codice lungo al massimo xx
  Dxx = Descrizionelunga al massimo xx}
var L:Integer;
begin
  Result:=Codice;
  if (Fmt = '') or (Fmt = 'C') then exit;
  Result:='';
  if Fmt[1] = 'C' then
    Result:=Codice
  else
    Result:=VarToStr(R003FGeneratoreStampeMW.Q265.Lookup('CODICE',Codice,'DESCRIZIONE'));
  L:=StrToIntDef(Copy(Fmt,2,2),0);
  if L > 0 then
    Result:=Copy(Result,1,L);
end;

function TA077FGeneratoreStampeDtM.GetGiustificativi(Fmt:String):String;
{Giustificativi letti da T040_GIUSTIFICATIVI}
var i:Integer;
    S:String;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=0 to High(GiustificativiDelGiorno) do
      if GiustificativiDelGiorno[i].tcausgius <> '' then
      begin
        case GiustificativiDelGiorno[i].ttipogius of
          'I':S:='GG:' + FormattaGiustificativo(GiustificativiDelGiorno[i].tcausgius,Fmt);
          'M':S:='MG:' + FormattaGiustificativo(GiustificativiDelGiorno[i].tcausgius,Fmt);
          'N':begin
              S:=R180MinutiOre(GiustificativiDelGiorno[i].tdallegius);
              Delete(S,Pos('.',S),1);
              S:=S + ':' + FormattaGiustificativo(GiustificativiDelGiorno[i].tcausgius,Fmt);
              end;
          'D':begin
              S:=R180MinutiOre(GiustificativiDelGiorno[i].tdallegius);
              Delete(S,Pos('.',S),1);
              S:=S + '-' + R180MinutiOre(GiustificativiDelGiorno[i].tallegius);
              Delete(S,Pos('.',S),1);
              S:=S + ':' + FormattaGiustificativo(GiustificativiDelGiorno[i].tcausgius,Fmt);
              end;
        end;
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + S;
      end;
end;

function TA077FGeneratoreStampeDtM.GetAnomaliaBloccante:String;
{Descrizione dell'anomalia bloccante}
begin
  Result:='';
  if R502ProDtM1.blocca > 0 then
    Result:=tdescanom1[R502ProDtM1.blocca].D;
end;

function TA077FGeneratoreStampeDtM.GetScostamentoPositivo:String;
begin
  Result:='0';
  if R502ProDtM1.scost >= 0 then
    Result:=IntToStr(R502ProDtM1.scost);
end;

function TA077FGeneratoreStampeDtM.GetOreLiquidabili:String;
var i,T:Integer;
begin
  Result:='0';
  T:=0;
  with R502ProDtM1 do
    for i:=1 to n_fasce do
      T:=T + tminstrgio[i];
  Result:=IntToStr(T);
end;

function TA077FGeneratoreStampeDtM.GetRiepilogoOreCausalizzate:String;
{Elenco delle ore causalizzate in presenza}
var i,j,T:Integer;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=1 to n_rieppres do
    begin
      if triepgiuspres[i].tcauspres = '' then Continue;
      if Result <> '' then
        Result:=Result + ' ';
      Result:=Result + triepgiuspres[i].tcauspres + ':';
      T:=0;
      for j:=1 to n_fasce do
        T:=T + triepgiuspres[i].tminpres[j];
      Result:=Result + R180MinutiOre(T);
    end;
end;

function TA077FGeneratoreStampeDtM.GetRiepilogoOreAssenza:String;
{Elenco delle assenze}
var i:Integer;
begin
  Result:='';
  with R502ProDtM1 do
    for i:=1 to n_riepasse do
    begin
      if Result <> '' then
        Result:=Result + ' ';
      Result:=Result + triepgiusasse[i].tcausasse + ':' + R180MinutiOre(triepgiusasse[i].tminvalasse);
    end;
end;

function TA077FGeneratoreStampeDtM.GetOreDiPresenzaCausalizzate(Fmt,Key,KeyTot:String):String;
{Ore di presenza causalizzate con le causali specificate in Fmt: * = tutto
 Valorizza anche l'eventuale dato CAUSALIPRESENZA}
var i,j,T:Integer;
    L:TStringList;
    Inclusa:Boolean;
begin
  Result:='0';
  T:=0;
  Inclusa:=True;
  if Copy(Fmt,1,2) = '*-' then
  begin
    Fmt:=Trim(Copy(Fmt,3,Length(Fmt)));
    Inclusa:=False;
  end;
  if Fmt = '' then
    Fmt:='*';
  L:=TStringList.Create;
  L.CommaText:=Fmt;
  with R502ProDtM1 do
    for i:=1 to n_rieppres do
    begin
      if triepgiuspres[i].tcauspres = '' then Continue;
      if (Inclusa and ((L.IndexOf('*') >= 0) or (L.IndexOf(triepgiuspres[i].tcauspres) >= 0))) or
         (not Inclusa and (L.IndexOf(triepgiuspres[i].tcauspres) < 0)) then
        for j:=1 to n_fasce do
          T:=T + triepgiuspres[i].tminpres[j];
    end;
  Result:=IntToStr(T);
  L.Free;
  with R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
      if UpperCase(DatiStampa[i].D) = 'CAUSALIPRESENZA' then
        PutValore(i,DatiStampa[i].V,Fmt,Key,KeyTot,0,(T > 0));
end;

function TA077FGeneratoreStampeDtM.GetOreCausABlocchi:String;
//Ore causalizzate in fasce a blocchi
var i:Integer;
    L:TStringList;
    S:String;
begin
  Result:='';
  L:=TStringList.Create;
  with R502ProDtM1 do
    for i:=0 to High(FascePaghe276) do
    begin
      if FascePaghe276[i].VocePaghe = '' then
        Break;
      L.Add(FascePaghe276[i].VocePaghe + '=' + R180MinutiOre(FascePaghe276[i].Ore));
    end;
  L.Sort;
  S:='';
  for i:=0 to L.Count - 1 do
  begin
    if S <> '' then
      S:=S + ' ';
    S:=S + L[i];
  end;
  L.Free;
  Result:=S;
end;

function TA077FGeneratoreStampeDtM.GetOreDiAssenzaGG(Fmt,Key,KeyTot,TipoOre:String):String;
{Ore di Assenza causalizzate con le causali specificate in Fmt: * = tutto
 Valorizza anche l'eventuale dato CAUSALIASSENZA}
var i,T:Integer;
    L:TStringList;
    Inclusa:Boolean;
begin
  Result:='0';
  T:=0;
  Inclusa:=True;
  if Copy(Fmt,1,2) = '*-' then
  begin
    Fmt:=Trim(Copy(Fmt,3,Length(Fmt)));
    Inclusa:=False;
  end;
  if Fmt = '' then
    Fmt:='*';
  L:=TStringList.Create;
  L.CommaText:=Fmt;
  with R502ProDtM1 do
    for i:=1 to n_riepasse do
      if (Inclusa and ((L.IndexOf('*') >= 0) or (L.IndexOf(triepgiusasse[i].tcausasse) >= 0))) or
         (not Inclusa and (L.IndexOf(triepgiusasse[i].tcausasse) < 0)) then
      begin
        if TipoOre = 'VALASSE' then
          T:=T + triepgiusasse[i].tminvalasse
        else
          T:=T + triepgiusasse[i].tminresasse;
      end;
  Result:=IntToStr(T);
  L.Free;
  with R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
      if UpperCase(DatiStampa[i].D) = 'CAUSALIASSENZA' then
      begin
        if DatiStampa[i].V = nil then
          DatiStampa[i].V:=TList.Create;
        PutValore(i,DatiStampa[i].V,Fmt,Key,KeyTot,0,(T > 0));
      end;
end;

function TA077FGeneratoreStampeDtM.GetOreReseInFascia(Fmt:String):String;
{Ore rese nella fascia specificata da Fmt:
  Maggiorazione% oppure Codice fascia}
var i,T:Integer;
    M:Real;
begin
  Result:='0';
  T:=0;
  with R502ProDtM1 do
    if Pos('%',Fmt) > 0 then
    begin
      try
        M:=StrToFloat(Copy(Fmt,1,Pos('%',Fmt) - 1));
      except
        exit;
      end;
      for i:=1 to n_fasce do
        if tfasceorarie[i].tpercfasc = M then
          T:=T + tminlav[i];
    end
    else
      for i:=1 to n_fasce do
        if tfasceorarie[i].tcodfasc = Fmt then
          T:=T + tminlav[i];
  Result:=IntToStr(T);
end;

function TA077FGeneratoreStampeDtM.GetOreLiquidabiliInFascia(Fmt:String):String;
{Ore liquidabili nella fascia specificata da Fmt:
  Maggiorazione% oppure Codice fascia}
var i,T:Integer;
    M:Real;
begin
  Result:='0';
  T:=0;
  with R502ProDtM1 do
    if Pos('%',Fmt) > 0 then
    begin
      try
        M:=Trunc(StrToFloat(Copy(Fmt,1,Pos('%',Fmt) - 1)));
      except
        exit;
      end;
      for i:=1 to n_fasce do
        if tfasceorarie[i].tpercfasc = M then
          T:=T + tminstrgio[i];
    end
    else
      for i:=1 to n_fasce do
        if tfasceorarie[i].tcodfasc = Fmt then
          T:=T + tminstrgio[i];
  Result:=IntToStr(T);
end;

function TA077FGeneratoreStampeDtM.GetOreInFascia(Vettore:array of integer; Fmt:String):String;
{Ore liquidabili nella fascia specificata da Fmt:
  Maggiorazione% oppure Codice fascia}
var i,T:Integer;
    M:Real;
begin
  Result:='0';
  T:=0;
  with R502ProDtM1 do
    if Pos('%',Fmt) > 0 then
    begin
      try
        M:=Trunc(StrToFloat(Copy(Fmt,1,Pos('%',Fmt) - 1)));
      except
        exit;
      end;
      for i:=1 to n_fasce do
        if tfasceorarie[i].tpercfasc = M then
          T:=T + Vettore[i - 1];
    end
    else
      for i:=1 to n_fasce do
        if tfasceorarie[i].tcodfasc = Fmt then
          T:=T + Vettore[i - 1];
  Result:=IntToStr(T);
end;

function TA077FGeneratoreStampeDtM.GetLiberaProfessione:String;
begin
  Result:='';
  with R502ProDtM1 do
    if Q320.SearchRecord('Data',Datacon,[srFromBeginning]) then
      repeat
        if Result <> '' then
          Result:=Result + ' ';
        Result:=Result + Q320.FieldByName('Dalle').AsString + '-' + Q320.FieldByName('Alle').AsString;
      until not(Q320.SearchRecord('Data',Datacon,[]));
  Result:=Copy(Result,1,50);
end;

function TA077FGeneratoreStampeDtM.GetPresenzaOreRese(i:Integer):String;
var x,T:Integer;
begin
  T:=0;
  if R502ProDtM1.n_rieppres < i then exit;
  with R502ProDtM1.triepgiuspres[i] do
    for x:=1 to High(tminpres) do
       inc(T,tminpres[x]);
  Result:=IntToStr(T);
end;

function TA077FGeneratoreStampeDtM.GetPresenzaOreReseFascia(i:Integer; Fmt:String):String;
var x,T:Integer;
    M:Real;
begin
  T:=0;
  if R502ProDtM1.n_rieppres < i then
    exit;
  with R502ProDtM1 do
  begin
    if Pos('%',Fmt) > 0 then
    begin
      try
        M:=Trunc(StrToFloat(Copy(Fmt,1,Pos('%',Fmt) - 1)));
      except
        exit;
      end;
      for x:=1 to n_fasce do
        if tfasceorarie[x].tpercfasc = M then
          T:=T + triepgiuspres[i].tminpres[x];
    end
    else
      for x:=1 to n_fasce do
        if tfasceorarie[x].tcodfasc = Fmt then
          T:=T + triepgiuspres[i].tminpres[x];
  end;
  Result:=IntToStr(T);
end;

procedure TA077FGeneratoreStampeDtM.GetMissioni;
{Lettura dati con R = 9}
var i,kc:Integer;
    Dato,Key,KeyTot,S,
    TipoIndennita,TariffaApplicata,OreConteggiate,Importo,VocePaghe:String;
    ImportoTotale,CostoTotale,IndSupTotali,RimborsiTotali,CostoRimborsi,IndKMTotali,KMTotali:Real;
const RInterno = 9;
begin
  if Trim(Parametri.CampiRiferimento.C8_Missione) = '' then
    exit;
  with selM040 do
  begin
    //Apertura anche M050 e M052
    SetVariabileDatoDalAl(selM050,RInterno);
    R180SetVariable(selM050,'PROGRESSIVO',C700Progressivo);
    SetVariabileDatoDalAl(selM052,RInterno);
    R180SetVariable(selM052,'PROGRESSIVO',C700Progressivo);
    SetVariabileDatoDalAl(selM040,RInterno);
    R180SetVariable(selM040,'PROGRESSIVO',C700Progressivo);
    SetVariable(':DATO_STORICO','T430.' + Trim(Parametri.CampiRiferimento.C8_Missione));
    if VarToStr(selM040.GetVariable('DATO_DALAL')) = 'DATADA' then
    begin
      R180SetVariable(selM040,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM040,'DATA2',R003FGeneratoreStampeMW.AData);
      R180SetVariable(selM050,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM050,'DATA2',R003FGeneratoreStampeMW.AData);
      R180SetVariable(selM052,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM052,'DATA2',R003FGeneratoreStampeMW.AData);
    end
    else
    begin
      R180SetVariable(selM040,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      R180SetVariable(selM040,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
      R180SetVariable(selM050,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      R180SetVariable(selM050,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
      R180SetVariable(selM052,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM052,'DATA2',R003FGeneratoreStampeMW.AData);
    end;
    selM050.Open;
    selM052.Open;
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('MESESCARICO').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('MESESCARICO').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Ricerca dell'indennità significativa per questo record
      TipoIndennita:='';
      TariffaApplicata:='0';
      OreConteggiate:=FloatToStr(FieldByName('OREINDINTERA').AsFloat + FieldByName('OREINDRIDOTTAH').AsFloat + FieldByName('OREINDRIDOTTAG').AsFloat + FieldByName('OREINDRIDOTTAHG').AsFloat);
      Importo:=FloatToStr(FieldByName('IMPORTOINDINTERA').AsFloat + FieldByName('IMPORTOINDRIDOTTAH').AsFloat + FieldByName('IMPORTOINDRIDOTTAG').AsFloat + FieldByName('IMPORTOINDRIDOTTAHG').AsFloat);
      VocePaghe:='';
      if FieldByName('OREINDINTERA').AsFloat <> 0 then
      begin
        TipoIndennita:='Ind.intera';
        TariffaApplicata:=FieldByName('TARIFFAINDINTERA').AsString;
        VocePaghe:=FieldByName('CODVOCEPAGHEINTERA').AsString;
      end
      else if FieldByName('OREINDRIDOTTAH').AsFloat <> 0 then
      begin
        TipoIndennita:='Ind.ridotta ore';
        TariffaApplicata:=FieldByName('TARIFFAINDRIDOTTAH').AsString;
        VocePaghe:=FieldByName('CODVOCEPAGHESUPHH').AsString;
      end
      else if FieldByName('OREINDRIDOTTAG').AsFloat <> 0 then
      begin
        TipoIndennita:='Ind.ridotta gg';
        TariffaApplicata:=FieldByName('TARIFFAINDRIDOTTAG').AsString;
        VocePaghe:=FieldByName('CODVOCEPAGHESUPGG').AsString;
      end
      else if FieldByName('OREINDRIDOTTAHG').AsFloat <> 0 then
      begin
        TipoIndennita:='Ind.ridotta ore/gg';
        TariffaApplicata:=FieldByName('TARIFFAINDRIDOTTAHG').AsString;
        VocePaghe:=FieldByName('CODVOCEPAGHESUPHHGG').AsString;
      end;
      //Calcolo del totale dei rimborsi effettuati
      RimborsiTotali:=0;
      IndSupTotali:=0;
      CostoRimborsi:=0;
      selM050.Filtered:=True;
      if selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA'
         VarArrayOf(['N','N',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),
         [srFromBeginning]) then
        repeat
          if selM050.FieldByName('TIPO_QUANTITA').AsString = 'I' then
          begin
            if selM050.FieldByName('MR_ANTICIPO').AsString = 'S' then // FLAG_ANTICIPO
              RimborsiTotali:=RimborsiTotali - selM050.FieldByName('MR_RIMBORSORICONOSCIUTO').AsFloat // IMPORTORIMBORSOSPESE
            else
              RimborsiTotali:=RimborsiTotali + selM050.FieldByName('MR_RIMBORSORICONOSCIUTO').AsFloat; // IMPORTORIMBORSOSPESE
            CostoRimborsi:=CostoRimborsi + selM050.FieldByName('MR_COSTO').AsFloat; // IMPORTOCOSTORIMBORSO
          end;
          IndSupTotali:=IndSupTotali + selM050.FieldByName('MR_INDENNITASUPPL').AsFloat; // IMPORTOINDENNITASUPPLEMENTARE
        until not selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA',
          VarArrayOf(['N','N',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),[]);
      //Calcolo del totale delle indennità km effettuate
      IndKMTotali:=0;
      KMTotali:=0;
      selM050.Filtered:=False;
      if selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA'
         VarArrayOf(['N','S',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),
         [srFromBeginning]) then
        repeat
          IndKMTotali:=IndKMTotali + selM050.FieldByName('MR_RIMBORSORICONOSCIUTO').AsFloat; // IMPORTORIMBORSOSPESE
          KMTotali:=KMTotali + selM050.FieldByName('MR_KMRICONOSCIUTI').AsFloat;
        until not selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA',
          VarArrayOf(['N','S',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),[]);
      //Calcolo totale importo della missione
      ImportoTotale:=FieldByName('IMPORTOINDINTERA').AsFloat +
                     FieldByName('IMPORTOINDRIDOTTAH').AsFloat +
                     FieldByName('IMPORTOINDRIDOTTAG').AsFloat +
                     FieldByName('IMPORTOINDRIDOTTAHG').AsFloat +
                     IndKMTotali;
      CostoTotale:=ImportoTotale;

      if selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA'
         VarArrayOf(['N','N',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),
         [srFromBeginning]) then
        repeat
          if selM050.FieldByName('TIPO_QUANTITA').AsString = 'I' then
          begin
            CostoTotale:=CostoTotale + selM050.FieldByName('MR_INDENNITASUPPL'{'IMPORTOINDENNITASUPPLEMENTARE'}).AsFloat + selM050.FieldByName('MR_COSTO'{'IMPORTOCOSTORIMBORSO'}).AsFloat;
            ImportoTotale:=ImportoTotale + selM050.FieldByName('MR_INDENNITASUPPL'{'IMPORTOINDENNITASUPPLEMENTARE'}).AsFloat;
            if selM050.FieldByName('MR_ANTICIPO'{'FLAG_ANTICIPO'}).AsString = 'S' then
              ImportoTotale:=ImportoTotale - selM050.FieldByName('MR_RIMBORSORICONOSCIUTO'{'IMPORTORIMBORSOSPESE'}).AsFloat
            else
              ImportoTotale:=ImportoTotale + selM050.FieldByName('MR_RIMBORSORICONOSCIUTO'{'IMPORTORIMBORSOSPESE'}).AsFloat;
          end;
        until not selM050.SearchRecord('MR_RICHIESTA;MR_INDENNITAKM;MR_MESESCARICO;MR_MESECOMPETENZA;MR_DADATA;MR_DAORA', // 'MESESCARICO;MESECOMPETENZA;DATADA;ORADA',
          VarArrayOf(['N','N',FieldByName('MESESCARICO').AsDateTime,FieldByName('MESECOMPETENZA').AsDateTime,FieldByName('DATADA').AsDateTime,FieldByName('ORADA').AsString]),[]);
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'MT_MESESCARICO' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MESESCARICO').AsDateTime)
          else if Dato = 'MT_MESECOMPETENZA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MESECOMPETENZA').AsDateTime)
          else if Dato = 'MT_DADATA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATADA').AsDateTime)
          else if Dato = 'MT_ADATA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATAA').AsDateTime)
          else if Dato = 'MT_DAORA' then
            S:=FieldByName('ORADA').AsString
          else if Dato = 'MT_AORA' then
            S:=FieldByName('ORAA').AsString
          else if Dato = 'MT_PROTOCOLLO' then
            S:=FieldByName('PROTOCOLLO').AsString
          else if Dato = 'MT_MISSIONEFORMAZIONE' then
            S:=FieldByName('TIPOREGISTRAZIONE').AsString
          else if Dato = 'MT_PARTENZA' then
            S:=FieldByName('PARTENZA').AsString
          else if Dato = 'MT_DESTINAZIONE' then
            S:=FieldByName('DESTINAZIONE').AsString
          else if Dato = 'MT_INDENNITATIPO' then
            S:=Tipoindennita
          else if Dato = 'MT_COMMESSA' then
            S:=FieldByName('COMMESSA').AsString
          else if Dato = 'MT_VOCEPAGHE' then
            S:=VocePaghe
          else if Dato = 'MT_STATOMISSIONE' then
            S:=FieldByName('STATO').AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO6' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'MT_MESESCARICO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MESESCARICO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_MESECOMPETENZA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MESECOMPETENZA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_DADATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATADA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_ADATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATAA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_DAORA' then
              PutValore(i,DatiStampa[i].V,FieldByName('ORADA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_AORA' then
              PutValore(i,DatiStampa[i].V,FieldByName('ORAA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_PROTOCOLLO' then
              PutValore(i,DatiStampa[i].V,FieldByName('PROTOCOLLO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_MISSIONEFORMAZIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('TIPOREGISTRAZIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_PARTENZA' then
              PutValore(i,DatiStampa[i].V,FieldByName('PARTENZA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_DESTINAZIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('DESTINAZIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_DURATAGIORNI' then
              PutValore(i,DatiStampa[i].V,FieldByName('TOTALEGG').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_DURATAORE' then
              PutValore(i,DatiStampa[i].V,IntToStr(R180OreMinutiExt(FieldByName('DURATA').AsString)),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_INDENNITATIPO' then
              PutValore(i,DatiStampa[i].V,TipoIndennita,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_INDENNITAAPPLICATA' then
              PutValore(i,DatiStampa[i].V,TariffaApplicata,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_ORECONTEGGIATE' then
              PutValore(i,DatiStampa[i].V,OreConteggiate,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_INDENNITAIMPORTO' then
              PutValore(i,DatiStampa[i].V,Importo,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_KMTOTALIFATTI' then
              PutValore(i,DatiStampa[i].V,FloatToStr(KMTotali),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_KMTOTALIIMPORTO' then
              PutValore(i,DatiStampa[i].V,FloatToStr(IndKMTotali),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_MODIFICAMANUALE' then
              PutValore(i,DatiStampa[i].V,FieldByName('FLAG_MODIFICATO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_STATOMISSIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('STATO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_NOTE' then
              PutValore(i,DatiStampa[i].V,FieldByName('NOTE_RIMBORSI').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_COMMESSA' then
              PutValore(i,DatiStampa[i].V,FieldByName('COMMESSA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_RIMBORSITOTALI' then
              PutValore(i,DatiStampa[i].V,FloatToStr(RimborsiTotali),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_COSTIRIMBORSITOTALI' then
              PutValore(i,DatiStampa[i].V,FloatToStr(CostoRimborsi),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_INDSUPPLTOTALI' then
              PutValore(i,DatiStampa[i].V,FloatToStr(IndSupTotali),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_RIMBINDSUPPLTOTALI' then
              PutValore(i,DatiStampa[i].V,FloatToStr(RimborsiTotali + IndSupTotali),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_IMPORTOTOTALE' then
              PutValore(i,DatiStampa[i].V,FloatToStr(ImportoTotale),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_COSTOTOTALE' then
              PutValore(i,DatiStampa[i].V,FloatToStr(CostoTotale),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MT_VOCEPAGHE' then
              PutValore(i,DatiStampa[i].V,VocePaghe,Key,KeyTot,DatiStampa[i].F,True)
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetMissioniRimborsi;
{Lettura dati con R = 10}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 10;
begin
  with selM050 do
  begin
    SetVariabileDatoDalAl(selM050,RInterno);
    R180SetVariable(selM050,'PROGRESSIVO',C700Progressivo);
    if VarToStr(GetVariable('DATO_DALAL')) = 'DATADA' then
    begin
      R180SetVariable(selM050,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM050,'DATA2',R003FGeneratoreStampeMW.AData);
    end
    else
    begin
      R180SetVariable(selM050,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      R180SetVariable(selM050,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    end;
    Open;
    Filtered:=True;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('MR_MESESCARICO').AsDateTime; // MESESCARICO
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('MR_MESESCARICO').AsDateTime;  // MESESCARICO
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          // nuovi dati 8.5.ini
          if Dato = 'MR_RICHIESTA' then
            S:=FieldByName('MR_RICHIESTA').AsString
          else if Dato = 'MR_INDENNITAKM' then
            S:=FieldByName('MR_INDENNITAKM').AsString
          else if Dato = 'MR_STATOAUTORIZZAZIONE' then
            S:=FieldByName('MR_STATOAUTORIZZAZIONE').AsString
          // nuovi dati 8.5.fine
          else if Dato = 'MR_IDMISSIONE' then
            S:=FieldByName('MR_IDMISSIONE').AsString
          else if Dato = 'MR_MESESCARICO' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MR_MESESCARICO').AsDateTime)    // MESESCARICO
          else if Dato = 'MR_MESECOMPETENZA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MR_MESECOMPETENZA').AsDateTime) // MESECOMPETENZA
          else if Dato = 'MR_DADATA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MR_DADATA').AsDateTime)         // DATADA
          else if Dato = 'MR_DAORA' then
            S:=FieldByName('MR_DAORA').AsString                                       // ORADA
          else if Dato = 'MR_CODICERIMBORSO' then
            S:=FieldByName('MR_CODICERIMBORSO').AsString                              // CODICERIMBORSOSPESE
          else if Dato = 'MR_ANTICIPO' then
            S:=FieldByName('MR_ANTICIPO').AsString                                    // FLAG_ANTICIPO
          else if Dato = 'MR_VOCEPAGHE' then
            S:=FieldByName('MR_VOCEPAGHE').AsString                                   // CODICEVOCEPAGHE
          else if Dato = 'MR_TIPOMISSIONE' then
            S:=FieldByName('MR_TIPOMISSIONE').AsString                                // TIPOMISSIONE
          else if Dato = 'MR_PROTOCOLLO' then
            S:=FieldByName('MR_PROTOCOLLO').AsString                                  // PROTOCOLLO
          else if Dato = 'MR_COMMESSA' then
            S:=FieldByName('MR_COMMESSA').AsString;                                   // COMMESSA
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO7' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            // nuovi dati 8.5.ini
            else if Dato = 'MR_RICHIESTA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_RICHIESTA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_INDENNITAKM' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_INDENNITAKM').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_STATOAUTORIZZAZIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_STATOAUTORIZZAZIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_IDMISSIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_IDMISSIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.fine
            else if Dato = 'MR_MESESCARICO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_MESESCARICO'{'MESESCARICO'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_MESECOMPETENZA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_MESECOMPETENZA'{'MESECOMPETENZA'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_DADATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_DADATA'{'DATADA'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_DAORA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_DAORA'{'ORADA'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_CODICERIMBORSO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_CODICERIMBORSO'{'CODICERIMBORSOSPESE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_DESCRIZIONERIMBORSO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_DESCRIZIONERIMBORSO'{'DESCRIZIONE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_ANTICIPO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_ANTICIPO'{'FLAG_ANTICIPO'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.ini
            else if Dato = 'MR_RIMBORSORICHIESTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_RIMBORSORICHIESTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.fine
            else if Dato = 'MR_RIMBORSORICONOSCIUTO' then // 'MR_RIMBORSO' // modifica dato 8.5
            begin
              if FieldByName('MR_ANTICIPO'{'FLAG_ANTICIPO'}).AsString = 'S' then
                PutValore(i,DatiStampa[i].V,FloatToStr(-FieldByName('MR_RIMBORSORICONOSCIUTO'{'IMPORTORIMBORSOSPESE'}).AsCurrency),Key,KeyTot,DatiStampa[i].F,True)
              else
                PutValore(i,DatiStampa[i].V,FieldByName('MR_RIMBORSORICONOSCIUTO'{'IMPORTORIMBORSOSPESE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            end
            else if Dato = 'MR_INDENNITASUPPL' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_INDENNITASUPPL'{'IMPORTOINDENNITASUPPLEMENTARE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_COSTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_COSTO'{'IMPORTOCOSTORIMBORSO'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.ini
            else if Dato = 'MR_KMRICHIESTI' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_KMRICHIESTI').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_KMRICONOSCIUTI' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_KMRICONOSCIUTI').AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.fine
            else if Dato = 'MR_VOCEPAGHE' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_VOCEPAGHE'{'CODICEVOCEPAGHE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_TIPOMISSIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_TIPOMISSIONE'{'TIPOMISSIONE'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_PROTOCOLLO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_PROTOCOLLO'{'PROTOCOLLO'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MR_COMMESSA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_COMMESSA'{'COMMESSA'}).AsString,Key,KeyTot,DatiStampa[i].F,True)
            // nuovi dati 8.5.ini
            else if Dato = 'MR_NOTE' then
              PutValore(i,DatiStampa[i].V,FieldByName('MR_NOTE').AsString,Key,KeyTot,DatiStampa[i].F,True);
            // nuovi dati 8.5.fine
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetMissioniIndKM;
{Lettura dati con R = 17}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 17;
begin
  with selM052 do
  begin
    SetVariabileDatoDalAl(selM052,RInterno);
    R180SetVariable(selM052,'PROGRESSIVO',C700Progressivo);
    if VarToStr(selM052.GetVariable('DATO_DALAL')) = 'DATADA' then
    begin
      R180SetVariable(selM052,'DATA1',R003FGeneratoreStampeMW.DaData);
      R180SetVariable(selM052,'DATA2',R003FGeneratoreStampeMW.AData);
    end
    else
    begin
      R180SetVariable(selM052,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
      R180SetVariable(selM052,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    end;
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('MESESCARICO').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('MESESCARICO').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'MK_MESESCARICO' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MESESCARICO').AsDateTime)
          else if Dato = 'MK_MESECOMPETENZA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('MESECOMPETENZA').AsDateTime)
          else if Dato = 'MK_DADATA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATADA').AsDateTime)
          else if Dato = 'MK_DAORA' then
            S:=FieldByName('ORADA').AsString
          else if Dato = 'MK_CODICE' then
            S:=FieldByName('CODICEINDENNITAKM').AsString
          else if Dato = 'MK_VOCEPAGHE' then
            S:=FieldByName('CODVOCEPAGHE').AsString
          else if Dato = 'MK_TIPOMISSIONE' then
            S:=FieldByName('TIPOMISSIONE').AsString
          else if Dato = 'MK_PROTOCOLLO' then
            S:=FieldByName('PROTOCOLLO').AsString
          else if Dato = 'MK_COMMESSA' then
            S:=FieldByName('COMMESSA').AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO14' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'MK_MESESCARICO' then
              PutValore(i,DatiStampa[i].V,FieldByName('MESESCARICO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_MESECOMPETENZA' then
              PutValore(i,DatiStampa[i].V,FieldByName('MESECOMPETENZA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_DADATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATADA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_DAORA' then
              PutValore(i,DatiStampa[i].V,FieldByName('ORADA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_CODICE' then
              PutValore(i,DatiStampa[i].V,FieldByName('CODICEINDENNITAKM').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_DESCRIZIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('DESCRIZIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_IMPORTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('IMPORTOINDENNITA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_KMFATTI' then
              PutValore(i,DatiStampa[i].V,FieldByName('KMPERCORSI').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_VOCEPAGHE' then
              PutValore(i,DatiStampa[i].V,FieldByName('CODVOCEPAGHE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_TIPOMISSIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('TIPOMISSIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_PROTOCOLLO' then
              PutValore(i,DatiStampa[i].V,FieldByName('PROTOCOLLO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MK_COMMESSA' then
              PutValore(i,DatiStampa[i].V,FieldByName('COMMESSA').AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetMissioniAnticipi;
{Lettura dati con R = 20}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 20;
begin
  with selM060 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;*)
    R180SetVariable(selM060,'PROGRESSIVO',C700Progressivo);
    Open;
    //Filtered:=True;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('DATA_MISSIONE').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('DATA_MISSIONE').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'MA_CASSA' then
            S:=FieldByName('CASSA').AsString
          else if Dato = 'MA_ANNOMOVIMENTO' then
            S:=FieldByName('ANNO_MOVIMENTO').AsString
          else if Dato = 'MA_CODICEVOCE' then
            S:=FieldByName('COD_VOCE').AsString
          else if Dato = 'MA_DATAIMPOSTAZIONESTATO' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime)
          else if Dato = 'MA_DATAMISSIONE' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATA_MISSIONE').AsDateTime)
          else if Dato = 'MA_DATAMOVIMENTO' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATA_MOVIMENTO').AsDateTime)
          else if Dato = 'MA_FLAGTOTALIZZATORE' then
            S:=FieldByName('FLAG_TOTALIZZATORE').AsString
          else if Dato = 'MA_IMPORTO' then
            S:=FieldByName('IMPORTO').AsString
          else if Dato = 'MA_NUMEROMOVIMENTO' then
            S:=FieldByName('NUM_MOVIMENTO').AsString
          else if Dato = 'MA_QUANTIT' then
            S:=FieldByName('QUANTITA').AsString
          else if Dato = 'MA_STATO' then
            S:=FieldByName('STATO').AsString
          else if Dato = 'MA_ITALIAESTERO' then
            S:=FieldByName('ITA_EST').AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO7' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'MA_CASSA' then
              PutValore(i,DatiStampa[i].V,FieldByName('CASSA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_ANNOMOVIMENTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('ANNO_MOVIMENTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_CODICEVOCE' then
              PutValore(i,DatiStampa[i].V,FieldByName('COD_VOCE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_DATAIMPOSTAZIONESTATO' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATA_IMPOSTAZIONE_STATO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_DATAMISSIONE' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATA_MISSIONE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_DATAMOVIMENTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATA_MOVIMENTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_FLAGTOTALIZZATORE' then
              PutValore(i,DatiStampa[i].V,FieldByName('FLAG_TOTALIZZATORE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_IMPORTO' then
                PutValore(i,DatiStampa[i].V,FieldByName('IMPORTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_NOTE' then
              PutValore(i,DatiStampa[i].V,FieldByName('NOTE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_NUMEROMOVIMENTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('NUM_MOVIMENTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_QUANTIT' then
              PutValore(i,DatiStampa[i].V,FieldByName('QUANTITA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_ITALIAESTERO' then
              PutValore(i,DatiStampa[i].V,FieldByName('ITA_EST').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_STATO' then
              PutValore(i,DatiStampa[i].V,FieldByName('STATO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'MA_NUMEROSOSPESO' then
              PutValore(i,DatiStampa[i].V,FieldByName('NROSOSP').AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetVociPaghe;
{Lettura dati con R = 11}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 11;
  function GetDescrizione(C:String):String;
  var j:Integer;
  begin
    Result:='';
    for j:=Low(VettConst) to High(VettConst) do
      if VettConst[j].CodInt = C then
      begin
        Result:=VettConst[j].Descrizione;
        Break;
      end;
  end;
begin
  with selT195 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;*)
    R180SetVariable(selT195,'PROGRESSIVO',C700Progressivo);
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('DATARIF').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('DATARIF').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'VP_MESECOMPETENZA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATARIF').AsDateTime)
          else if Dato = 'VP_ANNOCOMPETENZA' then
            S:=FormatDateTime('yyyy',FieldByName('DATARIF').AsDateTime)
          else if Dato = 'VP_MESECASSA' then
            S:=FormatDateTime('yyyymmdd',FieldByName('DATA_CASSA').AsDateTime)
          else if Dato = 'VP_ANNOCASSA' then
            S:=FormatDateTime('yyyy',FieldByName('DATA_CASSA').AsDateTime)
          else if Dato = 'VP_VOCEPAGHE' then
            S:=FieldByName('VOCEPAGHE').AsString
          else if Dato = 'VP_CODICE' then
            S:=FieldByName('COD_INTERNO').AsString
          else if Dato = 'VP_MISURA' then
            S:=FieldByName('UM').AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO8' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'VP_MESECOMPETENZA' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATARIF').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_ANNOCOMPETENZA' then
              PutValore(i,DatiStampa[i].V,FormatDateTime('yyyy',FieldByName('DATARIF').AsDateTime),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_MESECASSA' then
              PutValore(i,DatiStampa[i].V,FieldByName('DATA_CASSA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_ANNOCASSA' then
              PutValore(i,DatiStampa[i].V,FormatDateTime('yyyy',FieldByName('DATA_CASSA').AsDateTime),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_VOCEPAGHE' then
              PutValore(i,DatiStampa[i].V,FieldByName('VOCEPAGHE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_CODICE' then
              PutValore(i,DatiStampa[i].V,FieldByName('COD_INTERNO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_DESCRIZIONE' then
              PutValore(i,DatiStampa[i].V,GetDescrizione(FieldByName('COD_INTERNO').AsString),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_MISURA' then
              PutValore(i,DatiStampa[i].V,FieldByName('UM').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_VALORE' then
              PutValore(i,DatiStampa[i].V,FieldByName('VALORE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'VP_IMPORTO' then
              PutValore(i,DatiStampa[i].V,FieldByName('IMPORTO').AsString,Key,KeyTot,DatiStampa[i].F,True)
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetTurniReperibilita;
{Lettura dati con R = 12}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
    D:TDateTime;
const RInterno = 12;
begin
  with selT340 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;
    if R180InizioMese(DaData) <> GetVariable('DATA1') then
      Close;
    if R180InizioMese(AData) <> GetVariable('DATA2') then
      Close;*)
    R180SetVariable(selT340,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selT340,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selT340,'DATA2',R180InizioMese(R003FGeneratoreStampeMW.AData));
    Open;
    First;
    while not Eof do
    begin
      D:=EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,1);
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=D;
          DipendenteCorrente.DettaglioPeriodicoAl:=D;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'IR_DATA' then
            S:=FormatDateTime('yyyymmdd',D)
          else if Dato = 'IR_ANNNO' then
            S:=FieldByName('ANNO').AsString
          else if Dato = 'IR_VP_TURNO' then
            S:=FieldByName('VP_TURNO').AsString
          else if Dato = 'IR_VP_SPEZZONI' then
            S:=FieldByName('VP_ORE').AsString
          else if Dato = 'IR_VP_OREMAGGIORATE' then
            S:=FieldByName('VP_MAGGIORATE').AsString
          else if Dato = 'IR_VP_ORENONMAGG' then
            S:=FieldByName('VP_NONMAGGIORATE').AsString
          else if Dato = 'IR_VP_TURNIOLTREMAX' then
            S:=FieldByName('VP_TURNI_OLTREMAX').AsString
          else if Dato = 'IR_VP_GETTONECHIAMATA' then
            S:=FieldByName('VP_GETTONE_CHIAMATA').AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'IR_DATA' then
              PutValore(i,DatiStampa[i].V,DateToStr(D),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_ANNO' then
              PutValore(i,DatiStampa[i].V,FieldByName('ANNO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_TURNO' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_TURNO').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_SPEZZONI' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_ORE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_OREMAGGIORATE' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_MAGGIORATE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_ORENONMAGG' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_NONMAGGIORATE').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_TURNIOLTREMAX' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_TURNI_OLTREMAX').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'IR_VP_GETTONECHIAMATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('VP_GETTONE_CHIAMATA').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITATURNI' then
              PutValore(i,DatiStampa[i].V,FieldByName('TURNIINTERI').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITASPEZZONI' then
              PutValore(i,DatiStampa[i].V,IntToStr(R180OreMinutiExt(FieldByName('TURNIORE').AsString)),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITAOREMAGGIORATE' then
              PutValore(i,DatiStampa[i].V,IntToStr(R180OreMinutiExt(FieldByName('OREMAGG').AsString)),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITAORENONMAGG' then
              PutValore(i,DatiStampa[i].V,IntToStr(R180OreMinutiExt(FieldByName('ORENONMAGG').AsString)),Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITATURNIOLTREMAX' then
              PutValore(i,DatiStampa[i].V,FieldByName('TURNI_OLTREMAX').AsString,Key,KeyTot,DatiStampa[i].F,True)
            else if Dato = 'REPERIBILITAGETTONECHIAMATA' then
              PutValore(i,DatiStampa[i].V,FieldByName('GETTONE_CHIAMATA').AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetCreditiFormativi;
{Lettura dati con R = 13}
var Dato,Key,KeyTot,CodCorso:String;
    //D:TDateTime;
    RegistraCrediti:Boolean;
const RInterno = 13;
  procedure PutCreditiFormativi;
  var i:Integer;
      CreditiPartecipazione:Real;
  begin
    with selVSG651,R003FGeneratoreStampeMW do
      for i:=0 to High(DatiStampa) do
      try
        if Dati[DatiStampa[i].N].R = RInterno then
        begin
          if DatiStampa[i].V = nil then
            DatiStampa[i].V:=TList.Create;
          Dato:=UpperCase(DatiStampa[i].D);
          if Dato = 'PROGRESSIVO10' then
            PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
          else if Dato = 'CF_CREDITI_PARTECIPAZIONE' then
          begin
            //if R100FCreditiFormativiDtM.CompResCrediti.sProfiloCrediti <> '' then
            if RegistraCrediti and (selVSG651.FieldByName('CF_TIPO_PARTECIPAZIONE').AsString = 'P') then
              CreditiPartecipazione:=R100FCreditiFormativiDtM.ConteggioCreditiCorso(C700Progressivo,selVSG651.FieldByName('CF_COD_CORSO').AsString)
            else
              CreditiPartecipazione:=0;
            PutValore(i,DatiStampa[i].V,FloatToStr(CreditiPartecipazione),Key,KeyTot,DatiStampa[i].F,True);
          end
          else if Dato = 'CF_COMPETENZE' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nCompAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_COMPETENZEMIN' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nCompMinAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_COMPETENZEMAX' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nCompMaxAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_FRUITO' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nFruitoPeriodo),Key,KeyTot,0,True)
          else if Dato = 'CF_RESIDUO' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nResAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_RESIDUOMIN' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nResMinAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_RESIDUOMAX' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nResMaxAnnoCorr),Key,KeyTot,0,True)
          else if Dato = 'CF_RESIDUOANNOPREC' then
            PutValore(i,DatiStampa[i].V,FloatToStr(R100FCreditiFormativiDtM.CompResCrediti.nResAnnoPrec),Key,KeyTot,0,True)
          else
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
        end;
      except
      end;
  end;
begin
  with selVSG651 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
    begin
      Close;
      CodCorso:='';
    end;*)
    if R180SetVariable(selVSG651,'PROGRESSIVO',C700Progressivo) then
      CodCorso:='';
    Open;
    First;
    while not Eof do
    begin
      RegistraCrediti:=False;
      if (FieldByName('CF_COD_CORSO').AsString <> CodCorso) and (FieldByName('CF_TIPO_PARTECIPAZIONE').AsString = 'P') then
      begin
        CodCorso:=FieldByName('CF_COD_CORSO').AsString;
        RegistraCrediti:=True;
      end;
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(RInterno,selVSG651);
      (*D:=FieldByName('CF_DATA_PARTECIPAZIONE').AsDateTime;
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=D;
          DipendenteCorrente.DettaglioPeriodicoAl:=D;
        end;*)
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,RInterno,selVSG651);
      (*Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'CF_DATA_PARTECIPAZIONE' then
            S:=FormatDateTime('yyyymmdd',D)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;*)
      //Riepilogo Competenze/Residui
      with R003FGeneratoreStampeMW do
        if (EsisteDatoStampa('CF_CREDITI_PARTECIPAZIONE') >= 0) or
           (EsisteDatoStampa('CF_COMPETENZE') >= 0) or
           (EsisteDatoStampa('CF_COMPETENZEMIN') >= 0) or
           (EsisteDatoStampa('CF_COMPETENZEMAX') >= 0) or
           (EsisteDatoStampa('CF_FRUITO') >= 0) or
           (EsisteDatoStampa('CF_RESIDUO') >= 0) or
           (EsisteDatoStampa('CF_RESIDUOMIN') >= 0) or
           (EsisteDatoStampa('CF_RESIDUOMAX') >= 0) or
           (EsisteDatoStampa('CF_RESIDUOANNOPREC') >= 0) then
          R100FCreditiFormativiDtM.ConteggioCrediti(C700Progressivo,EncodeDate(R180Anno(AData),1,1),EncodeDate(R180Anno(AData),12,31),FieldByName('CF_PROFILO_CREDITI').AsString);
      PutCreditiFormativi;
      Next;
    end;
    with R003FGeneratoreStampeMW do
      if (RecordCount = 0) and
         ((EsisteDatoStampa('CF_CREDITI_PARTECIPAZIONE') >= 0) or
          (EsisteDatoStampa('CF_COMPETENZE') >= 0) or
          (EsisteDatoStampa('CF_COMPETENZEMIN') >= 0) or
          (EsisteDatoStampa('CF_COMPETENZEMAX') >= 0) or
          (EsisteDatoStampa('CF_FRUITO') >= 0) or
          (EsisteDatoStampa('CF_RESIDUO') >= 0) or
          (EsisteDatoStampa('CF_RESIDUOMIN') >= 0) or
          (EsisteDatoStampa('CF_RESIDUOMAX') >= 0) or
          (EsisteDatoStampa('CF_RESIDUOANNOPREC') >= 0)) then
      begin
        R100FCreditiFormativiDtM.ConteggioCrediti(C700Progressivo,EncodeDate(R180Anno(AData),1,1),EncodeDate(R180Anno(AData),12,31),FieldByName('CF_PROFILO_CREDITI').AsString);
        if R100FCreditiFormativiDtM.CompResCrediti.sProfiloCrediti <> '' then
        begin
          Key:='';
          KeyTot:='';
          PutCreditiFormativi;
        end;
      end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetIscrizioniSindacali;
{Lettura dati con R = 14}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
//    D:TDateTime;
const RInterno = 14;
begin
  with selVT246 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;*)
    R180SetVariable(selVT246,'PROGRESSIVO',C700Progressivo);
  end;
  GetSerbatoioStd(RInterno,selVT246);
  (*
    Open;
    First;
    while not Eof do
    begin
      D:=FieldByName('IS_DATA_ISCRIZIONE').AsDateTime;
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=D;
          DipendenteCorrente.DettaglioPeriodicoAl:=D;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'IS_DATA_ISCRIZIONE' then
            S:=FormatDateTime('yyyymmdd',D)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
  *)
end;

procedure TA077FGeneratoreStampeDtM.GetPartecipazioniSindacali;
{Lettura dati con R = 15}
var i:Integer;
    Dato,Key,KeyTot:String;
    //D:TDateTime;
const RInterno = 15;
  function GetRiepilogoSindacati(Dato:String):String;
  begin
    Result:='';
    with A124FPermessiSIndacaliDtM.A124MW.selCompetenze do
    begin
      if VarToStr(GetVariable('CODICE')) <> selVT247.FieldByName('OS_SINDACATO').AsString then
        Close;
      if VarToStr(GetVariable('DATA')) <> DateToStr(R003FGeneratoreStampeMW.AData) then
        Close;
      if VarToStr(GetVariable('PROGRESSIVO')) <> IntToStr(C700Progressivo) then
        Close;
      SetVariable('CODICE',selVT247.FieldByName('OS_SINDACATO').AsString);
      SetVariable('DATA',R003FGeneratoreStampeMW.AData);
      SetVariable('PROGRESSIVO',C700Progressivo);
      Open;
      if Dato = 'OS_COMPETENZE' then
        Result:=VarToStr(Lookup('TIPO','C','COMPETENZA'))
      else if Dato = 'OS_FRUITO' then
        Result:=VarToStr(Lookup('TIPO','C','FRUITO'))
      else if Dato = 'OS_RESIDUO' then
        Result:=VarToStr(Lookup('TIPO','C','RESIDUO'))
      else if Dato = 'OS_COMPETENZE_DAL' then
        Result:=VarToStr(Lookup('TIPO','C','DECORRENZA'))
      else if Dato = 'OS_COMPETENZE_AL' then
        Result:=VarToStr(Lookup('TIPO','C','SCADENZA'))
      else if Dato = 'OS_COMPETENZE_IND' then
        Result:=IntToStr(R180OreMinutiExt(VarToStr(Lookup('TIPO','I','COMPETENZA'))))
      else if Dato = 'OS_FRUITO_IND' then
        Result:=IntToStr(R180OreMinutiExt(VarToStr(Lookup('TIPO','I','FRUITO'))))
      else if Dato = 'OS_RESIDUO_IND' then
        Result:=IntToStr(R180OreMinutiExt(VarToStr(Lookup('TIPO','I','RESIDUO'))))
      else if Dato = 'OS_COMPETENZE_DAL_IND' then
        Result:=VarToStr(Lookup('TIPO','I','DECORRENZA'))
      else if Dato = 'OS_COMPETENZE_AL_IND' then
        Result:=VarToStr(Lookup('TIPO','I','SCADENZA'));
    end;
  end;
begin
  with selVT247 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;*)
    R180SetVariable(selVT247,'PROGRESSIVO',C700Progressivo);
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(RInterno, selVT247);
      (*D:=FieldByName('OS_DATA_INIZIO').AsDateTime;
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=D;
          DipendenteCorrente.DettaglioPeriodicoAl:=D;
        end;*)
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,RInterno, selVT247);
      (*Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'OS_DATA_INIZIO' then
            S:=FormatDateTime('yyyymmdd',D)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;*)
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if (Dato = 'OS_COMPETENZE') or (Dato = 'OS_FRUITO') or (Dato = 'OS_RESIDUO') or
               (Dato = 'OS_COMPETENZE_DAL') or (Dato = 'OS_COMPETENZE_AL') or
               (Dato = 'OS_COMPETENZE_IND') or (Dato = 'OS_FRUITO_IND') or (Dato = 'OS_RESIDUO_IND') or
               (Dato = 'OS_COMPETENZE_DAL_IND') or (Dato = 'OS_COMPETENZE_AL_IND') then
              PutValore(i,DatiStampa[i].V,GetRiepilogoSindacati(Dato),Key,KeyTot,DatiStampa[i].F,True)
            else
              PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetPermessiSindacali;
{Lettura dati con R = 16}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
//    D:TDateTime;
const RInterno = 16;
begin
  with selVT248 do
  begin
    (*if C700Progressivo <> GetVariable('PROGRESSIVO') then
      Close;*)
    R180SetVariable(selVT248,'PROGRESSIVO',C700Progressivo);
  end;
  GetSerbatoioStd(RInterno,selVT248);
  (*
    Open;
    First;
    while not Eof do
    begin
      D:=FieldByName('PS_DATA').AsDateTime;
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=D;
          DipendenteCorrente.DettaglioPeriodicoAl:=D;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if (Dato = 'PS_DATA') or
             (Dato = 'PS_DATA_PROTOCOLLO') or
             (Dato = 'PS_DATA_MODIFICA') then
            S:=FormatDateTime('yyyymmdd',D)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
  *)
end;

procedure TA077FGeneratoreStampeDtM.GetIncentivi;
{Lettura dati con R = 18}
var i,kc:Integer;
    Dato,Key,KeyTot,S:String;
const RInterno = 18;
  function GetAbbattimentiIncentivi(D:String):String;
  var Abb:Real;
  begin
    Result:='';
    Abb:=0;
    with selT763 do
    begin
      if GetVariable('PROGRESSIVO') <> selT762.FieldByName('PROGRESSIVO').AsInteger then
      begin
        Close;
        SetVariable('PROGRESSIVO',selT762.FieldByName('PROGRESSIVO').AsInteger);
      end;
      if GetVariable('ANNO') <> R180Anno(selT762.FieldByName('QI_DATA').AsDateTime) then
      begin
        Close;
        SetVariable('ANNO',R180Anno(selT762.FieldByName('QI_DATA').AsDateTime));
      end;
      if GetVariable('MESE') <> R180Mese(selT762.FieldByName('QI_DATA').AsDateTime) then
      begin
        Close;
        SetVariable('MESE',R180Mese(selT762.FieldByName('QI_DATA').AsDateTime));
      end;
      if GetVariable('TIPOQUOTA') <> selT762.FieldByName('QI_COD_TIPO_QUOTA').AsString then
      begin
        Close;
        SetVariable('TIPOQUOTA',selT762.FieldByName('QI_COD_TIPO_QUOTA').AsString);
      end;
      Open;
      First;
      while not Eof do
      begin
        Result:=Result + FieldByName('QI_TIPOABBATTIMENTO').AsString + ',';
        Abb:=Abb + FieldByName('QI_ABBATTIMENTO').AsFloat;
        Next;
      end;
      if D = 'QI_ABBATTIMENTO' then
        Result:=FloatToStr(Abb)
      else if D = 'QI_INCENTIVILORDI' then
        Result:=FloatToStr(Abb + selT762.FieldByName('QI_INCENTIVI').AsFloat)
      else if Result <> '' then
        Result:=Copy(Result,1,Length(Result) - 1);
    end;
  end;
begin
  with selT762 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selT762,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selT762,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selT762,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(RInterno, selT762);
      (*with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('QI_DATA').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('QI_DATA').AsDateTime;
        end;*)
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with R003FGeneratoreStampeMW.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if Dato = 'QI_TIPOABBATTIMENTO' then
            S:=GetAbbattimentiIncentivi(Dato)
          else if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO15' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if (Dato = 'QI_ABBATTIMENTO') or (Dato = 'QI_TIPOABBATTIMENTO') or (Dato = 'QI_INCENTIVILORDI') then
              PutValore(i,DatiStampa[i].V,GetAbbattimentiIncentivi(Dato),Key,KeyTot,DatiStampa[i].F,True)
            else
              PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
      selT763.Close;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetRischiPrescrizioni;
{Lettura dati con R = 21}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
const RInterno = 21;
begin
  with selVSG402 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selVSG402,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVSG402,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVSG402,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
  GetSerbatoioStd(RInterno,selVSG402);
  (*
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('RP_DATA_PERIODO').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('RP_DATA_PERIODO').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO17' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else
              PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;*)
end;

procedure TA077FGeneratoreStampeDtM.GetIncarichi;
{Lettura dati con R = 22}
var i(*,kc*):Integer;
    Dato,Key,KeyTot(*,S*):String;
const RInterno = 22;
  function GetDescUnitaOrg(Cod:String):String;
  begin
    Result:='';
    A000LookupTabella(Parametri.CampiRiferimento.C20_IncaricoUnitaOrg,selC20Incarichi);
    if not selC20Incarichi.Active then
      selC20Incarichi.Open;
    Result:=VarToStr(selC20Incarichi.Lookup('CODICE',Cod,'DESCRIZIONE'));
  end;
begin
  with selVSG303 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selVSG303,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVSG303,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVSG303,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (R003FGeneratoreStampeMW.TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('IN_DATA_AFFIDAMENTO').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=IfThen(FieldByName('IN_DATA_SCADENZA').IsNull,DipendenteCorrente.Al,FieldByName('IN_DATA_SCADENZA').AsDateTime);
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,RInterno,selVSG303);
      (*Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;*)
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if Dato = 'PROGRESSIVO18' then
              PutValore(i,DatiStampa[i].V,IntToStr(C700Progressivo),Key,KeyTot,0,True)
            else if Dato = 'IN_D_UNITAORG' then
              PutValore(i,DatiStampa[i].V,GetDescUnitaOrg(FieldByName('IN_COD_UNITAORG').AsString),Key,KeyTot,0,True)
            else
              PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetMessaggiWeb;
{Lettura dati con R = 23}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
const RInterno = 23;
begin
  with selVT280 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selVT280,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVT280,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVT280,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
  GetSerbatoioStd(RInterno,selVT280);
  (*
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('MW_DATA').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('MW_DATA').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
  *)
end;

procedure TA077FGeneratoreStampeDtM.GetRichiesteWeb;
{Lettura dati con R = 24}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
const RInterno = 24;
begin
  with selVT050T105 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selVT050T105,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVT050T105,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVT050T105,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
  GetSerbatoioStd(RInterno,selVT050T105);
  (*
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('RW_DATA1').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('RW_DATA2').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
  *)
end;

procedure TA077FGeneratoreStampeDtM.GetIterWeb;
{Lettura dati con R = 29}
const RInterno = 29;
var Key,KeyTot:String;
    SubKey,SubKeyTot:String;
    ODS:TOracleDataSet;
begin
  with selVT850_T851 do
  begin
    R180SetVariable(selVT850_T851,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVT850_T851,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVT850_T851,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;

  with selVT850_T851 do
  begin
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(RInterno,selVT850_T851);
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      ODS:=nil;
      if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_GIUSTIF then
        ODS:=selT050
      else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_STRMESE then
        ODS:=selT065
      else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_ORARIGG then
        ODS:=selT085
      else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_TIMBR then
        ODS:=selT105
      //else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_STRGIORNO then
      //  ODS:=selT325
      else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_RENDI_PROJ then
        ODS:=selT755
      //else if selVT850_T851.FieldByName('IA_ITER').AsString = ITER_MISSIONI then
      //  ODS:=selM140
      ;
      if ODS <> nil then
      begin
        R180SetVariable(ODS,'ID',selVT850_T851.FieldByName('IA_ID').AsInteger);
        ODS.Open;
        GetKeyStd(SubKey,SubKeyTot,RInterno,ODS);
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,RInterno,selVT850_T851);
      Key:=Key + SubKey;
      KeyTot:=KeyTot + SubKeyTot;
      //PutValoreStd(Key,KeyTot,RInterno,selVT850_T851);
      if ODS <> nil then
        PutValoreListaDataSet(Key,KeyTot,RInterno,[selVT850_T851,ODS])
      else
        PutValoreStd(Key,KeyTot,RInterno,selVT850_T851);
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetCartaServizi;
{Lettura dati con R = 25}
//var i,kc:Integer;
//    Dato,Key,KeyTot,S:String;
const RInterno = 25;
begin
  with selVT500 do
  begin
    (*if (C700Progressivo <> GetVariable('PROGRESSIVO')) or
       (R180InizioMese(DaData) <> GetVariable('DATA1')) or
       (R180FineMese(AData) <> GetVariable('DATA2')) then
      Close;*)
    R180SetVariable(selVT500,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selVT500,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selVT500,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  end;
  GetSerbatoioStd(RInterno,selVT500);
  (*
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      with A077FGeneratoreStampe do
        if (GetIdxTabelleCollegate(RInterno) >= 0) and (TabelleCollegate[GetIdxTabelleCollegate(RInterno)].Data[1] <> '') then
        begin
          DipendenteCorrente.DettaglioPeriodicoDal:=FieldByName('CS_DATA').AsDateTime;
          DipendenteCorrente.DettaglioPeriodicoAl:=FieldByName('CS_DATA').AsDateTime;
        end;
      if not PeriodoStoricoValido(RInterno) then
      begin
        Next;
        Continue;
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      Key:='';
      KeyTot:='';
      with A077FGeneratoreStampe.Serbatoi[A077FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
        for kc:=0 to High(KeyCumulo) do
        begin
          Dato:=UpperCase(Identificatore(KeyCumulo[kc].Nome));
          if FieldByName(Dato).DataType in [ftDate,ftDatetime] then
            S:=FormatDateTime('yyyymmdd',FieldByName(Dato).AsDateTime)
          else
            S:=FieldByName(Dato).AsString;
          Key:=Key + S;
          if KeyCumulo[kc].Totale then
            KeyTot:=KeyTot + S;
        end;
      with A077FGeneratoreStampe do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = RInterno then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            PutValore(i,DatiStampa[i].V,FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
  *)
end;

procedure TA077FGeneratoreStampeDtM.GetValutazioni;
{Lettura dati con R = 26}
var i:Integer;
    StatoAttuale:String;
const RInterno = 26;
begin
  StatoAttuale:='S';
  with R003FGeneratoreStampeMW.Serbatoi[R003FGeneratoreStampe.GetIdxSerbatoi(RInterno)] do
    for i:=0 to High(KeyCumulo) do
      if UpperCase(KeyCumulo[i].Nome) = 'VA_STATO_AVANZAMENTO' then
      begin
        StatoAttuale:='N';
        Break;
      end;
  with selSG710 do
  begin
    R180SetVariable(selSG710,'PROGRESSIVO',C700Progressivo);
    R180SetVariable(selSG710,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
    R180SetVariable(selSG710,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
    R180SetVariable(selSG710,'STATO_ATTUALE',StatoAttuale);
  end;
  GetSerbatoioStd(RInterno,selSG710);
end;

procedure TA077FGeneratoreStampeDtM.GetIncVerifiche;
{Lettura dati con R = 27}
const RInterno = 27;
begin
  R180SetVariable(selVSG308,'PROGRESSIVO',C700Progressivo);
  R180SetVariable(selVSG308,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
  R180SetVariable(selVSG308,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  GetSerbatoioStd(RInterno,selVSG308);
end;

procedure TA077FGeneratoreStampeDtM.GetVariazSaldiAnniPrec;
{Lettura dati con R = 28}
const RInterno = 28;
var Key,KeyTot:String;
    R:Byte;
    i,TotOrePerse,AnnoCompetenza:Integer;
    Dato:String;
    ConteggiR450:Boolean;
begin
  R:=RInterno;
  AnnoCompetenza:=0;
  R180SetVariable(selVT134,'PROGRESSIVO',C700Progressivo);
  R180SetVariable(selVT134,'DATA1',R180InizioMese(R003FGeneratoreStampeMW.DaData));
  R180SetVariable(selVT134,'DATA2',R180FineMese(R003FGeneratoreStampeMW.AData));
  with R003FGeneratoreStampeMW do
    ConteggiR450:=(EsisteDatoStampa('VAP_SALDO_ANNUO') >= 0) or (EsisteDatoStampa('VAP_TOTALE_ORE_PERSE') >= 0) or (EsisteDatoStampa('VAP_RESIDUO_ORE_PERSE') >= 0);
  if ConteggiR450 and (R450DtM1 = nil) then
    R450DtM1:=TR450DtM1.Create(nil);
  //espando qua GetSerbatoioStd(RInterno,selVT134);
  with selVT134 do
  begin
    Open;
    First;
    while not Eof do
    begin
      //Se si gestiscono i periodi storici, considero i dati del periodo storico corrente
      GetDettaglioPeriodicoStd(R,selVT134);
      if not PeriodoStoricoValido(R) then
      begin
        Next;
        Continue;
      end;
      if ConteggiR450 and (AnnoCompetenza <> selVT134.FieldByName('VAP_ANNO_COMPETENZA').AsInteger) then
      begin
        AnnoCompetenza:=selVT134.FieldByName('VAP_ANNO_COMPETENZA').AsInteger;
        R450DtM1.ConteggiMese('Generico',AnnoCompetenza,12,C700Progressivo);
      end;
      //Costruzione della chiave di cumulo e di totalizzazione
      GetKeyStd(Key,KeyTot,R,selVT134);
      //espando qua PutValoreStd(Key,KeyTot,R,selSerbatoio);
      with R003FGeneratoreStampeMW do
        for i:=0 to High(DatiStampa) do
        try
          if Dati[DatiStampa[i].N].R = R then
          begin
            if DatiStampa[i].V = nil then
              DatiStampa[i].V:=TList.Create;
            Dato:=UpperCase(DatiStampa[i].D);
            if ConteggiR450 then
              TotOrePerse:=R450DtM1.OrePersePeriodiche + R450DtM1.salcompannoprec + R450DtM1.salliqannoprec
            else
              TotOrePerse:=0;
            if Dato = 'VAP_SALDO_ANNUO' then
              PutValore(i,DatiStampa[i].V,IntToStr(R450DtM1.salannoatt),Key,KeyTot,(*DatiStampa[i].F*)0,True)
            else if Dato = 'VAP_TOT_ORE_PERSE' then
              PutValore(i,DatiStampa[i].V,IntToStr(TotOrePerse),Key,KeyTot,(*DatiStampa[i].F*)0,True)
            else if Dato = 'VAP_RESIDUO_ORE_PERSE' then
              PutValore(i,DatiStampa[i].V,IntToStr(TotOrePerse - selVT134.FieldByName('VAP_Tot_Variaz_Ore_Perse').AsInteger),Key,KeyTot,(*DatiStampa[i].F*)0,True)
            else
              PutValore(i,DatiStampa[i].V,selVT134.FieldByName(Dato).AsString,Key,KeyTot,DatiStampa[i].F,True);
          end;
        except
        end;
      Next;
    end;
  end;
end;

procedure TA077FGeneratoreStampeDtM.GetIndFunzione;
{Lettura dati con R = 30}
var i:Integer;
const RInterno = 30;
begin
  R180SetVariable(selCSI006,'PROGRESSIVO',C700Progressivo);
  R180SetVariable(selCSI006,'DATA1',R003FGeneratoreStampeMW.DaData);
  R180SetVariable(selCSI006,'DATA2',R003FGeneratoreStampeMW.AData);
  GetSerbatoioStd(RInterno,selCSI006);
end;

end.

unit W036UTraspDirigenzaDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, Oracle,
  A000UCostanti, A000UInterfaccia, A000USessione, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Math, Variants, StrUtils, IWApplication, medpIWMessageDlg;

type
  TW036FTraspDirigenzaDM = class(TDataModule)
    selSG210a: TOracleDataSet;
    selSG210b: TOracleDataSet;
    selSG211a: TOracleDataSet;
    selSG212: TOracleDataSet;
    selSG211b: TOracleDataSet;
    selSG211z: TOracleDataSet;
    selSG210aPROGRESSIVO: TIntegerField;
    selSG210aORDINE: TIntegerField;
    selSG210aINCARICO_ATTUALE: TStringField;
    selSG210aQUALIFICA: TStringField;
    selSG210aTIPO_AMMINISTRAZIONE: TStringField;
    selSG210aAMMINISTRAZIONE: TStringField;
    selSG210aCOMUNE: TStringField;
    selSG210aRUOLO: TStringField;
    selSG210aUNITA_ORGANIZZATIVA: TStringField;
    selSG210aTESTO: TStringField;
    selSG210aTEL_UFFICIO: TStringField;
    selSG210aFAX_UFFICIO: TStringField;
    selSG210aEMAIL_UFFICIO: TStringField;
    selSG210aSITO_WEB: TStringField;
    selSG210bPROGRESSIVO: TIntegerField;
    selSG210bORDINE: TIntegerField;
    selSG210bINCARICO_ATTUALE: TStringField;
    selSG210bQUALIFICA: TStringField;
    selSG210bTIPO_AMMINISTRAZIONE: TStringField;
    selSG210bAMMINISTRAZIONE: TStringField;
    selSG210bCOMUNE: TStringField;
    selSG210bRUOLO: TStringField;
    selSG210bUNITA_ORGANIZZATIVA: TStringField;
    selSG210bTESTO: TStringField;
    selSG210bTEL_UFFICIO: TStringField;
    selSG210bFAX_UFFICIO: TStringField;
    selSG210bEMAIL_UFFICIO: TStringField;
    selSG210bSITO_WEB: TStringField;
    selSG211aTIPO: TStringField;
    selSG211aPROGRESSIVO: TIntegerField;
    selSG211aORDINE: TIntegerField;
    selSG211aTITOLO_STUDIO: TStringField;
    selSG211aTESTO: TStringField;
    selSG211bTIPO: TStringField;
    selSG211bPROGRESSIVO: TIntegerField;
    selSG211bORDINE: TIntegerField;
    selSG211bTITOLO_STUDIO: TStringField;
    selSG211bTESTO: TStringField;
    selSG211zTIPO: TStringField;
    selSG211zPROGRESSIVO: TIntegerField;
    selSG211zORDINE: TIntegerField;
    selSG211zTITOLO_STUDIO: TStringField;
    selSG211zTESTO: TStringField;
    selSG212PROGRESSIVO: TIntegerField;
    selSG212LINGUA: TStringField;
    selSG212LIVELLO_PARLATO: TStringField;
    selSG212LIVELLO_SCRITTO: TStringField;
    selSG210aDECORRENZA: TDateTimeField;
    selSG210aDECORRENZA_FINE: TDateTimeField;
    selSG210bDECORRENZA: TDateTimeField;
    selSG210bDECORRENZA_FINE: TDateTimeField;
    selSG211aDATA: TDateTimeField;
    selSG211bDATA: TDateTimeField;
    selSG211zDATA: TDateTimeField;
    selT480: TOracleDataSet;
    dsrQ480: TDataSource;
    selSG210aD_COMUNE: TStringField;
    updSG210a: TOracleQuery;
    selSG210bD_COMUNE: TStringField;
    selSG215: TOracleDataSet;
    selSG215NOME_LOGICO: TStringField;
    selSG215NOME_CAMPO: TStringField;
    selSG215VAL_DEFAULT: TStringField;
    selListaValori: TOracleDataSet;
    selSG210OrdSucc: TOracleQuery;
    selSG211OrdSucc: TOracleQuery;
    selV430a: TOracleDataSet;
    selI060: TOracleDataSet;
    selV430b: TOracleQuery;
    selSG213: TOracleDataSet;
    selSG213SENTENZA_CONDANNA: TStringField;
    selSG213INCONFERIBILITA: TStringField;
    selSG213INCOMPATIBILITA: TStringField;
    selSG213PROGRESSIVO: TIntegerField;
    selSG213INCONF_AMMINISTRAZIONE: TStringField;
    selSG213INCONF_RUOLO: TStringField;
    dsrSG213: TDataSource;
    selSG213DATA_VALIDITA: TDateTimeField;
    selSG213DATA_COMPILAZIONE: TDateTimeField;
    selSG215CTRL_VALORE_DA_ELENCO: TStringField;
    selSG210aD_PROVINCIA: TStringField;
    selSG210bD_PROVINCIA: TStringField;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    procedure DataModuleCreate(Sender:TObject);
    procedure DataModuleDestroy(Sender:TObject);
    procedure DataSetNewRecord(DataSet:TDataSet);
    procedure EsperienzeCalcFields(DataSet:TDataSet);
    procedure DataSetControlloSezioniObbligatorie(DataSet: TDataSet);
    procedure DataSetBeforePost(DataSet:TDataSet);
    procedure selSG212PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure selSG213INCONFERIBILITAChange(Sender: TField);
  private
    CampiV430a: String;
    procedure ImpostaLabelMaxCar(DataSet:TOracleDataSet);
    function RecuperaI060Email: String;
    procedure ImpostaValoreDefault(DataSet:TOracleDataSet);
  public
    slQualif,slTipoAmm,slAmm,slRuolo,slUniOrg,slEmail,slSito,slTitStud,slLingua,slLivParl,slLivScr: TStringList;
    selAnagrafeW: TOracleDataSet;
    EspPrecRowid:String;
    DataOldIncAtt:TDateTime;
    procedure CaricaListaValori(NomeLogico:String);
    function RecuperaLista(NomeLogico:String):TStringList;
    function ValoreDefault(NomeLogico:String): String;
    function AbilitaDichiarazioni(NomeLogico:String):Boolean;
    function OrdineSuccessivo(OQ:TOracleQuery;Tipo:String;Prog:Integer;Data:TDateTime):Integer;
    function ControlloCampiObbligatori(DataSetCampi,DataSetValori:TDataSet):String;
    function ControlloValoreDaElenco(DataSet:TDataSet):String;
  end;

const sObbl = ' (*)';
const sMaxCar = ' (max 1000 caratteri)';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW036FTraspDirigenzaDM.DataModuleCreate(Sender: TObject);
  procedure AggiungiCampoV430(NomeLogico,Campo:String);
  var s:String;
  begin
    s:=Campo + IfThen(Copy(Campo,1,6) = 'DECODE',' ' + StringReplace(NomeLogico,'#','',[rfReplaceAll]));
    if ((Copy(s,1,4) = 'T430') or (Copy(s,1,6) = 'DECODE'))
    and not R180InConcat(s,CampiV430a) then
      CampiV430a:=CampiV430a + ',' + s;
  end;
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  ImpostaLabelMaxCar(selSG210a);
  ImpostaLabelMaxCar(selSG210b);
  ImpostaLabelMaxCar(selSG211a);
  ImpostaLabelMaxCar(selSG212);
  ImpostaLabelMaxCar(selSG211b);
  ImpostaLabelMaxCar(selSG211z);
  selT480.SetVariable('ORDERBY','ORDER BY CITTA');
  selT480.Open;
  CampiV430a:='T430DATADECORRENZA';
  with selSG215 do
  begin
    Open;
    while not Eof do
    begin
      AggiungiCampoV430(FieldByName('NOME_LOGICO').AsString,FieldByName('NOME_CAMPO').AsString);
      AggiungiCampoV430(FieldByName('NOME_LOGICO').AsString,FieldByName('VAL_DEFAULT').AsString);
      Next;
    end;
    First;
  end;
  selV430a.SetVariable('CAMPI',CampiV430a);
  slQualif:=TStringList.Create;
  CaricaListaValori('QUALIFICA');
  slTipoAmm:=TStringList.Create;
  CaricaListaValori('TIPO_AMMINISTRAZIONE');
  slAmm:=TStringList.Create;
  CaricaListaValori('AMMINISTRAZIONE');
  slRuolo:=TStringList.Create;
  CaricaListaValori('RUOLO');
  slUniOrg:=TStringList.Create;
  CaricaListaValori('UNITA_ORGANIZZATIVA');
  slEmail:=TStringList.Create;//Carico i valori successivamente, in base al dipendente selezionato
  slSito:=TStringList.Create;
  CaricaListaValori('SITO_WEB');
  slTitStud:=TStringList.Create;
  CaricaListaValori('TITOLO_STUDIO');
  slLingua:=TStringList.Create;
  CaricaListaValori('LINGUA');
  slLivParl:=TStringList.Create;
  CaricaListaValori('LIVELLO_PARLATO');
  slLivScr:=TStringList.Create;
  CaricaListaValori('LIVELLO_SCRITTO');
 except
 end;
end;

procedure TW036FTraspDirigenzaDM.DataModuleDestroy(Sender:TObject);
begin
 try
  FreeAndNil(slQualif);
  FreeAndNil(slTipoAmm);
  FreeAndNil(slAmm);
  FreeAndNil(slRuolo);
  FreeAndNil(slUniOrg);
  FreeAndNil(slEmail);
  FreeAndNil(slSito);
  FreeAndNil(slTitStud);
  FreeAndNil(slLingua);
  FreeAndNil(slLivParl);
  FreeAndNil(slLivScr);
 except
 end;
end;

procedure TW036FTraspDirigenzaDM.ImpostaLabelMaxCar(DataSet:TOracleDataSet);
var i:Integer;
begin
  with DataSet do
    for i:=0 to FieldCount - 1 do
      Fields[i].DisplayLabel:=Fields[i].DisplayLabel + IfThen(Fields[i].FieldName = 'TESTO',sMaxCar);
end;

procedure TW036FTraspDirigenzaDM.CaricaListaValori(NomeLogico:String);
var NomeColonnaOrig,I060Email,NomeColonna,Tab,Col,Ord,Storico,Desc,Valore: String;
    Lista:TStringList;
    ListaDesc:Boolean;
begin
  Lista:=RecuperaLista(NomeLogico);
  if Lista = nil then
    exit;
  Lista.Clear;
  Lista.StrictDelimiter:=True;
  NomeColonnaOrig:=VarToStr(selSG215.Lookup('NOME_LOGICO',NomeLogico,'NOME_CAMPO'));
  if NomeColonnaOrig = 'I060EMAIL' then
  begin
    I060Email:=StringReplace(RecuperaI060Email,'; ',',',[rfReplaceAll]);
    if I060Email <> '' then
      Lista.CommaText:=I060Email;
    exit;
  end;
  selListaValori.Close;
  selListaValori.SQL.Clear;
  ListaDesc:=False;//Default
  if NomeColonnaOrig = '' then
  begin
    Tab:='SG216_TRASP_ELENCO_VALORI';
    Col:='VALORE';
    Ord:='ORDINE,' + Col;
    selListaValori.SQL.Add(Format('SELECT %s CODICE FROM %s WHERE NOME_LOGICO = ''%s'' ORDER BY %s',[Col,Tab,NomeLogico,Ord]));
  end
  else if NomeColonnaOrig = NomeLogico then
  begin
    Tab:='SG210_TRASP_ESPERIENZE';
    Col:=NomeLogico;
    Ord:=Col;
    selListaValori.SQL.Add(Format('SELECT DISTINCT %s CODICE FROM %s ORDER BY %s',[Col,Tab,Ord]));
  end
  else
  begin
    ListaDesc:=Copy(NomeColonnaOrig,1,6) = 'T430D_';
    NomeColonna:=StringReplace(NomeColonnaOrig,IfThen(ListaDesc,'T430D_','T430'),'',[rfReplaceAll]);
    A000GetTabella(NomeColonna,Tab,Col,Storico);
    if (Tab <> '') and (Tab <> 'T030_ANAGRAFICO') then
    begin
      //Imposto la colonna Descrizione in base alla tabella di provenienza
      if (Tab = 'T430_STORICO') or (Tab = 'P430_ANAGRAFICO') then
        Desc:='NULL DESCRIZIONE'
      else if Tab = 'T480_COMUNI' then
        Desc:='CITTA DESCRIZIONE'
      else
        Desc:='DESCRIZIONE';
      Ord:=IfThen(ListaDesc,Desc,Col);
      if Storico = 'S' then
      begin
        selListaValori.SQL.Add('SELECT DISTINCT ' + Col + ' CODICE, ' + Desc + ' FROM ' + Tab + ' T1 WHERE ');
        selListaValori.SQL.Add('T1.DECORRENZA = (SELECT MAX(T2.DECORRENZA) FROM ' + Tab + ' T2 WHERE T1.' + Col + ' = T2.' + Col);
        selListaValori.SQL.Add(' AND TO_DATE(''' + FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro) + ''',''dd/mm/yyyy'') BETWEEN T2.DECORRENZA AND T2.DECORRENZA_FINE ) ORDER BY ' + Ord);
      end
      else
        selListaValori.SQL.Add(Format('SELECT DISTINCT %s CODICE, %s FROM %s ORDER BY %s',[Col,Desc,Tab,Ord]));
    end;
  end;
  try
    selListaValori.Open;
    while not selListaValori.Eof do
    begin
      Valore:=selListaValori.FieldByName(IfThen(ListaDesc,'DESCRIZIONE','CODICE')).AsString;
      if (Valore <> '') and (Lista.IndexOf(Valore) < 0) then
        Lista.Add(Valore);
      selListaValori.Next;
    end;
  except
  end;
end;

function TW036FTraspDirigenzaDM.RecuperaLista(NomeLogico:String):TStringList;
begin
  Result:=nil;
  if NomeLogico = 'QUALIFICA' then
    Result:=slQualif
  else if NomeLogico = 'TIPO_AMMINISTRAZIONE' then
    Result:=slTipoAmm
  else if NomeLogico = 'AMMINISTRAZIONE' then
    Result:=slAmm
  else if NomeLogico = 'RUOLO' then
    Result:=slRuolo
  else if NomeLogico = 'UNITA_ORGANIZZATIVA' then
    Result:=slUniOrg
  else if NomeLogico = 'EMAIL_UFFICIO' then
    Result:=slEmail
  else if NomeLogico = 'SITO_WEB' then
    Result:=slSito
  else if NomeLogico = 'TITOLO_STUDIO' then
    Result:=slTitStud
  else if NomeLogico = 'LINGUA' then
    Result:=slLingua
  else if NomeLogico = 'LIVELLO_PARLATO' then
    Result:=slLivParl
  else if NomeLogico = 'LIVELLO_SCRITTO' then
    Result:=slLivScr;
end;

function TW036FTraspDirigenzaDM.RecuperaI060Email:String; //Tratto da TA002FAnagrafeDtM1.Q030CalcFields
var EMail1,EMail2:String;
begin
  Result:='';
  //Costruisco I060EMail
  R180SetVariable(selI060,'Azienda',Parametri.Azienda);
  R180SetVariable(selI060,'Matricola',selAnagrafeW.FieldByName('Matricola').AsString);
  selI060.Open;
  selI060.First;
  while not selI060.Eof do //potrebbero esserci più account per la stessa matricola
  begin
    EMail1:=Trim(selI060.FieldByName('EMAIL').AsString) + ';';
    while Pos(';',EMail1) > 0 do //potrebbero esserci più email per lo stesso account
    begin
      EMail2:=Trim(Copy(EMail1,1,Pos(';',EMail1) - 1));
      if (EMail2 <> '')
      and (Pos(';' + EMail2 + ';',';' + Result) = 0) then
        Result:=Result + EMail2 + ';';
      EMail1:=Copy(EMail1,Pos(';',EMail1) + 1);
    end;
    selI060.Next;
  end;
  Result:=Copy(Result,1,Length(Result) - 1);
  Result:=StringReplace(Result,';','; ',[rfReplaceAll]);
end;

procedure TW036FTraspDirigenzaDM.DataSetNewRecord(DataSet:TDataSet);
begin
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  if (DataSet = selSG210a) or (DataSet = selSG210b) then
    DataSet.FieldByName('INCARICO_ATTUALE').AsString:=IfThen(DataSet = selSG210a,'S','N')
  else if (DataSet = selSG211a) or (DataSet = selSG211b) or (DataSet = selSG211z) then
    DataSet.FieldByName('TIPO').AsString:=IfThen(DataSet = selSG211a,'A',IfThen(DataSet = selSG211b,'B','Z'))
  else if DataSet = selSG213 then
    DataSet.FieldByName('DATA_VALIDITA').AsDateTime:=selSG213.GetVariable('DATA_VALIDITA');
  ImpostaValoreDefault(DataSet as TOracleDataSet);
end;

procedure TW036FTraspDirigenzaDM.ImpostaValoreDefault(DataSet:TOracleDataSet);
var i:Integer;
begin
  //Imposto il valore di default soltanto per i campi previsti sulla SG215
  for i:=0 to DataSet.FieldCount - 1 do
    if (VarToStr(selSG215.Lookup('NOME_LOGICO',DataSet.Fields[i].FieldName,'NOME_LOGICO')) = DataSet.Fields[i].FieldName)
    //il valore di default di TITOLO_STUDIO deve essere impostato solo per le righe di tipo A
    and ((DataSet.Fields[i].FieldName <> 'TITOLO_STUDIO') or (DataSet = selSG211a)) then
      DataSet.Fields[i].AsString:=ValoreDefault(DataSet.Fields[i].FieldName);
end;

function TW036FTraspDirigenzaDM.ValoreDefault(NomeLogico:String):String;
var NomeCampo:String;
    DataOggi,DataScad:TDateTime;
begin
  //Recupero il valore
  Result:=VarToStr(selSG215.Lookup('NOME_LOGICO',NomeLogico,'VAL_DEFAULT'));
  if (Copy(Result,1,4) = 'T430') or (Copy(Result,1,6) = 'DECODE') then
  begin
    NomeCampo:=IfThen(Copy(Result,1,6) = 'DECODE',StringReplace(NomeLogico,'#','',[rfReplaceAll]),Result);
    Result:=selV430a.FieldByName(NomeCampo).AsString;
    if NomeLogico = 'DECORRENZA' then
      with selV430b do
      begin
        SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('NOMECAMPO',NomeCampo);
        SetVariable('DEC_ATTUALE',selV430a.FieldByName('T430DATADECORRENZA').AsDateTime);
        SetVariable('VAL_ATTUALE',Result);
        Result:='';
        try
          Execute;
          Result:=FieldAsString(0);
        except
        end;
      end;
  end
  else if Result = 'I060EMAIL' then
    Result:=RecuperaI060Email;
  //Manipolo il valore
  if NomeLogico = 'DECORRENZA' then
    try
      StrToDate(Result);
    except
      Result:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
    end
  else if NomeLogico = '#DICHIARAZIONE_DATA_SCADENZA' then
  begin
    try
      if (Length(Result) = 5) and (Copy(Result,3,1) = '/')  then
      begin
        DataOggi:=Trunc(R180Sysdate(SessioneOracle));
        DataScad:=StrToDate(Result + '/' + IntToStr(R180Anno(DataOggi)));//dd/mm + /yyyy
        if DataOggi <= DataScad then //torno indietro di un anno se la scadenza quest'anno non è ancora stata superata
          DataScad:=StrToDate(Result + '/' + IntToStr(R180Anno(DataOggi) - 1));//dd/mm + /yyyy (anno prec)
      end
      else
        DataScad:=StrToDate(Result);//dd/mm/yyyy
    except
      DataScad:=1;//31/12/1899
    end;
    Result:=FormatDateTime('dd/mm/yyyy',DataScad);
  end;
end;

function TW036FTraspDirigenzaDM.AbilitaDichiarazioni(NomeLogico:String):Boolean;
var NomeCampo:String;
begin
  NomeCampo:=VarToStr(selSG215.Lookup('NOME_LOGICO',NomeLogico,'NOME_CAMPO'));
  Result:=(NomeCampo = '') or R180InConcat(VarToStr(selV430a.FieldByName(NomeCampo).AsString),ValoreDefault(NomeLogico));
end;

function TW036FTraspDirigenzaDM.OrdineSuccessivo(OQ:TOracleQuery;Tipo:String;Prog:Integer;Data:TDateTime):Integer;
begin
  with OQ do
  begin
    if VariableIndex('TIPO') >= 0 then
      SetVariable('TIPO',Tipo);
    SetVariable('PROGRESSIVO',Prog);
    if VariableIndex('DECORRENZA') >= 0 then
      SetVariable('DECORRENZA',Data);
    Execute;
    Result:=Field(0);
  end;
  inc(Result);
end;

procedure TW036FTraspDirigenzaDM.EsperienzeCalcFields(DataSet:TDataSet);
begin
  selT480.Filtered:=False;
  DataSet.FieldByName('D_COMUNE').AsString:=VarToStr(selT480.Lookup('CODICE',DataSet.FieldByName('COMUNE').AsString,'CITTA'));
  DataSet.FieldByName('D_PROVINCIA').AsString:=VarToStr(selT480.Lookup('CODICE',DataSet.FieldByName('COMUNE').AsString,'PROVINCIA'));
end;

procedure TW036FTraspDirigenzaDM.DataSetControlloSezioniObbligatorie(DataSet: TDataSet);
var MancaIncAtt,MancaTitStud,Manca2Sez:Boolean;
    MancaIncomp,MancaInconf,Manca2Dich:Boolean;
    s:String;
begin
  MancaIncAtt:=selSG210a.RecordCount = 0;
  MancaTitStud:=selSG211a.RecordCount = 0;
  Manca2Sez:=MancaIncAtt and MancaTitStud;
  MancaIncomp:=AbilitaDichiarazioni('#INCOMPATIBILITA') and (selSG213.RecordCount > 0) and selSG213.FieldByName('DATA_COMPILAZIONE').IsNull;
  MancaInconf:=AbilitaDichiarazioni('#INCONFERIBILITA') and (selSG213.RecordCount > 0) and selSG213.FieldByName('DATA_COMPILAZIONE').IsNull;
  Manca2Dich:=MancaIncomp and MancaInconf;
  if MancaIncAtt or MancaTitStud or MancaIncomp or MancaInconf then
  begin
    s:='Attenzione!';
    if MancaIncAtt or MancaTitStud then
      s:=s + ' Ricordarsi di compilare l' + IfThen(Manca2Sez,'e','a') + ' sezion' + IfThen(Manca2Sez,'i','e') + IfThen(MancaIncAtt,' "Incarico attuale"') + IfThen(Manca2Sez,' e') + IfThen(MancaTitStud,' "Titolo di studio"') + '!';
    if MancaIncomp or MancaInconf then
      s:=s + IfThen(MancaIncAtt or MancaTitStud,CRLF) + ' E'' necessario stampare l' + IfThen(Manca2Dich,'e','a') + ' dichiarazion' + IfThen(Manca2Dich,'i','e') + ' di' + IfThen(MancaIncomp,' "Incompatibilità"') + IfThen(Manca2Dich,' e') + IfThen(MancaInconf,' "Inconferibilità"') + ' aggiornat' + IfThen(Manca2Dich,'e','a') + '!';
    MsgBox.WebMessageDlg(s,mtWarning,[mbOK],nil,'');
  end;
end;

procedure TW036FTraspDirigenzaDM.DataSetBeforePost(DataSet:TDataSet);
var OQ:TOracleQuery;
    Tipo,CampoObbl,CampoInvalido:String;
    Data:TDateTime;
    DataVariata:Boolean;
begin
  { TODO : TEST IW 15 }
  with DataSet do
  begin
    OQ:=nil;
    DataVariata:=False;
    if (DataSet = selSG210a) or (DataSet = selSG210b) then
    begin
      OQ:=selSG210OrdSucc;
      Data:=FieldByName('DECORRENZA').AsDateTime;
      DataVariata:=FieldByName('DECORRENZA').AsDateTime <> FieldByName('DECORRENZA').OldValue;
    end
    else if (DataSet = selSG211a) or (DataSet = selSG211b) or (DataSet = selSG211z) then
    begin
      OQ:=selSG211OrdSucc;
      Tipo:=FieldByName('TIPO').AsString;
    end;
    if (OQ <> nil) and ((State = dsInsert) or DataVariata) then
      FieldByName('ORDINE').AsInteger:=OrdineSuccessivo(OQ,Tipo,FieldByName('PROGRESSIVO').AsInteger,Data);
  end;
  CampoObbl:=ControlloCampiObbligatori(DataSet,DataSet);
  if CampoObbl <> '' then
    raise exception.Create('Il campo "' + CampoObbl + '" è obbligatorio.');
  CampoInvalido:=ControlloValoreDaElenco(DataSet);
  if CampoInvalido <> '' then
    raise exception.Create('Il valore indicato nel campo "' + CampoInvalido + '" non è valido. Selezionarne uno dalla lista.');
  with DataSet do
    if DataSet = selSG210a then
    begin
      if State = dsInsert then
        if (DataOldIncAtt <> 0) and (DataOldIncAtt > Data) then
          raise exception.Create('La decorrenza del nuovo "Incarico attuale" (' + FormatDateTime('dd/mm/yyyy',Data) + ') non può essere inferiore a quella indicata in precedenza (' + FormatDateTime('dd/mm/yyyy',DataOldIncAtt) + ')!');
    end
    else if DataSet = selSG210b then
    begin
      if FieldByName('DECORRENZA').AsDateTime > FieldByName('DECORRENZA_FINE').AsDateTime then
        raise exception.Create('Le date devono essere in ordine cronologico!');
    end
    else if DataSet = selSG213 then
      FieldByName('DATA_COMPILAZIONE').AsDateTime:=R180SysDate(SessioneOracle);
end;

function TW036FTraspDirigenzaDM.ControlloCampiObbligatori(DataSetCampi,DataSetValori:TDataSet):String;
var i:Integer;
begin
  //DataSetCampi e DataSetValori possono essere diversi solo quando hanno la stessa struttura (es. selSG210a e selSG210b)
  //I campi obbligatori di DataSetCampi che non devono essere controllati su DataSetValori devono essere impostati a ReadOnly su DataSetValori (es. DECORRENZA_FINE)
  Result:='';
  for i:=0 to DataSetCampi.FieldCount - 1 do
    if (Pos(sObbl,DataSetCampi.Fields[i].DisplayLabel) > 0)
    and not DataSetValori.Fields[i].ReadOnly
    and (Trim(DataSetValori.Fields[i].AsString) = '') then
    begin
      Result:=StringReplace(DataSetCampi.Fields[i].DisplayLabel,sObbl,'',[rfReplaceAll]);
      Result:=StringReplace(Result,sMaxCar,'',[rfReplaceAll]);
      Exit;
    end;
end;

function TW036FTraspDirigenzaDM.ControlloValoreDaElenco(DataSet:TDataSet):String;
var i:Integer;
    Lista:TStringList;
begin
  Result:='';
  for i:=0 to DataSet.FieldCount - 1 do
    if VarToStr(selSG215.Lookup('NOME_LOGICO',DataSet.Fields[i].FieldName,'CTRL_VALORE_DA_ELENCO')) = 'S' then
    begin
      Lista:=RecuperaLista(DataSet.Fields[i].FieldName);
      if (Lista <> nil)
      and not DataSet.Fields[i].IsNull
      and (Lista.IndexOf(DataSet.Fields[i].AsString) < 0) then
      begin
        Result:=StringReplace(DataSet.Fields[i].DisplayLabel,sObbl,'',[rfReplaceAll]);
        Result:=StringReplace(Result,sMaxCar,'',[rfReplaceAll]);
        Exit;
      end;
    end;
end;

procedure TW036FTraspDirigenzaDM.selSG212PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if Pos('ORA-00001',E.Message) > 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La lingua selezionata è già stata caricata per il dipendente corrente!');
    Abort;
  end;
end;

procedure TW036FTraspDirigenzaDM.selSG213INCONFERIBILITAChange(Sender: TField);
  procedure RendiCampoObbligatorio(NomeCampo:String;Obbligatorio:Boolean);
  var sOrig:String;
  begin
    sOrig:=StringReplace(selSG213.FieldByName(NomeCampo).DisplayLabel,sObbl,'',[rfReplaceAll]);
    sOrig:=StringReplace(sOrig,sMaxCar,'',[rfReplaceAll]);
    selSG213.FieldByName(NomeCampo).DisplayLabel:=sOrig + IfThen(Obbligatorio,sObbl) + IfThen(NomeCampo = 'TESTO',sMaxCar);
  end;
begin
  RendiCampoObbligatorio('INCONF_RUOLO',AbilitaDichiarazioni('#INCONFERIBILITA') and (selSG213.FieldByName('INCONFERIBILITA').AsString = 'S'));
  RendiCampoObbligatorio('INCONF_AMMINISTRAZIONE',AbilitaDichiarazioni('#INCONFERIBILITA') and (selSG213.FieldByName('INCONFERIBILITA').AsString = 'S'));
end;

end.

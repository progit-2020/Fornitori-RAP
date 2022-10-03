unit A112UInvioMessaggiMW;

interface

uses
  System.SysUtils, System.Classes, DB, OracleData, Datasnap.DBClient, Forms,
  R005UDataModuleMW, R110UCreazioneFileMessaggi,
  A000UInterfaccia, A000UMessaggi, A000USessione,
  C180FunzioniGenerali, RegistrazioneLog;

type
  TAssegnaPickList = procedure(Tipo:String) of object;
  T112Dlg = procedure(msg,Chiave:String) of object;
  T112Inf = procedure(msg:String) of object;
  T112ClearKeys = procedure of object;

  TA112FInvioMessaggiMW = class(TR005FDataModuleMW)
    selT295: TOracleDataSet;
    selT295PROGRESSIVO: TFloatField;
    selT295MATRICOLA: TStringField;
    selT295NOMINATIVO: TStringField;
    selT295DATA_MSG: TDateTimeField;
    selT295ORA_MSG: TDateTimeField;
    selT295DATA_SCAD_MSG: TDateTimeField;
    selT295OPERATORE: TStringField;
    selT295TESTO_MSG: TStringField;
    dsrT295: TDataSource;
    selT265T275: TOracleDataSet;
    selT291: TOracleDataSet;
    selT291CODICE: TStringField;
    selT291DESCRIZIONE: TStringField;
    selT291TIPO_FILE: TStringField;
    selT291NOME_FILE: TStringField;
    selT291DATA_FILE: TStringField;
    selT291DEFAULT_FILE: TStringField;
    selT291NUM_RIPET_MSG: TFloatField;
    selT291NUM_GGVAL_MSG: TFloatField;
    selT291NUM_MMIND_CONS: TFloatField;
    selT291FILTRO_ANAGR: TStringField;
    selT291TIPO_FILTRO: TStringField;
    selT291REGISTRA_MSG: TStringField;
    selT291TIPO_REGISTRAZIONE: TStringField;
    dsrT291: TDataSource;
    selT292: TOracleDataSet;
    dsrT292: TDataSource;
    selC292: TClientDataSet;
    selC292TIPO_RECORD: TStringField;
    selC292NUMERO_RECORD: TIntegerField;
    selC292TIPO: TStringField;
    selC292POSIZIONE: TIntegerField;
    selC292LUNGHEZZA: TIntegerField;
    selC292NOME_COLONNA: TStringField;
    selC292FORMATO: TStringField;
    selC292VALORE_DEFAULT: TStringField;
    selC292NOME_DATO: TStringField;
    selC292CODICE_DATO: TStringField;
    selC292CHIAVE: TStringField;
    dsrC292: TDataSource;
    QSelect: TOracleDataSet;
    selODS: TOracleDataSet;
    selT002: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selC292AfterScroll(DataSet: TDataSet);
    procedure selC292BeforeDelete(DataSet: TDataSet);
    procedure selC292VALORE_DEFAULTValidate(Sender: TField);
    procedure selT295BeforeEdit(DataSet: TDataSet);
    procedure selT295BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
    procedure CaricaPickList;
  public
    { Public declarations }
    INIZ:Boolean;
    sSkippa,Chiamante:String;
    DHMess,DMess,HMess,DCons,DScad:TDateTime;
    NRip,Param,NomeFileParam:String;
    iFileEsistente:Integer;
    MantieniMsg:Boolean;
    R110FCreazioneFileMessaggi:TR110FCreazioneFileMessaggi;
    PLDefaultVal,PLCodDato:TStringList;
    AssegnaPickList: TAssegnaPickList;
    evtRichiesta:T112Dlg;
    evtInforma:T112Inf;
    evtClearKeys:T112ClearKeys;
    procedure RefreshT295(Data:TDateTime);
    procedure CaricaTabellaTemp(Parametri:String);
    procedure PreparaInviaMessaggi;
    procedure InviaMessaggi;
    procedure CaricaValore;
    function LeggiMessaggiDaTabella(Nome:String):TStringList;
    procedure PulisciVariabili;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA112FInvioMessaggiMW.DataModuleCreate(Sender: TObject);
begin
  Parametri.Applicazione:='RILPRE';
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  INIZ:=False;
  R110FCreazioneFileMessaggi:=TR110FCreazioneFileMessaggi.Create(nil);
  selT265T275.Open;
  CaricaPickList;
  selT291.Open;
  selT292.SetVariable('CODICE_PARM',selT291.FieldByName('CODICE').AsString);
  selT292.Open;
  selC292.CreateDataSet;
  PulisciVariabili;
end;

procedure TA112FInvioMessaggiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(R110FCreazioneFileMessaggi);
  FreeAndNil(PLDefaultVal);
  FreeAndNil(PLCodDato);
  inherited;
end;

procedure TA112FInvioMessaggiMW.CaricaPickList;
begin
  inherited;
  //Default valore: da tenere allineata sul A111MW
  PLDefaultVal:=TStringList.Create;
  PLDefaultVal.Add('ASS_COMPPREC');
  PLDefaultVal.Add('ASS_COMPCORR');
  PLDefaultVal.Add('ASS_COMPTOT');
  PLDefaultVal.Add('ASS_FRUITOPREC');
  PLDefaultVal.Add('ASS_FRUITOCORR');
  PLDefaultVal.Add('ASS_FRUITOTOT');
  PLDefaultVal.Add('ASS_RESIDUOPREC');
  PLDefaultVal.Add('ASS_RESIDUOCORR');
  PLDefaultVal.Add('ASS_RESIDUOTOT');
  PLDefaultVal.Add('ASS_GG_RESIDUOPREC');
  PLDefaultVal.Add('ASS_GG_RESIDUOCORR');
  PLDefaultVal.Add('ASS_GG_RESIDUOTOT');
  PLDefaultVal.Add('PRES_RESO_MESE');
  PLDefaultVal.Add('PRES_RESIDUO');
  PLDefaultVal.Add('SALDOMMCOR');
  PLDefaultVal.Add('SALDOAACORR');
  PLDefaultVal.Add('SALDOAAPREC');
  PLDefaultVal.Add('SALDOTOT');
  PLDefaultVal.Add('SALDOTOTNEG');
  PLDefaultVal.Add('RECUPERO_MOBILE');
  PLDefaultVal.Add('BANCAORE_RESIDUA');
  PLDefaultVal.Add('DEBITO_CREDITO');
  PLDefaultVal.Add('DATI_GG_ORARIO');
  PLDefaultVal.Add('DATI_GG_ANOMALIA1');
  PLDefaultVal.Add('DATI_GG_DEBITO');
  PLDefaultVal.Add('DATI_GG_HHPRESENZA');
  PLDefaultVal.Add('DATI_GG_HHASSENZA');
  PLDefaultVal.Add('DATI_GG_SCOST');
  PLDefaultVal.Add('DATI_GG_SCOSTNEG');
  PLDefaultVal.Add('DATI_GG_RIEPASS');
  PLDefaultVal.Add('DATI_GG_RIEPPRES');
  //Cod. dato
  PLCodDato:=TStringList.Create;
  selT265T275.First;
  while not selT265T275.Eof do
  begin
    PLCodDato.Add(selT265T275.FieldByName('CAUSALE').AsString);
    selT265T275.Next;
  end;
end;

procedure TA112FInvioMessaggiMW.selC292AfterScroll(DataSet: TDataSet);
begin
  if Assigned(AssegnaPickList) then
    AssegnaPickList(selC292.FieldByName('TIPO').AsString);
end;

procedure TA112FInvioMessaggiMW.selC292BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA112FInvioMessaggiMW.selC292VALORE_DEFAULTValidate(Sender: TField);
begin
  if (selC292.FieldByName('TIPO').AsString = 'VL')
  and (R180IndexOf(PLDefaultVal,UpperCase(selC292.FieldByName('VALORE_DEFAULT').AsString),255) = -1) then
    raise Exception.Create(A000MSG_A112_ERR_DEFAULT);
  if (selC292.FieldByName('TIPO').AsString = 'DE') and
     (Length(selC292.FieldByName('VALORE_DEFAULT').AsString) > (selC292.FieldByName('LUNGHEZZA').AsInteger)) then
    raise Exception.Create(Format(A000MSG_A112_ERR_FMT_CARATTERI,[IntToStr(selC292.FieldByName('LUNGHEZZA').AsInteger)]));
end;

procedure TA112FInvioMessaggiMW.RefreshT295(Data:TDateTime);
var Filtro:String;
begin
  Filtro:='';
  if (SelAnagrafe.SQL.Text <> '') and (Pos('ORDER BY',SelAnagrafe.SQL.Text) <> 1) then
  begin
    if Pos('ORDER BY',SelAnagrafe.SQL.Text) > 0 then
      Filtro:=' AND ' + StringReplace(Copy(SelAnagrafe.SQL.Text,Pos('WHERE ',SelAnagrafe.SQL.Text) + 6,Pos('ORDER BY', SelAnagrafe.SQL.Text) - (Pos('WHERE ',SelAnagrafe.SQL.Text) + 6)),':DataLavoro','T295.DATA_MSG',[rfIgnoreCase,rfReplaceAll])
    else
      Filtro:=' AND ' + StringReplace(Copy(SelAnagrafe.SQL.Text,Pos('WHERE ',SelAnagrafe.SQL.Text) + 6,Length(SelAnagrafe.SQL.Text) - (Pos('WHERE ',SelAnagrafe.SQL.Text) + 6)),':DataLavoro','T295.DATA_MSG',[rfIgnoreCase,rfReplaceAll]);
  end;
  if Filtro = ' AND ' then
    Filtro:='';
  with selT295 do
  begin
    Close;
    SetVariable('FILTRO',Filtro);
    SetVariable('DATA',Data);
    Open;
  end;
end;

procedure TA112FInvioMessaggiMW.selT295BeforeEdit(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA112FInvioMessaggiMW.selT295BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA112FInvioMessaggiMW.CaricaTabellaTemp(Parametri:String);
var i:integer;
    MaxSize:Integer;
begin
  i:=0;
  selT292.First;
  MaxSize:=0;
  while not selT292.Eof do
  begin
    if selT292.FieldByName('LUNGHEZZA').AsInteger > MaxSize then
      MaxSize:=selT292.FieldByName('LUNGHEZZA').AsInteger;
    if Length(selT292.FieldByName('VALORE_DEFAULT').AsString) > MaxSize then
      MaxSize:=Length(selT292.FieldByName('VALORE_DEFAULT').AsString);
    selT292.Next;
  end;
  selT292.First;
  with selC292 do
  begin
    Close;
    FieldByName('VALORE_DEFAULT').Size:=MaxSize;
    CreateDataSet;
    BeforeInsert:=nil;
    FieldByName('VALORE_DEFAULT').OnValidate:=nil;//DAnilo 9/12/13: se c'è un vecchio valore errato, l'OnValidate blocca tutto
    Open;
    LogChanges:=False;
    while not selT292.Eof do
    begin
      Append;
      FieldByName('TIPO_RECORD').AsString:=selT292.FieldByName('TIPO_RECORD').AsString;
      FieldByName('NUMERO_RECORD').Value:=selT292.FieldByName('NUMERO_RECORD').AsString;
      FieldByName('POSIZIONE').AsString:=selT292.FieldByName('POSIZIONE').AsString;
      FieldByName('LUNGHEZZA').AsString:=selT292.FieldByName('LUNGHEZZA').AsString;
      FieldByName('NOME_COLONNA').AsString:=selT292.FieldByName('NOME_COLONNA').AsString;
      FieldByName('TIPO').AsString:=selT292.FieldByName('TIPO').AsString;
      FieldByName('FORMATO').AsString:=selT292.FieldByName('FORMATO').AsString;
      if (FieldByName('TIPO').AsString = 'VL') or (FieldByName('TIPO').AsString = 'DE') then
      begin
        inc(i);
        if FieldByName('NOME_COLONNA').AsString = '*' then
          FieldByName('NOME_DATO').AsString:='DATO' + IntToStr(i)
        else
          FieldByName('NOME_DATO').AsString:=FieldByName('NOME_COLONNA').AsString + IntToStr(i);
      end;
      FieldByName('VALORE_DEFAULT').AsString:=selT292.FieldByName('VALORE_DEFAULT').AsString;
      FieldByName('CODICE_DATO').AsString:=selT292.FieldByName('CODICE_DATO').AsString;
      FieldByName('CHIAVE').AsString:=selT292.FieldByName('CHIAVE').AsString;
      selT292.Next;
      Post;
    end;
    BeforeInsert:=selC292BeforeDelete;
    FieldByName('VALORE_DEFAULT').OnValidate:=selC292VALORE_DEFAULTValidate;//DAnilo 9/12/13
    First;
    Filter:='(TIPO = ''DE'') OR (TIPO = ''VL'')';
    Filtered:=True;
    INIZ:=True;
  end;
end;

procedure TA112FInvioMessaggiMW.PreparaInviaMessaggi;
begin
  if (selT291.FieldByName('TIPO_FILTRO').AsString = '0') and (SelAnagrafe.RecordCount = 0) then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_A112_DLG_NO_ANAGRAFICHE,'NoAnagrafiche');
  //Lettura query personalizzate (black list / white list)
  if selT291.FieldByName('TIPO_FILTRO').AsString = '1' then
  begin
    selT002.SetVariable('NOME',selT291.FieldByName('FILTRO_ANAGR').AsString);
    selT002.Close;
    selT002.Open;
    if selT002.RecordCount = 0 then
    begin
      PulisciVariabili;
      raise exception.Create(A000MSG_A112_ERR_NO_SELEZIONE);
    end
    else
    begin
      selODS.Close;
      selODS.SQL.Clear;
      while not selT002.Eof do
      begin
        selODS.SQL.Add(selT002.FieldByName('RIGA').AsString);
        selT002.Next;
      end;
      selODS.Open;
    end;
  end;
  selC292.DisableControls;
  selC292.Filter:='';
  selC292.Filtered:=False;
  CaricaValore;
// richiamo procedura 'Creazione file messaggi'
  with R110FCreazioneFileMessaggi do
  begin
    SelT292:=selC292;
    if selT291.FieldByName('TIPO_FILTRO').AsString = '0' then
      SelC700:=SelAnagrafe
    else
      SelC700:=selODS;
    if SelC700.RecordCount > 1 then
      if Assigned(evtRichiesta) then
        evtRichiesta(Format(A000MSG_A112_DLG_FMT_ESEGUI,[IntToStr(SelC700.RecordCount)]),'Elabora');
    INIZ:=True;
    RefreshT295(DMess);
    selT295:=Self.selT295;
    TipoFile:=selT291.FieldByName('TIPO_FILE').AsString;
    TipoScrittura:=iFileEsistente;
    NomeFile:=NomeFileParam;
    Parametrizzazione:=Param;
    DataConsuntivo:=DCons;
    DataMessaggio:=DMess;
    DataScadenza:=DScad;
    OraMessaggio:=HMess;
    RegistraMSG:=selT291.FieldByName('REGISTRA_MSG').AsString;
    if (SelC700.RecordCount = 1) and (RegistraMSG = 'S') and MantieniMsg then
      if selT295.SearchRecord('PROGRESSIVO',selC700.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        if Assigned(evtRichiesta) then
          evtRichiesta(A000MSG_A112_DLG_SOVRASCRIVI_MSG,'EsisteMessaggio');
    if sSkippa = '' then
      Skippa:=MantieniMsg
    else
      Skippa:=sSkippa = 'S';
  end;
end;

procedure TA112FInvioMessaggiMW.InviaMessaggi;
begin
  //RegistraMsg.IniziaMessaggio(Chiamante);
  (A000SessioneIrisWIN.RegistraMsg as TRegistraMsg).IniziaMessaggio(Chiamante);
  R110FCreazioneFileMessaggi.Elabora;
  if Assigned(evtInforma) then
    evtInforma(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  PulisciVariabili;
end;

procedure TA112FInvioMessaggiMW.CaricaValore;
var OffsetGG,OffsetMM:Integer;
    D:TDateTime;
    F:String;
  function GetOffset(S,Tipo:String):Integer;
  begin
    Result:=0;
    if S = '' then exit;
    S:=UpperCase(S);
    if Copy(S,Length(S),1) = Tipo then
      Result:=StrToIntDef(Copy(S,1,Length(S) - 1),0);
  end;
  procedure Aggiorna(S:String);
  begin
    with selC292 do
    begin
      Edit;
      FieldByName('VALORE_DEFAULT').AsString:=S;
      Post;
    end;
  end;
begin
  D:=0;
  // impostazione Valore_Default per dati 'variabili'
  with selC292 do
  begin
    First;
    selT292.First;
    while not Eof do
    begin
      OffsetGG:=GetOffset(FieldByName('CODICE_DATO').AsString,'G');
      OffsetMM:=GetOffset(FieldByName('CODICE_DATO').AsString,'M');
      if FieldByName('TIPO').AsString = 'DT' then
        D:=R180AddMesi(DHMess + OffsetGG,OffsetMM)
      else if FieldByName('TIPO').AsString = 'DC' then
        D:=R180AddMesi(DCons + OffsetGG,OffsetMM)
      else if FieldByName('TIPO').AsString = 'DS' then
        D:=R180AddMesi(DScad + OffsetGG,OffsetMM);
      if (FieldByName('TIPO').AsString = 'DT') or (FieldByName('TIPO').AsString = 'DC') or (FieldByName('TIPO').AsString = 'DS') then
      begin
        F:=FieldByName('FORMATO').AsString;
        if Pos('31',F) > 0 then
        begin
          D:=R180FineMese(D);
          F:=StringReplace(F,'31','dd',[]);
        end;
        if F = UpperCase(F) then
          Aggiorna(UpperCase(FormatDateTime(F,D)))
        else
          Aggiorna(FormatDateTime(F,D));
      end
      else if FieldByName('TIPO').AsString = 'NR' then
        Aggiorna(NRip);
      Next;
      selT292.Next;
    end;
  end;
end;

function TA112FInvioMessaggiMW.LeggiMessaggiDaTabella(Nome:String):TStringList;
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

procedure TA112FInvioMessaggiMW.PulisciVariabili;
begin
  sSkippa:='';
  if Assigned(evtClearKeys) then
    evtClearKeys;
  with selC292 do
  begin
    EnableControls;
    Filter:='(TIPO = ''DE'') OR (TIPO = ''VL'')';
    Filtered:=True;
  end;
end;

end.

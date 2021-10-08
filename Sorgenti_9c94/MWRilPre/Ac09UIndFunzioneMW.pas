unit Ac09UIndFunzioneMW;

interface

uses
  Data.DB, OracleData, System.Classes, Oracle, System.SysUtils, System.Variants, System.Math, StrUtils,
  A000UInterfaccia, A000UMessaggi, A000USessione, R005UDataModuleMW, C180FunzioniGenerali, DatiBloccati,
  RegistrazioneLog;

type
  TAssegnaProc = procedure(Assegna:Boolean) of object;

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  TAc09FIndFunzioneMW = class(TR005FDataModuleMW)
    selCSI007: TOracleDataSet;
    dsrCSI007: TDataSource;
    selCSI007ID: TFloatField;
    selCSI007TIPO_RECORD: TStringField;
    selCSI007FASCIA: TStringField;
    selCSI007ORE: TStringField;
    selCSI007DISAGIO_SERALE: TStringField;
    selCSI007INDFUNZIONE: TStringField;
    selCSI004: TOracleDataSet;
    selbCSI007: TOracleDataSet;
    dsrCodice: TDataSource;
    selCodice: TOracleDataSet;
    selCodiceCODICE: TStringField;
    selCodiceDESCRIZIONE: TStringField;
    selCSI007D_INDFUNZIONE: TStringField;
    selbCSI006: TOracleDataSet;
    selbCSI006PROGRESSIVO: TFloatField;
    selbCSI006MATRICOLA: TStringField;
    selbCSI006COGNOME: TStringField;
    selbCSI006NOME: TStringField;
    selbCSI006CONTRATTO: TStringField;
    selbCSI006FASCIA: TStringField;
    selbCSI006TIPO_RECORD: TStringField;
    selbCSI006INDFUNZIONE: TStringField;
    selbCSI006SUM_ORE: TStringField;
    selbCSI006SUM_DISAGIO_SERALE: TStringField;
    dsrbCSI006: TDataSource;
    selbCSI006D_INDFUNZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selCodiceFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selCSI007BeforeDelete(DataSet: TDataSet);
    procedure selCSI007BeforeEdit(DataSet: TDataSet);
    procedure selCSI007BeforeInsert(DataSet: TDataSet);
    procedure selCSI007NewRecord(DataSet: TDataSet);
    procedure selCSI007BeforePost(DataSet: TDataSet);
    procedure selCSI007AfterPost(DataSet: TDataSet);
    procedure selCSI007ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selCSI007TranslateMessage(Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: string; Action: Char; var Msg: string);
    procedure selCSI007INDFUNZIONEValidate(Sender: TField);
    procedure selCSI007OREValidate(Sender: TField);
  private
    Azione:String;
    RegistraLogCSI007:TRegistraLog;
    selDatiBloccati: TDatiBloccati;
    procedure DatoBloccato;
  public
    selCSI006: TOracleDataset;
    TotOreInd,TotOreDisSer,TotOreIndOld,TotOreDisSerOld:Integer;
    ElencoDate: array of TElencoDate;
    evtAssegnaProc: TAssegnaProc;
    procedure CaricamentoDati(Query: TOracleDataSet; ParametriDato: String; Decorrenza: TDateTime);
    procedure ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
    procedure AggiornaCSI006;
    procedure CaricaElencoDate;
    procedure selCSI006AfterScroll;
    procedure selCSI006CalcFields;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TAc09FIndFunzioneMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  RegistraLogCSI007:=TRegistraLog.Create(nil);
  RegistraLogCSI007.Session:=SessioneOracle;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='';
  if Parametri.CampiRiferimento.C3_Indennita_Funzione <> '' then
  begin
    selCSI007.FieldByName('D_INDFUNZIONE').FieldKind:=fkLookup;
    selCSI007.FieldByName('D_INDFUNZIONE').LookupDataset:=selCodice;
    selCSI007.FieldByName('D_INDFUNZIONE').KeyFields:='INDFUNZIONE';
    selCSI007.FieldByName('D_INDFUNZIONE').LookupKeyFields:='CODICE';
    selCSI007.FieldByName('D_INDFUNZIONE').LookupResultField:='DESCRIZIONE';
    selbCSI006.FieldByName('D_INDFUNZIONE').FieldKind:=fkLookup;
    selbCSI006.FieldByName('D_INDFUNZIONE').LookupDataset:=selCodice;
    selbCSI006.FieldByName('D_INDFUNZIONE').KeyFields:='INDFUNZIONE';
    selbCSI006.FieldByName('D_INDFUNZIONE').LookupKeyFields:='CODICE';
    selbCSI006.FieldByName('D_INDFUNZIONE').LookupResultField:='DESCRIZIONE';
    CaricamentoDati(selCodice,Parametri.CampiRiferimento.C3_Indennita_Funzione,Parametri.DataLavoro);
    dsrCodice.DataSet:=selCodice;
  end
  else
  begin
    selCSI007.FieldByName('D_INDFUNZIONE').Free;
    selbCSI006.FieldByName('D_INDFUNZIONE').Free;
  end;
end;

procedure TAc09FIndFunzioneMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
  FreeAndNil(RegistraLogCSI007);
  inherited;
end;

procedure TAc09FIndFunzioneMW.CaricamentoDati(Query: TOracleDataSet; ParametriDato:String; Decorrenza: TDateTime);
begin
  if A000LookupTabella(ParametriDato,Query) then
    ImpostaDecorrenza(Query,Decorrenza);
end;

procedure TAc09FIndFunzioneMW.ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
begin
  if Parametri.CampiRiferimento.C3_Indennita_Funzione = '' then
    exit;
  if Query.VariableIndex('DECORRENZA') >= 0 then
    Query.SetVariable('DECORRENZA',Decorrenza);
  Query.Close;
  Query.Open;
end;

procedure TAc09FIndFunzioneMW.selCodiceFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=False;
  if selCSI004.Active then
    Accept:=VarToStr(selCSI004.Lookup('CODICE',DataSet.FieldByName('CODICE').AsString,'CODICE')) = DataSet.FieldByName('CODICE').AsString;
end;

procedure TAc09FIndFunzioneMW.AggiornaCSI006;
var BM:TBookMark;
begin
  BM:=selCSI006.GetBookmark;
  try { TODO : TEST IW 15 }
    selCSI006.Refresh;
    selCSI006.GotoBookmark(BM);
  finally
    selCSI006.FreeBookmark(BM);
  end;
  selbCSI006.Refresh;
end;

procedure TAc09FIndFunzioneMW.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  for i:=0 to High(ElencoDate) do
  begin
    ElencoDate[i].Data:=0;
    ElencoDate[i].Colorata:=False;
  end;
  SetLength(ElencoDate,0);
  i:=0;
  with selCSI006 do
  begin
    if RecordCount = 0 then
      exit;

    if Assigned(evtAssegnaProc) then
      evtAssegnaProc(False);
    selCSI006.AfterScroll:=nil;
    selCSI006.OnCalcFields:=nil;
    Puntatore:=GetBookmark;
	try
	  { TODO : TEST IW 15 }
      DisableControls;
      First;
      SetLength(ElencoDate,i + 1);
      ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
      inc(i);
      while not Eof do
      begin
        if ElencoDate[i - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          SetLength(ElencoDate,i + 1);
          ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      if Assigned(evtAssegnaProc) then
        evtAssegnaProc(True);
      GotoBookmark(Puntatore);
	finally
      FreeBookmark(Puntatore);
	end;
    EnableControls;
  end;
end;

procedure TAc09FIndFunzioneMW.selCSI006AfterScroll;
begin
  TotOreInd:=R180OreMinuti(selCSI006.FieldByName('SUM_ORE').AsString);
  TotOreDisSer:=R180OreMinuti(selCSI006.FieldByName('SUM_DISAGIO_SERALE').AsString);
  R180SetVariable(selCSI004,'CONTRATTO',selCSI006.FieldByName('CONTRATTO').AsString);
  R180SetVariable(selCSI004,'DATA',selCSI006.FieldByName('DATA').AsDateTime);
  selCSI004.Open;
  ImpostaDecorrenza(selCodice,selCSI006.FieldByName('DATA').AsDateTime);
  selCSI007.Close;
  selCSI007.SetVariable('ID',selCSI006.FieldByName('ID').AsInteger);
  selCSI007.SetVariable('TIPO_RECORD',selCSI006.FieldByName('TIPO_RECORD').AsString);
  selCSI007.SetVariable('FASCIA',selCSI006.FieldByName('FASCIA').AsString);
  selCSI007.Open;
end;

procedure TAc09FIndFunzioneMW.selCSI006CalcFields;
begin
  if selCSI006.FieldByName('TIPO_RECORD').AsString = 'M' then
  begin
    selbCSI007.Close;
    selbCSI007.SetVariable('ID',selCSI006.FieldByName('ID').AsFloat);
    selbCSI007.SetVariable('FASCIA',selCSI006.FieldByName('FASCIA').AsString);
    selbCSI007.Open;
    if selbCSI007.RecordCount > 0 then
    begin
      selCSI006.FieldByName('SUM_ORE_A').AsString:=selbCSI007.FieldByName('SUM_ORE').AsString;
      selCSI006.FieldByName('SUM_DISAGIO_SERALE_A').AsString:=selbCSI007.FieldByName('SUM_DISAGIO_SERALE').AsString;
    end;
  end;
end;

procedure TAc09FIndFunzioneMW.selCSI007BeforeDelete(DataSet: TDataSet);
begin
  DatoBloccato;
  if selCSI007.RecordCount = 1 then
    raise exception.Create(A000MSG_Ac09_ERR_DEL_UNICO_RECORD);
  inherited;
  Azione:='D';
  TotOreIndOld:=R180OreMinuti(selCSI007.FieldByName('ORE').AsString);
  TotOreDisSerOld:=R180OreMinuti(selCSI007.FieldByName('DISAGIO_SERALE').AsString);
end;

procedure TAc09FIndFunzioneMW.selCSI007BeforeEdit(DataSet: TDataSet);
begin
  DatoBloccato;
  inherited;
  Azione:='U';
  TotOreIndOld:=R180OreMinuti(selCSI007.FieldByName('ORE').AsString);
  TotOreDisSerOld:=R180OreMinuti(selCSI007.FieldByName('DISAGIO_SERALE').AsString);
end;

procedure TAc09FIndFunzioneMW.selCSI007BeforeInsert(DataSet: TDataSet);
begin
  DatoBloccato;
  inherited;
  Azione:='I';
end;

procedure TAc09FIndFunzioneMW.selCSI007NewRecord(DataSet: TDataSet);
begin
  inherited;
  selCSI007.FieldByName('ID').AsInteger:=selCSI006.FieldByName('ID').AsInteger;
  selCSI007.FieldByName('FASCIA').AsString:=selCSI006.FieldByName('FASCIA').AsString;
  selCSI007.FieldByName('TIPO_RECORD').AsString:='M';
  selCSI007.FieldByName('ORE').AsString:='00.00';
  selCSI007.FieldByName('DISAGIO_SERALE').AsString:='00.00';
end;

procedure TAc09FIndFunzioneMW.selCSI007BeforePost(DataSet: TDataSet);
begin
  inherited;
  if Trim(selCSI007.FieldByName('INDFUNZIONE').AsString) = '' then
    raise exception.Create(A000MSG_Ac09_ERR_NO_INDFUNZIONE);
  if (Trim(selCSI007.FieldByName('ORE').AsString) = '') or (R180OreMinuti(selCSI007.FieldByName('ORE').AsString) < 0) then
    raise exception.Create(A000MSG_Ac09_ERR_FORMATO_ORE);
  if (Trim(selCSI007.FieldByName('DISAGIO_SERALE').AsString) = '') or (R180OreMinuti(selCSI007.FieldByName('DISAGIO_SERALE').AsString) < 0) then
    raise exception.Create(A000MSG_Ac09_ERR_FORMATO_DISAGIO_SERALE);
  if R180OreMinuti(selCSI007.FieldByName('DISAGIO_SERALE').AsString) > R180OreMinuti(selCSI007.FieldByName('ORE').AsString) then
    raise exception.Create(A000MSG_Ac09_ERR_DISAGIO_SUPERA_ORE);
end;

procedure TAc09FIndFunzioneMW.selCSI007AfterPost(DataSet: TDataSet);
begin
  TotOreInd:=TotOreInd - IfThen(Azione <> 'I',TotOreIndOld,0) + IfThen(Azione <> 'D',R180OreMinuti(selCSI007.FieldByName('ORE').AsString),0);
  TotOreDisSer:=TotOreDisSer - IfThen(Azione <> 'I',TotOreDisSerOld,0) + IfThen(Azione <> 'D',R180OreMinuti(selCSI007.FieldByName('DISAGIO_SERALE').AsString),0);
  inherited;
end;

procedure TAc09FIndFunzioneMW.selCSI007ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if R180In(Action,['D','U','I']) then
  begin
    if TotOreInd > R180OreMinuti(selCSI006.FieldByName('SUM_ORE_A').AsString) then
      raise exception.Create(Format(A000MSG_Ac09_ERR_FMT_SUPERA_ORE_CALC,[IfThen((selCSI007.RecordCount + IfThen(Action = 'I',1)) > 1,' totali'),R180MinutiOre(TotOreInd),selCSI006.FieldByName('SUM_ORE_A').AsString]));
    if TotOreDisSer > R180OreMinuti(selCSI006.FieldByName('SUM_DISAGIO_SERALE_A').AsString) then
      raise exception.Create(Format(A000MSG_Ac09_ERR_FMT_SUPERA_DISAGIO_CALC,[IfThen((selCSI007.RecordCount + IfThen(Action = 'I',1)) > 1,' totali'),R180MinutiOre(TotOreDisSer),selCSI006.FieldByName('SUM_DISAGIO_SERALE_A').AsString]));
    if Sender.UpdatesPending then
    begin
      RegistraLogCSI007.SettaProprieta(IfThen(Action = 'D','C',IfThen(Action = 'U','M','I')),R180Query2NomeTabella(Sender),NomeOwner,Sender,True);
      RegistraLogCSI007.InserisciDato('PROGRESSIVO',IfThen(Action = 'I','',selCSI006.FieldByName('PROGRESSIVO').AsString),IfThen(Action = 'I',selCSI006.FieldByName('PROGRESSIVO').AsString,''));
      RegistraLogCSI007.InserisciDato('DATA',IfThen(Action = 'I','',selCSI006.FieldByName('DATA').AsString),IfThen(Action = 'I',selCSI006.FieldByName('DATA').AsString,''));
      RegistraLogCSI007.RegistraOperazione;
    end;
  end;
  inherited;
end;

procedure TAc09FIndFunzioneMW.selCSI007TranslateMessage(Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: string; Action: Char; var Msg: string);
begin
  inherited;
  if ErrorCode = 1 then
    Msg:=A000MSG_ERR_CHIAVE_DUPLICATA;
end;

procedure TAc09FIndFunzioneMW.selCSI007INDFUNZIONEValidate(Sender: TField);
begin
  inherited;
  if VarToStr(selCSI004.Lookup('CODICE',Sender.AsString,'CODICE')) <> Sender.AsString then
    raise exception.Create(A000MSG_ERR_SELEZIONARE_ELEMENTO);
end;

procedure TAc09FIndFunzioneMW.selCSI007OREValidate(Sender: TField);
begin
  inherited;
  R180OraValidate(Sender.AsString);
end;

procedure TAc09FIndFunzioneMW.DatoBloccato;
begin
  if selDatiBloccati.DatoBloccato(selCSI006.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selCSI006.FieldByName('DATA').AsDateTime),'CSI006') then
    raise exception.Create(selDatiBloccati.MessaggioLog);
end;

end.

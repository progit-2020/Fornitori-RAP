unit A094USkLimitiStraordMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, DatiBloccati, A000UInterfaccia,
  C180FunzioniGenerali, A000UCostanti, A000UMessaggi, A000USessione, Oracle;

type
  TProgressivo = function:Integer of object;
  TAggiornaEtichetteCampi = procedure (Tipo,Rag1,Rag2: String) of object;

  TA094FSkLimitiStraordMW = class(TR005FDataModuleMW)
    dsrT825: TDataSource;
    selT825: TOracleDataSet;
    FloatField1: TFloatField;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    selT825RESIDUABILE: TStringField;
    selT825LIQUIDABILE_TEORICO: TStringField;
    selT825RESIDUABILE_TEORICO: TStringField;
    selT275: TOracleDataSet;
    QCols: TOracleDataSet;
    selT810: TOracleDataSet;
    selT810CAMPO1: TStringField;
    selT810CAMPO2: TStringField;
    selT810ANNO: TIntegerField;
    selT810MESE: TIntegerField;
    selT810VALORE: TStringField;
    dsrT810: TDataSource;
    selT800_Data: TOracleDataSet;
    selT800_DataNOMECAMPO1: TStringField;
    selT800_DataNOMECAMPO2: TStringField;
    QLook1: TOracleDataSet;
    dsrLook1: TDataSource;
    QLook2: TOracleDataSet;
    dsrLook2: TDataSource;
    dsrT811: TDataSource;
    selT811: TOracleDataSet;
    selT811CAMPO1: TStringField;
    selT811CAMPO2: TStringField;
    selT811ANNO: TIntegerField;
    selT811MESE: TIntegerField;
    selT811VALORE: TStringField;
    Ins810: TOracleQuery;
    Upd810: TOracleQuery;
    Del810: TOracleQuery;
    SetAnno811: TOracleQuery;
    SetAnno810: TOracleQuery;
    Ins811: TOracleQuery;
    Upd811: TOracleQuery;
    Del811: TOracleQuery;
    procedure ValidateOreMinuti(Sender: TField);
    procedure selT825BeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT825NewRecord(DataSet: TDataSet);
    procedure selT825BeforeEdit(DataSet: TDataSet);
    procedure selT825BeforeDelete(DataSet: TDataSet);
    procedure selT825AfterPost(DataSet: TDataSet);
    procedure AbortOperation(DataSet: TDataSet);
    procedure selT810AfterPost(DataSet: TDataSet);
    procedure CancelUpdates(DataSet: TDataSet);
    procedure selT811AfterPost(DataSet: TDataSet);
    procedure registraBeforePost(DataSet: TDataSet);
  private
    //usati da A094
    FAggiornaEtichetteCampi: TAggiornaEtichetteCampi;
    //usati da A094 - WA094
    FProgressivoCorrente: TProgressivo;
    FSelT820_Funzioni: TOracleDataset;
  public
    //usati da A094 - WA094
    selDatiBloccati:TDatiBloccati;
    procedure SelT820NewRecord;
    procedure SelT820BeforePost;
    procedure SelT820BeforeEdit;
    procedure SelT820BeforeDelete;
    property ProgressivoCorrente: TProgressivo read FProgressivoCorrente write FProgressivoCorrente;
    property SelT820_Funzioni: TOracleDataset read FSelT820_Funzioni write FSelT820_Funzioni;
    //usati da A094 - WA191
    procedure T800BeforePost(Dataset: TDataset);
    //usati da A094 - WA189 - WA190
    procedure CambiaData(Anno, Tipo: String);
    procedure RefrAnno(Anno:Integer; Campo1, Campo2: String;Tipo: String);
    procedure SincronizzaT810(DataSet: TOracleDataset; Action: Char);
    procedure SincronizzaT811(DataSet: TOracleDataset; Action: Char);
    procedure selAnnoBeforePost(DataSet: TDataSet);
    procedure AssegnazioneAnnua(Anno: Integer; Campo1, Campo2, Tipo,OreMinuti: String);
    //usati da A094
    property AggiornaEtichetteCampi: TAggiornaEtichetteCampi read FAggiornaEtichetteCampi write FAggiornaEtichetteCampi;
  end;

implementation

{$R *.dfm}
procedure TA094FSkLimitiStraordMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT825.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  QCols.Open;
  selT800_Data.Open;
end;

procedure TA094FSkLimitiStraordMW.AbortOperation(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA094FSkLimitiStraordMW.CancelUpdates(DataSet: TDataSet);
begin
  if TOracleDataSet(DataSet).CachedUpdates then
    TOracleDataSet(DataSet).CancelUpdates;
end;

procedure TA094FSkLimitiStraordMW.selT825AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA094FSkLimitiStraordMW.selT825BeforeDelete(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Encodedate(StrToInt(selT825.FieldByName('Anno').AsString),1,1),'T825') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA094FSkLimitiStraordMW.selT825BeforeEdit(DataSet: TDataSet);
begin
  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Encodedate(StrToInt(selT825.FieldByName('Anno').AsString),1,1),'T825') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA094FSkLimitiStraordMW.selT825BeforePost(DataSet: TDataSet);
begin
  if selT825.FieldByName('Anno').AsString  = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Anno']));

  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Encodedate(StrToInt(selT825.FieldByName('Anno').AsString),1,1),'T825') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

   if QueryPK1.EsisteChiave('T825_LIQUIDINDANNUO ',selT825.RowId,selT825.State,['PROGRESSIVO','ANNO'],[IntToStr(FProgressivoCorrente),selT825.FieldByName('Anno').AsString]) then
    raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA094FSkLimitiStraordMW.selT825NewRecord(DataSet: TDataSet);
begin
  selT825.FieldByName('Progressivo').AsInteger:=FProgressivoCorrente;
  selT825.FieldByName('Anno').AsInteger:=StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro));
end;

procedure TA094FSkLimitiStraordMW.ValidateOreMinuti(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA094FSkLimitiStraordMW.SelT820NewRecord;
begin
  FSelT820_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=FProgressivoCorrente;
  FSelT820_Funzioni.FieldByName('ANNO').AsInteger:=StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro));
  FSelT820_Funzioni.FieldByName('LIQUIDABILE').Clear;
  FSelT820_Funzioni.FieldByName('CAUSALE').Clear;
end;

procedure TA094FSkLimitiStraordMW.SelT820BeforePost;
var Data: TDateTime;
begin
  try
    Data:=Encodedate(FSelT820_Funzioni.FieldByName('Anno').AsInteger,FSelT820_Funzioni.FieldByName('MESE').AsInteger,1);
  except
    raise Exception.Create(A000MSG_A094_ERR_DATA);
  end;
  if FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Liquidabile']));

  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Data,'T820') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  if FSelT820_Funzioni.FieldByName('CAUSALE').IsNull then
    if FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString = 'S' then
      FSelT820_Funzioni.FieldByName('CAUSALE').AsString:=A000LimiteMensileLiquidabile
    else if FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString = 'N' then
      FSelT820_Funzioni.FieldByName('CAUSALE').AsString:=A000LimiteMensileResiduabile;

  if Parametri.CampiRiferimento.C15_LimitiMensCaus = 'S' then
  begin
    if (FSelT820_Funzioni.FieldByName('CAUSALE').AsString = A000LimiteMensileResiduabile) and
       (FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString <> 'N') then
      raise Exception.Create(Format(A000MSG_A094_ERR_FMT_CAUSALE_BANCAORE,[A000LimiteMensileResiduabile,'S']));
    if (FSelT820_Funzioni.FieldByName('CAUSALE').AsString = A000LimiteMensileLiquidabile) and
       (FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString <> 'S') then
      raise Exception.Create(Format(A000MSG_A094_ERR_FMT_CAUSALE_BANCAORE,[A000LimiteMensileLiquidabile,'N']));
    if (FSelT820_Funzioni.FieldByName('CAUSALE').AsString <> A000LimiteMensileResiduabile) and
       (FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString = 'N') then
      raise Exception.Create(Format(A000MSG_A094_ERR_FMT_BANCAORE,[A000LimiteMensileResiduabile]));
  end
  else
  begin
    if FSelT820_Funzioni.FieldByName('LIQUIDABILE').AsString = 'N' then
      FSelT820_Funzioni.FieldByName('CAUSALE').AsString:=A000LimiteMensileResiduabile
    else
      FSelT820_Funzioni.FieldByName('CAUSALE').AsString:=A000LimiteMensileLiquidabile;
  end;
  if (FSelT820_Funzioni.FieldByName('CAUSALE').AsString = A000LimiteMensileResiduabile) or
     (FSelT820_Funzioni.FieldByName('CAUSALE').AsString = A000LimiteMensileLiquidabile) then
  begin
    FSelT820_Funzioni.FieldByName('DAL').AsInteger:=1;
    FSelT820_Funzioni.FieldByName('AL').AsInteger:=31;
  end;
  if FSelT820_Funzioni.FieldByName('DAL').AsInteger > FSelT820_Funzioni.FieldByName('AL').AsInteger then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  if FSelT820_Funzioni.FieldByName('ORE').IsNull and (not FSelT820_Funzioni.FieldByName('ORE_TEORICHE').IsNull) then
    FSelT820_Funzioni.FieldByName('ORE').AsString:=FSelT820_Funzioni.FieldByName('ORE_TEORICHE').AsString;
end;

procedure TA094FSkLimitiStraordMW.SelT820BeforeEdit;
begin
  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Encodedate(StrToInt(FSelT820_Funzioni.FieldByName('Anno').AsString),FSelT820_Funzioni.FieldByName('MESE').AsInteger,1),'T820') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA094FSkLimitiStraordMW.SelT820BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(FProgressivoCorrente,Encodedate(StrToInt(FSelT820_Funzioni.FieldByName('Anno').AsString),FSelT820_Funzioni.FieldByName('MESE').AsInteger,1),'T820') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA094FSkLimitiStraordMW.T800BeforePost(Dataset: TDataset);
var
  gg,mm : String;
  Data: TDateTime;
begin
  Data:=Dataset.FieldByName('DATADECORR').AsDateTime;
  gg:=FormatDateTime('dd',Data);
  mm:=FormatDateTime('mm',Data);
  if (gg <> '01') or (mm <> '01') then
    Raise Exception.Create(A000MSG_A094_ERR_DATA_DECOR);

  if Dataset.FieldByName('TIPOLIMITE').AsString = '' then
      Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Tipo limite']));

  if (Dataset.FieldByName('TIPOLIMITE').AsString <> 'L') and
     (Dataset.FieldByName('TIPOLIMITE').AsString <> 'R') then
      Raise Exception.Create(A000MSG_A094_ERR_TIPO_LIMITE_ERRATO);

  if Dataset.FieldByName('NOMECAMPO1').AsString = '' then
      Raise Exception.Create(A000MSG_A094_ERR_CAMPO);
end;

procedure TA094FSkLimitiStraordMW.selT810AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione();
  if selT810.CachedUpdates then
    SessioneOracle.ApplyUpdates([selT810],True);
end;

procedure TA094FSkLimitiStraordMW.registraBeforePost(DataSet: TDataSet);
begin
  inherited;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA094FSkLimitiStraordMW.selT811AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione();
  if selT811.CachedUpdates then
    SessioneOracle.ApplyUpdates([selT811],True);
end;

procedure TA094FSkLimitiStraordMW.CambiaData(Anno: String;Tipo: String);
var
  recdate: TDateTime;
  Rag1, Rag2: String;
begin
  try
    recdate:=StrToDate('01/01/'+Anno);
  except
    recdate:=Date;
  end;
  selT800_Data.Close;
  selT800_Data.SetVariable('Data',recdate);
  selT800_Data.SetVariable('Tipo',Tipo);
  selT800_Data.Open;
  Rag1:=selT800_Data.FieldByName('NomeCampo1').AsString;
  Rag2:=selT800_Data.FieldByName('NomeCampo2').AsString;
  QLook1.Close;
  QLook1.DeleteVariables;
  QLook1.SQL.Clear;
  if A000LookupTabella(Rag1,QLook1) then
  begin
    if QLook1.VariableIndex('DECORRENZA') >= 0 then
      QLook1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    QLook1.SQL.Add('SELECT '' '' CODICE,'' '' DESCRIZIONE FROM DUAL');
  QLook1.Open;

  QLook2.Close;
  QLook2.DeleteVariables;
  QLook2.SQL.Clear;
  if A000LookupTabella(Rag2,QLook2) then
  begin
    if QLook2.VariableIndex('DECORRENZA') >= 0 then
      QLook2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    QLook2.SQL.Add('SELECT '' '' CODICE,'' '' DESCRIZIONE FROM DUAL');
  QLook2.Open;

  if Assigned(FAggiornaEtichetteCampi) then
    FAggiornaEtichetteCampi(Tipo,Rag1, Rag2);
end;

procedure TA094FSkLimitiStraordMW.RefrAnno(Anno:Integer; Campo1,Campo2: String; Tipo: String);
var QAnno:TOracleDataSet;
begin
  if Tipo = 'L' then
    QAnno:=selT810
  else
    QAnno:=selT811;

  QAnno.Close;
  QAnno.SetVariable('Anno',Anno);
  QAnno.SetVariable('Campo1',Campo1);
  QAnno.SetVariable('Campo2',Campo2);
  QAnno.Open;
  CambiaData(IntToStr(Anno),Tipo);
end;

procedure TA094FSkLimitiStraordMW.AssegnazioneAnnua(Anno:Integer; Campo1,Campo2: String; Tipo: String; OreMinuti: String);
var
  Q:TOracleQuery;
  Tabella: String;
begin
  if Tipo = 'L' then
  begin
    Q:=SetAnno810;
    Tabella:=R180Query2NomeTabella(selT810);
  end
  else
  begin
    Q:=SetAnno811;
    Tabella:=R180Query2NomeTabella(selT811);
  end;

  RegistraLog.SettaProprieta('M',Tabella,NomeOwner,nil,True);
  RegistraLog.InserisciDato('ANNO','',IntToStr(Anno));
  RegistraLog.InserisciDato('CAMPO1','',Campo1);
  RegistraLog.InserisciDato('CAMPO2','',Campo2);
  RegistraLog.InserisciDato('ASSEGNAZIONE','',OreMinuti);
  RegistraLog.RegistraOperazione();

  Q.SetVariable('Anno',Anno);
  Q.SetVariable('Campo1',Campo1);
  Q.SetVariable('Campo2',Campo2);
  Q.SetVariable('Valore',OreMinuti);
  Q.Execute;
  SessioneOracle.Commit;
  RefrAnno(Anno, Campo1, Campo2,Tipo);
end;

procedure TA094FSkLimitiStraordMW.SincronizzaT810(DataSet: TOracleDataset; Action: Char);
var i: Integer;
begin
  if Action = 'I' then
  begin
    Ins810.SetVariable('CAMPO1',DataSet.FieldByName('Campo1').Value);
    Ins810.SetVariable('CAMPO2',DataSet.FieldByName('Campo2').Value);
    Ins810.SetVariable('ANNO',DataSet.FieldByName('Anno').Value);
    Ins810.SetVariable('Valore','00.00');
    for i:=1 to 12 do
    begin
      Ins810.SetVariable('Mese',i);
      Ins810.Execute;
    end;
  end;
  // modifica
  if Action = 'U' then
  begin
    Upd810.SetVariable('Anno',DataSet.FieldByName('Anno').Value);
    Upd810.SetVariable('Campo1',DataSet.FieldByName('Campo1').Value);
    Upd810.SetVariable('Campo2',DataSet.FieldByName('Campo2').Value);
    Upd810.SetVariable('Old_Anno',DataSet.FieldByName('Anno').medpOldValue);
    Upd810.SetVariable('Old_Campo1',DataSet.FieldByName('Campo1').medpOldValue);
    Upd810.SetVariable('Old_Campo2',DataSet.FieldByName('Campo2').medpOldValue);
    Upd810.Execute;
  end;
  // cancellazione
  if Action = 'D' then
  begin
    Del810.SetVariable('Old_Anno',DataSet.FieldByName('Anno').medpOldValue);
    Del810.SetVariable('Old_Campo1',DataSet.FieldByName('Campo1').medpOldValue);
    Del810.SetVariable('Old_Campo2',DataSet.FieldByName('Campo2').medpOldValue);
    Del810.Execute;
  end;
end;

procedure TA094FSkLimitiStraordMW.SincronizzaT811(DataSet: TOracleDataset; Action: Char);
var
  i: Integer;
begin
  // inserimento
  if Action = 'I' then
  begin
    Ins811.SetVariable('CAMPO1',DataSet.FieldByName('CAMPO1').Value);
    Ins811.SetVariable('CAMPO2',DataSet.FieldByName('CAMPO2').Value);
    Ins811.SetVariable('ANNO',DataSet.FieldByName('ANNO').Value);
    Ins811.SetVariable('Valore','00.00');
    for i:=1 to 12 do
    begin
      Ins811.SetVariable('Mese',i);
      Ins811.Execute;
    end;
  end;
  // modifica
  if Action = 'U' then
  begin
    Upd811.SetVariable('Anno',DataSet.FieldByName('Anno').Value);
    Upd811.SetVariable('Campo1',DataSet.FieldByName('Campo1').Value);
    Upd811.SetVariable('Campo2',DataSet.FieldByName('Campo2').Value);
    Upd811.SetVariable('Old_Anno',DataSet.FieldByName('Anno').medpOldValue);
    Upd811.SetVariable('Old_Campo1',DataSet.FieldByName('Campo1').medpOldValue);
    Upd811.SetVariable('Old_Campo2',DataSet.FieldByName('Campo2').medpOldValue);
    Upd811.Execute;
  end;
  // cancellazione
  if Action = 'D' then
  begin
    Del811.SetVariable('Old_Anno',DataSet.FieldByName('Anno').medpOldValue);
    Del811.SetVariable('Old_Campo1',DataSet.FieldByName('Campo1').medpOldValue);
    Del811.SetVariable('Old_Campo2',DataSet.FieldByName('Campo2').medpOldValue);
    Del811.Execute;
  end;
end;

procedure TA094FSkLimitiStraordMW.selAnnoBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('ANNO').AsString  = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Anno']));

  if selT800_Data.FieldByName('NOMECAMPO1').AsString = '' then  //non è presente raggruppamento per l'anno indicato
    raise Exception.Create(A000MSG_A094_ERR_RAGGR_ANNO);

  if selT800_Data.FieldByName('NOMECAMPO2').AsString = '' then
    DataSet.FieldByName('CAMPO2').AsString:='*';

  if DataSet.FieldByName('CAMPO1').AsString  = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT800_Data.FieldByName('NOMECAMPO1').AsString]));

  if DataSet.FieldByName('CAMPO2').AsString  = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[selT800_Data.FieldByName('NOMECAMPO2').AsString]));

  if (selT800_Data.FieldByName('NOMECAMPO1').AsString <> '') and
     (not QLook1.SearchRecord('CODICE',DataSet.FieldByName('CAMPO1').AsString,[srFromBeginning])) then
    raise Exception.Create(Format(A000MSG_A094_ERR_FMT_NON_IN_ELENCO,[selT800_Data.FieldByName('NOMECAMPO1').AsString]));

  if (selT800_Data.FieldByName('NOMECAMPO2').AsString <> '') and
     (not QLook2.SearchRecord('CODICE',DataSet.FieldByName('CAMPO2').AsString,[srFromBeginning])) then
    raise Exception.Create(Format(A000MSG_A094_ERR_FMT_NON_IN_ELENCO,[selT800_Data.FieldByName('NOMECAMPO2').AsString]));
end;

procedure TA094FSkLimitiStraordMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selDatiBloccati);
  inherited;
end;

end.

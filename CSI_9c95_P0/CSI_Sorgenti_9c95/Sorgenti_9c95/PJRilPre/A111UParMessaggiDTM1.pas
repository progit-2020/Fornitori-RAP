unit A111UParMessaggiDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, RegistrazioneLog, A000UCostanti, A000USessione, A000UInterfaccia,
  C700USelezioneAnagrafe, C180FunzioniGenerali, Crtl, DBClient, Provider,
  Variants, A111UParMessaggiMW;


type
  TA111FParMessaggiDTM1 = class(TDataModule)
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
    selT291NUM_MMIND_VALID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT291AfterCancel(DataSet: TDataSet);
    procedure selT291AfterDelete(DataSet: TDataSet);
    procedure selT291AfterEdit(DataSet: TDataSet);
    procedure selT291AfterInsert(DataSet: TDataSet);
    procedure selT291AfterPost(DataSet: TDataSet);
    procedure selT291AfterScroll(DataSet: TDataSet);
    procedure selT291BeforeCancel(DataSet: TDataSet);
    procedure selT291BeforeDelete(DataSet: TDataSet);
    procedure selT291BeforePost(DataSet: TDataSet);
    procedure selT291NewRecord(DataSet: TDataSet);
    procedure selT291CODICEChange(Sender: TField);
  private
    { Private declarations }
    procedure AssegnaPickList(Tipo:String);
  public
    { Public declarations }
    A111MW: TA111FParMessaggiMW;
  end;

var
  A111FParMessaggiDTM1: TA111FParMessaggiDTM1;

implementation

uses A111UParMessaggi;

{$R *.DFM}

procedure TA111FParMessaggiDTM1.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A111MW:=TA111FParMessaggiMW.Create(Self);
  A111MW.selT291:=selT291;
  A111MW.AssegnaPickList:=AssegnaPickList;
  selT291.Open;
end;

procedure TA111FParMessaggiDTM1.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA111FParMessaggiDTM1.AssegnaPickList(Tipo:String);
var i:Integer;
begin
  with A111FParMessaggi.dGrdTracciato,A111MW do
    for i:=0 to Columns.Count - 1 do
    begin
      Columns[i].PickList.Clear;
      if Columns[i].FieldName = 'TIPO_RECORD' then
        Columns[i].PickList.Assign(PLTipoRecord)
      else if Columns[i].FieldName = 'TIPO' then
        Columns[i].PickList.Assign(PLTipo)
      else if Columns[i].FieldName = 'VALORE_DEFAULT' then
      begin
        if Tipo = 'FI' then
          Columns[i].PickList.Assign(PLDefaultFill)
        else if Tipo = 'VL' then
          Columns[i].PickList.Assign(PLDefaultVal)
        else if Tipo = 'DE' then
          Columns[i].PickList.Assign(PLDefaultDesc)
        else if Tipo = 'AN' then
          Columns[i].PickList.Assign(PLDefaultAnag);
      end
      else if Columns[i].FieldName = 'FORMATO' then
      begin
        if (Tipo = 'DT') or (Tipo = 'DC') or (Tipo = 'DS') then
          Columns[i].PickList.Assign(PLFormatoData)
        else if Tipo = 'VL' then
          Columns[i].PickList.Assign(PLFormatoVal)
        else if Tipo = 'DE' then
          Columns[i].PickList.Assign(PLFormatoDesc);
      end
      else if (Columns[i].FieldName = 'CODICE_DATO') then
        Columns[i].PickList.Assign(PLCodDato)
      else if Columns[i].FieldName = 'CHIAVE' then
        Columns[i].PickList.Assign(PLChiave);
    end;
end;

procedure TA111FParMessaggiDTM1.selT291AfterCancel(DataSet: TDataSet);
begin
  A111MW.AfterCancel;
  A111MW.selT292.ReadOnly:=True;//Non serve in Cloud perché il dettaglio è gestito tramite ToolBar
end;

procedure TA111FParMessaggiDTM1.selT291AfterDelete(DataSet: TDataSet);
begin
  A111MW.AfterDelete;
  RegistraLog.RegistraOperazione;
end;

procedure TA111FParMessaggiDTM1.selT291AfterEdit(DataSet: TDataSet);
begin
  A111MW.selT292.ReadOnly:=False;//Non serve in Cloud perché il dettaglio è gestito tramite ToolBar
  A111MW.AfterEdit(A111FParMessaggi.dEdtCodice.Text);
end;

procedure TA111FParMessaggiDTM1.selT291AfterInsert(DataSet: TDataSet);
begin
  A111MW.selT292.ReadOnly:=False;//Non serve in Cloud perché il dettaglio è gestito tramite ToolBar
  A111MW.AfterInsert(A111FParMessaggi.dEdtCodice.Text);
end;

procedure TA111FParMessaggiDTM1.selT291AfterPost(DataSet: TDataSet);
begin
  A111MW.AfterPostStep1;
  RegistraLog.RegistraOperazione;
  A111MW.selT292.ReadOnly:=True;//Non serve in Cloud perché il dettaglio è gestito tramite ToolBar
  A111MW.AfterPostStep2;
end;

procedure TA111FParMessaggiDTM1.selT291AfterScroll(DataSet: TDataSet);
begin
  with A111FParMessaggi,A111MW.selT291 do
  begin
    LblProva.Caption:=' ';
    edtNumeroRipetiz.Value:=FieldByName('NUM_RIPET_MSG').AsInteger;
    edtNumeroGiorniValid.Value:=FieldByName('NUM_GGVAL_MSG').AsInteger;
    edtMesiIndietro.Value:=FieldByName('NUM_MMIND_CONS').AsInteger;
    edtValiditaDati.Value:=FieldByName('NUM_MMIND_VALID').AsInteger;
  end;
  A111MW.AfterScroll;
end;

procedure TA111FParMessaggiDTM1.selT291BeforeCancel(DataSet: TDataSet);
begin
  A111MW.BeforeCancel;
end;

procedure TA111FParMessaggiDTM1.selT291BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  A111MW.BeforeDelete;
end;

procedure TA111FParMessaggiDTM1.selT291BeforePost(DataSet: TDataSet);
begin
  A111MW.BeforePost;
  with A111FParMessaggi,A111MW.selT291 do
  begin
    FieldByName('NUM_RIPET_MSG').AsInteger:=edtNumeroRipetiz.Value;
    FieldByName('NUM_GGVAL_MSG').AsInteger:=edtNumeroGiorniValid.Value;
    FieldByName('NUM_MMIND_CONS').AsInteger:=edtMesiIndietro.Value;
    FieldByName('NUM_MMIND_VALID').AsInteger:=edtValiditaDati.Value;
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA111FParMessaggiDTM1.selT291NewRecord(DataSet: TDataSet);
begin
  A111MW.OnNewRecord;
end;

procedure TA111FParMessaggiDTM1.selT291CODICEChange(Sender: TField);
begin
  A111MW.CODICEChange;
end;

end.

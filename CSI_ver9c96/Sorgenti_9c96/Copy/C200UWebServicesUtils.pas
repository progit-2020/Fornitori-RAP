unit C200UWebServicesUtils;

interface

uses
  C200UWebServicesTypes,
  A000UCostanti,
  FunzioniGenerali,
  Data.DB,
  {$IF CompilerVersion >= 31}
  {versione 10.1 Berlin+}
  FireDAC.Comp.Client,
  {$ENDIF CompilerVersion >= 31}
  System.Classes,
  System.Types,
  System.SysUtils,
  System.StrUtils,
  System.Math;

type

  TC200FWebServicesUtils = class
  public
    class function CreateJSONFormatSettings: TFormatSettings;
    class function FileToByteArray(const PFileName: String): TByteDynArray; static;
    class procedure ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String); static;
  end;

  {$REGION 'Class e record helper'}

  {$IF CompilerVersion >= 31}
  {versione 10.1 Berlin+}
  TDatasetHelper = class helper for Data.DB.TDataset
  public
    function CloneDataset: TFDMemTable;
    function CloneField(Source: TField; AOwner: TComponent): TField;
    function GetVisibleFields: String;
    function GetDisplayLabels: String;
  end;

  TFDMemTableHelper = class helper for FireDAC.Comp.Client.TFDMemTable
  public
    procedure SetFields(const AVisibleFields: String; const ADisplayLables: String);
  end;
  {$ENDIF CompilerVersion >= 31}

  {$ENDREGION 'Class e record helper'}

implementation

uses
  System.Rtti;

{ TC200FWebServicesUtils }

class function TC200FWebServicesUtils.CreateJSONFormatSettings: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni per lo scambio via JSON
// IMPORTANTE
//   la distruzione dell'oggetto non è necessaria
begin
  Result:=TFormatSettings.Create;
  Result.DateSeparator:=JSON_DATE_SEPARATOR;
  Result.ShortDateFormat:=JSON_SHORT_DATE_FMT;
  Result.TimeSeparator:=JSON_TIME_SEPARATOR;
  Result.ShortTimeFormat:=JSON_SHORT_TIME_FMT;
  Result.LongTimeFormat:=JSON_LONG_TIME_FMT;
end;

class function TC200FWebServicesUtils.FileToByteArray(
  const PFileName: String): TByteDynArray;
const
  BLOCK_SIZE = 1024;
var
  BytesRead,BytesToWrite,Count:integer;
  F:File of Byte;
  pTemp:Pointer;
begin
  AssignFile(F,PFileName);
  Reset(F);
  try
   Count:=FileSize(F);
   SetLength(Result,Count);
   pTemp:=@Result[0];
   BytesRead:=BLOCK_SIZE;
   while (BytesRead = BLOCK_SIZE) do
   begin
     BytesToWrite:=Min(Count,BLOCK_SIZE);
     BlockRead(F,pTemp^,BytesToWrite,BytesRead);
     pTemp:=Pointer(LongInt(pTemp) + BLOCK_SIZE);
     Count:=Count - BytesRead;
   end;
  finally
    CloseFile(F);
  end;
end;

class procedure TC200FWebServicesUtils.ByteArrayToFile(const PByteArr: TByteDynArray;
  const PFileName: String);
var
  LStream: TMemoryStream;
begin
  LStream:=TMemoryStream.Create;
  try
    if length(PByteArr) > 0 then
      LStream.WriteBuffer(PByteArr[0],Length(PByteArr));
    LStream.SaveToFile(PFileName);
  finally
    LStream.Free;
  end;
end;

{$REGION 'Class e record helper'}

{$IF CompilerVersion >= 31}
{versione 10.1 Berlin+}

{ TDatasetHelper }

function TDatasetHelper.CloneField(Source: TField; AOwner: TComponent): TField;
// clona il field di un dataset
var
  i: Integer;
  LPropertyName: String;
  LPropertyVal: Variant;
const
  // impostare le proprietà delle classi figlie di TField
  // che si vogliono considerare nella clonazione
  // per facilitare la ricerca, ordine alfabetico per favore
  FIELD_PROPERTIES_ARR: array [0..17] of String = (
    'Active',
    'BlobType',
    'Currency',
    'DisplayFormat',
    'DisplayValues',
    'EditFormat',
    'Expression',
    'FixedChar',
    'GroupingLevel',
    'IncludeObjectField',
    'IndexName',
    'MaxValue',
    'MinValue',
    'ObjectType',
    'Precision',
    'ReferenceTableName',
    'Size',
    'Transliterate'
  );
begin
  Result:=TFieldClass(Source.ClassType).Create(AOwner);
  Result.Alignment:=Source.Alignment;
  Result.AutoGenerateValue:=Source.AutoGenerateValue;
  Result.ConstraintErrorMessage:=Source.ConstraintErrorMessage;
  Result.CustomConstraint:=Source.CustomConstraint;
  Result.DefaultExpression:=Source.DefaultExpression;
  Result.DisplayLabel:=Source.DisplayLabel;
  Result.DisplayWidth:=Source.DisplayWidth;
  Result.EditMask:=Source.EditMask;
  Result.FieldKind:=Source.FieldKind;
  Result.FieldName:=Source.FieldName;
  Result.ImportedConstraint:=Source.ImportedConstraint;
  Result.Index:=Source.Index;
  Result.LookupDataSet:=Source.LookupDataSet;
  Result.LookupKeyFields:=Source.LookupKeyFields;
  Result.LookupResultField:=Source.LookupResultField;
  Result.KeyFields:=Source.KeyFields;
  Result.LookupCache:=Source.LookupCache;
  Result.ProviderFlags:=Source.ProviderFlags;
  Result.ReadOnly:=Source.ReadOnly;
  Result.Required:=Source.Required;
  Result.Visible:=Source.Visible;

  // altre proprietà specifiche di classi figlie
  for i:=Low(FIELD_PROPERTIES_ARR) to High(FIELD_PROPERTIES_ARR) do
  begin
    LPropertyName:=FIELD_PROPERTIES_ARR[i];
    LPropertyVal:=TFunzioniGenerali.GetPropValue(Source,LPropertyName);
    TFunzioniGenerali.SetPropValue(Result,LPropertyName,LPropertyVal);
  end;
end;

function TDatasetHelper.GetVisibleFields: String;
var
  F: TField;
begin
  Result:='';

  for F in Fields do
  begin
    if F.Visible then
      Result:=Result + IfThen(Result <> '',',') + F.FieldName;
  end;
end;

function TDatasetHelper.GetDisplayLabels: String;
var
  F: TField;
begin
  Result:='';
  for F in Fields do
    Result:=Result + IfThen(Result <> '',',') + Format('"%s=%s"',[F.FieldName,F.DisplayLabel]);
end;

function TDatasetHelper.CloneDataset: TFDMemTable;
// clona un dataset
var
  i: integer;
  LField: TField;
begin
  Result:=TFDMemTable.Create(nil);

  // clona i fields sul dataset di destinazione
  Result.Close;
  Result.Fields.Clear;
  for i:=0 to Fields.Count - 1 do
  begin
    LField:=CloneField(Fields[i],Result.Fields.Dataset);
    // importante: tutti i fields vengono riportati a fkData
    // (nel contesto ci interessano solo i valori)
    LField.FieldKind:=fkData;
    LField.DataSet:=Result.Fields.Dataset;
  end;
  Result.Open;

  if not Active then
    Open;
  First;
  while not Eof do
  begin
    // aggiunge il record al dataset di destinazione
    // copiando i valori dei campi
    Result.Append;
    for i:=0 to FieldCount - 1 do
    begin
      Result.Fields[i].Value:=Fields[i].Value;
      Result.Fields[i].OnGetText:=Fields[i].OnGetText;
    end;
    Result.Post;

    Next;
  end;

  // riporta entrambi i dataset sul primo record
  First;
  Result.First;
end;

{ TFDMemTableHelper }

procedure TFDMemTableHelper.SetFields(const AVisibleFields: String; const ADisplayLables: String);
var
  F:TField;
  lstVisibleFields:TStringList;
  lstDisplayLabels:TStringList;
begin
  lstVisibleFields:=TStringList.Create;
  lstDisplayLabels:=TStringList.Create;
  lstVisibleFields.CommaText:=AVisibleFields;
  lstDisplayLabels.CommaText:=ADisplayLables;
  try
    for F in Fields do
    begin
      F.Visible:=lstVisibleFields.IndexOf(F.FieldName) >= 0;
      F.DisplayLabel:=lstDisplayLabels.Values[F.FieldName];
    end;
  finally
    lstVisibleFields.Free;
    lstDisplayLabels.Free;
  end;
end;

{$ENDIF CompilerVersion >= 31}

{$ENDREGION 'Class e record helper'}

end.

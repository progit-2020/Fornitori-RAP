unit A055UTurnazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, Variants, A000UInterfaccia;

type
  TA055FTurnazioniMW = class(TR005FDataModuleMW)
    Q641AggiornaTurnazione: TOracleQuery;
    Q641CancellaTurnazione: TOracleQuery;
    Q610: TOracleDataSet;
    D641: TDataSource;
    Q641: TOracleDataSet;
    Q641TURNAZIONE: TStringField;
    Q641ORDINE: TFloatField;
    Q641CICLO1: TStringField;
    Q641CICLO2: TStringField;
    Q641CICLO3: TStringField;
    Q641CICLO4: TStringField;
    Q641CICLO5: TStringField;
    Q641MULTIPLO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Q641CICLO1Validate(Sender: TField);
    procedure Q641BeforePost(DataSet: TDataSet);
    procedure Q641NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    Q640: TOracleDataSet;
    procedure BeforeDelete;
    procedure BeforePost;
    procedure SettaOrdineProgressivo(Inizio: Word);
  end;


implementation

{$R *.dfm}

procedure TA055FTurnazioniMW.DataModuleCreate(Sender: TObject);
begin
  Q641.SetVariable('ORDERBY','ORDER BY ORDINE');
  inherited;
  Q610.Open;
end;

procedure TA055FTurnazioniMW.Q641BeforePost(DataSet: TDataSet);
{Prevengo l'inserimento di cicli vuoti o di record nullo}
var i,j,k,h:Byte;
begin
  for i:=2 to 5 do
    if Q641.Fields[i].AsString = '' then
      begin
      k:=0;
      for j:=i + 1 to 6 do
        if Q641.Fields[j].AsString <> '' then
          begin
          k:=j;
          Break;
          end;
      if k > 0 then
        begin
        h:=k - i;
        for j:=k to 6 do
          begin
          Q641.Fields[j - h].AsString:=Q641.Fields[j].AsString;
          Q641.Fields[j].Clear;
          end;
        end;
      end;
  if Q641CICLO1.AsString = '' then
    Abort;
end;

procedure TA055FTurnazioniMW.Q641CICLO1Validate(Sender: TField);
begin
  if Sender.AsString = '' then exit;
  if Q610.Lookup('Codice',Sender.AsString,'Codice') = Null then
    raise Exception.Create('Ciclo non valido!');
end;

procedure TA055FTurnazioniMW.Q641NewRecord(DataSet: TDataSet);
begin
  Q641Turnazione.AsString:=Q640.FieldByName('Codice').AsString;
  Q641Multiplo.AsInteger:=1;
end;

procedure TA055FTurnazioniMW.BeforeDelete;
begin
  with Q641CancellaTurnazione do
  begin
    SetVariable('Turnazione',Q640.FieldByName('Codice').AsString);
    Execute;
  end;
end;

procedure TA055FTurnazioniMW.BeforePost;
begin
  if QueryPK1.EsisteChiave('T640_TURNAZIONI',Q640.RowId,Q640.State,['CODICE'],[Q640.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
  if Q640.State = dsEdit then
    if Q640.FieldByName('Codice').Value <> Q640.FieldByName('Codice').medpOldValue then
      with Q641AggiornaTurnazione do
      begin
        SetVariable('Turnazione',Q640.FieldByName('Codice').Value);
        SetVariable('Turnazione_Old',Q640.FieldByName('Codice').medpOldValue);
        try
          Execute;
        except
          SessioneOracle.Rollback;
          raise;
        end;
      end;
end;

procedure TA055FTurnazioniMW.SettaOrdineProgressivo(Inizio:Word);
{Assegno il progressivo a Ordine in modo da avere i cicli ordinati come sono stati inseriti}
var i:Word;
begin
  with Q641 do
    begin
    DisableControls;
    First;
    i:=Inizio;
    while not Eof do
      begin
      inc(i);
      Edit;
      FieldByName('Ordine').AsInteger:=i;
      Post;
      Next;
      end;
    First;
    EnableControls;
    end;
end;

end.

unit A107UInsAssAutoRegoleMW;

interface

uses R005UDataModuleMW, DB, Classes, OracleData, C180FunzioniGenerali;

type
  TA107FInsAssAutoRegoleMW = class(TR005FDataModuleMW)
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    selT045: TOracleDataSet;
    procedure BeforePost(Testo:String);
    procedure ValidaOre(Sender: TField);
  end;

implementation

{$R *.dfm}

procedure TA107FInsAssAutoRegoleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT265.Open;
  selT265.FieldByName('Codice').DisplayWidth:=7;
end;

procedure TA107FInsAssAutoRegoleMW.BeforePost(Testo:String);
begin
  selT045.FieldByName('CAUSALI').AsString:=Testo;
  if Pos(',',Testo) > 0 then
    selT045.FieldByName('ELIMINA_GIUSTIFICATIVI').AsString:='N';
end;

procedure TA107FInsAssAutoRegoleMW.ValidaOre(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

end.

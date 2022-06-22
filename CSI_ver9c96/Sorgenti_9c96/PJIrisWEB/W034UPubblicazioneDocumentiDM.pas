unit W034UPubblicazioneDocumentiDM;

interface

uses
  SysUtils, Classes, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, DBClient, DB;

type
  TW034FPubblicazioneDocumentiDM = class(TDataModule)
    cdsFile: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TW034FPubblicazioneDocumentiDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
 except
 end;
end;

end.

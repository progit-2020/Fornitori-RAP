unit A070UProfiliTurniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Oracle, Db, OracleData, Variants;

type
  TA070FProfiliTurniDtM1 = class(TR004FGestStoricoDtM)
    D602: TOracleDataSet;
    D602CODICE: TStringField;
    D602DESCRIZIONE: TStringField;
    D602NUMMAXGGCONSECUTIVIDILAVORO: TFloatField;
    D602NUMMINNOTTIPERGRUPPODINOTTI: TFloatField;
    D602NUMMAXNOTTIPERGRUPPODINOTTI: TFloatField;
    D602NUMRIPOSIDOPOTURNODINOTTE: TFloatField;
    D602NUMGGTRADUETURNIDINOTTE: TFloatField;
    D602NUMOKNOTTIPERCICLOFERIALE: TFloatField;
    D602NUMOKNOTTIPERCICLOFESTIVO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A070FProfiliTurniDtM1: TA070FProfiliTurniDtM1;

implementation

{$R *.DFM}

procedure TA070FProfiliTurniDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  D602.Open;
end;

end.

unit A130UOraLegaleSolareDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A130UOraLegaleSolareMW;

type
  TA130FOraLegaleSolareDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A130MW:TA130FOraLegaleSolareMW;
  end;

var
  A130FOraLegaleSolareDtM: TA130FOraLegaleSolareDtM;

implementation

{$R *.dfm}

procedure TA130FOraLegaleSolareDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A130MW:=TA130FOraLegaleSolareMW.Create(Self);
end;

end.

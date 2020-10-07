unit A109UImmaginiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGestStoricoDTM, Db, Oracle, OracleData, Variants, A000UInterfaccia,
  A109UImmaginiMW;

type
  TA109FImmaginiDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A109MW:TA109FImmaginiMW;
  end;

var
  A109FImmaginiDtM: TA109FImmaginiDtM;

implementation

{$R *.DFM}

procedure TA109FImmaginiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A109MW:=TA109FImmaginiMW.Create(Self);
end;

end.

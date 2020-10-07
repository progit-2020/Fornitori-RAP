unit A075UFineAnnoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, A075UFineAnnoMW  ;

type

  TA075FFineAnnoDtM1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A075MW:TA075FFineAnnoMW;
  end;

var
  A075FFineAnnoDtM1: TA075FFineAnnoDtM1;

implementation

{$R *.DFM}

procedure TA075FFineAnnoDtM1.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  A075MW:=TA075FFineAnnoMW.Create(Self);
end;


procedure TA075FFineAnnoDtM1.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A075MW);
end;

end.

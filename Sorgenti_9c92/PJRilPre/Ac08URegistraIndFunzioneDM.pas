unit Ac08URegistraIndFunzioneDM;

interface

uses
  Classes, Forms, Oracle, OracleData, Db, SysUtils, Controls,
  A000UInterfaccia, A000USessione, Ac08URegistraIndFunzioneMW,
  C180FunzioniGenerali;

type
  TAc08FRegistraIndFunzioneDM = class(TDataModule)
    procedure Ac08FRegistraIndFunzioneDMCreate(Sender: TObject);
    procedure Ac08FRegistraIndFunzioneDMDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure evtRichiesta(Msg:String);
  public
    { Public declarations }
    Ac08MW:TAc08FRegistraIndFunzioneMW;
  end;

var
  Ac08FRegistraIndFunzioneDM: TAc08FRegistraIndFunzioneDM;

implementation

uses Ac08URegistraIndFunzione;

{$R *.DFM}

procedure TAc08FRegistraIndFunzioneDM.Ac08FRegistraIndFunzioneDMCreate(Sender: TObject);
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
  Ac08MW:=TAc08FRegistraIndFunzioneMW.Create(Self);
  Ac08MW.evtRichiesta:=evtRichiesta;
end;

procedure TAc08FRegistraIndFunzioneDM.Ac08FRegistraIndFunzioneDMDestroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(Ac08MW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TAc08FRegistraIndFunzioneDM.evtRichiesta(Msg:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort;
end;

end.

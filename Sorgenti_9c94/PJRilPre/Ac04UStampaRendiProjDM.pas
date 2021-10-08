unit Ac04UStampaRendiProjDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Oracle, OracleData, (*Midaslib,*) Crtl, DBClient, Variants,
  A000UInterfaccia, A000USessione, Ac04UStampaRendiProjMW;

type
  TAc04FStampaRendiProjDM = class(TDataModule)
    procedure Ac04FDtM1Create(Sender: TObject);
    procedure Ac04FDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Ac04FStampaRendiProjMW: TAc04FStampaRendiProjMW;
  end;

var
  Ac04FStampaRendiProjDM: TAc04FStampaRendiProjDM;

implementation

uses Ac04UStampaRendiProj;

{$R *.DFM}

procedure TAc04FStampaRendiProjDM.Ac04FDtM1Create(Sender: TObject);
{Preparo le query Mensili}
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
  Ac04FStampaRendiProjMW:=TAc04FStampaRendiProjMW.Create(Self);
end;

procedure TAc04FStampaRendiProjDM.Ac04FDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  FreeAndNil(Ac04FStampaRendiProjMW);
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  end;
end;

end.

unit A033UStampaAnomalieDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia,  R500Lin,
  C180FunzioniGenerali,
  OracleData, Oracle, (*Midaslib,*) Crtl, DBClient, Variants,
  A033UStampaAnomalieMW;

type
  TA033FStampaAnomalieDtM1 = class(TDataModule)
    procedure A033FStampaAnomalieDtM1Create(Sender: TObject);
    procedure A033FStampaAnomalieDtM1Destroy(Sender: TObject);
  public
    A033FStampaAnomalieMW: TA033FStampaAnomalieMW;
  end;

var
  A033FStampaAnomalieDtM1: TA033FStampaAnomalieDtM1;

implementation

uses A033UStampaAnomalie, A033UStampaAnomalieQR, A033UElenco;

{$R *.DFM}

procedure TA033FStampaAnomalieDtM1.A033FStampaAnomalieDtM1Create(
  Sender: TObject);
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
  A033FStampaAnomalieMW:=TA033FStampaAnomalieMW.Create(Self);
  A033FStampaAnomalie.DBLookupCampo.ListSource:=A033FStampaAnomalieMW.dsrI010;
  //imposto datasource
  A033FStampaAnomalieQR.QRep.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText1.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText2.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText3.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText4.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText5.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.QRDBText6.DataSet:=A033FStampaAnomalieMW.TStampa;
  A033FStampaAnomalieQR.ERagg.DataSet:=A033FStampaAnomalieMW.TStampa;
end;

procedure TA033FStampaAnomalieDtM1.A033FStampaAnomalieDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A033FStampaAnomalieMW);
end;

end.

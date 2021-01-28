unit A042UStampaPreAssDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, OracleData, Oracle,
   (*Midaslib,*) Crtl, DBClient, Variants, A042UStampaPreAssMW;

type
  TA042FStampaPreAssDtM1 = class(TDataModule)
    D010: TDataSource;
    procedure A040FPianifRepDtM1Create(Sender: TObject);
    procedure A040FPianifRepDtM1Destroy(Sender: TObject);
  private
    function GetColoreA(Codice:String):Integer;
    function GetColoreP(Codice:String):Integer;
  public
    A042MW: TA042FStampaPreAssMW;
  end;

var
  A042FStampaPreAssDtM1: TA042FStampaPreAssDtM1;

implementation

uses  A042UDialogStampa, C004UParamForm;

{$R *.DFM}

procedure TA042FStampaPreAssDtM1.A040FPianifRepDtM1Create(Sender: TObject);
{Preparo le query Mensili}
var
  i:Integer;
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
  A042MW:=TA042FStampaPreAssMW.Create(Self);
  A042MW.GetColoreA:=GetColoreA;
  A042MW.GetColoreP:=GetColoreP;
  A042MW.SelAnagrafe:=C700SelAnagrafe;
  // spostato su MW ---ini
  //selI010:=TselI010.Create(Self);
  //selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  // spostato su MW ---fine

  //D010.DataSet:=A042MW.selI010;
  //Lorena 15/09/2006
end;

function TA042FStampaPreAssDtM1.GetColoreA(Codice: String): Integer;
begin
  Result:=StrToInt(C004FParamForm.GetParametro('COLOREA_' + Codice, inttostr(clWhite)));
end;

function TA042FStampaPreAssDtM1.GetColoreP(Codice: String): Integer;
begin
  Result:=StrToInt(C004FParamForm.GetParametro('COLOREP_' + Codice, inttostr(clWhite)));
end;

procedure TA042FStampaPreAssDtM1.A040FPianifRepDtM1Destroy(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  if A042MW <> nil then
    FreeAndNil(A042MW);
end;

end.

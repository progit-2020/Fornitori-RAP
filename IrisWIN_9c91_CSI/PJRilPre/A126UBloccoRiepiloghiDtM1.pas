unit A126UBloccoRiepiloghiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Oracle, OracleData,(*Midaslib,*) Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, A126UBloccoRiepiloghiMW;

type
  TA126FBloccoRiepiloghiDtM1 = class(TDataModule)
    selT180: TOracleDataSet;
    dsrT180: TDataSource;
    selT180MATRICOLA: TStringField;
    selT180NOME: TStringField;
    selT180RIEPILOGO: TStringField;
    selT180D_Riepilogo: TStringField;
    selT180PROGRESSIVO: TIntegerField;
    selT180DADATA: TStringField;
    selT180ADATA: TStringField;
    procedure A126FBloccoRiepiloghiDtM1Create(Sender: TObject);
    procedure A126FBloccoRiepiloghiDtM1Destroy(Sender: TObject);
    procedure selT180CalcFields(DataSet: TDataSet);
    procedure selT180BeforeInsert(DataSet: TDataSet);
    procedure selT180FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT180BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A126FBloccoRiepiloghiMW: TA126FBloccoRiepiloghiMW;
  end;

var
  A126FBloccoRiepiloghiDtM1: TA126FBloccoRiepiloghiDtM1;

implementation

uses A126UBloccoRiepiloghi;

{$R *.DFM}

procedure TA126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiDtM1Create(Sender: TObject);
{Preparo le query Mensili}
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  //SessioneOracle.Preferences.TrimStringFields:=True;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  A126FBloccoRiepiloghiMW:=TA126FBloccoRiepiloghiMW.Create(Self);
  A126FBloccoRiepiloghiMW.SelT180_Funzioni:=SelT180;

end;

procedure TA126FBloccoRiepiloghiDtM1.selT180CalcFields(DataSet: TDataSet);
begin
  A126FBloccoRiepiloghiMW.CalcFieldsT180;
end;

procedure TA126FBloccoRiepiloghiDtM1.selT180BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA126FBloccoRiepiloghiDtM1.selT180FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A126FBloccoRiepiloghiMW.FilterT180;
end;

procedure TA126FBloccoRiepiloghiDtM1.selT180BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.InserisciDato('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.SettaProprieta('C','T180_DATIBLOCCATI',Copy(Self.Name,1,4),nil,True);
  RegistraLog.InserisciDato('DAL-AL',DataSet.FieldByName('DADATA').AsString + '-' + DataSet.FieldByName('ADATA').AsString,'');
  RegistraLog.InserisciDato('RIEPILOGO',DataSet.FieldByName('RIEPILOGO').AsString,'');
  RegistraLog.RegistraOperazione;
end;

procedure TA126FBloccoRiepiloghiDtM1.A126FBloccoRiepiloghiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(A126FBloccoRiepiloghiMW);
end;

end.

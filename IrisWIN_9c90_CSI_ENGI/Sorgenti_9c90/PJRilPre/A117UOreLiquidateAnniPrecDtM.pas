unit A117UOreLiquidateAnniPrecDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  RegistrazioneLog, OracleData, Oracle,
  QueryStorico, A003UDataLavoroBis, Variants, DatiBloccati, DBClient,
  A117UOreLiquidateAnniPrecMW, A000UMessaggi;

type
  TA117FOreLiquidateAnniPrecDtM = class(TDataModule)
    Q134: TOracleDataSet;
    Q134PROGRESSIVO: TFloatField;
    Q134ANNO: TFloatField;
    Q134DATA: TDateTimeField;
    Q134ORE_LIQUIDATE: TStringField;
    Q134VARIAZIONE_ORE: TStringField;
    Q134NOTE: TStringField;
    Q134OREPERSE: TStringField;
    Q134OREPERSE_TOT: TStringField;
    Q134OREPERSE_RES: TStringField;
    procedure Q134NewRecord(DataSet: TDataSet);
    procedure Q134AfterPost(DataSet: TDataSet);
    procedure Q134BeforePost(DataSet: TDataSet);
    procedure Q134BeforeDelete(DataSet: TDataSet);
    procedure Q134AfterDelete(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q134CalcFields(DataSet: TDataSet);
    procedure Q134AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    AnnoLiq :Integer;
  public
    { Public declarations }
    A117FOreLiquidateAnniPrecMW: TA117FOreLiquidateAnniPrecMW;
    procedure SettaProgressivo;
  end;

var
  A117FOreLiquidateAnniPrecDtM: TA117FOreLiquidateAnniPrecDtM;

implementation

uses A117UOreLiquidateAnniPrec;

{$R *.DFM}

procedure TA117FOreLiquidateAnniPrecDtM.DataModuleCreate(Sender: TObject);
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
  A117FOreLiquidateAnniPrecMW:=TA117FOreLiquidateAnniPrecMW.Create(Self);
  A117FOreLiquidateAnniPrecMW.selT134_Funzioni:=Q134;
  Q134.FieldByName('DATA').OnGetText:=A117FOreLiquidateAnniPrecMW.DATAGetText;
  Q134.FieldByName('DATA').OnSetText:=A117FOreLiquidateAnniPrecMW.DATASetText;
  Q134.FieldByName('OREPERSE').OnValidate:=A117FOreLiquidateAnniPrecMW.OREPERSEValidate;
  Q134.FieldByName('ORE_LIQUIDATE').OnValidate:=A117FOreLiquidateAnniPrecMW.OREValidate;
  Q134.FieldByName('VARIAZIONE_ORE').OnValidate:=A117FOreLiquidateAnniPrecMW.OREValidate;

  A117FOreLiquidateAnniPrec.DButton.DataSet:=Q134;
  SettaProgressivo;
end;

procedure TA117FOreLiquidateAnniPrecDtM.SettaProgressivo;
begin
  A117FOreLiquidateAnniPrecMW.SvuotaCdsR450;
  Q134.Close;
  Q134.SetVariable('Progressivo',C700Progressivo);
  Q134.Open;
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134AfterOpen(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134AfterOpen;
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134CalcFields(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134CalcFields(C700Progressivo);
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134NewRecord(DataSet: TDataSet);
{Impostazioni nuovo record}
begin
  A117FOreLiquidateAnniPrecMW.SelT134NewRecord(C700Progressivo);
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134BeforePost(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134BeforePost(C700Progressivo);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134AfterPost(DataSet: TDataSet);
{Scarico le modifiche nella cache sul database}
var AnnoRes: Integer;
begin
  AnnoRes:=Q134.FieldByName('ANNO').AsInteger;
  AnnoLiq:=R180Anno(Q134.FieldByName('DATA').AsDateTime);
  try
    //Verifico se aggiornare i residui tramite il passaggio di anno
    A117FOreLiquidateAnniPrecMW.AggiornaResidui(C700Progressivo,AnnoLiq);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    on e: exception do
    begin
      SessioneOracle.RollBack;
      R180MessageBox(format(A000MSG_ERR_FMT_REG_FALLITA,[e.Message]),ESCLAMA);
    end;
  end;
  //ricarica cds
  Q134.Close;
  Q134.Open;
  Q134.Locate('ANNO',AnnoRes,[]);
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134BeforeDelete(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134BeforeDelete(C700Progressivo);
  AnnoLiq:=R180Anno(Q134.FieldByName('DATA').AsDateTime);
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA117FOreLiquidateAnniPrecDtM.Q134AfterDelete(DataSet: TDataSet);
begin
  try
    //Verifico se aggiornare i residui tramite il passaggio di anno
    A117FOreLiquidateAnniPrecMW.AggiornaResidui(C700Progressivo,AnnoLiq);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    on e: exception do
    begin
      SessioneOracle.RollBack;
      R180MessageBox(format(A000MSG_ERR_FMT_REG_FALLITA,[e.Message]),ESCLAMA);
      //ricarica dati
      Q134.Close;
      Q134.Open;
    end;
  end;
end;

procedure TA117FOreLiquidateAnniPrecDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(A117FOreLiquidateAnniPrecMW);
end;

end.

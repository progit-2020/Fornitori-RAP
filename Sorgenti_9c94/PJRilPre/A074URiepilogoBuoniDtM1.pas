unit A074URiepilogoBuoniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, QueryStorico,
  Oracle, OracleData, RegistrazioneLog, C180FunzioniGenerali,
  USelI010,Crtl, DBClient, Variants, A074URiepilogoBuoniMW;

type
  TA074FRiepilogoBuoniDtM1 = class(TDataModule)
    cdsT191: TClientDataSet;
    dcdsT191: TDataSource;
    cdsT191codice: TStringField;
    cdsT191d_codice: TStringField;
    cdsT191d_nomefile: TStringField;
    procedure A049FStampaPastiDtM1Create(Sender: TObject);
    procedure A049FStampaPastiDtM1Destroy(Sender: TObject);
    procedure cdsT191CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A074FRiepilogoBuoniMW: TA074FRiepilogoBuoniMW;
    procedure GetMeseUltimoAcquisto(MeseSucc:Boolean);
  end;

var
  A074FRiepilogoBuoniDtM1: TA074FRiepilogoBuoniDtM1;

implementation

uses A074URiepilogoBuoni,A074UStampaBuoni,A074UStampaAcquisti;

{$R *.DFM}

procedure TA074FRiepilogoBuoniDtM1.A049FStampaPastiDtM1Create(Sender: TObject);
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
  A074FRiepilogoBuoniMW:=TA074FRiepilogoBuoniMW.Create(Self);
  A074FRiepilogoBuoni.dcmbRaggrAnagrafico.ListSource:=A074FRiepilogoBuoniMW.dsrI010;
  A074FRiepilogoBuoni.dcmbParametrizzazione.ListSource:=A074FRiepilogoBuoniMW.dsrT191;

  with A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM do
  begin
    A074FStampaBuoni.RepR.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText1.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText2.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText3.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText4.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText5.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText6.DataSet:=TabellaStampa;
    A074FStampaBuoni.QRDBText7.DataSet:=TabellaStampa;

    A074FStampaAcquisti.QRep.DataSet:=TabellaStampa;
    A074FStampaAcquisti.QRDBText1.DataSet:=TabellaStampa;
    A074FStampaAcquisti.QRDBText2.DataSet:=TabellaStampa;
    A074FStampaAcquisti.QRDBText5.DataSet:=TabellaStampa;
    A074FStampaAcquisti.QRDBText7.DataSet:=TabellaStampa;
  end;
end;

procedure TA074FRiepilogoBuoniDtM1.GetMeseUltimoAcquisto(MeseSucc:Boolean);
var
  DataUltimoAcquisto: TDateTime;
begin
  DataUltimoAcquisto:=A074FRiepilogoBuoniMW.getUltimoAcquisto;
  if DataUltimoAcquisto = DATE_NULL then
    A074FRiepilogoBuoni.edtUltimoAcquisto.Text:=''
  else
    A074FRiepilogoBuoni.edtUltimoAcquisto.Text:=FormatDateTime('mmmm yyyy',DataUltimoAcquisto);

  if MeseSucc then
  begin
    if DataUltimoAcquisto = DATE_NULL then
      A074FRiepilogoBuoni.DataAcquisto:=R180InizioMese(Parametri.DataLavoro)
    else
      A074FRiepilogoBuoni.DataAcquisto:=R180InizioMese(DataUltimoAcquisto);

    A074FRiepilogoBuoni.edtDataAcquisto.Text:=FormatDateTime('mmmm yyyy',A074FRiepilogoBuoni.DataAcquisto);
  end;
end;

procedure TA074FRiepilogoBuoniDtM1.A049FStampaPastiDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  if A074FRiepilogoBuoniMW <> nil then
    FreeAndNil(A074FRiepilogoBuoniMW);
end;

procedure TA074FRiepilogoBuoniDtM1.cdsT191CalcFields(DataSet: TDataSet);
var DF,NF,Path,Nome:String;
begin
  NF:=Trim(VarToStr(A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',cdsT191.FieldByName('CODICE').AsString,'NOMEFILE')));
  DF:=Trim(VarToStr(A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',cdsT191.FieldByName('CODICE').AsString,'DATAFILE')));
  cdsT191.FieldByName('D_CODICE').AsString:=VarToStr(A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',cdsT191.FieldByName('CODICE').AsString,'DESCRIZIONE'));
  cdsT191.FieldByName('D_NOMEFILE').AsString:=NF;
  if DF <> '' then
  begin
    Path:=ExtractFilePath(NF);
    Nome:=ExtractFileName(NF);
    if pos('.',Nome) <> 0 then
      Insert(FormatDateTime(DF,A074FRiepilogoBuoni.DataAcquisto),Nome,pos('.',Nome))
    else
      Nome:=Nome + FormatDateTime(DF,A074FRiepilogoBuoni.DataAcquisto);
    cdsT191.FieldByName('D_NOMEFILE').AsString:=Path + Nome;  
  end;
end;

end.

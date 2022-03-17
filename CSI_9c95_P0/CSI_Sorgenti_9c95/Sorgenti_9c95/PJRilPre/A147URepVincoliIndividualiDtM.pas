unit A147URepVincoliIndividualiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, A147URepVincoliIndividualiMW;

type
  TA147FRepVincoliIndividualiDtM = class(TR004FGestStoricoDtM)
    selT385: TOracleDataSet;
    selT385PROGRESSIVO: TFloatField;
    selT385DECORRENZA: TDateTimeField;
    selT385DECORRENZA_FINE: TDateTimeField;
    selT385TIPOLOGIA: TStringField;
    selT385GIORNO: TStringField;
    selT385TURNI: TStringField;
    selT385DISPONIBILE: TStringField;
    selT385BLOCCA_PIANIF: TStringField;
    selT385DescGiorno: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT385NewRecord(DataSet: TDataSet);
    procedure selT385CalcFields(DataSet: TDataSet);
    procedure selT385AfterScroll(DataSet: TDataSet);
    procedure selT385BeforePost(DataSet: TDataSet);
    procedure selT385AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A147MW: TA147FRepVincoliIndividualiMW;
    procedure SettaProgressivo;
  end;

var
  A147FRepVincoliIndividualiDtM: TA147FRepVincoliIndividualiDtM;

implementation

uses A147URepVincoliIndividuali;

{$R *.dfm}

procedure TA147FRepVincoliIndividualiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT385,[evAfterDelete,
                              evBeforeDelete]);
  A147MW:=TA147FRepVincoliIndividualiMW.Create(Self);
  A147MW.selT385:=selT385;
  selT385.Open;
end;

procedure TA147FRepVincoliIndividualiDtM.selT385AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA147FRepVincoliIndividualiDtM.selT385AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A147FRepVincoliIndividuali.cmbGiorno.ItemIndex:=R180IndexOf(A147FRepVincoliIndividuali.cmbGiorno.Items,selT385.FieldByName('GIORNO').AsString,2);
end;

procedure TA147FRepVincoliIndividualiDtM.selT385BeforePost(DataSet: TDataSet);
begin
  A147MW.Giorno:=TrimRight(Copy(A147FRepVincoliIndividuali.cmbGiorno.Text,1,2));
  A147MW.BeforePost;
  inherited;
  //Registrazione operazioni
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA147FRepVincoliIndividualiDtM.selT385CalcFields(DataSet: TDataSet);
begin
  inherited;
  A147MW.CalcFields;
end;

procedure TA147FRepVincoliIndividualiDtM.selT385NewRecord(DataSet: TDataSet);
begin
  inherited;
  A147MW.NewRecord;
end;

procedure TA147FRepVincoliIndividualiDtM.SettaProgressivo;
begin
  selT385.Close;
  selT385.SetVariable('Tipo',A147MW.CodTipologia);
  selT385.SetVariable('Progressivo',C700Progressivo);
  selT385.Open;
end;

end.

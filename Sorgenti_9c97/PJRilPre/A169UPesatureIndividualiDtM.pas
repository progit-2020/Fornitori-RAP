unit A169UPesatureIndividualiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, A169UPesatureIndividualiMW, A169UCalcoloDtM;

type
  TA169FPesatureIndividualiDtM = class(TR004FGestStoricoDtM)
    selT773: TOracleDataSet;
    selT773CODGRUPPO: TStringField;
    selT773DESCRIZIONE: TStringField;
    selT773FILTRO_ANAGRAFE: TStringField;
    selT773CODTIPOQUOTA: TStringField;
    selT773PESO_TOTALE: TFloatField;
    selT773PESO_IND_MIN: TFloatField;
    selT773PESO_IND_MAX: TFloatField;
    selT773QUOTA_TOTALE: TFloatField;
    selT773DATARIF: TDateTimeField;
    selT773ANNO: TFloatField;
    selT773CHIUSO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT773AfterScroll(DataSet: TDataSet);
    procedure selT773NewRecord(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure InizioCiclo;
    procedure AvanzamentoCiclo;
    procedure FineCiclo;
  public
    A169FPesatureIndividualiMW: TA169FPesatureIndividualiMW;
  end;

var
  A169FPesatureIndividualiDtM: TA169FPesatureIndividualiDtM;

implementation

uses A169UPesatureIndividuali;

{$R *.dfm}

procedure TA169FPesatureIndividualiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT773,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A169FPesatureIndividualiMW:=TA169FPesatureIndividualiMW.Create(Self);
  A169FPesatureIndividualiMW.selT773:=selT773;
  A169FPesatureIndividualiMW.InizioCiclo:=InizioCiclo;
  A169FPesatureIndividualiMW.AvanzamentoCiclo:=AvanzamentoCiclo;
  A169FPesatureIndividualiMW.FineCiclo:=FineCiclo;
  A169FPesatureIndividuali.DButton.DataSet:=selT773;
  selT773.Open;
  A169FPesatureIndividualiMW.selT765.SetVariable('DEC',StrToDate('01/01/1900'));
  A169FPesatureIndividualiMW.selT765.Open;
end;

procedure TA169FPesatureIndividualiDtM.InizioCiclo;
begin
  A169FPesatureIndividuali.btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  A169FPesatureIndividuali.ProgressBar1.Max:=A169FPesatureIndividualiMW.selV430.RecordCount;
  A169FPesatureIndividuali.ProgressBar1.Position:=0;
end;

procedure TA169FPesatureIndividualiDtM.AvanzamentoCiclo;
begin
  A169FPesatureIndividuali.ProgressBar1.StepBy(1);
end;

procedure TA169FPesatureIndividualiDtM.FineCiclo;
begin
  Screen.Cursor:=crDefault;
  A169FPesatureIndividuali.ProgressBar1.Position:=0;
  A169FPesatureIndividuali.btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    A169FPesatureIndividuali.Aggiorna(False,False);
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
      A169FPesatureIndividuali.btnAnomalieClick(nil);
  end
  else
    A169FPesatureIndividuali.Aggiorna(True,False);
end;

procedure TA169FPesatureIndividualiDtM.selT773AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A169FPesatureIndividuali.dcmbTipoQuotaCloseUp(nil);
  A169FPesatureIndividuali.actModifica.Enabled:=selT773.FieldByName('CHIUSO').AsString = 'N';
  A169FPesatureIndividuali.actCancella.Enabled:=selT773.FieldByName('CHIUSO').AsString = 'N';
  A169FPesatureIndividuali.frmToolbarFiglio.actTFModifica.Enabled:=selT773.FieldByName('CHIUSO').AsString = 'N';
  A169FPesatureIndividualiMW.selT773AfterScroll(DataSet);
  A169FPesatureIndividuali.Aggiorna(False,False);
end;

procedure TA169FPesatureIndividualiDtM.selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  A169FPesatureIndividualiMW.selT773FilterRecord(DataSet,Accept);
end;

procedure TA169FPesatureIndividualiDtM.AfterPost(DataSet: TDataSet);
var s:String;
begin
  inherited;
  if A169FPesatureIndividualiMW.AggT774 then
  begin
    R180MessageBox(A000MSG_A169_MSG_DIPENDENTI_CAMBIATI,'INFORMA');
  end;
  A169FPesatureIndividualiMW.AfterPost(DataSet);
end;

procedure TA169FPesatureIndividualiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A169FPesatureIndividualiMW.BeforePostNoStorico(DataSet);
  inherited;
end;

procedure TA169FPesatureIndividualiDtM.selT773NewRecord(DataSet: TDataSet);
begin
  inherited;
  A169FPesatureIndividualiMW.selT773NewRecord(DataSet);
end;

end.

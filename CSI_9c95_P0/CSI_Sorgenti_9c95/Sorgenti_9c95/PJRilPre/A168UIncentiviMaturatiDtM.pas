unit A168UIncentiviMaturatiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, DatiBloccati,
  C700USelezioneAnagrafe, SelAnagrafe, C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, A168UIncentiviMaturatiMW;

type
  TA168FIncentiviMaturatiDtM = class(TR004FGestStoricoDtM)
    selT762: TOracleDataSet;
    selT762PROGRESSIVO: TFloatField;
    selT762ANNO: TFloatField;
    selT762MESE: TFloatField;
    selT762VARIAZIONI: TFloatField;
    selT762CODTIPOQUOTA: TStringField;
    selT762TIPOIMPORTO: TStringField;
    selT762Desc_Mese: TStringField;
    selT762Desc_Importo: TStringField;
    selT762Desc_Quota: TStringField;
    selT762Tipologia_Quota: TStringField;
    dsrT763: TDataSource;
    selT762Risparmio: TStringField;
    selT762IMPORTO: TFloatField;
    selT762GIORNI_ORE: TFloatField;
    selT762TIPOCALCOLO: TStringField;
    selT762DescGiorniOre: TStringField;
    selT763_old: TOracleDataSet;
    selT763_oldPROGRESSIVO: TFloatField;
    selT763_oldANNO: TFloatField;
    selT763_oldMESE: TFloatField;
    selT763_oldTIPOQUOTA: TStringField;
    selT763_oldTIPOABBATTIMENTO: TStringField;
    selT763_oldDesc_Abbattimento: TStringField;
    selT763_oldQUOTAABBATTIMENTO: TFloatField;
    selT763_oldMESEAPPLICAZIONEABBATTIMENTO: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT762CalcFields(DataSet: TDataSet);
    procedure selT762AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT762NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A168FIncentiviMaturatiMW: TA168FIncentiviMaturatiMW;
  end;

var
  A168FIncentiviMaturatiDtM: TA168FIncentiviMaturatiDtM;

implementation

{$R *.dfm}

procedure TA168FIncentiviMaturatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT762,[evAfterDelete,
                              evAfterPost,
                              evBeforeDelete,
                              evBeforePostNoStorico]);

  A168FIncentiviMaturatiMW:=TA168FIncentiviMaturatiMW.Create(Self);
  A168FIncentiviMaturatiMW.selT762:=selT762;
  dsrT763.DataSet:=A168FIncentiviMaturatiMW.selT763;
  selT762.FieldByName('DESC_QUOTA').LookupDataSet:=A168FIncentiviMaturatiMW.selT765;
  selT762.FieldByName('TIPOLOGIA_QUOTA').LookupDataSet:=A168FIncentiviMaturatiMW.selT765;
  selT762.FieldByName('RISPARMIO').LookupDataSet:=A168FIncentiviMaturatiMW.selT766;
end;

procedure TA168FIncentiviMaturatiDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.BeforeDelete(DataSet);
end;

procedure TA168FIncentiviMaturatiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.BeforePostNoStorico(DataSet);
end;

procedure TA168FIncentiviMaturatiDtM.selT762AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with A168FIncentiviMaturatiMW.selT763 do
  begin
    Close;
    SetVariable('PROG',selT762.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('ANNO',selT762.FieldByName('ANNO').AsInteger);
    SetVariable('MESE',selT762.FieldByName('MESE').AsInteger);
    SetVariable('QUOTA',selT762.FieldByName('CODTIPOQUOTA').AsString);
    Open;
  end;
end;

procedure TA168FIncentiviMaturatiDtM.selT762CalcFields(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.selT762CalcFields(DataSet);
end;

procedure TA168FIncentiviMaturatiDtM.selT762NewRecord(DataSet: TDataSet);
begin
  inherited;
  A168FIncentiviMaturatiMW.selT762NewRecord(DataSet);
end;

end.

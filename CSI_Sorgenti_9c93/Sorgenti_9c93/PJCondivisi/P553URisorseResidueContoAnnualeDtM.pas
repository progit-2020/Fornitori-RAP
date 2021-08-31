unit P553URisorseResidueContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, C180FunzioniGenerali;

type
  TP553FRisorseResidueContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP553: TOracleDataSet;
    selP552: TOracleDataSet;
    selT470: TOracleDataSet;
    dsrT470: TDataSource;
    selP553ANNO: TIntegerField;
    selP553COD_TABELLA: TStringField;
    selP553COLONNA_RIGA: TIntegerField;
    selP553MACRO_CATEG: TStringField;
    selP553DESCRIZIONE: TStringField;
    selP553IMPORTO_RESIDUO: TFloatField;
    selP553COD_TABELLA_QUOTE: TStringField;
    selP553COLONNA_QUOTE: TIntegerField;
    QSQL: TOracleDataSet;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP553AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P553FRisorseResidueContoAnnualeDtM: TP553FRisorseResidueContoAnnualeDtM;

implementation

{$R *.dfm}

uses P553URisorseResidueContoAnnuale;

procedure TP553FRisorseResidueContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP553, [evBeforePostNoStorico,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost]);
  selT470.Open;
  P553FRisorseResidueContoAnnuale.DButton.DataSet:=selP553;
  selP553.Open;
end;

procedure TP553FRisorseResidueContoAnnualeDtM.selP553AfterScroll(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  if P553FRisorseResidueContoAnnuale <> nil then
    with P553FRisorseResidueContoAnnuale do
    begin
      CaricaComboTabelle;
      i:=R180IndexOf(CmbTabella.Items,Dataset.FieldByName('COD_TABELLA').AsString,10);
      if i >= 0 then
        CmbTabella.Text:=Format('%-10s',[Dataset.FieldByName('COD_TABELLA').AsString]) + '-' +
                                    Copy(CmbTabella.Items[i],12,Length(CmbTabella.Items[i])-11)
      else
        CmbTabella.Text:='';
      cmbTabellaChange(nil);
      i:=R180IndexOf(CmbColonnaRiga.Items,Dataset.FieldByName('COLONNA_RIGA').AsString,3);
      if i >= 0 then
        CmbColonnaRiga.Text:=Format('%-3s',[Dataset.FieldByName('COLONNA_RIGA').AsString]) + '-' +
                                    Copy(CmbColonnaRiga.Items[i],5,Length(CmbColonnaRiga.Items[i])-4)
      else
        CmbColonnaRiga.Text:='';
      i:=R180IndexOf(CmbTabellaColonna.Items,Dataset.FieldByName('COD_TABELLA_QUOTE').AsString,10);
      if i >= 0 then
        CmbTabellaColonna.Text:=Format('%-10s',[Dataset.FieldByName('COD_TABELLA_QUOTE').AsString]) + '-' +
                                    Copy(CmbTabellaColonna.Items[i],12,Length(CmbTabellaColonna.Items[i])-11)
      else
        CmbTabellaColonna.Text:='';
      cmbTabellaColonnaChange(nil);
      i:=R180IndexOf(CmbColonna.Items,Dataset.FieldByName('COLONNA_QUOTE').AsString,3);
      if i >= 0 then
        CmbColonna.Text:=Format('%-3s',[Dataset.FieldByName('COLONNA_QUOTE').AsString]) + '-' +
                                    Copy(CmbColonna.Items[i],5,Length(CmbColonna.Items[i])-4)
      else
        CmbColonna.Text:='';
    end;
end;

procedure TP553FRisorseResidueContoAnnualeDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.FieldByName('IMPORTO_RESIDUO').IsNull) or (DataSet.FieldByName('IMPORTO_RESIDUO').AsFloat = 0) then
    raise exception.Create('Specificare un importo residuo diverso da zero!');
  with P553FRisorseResidueContoAnnuale do
  begin
    DataSet.FieldByName('COD_TABELLA').AsString:=TrimRight(Copy(CmbTabella.Text,1,10));
    DataSet.FieldByName('COLONNA_RIGA').AsString:=TrimRight(Copy(CmbColonnaRiga.Text,1,3));
    DataSet.FieldByName('COD_TABELLA_QUOTE').AsString:='';
    DataSet.FieldByName('COLONNA_QUOTE').AsString:='';
    if grbColonnaCalcolo.Visible then
    begin
      DataSet.FieldByName('COD_TABELLA_QUOTE').AsString:=TrimRight(Copy(CmbTabellaColonna.Text,1,10));
      DataSet.FieldByName('COLONNA_QUOTE').AsString:=TrimRight(Copy(CmbColonna.Text,1,3));
    end;
  end;
end;

end.

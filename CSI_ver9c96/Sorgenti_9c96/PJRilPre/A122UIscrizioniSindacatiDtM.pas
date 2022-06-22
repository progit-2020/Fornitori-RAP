unit A122UIscrizioniSindacatiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A122UIscrizioniSindacaliMW, A000UMessaggi;

type
  TA122FIscrizioniSindacatiDtM = class(TR004FGestStoricoDtM)
    selT246: TOracleDataSet;
    selT246PROGRESSIVO: TIntegerField;
    selT246NUM_PROT_ISCR: TFloatField;
    selT246DATA_ISCR: TDateTimeField;
    selT246DATA_DEC_ISCR: TDateTimeField;
    selT246NUM_PROT_CESS: TFloatField;
    selT246DATA_CESS: TDateTimeField;
    selT246DATA_DEC_CES: TDateTimeField;
    selT246COD_SINDACATO: TStringField;
    selT246DESC_SINDACATO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT246DATA_ISCRValidate(Sender: TField);
    procedure selT246DATA_CESSValidate(Sender: TField);
    procedure selT246DATA_DEC_ISCRValidate(Sender: TField);
    procedure selT246DATA_DEC_CESValidate(Sender: TField);
    procedure selT246CalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT246BeforeInsert(DataSet: TDataSet);
    procedure selT246COD_SINDACATOChange(Sender: TField);
  private
    procedure AssegnaSindacati(lista :TStringList);
  public
    A122MW: TA122FIscrizioniSindacaliMW;
  end;

var
  A122FIscrizioniSindacatiDtM: TA122FIscrizioniSindacatiDtM;

implementation

uses A122UIscrizioniSindacati;

{$R *.dfm}

procedure TA122FIscrizioniSindacatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT246,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A122FIscrizioniSindacati.DButton.DataSet:=selT246;
  A122MW:=TA122FIscrizioniSindacaliMW.Create(Self);
  A122MW.selT246:=selT246;
  A122MW.AssegnaSindacati:=AssegnaSindacati;
  selT246.Open;
end;

procedure TA122FIscrizioniSindacatiDtM.OnNewRecord(DataSet: TDataSet);
begin
  A122MW.SelT246OnNewRecord;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246DATA_ISCRValidate(Sender: TField);
begin
  A122MW.selT246DATA_ISCRValidate;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246DATA_CESSValidate(Sender: TField);
begin
  A122MW.selT246DATA_CESSValidate;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246DATA_DEC_ISCRValidate(Sender: TField);
begin
  A122MW.selT246DATA_DEC_ISCRValidate;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246DATA_DEC_CESValidate(Sender: TField);
begin
  A122MW.selT246DATA_DEC_CESValidate;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246CalcFields(DataSet: TDataSet);
begin
  A122MW.selT246CalcFields;
end;

procedure TA122FIscrizioniSindacatiDtM.AssegnaSindacati(lista: TStringList);
begin
  A122FIscrizioniSindacati.grdIscrizioni.Columns[6].PickList.Assign(lista);
end;

procedure TA122FIscrizioniSindacatiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A122MW.SelT246BeforePostStep1;
  //Controllo sul codice sindacato
  if R180IndexOf(A122FIscrizioniSindacati.grdIscrizioni.Columns[6].PickList,selT246.FieldByName('COD_SINDACATO').AsString,10) = -1 then
    raise exception.Create(A000MSG_A122_ERR_COD_SINDACATO);
  A122MW.SelT246BeforePostStep2;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246BeforeInsert(DataSet: TDataSet);
begin
  A122MW.selT246BeforeInsert;
end;

procedure TA122FIscrizioniSindacatiDtM.selT246COD_SINDACATOChange(Sender: TField);
begin
  inherited;
  A122MW.selT246COD_SINDACATOChange(Sender);
end;

end.

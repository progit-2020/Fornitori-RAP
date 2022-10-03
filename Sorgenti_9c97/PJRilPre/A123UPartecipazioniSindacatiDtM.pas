unit A123UPartecipazioniSindacatiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, Oracle, DB, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A123UPartecipazioniSindacatiMW, A000UMessaggi;

type
  TA123FPartecipazioniSindacatiDtM = class(TR004FGestStoricoDtM)
    selT247: TOracleDataSet;
    selT247PROGRESSIVO: TIntegerField;
    selT247DADATA: TDateTimeField;
    selT247ADATA: TDateTimeField;
    selT247COD_SINDACATO: TStringField;
    selT247COD_ORGANISMO: TStringField;
    selT247DESC_SINDACATO: TStringField;
    selT247DESC_ORGANISMO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT247BeforeInsert(DataSet: TDataSet);
    procedure selT247CalcFields(DataSet: TDataSet);
    procedure selT247DADATAValidate(Sender: TField);
    procedure selT247ADATAValidate(Sender: TField);
    procedure selT247COD_SINDACATOChange(Sender: TField);
    procedure selT247COD_ORGANISMOChange(Sender: TField);
  private
    procedure CaricaListeGriglia(Lista:TStringList);
  public
    A123MW: TA123FPartecipazioniSindacatiMW;
  end;

var
  A123FPartecipazioniSindacatiDtM: TA123FPartecipazioniSindacatiDtM;

implementation

uses A123UPartecipazioniSindacati;

{$R *.dfm}

procedure TA123FPartecipazioniSindacatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT247,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A123MW:=TA123FPartecipazioniSindacatiMW.Create(Self);
  A123FPartecipazioniSindacati.DButton.DataSet:=selT247;
  A123MW.selT247:=selT247;
  A123MW.CaricaListeGriglia:=CaricaListeGriglia;
  selT247.Open;
end;

procedure TA123FPartecipazioniSindacatiDtM.CaricaListeGriglia(Lista: TStringList);
begin
  A123FPartecipazioniSindacati.grdIscrizioni.Columns[2].PickList.Assign(Lista);
  //Carico lista organismi da proporre nel picklist della rispettiva colonna
  A123FPartecipazioniSindacati.grdIscrizioni.Columns[4].PickList.Clear;
  with A123MW.selT245 do
  begin
    First;
    while not Eof do
    begin
      A123FPartecipazioniSindacati.grdIscrizioni.Columns[4].PickList.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TA123FPartecipazioniSindacatiDtM.OnNewRecord(DataSet: TDataSet);
begin
  A123MW.SelT247OnNewRecord;
end;

procedure TA123FPartecipazioniSindacatiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A123MW.selT247BeforePostStep1;
  //Controllo sul codice sindacato
  if R180IndexOf(A123FPartecipazioniSindacati.grdIscrizioni.Columns[2].PickList,selT247.FieldByName('COD_SINDACATO').AsString,10) = -1 then
    raise exception.Create(A000MSG_A123_ERR_COD_SINDACATO);
  //Controllo sul codice organismo
  if R180IndexOf(A123FPartecipazioniSindacati.grdIscrizioni.Columns[4].PickList,selT247.FieldByName('COD_ORGANISMO').AsString,5) = -1 then
    raise exception.Create(A000MSG_A123_ERR_COD_ORGANISMO);
  A123MW.selT247BeforePostStep2;
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247BeforeInsert(DataSet: TDataSet);
begin
  A123MW.SelT247BeforeInsert;
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247CalcFields(DataSet: TDataSet);
begin
  A123MW.SelT247CalcFields;
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247DADATAValidate(Sender: TField);
begin
  A123MW.CaricaSindacati;
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247ADATAValidate(Sender: TField);
begin
  A123MW.SelT247ADATAValidate;
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247COD_SINDACATOChange(Sender: TField);
begin
  inherited;
  A123MW.SelT247COD_SINDACATOChange(Sender);
end;

procedure TA123FPartecipazioniSindacatiDtM.selT247COD_ORGANISMOChange(Sender: TField);
begin
  inherited;
  A123MW.selT247COD_ORGANISMOChange(Sender);
end;

end.

unit A162UIncentiviAssenzeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, DBCtrls, OracleData, Oracle, A000UInterfaccia, A000UCostanti, A000USessione,
  C180FunzioniGenerali, Grids, ExtCtrls, ComCtrls, DBGrids, Math,
  A162UIncentiviAssenzeMW, A000UMessaggi;

type
  TA162FIncentiviAssenzeDtM = class(TR004FGestStoricoDtM)
    selT769: TOracleDataSet;
    selT769DATO1: TStringField;
    selT769DECORRENZA: TDateTimeField;
    selT769DATO2: TStringField;
    selT769DATO3: TStringField;
    dsrDato1: TDataSource;
    dsrDato2: TDataSource;
    dsrDato3: TDataSource;
    selT769D_DATO1: TStringField;
    selT769D_DATO2: TStringField;
    selT769D_DATO3: TStringField;
    selT769PERC_ABBATTIMENTO: TFloatField;
    selT769PERC_ABB_FRANCHIGIA: TFloatField;
    selT769FORZA_ABB_GGINT: TStringField;
    dsrT255: TDataSource;
    dsrT256: TDataSource;
    selT769COD_TIPOACCORPCAUSALI: TStringField;
    selT769COD_CODICIACCORPCAUSALI: TStringField;
    selT769GESTIONE_FRANCHIGIA: TStringField;
    selT769CONTA_FRUITO_ORE: TStringField;
    selT769TIPO_ABBATTIMENTO: TStringField;
    dsrT766: TDataSource;
    selT769D_TIPOACCORP: TStringField;
    selT769D_TIPOABBAT: TStringField;
    selT769D_RISPARMIO: TStringField;
    selT769DECORRENZA_FINE: TDateTimeField;
    selT769CAUSALE: TStringField;
    dsrT265: TDataSource;
    selT769D_CAUSALE: TStringField;
    selT769ASSENZE_AGGIUNTIVE: TStringField;
    selT769PROPORZIONE_FRANCHIGIA: TStringField;
    selT769CONTA_SOLO_GGINT: TStringField;
    selT769D_CODICIACCORPCAUSALI: TStringField;
    selT769FRANCHIGIA_ASSENZE: TIntegerField;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT769AfterScroll(DataSet: TDataSet);
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
  public
    A162FIncentiviAssenzeMW: TA162FIncentiviAssenzeMW;
  end;

var
  A162FIncentiviAssenzeDtM: TA162FIncentiviAssenzeDtM;

implementation

uses A162UIncentiviAssenze;

{$R *.dfm}

procedure TA162FIncentiviAssenzeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A162FIncentiviAssenzeMW:=TA162FIncentiviAssenzeMW.Create(Self);
  A162FIncentiviAssenzeMW.selT769_Funzioni:=selT769;
  InterfacciaR004:=A162FIncentiviAssenze.InterfacciaR004;
  InizializzaDataSet(selT769,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  A162FIncentiviAssenze.DButton.DataSet:=selT769;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato1,Parametri.CampiRiferimento.C7_Dato1,InterfacciaR004.DataLavoro);
    selT769.FieldByName('D_DATO1').LookupDataset:=A162FIncentiviAssenzeMW.selDato1;
  end
  else
  begin
    selT769.FieldByName('D_DATO1').Free;
    A162FIncentiviAssenze.dlblDato1.DataSource:=nil;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato2,Parametri.CampiRiferimento.C7_Dato2,InterfacciaR004.DataLavoro);
    selT769.FieldByName('D_DATO2').LookupDataset:=A162FIncentiviAssenzeMW.selDato2;
  end
  else
  begin
    selT769.FieldByName('D_DATO2').Free;
    A162FIncentiviAssenze.dlblDato2.DataSource:=nil;
  end;

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato3,Parametri.CampiRiferimento.C7_Dato3,InterfacciaR004.DataLavoro);
    selT769.FieldByName('D_DATO3').LookupDataset:=A162FIncentiviAssenzeMW.selDato3;
  end
  else
  begin
    selT769.FieldByName('D_DATO3').Free;
    A162FIncentiviAssenze.dlblDato3.DataSource:=nil;
  end;

  selT769.FieldByName('D_TIPOACCORP').LookupDataSet:=A162FIncentiviAssenzeMW.selT255;
  selT769.FieldByName('D_CODICIACCORPCAUSALI').LookupDataSet:=A162FIncentiviAssenzeMW.selT256;
  selT769.FieldByName('D_CAUSALE').LookupDataSet:=A162FIncentiviAssenzeMW.selT265;
  selT769.FieldByName('D_TIPOABBAT').LookupDataSet:=A162FIncentiviAssenzeMW.selT766;
  selT769.FieldByName('D_RISPARMIO').LookupDataSet:=A162FIncentiviAssenzeMW.selT766;

  dsrDato1.Dataset:=A162FIncentiviAssenzeMW.selDato1;
  dsrDato2.Dataset:=A162FIncentiviAssenzeMW.selDato2;
  dsrDato3.Dataset:=A162FIncentiviAssenzeMW.selDato3;
  dsrT255.DataSet:=A162FIncentiviAssenzeMW.selT255;
  dsrT256.DataSet:=A162FIncentiviAssenzeMW.selT256;
  dsrT265.DataSet:=A162FIncentiviAssenzeMW.selT265;
  dsrT766.DataSet:=A162FIncentiviAssenzeMW.selT766;

  selT769.Open;
  selT769.Refresh;
end;

procedure TA162FIncentiviAssenzeDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A162FIncentiviAssenzeMW);
  inherited;
end;

procedure TA162FIncentiviAssenzeDtM.selT769AfterScroll(DataSet: TDataSet);
begin
  A162FIncentiviAssenzeMW.ImpostaTipoSelT256(selT769.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
  inherited;
  A162FIncentiviAssenzeMW.SelT769AfterScroll;
  A162FIncentiviAssenze.Abilitazioni;
end;

procedure TA162FIncentiviAssenzeDtM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A162FIncentiviAssenze.actRefresh.Execute;
end;

procedure TA162FIncentiviAssenzeDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A162FIncentiviAssenze.actRefresh.Execute;
end;

procedure TA162FIncentiviAssenzeDtM.BeforePost(DataSet: TDataSet);
begin
  A162FIncentiviAssenzeMW.SelT769BeforePost;
  inherited;
end;

end.


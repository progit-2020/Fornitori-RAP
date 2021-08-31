unit A131UGestioneAnticipiDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, DBGrids, C700USelezioneAnagrafe,
  Oracle, A000UInterfaccia, C180FunzioniGenerali, DBClient, A000UCostanti, A000USessione,
  A131UGestioneAnticipiMW;

type
  TA131FGestioneAnticipiDtm = class(TR004FGestStoricoDtM)
    selM060: TOracleDataSet;
    dscM060: TDataSource;
    selM060ANNO_MOVIMENTO: TStringField;
    selM060CASSA: TStringField;
    selM060COD_VOCE: TStringField;
    selM060FLAG_TOTALIZZATORE: TStringField;
    selM060STATO: TStringField;
    selM060NOTE: TStringField;
    selM060NUM_MOVIMENTO: TFloatField;
    selM060QUANTITA: TFloatField;
    selM060IMPORTO: TFloatField;
    selM060PROGRESSIVO: TFloatField;
    selM060DATA_MISSIONE: TDateTimeField;
    selM060DATA_IMPOSTAZIONE: TDateTimeField;
    selM060DATA_MOVIMENTO: TDateTimeField;
    dscM040: TDataSource;
    selM060ITA_EST: TStringField;
    selM060ID_MISSIONE: TIntegerField;
    selM060NROSOSP: TFloatField;
    selM060DESC_CODVOCE: TStringField;
    selM060D_STATO: TStringField;
    selM060PROTOCOLLO: TStringField;
    procedure selM060AfterScroll(DataSet: TDataSet);
    procedure AfterDelete(DataSet: TDataSet);         override;
    procedure BeforeEdit(DataSet: TDataSet);          override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet);           override;
    procedure selM060NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dscM040DataChange(Sender: TObject; Field: TField);
    procedure selM060CalcFields(DataSet: TDataSet);
  private
  public
    A131FGestioneAnticipiMW: TA131FGestioneAnticipiMW;
  end;

var
  A131FGestioneAnticipiDtm: TA131FGestioneAnticipiDtm;

implementation

uses A131UGestioneAnticipi, R001UGestTab;

{$R *.dfm}

procedure TA131FGestioneAnticipiDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selM060,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  A131FGestioneAnticipiMW:=TA131FGestioneAnticipiMW.Create(Self);
  A131FGestioneAnticipiMW.SelM060_Funzioni:=selM060;
  dscM040.DataSet:=A131FGestioneAnticipiMW.selM040;

  selM060.FieldByName('DESC_CODVOCE').LookupDataSet:=A131FGestioneAnticipiMW.selTAnticipi;
  //inizializzo con progressivo 0.
  //su cambia progressivo viene impostato quello corretto
  A131FGestioneAnticipiMW.ImpostaProgressivo;
end;

procedure TA131FGestioneAnticipiDtm.selM060NewRecord(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060NewRecord;
end;

procedure TA131FGestioneAnticipiDtm.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060AfterPost;
end;

procedure TA131FGestioneAnticipiDtm.BeforeEdit(DataSet: TDataSet);
begin
  DataSet.FieldByName('COD_VOCE').ReadOnly:=True;
end;

procedure TA131FGestioneAnticipiDtm.BeforePostNoStorico(DataSet: TDataSet);
var Msg:String;
begin
  inherited;
  Msg:=A131FGestioneAnticipiMW.selM060BeforePost;
  if (Msg <> '') then
  begin
    if R180MessageBox(Msg,'DOMANDA') <> mrYes then
      Abort;
  end;
end;

procedure TA131FGestioneAnticipiDtm.dscM040DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with A131FGestioneAnticipi do
  begin
//===========================
//DATI RELATIVI ALLE MISSIONI
//===========================
    LblDataDa.Caption:=A131FGestioneAnticipiMW.selM040.FieldByName('DATADA').AsString;
    LblProtocollo.Caption:=A131FGestioneAnticipiMW.selM040.FieldByName('PROTOCOLLO').AsString;
    LblMeseScarico.Caption:=A131FGestioneAnticipiMW.selM040.FieldByName('MESESCARICO').AsString;
    LblMeseCompetenza.Caption:=A131FGestioneAnticipiMW.selM040.FieldByName('MESECOMPETENZA').AsString;
  end;
end;

procedure TA131FGestioneAnticipiDtm.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060AfterDelete;
end;

procedure TA131FGestioneAnticipiDtm.selM060AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A131FGestioneAnticipiMW.selM060AfterScroll;
end;

procedure TA131FGestioneAnticipiDtm.selM060CalcFields(DataSet: TDataSet);
begin
  inherited;
  with selM060 do
  begin
    if FieldByName('STATO').AsString = 'S' then
      FieldByName('D_STATO').AsString:='Sospeso';
    if FieldByName('STATO').AsString = 'P' then
      FieldByName('D_STATO').AsString:='Protocollato';
    if FieldByName('STATO').AsString = 'L' then
      FieldByName('D_STATO').AsString:='Liquidato';
    if FieldByName('STATO').AsString = 'R' then
      FieldByName('D_STATO').AsString:='Recuperato';
  end;
end;

procedure TA131FGestioneAnticipiDtm.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A131FGestioneAnticipiMW);
  inherited;
end;

end.

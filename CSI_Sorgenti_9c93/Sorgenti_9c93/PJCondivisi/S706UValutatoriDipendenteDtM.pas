unit S706UValutatoriDipendenteDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, QueryStorico,
  A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe;

type
  TS706FValutatoriDipendenteDtM = class(TR004FGestStoricoDtM)
    selSG706: TOracleDataSet;
    selSG706DECORRENZA: TDateTimeField;
    selSG706DECORRENZA_FINE: TDateTimeField;
    selT030: TOracleDataSet;
    selT030PROGRESSIVO: TFloatField;
    selT030MATRICOLA: TStringField;
    selT030NOMINATIVO: TStringField;
    selT030CODFISCALE: TStringField;
    selSG706PROGRESSIVO: TIntegerField;
    insSG706: TOracleQuery;
    delSG706: TOracleQuery;
    selSG706PROGRESSIVO_VALUTATO: TIntegerField;
    selSG706MATRICOLA: TStringField;
    selSG706NOMINATIVO: TStringField;
    selSG706a: TOracleDataSet;
    selT430: TOracleDataSet;
    selCOLS: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure selSG706ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selSG706CalcFields(DataSet: TDataSet);
    procedure selSG706AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    QSGruppoValutatore:TQueryStorico;
  end;

var
  S706FValutatoriDipendenteDtM: TS706FValutatoriDipendenteDtM;

implementation

uses S706UValutatoriDipendente;

{$R *.dfm}

procedure TS706FValutatoriDipendenteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selSG706,[evBeforeInsert,
                               evBeforePostNoStorico,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost
                               ]);
  S706FValutatoriDipendente.DButton.Dataset:=selSG706;
  QSGruppoValutatore:=TQueryStorico.Create(nil);
  QSGruppoValutatore.Session:=SessioneOracle;
  selT030.Open;
  selSG706.Open;
  //Prelevo le lunghezze dei dati anagrafici
  selCOLS.SetVariable('CAMPO','''' + Parametri.CampiRiferimento.C21_ValutazioniRsp1 + '''');
  selCOLS.Open;
  if selCOLS.RecordCount > 0 then
    S706FValutatoriDipendente.LungDato:=selCOLS.FieldByName('DATA_LENGTH').AsInteger
  else
    S706FValutatoriDipendente.LungDato:=0;
  selCOLS.Close;
  selCOLS.SetVariable('CAMPO','''' + Parametri.CampiRiferimento.C21_ValutazioniRsp2 + '''');
  selCOLS.Open;
  if selCOLS.RecordCount > 0 then
    S706FValutatoriDipendente.LungDato2:=selCOLS.FieldByName('DATA_LENGTH').AsInteger
  else
    S706FValutatoriDipendente.LungDato2:=0;
end;

procedure TS706FValutatoriDipendenteDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(QSGruppoValutatore);
end;

procedure TS706FValutatoriDipendenteDtM.selSG706AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S706FValutatoriDipendente.NumRecords;
end;

procedure TS706FValutatoriDipendenteDtM.selSG706ApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: string);
begin
  inherited;
  if (Action <> 'D') and (Action <> 'I') and (Action <> 'U') then
    Exit;
  if selSG706.FieldByName('PROGRESSIVO_VALUTATO').IsNull then
    raise exception.Create('Attenzione: Inserire il dipendente da valutare');
end;

procedure TS706FValutatoriDipendenteDtM.selSG706CalcFields(DataSet: TDataSet);
begin
  inherited;
  selSG706.FieldByName('MATRICOLA').AsString:=VarToStr(selT030.Lookup('PROGRESSIVO',selSG706.FieldByName('PROGRESSIVO_VALUTATO').AsInteger,'MATRICOLA'));
  selSG706.FieldByName('NOMINATIVO').AsString:=VarToStr(selT030.Lookup('PROGRESSIVO',selSG706.FieldByName('PROGRESSIVO_VALUTATO').AsInteger,'NOMINATIVO'));
end;

procedure TS706FValutatoriDipendenteDtM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  S706FValutatoriDipendente.dedtDecorrenza.SetFocus;
end;

procedure TS706FValutatoriDipendenteDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  selSG706.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
  if selSG706.FieldByName('DECORRENZA').AsDateTime > selSG706.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise Exception.Create('Impostare correttamente il periodo!');
end;

end.

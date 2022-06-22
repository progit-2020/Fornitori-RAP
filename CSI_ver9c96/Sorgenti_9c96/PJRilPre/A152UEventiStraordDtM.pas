unit A152UEventiStraordDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, A000UMessaggi, DB, OracleData, C180FunzioniGenerali,
  Oracle, DBClient;

type
  TA152FEventiStraordDtM = class(TR004FGestStoricoDtM)
    selT722: TOracleDataSet;
    selT722CODICE: TStringField;
    selT722DECORRENZA: TDateTimeField;
    selT722DECORRENZA_FINE: TDateTimeField;
    selT722DESCRIZIONE: TStringField;
    selT722ID: TIntegerField;
    selT722ORE_TOTALI: TStringField;
    selT722ORE_INDIV: TStringField;
    selT722CAUSALE_STR: TStringField;
    selT275: TOracleDataSet;
    selT722D_CAUSALE_STR: TStringField;
    selT723: TOracleDataSet;
    dsrT723: TDataSource;
    selT723ID: TIntegerField;
    selT723CODGRUPPO: TStringField;
    selT723FILTRO_ANAGRAFE: TStringField;
    selT723TIPO: TStringField;
    selT723DESCRIZIONE: TStringField;
    selT723ORE: TStringField;
    selT723IMPORTO: TFloatField;
    selT722CAUSALE_STR_DOM: TStringField;
    selT722D_CAUSALE_STR_DOM: TStringField;
    selT722STATO: TStringField;
    cdsStato: TClientDataSet;
    selT722D_STATO: TStringField;
    selServizi: TOracleDataSet;
    scrT723BeforePost: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT722ORE_INDIVValidate(Sender: TField);
    procedure CausaleSetText(Sender: TField; const Text: string);
    procedure ValidaCausale(Sender: TField);
    procedure selT722AfterScroll(DataSet: TDataSet);
    procedure selT723NewRecord(DataSet: TDataSet);
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT723BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A152FEventiStraordDtM: TA152FEventiStraordDtM;

implementation

uses A152UEventiStraord;

{$R *.dfm}

procedure TA152FEventiStraordDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A152FEventiStraord.InterfacciaR004;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selT722,[evBeforeEdit,
                             evBeforeInsert,
                             evBeforePost,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnNewRecord,
                             evOnTranslateMessage]);
  with cdsStato do
  begin
    LogChanges:=False;
    EmptyDataSet;
    AppendRecord(['A','Aperto']);
    AppendRecord(['C','Chiuso']);
  end;

  selT275.Open;
  selT722.Open;
end;

procedure TA152FEventiStraordDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ID').Clear;
end;

procedure TA152FEventiStraordDtM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ID').ReadOnly:=True;
end;

procedure TA152FEventiStraordDtM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ID').ReadOnly:=True;
end;

procedure TA152FEventiStraordDtM.selT722AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selT723 do
  begin
    Close;
    SetVariable('ID',selT722.FieldByName('ID').AsInteger);
    Open;
  end;
end;

procedure TA152FEventiStraordDtM.selT722ORE_INDIVValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA152FEventiStraordDtM.selT723BeforePost(DataSet: TDataSet);
begin
  inherited;
  with scrT723BeforePost do
  begin
    ClearVariables;
    if selT723.State = dsEdit then
      SetVariable('P_ROWID',selT723.Rowid);
    SetVariable('P_LISTA',selT723.FieldByName('FILTRO_ANAGRAFE').AsString);
    SetVariable('P_ID',selT722.FieldByName('ID').AsInteger);
    Execute;
    if VarToStr(GetVariable('RESULT')) <> '' then
      raise Exception.Create('Servizi già in uso:' + #13#10 + GetVariable('RESULT'));
  end;
end;

procedure TA152FEventiStraordDtM.selT723NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT723.FieldByName('ID').AsInteger:=selT722.FieldByName('ID').AsInteger;
  selT723.FieldByName('TIPO').AsString:=selT722.FieldByName('CAUSALE_STR').AsString;
end;

procedure TA152FEventiStraordDtM.CausaleSetText(Sender: TField; const Text: string);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TA152FEventiStraordDtM.ValidaCausale(Sender: TField);
begin
  if (not Sender.IsNull) then
    if VarToStr(selT275.Lookup('CODICE',Sender.AsString,'CODICE')) = '' then
      raise exception.Create(Format(A000MSG_ERR_FMT_ELEM_LISTA,['Causale ' + Sender.AsString]));
end;

end.

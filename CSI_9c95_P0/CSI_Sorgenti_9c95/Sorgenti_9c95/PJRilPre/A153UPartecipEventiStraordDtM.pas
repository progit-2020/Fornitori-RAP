unit A153UPartecipEventiStraordDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  OracleData, Dialogs,
  A000USessione, A000UCostanti, A000UMessaggi, C700USelezioneAnagrafe, R004UGestStoricoDTM,
  DBClient;

type
  TA153FPartecipEventiStraordDtM = class(TR004FGestStoricoDtM)
    selT724: TOracleDataSet;
    selT724PROGRESSIVO: TIntegerField;
    selT724ID: TIntegerField;
    selT724DAL: TDateTimeField;
    selT724AL: TDateTimeField;
    selT724SERVIZI: TStringField;
    selT724DELEGATO: TStringField;
    selT724TIPO_LAVORO: TStringField;
    selT722: TOracleDataSet;
    selT724D_CODICE: TStringField;
    selT724D_DESCRIZIONE: TStringField;
    selT722ID: TIntegerField;
    selT722CODICE: TStringField;
    selT722DESCRIZIONE: TStringField;
    selT722DECORRENZA: TDateTimeField;
    selT722DECORRENZA_FINE: TDateTimeField;
    selT724D_DECORRENZA_FINE: TDateTimeField;
    selT724D_DECORRENZA: TDateTimeField;
    selServizi: TOracleDataSet;
    cdsTipoLavoro: TClientDataSet;
    selT724D_TIPO_LAVORO: TStringField;
    procedure selT724NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT724DELEGATOValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ApriSelServizi;
  end;

var
  A153FPartecipEventiStraordDtM: TA153FPartecipEventiStraordDtM;

implementation

{$R *.dfm}

procedure TA153FPartecipEventiStraordDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT724,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

  with cdsTipoLavoro do
  begin
    LogChanges:=False;
    EmptyDataSet;
    AppendRecord(['C','Comandato']);
    AppendRecord(['V','Volontario']);
  end;

  selT722.Open;
end;

procedure TA153FPartecipEventiStraordDtM.ApriSelServizi;
var Dal,Al,Filtro:String;
begin
  Dal:=A153FPartecipEventiStraordDtM.selT724.FieldByName('DAL').AsString;
  Al:=A153FPartecipEventiStraordDtM.selT724.FieldByName('AL').AsString;
  Filtro:=Format(#13#10 + 'AND ''%s'' >= DATADECORRENZA AND ''%s'' <= DATAFINE AND ''%s'' >= INIZIO AND ''%s'' <= NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY''))' + #13#10,[Al,Dal,Al,Dal]);
  selServizi.SetVariable('FILTRO',Filtro);
  selServizi.Open;
end;

procedure TA153FPartecipEventiStraordDtM.BeforePostNoStorico(DataSet: TDataSet);
var s:String;
begin
  inherited;
  if selT724.FieldByName('DAL').IsNull then
    raise Exception.Create(A000MSG_ERR_DATA_INIZIO_PERIODO);
  if selT724.FieldByName('AL').IsNull then
    raise Exception.Create(A000MSG_ERR_DATA_FINE_PERIODO);
  if selT724.FieldByName('DAL').AsDateTime > selT724.FieldByName('AL').AsDateTime then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  if selT724.FieldByName('DAL').AsDateTime < selT724.FieldByName('D_DECORRENZA').AsDateTime then
    raise Exception.Create(Format(A000MSG_A153_ERR_FMT_DATA_ANTECEDENTE,[selT724.FieldByName('DAL').AsString]));
  if selT724.FieldByName('AL').AsDateTime > selT724.FieldByName('D_DECORRENZA_FINE').AsDateTime then
    raise Exception.Create(Format(A000MSG_A153_ERR_FMT_DATA_SUCCESSIVA,[selT724.FieldByName('AL').AsString]));
  if selT724.FieldByName('SERVIZI').IsNull then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Servizi']));

  if A000LookupTabella(TORINO_COMUNE_STRUTT_EVENTI_STR,selServizi) then
  try
    ApriSelServizi;
    for s in selT724.FieldByName('SERVIZI').AsString.Split([',']) do
      if not selServizi.SearchRecord('CODICE',s,[srFromBeginning]) then
        raise Exception.CreateFmt('Il servizio %s non esiste.',[s]);
  finally
    selServizi.Close;
  end;
end;

procedure TA153FPartecipEventiStraordDtM.selT724DELEGATOValidate(Sender: TField);
begin
  if Sender.AsString <> '' then
    if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') then
      raise exception.Create(A000MSG_ERR_DATO_BOOLEAN_ERRATO);
end;

procedure TA153FPartecipEventiStraordDtM.selT724NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
end;

end.

unit A162UIncentiviAssenzeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, A000UInterfaccia,
  A000USessione, A000UCostanti, A000UMessaggi;

type
  TA162FIncentiviAssenzeMW = class(TR005FDataModuleMW)
    selDato1: TOracleDataSet;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    selT255: TOracleDataSet;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    selT255DESCRIZIONE: TStringField;
    selT256: TOracleDataSet;
    selT256COD_CODICIACCORPCAUSALI: TStringField;
    selT256DESCRIZIONE: TStringField;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    selT766: TOracleDataSet;
    selT766CODICE: TStringField;
    selT766DESCRIZIONE: TStringField;
    selT766RISPARMIO_BILANCIO: TStringField;
    selT265A: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelT769_Funzioni: TOracleDataset;
    procedure ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
  public
    procedure CaricamentoDati(Query: TOracleDataSet; ParametriDato: String; Decorrenza: TDateTime);
    procedure ImpostaDecorrenzaDatasetLookup;
    procedure ImpostaTipoSelT256(Tipo: String);
    function ListAssenzeAggiuntive(TipoAccorpCausali, CodAccorpCausali: String): TElencoValoriChecklist;
    procedure SelT769AfterScroll;
    procedure SelT769BeforePost;
    property selT769_Funzioni: TOracleDataset read FSelT769_Funzioni write FSelT769_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA162FIncentiviAssenzeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT255.Open;
  selT265.Open;
  selT766.Open;
end;

procedure TA162FIncentiviAssenzeMW.SelT769AfterScroll;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if not FSelT769_Funzioni.Eof then //refreshrecord resetterebbe EOF e i cicli vanno in loop
  begin
    ImpostaDecorrenzaDatasetLookup;
    FSelT769_Funzioni.RefreshRecord;
  end;
end;

procedure TA162FIncentiviAssenzeMW.SelT769BeforePost;
begin
  if (FSelT769_Funzioni.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat > 100) or (FSelT769_Funzioni.FieldByName('PERC_ABBATTIMENTO').AsFloat > 100) then
    raise Exception.Create(A000MSG_A162_ERR_PCT_ABBATT);
  if FSelT769_Funzioni.FieldByName('DATO1').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO1').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('DATO2').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO2').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('DATO3').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO3').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('COD_TIPOACCORPCAUSALI').AsString = '' then
    FSelT769_Funzioni.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('COD_CODICIACCORPCAUSALI').AsString = '' then
    FSelT769_Funzioni.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=' ';

  if (FSelT769_Funzioni.FieldByName('CAUSALE').IsNull) or
     (FSelT769_Funzioni.FieldByName('CAUSALE').AsString = '') then
    FSelT769_Funzioni.FieldByName('CAUSALE').AsString:=' ';

  if FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').IsNull then
    FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger:=0;

  if FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger > 999 then
    raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_TROPPO_GRANDE,['GG. franchigia']));


  if (FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger <> 0) and (FSelT769_Funzioni.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R') then
    FSelT769_Funzioni.FieldByName('TIPO_ABBATTIMENTO').AsString:='';
end;

procedure TA162FIncentiviAssenzeMW.ImpostaDecorrenzaDatasetLookup;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    ImpostaDecorrenza(selDato1,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    ImpostaDecorrenza(selDato2,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    ImpostaDecorrenza(selDato3,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
end;

procedure TA162FIncentiviAssenzeMW.CaricamentoDati(Query: TOracleDataSet; ParametriDato:String; Decorrenza: TDateTime);
begin
  if A000LookupTabella(ParametriDato,Query) then
  begin
    ImpostaDecorrenza(Query,Decorrenza);
  end;
end;

procedure TA162FIncentiviAssenzeMW.ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
begin
  if Query.VariableIndex('DECORRENZA') >= 0 then
    Query.SetVariable('DECORRENZA',Decorrenza);
  Query.Close;
  Query.Open;
end;

procedure TA162FIncentiviAssenzeMW.ImpostaTipoSelT256(Tipo:String);
begin
  selT256.Close;
  selT256.SetVariable('TIPO',Tipo);
  selT256.Open;
end;

function TA162FIncentiviAssenzeMW.ListAssenzeAggiuntive(TipoAccorpCausali:String; CodAccorpCausali:String): TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selT265A do
  begin
    Close;
    SetVariable('TipoAccorpCausali',TipoAccorpCausali);
    SetVariable('CodiciAccorpCausali',CodAccorpCausali);
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('Codice').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-5s %s',[codice, FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;
end.

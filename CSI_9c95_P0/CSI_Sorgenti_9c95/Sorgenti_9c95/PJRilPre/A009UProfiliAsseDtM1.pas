unit A009UProfiliAsseDtM1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali;

type
  TA009FProfiliAsseDtM1 = class(TR004FGestStoricoDtM)
    dsrT261: TDataSource;
    D260: TDataSource;
    D262: TDataSource;
    selT262: TOracleDataSet;
    selT262Anno: TFloatField;
    selT262CodProfilo: TStringField;
    selT262D_Profilo: TStringField;
    selT262CodRaggr: TStringField;
    selT262D_Raggruppamento: TStringField;
    selT262UMisura: TStringField;
    selT262Competenza1: TStringField;
    selT262Retribuzione1: TFloatField;
    selT262Competenza2: TStringField;
    selT262Retribuzione2: TFloatField;
    selT262Competenza3: TStringField;
    selT262Retribuzione3: TFloatField;
    selT262Competenza4: TStringField;
    selT262Retribuzione4: TFloatField;
    selT262Competenza5: TStringField;
    selT262Retribuzione5: TFloatField;
    selT262Competenza6: TStringField;
    selT262Retribuzione6: TFloatField;
    selT262PROPORZIONE: TStringField;
    selT262SOMMA: TStringField;
    selT262MG: TStringField;
    selT262ARRFAV: TStringField;
    selT262DATARES: TDateTimeField;
    selT262PROPGGMM: TStringField;
    selT262ARR_COMPETENZA_IN_ORE: TStringField;
    selT262MAX_FRUIZIONE_GIORN_IN_ORE: TStringField;
    selT262FRUIZ_ANNO_MINIMA: TStringField;
    selT261: TOracleDataSet;
    Q260: TOracleDataSet;
    Q262: TOracleDataSet;
    Q262ANNO: TFloatField;
    Q262CODPROFILO: TStringField;
    Q262CODRAGGR: TStringField;
    Q262DESCRIZIONE: TStringField;
    Q262UMISURA: TStringField;
    Q262COMPETENZA1: TStringField;
    Q262COMPETENZA2: TStringField;
    Q262COMPETENZA3: TStringField;
    Q262COMPETENZA4: TStringField;
    Q262COMPETENZA5: TStringField;
    Q262COMPETENZA6: TStringField;
    selT262FRUIZ_MINIMA_DAL: TDateTimeField;
    selT262RAPPORTI_UNITI: TStringField;
    selT262COMPETENZE_PERSONALIZZATE: TStringField;
    selT262FRUIZ_MAX_NUM_GG: TIntegerField;
    procedure ValidateOreMinuti(Sender: TField);
    procedure selT262Competenza1Validate(Sender: TField);
    procedure selT262AfterScroll(DataSet: TDataSet);
    procedure selT262NewRecord(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    SalvaAnno,SalvaProfilo:String;
  public
    { Public declarations }
  end;

var
  A009FProfiliAsseDtM1: TA009FProfiliAsseDtM1;

implementation

{$R *.dfm}

procedure TA009FProfiliAsseDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT262,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT262.Open;
  selT261.Open;
  Q260.Open;
end;

procedure TA009FProfiliAsseDtM1.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selT262.Close;
  selT261.Close;
  Q260.Close;
end;

procedure TA009FProfiliAsseDtM1.BeforePostNoStorico(DataSet: TDataSet);
begin
  if (selT262.State = dsEdit) and
     (selT262.FieldByName('CODRAGGR').AsString <> selT262.FieldByName('CODRAGGR').medpOldValue) then
    if R180MessageBox('Attenzione: dal profilo spariranno le competenze del raggruppamento ' + selT262.FieldByName('CODRAGGR').medpOldValue + '. Continuare?','DOMANDA') <> mrYes then
      Abort;
  selT262Competenza1.AsString:=StringReplace(selT262Competenza1.AsString,' ','',[rfReplaceAll]);
  selT262Competenza2.AsString:=StringReplace(selT262Competenza2.AsString,' ','',[rfReplaceAll]);
  selT262Competenza3.AsString:=StringReplace(selT262Competenza3.AsString,' ','',[rfReplaceAll]);
  selT262Competenza4.AsString:=StringReplace(selT262Competenza4.AsString,' ','',[rfReplaceAll]);
  selT262Competenza5.AsString:=StringReplace(selT262Competenza5.AsString,' ','',[rfReplaceAll]);
  selT262Competenza6.AsString:=StringReplace(selT262Competenza6.AsString,' ','',[rfReplaceAll]);
  inherited;
end;

procedure TA009FProfiliAsseDtM1.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet = selT262 then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODPROFILO').AsString) and
            A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODRAGGR').AsString)
  else if DataSet = selT261 then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q260 then
    Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA009FProfiliAsseDtM1.selT262NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT262.FieldByName('UMisura').AsString:='G';
  selT262.FieldByName('ARRFAV').AsString:='F';
  selT262.FieldByName('MG').AsString:='S';
  selT262.FieldByName('PROPORZIONE').AsString:='1';
  selT262.FieldByName('SOMMA').AsString:='S';
  selT262.FieldByName('ANNO').AsString:=SalvaAnno;
  selT262.FieldByName('CODPROFILO').AsString:=SalvaProfilo;
end;

procedure TA009FProfiliAsseDtM1.selT262AfterScroll(DataSet: TDataSet);
begin
  inherited;
  SalvaAnno:=selT262.FieldByName('ANNO').AsString;
  SalvaProfilo:=selT262.FieldByName('CODPROFILO').AsString;
end;

procedure TA009FProfiliAsseDtM1.selT262Competenza1Validate(Sender: TField);
begin
  inherited;
  {Controllo sui dati competenze: i giorni possono avere la parte decimale .5
  e le ore possono avere i minuti < 60}
  if selT262.FieldByName('UMisura').AsString = 'G' then
  begin
    if ((Copy(Sender.AsString,5,1) <> '5')) and ((Trim(Copy(Sender.AsString,5,1)) <> '')) then
      Raise Exception.Create('E'' ammesso solo .5 come parte decimale dei giorni');
  end
  else
    if (Copy(Sender.AsString,6,2) > '59') then
      Raise Exception.Create('I minuti devono essere minori di 60');
end;

procedure TA009FProfiliAsseDtM1.ValidateOreMinuti(Sender: TField);
begin
  inherited;
  if (Sender.IsNull) or (Trim(Sender.AsString) = '.') or (Trim(Sender.AsString) = '') then exit;
  R180OraValidate(Sender.AsString);
  if (Sender.FieldName = 'ARR_COMPETENZA_IN_ORE')then
    if 60 mod R180OreMinutiExt(Sender.AsString) <> 0 then
      raise Exception.Create('I minuti devono essere divisori di 60!');
end;

end.

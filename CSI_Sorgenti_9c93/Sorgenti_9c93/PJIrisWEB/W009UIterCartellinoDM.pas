unit W009UIterCartellinoDM;

interface

uses
  SysUtils, Classes, DB, Oracle, OracleData, StrUtils;

type
  TW009FIterCartellinoDM = class(TDataModule)
    selT860: TOracleDataSet;
    selRichiestePendenti: TOracleDataSet;
    selT070: TOracleDataSet;
    selT860ID: TFloatField;
    selT860ID_REVOCA: TFloatField;
    selT860ID_REVOCATO: TFloatField;
    selT860NOMINATIVO: TStringField;
    selT860MATRICOLA: TStringField;
    selT860COD_ITER: TStringField;
    selT860TIPO_RICHIESTA: TStringField;
    selT860AUTORIZZ_AUTOMATICA: TStringField;
    selT860REVOCABILE: TStringField;
    selT860DATA_RICHIESTA: TDateTimeField;
    selT860LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT860DATA_AUTORIZZAZIONE: TDateTimeField;
    selT860AUTORIZZAZIONE: TStringField;
    selT860NOMINATIVO_RESP: TStringField;
    selT860D_RESPONSABILE: TStringField;
    selT860D_AUTORIZZAZIONE: TStringField;
    selT860MESE_CARTELLINO: TDateTimeField;
    selT860PROGRESSIVO: TFloatField;
    selT860AUTORIZZ_UTILE: TStringField;
    selT860AUTORIZZ_REVOCA: TStringField;
    selT860FASE_CORRENTE: TFloatField;
    scrBloccaRiep: TOracleQuery;
    scrSbloccaRiep: TOracleQuery;
    selT860D_AUTORIZZAZIONE_FINALE: TStringField;
    selT860NOMINATIVO_RESP2: TStringField;
    selT860CF_RIEPILOGHI: TStringField;
    selT860ESISTE_PDF: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT860AfterOpen(DataSet: TDataSet);
    procedure selT860CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TW009FIterCartellinoDM.selT860CalcFields(DataSet: TDataSet);
var
  Aut,DescResp: String;
begin
  with TOracleDataset(DataSet) do
  begin
    // D_AUTORIZZAZIONE: descr. autorizzazione utile
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      Aut:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      Aut:='No'
    else
      Aut:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;

    // D_AUTORIZZAZIONE_FINALE: descr. autorizzazione finale
    if FieldByName('AUTORIZZAZIONE').AsString = '' then
      Aut:=''
    else if FieldByName('AUTORIZZAZIONE').AsString = 'N' then
      Aut:='No'
    else
      Aut:='Si';
    FieldByName('D_AUTORIZZAZIONE_FINALE').AsString:=Aut;

    // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
    // visualizza responsabile solo se c'è un'autorizzazione utile
    if Aut = '' then
      DescResp:=''
    else
      DescResp:=FieldByName(IfThen(Parametri.InibizioneIndividuale,'NOMINATIVO_RESP2','NOMINATIVO_RESP')).AsString;

    FieldByName('D_RESPONSABILE').AsString:=DescResp;
  end;
end;

procedure TW009FIterCartellinoDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
 except
 end;
end;

procedure TW009FIterCartellinoDM.selT860AfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selT860.FieldByName('DATA_RICHIESTA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  TDateTimeField(selT860.FieldByName('MESE_CARTELLINO')).DisplayFormat:='mm/yyyy';
end;

end.

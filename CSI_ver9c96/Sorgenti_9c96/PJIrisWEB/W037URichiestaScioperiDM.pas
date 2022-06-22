unit W037URichiestaScioperiDM;

interface

uses
  A000UInterfaccia,
  System.SysUtils, System.Classes, Data.DB, OracleData, Oracle;

type
  TW037FRichiestaScioperiDM = class(TDataModule)
    selT251: TOracleDataSet;
    selT251ID: TFloatField;
    selT251ID_REVOCA: TFloatField;
    selT251ID_REVOCATO: TFloatField;
    selT251NOMINATIVO: TStringField;
    selT251MATRICOLA: TStringField;
    selT251SESSO: TStringField;
    selT251COD_ITER: TStringField;
    selT251TIPO_RICHIESTA: TStringField;
    selT251AUTORIZZ_AUTOMATICA: TStringField;
    selT251REVOCABILE: TStringField;
    selT251DATA_RICHIESTA: TDateTimeField;
    selT251LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT251DATA_AUTORIZZAZIONE: TDateTimeField;
    selT251AUTORIZZAZIONE: TStringField;
    selT251NOMINATIVO_RESP: TStringField;
    selT251AUTORIZZ_AUTOM_PREV: TStringField;
    selT251AUTORIZZ_PREV: TStringField;
    selT251RESPONSABILE_PREV: TStringField;
    selT251AUTORIZZ_UTILE: TStringField;
    selT251AUTORIZZ_REVOCA: TStringField;
    selT251D_TIPO_RICHIESTA: TStringField;
    selT251D_RESPONSABILE: TStringField;
    selT251D_AUTORIZZAZIONE: TStringField;
    selT251ID_T250: TFloatField;
    selT251DATA: TDateTimeField;
    selT251CAUSALE: TStringField;
    selT251D_CAUSALE: TStringField;
    selT251TIPOGIUST: TStringField;
    selT251DAORE: TStringField;
    selT251AORE: TStringField;
    selT251SELEZIONE_ANAGRAFICA: TStringField;
    selT251MINIMO: TIntegerField;
    selT251PROGRESSIVO: TFloatField;
    selT252: TOracleDataSet;
    selT250: TOracleDataSet;
    selT252COGNOME: TStringField;
    selT252NOME: TStringField;
    selT252MATRICOLA: TStringField;
    selT252SCIOPERA: TStringField;
    selT252PROGRESSIVO: TFloatField;
    selT252ID: TFloatField;
    selT252CAUSALE: TStringField;
    selT252STATO: TStringField;
    selT252TIMBRATURE: TStringField;
    selT252REPERIBILITA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT251CalcFields(DataSet: TDataSet);
  private
    //
  public
    //
  end;

implementation

uses W037URichiestaScioperi;

{$R *.dfm}

procedure TW037FRichiestaScioperiDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
 except
 end;
end;

procedure TW037FRichiestaScioperiDM.DataModuleDestroy(Sender: TObject);
begin
  //
end;

procedure TW037FRichiestaScioperiDM.selT251CalcFields(DataSet: TDataSet);
var
  S, Aut, TipoRichiesta, DescTipoRichiesta, DescResp: String;
begin
  with selT251 do
  begin
    // descrizione tipo richiesta
    TipoRichiesta:=FieldByName('TIPO_RICHIESTA').AsString;
    if TipoRichiesta = W037_TR_P then
      DescTipoRichiesta:='Notifica provvisoria'
    else if TipoRichiesta = W037_TR_D then
      DescTipoRichiesta:='Notifica definitiva'
    else if TipoRichiesta = W037_TR_E then
      DescTipoRichiesta:='Notifica elaborata';
    FieldByName('D_TIPO_RICHIESTA').AsString:=DescTipoRichiesta;

    // autorizzatore
    Aut:=FieldByName('AUTORIZZ_UTILE').AsString;
    // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
    // visualizza responsabile solo se c'è un'autorizzazione utile
    if Aut = '' then
      DescResp:=''
    else
      DescResp:=FieldByName('NOMINATIVO_RESP').AsString;
    FieldByName('D_RESPONSABILE').AsString:=DescResp;

    // descr. autorizzazione
    if Aut = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;
  end;
end;

end.

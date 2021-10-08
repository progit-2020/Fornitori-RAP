unit A027UCarMenDtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDtM, Data.DB, OracleData,
  Variants, Oracle, C180FunzioniGenerali, C700USelezioneAnagrafe, A000UInterfaccia;

type
  TA027FCarMenDtM = class(TR004FGestStoricoDtM)
    selT065: TOracleDataSet;
    dsrT065: TDataSource;
    selT065ORE_DESTINATE: TStringField;
    selT065MATRICOLA: TStringField;
    selT065NOME: TStringField;
    selT065DATA: TDateTimeField;
    selT065CONTRATTO: TStringField;
    selT065PROGRESSIVO: TFloatField;
    selT065ID: TFloatField;
    USR_T065PCK_GESTSTRAORD_ESEGUILIQUIDAZIONE: TOracleQuery;
    USR_T065PCK_GESTSTRAORD_ANNULLALIQUIDAZIONE: TOracleQuery;
    USR_T065PCK_GESTSTRAORD_ANNULLADESTINAZIONE: TOracleQuery;
    selT065ORE_AUTORIZZATE: TStringField;
    selT065ORE_ECCEDENTI: TStringField;
    selT065ORE_DALIQUIDARE: TStringField;
    selT065ORE_DACOMPENSARE: TStringField;
    USR_T065PCK_GESTSTRAORD_ANNULLATAGLIOBAO: TOracleQuery;
    selT102OreNotturne: TOracleDataSet;
    dsrT102: TDataSource;
    selT102OreNotturneMATRICOLA: TStringField;
    selT102OreNotturneNOME: TStringField;
    selT102OreNotturneORE_NOTTURNE: TStringField;
    selT102OreNotturnePROGRESSIVO: TFloatField;
    USR_T065PCK_GESTSTRAORD_GESTIONEMAGGNOTT: TOracleQuery;
    selT102OreNotturneLIQUIDATO: TStringField;
    USR_T065PCK_GESTSTRAORD_ANNULLAMAGGNOTT: TOracleQuery;
    selT065STATO: TStringField;
    selT065TIPO_RICHIESTA: TStringField;
    selT065COD_ITER: TStringField;
    selT065ANOMALIA: TStringField;
    selT065C_ANOMALIA: TStringField;
    selT002: TOracleDataSet;
    dsrQryT002: TDataSource;
    selQryT002: TOracleDataSet;
    procedure selT065FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT102OreNotturneFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT065CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FFiltroDestinazione:String;
    procedure PutFiltroDestinazione(Value:String);
  public
    { Public declarations }
    procedure AnnullaDestinazione(ID:Integer);
    procedure AnnullaLiquidazione(ID:Integer);
    procedure AnnullaTaglioBancaOre(ID:Integer);
    procedure EseguiLiquidazione(ID:Integer);
    procedure GestioneMaggNott(Progressivo:Integer; Data:TDateTime);
    procedure AnnullaLiquidazioneOreNott(Progressivo:Integer; Data:TDateTime);
    procedure SettaSelQryT002(NomeQuery:String; MeseStrao:TDateTime);
    property FiltroDestinazione:String read FFiltroDestinazione write PutFiltroDestinazione;
  end;

var
  A027FCarMenDtM: TA027FCarMenDtM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA027FCarMenDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FFiltroDestinazione:='S';
end;

procedure TA027FCarMenDtM.PutFiltroDestinazione(Value:String);
begin
  FFiltroDestinazione:=Value;
  selT065.Filtered:=False;
  selT065.Filtered:=True;
end;

procedure TA027FCarMenDtM.selT065CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT065.FieldByName('C_ANOMALIA').AsString:='';
  if selT065.FieldByName('ORE_DESTINATE').AsString = 'N' then
    selT065.FieldByName('C_ANOMALIA').AsString:=selT065.FieldByName('ANOMALIA').AsString
  else if (selT065.FieldByName('ORE_DESTINATE').AsString = 'D') and (selT065.FieldByName('TIPO_RICHIESTA').AsString = 'R') then
    selT065.FieldByName('C_ANOMALIA').AsString:=selT065.FieldByName('ANOMALIA').AsString;
end;

procedure TA027FCarMenDtM.selT065FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=((FFiltroDestinazione = 'E') and R180In(DataSet.FieldByName('ORE_DESTINATE').AsString,['S','N'])) or
          (Dataset.FieldByName('ORE_DESTINATE').AsString = FFiltroDestinazione);
  if Accept then
    Accept:=C700SelAnagrafe.Lookup('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO') <> null;
end;

procedure TA027FCarMenDtM.selT102OreNotturneFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  //Accept:=C700SelAnagrafe.Lookup('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO') <> null;
end;

procedure TA027FCarMenDtM.SettaSelQryT002(NomeQuery: String; MeseStrao:TDateTime);
var lstVar:TStringList;
begin
  selQryT002.Close;
  selQryT002.SQL.Clear;
  selQryT002.DeleteVariables;
  selT002.Close;
  selT002.SetVariable('NOME',NomeQuery);
  selT002.Open;
  while not selT002.Eof do
  begin
    selQryT002.SQL.Add(selT002.FieldByName('RIGA').AsString);
    selT002.Next;
  end;
  selT002.Close;

  lstVar:=FindVariables(selQryT002.SQL.Text, False);
  if lstVar.Count > 0 then
    selQryT002.DeclareAndSet(lstVar[0],otDate,MeseStrao);
  selQryT002.Open;
end;

procedure TA027FCarMenDtM.AnnullaDestinazione(ID:Integer);
begin
  USR_T065PCK_GESTSTRAORD_ANNULLADESTINAZIONE.SetVariable('ID',ID);
  USR_T065PCK_GESTSTRAORD_ANNULLADESTINAZIONE.Execute;
  SessioneOracle.Commit;
  //selT065.Refresh;
end;

procedure TA027FCarMenDtM.AnnullaLiquidazione(ID:Integer);
begin
  USR_T065PCK_GESTSTRAORD_ANNULLALIQUIDAZIONE.SetVariable('ID',ID);
  USR_T065PCK_GESTSTRAORD_ANNULLALIQUIDAZIONE.Execute;
  SessioneOracle.Commit;
  //selT065.Refresh;
end;

procedure TA027FCarMenDtM.AnnullaTaglioBancaOre(ID:Integer);
begin
  USR_T065PCK_GESTSTRAORD_ANNULLATAGLIOBAO.SetVariable('ID',ID);
  USR_T065PCK_GESTSTRAORD_ANNULLATAGLIOBAO.Execute;
  SessioneOracle.Commit;
  //selT065.Refresh;
end;

procedure TA027FCarMenDtM.EseguiLiquidazione(ID:Integer);
begin
  USR_T065PCK_GESTSTRAORD_ESEGUILIQUIDAZIONE.SetVariable('ID',ID);
  USR_T065PCK_GESTSTRAORD_ESEGUILIQUIDAZIONE.Execute;
  SessioneOracle.Commit;
  //selT065.Refresh;
end;

procedure TA027FCarMenDtM.GestioneMaggNott(Progressivo:Integer; Data:TDateTime);
begin
  USR_T065PCK_GESTSTRAORD_GESTIONEMAGGNOTT.SetVariable('PROGRESSIVO',Progressivo);
  USR_T065PCK_GESTSTRAORD_GESTIONEMAGGNOTT.SetVariable('DATA',Data);
  USR_T065PCK_GESTSTRAORD_GESTIONEMAGGNOTT.Execute;
  SessioneOracle.Commit;
  //selT102OreNotturne.Refresh;
end;

procedure TA027FCarMenDtM.AnnullaLiquidazioneOreNott(Progressivo:Integer; Data:TDateTime);
begin
  USR_T065PCK_GESTSTRAORD_ANNULLAMAGGNOTT.SetVariable('PROGRESSIVO',Progressivo);
  USR_T065PCK_GESTSTRAORD_ANNULLAMAGGNOTT.SetVariable('DATA',Data);
  USR_T065PCK_GESTSTRAORD_ANNULLAMAGGNOTT.Execute;
  SessioneOracle.Commit;
  //selT102OreNotturne.Refresh;
end;

end.


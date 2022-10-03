unit Wc01URichiestaRendiProjDM;

interface

uses
  SysUtils, StrUtils, Classes, Math, DB, Oracle, OracleData, Variants,
  A000USessione, A000UInterfaccia, C018UIterAutDM, C180FunzioniGenerali, DatiBloccati,
  Datasnap.DBClient;

type
  TWc01FRichiestaRendiProjDM = class(TDataModule)
    selT755: TOracleDataSet;
    selT755ID: TFloatField;
    selT755ID_REVOCA: TFloatField;
    selT755ID_REVOCATO: TFloatField;
    selT755PROGRESSIVO: TIntegerField;
    selT755NOMINATIVO: TStringField;
    selT755MATRICOLA: TStringField;
    selT755SESSO: TStringField;
    selT755COD_ITER: TStringField;
    selT755TIPO_RICHIESTA: TStringField;
    selT755AUTORIZZ_AUTOMATICA: TStringField;
    selT755REVOCABILE: TStringField;
    selT755DATA_RICHIESTA: TDateTimeField;
    selT755LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT755DATA_AUTORIZZAZIONE: TDateTimeField;
    selT755AUTORIZZAZIONE: TStringField;
    selT755NOMINATIVO_RESP: TStringField;
    selT755AUTORIZZ_AUTOM_PREV: TStringField;
    selT755AUTORIZZ_PREV: TStringField;
    selT755RESPONSABILE_PREV: TStringField;
    selT755AUTORIZZ_UTILE: TStringField;
    selT755AUTORIZZ_REVOCA: TStringField;
    selT755D_TIPO_RICHIESTA: TStringField;
    selT755D_RESPONSABILE: TStringField;
    selT755D_AUTORIZZAZIONE: TStringField;
    selT755DATA: TDateTimeField;
    selT755ORE: TStringField;
    selT755CF_C_PROGETTO: TStringField;
    selT755CF_ORE_LIMITE_MESE: TStringField;
    selT755CF_ORE_AUT_MESE: TStringField;
    selT755CF_RIEP_ORE_MESE: TStringField;
    selT753: TOracleDataSet;
    selT755CF_RES_ORE_MESE: TStringField;
    cdsLista: TClientDataSet;
    cdsListaGG: TClientDataSet;
    selT755ID_T752: TFloatField;
    cdsListaPag: TClientDataSet;
    cdsT755Tab: TClientDataSet;
    dsrT755Tab: TDataSource;
    selT755CF_C_ATTIVITA: TStringField;
    selT755CF_C_TASK: TStringField;
    selaT755: TOracleDataSet;
    updT753: TOracleQuery;
    selT755CF_D_PROGETTO: TStringField;
    selT755CF_D_ATTIVITA: TStringField;
    selT755CF_D_TASK: TStringField;
    selT750: TOracleDataSet;
    selT755CF_ORE_AUTORIZ: TStringField;
    selbT755: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT755CalcFields(DataSet: TDataSet);
    procedure selT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    C018:TC018FIterAutDM;
    Dal,Al:TDateTime;
    TipoRichStr:String;
  end;

implementation

{$R *.dfm}

procedure TWc01FRichiestaRendiProjDM.DataModuleCreate(Sender: TObject);
var i:Integer;
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

procedure TWc01FRichiestaRendiProjDM.selT755CalcFields(DataSet: TDataSet);
var S:String;
begin
  // D_AUTORIZZAZIONE: descr. autorizzazione
  if selT755.FieldByName('AUTORIZZ_UTILE').AsString = '' then
    S:=''
  else if selT755.FieldByName('AUTORIZZ_UTILE').AsString = C018NO then
    S:='No'
  else
    S:='Si';
  selT755.FieldByName('D_AUTORIZZAZIONE').AsString:=S;
  selT755.FieldByName('D_RESPONSABILE').AsString:=Trim(selT755.FieldByName('NOMINATIVO_RESP').AsString);

  selT755.FieldByName('CF_C_PROGETTO').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'C_PROGETTO'));
  selT755.FieldByName('CF_D_PROGETTO').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'D_PROGETTO'));
  selT755.FieldByName('CF_C_ATTIVITA').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'C_ATTIVITA'));
  selT755.FieldByName('CF_D_ATTIVITA').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'D_ATTIVITA'));
  selT755.FieldByName('CF_C_TASK').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'C_TASK'));
  selT755.FieldByName('CF_D_TASK').AsString:=VarToStr(selT753.Lookup('ID_T752',selT755.FieldByName('ID_T752').AsInteger,'D_TASK'));

  C018.CodIter:=selT755.FieldByName('COD_ITER').AsString;
  C018.Id:=selT755.FieldByName('ID').AsInteger;
  selT755.FieldByName('CF_ORE_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE').Valore;
  if WR000DM.Responsabile or (selT755.FieldByName('AUTORIZZAZIONE').AsString = C018SI) then
    selT755.FieldByName('CF_ORE_AUTORIZ').AsString:=IfThen(selT755.FieldByName('CF_ORE_AUTORIZ').IsNull,selT755.FieldByName('ORE').AsString,selT755.FieldByName('CF_ORE_AUTORIZ').AsString);
end;

procedure TWc01FRichiestaRendiProjDM.selT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PROGETTI RENDICONTABILI',DataSet.FieldByName('ID_T750').AsString);
end;

end.

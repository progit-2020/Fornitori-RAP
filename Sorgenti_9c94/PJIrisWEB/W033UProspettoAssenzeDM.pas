unit W033UProspettoAssenzeDM;

interface

uses
  SysUtils, Classes, DB, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, DBClient, QueryStorico, USelI010;

type
  TW033FProspettoAssenzeDM = class(TDataModule)
    selT050: TOracleDataSet;
    selT100: TOracleDataSet;
    selT040: TOracleDataSet;
    cdsListaTimb: TClientDataSet;
    cdsLista: TClientDataSet;
    cdsListaPag: TClientDataSet;
    cdsListaAss: TClientDataSet;
    T010F_GGLAVORATIVO: TOracleQuery;
    selaT050: TOracleDataSet;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    DateTimeField1: TDateTimeField;
    FloatField4: TFloatField;
    DateTimeField2: TDateTimeField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    DateTimeField5: TDateTimeField;
    StringField24: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    StringField32: TStringField;
    cdsT050: TClientDataSet;
    dsrT050: TDataSource;
    T010F_GGSIGNIFICATIVO: TOracleQuery;
    D010: TDataSource;
    selSQL: TOracleDataSet;
    selT050Canc: TOracleDataSet;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    IntegerField2: TIntegerField;
    StringField33: TStringField;
    StringField34: TStringField;
    StringField35: TStringField;
    StringField36: TStringField;
    StringField37: TStringField;
    StringField38: TStringField;
    StringField39: TStringField;
    DateTimeField6: TDateTimeField;
    FloatField8: TFloatField;
    DateTimeField7: TDateTimeField;
    StringField40: TStringField;
    StringField41: TStringField;
    StringField42: TStringField;
    StringField43: TStringField;
    StringField44: TStringField;
    StringField45: TStringField;
    StringField46: TStringField;
    StringField47: TStringField;
    StringField48: TStringField;
    StringField49: TStringField;
    StringField50: TStringField;
    StringField51: TStringField;
    DateTimeField8: TDateTimeField;
    DateTimeField9: TDateTimeField;
    StringField52: TStringField;
    StringField53: TStringField;
    StringField54: TStringField;
    StringField55: TStringField;
    DateTimeField10: TDateTimeField;
    StringField56: TStringField;
    StringField57: TStringField;
    StringField58: TStringField;
    StringField59: TStringField;
    StringField60: TStringField;
    StringField61: TStringField;
    StringField62: TStringField;
    StringField63: TStringField;
    StringField64: TStringField;
    selCausali: TOracleDataSet;
    selaT050CSI_TIPO_MG: TStringField;
    selaT050D_CSI_TIPO_MG: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selaT050CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selI010:TselI010;
    QSGruppo:TQueryStorico;
  end;

implementation

{$R *.dfm}

procedure TW033FProspettoAssenzeDM.DataModuleCreate(Sender: TObject);
var i:Integer;
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
  QSGruppo:=TQueryStorico.Create(nil);
  QSGruppo.Session:=SessioneOracle;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'') AND NOME_CAMPO NOT IN (''T430PROGRESSIVO'',''T430DATADECORRENZA'',''T430DATAFINE'') AND NOME_CAMPO NOT LIKE ''P430%''','NOME_LOGICO');
  D010.DataSet:=selI010;
 except
 end;
end;

procedure TW033FProspettoAssenzeDM.DataModuleDestroy(Sender: TObject);
begin
 try
  FreeAndNil(QSGruppo);
  FreeAndNil(selI010);
 except
 end;
end;

procedure TW033FProspettoAssenzeDM.selaT050CalcFields(DataSet: TDataSet);
var
  DescCaus,TipoGius,Orario,Aut,LTipoMG,LDTipoMG: String;
begin
  with selaT050 do
  begin
    // D_CAUSALE: descrizione causale
    // D_CAUSALE_2: codice + descrizione causale
    DescCaus:=VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'DESCRIZIONE'));
    if DescCaus = '' then
      DescCaus:=VarToStr(WR000DM.selT275.Lookup('CODICE',FieldByName('CAUSALE').AsString,'DESCRIZIONE'));
    FieldByName('D_CAUSALE').AsString:=DescCaus;
    FieldByName('D_CAUSALE_2').AsString:=FieldByName('CAUSALE').AsString;
    if DescCaus <> '' then
      FieldByName('D_CAUSALE_2').AsString:=FieldByName('D_CAUSALE_2').AsString + ' - ' + DescCaus;

    // D_TIPOGIUST: descrizione tipo giustificativo
    TipoGius:=FieldByName('TIPOGIUST').AsString;
    if TipoGius = 'I' then
      FieldByName('D_TIPOGIUST').AsString:='Giornate'
    else if TipoGius = 'M' then
      FieldByName('D_TIPOGIUST').AsString:='Mezze giorn.'
    else if TipoGius = 'N' then
      FieldByName('D_TIPOGIUST').AsString:='Numero Ore'
    else if TipoGius = 'D' then
      FieldByName('D_TIPOGIUST').AsString:='Da ore/A ore';

    LTipoMG:=FieldByName('CSI_TIPO_MG').AsString;
    if LTipoMG = 'M' then
      LDTipoMG:='Mattino'
    else if LTipoMG = 'P' then
      LDTipoMG:='Pomeriggio'
    else
      LDTipoMG:=LTipoMG;
    FieldByName('D_CSI_TIPO_MG').AsString:=LDTipoMG;

    // D_DAORE_AORE: descrizione daore - a ore
    Orario:=FieldByName('NUMEROORE').AsString;
    if FieldByName('AORE').AsString <> '' then
      Orario:=Orario + ' - ' + FieldByName('AORE').AsString;
    FieldByName('D_DAORE_AORE').AsString:=Orario;

    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      Aut:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      Aut:='No'
    else
      Aut:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;
  end;
end;

end.

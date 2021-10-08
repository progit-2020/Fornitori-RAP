unit W018URichiestaTimbratureDM;

interface

uses
  SysUtils, Classes, StrUtils, DB, DBClient, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, C018UIterAutDM, C180FunzioniGenerali;

type
  TW018FRichiestaTimbratureDM = class(TDataModule)
    selT105: TOracleDataSet;
    selT105PROGRESSIVO: TIntegerField;
    selT105DATA: TDateTimeField;
    selT105ORA: TStringField;
    selT105VERSO: TStringField;
    selT105CAUSALE: TStringField;
    selT105AUTORIZZAZIONE: TStringField;
    selT105ELABORATO: TStringField;
    selT105OPERAZIONE: TStringField;
    selT105DATA_RICHIESTA: TDateTimeField;
    selT105DATA_AUTORIZZAZIONE: TDateTimeField;
    selT105CAUSALE_ORIG: TStringField;
    selT105VERSO_ORIG: TStringField;
    selT105MOTIVAZIONE: TStringField;
    selT105RILEVATORE_RICH: TStringField;
    selT105MATRICOLA: TStringField;
    selT105NOMINATIVO: TStringField;
    selT105NOMINATIVO_RESP: TStringField;
    selT105DESC_OPERAZIONE: TStringField;
    selT105D_AUTORIZZAZIONE: TStringField;
    selT105D_ELABORATO: TStringField;
    selT105AUTORIZZ_AUTOMATICA: TStringField;
    selT100ModifTimb: TOracleDataSet;
    selT100ModifTimbDATA: TDateTimeField;
    selT100ModifTimbORA: TStringField;
    selT100ModifTimbVERSO: TStringField;
    selT100ModifTimbFLAG: TStringField;
    selT100ModifTimbCAUSALE: TStringField;
    selT100ModifTimbRILEVATORE: TStringField;
    selT100ModifTimbMATRICOLA: TStringField;
    selT100ModifTimbNOMINATIVO: TStringField;
    selT100ModifTimbDESC_VERSO: TStringField;
    selT100ModifTimbDESC_CAUSALE: TStringField;
    selT100ModifTimbMOTIVAZIONE: TStringField;
    selT100ModifTimbPROGRESSIVO: TFloatField;
    dsrRiepOre: TDataSource;
    selT105RiepOre: TOracleDataSet;
    cdsRiepOre: TClientDataSet;
    cdsRiepOreDATA_CONTEGGI: TStringField;
    cdsRiepOreORE: TStringField;
    cdsRiepOreORE_CAUS: TStringField;
    cdsRiepOreORE_RICH_REC: TStringField;
    cdsRiepOreORE_RICH_PAG: TStringField;
    cdsRiepOreAUTORIZZAZIONE: TStringField;
    cdsRiepOreSALDO_ORE: TStringField;
    selT106: TOracleDataSet;
    selT105ID: TFloatField;
    selT105ID_REVOCA: TFloatField;
    selT105ID_REVOCATO: TFloatField;
    selT105SESSO: TStringField;
    selT105TIPO_RICHIESTA: TStringField;
    selT105AUTORIZZ_UTILE: TStringField;
    selT105AUTORIZZ_REVOCA: TStringField;
    selT105D_TIPO_RICHIESTA: TStringField;
    selT105COD_ITER: TStringField;
    selT105AUTORIZZ_AUTOM_PREV: TStringField;
    selT105RESPONSABILE_PREV: TStringField;
    selT105LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT105REVOCABILE: TStringField;
    selT105AUTORIZZ_PREV: TStringField;
    selT105D_RESPONSABILE: TStringField;
    selT105CAUSALE_UTILE: TStringField;
    selT105CAUSALE_UTILE_LIV: TIntegerField;
    selT100ModifTimbNOTE: TStringField;
    selT105DETTAGLIO_GG: TStringField;
    selT275Abilitate: TOracleDataSet;
    selT106Lookup: TOracleDataSet;
    selT105D_MOTIVAZIONE: TStringField;
    selT105RILEVATORE_ORIG: TStringField;
    procedure selT105CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT275AbilitateFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    C018:TC018FIterAutDM;
  end;

implementation

{$R *.dfm}

procedure TW018FRichiestaTimbratureDM.DataModuleCreate(Sender: TObject);
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

  // imposta costante QVistaOracle
  selT105.SetVariable('QVISTAORACLE',QVistaOracle);
 except
 end;
end;

procedure TW018FRichiestaTimbratureDM.selT105CalcFields(DataSet: TDataSet);
var S:String;
    C018DatoAutorizzatore:TC018DatoAutorizzatore;
begin
  with selT105 do
  begin
    FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';
    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;

    // D_ELABORATO: stato elaborazione
    if FieldByName('ELABORATO').AsString = 'S' then
      FieldByName('D_ELABORATO').AsString:='OK'
    else if FieldByName('ELABORATO').AsString = 'E' then
      FieldByName('D_ELABORATO').AsString:='Err'
    else
      FieldByName('D_ELABORATO').AsString:='';

    // DESC_OPERAZIONE: descrizione tipo operazione richiesta
    if FieldByName('OPERAZIONE').AsString = 'I' then
      FieldByName('DESC_OPERAZIONE').AsString:='INS'
    else if FieldByName('OPERAZIONE').AsString = 'M' then
      FieldByName('DESC_OPERAZIONE').AsString:='MOD'
    else if FieldByName('OPERAZIONE').AsString = 'C' then
      FieldByName('DESC_OPERAZIONE').AsString:='CAN';

    // D_RESPONSABILE: nominativo responsabile
    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);

    //CAUSALE_UTILE
    FieldByName('CAUSALE_UTILE').AsString:=FieldByName('CAUSALE').AsString;
    if C018.IterModificaValori then
    begin
      C018.Id:=FieldByName('ID').AsInteger;
      C018DatoAutorizzatore:=C018.GetDatoAutorizzatore('CAUSALE');
      if C018DatoAutorizzatore.Esiste then
      begin
        FieldByName('CAUSALE_UTILE').AsString:=C018DatoAutorizzatore.Valore;
        FieldByName('CAUSALE_UTILE_LIV').AsInteger:=C018DatoAutorizzatore.Livello;
      end;
    end;
  end;
end;

procedure TW018FRichiestaTimbratureDM.selT275AbilitateFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'T275' then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet.FieldByName('TIPO').AsString = 'T305' then
    Accept:=A000FiltroDizionario('CAUSALI GIUSTIFICAZIONE',DataSet.FieldByName('CODICE').AsString);
end;

end.

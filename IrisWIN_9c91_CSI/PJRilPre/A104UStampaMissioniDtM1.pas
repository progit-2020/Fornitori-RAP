unit A104UStampaMissioniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, OracleData, Oracle, (*Midaslib,*) Crtl, DBClient, Variants,
  QueryStorico, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TA104FStampaMissioniDtM1 = class(TR004FGestStoricoDtM)
    SelM040: TOracleDataSet;
    SelM050: TOracleDataSet;
    SelM050CODICERIMBORSOSPESE: TStringField;
    SelM050DESCRIZIONE: TStringField;
    SelM050IMPORTORIMBORSOSPESE: TFloatField;
    SelM050IMPORTOINDENNITASUPPLEMENTARE: TFloatField;
    TabellaStampa: TClientDataSet;
    SelM050FLAG_ANTICIPO: TStringField;
    Q010: TOracleDataSet;
    SelM052: TOracleDataSet;
    SelM052CODICEINDENNITAKM: TStringField;
    SelM052KMPERCORSI: TFloatField;
    SelM052IMPORTOINDENNITA: TFloatField;
    SelM052DESCRIZIONE: TStringField;
    SelM052IMPORTO: TFloatField;
    P050: TOracleDataSet;
    P050COD_ARROTONDAMENTO: TStringField;
    P050COD_VALUTA: TStringField;
    P050DECORRENZA: TDateTimeField;
    P050DESCRIZIONE: TStringField;
    P050VALORE: TFloatField;
    P050TIPO: TStringField;
    SelM040MATRICOLA: TStringField;
    SelM040COGNOME: TStringField;
    SelM040NOME: TStringField;
    SelM040PROGRESSIVO: TFloatField;
    SelM040MESESCARICO: TDateTimeField;
    SelM040MESECOMPETENZA: TDateTimeField;
    SelM040DATADA: TDateTimeField;
    SelM040ORADA: TStringField;
    SelM040PROTOCOLLO: TStringField;
    SelM040TIPOREGISTRAZIONE: TStringField;
    SelM040DATAA: TDateTimeField;
    SelM040ORAA: TStringField;
    SelM040TOTALEGG: TFloatField;
    SelM040DURATA: TStringField;
    SelM040TARIFFAINDINTERA: TFloatField;
    SelM040OREINDINTERA: TFloatField;
    SelM040IMPORTOINDINTERA: TFloatField;
    SelM040TARIFFAINDRIDOTTAH: TFloatField;
    SelM040OREINDRIDOTTAH: TFloatField;
    SelM040IMPORTOINDRIDOTTAH: TFloatField;
    SelM040TARIFFAINDRIDOTTAG: TFloatField;
    SelM040OREINDRIDOTTAG: TFloatField;
    SelM040IMPORTOINDRIDOTTAG: TFloatField;
    SelM040TARIFFAINDRIDOTTAHG: TFloatField;
    SelM040OREINDRIDOTTAHG: TFloatField;
    SelM040IMPORTOINDRIDOTTAHG: TFloatField;
    SelM040FLAG_MODIFICATO: TStringField;
    SelM040PARTENZA: TStringField;
    SelM040DESTINAZIONE: TStringField;
    SelM040ABBREVIAZIONE: TStringField;
    Q010DECORRENZA: TDateTimeField;
    Q010CODICE: TStringField;
    Q010TIPO_MISSIONE: TStringField;
    Q010DESCRIZIONE: TStringField;
    Q010OREMINIMEPERINDENNITA: TStringField;
    Q010LIMITEORERETRIBUITEINTERE: TStringField;
    Q010ARROTONDAMENTOORE: TFloatField;
    Q010PERCRETRIBSUPEROORE: TFloatField;
    Q010MAXGIORNIRETRMESE: TFloatField;
    Q010PERCRETRIBSUPEROGG: TFloatField;
    Q010ARROTTARIFFADOPORIDUZIONE: TStringField;
    Q010ARROTTOTIMPORTIDATIPAGHE: TStringField;
    Q010TIPO: TStringField;
    Q010RIDUZIONE_PASTO: TStringField;
    Q010PERCRETRIBPASTO: TFloatField;
    Q010TARIFFAINDENNITA: TFloatField;
    Q010TIPO_TARIFFA: TStringField;
    Q010CODVOCEPAGHEINTERA: TStringField;
    Q010CODVOCEPAGHESUPHH: TStringField;
    Q010CODVOCEPAGHESUPGG: TStringField;
    Q010CODVOCEPAGHESUPHHGG: TStringField;
    Q010ORERIMBORSOPASTO: TStringField;
    Q010TARIFFARIMBORSOPASTO: TFloatField;
    Q010ORERIMBORSOPASTO2: TStringField;
    Q010TARIFFARIMBORSOPASTO2: TFloatField;
    QSede: TOracleDataSet;
    SelM040COMMESSA: TStringField;
    SelM040DESCTIPOREGISTRAZIONE: TStringField;
    SelM040NOTE_RIMBORSI: TStringField;
    SelM040STATO: TStringField;
    Q010IND_DA_TAB_TARIFFE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    nPb_Arrotondamento:Real;
    sPb_Tipo:String;
    procedure CreaTabellaStampa;
    procedure LeggiParametri(Data:TDateTime;TipoRegistazione:string);
  end;

var
  A104FStampaMissioniDtM1: TA104FStampaMissioniDtM1;

implementation

{$R *.DFM}

procedure TA104FStampaMissioniDtM1.CreaTabellaStampa;
begin
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('stato',ftString,20,False);
  TabellaStampa.FieldDefs.Add('contatore', ftInteger,0,False);  
  TabellaStampa.FieldDefs.Add('progressivo', ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('matricola', ftString,8,False);
  TabellaStampa.FieldDefs.Add('cognome', ftString,30,False);
  TabellaStampa.FieldDefs.Add('nome', ftString,30,False);
  TabellaStampa.FieldDefs.Add('mesescarico', ftDate,0,False);
  TabellaStampa.FieldDefs.Add('mesecompetenza', ftDate,0,False);
  TabellaStampa.FieldDefs.Add('datada', ftDate,0,False);
  TabellaStampa.FieldDefs.Add('orada', ftString, 5, False);
  TabellaStampa.FieldDefs.Add('protocollo', ftString, 10, False);
  TabellaStampa.FieldDefs.Add('tiporegistrazione', ftString, 5,False);
  TabellaStampa.FieldDefs.Add('dataa',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('oraa', ftString, 5, False);
  TabellaStampa.FieldDefs.Add('totalegg', ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('durata', ftString, 7, False);
  TabellaStampa.FieldDefs.Add('tariffaindintera', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('oreindintera', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('abbreviazione', ftString,3,False);
  TabellaStampa.FieldDefs.Add('importoindintera', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('tariffaindridottah', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('oreindridottah', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('importoindridottah', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('tariffaindridottag', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('oreindridottag', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('importoindridottag', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('tariffaindridottahg', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('oreindridottahg', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('importoindridottahg', ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('flag_modificato', ftString, 1, False);
  TabellaStampa.FieldDefs.Add('partenza', ftString, 80, False);
  TabellaStampa.FieldDefs.Add('destinazione', ftString, 80, False);
  TabellaStampa.FieldDefs.Add('commessa', ftString, 80, False);
  TabellaStampa.FieldDefs.Add('desctiporegistrazione', ftString, 40, False);
  TabellaStampa.FieldDefs.Add('noterimborsi', ftmemo, 80, False);
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA104FStampaMissioniDtM1.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet = SelM040 then
    Accept:=A000FiltroDizionario('TIPOLOGIA TRASFERTA',DataSet.FieldByName('TIPOREGISTRAZIONE').AsString);
end;

procedure TA104FStampaMissioniDtM1.LeggiParametri(Data:TDateTime;TipoRegistazione:string);
var
  CodiceRegole:string;
  QSIndennita:TQueryStorico;
begin
  CodiceRegole:='';
  QSIndennita:=TQueryStorico.Create(nil);
  QSIndennita.Session:=SessioneOracle;
  //QSIndennita.GetDatiStorici('T430' + Parametri.CampiRiferimento.C8_Missione,Selm040PROGRESSIVO.AsInteger,Data,Data);
  QSIndennita.GetDatiStorici('T430' + Parametri.CampiRiferimento.C8_Missione,TabellaStampa.FieldByName('PROGRESSIVO').AsInteger,Data,Data);
  if QSIndennita.LocDatoStorico(Data) then
    CodiceRegole:=QSIndennita.FieldByName('T430' + Parametri.CampiRiferimento.c8_Missione).AsString;
  if (CodiceRegole <> '') and (TipoRegistazione <> '') then
  begin
    if (Q010.GetVariable('DECORRENZA') <> Data) or
       (Q010.GetVariable('TIPOREGISTRAZIONE') <> TipoRegistazione) or
       (Q010.GetVariable('CODICE') <> CodiceRegole) then
    begin
      Q010.Close;
      Q010.SetVariable('DECORRENZA',Data);
      Q010.SetVariable('TIPOREGISTRAZIONE',TipoRegistazione);
      Q010.SetVariable('CODICE',CodiceRegole);
      Q010.Open;
    end;
  end;
  if Not Q010.Active or ((Q010.Active) and (Q010.RecordCount=0)) then
    raise exception.Create('Regole non trovate per il dipendente con progressivo ' + Selm040PROGRESSIVO.AsString + '.');
  QSIndennita.Free;    
end;


procedure TA104FStampaMissioniDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //SEDE DI RIFERIMENTO - PARTENZA
  if A000LookupTabella(Parametri.CampiRiferimento.C8_Sede,QSede) then
  begin
    if QSede.VariableIndex('DECORRENZA') >= 0 then
      QSede.SetVariable('DECORRENZA',Parametri.DataLavoro);
    QSede.Close;
    QSede.Open;
  end;
end;

end.

unit A123UPartecipazioniSindacatiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, C180FunzioniGenerali;

type
  TA123LoadList = procedure(Lista:TStringList) of Object;

  TA123FPartecipazioniSindacatiMW = class(TR005FDataModuleMW)
    ControlloIscrizioni: TOracleQuery;
    selT245: TOracleDataSet;
    selT240: TOracleDataSet;
    selT240A: TOracleDataSet;
    selT245A: TOracleDataSet;
    selT247A: TOracleDataSet;
    selT247ACOD_ORGANISMO: TStringField;
    selT247ADESC_ORGANISMO: TStringField;
    selT247ACOD_SINDACATO: TStringField;
    selT247ADESC_SINDACATO: TStringField;
    selT247ADADATA: TDateTimeField;
    selT247AADATA: TDateTimeField;
    selT247AMATRICOLA: TStringField;
    selT247ANOMINATIVO: TStringField;
    dsrT247A: TDataSource;
    dsrT240A: TDataSource;
    dsrT245A: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    selT247: TOracleDataSet;
    CaricaListeGriglia: TA123LoadList;
    procedure CaricaSindacati;
    procedure SelT247OnNewRecord;
    procedure SelT247BeforeInsert;
    procedure selT247BeforePostStep1;
    procedure selT247BeforePostStep2;
    procedure SelT247CalcFields;
    procedure SelT247ADATAValidate;
    procedure SelT247COD_ORGANISMOChange(Sender: TField);
    procedure SelT247COD_SINDACATOChange(Sender: TField);
  end;

implementation

{$R *.dfm}

procedure TA123FPartecipazioniSindacatiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT245.Open;
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247OnNewRecord;
begin
  selT247.FieldByName('Progressivo').AsInteger:=ProgressivoC700;
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247BeforeInsert;
begin
  if ProgressivoC700 <= 0 then
    raise exception.create('Nessun dipendente selezionato!');
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247CalcFields;
begin
  //Impostazione campo DESCRIZIONE sindacato e DESCRIZIONE organismo
  selT240.Close;
  selT240.SetVariable('PROGRESSIVO',ProgressivoC700);
  selT240.SetVariable('DADATA',selT247.FieldByName('DADATA').AsDateTime);
  if Trim(selT247.FieldByName('ADATA').AsString) = '' then
    selT240.SetVariable('ADATA',StrToDateTime('31/12/3999'))
  else
    selT240.SetVariable('ADATA',selT247.FieldByName('ADATA').AsDateTime);
  selT240.Open;
  if selT240.SearchRecord('CODICE',selT247.FieldByName('COD_SINDACATO').AsString,[srFromBeginning]) then
    selT247.FieldByName('DESC_SINDACATO').AsString:=selT240.FieldByName('DESCRIZIONE').AsString;
  if selT245.SearchRecord('CODICE',selT247.FieldByName('COD_ORGANISMO').AsString,[srFromBeginning]) then
    selT247.FieldByName('DESC_ORGANISMO').AsString:=selT245.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247ADATAValidate;
begin
  if (Trim(selT247.FieldByName('ADATA').AsString) <> '') and
    (selT247.FieldByName('ADATA').AsDateTime < selT247.FieldByName('DADATA').AsDateTime) then
    raise exception.Create('La data di termine iscrizione deve essere maggiore della data di inizio iscrizione!');
  CaricaSindacati;
end;

procedure TA123FPartecipazioniSindacatiMW.CaricaSindacati;
var ListaSindacati:TStringList;
begin
  // Carico lista sindacati da proporre nel picklist della rispettiva colonna
  ListaSindacati:=TStringList.Create;
  ListaSindacati.Clear;
  //Impostazione campo DESCRIZIONE sindacato e DESCRIZIONE organismo
  selT240.Close;
  selT240.SetVariable('PROGRESSIVO',ProgressivoC700);
  selT240.SetVariable('DADATA',selT247.FieldByName('DADATA').AsDateTime);
  if Trim(selT247.FieldByName('ADATA').AsString) = '' then
    selT240.SetVariable('ADATA',StrToDateTime('31/12/3999'))
  else
    selT240.SetVariable('ADATA',selT247.FieldByName('ADATA').AsDateTime);
  selT240.Open;
  while not selT240.Eof do
  begin
    ListaSindacati.Add(Format('%-10s %s',[selT240.FieldByName('CODICE').AsString,selT240.FieldByName('DESCRIZIONE').AsString]));
    selT240.Next;
  end;
  if Assigned(CaricaListeGriglia) then
    CaricaListeGriglia(ListaSindacati);
  FreeAndNil(ListaSindacati);
end;

procedure TA123FPartecipazioniSindacatiMW.selT247BeforePostStep1;
begin
  inherited;
  selT247.FieldByName('COD_SINDACATO').AsString:=Trim(selT247.FieldByName('COD_SINDACATO').AsString);
  selT247.FieldByName('COD_ORGANISMO').AsString:=Trim(selT247.FieldByName('COD_ORGANISMO').AsString);
  //Controllo sulle date
  if (Trim(selT247.FieldByName('ADATA').AsString) <> '') and
    (selT247.FieldByName('ADATA').AsDateTime < selT247.FieldByName('DADATA').AsDateTime) then
    raise exception.Create('La data di termine iscrizione deve essere maggiore della data di inizio iscrizione!');
end;

procedure TA123FPartecipazioniSindacatiMW.selT247BeforePostStep2;
begin
  //Controllo intersezioni periodi
  //ControlloIscrizioni: num.record nello stesso periodo con stesso organismo sullo stesso sindacato
  //                                              oppure con sindacato diverso e diverso da RSU
  ControlloIscrizioni.SetVariable('PROGRESSIVO',ProgressivoC700);
  ControlloIscrizioni.SetVariable('COD_SINDACATO',selT247.FieldByName('COD_SINDACATO').AsString);
  ControlloIscrizioni.SetVariable('COD_ORGANISMO',selT247.FieldByName('COD_ORGANISMO').AsString);
  ControlloIscrizioni.SetVariable('DADATA',selT247.FieldByName('DADATA').AsDateTime);
  if Trim(selT247.FieldByName('ADATA').AsString) <> '' then
    ControlloIscrizioni.SetVariable('ADATA',selT247.FieldByName('ADATA').AsDateTime)
  else
    ControlloIscrizioni.SetVariable('ADATA',StrToDate('31/12/3999'));
  if selT247.RowId <> '' then
    ControlloIscrizioni.SetVariable('NUMRIGA','AND ROWID <> ''' + selT247.RowId + '''');
  ControlloIscrizioni.Execute;
  if ControlloIscrizioni.Field(0) > 0 then
    raise exception.Create('Esiste già una partecipazione valida nello stesso periodo!');
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247COD_SINDACATOChange(Sender: TField);
begin
  inherited;
  selT247.FieldByName('COD_SINDACATO').OnChange:=nil;
  selT247.FieldByName('COD_SINDACATO').AsString:=Trim(Copy(selT247.FieldByName('COD_SINDACATO').AsString,1,10));
  selT247.FieldByName('COD_SINDACATO').OnChange:=selT247COD_SINDACATOChange;
end;

procedure TA123FPartecipazioniSindacatiMW.SelT247COD_ORGANISMOChange(Sender: TField);
begin
  inherited;
  selT247.FieldByName('COD_ORGANISMO').OnChange:=nil;
  selT247.FieldByName('COD_ORGANISMO').AsString:=Trim(Copy(selT247.FieldByName('COD_ORGANISMO').AsString,1,5));
  selT247.FieldByName('COD_ORGANISMO').OnChange:=selT247COD_ORGANISMOChange;
end;

end.

unit A122UIscrizioniSindacaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, A000UInterfaccia;

type
  TA122StrList = procedure (lista :TStringList) of object;

  TA122FIscrizioniSindacaliMW = class(TR005FDataModuleMW)
    CalcolaData: TOracleQuery;
    ControlloIscrizioni: TOracleQuery;
    ControlloFiltro: TOracleQuery;
    selT240: TOracleDataSet;
  private
    { Private declarations }
  public
    selT246: TOracleDataSet;
    AssegnaSindacati: TA122StrList;
    procedure CaricaSindacati;
    procedure ControlloData(ID: Integer);
    procedure selT246CalcFields;
    procedure SelT246BeforePostStep1;
    procedure SelT246BeforePostStep2;
    procedure selT246DATA_CESSValidate;
    procedure selT246DATA_DEC_ISCRValidate;
    procedure selT246DATA_DEC_CESValidate;
    procedure selT246DATA_ISCRValidate;
    procedure selT246BeforeInsert;
    procedure selT246COD_SINDACATOChange(Sender: TField);
    procedure SelT246OnNewRecord;
  end;


implementation

{$R *.dfm}

procedure TA122FIscrizioniSindacaliMW.SelT246BeforePostStep1;
begin
  selT246.FieldByName('COD_SINDACATO').AsString:=Trim(selT246.FieldByName('COD_SINDACATO').AsString);
  // Controllo sulle date
  ControlloData(2);
  ControlloData(3);
  ControlloData(4);
end;

procedure TA122FIscrizioniSindacaliMW.SelT246BeforePostStep2;
begin
  //Controllo intersezioni periodi a livello di stesso sindacato
  ControlloIscrizioni.SetVariable('PROGRESSIVO',selT246.FieldByName('PROGRESSIVO').AsInteger);
  ControlloIscrizioni.SetVariable('COD_SINDACATO',selT246.FieldByName('COD_SINDACATO').AsString);
  ControlloIscrizioni.SetVariable('DECORRENZA',selT246.FieldByName('DATA_DEC_ISCR').AsDateTime);
  if Trim(selT246.FieldByName('DATA_DEC_CES').AsString) <> '' then
    ControlloIscrizioni.SetVariable('SCADENZA',selT246.FieldByName('DATA_DEC_CES').AsDateTime)
  else
    ControlloIscrizioni.SetVariable('SCADENZA',StrToDate('31/12/3999'));
  if selT246.State = dsEdit then
  ControlloIscrizioni.SetVariable('NUMRIGA','AND ROWID <> ''' + selT246.RowId + '''');
  ControlloIscrizioni.Execute;
  if ControlloIscrizioni.Field(0) > 0 then
    raise exception.Create('Per questo sindacato esiste già un''iscrizione valida nello stesso periodo!');
end;

procedure TA122FIscrizioniSindacaliMW.CaricaSindacati;
var ListaSindacati:TStringList;
begin
  // Carico lista sindacati da proporre nel picklist della rispettiva colonna
  ListaSindacati:=TStringList.Create;
  ListaSindacati.Clear;
  //selT240: elenco sindacati considerando le ultime decorrenze valide antecedenti
  //  la data di comunicazione iscrizione
  selT240.Close;
  (*Massimo 30/12/2013
  if selT246.FieldByName('DATA_DEC_ISCR').AsDateTime = 0 then
     selT240.SetVariable('DECORRENZA',Parametri.DataLavoro)
  else
  *)
  selT240.SetVariable('DECORRENZA',selT246.FieldByName('DATA_DEC_ISCR').AsDateTime);
  if Trim(selT246.FieldByName('DATA_DEC_CES').AsString) = '' then
  begin
    selT240.SetVariable('FINE',StrToDateTime('31/12/3999'));
    selT240.SetVariable('FLAG_FINE','N');
  end
  else
  begin
    selT240.SetVariable('FINE',selT246.FieldByName('DATA_DEC_CES').AsDateTime);
    selT240.SetVariable('FLAG_FINE','S');
  end;
  selT240.Open;
  selT240.First;
  while not selT240.Eof do
  begin
    //ControlloFiltro: verifica se il progressivo del dip. corrente è compreso nel filtro del sindacato
    if Trim(selT240.FieldByName('FILTRO').AsString) <> '' then
      ControlloFiltro.SetVariable('FILTRO',' AND (' + selT240.FieldByName('FILTRO').AsString + ')')
    else
      ControlloFiltro.SetVariable('FILTRO','');
    ControlloFiltro.SetVariable('PROGRESSIVO',ProgressivoC700);
    ControlloFiltro.Execute;
    if ControlloFiltro.Field(0) > 0 then
      ListaSindacati.Add(selT240.FieldByName('CODICE').AsString);
    selT240.Next;
  end;
  AssegnaSindacati(ListaSindacati);
  FreeAndNil(ListaSindacati);
end;

procedure TA122FIscrizioniSindacaliMW.ControlloData(ID:Integer);
begin
  case ID of
    2: if selT246.FieldByName('DATA_DEC_ISCR').AsDateTime < selT246.FieldByName('DATA_ISCR').AsDateTime then
         raise exception.Create('La data Decorrenza Iscrizione deve essere maggiore alla data Comunicazione!');
    3: if Trim(selT246.FieldByName('DATA_CESS').AsString) <> '' then
       begin
         if (selT246.FieldByName('DATA_CESS').AsDateTime < selT246.FieldByName('DATA_ISCR').AsDateTime) or
            (selT246.FieldByName('DATA_CESS').AsDateTime < selT246.FieldByName('DATA_DEC_ISCR').AsDateTime) then
           raise exception.Create('La data Comunicazione Cessazione deve essere maggiore della data Iscrizione!');
       end;
    4: if Trim(selT246.FieldByName('DATA_DEC_CES').AsString) <> '' then
       begin
         if (selT246.FieldByName('DATA_DEC_CES').AsDateTime < selT246.FieldByName('DATA_ISCR').AsDateTime) or
            (selT246.FieldByName('DATA_DEC_CES').AsDateTime < selT246.FieldByName('DATA_DEC_ISCR').AsDateTime) then
           raise exception.Create('La data Decorrenza Cessazione deve essere maggiore della data Iscrizione!');
         if (selT246.FieldByName('DATA_DEC_CES').AsDateTime < selT246.FieldByName('DATA_CESS').AsDateTime) then
           raise exception.Create('La Data Decorrenza di cessazione deve essere maggiore alla data Comunicazione!');
       end;
  end;
end;

procedure TA122FIscrizioniSindacaliMW.selT246CalcFields;
begin
  //Impostazione campo DESCRIZIONE sindacato
  selT240.Close;
  selT240.SetVariable('DECORRENZA',selT246.FieldByName('DATA_ISCR').AsDateTime);
  if Trim(selT246.FieldByName('DATA_DEC_CES').AsString) = '' then
  begin
    selT240.SetVariable('FINE',StrToDateTime('31/12/3999'));
    selT240.SetVariable('FLAG_FINE','N');
  end
  else
  begin
    selT240.SetVariable('FINE',selT246.FieldByName('DATA_DEC_CES').AsDateTime);
    selT240.SetVariable('FLAG_FINE','S');
  end;
  selT240.Open;
  if selT240.SearchRecord('CODICE',selT246.FieldByName('COD_SINDACATO').AsString,[srFromBeginning]) then
    selT246.FieldByName('DESC_SINDACATO').AsString:=selT240.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA122FIscrizioniSindacaliMW.selT246DATA_CESSValidate;
begin
  if Trim(selT246.FieldByName('DATA_CESS').AsString) <> '' then
  begin
    ControlloData(3);
    //Calcolo Data decorrenza cessazione = data cessazione + 1 mese
    if Trim(selT246.FieldByName('DATA_DEC_CES').AsString) = '' then
    begin
      CalcolaData.SetVariable('DATA',selT246.FieldByName('DATA_CESS').AsDateTime);
      CalcolaData.Execute;
      selT246.FieldByName('DATA_DEC_CES').AsDateTime:=CalcolaData.Field(0)-1;
    end;
  end;
end;

procedure TA122FIscrizioniSindacaliMW.selT246DATA_DEC_ISCRValidate;
begin
  if (Trim(selT246.FieldByName('DATA_ISCR').AsString) <> '') and
     (Trim(selT246.FieldByName('DATA_DEC_ISCR').AsString) = '') then
    raise exception.Create('La data Decorrenza Iscrizione deve essere valorizzata!');
  ControlloData(2);
  CaricaSindacati;
end;

procedure TA122FIscrizioniSindacaliMW.selT246DATA_DEC_CESValidate;
begin
  if (Trim(selT246.FieldByName('DATA_CESS').AsString) <> '') and
     (Trim(selT246.FieldByName('DATA_DEC_CES').AsString) = '') then
    raise exception.Create('La data Decorrenza Cessazione deve essere valorizzata!');
  ControlloData(4);
  CaricaSindacati;
end;

procedure TA122FIscrizioniSindacaliMW.selT246BeforeInsert;
begin
  if ProgressivoC700 <= 0 then
    raise exception.create('Nessun dipendente selezionato!');
end;

procedure TA122FIscrizioniSindacaliMW.selT246COD_SINDACATOChange(Sender: TField);
begin
  inherited;
  selT246.FieldByName('COD_SINDACATO').OnChange:=nil;
  selT246.FieldByName('COD_SINDACATO').AsString:=Trim(Copy(selT246.FieldByName('COD_SINDACATO').AsString,1,10));
  selT246.FieldByName('COD_SINDACATO').OnChange:=selT246COD_SINDACATOChange;
end;

procedure TA122FIscrizioniSindacaliMW.SelT246OnNewRecord;
begin
  selT246.FieldByName('Progressivo').AsInteger:=ProgressivoC700;
end;

procedure TA122FIscrizioniSindacaliMW.selT246DATA_ISCRValidate;
begin
  // Calcolo Data decorrenza iscrizione = data iscrizione + 1 mese
  if Trim(selT246.FieldByName('DATA_DEC_ISCR').AsString) = '' then
  begin
    CalcolaData.SetVariable('DATA',selT246.FieldByName('DATA_ISCR').AsDateTime);
    CalcolaData.Execute;
    selT246.FieldByName('DATA_DEC_ISCR').AsDateTime:=CalcolaData.Field(0);
  end;
end;


end.

unit A172USchedeQuantIndividualiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, Datasnap.DBClient,
  OracleData, C180FUnzioniGenerali, Variants, A000UInterfaccia, A000USessione, A000UMessaggi,
  Oracle, Generics.Collections, A000UCostanti;

type
  TTotali = record
    MaxImp,TotaleAccett,TotaleAssegn:Real;
    MaxOre,TotaleOreAccett,TotaleOreAssegn:Integer;
  end;

  TEvDataset = procedure (DataSet: TDataSet) of object;

  TA172FSchedeQuantIndividualiMW = class(TR005FDataModuleMW)
    cdsT768: TClientDataSet;
    selT762: TOracleDataSet;
    selT762Pag: TOracleDataSet;
    selT765: TOracleDataSet;
    selSG706: TOracleDataSet;
    selT768: TOracleDataSet;
    selT768ANNO: TFloatField;
    selT768CODGRUPPO: TStringField;
    selT768CODTIPOQUOTA: TStringField;
    selT768PROGRESSIVO: TIntegerField;
    selT768MATRICOLA: TStringField;
    selT768COGNOME: TStringField;
    selT768NOME: TStringField;
    selT768PARTTIME: TFloatField;
    selT768FLESSIBILITA: TStringField;
    selT768IMPORTO_ORARIO: TFloatField;
    selT768NUMORE_ASSEGNATE: TStringField;
    selT768TOTALE_ASSEGNATO: TFloatField;
    selT768NUMORE_ACCETTATE: TStringField;
    selT768TOTALE_ACCETTATO: TFloatField;
    selT768CONFERMATO: TStringField;
    selT768NOTE: TStringField;
    selT768DATO1: TStringField;
    selT768DATO2: TStringField;
    selT768DATO3: TStringField;
    selT768INF_OBIETTIVI: TStringField;
    selT768ACCETT_VALUTAZIONE: TStringField;
    selT768NUMORE_EXTRA: TStringField;
    selT768NUMORE_TOTALI: TStringField;
    selDato1: TOracleDataSet;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    dsrT768: TDataSource;
    selValutatori: TOracleDataSet;
    dsrValutatori: TDataSource;
    selV430: TOracleDataSet;
    selT770: TOracleDataSet;
    ControlloT768: TOracleDataSet;
    ControlloT040: TOracleDataSet;
    selSG735: TOracleDataSet;
    updT767: TOracleQuery;
    delT768: TOracleQuery;
    CambioValutatore: TOracleQuery;
    selSG715: TOracleDataSet;
    procedure cdsT768BeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG715BeforePost(DataSet: TDataSet);
    procedure selSG715NewRecord(DataSet: TDataSet);
  private
    cdsT768Initialized: Boolean;
    FSelT767_Funzioni: TOracleDataset;
    procedure Prepara;
  public
    ImpostazioniCampiCdsT768: TProc;
    procedure ImpostaSelSG715(Anno, Progressivo: Integer);
    function getTipoStampaQuant(Dato1, Dato2, Dato3: String): String;
    function getLstFlessibilita: TElencoValoriChecklist;
    procedure CaricaCdsT768;
    procedure selT767NewRecord;
    function selT767FilterRecord: Boolean;
    procedure selT767BeforePost(var InsT768, AggT768: Boolean);
    function DescrizioneStato: String;
    procedure SettaDatasetValutatori;
    function CalcolaTotali: TTotali;
    procedure cdsT768Post(Totali: TTotali);
    procedure selT767AfterPost;
    procedure selT767AfterPostInsT768Inizio(var Tot: Real; var TotOre: Integer);
    procedure selT767AfterPostInsT768ElaboraElemento(var Tot: Real; var TotOre: Integer);
    procedure selT767AfterPostInsT768Fine(var Tot: Real; var TotOre: Integer);
    procedure selT767BeforeDelete;
    property SelT767_Funzioni: TOracleDataset read FSelT767_Funzioni write FSelT767_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA172FSchedeQuantIndividualiMW.DataModuleCreate(Sender: TObject);
begin
  cdsT768Initialized:=False;
  dsrT768.DataSet:=cdsT768;
  dsrValutatori.DataSet:=selValutatori;
  inherited;
  selT765.SetVariable('DEC',StrToDate('01/01/1900'));
  selT765.Open;

  if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato1,selDato1) then
  begin
    if selDato1.VariableIndex('DECORRENZA') >= 0 then
      selDato1.SetVariable('DECORRENZA',Parametri.DataLavoro);
    selDato1.Close;
    selDato1.Open;
  end;
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato2,selDato2) then
    begin
      if selDato2.VariableIndex('DECORRENZA') >= 0 then
        selDato2.SetVariable('DECORRENZA',Parametri.DataLavoro);
      selDato2.Close;
      selDato2.Open;
    end;
  end;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato3,selDato3) then
    begin
      if selDato3.VariableIndex('DECORRENZA') >= 0 then
        selDato3.SetVariable('DECORRENZA',Parametri.DataLavoro);
      selDato3.Close;
      selDato3.Open;
    end;
  end;
end;

function TA172FSchedeQuantIndividualiMW.CalcolaTotali: TTotali;
begin
  Result.TotaleOreAssegn:=0;
  Result.TotaleAssegn:=0;
  Result.TotaleOreAccett:=0;
  Result.TotaleAccett:=0;
  Result.MaxOre:=0;
  Result.MaxImp:=0;
  cdsT768.DisableControls;
  cdsT768.First;
  while not cdsT768.Eof do
  begin
    Result.TotaleOreAssegn:=Result.TotaleOreAssegn + R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString);
    Result.TotaleAssegn:=Result.TotaleAssegn + cdsT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
    Result.TotaleOreAccett:=Result.TotaleOreAccett + R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString);
    Result.TotaleAccett:=Result.TotaleAccett + cdsT768.FieldByName('TOTALE_ACCETTATO').AsFloat;
    cdsT768.Next;
  end;
  cdsT768.First;
  Result.MaxOre:=Result.TotaleOreAssegn + Trunc(Result.TotaleOreAssegn * FSelT767_Funzioni.FieldByName('TOLLERANZA').AsFloat / 100);
  Result.MaxImp:=Result.TotaleAssegn + R180Arrotonda(Result.TotaleAssegn * FSelT767_Funzioni.FieldByName('TOLLERANZA').AsFloat / 100,0.01,'P');
  cdsT768.EnableControls;
end;

procedure TA172FSchedeQuantIndividualiMW.SettaDatasetValutatori;
begin
  selValutatori.Close;
  R180SetVariable(selValutatori,'AZIENDA',Parametri.Azienda);
  if FSelT767_Funzioni.FieldByName('ANNO').IsNull then
    R180SetVariable(selValutatori,'DATA',DATE_NULL)
  else
    R180SetVariable(selValutatori,'DATA',EncodeDate(FSelT767_Funzioni.FieldByName('ANNO').AsInteger,12,31));

  selValutatori.Open;
end;

function TA172FSchedeQuantIndividualiMW.DescrizioneStato: String;
begin
  if FSelT767_Funzioni.FieldByName('STATO').AsString = 'A' then
    Result:=A000MSG_A172_MSG_GRUPPO_APERTO
  else if FSelT767_Funzioni.FieldByName('STATO').AsString = 'M' then
    Result:=A000MSG_A172_MSG_GRUPPO_MODIFICA
  else if FSelT767_Funzioni.FieldByName('STATO').AsString = 'C' then
    Result:=A000MSG_A172_MSG_GRUPPO_CHIUSO;
end;

procedure TA172FSchedeQuantIndividualiMW.cdsT768BeforePost(DataSet: TDataSet);
var Minuti:Byte;
begin
  inherited;
  //Controllo campi ora
  if (not cdsT768.FieldByName('NUMORE_ASSEGNATE').IsNull) and (Trim(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString) <> '') and
     (Trim(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString) <> '.') then
  begin
    if Pos(' ',Trim(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString)) > 1 then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_ASSEGNATE);
    if Copy(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString,5,2) = '' then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_ASSEGNATE);
    Minuti:=StrToInt(Copy(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString,5,2));
    if Minuti > 59 then
      raise Exception.Create(A000MSG_A172_ERR_MINUTI_ORE_ASSEGNATE);
  end;
  if (not cdsT768.FieldByName('NUMORE_ACCETTATE').IsNull) and (Trim(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) <> '') and
     (Trim(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) <> '.') then
  begin
    if Pos(' ',Trim(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString)) > 1 then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_ACCETTATE);
    if Copy(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString,5,2) = '' then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_ACCETTATE);
    Minuti:=StrToInt(Copy(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString,5,2));
    if Minuti > 59 then
      raise Exception.Create(A000MSG_A172_ERR_MINUTI_ORE_ACCETTATE);
  end;
  if (not cdsT768.FieldByName('NUMORE_EXTRA').IsNull) and (Trim(cdsT768.FieldByName('NUMORE_EXTRA').AsString) <> '') and
     (Trim(cdsT768.FieldByName('NUMORE_EXTRA').AsString) <> '.') then
  begin
    if Pos(' ',Trim(cdsT768.FieldByName('NUMORE_EXTRA').AsString)) > 1 then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_EXTRA);
    if Copy(cdsT768.FieldByName('NUMORE_EXTRA').AsString,5,2) = '' then
      raise Exception.Create(A000MSG_A172_ERR_NUM_ORE_EXTRA);
    Minuti:=StrToInt(Copy(cdsT768.FieldByName('NUMORE_EXTRA').AsString,5,2));
    if Minuti > 59 then
      raise Exception.Create(A000MSG_A172_ERR_MINUTI_ORE_EXTRA);
  end;

  if selT768.SearchRecord('PROGRESSIVO',cdsT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
  begin
    if (cdsT768.FieldByName('CONFERMATO').AsString = selT768.FieldByName('CONFERMATO').AsString) and
       (selT768.FieldByName('CONFERMATO').AsString = 'S') and
      ((selT768.FieldByName('FLESSIBILITA').AsString <> cdsT768.FieldByName('FLESSIBILITA').AsString) or
        (selT768.FieldByName('NOTE').AsString <> cdsT768.FieldByName('NOTE').AsString) or
        (selT768.FieldByName('NUMORE_ASSEGNATE').AsString <> cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString) or
        (selT768.FieldByName('NUMORE_ACCETTATE').AsString <> cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) or
        (selT768.FieldByName('INF_OBIETTIVI').AsString <> cdsT768.FieldByName('INF_OBIETTIVI').AsString) or
        (selT768.FieldByName('ACCETT_VALUTAZIONE').AsString <> cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString) or
        (VarToStr(selSG706.Lookup('PROGRESSIVO_VALUTATO',cdsT768.FieldByName('PROGRESSIVO').AsInteger,'VALUTATORE')) <> cdsT768.FieldByName('VALUTATORE').AsString)) then
      raise Exception.Create(A000MSG_A172_ERR_GIA_FIRMATO);
    if (cdsT768.FieldByName('CONFERMATO').AsString = 'S') and
       (cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString = 'S') and
       (cdsT768.FieldByName('VALUTATORE').AsString = '') then
      raise Exception.Create(A000MSG_A172_ERR_NO_VALUTATORE);
    if (cdsT768.FieldByName('CONFERMATO').AsString = 'S') and (cdsT768.FieldByName('PARTTIME').AsString <> '100') and
       (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) > 0) and
       (R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) <= 0) then
      raise Exception.Create(A000MSG_A172_ERR_ORE_ACCETTATE_PROG_QUANT);
    if (cdsT768.FieldByName('CONFERMATO').AsString = 'S') and (cdsT768.FieldByName('PARTTIME').AsString <> '100') and
       (Pos('2',cdsT768.FieldByName('FLESSIBILITA').AsString) <= 0) and
       (R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString) > 0) then
      raise Exception.Create(A000MSG_A172_ERR_PROG_QUANT_ORE_ACCETTATE);
    if selT768.FieldByName('NUMORE_ASSEGNATE').AsString <> cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString then
      cdsT768.FieldByName('NUMORE_ACCETTATE').AsString:=cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString;
    cdsT768.FieldByName('TOTALE_ASSEGNATO').AsFloat:=R180Arrotonda(cdsT768.FieldByName('IMPORTO_ORARIO').AsFloat *
      StrToFloatDef(StringReplace(R180Centesimi(R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString)),'.',',',[rfReplaceAll]),0),0.01,'P');
    cdsT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=R180Arrotonda(cdsT768.FieldByName('IMPORTO_ORARIO').AsFloat *
      StrToFloatDef(StringReplace(R180Centesimi(R180OreMinutiExt(cdsT768.FieldByName('NUMORE_ACCETTATE').AsString)),'.',',',[rfReplaceAll]),0),0.01,'P');
  end;
end;

procedure TA172FSchedeQuantIndividualiMW.Prepara;
begin
  //Pulizia clientDataset
  if not cdsT768Initialized then
  begin
    cdsT768Initialized:=True;
    cdsT768.Close;
    cdsT768.FieldDefs.Clear;
    cdsT768.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsT768.FieldDefs.Add('OBIETTIVI_POSIZ',ftString,1,False);
    cdsT768.FieldDefs.Add('MATRICOLA',ftString,8,False);
    cdsT768.FieldDefs.Add('COGNOME',ftString,30,False);
    cdsT768.FieldDefs.Add('NOME',ftString,30,False);
    cdsT768.FieldDefs.Add('TOTQUOTAQUAL',ftFloat,0,False);
    cdsT768.FieldDefs.Add('PARTTIME',ftFloat,0,False);
    cdsT768.FieldDefs.Add('FLESSIBILITA',ftString,100,False);
    cdsT768.FieldDefs.Add('NOTE',ftString,1000,False);
    cdsT768.FieldDefs.Add('NUMORE_ASSEGNATE',ftString,6,False);
    cdsT768.FieldDefs.Add('NUMORE_ACCETTATE',ftString,6,False);
    cdsT768.FieldDefs.Add('IMPORTO_ORARIO',ftFloat,0,False);
    cdsT768.FieldDefs.Add('TOTALE_ASSEGNATO',ftFloat,0,False);
    cdsT768.FieldDefs.Add('TOTALE_ACCETTATO',ftFloat,0,False);
    cdsT768.FieldDefs.Add('INF_OBIETTIVI',ftString,1,False);
    cdsT768.FieldDefs.Add('ACCETT_VALUTAZIONE',ftString,1,False);
    cdsT768.FieldDefs.Add('VALUTATORE',ftString,100,False);
    cdsT768.FieldDefs.Add('CONFERMATO',ftString,1,False);
    cdsT768.FieldDefs.Add('DATO1',ftString,500,False);
    cdsT768.FieldDefs.Add('DATO2',ftString,500,False);
    cdsT768.FieldDefs.Add('DATO3',ftString,500,False);
    cdsT768.FieldDefs.Add('NUMORE_EXTRA',ftString,6,False);
    cdsT768.FieldDefs.Add('NUMORE_TOTALI',ftString,6,False);
    cdsT768.FieldDefs.Add('NUMORE_PAGATE',ftString,6,False);
    cdsT768.IndexDefs.Clear;
    cdsT768.IndexDefs.Add('Indice',('DATO1;DATO2;DATO3;COGNOME;NOME;MATRICOLA'),[]);
    cdsT768.IndexName:='Indice';
    cdsT768.CreateDataSet;
    cdsT768.LogChanges:=False;
    cdsT768.FieldByName('NUMORE_ASSEGNATE').EditMask:='!990:00;1;_';
    cdsT768.FieldByName('NUMORE_ACCETTATE').EditMask:='!990:00;1;_';
    cdsT768.FieldByName('NUMORE_EXTRA').EditMask:='!990:00;1;_';

    if Assigned(ImpostazioniCampiCdsT768)then
      ImpostazioniCampiCdsT768;
  end
  else
  begin
    cdsT768.EmptyDataSet;
  end;
end;

procedure TA172FSchedeQuantIndividualiMW.CaricaCdsT768;
var
  SaveReadOnly: Boolean;
begin
  Prepara;  //Pulizia clientDataset
  if FSelT767_Funzioni.RecordCount > 0 then
  begin
    selT762.Close;
    selT762.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
    selT762.SetVariable('MESE',R180Mese(FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime));
    selT762.SetVariable('ACCONTI','''' + StringReplace(VarToStr(selT765.Lookup('CODICE',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString,'ACCONTI')),',',''',''',[rfReplaceAll]) + '''');
    selT762.Open;
    selT762Pag.Close;
    selT762Pag.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
    selT762Pag.SetVariable('CODQUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
    selT762Pag.Open;
    selSG706.Close;
    selSG706.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
    selSG706.Open;
    cdsT768.DisableControls;
    SaveReadOnly:=cdsT768.ReadOnly;
    cdsT768.ReadOnly:=False;
    cdsT768.BeforePost:=nil;
    selT768.Close;
    selT768.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
    selT768.SetVariable('CODICE',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
    selT768.SetVariable('CODQUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
    selT768.Open;
    selT768.First;
    while not selT768.Eof do
    begin
      //Caricamento clientDataset
      cdsT768.Insert;
      cdsT768.FieldByName('PROGRESSIVO').AsInteger:=selT768.FieldByName('PROGRESSIVO').AsInteger;
      cdsT768.FieldByName('COGNOME').AsString:=selT768.FieldByName('COGNOME').AsString;
      cdsT768.FieldByName('NOME').AsString:=selT768.FieldByName('NOME').AsString;
      cdsT768.FieldByName('MATRICOLA').AsString:=selT768.FieldByName('MATRICOLA').AsString;
      cdsT768.FieldByName('TOTQUOTAQUAL').AsFloat:=0;
      if selT762.SearchRecord('PROGRESSIVO',selT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        cdsT768.FieldByName('TOTQUOTAQUAL').AsFloat:=selT762.FieldByName('TOTALE').AsFloat;
      cdsT768.FieldByName('PARTTIME').AsFloat:=selT768.FieldByName('PARTTIME').AsFloat;
      cdsT768.FieldByName('FLESSIBILITA').AsString:=selT768.FieldByName('FLESSIBILITA').AsString;
      cdsT768.FieldByName('NOTE').AsString:=selT768.FieldByName('NOTE').AsString;
      cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString:=selT768.FieldByName('NUMORE_ASSEGNATE').AsString;
      cdsT768.FieldByName('NUMORE_ACCETTATE').AsString:=selT768.FieldByName('NUMORE_ACCETTATE').AsString;
      cdsT768.FieldByName('IMPORTO_ORARIO').AsFloat:=selT768.FieldByName('IMPORTO_ORARIO').AsFloat;
      cdsT768.FieldByName('TOTALE_ASSEGNATO').AsFloat:=selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
      cdsT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=selT768.FieldByName('TOTALE_ACCETTATO').AsFloat;
      cdsT768.FieldByName('INF_OBIETTIVI').AsString:=selT768.FieldByName('INF_OBIETTIVI').AsString;
      cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString:=selT768.FieldByName('ACCETT_VALUTAZIONE').AsString;
      cdsT768.FieldByName('VALUTATORE').AsString:='';
      if selSG706.SearchRecord('PROGRESSIVO_VALUTATO',selT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        cdsT768.FieldByName('VALUTATORE').AsString:=selSG706.FieldByName('VALUTATORE').AsString;
      cdsT768.FieldByName('CONFERMATO').AsString:=selT768.FieldByName('CONFERMATO').AsString;
      cdsT768.FieldByName('DATO1').AsString:=selT768.FieldByName('DATO1').AsString + ' - ' +
        VarToStr(selDato1.Lookup('CODICE',selT768.FieldByName('DATO1').AsString,'DESCRIZIONE'));
      cdsT768.FieldByName('DATO2').AsString:=selT768.FieldByName('DATO2').AsString + ' - ' +
        VarToStr(selDato2.Lookup('CODICE',selT768.FieldByName('DATO2').AsString,'DESCRIZIONE'));
      cdsT768.FieldByName('DATO3').AsString:=selT768.FieldByName('DATO3').AsString + ' - ' +
        VarToStr(selDato3.Lookup('CODICE',selT768.FieldByName('DATO3').AsString,'DESCRIZIONE'));
      cdsT768.FieldByName('NUMORE_EXTRA').AsString:=selT768.FieldByName('NUMORE_EXTRA').AsString;
      cdsT768.FieldByName('NUMORE_TOTALI').AsString:=selT768.FieldByName('NUMORE_TOTALI').AsString;
      cdsT768.FieldByName('NUMORE_PAGATE').AsString:='';
      if selT762Pag.SearchRecord('PROGRESSIVO',selT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
        cdsT768.FieldByName('NUMORE_PAGATE').AsString:=R180MinutiOre(selT762Pag.FieldByName('TOTORE').AsInteger);
      cdsT768.Post;
      selT768.Next;
    end;
    cdsT768.First;
    cdsT768.ReadOnly:=SaveReadOnly;
    cdsT768.BeforePost:=cdsT768BeforePost;
    cdsT768.EnableControls;
  end;
end;

procedure TA172FSchedeQuantIndividualiMW.selT767NewRecord;
begin
  FSelT767_Funzioni.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro);
  //selT767.FieldByName('STATO').AsString:='A'; fatto da default campo
end;

procedure TA172FSchedeQuantIndividualiMW.selT767BeforePost(var InsT768:Boolean; var AggT768:Boolean);
begin
  if Trim(FSelT767_Funzioni.FieldByName('ANNO').AsString) = '' then
  begin
    FSelT767_Funzioni.FieldByName('ANNO').FocusControl;
    raise exception.Create(A000MSG_A172_ERR_ANNO_RIF);
  end;

  if FSelT767_Funzioni.FieldByName('DATARIF').IsNull then
    FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + FSelT767_Funzioni.FieldByName('ANNO').AsString);

  if R180Anno(FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime) <> FSelT767_Funzioni.FieldByName('ANNO').AsInteger then
  begin
    FSelT767_Funzioni.FieldByName('DATARIF').focusControl;
    raise exception.Create(A000MSG_A172_ERR_DATA_RIF);
  end;

  if Trim(FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString) = '' then
  begin
    FSelT767_Funzioni.FieldByName('CODGRUPPO').FocusControl;
    raise exception.Create(A000MSG_A172_ERR_NO_CODGRUPPO);
  end;

  if Trim(FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString) = '' then
  begin
    FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').FocusCOntrol;
    raise exception.Create(A000MSG_A172_ERR_TIPO_QUOTA);
  end;

  if (FSelT767_Funzioni.FieldByName('SUPERVISIONE').AsString = 'S') and (FSelT767_Funzioni.FieldByName('PROG_SUPERVISORE').IsNull or
    (FSelT767_Funzioni.FieldByName('PROG_SUPERVISORE').AsInteger = 0)) then
  begin
    FSelT767_Funzioni.FieldByName('PROG_SUPERVISORE').focusControl;
    raise exception.Create(A000MSG_A172_ERR_SUPERVISORE);
  end;

  if Trim(FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
  begin
    FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').FocusControl;
    raise exception.Create(A000MSG_A172_ERR_NO_FILTRO_ANAG);
  end;
  AggT768:=False;
  InsT768:=False;
  if (FSelT767_Funzioni.State = dsInsert) or
    ((FSelT767_Funzioni.State = dsEdit) and (selT768.RecordCount <= 0)) then  //se il gruppo è vuoto provo a ricaricare i dip.
    InsT768:=True;
  if (FSelT767_Funzioni.State = dsEdit) and
     ((FSelT767_Funzioni.FieldByName('ANNO').medpOldValue <> FSelT767_Funzioni.FieldByName('ANNO').AsInteger) or
      (FSelT767_Funzioni.FieldByName('DATARIF').medpOldValue <> FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime) or
      (FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').medpOldValue <> FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').AsString)) then
    AggT768:=True;
  if (InsT768 or AggT768) and (Trim(FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').AsString) <> '') then
  begin
    selV430.Close;
    selV430.SetVariable('PROFILO','T430' + Parametri.CampiRiferimento.C7_DATO1);
    selV430.SetVariable('DATARIF',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
    selV430.SetVariable('FILTRO',FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').AsString);
    try
      selV430.Open;
    except
      FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').FocusControl;
      raise exception.Create(A000MSG_A172_ERR_FILTRO_ANAG);
    end;
  end;
end;

function TA172FSchedeQuantIndividualiMW.selT767FilterRecord: Boolean;
begin
  Result:=A000FiltroDizionario('GRUPPI SC.QUANTITATIVE IND.',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
end;

procedure TA172FSchedeQuantIndividualiMW.selSG715BeforePost(DataSet: TDataSet);
var Tot:Real;
begin
  inherited;
  if ((selSG715.FieldByName('PESO1').AsFloat <> 0) and (Trim(selSG715.FieldByName('OBIETTIVO1').AsString) = '')) or
     ((selSG715.FieldByName('PESO2').AsFloat <> 0) and (Trim(selSG715.FieldByName('OBIETTIVO2').AsString) = ''))  or
     ((selSG715.FieldByName('PESO3').AsFloat <> 0) and (Trim(selSG715.FieldByName('OBIETTIVO3').AsString) = '')) then
    raise Exception.Create(A000MSG_A172_ERR_NO_DESC_OBIETTIVO);
  if ((selSG715.FieldByName('PESO1').AsFloat = 0) and (Trim(selSG715.FieldByName('OBIETTIVO1').AsString) <> '')) or
     ((selSG715.FieldByName('PESO2').AsFloat = 0) and (Trim(selSG715.FieldByName('OBIETTIVO2').AsString) <> ''))  or
     ((selSG715.FieldByName('PESO3').AsFloat = 0) and (Trim(selSG715.FieldByName('OBIETTIVO3').AsString) <> '')) then
    raise Exception.Create(A000MSG_A172_ERR_NO_PESO_OBIETTIVO);
  if selSG715.FieldByName('PESO4').AsFloat < 40 then
    raise Exception.Create(A000MSG_A172_ERR_PESO_OBIETTIVO4);
  Tot:=selSG715.FieldByName('PESO1').AsFloat + selSG715.FieldByName('PESO2').AsFloat +
      selSG715.FieldByName('PESO3').AsFloat + selSG715.FieldByName('PESO4').AsFloat;
  if Tot <> 100 then
    raise Exception.Create(Format(A000MSG_A172_ERR_FMT_SOMMA_PESI,[FloatToStr(Tot)]));
end;

procedure TA172FSchedeQuantIndividualiMW.selSG715NewRecord(DataSet: TDataSet);
begin
  inherited;
  //selSG715.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
  selSG715.FieldByName('PROGRESSIVO').AsInteger:=selSG715.GetVariable('PROGRESSIVO');
  selSG715.FieldByName('ANNO').AsInteger:=FSelT767_Funzioni.FieldByName('ANNO').AsInteger;
  selSG715.FieldByName('OBIETTIVO4').AsString:='Parte residua legata agli obiettivi di struttura ' + FSelT767_Funzioni.FieldByName('ANNO').AsString;
  selSG715.FieldByName('PESO4').AsFloat:=100;
end;

procedure TA172FSchedeQuantIndividualiMW.selT767AfterPost;
begin
  A000AggiornaFiltroDizionario('GRUPPI SC.QUANTITATIVE IND.','',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
end;

procedure TA172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Inizio(var Tot:Real; var TotOre:Integer);
var
  s: string;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  //Carico tutti i dip. che verificano il filtro anagrafe del gruppo e sono in servizio a DataRif
  selV430.Close;
  s:='T430' + Parametri.CampiRiferimento.C7_Dato1;
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    s:=s + ', T430' + Parametri.CampiRiferimento.C7_Dato2;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    s:=s + ', T430' + Parametri.CampiRiferimento.C7_Dato3;
  selV430.SetVariable('PROFILO',s);
  selV430.SetVariable('DATARIF',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
  selV430.SetVariable('FILTRO',FSelT767_Funzioni.FieldByName('FILTRO_ANAGRAFE').AsString);
  selV430.Open;
  Tot:=0;
  TotOre:=0;
end;

procedure TA172FSchedeQuantIndividualiMW.selT767AfterPostInsT768ElaboraElemento(var Tot:Real; var TotOre:Integer);
var s,Dato1, Dato2, Dato3:String;
  PT: Real;
begin
  Dato1:=selV430.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
  Dato2:='';
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    Dato2:=selV430.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
  Dato3:='';
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    Dato3:=selV430.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
  R180SetVariable(selT770,'DATO1',Dato1);
  R180SetVariable(selT770,'DATO2',Dato2);
  R180SetVariable(selT770,'DATO3',Dato3);
  R180SetVariable(selT770,'QUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
  R180SetVariable(selT770,'DATA',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
  selT770.Open;
  if (selT770.RecordCount > 0) and (R180OreMinutiExt(selT770.FieldByName('NUM_ORE').AsString) <> 0) and
     (Dato1 <> '') and
     ((Parametri.CampiRiferimento.C7_Dato2 = '') or
     ((Parametri.CampiRiferimento.C7_Dato2 <> '') and (Dato2 <> ''))) and
     ((Parametri.CampiRiferimento.C7_Dato3 = '') or
     ((Parametri.CampiRiferimento.C7_Dato3 <> '') and (Dato3 <> ''))) then
  begin
    //Controllare che il dip. non verifichi altri filtri, non faccia parte di altri gruppi else anomalia
    ControlloT768.Close;
    ControlloT768.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
    ControlloT768.SetVariable('QUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
    ControlloT768.SetVariable('GRUPPO',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
    ControlloT768.SetVariable('PROG',selV430.FieldByName('PROGRESSIVO').AsInteger);
    ControlloT768.Open;
    if ControlloT768.RecordCount > 0 then
    begin
      //Anomalia
      s:='Il dipendente non è stato inserito perchè fa già parte del gruppo ' + ControlloT768.FieldByName('CODGRUPPO').AsString;
      RegistraMsg.InserisciMessaggio('A',s,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
    end
    else
    begin
      //Controllare che il dip. non ha lunghe assenze nel giorno Datarif
      ControlloT040.Close;
      ControlloT040.SetVariable('DATA',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
      ControlloT040.SetVariable('PROG',selV430.FieldByName('PROGRESSIVO').AsInteger);
      ControlloT040.Open;
      if ControlloT040.RecordCount > 0 then
      begin
        //Anomalia
        s:='Il dipendente non è stato inserito perchè ha una lunga assenza ' + ControlloT040.FieldByName('CAUSALE').AsString;
        RegistraMsg.InserisciMessaggio('A',s,'',selV430.FieldByName('PROGRESSIVO').AsInteger);
      end
      else
      begin
        selT768.Insert;
        selT768.FieldByName('ANNO').AsInteger:=FSelT767_Funzioni.FieldByName('ANNO').AsInteger;
        selT768.FieldByName('CODGRUPPO').AsString:=FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString;
        selT768.FieldByName('CODTIPOQUOTA').AsString:=FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString;
        selT768.FieldByName('PROGRESSIVO').AsInteger:=selV430.FieldByName('PROGRESSIVO').AsInteger;
        selT768.FieldByName('DATO1').AsString:=Dato1;
        selT768.FieldByName('DATO2').AsString:=Dato2;
        selT768.FieldByName('DATO3').AsString:=Dato3;
        selT768.FieldByName('PARTTIME').AsFloat:=selV430.FieldByName('PARTTIME').AsFloat;
        selT768.FieldByName('IMPORTO_ORARIO').AsFloat:=selT770.FieldByName('IMPORTO').AsFloat;
        selT768.FieldByName('NUMORE_ASSEGNATE').AsString:=selT770.FieldByName('NUM_ORE').AsString;
        if selT768.FieldByName('PARTTIME').AsFloat <> 100 then
        begin
          PT:=selT768.FieldByName('PARTTIME').AsFloat;
          selSG735.Close;
          selSG735.SetVariable('QUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
          selSG735.SetVariable('DATARIF',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
          selSG735.SetVariable('PARTTIME',PT);
          selSG735.Open;
          if selSG735.RecordCount > 0 then
            PT:=selSG735.FieldByName('PERC').AsFloat;
          selT768.FieldByName('NUMORE_ASSEGNATE').AsString:=R180MinutiOre(
                Trunc(R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString) * PT / 100));
        end;
        selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat:=R180Arrotonda(selT768.FieldByName('IMPORTO_ORARIO').AsFloat *
              StrToFloatDef(StringReplace(R180Centesimi(R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString)),'.',',',[rfReplaceAll]),0),0.01,'P');
        selT768.FieldByName('NUMORE_ACCETTATE').AsString:=selT768.FieldByName('NUMORE_ASSEGNATE').AsString;
        selT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
        TotOre:=TotOre + R180OreMinutiExt(selT768.FieldByName('NUMORE_ASSEGNATE').AsString);
        Tot:=Tot + selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
        selT768.FieldByName('CONFERMATO').AsString:='N';
        selT768.Post;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TA172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Fine(var Tot:Real; var TotOre:Integer);
begin
  updT767.SetVariable('IMP',Tot);
  updT767.SetVariable('ORE',R180MinutiOre(TotOre));
  updT767.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
  updT767.SetVariable('GRUPPO',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
  updT767.SetVariable('QUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
  updT767.Execute;
  SessioneOracle.Commit;
end;

procedure TA172FSchedeQuantIndividualiMW.selT767BeforeDelete;
begin
  delT768.setVariable('ANNO',selT768.getVariable('ANNO'));
  delT768.setVariable('CODICE',selT768.getVariable('CODICE'));
  delT768.setVariable('CODQUOTA',selT768.getVariable('CODQUOTA'));
  delT768.Execute;
  SessioneOracle.Commit;
end;

function TA172FSchedeQuantIndividualiMW.getLstFlessibilita:TElencoValoriChecklist;
begin
  Result:=TElencoValoriChecklist.Create;

  Result.lstCodice.Add('1');
  Result.lstDescrizione.Add(Format('%-1s - %s',['1','Turnazione']));

  Result.lstCodice.Add('2');
  Result.lstDescrizione.Add(Format('%-1s - %s',['2','Progetti quantitativi']));

  Result.lstCodice.Add('3');
  Result.lstDescrizione.Add(Format('%-1s - %s',['3','Straordinario fino a 110 ore compreso quantitativo']));

  Result.lstCodice.Add('4');
  Result.lstDescrizione.Add(Format('%-1s - %s',['4','Altre condizioni (specificare)']));
end;

procedure TA172FSchedeQuantIndividualiMW.cdsT768Post(Totali: TTotali);
var
  Firma: Boolean;
  evBeforePost, evAfterPost: TEvDataset;
begin
  cdsT768.DisableControls;
  cdsT768.First;
  Firma:=False;
  while not cdsT768.Eof do
  begin
    if selT768.SearchRecord('PROGRESSIVO',cdsT768.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
    begin
      selT768.Edit;
      selT768.FieldByName('FLESSIBILITA').AsString:=cdsT768.FieldByName('FLESSIBILITA').AsString;
      selT768.FieldByName('NOTE').AsString:=cdsT768.FieldByName('NOTE').AsString;
      selT768.FieldByName('NUMORE_ASSEGNATE').AsString:=cdsT768.FieldByName('NUMORE_ASSEGNATE').AsString;
      selT768.FieldByName('TOTALE_ASSEGNATO').AsFloat:=cdsT768.FieldByName('TOTALE_ASSEGNATO').AsFloat;
      selT768.FieldByName('NUMORE_ACCETTATE').AsString:=cdsT768.FieldByName('NUMORE_ACCETTATE').AsString;
      selT768.FieldByName('TOTALE_ACCETTATO').AsFloat:=cdsT768.FieldByName('TOTALE_ACCETTATO').AsFloat;
      selT768.FieldByName('INF_OBIETTIVI').AsString:=cdsT768.FieldByName('INF_OBIETTIVI').AsString;
      selT768.FieldByName('ACCETT_VALUTAZIONE').AsString:=cdsT768.FieldByName('ACCETT_VALUTAZIONE').AsString;
      if selT768.FieldByName('CONFERMATO').AsString <> cdsT768.FieldByName('CONFERMATO').AsString then
        Firma:=True;
      selT768.FieldByName('CONFERMATO').AsString:=cdsT768.FieldByName('CONFERMATO').AsString;
      selT768.FieldByName('NUMORE_EXTRA').AsString:=cdsT768.FieldByName('NUMORE_EXTRA').AsString;
      selT768.Post;
    end;
    //Aggiorno il valutatore
    CambioValutatore.SetVariable('PROGRESSIVO_VALUTATO',cdsT768.FieldByName('PROGRESSIVO').AsInteger);
    CambioValutatore.SetVariable('DATA',StrToDate('31/12/' + FSelT767_Funzioni.FieldByName('ANNO').AsString));
    CambioValutatore.SetVariable('PROGRESSIVO_VALUTATORE',StrToIntDef(VarToStr(selValutatori.Lookup('VALUTATORE',cdsT768.FieldByName('VALUTATORE').AsString,'PROGRESSIVO')),0));
    CambioValutatore.Execute;
    cdsT768.Next;
  end;
  SessioneOracle.Commit;
  cdsT768.EnableControls;
  if (FSelT767_Funzioni.FieldByName('STATO').AsString = 'A') and Firma then
  begin //Diventa in modifica se anche solo un dip. ha firmato
    evBeforePost:=FSelT767_Funzioni.BeforePost;
    evAfterPost:=FSelT767_Funzioni.AfterPost;
    FSelT767_Funzioni.BeforePost:=nil;
    FSelT767_Funzioni.AfterPost:=nil;
    FSelT767_Funzioni.Edit;
    FSelT767_Funzioni.FieldByName('STATO').AsString:='M';
    FSelT767_Funzioni.Post;
    SessioneOracle.Commit;
    FSelT767_Funzioni.BeforePost:=evBeforePost;
    FSelT767_Funzioni.AfterPost:=evAfterPost;
  end;
  updT767.SetVariable('IMP',Totali.TotaleAssegn);
  updT767.SetVariable('ORE',R180MinutiOre(Totali.TotaleOreAssegn));
  updT767.SetVariable('ANNO',FSelT767_Funzioni.FieldByName('ANNO').AsInteger);
  updT767.SetVariable('GRUPPO',FSelT767_Funzioni.FieldByName('CODGRUPPO').AsString);
  updT767.SetVariable('QUOTA',FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
  updT767.Execute;
  SessioneOracle.Commit;
end;

function TA172FSchedeQuantIndividualiMW.getTipoStampaQuant(Dato1, Dato2, Dato3: String): String;
begin
  R180SetVariable(selT770,'DATO1',Dato1);
  R180SetVariable(selT770,'DATO2',Dato2);
  R180SetVariable(selT770,'DATO3',Dato3);
  R180SetVariable(selT770,'QUOTA', FSelT767_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
  R180SetVariable(selT770,'DATA',FSelT767_Funzioni.FieldByName('DATARIF').AsDateTime);
  selT770.Open;
  Result:=selT770.FieldByName('TIPO_STAMPAQUANT').AsString;
end;

procedure TA172FSchedeQuantIndividualiMW.ImpostaSelSG715(Anno,Progressivo: Integer);
begin
  selSG715.Close;
  selSG715.SetVariable('ANNO',Anno);
  selSG715.SetVariable('PROGRESSIVO',Progressivo);
  selSG715.Open;
end;
end.

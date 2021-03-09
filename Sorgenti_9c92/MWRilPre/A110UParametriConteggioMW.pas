unit A110UParametriConteggioMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali,A000UCostanti,A000UMessaggi,ControlloVociPaghe,Oracle;

type
  TA110DataSogliaFunction = function :String of Object;
  TA110FParametriConteggioMW = class(TR005FDataModuleMW)
    QSource: TOracleDataSet;
    DSource: TDataSource;
    DsrM011: TDataSource;
    dsrP050: TDataSource;
    selP050: TOracleDataSet;
    selP050COD_ARROTONDAMENTO: TStringField;
    selP050COD_VALUTA: TStringField;
    selP050DECORRENZA: TDateTimeField;
    selP050DESCRIZIONE: TStringField;
    selP050VALORE: TFloatField;
    selP050TIPO: TStringField;
    DsrP030: TDataSource;
    selP030: TOracleDataSet;
    selP030COD_VALUTA: TStringField;
    selP030DECORRENZA: TDateTimeField;
    selP030DESCRIZIONE: TStringField;
    selP030ABBREVIAZIONE: TStringField;
    selP030NUM_DEC_IMP_VOCE: TIntegerField;
    selP030NUM_DEC_IMP_UNIT: TIntegerField;
    selT265: TOracleDataSet;
    selT275: TOracleDataSet;
    DsrT265: TDataSource;
    DsrT275: TDataSource;
    selM013: TOracleDataSet;
    selM013CODICE: TStringField;
    selM013TIPO_MISSIONE: TStringField;
    selM013DECORRENZA: TDateTimeField;
    selM013DECORRENZA_FINE: TDateTimeField;
    selM013SOGLIA_GG: TStringField;
    selM013RIMBORSO_MAX: TFloatField;
    dsrM013: TDataSource;
    DsrM020: TDataSource;
    SelM020: TOracleDataSet;
    SelM020CODICE: TStringField;
    SelM020DESCRIZIONE: TStringField;
    SelM020CODICEVOCEPAGHE: TStringField;
    SelM020SCARICOPAGHE: TStringField;
    SelM020ESISTENZAINDENNITASUPPL: TStringField;
    SelM020CODICEVOCEPAGHEINDENNITASUPPL: TStringField;
    SelM020SCARICOPAGHEINDENNITASUPPL: TStringField;
    SelM020PERCINDENNITASUPPL: TFloatField;
    SelM020ARROTINDENNITASUPPL: TStringField;
    SelM020CalcArrotIndennitaSuppl: TStringField;
    DsrM021: TDataSource;
    selM021: TOracleDataSet;
    UpDM010: TOracleQuery;
    selM013_2: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    dsrM013_2: TDataSource;
    selDistM013: TOracleDataSet;
    delM013: TOracleQuery;
    UpdM013Decorrenza: TOracleQuery;
    UpdM013Decorrenza_2: TOracleQuery;
    selM011: TOracleDataSet;
    selM011CODICE: TStringField;
    selM011DESCRIZIONE: TStringField;
    selM011SELEZIONATO: TStringField;
    selM021RimbAuto: TOracleDataSet;
    dsrM021RimbAuto: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selM013_2BeforePost(DataSet: TDataSet);
    procedure selM013_2ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selM013_2NewRecord(DataSet: TDataSet);
    procedure selDistM013AfterOpen(DataSet: TDataSet);
    procedure selDistM013AfterScroll(DataSet: TDataSet);
    procedure SelM011AfterDelete(DataSet: TDataSet);
    procedure SelM011AfterPost(DataSet: TDataSet);
    procedure SelM011BeforeDelete(DataSet: TDataSet);
    procedure SelM011BeforePost(DataSet: TDataSet);
    procedure FiltroDizionarioM011(DataSet: TDataSet; var Accept: Boolean);
  private
    selControlloVociPaghe:TControlloVociPaghe;
    FSelM010_Funzioni: TOracleDataset;
    UpDateM010: boolean;
    OldCodice: String;
    procedure OpenselM013_2;
  public
    LstCodRimborsi,
    LstDescRimborsi,
    LstCodIndennita,
    LstDescIndennita: TStringList;
    DataSogliaRimborsiInput: TA110DataSogliaFunction;
    function IsCausalePresenza: Boolean;
    procedure M010CalcFields(DataSet: TDataSet);
    procedure FiltroDizionarioM010(DataSet: TDataSet; var Accept: Boolean);
    procedure OpenselM013;
    procedure CaricaListe;
    procedure PulisciCampiIndOr;
    procedure PulisciCampiStatoGen;
    procedure ResetRiduzionePasto;
    function ControlliFormali: String;
    function VerificaVociPaghe(CampoCodVoce: String): String;
    procedure InserisciVocePaghe(CampoCodVoce: String);
    function CountParamConteggio: Integer;
    function VerificaAltreRegole: String;
    procedure ImpostaCampiGiustif(Assenza: Boolean);
    procedure M010AfterPost;
    procedure OpenSelDistM013;
    procedure OpenselM013_2_NuovaDecorrenza;
    procedure OpenselM021RimbAuto; // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1
    function ControlloDecorrenze(DataDecorrenza: String;Storicizzazione: boolean): String;
    procedure AggiornaDecorrenze(DataDecorrenza: TDateTime;Storicizzazione: boolean);
    property selM010_Funzioni: TOracleDataset read FSelM010_Funzioni write FSelM010_Funzioni;
  end;

implementation

{$R *.dfm}

procedure TA110FParametriConteggioMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SelM013_2.SetVariable('ORDERBY','ORDER BY M013.DECORRENZA, M013.SOGLIA_GG');

  LstCodRimborsi:=TStringList.Create;
  LstDescRimborsi:=TStringList.Create;
  LstCodIndennita:=TStringList.Create;
  LstDescIndennita:=TStringList.Create;
  //----------------------------------------------------------------
  //LELLO: come gestisco le date di decorrenza se il dato libero collegato è storico???
  //Alberto 27/04/2005
  if A000LookupTabella(Parametri.CampiRiferimento.C8_Missione,QSource) then
  begin
    if QSource.VariableIndex('DECORRENZA') >= 0 then
      QSource.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    raise Exception.Create('Dato non specificato!');
  QSource.Open;
  SelM011.SetVariable('ORDERBY','ORDER BY CODICE');
  SelM011.Open;
  SelT265.Open;
  SelT275.Open;
  SelM020.Open;
  selM021.Open;
  CaricaListe;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA110FParametriConteggioMW.FiltroDizionarioM010(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TIPOLOGIA TRASFERTA',DataSet.FieldByName('TIPO_MISSIONE').AsString);
end;

procedure TA110FParametriConteggioMW.FiltroDizionarioM011(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TIPOLOGIA TRASFERTA',DataSet.FieldByName('CODICE').AsString)
end;

procedure TA110FParametriConteggioMW.M010CalcFields(DataSet: TDataSet);
begin
  inherited;
  if selP050.GetVariable('Decorrenza') <> FSelM010_Funzioni.FieldByName('DECORRENZA').AsDateTime then
  begin
    selP050.Close;
    selP050.SetVariable('Decorrenza',FSelM010_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selP050.Open;
  end;
  if selP030.GetVariable('Decorrenza') <> FSelM010_Funzioni.FieldByName('DECORRENZA').AsDateTime then
  begin
    selP030.Close;
    selP030.SetVariable('Decorrenza',FSelM010_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selP030.Open;
  end;
  FSelM010_Funzioni.FieldByName('CalcArrotTariffaDopoRiduzione').AsString:='';
  FSelM010_Funzioni.FieldByName('CalcArrotImportiDatiPaghe').AsString:='';
  if selP050.SearchRecord('COD_ARROTONDAMENTO',FSelM010_Funzioni.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString,[srFromBeginning]) then
    FSelM010_Funzioni.FieldByName('CalcArrotImportiDatiPaghe').AsString:=selP050.FieldByName('DESCRIZIONE').AsString;
  if selP050.searchRecord('COD_ARROTONDAMENTO',FSelM010_Funzioni.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString,[srFromBeginning]) then
    FSelM010_Funzioni.FieldByName('CalcArrotTariffaDopoRiduzione').AsString:=selP050.FieldByName('DESCRIZIONE').AsString;
  FSelM010_Funzioni.FieldByName('CalcCausale').AsString:=VarToStr(selT265.Lookup('Codice',FSelM010_Funzioni.FieldByName('CAUSALE_MISSIONE').AsString,'Descrizione'));
  if FSelM010_Funzioni.FieldByName('CalcCausale').AsString = '' then
    FSelM010_Funzioni.FieldByName('CalcCausale').AsString:=VarToStr(selT275.Lookup('Codice',FSelM010_Funzioni.FieldByName('CAUSALE_MISSIONE').AsString,'Descrizione'));
end;

procedure TA110FParametriConteggioMW.selDistM013AfterOpen(DataSet: TDataSet);
begin
  inherited;
  OpenSelM013_2;
end;

procedure TA110FParametriConteggioMW.selDistM013AfterScroll(DataSet: TDataSet);
begin
  inherited;
  OpenSelM013_2;
end;

procedure TA110FParametriConteggioMW.SelM011AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A000AggiornaFiltroDizionario('TIPI MISSIONE',OldCodice,'');
end;

procedure TA110FParametriConteggioMW.SelM011AfterPost(DataSet: TDataSet);
begin
  inherited;
  A000AggiornaFiltroDizionario('TIPOLOGIA TRASFERTA',OldCodice,DataSet.FieldByName('CODICE').AsString);
end;

procedure TA110FParametriConteggioMW.SelM011BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  OldCodice:=DataSet.FieldByName('CODICE').AsString;
end;

procedure TA110FParametriConteggioMW.SelM011BeforePost(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FieldByName('CODICE').AsString = '' then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_CODICE]));
  if DataSet.FieldByName('DESCRIZIONE').AsString = '' then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DESCRIZIONE]));
  if DataSet.FieldByName('SELEZIONATO').AsString = '' then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_SELEZIONATO]));

  if Dataset.State = dsInsert then
    OldCodice:=''
  else
    OldCodice:=DataSet.FieldByName('CODICE').medpOldValue;
end;

procedure TA110FParametriConteggioMW.OpenselM013_2;
begin
  R180SetVariable(selM013_2,'CODICE',selDistM013.FieldByName('CODICE').AsString);
  R180SetVariable(selM013_2,'TIPO_MISSIONE',selDistM013.FieldByName('TIPO_MISSIONE').AsString);
  if Not selDistM013.FieldByName('DECORRENZA').IsNull then
    R180SetVariable(selM013_2,'DECORRENZA',selDistM013.FieldByName('DECORRENZA').AsString)
  else
    R180SetVariable(selM013_2,'DECORRENZA',Date);
  selM013_2.Open;
end;

procedure TA110FParametriConteggioMW.OpenselM013_2_NuovaDecorrenza;
begin
  R180SetVariable(selM013_2,'CODICE',selDistM013.FieldByName('CODICE').AsString);
  R180SetVariable(selM013_2,'TIPO_MISSIONE',selDistM013.FieldByName('TIPO_MISSIONE').AsString);
  R180SetVariable(selM013_2,'DECORRENZA',DATE_NULL);
  selM013_2.Open;
end;

procedure TA110FParametriConteggioMW.selM013_2ApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: string);
begin
  inherited;
  if R180In(Action,['I','U']) then
  begin
    if not Assigned(DataSogliaRimborsiInput) then
      Raise Exception.Create(A000MSG_A110_ERR_NOT_ASSIGNED);

    selM013_2.FieldByName('DECORRENZA').AsDateTime:=StrToDateTime(DataSogliaRimborsiInput);
  end;
end;

procedure TA110FParametriConteggioMW.selM013_2BeforePost(DataSet: TDataSet);
var DataDecorrenza:TDateTime;
begin
  if not Assigned(DataSogliaRimborsiInput) then
    Raise Exception.Create(A000MSG_A110_ERR_NOT_ASSIGNED);

  if Not TryStrToDate(DataSogliaRimborsiInput,DataDecorrenza) then
    Raise Exception.Create(A000MSG_ERR_DATA_DECORRENZA);

  if selM013_2.FieldByName('SOGLIA_GG').IsNull xor selM013_2.FieldByName('RIMBORSO_MAX').IsNull then
    Raise Exception.Create(A000MSG_A110_ERR_INCOMPLETI);

  if (selM013_2.FieldByName('SOGLIA_GG').AsString = '') or (selM013_2.FieldByName('RIMBORSO_MAX').AsString = '') then
    Raise Exception.Create(A000MSG_A110_ERR_INCOMPLETI);

  if R180OreMinutiExt(selM013_2.FieldByName('SOGLIA_GG').AsString) > 1440 then
    Raise Exception.Create(A000MSG_A110_ERR_24H);
end;

procedure TA110FParametriConteggioMW.selM013_2NewRecord(DataSet: TDataSet);
begin
  inherited;
  selM013_2.FieldByName('CODICE').AsString:=VarToStr(selM013.GetVariable('CODICE'));
  selM013_2.FieldByName('TIPO_MISSIONE').AsString:=VarToStr(selM013.GetVariable('TIPO_MISSIONE'));
end;

procedure TA110FParametriConteggioMW.selT265FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
end;

procedure TA110FParametriConteggioMW.selT275FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

function TA110FParametriConteggioMW.IsCausalePresenza: Boolean;
begin
  Result:=selT275.Locate('Codice',FSelM010_Funzioni.FieldByName('CAUSALE_MISSIONE').AsString,[]);
end;

procedure TA110FParametriConteggioMW.OpenselM013;
begin
  R180SetVariable(selM013,'CODICE',FSelM010_Funzioni.FieldByName('CODICE').AsString);
  R180SetVariable(selM013,'TIPO_MISSIONE',FSelM010_Funzioni.FieldByName('TIPO_MISSIONE').AsString);
  R180SetVariable(selM013,'DECORRENZA',{M010.FieldByName('DECORRENZA').AsString}Parametri.DataLavoro);
  selM013.Open;
end;

// CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
// filtra dataset per indennità km automatica
procedure TA110FParametriConteggioMW.OpenselM021RimbAuto;
var
  ElencoIndKm, Filtro: String;
begin
  ElencoIndKm:=FSelM010_Funzioni.FieldByName('CODICI_INDENNITAKM').AsString;
  if ElencoIndKm = '' then
    Filtro:=''
  else
    Filtro:=Format('where instr('',%s,'','','' || codice || '','') > 0',[ElencoIndKm]);
  R180SetVariable(selM021RimbAuto,'FILTRO',Filtro);
  selM021RimbAuto.Open;
end;
// CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine

procedure TA110FParametriConteggioMW.CaricaListe;
begin
  LstCodRimborsi.Clear;
  LstDescRimborsi.Clear;
  LstCodIndennita.Clear;
  LstDescIndennita.Clear;
  with SelM020 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      LstCodRimborsi.Add(FieldByName('Codice').AsString);
      LstDescRimborsi.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
    SelM020.First;
  end;

  with selM021 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      LstCodIndennita.Add(FieldByName('Codice').AsString);
      LstDescIndennita.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TA110FParametriConteggioMW.PulisciCampiIndOr;
begin
  FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').Clear;
  FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROORE').Clear;
  FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').Clear;
  FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROGG').Clear;
end;

procedure TA110FParametriConteggioMW.PulisciCampiStatoGen;
begin
  FSelM010_Funzioni.FieldByName('TIPO_TARIFFA').Clear;
  FSelM010_Funzioni.FieldByName('TARIFFAINDENNITA').Clear;
  FSelM010_Funzioni.FieldByName('OREMINIMEPERINDENNITA').Clear;
  FSelM010_Funzioni.FieldByName('ARROTTARIFFADOPORIDUZIONE').Clear;

  FSelM010_Funzioni.FieldByName('CODVOCEPAGHESUPHHGG').Clear;
  FSelM010_Funzioni.FieldByName('CODVOCEPAGHESUPGG').Clear;
  FSelM010_Funzioni.FieldByName('CODVOCEPAGHESUPHH').Clear;
  FSelM010_Funzioni.FieldByName('CODVOCEPAGHEINTERA').Clear;
end;

procedure TA110FParametriConteggioMW.ResetRiduzionePasto;
begin
  FSelM010_Funzioni.FieldByName('RIDUZIONE_PASTO').AsString:='N';
end;

function TA110FParametriConteggioMW.ControlliFormali: String;
begin
  Result:='';
  //Controllo i dati inseriti...
  if FSelM010_Funzioni.FieldByName('DECORRENZA').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('DECORRENZA').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_DECORRENZA]);
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('CODICE').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('CODICE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_CODICE]);
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('TIPO_MISSIONE').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('TIPO_MISSIONE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_TIPO_MISSIONE]);
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('DESCRIZIONE').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('DESCRIZIONE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_DESC_REGOLA]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('TARIFFAINDENNITA').AsString = '') and
     (FSelM010_Funzioni.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'N') then
  begin
    FSelM010_Funzioni.FieldByName('TARIFFAINDENNITA').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_TAR_IND_INT]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('OREMINIMEPERINDENNITA').AsString = '') and
     (FSelM010_Funzioni.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'N') then
  begin
    FSelM010_Funzioni.FieldByName('OREMINIMEPERINDENNITA').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_ORE_MIN_IND]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('TIPO_TARIFFA').AsString = '') and
     (FSelM010_Funzioni.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'N') then
  begin
    FSelM010_Funzioni.FieldByName('TIPO_TARIFFA').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_TIPO_TAR_IND_INT]);
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('ARROTONDAMENTOORE').AsInteger < 1 then
  begin
    FSelM010_Funzioni.FieldByName('ARROTONDAMENTOORE').FocusControl;
    Result:=A000MSG_A110_ERR_ARROT_ORE;
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('TIPO').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('TIPO').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_TIPO_ARR_ORE]);
    Exit;
  end;
  if FSelM010_Funzioni.FieldByName('ARROTTOTIMPORTIDATIPAGHE').AsString = '' then
  begin
    FSelM010_Funzioni.FieldByName('ARROTTOTIMPORTIDATIPAGHE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_ARR_TOT_ORE]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('ARROTTARIFFADOPORIDUZIONE').AsString = '') and
     (FSelM010_Funzioni.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'N') then
  begin
    FSelM010_Funzioni.FieldByName('ARROTTARIFFADOPORIDUZIONE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_ARR_TAR_RID]);
    Exit;
  end;

  if (FSelM010_Funzioni.FieldByName('RIDUZIONE_PASTO').AsString <> 'S') and
     (FSelM010_Funzioni.FieldByName('TIPO_TARIFFA').AsString = 'O') and
     (FSelM010_Funzioni.FieldByName('IND_DA_TAB_TARIFFE').AsString <> 'S') then
  begin
    if (FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').AsString = '') then
    begin
      //??PclRegole.ActivePageIndex:=0;
      FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').FocusControl;
      Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_ORE_RETR_INT]);
      Exit;
    end;
    if (FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').AsString = '') and
       (FSelM010_Funzioni.FieldByName('TIPO_TARIFFA').AsString = 'O') then
    begin
      //??PclRegole.ActivePageIndex:=0;
      FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').FocusControl;
      Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_LIM_GG_RET_MESE]);
      Exit;
    end;
  end
  else
  begin
    if FSelM010_Funzioni.FieldByName('RIDUZIONE_PASTO').AsString = 'S' then
    begin
      if (FSelM010_Funzioni.FieldByName('PERCRETRIBPASTO').AsString = '') then
      begin
        //??PclRegole.ActivePageIndex:=0;
        FSelM010_Funzioni.FieldByName('PERCRETRIBPASTO').FocusControl;
        Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_PERC_RIMB_PASTO]);
        Exit;
      end;
    end;
  end;
  if (FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').AsString = '') and
     (FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROORE').AsString <> '') then
  begin
    //??PclRegole.ActivePageIndex:=0;
    FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_ORE_RETR_INT]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('LIMITEORERETRIBUITEINTERE').AsString <> '') and
     (FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROORE').AsString = '') then
  begin
    //??PclRegole.ActivePageIndex:=0;
    FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROORE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_PERC_SUP_ORE]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').AsString = '') and
     (FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROGG').AsString <> '') then
  begin
    //??PclRegole.ActivePageIndex:=0;
    FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_LIM_GG_RET_MESE]);
    Exit;
  end;
  if (FSelM010_Funzioni.FieldByName('MAXGIORNIRETRMESE').AsString <> '') and
     (FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROGG').AsString = '') then
  begin
    //??PclRegole.ActivePageIndex:=0;
    FSelM010_Funzioni.FieldByName('PERCRETRIBSUPEROGG').FocusControl;
    Result:=Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A110_MSG_PERC_SUP_GG]);
    Exit;
  end;

  if (FSelM010_Funzioni.FieldByName('ARROTONDAMENTOORE').AsFloat <= 0)
  or ((60 mod FSelM010_Funzioni.FieldByName('ARROTONDAMENTOORE').AsInteger) <> 0) then
  begin
    FSelM010_Funzioni.FieldByName('ARROTONDAMENTOORE').Clear;
    Result:=A000MSG_A110_ERR_ARROT_ORE_DIV;
    Exit;
  end;

  {
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  // se impostato il rimborso km auto, verifica l'indicazione del codice di ind. km
  if FSelM010_Funzioni.FieldByName('RIMB_KM_AUTO').AsString = 'S' then
  begin
    if FSelM010_Funzioni.FieldByName('IND_KM_AUTO').AsString = '' then
    begin
      Result:=A000MSG_A110_ERR_IND_KM;
      Exit;
    end;
  end;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine
  }
end;

function TA110FParametriConteggioMW.VerificaVociPaghe(CampoCodVoce:String): String;
var VoceOld: String;
begin
  Result:='';
  if (FSelM010_Funzioni.State = dsInsert) or (FSelM010_Funzioni.FieldByName(CampoCodVoce).medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=FSelM010_Funzioni.FieldByName(CampoCodVoce).medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,FSelM010_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Result:=selControlloVociPaghe.MessaggioLog;
end;

procedure TA110FParametriConteggioMW.InserisciVocePaghe(CampoCodVoce:String);
begin
  //se voce vuota esco ma non faccio abort altrimenti interromperei il salvataggio
  if Trim(FSelM010_Funzioni.FieldByName(CampoCodVoce).AsString) = '' then Exit;
  if not selControlloVociPaghe.ValutaInserimentoVocePaghe(FSelM010_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Abort;
end;

function TA110FParametriConteggioMW.CountParamConteggio: Integer;
begin
  with TOracleQuery.Create(nil) do
  begin
    try
      Name:='selCountM010';
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT M010.* ');
      SQL.Add('FROM M010_PARAMETRICONTEGGIO M010 ');
      SQL.Add('WHERE M010.DECORRENZA=TO_DATE(''' + FSelM010_Funzioni.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'') ');
      SQL.Add('AND M010.CODICE=''' + FSelM010_Funzioni.FieldByName('CODICE').AsString + '''');
      Execute;
      Result:=RowCount;
    finally
      Free;
    end;
  end;
end;

function TA110FParametriConteggioMW.VerificaAltreRegole: String;
begin
  Result:='';
  UpDateM010:=False;
  if ((CountParamConteggio > 0) and (FSelM010_Funzioni.State = dsInsert))
  or ((FSelM010_Funzioni.State = dsEdit) and (FSelM010_Funzioni.FieldByName('MAXMESIRIMB').OldValue <> FSelM010_Funzioni.FieldByName('MAXMESIRIMB').Value)) then
  begin
    Result:=A000MSG_A110_DLG_ALTRE_REGOLE;
    UpDateM010:=True;
  end;
end;

procedure TA110FParametriConteggioMW.ImpostaCampiGiustif(Assenza: Boolean);
begin
  if FSelM010_Funzioni.FieldByName('CAUSALE_MISSIONE').IsNull then
  begin
    FSelM010_Funzioni.FieldByName('GIUSTIF_HHMAX').Clear;
    FSelM010_Funzioni.FieldByName('GIUSTIF_COPRE_DEBITOGG').AsString:='N';
  end
  else if not Assenza then
    FSelM010_Funzioni.FieldByName('GIUSTIF_COPRE_DEBITOGG').AsString:='N';
end;

procedure TA110FParametriConteggioMW.M010AfterPost;
begin
  if UpDateM010 then
  begin
    UpDM010.Close;
    UpDM010.SQL.Clear;
    UpDM010.SQL.Add('UPDATE M010_PARAMETRICONTEGGIO M010');
    UpDM010.SQL.Add('SET M010.MAXMESIRIMB=' + FSelM010_Funzioni.FieldByName('MAXMESIRIMB').AsString + ' ');
    UpDM010.SQL.Add('WHERE M010.DECORRENZA=TO_DATE(''' + FSelM010_Funzioni.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'') ');
    UpDM010.SQL.Add('AND M010.CODICE=''' + FSelM010_Funzioni.FieldByName('CODICE').AsString + '''');
    UpDM010.Execute;
    SessioneOracle.Commit;
    FSelM010_Funzioni.Refresh;
  end;
end;

procedure TA110FParametriConteggioMW.OpenSelDistM013;
begin
  selDistM013.Close;
  selDistM013.SetVariable('CODICE',FSelM010_Funzioni.FieldByName('CODICE').AsString);
  selDistM013.SetVariable('TIPO_MISSIONE',FSelM010_Funzioni.FieldByName('TIPO_MISSIONE').AsString);
  selDistM013.Open;
  try
    selDistM013.DisableControls;
    while Not(selDistM013.Eof) and (selDistM013.FieldByName('DECORRENZA').AsDateTime < Parametri.DataLavoro) do
      selDistM013.Next;
  finally
    selDistM013.EnableControls;
  end;
end;

function TA110FParametriConteggioMW.ControlloDecorrenze(DataDecorrenza:String;Storicizzazione: boolean): String;
begin
  Result:='';
  with TOracleQuery.Create(nil) do
  begin
    try
      Session:=SessioneOracle;
      //Controllo "bloccante" decorrenze preesistenti
      SQL.Add('SELECT COUNT(*) AS NUMREC');
      SQL.Add('FROM M013_SOGLIE_RIMBORSIPASTO M013');
      SQL.Add('WHERE M013.CODICE = ''' + selM013_2.FieldByName('CODICE').AsString + '''');
      SQL.Add('AND M013.TIPO_MISSIONE = ''' + selM013_2.FieldByName('TIPO_MISSIONE').AsString + '''');
      SQL.Add('AND M013.DECORRENZA = TO_DATE(''' + DataDecorrenza + ''',''DD/MM/YYYY'')');
      if Not Storicizzazione then
        SQL.Add('AND M013.DECORRENZA <> TO_DATE(''' + selDistM013.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'')');
      Execute;
      if FieldAsInteger('NUMREC') > 0 then
        raise Exception.Create('Attenzione! Data decorrenza già utilizzata per questo codice e tipo missione.');
      //Controllo "NON bloccante" intersezione periodi
      SQL.Clear;
      SQL.Add('SELECT M013.*');
      SQL.Add('FROM M013_SOGLIE_RIMBORSIPASTO M013');
      SQL.Add('WHERE M013.CODICE = ''' + selM013_2.FieldByName('CODICE').AsString + '''');
      SQL.Add('AND M013.TIPO_MISSIONE = ''' + selM013_2.FieldByName('TIPO_MISSIONE').AsString + '''');
      SQL.Add('AND TO_DATE(''' + DataDecorrenza + ''',''DD/MM/YYYY'') BETWEEN M013.DECORRENZA AND M013.DECORRENZA_FINE');
        SQL.Add('AND M013.DECORRENZA_FINE <> TO_DATE(''31/12/3999'',''DD/MM/YYYY'')');
        if Not Storicizzazione then
          SQL.Add('AND M013.DECORRENZA <> TO_DATE(''' + selDistM013.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY'')');
        Execute;
        if RowCount > 0 then
          Result:=Format(A000MSG_A110_DLG_FMT_INTERSEC_DECORRENZA,[FieldAsString('DECORRENZA'),FieldAsString('DECORRENZA_FINE')]);
      finally
        Free;
      end;
  end;
end;

procedure TA110FParametriConteggioMW.AggiornaDecorrenze(DataDecorrenza:TDateTime;Storicizzazione: boolean);
begin
  //Cambio di decorrenza di regole già presenti
  if Not Storicizzazione and (selDistM013.FieldByName('DECORRENZA').AsDateTime <> DataDecorrenza) then
  begin
    UpdM013Decorrenza_2.SetVariable('CODICE',selM013_2.FieldByName('CODICE').AsString);
    UpdM013Decorrenza_2.SetVariable('TIPO_MISSIONE',selM013_2.FieldByName('TIPO_MISSIONE').AsString);
    UpdM013Decorrenza_2.SetVariable('DECORRENZA_NEW',DataDecorrenza);
    UpdM013Decorrenza_2.SetVariable('DECORRENZA_OLD',selM013_2.FieldByName('DECORRENZA').AsdateTime);
    UpdM013Decorrenza_2.Execute;
  end;
  //Allineamento date decorrenza fine
  UpdM013Decorrenza.Execute;
  SessioneOracle.Commit;
end;

procedure TA110FParametriConteggioMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(LstCodRimborsi);
  FreeAndNil(LstDescRimborsi);
  FreeAndNil(LstCodIndennita);
  FreeAndNil(LstDescIndennita);
  FreeAndNil(selControlloVociPaghe);
  SelM011.Close;
  selP050.Close;
  selP030.Close;
  SelM020.Close;
  SelM021.Close;
  inherited;
end;

end.

unit A100UImpRimborsiIterMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW,OracleData, Data.DB, C180FunzioniGenerali,
  A000UMessaggi, Oracle,A000UInterfaccia;

type
  TA100FImpRimborsiIterMW = class(TR005FDataModuleMW)
    SelM041: TOracleDataSet;
    SelM041PARTENZA: TStringField;
    SelM041DESTINAZIONE: TStringField;
    SelM041CHILOMETRI: TFloatField;
    SelM041TIPO1: TStringField;
    SelM041LOCALITA1: TStringField;
    SelM041TIPO2: TStringField;
    SelM041LOCALITA2: TStringField;
    selM021A: TOracleDataSet;
    P050: TOracleDataSet;
    P050COD_ARROTONDAMENTO: TStringField;
    P050COD_VALUTA: TStringField;
    P050DECORRENZA: TDateTimeField;
    P050DESCRIZIONE: TStringField;
    P050VALORE: TFloatField;
    P050TIPO: TStringField;
    updM150: TOracleQuery;
    selP150: TOracleQuery;
    selDatoSede: TOracleQuery;
    selM175: TOracleDataSet;
    selM175CODICE: TStringField;
    selM175DESCRIZIONE: TStringField;
    selM175VALORE: TStringField;
    dsrM175: TDataSource;
    selM170: TOracleDataSet;
    selM170CODICE: TStringField;
    selM170DESCRIZIONE: TStringField;
    selM170TARGA: TStringField;
    dsrM170: TDataSource;
    selM143: TOracleDataSet;
    dsrM143: TDataSource;
    selM143DATA: TDateTimeField;
    selM143DALLE: TStringField;
    selM143ALLE: TStringField;
    selM143NOTE: TStringField;
    selM143TIPO: TStringField;
    selM143D_TIPO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    nArrotondamento: Real;
    sTipo: String;
    FSelM150_Funzioni: TOracleDataset;
    function GetIndennitaKm(const NumKm: double; const Codice: String;
      const DataRif: TDateTime): double;
    procedure GetArrotondamento(Codice: string; Data: TDateTime);
    function GetSedeLavoro(Progressivo: Integer): String;
  public
    function selM150BeforePostPasso1: String;
    function selM150BeforePostPasso2: String;
    procedure KMPERCORSI_VARIATOValidate;
    procedure selM150CalcFields;
    procedure selM150AfterScroll;
    procedure ResetDatasetFigli;
    procedure ConfermaTuttiRimborsi;
    procedure selM150ApplyRecord(Action: Char; var Applied: Boolean);
    property SelM150_Funzioni: TOracleDataset read FSelM150_Funzioni write FSelM150_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA100FImpRimborsiIterMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SelM041.Open;
end;

procedure TA100FImpRimborsiIterMW.selM150CalcFields;
var
  Partenza, Rientro, ElencoDestinazioni: String;
  LstDest: TStringList;
  i: Integer;
begin
  inherited;

  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.ini
  // C_PERCORSO: percorso trasferta
  // 1. partenza
  Partenza:=FSelM150_Funzioni.FieldByName('PARTENZA').AsString;
  if selM041.SearchRecord('LOCALITA1',Partenza,[srFromBeginning]) then
    Partenza:=selM041.FieldByName('PARTENZA').AsString;

  // 2. destinazione
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine
  {
  Destinazione:=FSelM150_Funzioni.FieldByName('DESTINAZIONE').AsString;
  if selM041.SearchRecord('LOCALITA2',Destinazione,[srFromBeginning]) then
    Destinazione:=selM041.FieldByName('DESTINAZIONE').AsString;
  }
  // decodifica l'elenco delle destinazioni (che è separato da virgola)
  ElencoDestinazioni:=FSelM150_Funzioni.FieldByName('ELENCO_DESTINAZIONI').AsString;
  LstDest:=TStringList.Create;
  try
    LstDest.StrictDelimiter:=True;
    LstDest.CommaText:=ElencoDestinazioni;
    ElencoDestinazioni:='';
    for i:=0 to LstDest.Count - 1 do
    begin
      if selM041.SearchRecord('LOCALITA2',LstDest[i],[srFromBeginning]) then
        LstDest[i]:=selM041.FieldByName('DESTINAZIONE').AsString;
    end;
    ElencoDestinazioni:=LstDest.CommaText.Replace(',',' - ',[rfReplaceAll]);
  finally
    FreeAndNil(LstDest);
  end;
  // CUNEO_ASLCN1 - commessa 2014/145 SVILUPPO#1.fine

  // 3. rientro
  Rientro:=FSelM150_Funzioni.FieldByName('RIENTRO').AsString;
  if selM041.SearchRecord('LOCALITA1',Rientro,[srFromBeginning]) then
    Rientro:=selM041.FieldByName('PARTENZA').AsString;

  FSelM150_Funzioni.FieldByName('C_PERCORSO').AsString:=Format('%s - %s - %s',[Partenza,ElencoDestinazioni,Rientro]);
  // CUNEO_ASLCN1 - commessa: 2013/107 SVILUPPO#1.fine
  FSelM150_Funzioni.FieldByName('C_SEDE_LAVORO').AsString:=GetSedeLavoro(FSelM150_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  FSelM150_Funzioni.FieldByName('C_COMUNE_RES').AsString:=Format('%s (%s)',[FSelM150_Funzioni.FieldByName('COMUNE_RESIDENZA').AsString,FSelM150_Funzioni.FieldByName('CAP_RESIDENZA').AsString]);
  // CUNEO_ASLCN1 - chiamata 88143.ini
  FSelM150_Funzioni.FieldByName('C_COMUNE_DOM').AsString:=Format('%s (%s)',[FSelM150_Funzioni.FieldByName('COMUNE_DOMICILIO').AsString,FSelM150_Funzioni.FieldByName('CAP_DOMICILIO').AsString]);
  // CUNEO_ASLCN1 - chiamata 88143.fine
end;

procedure TA100FImpRimborsiIterMW.KMPERCORSI_VARIATOValidate;
begin
  // ricalcolo importo indennità km
  if FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').AsFloat > 0 then
    FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').AsFloat:=GetIndennitaKm(FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').AsFloat,
                                                                                    FSelM150_Funzioni.FieldByName('CODICE').AsString,
                                                                                    FSelM150_Funzioni.FieldByName('DATAA').AsDateTime)
  else
    FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').AsFloat:=0;
  if FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').IsNull then
    FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').Clear;
end;

function TA100FImpRimborsiIterMW.GetIndennitaKm(const NumKm: double; const Codice: String; const DataRif: TDateTime): double;
var
  nImportoDep: double;
begin
  if (Codice <> selM021A.GetVariable('CODICE')) or
     (DataRif <> selM021A.GetVariable('DECORRENZA')) then
  begin
    selM021A.Close;
    selM021A.SetVariable('CODICE', Codice);
    selM021A.SetVariable('DECORRENZA', DataRif);
    selM021A.Open;
  end;
  nImportoDep:=NumKm * selM021A.FieldByName('IMPORTO').AsFloat;
  GetArrotondamento(selM021A.FieldByName('ARROTONDAMENTO').AsString, DataRif);
  Result:=R180Arrotonda(nImportoDep, nArrotondamento, sTipo);
end;

Procedure TA100FImpRimborsiIterMW.GetArrotondamento(Codice: string; Data: TDateTime);
begin
  nArrotondamento:=1;
  sTipo:='P';
  P050.Close;
  P050.SetVariable('DECORRENZA', Data);
  P050.SetVariable('CODICE', Codice);
  P050.Open;
  P050.First;
  if not P050.Eof then
  begin
    nArrotondamento:=P050.FieldByName('VALORE').AsFloat;
    sTipo:=P050.FieldByName('TIPO').AsString;
  end;
end;

function TA100FImpRimborsiIterMW.selM150BeforePostPasso1: String;
begin
  Result:='';
  // stato ("A" oppure "S")
  if (FSelM150_Funzioni.FieldByName('STATO').AsString <> 'A') and
      (FSelM150_Funzioni.FieldByName('STATO').AsString <> 'S') then
      raise Exception.Create(A000MSG_A100_ERR_STATO_RIMBORSO);

  // km percorsi variato
  if not FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').IsNull then
  begin
    if FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').AsFloat < 0 then
      raise Exception.Create(A000MSG_A100_ERR_KM_AUTOR_NEG);
    if FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').AsFloat > FSelM150_Funzioni.FieldByName('KMPERCORSI').AsFloat then
    begin
      Result:=A000MSG_A100_MSG_KM_AUTOR;
    end;
  end;
end;

function TA100FImpRimborsiIterMW.selM150BeforePostPasso2: String;
begin
  Result:='';
  if not FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').IsNull then
  begin
    // ricalcolo importo indennità km
    FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').AsFloat:=GetIndennitaKm(FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').AsFloat,
                                                                              FSelM150_Funzioni.FieldByName('CODICE').AsString,
                                                                              FSelM150_Funzioni.FieldByName('DATAA').AsDateTime);
  end;

  // rimborso autorizzato
  if not FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').IsNull then
  begin
    if FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').AsFloat < 0 then
      raise Exception.Create(A000MSG_A100_ERR_IMP_AUTOR_NEG);

    if FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').AsFloat > FSelM150_Funzioni.FieldByName('RIMBORSO').AsFloat then
      Result:=A000MSG_A100_MSG_IMP_AUTOR;
  end;
end;

procedure TA100FImpRimborsiIterMW.ResetDatasetFigli;
begin
  selM170.Close;
  selM170.ClearVariables;
  selM170.Open;

  selM175.Close;
  selM175.ClearVariables;
  selM175.Open;

  // CUNEO_ASLCN1 - chiamata 88143.ini
  selM143.Close;
  selM143.ClearVariables;
  selM143.Open;
  // CUNEO_ASLCN1 - chiamata 88143.fine
end;

procedure TA100FImpRimborsiIterMW.selM150AfterScroll;
begin
  selM170.Close;
  selM170.SetVariable('ID',FSelM150_Funzioni.FieldByName('ID').AsInteger);
  selM170.Open;

  selM175.Close;
  selM175.SetVariable('ID',FSelM150_Funzioni.FieldByName('ID').AsInteger);
  selM175.Open;

  // CUNEO_ASLCN1 - chiamata 88143.ini
  selM143.Close;
  selM143.SetVariable('ID',FSelM150_Funzioni.FieldByName('ID').AsInteger);
  selM143.Open;
  // CUNEO_ASLCN1 - chiamata 88143.fine
end;

procedure TA100FImpRimborsiIterMW.selM150ApplyRecord(Action: Char; var Applied: Boolean);
begin
  inherited;
  if Action <> 'U' then
    exit;
  RegistraLog.SettaProprieta('M', R180Query2NomeTabella(FSelM150_Funzioni),NomeOwner, FSelM150_Funzioni, True);
  with updM150 do
  begin
    SetVariable('KMPERCORSI_VARIATO',FSelM150_Funzioni.FieldByName('KMPERCORSI_VARIATO').Value);
    SetVariable('RIMBORSO_VARIATO',FSelM150_Funzioni.FieldByName('RIMBORSO_VARIATO').Value);
    SetVariable('STATO', FSelM150_Funzioni.FieldByName('STATO').Value);
    SetVariable('RIGAID', FSelM150_Funzioni.RowId);
    SetVariable('ID', FSelM150_Funzioni.FieldByName('ID').AsInteger);
    Execute;
  end;
  RegistraLog.RegistraOperazione;
  Applied:=True;
end;

procedure TA100FImpRimborsiIterMW.ConfermaTuttiRimborsi;
begin
  with FSelM150_Funzioni do
  begin
    if State = dsEdit then
      Post;
    First;
    try
      while not Eof do
      begin
        if FieldByName('STATO').AsString = 'A' then
        begin
          Edit;
          FieldByName('STATO').AsString:='S';
          Post;
        end;
        Next;
      end;
    finally
      First;
    end;
  end;
end;

function TA100FImpRimborsiIterMW.GetSedeLavoro(Progressivo: Integer): String;
var
  CodComuneSede: string;
  CapComuneSede: string;
  DescComuneSede: string;
begin
  // comune della sede di lavoro
  // 1. se esiste C8_SEDE, e se è valorizzato per il progressivo corrente
  //    considerare il codice della T430.C8_SEDE
  CodComuneSede:='';
  CapComuneSede:='';
  DescComuneSede:='';
  if Parametri.CampiRiferimento.C8_Sede <> '' then
  begin
    try
      with selDatoSede do
      begin
        SetVariable('DATOSEDE',Parametri.CampiRiferimento.C8_Sede);
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('DATARIF',Parametri.DataLavoro);
        Execute;
        if RowCount > 0 then
        begin
          CodComuneSede:=FieldAsString(0);
          CapComuneSede:=FieldAsString(1);
          DescComuneSede:=FieldAsString(2);
        end;
      end;
    except
    end;
  end;

  // 2. altrimenti estrarre la sede di lavoro dalla tabella P150
  if CodComuneSede = '' then
  begin
    try
      with selP150 do
      begin
        Execute;
        if RowCount > 0 then
        begin
          CodComuneSede:=FieldAsString(0);
          CapComuneSede:=FieldAsString(1);
          DescComuneSede:=FieldAsString(2);
        end;
      end;
    except
    end;
  end;
  Result:=Format('%s (%s)',[DescComuneSede,CapComuneSede]);
end;

end.

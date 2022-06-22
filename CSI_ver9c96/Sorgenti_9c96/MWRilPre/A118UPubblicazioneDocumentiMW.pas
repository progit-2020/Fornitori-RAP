unit A118UPubblicazioneDocumentiMW;

interface

uses
  {$IFDEF IRISWEB}IWApplication,{$ENDIF}
  A000UInterfaccia, C180FunzioniGenerali, R005UDataModuleMW,
  StrUtils, IOUtils, Math, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Oracle, DB, OracleData;

type
  // tipologie di confronto sui livelli e campi
  TTipoTest = (ttDipendente,   // test da effettuare per il dipendente
               ttSupervisore,  // test da effettuare per il supervisore
               ttFormale       // test solo formale
              );

  TVariabile = record
    Nome: String;          // nome variabile
    Tipo: Integer;         // tipo variabile (nel dataset per valutazione filtro)
    TipoCampo: TFieldType; // tipo campo (clientdataset)
    RifData: Boolean;      // indica se la variabile è riferita alla data
  end;

  TCampo = class
  private
    FCampo: String;
    FVariabile,
    FRifData: Boolean;
    FTipoVariabile: Integer;
    FTipoCampo: TFieldType;
    FSizeCampo: Integer;
    FValoreInt: Integer;
    FValoreDate: TDateTime;
    FValoreFloat: double;
    procedure SetCampo(const Value: String);
  public
    Dal,
    Lung: Integer;
    Ext,
    Valore,
    Visibile,
    ErrMatch: String;
    // dati ridondanti: sarebbe bene trovare una soluzione migliore
    ParOperatore: String;
    ParMatricola: String;
    ParProgressivo: Integer;
    // dati ridondanti.fine
    function MatchTipoVariabile: Boolean;
    function MatchTipoField: Boolean;
    function Match(const PTipoTest: TTipoTest): Boolean;
    property Campo: String read FCampo write SetCampo;
    property Variabile: Boolean read FVariabile;
    property RifData: Boolean read FRifData;
    property TipoVariabile: Integer read FTipoVariabile; // per variabile dataset
    property TipoCampo: TFieldType read FTipoCampo;      // per clientdataset
    property SizeCampo: Integer read FSizeCampo;         // per clientdataset
  end;

  TLivello = class
  private
    // dati della struttura
    NomeI201: String;
    SeparatoreI201: String;
    FiltroI201: String;
    CampoArr: array of TCampo;
    selFiltro: TOracleQuery;
    // dati del file
    FNomeFile: String;
    FExtFile: String;
    procedure SetNomeFile(const Value: String);
  public
    Livello: Integer;
    PathFile: String;
    ExtI201: String;
    // dati ridondanti.ini: sarebbe bene trovare una soluzione migliore
    ParOperatore: String;
    ParMatricola: String;
    ParProgressivo: Integer;
    // dati ridondanti.fine
    constructor Create;
    destructor Destroy; override;
    procedure AddStrutturaCampo(const PCampo: String; const PDal, PLung: Integer; const PVisibile, PExt: String);
    function  GetCampo(const PCampo: String): TCampo;
    function  MatchNome(const PTipoTest: TTipoTest; var RErrMatch: String): Boolean;
    function  MatchFiltro(const PTipoTest: TTipoTest): Boolean;
    property NomeFile: String read FNomeFile write SetNomeFile;
    property ExtFile: String read FExtFile;
  end;

  TA118FPubblicazioneDocumentiMW = class(TR005FDataModuleMW)
    selFiltro: TOracleQuery;
    selI200: TOracleDataSet;
    selI201: TOracleDataSet;
    selI202: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCodice: String;             // codice tipologia documento
    FRootDir: String;            // directory base per i documenti di questa tipologia
    FLivArr: array of TLivello;
    function GetCodice: String;
    procedure SetCodice(const Value: String);
    function GetRootDir: String;
    procedure SetRootDir(const Value: String);
  public
    LivMaxDir: Integer;          // livello della directory più profonda
    LivFile: Integer;            // livello dei file
    ParOperatore: String;        // nome_utente per cui si vogliono estrarre i documenti
    ParMatricola: String;        // matricola per cui si vogliono estrarre i documenti
    ParProgressivo: Integer;     // progressivo per cui si vogliono estrarre i documenti
    function  CheckFiltroDoc(const PFiltro: String; var ErrMsg: String): Boolean;
    procedure Clear;
    function  GetLivello(const PLiv: Integer): TLivello;
    function  AddLivello(const PLiv: Integer; const PNome, PExt, PSeparatore, PFiltro: String): TLivello;
    function  GetValoreCampo(const PCampo: String; const PLiv: Integer; const PMatchTipoField: Boolean = True): String;
    class function GetFileName(const PPathCompleto: String): String; static;
    class function IsNomeVariabile(const PNome: String): Boolean; static;
    class function RemovePrefissoVariabile(const PNomeVariabile: String): String; static;
    property Codice: String read GetCodice write SetCodice;
    property RootDir: String read GetRootDir write SetRootDir;
    property Livello[const PLiv:Integer]: TLivello read GetLivello;
  end;

const
  ROOT_DIR_DEFAULT     = 'Archivi\usr_files\';
  FILLER_POSIZIONALE   = '_';
  ESTENSIONE_QUALSIASI = '.*';
  PREFISSO_VAR: String = ':';
  VAR_FILLER           = 'FILLER';
  VAR_ANNO             = 'ANNO';
  VAR_MESE             = 'MESE';
  VAR_GIORNO           = 'GIORNO';
  VAR_DATA             = 'DATA';
  VAR_PROGRESSIVO      = 'PROGRESSIVO';
  VAR_MATRICOLA        = 'MATRICOLA';
  VAR_NOME_UTENTE      = 'NOME_UTENTE';
  VAR_CODFISCALE       = 'CODFISCALE';
  LUNGHEZZA_CODFISCALE = 16;

  // elenco variabili ammesse con relative informazioni
  VARIABILI: array [0..8] of TVariabile = (
    (Nome: VAR_FILLER;          Tipo: otString;    TipoCampo: ftString;     RifData: False),
    (Nome: VAR_ANNO;            Tipo: otInteger;   TipoCampo: ftInteger;    RifData: True),
    (Nome: VAR_MESE;            Tipo: otInteger;   TipoCampo: ftString;     RifData: True),
    (Nome: VAR_GIORNO;          Tipo: otInteger;   TipoCampo: ftInteger;    RifData: True),
    (Nome: VAR_DATA;            Tipo: otString;    TipoCampo: ftDateTime;   RifData: True),
    (Nome: VAR_PROGRESSIVO;     Tipo: otInteger;   TipoCampo: ftInteger;    RifData: False),
    (Nome: VAR_MATRICOLA;       Tipo: otString;    TipoCampo: ftString;     RifData: False),
    (Nome: VAR_NOME_UTENTE;     Tipo: otString;    TipoCampo: ftString;     RifData: False),
    (Nome: VAR_CODFISCALE;      Tipo: otString;    TipoCampo: ftString;     RifData: False)
  );

implementation

{$R *.dfm}

procedure TA118FPubblicazioneDocumentiMW.DataModuleCreate(Sender: TObject);
begin
 try
  inherited;

  // inizializzazioni
  SetLength(FLivArr,0);
  LivMaxDir:=-1;
  LivFile:=-1;
  ParOperatore:='';
  ParMatricola:='';
  ParProgressivo:=0;

  // apertura dataset
  selI200.Close;
  selI200.Open;
 except
 end;
end;

procedure TA118FPubblicazioneDocumentiMW.DataModuleDestroy(Sender: TObject);
begin
 try
  Clear;
  inherited;
 except
 end;
end;

function TA118FPubblicazioneDocumentiMW.CheckFiltroDoc(const PFiltro: String; var ErrMsg: String): Boolean;
// applica il filtro di visualizzazione del tipo documento
// e restituisce True/False a seconda che il filtro sia verificato o meno
var
  FiltroSrc: String;
begin
  Result:=PFiltro = '';
  ErrMsg:='';

  // se il filtro è indicato lo valuta
  if not Result then
  begin
    try
      selFiltro.ClearVariables;
      selFiltro.DeleteVariables;
      selFiltro.SQL.Text:=Format('select count(*) from dual where %s',[PFiltro]);

      FiltroSrc:=PFiltro.ToUpper;

      // ricerca variabili speciali
      // :PROGRESSIVO = progressivo del dipendente
      if R180CercaParolaIntera(':PROGRESSIVO',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        selFiltro.DeclareVariable('PROGRESSIVO',otInteger);
        selFiltro.SetVariable('PROGRESSIVO',ParProgressivo);
        FiltroSrc:=StringReplace(FiltroSrc,':PROGRESSIVO','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // :MATRICOLA = matricola del dipendente
      if R180CercaParolaIntera(':MATRICOLA',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        selFiltro.DeclareVariable('MATRICOLA',otString);
        selFiltro.SetVariable('MATRICOLA',ParMatricola);
        FiltroSrc:=StringReplace(FiltroSrc,':MATRICOLA','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // :NOME_UTENTE = nome utente del dipendente
      if R180CercaParolaIntera(':NOME_UTENTE',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        selFiltro.DeclareVariable('NOME_UTENTE',otString);
        selFiltro.SetVariable('NOME_UTENTE',ParOperatore);
        FiltroSrc:=StringReplace(FiltroSrc,':NOME_UTENTE','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // verifica la presenza di altre variabili
      if Pos(':',FiltroSrc) > 0 then
        ErrMsg:='è stata utilizzata una variabile non prevista.'
      else
      begin
        selFiltro.Execute;
        Result:=selFiltro.FieldAsInteger(0) > 0;
      end;
    except
      on E: Exception do
        ErrMsg:=E.Message;
    end;
  end;
end;

procedure TA118FPubblicazioneDocumentiMW.Clear;
var
  i: Integer;
begin
  for i:=Low(FLivArr) to High(FLivArr) do
  begin
    if FLivArr[i].selFiltro <> nil then
      FreeAndNil(FLivArr[i].selFiltro);
    FreeAndNil(FLivArr[i]);
  end;
  SetLength(FLivArr,0);
end;

function TA118FPubblicazioneDocumentiMW.GetCodice: String;
begin
  Result:=FCodice;
end;

procedure TA118FPubblicazioneDocumentiMW.SetCodice(const Value: String);
var
  Liv: Integer;
  IsLivelloFile: Boolean;
  Ext: String;
  LivObj: TLivello;
begin
  // carica la struttura dati per la tipologia indicata
  if not selI200.SearchRecord('CODICE',Value,[srFromBeginning]) then
    raise Exception.Create('La tipologia selezionata è inesistente!');

  FCodice:=Value;

  // imposta la directory base (se non indicata utilizza la directory predefinita)
  RootDir:=selI200.FieldByName('ROOT').AsString;

  // distrugge la struttura preesistente
  Clear;

  // apre il dataset delle informazioni di dettaglio sui campi
  selI202.Close;
  selI202.Filtered:=False;
  selI202.SetVariable('CODICE',Value);
  selI202.Open;

  // ciclo sui livelli della struttura
  selI201.Close;
  selI201.SetVariable('CODICE',FCodice);
  selI201.Open;
  while not selI201.Eof do
  begin
    // aggiunge il livello alla struttura dati
    Liv:=selI201.FieldByName('LIVELLO').AsInteger;
    IsLivelloFile:=not selI201.FieldByName('EXT').IsNull;
    LivObj:=AddLivello(Liv,
                       selI201.FieldByName('NOME').AsString,
                       selI201.FieldByName('EXT').AsString,
                       selI201.FieldByName('SEPARATORE').AsString,
                       selI201.FieldByName('FILTRO').AsString);

    // filtra la struttura dei campi sul livello attuale
    selI202.Filtered:=False;
    selI202.Filter:=Format('LIVELLO = %d',[Liv]);
    selI202.Filtered:=True;

    // ciclo per impostare la struttura dei campi sul livello
    selI202.First;
    while not selI202.Eof do
    begin
      Ext:=IfThen(IsLivelloFile,LivObj.ExtI201,'');
      LivObj.AddStrutturaCampo(selI202.FieldByName('CAMPO').AsString,
                               selI202.FieldByName('DAL').AsInteger,
                               selI202.FieldByName('LUNG').AsInteger,
                               selI202.FieldByName('VISIBILE').AsString,
                               Ext);
      selI202.Next;
    end;

    // salva il livello massimo delle directory e il livello dei file
    if IsLivelloFile then
      LivFile:=Liv
    else if Liv > LivMaxDir then
      LivMaxDir:=Liv;

    // livello successivo
    selI201.Next;
  end;
end;

function TA118FPubblicazioneDocumentiMW.GetRootDir: String;
begin
  Result:=FRootDir;
end;

procedure TA118FPubblicazioneDocumentiMW.SetRootDir(const Value: String);
var
  PathBaseApplicativi: String;
begin
  if Value.Trim = '' then
  begin
    PathBaseApplicativi:={$IFDEF IRISWEB}
                         GGetWebApplicationThreadVar.ApplicationPath
                         {$ELSE}
                         ExtractFilePath(Application.ExeName)
                         {$ENDIF};
    FRootDir:=PathBaseApplicativi + ROOT_DIR_DEFAULT
  end
  else
  begin
    FRootDir:=Value;
  end;
end;

function TA118FPubblicazioneDocumentiMW.AddLivello(const PLiv: Integer;
  const PNome, PExt, PSeparatore, PFiltro: String): TLivello;
// aggiunge alla struttura i dati del livello PLiv
var
  i: Integer;
begin
  i:=Length(FLivArr);
  SetLength(FLivArr,i + 1);

  // crea un nuovo livello e ne imposta le proprietà
  FLivArr[i]:=TLivello.Create;
  // dati ridondanti.ini
  FLivArr[i].ParOperatore:=ParOperatore;
  FLivArr[i].ParMatricola:=ParMatricola;
  FLivArr[i].ParProgressivo:=ParProgressivo;
  // dati ridondanti.fine
  FLivArr[i].Livello:=PLiv;
  FLivArr[i].NomeI201:=PNome;
  FLivArr[i].ExtI201:=IfThen(PExt = '','',Format('.%s',[PExt]));
  FLivArr[i].SeparatoreI201:=PSeparatore;
  FLivArr[i].FiltroI201:=PFiltro;

  // crea oracle query per valutare il filtro dinamicamente
  if PFiltro <> '' then
  begin
    FLivArr[i].selFiltro:=TOracleQuery.Create(nil);
    FLivArr[i].selFiltro.Session:=SessioneOracle;
    FLivArr[i].selFiltro.ReadBuffer:=2;
    FLivArr[i].selFiltro.SQL.Text:=Format('select count(*) TOT from DUAL where %s',[PFiltro]);
  end;

  Result:=FLivArr[i];
end;

function TA118FPubblicazioneDocumentiMW.GetLivello(const PLiv: Integer): TLivello;
begin
  if (PLiv < Low(FLivArr)) or (PLiv > High(FLivArr)) then
    raise Exception.Create(Format('Livello di directory %d non presente nella struttura',[PLiv]));
  Result:=FLivArr[PLiv];
end;

function TA118FPubblicazioneDocumentiMW.GetValoreCampo(const PCampo: String;
  const PLiv: Integer; const PMatchTipoField: Boolean = True): String;
// estrae il valore del campo indicato partendo dal livello PLiv
// risalendo eventualmente fino al livello 0
// se PMatchTipoField = True
//   risale la struttura fino a dare un valore coerente con il tipo
//   (serve per il campo Mese, che può essere numerico oppure string)
var
  i: Integer;
  C: TCampo;
begin
  for i:=PLiv downto Low(FLivArr) do
  begin
    C:=GetLivello(i).GetCampo(PCampo);
    if C <> nil then
    begin
      if (not PMatchTipoField) or (C.MatchTipoField) then
      begin
        Result:=C.Valore;
        Break;
      end;
    end;
  end;
end;

class function TA118FPubblicazioneDocumentiMW.GetFileName(const PPathCompleto: String): String;
// estrae il solo nome della directory o file (senza path completo)
// esempi:
//   GetDirName('c:\temp\alfa\')            -> alfa
//   GetDirName('d:\database\uno\beta.doc') -> beta.doc
var
  x: Integer;
begin
  Result:=ExcludeTrailingPathDelimiter(PPathCompleto);
  x:=LastDelimiter(System.SysUtils.PathDelim + System.SysUtils.DriveDelim,Result);
  Result:=Result.Substring(x);
end;

class function TA118FPubblicazioneDocumentiMW.IsNomeVariabile(const PNome: String): Boolean;
// restituisce True se il nome indicato rappresenta una variabile
begin
  Result:=PNome.StartsWith(PREFISSO_VAR);
end;


class function TA118FPubblicazioneDocumentiMW.RemovePrefissoVariabile(const PNomeVariabile: String): String;
// restituisce il nome variabile senza il prefisso che lo contraddistingue (":")
begin
  Result:=PNomeVariabile.Substring(PREFISSO_VAR.Length);
end;

{ TLivello }

constructor TLivello.Create;
begin
  inherited;
  SetLength(CampoArr,0);
end;

destructor TLivello.Destroy;
var
  i: Integer;
begin
  if Assigned(selFiltro) then
    FreeAndNil(selFiltro);

  for i:=Low(CampoArr) to High(CampoArr) do
    FreeAndNil(CampoArr[i]);
  SetLength(CampoArr,0);

  inherited;
end;

procedure TLivello.AddStrutturaCampo(const PCampo: String; const PDal,PLung: Integer; const PVisibile, PExt: String);
// aggiunge la descrizione del campo alla struttura dati
var
  i: Integer;
begin
  i:=Length(CampoArr);
  SetLength(CampoArr,i + 1);

  // crea un nuovo oggetto con i dati del campo
  CampoArr[i]:=TCampo.Create;
  // dati ridondanti.ini
  CampoArr[i].ParOperatore:=ParOperatore;
  CampoArr[i].ParMatricola:=ParMatricola;
  CampoArr[i].ParProgressivo:=ParProgressivo;
  // dati ridondanti.fine
  CampoArr[i].Campo:=PCampo;
  CampoArr[i].Dal:=PDal;
  CampoArr[i].Lung:=PLung;
  CampoArr[i].Visibile:=PVisibile;
  CampoArr[i].Ext:=PExt;
end;

function TLivello.GetCampo(const PCampo: String): TCampo;
// estrae il valore del campo indicato
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to High(CampoArr) do
  begin
    if PCampo = CampoArr[i].Campo then
    begin
      Result:=CampoArr[i];
      Break;
    end;
  end;
end;

procedure TLivello.SetNomeFile(const Value: String);
var
  i, Limite: Integer;
  LstNomeFile: TStringList;
  NomePosizionale: Boolean;
begin
  FNomeFile:=Value;

  // se si tratta del livello file (ovvero se è definita l'estensione)
  // divide il nome file nelle due componenti (nome privo di estensione + estensione)
  // per i successivi confronti
  if ExtI201 <> '' then
  begin
    FExtFile:=TPath.GetExtension(FNomeFile);
    FNomeFile:=Copy(FNomeFile,1,Length(FNomeFile) - Length(FExtFile));
  end;

  NomePosizionale:=(SeparatoreI201 = '') and (Length(CampoArr) > 1);
  if NomePosizionale then
  begin
    // divide il nome del file / directory in parti in base a posizione e lunghezza
    for i:=0 to High(CampoArr) do
    begin
      CampoArr[i].Valore:=Copy(FNomeFile,CampoArr[i].Dal,CampoArr[i].Lung);
      CampoArr[i].Valore:=CampoArr[i].Valore.Replace(FILLER_POSIZIONALE,'',[rfReplaceAll]);
    end;
  end
  else
  begin
    // divide il nome del file / directory in parti in base al separatore
    LstNomeFile:=TStringList.Create;
    try
      R180Tokenize(LstNomeFile,FNomeFile,SeparatoreI201);
      // nome directory e struttura devono avere lo stesso numero di parti
      // se questo non avviene imposta comunque il valore per eventuali verifiche
      Limite:=Min(LstNomeFile.Count,Length(CampoArr));
      for i:=0 to Limite - 1 do
        CampoArr[i].Valore:=LstNomeFile[i];
    finally
      FreeAndNil(LstNomeFile);
    end;
  end;
end;

function TLivello.MatchNome(const PTipoTest: TTipoTest; var RErrMatch: String): Boolean;
// restituisce True se il nome del file rispetta formalmente la struttura dei campi
// definita sul livello, in base al parametro per il test
// oppure False altrimenti
// PTipoTest:
//   - ttDipendente:  confronta i campi controllando anche i valori delle variabili
//   - ttSupervisore: confronta i campi non considerando i valori delle variabili
//   - ttFormale:     confronta i campi solo a livello formale (tipo
var
  i: Integer;
begin
  Result:=False;
  RErrMatch:='';

  // controlla la struttura del nome file (verificando i campi da cui è composto)
  for i:=0 to High(CampoArr) do
  begin
    Result:=CampoArr[i].Match(PTipoTest);
    if not Result then
    begin
      RErrMatch:=CampoArr[i].ErrMatch;
      Break;
    end;
  end;

  // se per il livello è definita l'estensione (e quindi si tratta del livello file),
  // ne effettua il controllo
  if Result then
  begin
    if ExtI201 <> '' then
    begin
      Result:=(ExtI201 = ESTENSIONE_QUALSIASI) or
              (ExtI201.ToUpper = FExtFile.ToUpper);
      if not Result then
      begin
        RErrMatch:=Format('estensione file non corretta: "%s"',[FExtFile]);
        Exit;
      end;
    end;
  end;
end;

function TLivello.MatchFiltro(const PTipoTest: TTipoTest): Boolean;
// determina se il filtro indicato sul livello è verificato,
// in base al parametro di test
// PTipoTest =
// - ttDipendente
//   verifica i valori delle variabili
//   verifica che le variabili speciali (PROGRESSIVO, MATRICOLA e NOME_UTENTE) siano afferenti al dipendente selezionato
// - ttSupervisore / - ttFormale
//   verifica esclusivamente il tipo delle variabili
// se il filtro è sintatticamente errato solleva eccezione
var
  i:Integer;
  FiltroSrc: String;
const
  SEPARATORI_TOKEN = ',;()=<>|!/+-*';
begin
  // se il filtro è vuoto allora è ok
  Result:=FiltroI201 = '' ;

  if not Result then
  begin
    try
      selFiltro.ClearVariables;
      selFiltro.DeleteVariables;

      // impostazione variabili
      // 1. ricerca variabili nella stringa del filtro
      FiltroSrc:=FiltroI201.ToUpper;
      for i:=0 to High(CampoArr) do
      begin
        if (CampoArr[i].Variabile) and
           (R180CercaParolaIntera(PREFISSO_VAR + CampoArr[i].Campo,FiltroSrc,SEPARATORI_TOKEN) > 0) then
        begin
          selFiltro.DeclareVariable(CampoArr[i].Campo,CampoArr[i].TipoVariabile);
          selFiltro.SetVariable(CampoArr[i].Campo,CampoArr[i].Valore);
        end;
      end;
      // 2. ricerca variabili speciali
      // :PROGRESSIVO = progressivo del dipendente
      if R180CercaParolaIntera(':PROGRESSIVO',FiltroSrc,SEPARATORI_TOKEN) > 0 then
      begin
        selFiltro.DeclareVariable('PROGRESSIVO',otInteger);
        selFiltro.SetVariable('PROGRESSIVO',ParProgressivo);
      end;

      // :MATRICOLA = matricola del dipendente
      if R180CercaParolaIntera(':MATRICOLA',FiltroSrc,SEPARATORI_TOKEN) > 0 then
      begin
        selFiltro.DeclareVariable('MATRICOLA',otString);
        selFiltro.SetVariable('MATRICOLA',ParMatricola);
      end;

      // :NOME_UTENTE = nome utente del dipendente
      if R180CercaParolaIntera(':NOME_UTENTE',FiltroSrc,SEPARATORI_TOKEN) > 0 then
      begin
        selFiltro.DeclareVariable('NOME_UTENTE',otString);
        selFiltro.SetVariable('NOME_UTENTE',ParOperatore);
      end;

      // esegue il filtro via sql
      selFiltro.Execute;

      // se PTipoTest = ttDipendente verifica che il filtro sia corrispondente
      Result:=(PTipoTest <> ttDipendente) or (selFiltro.FieldAsInteger('TOT') > 0);
    except
      on E: Exception do
        raise Exception.Create(Format('Errore durante esecuzione filtro per il livello %d: %s',[Livello,E.Message]));
    end;
  end;
end;

{ TCampo }

procedure TCampo.SetCampo(const Value: String);
var
  i: Integer;
begin
  FVariabile:=Value.StartsWith(PREFISSO_VAR);
  FCampo:=IfThen(FVariabile,Value.Substring(PREFISSO_VAR.Length).ToUpper,Value);
  // imposta valori di default
  FTipoVariabile:=otString;
  FTipoCampo:=ftString;
  FSizeCampo:=260;
  FRifData:=False;
  if FVariabile then
  begin
    for i:=0 to High(VARIABILI) do
    begin
      if FCampo = VARIABILI[i].Nome then
      begin
        FTipoVariabile:=VARIABILI[i].Tipo;
        FTipoCampo:=VARIABILI[i].TipoCampo;
        FRifData:=VARIABILI[i].RifData;
        if FTipoCampo = ftString then
          FSizeCampo:=IfThen(Lung = 0,260,Lung)
        else
          FSizeCampo:=0;
      end;
    end;
  end;
end;

function TCampo.MatchTipoVariabile: Boolean;
// se il campo è variabile restituisce True se il valore del campo
// è coerente con il tipo della variabile
// se il campo è costante restituisce False
begin
  Result:=Variabile;
  if Result then
  begin
    // verifica che il tipo della variabile sia coerente
    case TipoVariabile of
      otInteger: Result:=TryStrToInt(Valore,FValoreInt);
      otFloat:   Result:=TryStrToFloat(Valore,FValoreFloat);
      otDate:    Result:=TryStrToDate(Valore,FValoreDate);
      otString:  Result:=True;
    else
      Result:=False;
    end;
  end;
end;

function TCampo.MatchTipoField: Boolean;
// se il campo è variabile
//   restituisce True se il valore del campo corrisponde al tipo
//   del campo definito sul dataset
//   oppure False altrimenti
// se il campo è costante
//   restituisce False sempre
var
  TmpInt: Integer;
  TmpDateTime: TDateTime;
begin
  // verifica che il tipo sia coerente con la definizione del campo del dataset
  case FTipoCampo of
    ftInteger:   Result:=TryStrToInt(Valore,TmpInt);
    ftDateTime:  Result:=TryStrToDateTime(Valore,TmpDateTime);
    ftString:    Result:=True;
  else
    Result:=False;
  end;
end;

function TCampo.Match(const PTipoTest: TTipoTest): Boolean;
// determina se il valore indicato per il campo corrisponde
// a quanto definito a livello di struttura
// se campo variabile:
//   - verifica che il tipo sia coerente
//   - per le variabili speciali verifica il dominio (es. ANNO, MESE)
//   - se PTipoTest = ttDipendente
//     -> verifica che le variabili PROGRESSIVO, MATRICOLA e NOME_UTENTE siano afferenti al dipendente selezionato
// se campo costante:
//   - verifica che il valore sia uguale (confronto case-insensitive)
var
  MIni, GIni, i: Integer;
  A, M, G, OldCampo, OldValore, ValoreCfr, TipoStr: String;
begin
  ErrMatch:='';
  if Variabile then
  begin
    // verifica che il tipo della variabile sia coerente
    Result:=MatchTipoVariabile;

    // il campo mese è trattato in modo particolare (ammette valori integer, oppure string)
    if (not Result) and (Campo <> VAR_MESE) then
    begin
      // verifica che il tipo della variabile sia coerente
      case TipoVariabile of
        otInteger: TipoStr:=' intero';
        otFloat:   TipoStr:=' numerico';
        otDate:    TipoStr:='a data';
        otString:  TipoStr:='a stringa';
      else
        TipoStr:='non definito';
      end;
      ErrMatch:=Format('tipo errato, mi aspettavo un%s',[TipoStr]);
    end
    else
    begin
      // tipo ok: verifica il dominio
      if Campo = VAR_ANNO then
      begin
        // anno
        // valore intero 1900 <= x <= 3999
        Result:=R180Between(FValoreInt,Low(TAnnoInt),High(TAnnoInt));
        if not Result then
          ErrMatch:=Format('valore fuori dal range previsto [%d - %d]',[Low(TAnnoInt),High(TAnnoInt)]);
      end
      else if Campo = VAR_MESE then
      begin
        // mese:
        // valore intero 1 <= x <= 12
        if Result then
        begin
          Result:=R180Between(FValoreInt,Low(TMeseInt),High(TMeseInt));
          if not Result then
            ErrMatch:=Format('valore fuori dal range previsto [%d - %d]',[Low(TMeseInt),High(TMeseInt)]);
        end
        else
        begin
          ValoreCfr:=Valore.ToUpper;
          // nome del mese in formato lungo: gennaio, febbraio, marzo, ...
          for i:=1 to High({$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames) do
          begin
            if ValoreCfr = {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[i].ToUpper then
            begin
              Result:=True;
              Break;
            end;
          end;
          if not Result then
          begin
            // nome del mese in formato corto: gen, feb, mar, ...
            for i:=1 to High({$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames) do
            begin
              if ValoreCfr = {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[i].ToUpper then
              begin
                Result:=True;
                Break;
              end;
            end;
          end;
          if not Result then
            ErrMatch:='mese non valido';
        end;
      end
      else if Campo = VAR_GIORNO then
      begin
        // giorno
        // valore intero 1 <= x <= 31 (il mese non è noto)
        Result:=R180Between(FValoreInt,Low(TGiornoInt),High(TGiornoInt));
        if not Result then
          ErrMatch:=Format('valore fuori dal range previsto [%d - %d]',[Low(TGiornoInt),High(TGiornoInt)]);
      end
      else if Campo = VAR_DATA then
      begin
        // data
        // valore data in un formato predefinito: yyyymmgg oppure yyyy-mm-gg
        Result:=(Valore.Length = 10) or (Valore.Length = 8);
        if Result then
        begin
          MIni:=IfThen(Valore.Length = 10,6,5);
          GIni:=IfThen(Valore.Length = 10,9,7);

          // separa le informazioni di giorno, mese e anno
          A:=Copy(Valore,1,4);
          M:=Copy(Valore,MIni,2);
          G:=Copy(Valore,GIni,2);

          OldCampo:=Campo;
          OldValore:=Valore;

          // controllo anno
          Campo:=VAR_ANNO;
          Valore:=A;
          Result:=Result and Match(PTipoTest);

          // controllo mese
          if Result then
          begin
            Campo:=VAR_MESE;
            Valore:=M;
            Result:=Result and Match(PTipoTest);
          end;

          // controllo giorno
          if Result then
          begin
            Campo:=VAR_GIORNO;
            Valore:=G;
            Result:=Result and Match(PTipoTest);
          end;

          Campo:=OldCampo;
          Valore:=OldValore;
        end;
      end
      else if Campo = VAR_CODFISCALE then
      begin
        // codice fiscale: 16 caratteri
        Result:=Valore.Length = LUNGHEZZA_CODFISCALE;
        if not Result then
          ErrMatch:=Format('valore di lunghezza errata, deve essere di %d caratteri',[LUNGHEZZA_CODFISCALE]);
      end
      else if Campo = VAR_PROGRESSIVO then
      begin
        // progressivo
        // controllo effettuato solo per tipo test dipendente
        // valore fisso = progressivo del dipendente
        Result:=(PTipoTest <> ttDipendente) or (FValoreInt = ParProgressivo);
        if not Result then
          ErrMatch:='valore non corrispondente';
      end
      else if Campo = VAR_MATRICOLA then
      begin
        // matricola
        // controllo effettuato solo per tipo test dipendente
        // valore fisso = matricola del dipendente
        Result:=(PTipoTest <> ttDipendente) or (Valore = ParMatricola);
        if not Result then
          ErrMatch:='valore non corrispondente';
      end
      else if Campo = VAR_NOME_UTENTE then
      begin
        // nome_utente
        // controllo effettuato solo per tipo test dipendente
        // valore fisso = nome_utente del dipendente
        Result:=(PTipoTest <> ttDipendente) or (Valore = ParOperatore);
        if not Result then
          ErrMatch:='valore non corrispondente';
      end
      else if Campo = VAR_FILLER then
      begin
        // filler
        // valore qualsiasi
        Result:=True;
      end
      else
      begin
        // variabile non riconosciuta
        // valore qualsiasi
        Result:=True;
      end;
    end
  end
  else
  begin
    // campo costante
    Result:=Campo.ToUpper = Valore.ToUpper;
    if not Result then
      ErrMatch:='valore costante differente';
  end;

  // imposta stringa errore
  if not Result then
  begin
    if Variabile then
      ErrMatch:=Format('variabile %s = %s (%s)',[Campo,Valore,ErrMatch])
    else
      ErrMatch:=Format('%s (token: %s, valore richiesto: %s)',[ErrMatch,Valore,Campo]);
  end;
end;

end.

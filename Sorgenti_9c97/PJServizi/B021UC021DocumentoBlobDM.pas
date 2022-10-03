unit B021UC021DocumentoBlobDM;

interface

uses
  DBXJSON,
  System.JSON,
  C180FunzioniGenerali,
  B021UIrisRestSvcDM,
  B021UUtils,
  R014URestDM,
  SysUtils,
  IOUtils,
  Classes,
  Oracle;

type
  TDocumento = class(TPersistent)
  private
    Path: String;
    FileBase64: String;
    ID: Integer;
    NomeFile: String;
    Size: Integer;
  end;

  TB021FC021DocumentoBlobDM = class(TR014FRestDM)
  private
    // variabili che memorizzano i parametri passati
    FPath: String;
    FFileName: String;
    FJson: String;
    function GetDocumentoBlob(PPath: String; PFileName: String):TJSONObject;
    function SaveDocumentoBlob(Json: String):TJSONObject;
    function DeleteDocumentoBlob(Path: String; PFileName: String):TJSONObject;
    procedure LeggiInputJson(InputString: String; Documento: TDocumento);
  protected
    function ConvertJSON(DocPersistent: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
    function AcceptDato: TJSONObject; override;
    function CancelDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FC021DocumentoBlobDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  Result:=True;
  if Operazione = 'R' then
  begin
    try
      FPath:=GetParam('Path');
      FFileName:=GetParam('FileName');
    except
      RErrMsg:='Errore nel recupero dei parametri';
      Result:=False;
    end;
  end
  else if Operazione = 'C' then
  begin
    try
      FJson:=GetParam('Json');
    except
      RErrMsg:='Errore nel recupero dei parametri';
      Result:=False;
    end;
  end
  else if Operazione = 'D' then
  begin
    try
      FPath:=GetParam('Path');
      FFileName:=GetParam('FileName');
    except
      RErrMsg:='Errore nel recupero dei parametri';
      Result:=False;
    end;
  end;
end;

function TB021FC021DocumentoBlobDM.GetDato: TJSONObject;
begin
  Result:=GetDocumentoBlob(FPath,FFileName);
end;

function TB021FC021DocumentoBlobDM.GetDocumentoBlob(PPath: String; PFileName: String): TJSONObject;
var
  Documento: TDocumento;
begin
  Documento:=TDocumento.Create;
  try
    Documento.Path:=PPath;
    if not TryStrToInt(PFileName,Documento.ID) then
      Documento.NomeFile:=PFileName;
    Documento.FileBase64:=R180EncodeFileB64(TPath.Combine(PPath,PFileName));
    Documento.Size:=Length(Documento.FileBase64);
    Result:=ConvertJSON(Documento);
  finally
    FreeAndNil(Documento);
  end;
end;

function TB021FC021DocumentoBlobDM.ConvertJSON(DocPersistent: TPersistent): TJSONObject;
var
  Documento: TDocumento;
begin
  if not Assigned(DocPersistent) then
  begin
    Result:=nil;
    Exit;
  end;

  Documento:=TDocumento(DocPersistent);
  Result:=TJSONObject.Create;
  // crea le coppie chiave-valore del json
  Result.AddPair('Path',TJsonString.Create(Documento.Path.Replace('\','\\',[rfReplaceAll]))); // backslash è un carattere di controllo in json, occorre raddoppiarlo
  Result.AddPair('ID',TJsonNumber.Create(Documento.ID));
  Result.AddPair('NomeFile',TJsonString.Create(Documento.NomeFile));
  Result.AddPair('Size',TJsonNumber.Create(Documento.Size));
  Result.AddPair('FileBase64',TJsonString.Create(Documento.FileBase64));
end;

function TB021FC021DocumentoBlobDM.AcceptDato: TJSONObject;
begin
  Result:=SaveDocumentoBlob(FJson);
end;

function TB021FC021DocumentoBlobDM.SaveDocumentoBlob(Json: String): TJSONObject;
var
  Documento: TDocumento;
  LFileName: string;
begin
  Documento:=TDocumento.Create;
  try
    // memorizzazione del json utile all'interno di Documento
    LeggiInputJson(Json, Documento);

    // compone il nome del file completo del percorso
    LFileName:=TPath.Combine(Documento.Path,Documento.ID.ToString);

    // se il file esiste già solleva eccezione
    if TFile.Exists(LFileName) then
      raise EB021DuplicateDocument.Create(Format('Il documento con ID %d è già presente in archivio!',[Documento.ID]));

    // salvataggio del file nel path specificato
    R180DecodeFileB64(Documento.FileBase64,LFileName);

    Result:=nil;
  finally
    FreeAndNil(Documento);
  end;
end;

procedure TB021FC021DocumentoBlobDM.LeggiInputJson(InputString: String; Documento: TDocumento);
var
  InputJson: TJSONObject;
begin
  InputString:=InputString.Replace('\', '\\', [rfReplaceAll]);  // backslash è un carattere di controllo in json, occorre raddoppiarlo
  // conversione da stringa a json
  InputJson:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(InputString),0) as TJSONObject;
  try
    try
      // estrazione dei valori
      Documento.Path:=InputJson.Get('Path').JsonValue.Value;
      if (Documento.Path <> '') and (Documento.Path.Chars[Documento.Path.Length - 1] <> '\') then
        Documento.Path:=Documento.Path + '\';
      Documento.ID:=InputJson.Get('ID').JsonValue.Value.ToInteger;
      Documento.Size:=InputJson.Get('Size').JsonValue.Value.ToInteger;
      Documento.FileBase64:=InputJson.Get('FileBase64').JsonValue.Value;
    except
      raise Exception.Create('Errore nel recupero dei dati JSON');
    end;
  finally
    FreeAndNil(InputJson);
  end;
  // controllo: la dimensione di partenza deve essere la stessa di quella di arrivo
  if Length(Documento.FileBase64) <> Documento.Size then
    raise Exception.Create('La dimensione di arrivo del file non corrisponde con quella di partenza');
end;

function TB021FC021DocumentoBlobDM.CancelDato: TJSONObject;
begin
  Result:=DeleteDocumentoBlob(FPath,FFileName);
end;

function TB021FC021DocumentoBlobDM.DeleteDocumentoBlob(Path: String; PFileName: String): TJSONObject;
var
  LFilePath: String;
begin
  LFilePath:=TPath.Combine(Path,PFileName);
  if TFile.Exists(LFilePath) then
    TFile.Delete(LFilePath);

  Result:=nil;
end;

end.

unit B021UC021DocumentoBlobTicketDM;

interface

uses
  DBXJSON,
  System.JSON,
  C180FunzioniGenerali,
  B021UIrisRestSvcDM,
  B021UUtils,
  R014URestDM,
  A000UCostanti,
  C021UDocumentiManagerDM,
  SysUtils,
  IOUtils,
  Classes,
  Oracle;

type
  TB021FC021DocumentoBlobTicketDM = class(TR014FRestDM)
  private
    // variabili che memorizzano i parametri passati
    FId: Integer;
    FJson: String;
    function GetDocumentoBlobTicket(FId: Integer):TJSONObject;
  protected
    function ConvertJSON(DocPersistent: TDocumento): TJSONObject;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FC021DocumentoBlobTicketDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  Result:=True;
  if Operazione = 'R' then
  begin
    try
      FId:=StrToInt(GetParam('Id'));
    except
      RErrMsg:='Errore nel recupero dei parametri';
      Result:=False;
    end;
  end;
end;

function TB021FC021DocumentoBlobTicketDM.GetDato: TJSONObject;
begin
  Result:=GetDocumentoBlobTicket(FId);
end;

function TB021FC021DocumentoBlobTicketDM.GetDocumentoBlobTicket(FId: Integer): TJSONObject;
var
  Documento: TDocumento;
  LResCtrl: TResCtrl;
  C021DM: TC021FDocumentiManagerDM;
begin
  C021DM:=TC021FDocumentiManagerDM.Create(Self);
  Documento:=TDocumento.Create;
  try
    // estrae il file con i metadati associati
    LResCtrl:=C021DM.DownloadFromDocumentale(FId,Documento);
    if not LResCtrl.Ok then
      raise Exception.Create(LResCtrl.Messaggio);
    //aggiunge il ticket nel pdf se presente lo script sql associato alla tipologia
    LResCtrl:=C021DM.AggiungiTicketPdf(Documento);
    if not LResCtrl.Ok then
      raise Exception.Create(LResCtrl.Messaggio);

    Documento.FileBase64:=R180EncodeFileB64(Documento.FilePath);
    Documento.Dimensione:=Length(Documento.FileBase64);
    Result:=ConvertJSON(Documento);
  finally
    FreeAndNil(Documento);
    FreeAndNil(C021DM);
  end;
end;

function TB021FC021DocumentoBlobTicketDM.ConvertJSON(DocPersistent: TDocumento): TJSONObject;
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
  Result.AddPair('Path',TJsonString.Create(Documento.PathStorage.Replace('\','\\',[rfReplaceAll]))); // backslash è un carattere di controllo in json, occorre raddoppiarlo
  Result.AddPair('ID',TJsonNumber.Create(Documento.ID));
  Result.AddPair('NomeFile',TJsonString.Create(Documento.NomeFile));
  Result.AddPair('Size',TJsonNumber.Create(Documento.Dimensione));
  Result.AddPair('FileBase64',TJsonString.Create(Documento.FileBase64));
end;

end.

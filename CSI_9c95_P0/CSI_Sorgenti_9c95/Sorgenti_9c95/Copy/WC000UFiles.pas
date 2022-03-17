unit WC000UFiles;

interface

uses
  Classes, SysUtils, HttpApp, IW.Content.Base, IWApplication, IW.Common.System,
  XMLIntf, XMLDoc, IWGlobal, IW.Http.Request, IW.Http.Reply, ActiveX, DateUtils,
  A000UCostanti, System.SyncObjs, System.Contnrs, IOUtils;

type
  TIWURLFilesResponder = class(TContentBase)
  private
    lstFileHtml: TStringList;
    function GetErrorResult(E: Exception): string;
    function GetRisultato(AResponse: THttpReply; AParams:TStrings): Boolean;
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

const
  URL_PATH   = 'Files/help';
  //HTML_FILE  = 'err_limitesessioni.html';
  BOOKMARK_META_REFRESH   = '{%META_REFRESH%}';
  META_REFRESH            = '<meta http-equiv="refresh" content="10;URL=%s">';

implementation

uses
  A000UInterfaccia, IWMimeTypes;

constructor TIWURLFilesResponder.Create;
begin
  inherited;
  lstFileHtml:=TStringList.Create;
  FileMustExist:=False;
  CanStartSession:=True;
  //RequiresSessionStart:=False;
end;

destructor TIWURLFilesResponder.Destroy;
begin
  FreeAndNil(lstFileHtml);
  inherited;
end;

function TIWURLFilesResponder.GetRisultato(AResponse: THttpReply; AParams:TStrings): Boolean;
var
  ErrFile, Html, UrlRedirect, MetaRefresh: String;
begin
  try
    ErrFile:=IncludeTrailingPathDelimiter(gsAppPath) + AParams[0];//HTML_FILE;
    if not TFile.Exists(ErrFile) then
      raise Exception.Create(Format('Il file %s non è stato trovato!',[AParams[0]]));

    // carica in memoria il file statico da visualizzare
    lstFileHtml.LoadFromFile(ErrFile);

    // determina url per redirect
    UrlRedirect:=W000ParConfig.UrlSuperoMaxSessioni.Trim;

    if UrlRedirect = '' then
    begin
      // nessun metatag di refresh
      MetaRefresh:='';
    end
    else
    begin
      // prepara il metatag di refresh
      MetaRefresh:=Format(META_REFRESH,[UrlRedirect]);
    end;

    // sostituzione variabili nel file

    // 1. metatag per redirect
    if lstFileHtml.Text.Contains(BOOKMARK_META_REFRESH) then
      lstFileHtml.Text:=lstFileHtml.Text.Replace(BOOKMARK_META_REFRESH,MetaRefresh,[rfIgnoreCase]);

    Html:=lstFileHtml.Text;
  except
    on E: Exception do
    begin
      Html:='Attenzione!Si è verificato un errore:'#13#10 +
            E.Message + #13#10 +
            E.ClassName;
    end;
  end;
  AResponse.ContentType:= 'text/html';
  AResponse.WriteString(Html);
  Result:=True;
end;

function TIWURLFilesResponder.GetErrorResult(E: Exception): string;
begin
  Result:=URL_RESPONDER_ERROR_RESP + E.ClassName + ': ' + E.Message;
end;

function TIWURLFilesResponder.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
begin
  Result:= True;
  aReply.ContentType:=MIME_HTML;
  try
    Result:=GetRisultato(aReply,aParams);
  except
    on E:Exception do
      aReply.WriteString(GetErrorResult(E));
  end;
end;

initialization

finalization

end.
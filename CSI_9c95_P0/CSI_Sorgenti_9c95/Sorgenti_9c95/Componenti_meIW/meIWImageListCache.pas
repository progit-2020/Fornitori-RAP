unit meIWImageListCache;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  IWImageList, Vcl.Graphics, IWMimeTypes, IW.CacheStream;

type
  TmeImmagineCache = record
    PercorsoOriginale: String;
    TipoMIME: String;
    URLCache: String;
  end;

  TmeIWImageListCache = class(TIWImageList)
  private
    ImmaginiCache: array of TmeImmagineCache;
  protected
    function GetCount: Integer; override;
  public
    // Per non creare confusione, inibiamo l'azione dei metodi ereditati da TCustomImageList
    constructor Create(AOwner: TComponent); override;
    constructor CreateSize(AWidth, AHeight: Integer);
    function Add(Image, Mask: TBitmap): Integer;
    function AddIcon(Image: TIcon): Integer;
    function AddImage(Value: TCustomImageList; Index: Integer): Integer;
    procedure AddImages(Value: TCustomImageList);
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    function GetBitmap(Index: Integer; Image: TBitmap): Boolean;
    procedure GetIcon(Index: Integer; Image: TIcon); overload;
    procedure GetIcon(Index: Integer; Image: TIcon; ADrawingStyle: TDrawingStyle;
      AImageType: TImageType); overload;
    procedure Insert(Index: Integer; Image, Mask: TBitmap);
    procedure InsertIcon(Index: Integer; Image: TIcon);
    procedure InsertMasked(Index: Integer; Image: TBitmap; MaskColor: TColor);
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Replace(Index: Integer; Image, Mask: TBitmap);
    procedure ReplaceIcon(Index: Integer; Image: TIcon);
    // Metodi nuovi
    procedure MedpAggiungi(const PFilePath:String; const PMimeType:String = MIME_PNG);
    function ExtractImageToCache(aImageIndex: Integer; const ACacheType: TCacheType = ctOneTime): string; override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

resourcestring
  MSG_NON_USARE='Il metodo TmeIWImageListCache.%s() NON deve essere utilizzato.' + #10#13 +
                'Fare riferimento al Wiki MEDP per maggiori informazioni.';
  MSG_FILE_NON_TROVATO='Impossibile aggiungere %s alla ImageListCache. File non trovato.';

implementation

uses IWForm,IWApplication,IWAppCache;

function TmeIWImageListCache.GetCount: Integer;
begin
  Result:=Length(ImmaginiCache);
end;

constructor TmeIWImageListCache.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(ImmaginiCache,0);
end;

constructor TmeIWImageListCache.CreateSize(AWidth, AHeight: Integer);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['CreateSize']));
end;

function  TmeIWImageListCache.Add(Image, Mask: TBitmap): Integer;
begin
  raise Exception.Create(Format(MSG_NON_USARE,['Add']));
end;

function  TmeIWImageListCache.AddIcon(Image: TIcon): Integer;
begin
  raise Exception.Create(Format(MSG_NON_USARE,['AddIcon']));
end;

function  TmeIWImageListCache.AddImage(Value: TCustomImageList; Index: Integer): Integer;
begin
  raise Exception.Create(Format(MSG_NON_USARE,['AddImage']));
end;

procedure TmeIWImageListCache.AddImages(Value: TCustomImageList);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['AddImages']));
end;

function  TmeIWImageListCache.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  raise Exception.Create(Format(MSG_NON_USARE,['AddMasked']));
end;

procedure TmeIWImageListCache.Clear;
begin
  SetLength(ImmaginiCache,0);
end;

procedure TmeIWImageListCache.Delete(Index: Integer);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['Delete']));
end;

function  TmeIWImageListCache.GetBitmap(Index: Integer; Image: TBitmap): Boolean;
begin
  raise Exception.Create(Format(MSG_NON_USARE,['GetBitmap']));
end;

procedure TmeIWImageListCache.GetIcon(Index: Integer; Image: TIcon);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['GetIcon']));
end;

procedure TmeIWImageListCache.GetIcon(Index: Integer; Image: TIcon; ADrawingStyle: TDrawingStyle; AImageType: TImageType);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['GetIcon']));
end;

procedure TmeIWImageListCache.Insert(Index: Integer; Image, Mask: TBitmap);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['Insert']));
end;

procedure TmeIWImageListCache.InsertIcon(Index: Integer; Image: TIcon);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['InsertIcon']));
end;

procedure TmeIWImageListCache.InsertMasked(Index: Integer; Image: TBitmap; MaskColor: TColor);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['InsertMasked']));
end;

procedure TmeIWImageListCache.Move(CurIndex, NewIndex: Integer);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['Move']));
end;

procedure TmeIWImageListCache.Replace(Index: Integer; Image, Mask: TBitmap);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['Replace']));
end;

procedure TmeIWImageListCache.ReplaceIcon(Index: Integer; Image: TIcon);
begin
  raise Exception.Create(Format(MSG_NON_USARE,['ReplaceIcon']));
end;

procedure TmeIWImageListCache.MedpAggiungi(const PFilePath:String; const PMimeType:String = MIME_PNG);
var
  NuovaImmagineCache:TmeImmagineCache;
begin
  if FileExists(PFilePath) then
  begin
    NuovaImmagineCache.PercorsoOriginale:=PFilePath;
    NuovaImmagineCache.TipoMIME:=PMimeType;
    NuovaImmagineCache.URLCache:='';
    SetLength(ImmaginiCache,Length(ImmaginiCache) + 1);
    ImmaginiCache[Length(ImmaginiCache) - 1]:=NuovaImmagineCache;
  end
  else
    raise Exception.Create(Format(MSG_FILE_NON_TROVATO,[PFilePath]));
end;

{ TIWImageList.ExtractImageToCache() estrae l'immagine bitmap dalla lista interna all'indice aImageIndex
  e con TIWAppCache.GraphicToCacheFile() la copia in cache utilizzando come meccanismo predefinito di cache
  ctOneTime (copia in cache globale dell'applicazione, alla prima richiesta da parte del client il file in
  cache viene cancellato). Viene mantenuta eventualmente una lista interna con gli URL per i file già in cache,
  in tal caso il cache type viene modificato in ctForm e il cache owner diventa un form - a meno che l'owner
  non sia un oggetto di tipo diverso, in questo caso l'owner diventa la sessione e il tipo cache ctSession.
  Nel primo caso: i file cache restano su disco fino alla distruzione della form. Nel secondo della sessione.
  Questa versione modificata:
    - copia il file immagine direttamente dal file system nella directory della cache
      con owner uguale alla sessione (inutile, ma anche se sulle API c'è scritto che questo parametro può essere nil c'è un controllo esplicito che lo vieta) e tipo
      cache ctApp: i file resteranno fisicamente in cache per tutta l'esecuzione dell'applicazione (no
      cancellazione fisica dopo richiesta)
    - se il file di destinazione nella cache esiste già (è <nome_e_estensione_file_originale>.tmp) il file NON
      viene sovrascritto (ci pensa TIWAppCache.AddFileToCache()). Se quindi il file cambia dopo la prima estrazione
      bisogna riavviare il server;
    - viene mantenuta una lista che evita di richiamare TIWAppCache.AddFileToCache() se conosciamo già l'URL
      del file in cache (quindi è già stato copiato).
}

function TmeIWImageListCache.ExtractImageToCache(aImageIndex: Integer; const ACacheType: TCacheType = ctOneTime): string;
var
  xCacheOwner: TObject;
  xCacheType: TCacheType;
  Idx1,Idx2: Integer;
begin
  Result:='';
  xCacheOwner:=GGetWebApplicationThreadVar;
  if (Count > 0) and (AImageIndex > -1) and (AImageIndex < Count) and Assigned(xCacheOwner) then begin
    // Recupero l'URL nella nostra lista interna
    Result:=ImmaginiCache[AImageIndex].URLCache;
    if (FileExists(ImmaginiCache[AImageIndex].PercorsoOriginale)) and (Result <> '') then
    begin
      // Il file è presente in cache. Result contiene già l'URL con cui raggiungerlo
      Exit;
    end;
    // Copio l'immagine in cache, specificando che deve essere mantenuta fino a che non viene
    // arrestato il server. Mi viene ritornato l'URL della risorsa. Aggiorno il record relativo
    // e ritorno l'URL. Se un file con lo stesso nome era già stato copiato in cache da un
    // altro TmeIWImageListCache instanziato, TIWAppCache.AddFileToCache() recupera semplicemente
    // l'URL relativo. In caso contrario, copia il file originale in cache aggiungendo il suffisso .tmp
    // e lo aggiunge al cache manager.
    xCacheType:=ctApp;
    ImmaginiCache[AImageIndex].URLCache:=TIWAppCache.AddFileToCache(xCacheOwner,ImmaginiCache[AImageIndex].PercorsoOriginale,
                                                                    ImmaginiCache[AImageIndex].TipoMIME,xCacheType);
    Idx2:=Pos('/$/',ImmaginiCache[AImageIndex].URLCache);
    Idx1:=Idx2 - 1;
    while (Idx1 > 0) and (ImmaginiCache[AImageIndex].URLCache[Idx1] <> '/') do
    begin
      dec(Idx1);
    end;
    if (Idx1 > 0) and (ImmaginiCache[AImageIndex].URLCache[Idx1] = '/') then
      ImmaginiCache[AImageIndex].URLCache:=Copy(ImmaginiCache[AImageIndex].URLCache,1,Idx1 - 1) + Copy(ImmaginiCache[AImageIndex].URLCache,Idx2,Length(ImmaginiCache[AImageIndex].URLCache));
    Result:=ImmaginiCache[AImageIndex].URLCache;
  end;
end;

destructor TmeIWImageListCache.Destroy;
begin
  SetLength(ImmaginiCache,0);
  inherited;
end;

end.

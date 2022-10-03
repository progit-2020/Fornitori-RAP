unit A052UParCarMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW,
  System.Generics.Defaults, System.Generics.Collections, Data.DB, OracleData,
  C180FunzioniGenerali, A000USessione,A000UInterfaccia, USelI010, A027UCostanti,
  Vcl.Graphics;

type
  TFontProperties = class
  const
     PH_COLOR: String = '[C]';
     PH_NAME:  String = '[F]';
     PH_SIZE:  String = '[S]';
     PH_STYLE: String = '[ST]';
  private
    FColor: Integer;
    FName: String;
    FSize: Integer;
    FBold: boolean;
    FItalic: boolean;
    FUnderline : boolean;
    FStrikeOut: boolean;
    procedure ReadStyle(Style: String);
  public
    function CaricaDaDB(sezione:String; Valori: String): String;
    function ToDBString:String;
    function getStyle: String;
    property Color: Integer read FColor write FColor;
    property Name: String read FName write FName;
    property Size: Integer read FSize write FSize;
    property Bold: boolean read FBold write FBold;
    property Italic: boolean read FItalic write FItalic;
    property Underline : boolean read FUnderline write FUnderline;
    property StrikeOut: boolean read FStrikeOut write FStrikeOut;
  end;

  TLabelProperties = class
  const
    PH_NAME:    String = '[N]';
    PH_CAPTION: String = '[C]';
    PH_TOP:     String = '[T]';
    PH_LEFT:    String = '[L]';
    PH_HEIGHT:  String = '[H]';
    PH_WIDTH:   String = '[W]';
    PH_TAG:     String = '[G]';
  private
    FName: String;
    FUniqueName: String;
    FCaption: String;
    FTop: Integer;
    FLeft: Integer;
    FHeight: Integer;
    FWidth: Integer;
    FTag: Integer;
  public
    function CaricaDaDB(sezione:String; Valori: String): String;
    function ToDBString: String;
    property Name: String read FName write FName;
    property UniqueName: String read FUniqueName write FUniqueName;
    property Caption: String read FCaption write FCaption;
    property Top: Integer read FTop write FTop;
    property Left: Integer read FLeft write FLeft;
    property Height: Integer read FHeight write FHeight;
    property Width: Integer read FWidth write FWidth;
    property Tag: Integer read FTag write FTag;
  end;

  TSezione = class
  const
    INTESTAZIONE  = 'Intestazione';
    DETTAGLIO     = 'Dettaglio';
    RIEPILOGO     = 'Riepilogo';
    ELENCO_SEZIONI : array[0..2] of String = (INTESTAZIONE,DETTAGLIO,RIEPILOGO);
    TAG_MULTIPLI : array[0..2] of Integer = (1000,2000,2001);
    DEFLEFT = 7;
  public
    Name: String;
    FontProperties: TFontProperties;
    LstLabels: TList<TLabelProperties>;
    function getDefWidth: Integer;
    function getDefHeight: Integer;
    function SettaWidth(W:Integer; S:String ): Integer;
    function GotoNearestX(X: Integer) : Integer;
    function GotoNearestY(Y: Integer) : Integer;
    function Carica(sezione:String; lstValoriDB: TStringList): TStringList;
    function Salva(sezione:String):TStringList;
    procedure CreaNomeUnivocoLabel(labelProperties: TLabelProperties);
    function getLabel(UnName:String):TLabelProperties;
    procedure addLabel(labelProperties: TLabelProperties);
    procedure removeLabel(UnName:String);
    procedure removeAllLabels;
    constructor Create(s: String); overload;
    destructor Destroy; override;
  end;

  TA052FParCarMW = class(TR005FDataModuleMW)
    selT951: TOracleDataSet;
    DI010: TDataSource;
    selT265: TOracleDataSet;
    selT275: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSelT950_Funzioni: TOracleDataset;
    VecchioCodiceDizionario: String;
    function CaricaImpostazioni: TStringList;
    procedure RemoveSezione(sezione: String);
  public
    dicSezioni: TDictionary<String,TSezione>;
    selI010:TselI010;
    function EnableGiorniMese(Tag: Integer): Boolean;
    function EnableGiustificativi(Tag: Integer): Boolean;
    function EnableTimbrature(Tag: Integer): Boolean;
    function EnableTurno(Tag: Integer): Boolean;
    function EnableTotali(Tag: Integer): Boolean;
    function CausaliDaVisualizzare(Tag:Integer): Boolean;
    function GetCheckedTotali(Tag:Integer): Boolean;
    function GetTagTotali(checked:Boolean; Tag:Integer): Integer;
    function GetItemIndexTurno(Tag:Integer): Integer;
    function GetTagTurno(ItemIndex: Integer): Integer;
    function GetItemIndexCausale(Tag:Integer): Integer;
    function GetTagCausale(ItemIndex: Integer): Integer;
    function GetItemIndexGiustificativi(Tag:Integer): Integer;
    function GetTagGiustificativi(ItemIndex:Integer): Integer;
    function GetCheckedOrologio(Tag:Integer): Boolean;
    function GetTagOrologio(checked:Boolean; Tag:Integer): Integer;
    function HasProprieta(Tag:Integer): Boolean;
    function SelT950Filter: boolean;
    procedure selT950BeforeDelete;
    procedure selT950AfterDelete;
    procedure selT950BeforePost;
    procedure selT950AfterPost;
    procedure ResetDictSezioni;
    procedure SalvaSezioni;
    function CreaLabelIntestazione(X, Y: Integer): TLabelProperties;
    function CreaLabelDettaglio(DatoDett:TDett; X, Y: Integer): TLabelProperties;
    function CreaLabelRiepilogo(DatoRiep:TRiep; X, Y: Integer): TLabelProperties;
    function SelT950AfterScroll: TStringList;
    property SelT950_Funzioni: TOracleDataset read FSelT950_Funzioni write FSelT950_Funzioni;
  end;

implementation

uses
  System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TLabelProperties }
function TLabelProperties.CaricaDaDB(sezione:String; Valori: String): String;
var App: String;
begin
  Result:='';
  //Leggo il Nome della labels
  if not R180Getvalore(Valori,PH_NAME,PH_CAPTION,FName) then
  begin
    Result:=sezione + ':La label non è completa (Nome)';
    Exit;
  end;

  if not R180Getvalore(Valori,PH_CAPTION,PH_TOP,FCaption) then
  begin
    Result:=sezione + ':La label non è completa (Caption)';
    Exit;
  end;
  if not R180Getvalore(Valori,PH_TOP,PH_LEFT,App) then
  begin
    Result:=sezione + ':La label non è completa (Top)';
    Exit;
  end;
  FTop:=App.ToInteger;

  if not R180Getvalore(Valori,PH_LEFT,PH_HEIGHT,App) then
  begin
    Result:=sezione + ':La label non è completa (Left)';
    Exit;
  end;
  FLeft:=App.ToInteger;

  if not R180Getvalore(Valori,PH_HEIGHT,PH_WIDTH,App) then
  begin
    Result:=sezione + ':La label non è completa (Altezza)';
    Exit;
  end;
  FHeight:=App.ToInteger;

  if not R180Getvalore(Valori,PH_WIDTH,PH_TAG,App) then
  begin
    Result:=sezione + ':La label non è completa (Larghezza)';
    exit;
  end;
  FWidth:=App.ToInteger;

  if not R180Getvalore(Valori,PH_TAG,'',App) then
    FTag:=0;
  FTag:=App.ToInteger;
end;

function TLabelProperties.ToDBString: String;
begin
  Result:='[N]' + FName +
          '[C]' + FCaption +
          '[T]' + FTop.ToString +
          '[L]' + FLeft.ToString +
          '[H]' + FHeight.ToString +
          '[W]' + FWidth.ToString +
          '[G]' + FTag.ToString;
end;

{ TFontProperties }

function TFontProperties.CaricaDaDB(sezione:String; Valori: String): String;
var App: String;
begin
  Result:='';
  //Impostazioni del Font
  //Leggo il colore del Font
  if not R180GetValore(Valori,PH_COLOR,PH_NAME,App) then
  begin
    Result:=sezione + ':Il font non è completo (Colore)';
    exit;
  end;
  FColor:=App.ToInteger;

  //Leggo il nome del Font
  if not R180Getvalore(Valori,PH_NAME,PH_SIZE,FName) then
  begin
    Result:=sezione + ':Il font non è completo (Nome)';
    exit;
  end;

  //Leggo il Size del Font
  if not R180Getvalore(Valori,PH_SIZE,PH_STYLE,App) then
  begin
    Result:=Sezione + ':Il font non è completo (Dimensione)';
    exit;
  end;
  FSize:=App.ToInteger;

  //Leggo lo Style del Font
  if not R180Getvalore(Valori,PH_STYLE,'',App) then
  begin
    Result:=sezione + ':Il font non è completo (Stile)';
    exit;
  end;
  ReadStyle(App);
end;

function TFontProperties.getStyle: String;
begin
  Result:='0000';
  if FBold then Result[1]:='1';
  if FItalic then Result[2]:='1';
  if FUnderline then Result[3]:='1';
  if FStrikeOut then Result[4]:='1';
end;

procedure TFontProperties.ReadStyle(Style: String);
begin
  FBold:=(Style[1] = '1');
  FItalic:=(Style[2] = '1');
  FUnderline:=(Style[3] = '1');
  FStrikeOut:=(Style[4] = '1');
end;

function TFontProperties.ToDBString: String;
begin
  Result:=PH_COLOR + FColor.ToString +
          PH_NAME + FName +
          PH_SIZE + FSize.ToString +
          PH_STYLE + getStyle;
end;

{ TSezione }

constructor TSezione.Create(s:String);
begin
  inherited Create;
  name:=s;
  FontProperties:=TFontProperties.Create();
  //Imposto default. su win ha il font sulle scrollbox
  FontProperties.Name:='Courier new';
  FontProperties.Size:=8;
  FontProperties.Color:=clBlack;

  lstLabels:=TList<TLabelProperties>.Create();
end;

procedure TSezione.addLabel(LabelProperties: TLabelProperties);
begin
  lstLabels.add(LabelProperties);
end;

procedure TSezione.removeLabel(UnName:String);
var
  LabelProperties: TLabelProperties;
  i:Integer;
begin
  for i:=0 to lstLabels.Count - 1 do
  begin
    LabelProperties:=lstLabels[i];
    if LabelProperties.UniqueName.Equals(UnName) then
    begin
      lstLabels.Remove(LabelProperties);
      FreeAndNil(LabelProperties);
      break;
    end;
  end;
end;

procedure TSezione.removeAllLabels;
var
  LabelProperties: TLabelProperties;
  i:Integer;
begin
  for i:=0 to lstLabels.Count - 1 do
  begin
    LabelProperties:=lstLabels[i] ;
    FreeAndNil(LabelProperties);
  end;
  lstLabels.Clear;
end;

function TSezione.getLabel(UnName:String):TLabelProperties;
var
  LabelProperties: TLabelProperties;
begin
  result:=nil;
  for LabelProperties in lstLabels do
  begin
    if LabelProperties.UniqueName.Equals(UnName) then
      Result:=LabelProperties;
  end;
end;
//Alcuni campi di dati liberi possono essere presenti
//più volte (nel riepilogo) e quindi il nome del campo(FName) non è
//univoco per il componente. Creo un nome univoco per poterli aggiungere
//nello scrollbox e anche per reperire in modo univoco da web
//il nome univoco è composto da name_<idprogressivo>
procedure TSezione.CreaNomeUnivocoLabel(labelProperties: TLabelProperties);
var lbl: TLabelProperties;
  id,maxId,t:Integer;
  AllowMultiple:Boolean;
  nomeLabel: String;
begin
  maxId:=0;
  AllowMultiple:=False;
  for t in TAG_MULTIPLI do
  begin
    if t = labelProperties.Tag  then
      AllowMultiple:=True;
  end;
  //devo considerare anche il contenitore(sezione)
  nomeLabel:=Identificatore(Self.Name + '_' + labelProperties.Name + '_');
  if AllowMultiple then
  begin
    for lbl in LstLabels do
    begin
      if lbl.UniqueName.StartsWith(nomeLabel) then
      begin
        id:=lbl.UniqueName.Substring(nomeLabel.Length).ToInteger();
        if  id > maxId then
          maxId:=id;
      end;
    end;
  end;
  maxId:=maxId + 1;
  labelProperties.uniqueName:=nomeLabel + maxid.ToString();
end;

function TSezione.getDefWidth: Integer;
begin
  if FontProperties <> nil then
    Result:=FontProperties.Size
  else
    Result:=0;
end;

function TSezione.getDefHeight: Integer;
begin
  Result:=2 * getDefWidth - getDefWidth div 4;
end;

function TSezione.SettaWidth(W:Integer; S:String ) : Integer;
{Setto la larghezza della TLabel in base alla descrizione e alla lunghezza del dato}
var DW:Integer;
begin
  DW:=getDefWidth;
  Result:=DW * Length(S) + DW * W;
end;

function TSezione.GotoNearestX( X: Integer ) : Integer;
{Arrotonda la posizione di inserimento in base alla variabile DefWidth}
var DW:Integer;
begin
  DW:=getDefWidth;
  Result:=(X div DW) * DW + DefLeft;
end;

function TSezione.GotoNearestY( Y: Integer ) : Integer;
{Arrotonda la posizione di inserimento in base alle variabili DefWidth/DefHeight}
var DH:LongInt;
begin
  DH:=getDefHeight;
  Result:=(Y div DH) * DH;
end;

function TSezione.Salva(sezione:String):TStringList;
var suff: String;
    labelProperties: TLabelProperties;
begin
  Result:=TStringList.Create;
  suff:=sezione;
  if sezione = TSezione.INTESTAZIONE  then
    suff:='';
  Result.Add(Format('[FONT%s]',[suff]));
  Result.Add(FontProperties.ToDBString);

  //Linea di partenza delle Impostazioni delle Labels
  Result.Add(Format('[LABELS%s]',[suff]));

  for labelProperties in lstlabels do
    Result.Add(labelProperties.toDBString);
end;

function TSezione.Carica(sezione:String; lstValoriDB: TStringList): TStringList;
var
  suff, s, Msg: String;
  i,i2,j: Integer;
  LabelProperties: TLabelProperties;
begin
  Result:=TStringList.Create;

  suff:=sezione;
  if sezione = TSezione.INTESTAZIONE  then
    suff:='';
  i:=lstValoriDB.IndexOf(Format('[FONT%s]',[suff]));
  if i = -1 then
  begin
    Result.Add(sezione + ':Il font non è leggibile.');
  end
  else
  begin
    s:=lstValoriDB[i + 1];
    Msg:=FontProperties.CaricaDaDB(sezione,s);
    //Aggiungo gli errori
    if Msg <> '' then
      Result.Add(Msg);
  end;
  //Linea di partenza delle Impostazioni delle Labels
  i:=lstValoriDB.IndexOf(Format('[LABELS%s]',[Suff]));
  //Cerco la fine delle impostazioni del gruppo (Intestazione/Dettaglio/Riepilogo)
  i2:=lstValoriDB.IndexOf('[FONT' + TSezione.DETTAGLIO + ']');
  if i2 < i then
  begin
    i2:=lstValoriDB.IndexOf('[FONT' + TSezione.RIEPILOGO + ']');
    if i2 < i then
      i2:=lstValoriDB.Count;
    end;
  if i = -1 then
  begin
    Result.Add(sezione + ':Le labels non sono leggibili.');
    exit;
  end;
  for j:=i + 1 to i2 - 1 do
  begin
    s:=lstValoriDB[j];
    LabelProperties:=TLabelProperties.Create;
    Msg:=LabelProperties.CaricaDaDB(sezione,s);
    CreaNomeUnivocoLabel(LabelProperties);
     //Aggiungo gli errori
    if Msg <> '' then
    begin
      Result.Add(Msg);
      FreeAndNil(LabelProperties);
    end
    else
    begin
      LstLabels.Add(LabelProperties);
    end;
  end;
end;


destructor TSezione.Destroy;
var
  LabelProperties:TLabelProperties;
  i:Integer;
begin
  inherited;
  FreeAndNil(FontProperties);
  removeAllLabels;
  FreeAndNil(lstLabels);
end;

{ TA052FParCarMW }

procedure TA052FParCarMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  dicSezioni:=TDictionary<String,TSezione>.Create;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  DI010.DataSet:=selI010;   //Non uso i campi persistenti poichè hanno dato dei problemi col campo Memo
  selT265.Open;
  selT275.Open;
end;

function TA052FParCarMW.EnableGiorniMese(Tag: Integer): Boolean;
begin
  Result:=Tag in [C_GG1..C_GG1];
end;

function TA052FParCarMW.EnableGiustificativi(Tag: Integer): Boolean;
begin
  Result:=Tag in [C_GI1..C_GI2];
end;

function TA052FParCarMW.EnableTimbrature(Tag: Integer): Boolean;
begin
  Result:=Tag in [C_TI1..C_TI8];
end;

function TA052FParCarMW.EnableTurno(Tag: Integer): Boolean;
begin
  Result:=Tag in [C_TR1,C_TR2];
end;

function TA052FParCarMW.EnableTotali(Tag: Integer): Boolean;
begin
  Result:=(Tag in C_TOTALI_NO) or (Tag in C_TOTALI_SI);
end;

function TA052FParCarMW.CausaliDaVisualizzare(Tag:Integer): Boolean;
begin
  Result:=Tag in [C_CAU1..C_CAU2];
end;

function TA052FParCarMW.GetCheckedTotali(Tag:Integer): Boolean;
begin
  if Tag in C_TOTALI_NO then
    Result:=False
  else if Tag in C_TOTALI_SI then
    Result:=True;
end;

function TA052FParCarMW.GetTagTotali(Checked:Boolean; Tag:Integer): Integer;
begin
  Result:=Tag;
  //Attivazione del totale
  if Checked and (Tag in C_TOTALI_NO) then
  begin
    if Tag = C_INDP1 then
      Result:=C_INDP2
    else if Tag = C_INDF1 then
      Result:=C_INDF2
    else if Tag = C_INDN1 then
      Result:=C_INDN2
    else
      Result:=Tag + 1;
  end;
  //Disattivazione del totale
  if (not Checked ) and (Tag in C_TOTALI_SI) then
  begin
    if Tag = C_INDP2 then
      Result:=C_INDP1
    else if Tag = C_INDF2 then
      Result:=C_INDF1
    else if Tag = C_INDN2 then
      Result:=C_INDN1
    else
      Result:=Tag - 1;
  end;
end;

function TA052FParCarMW.getItemIndexTurno(Tag:Integer): Integer;
begin
  if Tag = C_TR1  then
    Result:=0
  else if Tag = C_TR2 then
    Result:=1
  else
    Result:=-1;
end;

function TA052FParCarMW.getTagTurno(ItemIndex: Integer): Integer;
begin
  if ItemIndex = 0 then
    Result:=C_TR1
  else if ItemIndex = 1 then
    Result:=C_TR2
  else
    Result:=-1;
end;

function TA052FParCarMW.getItemIndexCausale(Tag:Integer): Integer;
begin
  if Tag in [C_TI1,C_TI5] then
    Result:=0
  else if Tag in [C_TI2,C_TI6] then
    Result:=1
  else if Tag in [C_TI3,C_TI7] then
    Result:=2
  else if Tag in [C_TI4,C_TI8] then
    Result:=3
  else
    Result:=-1;
end;

function TA052FParCarMW.getTagCausale(ItemIndex: Integer): Integer;
begin
  Result:=C_TI1 + ItemIndex;
end;

function TA052FParCarMW.GetItemIndexGiustificativi(Tag:Integer): Integer;
begin
  if Tag = C_GI1 then
    Result:=0
  else if Tag = C_GI2 then
    Result:=1
  else
    Result:=-1;
end;

function TA052FParCarMW.GetTagGiustificativi(ItemIndex:Integer): Integer;
begin
  if ItemIndex = 0 then
    Result:=C_GI1
  else if ItemIndex = 1 then
    Result:=C_GI2
  else
    Result:=-1;
end;

function TA052FParCarMW.GetCheckedOrologio(Tag:Integer): Boolean;
begin
  Result:=Tag in [C_TI5..C_TI8];
end;

function TA052FParCarMW.GetTagOrologio(checked:Boolean; Tag:Integer): Integer;
begin
  Result:=Tag;
  if Checked then
    inc(Result,4);
end;

function TA052FParCarMW.CaricaImpostazioni: TStringList;
var lstValoriDB: TStringList;
    lstErrori: TStringList;
    s: String;
begin
  Result:=TStringList.Create;
  resetDictSezioni;
  lstValoriDB:=TStringList.Create;
  try
    while not selT951.Eof do
    begin
      lstValoriDB.Add(selT951.FieldByName('RIGA').AsString.Trim);
      selT951.Next;
    end;
    if lstValoriDB.Count > 0 then
    begin
      for s in dicSezioni.Keys do
      begin
        lstErrori:=dicSezioni.Items[s].Carica(s,lstValoriDB);
        Result.AddStrings(lstErrori);
        FreeAndNil(lstErrori);
      end;
    end;
  finally
    FreeAndNil(lstValoriDB);
  end;
end;

function TA052FParCarMW.HasProprieta(Tag:Integer): Boolean;
begin
  Result:=Tag in [C_GG1..C_SC2,
                 C_TR1,C_TR2,
                 C_SN1..C_LF2,
                 C_PRI1..C_PRT2,
                 C_PRU1..C_PRU2,
                 C_CMNG1..C_CMNG2,
                 C_ESC1..C_ESC2,
                 C_PM1..C_PM2,
                 C_FENNG1..C_PCONV2,
                 C_CAU1..C_CAU2,
                 C_IT1..C_IT2,
                 C_INDP1,C_INDP2,
                 C_INDF1,C_INDF2,
                 C_INDN1,C_INDN2,
                 C_NUMN1..C_NUMN2
                 ];
end;

procedure TA052FParCarMW.removeSezione(sezione: String);
var sez: TSezione;
begin
  if dicSezioni.ContainsKey(sezione) then
  begin
    Sez:=dicSezioni.Items[sezione];
    FreeAndNil(Sez);
    dicSezioni.Remove(sezione);
  end;
end;

function TA052FParCarMW.SelT950Filter: boolean;
begin
  Result:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',FSelT950_Funzioni.FieldByName('CODICE').AsString);
end;

procedure TA052FParCarMW.selT950BeforeDelete;
begin
 VecchioCodiceDizionario:=FSelT950_Funzioni.FieldByName('CODICE').AsString;
end;

procedure TA052FParCarMW.selT950AfterDelete;
begin
  A000AggiornaFiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',VecchioCodiceDizionario,'');
end;

procedure TA052FParCarMW.selT950BeforePost;
begin
  if FSelT950_Funzioni.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(FSelT950_Funzioni.FieldByName('Codice').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  FSelT950_Funzioni.FieldByName('Codice').AsString:=Trim(FSelT950_Funzioni.FieldByName('Codice').AsString);
  if QueryPK1.EsisteChiave('T950_STAMPACARTELLINO',FSelT950_Funzioni.RowId,FSelT950_Funzioni.State,['CODICE'],[FSelT950_Funzioni.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
end;

procedure TA052FParCarMW.selT950AfterPost;
begin
  SalvaSezioni;
  A000AggiornaFiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',VecchioCodiceDizionario,FSelT950_Funzioni.FieldByName('CODICE').AsString);
end;

procedure TA052FParCarMW.resetDictSezioni;
var s: String;
begin
  //Non usare direttamente dicSezioni.Keys  ma il toArray
  //perchè rimuovendo le chiavi, l'iterator sulle chiavi non scorre tutti gli elementi
  for s in dicSezioni.Keys.ToArray do
    removeSezione(s);

  //Inizializzo con oggetti vuoti
  for s in TSezione.ELENCO_SEZIONI do
    dicSezioni.Add(s, TSezione.Create(s) );
end;

procedure TA052FParCarMW.SalvaSezioni;
var s, sezione: String;
  i: Integer;
  lst: tstringlist;
begin
  with selT951 do
  begin
    Close;
    SetVariable('CODICE',FSelT950_Funzioni.FieldByName('CODICE').AsString);
    Open;
    while not Eof do
      Delete;

    i:=0;
    //non usare keys perchè la sequenza è quesa e prestabilita
    for sezione in TSezione.ELENCO_SEZIONI do
    begin
      //Font
      lst:=dicSezioni[sezione].Salva(sezione);
      try
        for s in lst do
        begin
          Append;
          FieldByName('CODICE').AsString:=FSelT950_Funzioni.FieldByName('CODICE').AsString;
          FieldByName('NUMRIGA').AsInteger:=i;
          FieldByName('RIGA').AsString:=s;
          i:=i + 1;
          Post;
        end;
      finally
        FreeAndNil(lst);
      end;
    end;
  end;
end;

procedure TA052FParCarMW.DataModuleDestroy(Sender: TObject);
var s: String;
begin
  //Non usare direttamente dicSezioni.Keys  ma il toArray
  //perchè rimuovendo le chiavi, l'iterator sulle chiavi non scorre tutti gli elementi
  for s in dicSezioni.Keys.ToArray do
    removeSezione(s);

  FreeAndNil(dicSezioni);
  FreeAndNil(selI010);
  inherited;
end;

function TA052FParCarMW.SelT950AfterScroll: TStringList;
begin
  selT951.Close;
  selT951.SetVariable('CODICE',FSelT950_Funzioni.FieldByName('CODICE').AsString);
  selT951.Open;
  Result:=CaricaImpostazioni;
end;

function TA052FParCarMW.CreaLabelIntestazione(X, Y: Integer): TLabelProperties;
var L:Integer;
begin
  Result:=TLabelProperties.Create;
  L:=selI010.FieldByName('POSIZIONE').AsInteger;
  if L = 0 then L:=10;
  Result.caption:=selI010.FieldByName('NOME_LOGICO').AsString;
  Result.left:=dicSezioni[TSezione.INTESTAZIONE].GotoNearestX(X);
  Result.top:=dicSezioni[TSezione.INTESTAZIONE].GotoNearestY(Y);
  Result.height:=dicSezioni[TSezione.INTESTAZIONE].getDefHeight;
  Result.width:=dicSezioni[TSezione.INTESTAZIONE].SettaWidth(L,Result.caption);
  Result.tag:=0;
  Result.name:=selI010.FieldByName('NOME_CAMPO').AsString;
  dicSezioni[TSezione.INTESTAZIONE].CreaNomeUnivocoLabel(Result);
end;

function TA052FParCarMW.CreaLabelDettaglio(DatoDett:TDett; X, Y: Integer): TLabelProperties;
var L:Integer;
begin
  Result:=TLabelProperties.Create;

  L:=DatoDett.W;
  Result.left:=dicSezioni[TSezione.DETTAGLIO].GotoNearestX(X);
  Result.top:=dicSezioni[TSezione.DETTAGLIO].GotoNearestY(Y);
  Result.height:=dicSezioni[TSezione.DETTAGLIO].getDefHeight;
  Result.width:=dicSezioni[TSezione.DETTAGLIO].SettaWidth(L,'');

  Result.tag:=DatoDett.N;
  Result.name:=DatoDett.D;
  Result.caption:=DatoDett.D;
  dicSezioni[TSezione.DETTAGLIO].CreaNomeUnivocoLabel(Result);
end;

function TA052FParCarMW.CreaLabelRiepilogo(DatoRiep:TRiep; X, Y: Integer): TLabelProperties;
var L:Integer;
begin
  Result:=TLabelProperties.Create;
  L:=DatoRiep.W;

  Result.left:=dicSezioni[TSezione.RIEPILOGO].GotoNearestX(X);
  Result.top:=dicSezioni[TSezione.RIEPILOGO].GotoNearestY(Y);
  Result.height:=dicSezioni[TSezione.RIEPILOGO].getDefHeight;
  Result.width:=dicSezioni[TSezione.RIEPILOGO].SettaWidth(L,'');
  Result.tag:=DatoRiep.N;
  Result.name:=DatoRiep.D;
  Result.caption:=DatoRiep.D;
  dicSezioni[TSezione.RIEPILOGO].CreaNomeUnivocoLabel(Result);
end;

end.

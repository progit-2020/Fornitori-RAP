unit A106UDistanzeTrasfertaMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, A000UMessaggi,
  Data.DB, OracleData, C019UDistanziometro, C180FunzioniGenerali, Variants;

type
  TA106FDistanzeTrasfertaMW = class(TR005FDataModuleMW)
    SelT480: TOracleDataSet;
    SelM042: TOracleDataSet;
    SelM042CODICE: TStringField;
    SelM042DESCRIZIONE: TStringField;
    dsrSelT480: TDataSource;
    dsrSelM042: TDataSource;
    SelM041C: TOracleDataSet;
    SelT480CODICE: TStringField;
    SelT480CITTA: TStringField;
    SelT480CAP: TStringField;
    SelT480PROVINCIA: TStringField;
    SelT480CODCATASTALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelM041_Funzioni: TOracleDataset;
  public
    EseguiCalcoloDistanze: Boolean;
    procedure selM041BeforePost;
    property SelM041_Funzioni: TOracleDataset read FSelM041_Funzioni write FSelM041_Funzioni;
  end;

implementation

{$R *.dfm}

procedure TA106FDistanzeTrasfertaMW.DataModuleCreate(Sender: TObject);
var LErrore: String;
begin
  inherited;
  SelT480.SetVariable('ORDERBY','ORDER BY CITTA');
  SelT480.Open;
  SelM042.Open;
  // determina se attivare o meno il calcolo delle distanze
  // utilizzando il webservice esterno
  EseguiCalcoloDistanze:=TC019FDistanziometro.GetDistanza('CUNEO','ACCEGLIO',LErrore) > 0;
end;

procedure TA106FDistanzeTrasfertaMW.selM041BeforePost;
var
  Dist: Integer;
  Partenza,PartenzaDesc,PartenzaCap,PartenzaProv,
  Destinazione,DestinazioneDesc,DestinazioneCap,DestinazioneProv,
  Errore: String;
  VPartenza, VDestinazione: Variant;
begin
  if (FSelM041_Funzioni.FieldByName('LOCALITA1').AsString = '') then
    raise exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A106_MSG_PARTENZA]));

  if (FSelM041_Funzioni.FieldByName('LOCALITA2').AsString = '') then
    raise exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A106_MSG_DESTINAZIONE]));

  if (FSelM041_Funzioni.FieldByName('LOCALITA1').AsString = FSelM041_Funzioni.FieldByName('LOCALITA2').AsString) then
    raise exception.Create(A000MSG_A106_ERR_LOCALITA);

  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 04.02.2014.ini
  // in inserimento / modifica, se l'utente introduce un valore nullo oppure 0,
  // verrà poi richiamato il webservice di calcolo distanza
  //if (FSelM041_Funzioni.FieldByName('CHILOMETRI').AsInteger <= 0) then
  if (FSelM041_Funzioni.FieldByName('CHILOMETRI').AsInteger < 0) then
    raise exception.Create(A000MSG_A106_ERR_CHILOMETRI);
  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 04.02.2014.fine

  //Verifico che non esista già la stessa distanza caricata, eventualmente al contrario
  //Se esiste non permetto di inserire
  SelM041C.Close;
  SelM041C.ClearVariables;
  SelM041C.SetVariable('CODLOC1',FSelM041_Funzioni.FieldByName('TIPO1').AsString + FSelM041_Funzioni.FieldByName('LOCALITA1').AsString);
  SelM041C.SetVariable('CODLOC2',FSelM041_Funzioni.FieldByName('TIPO2').AsString + FSelM041_Funzioni.FieldByName('LOCALITA2').AsString);
  If FSelM041_Funzioni.State = dsEdit then
    SelM041C.SetVariable('NROWID','AND ROWID <> '''  + FSelM041_Funzioni.RowId + '''');
  SelM041C.Open;
  if SelM041C.Fields[0].AsInteger > 0 then
    raise exception.Create(A000MSG_A106_ERR_DUPLICAZIONE);

  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 04.02.2014.ini
  // se l'utente ha introdotto valore nullo oppure 0 richiama webservice di calcolo distanza
  if (EseguiCalcoloDistanze) and
     ((FSelM041_Funzioni.FieldByName('CHILOMETRI').IsNull) or
      (FSelM041_Funzioni.FieldByName('CHILOMETRI').AsInteger = 0)) then
  begin
    // per il richiamo al webservice considera solo le distanze da comune a comune
    if (FSelM041_Funzioni.FieldByName('TIPO1').AsString = 'C') and
       (FSelM041_Funzioni.FieldByName('TIPO2').AsString = 'C') then
    begin
      // occorre andare in lookup sulla t480
      // purtroppo i campi di lookup del dataset non sono valorizzati correttamente

      // AOSTA_REGIONE - chiamata 82052.ini
      // riconoscimento non corretto delle distanze dovuto alle ambiguità intrinseche del nome del comune
      // è stato aggiunto il cap del comune per discriminare
      //Partenza:=VarToStr(SelT480.Lookup('CODICE',FSelM041_Funzioni.FieldByName('LOCALITA1').AsString,'CITTA'));
      //Destinazione:=VarToStr(SelT480.Lookup('CODICE',FSelM041_Funzioni.FieldByName('LOCALITA2').AsString,'CITTA'));
      VPartenza:=SelT480.Lookup('CODICE',FSelM041_Funzioni.FieldByName('LOCALITA1').AsString,'CITTA;CAP;PROVINCIA');
      if VarIsNull(VPartenza) then
      begin
        Partenza:='';
      end
      else
      begin
        PartenzaDesc:='';
        PartenzaCap:='';
        PartenzaProv:='';
        if not VarIsNull(VPartenza[0]) then
          PartenzaDesc:=String(VPartenza[0]);
        if not VarIsNull(VPartenza[1]) then
          PartenzaCap:=String(VPartenza[1]);
        if not VarIsNull(VPartenza[2]) then
          PartenzaProv:=String(VPartenza[2]);
        Partenza:=TC019FDistanziometro.FormattaLocalita(PartenzaDesc,PartenzaCap,PartenzaProv);
      end;
      // destinazione
      VDestinazione:=SelT480.Lookup('CODICE',FSelM041_Funzioni.FieldByName('LOCALITA2').AsString,'CITTA;CAP;PROVINCIA');
      if VarIsNull(VDestinazione) then
      begin
        Destinazione:='';
      end
      else
      begin
        DestinazioneDesc:='';
        DestinazioneCap:='';
        DestinazioneProv:='';
        if not VarIsNull(VDestinazione[0]) then
          DestinazioneDesc:=String(VDestinazione[0]);
        if not VarIsNull(VDestinazione[1]) then
          DestinazioneCap:=String(VDestinazione[1]);
        if not VarIsNull(VDestinazione[2]) then
          DestinazioneProv:=String(VDestinazione[2]);
        Destinazione:=TC019FDistanziometro.FormattaLocalita(DestinazioneDesc,DestinazioneCap,DestinazioneProv);
      end;
      // AOSTA_REGIONE - chiamata 82052.fine
      Dist:=TC019FDistanziometro.GetDistanza(Partenza,Destinazione,Errore);
    end
    else
    begin
      Dist:=0;
    end;

    if Dist = 0 then
    begin
      // imposta valore 0 su database
      FSelM041_Funzioni.FieldByName('CHILOMETRI').AsInteger:=0;
    end
    else
    begin
      // imposta la distanza restituita dal webservice
      Dist:=Trunc(R180Arrotonda(Dist/1000,1,'P'));
      FSelM041_Funzioni.FieldByName('CHILOMETRI').AsInteger:=Dist;
    end;
  end;
  // AOSTA_REGIONE - commessa: 2013/031 VARIE#1 - riesame del 04.02.2014.fine
end;
end.

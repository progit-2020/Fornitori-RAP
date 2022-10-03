unit A115UIterAutorizzativiMW;

interface

uses
  System.SysUtils,
  System.Classes,
  R005UDataModuleMW,
  Data.DB,
  Math,
  OracleData,
  A000UInterfaccia,
  A000UCostanti,
  A000USessione,
  C180FunzioniGenerali,
  Oracle,
  System.StrUtils,
  System.Variants,
  Datasnap.DBClient,
  C018UIterAutDM,
  RegistrazioneLog;

type
  TA115FIterAutorizzativiMW = class(TR005FDataModuleMW)
    selI097: TOracleDataSet;
    selI097AZIENDA: TStringField;
    selI097ITER: TStringField;
    selI097COD_ITER: TStringField;
    selI097NUM_CONDIZ: TIntegerField;
    selI097CONDIZ_VALIDITA: TStringField;
    selI097MESSAGGIO: TStringField;
    selI097BLOCCANTE: TStringField;
    selI094: TOracleDataSet;
    selI094AZIENDA: TStringField;
    selI094ITER: TStringField;
    selI094d_riepilogo: TStringField;
    selI094RIEPILOGO: TStringField;
    selI094STATO: TStringField;
    selI094EXPR_DATA: TStringField;
    cdsBloccoRiep: TClientDataSet;
    scrI093P_AGGIORNA_ITER: TOracleQuery;
    procedure selI093AfterScroll;
    procedure selI093BeforeDelete;
    procedure selI093BeforeInsert;
    procedure I093TestExprSQL;
    procedure selI093BeforePost;
    procedure selI093CalcFields;
    procedure selI094BeforePost(DataSet: TDataSet);
    procedure selI094NewRecord(DataSet: TDataSet);
    procedure selI095AfterOpen;
    procedure selI095AfterScroll;
    procedure selI095BeforeDelete;
    procedure selI095BeforeInsert;
    procedure selI095BeforePost;
    procedure selI095CalcFields;
    procedure selI095NewRecord;
    procedure selI096AfterPost;
    procedure selI096BeforeDelete;
    procedure selI096BeforeInsert;
    procedure selI096BeforePost;
    procedure selI096NewRecord;
    procedure selI097BeforePost(DataSet: TDataSet);
    procedure selI097NewRecord(DataSet: TDataSet);
    procedure ApplyRecordRegistraLog(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
  const
    NON_ASSEGNATO = 'Non assegnato';
  private
    ModuloIterAutorizzativiIter:Boolean;
    function CodIterToDesc(param:String):String;
    procedure CaricaCdsBloccoRiep;
  public
    selI093:TOracleDataSet;
    selI095:TOracleDataSet;
    selI096:TOracleDataSet;
    AziendaCorrente:String;
    I093EnabledInsert:Boolean;
    LivMax: Integer;
    ModuloIterAutorizzativi:Boolean;
    RegistraLogSecondario:TRegistraLog;
    procedure check_I095;
    procedure check_I096;
    procedure OpenSelI093;
    procedure AggiornaI093_I095_I096;
    procedure AbilitazioniColonneI096;
    function GetI091Gruppo(CodI091:String):String;
    procedure AggiornaLivMax;
  end;

var
  A115FIterAutorizzativiMW: TA115FIterAutorizzativiMW;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA115FIterAutorizzativiMW.OpenSelI093;
begin
  if not selI093.Active then
  begin
    CaricaCdsBloccoRiep; // Caricamento valori riepilogo in lookup
    R180SetVariable(selI093,'AZIENDA',AziendaCorrente);
    selI093.Open;
  end;
end;

procedure TA115FIterAutorizzativiMW.selI093AfterScroll;
var
  GestAllegati: Boolean;
begin

  //Sempre abilitato per l'iter delle missioni
  ModuloIterAutorizzativiIter:=ModuloIterAutorizzativi or (selI093.FieldByName('ITER').AsString = ITER_MISSIONI);

  // gestione allegati: al momento solo per missioni e giustificativi
  GestAllegati:=R180In(selI093.FieldByName('ITER').AsString,[ITER_MISSIONI,ITER_GIUSTIF]);

  // interrompe disegno interfaccia
  selI094.DisableControls;
  selI095.DisableControls;

  try
    // tabella iter
    selI093.FieldByName('REVOCABILE').ReadOnly:=selI093.FieldByName('ITER').AsString <> ITER_GIUSTIF;

    // tabella I094
    selI094.Close;
    selI094.SetVariable('AZIENDA',selI093.FieldByName('AZIENDA').AsString);
    selI094.SetVariable('ITER',selI093.FieldByName('ITER').AsString);
    selI094.Open;

    // tabella delle strutture
    selI095.Close;
    selI095.SetVariable('AZIENDA',selI093.FieldByName('AZIENDA').AsString);
    selI095.SetVariable('ITER',selI093.FieldByName('ITER').AsString);
    selI095.Open;
    selI095.FieldByName('CONDIZIONE_ALLEGATI').ReadOnly:=not GestAllegati;
    selI095.FieldByName('ALLEGATI_MODIFICABILI').ReadOnly:=not GestAllegati;

    // tabella livelli
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Visible:=selI095.FieldByName('ITER').AsString = ITER_GIUSTIF;
    selI096.FieldByName('FASE').Visible:=R180In(selI095.FieldByName('ITER').AsString,[ITER_MISSIONI, ITER_STRMESE]);
    selI096.FieldByName('ALLEGATI_VISIBILI').ReadOnly:=not GestAllegati;
    selI096.FieldByName('ALLEGATI_OBBLIGATORI').ReadOnly:=not GestAllegati;
    AbilitazioniColonneI096;
  finally
    // riattiva disegno interfaccia
    selI094.EnableControls;
    selI095.EnableControls;
  end;
end;

procedure TA115FIterAutorizzativiMW.selI093BeforeDelete;
begin
  Abort;
end;

procedure TA115FIterAutorizzativiMW.selI093BeforeInsert;
begin
  if not I093EnabledInsert then
    Abort;
end;

procedure TA115FIterAutorizzativiMW.selI093BeforePost;
begin
  I093TestExprSQL;
  if (selI093.FieldByName('REVOCABILE').AsString <> 'S') and
     (selI093.FieldByName('REVOCABILE').AsString <> 'N') then
    raise Exception.Create('I valori permessi nel campo "revocabile" sono S o N.');
end;

procedure TA115FIterAutorizzativiMW.selI093CalcFields;
begin
  selI093.FieldByName('D_ITER').AsString:=A000GetDescIter(selI093.FieldByName('ITER').AsString);
  selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(vuoto)';
  if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger = 1 then
    selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(1 elemento)'
  else if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger > 0 then
    selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:=Format('(%d elementi)',[selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger]);
end;

procedure TA115FIterAutorizzativiMW.selI094BeforePost(DataSet: TDataSet);
begin
  if selI094.FieldByName('RIEPILOGO').IsNull then
    Raise Exception.Create('Impossibile inserire NULL nel campo riepilogo.');
  if (selI094.FieldByName('STATO').AsString <> 'C') and
     (selI094.FieldByName('STATO').AsString <> 'A') then
    Raise Exception.Create('I valori permessi nel campo "Stato" sono C o A.');
end;

procedure TA115FIterAutorizzativiMW.selI094NewRecord(DataSet: TDataSet);
begin
  selI094.FieldByName('AZIENDA').AsString:=selI093.FieldByName('AZIENDA').AsString;
  selI094.FieldByName('ITER').AsString:=selI093.FieldByName('ITER').AsString;
end;

procedure TA115FIterAutorizzativiMW.selI095AfterOpen;
begin
  selI095.FieldByName('COD_ITER').ReadOnly:=not ModuloIterAutorizzativiIter;
  selI095.FieldByName('DESCRIZIONE').ReadOnly:=not ModuloIterAutorizzativiIter;
  selI095.FieldByName('FILTRO_RICHIESTA').Visible:=ModuloIterAutorizzativiIter;
  selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').Visible:=ModuloIterAutorizzativiIter;
end;

procedure TA115FIterAutorizzativiMW.selI095AfterScroll;
begin
  // interrompe disegno interfaccia
  selI097.DisableControls;
  selI096.DisableControls;

  try
    // tabella dei livelli
    selI096.Close;
    selI096.SetVariable('AZIENDA',selI095.FieldByName('AZIENDA').AsString);
    selI096.SetVariable('ITER',selI095.FieldByName('ITER').AsString);
    selI096.SetVariable('COD_ITER',selI095.FieldByName('COD_ITER').AsString);
    selI096.Open;
    AggiornaLivMax;

    // tabella I097
    selI097.Close;
    selI097.SetVariable('AZIENDA',selI095.FieldByName('AZIENDA').AsString);
    selI097.SetVariable('ITER',selI095.FieldByName('ITER').AsString);
    selI097.SetVariable('COD_ITER',selI095.FieldByName('COD_ITER').AsString);
    selI097.Open;
  finally
    // riattiva disegno interfaccia
    selI097.EnableControls;
    selI096.EnableControls;
  end;
end;

procedure TA115FIterAutorizzativiMW.selI095BeforeDelete;
begin
  if not ModuloIterAutorizzativiIter then
    Abort;
  //Controlli per delete
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075, MONDOEDP.I096_LIVELLI_ITER_AUT I096');
    SQL.Add(' WHERE I096.AZIENDA = ''' + selI095.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I096.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I096.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND NVL(I075.ACCESSO,''N'') <> ''N''');
    SQL.Add('   AND I096.AZIENDA = I075.AZIENDA(+)');
    SQL.Add('   AND I096.ITER = I075.ITER(+)');
    SQL.Add('   AND I096.COD_ITER = I075.COD_ITER(+)');
    SQL.Add('   AND I096.LIVELLO = I075.LIVELLO(+)');
    Open;
    if FieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI095.FieldByName('AZIENDA').AsString +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS NREC FROM ' + (*I090.UTENTE +*) ' T850_ITER_RICHIESTE T850'); // FIXME UTENTE
    SQL.Add(' WHERE T850.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('  AND T850.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + Parametri.Username +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;
    Close;
    Free;
  end;
end;

procedure TA115FIterAutorizzativiMW.selI095BeforeInsert;
begin
  if not ModuloIterAutorizzativiIter then
    Abort;
end;

procedure TA115FIterAutorizzativiMW.selI095BeforePost;
var i,minI097,maxI097: Integer;
begin
  if selI095.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').IsNull then
    selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').AsInteger:=-1;

  if selI095.FieldByName('MAX_LIV_NOTE_MODIFICABILI').IsNull then
    selI095.FieldByName('MAX_LIV_NOTE_MODIFICABILI').AsInteger:=0;

  if Trim(selI095.FieldByName('COD_ITER').AsString) = '' then
    raise Exception.Create('Indicare il codice della struttura');

  if not R180In(selI095.FieldByName('FILTRO_INTERFACCIA').AsString,['S','N']) then
    raise Exception.Create('''Filtrabile'' può valere S o N');

  if Trim(selI095.FieldByName('ALLEGATI_MODIFICABILI').AsString) = '' then
    raise Exception.Create('Indicare un valore per ''Allegati modif.''');

  //Riordinamento record delle condizioni di validità
  minI097:=High(Integer);
  maxI097:=0;
  selI097.First;
  while not selI097.Eof do
  begin
    if selI097.FieldByName('NUM_CONDIZ').AsInteger > 0 then
    begin
      if selI097.FieldByName('NUM_CONDIZ').AsInteger > maxI097 then
        maxI097:=selI097.FieldByName('NUM_CONDIZ').AsInteger;
      if selI097.FieldByName('NUM_CONDIZ').AsInteger < minI097 then
        minI097:=selI097.FieldByName('NUM_CONDIZ').AsInteger;
    end;
    selI097.Next;
  end;
  i:=maxI097 + 1;
  selI097.ReadOnly:=False;
  selI097.First;
  try
    while not selI097.Eof do
    begin
      if selI097.FieldByName('NUM_CONDIZ').AsInteger <= 0 then
      begin
        selI097.Edit;
        selI097.FieldByName('NUM_CONDIZ').AsInteger:=i;
        selI097.Post;
        Inc(i);
      end;
      selI097.Next;
    end;
  finally
    selI097.ReadOnly:=True;
    selI097.First;
  end;
end;

procedure TA115FIterAutorizzativiMW.selI095CalcFields;
begin
  selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(vuoto)';
  if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger = 1 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(1 elemento)'
  else if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger > 0 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:=Format('(%d elementi)',[selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger]);
end;

procedure TA115FIterAutorizzativiMW.selI095NewRecord;
begin
  selI095.FieldByName('AZIENDA').asString:=selI093.FieldByName('AZIENDA').asString;
  selI095.FieldByName('ITER').asString:=selI093.FieldByName('ITER').asString;
end;

procedure TA115FIterAutorizzativiMW.selI096AfterPost;
begin
  check_I096;
end;

procedure TA115FIterAutorizzativiMW.selI096BeforeDelete;
begin
 if not ModuloIterAutorizzativiIter then
    Abort;
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075');
    SQL.Add(' WHERE I075.AZIENDA = ''' + selI096.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I075.ITER = ''' + selI096.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I075.COD_ITER = ''' + selI096.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND I075.LIVELLO = ''' + selI096.FieldByName('LIVELLO').AsString + '''');
    SQL.Add('   AND I075.ACCESSO <> ''N''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI096.FieldByName('AZIENDA').AsString +
                             ', ' + selI096.FieldByName('ITER').AsString +
                             ', ' + selI096.FieldByName('COD_ITER').AsString +
                             ', ' + selI096.FieldByName('LIVELLO').AsString + '" è utilizzato da un profilo dipendente.');
    end;
  end;
  if selI096.FieldByName('LIVELLO').AsInteger = 1 then
    Abort;
end;

procedure TA115FIterAutorizzativiMW.selI096BeforeInsert;
begin
  if not ModuloIterAutorizzativiIter then
  begin
    if selI096.FieldByName('ITER').AsString <> ITER_CARTELLINO then
      raise Exception.Create('Impossibile inserire più di un livello per l''iter "' +
                             A000GetDescIter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.')
    else if selI096.RecordCount >= 2 then
      raise Exception.Create('Impossibile inserire più di due livelli per l''iter "' +
                             A000GetDescIter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.');
  end;
end;

procedure TA115FIterAutorizzativiMW.selI096BeforePost;
var
  ValPossibili:TArrString;
  i:Integer;
begin
  //Controlli campo OBBLIGATORIO I096
  if (selI096.State = dsEdit) and (selI096.FieldByName('LIVELLO').medpOldValue <> selI096.FieldByName('LIVELLO').Value) then
  begin
    selI096.FieldByName('LIVELLO').Value:=selI096.FieldByName('LIVELLO').medpOldValue;
    raise Exception.Create('Impossibile modificare!'#13#10'Livello è un campo chiave.');
  end;
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and selI096.FieldByName('VALORI_POSSIBILI').IsNull then
    selI096.FieldByName('VALORI_POSSIBILI').AsString:='S';
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') then
  begin
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
    selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Clear;
  end;
  if selI096.FieldByName('OBBLIGATORIO').AsString = 'S' then
    selI096.FieldByName('AVVISO').AsString:='N';
  if not(R180CarattereDef(selI096.FieldByName('OBBLIGATORIO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Obbligatorio" sono S o N.');
  if not(R180CarattereDef(selI096.FieldByName('DATI_MODIFICABILI').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Dati modificabili" sono S o N.');
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and not(R180CarattereDef(selI096.FieldByName('AVVISO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Avviso" sono S o N.');
  if selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S,N') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N,S') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S') (*and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N')*) then
    raise Exception.Create('Se "Autorizz. intermedia" è nulla, "Valori possibili" può contenere solo S o N.');
  ValPossibili:=R180SplittaArray(selI096.FieldByName('VALORI_POSSIBILI').AsString,',');
  for i:=Low(ValPossibili) to High(ValPossibili) do
    if Length(ValPossibili[i]) > 1 then
      raise Exception.Create(ValPossibili[i] + ': più lungo di un carattere.');
  SetLength(ValPossibili,0);
  if selI096.FieldByName('ITER').AsString = ITER_GIUSTIF then
  begin
    if (not selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull) and
       ((selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString = 'N') or
        (selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString <> StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]))) then
      raise Exception.Create('Il valore di "Autorizz. intermedia" può essere solo ' + StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]));
  end
  else
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
  if (selI096.FieldByName('INVIO_EMAIL').AsString <> 'N') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'A') and
     (selI096.FieldByName('INVIO_EMAIL').AsString <> 'R') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'E') then
    raise Exception.Create('Il valore del dato Invio e-mail non è consentito: "' + selI096.FieldByName('INVIO_EMAIL').AsString + '".');
  if (selI096.FieldByName('ALLEGATI_OBBLIGATORI').AsString <> 'S') and
     (selI096.FieldByName('ALLEGATI_OBBLIGATORI').AsString <> 'N') then
    raise Exception.Create(Format('I valori permessi nel campo "%s" sono S o N.',[selI096.FieldByName('ALLEGATI_OBBLIGATORI').DisplayLabel]));
  if (selI096.FieldByName('ALLEGATI_VISIBILI').AsString <> 'S') and
     (selI096.FieldByName('ALLEGATI_VISIBILI').AsString <> 'N') then
    raise Exception.Create(Format('I valori permessi nel campo "%s" sono S o N.',[selI096.FieldByName('ALLEGATI_VISIBILI').DisplayLabel]));

  if (selI096.State = dsInsert) and (selI096.FieldByName('LIVELLO').AsInteger = LivMax + 1) then
    Inc(LivMax);
end;

procedure TA115FIterAutorizzativiMW.selI096NewRecord;
begin
  selI096.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI096.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI096.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI096.FieldByName('LIVELLO').AsInteger:=LivMax+1; //1;
  selI096.FieldByName('OBBLIGATORIO').AsString:='S';
  selI096.FieldByName('AVVISO').AsString:='N';
  selI096.FieldByName('VALORI_POSSIBILI').AsString:='S,N';
  selI096.FieldByName('DATI_MODIFICABILI').AsString:='N';
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString:='';
  selI096.FieldByName('INVIO_EMAIL').AsString:='N';
end;

procedure TA115FIterAutorizzativiMW.selI097BeforePost(DataSet: TDataSet);
begin
  inherited;
  if (selI097.FieldByName('BLOCCANTE').AsString <> 'S') and (selI097.FieldByName('BLOCCANTE').AsString <> 'N') then
  raise Exception.Create('I valori permessi nel campo "bloccante" sono S o N.');
end;

procedure TA115FIterAutorizzativiMW.selI097NewRecord(DataSet: TDataSet);
begin
  inherited;
  selI097.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI097.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI097.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI097.FieldByName('NUM_CONDIZ').AsInteger:=-1;
end;

function TA115FIterAutorizzativiMW.GetI091Gruppo(CodI091:String):String;
var i:Integer;
begin
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if DatiEnte[i].Nome = CodI091 then
    begin
      Result:=DatiEnte[i].Gruppo;
      exit
    end;
  Result:=NON_ASSEGNATO;
end;

procedure TA115FIterAutorizzativiMW.AbilitazioniColonneI096;
var AbilitaI096:Boolean;
begin
  //Gestione abilitazioone colonne I096
  AbilitaI096:=ModuloIterAutorizzativi or (selI096.FieldByName('ITER').AsString = ITER_CARTELLINO);
  selI096.FieldByName('LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('DESC_LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('FASE').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('OBBLIGATORIO').Visible:=AbilitaI096;
  selI096.FieldByName('AVVISO').Visible:=AbilitaI096;
  selI096.FieldByName('VALORI_POSSIBILI').Visible:=AbilitaI096;
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').Visible:=AbilitaI096;
  selI096.FieldByName('SCRIPT_AUTORIZZ').Visible:=AbilitaI096;
  selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Visible:=AbilitaI096;
  selI096.FieldByName('ALLEGATI_VISIBILI').Visible:=AbilitaI096;
  selI096.FieldByName('ALLEGATI_OBBLIGATORI').Visible:=AbilitaI096;
end;

procedure TA115FIterAutorizzativiMW.AggiornaI093_I095_I096;
var
  Iter:TIterAutorizzativi;
begin
  for Iter in A000IterAutorizzativi do
  begin
    scrI093P_AGGIORNA_ITER.ClearVariables;
    scrI093P_AGGIORNA_ITER.SetVariable('AZIENDA', AziendaCorrente);
    scrI093P_AGGIORNA_ITER.SetVariable('ITER', Iter.Cod);
    try
      scrI093P_AGGIORNA_ITER.Execute;
    except
    end;
  end;
end;

procedure TA115FIterAutorizzativiMW.AggiornaLivMax;
begin
  try
    LivMax:=0;
    if selI096.Active then
      if selI096.RecordCount > 0 then
      begin
        selI096.Last;
        LivMax:=selI096.FieldByName('LIVELLO').AsInteger;
        selI096.First;
      end;
  except
    on e:exception do
      R180MessageBox(e.message,ERRORE,'Calcolo livello');
  end;
end;

procedure TA115FIterAutorizzativiMW.I093TestExprSQL;
var
  TabIter,MsgErrore,Oggetto,Corpo:String;
  C018DM:TC018FIterAutDM;
  procedure EseguiTestMail(OQ:TOracleQuery; Campo:String);
  var Sez,Dest:String;
  begin
    if Pos('OGGETTO',Campo) > 0 then
      Sez:='l''Oggetto'
    else
      Sez:=' Corpo';
    if Pos('RESP',Campo) > 0 then
      Dest:='l''Autorizzatore'

    else
      Dest:='il Richiedente';
    OQ.SetVariable('OGGETTO',IfThen(Pos('OGGETTO',Campo) > 0,selI093.FieldByName(Campo).AsString,'null'));
    OQ.SetVariable('CORPO',IfThen(Pos('CORPO',Campo) > 0,selI093.FieldByName(Campo).AsString,'null'));
    OQ.SetVariable('TABELLA',C018DM.TabellaIter);
    with FindVariables(UpperCase(selI093.FieldByName(Campo).AsString), False) do
    try
      if OQ.VariableIndex('OPERAZIONE') >= 0 then
        OQ.DeleteVariable('OPERAZIONE');
      if IndexOf('OPERAZIONE') >= 0 then
        OQ.DeclareVariable('OPERAZIONE',otString);
    finally
      Free;
    end;
    try
      OQ.Execute;
    except
      on e:exception do
        raise Exception.CreateFmt('Errore sul%s della mail per %s : %s %s',[Sez,Dest,#13#10,e.Message]);
    end;
  end;
begin
  //Creazione del C018 per utilizzare effettivamente le query contenute in: selMailPerRichiedente e selMailPerAutorizzatore
  C018DM:=TC018FIterAutDM.Create(nil);
  with C018DM do
  try
    Iter:=Self.selI093.FieldByName('ITER').AsString;
    //Verifica script del richiedente
    if not Self.selI093.FieldByName('MAIL_OGGETTO_DIP').IsNull then
      //Oggetto:=Self.selI093.FieldByName('MAIL_OGGETTO_DIP').AsString;
      EseguiTestMail(selMailPerRichiedente,'MAIL_OGGETTO_DIP');
    if not Self.selI093.FieldByName('MAIL_CORPO_DIP').IsNull then
      EseguiTestMail(selMailPerRichiedente,'MAIL_CORPO_DIP');

    //Verifica script dell'autorizzatore
    if not Self.selI093.FieldByName('MAIL_OGGETTO_RESP').IsNull then
      EseguiTestMail(selMailPerAutorizzatore,'MAIL_OGGETTO_RESP');
    if not Self.selI093.FieldByName('MAIL_CORPO_RESP').IsNull then
      EseguiTestMail(selMailPerAutorizzatore,'MAIL_CORPO_RESP');
  finally
    FreeAndNil(C018DM);
  end;

  if not selI093.FieldByName('EXPR_PERIODO_VISUAL').IsNull then
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Text:=Format('select %s from DUAL',[selI093.FieldByName('EXPR_PERIODO_VISUAL').AsString]);
    try
      Execute;
      if FieldType(0) <> otDate then
        raise Exception.Create('L''espressione deve restituire come primo valore una data valida.');
      if (FieldCount > 1) and (FieldType(1) <> otDate) then
        raise Exception.Create('L''espressione deve restituire come secondo valore una data valida.');
    except
      on e:Exception do
        raise Exception.CreateFmt('Errore nel periodo di visualizzazione: %s %s',[#13#10,E.Message]);
    end;
  finally
    Free;
  end;
end;

procedure TA115FIterAutorizzativiMW.ApplyRecordRegistraLog(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
var NomeTabella:String;
begin
  inherited;
  if not (Action in ['I','U','D']) then
     exit;

  if Pos('I093_BASE_ITER_AUT',Sender.SQL.Text) > 0 then
    NomeTabella:='I093_BASE_ITER_AUT'
  else if Pos('I094_CHKDATI_ITER_AUT',Sender.SQL.Text) > 0 then
    NomeTabella:='I094_CHKDATI_ITER_AUT'
  else if Pos('I095_ITER_AUT',Sender.SQL.Text) > 0 then
    NomeTabella:='I095_ITER_AUT'
  else if Pos('I096_LIVELLI_ITER_AUT',Sender.SQL.Text) > 0 then
    NomeTabella:='I096_LIVELLI_ITER_AUT'
  else if Pos('I097_VALIDITA_ITER_AUT',Sender.SQL.Text) > 0 then
    NomeTabella:='I097_VALIDITA_ITER_AUT';

  if RegistraLogSecondario <> nil then
  begin
    if NomeTabella <> '' then
    begin
      case Action of
        'I':RegistraLogSecondario.SettaProprieta('I',NomeTabella,'A008',Sender,True);
        'U':RegistraLogSecondario.SettaProprieta('M',NomeTabella,'A008',Sender,True);
        'D':RegistraLogSecondario.SettaProprieta('C',NomeTabella,'A008',Sender,True);
      end;
      RegistraLogSecondario.RegistraOperazione;
    end;
  end;
end;

procedure TA115FIterAutorizzativiMW.CaricaCdsBloccoRiep;
var i:integer;
begin
  while not cdsBloccoRiep.Eof do
    cdsBloccoRiep.Delete;

  for i:=0 to High(lstRiepiloghi) do
  begin
    cdsBloccoRiep.Insert;
    cdsBloccoRiep.FieldByName('CODICE').AsString:=Trim(Copy(lstRiepiloghi[i],1,5));
    cdsBloccoRiep.FieldByName('DESCRIZIONE').AsString:=Copy(lstRiepiloghi[i],1,Length(lstRiepiloghi[i]));
    cdsBloccoRiep.Post;
  end;
  cdsBloccoRiep.IndexDefs.Add('INDICE1','CODICE',[]);
  cdsBloccoRiep.IndexName:='INDICE1';
end;

procedure TA115FIterAutorizzativiMW.check_I095;
var
  MassimoI095: Integer;
  Iter,CodIter: String;
begin
  if not selI095.Active then
    exit;
  Iter:=selI095.FieldByName('ITER').AsString;
  CodIter:=selI095.FieldByName('COD_ITER').AsString;
  try
    selI095.DisableControls;
    selI095.First;
    MassimoI095:=0;
    while not selI095.Eof do
    begin
      if selI095.FieldByName('FILTRO_RICHIESTA').IsNull then
        Inc(MassimoI095);
      if MassimoI095 > 1 then
      begin
        break;
      end;
      selI095.Next;
    end;
    selI095.SearchRecord('ITER;COD_ITER',VarArrayOf([Iter,CodIter]),[srFromBeginning]);
    if MassimoI095 > 1 then
    begin
      raise Exception.Create('Impossibile inserire più di un "Condiz. per riconoscimento Codice Iter" nullo per l''iter ' + CodIterToDesc(selI093.FieldByName('ITER').AsString));
    end;
  finally
    selI095.EnableControls;
  end;
end;

procedure TA115FIterAutorizzativiMW.check_I096;
var
  MassimoI096: Integer;
  Iter,CodIter: String;
begin
  if not selI096.Active then
    exit;
  Iter:=selI096.FieldByName('ITER').AsString;
  CodIter:=selI096.FieldByName('COD_ITER').AsString;
  //Per ogni struttura verifico completezza di livelli per ogni iter + cod_iter
  try
    selI096.DisableControls;
    selI096.First;
    MassimoI096:=0;
    while not selI096.Eof do
    begin
      MassimoI096:=Max(MassimoI096,selI096.FieldByName('LIVELLO').AsInteger);
      selI096.Next;
    end;
    selI096.SearchRecord('ITER;COD_ITER',VarArrayOf([Iter,CodIter]),[srFromBeginning]);
    if MassimoI096 <> selI096.RecordCount then
    begin
      raise Exception.Create(Format('Livelli non consecutivi per l''iter "%s" e codice iter "%s"',
                            [A000GetDescIter(selI096.FieldByName('ITER').AsString),
                            selI096.FieldByName('COD_ITER').AsString]));
    end;
  finally
    selI096.EnableControls;
  end;
end;

function TA115FIterAutorizzativiMW.CodIterToDesc(param:String):String;
var
  Iter:TIterAutorizzativi;
begin
  Result:='<sconosciuto>';
  if param <> '' then
  begin
    for Iter in A000IterAutorizzativi do
    begin
      if Iter.Cod = param then
      begin
        Result:=Iter.Desc;
        Break;
      end;
    end;
  end;
end;

end.

unit A136UComposizioneRelazioneMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, DBClient, OracleData, Provider, StrUtils, Clipbrd,
  A000UCostanti, A000USessione, Oracle;

type
  TRelazioniStampa = record
    Decorrenza: TDateTime;
    TabPilotata:string;
    ColPilotata:string;
    TabPilota: string;
    ColPilota: string;
    NomeCds: string;
    LivCds: integer;
    Cds:TClientDataSet;
  end;

  TSerie = record
    SL: TStringList;
  end;

  TCampi = record
    NomeCampoTab:String;
  end;

  TCampiStorici = record
    NomeCampoCDS:String;
    NomeCampoTab:String;
  end;

  TDecRel = record
    Decorrenza: TDateTime;
  end;

  TA136FComposizioneRelazioneMW = class(TR005FDataModuleMW)
    cdsCampiRelazioni: TClientDataSet;
    cdsCampiRelazioniVALOREPILOTATO: TStringField;
    cdsCampiRelazioniVALOREPILOTA: TStringField;
    insI035: TOracleQuery;
    selI030a: TOracleDataSet;
    cdsStampa: TClientDataSet;
    selPilotatoStampa: TOracleDataSet;
    selPilotaStampa: TOracleDataSet;
    selI035a: TOracleDataSet;
    cdsAppoggio: TClientDataSet;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    DStampa: TDataSource;
    crea_X001: TOracleQuery;
    selX001: TOracleDataSet;
    cdsSpostaLivRel: TClientDataSet;
    StringField9: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    selI030b: TOracleDataSet;
    selI030bTABELLA: TStringField;
    selI030bCOLONNA: TStringField;
    selI030bDECORRENZA: TDateTimeField;
    selI030bDECORRENZA_FINE: TDateTimeField;
    selI030bORDINE: TIntegerField;
    selI030bTIPO: TStringField;
    selI030bD_TIPO: TStringField;
    selI030bTAB_ORIGINE: TStringField;
    selI030bCOL_ORIGINE: TStringField;
    selI035b: TOracleDataSet;
    cdsDatiDecFine: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI030bCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    ListaValoriStampa: TStringList;
    RelStampa: array of TRelazioniStampa;
    recCampiStorici: array of TCampiStorici;
    MaxLivUsato: Integer;
    function RelazioneStandard(DecFin:TDateTime; var ColPilota:String): Boolean;
    function ValoriPilotaStampa(DecFin:TDateTime; ColPilota: String): Boolean;
    function ControlloLivelli: Integer;
  public
    { Public declarations }
    SqlRel:String;
    lstRelazione:TStringList;
    ColPilota:String;
    selI030:TOracleDataSet;
    function RecuperaDecorrenzeStrutturaCDC(Struttura:String;DataDa,DataA:TDateTime): String;
    procedure ComponiRelazione;
    procedure RiscriviSQLRelazione;
    procedure GestioneStampa(Tipo:String;DecIni,DecFin:TDateTime;VisDecorrenza,VisNomeCampo,VisCodice,VisDescrizione,VisScadenza:Boolean;TabPartenza,ColPartenza,Struttura:String;LivelliDaEstrarre:Integer;SLRDecRel:TDateTime;SLRColPilota,SLRColPilotata:String);
    procedure VisualizzaColonne(VisDecorrenza,VisNomeCampo,VisCodice,VisDescrizione,VisScadenza,InvertiOrdine:Boolean);
    procedure SpostaLivelloRelazione(TabPilota,ColPilota,ColPilotato1,ColPilotato2:String;DecIni,DecFin:TDateTime;var DecRel:TDateTime);
    procedure InvertiOrdineLetturaCampi;
    procedure ImpostaOrdinamento;
    procedure ChiusuraCodici;
    procedure CancellaRecordDoppi;
    procedure ImpostaPrimaDecorrenzaCodici;
    procedure VisualizzaSoloVariazioni(DataDaCancellare:TDateTime;NomeCampoDecorrenza:String);
    procedure EstrazioneX001(TableSpace,NomeCampo:String;Livelli,VersioneDB:Integer);
  end;

var
  A136FComposizioneRelazioneMW: TA136FComposizioneRelazioneMW;

implementation

{$R *.dfm}

procedure TA136FComposizioneRelazioneMW.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  //Serve per gestione B014
  if Self.Owner is TOracleSession then
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=(Self.Owner as TOracleSession);
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=(Self.Owner as TOracleSession);
    end
    //InsI035.Session:=(Self.Owner as TOracleSession)
  else
    inherited;
  cdsCampiRelazioni.CreateDataSet;
  cdsCampiRelazioni.LogChanges:=False;
  cdsAppoggio.CreateDataSet;
  cdsAppoggio.LogChanges:=False;
  cdsSpostaLivRel.CreateDataSet;
  cdsSpostaLivRel.LogChanges:=False;
  cdsDatiDecFine.CreateDataSet;
  cdsDatiDecFine.LogChanges:=False;
  lstRelazione:=TStringList.Create;
end;

procedure TA136FComposizioneRelazioneMW.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  FreeAndNil(lstRelazione);
  for i := 0 to High(RelStampa) do
    FreeAndNil(RelStampa[i].Cds);
  FreeAndNil(ListaValoriStampa);
  cdsCampiRelazioni.Free;
  cdsDatiDecFine.Free;
  cdsSpostaLivRel.Free;
  cdsAppoggio.Free;
  cdsStampa.Free;
end;

procedure TA136FComposizioneRelazioneMW.selI030bCalcFields(DataSet: TDataSet);
var
  S,CampoPilota,Appoggio: String;
begin
  inherited;
  //Estraggo il campo pilota se c'è ed è l'unico
  S:='';
  with selI035b do
  begin
    Close;
    SetVariable('TABELLA',selI030b.FieldByName('TABELLA').AsString);
    SetVariable('COLONNA',selI030b.FieldByName('COLONNA').AsString);
    SetVariable('DECORRENZA',selI030b.FieldByName('DECORRENZA').AsDateTime);
    Open;
    while not Eof do
    begin
      S:=S + ' ' + FieldByName('RELAZIONE').AsString;
      Next;
    end;
  end;
  S:=Trim(S);
  CampoPilota:='';
  Appoggio:='';
  //Cerco tutte le colonne pilota specificate nella relazione
  while Pos('<#>',S) > 0 do
  begin
    //Controllo se si fa riferimento sempre ad una sola colonna pilota
    Appoggio:=Copy(S,Pos('<#>',S)+3,Pos('<#>',Copy(S,Pos('<#>',S)+3))-1);
    if (Appoggio = ';') or (Appoggio = 'D') or (Appoggio = 'W') then
    begin
      S:=Copy(S,Pos(Appoggio,S)+Length(Appoggio)+3);
      Continue;
    end;
    if (CampoPilota <> '') and (Appoggio <> CampoPilota) then
      Exit;
    CampoPilota:=Appoggio;
    S:=Copy(S,Pos(CampoPilota,S)+Length(CampoPilota)+3);
  end;
  selI030b.FieldByName('COL_ORIGINE').AsString:=CampoPilota;
end;

// GESTIONE B014 PER IA140_I030

procedure TA136FComposizioneRelazioneMW.ComponiRelazione;
var
  Abbinamenti,ValorePilota,ValorePilotato,CondizionePilota,CondizionePilotato:String;
  T,C,D,Storico:String;
  i:Integer;
begin
  //Inizializzazioni
  SqlRel:='';
  lstRelazione.Clear;
  Screen.Cursor:=crHourGlass;
  //Se la relazione è di tipo Filtro...
  if selI030.FieldByName('TIPO').AsString = 'F' then
  begin
    with cdsCampiRelazioni do
    begin
      DisableControls;
      IndexName:='IND_PILOTA';
      First;
      ValorePilota:=FieldByName('VALOREPILOTA').AsString;
      if selI030.FieldByName('TABELLA').AsString = 'T430_STORICO' then
        A000GetTabella(selI030.FieldByName('COLONNA').AsString,T,C,Storico,selI030.Session)
      else if selI030.FieldByName('TABELLA').AsString = 'P430_ANAGRAFICO' then
        A000GetTabellaP430(selI030.FieldByName('COLONNA').AsString,T,C,Storico);
      if T = 'T480_COMUNI' then
        D:='CITTA DESCRIZIONE'
      else if (T = 'T430_STORICO') or (T = 'P430_ANAGRAFICO') then
        D:='NULL DESCRIZIONE'
      else
        D:='DESCRIZIONE';
      //Ciclo sui valori impostati
      for i := 1 to RecordCount + 1 do
      begin
        //Aggiungo i valori pilotati finché non cambia il valore pilota, non sono finiti i record o non trovo il valore pilotato Null
        if (Trim(ValorePilotato) <> ''''',') and (ValorePilota = FieldByName('VALOREPILOTA').AsString) and (not Eof) and (Length(ValorePilotato) < 750) then
          ValorePilotato:=ValorePilotato + '''' + FieldByName('VALOREPILOTATO').AsString + ''','
        else
        begin
          //Se il valore pilotato non è vuoto...
          if Trim(ValorePilotato) <> ''''',' then
            CondizionePilotato:='IN (' + Copy(ValorePilotato,1,Length(ValorePilotato)-1) + ')'
          else
            CondizionePilotato:='IS NULL';
          //Se il valore pilota è vuoto...
          if ValorePilota = '' then
          begin
            ValorePilota:='NULL';
            CondizionePilota:='IS ' + ValorePilota;
          end
          else
          begin
            ValorePilota:='''' + ValorePilota + '''';
            CondizionePilota:='= ' + ValorePilota;
          end;
          //Vado a capo quando inserisco la UNION
          if SqlRel <> '' then
          begin
            SqlRel:=SqlRel + #13 + ' UNION ';
            Abbinamenti:='UNION ';
          end;
          //Imposto la singola relazione
          SqlRel:=SqlRel + Format('SELECT DISTINCT %s, %s FROM %s WHERE %s %s AND %s %s',[C,D,T,C,CondizionePilotato,'<#>' + ColPilota + '<#>',CondizionePilota]);
          lstRelazione.Add(Abbinamenti + Format('SELECT DISTINCT %s, %s FROM %s WHERE %s %s AND %s %s',[C,D,T,C,CondizionePilotato,'<#>' + ColPilota + '<#>',CondizionePilota]));
          //Ridefinisco il valore pilota e il primo valore pilotato
          if not Eof then
          begin
            ValorePilota:=FieldByName('VALOREPILOTA').AsString;
            ValorePilotato:='''' + FieldByName('VALOREPILOTATO').AsString + ''',';
          end;
        end;
        Next;
      end;
      //Aggiungo l'Order By
      if SqlRel <> '' then
      begin
        SqlRel:=SqlRel + Format(' ORDER BY %s',[C]);
        lstRelazione.Add(Format('ORDER BY %s',[C]));
      end;
      IndexName:='IND_PILOTATO';
      EnableControls;
    end;
  end
  //Se la relazione è di tipo Vincolato o Libero...
  else if (selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L') then
  begin
    with cdsCampiRelazioni do
    begin
      DisableControls;
      IndexName:='IND_PILOTATO';
      First;
      I:=0;
      //Ciclo su tutti i valori impostati
      while not Eof do
      begin
        //Registro solo gli abbinamenti delle assegnazioni significative
        if FieldByName('VALOREPILOTATO').AsString <> '' then
        begin
          //Imposto il valore pilota
          if FieldByName('VALOREPILOTA').AsString = '' then
            ValorePilota:='NULL,'
          else
            ValorePilota:='''' + FieldByName('VALOREPILOTA').AsString + ''',';
          //Imposto il valore pilotato
          ValorePilotato:='''' + FieldByName('VALOREPILOTATO').AsString + ''',';
          //Abbino i valori nell'SQL della relazione
          Abbinamenti:=Abbinamenti + ValorePilota + ValorePilotato;
          I:=I+1;
          //Verifico di spezzare la riga quando supero i 750 caratteri o le 100 coppie
          if (I = 100) or (Length(Abbinamenti) >= 750) then
          begin
            if SqlRel <> '' then
              SqlRel:=SqlRel + #13;
            SqlRel:=SqlRel + 'DECODE(<#>' + ColPilota + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#> ';
            lstRelazione.Add('DECODE(<#>' + ColPilota + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#>');
            I:=0;
            Abbinamenti:='';
          end;
        end;
        Next;
      end;
      //Se ci sono stati degli abbinamenti, imposto la Decode
      if Abbinamenti <> '' then
      begin
        if SqlRel <> '' then
          SqlRel:=SqlRel + #13;
        SqlRel:=SqlRel + 'DECODE(<#>' + ColPilota + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#> ';
        lstRelazione.Add('DECODE(<#>' + ColPilota + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#>');
      end;
      IndexName:='IND_PILOTA';
      EnableControls;
    end;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA136FComposizioneRelazioneMW.RiscriviSQLRelazione;
var
  i:Integer;
begin
  for i := 1 to lstRelazione.Count do
  begin
    insI035.SetVariable('TABELLA',selI030.FieldByName('TABELLA').AsString);
    insI035.SetVariable('COLONNA',selI030.FieldByName('COLONNA').AsString);
    insI035.SetVariable('DECORRENZA',selI030.FieldByName('DECORRENZA').AsDateTime);
    insI035.SetVariable('NUM',i);
    insI035.SetVariable('RELAZIONE',lstRelazione[i-1]);
    insI035.Execute;
  end;
end;

// FINE GESTIONE B014 PER IA140_I030

// INIZIO GESTIONE STAMPA RELAZIONI

procedure TA136FComposizioneRelazioneMW.GestioneStampa(Tipo:String;DecIni,DecFin:TDateTime;VisDecorrenza,VisNomeCampo,VisCodice,VisDescrizione,VisScadenza:Boolean;TabPartenza,ColPartenza,Struttura:String;LivelliDaEstrarre:Integer;SLRDecRel:TDateTime;SLRColPilota,SLRColPilotata:String);
var
  i,MaxLiv:integer;
  S,PilotiScorsi,ColPilota,TabPilotata,ColPilotata,ValPilotata: String;

  procedure RegistraRecord;
  var
    i:integer;
  begin
    for i:=0 to cdsStampa.FieldCount - 1 do
      if not cdsStampa.Fields[i].IsNull then
      begin
        cdsStampa.Post;
        Break;
      end;
    if cdsStampa.State = dsInsert then
     cdsStampa.Cancel;
  end;

  procedure ScriviCdsStampa(XTabPilotata,XColPilotata,XValPilotata:String;LivUsato:Integer);
  var xx:Integer;
  begin
    if (LivelliDaEstrarre = 0) or (LivUsato < LivelliDaEstrarre) then
      for xx := 0 to High(RelStampa) do
        //Se trovo un nuovo livello gerarchico...
        if (RelStampa[xx].TabPilota = XTabPilotata)
        and (RelStampa[xx].ColPilota = XColPilotata)
        and ((Struttura = '') or (Pos(',' + RelStampa[xx].ColPilotata + ',',',' + Struttura + ',') > 0)) then
        begin
          cdsStampa.FieldByName('Decorrenza'+IntToStr(LivUsato)).AsDateTime:=RelStampa[xx].Decorrenza;
          cdsStampa.FieldByName('NomeCampo'+IntToStr(LivUsato)).AsString:=RelStampa[xx].ColPilotata;
          if VarToStr(RelStampa[xx].Cds.Lookup('VALOREPILOTA',XValPilotata,'VALOREPILOTATO')) <> '' then
          begin
            cdsStampa.FieldByName('Codice'+IntToStr(LivUsato)).AsString:=VarToStr(RelStampa[xx].Cds.Lookup('VALOREPILOTA',XValPilotata,'VALOREPILOTATO'));
            cdsStampa.FieldByName('Descrizione'+IntToStr(LivUsato)).AsString:=VarToStr(RelStampa[xx].Cds.Lookup('VALOREPILOTA',XValPilotata,'DESCRIZIONEPILOTATO'));
            if LivUsato > MaxLivUsato then
              MaxLivUsato:=LivUsato;
            ScriviCdsStampa(RelStampa[xx].TabPilotata,RelStampa[xx].ColPilotata,VarToStr(RelStampa[xx].Cds.Lookup('VALOREPILOTA',XValPilotata,'VALOREPILOTATO')),LivUsato + 1);
          end
          else
          begin
            RegistraRecord;
            cdsStampa.Append;
          end;
        end;
    RegistraRecord;
    cdsStampa.Append;
  end;

begin
  Screen.Cursor:=crHourGlass;
  PilotiScorsi:=',';
  try
    //Distruzione degli elementi
    for i := 0 to High(RelStampa) do
      FreeAndNil(RelStampa[i].Cds);
    FreeAndNil(ListaValoriStampa);
    cdsStampa.ReadOnly:=False;
    if cdsStampa.Active then
      cdsStampa.EmptyDataSet;
    cdsStampa.FieldDefs.Clear;
    cdsStampa.IndexDefs.Clear;
    cdsStampa.IndexName:='';
    cdsStampa.Close;
  except
  end;
  //Svuoto il vettore delle relazioni da stampare
  SetLength(RelStampa,0);
  //Estraggo le testate delle relazioni
  with selI030a do
  begin
    Close;
    SetVariable('TIPO',Tipo);
    SetVariable('DECORRENZA',DecIni);
    if Struttura <> '' then
      S:='AND COLONNA IN (''' + StringReplace(Copy(Struttura,Pos(',',Struttura) + 1),',',''',''',[rfReplaceAll]) + ''')'
    else
      S:='';
    SetVariable('GESTIONE_STRUTTURA',S);
    Open;
    if RecordCount = 0 then
    begin
      Screen.Cursor:=crDefault;
      raise Exception.Create('Non ci sono relazioni da elaborare!');
    end;
    //Per ogni relazione estratta
    while not Eof do
    begin
      //Se la relazione è standard la registro nel vettore RelStampa
      if (FieldByName('COLONNA').AsString = SLRColPilotata) or RelazioneStandard(DecFin,ColPilota) then
      begin
        if FieldByName('COLONNA').AsString = SLRColPilotata then
        begin
          ColPilota:=SLRColPilota;
          cdsAppoggio.EmptyDataSet;
          cdsAppoggio.Data:=cdsSpostaLivRel.Data;
        end;
        SetLength(RelStampa,Length(RelStampa) + 1);
        i:=High(RelStampa);
        RelStampa[i].Decorrenza:=FieldByName('DECORRENZA').AsDateTime;
        RelStampa[i].TabPilotata:=FieldByName('TABELLA').AsString;
        RelStampa[i].ColPilotata:=FieldByName('COLONNA').AsString;
        RelStampa[i].TabPilota:=FieldByName('TAB_ORIGINE').AsString;
        RelStampa[i].ColPilota:=ColPilota;
        RelStampa[i].NomeCds:='cdsRel'+IntToStr(i);
        RelStampa[i].LivCds:=0;
        RelStampa[i].Cds:=TClientDataSet.Create(nil);
        RelStampa[i].Cds.Name:='cdsRel'+IntToStr(i);
        //Carico il cds della relazione, con i dati caricati in cdsAppoggio
        with TDataSetProvider.Create(nil) do
        try
          DataSet:=cdsAppoggio;
          RelStampa[i].Cds.FieldDefs.Clear;
          RelStampa[i].Cds.IndexDefs.Clear;
          RelStampa[i].Cds.IndexName:='';
          RelStampa[i].Cds.Data:=Data;
          RelStampa[i].Cds.LogChanges:=False;
        finally
          Free;
          cdsAppoggio.EmptyDataSet;
        end;
      end;
      Next;
    end;
  end;
  //Creo 4 colonne per il campo pilota
  cdsStampa.FieldDefs.Add('Decorrenza',ftDateTime);
  cdsStampa.FieldDefs.Add('NomeCampo',ftString,50);
  cdsStampa.FieldDefs.Add('Codice',ftString,50);
  cdsStampa.FieldDefs.Add('Descrizione',ftString,500);
  //Creo 4 colonne per ogni livello gerarchico delle relazioni da stampare
  MaxLiv:=ControlloLivelli;
  MaxLivUsato:=0;
  for i:=0 to MaxLiv do
  begin
    cdsStampa.FieldDefs.Add('Decorrenza'+IntToStr(i),ftDateTime);
    cdsStampa.FieldDefs.Add('NomeCampo'+IntToStr(i),ftString,50);
    cdsStampa.FieldDefs.Add('Codice'+IntToStr(i),ftString,50);
    cdsStampa.FieldDefs.Add('Descrizione'+IntToStr(i),ftString,500);
  end;
  cdsStampa.FieldDefs.Add('Scadenza',ftDateTime);
  cdsStampa.CreateDataSet;
  cdsStampa.LogChanges:=False;
  cdsStampa.DisableControls;        
  //Ciclo sulle relazioni per il caricamento sul cds finale della stampa
  for i:=0 to High(RelStampa) do
  begin
    RelStampa[i].Cds.First;
    //Scrivo sul cds finale partendo solo dalle relazioni "padre" o partendo da una colonna in particolare, se specificata
    if (  ((ColPartenza <> '') and (TabPartenza = RelStampa[i].TabPilota) and (ColPartenza = RelStampa[i].ColPilota) and (RelStampa[i].LivCds <> MaxLiv + 1) and ((Struttura = '') or (Pos(',' + RelStampa[i].ColPilotata + ',',',' + Struttura + ',') > 0)))
        or ((ColPartenza = '') and (RelStampa[i].LivCds = 0)))
    and (Pos(',' + RelStampa[i].TabPilota + '.' + RelStampa[i].ColPilota + ',',PilotiScorsi) = 0) then
    begin
      PilotiScorsi:=PilotiScorsi + RelStampa[i].TabPilota + '.' + RelStampa[i].ColPilota + ',';
      //Ciclo sui dati di ogni cds
      while not RelStampa[i].Cds.Eof do
      begin
        cdsStampa.Append;
        //Inserisco i valori pilota della relazione "padre"
        cdsStampa.FieldByName('Decorrenza').AsDateTime:=RelStampa[i].Decorrenza;
        cdsStampa.FieldByName('NomeCampo').AsString:=RelStampa[i].ColPilota;
        cdsStampa.FieldByName('Codice').AsString:=RelStampa[i].Cds.FieldByName('VALOREPILOTA').AsString;
        cdsStampa.FieldByName('Descrizione').AsString:=RelStampa[i].Cds.FieldByName('DESCRIZIONEPILOTA').AsString;
        //Imposto le coordinate del dato pilotato
        TabPilotata:=RelStampa[i].TabPilota;
        ColPilotata:=RelStampa[i].ColPilota;
        ValPilotata:=RelStampa[i].Cds.FieldByName('VALOREPILOTA').AsString;
        ScriviCDSStampa(TabPilotata,ColPilotata,ValPilotata,0);
        RegistraRecord;
        RelStampa[i].Cds.Next;
      end;
    end;
  end;
  cdsStampa.First;
  VisualizzaColonne(VisDecorrenza,VisNomeCampo,VisCodice,VisDescrizione,VisScadenza,False);
  cdsStampa.EnableControls;
  cdsStampa.ReadOnly:=True;
  Screen.Cursor:=crDefault;
end;

function TA136FComposizioneRelazioneMW.RelazioneStandard(DecFin:TDateTime; var ColPilota:String):Boolean;
var
  T,C,D,S,S1,S2,Storico,CampoPilota,Appoggio,SQLRelStampa:String;
  //ValorePilota,ValorePilotato,
  sAbbinaValori:String;
  //bUnion,bValoriPilotatiDuplicati:Boolean;
  //i,j:Integer;
begin
  Result:=True;
  //Inizializzazione
  ListaValoriStampa:=TStringList.Create;
  //Recupero relazione da I035
  with selI035a do
  begin
    Close;
    SetVariable('TABELLA',selI030a.FieldByName('TABELLA').AsString);
    SetVariable('COLONNA',selI030a.FieldByName('COLONNA').AsString);
    SetVariable('DECORRENZA',selI030a.FieldByName('DECORRENZA').AsDateTime);
    Open;
    SQLRelStampa:='';
    while not Eof do
    begin
      SQLRelStampa:=SQLRelStampa + FieldByName('RELAZIONE').AsString + ' ';
      Next;
    end;
  end;
  SQLRelStampa:=Trim(SQLRelStampa);
  //Estraggo i dati dalla tabella di riferimento della colonna pilotata
  if selI030a.FieldByName('TABELLA').AsString = 'T430_STORICO' then
    A000GetTabella(selI030a.FieldByName('COLONNA').AsString,T,C,Storico,selI030a.Session)
  else if selI030a.FieldByName('TABELLA').AsString = 'P430_ANAGRAFICO' then
    A000GetTabellaP430(selI030a.FieldByName('COLONNA').AsString,T,C,Storico);
  if (T <> '') and (T <> 'T030_ANAGRAFICO') then
  begin
    selPilotatoStampa.Close;
    selPilotatoStampa.SQL.Clear;
    //Imposto la colonna Descrizione in base alla tabella di provenienza
    if (T = 'T430_STORICO') or (T = 'P430_ANAGRAFICO') then
      D:='NULL DESCRIZIONE'
    else if T = 'T480_COMUNI' then
      D:='CITTA DESCRIZIONE'
    else
      D:='DESCRIZIONE';
    if Storico = 'S' then
    begin
      selPilotatoStampa.SQL.Add('SELECT DISTINCT ' + C + ' CODICE, ' + D + ' FROM ' + T + ' T1 WHERE ');
      selPilotatoStampa.SQL.Add('T1.DECORRENZA = (SELECT MAX(T2.DECORRENZA) FROM ' + T + ' T2 WHERE T1.' + C + ' = T2.' + C);
// Danilo 02/10/2008      selPilota.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
// Danilo 12/01/2009      selPilotatoStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + IfThen(selI030a.FieldByName('DECORRENZA_FINE').IsNull,'31/12/3999',FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA').AsDateTime)) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
// Danilo 27/10/2009      selPilotatoStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + IfThen(selI030a.FieldByName('DECORRENZA_FINE').IsNull,'31/12/3999',FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA_FINE').AsDateTime)) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
      selPilotatoStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + IfThen(DecFin <> 0,FormatDateTime('dd/mm/yyyy',DecFin),IfThen(selI030a.FieldByName('DECORRENZA_FINE').IsNull,'31/12/3999',FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA_FINE').AsDateTime))) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
    end
    else
      selPilotatoStampa.SQL.Add(Format('SELECT DISTINCT %s CODICE, %s FROM %s ORDER BY %s',[C,D,T,C]));
    try
      selPilotatoStampa.Open;
      sAbbinaValori:='';
      (*Danilo 15/04/2010: Il codice non gestisce bene il Tipo Filtrato, quindi viene remmato per eventuali sviluppi futuri
      //Se la relazione è di tipo Filtro...
      if selI030a.FieldByName('TIPO').AsString = 'F' then
      begin
        //Controllo se l'inizio della relazione è standard
        if Copy(SQLRelStampa,1,15) = 'SELECT DISTINCT' then
        begin
          ListaValoriStampa.Clear;
          S:=SQLRelStampa;
          CampoPilota:='';
          Appoggio:='';
          while Pos('<#>',S) > 0 do
          begin
            //Controllo se si fa riferimento sempre ad una sola colonna pilota
            Appoggio:=Copy(S,Pos('<#>',S)+3,Pos('<#>',Copy(S,Pos('<#>',S)+3))-1);
            if (Appoggio = ';') or (Appoggio = 'D') or (Appoggio = 'W') then
            begin
              S:=Copy(S,Pos(Appoggio,S)+Length(Appoggio)+3);
              Continue;
            end;
            if (CampoPilota <> '') and (Appoggio <> CampoPilota) then
            begin
              Result:=False;
              exit;
            end;
            CampoPilota:=Appoggio;
            S:=Copy(S,Pos(CampoPilota,S)+Length(CampoPilota)+3);
          end;
          if not ValoriPilotaStampa(DecFin,CampoPilota) then
          begin
            Result:=False;
            exit;
          end;
          S:=SQLRelStampa;
          S:=Copy(S,Pos('FROM',S));
          //Cerco tutti i valori pilotati specificati nella relazione
          while (Pos('(',S) > 0) or (Pos('NULL',S) > 0) do
          begin
            //Cerco il valore pilotato di riferimento (o è NULL o inizia con la parentesi)
            if ((Pos('(',S) > 0) and (Pos('NULL',S) > 0) and (Pos('(',S) < Pos('NULL',S))) or
               ((Pos('(',S) > 0) and (Pos('NULL',S) = 0)) then
            begin
              //...Il più vicino ha la parentesi
              ValorePilotato:=Copy(S,Pos('(',S)+1,Pos(')',S)-Pos('(',S)-1);
            end
            else if ((Pos('(',S) > 0) and (Pos('NULL',S) > 0) and (Pos('(',S) > Pos('NULL',S))) or
                    ((Pos('(',S) = 0) and (Pos('NULL',S) > 0)) then
            begin
              //...Il più vicino ha il null
              ValorePilotato:='NULL';
            end;
            //ValorePilotato:=Copy(S,Pos('(',S)+1,Pos(')',S)-Pos('(',S)-1);
            S:=Copy(S,Pos(ValorePilotato,S)+Length(ValorePilotato));
            //Cerco il valore pilota di riferimento (o è NULL o inizia con l'apice)
            if ((Pos('''',S) > 0) and (Pos('NULL',S) > 0) and (Pos('''',S) < Pos('NULL',S))) or
               ((Pos('''',S) > 0) and (Pos('NULL',S) = 0)) then
            begin
              //...Il più vicino ha l'apice
              S:=Copy(S,Pos('''',S)+1);
              ValorePilota:=Copy(S,1,Pos('''',S)-1);
              S:=Copy(S,Pos(ValorePilota,S)+Length(ValorePilota)+1);
            end
            else if ((Pos('''',S) > 0) and (Pos('NULL',S) > 0) and (Pos('''',S) > Pos('NULL',S))) or
                    ((Pos('''',S) = 0) and (Pos('NULL',S) > 0)) then
            begin
              //...Il più vicino ha il null
              S:=Copy(S,Pos('NULL',S));
              ValorePilota:=Copy(S,1,4);
              S:=Copy(S,5);
            end
            else
            begin
              Result:=False;
              exit;
            end;
            //Gestisco il caricamento dei valori pilota/pilotato nella lista
            if ValorePilotato = 'NULL' then
              if ValorePilota = 'NULL' then
                sAbbinaValori:=sAbbinaValori + 'NULL,NULL,'
              else
                sAbbinaValori:=sAbbinaValori + 'NULL,''' + ValorePilota + ''','
            else
            begin
              if ValorePilota <> 'NULL' then
                ValorePilota:='''' + ValorePilota + '''';
              ValorePilotato:=ValorePilotato + ',';
              while Pos(',',ValorePilotato) > 0 do
              begin
                sAbbinaValori:=sAbbinaValori + Copy(ValorePilotato,1,Pos(',',ValorePilotato)) + ValorePilota + ',' ;
                ValorePilotato:=Copy(ValorePilotato,Pos(',',ValorePilotato)+1);
              end;
            end;
            //Cerco l'eventuale Union
            bUnion:=Pos('UNION',S) > 0;
            //Mi posiziono sulla FROM per evitare l'eventuale NULL della Descrizione
            S:=Copy(S,Pos('FROM',S));
            //Se trovo altri valori pilotati ma non la Union o viceversa...
            if (((Pos('(',S) > 0) or  (Pos('NULL',S) > 0)) and not bUnion) or
               (((Pos('(',S) = 0) and (Pos('NULL',S) = 0)) and bUnion) then
            begin
              Result:=False;
              exit;
            end;
          end;
        end
        else if (Trim(SQLRelStampa) <> '') then
        begin
          Result:=False;
          exit;
        end;
        //Carico la lista degli abbinamenti
        ListaValoriStampa.Clear;
        ListaValoriStampa.QuoteChar:='''';
        ListaValoriStampa.Delimiter:=',';
        ListaValoriStampa.StrictDelimiter:=True;
        ListaValoriStampa.DelimitedText:=Copy(sAbbinaValori,1,Length(sAbbinaValori) - 1);
        bValoriPilotatiDuplicati:=False;
        for i := 0 to ListaValoriStampa.Count - 1 do
          if i mod 2 = 0 then
          begin
            for j := 0 to ListaValoriStampa.Count - 1 do
              if (j mod 2 = 0) and (i <> j) and (ListaValoriStampa[i] = ListaValoriStampa[j]) then
              begin
                bValoriPilotatiDuplicati:=True;
                Break;
              end;
            if bValoriPilotatiDuplicati then
              Break;
          end;
        if (bValoriPilotatiDuplicati) then
        begin
          Result:=False;
          exit;
        end;
      end
      //Se la relazione è di tipo Vincolato o Libero...
      else*)
      if (selI030a.FieldByName('TIPO').AsString = 'S') or (selI030a.FieldByName('TIPO').AsString = 'L') then
      begin
        //Controllo se l'SQL contiene gli elementi standard
        if (Copy(SQLRelStampa,1,10) = 'DECODE(<#>') and
           (Pos('<#>D<#>',SQLRelStampa) > 0) and
           (Pos('<#>;<#>',SQLRelStampa) > 0) then
        begin
          S1:=SQLRelStampa;
          while (Pos('<#>D<#>',S1) > 0) and (Pos('<#>;<#>',S1) > 0) do
          begin
            S2:=Copy(S1,Pos('<#>',Copy(S1,Pos('<#>',S1)+3))+Pos('<#>',S1)+3+3);
            if sAbbinaValori <> '' then
              sAbbinaValori:=sAbbinaValori + ',';
            sAbbinaValori:=sAbbinaValori + Copy(S2,1,Pos(')',S2)-1);
            S1:=Copy(S1,Pos('<#>;<#>',S1)+7);
          end;
          //Carico la lista degli abbinamenti
          ListaValoriStampa.Clear;
          ListaValoriStampa.QuoteChar:='''';
          ListaValoriStampa.Delimiter:=',';
          ListaValoriStampa.StrictDelimiter:=True;
          ListaValoriStampa.DelimitedText:=sAbbinaValori;
          //Recupero la colonna pilota
          S:=SQLRelStampa;
          CampoPilota:='';
          Appoggio:='';
          while Pos('<#>',S) > 0 do
          begin
            //Controllo se si fa riferimento sempre ad una sola colonna pilota
            Appoggio:=Copy(S,Pos('<#>',S)+3,Pos('<#>',Copy(S,Pos('<#>',S)+3))-1);
            if (Appoggio = ';') or (Appoggio = 'D') or (Appoggio = 'W') then
            begin
              S:=Copy(S,Pos(Appoggio,S)+Length(Appoggio)+3);
              Continue;
            end;
            if (CampoPilota <> '') and (Appoggio <> CampoPilota) then
            begin
              Result:=False;
              exit;
            end;
            CampoPilota:=Appoggio;
            S:=Copy(S,Pos(CampoPilota,S)+Length(CampoPilota)+3);
          end;
          //
          if CampoPilota <> '' then
            //Recupero i valori pilota provando ad abbinare i valori pilotati
            if not ValoriPilotaStampa(DecFin,CampoPilota) then
            begin
              Result:=False;
              exit;
            end;
        end
        else if (Trim(SQLRelStampa) <> '') then
        begin
          Result:=False;
          exit;
        end;
      end;
    except
      Result:=False;
    end;
  end
  else
  begin
    Result:=False;
    exit;
  end;
  ColPilota:=CampoPilota;
end;

function TA136FComposizioneRelazioneMW.ValoriPilotaStampa(DecFin:TDateTime; ColPilota: String): Boolean;
var
  T,C,D,Storico:String;
  I:Integer;
begin
  Result:=True;
  if selI030a.FieldByName('TAB_ORIGINE').AsString = 'T430_STORICO' then
    A000GetTabella(ColPilota,T,C,Storico,selI030a.Session)
  else if selI030a.FieldByName('TAB_ORIGINE').AsString = 'P430_ANAGRAFICO' then
    A000GetTabellaP430(ColPilota,T,C,Storico);
  if (T <> '') and (T <> 'T030_ANAGRAFICO') then
  begin
    selPilotaStampa.SQL.Clear;
    if (T = 'T430_STORICO') or (T = 'P430_ANAGRAFICO') then
      D:='NULL DESCRIZIONE'
    else if T = 'T480_COMUNI' then
      D:='CITTA DESCRIZIONE'
    else
      D:='DESCRIZIONE';
    if Storico = 'S' then
    begin
      selPilotaStampa.SQL.Add('SELECT DISTINCT ' + C + ' CODICE, ' + D + ' FROM ' + T + ' T1 WHERE ');
      selPilotaStampa.SQL.Add('T1.DECORRENZA = (SELECT MAX(T2.DECORRENZA) FROM ' + T + ' T2 WHERE T1.' + C + ' = T2.' + C);
// Danilo 02/10/2008      selPilota.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
// Danilo 12/01/2009      selPilotaStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA').AsDateTime) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
// Danilo 27/10/2009      selPilotaStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + IfThen(selI030a.FieldByName('DECORRENZA_FINE').IsNull,'31/12/3999',FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA_FINE').AsDateTime)) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
      selPilotaStampa.SQL.Add(' AND T2.DECORRENZA <= TO_DATE(''' + IfThen(DecFin <> 0,FormatDateTime('dd/mm/yyyy',DecFin),IfThen(selI030a.FieldByName('DECORRENZA_FINE').IsNull,'31/12/3999',FormatDateTime('dd/mm/yyyy',selI030a.FieldByName('DECORRENZA_FINE').AsDateTime))) + ''',''dd/mm/yyyy'')) ORDER BY ' + C);
    end
    else
      selPilotaStampa.SQL.Add(Format('SELECT DISTINCT %s CODICE, %s FROM %s ORDER BY %s',[C,D,T,C]));
    selPilotaStampa.Close;
    try
      selPilotaStampa.Open;
      cdsCampiRelazioni.EmptyDataSet;
      while not selPilotaStampa.Eof do
      begin
        //I valori pilota ce li ho sul DataSet
        cdsAppoggio.Append;
        cdsAppoggio.FieldByName('VALOREPILOTA').AsString:=selPilotaStampa.FieldByName('CODICE').AsString;
        cdsAppoggio.FieldByName('DESCRIZIONEPILOTA').AsString:=selPilotaStampa.FieldByName('DESCRIZIONE').AsString;
        //I valori pilotati li cerco sulla lista degli abbinamenti
        for i := 0 to ListaValoriStampa.Count - 1 do
          if (i mod 2 = 0)
          and
             ((ListaValoriStampa[i] = selPilotaStampa.FieldByName('CODICE').AsString) or
              ((ListaValoriStampa[i] = 'NULL') and
               (selPilotaStampa.FieldByName('CODICE').AsString = ''))) then
          begin
            //Se il valore pilotato abbinato è null...
            if ListaValoriStampa[i+1] = 'NULL' then
              cdsAppoggio.FieldByName('VALOREPILOTATO').AsString:=''
            else
            begin
              cdsAppoggio.FieldByName('VALOREPILOTATO').AsString:=ListaValoriStampa[i+1];
              cdsAppoggio.FieldByName('DESCRIZIONEPILOTATO').AsString:=VarToStr(selPilotatoStampa.Lookup('CODICE',ListaValoriStampa[i+1],'DESCRIZIONE'));
            end;
            Break;
          end;
        cdsAppoggio.Post;
        selPilotaStampa.Next;
      end;
    except
      cdsAppoggio.EmptyDataSet;
      Result:=False;
      exit;
    end;
  end
  else
  begin
    Result:=False;
    exit;
  end;
  cdsAppoggio.First;
end;

function TA136FComposizioneRelazioneMW.RecuperaDecorrenzeStrutturaCDC(Struttura:String;DataDa,DataA:TDateTime): String;
var
  CDSDecRel:TClientDataSet;
  T,C,Storico,S:String;
  DSApp:TOracleDataSet;
  i:Integer;
  PrimoCampo:Boolean;
begin
  Result:='';
  cdsDatiDecFine.EmptyDataSet;
  //Recupero le date decorrenza
  cdsDecRel:=TClientDataSet.Create(nil);
  cdsDecRel.Name:='cdsDecRel';
  cdsDecRel.FieldDefs.Add('Decorrenza',ftDateTime);
  cdsDecRel.IndexDefs.Add('I1','Decorrenza',[]);
  cdsDecRel.CreateDataSet;
  cdsDecRel.LogChanges:=False;
  cdsDecRel.Insert;
  cdsDecRel.FieldByName('Decorrenza').AsDateTime:=DataDa;
  cdsDecRel.Post;
  selI030b.Open;
  with selI030b do
  begin
    First;
    while not Eof do
    begin
      if (Pos(',' + FieldByName('COLONNA').AsString + ',',',' + Struttura + ',') > 0)
      and (Pos(',' + FieldByName('COL_ORIGINE').AsString + ',',',' + Struttura + ',') > 0)
      and (FieldByName('DECORRENZA').AsDateTime >= DataDa)
      and (FieldByName('DECORRENZA').AsDateTime <= DataA)
      and not cdsDecRel.Locate('Decorrenza',FieldByName('DECORRENZA').AsDateTime,[]) then
      begin
        cdsDecRel.Insert;
        cdsDecRel.FieldByName('Decorrenza').AsDateTime:=FieldByName('DECORRENZA').AsDateTime;
        cdsDecRel.Post;
      end;
      Next;
    end;
  end;
  S:=Struttura + IfThen(Struttura <> '',',','');
  PrimoCampo:=True;
  SetLength(recCampiStorici,0);
  while Pos(',',S) > 0 do
  begin
    if PrimoCampo then
    begin
      PrimoCampo:=False;
      i:=-1;
    end
    else
      inc(i);
    A000GetTabella(Copy(S,1,Pos(',',S) - 1),T,C,Storico,selI030b.Session);
    if (Storico = 'S') and (Copy(T,1,4) = 'I501') then
    begin
      SetLength(recCampiStorici,length(recCampiStorici) + 1);
      recCampiStorici[High(recCampiStorici)].NomeCampoCDS:='Codice' + IfThen(i = -1,'',IntToStr(i));
      recCampiStorici[High(recCampiStorici)].NomeCampoTab:=Copy(S,1,Pos(',',S) - 1);

      DSApp:=TOracleDataSet.Create(nil);
      DSApp.Session:=selI030b.Session;
      with DSApp do
      begin
        SQL.Clear;
        SQL.Add('select distinct decorrenza from ' + T + ' i1 where decorrenza <>');
        SQL.Add('(select max(i2.decorrenza_fine) + 1 from ' + T + ' i2');
        SQL.Add(' where i2.codice = i1.codice and i2.decorrenza < i1.decorrenza)');
        Open;
        while not Eof do
        begin
          if (FieldByName('DECORRENZA').AsDateTime >= DataDa)
          and (FieldByName('DECORRENZA').AsDateTime <= DataA)
          and not cdsDecRel.Locate('Decorrenza',FieldByName('DECORRENZA').AsDateTime,[]) then
          begin
            cdsDecRel.Insert;
            cdsDecRel.FieldByName('Decorrenza').AsDateTime:=FieldByName('DECORRENZA').AsDateTime;
            cdsDecRel.Post;
          end;
          Next;
        end;
        Close;
        SQL.Clear;
        SQL.Add('select distinct i501.codice from');
        SQL.Add('(select codice, decorrenza_fine');
        SQL.Add('from ' + T + ' i1');
        SQL.Add('where decorrenza_fine <> to_date(''31123999'',''ddmmyyyy'')');
        SQL.Add('and (decorrenza_fine = (select max(decorrenza_fine)');
        SQL.Add('                        from ' + T + ' i3');
        SQL.Add('                        where i3.codice = i1.codice)');
        SQL.Add(' or decorrenza_fine <> (select min(i2.decorrenza) - 1');
        SQL.Add('                        from ' + T + ' i2');
        SQL.Add('                        where i2.codice = i1.codice');
        SQL.Add('                        and i2.decorrenza > i1.decorrenza))) a, ' + T + ' i501');
        SQL.Add('where a.codice = i501.codice');
        SQL.Add('and (a.decorrenza_fine = i501.decorrenza_fine');
        SQL.Add(' or i501.decorrenza_fine = to_date(''31123999'',''ddmmyyyy''))');
        SQL.Add('order by i501.codice');
        Open;
        while not Eof do
        begin
          cdsDatiDecFine.Insert;
          cdsDatiDecFine.FieldByName('DATO').AsString:='Codice' + IfThen(i = -1,'',IntToStr(i));
          cdsDatiDecFine.FieldByName('CODICE').AsString:=FieldByName('CODICE').AsString;
          cdsDatiDecFine.FieldByName('TABELLA').AsString:=T;
          cdsDatiDecFine.Post;
          Next;
        end;
        DSApp.Free;
      end;
    end;
    S:=Copy(S,Pos(',',S) + 1);
  end;
  cdsDecRel.IndexName:='I1';
  cdsDecRel.First;
  while not cdsDecRel.Eof do
  begin
    Result:=Result + cdsDecRel.FieldByName('Decorrenza').AsString + ',';
    cdsDecRel.Next;
  end;
  cdsDecRel.Free;
end;

function TA136FComposizioneRelazioneMW.ControlloLivelli: Integer;
var
  i,j,k: Integer;
  TabPilotata,ColPilotata,TabPilota,ColPilota: String;
  Continua: Boolean;
  Serie: array of TSerie;
begin
  Result:=0;
  SetLength(Serie,0);
  //Ciclo sulle relazioni da stampare
  for i := 0 to High(RelStampa) do
  begin
    if RelStampa[i].LivCds = -1 then
      Continue;
    RelStampa[i].LivCds:=-1;
    //Creo una nuova StringList e carico il primo valore
    SetLength(Serie,Length(Serie) + 1);
    k:=High(Serie);
    Serie[k].SL:=TStringList.Create;
    Serie[k].SL.Add(RelStampa[i].NomeCds);
    //Imposto le coordinate del dato pilotato
    TabPilotata:=RelStampa[i].TabPilotata;
    ColPilotata:=RelStampa[i].ColPilotata;
    Continua:=True;
    //Ciclo finché trovo livelli gerarchici
    while Continua do
    begin
      Continua:=False;
      //Ciclo sulle relazioni da stampare
      for j := 0 to High(RelStampa) do
      begin
        //Se trovo un nuovo livello gerarchico...
        if  (RelStampa[j].TabPilota = TabPilotata)
        and (RelStampa[j].ColPilota = ColPilotata) then
        begin
          //Aggiorno le variabili
          Continua:=True;
          //Aggiorno il livello gerarchico del cds
          RelStampa[j].LivCds:=-1;
          //Carico il valore del livello inferiore
          Serie[k].SL.Add(RelStampa[j].NomeCds);
          //Aggiorno le coordinate del dato pilotato per continuare a cercare
          TabPilotata:=RelStampa[j].TabPilotata;
          ColPilotata:=RelStampa[j].ColPilotata;
          Break;
        end;
      end;
    end;
    //Imposto le coordinate del dato pilota
    TabPilota:=RelStampa[i].TabPilota;
    ColPilota:=RelStampa[i].ColPilota;
    Continua:=True;
    //Ciclo finché trovo livelli gerarchici
    while Continua do
    begin
      Continua:=False;
      //Ciclo sulle relazioni da stampare
      for j := 0 to High(RelStampa) do
      begin
        //Se trovo un nuovo livello gerarchico...
        if  (RelStampa[j].TabPilotata = TabPilota)
        and (RelStampa[j].ColPilotata = ColPilota) then
        begin
          //Aggiorno le variabili
          Continua:=True;
          //Aggiorno il livello gerarchico del cds
          RelStampa[j].LivCds:=-1;
          //Carico il valore del livello superiore
          Serie[k].SL.Insert(0,RelStampa[j].NomeCds);
          //Aggiorno le coordinate del dato pilota per continuare a cercare
          TabPilota:=RelStampa[j].TabPilota;
          ColPilota:=RelStampa[j].ColPilota;
          Break;
        end;
      end;
    end;
  end;
  //Ciclo su tutte le StringList
  for i := 0 to High(Serie) do
    //Ciclo su tutti i valori di ogni StringList
    for j := 0 to Serie[i].SL.Count - 1 do
    begin
      //Restituisco il livello più alto acquisito
      if j > Result then
        Result:=j;
      //Ciclo sulle relazioni da stampare
      for k := 0 to High(RelStampa) do
        if RelStampa[k].NomeCds = Serie[i].SL[j] then
        begin
          //Assegno il livello al cds corrispondente
          RelStampa[k].LivCds:=j;
          Break;
        end;
    end;
  //Distruggo le StringList create
  for i := 0 to High(Serie) do
  begin
    FreeAndNil(Serie[i].SL);
  end;
end;

procedure TA136FComposizioneRelazioneMW.VisualizzaColonne(VisDecorrenza,VisNomeCampo,VisCodice,VisDescrizione,VisScadenza,InvertiOrdine:Boolean);
var
  i:Integer;
begin
  //Imposto la visualizzazione delle 4 colonne per il campo pilota
  cdsStampa.FieldByName('Decorrenza').DisplayWidth:=10;
  cdsStampa.FieldByName('Decorrenza').Visible:=VisDecorrenza and not InvertiOrdine;
  cdsStampa.FieldByName('NomeCampo').DisplayLabel:='Dato pilota';
  cdsStampa.FieldByName('NomeCampo').DisplayWidth:=15;
  cdsStampa.FieldByName('NomeCampo').Visible:=VisNomeCampo;
  cdsStampa.FieldByName('Codice').DisplayLabel:='Codice pilota';
  cdsStampa.FieldByName('Codice').DisplayWidth:=10;
  cdsStampa.FieldByName('Codice').Visible:=VisCodice;
  cdsStampa.FieldByName('Descrizione').DisplayLabel:='Descrizione pilota';
  cdsStampa.FieldByName('Descrizione').DisplayWidth:=25;
  cdsStampa.FieldByName('Descrizione').Visible:=VisDescrizione;
  //Imposto la visualizzazione delle altre colonne per i campi pilotati
  for i:=0 to (cdsStampa.FieldCount div 4) - 2 do
  begin
    cdsStampa.FieldByName('Decorrenza'+IntToStr(i)).DisplayLabel:='Dec. ' + IntToStr(i + 1) + '° liv.';
    cdsStampa.FieldByName('Decorrenza'+IntToStr(i)).DisplayWidth:=10;
    cdsStampa.FieldByName('Decorrenza'+IntToStr(i)).Visible:=VisDecorrenza and ((not InvertiOrdine and (i <= MaxLivUsato) and (i <> 0)) or (InvertiOrdine and (i = MaxLivUsato)));
    cdsStampa.FieldByName('NomeCampo'+IntToStr(i)).DisplayLabel:='Dato pilotato ' + IntToStr(i + 1) + '° liv.';
    cdsStampa.FieldByName('NomeCampo'+IntToStr(i)).DisplayWidth:=15;
    cdsStampa.FieldByName('NomeCampo'+IntToStr(i)).Visible:=VisNomeCampo and (i <= MaxLivUsato);
    cdsStampa.FieldByName('Codice'+IntToStr(i)).DisplayLabel:='Codice ' + IntToStr(i + 1) + '° liv.';
    cdsStampa.FieldByName('Codice'+IntToStr(i)).DisplayWidth:=10;
    cdsStampa.FieldByName('Codice'+IntToStr(i)).Visible:=VisCodice and (i <= MaxLivUsato);
    cdsStampa.FieldByName('Descrizione'+IntToStr(i)).DisplayLabel:='Descrizione ' + IntToStr(i + 1) + '° liv.';
    cdsStampa.FieldByName('Descrizione'+IntToStr(i)).DisplayWidth:=25;
    cdsStampa.FieldByName('Descrizione'+IntToStr(i)).Visible:=VisDescrizione and (i <= MaxLivUsato);
  end;
  cdsStampa.FieldByName('Scadenza').DisplayWidth:=10;
  cdsStampa.FieldByName('Scadenza').Visible:=VisScadenza;
end;

procedure TA136FComposizioneRelazioneMW.SpostaLivelloRelazione(TabPilota,ColPilota,ColPilotato1,ColPilotato2:String;DecIni,DecFin:TDateTime;var DecRel:TDateTime);
var
  CDS1,CDS2: TClientDataSet;
begin
  cdsSpostaLivRel.EmptyDataSet;
  GestioneStampa('''S'',''L''',DecIni,DecFin,False,False,False,False,False,TabPilota,ColPilota,ColPilota + ',' + ColPilotato1,1,0,'','');
  CDS1:=TClientDataSet.Create(nil);
  CDS1.Name:='CDS1';
  //Carico il cds della relazione, con i dati caricati in cdsAppoggio
  with TDataSetProvider.Create(nil) do
  try
    DataSet:=cdsStampa;
    CDS1.FieldDefs.Clear;
    CDS1.IndexDefs.Clear;
    CDS1.IndexName:='';
    CDS1.Data:=Data;
    CDS1.LogChanges:=False;
  finally
    Free;
    cdsStampa.EmptyDataSet;
  end;
  //
  GestioneStampa('''S'',''L''',DecIni,DecFin,False,False,False,False,False,TabPilota,ColPilota,ColPilota + ',' + ColPilotato2,1,0,'','');
  CDS2:=TClientDataSet.Create(nil);
  CDS2.Name:='CDS2';
  //Carico il cds della relazione, con i dati caricati in cdsAppoggio
  with TDataSetProvider.Create(nil) do
  try
    DataSet:=cdsStampa;
    CDS2.FieldDefs.Clear;
    CDS2.IndexDefs.Clear;
    CDS2.IndexName:='';
    CDS2.Data:=Data;
    CDS2.LogChanges:=False;
  finally
    Free;
    cdsStampa.EmptyDataSet;
  end;
  //
  CDS1.First;
  CDS2.First;
  DecRel:=CDS2.FieldByName('Decorrenza').AsDateTime;
  while not CDS1.Eof do
  begin
    if not cdsSpostaLivRel.Locate('VALOREPILOTA;VALOREPILOTATO',VarArrayOf([CDS1.FieldByName('Codice0').AsString,VarToStr(CDS2.Lookup('Codice',CDS1.FieldByName('Codice').AsString,'Codice0'))]),[]) then
    begin
      cdsSpostaLivRel.Last;
      cdsSpostaLivRel.Append;
      cdsSpostaLivRel.FieldByName('VALOREPILOTA').AsString:=CDS1.FieldByName('Codice0').AsString;
      cdsSpostaLivRel.FieldByName('DESCRIZIONEPILOTA').AsString:=CDS1.FieldByName('Descrizione0').AsString;
      cdsSpostaLivRel.FieldByName('VALOREPILOTATO').AsString:=VarToStr(CDS2.Lookup('Codice',CDS1.FieldByName('Codice').AsString,'Codice0'));
      cdsSpostaLivRel.FieldByName('DESCRIZIONEPILOTATO').AsString:=VarToStr(CDS2.Lookup('Codice',CDS1.FieldByName('Codice').AsString,'Descrizione0'));
      cdsSpostaLivRel.Post;
    end;
    CDS1.Next;
  end;
  FreeAndNil(CDS1);
  FreeAndNil(CDS2);
end;

procedure TA136FComposizioneRelazioneMW.InvertiOrdineLetturaCampi;
var
  i,j:Integer;
begin
  //Sposto i campi per leggere gerarchicamente i dati da sinistra verso destra
  for i:=1 to cdsStampa.FieldCount div 4 do
    for j := 1 to 4 do
      cdsStampa.Fields[0].Index:=cdsStampa.FieldCount - 2 - ((i-1)*4);
  cdsStampa.Fields[cdsStampa.FieldCount - 1].Index:=1;
end;

procedure TA136FComposizioneRelazioneMW.ImpostaOrdinamento;
var
  OrderCDS1,OrderCDS2: String;
  i:Integer;
begin
  cdsStampa.IndexDefs.Clear;
  //Creo l'indice per l'ordinamento dei dati
  for i:=0 to cdsStampa.FieldCount - 1 do
    if Pos('Codice',cdsStampa.Fields[i].FieldName) = 1 then
      OrderCDS1:=OrderCDS1 + IfThen(OrderCDS1 <> '',';','') + cdsStampa.Fields[i].FieldName;
  OrderCDS2:=OrderCDS1;
  for i:=0 to cdsStampa.FieldCount - 1 do
    if (Pos('Decorrenza',cdsStampa.Fields[i].FieldName) = 1) and (cdsStampa.Fields[i].Visible) then
    begin
      OrderCDS1:=OrderCDS1 + IfThen(OrderCDS1 <> '',';','') + cdsStampa.Fields[i].FieldName;
      OrderCDS2:=cdsStampa.Fields[i].FieldName + IfThen(OrderCDS2 <> '',';','') + OrderCDS2;
      Break;
    end;
  cdsStampa.IndexDefs.Add('INDICE1',OrderCDS1,[]);
  cdsStampa.IndexDefs.Add('INDICE2',OrderCDS2,[]);
end;

procedure TA136FComposizioneRelazioneMW.ChiusuraCodici;
var
  DsApp:TOracleDataSet;
begin
  cdsStampa.ReadOnly:=False;
  with cdsDatiDecFine do
  begin
    if RecordCount > 0 then
      First;
    while not Eof do
    begin
      cdsStampa.Filter:=FieldByName('DATO').AsString + ' = ''' + FieldByName('CODICE').AsString + '''';
      cdsStampa.Filtered:=True;
      while not cdsStampa.Eof do
      begin
        DSApp:=TOracleDataSet.Create(nil);
        DSApp.Session:=selI030b.Session;
        DSApp.SQL.Clear;
        DSApp.SQL.Add('select max(decorrenza_fine) scadenza from ' + FieldByName('TABELLA').AsString);
        DSApp.SQL.Add('where codice = ''' + FieldByName('CODICE').AsString + '''');
        DSApp.SQL.Add('and decorrenza < to_date(''' + cdsStampa.FieldByName('Scadenza').AsString + ''',''dd/mm/yyyy'')');
        DSApp.Open;
        if not DsApp.Eof then
          if DSApp.FieldByName('SCADENZA').AsDateTime < cdsStampa.FieldByName('Scadenza').AsDateTime then
          begin
            cdsStampa.Edit;
            cdsStampa.FieldByName('Scadenza').AsDateTime:=DSApp.FieldByName('SCADENZA').AsDateTime;
            cdsStampa.Post;
          end;
        DSApp.Free;
        cdsStampa.Next;
      end;
      cdsStampa.Filter:='';
      cdsStampa.Filtered:=False;
      Next;
    end;
  end;
  with cdsStampa do
  begin
    cdsStampa.Filter:='Scadenza < ' + cdsStampa.Fields[0].FieldName;
    Filtered:=True;
    Last;
    while RecordCount > 0 do
      Delete;
    Filter:='';
    Filtered:=False;
  end;
  cdsStampa.ReadOnly:=True;
end;

procedure TA136FComposizioneRelazioneMW.CancellaRecordDoppi;
type
  TDescrizioni = record
    Descrizione: String;
  end;
var
  BM:TBookMark;
  i:Integer;
  sFiltro:String;
  Descrizioni: array of TDescrizioni;
  CodiceValorizzato:Boolean;
  DecIni,Decorrenza,Scadenza:TDateTime;
begin
  with cdsStampa do
  begin
    ReadOnly:=False;
    Filtered:=False;
    Filter:='';
    sFiltro:='';
    First;
    while not Eof do
    begin
      BM:=GetBookMark; { TODO : TEST IW 15 }
	  try
        DecIni:=Fields[0].AsDateTime;
        CodiceValorizzato:=False;
        for i:=0 to FieldCount - 1 do
          if Pos('Codice',Fields[i].FieldName) = 1 then
          begin
            sFiltro:=IfThen(sFiltro <> '',sFiltro + ' AND ',sFiltro);
            sFiltro:=sFiltro + '(' + Fields[i].FieldName + ' = ' + QuotedStr(Fields[i].AsString) + ')';
            if Trim(Fields[i].AsString) <> '' then
              CodiceValorizzato:=True;
          end;
        if CodiceValorizzato then
        begin
          //Filtro i record con gli stessi codici
          Filter:=sFiltro;
          Filtered:=True;
          //Mi posiziono sull'ultimo per iniziare l'appiattimento
          Last;
          Decorrenza:=Fields[0].AsDateTime;
          //L'appiattimento finisce quando sono arrivato al punto di partenza
          while DecIni <> Decorrenza do
          begin
            //Prendo decorrenza e scadenza del record da confrontare
            Decorrenza:=Fields[0].AsDateTime;
            Scadenza:=FieldByName('Scadenza').AsDateTime;
            //Vado al record precedente
            if DecIni <> Decorrenza then
              Prior;
            //Se il periodo precedente è contiguo...
            if FieldByName('Scadenza').AsDateTime + 1 = Decorrenza then
            begin
              //...torno su quello successivo...
              Next;
              //...ne prelevo anche le descrizioni...
              SetLength(Descrizioni,0);
              for i:=0 to FieldCount - 1 do
              begin
                SetLength(Descrizioni,Length(Descrizioni) + 1);
                if Pos('Descrizione',Fields[i].FieldName) = 1 then
                  Descrizioni[High(Descrizioni)].Descrizione:=Fields[i].AsString;
              end;
              //...e lo cancello
              Delete;
              //Ritorno su quello precedente...
              if Fields[0].AsDateTime > Decorrenza then
                Prior;
              //...e gli aggiorno la scadenza e le descrizioni
              Edit;
              FieldByName('Scadenza').AsDateTime:=Scadenza;
              for i:=0 to FieldCount - 1 do
                if Pos('Descrizione',Fields[i].FieldName) = 1 then
                  Fields[i].AsString:=Descrizioni[i].Descrizione;
              Post;
            end;
          end;
        end;
        Filtered:=False;
        Filter:='';
        sFiltro:='';
        GoToBookMark(BM);
	  finally
        FreeBookMark(BM);
	  end;
      Next;
    end;
    for i:=0 to FieldCount - 1 do
      if Pos('Codice',Fields[i].FieldName) = 1 then
      begin
        sFiltro:=IfThen(sFiltro <> '',sFiltro + ' AND ',sFiltro);
        sFiltro:=sFiltro + '(' + Fields[i].FieldName + ' = '''')';
      end;
    Filter:=sFiltro;
    Filtered:=True;
    Last;
    while RecordCount > 0 do
      Delete;
    Filtered:=False;
    Filter:='';
    sFiltro:='';
    ReadOnly:=True;
  end;
end;

procedure TA136FComposizioneRelazioneMW.ImpostaPrimaDecorrenzaCodici;
var
  DsApp:TOracleDataSet;
  i,j:Integer;
begin
  if Length(recCampiStorici) = 0 then
    exit;
  //Per ogni codice storicizzato di ogni riga verifico qual è la minima decorrenza;
  //se la decorrenza della riga è antecedente la pospongo
  cdsStampa.ReadOnly:=False;
  cdsStampa.First;
  while not cdsStampa.Eof do
  begin
    for i:=0 to cdsStampa.FieldCount - 1 do
      if (Copy(cdsStampa.Fields[i].FieldName,1,6) = 'Codice') then
        if (cdsStampa.Fields[i].AsString <> '') then
          for j:=0 to High(recCampiStorici) do
            if cdsStampa.Fields[i].FieldName = recCampiStorici[j].NomeCampoCDS then
            begin
              DSApp:=TOracleDataSet.Create(nil);
              DSApp.Session:=selI030b.Session;
              DSApp.SQL.Clear;
              DSApp.SQL.Add('select min(decorrenza) decorrenza from ' + 'I501' + recCampiStorici[j].NomeCampoTab);
              DSApp.SQL.Add('where codice = ''' + cdsStampa.Fields[i].AsString + '''');
              DSApp.Open;
              if not DsApp.Eof then
                if DSApp.FieldByName('DECORRENZA').AsDateTime > cdsStampa.Fields[0].AsDateTime then
                begin
                  cdsStampa.Edit;
                  cdsStampa.Fields[0].AsDateTime:=DSApp.FieldByName('DECORRENZA').AsDateTime;
                  cdsStampa.Post;
                end;
              DSApp.Free;
              Break;
            end;
    cdsStampa.Next;
  end;
  with cdsStampa do
  begin
    cdsStampa.Filter:='Scadenza < ' + cdsStampa.Fields[0].FieldName;
    Filtered:=True;
    Last;
    while RecordCount > 0 do
      Delete;
    Filter:='';
    Filtered:=False;
  end;
  cdsStampa.ReadOnly:=True;
end;

procedure TA136FComposizioneRelazioneMW.VisualizzaSoloVariazioni(DataDaCancellare:TDateTime;NomeCampoDecorrenza:String);
begin
  with cdsStampa do
    if RecordCount > 0 then
    begin
      First;
      ReadOnly:=False;
      Filter:='';
      Filtered:=False;
      Filter:=NomeCampoDecorrenza + ' = ' + FloatToStr(DataDaCancellare);
      Filtered:=True;
      Last;
      while RecordCount > 0 do
        Delete;
      Filtered:=False;
      Filter:='';
      ReadOnly:=True;
      First;
    end;
end;

// FINE GESTIONE STAMPA RELAZIONI

// INIZIO ESTRAZIONE IN TABELLA X001

procedure TA136FComposizioneRelazioneMW.EstrazioneX001(TableSpace,NomeCampo:String;Livelli,VersioneDB:Integer);
var
  i,k:Integer;
  NomeTabella,NomeCampoCDS,S:String;
  recCampi: array of TCampi;
  function NomeColonna(NomeCampo:String):String;
  begin
    Result:='';
    with cdsStampa do
    begin
      First;
      while not Eof do
      begin
        if FieldByName(NomeCampo).AsString <> '' then
        begin
          Result:=FieldByName(NomeCampo).AsString;
          Break;
        end;
        Next;
      end;
      First;
    end;
  end;
begin
  //Ricavare nome tabella X001_nomecampo_livello
  NomeTabella:='X001_' + Trim(Format('%22s',[NomeCampo])) + '_' + IntToStr(Livelli);
  //Prevedere un array contenente il nome della campo del clientDataSet e il relativo nome della colonna della tabella
  k:=(cdsStampa.FieldCount div 4) - 2;
  SetLength(recCampi,0);
  for i:=0 to cdsStampa.FieldCount - 1 do
  begin
    SetLength(recCampi,length(recCampi) + 1);
    NomeCampoCDS:=cdsStampa.Fields[i].FieldName;
    if (NomeCampoCDS = 'Decorrenza')
    or (NomeCampoCDS = 'NomeCampo')
    or (NomeCampoCDS = 'Decorrenza' + IntToStr(k))
    or (NomeCampoCDS = 'NomeCampo' + IntToStr(k))
    or (NomeCampoCDS = 'Scadenza') then
      recCampi[High(recCampi)].NomeCampoTab:=Trim(Format('%30s',[UpperCase(NomeCampoCDS)]));
    if (NomeCampoCDS = 'Codice') then
      recCampi[High(recCampi)].NomeCampoTab:=Trim(Format('%30s',[UpperCase(NomeColonna('NomeCampo'))]));
    if (NomeCampoCDS = 'Descrizione') then
      recCampi[High(recCampi)].NomeCampoTab:=Trim(Format('%30s',[UpperCase('D_' + NomeColonna('NomeCampo'))]));
    if (NomeCampoCDS = 'Codice' + IntToStr(k)) then
      recCampi[High(recCampi)].NomeCampoTab:=Trim(Format('%30s',[UpperCase(NomeColonna('NomeCampo' + IntToStr(k)))]));
    if (NomeCampoCDS = 'Descrizione' + IntToStr(k)) then
    begin
      recCampi[High(recCampi)].NomeCampoTab:=Trim(Format('%30s',[UpperCase('D_' + NomeColonna('NomeCampo' + IntToStr(k)))]));
      dec(k);
    end;
    if (Trim(recCampi[High(recCampi)].NomeCampoTab) = '')
    or (Trim(recCampi[High(recCampi)].NomeCampoTab) = 'D_') then
      recCampi[High(recCampi)].NomeCampoTab:='C_A_M_P_O__' + IntToStr(i);
  end;
  //Se esiste già dropparla
  with crea_X001 do
  begin
    SQL.Clear;
    SQL.Add('DROP TABLE ' + NomeTabella + IfThen(VersioneDB >= 10,' PURGE',''));
    try
      Execute;
    except
    end;
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + NomeTabella + ' (');
    for i:=0 to cdsStampa.FieldCount - 1 do
    begin
      S:=IfThen(S <> '',',','');
      S:=S + recCampi[i].NomeCampoTab;
      if (Pos('Decorrenza',cdsStampa.Fields[i].FieldName) = 1)
      or (cdsStampa.Fields[i].FieldName = 'Scadenza') then
        S:=S + ' DATE'
      else
        S:=S + ' VARCHAR2(' + IntToStr(cdsStampa.Fields[i].Size) + ')';
      SQL.Add(S);
    end;
    SQL.Add(') TABLESPACE ' + TableSpace);
    SQL.Add('  STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0)');
    Execute;
  end;
  //Popolare la tabella in base al cdsStampa NON filtrato
  selX001.Close;
  selX001.SQL.Text:='SELECT T.*, T.ROWID FROM ' + NomeTabella + ' T';
  selX001.Open;
  cdsStampa.Filtered:=False;
  cdsStampa.First;
  while not cdsStampa.Eof do
  begin
    selX001.Insert;
    for i:=0 to cdsStampa.FieldCount - 1 do
      selX001.Fields[i].AsString:=cdsStampa.Fields[i].AsString;
    selX001.Post;
    cdsStampa.Next;
  end;
  cdsStampa.First;
  selX001.Session.Commit;
  selX001.First;
  if cdsStampa.Filter <> '' then
    cdsStampa.Filtered:=True;
  //Eliminare le colonne invisibili
  for i:=cdsStampa.FieldCount - 1 downto 0 do
    if not cdsStampa.Fields[i].Visible then
    begin
      crea_X001.SQL.Clear;
      crea_X001.SQL.Add('ALTER TABLE ' + NomeTabella + ' DROP COLUMN ' + recCampi[i].NomeCampoTab);
      crea_X001.Execute;
    end
    else
      if Pos('Decorrenza',cdsStampa.Fields[i].FieldName) = 1 then
        NomeCampoCDS:=cdsStampa.Fields[i].FieldName;
  //Rinominare la colonna della decorrenza
  if Pos('Decorrenza',NomeCampoCDS) = 1 then
  begin
    crea_X001.SQL.Clear;
    crea_X001.SQL.Add('ALTER TABLE ' + NomeTabella + ' RENAME COLUMN ' + NomeCampoCDS + ' TO DECORRENZA');
    crea_X001.Execute;
  end;
end;

// FINE ESTRAZIONE IN TABELLA X001

end.

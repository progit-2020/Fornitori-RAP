unit A060UTimbIrregolariMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000UInterfaccia, A000USessione, R005UDataModuleMW, DB, Oracle, OracleData,
  C180FunzioniGenerali, DateUtils, RegistrazioneLog;

type
  TRepaintValue = procedure(NewValue:String) of object;

  TA060FTimbIrregolariMW = class(TR005FDataModuleMW)
    selI101: TOracleDataSet;
    QI101: TOracleDataSet;
    QI090: TOracleDataSet;
    selI100: TOracleDataSet;
    QI101Del: TOracleQuery;
    delI101: TOracleQuery;
    selI091: TOracleDataSet;
    DbScarico: TOracleSession;
    Q100: TOracleQuery;
    scrTIMB_TRIGGER_BEFORE: TOracleQuery;
    scrTIMB_TRIGGER_AFTER: TOracleQuery;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    Q430: TOracleDataSet;
    Q361: TOracleDataSet;
    Q370: TOracleQuery;
    QI101EDBADGE: TStringField;
    QI101VERSO: TStringField;
    QI101RILEV: TStringField;
    QI101CAUSALE: TStringField;
    QI101AZIENDE: TStringField;
    QI101SCARICO: TStringField;
    QI101BADGE: TFloatField;
    QI101ORA: TDateTimeField;
    QI101DATA: TDateTimeField;
    DI101: TDataSource;
    dscI101: TDataSource;
    QI101FUNZIONE: TStringField;
    QI101CHIAVE: TStringField;
    selChiave: TOracleDataSet;
    selI101Chiave: TOracleDataSet;
    selI101Scarico: TOracleDataSet;
    procedure QI101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure Q100AfterQuery(Sender: TOracleQuery);
    procedure Q100BeforeQuery(Sender: TOracleQuery);
    procedure QI101AfterOpen(DataSet: TDataSet);
  private
    SessioneOracleA060:TOracleSession;
    UsatoDaB006:Boolean;
    DataI,DataF:TDateTime;
    LProg:TStringList;
    Residui:Boolean;
    procedure Ripristino;
    procedure ScaricaRiga(var OUTTM, OUTTP: Integer);
    procedure AllineaTimbrature;
    function NomeMaschera:String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    function GetFiltroChiave: String;
    function GetFiltroScarico: String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  public
    DaData, AData: TDateTime;
    GrdRisultatiVisibile:Boolean;
    RepaintBadge: TRepaintValue;
    RepaintAzienda: TRepaintValue;
    RepaintStatusBar:TRepaintValue;
    DaBadge,ABadge,AziendaDescr,BadgeDescr: String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave,AChiave,DaScarico,AScarico: String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    RegistraMsgA060:TRegistraMsg;
    procedure CaricaTimbrature;
    function CancellaTimbrature: String;
    function Scarico: String;
    function CaricaListaBadge: TStringList;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    function CaricaListaChiavi: TStringList;
    function CaricaListaParamScarico: TStringList;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  end;

implementation

uses A023UAllTimbMW, A000UMessaggi;

{$R *.dfm}

procedure TA060FTimbIrregolariMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if Self.Owner is TOracleSession then
  begin
    SessioneOracleA060:=(Self.Owner as TOracleSession);
    UsatoDaB006:=True;
  end
  else
  begin
    SessioneOracleA060:=SessioneOracle;
    UsatoDaB006:=False;
  end;
  if (not UsatoDaB006) and (not SessioneOracleA060.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracleA060);
  end;
  selI100.Session:=SessioneOracleA060;
  QI101.Session:=SessioneOracleA060;
  QI101Del.Session:=SessioneOracleA060;
  delI101.Session:=SessioneOracleA060;
  selI101.Session:=SessioneOracleA060;
  QI090.Session:=SessioneOracleA060;
  selI091.Session:=SessioneOracleA060;
  QI090.Open;
  with QI101 do
  begin
    SetVariable('ORDERBY','ORDER BY DATA, BADGE, ORA');
    if not UsatoDaB006 then
    begin
      if Parametri.Azienda <> 'AZIN' then
        Filtered:=True;
      SetVariable('Data1',R180InizioMese(Parametri.DataLavoro));
      SetVariable('Data2',R180FineMese(Parametri.DataLavoro));
    end
    else
    begin
      SetVariable('DABADGE',0);
      SetVariable('ABADGE',999999999999999);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
      // range per la chiave
      SetVariable('FILTRO_CHIAVE',GetFiltroChiave);
      // range per la parametrizzazione di scarico
      SetVariable('FILTRO_SCARICO',GetFiltroScarico);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
      SetVariable('Data1',R180AddMesi(R180InizioMese(Date),-1));
      SetVariable('Data2',Date);
    end;
    Open;
  end;
  selI100.Open;
end;

function TA060FTimbIrregolariMW.Scarico:String;
{Scarico gestendo la multiaziendalità:
 Scorro le aziende
   Scorro le timbrature irregolari contenute in I101}
var
  S, Msg:String;
begin
  if DaData > AData then
  begin
    Result:=A000MSG_ERR_PERIODO_ERRATO;
    Exit;
  end;
  Msg:='';
  //Lettura timb.irregolari del periodo specificato
  R180SetVariable(QI101,'Data1',DaData);
  R180SetVariable(QI101,'Data2',AData);
  QI101.DisableControls;
  //Scorrimento aziende
  QI090.First;
  with QI090 do
  begin
    while not Eof do
    begin
      selI091.Close;
      selI091.SetVariable('AZIENDA',FieldByName('AZIENDA').AsString);
      selI091.Open;
      if VarToStr(selI091.Lookup('TIPO','C25_TIMBIRR_AUTO','DATO')) = 'N' then
      begin
        Next;
        Continue;
      end;
      Q100.Close;
      Q275.Close;
      Q305.Close;
      Q361.Close;
      Q430.Close;
      //Setto le impostazioni del database in oggetto
      DbScarico.Logoff;
      DbScarico.LogonDataBase:=Session.LogonDatabase;
      DbScarico.LogonUserName:=FieldByName('UTENTE').AsString;
      DbScarico.LogonPassword:=R180Decripta(FieldByName('PAROLACHIAVE').AsString,21041974);
      try
        DbScarico.Logon;
      except
        try
          DbScarico.LogonDataBase:='IRIS';
          DbScarico.Logon;
        except
          Msg:='DataBase non connesso.';
          if UsatoDaB006 then
            RegistraMsgA060.InserisciMessaggio('A',Msg,FieldByName('Azienda').AsString);
          Next;
          Continue;
        end;
      end;
      if (not UsatoDaB006) then
      begin
        AziendaDescr:=FieldByName('Azienda').AsString;
        if Assigned(RepaintAzienda) then
          RepaintAzienda(AziendaDescr)
      end;
      if UsatoDaB006 then
        RegistraMsgA060.InserisciMessaggio('I','INIZIO RIPRISTINO TIMBRATURE IRREGOLARI',FieldByName('Azienda').AsString);
      Q361.Open;  //Leggo gli orologi
      Ripristino;  //Scorrimento Timbrature irregolari
      if UsatoDaB006 then
        RegistraMsgA060.InserisciMessaggio('I','FINE RIPRISTINO TIMBRATURE IRREGOLARI',FieldByName('Azienda').AsString);
      Next;
    end;
  end;
  S:='';
  QI101.EnableControls;
  if Residui then
    S:=Format('%sSono presenti timbrature irregolari',[#13]);
  if (not UsatoDaB006) then
    Msg:='Scarico terminato. ' + S;
  if (not UsatoDaB006) and GrdRisultatiVisibile then
    QI101.Open;
  Result:=Msg;
end;

procedure TA060FTimbIrregolariMW.Ripristino;
{Leggo il file sequenziale e scarico le timbrature corrispondenti su Q100}
var TM,TP:Integer;
begin
  LProg:=TStringList.Create;
  DataI:=EncodeDate(3999,12,31);
  DataF:=EncodeDate(1900,1,1);
  TP:=0;
  TM:=0;
  with QI101 do
  begin
    Open;
    while not Eof do
    begin
      if (Trim(FieldByName('AZIENDE').AsString) = '') or
         (Pos(',' + QI090.FieldByName('AZIENDA').AsString + ',',',' + FieldByName('AZIENDE').AsString + ',') > 0) then
        ScaricaRiga(TM,TP);
      Next;
    end;
    Close;
  end;
  if (TP + TM > 0) and UsatoDaB006 then
    RegistraMsgA060.InserisciMessaggio('I','Recuperate ' + IntToStr(TP) + ' timbrature di presenza e ' + IntToStr(TM) + ' timbrature di mensa',QI090.FieldByName('Azienda').AsString);
  DbScarico.Commit;
  SessioneOracleA060.Commit;
  AllineaTimbrature;
  LProg.Free;
end;

procedure TA060FTimbIrregolariMW.AllineaTimbrature;
var i:Integer;
    A023:TA023FAllTimbMW;
begin
  A023:=TA023FAllTimbMW.Create(nil);
  try
    with A023 do
    begin
      Q100.Session:=DbScarico;
      Q100Upd.Session:=DbScarico;
      for i:=0 to LProg.Count - 1 do
        Allinea(StrToInt(LProg[i]),DataI,DataF);
    end;
  finally
    FreeAndNil(A023);
  end;
end;

procedure TA060FTimbIrregolariMW.ScaricaRiga(var OUTTM,OUTTP:Integer);
{Esamina la riga letta dal file seq. e la scrive su Q100/Q361 oppure
la registra su NFAppoggio}
var Data,Ora:TDateTime;
    Badge:Real;
    EdBadge,Causale:String;
    Pres,Mensa:Boolean;
    IVerso,IRilev:String;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    Chiave, ExprChiave, Prog: String;
    Lst: TStringList;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    A,M,G,H,N,Sec,MSec:Word;
    procedure InsTimb(Q:TOracleQuery; TriggerBefore,TriggerAfter:String);
    //Inserimento timbrature di presenza o di mensa
    begin
      with Q do
      begin
        if TriggerBefore = 'S' then
          Q.BeforeQuery:=Q100BeforeQuery
        else
          Q.BeforeQuery:=nil;
        if TriggerAfter = 'S' then
          Q.AfterQuery:=Q100AfterQuery
        else
          Q.AfterQuery:=nil;
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
        //SetVariable('Progressivo',Q430.FieldByName('Progressivo').AsInteger);
        if Chiave <> '' then
        begin
          // utilizza il dataset legato alla chiave alternativa
          SetVariable('Progressivo',selChiave.FieldByName('Progressivo').AsInteger);
        end
        else
        begin
          // utilizza il dataset legato al badge
          SetVariable('Progressivo',Q430.FieldByName('Progressivo').AsInteger);
        end;
        // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
        SetVariable('Data',Data);
        SetVariable('Ora',Ora);
        //Verso già letto e trasformato precedentemente
        SetVariable('Verso',IVerso);
        //Estraggo Rilevatore
        SetVariable('Rilevatore',Trim(IRilev));
        if Trim(IRilev) = '' then
          SetVariable('Flag','I')
        else
          SetVariable('Flag','O');
        try
          if StrToInt(Trim(Causale)) = 0 then
            Causale:='';
        except
        end;
        SetVariable('Causale',Trim(Causale));
        if (not UsatoDaB006) then
        begin
          // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
          if Chiave <> '' then
            BadgeDescr:=Chiave
          else
            BadgeDescr:=FloatToStr(Badge);
          // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
          if Assigned(RepaintBadge) then
            RepaintBadge(BadgeDescr)
        end;
        try
          Execute;
        except
        end;
      end;
    end;
    procedure CancellaI101;
    //Cancellazione timbratura ripristinata dalle timbrature irregolari
    begin
      with QI101Del do
      begin
        SetVariable('ROW_ID',QI101.RowID);
        Execute;
      end;
    end;
begin
  try
    //Estraggo Causale
    Causale:=QI101.FieldByName('Causale').AsString;
    //Estraggo verso
    IVerso:=QI101.FieldByName('Verso').AsString;
    //Estraggo data per sapere a quale storico mi riferisco
    Data:=QI101.FieldByName('Data').AsDateTime;
    //Estraggo Badge
    Badge:=QI101.FieldByName('Badge').AsFloat;
    EdBadge:=QI101.FieldByName('EdBadge').AsString;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // estrae il dato chiave in alternativa al badge
    Chiave:=QI101.FieldByName('Chiave').AsString;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    //Estraggo Ora timbratura
    Ora:=QI101.FieldByName('Ora').AsDateTime;
    //Estraggo Rilevatore
    IRilev:=QI101.FieldByName('Rilev').AsString;
    if (Trim(IRilev) <> '') and Q361.SearchRecord('Rilevatore',Trim(IRilev),[srFromBeginning]) then
    begin
      if (Q361.FieldByName('Scarico').AsString = '') then
        IRilev:=Q361.FieldByName('CODICE').AsString
      else if Q361.SearchRecord('Rilevatore;Scarico',VarArrayOf([Trim(IRilev),QI101.FieldByName('SCARICO').AsString]),[srFromBeginning]) then
        IRilev:=Q361.FieldByName('CODICE').AsString;
    end;
    //Verifico se il verso è fissato all'orologio
    if Q361.Locate('Codice',Trim(IRilev),[]) then
    begin
      if Q361.FieldByName('Verso').AsString = 'E' then
        IVerso:='E'
      else if Q361.FieldByName('Verso').AsString = 'U' then
        IVerso:='U';
    end;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // se è indicato il dato chiave in alternativa al badge effettua la query
    // personalizzata per estrarre il progressivo del dipendente
    if Chiave <> '' then
    begin
      ExprChiave:=VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'EXPR_CHIAVE'));

      // estrazione del progressivo data la chiave alternativa al badge
      Lst:=TStringList.Create;
      try
        Lst:=FindVariables(ExprChiave,False); // non considera i duplicati
        Lst.CaseSensitive:=False;
        with selChiave do
        begin
          // se l'espressione contiene la variabile :DATA la dichiara
          if (Lst.IndexOf('Data') > -1) and
             (VariableIndex('Data') = -1) then
          begin
            DeclareVariable('Data',otDate);
          end;
          Close;
          SQL.Text:=ExprChiave;

          // imposta le variabili
          SetVariable('Chiave',Chiave);
          if VariableIndex('Data') > -1 then
            SetVariable('Data',Data);
          try
            Open;
          except
            on E:Exception do
            begin
              //RegistraMsg.InserisciMessaggio('A',E.Message);
              //???
            end;
          end;

          if RecordCount = 0 then
            //Se non esiste il movimento storico registro la timbratura sui
            //residui e passo alla successiva
            Abort;
        end;
      finally
        FreeAndNil(Lst);
      end;
    end
    else
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    begin
      //Leggo il badge storicizzato
      with Q430 do
      begin
        Close;
        SetVariable('Data',Data);
        DecodeDate(Data,A,M,G);
        DecodeTime(Ora,H,N,Sec,MSec);
        SetVariable('DataOra',EncodeDateTime(A,M,G,H,N,Sec,0));
        SetVariable('Badge',Badge);
        Open;
        if RecordCount = 0 then
          //Se non esiste il movimento storico salto non registro niente
          Abort;
      end;
      //Controllo l'edizione del badge se significativa e se il badge non è di servizio EDBADGE='BS'
      if (Edbadge <> '') and (Q430.FieldByName('EdBadge').AsString <> 'BS') then
      begin
        with TStringList.Create do
        begin
          try
            Clear;
            CommaText:=Q430.FieldByName('EdBadge').AsString;
            if IndexOf(Trim(EdBadge)) < 0 then
              Abort;
          finally
            Free; // memory leak
          end;
        end;
      end;
    end;
//============================================================================
//SE CAMPO FUNZIONE E' <> "E" LE TIMBR SONO O TUTTE "P"(PRESENZA) O "M"(MENSA)
//============================================================================
    Pres:=True; //per default sono timbrature di presenza
    Mensa:=False;
    if QI101.FieldByName('FUNZIONE').AsString = 'E' then
    begin
      if Q361.Locate('Codice',Trim(IRilev),[]) then
      begin
        if Q361.FieldByName('Funzione').AsString = 'M' then
        //Timbratura solo di mensa
        begin
          Pres:=False;
          Mensa:=True;
        end
        else
        begin
          //Timbratura sia di Presenza che di mensa
          if Q361.FieldByName('Funzione').AsString = 'E' then
          begin
            if Q361.FieldByName('CausMensa').IsNull then
              Mensa:=True
            else if Trim(Causale) = Q361.FieldByName('CausMensa').AsString then
            begin
              Pres:=False;
              Mensa:=True;
            end
            else
            begin
              Pres:=True;
              Mensa:=False;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if QI101.FieldByName('FUNZIONE').AsString = 'P' then
      begin
        Pres:=True;
        Mensa:=False;
      end
      else
      begin
        Pres:=False;
        Mensa:=True;
      end;
    end;
    if Pres then
    begin
      InsTimb(Q100,
              VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'TRIGGER_BEFORE')),
              VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'TRIGGER_AFTER'))
              );
      //Registro dati per allineamento timbrature successivo
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
      // gestione del dataset specifico nel caso di chiave alternativa al badge
      {
      if LProg.IndexOf(Q430.FieldByName('Progressivo').AsString) = -1 then
        LProg.Add(Q430.FieldByName('Progressivo').AsString);
      }
      if VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'EXPR_CHIAVE')) <> '' then
        Prog:=selChiave.FieldByName('Progressivo').AsString
      else
        Prog:=Q430.FieldByName('Progressivo').AsString;
      if LProg.IndexOf(Prog) = -1 then
        LProg.Add(Prog);
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
      if Data < DataI then
        DataI:=Data;
      if Data > DataF then
        DataF:=Data;
      Inc(OUTTP);
    end;
    if Mensa then
    begin
      InsTimb(Q370,
              VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'TRIGGER_BEFORE')),
              VarToStr(selI100.Lookup('SCARICO',QI101.FieldByName('SCARICO').AsString,'TRIGGER_AFTER'))
             );
      Inc(OUTTM);
    end;
    //Se va tutto bene cancello il record da I101
    CancellaI101;
    DbScarico.Commit;
  except
    Residui:=True;
  end;
end;

function TA060FTimbIrregolariMW.CancellaTimbrature:String;
var Msg:String;
begin
  Msg:='';
  with delI101 do
  begin
    SetVariable('Data1',DaData);
    SetVariable('Data2',AData);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    if DaBadge = '' then
      SetVariable('DABADGE',0)
    else
      SetVariable('DABADGE',StrToFloat(DaBadge));
    if ABadge = '' then
      SetVariable('ABADGE',999999999999999)
    else
      SetVariable('ABADGE',StrToFloat(ABadge));
    // range per la chiave
    SetVariable('FILTRO_CHIAVE',GetFiltroChiave);
    // range per la parametrizzazione di scarico
    SetVariable('FILTRO_SCARICO',GetFiltroScarico);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    Execute;
    if delI101.RowsProcessed > 0 then
    begin
      RegistraLog.SettaProprieta('C','I101_TIMBIRREGOLARI',NomeMaschera,nil,True);
      RegistraLog.InserisciDato('DATA:DAL-AL',Format('%s-%s',[DateToStr(DaData),DateToStr(AData)]),'');
      RegistraLog.InserisciDato('BADGE:DAL-AL',Format('%s-%s',[DaBadge,ABadge]),'');
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
      RegistraLog.InserisciDato('CHIAVE:DA-A',Format('%s-%s',[DaChiave,AChiave]),'');
      RegistraLog.InserisciDato('SCARICO:DA-A',Format('%s-%s',[DaScarico,AScarico]),'');
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
      RegistraLog.RegistraOperazione;
    end;
    SessioneOracle.Commit;
    QI101.Refresh;
    Msg:='Cancellazione terminata';
    Result:=Msg;
  end;
end;

function TA060FTimbIrregolariMW.NomeMaschera:String;
begin
  // bugfix.ini: se Owner nil dà access violation
  if Self.Owner = nil then
  begin
    // codice maschera win
    Result:=Copy(Self.Name,1,4);
  end
  else
  // bugfix.fine
  begin
    Result:=Copy(Self.Owner.Name,1,4);
    if Copy(Self.Owner.Name,1,1) = 'W' then
      Result:=Copy(Self.Owner.Name,1,5);
  end;
end;

function TA060FTimbIrregolariMW.GetFiltroChiave: String;
begin
  if (DaChiave = '') and (AChiave = '') then
  begin
    // nessun filtro sulla chiave
    Result:='';
  end
  else if (DaChiave = '') then
  begin
    // solo da chiave indicato
    Result:=Format('and CHIAVE <= %s',[QuotedStr(AChiave)])
  end
  else if (AChiave = '') then
  begin
    // solo a chiave indicato
    Result:=Format('and CHIAVE >= %s',[QuotedStr(DaChiave)])
  end
  else
  begin
    // entrambe le chiavi indicate
    Result:=Format('and CHIAVE between %s and %s',[QuotedStr(DaChiave),QuotedStr(AChiave)])
  end;
end;

function TA060FTimbIrregolariMW.GetFiltroScarico: String;
begin
  if (DaScarico = '') and (AScarico = '') then
  begin
    // nessun filtro sullo scarico
    Result:='';
  end
  else if (DaScarico = '') then
  begin
    // solo da scarico indicato
    Result:=Format('and SCARICO <= %s',[QuotedStr(AScarico)])
  end
  else if (AScarico = '') then
  begin
    // solo a scarico indicato
    Result:=Format('and SCARICO >= %s',[QuotedStr(DaScarico)])
  end
  else
  begin
    // entrambe le parametrizzazioni di scarico indicate
    Result:=Format('and SCARICO between %s and %s',[QuotedStr(DaScarico),QuotedStr(AScarico)])
  end;
end;

function TA060FTimbIrregolariMW.CaricaListaBadge:TStringList;
var strList:TStringList;
begin
  strList:=TStringList.Create;
  strList.Clear;
  if (DaData <> selI101.GetVariable('Data1')) or (AData <> selI101.GetVariable('Data2')) then
  begin
    selI101.SetVariable('Data1',DaData);
    selI101.SetVariable('Data2',AData);
    selI101.Close;
    selI101.Open;
    while not selI101.Eof do
    begin
      strList.Add(selI101.FieldByName('BADGE').AsString);
      selI101.Next;
    end;
  end;
  Result:=strList;
end;

// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
function TA060FTimbIrregolariMW.CaricaListaChiavi:TStringList;
var strList:TStringList;
begin
  strList:=TStringList.Create;
  strList.Clear;
  if (DaData <> selI101Chiave.GetVariable('Data1')) or (AData <> selI101Chiave.GetVariable('Data2')) then
  begin
    selI101Chiave.SetVariable('Data1',DaData);
    selI101Chiave.SetVariable('Data2',AData);
    selI101Chiave.Close;
    selI101Chiave.Open;
    while not selI101Chiave.Eof do
    begin
      strList.Add(selI101Chiave.FieldByName('CHIAVE').AsString);
      selI101Chiave.Next;
    end;
  end;
  Result:=strList;
end;

function TA060FTimbIrregolariMW.CaricaListaParamScarico:TStringList;
var strList:TStringList;
begin
  strList:=TStringList.Create;
  strList.Clear;
  if (DaData <> selI101Scarico.GetVariable('Data1')) or (AData <> selI101Scarico.GetVariable('Data2')) then
  begin
    selI101Scarico.SetVariable('Data1',DaData);
    selI101Scarico.SetVariable('Data2',AData);
    selI101Scarico.Close;
    selI101Scarico.Open;
    while not selI101Scarico.Eof do
    begin
      strList.Add(selI101Scarico.FieldByName('SCARICO').AsString);
      selI101Scarico.Next;
    end;
  end;
  Result:=strList;
end;
// AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine

procedure TA060FTimbIrregolariMW.CaricaTimbrature;
begin
  QI101.SetVariable('Data1',DaData);
  QI101.SetVariable('Data2',AData);
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
  //QI101.SetVariable('DABADGE',StrToFloat(DaBadge));
  if DaBadge = '' then
    QI101.SetVariable('DABADGE',0)
  else
    QI101.SetVariable('DABADGE',StrToFloat(DaBadge));
  //QI101.SetVariable('ABADGE',StrToFloat(ABadge));
  if ABadge = '' then
    QI101.SetVariable('ABADGE',999999999999999)
  else
    QI101.SetVariable('ABADGE',StrToFloat(ABadge));
  // range per la chiave
  QI101.SetVariable('FILTRO_CHIAVE',GetFiltroChiave);
  // range per la parametrizzazione di scarico
  QI101.SetVariable('FILTRO_SCARICO',GetFiltroScarico);
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  QI101.Close;
  QI101.Open;
end;

procedure TA060FTimbIrregolariMW.Q100AfterQuery(Sender: TOracleQuery);
{Esecuzione della procedura Oracle TIMB_TRIGGER_AFTER dopo l'acquisizione}
begin
  with scrTIMB_TRIGGER_AFTER do
  try
    SetVariable('PROGRESSIVO',Sender.GetVariable('PROGRESSIVO'));
    SetVariable('DATA',Sender.GetVariable('DATA'));
    SetVariable('ORA',Sender.GetVariable('ORA'));
    SetVariable('VERSO',Sender.GetVariable('VERSO'));
    SetVariable('CAUSALE',Sender.GetVariable('CAUSALE'));
    if Sender = Q100 then
      SetVariable('TABELLA','T100')
    else
      SetVariable('TABELLA','T370');
    Execute;
  except
  end;
end;

procedure TA060FTimbIrregolariMW.Q100BeforeQuery(Sender: TOracleQuery);
{Esecuzione della procedura Oracle TIMB_TRIGGER_BEFORE prima dell'acquisizione}
begin
  with scrTIMB_TRIGGER_BEFORE do
  try
    SetVariable('PROGRESSIVO',Sender.GetVariable('PROGRESSIVO'));
    SetVariable('DATA',Sender.GetVariable('DATA'));
    SetVariable('ORA',Sender.GetVariable('ORA'));
    SetVariable('VERSO',Sender.GetVariable('VERSO'));
    SetVariable('CAUSALE',Sender.GetVariable('CAUSALE'));
    if Sender = Q100 then
      SetVariable('TABELLA','T100')
    else
      SetVariable('TABELLA','T370');
    Execute;
    //Gestione della modifica del verso
    if GetVariable('VERSO') <> Sender.GetVariable('VERSO') then
      Sender.SetVariable('VERSO',GetVariable('VERSO'));
    //Gestione della modifica della causale
    if GetVariable('CAUSALE') <> Sender.GetVariable('CAUSALE') then
      Sender.SetVariable('CAUSALE',GetVariable('CAUSALE'));
    //Gestione dell'annullamento dell'operazione
    if GetVariable('VALIDA') = 'N' then
    begin
      //ScriviMessaggio('Timbratura annullata');
      Abort;
    end;
  except
    on E:Exception do
      if E is EAbort then
        raise;
  end;
end;

procedure TA060FTimbIrregolariMW.QI101AfterOpen(DataSet: TDataSet);
begin
  if (not UsatoDaB006) then
  begin
    if Assigned(RepaintAzienda) then
      RepaintStatusBar(Format('%d Records',[DataSet.RecordCount]))
  end;
end;

procedure TA060FTimbIrregolariMW.QI101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if Parametri.Azienda <> 'AZIN' then
  begin
    if (Pos(',' + Parametri.Azienda + ',',',' + QI101.FieldByName('AZIENDE').AsString + ',') <= 0) and
       (Not QI101.FieldByName('AZIENDE').IsNull) then
      Accept:=False;
  end;
end;

end.

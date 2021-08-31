unit A166UQuoteIndividualiMW;

interface

uses
  System.SysUtils, System.Classes, Variants, R005UDataModuleMW, Data.DB, OracleData, C180FUnzioniGenerali,
  QueryStorico, A000UInterfaccia, A000UMessaggi, Oracle;

type
  TA166FQuoteIndividualiMW = class(TR005FDataModuleMW)
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT765TIPOQUOTA: TStringField;
    selT770: TOracleDataSet;
    selT775b: TOracleDataSet;
    selSQL: TOracleQuery;
    selT030: TOracleDataSet;
    selT775A: TOracleDataSet;
    IntegerField1: TIntegerField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    StringField2: TStringField;
    FloatField2: TFloatField;
    StringField3: TStringField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    StringField4: TStringField;
    StringField5: TStringField;
    FloatField5: TFloatField;
    StringField6: TStringField;
    StringField7: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT775AAfterPost(DataSet: TDataSet);
    procedure selT775ABeforePost(DataSet: TDataSet);
  private
    private FselT775_Funzioni: TOracleDataset;
    procedure GetQuote(sel: String; Data: TDateTime; var Importo: Real);
  public
    QSIncentivi:TQueryStorico;
    procedure SelT775AfterScroll;
    procedure SelT775OnNewRecord;
    procedure ControlliBeforePost;
    procedure ImpostaDecorrenzaDatasetLookup;
    function getTipoQuotaByCod(Cod: String): String;
    procedure ImpostaImportoPenalizzazione;
    function MessaggioForzaDecorrenzaScadenza: String;
    procedure AcquisizioneDaFileInizio;
    procedure AcquisizioneDaFileFine;
    procedure Acquisisci(Riga: String; TipoQuota: String);
    property selT775_Funzioni: TOracleDataset read FselT775_Funzioni write FselT775_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA166FQuoteIndividualiMW.SelT775AfterScroll;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if (FSelT775_Funzioni.State = dsBrowse) and
    (FSelT775_Funzioni.Eof) then //refreshrecord resetterebbe EOF e i cicli vanno in loop
    Exit;

  ImpostaDecorrenzaDatasetLookup;
  FSelT775_Funzioni.RefreshRecord;
end;

procedure TA166FQuoteIndividualiMW.SelT775OnNewRecord;
begin
  FSelT775_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  (* default da db
  selT775.FieldByName('SALTAPROVA').AsString:='N';
  selT775.FieldByName('CONSIDERA_SALDO').AsString:='S';
  *)
end;

procedure TA166FQuoteIndividualiMW.ImpostaDecorrenzaDatasetLookup;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if R180SetVariable(selT765,'DECORRENZA',FSelT775_Funzioni.FieldByName('DECORRENZA').AsDateTime) then
    selT765.Open;
end;

function TA166FQuoteIndividualiMW.getTipoQuotaByCod(Cod: String): String;
begin
  Result:='';
  if selT765.SearchRecord('CODICE',Cod,[srFromBeginning]) then
    Result:=selT765.FieldByName('TIPOQUOTA').AsString;
end;

procedure TA166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;
var Q,R,L,S: string;
   Importo,Penalizzazione:Real;
begin
  if Trim(FselT775_Funzioni.FieldByName('CODTIPOQUOTA').AsString) = '' then
    Exit;
  //Compila in automatico Incentivi e Risorse
  Q:='T430' + Parametri.CampiRiferimento.C7_Dato1;
  R:='T430' + Parametri.CampiRiferimento.C7_Dato2;
  L:='T430' + Parametri.CampiRiferimento.C7_Dato3;
  S:='';
  if Trim(Q) <> 'T430' then
    S:=Q;
  if Trim(R) <> 'T430' then
  begin
    if S <> '' then
      S:=S + ',';
    S:=S + R;
  end;
  if Trim(L) <> 'T430' then
  begin
    if S <> '' then
      S:=S + ',';
    S:=S + L;
  end;
  QSIncentivi.GetDatiStorici(S,selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime,R180FineMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime));
  QSIncentivi.LocDatoStorico(R180FineMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime));
  selT770.Close;
  selT770.SetVariable('DATAINIZIO',FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if (not FselT775_Funzioni.FieldByName('SCADENZA').IsNull) and (FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime <> 0) then
    selT770.SetVariable('DATAFINE',FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime)
  else
    selT770.SetVariable('DATAFINE',StrToDate('31/12/3999'));
  selT770.SetVariable('CODTIPOQUOTA','''' + FselT775_Funzioni.FieldByName('CODTIPOQUOTA').AsString + '''');
  selT770.Open;
  GetQuote('I',R180FineMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime),Importo);
  if (FselT775_Funzioni.FieldByName('IMPORTO').AsFloat = 0) then
    FselT775_Funzioni.FieldByName('IMPORTO').AsFloat:=Importo;
  GetQuote('P',R180FineMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime),Penalizzazione);
  FselT775_Funzioni.FieldByName('PENALIZZAZIONE').AsFloat:=Penalizzazione;
end;

procedure TA166FQuoteIndividualiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  QSIncentivi:=TQueryStorico.Create(nil);
  QSIncentivi.Session:=SessioneOracle;
end;

procedure TA166FQuoteIndividualiMW.GetQuote(sel:String; Data:TDateTime; var Importo:Real);
var D1,D2,D3,DOld:String;
    Trovato:Boolean;
  function CercaQuotaStorica:Boolean;
  begin
    Result:=False;
    if selT770.SearchRecord('DATO1;DATO2;DATO3',VarArrayOf([D1,D2,D3]),[srFromBeginning]) then
    begin
      repeat
        if selT770.FieldByName('DECORRENZA').AsDateTime <= Data then
        begin
          Result:=True;
          Break;
        end;
      until not selT770.SearchRecord('DATO1;DATO2;DATO3',VarArrayOf([D1,D2,D3]),[]);
    end;
  end;
begin
  {
    Viene fatta una ricerca con i seguenti criteri:
    - DATO1, DATO2, DATO3
    - DATO1, *, DATO3
    - DATO1, DATO2, *
    - DATO1, *, *
  }
  Importo:=0;
  D1:='*';
  D2:='*';
  D3:='*';
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    D1:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
  if (Parametri.CampiRiferimento.C7_Dato2 <> '') and
     (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString <> '') then
    D2:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
  if (Parametri.CampiRiferimento.C7_Dato3 <> '') and
     (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString <> '') then
    D3:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
  Trovato:=CercaQuotaStorica;
  if (not Trovato) and (D2 <> '*') then
  begin
    DOld:=D2;
    D2:='*';
    Trovato:=CercaQuotaStorica;
    if not Trovato then
    begin
      D2:=DOld;
      D3:='*';
      Trovato:=CercaQuotaStorica;
      if (not Trovato) and (D2 <> '*') then
      begin
        D2:='*';
        Trovato:=CercaQuotaStorica;
      end;
    end;
  end;
  if Trovato then
  begin
    if sel = 'P' then
      Importo:=selT770.FieldByName('PENALIZZAZIONE').AsInteger
    else
      Importo:=selT770.FieldByName('IMPORTO').AsFloat;
  end;
end;

function TA166FQuoteIndividualiMW.MessaggioForzaDecorrenzaScadenza: String;
begin
  Result:='';
  if (FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime)) and
     (FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime <> R180FineMese(FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime)) then
  begin
    Result:=A000MSG_A166_DLG_FORZA_DEC_SCAD;
  end
  else if (FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime)) and
          (FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime = R180FineMese(FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime)) then
  begin
    Result:=A000MSG_A166_DLG_FORZA_DEC
  end
  else if (FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime = R180InizioMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime)) and
          (FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime <> R180FineMese(FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime)) then
  begin
    Result:=A000MSG_A166_DLG_FORZA_SCAD;
  end;
end;

procedure TA166FQuoteIndividualiMW.selT775AAfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA166FQuoteIndividualiMW.selT775ABeforePost(DataSet: TDataSet);
begin
  inherited;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  end;
end;

procedure TA166FQuoteIndividualiMW.ControlliBeforePost;
begin
  selT775b.Close;
  selT775b.SetVariable('PROG',FselT775_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT775b.SetVariable('DEC',FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selT775b.SetVariable('SCAD',FselT775_Funzioni.FieldByName('SCADENZA').AsDateTime);
  selT775b.SetVariable('COD',FselT775_Funzioni.FieldByName('CODTIPOQUOTA').AsString);
  if FselT775_Funzioni.State = dsInsert then
    selT775b.SetVariable('RIGA','0')
  else
    selT775b.SetVariable('RIGA',FselT775_Funzioni.RowId);
  selT775b.Open;
  if selT775b.RecordCount > 0  then
    raise exception.Create(A000MSG_ERR_PERIODI_INTERSECANTI);

  QSIncentivi.GetDatiStorici('T430' + Parametri.CampiRiferimento.C7_Dato1,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime,R180FineMese(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime));
  QSIncentivi.LocDatoStorico(FselT775_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT COUNT(*) FROM T760_REGOLEINCENTIVI T760');
  selSQL.SQL.Add('WHERE T760.LIVELLO = ''' + QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString + '''');
  selSQL.SQL.Add('  AND T760.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI');
  selSQL.SQL.Add('                          WHERE LIVELLO = T760.LIVELLO');
  selSQL.SQL.Add('                            AND DECORRENZA <= TO_DATE(''' + FselT775_Funzioni.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY''))');
  selSQL.Execute;
  if StrToIntDef(VarToStr(selSQL.Field(0)),0) = 0 then
    raise exception.Create(Format(A000MSG_A166_ERR_FMT_REGOLE_INCENTIVI,[Parametri.CampiRiferimento.C7_Dato1]));

  if VarToStr(selT765.Lookup('CODICE',FselT775_Funzioni.FieldByName('CODTIPOQUOTA').AsString,'TIPOQUOTA')) = 'Q' then
  begin  //verifico le regole generali impostate
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT TIPO_QUOTEQUANT FROM T760_REGOLEINCENTIVI T760');
    selSQL.SQL.Add('WHERE T760.LIVELLO = ''' + QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString + '''');
    selSQL.SQL.Add('  AND T760.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T760_REGOLEINCENTIVI');
    selSQL.SQL.Add('                          WHERE LIVELLO = T760.LIVELLO');
    selSQL.SQL.Add('                            AND DECORRENZA <= TO_DATE(''' + FselT775_Funzioni.FieldByName('DECORRENZA').AsString + ''',''DD/MM/YYYY''))');
    selSQL.Execute;
    if VarToStr(selSQL.Field(0)) = 'S' then
      raise exception.Create(A000MSG_A166_ERR_QUOTE_QUANTITATIVE);
  end;
end;

procedure TA166FQuoteIndividualiMW.AcquisizioneDaFileInizio;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  selT030.Open;
  selSQL.SQL.Clear;  //Faccio un salvataggio della tabella
  selSQL.SQL.Add('DROP TABLE BCK_T775_ACQFILE');
  try
    selSQL.Execute;
  except
  end;
  selSQL.SQL.Clear;
  selSQL.SQL.Add('CREATE TABLE BCK_T775_ACQFILE AS');
  selSQL.SQL.Add('SELECT * FROM T775_QUOTEINDIVIDUALI');
  try
    selSQL.Execute;
  except
    on E:exception do
    begin
      RegistraMsg.InserisciMessaggio('A','Salvataggio tabella esistente fallito: ' + E.Message);
    end;
  end;
end;

procedure TA166FQuoteIndividualiMW.Acquisisci(Riga: String;TipoQuota: String);
var R,Matr,MM,AAAA,Inizio,Fine,Imp,Ore,Ind,Strutt: String;
  Anom:Boolean;
begin
  R:=Riga;
  Matr:=Trim(Copy(R,1,Pos(';',R)-1));
  if not selT030.SearchRecord('MATRICOLA',Matr,[srFromBeginning]) then
  begin
    RegistraMsg.InserisciMessaggio('A','Matricola ''' + Matr + ''' non trovata in T030_ANAGRAFICO!');
    Exit;
  end;
  if not SelAnagrafe.SearchRecord('MATRICOLA',Matr,[srFromBeginning]) then
  begin
    RegistraMsg.InserisciMessaggio('A','Dipendente non presente nella selezione anagrafe!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
  MM:=Format('%2d',[StrToIntDef(Trim(Copy(R,1,Pos(';',R)-1)),0)]);
  R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
  AAAA:=Trim(Copy(R,1,Pos(';',R)-1));
  Inizio:='';
  if (Trim(MM) <> '0') and (AAAA <> '') then
  begin
    Inizio:='01/' + MM + '/' + AAAA;
    try
      StrToDate(Inizio);
    except
      RegistraMsg.InserisciMessaggio('A','Data inizio ' + Inizio + ' non valida!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
  end
  else if ((Trim(MM) <> '0') and (AAAA = '')) or ((Trim(MM) = '0') and (AAAA <> ''))then
  begin
    RegistraMsg.InserisciMessaggio('A','Mese/Anno inizio ' + MM + '/' + AAAA + ' non validi!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
  MM:=Format('%2d',[StrToIntDef(Trim(Copy(R,1,Pos(';',R)-1)),0)]);
  R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
  if Pos(';',R) > 0 then
    AAAA:=Trim(Copy(R,1,Pos(';',R)-1))
  else
    AAAA:=R;
  Fine:='';
  if (Trim(MM) <> '0') and (AAAA <> '') then
  begin
    Fine:='01/' + MM + '/' + AAAA;
    try
      StrToDate(Fine);
    except
      RegistraMsg.InserisciMessaggio('A','Data fine ' + Fine + ' non valida!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
  end
  else if ((Trim(MM) <> '0') and (AAAA = '')) or ((Trim(MM) = '0') and (AAAA <> ''))then
  begin
    RegistraMsg.InserisciMessaggio('A','Mese/Anno fine ' + MM + '/' + AAAA + ' non validi!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  if Fine <> '' then
    Fine:=DateToStr(R180FineMese(StrToDate(Fine)));
  if Pos(';',R) > 0 then
  begin
    R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
    if Pos(';',R) > 0 then
      Imp:=Trim(Copy(R,1,Pos(';',R)-1))
    else
      Imp:=R;
    if Imp <> '' then
    try
      StrToFloat(Imp);
    except
      RegistraMsg.InserisciMessaggio('A','Importo ' + Imp + ' non valido!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
  end;
  if Pos(';',R) > 0 then
  begin
    R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
    if Pos(';',R) > 0 then
      Ore:=Trim(Copy(R,1,Pos(';',R)-1))
    else
      Ore:=R;
    Ore:=StringReplace(StringReplace(Ore,',','.',[rfReplaceAll]),':','.',[rfReplaceAll]);
    if Ore <> '' then
      try
        if Pos('.',Ore) > 0 then
        begin
          StrToFloat(Copy(Ore,1,Pos('.',Ore)-1));
          StrToFloat(Copy(Ore,Pos('.',Ore)+1,2));
          R180OreMinutiExt(Ore);
        end
        else
          StrToFloat('x'); //forzo l'errore
      except
        RegistraMsg.InserisciMessaggio('A','Numero ore ' + Ore + ' non valido!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
  end;
  if Pos(';',R) > 0 then
  begin
    R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
    if Pos(';',R) > 0 then
      Ind:=Copy(R,1,Pos(';',R)-1)
    else
      Ind:=R;
    if Ind <> '' then
      try
        StrToFloat(Ind);
      except
        RegistraMsg.InserisciMessaggio('A','Percentuale di valutazione individuale ' + Ind + ' non valida!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
  end;
  if Pos(';',R) > 0 then
  begin
    R:=Copy(R,Pos(';',R)+1,Length(R)-Pos(';',R));
    if Pos(';',R) > 0 then
      Strutt:=Copy(R,1,Pos(';',R)-1)
    else
      Strutt:=R;
    if Strutt <> '' then
      try
        StrToFloat(Strutt);
      except
        RegistraMsg.InserisciMessaggio('A','Percentuale di valutazione strutturale ' + Strutt + ' non valida!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
  end;
  //Se inizio non valorizz. --> si vogliono chiudere le quote
  if (Inizio = '') and (Fine = '') then
  begin
    RegistraMsg.InserisciMessaggio('A','Data inizio e data fine non valorizzati!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  if (Inizio <> '') and (Fine = '') then
    Fine:='31/12/3999';
  if (Inizio <> '') and (Fine <> '') and
     (StrToDate(Inizio) > StrToDate(Fine)) then
  begin
    RegistraMsg.InserisciMessaggio('A','Data inizio maggiore di data fine!','',selT030.FieldByName('PROGRESSIVO').AsInteger);
    Exit;
  end;
  //A questo punto sono sicura che i dati sono corretti e quindi inserisco
  selT775A.Close;
  selT775A.SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
  selT775A.SetVariable('QUOTA',TipoQuota);
  selT775A.Open;
  if Inizio = '' then //Fine <> '' --> aggiornare le scadenze
  begin
    selT775A.First;
    Anom:=True;
    while not selT775A.Eof do
    begin
      if (StrToDate(Fine) >= selT775A.FieldByName('DECORRENZA').AsDateTime) and
         (StrToDate(Fine) <= selT775A.FieldByName('SCADENZA').AsDateTime) then
      begin
        selT775A.Edit;
        selT775A.FieldByName('SCADENZA').AsDateTime:=StrToDate(Fine);
        selT775A.Post;
        SessioneOracle.Commit;
        Anom:=False;
      end;
      selT775A.Next;
    end;
    if Anom then
    begin
      RegistraMsg.InserisciMessaggio('A','Data ' + Fine + ' non compresa in alcun periodo delle quote',
        '',selT030.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
  end
  else  //Inizio <> '' and Fine <> ''
  begin
    if (Imp = '') and (Ore = '') and (Ind = '') and (Strutt = '') then  //aggiornare le scadenze
    begin
      if selT775A.SearchRecord('DECORRENZA',StrToDate(Inizio),[srFromBeginning]) then
      begin
        if (Fine <> '31/12/3999') and (selT775A.FieldByName('SCADENZA').AsDateTime < StrToDate(Fine)) then
        begin
          RegistraMsg.InserisciMessaggio('A','Data scadenza antecedente alla data di chiusura ' + Fine,
            '',selT030.FieldByName('PROGRESSIVO').AsInteger);
          Exit;
        end
        else
        begin
          selT775A.Edit;
          selT775A.FieldByName('SCADENZA').AsDateTime:=StrToDate(Fine);
          selT775A.Post;
          SessioneOracle.Commit;
        end;
      end
      else
      begin
        RegistraMsg.InserisciMessaggio('A','Data decorrenza ' + Inizio + ' non trovata',
          '',selT030.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
    end
    else  //aggiornare i dati
    begin
      Anom:=False;
      selT775A.First; //Il primo record è la max decorrenza
      while not selT775A.Eof do
      begin
        if ((selT775A.FieldByName('DECORRENZA').AsDateTime > StrToDate(Inizio)) and
            (selT775A.FieldByName('DECORRENZA').AsDateTime <= StrToDate(Fine))) or
           ((selT775A.FieldByName('DECORRENZA').AsDateTime <= StrToDate(Inizio)) and
            (selT775A.FieldByName('SCADENZA').AsDateTime >= StrToDate(Inizio)) and
            (selT775A.FieldByName('SCADENZA').AsDateTime <> StrToDate('31/12/3999'))) then
        begin
          RegistraMsg.InserisciMessaggio('A','Esiste già un periodo intersecante l''intervallo ' + Inizio + ' - ' + Fine,
            '',selT030.FieldByName('PROGRESSIVO').AsInteger);
          Anom:=True;
          Break;
        end;
        selT775A.Next;
      end;
      if Anom then
        Exit;
      //se trovo il record con stesso inizio, la scadenza è 31/12/3999 e quindi lo aggiorno
      if selT775A.SearchRecord('DECORRENZA',StrToDate(Inizio),[srFromBeginning]) then
        selT775A.Edit
      else
      begin
        selT775A.First;
        while not selT775A.Eof do
        begin  //aggiorno a inizio-1 la max(decorrenza) antecedente Inizio che avrà scadenza 31/12/3999
          if (selT775A.FieldByName('DECORRENZA').AsDateTime < StrToDate(Inizio)) and
             (selT775A.FieldByName('SCADENZA').AsDateTime > StrToDate(Inizio)) then
          begin
            selT775A.Edit;
            selT775A.FieldByName('SCADENZA').AsDateTime:=StrToDate(Inizio)-1;
            selT775A.Post;
            SessioneOracle.Commit;
            Break;
          end;
          selT775A.Next;
        end;
        selT775A.Refresh;
        selT775A.Insert;
      end;
      selT775A.FieldByName('PROGRESSIVO').AsInteger:=selT030.FieldByName('PROGRESSIVO').AsInteger;
      selT775A.FieldByName('DECORRENZA').AsDateTime:=StrToDate(Inizio);
      selT775A.FieldByName('SCADENZA').AsDateTime:=StrToDate(Fine);
      selT775A.FieldByName('CODTIPOQUOTA').AsString:=TipoQuota;
      if Imp <> '' then
        selT775A.FieldByName('IMPORTO').AsFloat:=StrToFloatDef(Imp,0);
      if Ore <> '' then
        selT775A.FieldByName('NUM_ORE').AsString:=Ore;
      if Ind <> '' then
        selT775A.FieldByName('PERC_INDIVIDUALE').AsFloat:=StrToFloatDef(Ind,0);
      if Strutt <> '' then
        selT775A.FieldByName('PERC_STRUTTURALE').AsFloat:=StrToFloatDef(Strutt,0);
      selT775A.Post;
      SessioneOracle.Commit;
    end;
  end;
end;

procedure TA166FQuoteIndividualiMW.AcquisizioneDaFileFine;
begin
  SessioneOracle.Commit;
  selT030.Close;
end;

procedure TA166FQuoteIndividualiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(QSIncentivi);
  inherited;
end;

end.

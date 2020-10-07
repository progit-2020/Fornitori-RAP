unit R250UScaricoGiustificativiDtM;

interface

uses
  Windows, Messages, SysUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, R600, R500Lin, StdCtrls,
  StrUtils, RegistrazioneLog, {A004UGiustifAssPresDtM1} A004UGiustifAssPresMW;

type
  TTipoCausale = (tcNone,tcAssenza,tcPresenza,tcGiustificazione);

  TR250FScaricoGiustificativiDtM = class(TR004FGestStoricoDtM)
    selI150: TOracleDataSet;
    selI090: TOracleDataSet;
    DbScarico: TOracleSession;
    FormattaData: TOracleQuery;
    SelT030: TOracleDataSet;
    SelT040: TOracleDataSet;
    SelT265: TOracleDataSet;
    selI102: TOracleDataSet;
    selI102ORA: TStringField;
    dsrI102: TDataSource;
    selI102MODULO: TStringField;
    selGiustif: TOracleDataSet;
    _selSG101: TOracleDataSet;
    delT040: TOracleQuery;
    insT040: TOracleQuery;
    selT275: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI102ORAValidate(Sender: TField);
    procedure selI102NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    nNumRiga:integer;
    bResult,ScaricoAutomatico:Boolean;
    sMessaggio:String;
    //***A004FGiustifAssPresDtM1:TA004FGiustifAssPresDtM1;
    A004MW: TA004FGiustifAssPresMW; //***
    function CercaCausale(Causale:String):TTipoCausale;
    procedure ScriviMessaggio(S:String);
    procedure GestioneParametrizzazione;
    procedure InserisciGiustificativo;
    procedure RecuperaDatoDaFile(sRigaIn:string; sPosizioneIn:string; var sVarOut:string);
  public
    NFCopia,NFCorrente,FileLog,sPv_NomeFileAcquisizione:String;
    FIn: TextFile;
    LScarico,LAzienda,LBadge,LMatricola,LRiga:TLabel;
    ScrollBox:TScrollBox;
    SessioneOracleB015,SOB015Interna: TOracleSession;
    function ControlloConnessioneDatabase:Boolean;
    procedure ConnettiDataBase(Alias:String);
    procedure Scarico(Unico,Automatico:Boolean);
  end;

var
  R250FScaricoGiustificativiDtM: TR250FScaricoGiustificativiDtM;

implementation

{$R *.dfm}

procedure TR250FScaricoGiustificativiDtM.DataModuleCreate(Sender: TObject);
begin
  SessioneOracleB015:=TOracleSession.Create(nil);
  SOB015Interna:=SessioneOracleB015;
  LAzienda:=nil;
  LBadge:=nil;
  LRiga:=nil;
  ScrollBox:=nil;
  selI150.Filter:='CORRENTE = ''S''';
  selI150.Filtered:=True;
end;

procedure TR250FScaricoGiustificativiDtM.ConnettiDataBase(Alias:String);
begin
  // log mantenuto per errori di connessione oracle
  FileLog:=ExtractFilePath(Application.ExeName) + 'B015_' + Alias + '.log';
  selI150.Session:=SessioneOracleB015;
  SelI090.Session:=SessioneOracleB015;
  selI102.Session:=SessioneOracleB015;
  RegistraMsg.SessioneOracleApp:=SessioneOracleB015;
  if not SessioneOracleB015.Connected then
  begin
    SessioneOracleB015.LogonDatabase:=Alias;
    A000LogonDBOracle(SessioneOracleB015);
  end;
  try
    selI150.Open;
    selI102.Open;
    selI090.Open;
  except
  end;
end;

procedure TR250FScaricoGiustificativiDtM.ScriviMessaggio(S:String);
begin
  try R180AppendFile(FileLog,S); except end
end;

function TR250FScaricoGiustificativiDtM.ControlloConnessioneDatabase:Boolean;
begin
  try
    if not SessioneOracleB015.Connected then
    begin
      try
        {$IFDEF IRISWEB}
          SessioneOracleB015.ThreadSafe:=True;
        {$ENDIF}
        SessioneOracleB015.LogOn;
        selI150.Open;
        selI090.Open;
        selI102.Open;
      except
      end;
    end;

    case SessioneOracleB015.CheckConnection(True) of
      ccError:
      begin
        ScriviMessaggio(FormatDateTime('dd/mm/yyyy hh.nn ',Now) + '-[' + SessioneOracleB015.LogonDatabase + '] Connessione con Oracle non esistente');
      end;
      ccReconnected:
      begin
        selI150.Open;
        selI090.Open;
        selI102.Open;
      end;
    end;
  except
  end;
  Result:=SessioneOracleB015.Connected;
end;

procedure TR250FScaricoGiustificativiDtM.Scarico(Unico,Automatico:Boolean);
{Scarico gestendo la multiaziendalità}
var NomeOwner:String;
begin
  A000SettaVariabiliAmbiente;
  ScaricoAutomatico:=Automatico;
  if not ControlloConnessioneDatabase then
    exit;
  NomeOwner:='A103';
  if Owner <> nil then
    NomeOwner:=Copy(Owner.Name,1,{$IFNDEF WEBPJ}4{$ELSE}5{$ENDIF});
  RegistraMsg.IniziaMessaggio(IfThen(ScaricoAutomatico,'B015',NomeOwner));
  RegistraMsg.InserisciMessaggio('I','INIZIO ACQUISIZIONE GIUSTIFICATIVI');
  if not Unico then
    selI150.First;
  //Ciclo sulle parametrizzazioni
  repeat
    if Unico or (selI150.FieldByName('CORRENTE').AsString = 'S') then
    try
      GestioneParametrizzazione;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',E.Message);
    end;
    if not Unico then
      selI150.Next;
  until Unico or selI150.Eof;
end;

procedure TR250FScaricoGiustificativiDtM.GestioneParametrizzazione;
var NB:Integer;
    NomeTabella,Condizione:String;
begin
  RegistraMsg.InserisciMessaggio('I','  Parametrizzazione: ' + selI150.FieldByName('CODICE').AsString);
  if ScrollBox <> nil then
  begin
    LScarico.Caption:=selI150.FieldByName('CODICE').AsString;
    ScrollBox.Repaint;
  end;
  selI090.Close;
  if selI150.FieldByName('AZIENDA').IsNull then
    selI090.SetVariable('AZIENDA','AZIN')
  else
    selI090.SetVariable('AZIENDA',selI150.FieldByName('AZIENDA').AsString);
  selI090.Open;
  RegistraMsg.InserisciMessaggio('I','  Azienda: ' + VarToStrDef(selI090.GetVariable('Azienda'),''),VarToStrDef(selI090.GetVariable('Azienda'),''));
  if (not selI090.FieldByName('VERSIONEDB').IsNull) and (selI090.FieldByName('VERSIONEDB').AsString <> VersionePA) then
  begin
    RegistraMsg.InserisciMessaggio('A',Format('  La versione del database (%s) non corrisponde alla versione del prodotto(%s). Elaborazione interrotta!',[selI090.FieldByName('VERSIONEDB').AsString,VersionePA]),selI090.FieldByName('AZIENDA').AsString);
    Abort;
  end;
  if SelI150.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    sPv_NomeFileAcquisizione:=SelI150.FieldByName('NOMEFILE').AsString;
    //Controllo se il file esiste...
    if not FileExists(sPv_NomeFileAcquisizione) then
    begin
      RegistraMsg.InserisciMessaggio('A','Il percorso del file di acquisizione dei giustificativi ''' + sPv_NomeFileAcquisizione + ''' non è corretto o il file è inesistente.',selI090.FieldByName('AZIENDA').AsString);
      Abort;
    end;
    //Copio il file nella cartella di lavoro temporanea
    //NFCorrente:=Parametri.Path + '\Temp\AssCor';
    NFCorrente:=ExtractFilePath(Application.ExeName)+ 'Archivi\Temp\AssCor' + SessioneOracleB015.LogonDatabase;
    if not CopyFile(PChar(sPv_NomeFileAcquisizione),PChar(NFCorrente),False) then
    begin
      RegistraMsg.InserisciMessaggio('A','Impossibile creare il file di appoggio! Copia da: ' + sPv_NomeFileAcquisizione + ' a: ' + NFCorrente,selI090.FieldByName('AZIENDA').AsString);
      Abort;
    end;
    //Creo la copia di backup del file ASCII di input
    NFCopia:=ExtractFilePath(sPv_NomeFileAcquisizione) + 'AB' + FormatDateTime('yymmdd',Date) + '.';
    bResult:=False;
    NB:=0;
    while not bResult do
    begin
      if CopyFile(PChar(sPv_NomeFileAcquisizione), PChar(NFCopia + Format('%3.3d',[NB])),True) then
        bResult:=True
      else
        NB:=NB + 1;
      if NB = 1000 then
      begin
        if not CopyFile(PChar(sPv_NomeFileAcquisizione),PChar(NFCopia + '999'),False) then
        begin
          //Cancello il file temporaneo creato prima
          DeleteFile(NFCorrente);
          RegistraMsg.InserisciMessaggio('A','Impossibile creare il file di Salvataggio!',selI090.FieldByName('AZIENDA').AsString);
          Abort;
        end;
      end;
    end;
    //Cancello il file creato dall'utente
    DeleteFile(sPv_NomeFileAcquisizione);
    try
      AssignFile(FIn, NFCorrente);
      Reset(FIn);
    except
      RegistraMsg.InserisciMessaggio('A','Impossibile aprire il file ''' + NFCorrente + '''.',selI090.FieldByName('AZIENDA').AsString);
      Abort;
    end;
  end;
  //Setto le impostazioni del database in oggetto
  try
    DbScarico.LogOff;
  except
  end;
  //Distruzione A004
  FreeAndNil(A004MW{A004FGiustifAssPresDtM1});

  DbScarico.LogonDatabase:=SessioneOracleB015.LogonDatabase;
  DbScarico.LogonUserName:=selI090.FieldByName('UTENTE').AsString;
  DbScarico.LogonPassword:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
  try
    DbScarico.Logon;
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',E.Message,selI090.FieldByName('AZIENDA').AsString);
      CloseFile(FIn);
      DeleteFile(NFCorrente);
      Abort;
    end;
  end;
  //Creazione A004
  //***A004FGiustifAssPresDtM1:=TA004FGiustifAssPresDtM1.Create(DBScarico);
  A004MW:=TA004FGiustifAssPresMW.Create(DbScarico); //***

  if ScrollBox <> nil then
  begin
    LAzienda.Caption:=VarToStrDef(selI090.GetVariable('Azienda'),'');
    LRiga.Caption:='0';
    ScrollBox.RePaint;
  end;

  try
    A004MW{A004FGiustifAssPresDtM1}.R600DtM1.VisualizzaAnomalie:=False;
    if selI150.FieldByName('TIPOFILE').AsString = 'T' then
    begin
      try
        NomeTabella:=SelI150.FieldByName('NOMEFILE').AsString;
        selGiustif.Session:=DBScarico;
        selGiustif.Close;
        selGiustif.SetVariable('TABELLA',NomeTabella);
        Condizione:='';
        if selI150.FieldByName('ELABORATO').AsString <> '' then
          Condizione:='where (' + selI150.FieldByName('ELABORATO').AsString + ' IS NULL or ' + selI150.FieldByName('ELABORATO').AsString + '<> ''S'') ';
        if selI150.FieldByName('ID').AsString <> '' then
          Condizione:=Condizione + 'order by ' + selI150.FieldByName('ID').AsString;
        selGiustif.SetVariable('CONDIZIONE',Condizione);
        selGiustif.Open;
      except
        raise exception.Create('Impossibile aprire la tabella ' + NomeTabella + '!');
      end;
    end;
    selT265.Session:=DBScarico;
    selT265.Close;
    selT265.Open;
    selT275.Session:=DBScarico;
    selT275.Close;
    selT275.Open;
    nNumRiga:=0;
    if SelI150.FieldByName('TIPOFILE').AsString = 'F' then
    begin
      while not Eof(FIn) do
        InserisciGiustificativo;
    end
    else
    begin
      while not selGiustif.Eof do
      begin
        InserisciGiustificativo;
        if (selI150.FieldByName('ELABORATO').AsString <> '') then
        begin
          selGiustif.Edit;
          selGiustif.FieldByName(SelI150.FieldByName('ELABORATO').AsString).AsString:='S';
          if (selI150.FieldByName('DATA_ELABORAZIONE').AsString <> '') then
            selGiustif.FieldByName(SelI150.FieldByName('DATA_ELABORAZIONE').AsString).AsString:=DateTimeToStr(R180SysDate(selGiustif.Session));
          if selI150.FieldByName('MESSAGGIO').AsString <> '' then
            selGiustif.FieldByName(selI150.FieldByName('MESSAGGIO').AsString).AsString:=sMessaggio;
          selGiustif.Post;
          selGiustif.Next;
        end
        else
          selGiustif.Delete;
      end;
    end;
  finally
    if SelI150.FieldByName('TIPOFILE').AsString = 'F' then
    begin
      //Chiudo il file temporaneo
      CloseFile(FIn);
      //Cancello il file temporaneo
      DeleteFile(NFCorrente);
    end
    else
      selGiustif.Close;
    RegistraMsg.InserisciMessaggio('I','    Righe elaborate: ' + IntToStr(nNumRiga),selI090.FieldByName('AZIENDA').AsString);
  end;
end;

procedure TR250FScaricoGiustificativiDtM.InserisciGiustificativo;
var
  sIn, sMatricola, sBadge, sAnnoDa, sAnnoA, sMeseDa, sMeseA, sGiornoDa, sGiornoA, sHHDa, sHHA, sMMDa, sMMA, sCausale, sTipo,
  sDataDa, sDataA, sOraDa, sOraA, sIdentificazione, sNumGiorni, sFamiliare:String;
  CausaleOriginale:String;
  nProgressivo, i:Integer;
  DataCorr,DataCorra:TDateTime;
  bAnomalia,CausaleSuccessiva:Boolean;
  TipoCausale:TTipoCausale;
begin
  nNumRiga:=nNumRiga+1;
  sMatricola:='';
  sBadge:='';
  sAnnoDa:='';
  sAnnoA:='';
  sMeseDa:='';
  sMeseA:='';
  sGiornoDa:='';
  sGiornoA:='';
  sHHDa:='';
  sHHA:='';
  sMMDa:='';
  sMMA:='';
  sCausale:='';
  sTipo:='';
  sDataDa:='';
  sDataA:='';
  sOraDa:='';
  sOraA:='';
  sIdentificazione:='';
  sNumGiorni:='';
  sIn:='';
  sFamiliare:='';
  sMessaggio:='';
  if SelI150.FieldByName('TIPOFILE').AsString = 'F' then
    Readln(FIn,sIn);
  if (sIn <> '') or (selGiustif.Active and (not selGiustif.Eof)) then
  begin
    //MATRICOLA
    if (Trim(selI150.FieldByName('MATRICOLA').AsString) <> '0,0') and (Trim(selI150.FieldByName('MATRICOLA').AsString) <> '') then  //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('MATRICOLA').AsString,sMatricola);
    //BADGE
    if (Trim(SelI150.FieldByName('BADGE').AsString) <> '0,0') and (Trim(selI150.FieldByName('BADGE').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('BADGE').AsString,sBadge);
    if (sBadge = '') and (sMatricola = '') then
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Matricola/Badge non indicati.',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Matricola/Badge non indicati.';
      Exit;
    end
    else if (sBadge <> '') and (sMatricola='') then  //Se ho soltanto il badge controllo che sia un valore numerico...
    begin
      try
        sBadge:=inttostr(strtoint(sBadge));
      except
        //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Valore del Badge non numerico.',selI090.FieldByName('AZIENDA').AsString);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Valore del Badge non numerico.';
        exit;
      end;
    end;
    if ScrollBox <> nil then
    begin
      LBadge.Caption:=sBadge;
      LMatricola.Caption:=sMatricola;
      LRiga.Caption:=inttostr(nNumRiga);
      ScrollBox.RePaint;
    end;
    //DATADA
    if (Trim(SelI150.FieldByName('ANNODA').AsString) <> '0,0') and (Trim(selI150.FieldByName('ANNODA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('ANNODA').AsString, sAnnoDa);
    if (Trim(SelI150.FieldByName('MESEDA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('MESEDA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('MESEDA').AsString, sMeseDa);
    if (Trim(SelI150.FieldByName('GIORNODA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('GIORNODA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('GIORNODA').AsString, sGiornoDa);
    if (sAnnoDa <> '') and (sMeseDa <> '') and (sGiornoDa <> '') then
    begin
      try
        if strtoint(sAnnoDa) <= 99 then
          if strtoint(sAnnoDa) <= 50 then
            sAnnoDa:=IntToStr(strtoint(sAnnoDa) + 2000)
          else
            sAnnoDa:=IntToStr(strtoint(sAnnoDa) + 1900);
        sDataDa:=Datetostr(EncodeDate(strtoint(sAnnoDa),strtoint(sMeseDa),strtoint(sGiornoDa)));
      except
        //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data da'' errato.',selI090.FieldByName('AZIENDA').AsString);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data da'' errato.';
        exit;
      end;
    end
    else
    begin
      if (Trim(SelI150.FieldByName('DATADA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('DATADA').AsString) <> '') then //Lorena 11/08/2005
      begin
        RecuperaDatoDaFile(sIn,SelI150.FieldByName('DATADA').AsString, sDataDa);
        if sDataDa <> '' then
        try
          FormattaData.Session:=DBScarico;
          FormattaData.SetVariable('DATA',sDataDa);
          FormattaData.SetVariable('FORMATO',SelI150.FieldByName('FORMATODATA').AsString);
          FormattaData.Execute;
          DataCorr:=FormattaData.Field(0);
          sDataDa:=DateToStr(DataCorr);
        except
          //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
          RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data da'' errato.',selI090.FieldByName('AZIENDA').AsString);
          sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data da'' errato.';
          exit;
        end;
      end;
    end;
    if Trim(sDataDa) = '' then  //Lorena 11/08/2005
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - ''Data da'' incompleta.',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - ''Data da'' incompleta.';
      exit;
    end;
    //DATAA
    if (Trim(SelI150.FieldByName('ANNOA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('ANNOA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('ANNOA').AsString, sAnnoA);
    if (Trim(SelI150.FieldByName('MESEA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('MESEA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('MESEA').AsString, sMeseA);
    if (Trim(SelI150.FieldByName('GIORNOA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('GIORNOA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('GIORNOA').AsString, sGiornoA);
    if (sAnnoA<>'') and (sMeseA<>'') and (sGiornoA<>'') then
    begin
      try
        if strtoint(sAnnoA) <= 99 then
          if strtoint(sAnnoA) <= 50 then
            sAnnoA:=IntToStr(strtoint(sAnnoA) + 2000)
          else
            sAnnoA:=IntToStr(strtoint(sAnnoA) + 1900);
        sDataA:=Datetostr(EncodeDate(strtoint(sAnnoA),strtoint(sMeseA),strtoint(sGiornoA)));
      except
        //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data a'' errato.',selI090.FieldByName('AZIENDA').AsString);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data a'' errato.';
        exit;
      end;
    end
    else if (Trim(SelI150.FieldByName('NUMGIORNI').AsString) <> '0,0') and (Trim(SelI150.FieldByName('NUMGIORNI').AsString) <> '') then //Lorena 11/08/2005
    begin
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('NUMGIORNI').AsString, sNumGiorni);
      if Trim(sNumGiorni) <> '' then
      begin
        try
          DataCorr:=StrToDate(sDataDa);
          sDataA:=DateToStr(DataCorr + StrToInt(sNumGiorni) - 1);
        except
          //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
          RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Valore di Numero giorni errato.',selI090.FieldByName('AZIENDA').AsString);
          sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Valore di Numero giorni errato.';
          exit;
        end;
      end;
    end
    else   //Norman 22/02/2007
    begin
      if (Trim(SelI150.FieldByName('DATAA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('DATAA').AsString) <> '') then
      begin
        RecuperaDatoDaFile(sIn,SelI150.FieldByName('DATAA').AsString, sDataA);
        if sDataA <> '' then
        try
          FormattaData.Session:=DBScarico;
          FormattaData.SetVariable('DATA',sDataA);
          FormattaData.SetVariable('FORMATO',SelI150.FieldByName('FORMATODATA').AsString);
          FormattaData.Execute;
          DataCorra:=FormattaData.Field(0);
          sDataA:=DateToStr(DataCorra);
        except
          //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
          RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data a'' errato.',selI090.FieldByName('AZIENDA').AsString);
          sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Data a'' errato.';
          exit;
        end;
      end;
    end;
    if Trim(sDataA) = '' then
    begin
      sDataA:=sDataDa;
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      (*
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - ''Data a'' incompleta.',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - ''Data a'' incompleta.';
      exit;
      *)
    end;
    //ORADA
    if (Trim(SelI150.FieldByName('ORADA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('ORADA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('ORADA').AsString, sHHDa);
    if (Trim(SelI150.FieldByName('MINDA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('MINDA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('MINDA').AsString, sMMDa);
    if (sHHDa <> '') and (sMMDa <> '') then
    begin
      try
        sOraDa:=FormatDateTime('hh.nn',EncodeTime(strtoint(sHHDa), strtoint(sMMDa),0,0));
      except
        //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Ora da'' errato.',selI090.FieldByName('AZIENDA').AsString);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Ora da'' errato.';
        exit;
      end;
    end
    else if ((sHHDa <> '') and (sMMDa = '')) or ((sHHDa = '') and (sMMDa <> '')) then
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - ''Ora da'' incompleta.',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - ''Ora da'' incompleta.';
      exit;
    end
    else if (Trim(SelI150.FieldByName('HHMMDA').AsString) <> '') then
    begin
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('HHMMDA').AsString, sOraDa);
      sOraDa:=R180MinutiOre(R180OreMinutiExt(sOraDa));
    end;
    if sOraDa = '' then
      sOraDa:='00.00';
    //ORAA
    if (Trim(SelI150.FieldByName('ORAA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('ORAA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('ORAA').AsString, sHHA);
    if (Trim(SelI150.FieldByName('MINA').AsString) <> '0,0') and (Trim(SelI150.FieldByName('MINA').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('MINA').AsString, sMMA);
    if (sHHA <> '') and (sMMA <> '') then
    begin
      try
        sOraA:=FormatDateTime('hh.nn',EncodeTime(strtoint(sHHA),strtoint(sMMA),0,0));
      except
        //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Ora a'' errato.',selI090.FieldByName('AZIENDA').AsString);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Formato ''Ora a'' errato.';
        exit;
      end;
    end
    else if ((sHHA <> '') and (sMMA = '')) or ((sHHA = '') and (sMMA <> '')) then
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - ''Ora a'' incompleta.',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - ''Ora a'' incompleta.';
      exit;
    end
    else if (Trim(SelI150.FieldByName('HHMMA').AsString) <> '') then
    begin
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('HHMMA').AsString, sOraA);
      sOraA:=R180MinutiOre(R180OreMinutiExt(sOraA));
    end;
    if sOraA = '' then
      sOraA:='00.00';
    //CAUSALE
    if (Trim(SelI150.FieldByName('CAUSALE').AsString) <> '0,0') and (Trim(SelI150.FieldByName('CAUSALE').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('CAUSALE').AsString, sCausale);
    //TIPO
    if (Trim(SelI150.FieldByName('TIPO').AsString) <> '0,0') and (Trim(SelI150.FieldByName('TIPO').AsString) <> '') then //Lorena 11/08/2005
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('TIPO').AsString, sTipo);
    if sCausale = '' then
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Causale non indicata',selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Causale non indicata';
      exit;
    end
    else
    begin
      //Controllo l'esistenza della causale
      TipoCausale:=CercaCausale(sCausale);
      case TipoCausale of
      tcAssenza:sCausale:=SelT265.FieldByName('Codice').AsString;
      tcPresenza:sCausale:=SelT275.FieldByName('Codice').AsString;
      tcNone:begin
               //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
               RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Causale ''' + sCausale + ''' inesistente',selI090.FieldByName('AZIENDA').AsString);
               sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Causale ''' + sCausale + ''' inesistente';
               exit;
             end;
      end;
    end;
    //Se ho indicato la matricola, leggo il progressivo associato alla matricola
    //altrimenti leggo il progressivo associato al badge
    SelT030.Active:=False;
    SelT030.Session:=DBScarico;
    SelT030.SQL.Clear;
    SelT030.DeleteVariables;
    if sMatricola <> '' then
    begin
      if selI150.FieldByName('MATRICOLA_NUMERICA').AsString = 'S' then
        SelT030.Sql.Add('SELECT PROGRESSIVO FROM T030_ANAGRAFICO WHERE TO_NUMBER(MATRICOLA) = ' + sMatricola)
      else
        SelT030.Sql.Add('SELECT PROGRESSIVO FROM T030_ANAGRAFICO WHERE MATRICOLA = ''' + sMatricola + '''');
      sIdentificazione:=' (MATRICOLA ' + sMatricola + ')';
    end
    else
    begin
      SelT030.Sql.Add('SELECT PROGRESSIVO FROM T430_STORICO T430 WHERE BADGE = ' + sBadge);
      SelT030.Sql.Add(' AND :DATA BETWEEN DATADECORRENZA AND DATAFINE');
      SelT030.Sql.Add(' AND EXISTS(SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND :DATA BETWEEN INIZIO AND NVL(FINE,:DATA + 1))');
      SelT030.DeclareVariable('DATA',otDate);
      SelT030.SetVariable('DATA',strtodate(sDataA));
      sIdentificazione:=' (BADGE ' + sBadge + ')';
    end;
    SelT030.Active:=True;
    if not SelT030.Eof then
      nProgressivo:=SelT030.FieldByName('PROGRESSIVO').asInteger
    else
    begin
      //Si tratta di un'anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Il dipendente indicato non risulta presente in anagrafica' + sIdentificazione,selI090.FieldByName('AZIENDA').AsString);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Il dipendente indicato non risulta presente in anagrafica' + sIdentificazione;
      exit;
    end;
    //Familiare (datanas familiare)
    A004MW{A004FGiustifAssPresDtM1}.Var_Familiari:='';
    if Trim(SelI150.FieldByName('FAMILIARE').AsString) <> '' then
    begin
      RecuperaDatoDaFile(sIn,SelI150.FieldByName('FAMILIARE').AsString, sFamiliare);
      // se la data è valorizzata ed è una data valida viene salvata
      // altrimenti viene impostata a 0 (ossia null)
      // nota: se la data è valorizzata ma non è valida viene ugualmente impostata a 0
      //       se la causale richiede il familiare -> la segnalazione dell'anomalia sarà delegata
      //       alla fase di controllo prima dell'inserimento del giustificativi
      if Trim(sFamiliare) <> '' then
      begin
        try
          FormattaData.Session:=DBScarico;
          FormattaData.SetVariable('DATA',sFamiliare);
          FormattaData.SetVariable('FORMATO',SelI150.FieldByName('FORMATODATA').AsString);
          FormattaData.Execute;
          A004MW{A004FGiustifAssPresDtM1}.Var_Familiari:=FormattaData.FieldAsString(0);
        except
          // la data del familiare viene annullata
          A004MW{A004FGiustifAssPresDtM1}.Var_Familiari:='';
        end;
      end;
    end;
    //Converto il tipo dell'assenza nel tipo previsto per la nostra codifica
    if sTipo <> '' then
    begin
      if sTipo = SelI150.FieldByName('CODICE_TIPOI').AsString then
        sTipo:='I'
      else if sTipo = SelI150.FieldByName('CODICE_TIPOM').AsString then
        sTipo:='M'
      else if sTipo = SelI150.FieldByName('CODICE_TIPOD').AsString then
        sTipo:='D'
      else if sTipo = SelI150.FieldByName('CODICE_TIPON').AsString then
        sTipo:='N'
      else
      begin
        //Si tratta di un anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Tipo di assenza non riconosciuto',selI090.FieldByName('AZIENDA').AsString,nProgressivo);
        sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Tipo di assenza non riconosciuto' + sIdentificazione;
        exit;
      end;
    end
    else
    begin
      if (sOraDa='00.00') and (sOraA='00.00') then
        sTipo:='I'
      else if (*(sOraDa<>'00.00') and*) (sOraA<>'00.00') then
        sTipo:='D'
      else
        sTipo:='N'
    end;
    //Controllo il tipo di giustificativo (GG,MG,N.ore,DaOre-AOre)
    if (*((sTipo = 'D') or *)(sTipo = 'N') and (sOraDa='00.00') then
    begin
      //Si tratta di un anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Manca il dato ''Da Ore.''',selI090.FieldByName('AZIENDA').AsString,nProgressivo);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Manca il dato ''Da Ore.''' + sIdentificazione;
      exit;
    end;
    if (sTipo = 'D') and (sOraA='00.00') then
    begin
      //Si tratta di un anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A','Riga n. ' + inttostr(nNumRiga) + ' - Manca il dato ''A Ore.''',selI090.FieldByName('AZIENDA').AsString,nProgressivo);
      sMessaggio:='Riga n. ' + inttostr(nNumRiga) + ' - Manca il dato ''A Ore.''' + sIdentificazione;
      exit;
    end;
    //Ripeto i controlli e gli inserimenti nel caso si tratti di un periodo
    CausaleSuccessiva:=False;
    CausaleOriginale:=sCausale;

    //Creare a004 dopo aver fatto il logon su dbscarico, e vedere dove distruggerlo
    //Cercare di non riferirsi alla R600 (prima di questo blocco), oppure di riferirsi a A004.R600
    //Vedere come passare DBScarico a A004 in modo che A004.SessioneOracle = DbScarico
    //Prob: SessioneOracle:=DbScarico
    with A004MW{A004FGiustifAssPresDtM1} do
    begin
      Q040.Close;
      Q040.SetVariable('PROGRESSIVO',nProgressivo);
      Q040.Open;

      chkNuovoPeriodo:=False;
      GestioneSingolaDM:=True;
      AnomalieInterattive:=False;
      R600DtM1.VisualizzaAnomalie:=False;
      R600DtM1.AnomalieBloccanti:=True;
      R600DtM1.AnomalieNonBloccanti:='1,10';
      //***ProgressBar:=nil;

      Var_Gestione:=0;
      Var_TipoCaus:=IfThen(TipoCausale = tcAssenza,1,2);
      Var_TipoGiust_Count:=IfThen(TipoCausale = tcAssenza,4,2);
      if sTipo[1] = 'I' then
        Var_TipoGiust:=0
      else if sTipo[1] = 'M' then
        Var_TipoGiust:=1
      else if sTipo[1] = 'N' then
        Var_TipoGiust:=2 - IfThen(TipoCausale = tcAssenza,0,2)
      else if sTipo[1] = 'D' then
        Var_TipoGiust:=3 - IfThen(TipoCausale = tcAssenza,0,2);
      Var_DaOre:=sOraDa;
      Var_AOre:=sOraA;
      Var_NumGG:=0;
      Var_DaData:=sDataDa;
      Var_AData:=sDataA;
      Var_Causale:=sCausale;
      Var_Progressivo:=nProgressivo;

      Giustif.Causale:=sCausale;
      Giustif.Inserimento:=True;
      Giustif.Modo:=sTipo[1];
      Giustif.DaOre:=sOraDa;
      Giustif.AOre:=sOraA;

      DataInizio:=StrToDate(sDataDa);
      DataFine:=StrToDate(sDataA);
      DataInizioOrig:=DataInizio;
      Chiamante:='R250';
      if (SelI150.FieldByName('TIPO_OPERAZIONE').AsString = '') or
         (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'I') then
      begin
        InserisciGiustif(False);
        for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
          RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
        for I := 0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[I],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
      end
      else if ((bAnomalia) and (SelI150.FieldByName('ANOMALIE_BLOCCANTI').AsString = 'S')) or
              (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'C') then
      begin
        CancellaGiustif(False,False);
        for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
          RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
      end;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TR250FScaricoGiustificativiDtM.RecuperaDatoDaFile(sRigaIn:string; sPosizioneIn:string; var sVarOut:string);
var
  P, nInizio, nFine, i, PosInizio:integer;
  Appoggio:String;
begin
  if selI150.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    P:=Pos(',',sPosizioneIn);
    nInizio:=strtoint(Copy(sPosizioneIn,1,P - 1));
    nFine:=strtoint(Copy(sPosizioneIn,P + 1,Length(sPosizioneIn)));
    if selI150.FieldByName('SEPARATORE').IsNull then  //Lorena 11/08/2005
      sVarOut:=trim(copy(sRigaIn, nInizio, nFine))
    else
    begin  //Lorena 11/08/2005
      Appoggio:=sRigaIn;
      for i:=1 to nInizio -1 do
      begin
        PosInizio:=Pos(selI150.FieldByName('SEPARATORE').AsString,Appoggio);
        Appoggio:=Copy(Appoggio,PosInizio + 1,Length(Appoggio) - PosInizio)
      end;
      if Pos(selI150.FieldByName('SEPARATORE').AsString,Appoggio) > 0 then
        sVarOut:=Trim(Copy(Appoggio,1,Pos(selI150.FieldByName('SEPARATORE').AsString,Appoggio) - 1))
      else
        sVarOut:=Appoggio;
    end;
  end
  else
    //sVarOut:=selGiustif.FieldByName(sPosizioneIn).AsString;
    sVarOut:=VarToStr(selGiustif.FieldByName(sPosizioneIn).Value);
end;

function TR250FScaricoGiustificativiDtM.CercaCausale(Causale:String):TTipoCausale;
{Ricerca il codice causale per stabilirne il tipo (Nessuno,Assenza,Presenza,Giustificazione)}
begin
  Result:=tcNone;
  (* Alberto 17/10/2005; spostato all'inizio dell'elaborazione
  selT265.Session:=DBScarico;
  selT265.Close;
  selT265.Open;
  *)
  if SelI150.FieldByName('DESCCAUSALE').AsString = 'S' then //Lorena 22/08/2005
  begin
    if SelT265.Locate('Descrizione',Trim(Causale),[loCaseInsensitive]) then
    begin
      Result:=tcAssenza;
      exit;
    end
    else if SelT275.Locate('Descrizione',Trim(Causale),[loCaseInsensitive]) then
    begin
      Result:=tcPresenza;
      exit;
    end

  end
  else
  begin
    if SelT265.Locate('Codice',Trim(Causale),[loCaseInsensitive]) then
    begin
      Result:=tcAssenza;
      exit;
    end
    else if SelT275.Locate('Codice',Trim(Causale),[loCaseInsensitive]) then
    begin
      Result:=tcPresenza;
      exit;
    end;
  end;
end;

procedure TR250FScaricoGiustificativiDtM.selI102NewRecord(DataSet: TDataSet);
begin
  selI102.FieldByName('MODULO').AsString:='B015';
end;

procedure TR250FScaricoGiustificativiDtM.selI102ORAValidate(Sender: TField);
begin
  if not Sender.IsNull then
    R180OraValidate(Sender.Asstring);
end;

procedure TR250FScaricoGiustificativiDtM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  if A004MW{A004FGiustifAssPresDtM1} <> nil then
    FreeAndNil(A004MW{A004FGiustifAssPresDtM1});

  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(SOB015Interna);
end;

end.

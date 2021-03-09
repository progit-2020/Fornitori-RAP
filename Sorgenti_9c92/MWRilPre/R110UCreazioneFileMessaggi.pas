unit R110UCreazioneFileMessaggi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, DBClient, Crtl, Oracle, A000UCostanti, A000USessione, A000UInterfaccia,
  RegistrazioneLog,
  C180FunzioniGenerali, R450, R500Lin, Rp502Pro, R600, Math, StrUtils, Variants;

type
  TR110FCreazioneFileMessaggi = class(TDataModule)
    QSQL: TOracleQuery;
    selT361: TOracleDataSet;
    selT361CODICE: TStringField;
    selT361DESCRIZIONE: TStringField;
    selT361FUNZIONE: TStringField;
    selT361CAUSMENSA: TStringField;
    selT361VERSO: TStringField;
    selT361POSTAZIONE: TStringField;
    selT361INDIRIZZO_TERMINALE: TStringField;
    selT361INDIRIZZO_IP: TStringField;
    selT361RICEZIONE_MESSAG: TStringField;
    selT265: TOracleDataSet;
    insT295: TOracleQuery;
    delT295: TOracleQuery;
    selT295Prog: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    F:TextFile;
    Riga,Stringa,NomiColonne,ParteDF,Reg_Testo,CausAssOld:string;
    ListaOrologi,ListaNumRec,ListaOrologiIntestazione,lstCampiChiave:TStringList;
    Orologi,DatiRiepilogativi,DatiGiornalieri:Boolean;
    MessaggioValido:Boolean;
    ContaDV:integer;
    DataConsuntivoOld:TDateTime;
    R450DtM:TR450DtM1;
    R502ProDtM:TR502ProDtM1;
    R600DtM:TR600DtM1;
    SessioneIWR110:TSessioneIrisWIN;
    procedure ElaborazioneInizio;
    procedure CicloPrincipale;
    procedure ElaborazioneOrologi(var TotOrologi:integer);
    procedure ElaboraRigaMessaggio(TipoRec:String);
    procedure ScriviRigaMessaggio(TipoRec:String);
    procedure PreparaRigaMessaggio;
    procedure Formatta(Tipo,UMisura:String; var Valore:String);
    procedure RegistraMessaggio;
  public
    { Public declarations }
    NomeFile,TipoFile,Parametrizzazione,RegistraMSG:String;
    Skippa,ErroreSuLog:Boolean;
    TipoScrittura:Integer;
    DataConsuntivo,DataMessaggio,OraMessaggio,DataScadenza:TDateTime;
    //LogMessaggi:TStringList;
    SelC700:TOracleDataSet;
    SelT295:TOracleDataSet;
    SelT292:TClientDataSet;
    procedure Elabora;
  end;

(*var
  R110FCreazioneFileMessaggi: TR110FCreazioneFileMessaggi;*)

implementation

{$R *.DFM}

procedure TR110FCreazioneFileMessaggi.DataModuleCreate(Sender: TObject);
var i:integer;
begin
  SessioneIWR110:=A000SessioneIrisWIN;
  if Self.Owner <> nil then
    if Self.Owner is TSessioneIrisWIN then
      SessioneIWR110:=Self.Owner as TSessioneIrisWIN;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneIWR110.SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneIWR110.SessioneOracle;
  end;
  R450DtM:=TR450DtM1.Create(SessioneIWR110.SessioneOracle);
  R502ProDtM:=TR502ProDtM1.Create(SessioneIWR110.SessioneOracle);
  R600DtM:=TR600DtM1.Create(SessioneIWR110.SessioneOracle);
  selT361.Open;
  ListaOrologi:=TStringList.Create;
  ListaOrologiIntestazione:=TStringList.Create;
  ListaNumRec:=TStringList.Create;
  lstCampiChiave:=TStringList.Create;
end;

procedure TR110FCreazioneFileMessaggi.Elabora;
begin
  // Inizio
  SelT292.First;
  ErroreSuLog:=False;
  //LogMessaggi.Clear;
  //LogMessaggi.Add('Parametrizzazione: ' + Parametrizzazione);
  //LogMessaggi.Add('Inizio elaborazione: ' + DateTimeToStr(Now));
  TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Parametrizzazione: ' + Parametrizzazione,SessioneIWR110.Parametri.Azienda);
  TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Inizio elaborazione: ' + DateTimeToStr(Now),SessioneIWR110.Parametri.Azienda);
  ContaDV:=0;
  Orologi:=SelT292.Locate('TIPO','PT',[]) or SelT292.Locate('TIPO','IN',[]);
  DatiRiepilogativi:=SelT292.Locate('VALORE_DEFAULT','SALDOMMCOR',[]) or
//                     SelT292.Locate('VALORE_DEFAULT','SALDOAACOR',[]) or    Lorena 16/10/2006
//                     SelT292.Locate('VALORE_DEFAULT','SALDOAANEG',[]) or
                     SelT292.Locate('VALORE_DEFAULT','SALDOAACORR',[]) or
                     SelT292.Locate('VALORE_DEFAULT','SALDOAAPREC',[]) or
                     SelT292.Locate('VALORE_DEFAULT','SALDOTOT',[]) or
                     SelT292.Locate('VALORE_DEFAULT','SALDOTOTNEG',[]) or
                     SelT292.Locate('VALORE_DEFAULT','PRES_RESO_MESE',[]) or
                     SelT292.Locate('VALORE_DEFAULT','PRES_RESIDUO',[]) or
                     SelT292.Locate('VALORE_DEFAULT','RECUPERO_MOBILE',[]) or
                     SelT292.Locate('VALORE_DEFAULT','DEBITO_CREDITO',[]) or
                     SelT292.Locate('VALORE_DEFAULT','BANCAORE_RESIDUA',[]);
  DatiGiornalieri:=SelT292.Locate('VALORE_DEFAULT','DATI_GG',[loPartialKey]);
  // Elaborazione
  try
    ElaborazioneInizio;
    CicloPrincipale;
  except
    on E:Exception do
    begin
      //LogMessaggi.Add('  ' + E.Message);
      TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  ' + E.Message,SessioneIWR110.Parametri.Azienda);
      ErroreSuLog:=True;
    end;
  end;
  // Chiusura
  SelT292.Filter:='';
  SelT292.Filtered:=False;
  if TipoFile = 'A' then
    try
      //Normalmente dovrebbe essere già chiuso. Viene richiuso per non bloccarlo nel caso ci siano stati errori precedenti
      CloseFile(F);
    except
    end;
  //LogMessaggi.Add('Totale messaggi elaborati: ' + IntToStr(ContaDV));
  //LogMessaggi.Add('Fine elaborazione: ' + DateTimeToStr(Now));
  TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Totale messaggi elaborati: ' + IntToStr(ContaDV),SessioneIWR110.Parametri.Azienda);
  TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Fine elaborazione: ' + DateTimeToStr(Now),SessioneIWR110.Parametri.Azienda);
end;

procedure TR110FCreazioneFileMessaggi.ElaborazioneInizio;
var OldNumRec,S:string;
    DV:boolean;
begin
  // CREAZIONE FILE SEQ - TABELLA ORACLE
  DV:=False;
  if TipoFile = 'A' then
  begin
    //Gestione file sequenziale
    if not (FileExists(NomeFile) and (TipoScrittura = 0)) then
      DeleteFile(NomeFile);
  end
  else
    //Gestione tabella Oracle
    with QSQL do
    begin
      // cancellazione tabella oracle solo se 'Ricrea'
      if TipoScrittura = 1 then
      try
        SQL.Clear;
        if Parametri.VersioneOracle >= 10 then
          SQL.Add('DROP TABLE ' + NomeFile + ' PURGE')
        else
          SQL.Add('DROP TABLE ' + NomeFile);
        Execute;
      except
        //LogMessaggi.Add('  CANCELLAZIONE TABELLA FALLITA!');
        TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  CANCELLAZIONE TABELLA FALLITA!');
        ErroreSuLog:=True;
      end;
      lstCampiChiave.Clear;
      SelT292.First;
      SQL.Clear;
      SQL.Add('CREATE TABLE ' + NomeFile + '(');
      OldNumRec:=SelT292.FieldByName('NUMERO_RECORD').AsString;
      while not SelT292.Eof do
      begin
        S:='';
        if SQL.Count > 1 then S:=S + ',';
        S:=S + SelT292.FieldByName('NOME_COLONNA').AsString +' VARCHAR2(' + SelT292.FieldByName('LUNGHEZZA').AsString + ')';
        SQL.Add(S);
        //Gestione campi chiave per l'update
        if SelT292.FieldByName('CHIAVE').AsString = 'S' then
          lstCampiChiave.Add(SelT292.FieldByName('NOME_COLONNA').AsString + '=');
        SelT292.Next;
        if SelT292.FieldByName('NUMERO_RECORD').AsString <> OldNumRec then
          if not DV then
            OldNumRec:=SelT292.FieldByName('NUMERO_RECORD').AsString
          else
            Break;
        if SelT292.FieldByName('TIPO_RECORD').AsString = 'DV' then DV:=True;
      end;
      SQL.Add(') TABLESPACE ' + SessioneIWR110.Parametri.TSAusiliario);
      SQL.Add('PCTFREE 5 PCTUSED 80 STORAGE (PCTINCREASE 0 INITIAL 512K NEXT 512K) NOPARALLEL');
      try
        Execute;
      except
        if TipoScrittura = 1 then
        begin
          //LogMessaggi.Add('  CREAZIONE TABELLA FALLITA!');
          TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  CREAZIONE TABELLA FALLITA!');
          ErroreSuLog:=True;
        end;
      end;
    end;
end;

procedure TR110FCreazioneFileMessaggi.CicloPrincipale;
var i,TotOrologi:integer;
    INT:boolean;
begin
// ELABORAZIONE CICLO PRINCIPALE
  INT:=False;
  TotOrologi:=0;
  ListaOrologiIntestazione.Clear;
  SelC700.First;
  if selT295 = nil then
    selT295:=selT295Prog;
  if selT295 = selT295Prog then
  begin
    selT295.SetVariable('DATA',Trunc(DataMessaggio));
    selT295.Close;
    selT295.Open;
  end;
  while not SelC700.Eof do       // ciclo dipendenti
  begin
    TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Elaborazione dati di ' + selC700.FieldByName('COGNOME').AsString + ' ' + selC700.FieldByName('NOME').AsString,SessioneIWR110.Parametri.Azienda,selC700.FieldByName('PROGRESSIVO').AsInteger);
    CausAssOld:='';
    DataConsuntivoOld:=0;
    if TipoFile = 'A' then
    begin
      AssignFile(F,NomeFile);
      if FileExists(NomeFile) then
        Append(F)
      else
        Rewrite(F);
    end;
    try
      Reg_Testo:='';
      if Orologi then
        ElaborazioneOrologi(TotOrologi);
      // Controllo su esistenza messaggio
      if (RegistraMSG <> 'S') or
         ((RegistraMSG = 'S') and not Skippa) or
         ((RegistraMSG = 'S') and Skippa and (not selT295.SearchRecord('PROGRESSIVO',selC700.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]))) then
        // Controllo su valorizzazione badge
        if SelC700.FieldByName('T430BADGE').AsString <> '' then
          for i:=0 to TotOrologi do  // ciclo orologi
          begin
            if Orologi then
            begin
              selT361.SearchRecord('CODICE',ListaOrologi[i],[srFromBeginning]);
              if (TipoFile = 'A') and (TipoScrittura = 1) then
                if ListaOrologiIntestazione.IndexOf(ListaOrologi[i]) = -1 then
                begin
                // crea intestazione se: file seq, Ricrea, non ancora elaborata x questo orologio in caso di elab con orologi
                  ListaOrologiIntestazione.Add(ListaOrologi[i]);
                  ParteDF:='';
                  ElaboraRigaMessaggio('IN');
                end;
            end
            else if (TipoFile = 'A') and (TipoScrittura = 1) then
              if not INT then
              begin
              // crea intestazione se: file seq, Ricrea, non ancora elaborata in caso di elab senza orologi
                INT:=True;
                ParteDF:='';
                ElaboraRigaMessaggio('IN');
              end;
          // crea record DF se: badge valorizzato
            ParteDF:='';
            ElaboraRigaMessaggio('DF');
          // crea record DV se: badge valorizzato
            if DatiRiepilogativi then  //R450 se sono richiesti dati riepilogativi
              R450DtM.ConteggiMese('Generico',R180Anno(DataConsuntivo),R180Mese(DataConsuntivo),selC700.FieldByName('PROGRESSIVO').AsInteger);
            ElaboraRigaMessaggio('DV');
          end
        else
          //LogMessaggi.Add('  ' + selC700.FieldByName('MATRICOLA').AsString + '-' + selC700.FieldByName('COGNOME').AsString + ' ' +
          //  selC700.FieldByName('NOME').AsString + ': DIPENDENTE SENZA BADGE VALORIZZATO')
          TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  ' + selC700.FieldByName('MATRICOLA').AsString + '-' + selC700.FieldByName('COGNOME').AsString + ' ' +
            selC700.FieldByName('NOME').AsString + ': DIPENDENTE SENZA BADGE VALORIZZATO','',selC700.FieldByName('PROGRESSIVO').AsInteger)
      else if selT295 <> selT295Prog then
        //LogMessaggi.Add('  ' + selC700.FieldByName('MATRICOLA').AsString + '-' + selC700.FieldByName('COGNOME').AsString + ' ' +
        //    selC700.FieldByName('NOME').AsString + ': MESSAGGIO GIA'' ESISTENTE PER IL DIPENDENTE');
        TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  ' + selC700.FieldByName('MATRICOLA').AsString + '-' + selC700.FieldByName('COGNOME').AsString + ' ' +
            selC700.FieldByName('NOME').AsString + ': MESSAGGIO GIA'' ESISTENTE PER IL DIPENDENTE','',selC700.FieldByName('PROGRESSIVO').AsInteger);
      SessioneIWR110.SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        //LogMessaggi.Add('  ' + E.Message);
        TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  ' + E.Message,'',selC700.FieldByName('PROGRESSIVO').AsInteger);
        ErroreSuLog:=True;
      end;
    end;
    try
      if TipoFile = 'A' then CloseFile(F);
    except
    end;
    SelC700.Next;
  end;
end;

procedure TR110FCreazioneFileMessaggi.ElaborazioneOrologi(var TotOrologi:integer);
var i:integer;
begin
// CARICAMENTO LISTA OROLOGI DA ELABORARE
  ListaOrologi.Clear;
  ListaOrologi.CommaText:=SelC700.FieldByName('T430TERMINALI').AsString;
  if ListaOrologi.Count = 0 then
  begin
    selT361.First;
    while not selT361.Eof do
    begin
      ListaOrologi.Add(selT361.FieldByName('CODICE').AsString);
      selT361.Next;
    end;
  end
  else
    for i:=ListaOrologi.Count - 1 downto 0 do
      if not selT361.SearchRecord('CODICE',ListaOrologi[i],[srFromBeginning]) then
        ListaOrologi.Delete(i);
  TotOrologi:=ListaOrologi.Count - 1;
end;

procedure TR110FCreazioneFileMessaggi.ElaboraRigaMessaggio(TipoRec:string);
var OldNumRec:integer;
begin
// CONTEGGIO NUMERO RECORD DA ELABORARE
  OldNumRec:=0;
  ListaNumRec.Clear;
  with SelT292 do
  begin
  // conta quanti record di tipo xx ci sono
    Filter:='TIPO_RECORD=''' + TipoRec + '''';
    Filtered:=True;
    First;
    while not Eof do
    begin
      if FieldByName('NUMERO_RECORD').AsInteger <> OldNumRec then
      begin
        OldNumRec:=FieldByName('NUMERO_RECORD').AsInteger;
        ListaNumRec.Add(IntToStr(FieldByName('NUMERO_RECORD').AsInteger));
      end;
      Next;
    end;
  end;
  ScriviRigaMessaggio(TipoRec);
end;

procedure TR110FCreazioneFileMessaggi.ScriviRigaMessaggio(TipoRec:string);
var i,j:Integer;
    ColonneDF:String;
begin
// SCRITTURA RECORD MESSAGGIO
  for i:=0 to (ListaNumRec.Count - 1) do
  begin
    with SelT292 do
    begin
      Filter:='(TIPO_RECORD=''' + TipoRec + ''') AND (NUMERO_RECORD=' + ListaNumRec[i] + ')';
      Filtered:=True;
    end;
    MessaggioValido:=True;
    PreparaRigaMessaggio;
    if not MessaggioValido then
      exit;
    if TipoRec = 'DF' then
      if TipoFile = 'A' then
        ParteDF:=Riga
      else
      begin
        ColonneDF:=NomiColonne;
        ParteDF:=Stringa;
      end;
    if TipoRec <> 'DF' then
      if TipoFile = 'A' then
      begin
        if ParteDF <> '' then
          Riga:=ParteDF + Riga;
        Writeln(F,Riga);
      end
      else
      begin
        if ParteDF <> '' then
        begin
          Stringa:=ParteDF + ',' + Stringa;
          NomiColonne:=NomiColonne + ',' + ColonneDF;
        end;
        if lstCampiChiave.Count > 0 then
        begin
          QSQL.Clear;
          QSQL.SQL.Add('DELETE FROM ' + NomeFile + ' WHERE');
          for j:=0 to lstCampiChiave.Count - 1 do
            if j < lstCampiChiave.Count - 1 then
              QSQL.SQL.Add(lstCampiChiave[j] + ' AND ')
            else
              QSQL.SQL.Add(lstCampiChiave[j]);
        try
          QSQL.Execute;
        except
          on E:Exception do
          begin
            //LogMessaggi.Add('  CANCELLAZIONE IN TABELLA FALLITA! ' + E.Message);
            TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  CANCELLAZIONE IN TABELLA FALLITA! ' + E.Message);
            ErroreSuLog:=True;
          end;
        end;
        end;
        QSQL.Clear;
        QSQL.SQL.Add('INSERT INTO ' + NomeFile + ' (' + NomiColonne + ') VALUES (' + Stringa + ')');
        try
          QSQL.Execute;
        except
          on E:Exception do
          begin
            //LogMessaggi.Add('  INSERIMENTO IN TABELLA FALLITA! ' + E.Message);
            TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  INSERIMENTO IN TABELLA FALLITA! ' + E.Message);
            ErroreSuLog:=True;
          end;
        end;
      end;
    if TipoRec = 'DV' then
    begin
      ContaDV:=ContaDV + 1;
      if RegistraMSG = 'S' then
        //Registrazione messaggio
        RegistraMessaggio
      else if RegistraMSG = 'P' then
      begin
        //Cancellazione messaggio
        delT295.SetVariable('PROGRESSIVO',selC700.FieldByName('PROGRESSIVO').AsInteger);
        delT295.Execute;
      end;
    end;
  end;
end;

procedure TR110FCreazioneFileMessaggi.PreparaRigaMessaggio;
var Valore,UMisura:string;
    CompP,CompC,CompT,
    FruitoP,FruitoC,FruitoT,
    ResiduoP,ResiduoC,ResiduoT,
    GResiduoP,GResiduoC,GResiduoT:Real;
    function Trasforma(Dato:Real):String;
    begin
      if UMisura = 'O' then
        Result:=R180MinutiOre(Trunc(Dato))
      else
        Result:=FloatToStr(Dato);
    end;
    function CheckScheda(S:String):String;
    begin
      Result:=S;
      UMisura:='O';
      if R450DtM.ttrovscheda[R180Mese(DataConsuntivo)] = 0 then
        Result:='ERR';
    end;
    function GetRecuperoMobile(OffSet:Integer):String;
    var RR:TRiepilogoRecuperi;
        i:Integer;
    begin
      Result:='';
      UMisura:='O';
      R450DtM.GetRiepilogoRecuperi(RR);
      for i:=0 to High(RR) do
        if R180AddMesi(R180InizioMese(DataConsuntivo),OffSet) = RR[i].DataAbbatt then
          Result:=R180MinutiOre(RR[i].Recupero);
    end;
    function GetRiepilogoAssenze(Causale,Dato:String):String;
    {Riepilogo assenze cumulando le variabili se sono indicate più causali}
    var G:TGiustificativo;
        i:Integer;
    begin
      Result:='0';
      if Causale = '' then
      begin
        Result:='ERR';
        exit;
      end;
      if (Causale <> CausAssOld) or (DataConsuntivo <> DataConsuntivoOld) then
      begin
        UMisura:='';
        GResiduoP:=0;
        GResiduoC:=0;
        GResiduoT:=0;
        CompP:=0;
        CompC:=0;
        CompT:=0;
        FruitoP:=0;
        FruitoC:=0;
        FruitoT:=0;
        ResiduoP:=0;
        ResiduoC:=0;
        ResiduoT:=0;
        CausAssOld:=Causale;
        DataConsuntivoOld:=dataConsuntivo;
        with TStringList.Create do
        try
          CommaText:=Causale;
          for i:=0 to Count - 1 do
          begin
            if (R600DtM.Progressivo <> selC700.FieldByName('PROGRESSIVO').AsInteger) or (R600DtM.Giustificativo.Causale <> Strings[i]) then
            begin
              G.Causale:=Strings[i];
              G.Inserimento:=False;
              G.Modo:='I';
              R600DtM.GetAssenze(selC700.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(DataConsuntivo),R180FineMese(DataConsuntivo),0,G);
              if UMisura <> R600DtM.UMisura then
              begin
                CompP:=0;
                CompC:=0;
                CompT:=0;
                FruitoP:=0;
                FruitoC:=0;
                FruitoT:=0;
                ResiduoP:=0;
                ResiduoC:=0;
                ResiduoT:=0;
              end;
            end;
            UMisura:=R600DtM.UMisura;
            CompP:=CompP + R600DtM.ValCompPrec;
            CompC:=CompC + R600DtM.ValCompCorr;
            CompT:=CompT + R600DtM.ValCompTot;
            FruitoP:=FruitoP + R600DtM.ValFruitoPrec;
            FruitoC:=FruitoC + R600DtM.ValFruitoCorr;
            FruitoT:=FruitoT + R600DtM.ValFruitoTot;
            ResiduoP:=ResiduoP + R600DtM.ValResiduoPrec;
            ResiduoC:=ResiduoC + R600DtM.ValResiduoCorr;
            ResiduoT:=ResiduoT + R600DtM.ValResiduo;
            GResiduoP:=GResiduoP + R600DtM.ValResiduoPrecGG;
            GResiduoC:=GResiduoC + R600DtM.ValResiduoCorrGG;
            GResiduoT:=GResiduoT + R600DtM.ValResiduoGG;
          end;
        finally
          Free;
        end;
      end;
      if Dato = 'ASS_COMPPREC' then Result:=Trasforma(CompP)
      else if Dato = 'ASS_COMPCORR' then Result:=Trasforma(CompC)
      else if Dato = 'ASS_COMPTOT' then Result:=Trasforma(CompT)
      else if Dato = 'ASS_FRUITOPREC' then Result:=Trasforma(FruitoP)
      else if Dato = 'ASS_FRUITOCORR' then Result:=Trasforma(FruitoC)
      else if Dato = 'ASS_FRUITOTOT' then Result:=Trasforma(FruitoT)
      else if Dato = 'ASS_RESIDUOPREC' then Result:=Trasforma(ResiduoP)
      else if Dato = 'ASS_RESIDUOCORR' then Result:=Trasforma(ResiduoC)
      else if Dato = 'ASS_RESIDUOTOT' then Result:=Trasforma(ResiduoT)
      else if Dato = 'ASS_GG_RESIDUOPREC' then
      begin
        Result:=FloatToStr(GResiduoP);
        UMisura:='G';
      end
      else if Dato = 'ASS_GG_RESIDUOCORR' then
      begin
        Result:=FloatToStr(GResiduoC);
        UMisura:='G';
      end
      else if Dato = 'ASS_GG_RESIDUOTOT' then
      begin
        Result:=FloatToStr(GResiduoT);
        UMisura:='G';
      end
    end;
    function GetRiepilogoPresenze(Causale,Dato:String):String;
    {Riepilogo presenze cumulando le variabili se sono indicate più causali}
    var i,k,x,OreReseMese,Residuo:Integer;
    begin
      Result:='0';
      UMisura:='O';
      OreReseMese:=0;
      Residuo:=0;
      if Causale = '' then
      begin
        Result:='ERR';
        exit;
      end;
      with TStringList.Create do
      try
        CommaText:=Causale;
        for i:=0 to Count - 1 do
        begin
          k:=R450DtM.IndiceRiepPres(Strings[i]);
          if k >= 0 then
            for x:=1 to MaxFasce do
            begin
              OreReseMese:=OreReseMese + R450DtM.RiepPres[k].OreReseMese[x];
              Residuo:=Residuo + R450DtM.RiepPres[k].Residuo[x];
            end;
        end;
      finally
        Free;
      end;
      if Dato = 'PRES_RESO_MESE' then Result:=R180MinutiOre(OreReseMese)
      else if Dato = 'PRES_RESIDUO' then Result:=R180MinutiOre(Residuo);
    end;
    function GetDatiGiornalieri(Dato,DataRif:String):String;
    {Richiamo i conteggi giornalieri per verificare l'anomalia delle timbrature in sequenza}
    var i:Integer;
        S:String;
        DR:TDateTime;
    begin
      Result:='';
      UMisura:='';
      //Cacolo la data di riferimento, riferita alla data del messaggio o alla data del consuntivo
      DR:=0;
      if Pos('DT',DataRif) > 0 then
      begin
        DR:=Trunc(DataMessaggio);
        DataRif:=StringReplace(DataRif,'DT','',[rfIgnoreCase]);
      end
      else if Pos('DC',DataRif) > 0 then
      begin
        DR:=DataConsuntivo;
        DataRif:=StringReplace(DataRif,'DC','',[rfIgnoreCase]);
      end;
      DR:=DR + StrToIntDef(DataRif,0);
      R502ProDtM.PeriodoConteggi(DR,DR);
      R502ProDtM.Conteggi('Cartolina',selC700.FieldByName('PROGRESSIVO').AsInteger,DR);
      if Dato = 'DATI_GG_ANOMALIA1' then
      begin
        UMisura:='T';
        if R502ProDtM.Blocca = 2 then
          for i:=0 to High(R502ProDtM.TimbratureDelGiorno) do
          begin
            if R502ProDtM.TimbratureDelGiorno[i].tversotimb <> #0 then
              //Result:=Result + R502ProDtM.TimbratureDelGiorno[i].tversotimb + R180MinutiOreExt(R502ProDtM.TimbratureDelGiorno[i].toratimb) + ' '
              Result:=Result + R502ProDtM.TimbratureDelGiorno[i].tversotimb + R180MinutiOre(R502ProDtM.TimbratureDelGiorno[i].toratimb) + ' '
            else
              Break;
          end
      end
      else if Dato = 'DATI_GG_DEBITO' then
        Result:=IntToStr(R502ProDtM.debitorp)
      else if Dato = 'DATI_GG_HHPRESENZA' then
        Result:=IntToStr(R502ProDtM.OreReseTotali - R502ProDtM.minassenze)
      else if Dato = 'DATI_GG_HHASSENZA' then
        Result:=IntToStr(R502ProDtM.minassenze)
      else if Dato = 'DATI_GG_SCOSTNEG' then
        Result:=IntToStr(R502ProDtM.scostneg)
      else if Dato = 'DATI_GG_SCOST' then
        Result:=IntToStr(R502ProDtM.scost)
      else if Dato = 'DATI_GG_ORARIO' then
      begin
        UMisura:='T';
        Result:=R502ProDtM.c_orario;
      end
      else if Dato = 'DATI_GG_RIEPASS' then
      begin
        UMisura:='T';
        for i:=1 to R502ProDtM.n_riepasse do
        begin
          S:=R502ProDtM.ValStrT265[R502ProDtM.triepgiusasse[i].tcausasse,'INFLUCONT'];
          if (S = 'B') or (S = 'D') then
            Result:=Result + '<' + R502ProDtM.triepgiusasse[i].tcausasse + '=' + R180MinutiOre(R502ProDtM.triepgiusasse[i].tminvalasse) + '>'
          else
            Result:=Result + '<' + R502ProDtM.triepgiusasse[i].tcausasse + '=' + R180MinutiOre(R502ProDtM.triepgiusasse[i].tminresasse) + '>';
        end;
      end
      else if Dato = 'DATI_GG_RIEPPRES' then
      begin
        UMisura:='T';
        for i:=1 to R502ProDtM.n_rieppres do
          if R502ProDtM.triepgiuspres[i].tcauspres <> '' then
            Result:=Result + '<' + R502ProDtM.triepgiuspres[i].tcauspres + '=' + R180MinutiOre(R502ProDtM.RiepPresTotale[i]) + '>';
      end;
    end;
begin
// PREPARAZIONE RECORD MESSAGGIO
  Riga:='';
  Stringa:='';
  NomiColonne:='';
  with SelT292 do
  begin
  // impostazione valore del dato (Valore)
    First;
    while not Eof do
    begin
      UMisura:='';
      if (FieldByName('TIPO').AsString = 'FI') or
         (FieldByName('TIPO').AsString = 'DC') or
         (FieldByName('TIPO').AsString = 'DT') or
         (FieldByName('TIPO').AsString = 'DS') then
        Valore:=FieldByName('VALORE_DEFAULT').AsString;
      if FieldByName('TIPO').AsString = 'NR' then
        Valore:=StringReplace(R180DimLungR(FieldByName('VALORE_DEFAULT').AsString,FieldByName('LUNGHEZZA').AsInteger),' ','0',[rfReplaceAll]);
      if FieldByName('TIPO').AsString = 'BA' then
        Valore:=Format('%.*d',[FieldByName('LUNGHEZZA').AsInteger,SelC700.FieldByName('T430BADGE').AsInteger]);
      if FieldByName('TIPO').AsString = 'AN' then
        Valore:=Format('%-*s',[FieldByName('LUNGHEZZA').AsInteger,SelC700.FieldByName(FieldByName('VALORE_DEFAULT').AsString).AsString]);
      if FieldByName('TIPO').AsString = 'IN' then
        Valore:=selT361.FieldByName('INDIRIZZO_TERMINALE').AsString;
      if FieldByName('TIPO').AsString = 'PT' then
        Valore:=selT361.FieldByName('POSTAZIONE').AsString;
      if FieldByName('TIPO').AsString = 'DE' then
        Valore:=FieldByName('VALORE_DEFAULT').AsString;
      //Variabili
      if FieldByName('TIPO').AsString = 'VL' then
      begin
        TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('I','Elaborazione dato ' + FieldByName('VALORE_DEFAULT').AsString,SessioneIWR110.Parametri.Azienda,selC700.FieldByName('PROGRESSIVO').AsInteger);
        //Saldi orari
        if FieldByName('VALORE_DEFAULT').AsString = 'SALDOMMCOR' then
          Valore:=CheckScheda(R180MinutiOre(R450DtM.salmeseatt))
        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOAACORR' then     //Lorena 16/10/2006
          Valore:=CheckScheda(R180MinutiOre(R450DtM.salcompannoatt + R450DtM.salliqannoatt))
        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOAAPREC' then     //Lorena 16/10/2006
          Valore:=CheckScheda(R180MinutiOre(R450DtM.salcompannoprec + R450DtM.salliqannoprec))
//        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOAACOR' then    Lorena 16/10/2006
        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOTOT' then
          Valore:=CheckScheda(R180MinutiOre(R450DtM.salannoatt))
//        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOAANEG' then    Lorena 16/10/2006
        else if FieldByName('VALORE_DEFAULT').AsString = 'SALDOTOTNEG' then
          Valore:=CheckScheda(R180MinutiOre(Min(R450DtM.salannoatt,0)))
        else if FieldByName('VALORE_DEFAULT').AsString = 'RECUPERO_MOBILE' then
          Valore:=GetRecuperoMobile(StrToIntDef(FieldByName('CODICE_DATO').AsString,0))
        else if FieldByName('VALORE_DEFAULT').AsString = 'DEBITO_CREDITO' then
          Valore:=CheckScheda(R180MinutiOre(R450DtM.salcompannoprec + R450DtM.salcompannoatt - R450DtM.BancaOreResidua - R450DtM.BancaOreResiduaPrec))
        else if FieldByName('VALORE_DEFAULT').AsString = 'BANCAORE_RESIDUA' then
          Valore:=CheckScheda(R180MinutiOre(R450DtM.BancaOreResidua + R450DtM.BancaOreResiduaPrec))
        //Riepiloghi presenze
        else if (Copy(FieldByName('VALORE_DEFAULT').AsString,1,5) = 'PRES_') then
          Valore:=GetRiepilogoPresenze(Trim(FieldByName('CODICE_DATO').AsString),FieldByName('VALORE_DEFAULT').AsString)
        //Riepiloghi assenze
        else if (Copy(FieldByName('VALORE_DEFAULT').AsString,1,4) = 'ASS_') then
          Valore:=GetRiepilogoAssenze(Trim(FieldByName('CODICE_DATO').AsString),FieldByName('VALORE_DEFAULT').AsString)
        //DatiGiornalieri
        else if (Copy(FieldByName('VALORE_DEFAULT').AsString,1,8) = 'DATI_GG_') then
        begin
          Valore:=GetDatiGiornalieri(FieldByName('VALORE_DEFAULT').AsString,Trim(FieldByName('CODICE_DATO').AsString));
          MessaggioValido:=not((Valore = '') and (FieldByName('VALORE_DEFAULT').AsString = 'DATI_GG_ANOMALIA1'));
        end;
      end;
      if (FieldByName('TIPO').AsString = 'AN') or
         (FieldByName('TIPO').AsString = 'DE') or
         (FieldByName('TIPO').AsString = 'VL') or
         (FieldByName('TIPO').AsString = 'DC') or
         (FieldByName('TIPO').AsString = 'DT') or
         (FieldByName('TIPO').AsString = 'DS') then
        Reg_Testo:=Reg_Testo + Valore + ' ';
      Formatta(FieldByName('TIPO').AsString,UMisura,Valore);
      // composizione riga messaggio con Valore
      Valore:=Copy(Valore,1,FieldByName('LUNGHEZZA').AsInteger);
      if TipoFile = 'A' then
        Riga:=Riga + Format('%-*s',[FieldByName('LUNGHEZZA').AsInteger,Valore])
      else
      begin
        if NomiColonne <> '' then
          NomiColonne:=NomiColonne + ',';
        NomiColonne:=NomiColonne + FieldByName('NOME_COLONNA').AsString;
        if Stringa <> '' then
          Stringa:=Stringa + ',';
        Stringa:=Stringa + '''' + AggiungiApice(Format('%s',[Trim(Valore)])) + '''';
        //Stringa:=Stringa + '''' + Format('%-*s',[FieldByName('LUNGHEZZA').AsInteger,Valore]) + '''';
      end;
      //Gestione campi chiave per Update
      if lstCampiChiave.IndexOfName(FieldByName('NOME_COLONNA').AsString) >= 0 then
        lstCampiChiave.Values[FieldByName('NOME_COLONNA').AsString]:='''' + AggiungiApice(Trim(Valore)) + '''';
      Next;
    end;
  end;
end;

procedure TR110FCreazioneFileMessaggi.Formatta(Tipo,UMisura:String; var Valore:string);
{Formattazione valore: segno, precisione decimali, allineamento}
var Campo,Segno,SegnoP,SegnoN:string;
    ndec,x:Integer;
begin
  if (Tipo <> 'VL') and (Tipo <> 'DE') then exit;
  with TStringList.Create do
  try
    CommaText:=selT292.FieldByName('FORMATO').AsString;
    if (Tipo = 'VL') and (Valore <> 'ERR') and (UMisura <> 'T') then
    begin
      //Gestione precisione decimali
      if UMisura <> 'O' then
      begin
        ndec:=StrToIntDef(Values['D'],-1);
        if ndec >= 0 then
          begin
            if Valore = '' then
              Valore:='0';
            Valore:=Format('%.*f',[ndec,StrToFloat(Valore)]);
          end;
      end;
      //Gestione minuti Si/No
      if (UMisura = 'O') and (Values['M'] = 'N') then
        Valore:=Copy(Valore,1,Pos('.',Valore) - 1);
      //Gestione del segno positivo/negativo
      if Copy(Valore,1,1) = '-' then
        Campo:=Copy(Valore,2,(Length(Valore) - 1))
      else
        Campo:=Valore;
      //Caratteri del segno positivo/negativo
      SegnoN:=Values['S'];
      SegnoP:=Copy(SegnoN,2,1);
      if SegnoN = '' then
        SegnoN:='-';
      if SegnoP = '#' then
        SegnoP:=' ';
      if Copy(Valore,1,1) = '-' then
        Segno:=SegnoN
      else
        Segno:=SegnoP;
      //Posizione del segno rispetto al valore (davanti/dopo)
      if IndexOf('XS') >= 0 then
        Valore:=Campo + Segno
      else
        Valore:=Segno + Campo;
    end;
    //Allineamento centrato
    if Values['A'] = 'C' then
    begin
      x:=max(0,(selT292.FieldByName('LUNGHEZZA').AsInteger - Length(Valore)) div 2);
      Valore:=Format('%-*s',[x,'']) + Valore;
    end
    //Allineamento a destra
    else if Values['A'] = 'D' then
    begin
      x:=max(0,(selT292.FieldByName('LUNGHEZZA').AsInteger - Length(Valore)));
      Valore:=Format('%-*s',[x,'']) + Valore;
    end;
  finally
    Free;
  end;
end;

procedure TR110FCreazioneFileMessaggi.RegistraMessaggio;
begin
  insT295.SetVariable('PROGRESSIVO',selC700.FieldByName('PROGRESSIVO').AsInteger);
  insT295.SetVariable('DATA_MSG',DataMessaggio);
  insT295.SetVariable('ORA_MSG',Now);
  insT295.SetVariable('OPERATORE',SessioneIWR110.Parametri.Operatore);
  insT295.SetVariable('TESTO_MSG',Reg_Testo);
  insT295.SetVariable('DATA_SCAD_MSG',DataScadenza);
  try
    insT295.Execute;
  except
    on E:Exception do
    begin
      //LogMessaggi.Add('  FALLITA REGISTRAZIONE MESSAGGI IN TABELLA!');
      //LogMessaggi.Add('  ' + E.Message);
      TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  FALLITA REGISTRAZIONE MESSAGGI IN TABELLA!');
      TRegistraMsg(SessioneIWR110.RegistraMsg).InserisciMessaggio('A','  ' + E.Message);
      ErroreSuLog:=True;
    end;
  end;
  Reg_Testo:='';
end;

procedure TR110FCreazioneFileMessaggi.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(ListaOrologi);
  FreeAndNil(ListaOrologiIntestazione);
  FreeAndNil(ListaNumRec);
  FreeAndNil(lstCampiChiave);
  FreeAndNil(R450DtM);
  FreeAndNil(R502ProDtM);
  FreeAndNil(R600DtM);
end;

end.

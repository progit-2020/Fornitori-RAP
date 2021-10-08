unit Ac11UElaborazioneFesteParticolariMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, CheckLst,
  Datasnap.DBClient, Oracle, OracleData, Variants, StrUtils, Math,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, USelI010,
  C180FunzioniGenerali, DatiBloccati, A004UGiustifAssPresMW, R600;

type
  TevIniziaProgressBar = procedure(nMax:Integer;FA:String) of object;
  TevAvanzaProgressBar = procedure of object;

  TAc11FElaborazioneFesteParticolariMW = class(TR005FDataModuleMW)
    selListaFeste: TOracleDataSet;
    selTipiFesta: TOracleDataSet;
    selTipiFestaCODICE: TStringField;
    selTipiFestaDESCRIZIONE: TStringField;
    delaCSI010: TOracleQuery;
    selRegoleFesta: TOracleDataSet;
    selDettIndFesta: TOracleDataSet;
    selaV430: TOracleDataSet;
    insaCSI010: TOracleQuery;
    insbCSI010: TOracleQuery;
    delbCSI010: TOracleQuery;
    selGgLav: TOracleQuery;
    updaCSI010: TOracleQuery;
    selT100: TOracleDataSet;
    selT040: TOracleDataSet;
    D010: TDataSource;
    cdsDipObblTimb: TClientDataSet;
    dsrDipObblTimb: TDataSource;
    selDettIndFestaSP: TOracleDataSet;
    updbCSI010: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT040FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    DataSys:TDateTime;
    selDatiBloccati:TDatiBloccati;
    A004MW: TA004FGiustifAssPresMW;
    bTimbrature,bCauPresenza,bCauAssEscl,bCausInsert,bCauAssIncl:Boolean;
    bCausSostReg,bCausSostInd:Boolean;
    function RegolaApplicabile(ODS:TOracleDataSet): Boolean;
    function GiornoLavorativo:Boolean;
    procedure ApriCartellino;
    procedure VerificaCartellino;
    function EsisteCausSostit(ODS:TOracleDataSet): Boolean;
    procedure SegnaloSceltaMancante;
    procedure SegnaloGiornoNonVuoto;
    function DipObblTimb:Boolean;
    function FormattaAnomalie(Messaggio:String): String;
  public
    { Public declarations }
    Anno:Integer;
    ListaFeste,ListaFesteSel:TStringList;
    DataFesta:TDateTime;
    TipoFesta,DescFesta:String;
    Prog:Integer;
    bGeneraDettA,bGeneraDettM,bCancellaDettA,bApplicaScelte,bControllaScelte,bSvuotaScelte:Boolean;
    sDatoDipObblTimb,sValoreDipObblTimb:String;
    selI010:TselI010;
    evIniziaProgressBar:TevIniziaProgressBar;
    evAvanzaProgressBar:TevAvanzaProgressBar;
    procedure RecuperaFesteAnno;
    procedure RecuperaFestaSel(FestaSel:String);
    procedure ControlliGen;
    function ControlliDip: Boolean;
    procedure Inizializzazioni;
    procedure GeneraDett;
    procedure CancellaDett;
    procedure ApplicaScelte;
    procedure ControllaScelte;
    procedure SvuotaScelte;
    procedure Finalizzazioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAc11FElaborazioneFesteParticolariMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cdsDipObblTimb.CreateDataSet;
  ListaFeste:=TStringList.Create;
  ListaFesteSel:=TStringList.Create;
  selTipiFesta.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');
  D010.DataSet:=selI010;
end;

procedure TAc11FElaborazioneFesteParticolariMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
  ListaFesteSel.Free;
  ListaFeste.Free;
end;

procedure TAc11FElaborazioneFesteParticolariMW.RecuperaFesteAnno;
var i: Integer;
    s2: String;
begin
  if Anno > 0 then
  begin
    for i:=0 to ListaFesteSel.Count - 1 do
      s2:=s2 + IfThen(s2 <> '',',') + Copy(ListaFesteSel[i],1,7);
    s2:=',' + s2 + ',';
    ListaFeste.Clear;
    with selListaFeste do
    begin
      Close;
      SetVariable('ANNO',IntToStr(Anno));
      Open;
      First;
      while not Eof do
      begin
        ListaFeste.Add(Trim(Format('%-1s %-10s %-50s',[FieldByName('TIPO_FESTIVITA').AsString,FieldByName('DATA_FESTIVITA').AsString,VarToStr(selTipiFesta.Lookup('CODICE',FieldByName('TIPO_FESTIVITA').AsString,'DESCRIZIONE'))])));
        Next;
      end;
    end;
    ListaFesteSel.Clear;
    for i:=0 to ListaFeste.Count - 1 do
      if Pos(',' + Copy(ListaFeste[i],1,7) + ',',s2) > 0 then
        ListaFesteSel.Add(ListaFeste[i]);
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.RecuperaFestaSel(FestaSel:String);
begin
  TipoFesta:=Copy(FestaSel,1,1);
  DataFesta:=StrToDate(Copy(FestaSel,3,10));
  DescFesta:=Trim(Copy(FestaSel,14));
end;

procedure TAc11FElaborazioneFesteParticolariMW.ControlliGen;
var n:Integer;
begin
  if SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if ListaFesteSel.Count = 0 then
    raise exception.Create(A000MSG_Ac11_ERR_ELABORAZIONE + A000MSG_ERR_SELEZIONARE_ELEMENTO);
  DataSys:=Trunc(R180SysDate(SessioneOracle));
  if bGeneraDettA or bCancellaDettA then
  begin
    //Cercare con data e tipo selezionati tutti i record con progressivo <> -1 e bloccare se data registrazione valorizzata o scelta definitiva valorizzata
    for n:=0 to ListaFesteSel.Count - 1 do
    begin
      RecuperaFestaSel(ListaFesteSel[n]);
      with selDettIndFesta do
      begin
        Close;
        SetVariable('TIPO_FESTIVITA',TipoFesta);
        SetVariable('DATA_FESTIVITA',DataFesta);
        SetVariable('TIPO_RECORD','M');
        SetVariable('PROGRESSIVO',null);
        SetVariable('CONDIZIONE','and (DATA_SCELTA is not null or SCELTA_DEFINITIVA is not null)');
        Open;
        if RecordCount > 0 then
          raise exception.Create(FormattaAnomalie(A000MSG_Ac11_ERR_ELABORAZIONE + A000MSG_Ac11_ERR_SCELTA_EFFETTUATA));
      end;
    end;
    //Cercare con data e tipo selezionati il record con progressivo = -1 e bloccare se l'inizio del periodo di scelta sulla regola è minore della trunc(sysdate)
    for n:=0 to ListaFesteSel.Count - 1 do
    begin
      RecuperaFestaSel(ListaFesteSel[n]);
      with selRegoleFesta do
      begin
        Close;
        SetVariable('TIPO_FESTIVITA',TipoFesta);
        SetVariable('DATA_FESTIVITA',DataFesta);
        SetVariable('FILTRO_ANAGRA','');
        Open;
        while not Eof do
        begin
          if FieldByName('INIZIO_SCELTA').AsDateTime < DataSys then
            raise exception.Create(FormattaAnomalie(A000MSG_Ac11_ERR_ELABORAZIONE + A000MSG_Ac11_ERR_PERIODO_INIZIATO));
          Next;
        end;
      end;
    end;
  end
  else if bApplicaScelte or bControllaScelte then
  begin
    if (sDatoDipObblTimb <> '') and (sValoreDipObblTimb = '') then
      raise exception.Create(A000MSG_Ac11_ERR_ELABORAZIONE + A000MSG_Ac11_ERR_NO_VALORE_OBBL_TIMB);
  end;
end;

function TAc11FElaborazioneFesteParticolariMW.ControlliDip:Boolean;
var DIniScelta,DFinScelta:TDateTime;
begin
  Result:=False;
  if bApplicaScelte or bSvuotaScelte then
  begin
    //Salto il dipendente se il cartellino è chiuso
    selDatiBloccati.Close;
    if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(DataFesta),'T040') then
    begin
      if selDettIndFesta.FieldByName('TIPO_RECORD').AsString = 'M' then
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(A000MSG_Ac11_ERR_CARTELLINO_CHIUSO + ' (' + selDatiBloccati.MessaggioLog + ')'),'',Prog);
      Exit;
    end;
    //Il periodo di scelta non è ancora finito
    DIniScelta:=selDettIndFesta.FieldByName('INIZIO_SCELTA').AsDateTime;
    DFinScelta:=selDettIndFesta.FieldByName('FINE_SCELTA').AsDateTime;
    if DFinScelta >= DataSys then
    begin
      if selDettIndFesta.FieldByName('TIPO_RECORD').AsString = 'M' then
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(Format(A000MSG_Ac11_ERR_FMT_PERIODO_NON_FINITO,[DateToStr(DIniScelta),DateToStr(DFinScelta)])),'',Prog);
      Exit;
    end;
  end;
  Result:=True;
end;

procedure TAc11FElaborazioneFesteParticolariMW.Inizializzazioni;
begin
  if bApplicaScelte or bSvuotaScelte then
  begin
    selDatiBloccati:=TDatiBloccati.Create(nil);
    selDatiBloccati.TipoLog:='';
  end;
  if bApplicaScelte then
  begin
    A004MW:=TA004FGiustifAssPresMW.Create(nil);
  //MW per inserimento e cancellazione caus_insert
    // indica di non eseguire la commit in fase di inserimento
    // solo se tutti gli inserimenti vanno a buon fine si committa la transazione,
    // altrimenti si effettua la rollback
    //A004MW.EseguiCommit:=False;
    A004MW.chkNuovoPeriodo:=False;
    A004MW.GestioneSingolaDM:=True;
    A004MW.AnomalieInterattive:=False;
    A004MW.R600DtM1.VisualizzaAnomalie:=False;
    A004MW.R600DtM1.AnomalieBloccanti:=True;
    A004MW.R600DtM1.AnomalieNonBloccanti:='1';

    A004MW.Var_Gestione:=0;
    A004MW.Var_TipoCaus:=1;
    A004MW.Var_TipoGiust_Count:=4;
    A004MW.Var_TipoGiust:=0; //'I'
    A004MW.Var_DaOre:='';
    A004MW.Var_AOre:='';
    A004MW.Var_NumGG:=0;

    A004MW.Giustif.Modo:='I';
    A004MW.Giustif.DaOre:=A004MW.Var_DaOre;
    A004MW.Giustif.AOre:=A004MW.Var_AOre;

    A004MW.Chiamante:='Ac11';
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.GeneraDett;
var FA:String;
begin
  ApriCartellino;
  //Cancello i record dei dipendenti selezionati
  CancellaDett;
  //Genero il dettaglio individuale
  with selRegoleFesta do
  begin
    Close;
    SetVariable('TIPO_FESTIVITA',TipoFesta);
    SetVariable('DATA_FESTIVITA',DataFesta);
    SetVariable('FILTRO_ANAGRA','');
    Open;
    //Ciclare sui vari filtri anagrafe per data e tipo selezionati e record con progressivo = -1
    while not Eof do
    begin
      selaV430.Close;
      selaV430.SetVariable('QVISTAORACLE',QVistaOracle);
      selaV430.SetVariable('DATALAVORO',DataFesta);
      FA:=FieldByName('FILTRO_ANAGRA').AsString;
      FA:=FA + ' and :DataLavoro BETWEEN V430.T430Inizio AND nvl(V430.T430Fine,TO_DATE(''31123999'',''DDMMYYYY''))'; //solo dipendenti in servizio
      selaV430.SetVariable('FILTRO',FA);
      selaV430.Open;
      if Assigned(evIniziaProgressBar) then
        evIniziaProgressBar(selaV430.RecordCount,IntToStr(RecNo) + ': ' + FieldByName('FILTRO_ANAGRA').AsString);
      //Per ogni dipendente estratto dal filtro:
      while not selaV430.Eof do
      begin
        if Assigned(evAvanzaProgressBar) then
          evAvanzaProgressBar;
        //Se il dipendente non è stato selezionato lo salto
        if StrToIntDef(VarToStr(selAnagrafe.Lookup('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO')),0) <> selaV430.FieldByName('PROGRESSIVO').AsInteger then
        begin
          selaV430.Next;
          Continue;
        end;
        selT040.Filtered:=False;
        Prog:=selaV430.FieldByName('PROGRESSIVO').AsInteger;
        selT040.Filtered:=True;
        selDettIndFesta.Close;
        selDettIndFesta.SetVariable('TIPO_FESTIVITA',TipoFesta);
        selDettIndFesta.SetVariable('DATA_FESTIVITA',DataFesta);
        selDettIndFesta.SetVariable('TIPO_RECORD','A');
        selDettIndFesta.SetVariable('PROGRESSIVO',Prog);
        selDettIndFesta.SetVariable('CONDIZIONE','');
        selDettIndFesta.Open;
        if selDettIndFesta.RecordCount > 0 then
          //Se esiste già un record di tipo A con data e tipo selezionati, segnalare anomalia e saltare (perché il dipendente rientra in 2 filtri anagrafe)
          RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(A000MSG_Ac11_ERR_DIP_2_FILTRI_ANAGRAFE),'',Prog)
        else
        begin
          insaCSI010.SetVariable('TIPO_FESTIVITA',TipoFesta);
          insaCSI010.SetVariable('DATA_FESTIVITA',DataFesta);
          insaCSI010.SetVariable('PROGRESSIVO_BASE',-1);
          insaCSI010.SetVariable('FILTRO_ANAGRA',FieldByName('FILTRO_ANAGRA').AsString);
          insaCSI010.SetVariable('PROGRESSIVO_INS',Prog);
          insaCSI010.SetVariable('TIPO_RECORD','A');
          EsisteCausSostit(selRegoleFesta);
          insaCSI010.SetVariable('APP',IfThen(RegolaApplicabile(selRegoleFesta),'S','N'));
          //Regola NON applicabile:
          // presente causale di sostituzione: forzo il relativo comportamento
          // altri motivi: forzo l'esclusione del diritto
          insaCSI010.SetVariable('FLAG_SCELTA','N');//viene usato nel SQL solo se APP = 'N'
          insaCSI010.SetVariable('SCELTE_POSSIBILI','');//viene usato nel SQL solo se APP = 'N'
          insaCSI010.SetVariable('COMP_NOSCELTA',IfThen(bCausSostReg,FieldByName('COMP_CAUSSOST').AsString,'Z'));//viene usato nel SQL solo se APP = 'N'
          insaCSI010.Execute;
          //Se chkGeneraDettM.Checked, creare il record di tipo M copiandolo dal record di tipo A
          if bGeneraDettM then
          begin
            insaCSI010.SetVariable('PROGRESSIVO_BASE',Prog);
            insaCSI010.SetVariable('TIPO_RECORD','M');
            insaCSI010.Execute;
          end;
        end;
        selaV430.Next;
      end;
      Next;
    end;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.CancellaDett;
begin
  if Assigned(evIniziaProgressBar) then
    evIniziaProgressBar(selAnagrafe.RecordCount,'');
  while not selAnagrafe.Eof do
  begin
    if Assigned(evAvanzaProgressBar) then
      evAvanzaProgressBar;
    //Cancellare i record di tipo A con data e tipo selezionati e progressivo <> -1
    delaCSI010.SetVariable('TIPO_FESTIVITA',TipoFesta);
    delaCSI010.SetVariable('DATA_FESTIVITA',DataFesta);
    delaCSI010.SetVariable('TIPO_RECORD','A');
    delaCSI010.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    delaCSI010.Execute;
    //Se chkGeneraDettM.Checked, cancellare i record di tipo M con data e tipo selezionati e progressivo <> -1
    if bGeneraDettM then
    begin
      delaCSI010.SetVariable('TIPO_RECORD','M');
      delaCSI010.Execute;
    end;
    selAnagrafe.Next;
  end;
end;

function TAc11FElaborazioneFesteParticolariMW.RegolaApplicabile(ODS:TOracleDataSet): Boolean;
begin
  Result:=False;
  //La presenza della causale sostitutiva esclude sempre il diritto
  if ((ODS = selDettIndFesta) and bCausSostInd)
  or ((ODS = selRegoleFesta) and bCausSostReg) then
    exit;
  //A = Sabato e domenica/Riposo per turnista (alias Giorno non lavorativo):
  if ODS.FieldByName('CONDIZIONE_APPLIC').AsString = 'A' then
  begin
    if bControllaScelte then //apro il dataset sul dipendente corrente perché non lo posso aprire prima col filtro_anagra della regola
    begin
      selaV430.Close;
      selaV430.SetVariable('QVISTAORACLE',QVistaOracle);
      selaV430.SetVariable('DATALAVORO',DataFesta);
      selaV430.SetVariable('FILTRO','(T030.PROGRESSIVO = ' + IntToStr(Prog) + ')');
      selaV430.Open;
    end;
    //per dipendenti turnisti, qualsiasi giorno di riposo.
    if selaV430.FieldByName('T430TGESTIONE').AsString = '1' then
      Result:=not GiornoLavorativo
    //per dipendenti non turnisti, se domenica o se sabato non lavorativo.
    else if selaV430.FieldByName('T430TGESTIONE').AsString = '0' then
      Result:=(DayOfWeek(DataFesta) = 1) or ((DayOfWeek(DataFesta) = 7) and not GiornoLavorativo);
  end
  //B = Sabato e domenica per tutti: sabato o domenica per tutti.
  else if ODS.FieldByName('CONDIZIONE_APPLIC').AsString = 'B' then
    Result:=(DayOfWeek(DataFesta) = 1) or (DayOfWeek(DataFesta) = 7)
  //C = Solo se giorno lavorativo: se giorno lavorativo per tutti.
  else if ODS.FieldByName('CONDIZIONE_APPLIC').AsString = 'C' then
    Result:=GiornoLavorativo
  //S = Sempre senza restrizioni: sempre applicabile.
  else if ODS.FieldByName('CONDIZIONE_APPLIC').AsString = 'S' then
    Result:=True;
  //Nel caso specifico del Santo Patrono, il dipendente non né ha più diritto se nell’anno l’ha già precedentemente fruito o accumulato alle ferie, in una diversa sede.
  //Se è applicabile il Santo Patrono corrente, annullare quelli eventualmente futuri
  if Result and (TipoFesta = 'A') then
    with selDettIndFestaSP do //dataset specchio di selDettIndFesta ma apposta per cercare altri Santo Patrono
    begin
      Close;
      SetVariable('TIPO_FESTIVITA',TipoFesta);
      SetVariable('DATA_FESTIVITA',null);
      SetVariable('TIPO_RECORD','M');
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('CONDIZIONE','and TO_CHAR(DATA_FESTIVITA,''YYYY'') = ''' + IntToStr(Anno) + ''' and TO_CHAR(DATA_FESTIVITA,''DD/MM/YYYY'') <> ''' + DateToStr(DataFesta) + '''');
      Open;
      while not Eof do
      begin
        //Se ho già scelto un altro Santo Patrono o è iniziato il periodo di scelta di un Santo Patrono applicabile, non applico il nuovo record
        if (    not FieldByName('SCELTA_DEFINITIVA').IsNull
            and (FieldByName('SCELTA_DEFINITIVA').AsString <> 'Z'))
        or (    FieldByName('SCELTA_DEFINITIVA').IsNull
            and (   not FieldByName('DATA_SCELTA').IsNull
                 or (    (FieldByName('INIZIO_SCELTA').AsDateTime <= DataSys)
                     and (FieldByName('COMP_NOSCELTA').AsString <> 'Z')))) then
        begin
          Result:=False;
          Break;
        end;
        Next;
      end;
      if Result then //Se sto per applicare la regola del Santo Patrono...
      begin
        First;
        while not Eof do
        begin
          //se il periodo di altri Santo Patrono applicabili deve ancora iniziare...
          if  (FieldByName('INIZIO_SCELTA').AsDateTime > DataSys)
          and (   (    not FieldByName('SCELTA_DEFINITIVA').IsNull
                   and (FieldByName('SCELTA_DEFINITIVA').AsString <> 'Z'))
               or (    FieldByName('SCELTA_DEFINITIVA').IsNull
                   and (FieldByName('COMP_NOSCELTA').AsString <> 'Z'))) then
          begin
            //se l'altro Santo Patrono avverrà prima del Santo Patrono corrente, quest'ultimo diventa non applicabile
            if FieldByName('DATA_FESTIVITA').AsDateTime < DataFesta then //non bisogna toccare l'ordinamento per DATA_FESTIVITA
            begin
              Result:=False;
              Break;
            end
            else if not bControllaScelte then //modifico i dati solo se non è un semplice controllo
            //se gli altri Santo Patrono avverranno dopo il Santo Patrono corrente, allora diventano non applicabili
            begin
              Edit;
              FieldByName('FLAG_SCELTA').AsString:='N';
              FieldByName('SCELTE_POSSIBILI').AsString:='';
              FieldByName('COMP_NOSCELTA').AsString:='Z';
              Post;
              //Allineo il record automatico
              updbCSI010.SetVariable('DATA_FESTIVITA',FieldByName('DATA_FESTIVITA').AsDateTime);
              updbCSI010.SetVariable('TIPO_FESTIVITA',FieldByName('TIPO_FESTIVITA').AsString);
              updbCSI010.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
              updbCSI010.SetVariable('FLAG_SCELTA',FieldByName('FLAG_SCELTA').AsString);
              updbCSI010.SetVariable('SCELTE_POSSIBILI',FieldByName('SCELTE_POSSIBILI').AsString);
              updbCSI010.SetVariable('COMP_NOSCELTA',FieldByName('COMP_NOSCELTA').AsString);
              updbCSI010.Execute;
            end;
          end;
          Next;
        end;
      end;
    end;
end;

function TAc11FElaborazioneFesteParticolariMW.GiornoLavorativo:Boolean;
begin
  selGgLav.SetVariable('PROGRESSIVO',Prog);
  selGgLav.SetVariable('DATA',DataFesta);
  selGgLav.Execute;
  Result:=VarToStr(selGgLav.GetVariable('GGLAV')) = 'S';
end;

procedure TAc11FElaborazioneFesteParticolariMW.ApriCartellino;
begin
  //Giustificativi
  with selT040 do
  begin
    Close;
    SetVariable('TIPO_FESTIVITA',TipoFesta);
    SetVariable('DATA_FESTIVITA',DataFesta);
    Filtered:=False;
    Open;
  end;
  //Timbrature
  with selT100 do
  begin
    Close;
    SetVariable('TIPO_FESTIVITA',TipoFesta);
    SetVariable('DATA_FESTIVITA',DataFesta);
    Open;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.VerificaCartellino;
begin
  //presenza timbrature
  bTimbrature:=StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO',Prog,'N_TIMB')),0) > 0;
  //causali di presenza
  bCauPresenza:=VarToStr(selT040.Lookup('ESCLUSIONE','','CAUSALE')) <> '';
  //causali di assenza con Esclusione dalle ore rese
  bCauAssEscl:=VarToStr(selT040.Lookup('ESCLUSIONE','S','CAUSALE')) <> '';
  //causale di assenza a giornata intera indicata in caus_insert
  bCausInsert:=VarToStr(selT040.Lookup('CAUSALE;TIPOGIUST',VarArrayOf([selDettIndFesta.FieldByName('CAUS_INSERT').AsString,'I']),'CAUSALE')) <> '';
  //causali di assenza non a giornata intera senza Esclusione dalle ore rese
  bCauAssIncl:=(VarToStr(selT040.Lookup('ESCLUSIONE;TIPOGIUST',VarArrayOf(['N','M']),'CAUSALE')) <> '')  //mezza giornata
            or (VarToStr(selT040.Lookup('ESCLUSIONE;TIPOGIUST',VarArrayOf(['N','N']),'CAUSALE')) <> '')  //numero ore
            or (VarToStr(selT040.Lookup('ESCLUSIONE;TIPOGIUST',VarArrayOf(['N','D']),'CAUSALE')) <> ''); //dalle alle
end;

function TAc11FElaborazioneFesteParticolariMW.EsisteCausSostit(ODS:TOracleDataSet): Boolean;
begin
  Result:=False;
  if selT040.RecordCount > 0 then
  begin
    selT040.First;
    while not selT040.Eof do
    begin
      //causali di assenza a giornata intera che rientrano in caus_sostit
      if (selT040.FieldByName('TIPOGIUST').AsString = 'I')
      and R180InConcat(selT040.FieldByName('CAUSALE').AsString,ODS.FieldByName('CAUS_SOSTIT').AsString) then
      begin
        Result:=True;
        Break;
      end;
      selT040.Next;
    end;
  end;
  if ODS = selRegoleFesta then
    bCausSostReg:=Result
  else if ODS = selDettIndFesta then
    bCausSostInd:=Result;
end;

procedure TAc11FElaborazioneFesteParticolariMW.SegnaloSceltaMancante;
begin
  if selDettIndFesta.FieldByName('TIPO_RECORD').AsString <> 'M' then
    exit;
  RegistraMsg.InserisciMessaggio(IfThen(bControllaScelte,'I','A'),FormattaAnomalie(A000MSG_Ac11_ERR_NO_SCELTA_EFFETTUATA),'',Prog);
end;

procedure TAc11FElaborazioneFesteParticolariMW.SegnaloGiornoNonVuoto;
var msg: String;
begin
  if selDettIndFesta.FieldByName('TIPO_RECORD').AsString <> 'M' then
    exit;
  msg:=A000MSG_Ac11_ERR_SCELTA_FRUIZIONE;
  if bTimbrature then
    msg:=msg + ' ' + A000MSG_Ac11_ERR_TIMBRATURE;
  if bCauPresenza then
    msg:=msg + ' ' + IfThen(bTimbrature,'e ') + A000MSG_Ac11_ERR_PRESENZE;
  if bCauAssEscl then
    msg:=msg + ' ' + IfThen(bTimbrature or bCauPresenza,'e ') + A000MSG_Ac11_ERR_ASSENZE_CON_ESCLUSIONE;
  RegistraMsg.InserisciMessaggio(IfThen(bControllaScelte,'I','A'),FormattaAnomalie(msg),'',Prog);
end;

function TAc11FElaborazioneFesteParticolariMW.DipObblTimb:Boolean;
begin
  Result:=False;
  if sDatoDipObblTimb <> '' then
  begin
    selaV430.Close;
    selaV430.SetVariable('QVISTAORACLE',QVistaOracle);
    selaV430.SetVariable('DATALAVORO',DataFesta);
    selaV430.SetVariable('FILTRO','(T030.PROGRESSIVO = ' + IntToStr(Prog) + ' and ' + sDatoDipObblTimb + ' = ''' + sValoreDipObblTimb + ''')');
    selaV430.Open;
    Result:=selaV430.RecordCount = 1;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.ApplicaScelte;
var i:Integer;
    CSceltaA,DSceltaA:String;
begin
  ApriCartellino;
  //MW per inserimento e cancellazione caus_insert
  A004MW.Var_DaData:=FormatDateTime('dd/mm/yyyy',DataFesta);
  A004MW.Var_AData:=FormatDateTime('dd/mm/yyyy',DataFesta);
  A004MW.DataInizio:=DataFesta;
  A004MW.DataFine:=DataFesta;
  A004MW.DataInizioOrig:=DataFesta;
  if Assigned(evIniziaProgressBar) then
    evIniziaProgressBar(selAnagrafe.RecordCount,'');
  //Scelte dei dipendenti selezionati
  while not selAnagrafe.Eof do
  begin
    if Assigned(evAvanzaProgressBar) then
      evAvanzaProgressBar;
    with selDettIndFesta do
    begin
      Close;
      SetVariable('TIPO_FESTIVITA',TipoFesta);
      SetVariable('DATA_FESTIVITA',DataFesta);
      SetVariable('TIPO_RECORD',null);
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('CONDIZIONE',null);
      Open;
      while not Eof do
      begin
        selT040.Filtered:=False;
        Prog:=FieldByName('PROGRESSIVO').AsInteger;
        selT040.Filtered:=True;
        if ControlliDip then
        begin
          //Il record automatico va sempre ricalcolato (dal calcolo precedente potrebbe essere cambiato qualche dato)
          if FieldByName('TIPO_RECORD').AsString = 'A' then
          begin
            Edit;
            FieldByName('SCELTA_DEFINITIVA').AsString:='';
            Post;
          end;
          EsisteCausSostit(selDettIndFesta);
          VerificaCartellino;
          //Il record manuale va ricalcolato solo se vuoto o svuotato (per non sovrascrivere le forzature manuali)
          if FieldByName('SCELTA_DEFINITIVA').IsNull then
          begin
            Edit;
            //Forzo sempre il comportamento in caso di causale sostitutiva
            if bCausSostInd then
              FieldByName('SCELTA_DEFINITIVA').AsString:=FieldByName('COMP_CAUSSOST').AsString //Non può mai essere 'A'-Fruizione
            //Applico la scelta del dipendente, se effettuata
            else if not FieldByName('SCELTA_EFFETTUATA').IsNull then
              FieldByName('SCELTA_DEFINITIVA').AsString:=FieldByName('SCELTA_EFFETTUATA').AsString
            else if not DipObblTimb //Se non ha scelto un dipendente senza obbligo di timbratura
            and (Pos(',',FieldByName('SCELTE_POSSIBILI').AsString) > 0) //e aveva più di una scelta possibile
            and (Pos('A',FieldByName('SCELTE_POSSIBILI').AsString) > 0) //per il Santo Patrono (le altre festività dovrebbero cadere in giorni non lavorativi che quasi sicuramente rimarranno "vuoti" e senza possibilità di 'A'-Fruizione)
            and not bTimbrature and not bCauPresenza and not bCauAssEscl then //e il giorno è "vuoto"
              SegnaloSceltaMancante//allora segnalo e non applico nessuna scelta
            //Negli altri casi, applico il comportamento predefinito
            else
              FieldByName('SCELTA_DEFINITIVA').AsString:=FieldByName('COMP_NOSCELTA').AsString;
            Post;
          end;
          //Se è stata scelta la Fruizione valuto se inserire la caus_insert (La scelta 'A'-Fruizione dovrebbe capitare solo per il Santo Patrono)
          if FieldByName('SCELTA_DEFINITIVA').AsString = 'A' then
          begin
            //Se giorno non "vuoto"
            if bTimbrature or bCauPresenza or bCauAssEscl then
            begin
              //Dipendente con obbligo di timbratura
              if DipObblTimb then
              begin
                Edit;
                FieldByName('SCELTA_DEFINITIVA').AsString:='C';//Forzo 'C'-Aumenta competenza ferie
                Post;
              end
              //Dipendente senza obbligo di timbratura
              else
              begin
                SegnaloGiornoNonVuoto;
                //Se la scelta definitiva NON è stata forzata manualmente
                if (FieldByName('SCELTA_EFFETTUATA').AsString = 'A')
                or (FieldByName('SCELTA_EFFETTUATA').IsNull and (FieldByName('COMP_NOSCELTA').AsString = 'A')) then
                begin
                  Edit;
                  FieldByName('SCELTA_DEFINITIVA').AsString:='';//Non applico nessuna scelta
                  Post;
                end;
              end;
            end
            //Se (giorno "vuoto" e) record manuale
            else if FieldByName('TIPO_RECORD').AsString = 'M' then
            begin
              // apre dataset per gestione giustificativo
              A004MW.Q040.Close;
              A004MW.Q040.SetVariable('PROGRESSIVO',Prog);
              A004MW.Q040.Open;
              // imposta variabile su middleware
              A004MW.Var_Progressivo:=Prog;
              //Verifico se cancellare delle causali di assenza
              if selT040.RecordCount > 0 then
              begin
                selT040.First;
                while not selT040.Eof do
                begin
                  //causali di assenza non a giornata intera le lascio
                  //causali di assenza (a giornata intera) che rientrano in caus_sostit le lascio
                  //causali di assenza (a giornata intera) di riposo le lascio
                  //causali di assenza (a giornata intera) rimanenti le cancello
                  if (selT040.FieldByName('TIPOGIUST').AsString = 'I')
                  and not R180InConcat(selT040.FieldByName('CAUSALE').AsString,FieldByName('CAUS_SOSTIT').AsString)
                  and (selT040.FieldByName('CODINTERNO').AsString <> 'H') then
                    try
                      A004MW.Var_Causale:=selT040.FieldByName('CAUSALE').AsString;
                      A004MW.Giustif.Causale:=selT040.FieldByName('CAUSALE').AsString;
                      A004MW.Giustif.Inserimento:=False;
                      // effettua cancellazione
                      A004MW.CancellaGiustif(False,False);
                      // segnalazione errore
                      if A004MW.ErroreCancellazione <> '' then
                        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(A004MW.ErroreCancellazione),'',Prog);
                    except
                      on E: Exception do
                        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(E.Message),'',Prog);
                    end;
                  selT040.Next;
                end;
              end;
              //inserisco se non esiste la causale di sostituzione
              if not bCausSostInd then
                try
                  // controllo esistenza causale
                  if not A004MW.R600DtM1.Q265.SearchRecord('CODICE',FieldByName('CAUS_INSERT').AsString,[srFromBeginning]) then
                    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_CAUS_ASS_INESISTENTE),[FieldByName('CAUS_INSERT').AsString]));
                  A004MW.Var_Causale:=FieldByName('CAUS_INSERT').AsString;
                  A004MW.Giustif.Causale:=FieldByName('CAUS_INSERT').AsString;
                  A004MW.Giustif.Inserimento:=True;
                  // effettua inserimento giustificativo
                  A004MW.InserisciGiustif(False);
                  // gestione anomalie
                  if A004MW.R600DtM1.ListAnomalie.Count > 0 then
                    for i:=0 to A004MW.R600DtM1.ListAnomalie.Count - 1 do
                      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(A004MW.R600DtM1.ListAnomalie[i]),'',Prog);
                except
                  on E: Exception do
                    RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(E.Message),'',Prog);
                end;
            end;
          end;
        end;
        Next;
      end;
    end;
    selAnagrafe.Next;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.ControllaScelte;
var CSceltaM,SceltePossibili:String;
begin
  //Prevedere controlli di congruenza tra scelte operate dal dipendente e presenze/assenze effettive
  ApriCartellino;
  if Assigned(evIniziaProgressBar) then
    evIniziaProgressBar(selAnagrafe.RecordCount,'');
  //Scelte dei dipendenti selezionati
  while not selAnagrafe.Eof do
  begin
    if Assigned(evAvanzaProgressBar) then
      evAvanzaProgressBar;
    with selDettIndFesta do
    begin
      Close;
      SetVariable('TIPO_FESTIVITA',TipoFesta);
      SetVariable('DATA_FESTIVITA',DataFesta);
      SetVariable('TIPO_RECORD','M');
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('CONDIZIONE','');
      Open;
      //Scorro i record individuali
      while not Eof do
      begin
        selT040.Filtered:=False;
        Prog:=FieldByName('PROGRESSIVO').AsInteger;
        selT040.Filtered:=True;
        //Recupero la regola in base al filtro_anagra (solo per segnalare eventuali disallineamenti che di norma non dovrebbero capitare)
        selRegoleFesta.Close;
        selRegoleFesta.SetVariable('TIPO_FESTIVITA',TipoFesta);
        selRegoleFesta.SetVariable('DATA_FESTIVITA',DataFesta);
        selRegoleFesta.SetVariable('FILTRO_ANAGRA',FieldByName('FILTRO_ANAGRA').AsString);
        selRegoleFesta.Open;
        if selRegoleFesta.RecordCount = 0 then
          RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(A000MSG_Ac11_ERR_NO_REGOLA),'',Prog);
        //FASE 1 - scelta in conflitto con pianificazione turno; (scelta_definitiva del tipo_record 'M' non rientra in scelte_possibili faccio rieseguire RegolaApplicabile della regola individuale)
        //prelevo la scelta definitiva, o la evinco
        VerificaCartellino;
        EsisteCausSostit(selDettIndFesta);
        CSceltaM:=FieldByName('SCELTA_DEFINITIVA').AsString;
        if CSceltaM = '' then
        begin
          //Forzo sempre il comportamento in caso di causale sostitutiva
          if bCausSostInd then
            CSceltaM:=FieldByName('COMP_CAUSSOST').AsString //Non può mai essere 'A'-Fruizione
          //Applico la scelta del dipendente, se effettuata
          else if not FieldByName('SCELTA_EFFETTUATA').IsNull then
            CSceltaM:=FieldByName('SCELTA_EFFETTUATA').AsString
          else if not DipObblTimb //Se non ha scelto un dipendente senza obbligo di timbratura
          and (Pos(',',FieldByName('SCELTE_POSSIBILI').AsString) > 0) //e aveva più di una scelta possibile
          and (Pos('A',FieldByName('SCELTE_POSSIBILI').AsString) > 0) //per il Santo Patrono (le altre festività dovrebbero cadere in giorni non lavorativi che quasi sicuramente rimarranno "vuoti" e senza possibilità di 'A'-Fruizione)
          and not bTimbrature and not bCauPresenza and not bCauAssEscl then //e il giorno è "vuoto"
            SegnaloSceltaMancante//allora segnalo e non applico nessuna scelta
          //Negli altri casi, applico il comportamento predefinito
          else
            CSceltaM:=FieldByName('COMP_NOSCELTA').AsString;
        end;
        //prelevo le scelte possibili
        if RegolaApplicabile(selDettIndFesta) then
        begin
          SceltePossibili:=FieldByName('SCELTE_POSSIBILI').AsString;
          if FieldByName('SCELTA_EFFETTUATA').IsNull then
            if not FieldByName('COMP_NOSCELTA').IsNull
            and not R180InConcat(FieldByName('COMP_NOSCELTA').AsString,SceltePossibili) then
              SceltePossibili:=SceltePossibili + IfThen(SceltePossibili <> '',',') + FieldByName('COMP_NOSCELTA').AsString;
          //Se è stata scelta la Fruizione
          if CSceltaM = 'A' then
            //Se giorno non "vuoto"
            if bTimbrature or bCauPresenza or bCauAssEscl then
              //Dipendente con obbligo di timbratura
              if DipObblTimb then
                //Forzo 'C'-Aumenta competenza ferie
                SceltePossibili:='C';
        end
        else
          SceltePossibili:=IfThen(bCausSostInd,FieldByName('COMP_CAUSSOST').AsString,'Z');
        //segnalo se la scelta effettuata o predefinita non rientra tra le scelte possibili
        if (CSceltaM <> '') //se CSceltaM è vuoto ho già dato il messaggio di SegnaloSceltaMancante
        and not R180InConcat(CSceltaM,SceltePossibili) then
          RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(Format(A000MSG_Ac11_ERR_FMT_SCELTA_EXTRA_LISTA,[CSceltaM,SceltePossibili])),'',Prog);
        //FASE 2 - presenza di timbrature o di altro giustificativo (causali di presenza o causali di assenza escluse dalla ore di assenza) con scelta di fruire della festività (effettuare i controlli di ApplicaScelte senza applicare nessuna modifica)
        //controllo la scelta effettuata o forzata
        if CSceltaM = 'A' then
        begin
          if bTimbrature or bCauPresenza or bCauAssEscl then
            SegnaloGiornoNonVuoto;
        end
        //FASE 3 - solo per chi ha l'obbligo di timbratura, verificare assenza di timbrature e di giustificativo (causali di presenza e causali di assenza escluse dalla ore di assenza) con scelta di accumulare il Santo Patrono nel monte ferie;
        //controllo la scelta effettuata o forzata
        else if (CSceltaM = 'C')
        and (TipoFesta = 'A') //le altre festività dovrebbero cadere in giorni non lavorativi
        and DipObblTimb
        and not bTimbrature
        and not bCauPresenza
        and not bCauAssEscl then
          RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(A000MSG_Ac11_ERR_SCELTA_COMPETENZE),'',Prog);
        //FASE 4 - segnalare se presenti causali di assenza non a giornata intera con esclusione = 'N' contemporaneamente a causale di assenza a giornata intera indicata nel relativo caus_insert
        if not FieldByName('CAUS_INSERT').IsNull
        and bCausInsert
        and bCauAssIncl then
          RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(Format(A000MSG_Ac11_ERR_FMT_ASS_NO_ESCLUSIONE,[FieldByName('CAUS_INSERT').AsString])),'',Prog);
        Next;
      end;
    end;
    selAnagrafe.Next;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.SvuotaScelte;
begin
  if Assigned(evIniziaProgressBar) then
    evIniziaProgressBar(selAnagrafe.RecordCount,'');
  while not selAnagrafe.Eof do
  begin
    if Assigned(evAvanzaProgressBar) then
      evAvanzaProgressBar;
    with selDettIndFesta do
    begin
      Close;
      SetVariable('TIPO_FESTIVITA',TipoFesta);
      SetVariable('DATA_FESTIVITA',DataFesta);
      SetVariable('TIPO_RECORD','M');
      SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('CONDIZIONE','and SCELTA_DEFINITIVA is not null');
      Open;
      //Scorro i record individuali
      while not Eof do
      begin
        Prog:=FieldByName('PROGRESSIVO').AsInteger;
        if ControlliDip then
        begin
          //Svuotare il campo scelta_definitiva dei record di tipo M con data e tipo selezionati e progressivo <> -1
          Edit;
          FieldByName('SCELTA_DEFINITIVA').AsString:='';
          Post;
        end;
        Next;
      end;
    end;
    selAnagrafe.Next;
  end;
end;

procedure TAc11FElaborazioneFesteParticolariMW.Finalizzazioni;
var n:Integer;
begin
  for n:=0 to ListaFesteSel.Count - 1 do
  begin
    RecuperaFestaSel(ListaFesteSel[n]);
    if bGeneraDettA then
      if not bGeneraDettM then
      begin
        //Se not chkGeneraDettM.Checked, creo i record di tipo M per i dipendenti che hanno solo il record di tipo A con data e tipo selezionati
        insbCSI010.SetVariable('TIPO_FESTIVITA',TipoFesta);
        insbCSI010.SetVariable('DATA_FESTIVITA',DataFesta);
        insbCSI010.Execute;
        //Se not chkGeneraDettM.Checked, cancello i record di tipo M per i dipendenti che hanno solo il record di tipo M con data e tipo selezionati
        delbCSI010.SetVariable('TIPO_FESTIVITA',TipoFesta);
        delbCSI010.SetVariable('DATA_FESTIVITA',DataFesta);
        delbCSI010.Execute;
        //Se not chkGeneraDettM.Checked, aggiorno il filtro_anagra dei record di tipo M con quelli di tipo A per evitare disallineamenti
        updaCSI010.SetVariable('TIPO_FESTIVITA',TipoFesta);
        updaCSI010.SetVariable('DATA_FESTIVITA',DataFesta);
        updaCSI010.Execute;
      end;
  end;
  if bApplicaScelte then
    FreeAndNil(A004MW);
  if bApplicaScelte or bSvuotaScelte then
    selDatiBloccati.Free;
end;

function TAc11FElaborazioneFesteParticolariMW.FormattaAnomalie(Messaggio:String): String;
begin
  Result:=IfThen(bGeneraDettA,  'GENERAZIONE DETTAGLIO INDIVIDUALE',
          IfThen(bCancellaDettA,'CANCELLAZIONE DETTAGLIO INDIVIDUALE',
          IfThen(bApplicaScelte,'APPLICAZIONE SCELTE DEFINITIVE',
          IfThen(bControllaScelte,'CONTROLLO CONGRUENZA SCELTE DEFINITIVE',
          IfThen(bSvuotaScelte,'SVUOTAMENTO SCELTE DEFINITIVE'
          ))))) + '; ' +
          'Data: ' + DateToStr(DataFesta) + '; ' +
          'Tipo: ' + TipoFesta + '; ' +
          'Desc: ' + DescFesta + '; ' +
          Messaggio;
end;

procedure TAc11FElaborazioneFesteParticolariMW.selT040FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=selT040.FieldByName('PROGRESSIVO').AsInteger = Prog;
end;

end.

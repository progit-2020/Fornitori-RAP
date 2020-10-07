unit W001UIrisWebDtM;

interface

uses
  WR000UBaseDM, A000USessione,
  C180FunzioniGenerali, USelI010,
  DBClient, Windows, Messages, SysUtils, StrUtils, Classes,
  Controls, Forms, Db, OracleData, Oracle, Variants, Math,
  IWInit, IWApplication;

type
  TCampo = record
    FieldName: String;
    DisplayLabel: String;
    AsString: String;
    Clickable: Boolean;
    HasDesc: Boolean;
    DescAsString: String;
    NomePagina: String;
    Top: Integer;
    Left: Integer;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  TNumMessaggi = record
    Totali: Integer;
    LetturaObbligatoria: Integer;
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  TW001FIrisWebDtM = class(TWR000FBaseDM)
    seldistT003: TOracleDataSet;
    selT003: TOracleDataSet;
    selDistAnagrafe: TOracleDataSet;
    insT003: TOracleQuery;
    selT350: TOracleDataSet;
    selT275: TOracleDataSet;
    selT265: TOracleDataSet;
    dsrT040: TDataSource;
    selT280: TOracleDataSet;
    selSG110: TOracleDataSet;
    selSG111: TOracleDataSet;
    selSG112: TOracleDataSet;
    selSG110_Luoghi: TOracleDataSet;
    selSG110PROGRESSIVO: TFloatField;
    selSG110DATA_REGISTRAZIONE: TDateTimeField;
    selSG110TIPOESPERIENZA: TStringField;
    selSG110DETTAGLIOESPERIENZA: TStringField;
    selSG110INCLUDI_STAMPA: TStringField;
    selSG110LUOGO_ESPERIENZA: TStringField;
    selSG110INIZIO_ESPERIENZA: TDateTimeField;
    selSG110FINE_ESPERIENZA: TDateTimeField;
    selSG110DESCRIZIONE: TStringField;
    selSG110ORIGINE: TStringField;
    selSG110STATO: TStringField;
    selSG110RI: TStringField;
    selSG110Desc_Tipo: TStringField;
    selSG110Desc_Dettaglio: TStringField;
    selSG113: TOracleDataSet;
    selSQL: TOracleDataSet;
    selSG651: TOracleDataSet;
    selSG650: TOracleDataSet;
    selSG654: TOracleDataSet;
    selSG651PROGRESSIVO: TFloatField;
    selSG651COD_CORSO: TStringField;
    selSG651DATA_CORSO: TDateTimeField;
    selSG651DURATA_CORSO: TStringField;
    selSG651NOTE: TStringField;
    selSG651TIPO_RECORD: TStringField;
    selSG651ORIGINE: TStringField;
    selSG651RI: TStringField;
    selSG651PULSANTE: TStringField;
    selSG651Desc_Corso: TStringField;
    selSG651Desc_TipoPart: TStringField;
    selSG110Desc_Stato: TStringField;
    selSG651STATO: TStringField;
    selSG651Desc_Stato: TStringField;
    delT003: TOracleQuery;
    Q950Lista: TOracleDataSet;
    selSG101: TOracleDataSet;
    selQSQL: TOracleQuery;
    cdsT950Int: TClientDataSet;
    selSG651ORA_INIZIO: TStringField;
    selSG651ORA_FINE: TStringField;
    selSG650Ediz: TOracleDataSet;
    selSG650Giorn: TOracleDataSet;
    selSG659: TOracleDataSet;
    selSG651DECORRENZA: TDateTimeField;
    selSG651EDIZIONE: TStringField;
    selSG651PROFILO_CREDITI: TStringField;
    selSG651DATA_ISCRIZIONE: TDateTimeField;
    selSG651Iscritti: TOracleDataSet;
    selSG651OPERATORE_ISCRIZIONE: TStringField;
    selSG651OPERATORE_AUTORIZZAZIONE: TStringField;
    selSG651DATA_AUTORIZZAZIONE: TDateTimeField;
    selSG651MATRICOLA: TStringField;
    selSG651NOMINATIVO: TStringField;
    selSG650c: TOracleDataSet;
    selSG651DESCGIORNO: TStringField;
    selT910: TOracleDataSet;
    SelCurriculum: TOracleDataSet;
    SelCurriculumPROGRESSIVO: TFloatField;
    SelCurriculumINIZIO: TStringField;
    SelCurriculumFINE: TStringField;
    SelCurriculumDETTAGLIO: TStringField;
    SelCurriculumTIPOESPERIENZA: TStringField;
    SelCurriculumLUOGO: TStringField;
    SelCurriculumNOTE: TStringField;
    SelCurriculumNOMINATIVO: TStringField;
    selT430: TOracleDataSet;
    selSG651ControlloIscritti: TOracleDataSet;
    SelSG655: TOracleDataSet;
    selT375: TOracleDataSet;
    selT305: TOracleDataSet;
    selP442Cumulo: TOracleDataSet;
    selP442NonCumulo: TOracleDataSet;
    selP442: TOracleDataSet;
    selP500: TOracleDataSet;
    selV430: TOracleDataSet;
    selP441_Note: TOracleDataSet;
    selP442A: TOracleDataSet;
    selP441: TOracleDataSet;
    dsrP441: TDataSource;
    delSG651: TOracleQuery;
    selSG651NUMERO_GIORNO: TFloatField;
    selSG651TIPO_PARTECIPAZIONE: TStringField;
    selSG651CREDITI: TFloatField;
    selSG651MAX_PARTECIPANTI: TFloatField;
    selSG651MAX_ISCRITTI: TFloatField;
    selSG651DATA_FINE: TDateTimeField;
    selSg651StatoGiornate: TOracleDataSet;
    delSG651b: TOracleQuery;
    upSG651: TOracleQuery;
    selI060Utenti: TOracleDataSet;
    selI061NomiProfili: TOracleDataSet;
    selI061PermessiUtente: TOracleDataSet;
    selI061DelegheUtente: TOracleDataSet;
    selI061DelegheEsistenti: TOracleDataSet;
    selI060DatiUtente: TOracleDataSet;
    selI090: TOracleDataSet;
    selI061ProfiloAssegnato: TOracleDataSet;
    selI061: TOracleDataSet;
    selDatoLibero: TOracleDataSet;
    selP504: TOracleDataSet;
    selT040: TOracleDataSet;
    selT040IMGSTAMPA: TStringField;
    selT040PROGRESSIVO: TFloatField;
    selT040DATA: TDateTimeField;
    selT040CAUSALE: TStringField;
    selT040DESCRIZIONE: TStringField;
    selT040DATANAS: TDateTimeField;
    selT040PROGRCAUSALE: TFloatField;
    selT040TIPOGIUST: TStringField;
    selT040DAORE: TDateTimeField;
    selT040AORE: TDateTimeField;
    selT040SCHEDA: TStringField;
    selT040STAMPA: TStringField;
    sel2T100: TOracleQuery;
    selSG101Causali: TOracleDataSet;
    selT080: TOracleDataSet;
    selT020: TOracleDataSet;
    selT163: TOracleDataSet;
    selaP504: TOracleDataSet;
    selAnagrafePeriodica: TOracleDataSet;
    updP441: TOracleQuery;
    insT280: TOracleQuery;
    selSG122: TOracleDataSet;
    insSG122: TOracleQuery;
    selSG122PROGRESSIVO: TIntegerField;
    selSG122DATA_AGG: TDateTimeField;
    selSG122TIPO_FAM: TStringField;
    selSG122COGNOME: TStringField;
    selSG122NOME: TStringField;
    selSG122CARICO: TStringField;
    selSG122DATA_CARICO_DA: TDateTimeField;
    selSG122DATA_CARICO_A: TDateTimeField;
    selSG122PERC_CARICO: TFloatField;
    selSG122MANCA_CONIUGE: TStringField;
    selSG122DETR_FIGLIO_HANDICAP: TStringField;
    selSG122DATANAS: TDateTimeField;
    selSG122CODFISCALE: TStringField;
    selSG122DESC_TIPO_FAM: TStringField;
    selSG122NUMORD: TFloatField;
    selSG120: TOracleDataSet;
    selaSG120: TOracleDataSet;
    selT480: TOracleDataSet;
    updSG122: TOracleQuery;
    selCOLS: TOracleDataSet;
    insStorico: TOracleQuery;
    selaSG101: TOracleDataSet;
    updSG101: TOracleQuery;
    insSG101: TOracleQuery;
    selbSG101: TOracleDataSet;
    updP430: TOracleQuery;
    selStorici: TOracleDataSet;
    selP020: TOracleDataSet;
    selSG122ORANAS: TStringField;
    updI061UltimoAccesso: TOracleQuery;
    selT361: TOracleDataSet;
    selT257: TOracleDataSet;
    selAssPres: TOracleDataSet;
    selT280EMail: TOracleDataSet;
    selT040NOTE: TStringField;
    selP441DATA_CEDOLINO: TStringField;
    selP441DATA_RETRIBUZIONE: TStringField;
    selP441TIPO_CEDOLINO: TStringField;
    selP441DATA_EMISSIONE: TDateTimeField;
    selP441DATA_CONSEGNA: TDateTimeField;
    selP441ID_CEDOLINO: TFloatField;
    selT282Count: TOracleQuery;
    selT282CountOper: TOracleQuery;
    selDatiPag: TOracleDataSet;
    selNotificaEventiSciopero: TOracleDataSet;
    selAnagEventoSciopero: TOracleDataSet;
    selT025: TOracleDataSet;
    procedure selSG651BeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selSG110CalcFields(DataSet: TDataSet);
    procedure selSG651CalcFields(DataSet: TDataSet);
    procedure selSG122CalcFields(DataSet: TDataSet);
    procedure selAssPresFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT280AfterOpen(DataSet: TDataSet);
    procedure selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    function CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
    function GetActiveFormCod: String;
    function EsisteFilePDFCedolino: String;
  public
    lstSQL: TStringList;          // utilizzato in W002RicercaAnagrafe: filtro della ricerca anagrafe
    FiltroRicerca,                // filtro anagrafe
    OrdinamentoRicerca,           // filtro anagrafe
    AccessoDirettoValutatore,     // valutazioni
    TipoValutazione: String;      // valutazioni
    SoloStampa: Boolean;          // valutazioni
    RefreshT003: Boolean;         // utilizzato in W002RicercaAnagrafe e W002AnagrafeElenco
    DataSetCorsi: TOracleDataSet; // utilizzato in W014PianifCorsi
    BookmarkIP: TBookMark;        // utilizzato in W002AnagrafeElenco
    CampoArr: array of TCampo;    // utilizzato in W002DatiAnagrafici + W002AnagrafeScheda
    procedure InizializzazioneW001DtM; override;
    function  AccessoValutatore(Azienda,Utente:String):String;
    procedure RegistraMessaggioT280(Progressivo:Integer; Flag,Titolo,Log,Testo:String);
    procedure GetDatiAnagrafici(var Row:Integer;SchedaCompleta:Boolean);
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    //function  GetNumMsgDaLeggere: Integer;
    function  GetNumMsgDaLeggere: TNumMessaggi;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  end;

implementation

uses A000UInterfaccia, R010UPaginaWeb;

{$R *.DFM}

procedure TW001FIrisWebDtM.DataModuleCreate(Sender: TObject);
begin
 try
  inherited;
  if (Owner as TIWApplication).Data <> nil then
  begin
    SetLength(BookmarkIP,0);
    SetLength(CampoArr,0);
    if lstSQL = nil then
      lstSQL:=TStringList.Create;
  end;

  FiltroRicerca:='';
  OrdinamentoRicerca:='';
  AccessoDirettoValutatore:='N';
  //TipoValutazione:='';
  Responsabile:=False;
  RefreshT003:=False;
  DataSetCorsi:=nil;
 except
 end;
end;

procedure TW001FIrisWebDtM.DataModuleDestroy(Sender: TObject);
begin
 try
  if lstSQL <> nil then
    try FreeAndNil(lstSQL); except end;
  if BookmarkIP <> nil then
  begin
    try
      {$IFNDEF VER185}if (Length(BookmarkIP) > 0) then{$ENDIF}
        if cdsAnagrafe.BookmarkValid(BookmarkIP) then
          cdsAnagrafe.FreeBookmark(BookmarkIP);
    except
    end;
  end;
  if CampoArr <> nil then
    SetLength(CampoArr,0);

  inherited;
 except
 end;
end;

function TW001FIrisWebDtM.GetActiveFormCod: String;
begin
  Result:='';
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.ActiveForm <> nil) then
  begin
    try
      Result:=(GGetWebApplicationThreadVar.ActiveForm as TR010FPaginaWeb).medpCodiceForm;
    except
    end;
  end;
end;

procedure TW001FIrisWebDtM.InizializzazioneW001DtM;
begin
  //TORINO_REGIONE: invio mail per eliminazione automatica dei giustificativi in presenza di timbrature
  //T280 contiene righe con FLAG = '3', popolate da un trigger sulla T100
  if Parametri.CampiRiferimento.C90_EMailSMTPHost <> '' then
  begin
    with selT280EMail do
    begin
      Open;
      if RecordCount > 0 then
      begin
        //Prima passata per valorizzare LOG in modo che altri non leggano le stesse richieste
        while not Eof do
        begin
          Edit;
          FieldByName('LOG').AsString:='(inviata email)';
          Post;
          Next;
        end;
        SessioneOracle.Commit;
        //Seconda passata per invio email
        First;
        while not Eof do
        begin
          //Alberto 22/12/2011: invio solo al richiedente
          try
            InviaEMail(False,FieldByName('PROGRESSIVO').AsInteger,FieldByName('TITOLO').AsString,FieldByName('TESTO').AsString,
                      -1,'','','',
                      FieldByName('EMAIL').AsString,FieldByName('EMAIL_CC').AsString,FieldByName('EMAIL_CCN').AsString);
          except
          end;
          Next;
        end;
      end;
      CloseAll;
    end;
  end;

  //selSG110 (W012)
  selSG110.SetVariable('QVISTAORACLE',QVistaOracle);
  //selSG113 (W013)
  selSG113.SetVariable('QVISTAORACLE',QVistaOracle);
  //selSG651 (W014)
  selSG651.SetVariable('QVISTAORACLE',QVistaOracle);

  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
  // prepara il dataset selAnagEvento, utilizzato per estrarre le anagrafiche
  // della selezione indicata in un determinato evento di sciopero
  selAnagEventoSciopero.SQL.Text:=QVistaOracle;
  selAnagEventoSciopero.SQL.Insert(0,Format('SELECT %s T030.PROGRESSIVO FROM',[Parametri.CampiRiferimento.C26_HintT030V430]));
  selAnagEventoSciopero.SQL.Add(':FILTRO_IN_SERVIZIO');
  selAnagEventoSciopero.SQL.Add(':FILTRO');
  selAnagEventoSciopero.DeleteVariables;
  selAnagEventoSciopero.DeclareVariable('DATALAVORO',otDate);
  selAnagEventoSciopero.DeclareVariable('FILTRO',otSubst);
  selAnagEventoSciopero.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);
  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine

  inherited;

  //Alberto 19/09/2018: per accesso da dipendente forzo la data corrente come data di lavoro senza considerare eventuale data salvata su T432
  if TipoUtente <> '**Supervisore**' then
    Parametri.DataLavoro:=Date;
end;

function TW001FIrisWebDtM.AccessoValutatore(Azienda,Utente:String):String;
var i:Integer;
begin
  Result:='N';
  //Se l'utente è di I070 non effettuo l'accesso diretto, a causa dell'eventuale pesantezza del filtro anagrafe
  if TipoUtente = 'Supervisore' then
    exit;
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
    //Se trovo una funzione web abilitata...
    if (UpperCase(Copy(Parametri.AbilitazioniFunzioni[i].Funzione,1,5)) = UpperCase('OpenW'))
    and (UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) <> UpperCase('OpenW007GestioneSicurezza'))
    and (   (Parametri.AbilitazioniFunzioni[i].Inibizione = 'S')
         or (Parametri.AbilitazioniFunzioni[i].Inibizione = 'R')) then
      //...deve essere per l'autovalutazione...
      if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW022SchedaAutovalutazioni') then
        Result:=IfThen(Result <> 'V','A',Result)
      //...deve essere per le schede quant.ind...
      else if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW031SchedeQuantIndividuali') then
        Result:=IfThen(Result <> 'V',IfThen(Result <> 'A','Q',Result),Result)
      //...o per la valutazione...
      else if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase('OpenW022SchedaValutazioni') then
        Result:='V'
      //...altrimenti esco
      else
      begin
        Result:='N';
        Break;
      end;
end;

procedure TW001FIrisWebDtM.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet = selT020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT163 then
    Accept:=A000FiltroDizionario('PROFILI INDENNITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT265 then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT275 then
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT350 then
    Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT361 then
    Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q950Lista then
    Accept:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT910 then
    Accept:=A000FiltroDizionario('GENERATORE DI STAMPE',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = seldistT003 then
    Accept:=A000FiltroDizionario('SELEZIONI ANAGRAFICHE',DataSet.FieldByName('NOME').AsString)
  else if DataSet = selT025 then
    Accept:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',DataSet.FieldByName('PAR_CARTELLINO').AsString);
end;

procedure TW001FIrisWebDtM.selAssPresFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'A' then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TW001FIrisWebDtM.selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=EsisteFilePDFCedolino = 'S';
end;

function TW001FIrisWebDtM.EsisteFilePDFCedolino: String;
var NomeFileOrig,PathPDF:String;
    IdCedolino:Integer;
    DataRetribuzione,DataCedolino:TDateTime;
begin
  inherited;
  Result:='N';
  if Parametri.WEBCedoliniFilePDF = 'S' then
    try
      DataRetribuzione:=R180FineMese(StrToDate('01/' + selP441.FieldByName('DATA_RETRIBUZIONE').AsString));
      selP500.Close;
      selP500.SetVariable('Anno', strtoint(FormatDateTime('yyyy',DataRetribuzione)));
      selP500.Open;
      if selP500.RecordCount > 0 then
        PathPDF:=selP500.FieldByName('PATH_FILEPDF_CED').AsString
      else
        PathPDF:='';
      DataCedolino:=R180FineMese(StrToDate('01/' + selP441.FieldByName('DATA_CEDOLINO').AsString));
      IdCedolino:=selP441.FieldByName('ID_CEDOLINO').AsInteger;
      NomeFileOrig:=PathPDF + '\' + FormatDateTime('yyyymm',DataCedolino) + '\' + IntToStr(IdCedolino) + '.pdf';
      Result:=IfThen(FileExists(NomeFileOrig),'S','N');
    except
    end;
end;

procedure TW001FIrisWebDtM.selSG110CalcFields(DataSet: TDataSet);
begin
  with selSG110 do
  begin
    FieldByName('Desc_Tipo').AsString:=FieldByName('TIPOESPERIENZA').AsString + ' - ' +
      VarToStr(selSG111.Lookup('CODICE',FieldByName('TIPOESPERIENZA').AsString,'DESCRIZIONE'));
    FieldByName('Desc_Dettaglio').AsString:=FieldByName('DETTAGLIOESPERIENZA').AsString + ' - ' +
      VarToStr(selSG112.Lookup('TIPOESPERIENZA;CODICE',VarArrayOf([FieldByName('TIPOESPERIENZA').AsString,FieldByName('DETTAGLIOESPERIENZA').AsString]),'DESCRIZIONE'));
    if FieldByName('STATO').AsString = 'I' then
      FieldByName('Desc_Stato').AsString:='Valida'
    else if FieldByName('STATO').AsString = 'C' then
      FieldByName('Desc_Stato').AsString:='Non Valida'
    else if FieldByName('STATO').AsString = 'R' then
      FieldByName('Desc_Stato').AsString:='Richiesta';
  end;
end;

procedure TW001FIrisWebDtM.selSG122CalcFields(DataSet: TDataSet);
begin
  with selSG122 do
  begin
    if FieldByName('TIPO_FAM').AsString = 'CG' then
      FieldByName('DESC_TIPO_FAM').AsString:='Coniuge'
    else if Copy(FieldByName('TIPO_FAM').AsString,1,2) = 'FG' then
      FieldByName('DESC_TIPO_FAM').AsString:=Copy(FieldByName('TIPO_FAM').AsString,3) + '° Figlio'
    else if Copy(FieldByName('TIPO_FAM').AsString,1,2) = 'AL' then
      FieldByName('DESC_TIPO_FAM').AsString:=Copy(FieldByName('TIPO_FAM').AsString,3) + '° Altro familiare';
  end;
end;

procedure TW001FIrisWebDtM.selSG651CalcFields(DataSet: TDataSet);
var
  sDep:string;
begin
  with selSG651 do
  begin
    if DataSetCorsi = nil then
    begin
      if not Responsabile then
        DataSetCorsi:=selSG650
      else
        DataSetCorsi:=selSG650c;
      DataSetCorsi.SetVariable('DATAINIZIO',GetVariable('DATAINIZIO'));
      DataSetCorsi.SetVariable('DATAFINE',GetVariable('DATAFINE'));
      DataSetCorsi.Open;
    end
    else if not DataSetCorsi.Active then
    begin
      DataSetCorsi.SetVariable('DATAINIZIO',GetVariable('DATAINIZIO'));
      DataSetCorsi.SetVariable('DATAFINE',GetVariable('DATAFINE'));
      DataSetCorsi.Open;
    end;
    sDep:=VarToStr(DataSetCorsi.Lookup('CODICE',FieldByName('COD_CORSO').AsString,'TITOLO_CORSO'));
    FieldByName('Desc_Corso').AsString:=FieldByName('COD_CORSO').AsString + ' - ' + sDep;
    if FieldByName('STATO').AsString = 'I' then
      FieldByName('Desc_Stato').AsString:='Valida'
    else if FieldByName('STATO').AsString = 'C' then
      FieldByName('Desc_Stato').AsString:='Non Valida'
    else if FieldByName('STATO').AsString = 'R' then
      FieldByName('Desc_Stato').AsString:='Richiesta'
    else if FieldByName('STATO').AsString = 'A' then
      FieldByName('Desc_Stato').AsString:='Autorizzata'
    else if FieldByName('STATO').AsString = 'N' then
      FieldByName('Desc_Stato').AsString:='Non autorizzata';
  end;
end;

procedure TW001FIrisWebDtM.selT280AfterOpen(DataSet: TDataSet);
begin
  TDateTimeField(selT280.FieldByName('DATA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW001FIrisWebDtM.selSG651BeforePost(DataSet: TDataSet);
begin
  //Controllo se il dipendente ha già partecipato alla stessa giornata di corso in passato...
  selSG651ControlloIscritti.Close;
  selSG651ControlloIscritti.SetVariable('CODICEIN',DataSet.FieldByName('COD_CORSO').AsString);
  selSG651ControlloIscritti.SetVariable('NUMERO_GIORNO',DataSet.FieldByName('NUMERO_GIORNO').AsInteger);
  selSG651ControlloIscritti.Open;
  if selSG651ControlloIscritti.RecordCount > 0 then
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: hai già partecipato a questa giornata di corso in passato!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),GetActiveFormCod,Dataset,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),GetActiveFormCod,Dataset,True);
  end;
end;

procedure TW001FIrisWebDtM.RegistraMessaggioT280(Progressivo:Integer; Flag,Titolo,Log,Testo:String);
begin
  with insT280 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Now);
    SetVariable('MITTENTE',Parametri.Operatore);
    SetVariable('FLAG',Flag);
    SetVariable('TITOLO',Titolo);
    SetVariable('LOG',Log);
    SetVariable('TESTO',Testo);
    Execute;
  end;
end;

function TW001FIrisWebDtM.CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
var
  v: Variant;
  NomeCampo,Accesso: string;
  Posizione: Integer;
begin
  // campo progressivo -> escluso
  Result:=(Campo = 'PROGRESSIVO') or
          (Campo = 'T430PROGRESSIVO');
  if Result then
    Exit;

  // campo descrittivo (di decodifica) -> escluso
  Result:=(Copy(Campo,1,6) = 'T430D_') and
          (Campo <> 'T430D_PROVINCIA'); // dicitura fissa per "provincia di residenza"
  if Result then
    Exit;

  // estrae dati da tabella I010
  v:=cdsI010.Lookup('NOME_CAMPO',Campo,'NOME_CAMPO;ACCESSO;POSIZIONE');

  // campo non trovato -> escluso
  Result:=VarIsNull(v);
  if Result then
    Exit;

  // salva dati in variabili di appoggio
  NomeCampo:=VarToStr(v[0]);
  Accesso:=VarToStr(v[1]);
  Posizione:=StrToIntDef(VarToStr(v[2]),-1);

  // accesso 'N' oppure non indicato -> escluso
  Result:=(Accesso = 'N') or (Accesso = '');
  if Result then
    Exit;

  // scheda non completa e posizione < 0 -> escluso
  Result:=(not SchedaCompleta) and
          (Posizione < 0);
end;

procedure TW001FIrisWebDtM.GetDatiAnagrafici(var Row:Integer; SchedaCompleta:Boolean);
var
  //i:Integer;
  F:TField;
  NomeCampo,OldIndexName: String;
begin
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
  // la scheda anagrafica visualizza i campi ordinati in base all'indice "Layout" di cdsI010
  OldIndexName:=cdsI010.IndexName;
  cdsI010.IndexName:='Layout';
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini

  SetLength(CampoArr,0);
  Row:=0;
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
  // nuova gestione per ordinamento campi: utilizza cdsI010
  {
  for i:=0 to cdsAnagrafe.FieldCount - 1 do
  begin
    if CampoDaEscludere(cdsAnagrafe.Fields[i].FieldName, SchedaCompleta) then
      Continue;

    // inserisce i dati nell'array
    SetLength(CampoArr,Row + 1);
    CampoArr[Row].FieldName:=cdsAnagrafe.Fields[i].FieldName;
    CampoArr[Row].DisplayLabel:=cdsAnagrafe.Fields[i].DisplayLabel;
    CampoArr[Row].AsString:=cdsAnagrafe.Fields[i].AsString;
    CampoArr[Row].Clickable:=False;
    CampoArr[Row].HasDesc:=False;
    if Copy(CampoArr[Row].FieldName,1,4) = 'T430' then
    begin
      CampoArr[Row].Clickable:=True;
      F:=cdsAnagrafe.FindField(StringReplace(CampoArr[Row].FieldName,'T430','T430D_',[]));
      if F <> nil then
      begin
        CampoArr[Row].HasDesc:=True;
        CampoArr[Row].DescAsString:=F.AsString;
      end;
    end;
    inc(Row);
  end;
  }
  with cdsI010 do
  begin
    First;
    while not Eof do
    begin
      NomeCampo:=FieldByName('NOME_CAMPO').AsString;
      if not CampoDaEscludere(NomeCampo,SchedaCompleta) then
      begin
        // inserisce i dati nell'array
        SetLength(CampoArr,Row + 1);
        CampoArr[Row].FieldName:=NomeCampo;
        CampoArr[Row].DisplayLabel:=FieldByName('CAPTION_LAYOUT').AsString;
        CampoArr[Row].NomePagina:=Format('(%s) %s',[FieldByName('NOMEPAGINA_ORD').AsString,FieldByName('NOMEPAGINA').AsString]);
        CampoArr[Row].Top:=FieldByName('TOP').AsInteger;
        CampoArr[Row].Left:=FieldByName('LFT').AsInteger;
        F:=cdsAnagrafe.FindField(NomeCampo);
        if F = nil then
          CampoArr[Row].AsString:=''
        else
          CampoArr[Row].AsString:=F.AsString;
        CampoArr[Row].Clickable:=False;
        CampoArr[Row].HasDesc:=False;
        if Copy(NomeCampo,1,4) = 'T430' then
        begin
          CampoArr[Row].Clickable:=True;
          F:=cdsAnagrafe.FindField(StringReplace(NomeCampo,'T430','T430D_',[]));
          if F <> nil then
          begin
            CampoArr[Row].HasDesc:=True;
            CampoArr[Row].DescAsString:=F.AsString;
          end;
        end;

        inc(Row);
      end;
      Next;
    end;
  end;

  // ripristina l'indice originale su cdsI010
  cdsI010.IndexName:='Layout';
  // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
//function TW001FIrisWebDtM.GetNumMsgDaLeggere: Integer;
function TW001FIrisWebDtM.GetNumMsgDaLeggere: TNumMessaggi;
// MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
// gestione del modulo messaggistica
// estrae il numero di messaggi da leggere per l'operatore o l'utente web collegato
//   Result.Totali: tot. messaggi con data_lettura null
// MONDOEDP - commessa MAN/07 SVILUPPO#57 - riesame del 28.04.2014.ini
// i messaggi con lettura obbligatoria vengono contati non in base alla
// data_lettura nulla, ma in base alla data ricezione!
//   Result.LetturaObbligatoria: tot. messaggi con data_ricezione null se lettura obbligatoria
// MONDOEDP - commessa MAN/07 SVILUPPO#57 - riesame del 28.04.2014.fine
var
  selCount: TOracleQuery;
begin
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  //Result:=0;
  Result.Totali:=0;
  Result.LetturaObbligatoria:=0;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  try
    // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    if TipoUtente = 'Supervisore' then
    begin
      selT282CountOper.SetVariable('UTENTE',Parametri.Operatore);
      selCount:=selT282CountOper;
    end
    else
    begin
      selT282Count.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      selCount:=selT282Count;
    end;
    // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

    // query conteggio messaggi da leggere
    selCount.Execute;
    if not selCount.Eof then
    begin
      // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
      //Result:=selCount.FieldAsInteger(0);
      Result.Totali:=selCount.FieldAsInteger(0);
      Result.LetturaObbligatoria:=selCount.FieldAsInteger(1);
      // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
    end;
  except
  end;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

end.


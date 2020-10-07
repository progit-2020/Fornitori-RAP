unit Ac05UImportRimborsiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Forms,
  Math, Data.DB, OracleData, StrUtils, Oracle, OracleMonitor, System.Generics.Collections, IOUtils, Vcl.Controls,
  Datasnap.DBClient, Winapi.ActiveX,
  RegistrazioneLog, R004UGestStoricoDTM, C017UEMailDtM, C180FunzioniGenerali, A000UInterfaccia, A000UCostanti, A000UMessaggi;

const
  LUNG_COD_ANOM   = 5;
  AC05            = 'Ac05';
  AC05_CODPAGAM   = 'CODICE_PAGAMENTO';
  AC05_CHIAVE     = 'CHIAVE';
  AC05_DECORRENZA = 'DECORRENZA';
  AC05_SCADENZA   = 'SCADENZA';
  AC05_CODRIMB    = 'COD_RIMBORSO';
  AC05_IMPORTO    = 'IMPORTO';

type
  TCampo = record
    CampoExcel, CampoDB, Intestazione, FmtData, TipoDato:String;
    IdxExcel:Integer;
  end;

  TArrCampi = array of TCampo;

  TProcISB = procedure(Testo:String) of object;
  TProcIPB = procedure(Max:Integer) of object;
  TProc = procedure of object;

  TAc05FImportRimborsiDM = class(TR004FGestStoricoDtM)
    selInputDati: TOracleDataSet;
    OQTabella: TOracleQuery;
    selIA110: TOracleDataSet;
    selIA100: TOracleDataSet;
    selT030: TOracleDataSet;
    dsrIA100: TDataSource;
    cdsIA100: TClientDataSet;
    dsrCdsIA100: TDataSource;
    cdsIA100NOME_STRUTTURA: TStringField;
    cdsIA100NOME_FILE: TStringField;
    selM040: TOracleDataSet;
    selCSI003: TOracleDataSet;
    selInputGruppi: TOracleDataSet;
    selM050: TOracleDataSet;
    selM051: TOracleDataSet;
    selP030: TOracleDataSet;
    selM049: TOracleDataSet;
    dsrM049: TDataSource;
    cdsIA100CODICE_PAGAMENTO: TStringField;
    cdsIA100TIPO_SOMMA_PAGAMENTO: TStringField;
    selM051b: TOracleDataSet;
    selM140: TOracleDataSet;
    selM150: TOracleDataSet;
    selM150b: TOracleDataSet;
    cdsNotifiche: TClientDataSet;
    INVIOEMAIL_VARIAZ_RIMB_RESP: TOracleQuery;
    selT280EMail: TOracleDataSet;
    selI091: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure dsrCdsIA100DataChange(Sender: TObject; Field: TField);
    procedure selInputDatiAfterOpen(DataSet: TDataSet);
    procedure selInputDatiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    RichiamoEsterno:Boolean;
    NomeStruttura,Valuta:String;
    Campo:TArrCampi;
    function ControlliMissione(RegistraNotifiche:Boolean = False):String;
    function GetIdxCampo(ID:String):Integer;
    function GetNomeCampoDB(ID:String):String;
    function EsisteRimborso:Boolean;
    procedure EMailNotifiche;
    procedure InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
                         const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
                         const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
  public
    Func_Name:String;
    NomeFile:String;
    Filtro,RispostaGen,nRimbCaricabili,nRimbCaricati,nRimbCollegati:Integer;
    SoloDipendenti,CollegaRimborsi,SoloControllo:Boolean;
    lstMatricole:TStringList;
    evtImpostaStatusBar:TProcISB;
    evtImpostaProgressBar:TProcIPB;
    evtIncrementaProgressBar:TProc;
    IA100DataChange:TProc;
    RegistraMsgAc05:TRegistraMsg;
    procedure GetStrutture(AziendaRif:String = '');
    procedure ApriStruttura;
    procedure ControlloParametri;
    procedure ImportazioneDati(ResetDati: String = 'S');
    procedure RegistraRimborsi;
  end;

implementation

uses
  ComObj;

{$R *.dfm}

procedure TAc05FImportRimborsiDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  //Serve per gestione B014
  RichiamoEsterno:=False;
  if Self.Owner is TOracleSession then
  begin
    RichiamoEsterno:=True;
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=(Self.Owner as TOracleSession);
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=(Self.Owner as TOracleSession);
    end;
  end
  else
    inherited;
  nRimbCollegati:=0;
  Filtro:=2;
  InizializzaDataSet(selInputDati,[]);
  if not RichiamoEsterno then
  begin
    RegistraMsgAc05:=RegistraMsg;
    GetStrutture;
  end;
  selM049.Open;
  selM049.Fields[0].DisplayWidth:=7;
  selCSI003.Open;
  if RichiamoEsterno then
    selP030.SetVariable('DATA',R180Sysdate(selInputDati.Session))
  else
    selP030.SetVariable('DATA',Parametri.DataLavoro);
  selP030.Open;
  if selP030.RecNo = 1 then
    Valuta:=selP030.FieldByName('COD_VALUTA').AsString;
end;

procedure TAc05FImportRimborsiDM.GetStrutture(AziendaRif:String = '');
begin
  if AziendaRif = '' then //Se non richiamata da B014
    AziendaRif:=Parametri.Azienda;
  selIA100.SetVariable('AZIENDA',AziendaRif);
  selIA100.Open;
  selIA100.Fields[0].DisplayWidth:=30; //permette alla combo delle strutture di visualizzare sia il nome della struttura che il nome del file
  cdsIA100.CreateDataSet; //crea il clientdataset in cui salvare le info sul record selezionato dalla combo
end;

procedure TAc05FImportRimborsiDM.dsrCdsIA100DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //salvataggio informazioni struttura ogni volta che viene cambiato il valore della combo
  NomeStruttura:=cdsIA100.FieldByName('NOME_STRUTTURA').AsString;
  if NomeStruttura <> '' then //al primo datachange i valori sono ancora vuoti
  begin
    try
      ApriStruttura;
    except
      CollegaRimborsi:=False;
    end;
    if Assigned(IA100DataChange) then
      IA100DataChange;  //procedure of object per speciali elaborazioni dalla unit della form
  end;
end;

procedure TAc05FImportRimborsiDM.ApriStruttura;
begin
  Func_Name:='Ac05DM.ApriStruttura';
  selInputDati.Close;
  selInputDati.SetVariable('TABELLA',NomeStruttura);
  selInputDati.SetVariable('MEDP_IDMISSIONE',Null);
  selInputDati.SetVariable('MEDP_CODRIMBORSO',Null);
  selInputDati.Filtered:=False; //viene disattivato il filtro perchè in caso di apertura di una tabella incompatibile non viene fuori nessun errore
  selInputDati.Open;
  //attivazione del pulsante per collegare i rimborsi alle missioni solo se sono presenti record non elaborati
  OQTabella.Clear;
  OQTabella.DeclareAndSet('TABELLA',otSubst,NomeStruttura);
  OQTabella.SQL.Add('select count(*) from :TABELLA where MEDP_COLLEGATO = ''N''');
  try
    OQTabella.Execute;
    CollegaRimborsi:=OQTabella.FieldAsInteger(0) > 0;
  except
  end;
end;

procedure TAc05FImportRimborsiDM.selInputDatiAfterOpen(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  //tutti i campi, generati automaticamente, vengono impostati ad una larghezza base per poter essere visualizzati più facilmente
  for i:=0 to selInputDati.FieldCount - 1 do
    selInputDati.Fields[i].DisplayWidth:=Min(20,selInputDati.Fields[i].DisplayWidth);
end;

procedure TAc05FImportRimborsiDM.selInputDatiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  case Filtro of
    0: Accept:=selInputDati.FieldByName('MEDP_COLLEGATO').AsString = 'N';
    1: Accept:=selInputDati.FieldByName('MEDP_COLLEGATO').AsString = 'S';
    2: Accept:=True;
  end;
  if (lstMatricole <> nil) and SoloDipendenti then
    Accept:=Accept and (lstMatricole.IndexOf(selInputDati.FieldByName('MEDP_MATRICOLA').AsString) >= 0);
end;

procedure TAc05FImportRimborsiDM.ControlloParametri;
var Righe,Colonne,Riga,Colonna,Foglio,i:Integer;
    Excel,XLSheet:Variant;
    NomeCampo:String;

  procedure ApriExcel;
  begin
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CoInitializeEx']));
    try
      //CoInitialize(nil);
      CoInitializeEx(nil,COINIT_DISABLE_OLE1DDE(*COINIT_APARTMENTTHREADED*)(*COINIT_MULTITHREADED*));
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CoInitializeEx: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CreateOleObject']));
    try
      Excel:=CreateOleObject('Excel.Application');
      Excel.Visible:=False;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CreateOleObject: ' + E.Message]));
    end;
    //apertura excel al path designato, foglio 1
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.WorkBooks.Open']));
    try
      Excel.WorkBooks.Open(NomeFile);
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.WorkBooks.Open: ' + E.Message]));
    end;
  end;

  procedure ChiudiExcel;
  begin
    //pulizia oggetti excel
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.Workbooks.Close']));
    try
      Excel.Workbooks.Close;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Workbooks.Close: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.Quit']));
    try
      Excel.Quit;
      Excel:=Unassigned;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Quit: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CoUninitialize']));
    try
      CoUninitialize;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CoUninitialize: ' + E.Message]));
    end;
  end;

begin
  Func_Name:='Ac05DM.ControlloParametri';

  cdsNotifiche.Close;
  cdsNotifiche.CreateDataSet;
  cdsNotifiche.Open;
  cdsNotifiche.EmptyDataSet;

  if (Filtro > 0) then
  begin
    if not TFile.Exists(NomeFile) then
      raise Exception.Create(A000MSG_Ac05_ERR_FILE_NON_ESISTE);
  end;
  try
    if (Filtro > 0) then
    try
      //inizializzazione oggetti excel
      Foglio:=1;
      ApriExcel;
      XLSheet:=Excel.Worksheets[Foglio];
      //calcolo del numero di righe e colonne totali
      Colonne:=XLSheet.UsedRange.Columns.Count;
      Righe:=XLSheet.UsedRange.Rows.Count;
    finally
      //ChiudiExcel;
    end;
    //Estrazione dei campi della tabella
    selIA110.Close;
    selIA110.SetVariable('STRUTTURA',NomeStruttura);
    selIA110.SetVariable('AZIENDA',VarToStr(selIA100.GetVariable('AZIENDA')));
    selIA110.Open;
    SetLength(Campo,0);
    Riga:=1;
    while not selIA110.Eof do
    begin
      if selIA110.FieldByName('CAMPO').AsString.Trim <> '' then
      begin
        SetLength(Campo,Length(Campo) + 1);
        Campo[High(Campo)].CampoExcel:=selIA110.FieldByName('NOME_DATO').AsString.Trim;
        Campo[High(Campo)].CampoDB:=selIA110.FieldByName('CAMPO').AsString.Trim;
        Campo[High(Campo)].Intestazione:=selIA110.FieldByName('INTESTAZIONE').AsString.Trim;
        Campo[High(Campo)].FmtData:=selIA110.FieldByName('FMT_DATA').AsString.Trim;
        Campo[High(Campo)].TipoDato:=selIA110.FieldByName('TIPO_DATO').AsString.Trim;
        Campo[High(Campo)].IdxExcel:=-1;

        try
          //ApriExcel;
          for Colonna:=1 to Colonne do
          try
            //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.Cells[1, ' + Colonna.ToString + '].Value']));
            if VarToStr(Excel.Cells[Riga, Colonna].Value).Trim = Campo[High(Campo)].CampoExcel then
            begin
              Campo[High(Campo)].IdxExcel:=Colonna;
              Break;
            end;
          except
            on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Cells[1, ' + Colonna.ToString + '].Value: ' + E.Message]));
          end;
        finally
          //ChiudiExcel;
        end;

      end
      else if RichiamoEsterno
      and (selIA110.FieldByName('INTESTAZIONE').AsString.Trim = AC05_CODPAGAM)
      and (selIA110.FieldByName('NOME_DATO').AsString.Trim <> '') then
      begin
        //Richiamo da B014: recupero il Tipo pagamento da una riga fittizia
        dsrCdsIA100.OnDataChange:=nil;
        cdsIA100.Edit;
        cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString:=selIA110.FieldByName('NOME_DATO').AsString.Trim;
        cdsIA100.Post;
        dsrCdsIA100.OnDataChange:=dsrCdsIA100DataChange;
      end;
      selIA110.Next;
    end;
  finally
    if (Filtro > 0) then
    begin
      //(*
      ChiudiExcel;
      //*)
    end;
  end;
  if (Trim(cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString) = '')
  or (VarToStr(selM049.Lookup('CODICE',Trim(cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString),'CODICE')) <> Trim(cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString)) then
    raise Exception.Create(A000MSG_Ac05_ERR_TIPO_PAGAMENTO);
  for i:=0 to 3 do
  begin
    case i of
      0:NomeCampo:=AC05_CHIAVE;
      1:NomeCampo:=AC05_DECORRENZA;
      2:NomeCampo:=AC05_CODRIMB;
      3:NomeCampo:=AC05_IMPORTO;
    end;
    if (Filtro > 0) then
    begin
      if GetIdxCampo(NomeCampo) = -1 then
        raise exception.Create(Format(A000MSG_Ac05_ERR_FMT_CAMPO,[NomeCampo]));
      if Campo[GetIdxCampo(NomeCampo)].CampoExcel = '' then
        raise exception.Create(Format(A000MSG_Ac05_ERR_FMT_COLONNA,[NomeCampo]));
      if Campo[GetIdxCampo(NomeCampo)].IdxExcel = -1 then
        raise exception.Create(Format(A000MSG_Ac05_ERR_FMT_COLONNA_NON_TROV,[Campo[GetIdxCampo(NomeCampo)].CampoExcel,NomeCampo]));
    end;
  end;
end;

procedure TAc05FImportRimborsiDM.ImportazioneDati(ResetDati: String = 'S');
var Righe,Colonne,Riga,Colonna,i,Foglio:Integer;
    Excel,XLSheet:Variant;
    Data:TDateTime;
    CampoChiave,CodRimborso,CodRimborsoAgenzia,MsgErr,MsgErrCtrl:String;
    Importo:Real;
    RecordValorizzato:Boolean;

  procedure ApriExcel;
  begin
    //creazione dell'oggetto di interfaccia con excel
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CoInitializeEx']));
    try
      //CoInitialize(nil);
      CoInitializeEx(nil,COINIT_DISABLE_OLE1DDE(*COINIT_APARTMENTTHREADED*)(*COINIT_MULTITHREADED*));
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CoInitializeEx: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CreateOleObject']));
    try
      Excel:=CreateOleObject('Excel.Application');
      //inizializzazione variabili
      Excel.Visible:=False;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CreateOleObject: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.WorkBooks.Open']));
    try
      //apertura excel al path designato
      Excel.WorkBooks.Open(NomeFile);
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.WorkBooks.Open: ' + E.Message]));
    end;
  end;

  procedure ChiudiExcel;
  begin
    //pulizia oggetti excel
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.WorkBooks.Close']));
    try
      Excel.Workbooks.Close;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Workbooks.Close: ' + E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.Quit']));
    try
      Excel.Quit;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Quit: ' + E.Message]));
    end;
    try
      Excel:=Unassigned;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,E.Message]));
    end;
    //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CoUninitialize']));
    try
      CoUninitialize;
    except
      on E:Exception do RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CoUninitialize: ' + E.Message]));
    end;
  end;

begin
  Func_Name:='Ac05DM.ImportazioneDati';
      if not TFile.Exists(NomeFile) then
      raise Exception.Create(A000MSG_Ac05_ERR_FILE_NON_ESISTE);
  if not RichiamoEsterno then
  begin
    if Assigned(evtImpostaStatusBar) then
      evtImpostaStatusBar(A000MSG_MSG_ELABORAZIONE_IN_CORSO);
  end;
  selCSI003.Refresh;
  try
    Foglio:=1;
    ApriExcel;
    XLSheet:=Excel.Worksheets[Foglio];
    //calcolo del numero di righe e colonne totali
    Colonne:=XLSheet.UsedRange.Columns.Count;
    Righe:=XLSheet.UsedRange.Rows.Count;
  finally
    //ChiudiExcel;
  end;
  try
    //cancellazione della tabella
    selInputDati.Close;
    if ResetDati = 'S' then //Eventualmente specificato su B014
    begin
      OQTabella.Clear;  //svuoto la query perchè la bind variable usata nella funzione controlla è di tipo otString
      OQTabella.DeclareAndSet('TABELLA',otSubst,NomeStruttura);
      OQTabella.SQL.Add('drop table :TABELLA');
      try
        OQTabella.Execute;
      except
      end;
    end;
    try
      selInputDati.Open;//Verifico se esiste la tabella
      selInputDati.Close;//Se esiste, la richiudo così com'è, altrimenti la creo
    except
      //generazione tabella di importazione
      OQTabella.Clear;
      OQTabella.DeclareAndSet('TABELLA',otSubst,NomeStruttura);
      OQTabella.SQL.Add('create table :TABELLA' + CRLF + '(' + CRLF + 'MEDP_ID number,' +
                                                               CRLF + ' MEDP_TIMESTAMP date default sysdate,' +
                                                               CRLF + ' MEDP_ESISTENTE varchar2(1) default ''N'',' +
                                                               CRLF + ' MEDP_COLLEGATO varchar2(1) default ''N'',' +
                                                               CRLF + ' MEDP_MATRICOLA varchar2(8),' +
                                                               CRLF + ' MEDP_PROGRESSIVO number(8),' +
                                                               CRLF + ' MEDP_IDMISSIONE number(8),' +
                                                               CRLF + ' MEDP_CODRIMBORSO varchar2(5),' +
                                                               CRLF + ' MEDP_MESSAGGIO varchar2(500)');
      //impostazione dei campi della tabella contenuti nel vettore
      for i:=0 to High(Campo) do
      begin
        OQTabella.DeclareAndSet(Campo[i].CampoDB,otSubst,Campo[i].CampoDB);
        OQTabella.SQL.Add(', ' + OQTabella.VariableName(i+1) + IfThen(Campo[i].TipoDato = 'D',' date',IfThen(Campo[i].TipoDato = 'N',' number',' varchar2(100)')));
      end;
      OQTabella.SQL.Add(')');
      OQTabella.Execute;
    end;
    //generazione trigger tabella
    OQTabella.Clear;
    OQTabella.DeclareAndSet('TABELLA',otSubst,NomeStruttura);
    OQTabella.SQL.Add(CRLF + 'create or replace trigger CSI_' + NomeStruttura + '_BEFOREINS' + CRLF + 'before insert on :TABELLA for each row' + CRLF + 'declare' + CRLF + 'begin' + CRLF + 'select CSI_IMP_EXCEL_ID.nextval into :NEW.MEDP_ID from dual;' + CRLF + 'end;');
    OQTabella.Execute;
    //disabilitazione interfaccia
    selInputDati.DisableControls;
    selInputDati.ReadOnly:=False;
    if not RichiamoEsterno then
    begin
      if Assigned(evtImpostaProgressBar) then
        evtImpostaProgressBar(Righe - 1);
    end;
    //importazione dei dati
    selInputDati.Open;
    for i:=0 to selInputDati.FieldCount - 1 do
      selInputDati.Fields[i].DisplayWidth:=20;
    for Riga:=2 to Righe do
    begin
      if not RichiamoEsterno then
      begin
        if Assigned(evtIncrementaProgressBar) then
          evtIncrementaProgressBar;
        Application.ProcessMessages;
      end;

      selInputDati.Append;
      MsgErr:='';

      try
        //ApriExcel;

        //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CampoChiave']));
        try
          //recupero la missione in base al campo CHIAVE che ne contiene il protocollo
          Colonna:=Campo[GetIdxCampo(AC05_CHIAVE)].IdxExcel;
          CampoChiave:=VarToStr(Excel.Cells[Riga,Colonna].Value).Trim;
          //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s %s',[Func_Name,'CampoChiave:',CampoChiave]));
        except
          on E:Exception do
            RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CampoChiave: ' + E.Message]));
        end;
        //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'CodRimborsoAgenzia']));
        try
          //ricerca del codice rimborso corrispettivo al codice contenuto nel file excel
          Colonna:=Campo[GetIdxCampo(AC05_CODRIMB)].IdxExcel;
          CodRimborsoAgenzia:=VarToStr(Excel.Cells[Riga,Colonna].Value).Trim;
          //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s %s',[Func_Name,'CodRimborsoAgenzia:',CodRimborsoAgenzia]));
        except
          on E:Exception do
            RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'CodRimborsoAgenzia: ' + E.Message]));
        end;
        //Cerco la richiesta di questa missione
        selM140.Close;
        selM140.SetVariable('PROTOCOLLO',CampoChiave);
        selM140.SetVariable('ID_RICHIESTA',Null);
        selM140.Open;
        //Cerco la missione
        selM040.Close;
        selM040.SetVariable('PROTOCOLLO',CampoChiave);
        selM040.SetVariable('ID_MISSIONE',Null);
        selM040.Open;
        begin
          selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger:=IfThen(selM140.RecordCount > 0,selM140.FieldByName('ID_RICHIESTA').AsInteger,selM040.FieldByName('ID_MISSIONE').AsInteger);
          selT030.Close;
          selT030.SetVariable('PROGRESSIVO',IfThen(selM140.RecordCount > 0,selM140.FieldByName('PROGRESSIVO').AsInteger,selM040.FieldByName('PROGRESSIVO').AsInteger));
          selT030.Open;
          if selT030.RecordCount > 0 then
          begin
            selInputDati.FieldByName('MEDP_MATRICOLA').AsString:=selT030.FieldByName('MATRICOLA').AsString;
            selInputDati.FieldByName('MEDP_PROGRESSIVO').AsInteger:=selT030.FieldByName('PROGRESSIVO').AsInteger;
          end;
        end;
        CodRimborso:=VarToStr(selCSI003.Lookup('RIMBORSO_AGENZIA',CodRimborsoAgenzia,'COD_RIMBORSO'));
        if CodRimborso = '' then
          MsgErr:=Trim(MsgErr + ' ' + A000MSG_Ac05_ERR_RIMBORSO_NON_TROV)
        else
          selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString:=CodRimborso;
        //Controlli
        MsgErrCtrl:=ControlliMissione;
        if MsgErrCtrl <> '' then
          MsgErr:=Trim(MsgErr + ' ' + MsgErrCtrl);
        //importazione effettiva da excel a database
        for i:=0 to High(Campo) do
        begin
          if Campo[i].IdxExcel = -1 then
            Continue;
          Colonna:=Campo[i].IdxExcel;
          try
            //RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,'Excel.Cells[' + Riga.ToString + ', ' + Colonna.ToString + '].Value']));
            if Campo[i].TipoDato = 'D' then
            begin
              if VarToStr(Excel.Cells[Riga,Colonna].Value).Trim <> '' then
              begin
                //OK: 09/01/2018 06:00:00
                //KO: 09/01/2018 6.00.00
                try
                  Data:=R180StrToDateFmt(VarToStr(Excel.Cells[Riga,Colonna].Value).Trim,Campo[i].FmtData);
                except
                  //Se stringa di formattazione hh.mm va in errore, provo con h.mm
                  Data:=R180StrToDateFmt(VarToStr(Excel.Cells[Riga,Colonna].Value).Trim,StringReplace(Campo[i].FmtData,'hh','h',[rfIgnoreCase]));
                end;
                selInputDati.FieldByName(Campo[i].CampoDB).AsDateTime:=Data;
              end;
            end
            else if Campo[i].TipoDato = 'N' then
            begin
              if VarToStr(Excel.Cells[Riga,Colonna].Value).Trim <> '' then
              begin
                Importo:=StrToFloat(VarToStr(Excel.Cells[Riga,Colonna].Value).Trim);
                selInputDati.FieldByName(Campo[i].CampoDB).AsFloat:=Importo;
                //Aggiorno l'importo da notificare
                if cdsNotifiche.Locate('ID_MISSIONE',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger,[]) then
                begin
                  cdsNotifiche.Edit;
                  cdsNotifiche.FieldByName('IMPORTO').AsFloat:=cdsNotifiche.FieldByName('IMPORTO').AsFloat + Importo;
                  cdsNotifiche.FieldByName('ELENCO_VOCI').AsString:=cdsNotifiche.FieldByName('ELENCO_VOCI').AsString +
                                                                    CRLF +
                                                                    Format('%s[%s]=%s',[VarToStr(selCSI003.Lookup('COD_RIMBORSO',selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString,'DESCRIZIONE')), selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString, FloatToStr(Importo)]);

                  cdsNotifiche.Post;
                end;
              end;
            end
            else
              selInputDati.FieldByName(Campo[i].CampoDB).AsString:=VarToStr(Excel.Cells[Riga,Colonna].Value).Trim;
          except
            on E:Exception do
            begin
              RegistraMsgAc05.InserisciMessaggio('A',Format('%s: %s',[Func_Name,'Excel.Cells[' + Riga.ToString + ', ' + Colonna.ToString + '].Value: ' + E.Message]));
              MsgErr:=Trim(MsgErr + ' ' + E.Message);
            end;
          end;
        end;

      finally
        //ChiudiExcel;
      end;

      RecordValorizzato:=False;
      for i:=0 to selInputDati.FieldCount - 1 do
        if (Copy(selInputDati.Fields[i].FieldName,1,5) <> 'MEDP_') and (not selInputDati.Fields[i].IsNull) then
        begin
          RecordValorizzato:=True;
          Break;
        end;
      if not RecordValorizzato then
        selInputDati.Cancel
      else
      begin
        selInputDati.FieldByName('MEDP_MESSAGGIO').AsString:=MsgErr;
        selInputDati.FieldByName('MEDP_ESISTENTE').AsString:=IfThen(EsisteRimborso,'S','N');
        //se si è verificato un errore di importazione sul singolo record, esso viene cancellato
        selInputDati.Post;
        selInputDati.RefreshRecord;//Serve a recuperare il MEDP_ID che è impostato da trigger
        selInputDati.Session.Commit;
        if RichiamoEsterno then
          if (selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'S') or not selInputDati.FieldByName('MEDP_MESSAGGIO').IsNull then
            RegistraMsgAc05.InserisciMessaggio('A',Format('    *** %s - %s: %s',[Func_Name,
                                                                             Format('Protocollo: %s - Matricola: %s - Cod.Rimborso: %s (%s)',[CampoChiave,selInputDati.FieldByName('MEDP_MATRICOLA').AsString,CodRimborso,CodRimborsoAgenzia]),
                                                                             //Format('MEDP_ID n. %d',[selInputDati.FieldByName('MEDP_ID').AsInteger]),
                                                                             Trim(IfThen(selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'S','Rimborso già esistente') +
                                                                                  IfThen(not selInputDati.FieldByName('MEDP_MESSAGGIO').IsNull,' ' + selInputDati.FieldByName('MEDP_MESSAGGIO').AsString))]),
                                           VarToStr(selIA100.GetVariable('AZIENDA')),selInputDati.FieldByName('MEDP_PROGRESSIVO').AsInteger);
      end;
    end;
  finally
    try
      //(*
      ChiudiExcel;
      //*)
      selInputDati.Session.Commit;
      selInputDati.ReadOnly:=True;
      selInputDati.Refresh;
      //riabilitazione dell'interfaccia
      selInputDati.EnableControls;
    except
    end;
  end;
  if cdsNotifiche.RecordCount > 0 then
    EmailNotifiche;
end;

procedure TAc05FImportRimborsiDM.RegistraRimborsi;
var ProgRimborsoIns,ProgRimborsoRich,ProgRimborsoMiss,i:Integer;
    Importo:Real;
    MsgErrCtrl,ElencoValori:String;
begin
  Func_Name:='Ac05DM.RegistraRimborsi.' + IfThen(SoloControllo,'Controlla','Inserisci');
  if not RichiamoEsterno then
  begin
    if Assigned(evtImpostaStatusBar) then
      evtImpostaStatusBar(IfThen(SoloControllo,A000MSG_MSG_CONTROLLI_IN_CORSO,A000MSG_MSG_REGISTRAZIONE_IN_CORSO));
  end;
  nRimbCaricabili:=0;
  nRimbCaricati:=0;
  nRimbCollegati:=0;
  selCSI003.Refresh;
  cdsNotifiche.Close;
  cdsNotifiche.CreateDataSet;
  cdsNotifiche.Open;
  cdsNotifiche.EmptyDataSet;
  if not RichiamoEsterno then
  begin
    //inizio log di elaborazione
    RegistraMsgAc05.IniziaMessaggio(AC05);
    RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,A000MSG_Ac05_MSG_INIZIO_COLLEGAMENTO]));
  end;
  try
    //Disabilito scorrimento
    selInputDati.DisableControls;
    selInputDati.ReadOnly:=False;
    //Recupero i binomi missione/tipo rimborso per M050
    selInputGruppi.Close;
    selInputGruppi.SetVariable('TABELLA',NomeStruttura);
    selInputGruppi.Open;
    if not RichiamoEsterno then
    begin
      if Assigned(evtImpostaProgressBar) then
        evtImpostaProgressBar(selInputGruppi.RecordCount);
    end;
    selInputGruppi.First;
    //Scorro i binomi missione/tipo rimborso
    while not selInputGruppi.Eof do
    begin
      //Recupero i rimborsi per missione/tipo rimborso
      selInputDati.Close;
      selInputDati.SetVariable('MEDP_IDMISSIONE',selInputGruppi.FieldByName('MEDP_IDMISSIONE').AsInteger);
      selInputDati.SetVariable('MEDP_CODRIMBORSO',selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString);
      selInputDati.Open;
      if not RichiamoEsterno then
      begin
        if Assigned(evtIncrementaProgressBar) then
          evtIncrementaProgressBar;
        Application.ProcessMessages;
      end;
      //Scorro i rimborsi per missione/tipo rimborso
      selInputDati.First;
      while not selInputDati.Eof do
      begin
        try
          if SoloControllo then
            nRimbCaricabili:=nRimbCaricabili + 1;
          //ricerca richiesta della missione
          selM140.Close;
          selM140.SetVariable('PROTOCOLLO',Null);
          selM140.SetVariable('ID_RICHIESTA',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger);
          selM140.Open;
          //ricerca missione
          selM040.Close;
          selM040.SetVariable('PROTOCOLLO',Null);
          selM040.SetVariable('ID_MISSIONE',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger);
          selM040.Open;
          //ricerca del codice rimborso
          if VarToStr(selCSI003.Lookup('COD_RIMBORSO',selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString,'COD_RIMBORSO')) <> selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString then
            raise Exception.Create(A000MSG_Ac05_ERR_RIMBORSO_NON_TROV);
          //controllo dell'importo
          try
            Importo:=selInputDati.FieldByName(GetNomeCampoDB(AC05_IMPORTO)).AsFloat;
          except
            raise Exception.Create(A000MSG_Ac05_ERR_IMPORTO);
          end;
          //controllo esistenza missione
          MsgErrCtrl:=ControlliMissione(not SoloControllo);
          if MsgErrCtrl <> '' then
            raise Exception.Create(MsgErrCtrl);
          if SoloControllo then
          begin
            if EsisteRimborso then
            begin
              nRimbCaricati:=nRimbCaricati + 1;
              //Registro che il record è già presente
              selInputDati.Edit;
              selInputDati.FieldByName('MEDP_ESISTENTE').AsString:='S';
              selInputDati.Post;
            end
            else if selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'S' then
            begin
              selInputDati.Edit;
              selInputDati.FieldByName('MEDP_ESISTENTE').AsString:='N';
              selInputDati.Post;
            end;
          end
          else
          begin
            ElencoValori:='';
            if (selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'S') and (RispostaGen = mrNo) then
              for i:=0 to selInputDati.FieldCount - 1 do
                ElencoValori:=ElencoValori + selInputDati.Fields[i].FieldName + ': ' + selInputDati.Fields[i].AsString + CRLF;
            if (selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'N')
            or (RispostaGen = mrYes)
            or ((RispostaGen = mrNo) and (R180MessageBox(Format(A000MSG_Ac05_DLG_FMT_REG_RIMB_ESISTENTE,[Trim(ElencoValori)]),'DOMANDA') = mrYes)) then
            begin
              //Aggiorno l'importo da notificare
              if cdsNotifiche.Locate('ID_MISSIONE',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger,[]) then
              begin
                cdsNotifiche.Edit;
                cdsNotifiche.FieldByName('IMPORTO').AsFloat:=cdsNotifiche.FieldByName('IMPORTO').AsFloat + Importo;
                cdsNotifiche.Post;
              end;
              //ATTENZIONE: in B014 RispostaGen vale mrOk: inserisce solo i rimborsi non già esistenti. Esegue il seguente codice grazie alla condizione: selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'N'
              ProgRimborsoIns:=-1;
              ProgRimborsoRich:=-1;
              ProgRimborsoMiss:=-1;
              //Gestione richiesta di missione
              if selM140.RecordCount > 0 then
              begin
                //Su M150 inserire chiave della M140 + per ogni INDENNITA_KM/CODICE incrementare il ID_RIMBORSO.
                selM150.Close;
                selM150.SetVariable('ID_RICHIESTA',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger);
                selM150.SetVariable('INDENNITA_KM','N');
                selM150.SetVariable('CODICE',selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString);
                selM150.Open;
                selM150.Last;
                if selM150.RecordCount > 0 then
                  ProgRimborsoRich:=selM150.FieldByName('ID_RIMBORSO').AsInteger;
              end;
              //Gestione missione
              if selM040.RecordCount > 0 then
              begin
                //Su M050 inserire chiave della M040 + ID_MISSIONE + trascodifica del campo excel TIPOLOGIA_DOC. L'importo corrisponde alla somma degli importi di M051.
                selM050.Close;
                selM050.SetVariable('ID_MISSIONE',selM040.FieldByName('ID_MISSIONE').AsInteger);
                selM050.Open;
                if selM050.SearchRecord('CODICERIMBORSOSPESE',selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString,[srFromBeginning]) then
                begin
                  selM050.Edit;
                  if VarToStr(selM049.Lookup('CODICE',cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString,'SOMMA')) = 'S' then
                    selM050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat:=selM050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat + Importo;
                  selM050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat:=selM050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat + Importo;
                  RegistraLog.SettaProprieta('M','M050_RIMBORSI',AC05,selM050,True);
                  selM050.Post;
                  //Log
                  RegistraLog.RegistraOperazione;
                end
                else
                begin
                  selM050.Append;
                  selM050.FieldByName('ID_MISSIONE').AsInteger:=selM040.FieldByName('ID_MISSIONE').AsInteger;
                  selM050.FieldByName('PROGRESSIVO').AsInteger:=selM040.FieldByName('PROGRESSIVO').AsInteger;
                  selM050.FieldByName('MESESCARICO').AsDateTime:=selM040.FieldByName('MESESCARICO').AsDateTime;
                  selM050.FieldByName('MESECOMPETENZA').AsDateTime:=selM040.FieldByName('MESECOMPETENZA').AsDateTime;
                  selM050.FieldByName('DATADA').AsDateTime:=selM040.FieldByName('DATADA').AsDateTime;
                  selM050.FieldByName('ORADA').AsString:=selM040.FieldByName('ORADA').AsString;
                  selM050.FieldByName('CODICERIMBORSOSPESE').AsString:=selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString;
                  selM050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat:=0;
                  if VarToStr(selM049.Lookup('CODICE',cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString,'SOMMA')) = 'S' then
                    selM050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat:=Importo;
                  selM050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat:=Importo;
                  selM050.FieldByName('COD_VALUTA_EST').AsString:=Valuta;
                  selM050.Post;
                  //Log
                  RegistraLog.SettaProprieta('I','M050_RIMBORSI',AC05,selM050,True);
                  RegistraLog.RegistraOperazione;
                end;
                //Su M051 inserire chiave della M050 + incrementare il PROGRIMBORSO. TIPORIMBORSO si prende una volta sola
                selM051.Close;
                selM051.SetVariable('PROGRESSIVO',selM050.FieldByName('PROGRESSIVO').AsInteger);
                selM051.SetVariable('MESESCARICO',selM050.FieldByName('MESESCARICO').AsDateTime);
                selM051.SetVariable('MESECOMPETENZA',selM050.FieldByName('MESECOMPETENZA').AsDateTime);
                selM051.SetVariable('DATADA',selM050.FieldByName('DATADA').AsDateTime);
                selM051.SetVariable('ORADA',selM050.FieldByName('ORADA').AsString);
                selM051.SetVariable('CODICERIMBORSOSPESE',selM050.FieldByName('CODICERIMBORSOSPESE').AsString);
                selM051.Open;
                selM051.Last;
                if selM051.RecordCount > 0 then
                  ProgRimborsoMiss:=selM051.FieldByName('PROGRIMBORSO').AsInteger;
              end;
              //Recupero il progressivo del rimborso che non vada in chiave duplicata quando ci sarà il ribaltamento richiesta-->missione
              ProgRimborsoIns:=Max(ProgRimborsoRich,ProgRimborsoMiss) + 1;
              //Inserimento dettaglio rimborso su missione
              if selM040.RecordCount > 0 then
              begin
                selM051.Append;
                selM051.FieldByName('PROGRESSIVO').AsInteger:=selM050.FieldByName('PROGRESSIVO').AsInteger;
                selM051.FieldByName('MESESCARICO').AsDateTime:=selM050.FieldByName('MESESCARICO').AsDateTime;
                selM051.FieldByName('MESECOMPETENZA').AsDateTime:=selM050.FieldByName('MESECOMPETENZA').AsDateTime;
                selM051.FieldByName('DATADA').AsDateTime:=selM050.FieldByName('DATADA').AsDateTime;
                selM051.FieldByName('ORADA').AsString:=selM050.FieldByName('ORADA').AsString;
                selM051.FieldByName('CODICERIMBORSOSPESE').AsString:=selM050.FieldByName('CODICERIMBORSOSPESE').AsString;
                selM051.FieldByName('DATARIMBORSO').AsDateTime:=Trunc(selInputDati.FieldByName(GetNomeCampoDB(AC05_DECORRENZA)).AsDateTime);
                selM051.FieldByName('PROGRIMBORSO').AsInteger:=ProgRimborsoIns;
                selM051.FieldByName('IMPORTO').AsFloat:=Importo;
                selM051.FieldByName('TIPORIMBORSO').AsString:=cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString;
                selM051.Post;
                //Log
                RegistraLog.SettaProprieta('I','M051_DETTAGLIORIMBORSO',AC05,selM051,True);
                RegistraLog.RegistraOperazione;
              end;
              //Inserimento dettaglio rimborso su richiesta
              if selM140.RecordCount > 0 then
              begin
                selM150.Append;
                selM150.FieldByName('ID').AsInteger:=selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger;
                selM150.FieldByName('INDENNITA_KM').AsString:='N';
                selM150.FieldByName('CODICE').AsString:=selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString;
                selM150.FieldByName('KMPERCORSI').AsInteger:=0;
                selM150.FieldByName('COD_VALUTA').AsString:=Valuta;
                selM150.FieldByName('RIMBORSO').AsFloat:=Importo;
                selM150.FieldByName('STATO').AsString:='A';//oppure S,I
                selM150.FieldByName('DATA_RIMBORSO').AsDateTime:=Trunc(selInputDati.FieldByName(GetNomeCampoDB(AC05_DECORRENZA)).AsDateTime);
                selM150.FieldByName('AUTOMATICO').AsString:='N';
                selM150.FieldByName('ID_RIMBORSO').AsInteger:=ProgRimborsoIns;
                selM150.Post;
                //Log
                RegistraLog.SettaProprieta('I','M150_RICHIESTE_RIMBORSI',AC05,selM150,True);
                RegistraLog.RegistraOperazione;
              end;
              //Registro che il record è stato collegato
              selInputDati.Edit;
              selInputDati.FieldByName('MEDP_COLLEGATO').AsString:='S';
              selInputDati.Post;
              nRimbCollegati:=nRimbCollegati + 1;
            end;
            if RichiamoEsterno then
              selInputDati.Session.Commit;
          end;
        except
          on E:Exception do
          begin
            selInputDati.Session.Rollback;
            RegistraMsgAc05.InserisciMessaggio('A',
                                           IfThen(RichiamoEsterno,'    *** ') +
                                           Format('%s - %s: %s (%s)',
                                                  [Func_Name,
                                                   Format('Protocollo: %s - Matricola: %s - Cod.Rimborso: %s (%s)',[selInputDati.FieldByName(GetNomeCampoDB(AC05_CHIAVE)).AsString,selInputDati.FieldByName('MEDP_MATRICOLA').AsString,selInputGruppi.FieldByName('MEDP_CODRIMBORSO').AsString,selInputDati.FieldByName(GetNomeCampoDB(AC05_CODRIMB)).AsString]),
                                                   //Format('MEDP_ID n. %d',[selInputDati.FieldByName('MEDP_ID').AsInteger]),
                                                   E.Message,
                                                   E.ClassName]),
                                           VarToStr(selIA100.GetVariable('AZIENDA')),selInputDati.FieldByName('MEDP_PROGRESSIVO').AsInteger);
            if not RichiamoEsterno then
              raise;
          end;
        end;
        selInputDati.Next;
      end;
      selInputGruppi.Next;
    end;
  finally
    if not RichiamoEsterno then
      RegistraMsgAc05.InserisciMessaggio('I',Format('%s: %s',[Func_Name,A000MSG_Ac05_MSG_FINE_COLLEGAMENTO]));
    selInputDati.Session.Commit;
    selInputDati.Close;
    selInputDati.SetVariable('MEDP_IDMISSIONE',Null);
    selInputDati.SetVariable('MEDP_CODRIMBORSO',Null);
    selInputDati.Open;
    selInputDati.First;
    selInputDati.EnableControls;
    selInputDati.ReadOnly:=True;
    if cdsNotifiche.RecordCount > 0 then
      EmailNotifiche;
  end;
end;

function TAc05FImportRimborsiDM.ControlliMissione(RegistraNotifiche:Boolean = False):String;
var MissioneAnnullata:Boolean;
begin
  Result:='';
  MissioneAnnullata:=false;
  if (selM140.RecordCount = 0) and (selM040.RecordCount = 0) then
    Result:=Trim(Result + ' ' + A000MSG_Ac05_ERR_ID_MISSIONE_NON_TROV)
  else if (selM140.RecordCount > 1) or (selM040.RecordCount > 1) then
  begin
    if selM140.RecordCount > 1 then
      Result:=Trim(Result + ' ' + A000MSG_Ac05_ERR_PROTOCOLLO_PIU_RICHIESTE);
    if selM040.RecordCount > 1 then
      Result:=Trim(Result + ' ' + A000MSG_Ac05_ERR_PROTOCOLLO_PIU_MISSIONI);
  end
  else if (selM140.RecordCount > 0) and (selM040.RecordCount > 0)
  and (selM140.FieldByName('ID_RICHIESTA').AsInteger <> selM040.FieldByName('ID_MISSIONE').AsInteger) then
    Result:=Trim(Result + ' ' + A000MSG_Ac05_ERR_ID_RICHIESTA_INCOERENTE)
  else
  begin
    MissioneAnnullata:=(selM140.RecordCount > 0) and (selM140.FieldByName('TIPO_RICHIESTA').AsString = 'A');
    if RegistraNotifiche or MissioneAnnullata then
    begin
      if cdsNotifiche.Locate('ID_MISSIONE',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger,[]) then
        cdsNotifiche.Edit
      else
        cdsNotifiche.Append;
      cdsNotifiche.FieldByName('ID_MISSIONE').AsInteger:=selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger;
      cdsNotifiche.FieldByName('ANNULLATA').AsString:='N';
      if not MissioneAnnullata then
        cdsNotifiche.FieldByName('ELENCO_VOCI').AsString:=cdsNotifiche.FieldByName('ELENCO_VOCI').AsString +
                                                          CRLF +
                                                          Format('%s[%s]=%s',[VarToStr(selCSI003.Lookup('COD_RIMBORSO',selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString,'DESCRIZIONE')), selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString, selInputDati.FieldByName(GetNomeCampoDB(AC05_IMPORTO)).AsString]);
    end;
    if MissioneAnnullata then
    begin
      cdsNotifiche.FieldByName('ANNULLATA').AsString:='S';
      Result:=Trim(Result + ' ' + A000MSG_Ac05_ERR_ID_RICHIESTA_ANNULLATA);
    end;
    if cdsNotifiche.State in [dsEdit,dsInsert] then
      cdsNotifiche.Post;
  end;
end;

function TAc05FImportRimborsiDM.GetIdxCampo(ID:String):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(Campo) do
    if Campo[i].Intestazione = ID then
    begin
      Result:=i;
      Break;
    end;
end;

function TAc05FImportRimborsiDM.GetNomeCampoDB(ID:String):String;
var i:Integer;
begin
  for i:=0 to High(Campo) do
    if Campo[i].Intestazione = ID then
    begin
      Result:=Campo[i].CampoDB;
      Break;
    end;
end;

function TAc05FImportRimborsiDM.EsisteRimborso:Boolean;
begin
  Result:=False;
  try
    //Controllo se la richiesta di rimborso è già presente
    selM150b.Close;
    selM150b.SetVariable('ID_RICHIESTA',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger);
    selM150b.SetVariable('INDENNITA_KM','N');
    selM150b.SetVariable('CODICE',selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString);
    selM150b.SetVariable('KMPERCORSI',0);
    selM150b.SetVariable('RIMBORSO',selInputDati.FieldByName(GetNomeCampoDB(AC05_IMPORTO)).AsFloat);
    selM150b.SetVariable('DATA_RIMBORSO',Trunc(selInputDati.FieldByName(GetNomeCampoDB(AC05_DECORRENZA)).AsDateTime));
    selM150b.Open;
    Result:=selM150b.FieldByName('N_RIMB').AsInteger > 0;
    if Result then exit;
    //Controllo se il rimborso è già presente
    selM051b.Close;
    selM051b.SetVariable('ID_MISSIONE',selInputDati.FieldByName('MEDP_IDMISSIONE').AsInteger);
    selM051b.SetVariable('CODICERIMBORSOSPESE',selInputDati.FieldByName('MEDP_CODRIMBORSO').AsString);
    selM051b.SetVariable('DATARIMBORSO',Trunc(selInputDati.FieldByName(GetNomeCampoDB(AC05_DECORRENZA)).AsDateTime));
    selM051b.SetVariable('IMPORTO',selInputDati.FieldByName(GetNomeCampoDB(AC05_IMPORTO)).AsFloat);
    selM051b.SetVariable('TIPORIMBORSO',cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString);
    selM051b.Open;
    Result:=selM051b.FieldByName('N_RIMB').AsInteger > 0;
  except
  end;
end;

procedure TAc05FImportRimborsiDM.EMailNotifiche;
var MailInviate:Boolean;
begin
  MailInviate:=False;
  cdsNotifiche.First;
  while not cdsNotifiche.Eof do
  try
    if cdsNotifiche.FieldByName('IMPORTO').AsFloat = 0 then
      Continue;
    INVIOEMAIL_VARIAZ_RIMB_RESP.SetVariable('ID_MISSIONE',cdsNotifiche.FieldByName('ID_MISSIONE').AsInteger);
    INVIOEMAIL_VARIAZ_RIMB_RESP.SetVariable('IMPORTO',cdsNotifiche.FieldByName('IMPORTO').AsFloat);
    INVIOEMAIL_VARIAZ_RIMB_RESP.SetVariable('ANNULLATA',cdsNotifiche.FieldByName('ANNULLATA').AsString);
    INVIOEMAIL_VARIAZ_RIMB_RESP.SetVariable('ELENCO_VOCI',cdsNotifiche.FieldByName('ELENCO_VOCI').AsString);
    INVIOEMAIL_VARIAZ_RIMB_RESP.Execute;
    MailInviate:=True;
  finally
    cdsNotifiche.Next;
  end;

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

procedure TAc05FImportRimborsiDM.InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
var
  C017DtM:TC017FEMailDtM;
begin
  selI091.Open;
  Parametri.CampiRiferimento.C90_EMailSMTPHost:=VarToStr(selI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
  Parametri.CampiRiferimento.C90_EMailUserName:=VarToStr(selI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
  Parametri.CampiRiferimento.C90_EMailHeloName:=VarToStr(selI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
  Parametri.CampiRiferimento.C90_EMailPassWord:=R180Decripta(VarToStr(selI091.LookUp('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
  Parametri.CampiRiferimento.C90_EMailPort:=VarToStr(selI091.LookUp('Tipo','C90_EMAIL_PORT','Dato'));
  Parametri.CampiRiferimento.C90_EMailSenderIndirizzo:=VarToStr(selI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
  Parametri.CampiRiferimento.C90_EMailAuthType:=VarToStr(selI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
  Parametri.CampiRiferimento.C90_EMailUseTLS:=VarToStr(selI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));

  C017DtM:=TC017FEMailDtM.Create(nil);
  try
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.DestResponsabile:=PDestResponsabile;
      C017DtM.Progressivo:=PProgressivo;
      C017DtM.Oggetto:=POggetto;
      C017DtM.Testo:=PTesto;
      C017DtM.TagFunzione:=PTag;
      C017DtM.Iter:=PIter;
      C017DtM.CodIter:=PCodIter;
      C017DtM.LivelliDest:=PLivelliDest;
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.InviaEMail;
    except
    end;
  finally
    FreeAndNil(C017DtM);
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    C017DtM:=TC017FEMailDtM.Create(nil);
    try
      try
        C017DtM.SollevaEccezioni:=True;
        C017DtM.Sessione:=SessioneOracle;
        C017DtM.DestResponsabile:=False;
        C017DtM.Oggetto:=POggetto;
        C017DtM.Testo:=PTesto;
        C017DtM.TagFunzione:=PTag;
        C017DtM.CercaDestinatari:=False;
        C017DtM.Destinatari:=PDestinatari;
        C017DtM.DestinatariCC:=PDestinatariCC;
        C017DtM.DestinatariCCN:=PDestinatariCCN;
        //C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
        C017DtM.InviaEMail;
      except
      end;
    finally
      FreeAndNil(C017DtM);
    end;
  end;
end;

end.

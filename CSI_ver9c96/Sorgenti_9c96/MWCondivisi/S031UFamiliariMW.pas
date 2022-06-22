unit S031UFamiliariMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, R005UDataModuleMW, DB, Oracle, A000UInterfaccia, C180FunzioniGenerali,
  A000UCostanti, A000UMessaggi, MedpBackupOldValue;

type
  TS031StoricizzazioneEvents = function :boolean of object;
  TS031ValOriginaliEvents = function :TStringList of object;
  TS031VerificaParentelaEvents = procedure of object;

  TS031FFamiliariMW = class(TR005FDataModuleMW)
    Q480: TOracleDataSet;
    Q480CODICE: TStringField;
    Q480CITTA: TStringField;
    Q480CAP: TStringField;
    Q480PROVINCIA: TStringField;
    Q480CODCATASTALE: TStringField;
    selT030: TOracleDataSet;
    dsrQ480: TDataSource;
    selT265: TOracleDataSet;
    updSG101: TOracleQuery;
    selT040Count: TOracleQuery;
    selNumOrd: TOracleQuery;
    selGradoPar: TOracleQuery;
    selCodFiscDuplicato: TOracleQuery;
    selNomePA: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    RichiamaDataPresuntaChange: Boolean;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    procedure AggiornaProgressivo;
    procedure AllineaDatiUguali;
    function StoricizzazioneInCorso:boolean;
    function RipristinoValoriInCorso:boolean;
  public
    selSG101:TOracleDataSet;
    selSG101OldValues:TmedpBackupOldValue;
    ChiavePrimaria:TStringList;
    cmbParentelaSelItemIndex, cmbTipoParSelItemIndex, cmbTipoAdozSelItemIndex,
    cmbMotivoTerzoGradoSelItemIndex, cmbTipoDisabilitaSelItemIndex, cmbDurataContrattoSelItemIndex,
    cmbAlternativaSelItemIndex, cmbAlternativaMotivoTerzoGradoSelItemIndex,cmbPartFruizMaternitaSelItemIndex :Integer;
    MsgErrore, cmbNomeSelPAText, cmbAlternativaNomeSelPAText : String;
    VerificaParentelaEvents:TS031VerificaParentelaEvents;
    TrovaValoriOriginali:TS031ValOriginaliEvents;
    VerificaStoricizzazioneEvents,VerificaRipristinoValoriEvents:TS031StoricizzazioneEvents;
    procedure QSG101ValidaMatricola;
    procedure QSG101ValidaFields;
    procedure QSG101ValidaFieldsNonBloccanti;
    procedure QSG101NuovoRecord;
    procedure QSG101AfterPost;
    procedure AllineaDatiFissi;
    procedure AllineaParentela;
    procedure EliminaFamiliareSelezionato;
    procedure CaricaSeStesso;
    procedure selSG101DATANASChange(GravidanzaVisible: Boolean);
    procedure selSG101DATANAS_PRESUNTAChange(GravidanzaVisible:Boolean);
    procedure selSG101DATAADOZChange(GravidanzaVisible:Boolean);
    procedure selSG101GRAV_INIZIO_SCELTAChange(GravidanzaVisible: Boolean);
    procedure selSG101GRAV_INIZIO_EFFChange(GravidanzaVisible: Boolean);
    procedure selSG101GRAV_FINE_EFFChange(GravidanzaVisible: Boolean);
    function GetCausaliFG: String;
    function cmbParentelaItemIndex: integer;
    function cmbTipoAdozItemIndex: integer;
    function cmbTipoParentelaItemIndex: integer;
    function cmbMotivoTerzoGradoItemIndex: integer;
    function cmbTipoDisabilitaItemIndex: integer;
    function cmbDurataContrattoItemIndex: integer;
    function cmbAlternativaItemIndex: integer;
    function cmbAlternativaMotivoTerzoGradoItemIndex: integer;
    function cmbNomePAItemIndex: integer;
    function cmbAlternativaNomePAItemIndex: integer;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    function cmbPartFruizMaternitaItemIndex: Integer;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    function AnnoAvvicinamentoFam: Integer;
    function IsDataDichiarazDaAggiornare: Boolean;
    function IsDataDichiarazVuota: Boolean;
  end;

const
  CAMPI_FISSI_SG101: array[0..7] of String = (  //Dati non storicizzabili
    'MATRICOLA',
    'COGNOME',
    'NOME',
    'SESSO',
    'DATANAS',
    'COMNAS',
    'CAPNAS',
    'CODFISCALE'
  );

implementation

{$R *.dfm}

procedure TS031FFamiliariMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  RichiamaDataPresuntaChange:=False;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  Q480.SetVariable('ORDERBY','ORDER BY CITTA');
  Q480.Open;
  selT030.Open;
  selSG101OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TS031FFamiliariMW.CaricaSeStesso;
begin
  selSG101.DisableControls;
  selSG101.Insert;
  selSG101.FieldByName('GRADOPAR').AsString:='NS';
  selSG101.FieldByName('MATRICOLA').AsString:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
  QSG101ValidaMatricola;
  selSG101.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(Trunc(selSG101.FieldByName('DATANAS').AsDateTime));
  selSG101.Post;
  SessioneOracle.Commit;
  selSG101.EnableControls;
end;

procedure TS031FFamiliariMW.EliminaFamiliareSelezionato;
begin
  with selT040Count do
  begin
    SetVariable('PROGRESSIVO',selSG101.FieldByName('PROGRESSIVO').AsInteger);
    // CSI - evolutive.ini
    if not selSG101.FieldByName('DATAADOZ').IsNull then
      SetVariable('DATANAS',selSG101.FieldByName('DATAADOZ').AsDateTime)
    else
    // CSI - evolutive.fine
      SetVariable('DATANAS',selSG101.FieldByName('DATANAS').AsDateTime);
    Execute;
    if GetVariable('COUNT') > 0 then
      //Impossibile eliminare il familiare! Sono presenti %s giustificativi nel periodo compreso tra il %s e il %s.';
      raise Exception.Create(Format(A000MSG_S031_ERR_FMT_CANCFAM_GIUSTIF,[VarToStr(GetVariable('COUNT')),VarToStr(GetVariable('MINDATA')),VarToStr(GetVariable('MAXDATA'))]));
  end;
end;

procedure TS031FFamiliariMW.AggiornaProgressivo;
begin
  updSG101.SetVariable('DATA_ULT_FAM_CAR',selSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime);
  updSG101.SetVariable('PROGRESSIVO',selSG101.FieldByName('PROGRESSIVO').AsInteger);
  updSG101.Execute;
  SessioneOracle.Commit;
end;

procedure TS031FFamiliariMW.QSG101AfterPost;
begin
  //Aggiornamento dati che devono essere uguali su tutti i familiari (Data ultima dichiarazione)
  AggiornaProgressivo;
  //Aggiornamento dati che devono essere uguali su tutti i familiari (Anno avvicinamento familiare)
  if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (not selSG101.FieldByName('TIPO_DISABILITA').IsNull) then
    AllineaDatiUguali;
end;

procedure TS031FFamiliariMW.QSG101NuovoRecord;
begin
  if StoricizzazioneInCorso then
    Exit;
  selSG101.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selNumOrd.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selNumOrd.Execute;
  selSG101.FieldByName('NumOrd').AsInteger:=selNumOrd.FieldAsInteger(0) + 1;
  if not selNumOrd.FieldIsNull(1) then
    selSG101.FieldByName('Data_Ult_Fam_Car').AsDateTime:=selNumOrd.FieldAsDate(1)
  else
    selSG101.FieldByName('Data_Ult_Fam_Car').AsString:='';
end;

procedure TS031FFamiliariMW.QSG101ValidaFields;
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if (selSG101.FieldByName('DECORRENZA').IsNull) and
     (not StoricizzazioneInCorso) and
     (selSG101.State = dsInsert) then
  begin
    if not selSG101.FieldByName('DATANAS').IsNull then
      selSG101.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(Trunc(selSG101.FieldByName('DATANAS').AsDateTime))
    else if not selSG101.FieldByName('DATANAS_PRESUNTA').IsNull then
      selSG101.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(Trunc(selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime))
    else
      selSG101.FieldByName('DECORRENZA').AsDateTime:=StrToDate('01/01/1900');
  end;

  //Evento obbligatorio
  VerificaParentelaEvents;

  //Controlli bloccanti
  if (selSG101.FieldByName('GRADOPAR').AsString = 'NS') then
  begin
    selGradoPar.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selGradoPar.SetVariable('NUM',selSG101.FieldByName('NUMORD').AsInteger);
    selGradoPar.Execute;
    if StrToIntDef(VarToStr(selGradoPar.Field(0)),0) <> 0 then
      raise exception.Create(A000MSG_S031_ERR_GRADO_NESSUNO);  //'Esiste già un familiare con grado di parentela ''Nessuno''!';
  end;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'NS') and (selSG101.FieldByName('MATRICOLA').IsNull) then
  begin
    selSG101.FieldByName('MATRICOLA').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_MATR_NULLA);  //Specificare la matricola di riferimento del dipendente!
  end;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'NS') and (selSG101.FieldByName('MATRICOLA').AsString <> SelAnagrafe.FieldByName('MATRICOLA').AsString) then
  begin
    selSG101.FieldByName('MATRICOLA').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_MATR_NODIP);  //La matricola specificata non è quella del dipendente selezionato!
  end;
  if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (selSG101.FieldByName('MATRICOLA').AsString = SelAnagrafe.FieldByName('MATRICOLA').AsString) then
  begin
    selSG101.FieldByName('MATRICOLA').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_MATR_DIP);  //La matricola specificata non può essere quella del dipendente selezionato!
  end;
  // codice fiscale duplicato
  if not selSG101.FieldByName('CodFiscale').IsNull then
  begin
    selCodFiscDuplicato.SetVariable('PROGRESSIVO',selSG101.FieldByName('Progressivo').AsInteger);
    selCodFiscDuplicato.SetVariable('CODICE_FISCALE',selSG101.FieldByName('CodFiscale').AsString);
    selCodFiscDuplicato.SetVariable('NUMERO_ORDINE',selSG101.FieldByName('NumOrd').AsInteger);
    selCodFiscDuplicato.Execute;
    if selCodFiscDuplicato.Field(0) <> 0 then
      raise exception.Create(Format(A000MSG_S031_ERR_FMT_CF_DOPPIO,[IntToStr(selCodFiscDuplicato.Field(0))]));  //'Codice fiscale già utilizzato per il familiare con numero ordine
  end;
  // verifica tipo di parentela
  if (selSG101.FieldByName('GRADOPAR').AsString = 'NP') and
     (selSG101.FieldByName('NUMGRADO').AsString <> '') and (StrToIntDef(selSG101.FieldByName('NUMGRADO').AsString,0) < 2) then
  begin
    selSG101.FieldByName('NUMGRADO').FocusControl;
    raise exception.Create(Format(A000MSG_S031_ERR_FMT_GRADO,['Nipote','2'])); //'Per la parentela ''Nipote'' occorre specificare un grado superiore o uguale a 2!'
  end;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'NF') and
     (selSG101.FieldByName('NUMGRADO').AsString <> '') and (StrToIntDef(selSG101.FieldByName('NUMGRADO').AsString,0) < 2) then
  begin
    selSG101.FieldByName('NUMGRADO').FocusControl;
    raise exception.Create(Format(A000MSG_S031_ERR_FMT_GRADO,['Nipote equiparato figlio','2']));  //'Per la parentela ''Nipote equiparato figlio'' occorre specificare un grado superiore o uguale a 2!'
  end;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'AL') and (selSG101.FieldByName('NUMGRADO').AsString <> '') and
     (StrToIntDef(selSG101.FieldByName('NUMGRADO').AsString,0) < 1) then
  begin
    selSG101.FieldByName('NUMGRADO').FocusControl;
    raise exception.Create(Format(A000MSG_S031_ERR_FMT_GRADO,['Altro','1']));  //'Per la parentela ''Altro'' occorre specificare un grado superiore o uguale a 1!');
  end;
  if (    (selSG101.FieldByName('GRADOPAR').AsString = 'CG')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DC'))
  or (    (selSG101.FieldByName('GRADOPAR').AsString = 'FG')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DC')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DF')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DA'))
  or (    ((selSG101.FieldByName('GRADOPAR').AsString = 'NP') or (selSG101.FieldByName('GRADOPAR').AsString = 'NF'))
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DF')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DA'))
  or (    (selSG101.FieldByName('GRADOPAR').AsString <> 'CG')
      and (selSG101.FieldByName('GRADOPAR').AsString <> 'FG')
      and (selSG101.FieldByName('GRADOPAR').AsString <> 'NP')
      and (selSG101.FieldByName('GRADOPAR').AsString <> 'NF')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'DA'))
  or (   ((selSG101.FieldByName('GRADOPAR').AsString = 'NS') or (selSG101.FieldByName('GRADOPAR').AsString = 'AF'))
      and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')) then
  begin
    selSG101.FieldByName('TIPO_DETRAZIONE').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_IRPEF);  //Grado di parentela incompatibile con il tipo di detrazione IRPEF!
  end;
  if (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND') and (selSG101.FieldByName('PERC_CARICO').AsFloat = 0) then
  begin
    selSG101.FieldByName('PERC_CARICO').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_PERC_NULLA);  //Familiare con detrazione IRPEF ma percentuale di carico sul dipendente nulla!
  end;
  if (selSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'ND') and (selSG101.FieldByName('PERC_CARICO').AsFloat <> 0) then
  begin
    selSG101.FieldByName('PERC_CARICO').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_PERC_NON_NULLA);  //Detrazione IRPEF per nessun familiare ma percentuale di carico sul dipendente valorizzata!
  end;
  if (selSG101.FieldByName('COMPONENTE_ANF').AsString = 'S') and
    ((selSG101.FieldByName('GRADOPAR').AsString = 'GT') or (selSG101.FieldByName('GRADOPAR').AsString = 'AL') or
     (selSG101.FieldByName('GRADOPAR').AsString = 'NS') or (selSG101.FieldByName('GRADOPAR').AsString = 'AF')) then
  begin
    selSG101.FieldByName('COMPONENTE_ANF').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_ANF);  //Il familiare non può fare parte del nucleo per l''assegno!
  end;

  if selSG101.FieldByName('DATANAS_PRESUNTA').IsNull then
    selSG101.FieldByName('DATANAS_PRESUNTA').Value:=selSG101.FieldByName('DATANAS').Value;
  if selSG101.FieldByName('DATANAS').IsNull then
    selSG101.FieldByName('DATANAS').Value:=selSG101.FieldByName('DATANAS_PRESUNTA').Value;
  if selSG101.FieldByName('DATANAS').IsNull and selSG101.FieldByName('DATAADOZ').IsNull and (not selSG101.FieldByName('CAUSALI_ABILITATE').IsNull) then
  begin
    selSG101.FieldByName('DATANAS').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_DATADOZ_NULLA);  //Specificare la data di nascita o la data di adozione!
  end;
  if (selSG101.FieldByName('COMPONENTE_ANF').AsString = 'S') and
    ((selSG101.FieldByName('GRADOPAR').AsString = 'FG') or (selSG101.FieldByName('GRADOPAR').AsString = 'FR') or
     (selSG101.FieldByName('GRADOPAR').AsString = 'NP') or (selSG101.FieldByName('GRADOPAR').AsString = 'NF')) and
     (selSG101.FieldByName('DATANAS').IsNull) then
  begin
    selSG101.FieldByName('DATANAS').FocusControl;
    raise exception.Create(A000MSG_S031_ERR_DATANAS_NULLA);  //Specificare la data di nascita del familiare!
  end;
  if (not selSG101.FieldByName('TIPO_DISABILITA').IsNull) then
  begin
    if selSG101.FieldByName('DATANAS').IsNull then
    begin
      selSG101.FieldByName('DATANAS').FocusControl;
      raise exception.Create(A000MSG_S031_ERR_DATANAS_NULLA);  //Specificare la data di nascita del familiare!
    end;
    if selSG101.FieldByName('COMNAS').IsNull then
    begin
      selSG101.FieldByName('COMNAS').FocusControl;
      raise exception.Create(Format(A000MSG_S031_ERR_FMT_COMUNE_NULLO,['nascita']));   //Specificare il comune di nascita del familiare!
    end;
    if selSG101.FieldByName('CODFISCALE').IsNull then
    begin
      selSG101.FieldByName('CODFISCALE').FocusControl;
      raise exception.Create(A000MSG_S031_ERR_CF_NULLO);       //Specificare il codice fiscale del familiare!
    end;
    if (selSG101.FieldByName('NUMGRADO').AsString = '3') and (selSG101.FieldByName('MOTIVO_GRADO_3').IsNull) then
      raise exception.Create(Format(A000MSG_S031_ERR_FMT_M3G_NULLO,['del familiare']));      //Specificare il motivo terzo grado!
    if (selSG101.FieldByName('TIPO_DISABILITA').AsString = '1') and (selSG101.FieldByName('ANNO_REVISIONE').IsNull) then
    begin
      selSG101.FieldByName('ANNO_REVISIONE').FocusControl;
      raise exception.Create(A000MSG_S031_ERR_AAREV_NULLO);    //Specificare la data di revisione!
    end;
    if selSG101.FieldByName('MATRICOLA').IsNull and selSG101.FieldByName('COMUNE').IsNull then
    begin
      selSG101.FieldByName('COMUNE').FocusControl;
      raise exception.Create(Format(A000MSG_S031_ERR_FMT_COMUNE_NULLO,['residenza']));   //Specificare il comune di residenza del familiare!
    end;
    if (selSG101.FieldByName('GRADOPAR').AsString = 'FG') and (selSG101.FieldByName('ALTERNATIVA').IsNull) then
      raise exception.Create(A000MSG_S031_ERR_ALTERN_NULLA);  //Specificare il tipo soggetto dell''alternativa!
    if (selSG101.FieldByName('ALTERNATIVA').AsString = '5') and (selSG101.FieldByName('MOTIVO_GRADO_3_ALT').IsNull) then
      raise exception.Create(Format(A000MSG_S031_ERR_FMT_M3G_NULLO,['dell''alternativa']));      //Specificare il motivo terzo grado!
    if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (selSG101.State = dsInsert) and
       (selSG101.FieldByName('ANNO_AVV_FAM').IsNull) and (AnnoAvvicinamentoFam <> 0) then
      selSG101.FieldByName('ANNO_AVV_FAM').AsInteger:=AnnoAvvicinamentoFam;
  end;
  if (not selSG101.FieldByName('ANNO_AVV').IsNull or not selSG101.FieldByName('ANNO_AVV_FAM').IsNull) and (selSG101.FieldByName('TIPO_DISABILITA').IsNull) then
    raise exception.Create(A000MSG_S031_ERR_DISAB_NULLA);  //Specificare il tipo di disabilità!
  if (not selSG101.FieldByName('ALTERNATIVA').IsNull) and (selSG101.FieldByName('TIPO_DISABILITA').IsNull) then
    raise exception.Create(A000MSG_S031_ERR_DISAB_NULLA);  //Specificare il tipo di disabilità!

  if (not selSG101.FieldByName('GRAV_FINE').IsNull) and (not selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull) and
     (selSG101.FieldByName('GRAV_FINE').AsDateTime < selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime ) then
  begin
    selSG101.FieldByName('GRAV_FINE').FocusControl;
    raise Exception.Create(Format(A000MSG_S031_ERR_FMT_PERIODO,['La data fine gravidanza','all''inizio effettivo']));  //La data fine gravidanza deve essere maggiore o uguale all''inizio effettivo!
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  if (R180In(selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString,['1','2'])) and
     (selSG101.FieldByName('DATAADOZ').IsNull) then
  begin
    selSG101.FieldByName('DATAADOZ').FocusControl;
    raise Exception.Create(A000MSG_S031_ERR_DATA_ADOZ_NULLA); //'E'' necessario indicare obbligatoriamente la data di adozione!';
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  if (not selSG101.FieldByName('DATA_PREADOZ').IsNull) and (not selSG101.FieldByName('DATAADOZ').IsNull) and
     (selSG101.FieldByName('DATAADOZ').AsDateTime < selSG101.FieldByName('DATA_PREADOZ').AsDateTime ) then
  begin
    selSG101.FieldByName('DATAADOZ').FocusControl;
    raise Exception.Create(Format(A000MSG_S031_ERR_FMT_PERIODO,['La data adozione','alla data pre-adozione']));  //La data adozione deve essere maggiore o uguale alla data pre-adozione!
  end;
  if (not selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull) and (not selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull) and
     (selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime > selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime) then
  begin
    selSG101.FieldByName('GRAV_INIZIO_EFF').FocusControl;
    raise Exception.Create(A000MSG_S031_MSG_INIZIO_EFF);  //L''inizio gravidanza effettivo non può essere successivo all''inizio scelto dal dipendente!
  end;
  if (not selSG101.FieldByName('DATA_PREADOZ').IsNull) and (selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString <> '2') then
    raise exception.Create(A000MSG_S031_MSG_DATA_PREADOZ);
end;

procedure TS031FFamiliariMW.QSG101ValidaFieldsNonBloccanti;
var
  Dal,Al,LDataRif:TDateTime;
  LTipoPeriodo: String;
begin
  //Controlli non bloccanti
  if (selSG101.FieldByName('GRADOPAR').AsString <> 'NS') and (selSG101.FieldByName('GRADOPAR').AsString <> 'CG') and (not selSG101.FieldByName('MATRICOLA').IsNull) then
    //il grado di parentela potrebbe essere incompatibile con il numero di matricola
    MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_INCOMPATIBILE,['numero di matricola']) + CRLF;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'FG') and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString = 'DA') then
    //il grado di parentela potrebbe essere incompatibile con il tipo di detrazione IRPEF
    MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_INCOMPATIBILE,['tipo di detrazione IRPEF']) + CRLF;
  if ((selSG101.FieldByName('GRADOPAR').AsString = 'AL') or
      (selSG101.FieldByName('GRADOPAR').AsString = 'NP') or
      (selSG101.FieldByName('GRADOPAR').AsString = 'NF')) and
     (Trim(selSG101.FieldByName('NUMGRADO').AsString) = '') then
      //grado di parentela non indicato
    MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_NULLO,['grado di parentela']) + CRLF;
  if (selSG101.FieldByName('GRADOPAR').AsString = 'AL') and (Trim(selSG101.FieldByName('TIPOPAR').AsString) = '') then
    //tipo di parentela non indicato
    MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_NULLO,['tipo di parentela']) + CRLF;

  if (not selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull) or
     (not selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull) then
  begin
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    // utilizza ora come data di riferimento, nell'ordine:
    // 1. data di preadozione
    // 2. data di adozione
    // 3. data presunta di nascita (come faceva prima)
    {
    Dal:=R180AddMesi(selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime,-2,True);
    Al:=R180AddMesi(selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime,-1,True);
    }
    if not selSG101.FieldByName('DATA_PREADOZ').IsNull then
    begin
      LTipoPeriodo:='adozione';
      LDataRif:=selSG101.FieldByName('DATA_PREADOZ').AsDateTime;
      Dal:=LDataRif;
      Al:=R180AddMesi(LDataRif,5,True);
    end
    else if not selSG101.FieldByName('DATAADOZ').IsNull then
    begin
      LTipoPeriodo:='adozione';
      LDataRif:=selSG101.FieldByName('DATAADOZ').AsDateTime;
      Dal:=LDataRif;
      Al:=R180AddMesi(LDataRif,5,True);
    end
    else
    begin
      LTipoPeriodo:='gravidanza';
      LDataRif:=selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime;
      Dal:=R180AddMesi(LDataRif,-2,True);
      Al:=R180AddMesi(LDataRif,0,True); //Alberto 17/06/2019: Adeguamento contrattuale. Inizio maternità consentita a partire dal giorno del parto.
    end;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

    if not selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull then
    begin
      if (selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime < Dal) or
         (selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime > Al) then
        MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_INIZIO_FUORI_PERIODO,['l''inizio ' + LTipoPeriodo + ' scelto dal dipendente',DateToStr(Dal) + '-' + DateToStr(Al)]) + CRLF;
    end;
    if not selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull then
    begin
      if (selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime < Dal) or
         (selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime > Al) then
        MsgErrore:=MsgErrore + ' - ' + Format(A000MSG_S031_MSG_FMT_INIZIO_FUORI_PERIODO,['l''inizio ' + LTipoPeriodo + ' effettivo',DateToStr(Dal) + '-' + DateToStr(Al)]) + CRLF;
    end;
  end;
end;

procedure TS031FFamiliariMW.AllineaDatiFissi;
var
  Q: TOracleQuery;
  i: Integer;
  NomeCampo,S: String;
  Differenza: Boolean;
  LValoriOriginali:TStringList;
begin
  Q:=TOracleQuery.Create(nil);
  try
    LValoriOriginali:=TStringList.Create;
    Q.Session:=SessioneOracle;
    //Update Tabella set Campo1 = 'Valore1', ...
    Q.SQL.Add('UPDATE SG101_FAMILIARI SET');
    for i:=0 to High(CAMPI_FISSI_SG101) do
    begin
      NomeCampo:=CAMPI_FISSI_SG101[i];
      try
        if Assigned(TrovaValoriOriginali) then
          LValoriOriginali.assign(TrovaValoriOriginali)
        else
           raise exception.Create(A000MSG_S031_ERR_ALLINEA);  //Allineamento dati fallito. Valori Originali non trovati.
        if selSG101.FieldByName(NomeCampo).AsString <> LValoriOriginali.Values[NomeCampo] then
        begin
          S:='';
          if Differenza then
            S:=',';
          if selSG101.FieldByName(NomeCampo) is TDateTimeField then
            S:=S + Format('%s = to_date(''%s'',''dd/mm/yyyy hh24.mi.ss'')',[NomeCampo,AggiungiApice(selSG101.FieldByName(NomeCampo).AsString)])
          else
            S:=S + NomeCampo + ' = ''' + AggiungiApice(selSG101.FieldByName(NomeCampo).AsString) + '''';
          Q.SQL.Add(S);
          Differenza:=True;
        end;
      except
      end;
    end;
    //Nessuna differenza da applicare
    if not Differenza then
      exit;
    //Where Chiave = 'chiave' and DECORRENZA > :DECORRENZA
    Q.SQL.Add('WHERE');
    if ChiavePrimaria.Count = 0 then
      Q.SQL.Add('1 = 1');
    for i:=0 to ChiavePrimaria.Count - 1 do
    begin
      S:=ChiavePrimaria[i] + ' = ''' + AggiungiApice(selSG101.FieldByName(ChiavePrimaria[i]).AsString) + '''';
      if i < ChiavePrimaria.Count - 1 then
        S:=S + ' AND ';
      Q.SQL.Add(S);
    end;
    // update su tutte le decorrenze diverse da quella corrente
    Q.SQL.Add('AND DECORRENZA <> :DECORRENZA');
    Q.DeclareVariable('DECORRENZA',otDate);
    Q.SetVariable('DECORRENZA',selSG101.FieldByName('DECORRENZA').AsDateTime);
    Q.Execute;
    Q.Session.Commit;
  finally
    if LValoriOriginali <> nil then
      FreeAndNil(LValoriOriginali);
    FreeAndNil(Q);
  end;
end;

function TS031FFamiliariMW.AnnoAvvicinamentoFam: Integer;
var Q: TOracleQuery;
begin
  //Anno avvicinamento al domicilio del familiare letto su gradopar diverso da Nessuno 
  Result:=0;
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    Q.SQL.Add('SELECT MAX(ANNO_AVV_FAM) ANNO_AVV_FAM FROM SG101_FAMILIARI SG101 ');
    Q.SQL.Add(' WHERE PROGRESSIVO = ' + selSG101.FieldByName('PROGRESSIVO').AsString);
    Q.SQL.Add('   AND GRADOPAR <> ''NS''');
    Q.SQL.Add('   AND ANNO_AVV_FAM IS NOT NULL');
    Q.Execute;
    if (Q.RowCount > 0) and (Q.Field(0) <> null) then
      Result:=Q.Field(0);
  finally
    FreeAndNil(Q);
  end;
end;

procedure TS031FFamiliariMW.AllineaDatiUguali;
var Q: TOracleQuery;
begin
  //Aggiorno Anno avvicinamento al domicilio del familiare su gradopar diverso da Nessuno
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    Q.SQL.Add('UPDATE SG101_FAMILIARI SG101 SET ');
    if selSG101.FieldByName('ANNO_AVV_FAM').IsNull then
      Q.SQL.Add('  ANNO_AVV_FAM = NULL')
    else
      Q.SQL.Add('  ANNO_AVV_FAM = ' + selSG101.FieldByName('ANNO_AVV_FAM').AsString);
    Q.SQL.Add(' WHERE PROGRESSIVO = ' + selSG101.FieldByName('PROGRESSIVO').AsString);
    Q.SQL.Add('   AND GRADOPAR <> ''NS''');
    Q.SQL.Add('   AND TIPO_DISABILITA IS NOT NULL');
    Q.Execute;
    Q.Session.Commit;
  finally
    FreeAndNil(Q);
  end;
end;

procedure TS031FFamiliariMW.QSG101ValidaMatricola;
begin
  inherited;
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if selSG101.FieldByName('MATRICOLA').AsString = '' then
    exit;
  if selT030.SearchRecord('MATRICOLA',selSG101.FieldByName('MATRICOLA').AsString,[srFromBeginning]) then
  begin
    selSG101.FieldByName('COGNOME').AsString:=selT030.FieldByName('COGNOME').AsString;
    selSG101.FieldByName('NOME').AsString:=selT030.FieldByName('NOME').AsString;
    if selT030.FieldByName('DATANAS').AsString = '' then
      selSG101.FieldByName('DATANAS').AsString:=''
    else
      selSG101.FieldByName('DATANAS').AsDateTime:=selT030.FieldByName('DATANAS').AsDateTime;
    selSG101.FieldByName('SESSO').AsString:=selT030.FieldByName('SESSO').AsString;
    selSG101.FieldByName('COMNAS').AsString:=selT030.FieldByName('COMUNENAS').AsString;
    selSG101.FieldByName('CAPNAS').AsString:=selT030.FieldByName('CAPNAS').AsString;
    if selT030.FieldByName('CODFISCALE').AsString <> '' then
      selSG101.FieldByName('CODFISCALE').AsString:=selT030.FieldByName('CODFISCALE').AsString;
    selSG101.FieldByName('COMUNE').AsString:='';
    selSG101.FieldByName('CAP').AsString:='';
    selSG101.FieldByName('INDIRIZZO').AsString:='';
    selSG101.FieldByName('TELEFONO').AsString:='';
    selSG101.FieldByName('NOME_PA').AsString:='';
    selSG101.FieldByName('DURATA_PA').AsString:='';
  end;
end;

procedure TS031FFamiliariMW.selSG101DATANASChange(GravidanzaVisible:Boolean);
var n:Integer;
  FineTeorica:TDateTime;
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if GravidanzaVisible then
  begin
    if (not selSG101.FieldByName('DATANAS').IsNull) and (not selSG101.FieldByName('DATANAS_PRESUNTA').IsNull) and
       (not selSG101.FieldByName('GRAV_FINE').IsNull) and
       (selSG101.FieldByName('DATANAS').AsDateTime > selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime) then
    begin
      n:=Trunc(selSG101.FieldByName('DATANAS').AsDateTime - selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime);
      if n > 0 then  //Se la data nascita è successiva a quella presunta di x giorni
      begin
        FineTeorica:=0;
        if not selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull then
          FineTeorica:=R180AddMesi(selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime,5,True);
        //Se la data fine teorica spostata in avanti di n giorni è diversa dalla data effettiva allora reimposto quest'ultima
        if (FineTeorica <> 0) and (FineTeorica + n <> selSG101.FieldByName('GRAV_FINE').AsDateTime) then
          selSG101.FieldByName('GRAV_FINE').AsDateTime:=FineTeorica + n;
      end;
    end;
  end;
end;

procedure TS031FFamiliariMW.selSG101DATANAS_PRESUNTAChange(GravidanzaVisible:Boolean);
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // utilizza accorgimenti per evitare loop di eventi
  if RichiamaDataPresuntaChange then
    RichiamaDataPresuntaChange:=False;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  // ennesima modifica.ini
  {
  if (not selSG101.FieldByName('DATANAS_PRESUNTA').IsNull) and
     (selSG101.FieldByName('DATANAS').IsNull) then
  }
  if (not selSG101.FieldByName('DATANAS_PRESUNTA').IsNull) and
     ((selSG101.FieldByName('DATANAS').IsNull) or
      (selSG101.FieldByName('REG_DATANAS').AsString = 'N')) then
  // ennesima modifica.fine
  begin
    selSG101.FieldByName('DATANAS').AsDateTime:=selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime;
  end;
  if GravidanzaVisible then
  begin
    if (selSG101.FieldByName('DATA_PREADOZ').IsNull) and
       (selSG101.FieldByName('DATAADOZ').IsNull) then
    begin
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      // se la data di nascita effettiva non è ancora indicata,
      // il periodo di gravidanza viene determinato dando precedenza alle date di adozione
      if selSG101.FieldByName('DATANAS').IsNull then
        RichiamaDataPresuntaChange:=True;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
      if selSG101.FieldByName('DATANAS_PRESUNTA').IsNull then
      begin
        if not selSG101.FieldByName('GRAV_INIZIO_TEOR').IsNull then //per non far scattare l'evento onChange del campo, quando si esegue il Clear
          selSG101.FieldByName('GRAV_INIZIO_TEOR').Clear;
        if not selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull then //per non far scattare l'evento onChange del campo, quando si esegue il Clear
          selSG101.FieldByName('GRAV_INIZIO_SCELTA').Clear;
      end
      else
      begin
        selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime:=R180AddMesi(selSG101.FieldByName('DATANAS_PRESUNTA').AsDateTime,-2,True);
        selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime:=selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime;
      end;
    end;
  end;
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TS031FFamiliariMW.selSG101DATAADOZChange(GravidanzaVisible:Boolean);
// richiamato se si modificano la data di adozione o preadozione
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if GravidanzaVisible then
  begin
    // l'impostazione del periodo di gravidanza è effettuato dando
    // precedenza alla data di preadozione, quindi alla data di adozione
    if selSG101.FieldByName('DATA_PREADOZ').IsNull then
    begin
      if selSG101.FieldByName('DATAADOZ').IsNull then
      begin
        if not selSG101.FieldByName('GRAV_INIZIO_TEOR').IsNull then //per non far scattare l'evento onChange del campo, quando si esegue il Clear
          selSG101.FieldByName('GRAV_INIZIO_TEOR').Clear;
        if not selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull then //per non far scattare l'evento onChange del campo, quando si esegue il Clear
        selSG101.FieldByName('GRAV_INIZIO_SCELTA').Clear;
      end
      else
      begin
        selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime:=selSG101.FieldByName('DATAADOZ').AsDateTime;
        selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime:=selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime;
      end;
    end
    else
    begin
      selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime:=selSG101.FieldByName('DATA_PREADOZ').AsDateTime;
      selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime:=selSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime;
    end;
  end;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TS031FFamiliariMW.selSG101GRAV_INIZIO_EFFChange(GravidanzaVisible:Boolean);
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if GravidanzaVisible then
  begin
    if selSG101.FieldByName('GRAV_INIZIO_EFF').IsNull then
      selSG101GRAV_INIZIO_SCELTAChange(GravidanzaVisible)
    else
      selSG101.FieldByName('GRAV_FINE').AsDateTime:=R180AddMesi(selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime,5,True);
  end;
end;

procedure TS031FFamiliariMW.selSG101GRAV_FINE_EFFChange(GravidanzaVisible: Boolean);
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if GravidanzaVisible then
  begin
    if selSG101.FieldByName('GRAV_FINE').IsNull then
      selSG101GRAV_INIZIO_EFFChange(GravidanzaVisible);
  end;
end;

procedure TS031FFamiliariMW.selSG101GRAV_INIZIO_SCELTAChange(GravidanzaVisible:Boolean);
begin
  if StoricizzazioneInCorso and RipristinoValoriInCorso then
    exit;

  if GravidanzaVisible then
  begin
    if selSG101.FieldByName('GRAV_INIZIO_SCELTA').IsNull then
    begin
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
      // il metodo change va richiamato solo in determinati casi,
      // in modo da evitare loop
      if RichiamaDataPresuntaChange then
      begin
        selSG101DATANAS_PRESUNTAChange(GravidanzaVisible);
      end;
      // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    end
    else
      selSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime:=selSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime;
  end;
end;

function TS031FFamiliariMW.StoricizzazioneInCorso: boolean;
begin
  if Assigned(VerificaStoricizzazioneEvents) then
    Result:=VerificaStoricizzazioneEvents;
end;

function TS031FFamiliariMW.RipristinoValoriInCorso: boolean;
begin
  if Assigned(VerificaRipristinoValoriEvents) then
    Result:=VerificaRipristinoValoriEvents;
end;


function TS031FFamiliariMW.cmbParentelaItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('GRADOPAR').AsString = 'NS' then
      Result:=0
    else if FieldByName('GRADOPAR').AsString = 'CG' then
      Result:=1
    else if FieldByName('GRADOPAR').AsString = 'FG' then
      Result:=2
    else if FieldByName('GRADOPAR').AsString = 'GT' then
      Result:=3
    else if FieldByName('GRADOPAR').AsString = 'FR' then
      Result:=4
    else if FieldByName('GRADOPAR').AsString = 'NP' then
      Result:=5
    else if FieldByName('GRADOPAR').AsString = 'NF' then
      Result:=6
    else if FieldByName('GRADOPAR').AsString = 'AL' then
      Result:=7
    else if FieldByName('GRADOPAR').AsString = 'AF' then
      Result:=8;
  end;
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
function TS031FFamiliariMW.cmbPartFruizMaternitaItemIndex: Integer;
var
  LPartFruizMaternita: String;
begin
  LPartFruizMaternita:=selSG101.FieldByName('PART_FRUIZ_MATERNITA').AsString;
  Result:=-1;
  if LPartFruizMaternita = '' then
    Result:=0
  else if LPartFruizMaternita = 'A' then
    Result:=1;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

function TS031FFamiliariMW.cmbTipoParentelaItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('TIPOPAR').AsString = 'P' then
      Result:=0
    else if FieldByName('TIPOPAR').AsString = 'A' then
      Result:=1;
  end;
end;

function TS031FFamiliariMW.cmbMotivoTerzoGradoItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('MOTIVO_GRADO_3').AsString = '1' then  //Coniuge della persona disabile con età superiore ai 65 anni
      Result:=0
    else if FieldByName('MOTIVO_GRADO_3').AsString = '2' then  //Genitore della persona disabile con età superiore ai 65 anni
      Result:=1
    else if FieldByName('MOTIVO_GRADO_3').AsString = '3' then   //Coniuge affetto da patologia invalidante
      Result:=2
    else if FieldByName('MOTIVO_GRADO_3').AsString = '4' then   //Genitori affetti da patologia invalidante
      Result:=3
    else if FieldByName('MOTIVO_GRADO_3').AsString = '5' then   //Coniuge deceduto o mancante
      Result:=4
    else if FieldByName('MOTIVO_GRADO_3').AsString = '6' then   //Genitori deceduti o mancanti
      Result:=5
    else if FieldByName('MOTIVO_GRADO_3').AsString = '7' then   //Regime precedente Legge 183/2010
      Result:=6;
  end;
end;

function TS031FFamiliariMW.cmbTipoAdozItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('TIPO_ADOZ_AFFID').AsString = '1' then  //Adozione nazionale
      Result:=0
    else if FieldByName('TIPO_ADOZ_AFFID').AsString = '2' then  //Adozione internazionale
      Result:=1
    else if FieldByName('TIPO_ADOZ_AFFID').AsString = '3' then  //Affido residenziale
      Result:=2
    else if FieldByName('TIPO_ADOZ_AFFID').AsString = '4' then  //Affidamento
      Result:=3;
  end;
end;

function TS031FFamiliariMW.cmbTipoDisabilitaItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('TIPO_DISABILITA').AsString = '1' then  //Rivedibile
      Result:=0
    else if FieldByName('TIPO_DISABILITA').AsString = '2' then  //Non rivedibile
      Result:=1
    else if FieldByName('TIPO_DISABILITA').AsString = '3' then   //Provvisorio
      Result:=2;
  end;
end;

function TS031FFamiliariMW.cmbNomePAItemIndex: integer;
var lstNomePA:TStringList;
begin
  Result:=-1;
  if Trim(selSG101.FieldByName('NOME_PA').AsString) = '' then
    Exit;
  lstNomePA:=TStringList.Create;
  lstNomePA.Clear;
  with selNomePA do
  begin
    Close;
    SetVariable('DATO','NOME_PA');
    Open;
    First;
    while not Eof do
    begin
      lstNomePA.Add(FieldByName('NOME_PA').AsString);
      Next;
    end;
  end;
  Result:=R180IndexOf(lstNomePA,selSG101.FieldByName('NOME_PA').AsString,100);
  FreeAndNil(lstNomePA);
end;

function TS031FFamiliariMW.cmbAlternativaNomePAItemIndex: integer;
var lstNomePA:TStringList;
begin
  Result:=-1;
  if Trim(selSG101.FieldByName('NOME_PA_ALT').AsString) = '' then
    Exit;
  lstNomePA:=TStringList.Create;
  lstNomePA.Clear;
  with selNomePA do
  begin
    Close;
    SetVariable('DATO','NOME_PA_ALT');
    Open;
    First;
    while not Eof do
    begin
      lstNomePA.Add(FieldByName('NOME_PA_ALT').AsString);
      Next;
    end;
  end;
  Result:=R180IndexOf(lstNomePA,selSG101.FieldByName('NOME_PA_ALT').AsString,100);
  FreeAndNil(lstNomePA);
end;

function TS031FFamiliariMW.cmbDurataContrattoItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('DURATA_PA').AsString = '1' then  //Indeterminato
      Result:=0
    else if FieldByName('DURATA_PA').AsString = '2' then  //Determinato
      Result:=1;
  end;
end;

function TS031FFamiliariMW.cmbAlternativaItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('ALTERNATIVA').AsString = '1' then  //Genitore
      Result:=0
    else if FieldByName('ALTERNATIVA').AsString = '2' then  //Coniuge
      Result:=1
    else if FieldByName('ALTERNATIVA').AsString = '3' then  //Figlio
      Result:=2
    else if FieldByName('ALTERNATIVA').AsString = '4' then  //Parente o affine fino al II grado
      Result:=3
    else if FieldByName('ALTERNATIVA').AsString = '5' then  //Parente o affine fino al III grado
      Result:=4
    else if FieldByName('ALTERNATIVA').AsString = '6' then  //Nessuno
      Result:=5;
  end;
end;

function TS031FFamiliariMW.cmbAlternativaMotivoTerzoGradoItemIndex: integer;
begin
  with selSG101 do
  begin
    Result:=-1;
    if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '1' then  //Coniuge della persona disabile con età superiore ai 65 anni
      Result:=0
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '2' then  //Genitore della persona disabile con età superiore ai 65 anni
      Result:=1
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '3' then   //Coniuge affetto da patologia invalidante
      Result:=2
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '4' then   //Genitori affetti da patologia invalidante
      Result:=3
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '5' then   //Coniuge deceduto o mancante
      Result:=4
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '6' then   //Genitori deceduti o mancanti
      Result:=5
    else if FieldByName('MOTIVO_GRADO_3_ALT').AsString = '7' then   //Regime precedente Legge 183/2010
      Result:=6;
  end;
end;

function TS031FFamiliariMW.GetCausaliFG:String;
begin
  Result:='';
  with selT265 do
  begin
    Open;
    First;
    while not Eof do
    begin
      if FieldByName('FRUIBILE').AsString = 'S' then
        Result:=Result + IfThen(Result <> '',',','') + FieldByName('CODICE').AsString;
      Next;
    end;
  end;
end;

procedure TS031FFamiliariMW.AllineaParentela;
begin
 // grado di parentela
  selSG101.FieldByName('GRADOPAR').AsString:='';
  case cmbParentelaSelItemIndex of
    0: selSG101.FieldByName('GRADOPAR').AsString:='NS';
    1: selSG101.FieldByName('GRADOPAR').AsString:='CG';
    2: selSG101.FieldByName('GRADOPAR').AsString:='FG';
    3: selSG101.FieldByName('GRADOPAR').AsString:='GT';
    4: selSG101.FieldByName('GRADOPAR').AsString:='FR';
    5: selSG101.FieldByName('GRADOPAR').AsString:='NP';
    6: selSG101.FieldByName('GRADOPAR').AsString:='NF';
    7: selSG101.FieldByName('GRADOPAR').AsString:='AL';
    8: selSG101.FieldByName('GRADOPAR').AsString:='AF';
  end;

  selSG101.FieldByName('TIPOPAR').AsString:='';
  case cmbTipoParSelItemIndex of
    0: selSG101.FieldByName('TIPOPAR').AsString:='P';
    1: selSG101.FieldByName('TIPOPAR').AsString:='A';
  end;

  selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='';
  case cmbMotivoTerzoGradoSelItemIndex of
    0: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='1';
    1: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='2';
    2: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='3';
    3: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='4';
    4: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='5';
    5: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='6';
    6: selSG101.FieldByName('MOTIVO_GRADO_3').AsString:='7';
  end;

  selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString:='';
  case cmbTipoAdozSelItemIndex of
    0: selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString:='1';
    1: selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString:='2';
    2: selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString:='3';
    3: selSG101.FieldByName('TIPO_ADOZ_AFFID').AsString:='4';
  end;

  selSG101.FieldByName('TIPO_DISABILITA').AsString:='';
  case cmbTipoDisabilitaSelItemIndex of
    0: selSG101.FieldByName('TIPO_DISABILITA').AsString:='1';
    1: selSG101.FieldByName('TIPO_DISABILITA').AsString:='2';
    2: selSG101.FieldByName('TIPO_DISABILITA').AsString:='3';
  end;

  selSG101.FieldByName('DURATA_PA').AsString:='';
  case cmbDurataContrattoSelItemIndex of
    0: selSG101.FieldByName('DURATA_PA').AsString:='1';
    1: selSG101.FieldByName('DURATA_PA').AsString:='2';
  end;

  selSG101.FieldByName('ALTERNATIVA').AsString:='';
  case cmbAlternativaSelItemIndex of
    0: selSG101.FieldByName('ALTERNATIVA').AsString:='1';
    1: selSG101.FieldByName('ALTERNATIVA').AsString:='2';
    2: selSG101.FieldByName('ALTERNATIVA').AsString:='3';
    3: selSG101.FieldByName('ALTERNATIVA').AsString:='4';
    4: selSG101.FieldByName('ALTERNATIVA').AsString:='5';
    5: selSG101.FieldByName('ALTERNATIVA').AsString:='6';
    6: selSG101.FieldByName('ALTERNATIVA').AsString:='7';
  end;

  selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='';
  case cmbAlternativaMotivoTerzoGradoSelItemIndex of
    0: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='1';
    1: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='2';
    2: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='3';
    3: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='4';
    4: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='5';
    5: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='6';
    6: selSG101.FieldByName('MOTIVO_GRADO_3_ALT').AsString:='7';
  end;

  selSG101.FieldByName('NOME_PA').AsString:=cmbNomeSelPAText;
  selSG101.FieldByName('NOME_PA_ALT').AsString:=cmbAlternativaNomeSelPAText;

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  case cmbPartFruizMaternitaSelItemIndex of
    0: selSG101.FieldByName('PART_FRUIZ_MATERNITA').AsString:='';
    1: selSG101.FieldByName('PART_FRUIZ_MATERNITA').AsString:='A';
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

function TS031FFamiliariMW.IsDataDichiarazDaAggiornare:Boolean;
begin
  Result:=False;
  //Se in storicizzazione o modifica è cambiato qualche dato delle detrazioni IRPEF
  //o in inserimento ho messo il familiare a carico,
  //chiedo se aggiornare la data di ultima dichiarazione se è vecchia
  if (   (    (StoricizzazioneInCorso or (selSG101.State in [dsEdit]))
          and (   (selSG101.FieldByName('TIPO_DETRAZIONE').Value <> selSG101OldValues.FieldByName('TIPO_DETRAZIONE').Value)
               or (selSG101.FieldByName('PERC_CARICO').Value <> selSG101OldValues.FieldByName('PERC_CARICO').Value)
               or (selSG101.FieldByName('DETR_FIGLIO_HANDICAP').Value <> selSG101OldValues.FieldByName('DETR_FIGLIO_HANDICAP').Value)))
      or (    (not StoricizzazioneInCorso and (selSG101.State in [dsInsert]))
          and (selSG101.FieldByName('TIPO_DETRAZIONE').AsString <> 'ND')))
  and (    selSG101.FieldByName('DATA_ULT_FAM_CAR').IsNull
       or (selSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime < Trunc(R180Sysdate(SessioneOracle)))) then
  Result:=True;
end;

function TS031FFamiliariMW.IsDataDichiarazVuota:Boolean;
begin
  Result:=False;
  if (VarToStr(selSG101.FieldByName('DATA_ULT_FAM_CAR').Value) = '')
  and (VarToStr(selSG101OldValues.FieldByName('DATA_ULT_FAM_CAR').Value) <> '') then
    Result:=True;
end;

end.

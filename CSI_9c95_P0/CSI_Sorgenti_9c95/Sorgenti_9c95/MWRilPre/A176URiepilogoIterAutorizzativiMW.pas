unit A176URiepilogoIterAutorizzativiMW;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, OracleData, Data.DB, Oracle,
  A000UInterfaccia, A000UCostanti, A000USessione, C018UIterAutDM, C180FunzioniGenerali,
  FunzioniGenerali, RegistrazioneLog, StrUtils;

const
  A176AZIONE_APPLICA_AUT   = 'applica autorizzazione';
  A176AZIONE_ANNULLA_AUT   = 'annulla autorizzazione';
  A176AZIONE_CANCELLA_RICH = 'cancella richiesta';
  A176AZIONE_CAMBIA_STRUTT  = 'cambia struttura';
  A176AUTORIZZA = 'autorizza';
  A176NEGA      = 'nega';

type
  TA176FRiepilogoIterAutorizzativiMW = class(TR005FDataModuleMW)
    selVT050: TOracleDataSet;
    selVT105: TOracleDataSet;
    selVM140: TOracleDataSet;
    selVT065: TOracleDataSet;
    selVT860: TOracleDataSet;
    selVT085: TOracleDataSet;
    selVT251: TOracleDataSet;
    selVT325_EU: TOracleDataSet;
    selVT325: TOracleDataSet;
    selVT050PROGRESSIVO: TIntegerField;
    selVT050T050CAUSALE: TStringField;
    selVT050T050TIPOGIUST: TStringField;
    selVT050T050DAL: TDateTimeField;
    selVT050T050AL: TDateTimeField;
    selVT050T050NUMEROORE: TStringField;
    selVT050T050AORE: TStringField;
    selVT050T050DATANAS: TDateTimeField;
    selVT050T050NUMEROORE_PREV: TStringField;
    selVT050T050AORE_PREV: TStringField;
    selVT050T050ELABORATO: TStringField;
    selVT050T850ITER: TStringField;
    selVT050T850COD_ITER: TStringField;
    selVT050T850ID: TFloatField;
    selVT050T850DATA: TDateTimeField;
    selVT050T850STATO: TStringField;
    selVT050T850NOTE: TStringField;
    selVT050T850TIPO_RICHIESTA: TStringField;
    selVT050T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT050T850ID_REVOCA: TFloatField;
    selVT050T850ID_REVOCATO: TFloatField;
    selVT105PROGRESSIVO: TIntegerField;
    selVT105T105DATA: TDateTimeField;
    selVT105T105ORA: TStringField;
    selVT105T105VERSO: TStringField;
    selVT105T105CAUSALE: TStringField;
    selVT105T105RILEVATORE_RICH: TStringField;
    selVT105T105OPERAZIONE: TStringField;
    selVT105T105CAUSALE_ORIG: TStringField;
    selVT105T105VERSO_ORIG: TStringField;
    selVT105T105RILEVATORE_ORIG: TStringField;
    selVT105T105MOTIVAZIONE: TStringField;
    selVT105T105ELABORATO: TStringField;
    selVT105T850ITER: TStringField;
    selVT105T850COD_ITER: TStringField;
    selVT105T850ID: TFloatField;
    selVT105T850DATA: TDateTimeField;
    selVT105T850STATO: TStringField;
    selVT105T850NOTE: TStringField;
    selVT105T850TIPO_RICHIESTA: TStringField;
    selVT105T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT105T850ID_REVOCA: TFloatField;
    selVT105T850ID_REVOCATO: TFloatField;
    selVM140PROGRESSIVO: TIntegerField;
    selVM140M140FLAG_DESTINAZIONE: TStringField;
    selVM140M140FLAG_ISPETTIVA: TStringField;
    selVM140M140DATADA: TDateTimeField;
    selVM140M140DATAA: TDateTimeField;
    selVM140M140ORADA: TStringField;
    selVM140M140ORAA: TStringField;
    selVM140M140PROTOCOLLO: TStringField;
    selVM140M140FLAG_TIPOACCREDITO: TStringField;
    selVM140M140DELEGATO: TStringField;
    selVM140M140TIPOREGISTRAZIONE: TStringField;
    selVM140M140ANNULLAMENTO: TStringField;
    selVM140M140FLAG_PERCORSO: TStringField;
    selVM140M140MISSIONE_RIAPERTA: TStringField;
    selVM140T850ITER: TStringField;
    selVM140T850COD_ITER: TStringField;
    selVM140T850ID: TFloatField;
    selVM140T850DATA: TDateTimeField;
    selVM140T850STATO: TStringField;
    selVM140T850NOTE: TStringField;
    selVM140T850TIPO_RICHIESTA: TStringField;
    selVM140T850AUTORIZZ_AUTOMATICA: TStringField;
    selVM140T850ID_REVOCA: TFloatField;
    selVM140T850ID_REVOCATO: TFloatField;
    selVT065PROGRESSIVO: TIntegerField;
    selVT065T065DATA: TDateTimeField;
    selVT065T065TIPO: TStringField;
    selVT065T065ID_CONGUAGLIO: TIntegerField;
    selVT065T065ORE_ECCED_CALC: TStringField;
    selVT065T065ORE_ECCEDENTI: TStringField;
    selVT065T065ORE_DACOMPENSARE: TStringField;
    selVT065T065ORE_DALIQUIDARE: TStringField;
    selVT065T065CAUSALE: TStringField;
    selVT065T065ORE_CAUSALIZZATE: TStringField;
    selVT065T065MIN_ORE_DALIQUIDARE: TStringField;
    selVT065T065MIN_ORE_DACOMPENSARE: TStringField;
    selVT065T850ITER: TStringField;
    selVT065T850COD_ITER: TStringField;
    selVT065T850ID: TFloatField;
    selVT065T850DATA: TDateTimeField;
    selVT065T850STATO: TStringField;
    selVT065T850NOTE: TStringField;
    selVT065T850TIPO_RICHIESTA: TStringField;
    selVT065T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT065T850ID_REVOCA: TFloatField;
    selVT065T850ID_REVOCATO: TFloatField;
    selVT085PROGRESSIVO: TIntegerField;
    selVT085T085DATA_ORARIO: TDateTimeField;
    selVT085T085TIPOGIORNO: TStringField;
    selVT085T085GIORNO: TStringField;
    selVT085T085DATA_INVER: TDateTimeField;
    selVT085T085TIPOGIORNO_INVER: TStringField;
    selVT085T085ORARIO_INVER: TStringField;
    selVT085T085SOLO_NOTE: TStringField;
    selVT085T850ITER: TStringField;
    selVT085T850COD_ITER: TStringField;
    selVT085T850ID: TFloatField;
    selVT085T850DATA: TDateTimeField;
    selVT085T850STATO: TStringField;
    selVT085T850NOTE: TStringField;
    selVT085T850TIPO_RICHIESTA: TStringField;
    selVT085T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT085T850ID_REVOCA: TFloatField;
    selVT085T850ID_REVOCATO: TFloatField;
    selVT050T850RICHIEDENTE: TStringField;
    selVT105T850RICHIEDENTE: TStringField;
    selVM140T850RICHIEDENTE: TStringField;
    selVT065T850RICHIEDENTE: TStringField;
    selVT085T850RICHIEDENTE: TStringField;
    selVT860PROGRESSIVO: TFloatField;
    selVT860T860MESE_CARTELLINO: TDateTimeField;
    selVT860T850ITER: TStringField;
    selVT860T850COD_ITER: TStringField;
    selVT860T850ID: TFloatField;
    selVT860T850DATA: TDateTimeField;
    selVT860T850RICHIEDENTE: TStringField;
    selVT860T850STATO: TStringField;
    selVT860T850NOTE: TStringField;
    selVT860T850TIPO_RICHIESTA: TStringField;
    selVT860T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT860T850ID_REVOCA: TFloatField;
    selVT860T850ID_REVOCATO: TFloatField;
    selVT251PROGRESSIVO: TFloatField;
    selVT251VT251DATA_SCIOPERO: TDateTimeField;
    selVT251VT251ID_T250: TFloatField;
    selVT251VT251CAUSALE: TStringField;
    selVT251VT251D_CAUSALE: TStringField;
    selVT251VT251TIPOGIUST: TStringField;
    selVT251VT251DAORE: TStringField;
    selVT251VT251AORE: TStringField;
    selVT251VT251SELEZIONE_ANAGRAFICA: TStringField;
    selVT251VT251MINIMO: TIntegerField;
    selVT251T850ID: TFloatField;
    selVT251T850DATA: TDateTimeField;
    selVT251T850RICHIEDENTE: TStringField;
    selVT251T850NOTE: TStringField;
    selVT251T850STATO: TStringField;
    selVT251T850TIPO_RICHIESTA: TStringField;
    selVT251T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT251T850ID_REVOCA: TFloatField;
    selVT251T850ID_REVOCATO: TFloatField;
    selVT251T850ITER: TStringField;
    selVT251T850COD_ITER: TStringField;
    selVT325_EUVT325ID_T325: TFloatField;
    selVT325_EUVT325DATA: TDateTimeField;
    selVT325_EUPROGRESSIVO: TIntegerField;
    selVT325_EUVT325TIMBRATURE: TStringField;
    selVT325_EUVT325ORE_LORDE: TStringField;
    selVT325_EUVT325ORE_CONTEGGIATE: TStringField;
    selVT325_EUVT325DEBITO: TStringField;
    selVT325_EUVT325DETR_MENSA: TStringField;
    selVT325_EUVT325RITARDO: TStringField;
    selVT325_EUVT325MOTIVAZIONE: TStringField;
    selVT325_EUVT325TIPO_E: TStringField;
    selVT325_EUVT325ECCEDENZA_E: TStringField;
    selVT325_EUVT325SPEZ_E: TStringField;
    selVT325_EUVT325SPEZ_DALLE1_E: TStringField;
    selVT325_EUVT325SPEZ_ALLE1_E: TStringField;
    selVT325_EUVT325CAUS1_E: TStringField;
    selVT325_EUVT325CAUS_ORIG_E: TStringField;
    selVT325_EUVT325AUTORIZZAZIONE_E: TStringField;
    selVT325_EUVT325MOTIVAZIONE_E: TStringField;
    selVT325_EUVT325TIPO_U: TStringField;
    selVT325_EUVT325ECCEDENZA_U: TStringField;
    selVT325_EUVT325SPEZ_U: TStringField;
    selVT325_EUVT325SPEZ_DALLE1_U: TStringField;
    selVT325_EUVT325SPEZ_ALLE1_U: TStringField;
    selVT325_EUVT325CAUS1_U: TStringField;
    selVT325_EUVT325CAUS_ORIG_U: TStringField;
    selVT325_EUVT325AUTORIZZAZIONE_U: TStringField;
    selVT325_EUVT325MOTIVAZIONE_U: TStringField;
    selVT325_EUT850ID: TFloatField;
    selVT325_EUT850DATA: TDateTimeField;
    selVT325_EUT850NOTE: TStringField;
    selVT325_EUT850STATO: TStringField;
    selVT325_EUT850TIPO_RICHIESTA: TStringField;
    selVT325_EUT850AUTORIZZ_AUTOMATICA: TStringField;
    selVT325_EUT850ID_REVOCA: TFloatField;
    selVT325_EUT850ID_REVOCATO: TFloatField;
    selVT325_EUT850ITER: TStringField;
    selVT325_EUT850COD_ITER: TStringField;
    selVT325_EUT850RICHIEDENTE: TStringField;
    selVT325VT325ID_ID: TFloatField;
    selVT325PROGRESSIVO: TIntegerField;
    selVT325VT325DATA: TDateTimeField;
    selVT325VT325TIMBRATURE: TStringField;
    selVT325VT325ORE_LORDE: TStringField;
    selVT325VT325ORE_CONTEGGIATE: TStringField;
    selVT325VT325DEBITO: TStringField;
    selVT325VT325DETR_MENSA: TStringField;
    selVT325VT325RITARDO: TStringField;
    selVT325VT325TIPO: TStringField;
    selVT325VT325ECCEDENZA: TStringField;
    selVT325VT325SPEZ: TStringField;
    selVT325VT325CAUS_ORIG: TStringField;
    selVT325VT325SPEZ_DALLE1: TStringField;
    selVT325VT325SPEZ_ALLE1: TStringField;
    selVT325VT325CAUS1: TStringField;
    selVT325VT325SPEZ_DALLE2: TStringField;
    selVT325VT325SPEZ_ALLE2: TStringField;
    selVT325VT325CAUS2: TStringField;
    selVT325VT325SPEZ_DALLE3: TStringField;
    selVT325VT325SPEZ_ALLE3: TStringField;
    selVT325VT325CAUS3: TStringField;
    selVT325VT325MOTIVAZIONE: TStringField;
    selVT325T850ID: TFloatField;
    selVT325T850DATA: TDateTimeField;
    selVT325T850RICHIEDENTE: TStringField;
    selVT325T850NOTE: TStringField;
    selVT325T850STATO: TStringField;
    selVT325T850TIPO_RICHIESTA: TStringField;
    selVT325T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT325T850ID_REVOCA: TFloatField;
    selVT325T850ID_REVOCATO: TFloatField;
    selVT325T850ITER: TStringField;
    selVT325T850COD_ITER: TStringField;
    selVT050T850CONDIZ_ALLEGATI: TStringField;
    selVT105T850CONDIZ_ALLEGATI: TStringField;
    selVM140T850CONDIZ_ALLEGATI: TStringField;
    selVT065T850CONDIZ_ALLEGATI: TStringField;
    selVT085T850CONDIZ_ALLEGATI: TStringField;
    selVT860T850CONDIZ_ALLEGATI: TStringField;
    selVT251T850CONDIZ_ALLEGATI: TStringField;
    selVT325_EUT850CONDIZ_ALLEGATI: TStringField;
    selVT325T850CONDIZ_ALLEGATI: TStringField;
    selVT050T853FILE_ALLEGATO: TStringField;
    selVT105T853FILE_ALLEGATO: TStringField;
    selVM140T853FILE_ALLEGATO: TStringField;
    selVT065T853FILE_ALLEGATO: TStringField;
    selVT085T853FILE_ALLEGATO: TStringField;
    selVT860T853FILE_ALLEGATO: TStringField;
    selVT251T853FILE_ALLEGATO: TStringField;
    selVT325_EUT853FILE_ALLEGATO: TStringField;
    selVT325T853FILE_ALLEGATO: TStringField;
    dsrT851DettIter: TDataSource;
    selI095: TOracleDataSet;
    dsrI095: TDataSource;
    T850P_MAIL_ANNULLAMENTO: TOracleQuery;
    dsrT265T275: TDataSource;
    selT265T275: TOracleDataSet;
    selVT755: TOracleDataSet;
    selVT755T850RICHIEDENTE: TStringField;
    selVT755T850DATA: TDateTimeField;
    selVT755T850ITER: TStringField;
    selVT755T850NOTE: TStringField;
    selVT755T850STATO: TStringField;
    selVT755T850AUTORIZZ_AUTOMATICA: TStringField;
    selVT755T853FILE_ALLEGATO: TStringField;
    selVT755T850CONDIZ_ALLEGATI: TStringField;
    selVT755T850ID: TFloatField;
    selVT755T850TIPO_RICHIESTA: TStringField;
    selVT755T850COD_ITER: TStringField;
    selVT755T850ID_REVOCA: TFloatField;
    selVT755T850ID_REVOCATO: TFloatField;
    selVT755PROGRESSIVO: TIntegerField;
    selVT755T755DATA: TDateField;
    selVT755T755ORE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selVT960T960DIMENSIONEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selVSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    pProgressivo:integer;
    pTipoEstrazioneIter, pAllegatoExist, pCondizAllegato, pCausale:string;
    pDataRichDa, pDataRichA:TDateTime;
    pPeriodoRichDa, pPeriodoRichA:TDateTime;
    StringListLivello:TStringList;
    FiltroSQL:string;
    procedure CreaFiltro;
    procedure SetTipoEstrazione(Tipo:string);
    procedure SetProgressivo(inProgr:integer);
    procedure SetDataRichDa(inData:TDateTime);
    procedure SetDataRichA(inData:TDateTime);
    procedure SetPeriodoRichDa(inData:TDateTime);
    procedure SetPeriodoRichA(inData:TDateTime);
    procedure SetAllegatoExist(Val:string);
    procedure SetCondizAllegato(Val:string);
    procedure SetCausale(Val:string);
  public
    { Public declarations }
    C018:TC018FIterAutDM;
    DataSetAttivo:TOracleDataSet;
    function IterDescToCod(Descrizione:string):string;
    function ResetRichiesta(const Livello:Integer;const DelDatiDB:Boolean):string;
    function CancellaRichiesta(const DelDatiDB:Boolean):string;
    function ForzaRichiesta(const Livello:Integer; const Stato:Boolean):string;
    function CambiaStruttura(StrutturaOld,StrutturaNew:String):String;
    function CaricaCmbLivelliA176MW(Azione:string):TStringList;
    procedure OpenDataSetAttivo;
    procedure SetC018selT851;
    procedure SetIDIter(inIter,inCodIter:String; inID:integer);
    property Progressivo:integer read pProgressivo write SetProgressivo;
    property TipoEstrazioneIter:string read pTipoEstrazioneIter write SetTipoEstrazione;
    property DataRichDa:TDateTime read pDataRichDa write SetDataRichDa;
    property DataRichA:TDateTime read pDataRichA write SetDataRichA;
    property PeriodoRichDa:TDateTime read pPeriodoRichDa write SetPeriodoRichDa;
    property PeriodoRichA:TDateTime read pPeriodoRichA write SetPeriodoRichA;
    property AllegatoExist:string read pAllegatoExist write SetAllegatoExist;
    property CondizAllegato:string read pCondizAllegato write SetCondizAllegato;
    property Causale:string read pCausale write SetCausale;
  end;

implementation

{$R *.dfm}

uses
  SelAnagrafe;

function TA176FRiepilogoIterAutorizzativiMW.CaricaCmbLivelliA176MW(Azione:string):TStringList;
begin
  Azione:=Azione.toLower;
  Result:=StringListLivello;
  StringListLivello.Clear;
  if (Azione = A176AZIONE_APPLICA_AUT) and (VarToStr(C018.selT851.Lookup('OBBLIGATORIO;STATO',VarArrayOf(['S','No']),'STATO')).ToUpper = 'NO') then
  begin
    //Solo se sono nella condizione di "forzare" un iter
    //Se è presente un livello obbligatorio non autorizzato, non carico nulla nella cmbLivello
    Exit;
  end;
  C018.selT851.Last;
  while not C018.selT851.Bof do
  begin
    if (Azione = A176AZIONE_APPLICA_AUT) and (C018.selT851.FieldByName('STATO').AsString.ToUpper = 'SI') then
    begin
      //Solo se sono nella condizione di "forzare" un iter
      //Inserisco i livelli successivi all'ultimo con stato uguale a "S"
      //Se non vi è alcun record con stato uguale a "S", lì inserisco tutti
      Break;
    end;
    if (Azione = A176AZIONE_ANNULLA_AUT) then
    begin
      //Se Reset caricare solo i livelli solo se STATO <> null
      if not C018.selT851.FieldByName('STATO').isNull then
      begin
        StringListLivello.Add(C018.selT851.FieldByName('LIVELLO').AsString);
      end;
    end
    else if (Azione = A176AZIONE_CANCELLA_RICH) then
    begin
      Result.Add(C018.selT851.FieldByName('LIVELLO').AsString);
    end
    else if (Azione = A176AZIONE_APPLICA_AUT) then
    begin
      //Solo se sono nella condizione di "forzare" un iter
      //Carico i livelli che sono obbligatori
      if (C018.selT851.FieldByName('OBBLIGATORIO').AsString.ToUpper = 'S') then
      begin
        Result.Add(C018.selT851.FieldByName('LIVELLO').AsString);
      end;
    end;
    C018.selT851.Prior;
  end;
end;

function TA176FRiepilogoIterAutorizzativiMW.ResetRichiesta(const Livello:Integer;const DelDatiDB:Boolean):string;
var
  selTabLog:TOracleDataset;
begin
  if DelDatiDB then
  begin
    selTabLog:=TOracleDataSet.Create(nil);
  end;
  try
    //Log cancella T040 - T100 - M040
    if DelDatiDB then
    begin
      selTabLog.Session:=SessioneOracle;
      selTabLog.SQL.Add('select T.*');
      selTabLog.SQL.Add('  from :TABELLA T');
      selTabLog.SQL.Add(' where :NOME_DATO = :ID');
      selTabLog.DeclareAndSet('TABELLA',otSubst,C018.TabellaDB.NomeTabella);
      selTabLog.DeclareAndSet('NOME_DATO',otSubst,C018.TabellaDB.NomeDatoID);
      selTabLog.DeclareAndSet('ID',otInteger,C018.ID);
      selTabLog.Open;
    end;
    with T850P_MAIL_ANNULLAMENTO do
    try
      SetVariable('ID',C018.ID);
      SetVariable('OPERAZIONE','A');
      Execute;
    except
    end;
    Result:=C018.ResetRichiesta(Livello, DelDatiDB);
    if Result.IsEmpty then
    begin
      //Log cancellazioni T851
      C018.selT851.First;
      while not C018.selT851.Eof do
      begin
        if C018.selT851.FieldByName('LIVELLO').AsInteger >= Livello then
        begin
          RegistraLog.SettaProprieta('C','T851_ITER_AUTORIZZAZIONI','A176',C018.selT851,True);
          RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
          RegistraLog.InserisciDato('ID',C018.ID.ToString,'');
          RegistraLog.RegistraOperazione;
        end;
        C018.selT851.Next;
      end;
      //Log modifiche T850
      if not DataSetAttivo.FieldByName('T850STATO').isNull then
      begin
        RegistraLog.SettaProprieta('M','T850_ITER_RICHIESTE','A176',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
        RegistraLog.InserisciDato('ID',C018.Id.ToString,'');
        RegistraLog.InserisciDato('STATO',DataSetAttivo.FieldByName('T850STATO').asString,'null');
        RegistraLog.RegistraOperazione;
      end;
      if DelDatiDB and R180In(C018.Iter,[ITER_GIUSTIF,ITER_TIMBR,ITER_MISSIONI]) then
      begin
        //Log modifica  T050 - T105
        if R180In(C018.Iter,[ITER_GIUSTIF,ITER_TIMBR]) then
        begin
          RegistraLog.SettaProprieta('M',C018.TabellaIter,'A176',nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
          RegistraLog.InserisciDato('ID',C018.Id.ToString,'');
          RegistraLog.InserisciDato('ELABORATO',DataSetAttivo.FieldByName(C018.TabellaIter.Substring(0,4) + 'ELABORATO').AsString,'N');
          RegistraLog.RegistraOperazione;
        end;
        if DelDatiDB then
        begin
          //Log cancella T040 - T100 - M040
          selTabLog.First;
          while Not selTabLog.Eof do
          begin
            RegistraLog.SettaProprieta('C',C018.TabellaDB.NomeTabella,'A176',selTabLog,True);
            RegistraLog.RegistraOperazione;
            selTabLog.Next;
          end;
        end;
      end;
      SessioneOracle.Commit;
    end;
  finally
    if selTabLog <> nil then
    begin
      FreeAndNil(selTabLog);
    end;
  end;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.selVSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('MODELLI DI CERTIFICAZIONE',DataSet.FieldByName('SG230COD_MODELLO').AsString);
end;

procedure TA176FRiepilogoIterAutorizzativiMW.selVT960T960DIMENSIONEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=R180GetFileSizeStr(Sender.AsLargeInt);
end;

function TA176FRiepilogoIterAutorizzativiMW.ForzaRichiesta(const Livello:Integer; const Stato:Boolean):string;
begin
  Result:='';
  try
    C018.ForzaRichiesta(Livello, Stato);
  except
    on e:exception do
    begin
      Result:=e.Message;
      SessioneOracle.Rollback;
    end;
  end;
end;

function TA176FRiepilogoIterAutorizzativiMW.CambiaStruttura(StrutturaOld,StrutturaNew:String):String;
begin
  Result:='';
  try
    if StrutturaOld = StrutturaNew then
      raise Exception.Create('Indicare una struttura diversa');
    if StrutturaNew = '' then
      raise Exception.Create('Struttura non specificata');
    C018.AssegnaCodIter(C018.Id,C018.Iter,StrutturaNew);
    C018.CodIter:=StrutturaNew;
    RegistraLog.SettaProprieta('M','T850_ITER_RICHIESTE','A176',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
    RegistraLog.InserisciDato('ID',C018.Id.ToString,'');
    RegistraLog.InserisciDato('ITER',C018.Iter,'');
    RegistraLog.InserisciDato('COD_ITER',StrutturaOld,StrutturaNew);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
  except
    on e:exception do
    begin
      Result:=e.Message;
      SessioneOracle.Rollback;
    end;
  end;
end;

function TA176FRiepilogoIterAutorizzativiMW.CancellaRichiesta(const DelDatiDB:Boolean):string;
var
  selTabLog:TOracleDataSet;
begin
  if DelDatiDB then
  begin
    selTabLog:=TOracleDataSet.Create(nil);
  end;
  try
    if DelDatiDB then
    begin
      selTabLog.Session:=SessioneOracle;
      selTabLog.SQL.Add('select T.*');
      selTabLog.SQL.Add('  from :TABELLA T');
      selTabLog.SQL.Add(' where :NOME_DATO = :ID');
      selTabLog.DeclareAndSet('TABELLA',otSubst,C018.TabellaDB.NomeTabella);
      selTabLog.DeclareAndSet('NOME_DATO',otSubst,C018.TabellaDB.NomeDatoID);
      selTabLog.DeclareAndSet('ID',otInteger,C018.ID);
      selTabLog.Open;
    end;

    with T850P_MAIL_ANNULLAMENTO do
    try
      SetVariable('ID',C018.ID);
      SetVariable('OPERAZIONE','C');
      Execute;
    except
    end;
    // elimina fisicamente la richiesta dal db ed eventualmente i dati su cartellino
    Result:=C018.CancellaRichiesta(DelDatiDB);

    // se Result è vuoto significa che l'operazione è andata a buon fine
    if Result.IsEmpty then
    begin
      //Log cancellazioni T851
      C018.selT851.First;
      while not C018.selT851.Eof do
      begin
        RegistraLog.SettaProprieta('C','T851_ITER_AUTORIZZAZIONI','A176',C018.selT851,True);
        RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
        RegistraLog.InserisciDato('ID',C018.ID.ToString,'');
        RegistraLog.RegistraOperazione;
        C018.selT851.Next;
      end;
      RegistraLog.SettaProprieta('C','T850_ITER_RICHIESTE','A176',nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
      RegistraLog.InserisciDato('ID',C018.Id.ToString,'');
      RegistraLog.RegistraOperazione;
      if DelDatiDB and R180In(C018.Iter,[ITER_GIUSTIF,ITER_TIMBR,ITER_MISSIONI]) then
      begin
        //Log cancellazione  T050 - T105
        RegistraLog.SettaProprieta('C',C018.TabellaIter,'A176',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
        RegistraLog.InserisciDato('ID',C018.Id.ToString,'');
        RegistraLog.RegistraOperazione;
        if DelDatiDB then
        begin
          //Log cancellazione T040 - T100 - M040
          selTabLog.First;
          while Not selTabLog.Eof do
          begin
            RegistraLog.SettaProprieta('C',C018.TabellaDB.NomeTabella,'A176',selTabLog,True);
            RegistraLog.RegistraOperazione;
            selTabLog.Next;
          end;
        end;
      end;
      SessioneOracle.Commit;
    end;
  finally
    if DelDatiDB then
    begin
      FreeAndNil(selTabLog);
    end;
  end;
end;

function TA176FRiepilogoIterAutorizzativiMW.IterDescToCod(Descrizione:string):string;
var
  i:integer;
begin
  //Input codice iter -> output descrizione iter
  Result:='';
  i:=Low(A000IterAutorizzativi);
  while (A000IterAutorizzativi[i].Desc <> Descrizione) and
        (i <= High(A000IterAutorizzativi)) do
  begin
    inc(i);
  end;
  if A000IterAutorizzativi[i].Desc = Descrizione then
  begin
    Result:=A000IterAutorizzativi[i].Cod;
  end;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetAllegatoExist(Val:string);
begin
  pAllegatoExist:=Val.ToLower.Trim;
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetCondizAllegato(Val:string);
begin
  pCondizAllegato:=Val.ToLower.Trim;
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.CreaFiltro;
var
  CondizioneSQL:string;
begin
  //Costruzione del filtro
  //progressivo
  //data
  //periodo richiesto
  //causale
  //Test esistenza allegato
  //Test Condizione allegato
  FiltroSQL:='';
  FiltroSQL:=Format('and PROGRESSIVO = %d',[progressivo]) + CRLF;
  FiltroSQL:=FiltroSQL + Format(' and trunc(T850DATA) between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[pDataRichDa.ToString, pDataRichA.ToString]) + CRLF;
  if not R180In(C018.Iter, [ITER_RENDI_PROJ]) and Assigned(C018.Periodo) then
    FiltroSQL:=FiltroSQL + Format(' and  greatest(to_date(''%s'',''dd/mm/yyyy''), trunc(%s)) <= least(to_date(''%s'',''dd/mm/yyyy''), trunc(%s))',
    [pPeriodoRichDa.ToString, stringreplace(C018.GetColonnaVistaPeriodoInizio, 'T_ITER.', C018.Iter, [rfReplaceAll, rfIgnoreCase]),
     pPeriodoRichA.ToString, stringreplace(C018.GetColonnaVistaPeriodoFine, 'T_ITER.', C018.Iter, [rfReplaceAll, rfIgnoreCase])]) + CRLF;

  if (C018.Iter = ITER_GIUSTIF) and (pCausale <> '') then
    FiltroSQL:=FiltroSQL + Format(' and T050CAUSALE = ''%s''',[pCausale]);

  //Filtro se esite allegato
  if not AllegatoExist.IsEmpty and (AllegatoExist <> 'tutti') then
  begin
    CondizioneSQL:='';
    if AllegatoExist = 'con allegato' then
    begin
      CondizioneSQL:='>';
    end
    else if AllegatoExist = 'senza allegato' then
    begin
      CondizioneSQL:='=';
    end;
    FiltroSQL:=FiltroSQL + Format('and T853F_NUMALLEGATI(T850ID) %s 0',[CondizioneSQL]) + CRLF;
  end;
  //Filtro su condizione allegato
  if not pCondizAllegato.IsEmpty and (pCondizAllegato <> 'tutti') then
  begin
    CondizioneSQL:='';
    if pCondizAllegato = 'allegati non previsti' then
    begin
      CondizioneSQL:='N';
    end
    else if pCondizAllegato = 'allegati facoltativi' then
    begin
      CondizioneSQL:='F';
    end
    else if pCondizAllegato = 'allegati obbligatori' then
    begin
      CondizioneSQL:='O';
    end;
    FiltroSQL:=FiltroSQL + Format('and nvl(T850CONDIZ_ALLEGATI,''N'') = ''%s''',[CondizioneSQL]) + CRLF;
  end;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.OpenDataSetAttivo;
begin
  //Imposto il filtro e apro il dataset
  DataSetAttivo.SetVariable('FILTRO',FiltroSQL);
  DataSetAttivo.Open;
  DataSetAttivo.Refresh;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetC018selT851;
begin
  //Apro DataSet C018.selT851
  //Prendo i record con il livello > 0
  C018.LeggiIterCompleto;
  C018.selT851.Filtered:=False;
  C018.selT851.Filter:='(LIVELLO > 0)';
  C018.selT851.Filtered:=True;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetCausale(Val: string);
begin
  pCausale:=Val.ToUpper.Trim;
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  StringListLivello:=TStringList.Create;
  pProgressivo:=-1;
  pDataRichDa:=R180InizioMese(Parametri.DataLavoro).AddMonths(-1);
  pDataRichA:=R180FineMese(Parametri.DataLavoro);
  pPeriodoRichDa:=pDataRichDa;
  pPeriodoRichA:=pDataRichA;

  selT265T275.SetVariable('CAUPRESENZE', IfThen(Parametri.CampiRiferimento.C90_W010CausPres = 'S','1','0'));
  selT265T275.Open;

  C018:=TC018FIterAutDM.Create(Self);
  C018.Chiamante:='A176';
  C018.Responsabile:=False;
  //Assegnazione dataset struttura IterAutorizzativi C018.selT851
  dsrT851DettIter.DataSet:=C018.selT851;
  ///C018.AccessoReadOnly:=True;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(C018);
  FreeAndNil(StringListLivello);
  inherited;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetDataRichDa(inData:TDateTime);
begin
  pDataRichDa:=Trunc(inData);
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetDataRichA(inData:TDateTime);
begin
  pDataRichA:=Trunc(inData);
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetPeriodoRichA(inData: TDateTime);
begin
  pPeriodoRichA:=Trunc(inData);
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetPeriodoRichDa(inData: TDateTime);
begin
  pPeriodoRichDa:=Trunc(inData);
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetProgressivo(inProgr:integer);
begin
  pProgressivo:=inProgr;
  CreaFiltro;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetIDIter(inIter,inCodIter:String; inID:integer);
begin
  C018.Iter:=inIter;
  C018.IterCodForm:=CodForm;
  C018.CodIter:=inCodIter;
  C018.ID:=inID;
  R180SetVariable(selI095,'AZIENDA',Parametri.Azienda);
  R180SetVariable(selI095,'ITER',inIter);
  selI095.Open;
end;

procedure TA176FRiepilogoIterAutorizzativiMW.SetTipoEstrazione(Tipo:string);
begin
  //Valorizzo DataSetAttivo sulla base del tipo ITER
  if DataSetAttivo <> nil then
  begin
    DataSetAttivo.Close;
  end;
  if Tipo = ITER_GIUSTIF then
  begin
    DataSetAttivo:=selVT050;
  end
  else if Tipo = ITER_TIMBR then
  begin
    DataSetAttivo:=selVT105;
  end
  else if Tipo = ITER_MISSIONI then
  begin
    DataSetAttivo:=selVM140;
  end
  else if Tipo = ITER_STRMESE then
  begin
    DataSetAttivo:=selVT065;
  end
  else if Tipo = ITER_STRGIORNO then
  begin
    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      DataSetAttivo:=selVT325_EU;
    end
    else
    begin
      DataSetAttivo:=selVT325;
    end;
  end
  else if Tipo = ITER_ORARIGG then
  begin
    DataSetAttivo:=selVT085;
  end
  else if Tipo = ITER_CARTELLINO then
  begin
    DataSetAttivo:=selVT860;
  end
  else if Tipo = ITER_SCIOPERI then
  begin
    DataSetAttivo:=selVT251;
  end
  else if Tipo = ITER_RENDI_PROJ then
  begin
    DataSetAttivo:=selVT755;
  end;
  C018.Iter:=Tipo;
  DataSetAttivo.ReadOnly:=True;
  CreaFiltro;
  pTipoEstrazioneIter:=Tipo;
end;

end.

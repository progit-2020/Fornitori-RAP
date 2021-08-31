unit A006UModelliOrarioMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, C180FunzioniGenerali,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi;

type
  TA006AfterOpen = procedure of object;
  TA006GetFieldValue = function(Field: String):String of object;
  TA006GetCmbValue = function:String of object;
  TA006Boolean = function:Boolean of object;

  TTipoOrario = (toA,toB,toC,toD,toE,toF,toNull);
  TPeriodoLav = (plC,plS,plEU,plT1,plT2,plSpc,plNull);

  TA006FModelliOrarioMW = class(TR005FDataModuleMW)
    selT021Copia: TOracleDataSet;
    selT020CopiaW: TOracleDataSet;
    selT020CopiaR: TOracleDataSet;
    selT021Control: TOracleDataSet;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selT276: TOracleDataSet;
    dstT276: TDataSource;
    selT275: TOracleDataSet;
    dsrT275: TDataSource;
    selT021STR: TOracleDataSet;
    StringField23: TStringField;
    DateTimeField2: TDateTimeField;
    selT021STRTipo_Fascia: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    dsrT021STR: TDataSource;
    dsrT021PM: TDataSource;
    selT021PM: TOracleDataSet;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    selT021PMTipo_Fascia: TStringField;
    StringField3: TStringField;
    StringField15: TStringField;
    StringField17: TStringField;
    StringField10: TStringField;
    StringField4: TStringField;
    StringField18: TStringField;
    StringField8: TStringField;
    selT021PMMMFLEX: TStringField;
    selT021PN: TOracleDataSet;
    selT021PNROWNUM: TFloatField;
    selT021PNCODICE: TStringField;
    selT021PNDECORRENZA: TDateTimeField;
    selT021PNTIPO_FASCIA: TStringField;
    selT021PNENTRATA: TStringField;
    selT021PNUSCITA: TStringField;
    selT021PNENTRATA_OBB: TStringField;
    selT021PNUSCITA_OBB: TStringField;
    selT021PNSIGLATURNI: TStringField;
    selT021PNNUMTURNO: TIntegerField;
    selT021PNMMFLEX: TStringField;
    selT021PNORETEOTUR: TStringField;
    selT021PNORETEOTUR2: TStringField;
    selT021PNOREMINIME: TStringField;
    selT021PNMMANTICIPO: TStringField;
    selT021PNMMANTICIPOU: TStringField;
    selT021PNTOLLERANZA: TStringField;
    selT021PNTOLLERANZAU: TStringField;
    selT021PNARRFLESFASC: TStringField;
    selT021PNARRFLESFASCU: TStringField;
    selT021PNMMRITARDO: TStringField;
    selT021PNMMRITARDOU: TStringField;
    selT021PNMMARROTOND: TStringField;
    selT021PNMMARROTONDU: TStringField;
    selT021PNARRRITARDO: TStringField;
    selT021PNARRUSCANT: TStringField;
    selT021PNSCOST_PUNTI_NOMINALI_E: TStringField;
    selT021PNSCOST_PUNTI_NOMINALI_U: TStringField;
    dsrT021PN: TDataSource;
    selT021STROREMINIME: TStringField;
    selT021PNDISAGIO_SERALE: TStringField;
    procedure selT021AfterOpen(DataSet: TDataSet);
    procedure selT021BeforeInsert(DataSet: TDataSet);
    procedure selT021BeforePost(DataSet: TDataSet);
    procedure selT021ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selT021NewRecord(DataSet: TDataSet);
    procedure selT021PMAfterScroll(DataSet: TDataSet);
    procedure TIPO_FASCIAValidate(Sender: TField);
    procedure ValidateOreMinuti(Sender: TField);
    procedure selT021PNNUMTURNOValidate(Sender: TField);
    procedure selT021PMTipo_FasciaChange(Sender: TField);
    procedure selT275AfterOpen(DataSet: TDataSet);
    procedure selT021STRAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    CodiceOld,CodiceNew:String;
    DecorrenzaOld,DecorrenzaNew:TDateTime;
    procedure CambiaCodiceDecorrenza;
    function GetT020FieldValue(Field: String):String;
  public
    lstT275:TStringList;
    selT020: TOracleDataSet;
    FTipoOrario:TTipoOrario;
    FPeriodoLav:TPeriodoLav;
    evT021AfterOpen: TA006AfterOpen;
    evT020FieldValue: TA006GetFieldValue;
    evGetCmbTipoMensaValue: TA006GetCmbValue;
    evStoricoOttimizzato: TA006Boolean;
    D_PerLav: array [0..5] of TItemsValues;
    procedure SelT020BeforePost;
    procedure SelT020fterScroll;
    procedure SelT020AfterPostStep1;
    procedure SelT020AfterPostStep2;
    procedure SelT020AfterCancel;
    procedure PopolaD_PerLav;
    procedure ResetVariabili;
    procedure PulisciTipoFasciaPMA;
    procedure selT020FilterRecord(DataSet: TDataSet;var Accept: Boolean);
    procedure VisualizzaDatiTimbrature(FrazionamentoDebitoNotturno: Boolean);
    function AggiornaItemsPerLav(Items: TStrings):Integer;
    function SettaTipoOrario(TipoOrario: String):boolean;
    function SettaPeriodoLav(PeriodoLav: String): boolean;
    const
      D_TipoOrario: array[0..4] of TItemsValues = (
        (Item:'A - Flessibile con recupero giorn.';     Value:'A'),
        (Item:'B - Flessibile senza recupero giorn.';   Value:'B'),
        (Item:'C - Elastico';                           Value:'C'),
        (Item:'D - Libero';                             Value:'D'),
        (Item:'E - Turni';                              Value:'E')
        );
      D_Flessibilita: array[0..3] of TItemsValues = (
        (Item:'A - Unica';                  Value:'A'),
        (Item:'B - Con recupero distinto';  Value:'B'),
        (Item:'C - Con recupero pomerid.';  Value:'C'),
        (Item:'D - Con recupero misto';     Value:'D')
        );
      D_PausaMensa: array[0..6] of TItemsValues = (
        (Item:'Z - No pausa mensa';                          Value:'Z'),
        (Item:'A - Timbrature obbligatorie';                 Value:'A'),
        (Item:'B - Facoltativa: recupero in uscita';         Value:'B'),
        (Item:'C - Detrazione automatica totale';            Value:'C'),
        (Item:'D - Detrazione automatica totale';            Value:'D'),
        (Item:'E - Detrazione automatica parziale';          Value:'E'),
        (Item:'F - Detrazione parziale con rientro minimo';  Value:'F')
        );
      D_TipoStraordinario: array[0..3] of TItemsValues = (
        (Item:'Ore migliori oltre il debito';              Value:'1'),
        (Item:'Ore eccedenti oltre il debito';             Value:'2'),
        (Item:'Ore esterne all''orario';                   Value:'3'),
        (Item:'Ore esterne all''orario oltre il debito';   Value:'4')
        );
      D_EccCompCausalizzata: array [0..2] of TItemsValues = (
        (Item:'Nessuna';           Value:'N'),
        (Item:'Oltre la soglia';   Value:'E'),
        (Item:'Causalizzata';      Value:'C')
        );
      D_TipoFasciaStraordinario: array [0..3] of TItemsValues = (
        (Item:'FO';           Value:'FO'),
        (Item:'STR';          Value:'STR'),
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
        (Item:'MGM';          Value:'MGM'),
        (Item:'MGP';          Value:'MGP')
        // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
        );
      D_TipoFasciaPausaMensa: array [0..1] of TItemsValues = (
        (Item:'PMA';           Value:'PMA'),
        (Item:'PMT';           Value:'PMT')
        );
      D_TipoFasciaTimbrature: array [0..0] of TItemsValues = (
        (Item:'PN';           Value:'PN')
        );
  end;

implementation

{$R *.dfm}

procedure TA006FModelliOrarioMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstT275:=TStringList.Create;
  with selT275 do
  begin
    Open;
    while not Eof do
    begin
      lstT275.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  selT276.Open;
  selT265.Open;
end;

procedure TA006FModelliOrarioMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstT275);
end;

function TA006FModelliOrarioMW.GetT020FieldValue(Field: String): String;
begin
  if Assigned(evT020FieldValue) then
    Result:=evT020FieldValue(Field)
  else
    raise Exception.Create(A000MSG_ERR_FUNZ_NON_ASSEGNATA);
end;

procedure TA006FModelliOrarioMW.selT021AfterOpen(DataSet: TDataSet);
begin
  if Assigned(evT021AfterOpen) then
    evT021AfterOpen;
end;

procedure TA006FModelliOrarioMW.selT021ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  //Registrazione dei log di T021
  case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),NomeOwner,Sender,False);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),NomeOwner,Sender,False);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),NomeOwner,Sender,False);
  end;
  // Commento già presente prima dell'introduzione di MW
  //if Action in ['D','U','I'] then
  //  RegistraLog.RegistraOperazione(False);
end;

procedure TA006FModelliOrarioMW.selT021BeforeInsert(DataSet: TDataSet);
{Controllo di non inserire più fasce di quante previste da ogni tipologia}
var MaxFasce:Word;
    CodTipoMensa: String;
begin
  MaxFasce:=0;
  if DataSet = selT021PN then
  begin
    if (FTipoOrario in [toA,toB]) and (FPeriodoLav = plC) then
      MaxFasce:=1;
    if (FTipoOrario in [toA,toB]) and (FPeriodoLav = plS) then
      MaxFasce:=2;
    if (FTipoOrario in [toC]) then
      MaxFasce:=2;
    if (FTipoOrario in [toD]) then
      MaxFasce:=1;
    if (FTipoOrario in [toE]) then
      MaxFasce:=999;
  end;
  if DataSet = selT021PM then
  begin
    CodTipoMensa:=GetT020FieldValue('TipoMensa');
    if (CodTipoMensa = 'A') or (CodTipoMensa = 'B') then
      MaxFasce:=1
    else
      MaxFasce:=2;
  end;
  if DataSet.RecordCount = MaxFasce then
    raise Exception.Create(A000MSG_A006_ERR_TIPO_ORARIO);
end;

procedure TA006FModelliOrarioMW.selT021BeforePost(DataSet: TDataSet);
var
  i:Integer;
  cmbTipoMensaVal: String;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LDurata: Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  //Forzatura uscita per orario libero
  if (DataSet.FieldByName('TIPO_FASCIA').AsString = 'PN') and DataSet.FieldByName('USCITA').IsNull and (GetT020FieldValue('PerLav') = 'L') then
    DataSet.FieldByName('USCITA').AsString:='00.00';
  //Forzatura inizio mensa per PMA se 'Forzata se uscita dopo ora max.'
  if (DataSet.FieldByName('TIPO_FASCIA').AsString = 'PMA') and (GetT020FieldValue('PM_AUTO_URIT') = 'S') then
  begin
    DataSet.FieldByName('ENTRATA').AsString:='00.00';
    DataSet.FieldByName('OREMINIME').Clear;
  end;
  //Pulizia dei campi orari senza valore
  for i:=0 to DataSet.FieldCount - 1 do
    if (Trim(DataSet.Fields[i].AsString) = '.') or (Trim(DataSet.Fields[i].AsString) = '') then
      DataSet.Fields[i].Clear;
  //Controllo Entrate/Uscite
  if (R180OreMinutiExt(DataSet.FieldByName('ENTRATA').AsString) >= R180OreMinutiExt(DataSet.FieldByName('USCITA').AsString)) then
    if (DataSet.FieldByName('TIPO_FASCIA').AsString <> 'STR') or (R180OreMinutiExt(DataSet.FieldByName('USCITA').AsString) > 0) then
      if not((DataSet.FieldByName('TIPO_FASCIA').AsString = 'PN') and ((GetT020FieldValue('PERLAV') = 'T1') or (GetT020FieldValue('PERLAV') = 'L'))) then
        if (DataSet.FieldByName('TIPO_FASCIA').AsString = 'PMA') or (DataSet.FieldByName('TIPO_FASCIA').AsString = 'PMT') then
          raise Exception.Create(A000MSG_A006_ERR_INIZIO_RIENTRO)
        else
          raise Exception.Create(A000MSG_A006_ERR_ENTRATA_USCITA);
  //Controlli sulla fascia obbligatoria
  if (DataSet.FieldByName('TIPO_FASCIA').AsString = 'PN') and
     (GetT020FieldValue('TIPOORA') = 'C') and
     ((not selT021PN.FieldByName('ENTRATA_OBB').IsNull) or (not selT021PN.FieldByName('USCITA_OBB').IsNull)) then
  begin
    if R180OreMinutiExt(DataSet.FieldByName('ENTRATA').AsString) > R180OreMinutiExt(DataSet.FieldByName('ENTRATA_OBB').AsString) then
      raise Exception.Create('L''Entrata non può essere maggiore dell''Entrata obbligatoria!');
    if R180OreMinutiExt(DataSet.FieldByName('USCITA_OBB').AsString) > R180OreMinutiExt(DataSet.FieldByName('USCITA').AsString) then
      raise Exception.Create('L''Uscita obbligatoria non può essere maggiore dell''Uscita!');
    if R180OreMinutiExt(DataSet.FieldByName('USCITA_OBB').AsString) < R180OreMinutiExt(DataSet.FieldByName('ENTRATA_OBB').AsString) then
      raise Exception.Create('L''Entrata obbligatoria non può essere maggiore dell''Uscita obbligatoria!');
  end;
  //Controlli fasce pausa mensa
  if DataSet.FieldByName('TIPO_FASCIA').AsString = 'PMT' then
  begin
    if R180OreMinutiExt(DataSet.FieldByName('ENTRATA').AsString) > R180OreMinutiExt(DataSet.FieldByName('MMRITARDO').AsString) then
      raise Exception.Create('La fascia di Inizio Mensa è errata!');
    if R180OreMinutiExt(DataSet.FieldByName('USCITA').AsString) < R180OreMinutiExt(DataSet.FieldByName('MMANTICIPOU').AsString) then
      raise Exception.Create('La fascia di Rientro Mensa è errata!');
    if R180OreMinutiExt(DataSet.FieldByName('MMRITARDO').AsString) > R180OreMinutiExt(DataSet.FieldByName('USCITA').AsString) then
      raise Exception.Create('La fascia di Inizio Mensa non può superare il Rientro');
    if R180OreMinutiExt(DataSet.FieldByName('ENTRATA').AsString) > R180OreMinutiExt(DataSet.FieldByName('MMANTICIPOU').AsString) then
      raise Exception.Create('La fascia di Rientro Mensa non può essere antecedente all''Inizio');
    cmbTipoMensaVal:=evGetCmbTipoMensaValue;
    if (cmbTipoMensaVal <> 'B') and (cmbTipoMensaVal <> 'D') and (cmbTipoMensaVal <> 'E') and (cmbTipoMensaVal <> 'F') then
      DataSet.FieldByName('MMFLEX').Clear;
    if Trim(DataSet.FieldByName('MMFLEX').AsString) = '.' then
      DataSet.FieldByName('MMFLEX').Clear;
  end;
  if DataSet.FieldByName('TIPO_FASCIA').AsString = 'PMA' then
    DataSet.FieldByName('MMFLEX').Clear;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // avendo abilitato la colonna OREMINIME (Durata), valorizzarla solo per le fasce MGM e MGP:
  // pulire OreMinime se TIPO_FASCIA <> MGM,MGP
  if DataSet = selT021STR then
  begin
    if R180In(DataSet.FieldByName('TIPO_FASCIA').AsString,['MGM','MGP']) then
    begin
      LDurata:=R180OreMinuti(DataSet.FieldByName('USCITA').AsString) - R180OreMinuti(DataSet.FieldByName('ENTRATA').AsString);
      if LDurata < R180OreMinuti(DataSet.FieldByName('OREMINIME').AsString) then
        DataSet.FieldByName('OREMINIME').AsString:=R180MinutiOre(LDurata);
    end
    else
    begin
      DataSet.FieldByName('OREMINIME').Clear;
    end;
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA006FModelliOrarioMW.selT021NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('CODICE').AsString:=GetT020FieldValue('CODICE');
  DataSet.FieldByName('DECORRENZA').AsString:=GetT020FieldValue('DECORRENZA');
  if DataSet = selT021PN then
    DataSet.FieldByName('TIPO_FASCIA').AsString:='PN';
  if DataSet = selT021PM then
    DataSet.FieldByName('TIPO_FASCIA').AsString:='PMT';
  if DataSet = selT021STR then
    DataSet.FieldByName('TIPO_FASCIA').AsString:='STR';
  if (DataSet = selT021PN) and (FTipoOrario = toE) then
    if DataSet.RecordCount < TIntegerField(DataSet.FieldByName('NUMTURNO')).MaxValue then
      DataSet.FieldByName('NUMTURNO').AsInteger:=DataSet.RecordCount + 1
    else
     DataSet.FieldByName('NUMTURNO').AsInteger:=TIntegerField(DataSet.FieldByName('NUMTURNO')).MaxValue;
end;

procedure TA006FModelliOrarioMW.selT021PMAfterScroll(DataSet: TDataSet);
{Impostazione dei dati necessari a seconda del tipo di fascia mensa selezionata}
begin
  with selT021PM do
  begin
    FieldByName('MMRITARDO').ReadOnly:=FieldByName('TIPO_FASCIA').AsString = 'PMA';
    FieldByName('MMANTICIPOU').ReadOnly:=FieldByName('TIPO_FASCIA').AsString = 'PMA';
    FieldByName('MMARROTOND').ReadOnly:=FieldByName('TIPO_FASCIA').AsString = 'PMA';
    FieldByName('MMARROTONDU').ReadOnly:=FieldByName('TIPO_FASCIA').AsString = 'PMA';
    //Commento già presente prima dell'inserimento del Middleware
    (*FieldByName('OREMINIME').ReadOnly:=(FieldByName('TIPO_FASCIA').AsString = 'PMT') or
                                              (selT020.FieldByName('PM_AUTO_URIT').AsString = 'S');*)
    FieldByName('OREMINIME').ReadOnly:=(FieldByName('TIPO_FASCIA').AsString = 'PMA') and
                                                 (GetT020FieldValue('PM_AUTO_URIT') = 'S');
    FieldByName('MMFLEX').ReadOnly:=FieldByName('TIPO_FASCIA').AsString = 'PMA';
  end;
end;

procedure TA006FModelliOrarioMW.selT021PMTipo_FasciaChange(Sender: TField);
begin
  selT021PMAfterScroll(selT021PM);
end;

procedure TA006FModelliOrarioMW.selT021PNNUMTURNOValidate(Sender: TField);
begin
  if (Sender.AsInteger < 0) or (Sender.AsInteger > 4) then
    raise Exception.Create(A000MSG_A006_ERR_NUMERO_TURNO)
end;

procedure TA006FModelliOrarioMW.selT021STRAfterPost(DataSet: TDataSet);
//Norman 03/11/2006: controlla che l'utente non inserisca più di 2 fasce orarie di tipo STR.
begin
  selT021STR.DisableControls;
  try
    // straordinario
    selT021STR.Filter:='TIPO_FASCIA = ''STR''';
    selT021STR.Filtered:=True;
    if selT021STR.RecordCount > 2 then
      raise Exception.Create(A000MSG_A006_ERR_TIPO_ORARIO);

    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // mezza giornata mattino
    selT021STR.Filtered:=False;
    selT021STR.Filter:='TIPO_FASCIA = ''MGM''';
    selT021STR.Filtered:=True;
    if selT021STR.RecordCount > 1 then
      raise Exception.Create(A000MSG_A006_ERR_TIPO_ORARIO);

    // mezza giornata pomeriggio
    selT021STR.Filtered:=False;
    selT021STR.Filter:='TIPO_FASCIA = ''MGP''';
    selT021STR.Filtered:=True;
    if selT021STR.RecordCount > 1 then
      raise Exception.Create(A000MSG_A006_ERR_TIPO_ORARIO);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  finally
    selT021STR.Filtered:=False;
    selT021STR.EnableControls;
  end;
end;

procedure TA006FModelliOrarioMW.selT275AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=7;
end;

procedure TA006FModelliOrarioMW.TIPO_FASCIAValidate(Sender: TField);
begin
  if (Sender = selT021PNTipo_Fascia) then
    if Sender.AsString <> 'PN' then
      raise Exception.Create('I valori ammessi sono ''PN''!');
  if (Sender = selT021PMTipo_Fascia) then
    if (Sender.AsString <> 'PMA') and (Sender.AsString <> 'PMT') then
      raise Exception.Create('I valori ammessi sono ''PMA'',''PMT''!');
  if (Sender = selT021STRTipo_Fascia) then
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    //if (Sender.AsString <> 'STR') and (Sender.AsString <> 'FO') then
    //  raise Exception.Create('I valori ammessi sono ''STR'',''FO''!');
    if (Sender.AsString <> 'STR') and (Sender.AsString <> 'FO') and (Sender.AsString <> 'MGM') and (Sender.AsString <> 'MGP') then
      raise Exception.Create('I valori ammessi sono ''STR'',''FO'',''MGM'',''MGP''!');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TA006FModelliOrarioMW.ValidateOreMinuti(Sender: TField);
begin
  inherited;
  if (Sender.IsNull) or (Trim(Sender.AsString) = '.') or (Trim(Sender.AsString) = '') then exit;
  R180OraValidate(Sender.AsString);
  if (Sender.FieldName = 'ARRFLESFASC') or
     (Sender.FieldName = 'ARRFLESFASCU') or
     (Sender.FieldName = 'MMARROTOND') or
     (Sender.FieldName = 'ARRRITARDO') or
     (Sender.FieldName = 'ARRUSCANT') or
     (Sender.FieldName = 'MMARROTONDU') or
     (Sender.FieldName = 'ARRFUOENT') or
     (Sender.FieldName = 'ARRFUOUSC') or
     (Sender.FieldName = 'ARRPOS') or
     (Sender.FieldName = 'ARRNEG') or
     (Sender.FieldName = 'ARRIVRANG') or
     (Sender.FieldName = 'ARROTGIOR') or
     (Sender.FieldName = 'ARR_ECCED_LIQ') or
     (Sender.FieldName = 'ARR_ECCED_FASCE') then
  begin
    //Alberto 05/09/2012: annullato il controllo
    //if 60 mod R180OreMinutiExt(Sender.AsString) <> 0 then
    //  raise Exception.Create('I minuti devono essere divisori di 60!');
  end;
end;

procedure TA006FModelliOrarioMW.CambiaCodiceDecorrenza;
var i:Integer;
begin
  //Copia di selT020 con nuovo codice/decorrenza
  selT020CopiaR.SetVariable('CODICE',CodiceOld);
  selT020CopiaR.Open;
  selT020CopiaW.SetVariable('CODICE',CodiceNew);
  selT020CopiaW.Open;
  while not selT020CopiaR.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT020CopiaR.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT020CopiaW.Append;
      for i:=0 to selT020CopiaR.FieldCount - 1 do
        selT020CopiaW.Fields[i].Value:=selT020CopiaR.Fields[i].Value;
      if CodiceOld <> CodiceNew then
        selT020CopiaW.FieldByName('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT020CopiaR.FieldByname('DECORRENZA').AsDateTime then
        selT020CopiaW.FieldByName('DECORRENZA').AsDateTime:=DecorrenzaNew;
      selT020CopiaW.Post;
    end;
    selT020CopiaR.Next;
  end;
  //Modifica di selT021
  selT021Copia.SetVariable('CODICE',CodiceOld);
  selT021Copia.Open;
  while not selT021Copia.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT021Copia.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT021Copia.Edit;
      if CodiceOld <> CodiceNew then
        selT021Copia.FieldByname('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT021Copia.FieldByname('DECORRENZA').AsDateTime then
        selT021Copia.FieldByname('DECORRENZA').AsDateTime:=DecorrenzaNew;
     selT021Copia.Post;
    end;
    selT021Copia.Next;
  end;
  //Eliminazione di selT020 originale
  if DecorrenzaOld <> DecorrenzaNew then
    if selT020CopiaR.SearchRecord('DECORRENZA',DecorrenzaOld,[srFromBeginning]) then
      selT020CopiaR.Delete;
  if CodiceOld <> CodiceNew then
  begin
    selT020CopiaR.First;
    while not selT020CopiaR.Eof do
      selT020CopiaR.Delete;
  end;
  selT020CopiaW.CloseAll;
  selT020CopiaR.CloseAll;
  selT021Copia.CloseAll;
  selT020.Refresh;
  if CodiceOld <> CodiceNew then
    selT020.SearchRecord('CODICE',CodiceNew,[srFromBeginning]);
  selT020.SearchRecord('CODICE;DECORRENZA',VarArrayOf([CodiceNew,DecorrenzaNew]),[srFromBeginning]);
end;

procedure TA006FModelliOrarioMW.SelT020BeforePost;
{Controlli complessivi prima della conferma di registrazione}
var
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  LFascia, LUscitaMGM, LEntrataMGP: String;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  procedure VerificaNumFasce(DS:TOracleDataSet; Fascia:String; Min,Max:Word);
  var TF:String;
  begin
    DS.Filter:='TIPO_FASCIA = ''' + Fascia + '''';
    DS.Filtered:=True;
    if Fascia = 'PN' then
      TF:=' di Timbratura (PN)'
    else if Fascia = 'FO' then
      TF:='Obbligatorie (FO)'
    else if Fascia = 'STR' then
      TF:='di Straordinario (STR)'
    else if Fascia = 'PMT' then
      TF:='di Pausa Mensa Timbrata (PMT)'
    else if Fascia = 'PMA' then
      TF:='di Pausa Mensa Automatica (PMA)'
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    else if Fascia = 'MGM' then
      TF:='di Mezza Giornata Mattino (MGM)'
    else if Fascia = 'MGP' then
      TF:='di Mezza Giornata Pomeriggio (MGP)';
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    DS.DisableControls;
    DS.Filter:='TIPO_FASCIA = ''' + Fascia + '''';
    DS.Filtered:=True;
    try
      if DS.RecordCount < Min then
        raise Exception.Create(Format('Le fasce %s non possono essere meno di %d!',[TF,Min]))
      else if DS.RecordCount > Max then
        raise Exception.Create(Format('Le fasce %s non possono essere più di %d!',[TF,Max]))
    finally
      DS.Filtered:=False;
      DS.EnableControls;
    end;
  end;
  procedure AggiornaCodice(DS:TOracleDataSet);
  {Aggiornamento delle fasce se il codice dell'orario viene cambiato con fasce già esistenti(es. in inserimento)}
  var RI:String;
  begin
    if DS.State in [dsEdit,dsInsert] then
      DS.Post;
    DS.DisableControls;
    try
      DS.First;
      while not DS.Eof do
      begin
        RI:=DS.RowId;
        DS.Edit;
        DS.FieldByName('CODICE').AsString:=selT020.FieldByName('CODICE').AsString;
        DS.FieldByName('DECORRENZA').AsDateTime:=selT020.FieldByName('DECORRENZA').AsDateTime;
        DS.Post;
        if not DS.SearchRecord('ROWID',RI,[srFromBeginning]) then
          raise Exception.Create(Format(A000MSG_A006_ERR_FMT_MODIF_CODICE,[DS.Name]));
        DS.Next;
      end;
    finally
      DS.First;
      DS.EnableControls;
    end;
  end;
begin
  try
    if (FTipoOrario in [toA,toB]) and (FPeriodoLav in [plC]) then
      VerificaNumFasce(selT021PN,'PN',1,1);
    if (FTipoOrario in [toA,toB]) and (FPeriodoLav in [plS]) then
      VerificaNumFasce(selT021PN,'PN',2,2);
    if (FTipoOrario in [toC]) then
      VerificaNumFasce(selT021PN,'PN',1,1);
    if (FTipoOrario in [toD]) and (FPeriodoLav in [plSpc]) then
      VerificaNumFasce(selT021PN,'PN',0,1);
    if (FTipoOrario in [toD]) and (FPeriodoLav in [plEU]) then
      VerificaNumFasce(selT021PN,'PN',0,1);
    if (FTipoOrario in [toE]) then
      VerificaNumFasce(selT021PN,'PN',1,999);
    VerificaNumFasce(selT021STR,'STR',0,2);

    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // verifica le fasce di mezza giornata
    //*** su tutti i tipi orario?? filtrare in qualche modo?
    VerificaNumFasce(selT021STR,'MGM',0,1);
    VerificaNumFasce(selT021STR,'MGP',0,1);

    // verificare che il punto di Uscita di MGM sia <= del punto di Entrata di MGP (se esistente)
    LUscitaMGM:='';
    LEntrataMGP:='';
    selT021STR.DisableControls;
    try
      selT021STR.Filter:=Format('(TIPO_FASCIA = ''%s'') OR (TIPO_FASCIA = ''%s'')',['MGM','MGP']);
      selT021STR.Filtered:=True;
      selT021STR.First;
      while not selT021STR.Eof do
      begin
        LFascia:=selT021STR.FieldByName('TIPO_FASCIA').AsString;
        if LFascia = 'MGM' then
          LUscitaMGM:=selT021STR.FieldByName('USCITA').AsString
        else if LFascia = 'MGP' then
          LEntrataMGP:=selT021STR.FieldByName('ENTRATA').AsString;
        selT021STR.Next;
      end;
      if (LUscitaMGM <> '' ) and (LEntrataMGP <> '') then
      begin
        if R180OreMinutiExt(LUscitaMGM) > R180OreMinutiExt(LEntrataMGP) then
          raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A006_ERR_FMT_ORDINE_FASCE_MG),[LUscitaMGM,LEntrataMGP]));
      end;
    finally
      selT021STR.Filtered:=False;
      selT021STR.EnableControls;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

    if selT020.FieldByName('TIPOMENSA').AsString <= 'B' then
      VerificaNumFasce(selT021PM,'PMA',0,0);
    if selT020.FieldByName('TIPOMENSA').AsString < 'Z' then
      VerificaNumFasce(selT021PM,'PMT',1,1);
    if (selT020.FieldByName('TIPOMENSA').AsString >= 'C') and
       (selT020.FieldByName('TIPOMENSA').AsString < 'Z') then
      VerificaNumFasce(selT021PM,'PMA',1,1);
    //Flessibilità forzata per orario flessibile continuato
    if (FTipoOrario = toA) and (FPeriodoLav = plC) and (selT020.FieldByName('TipoFle').AsString <> 'A') then
      selT020.FieldByName('TipoFle').AsString:='A';
    if (FTipoOrario in [toA,toB,toC]) and selT020.FieldByName('TipoFle').IsNull then
       raise Exception.Create('E'' necessario inserire un tipo di flessibilità');
    if (selT020.FieldByName('Matura_RipCom').AsString = 'S') and ((FTipoOrario <> toE) or (selT020.FieldByName('CompFascia').AsString = '3') or (selT020.FieldByName('CompFascia').AsString = '4')) then
       raise Exception.Create('La maturazione dei riposi compensativi è consentita solo con orario E e tipo straordinario da Debito Giornaliero');
    //Limiti per Ricalcolo debito gg
    if selT020.FieldByName('Ricalcolo_Debito_GG').AsString = 'S' then
      if R180OreMinutiExt(selT020.FieldByName('Ricalcolo_Min').AsString) > R180OreMinutiExt(selT020.FieldByName('Ricalcolo_Max').AsString) then
        raise Exception.Create('I limiti del Ricalcolo del debito non sono corretti!');
    //Pausa mensa obbligatoria per Tipo orario Elastico Spezzato
    if (FTipoOrario = toC) and (FPeriodoLav = plS) and (selT020.FieldByName('TipoMensa').AsString <> 'A') then
      raise Exception.Create('con Tipo orario = C e Periodo lavorativo = S, la pausa mensa può solo essere di tipo A');
    //Verifica fasce mensa
    if selT020.FieldByName('TIPOMENSA').AsString <> 'Z' then
    begin
      if (FTipoOrario in [toA,toB]) and (FPeriodoLav = plS) then
        selT020.FieldByName('TIPOMENSA').AsString:='Z';
      if (FTipoOrario = toC) and (FPeriodoLav = plC) then
        if (selT020.FieldByName('TipoMensa').AsString <> 'D') and (selT020.FieldByName('TipoMensa').AsString <> 'E') then
          raise Exception.Create('con Tipo orario = C e Periodo lavorativo = C, la pausa mensa può solo essere di tipo D o E');
      if (FTipoOrario = toD) and (FPeriodoLav = plSpc) then
        if (selT020.FieldByName('TipoMensa').AsString <> 'A') and (selT020.FieldByName('TipoMensa').AsString <> 'C') and (selT020.FieldByName('TipoMensa').AsString <> 'E') then
          raise Exception.Create('con Tipo orario = D e Periodo lavorativo Libero, la pausa mensa può solo essere di tipo A, C o E');
    end;
    //Controllo fascia obbligatoria per orario Elastico
    if (FTipoOrario = toC) and selT021PN.SearchRecord('TIPO_FASCIA','PN',[srFromBeginning]) then
    begin
      if (selT021PN.FieldByName('ENTRATA_OBB').IsNull) or (selT021PN.FieldByName('USCITA_OBB').IsNull) then
        raise Exception.Create('Il tipo orario Elastico richiede la fascia obbligatoria!');
      if R180OreMinutiExt(selT021PN.FieldByName('ENTRATA').AsString) > R180OreMinutiExt(selT021PN.FieldByName('ENTRATA_OBB').AsString) then
        raise Exception.Create('L''Entrata non può essere maggiore dell''Entrata obbligatoria!');
      if R180OreMinutiExt(selT021PN.FieldByName('USCITA_OBB').AsString) > R180OreMinutiExt(selT021PN.FieldByName('USCITA').AsString) then
        raise Exception.Create('L''Uscita obbligatoria non può essere maggiore dell''Uscita!');
      if R180OreMinutiExt(selT021PN.FieldByName('USCITA_OBB').AsString) < R180OreMinutiExt(selT021PN.FieldByName('ENTRATA_OBB').AsString) then
        raise Exception.Create('L''Entrata obbligatoria non può essere maggiore dell''Uscita obbligatoria!');
    end;
    //Controlli sulla fascia di mensa per orario Elastico Spezzato
    if (FTipoOrario = toC) and (FPeriodoLav = plS) then
    begin
      selT021PM.SearchRecord('TIPO_FASCIA','PMT',[srFromBeginning]);
      selT021PN.SearchRecord('TIPO_FASCIA','PN',[srFromBeginning]);
      if selT021PN.FieldByName('ENTRATA').AsString > selT021PM.FieldByName('ENTRATA').AsString then
        raise Exception.Create('L''ora di inizio mensa deve essere maggiore della prima entrata!');
      selT021PN.SearchRecord('TIPO_FASCIA','PN',[]);
      if selT021PN.FieldByName('USCITA').AsString < selT021PM.FieldByName('USCITA').AsString then
        raise Exception.Create('L''ora di rientro mensa deve essere minore dell''ultima uscita!');
    end;
    //Controlli pausa mensa automatica
    if selT021PM.SearchRecord('TIPO_FASCIA','PMA',[srFromBeginning]) then
      if selT020.FieldByName('PM_Auto_URit').AsString = 'S' then
      begin
        selT021PM.Edit;
        selT021PM.FieldByName('ENTRATA').AsString:='00.00';
        selT021PM.FieldByName('OREMINIME').Clear;
        selT021PM.Post;
      end
      else if selT021PM.FieldByName('OREMINIME').IsNull then
        raise Exception.Create('La Pausa Mensa Automatica richiede le ore minime!');
    //Controlli sullo straordinario
    if R180OreMinutiExt(selT020.FieldByname('SCOSTGG_MIN_SOGLIA').AsString) > R180OreMinutiExt(selT020.FieldByname('MINSCOSTR').AsString) then
      raise Exception.Create('La Soglia per eccedenza oltre debito deve essere maggiore o uguale alla Eccedenza minima oltre debito!');
    if (not selT020.FieldByName('MaxGioStr').IsNull) and
       (R180OreMinutiExt(selT020.FieldByName('MaxGioStr').AsString) < R180OreMinutiExt(selT020.FieldByName('MinGioStr').AsString)) then
      raise Exception.Create('Il tempo massimo di straordinario deve essere maggiore o uguale ai minuti minimi!');
  finally
  end;
  //Gestione del cambio codice/decorrenza per salvaguardare la foreign key
  if (selT020.State = dsEdit) and
     ((selT020.FieldByName('CODICE').Value <> selT020.FieldByName('CODICE').medpOldValue) or
      (selT020.FieldByName('DECORRENZA').Value <> selT020.FieldByName('DECORRENZA').medpOldValue)) then
  begin
    CodiceOld:=selT020.FieldByName('CODICE').medpOldValue;
    CodiceNew:=selT020.FieldByName('CODICE').Value;
    DecorrenzaOld:=selT020.FieldByName('DECORRENZA').medpOldValue;
    DecorrenzaNew:=selT020.FieldByName('DECORRENZA').Value;
    selT020.FieldByName('CODICE').Value:=selT020.FieldByName('CODICE').medpOldValue;
    selT020.FieldByName('DECORRENZA').Value:=selT020.FieldByName('DECORRENZA').medpOldValue;
    AggiornaCodice(selT021PN);
    AggiornaCodice(selT021PM);
    AggiornaCodice(selT021STR);
  end;
end;

procedure TA006FModelliOrarioMW.selT020FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA006FModelliOrarioMW.SelT020fterScroll;
begin
  with selT021PN do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selT020.FieldByName('CODICE').AsString);
    SetVariable('DECORRENZA',selT020.FieldByName('DECORRENZA').AsDateTime);
    Open;
    EnableControls;
  end;
  with selT021PM do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selT020.FieldByName('CODICE').AsString);
    SetVariable('DECORRENZA',selT020.FieldByName('DECORRENZA').AsDateTime);
    Open;
    EnableControls;
  end;
  with selT021STR do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',selT020.FieldByName('CODICE').AsString);
    SetVariable('DECORRENZA',selT020.FieldByName('DECORRENZA').AsDateTime);
    Open;
    EnableControls;
  end;
end;

procedure TA006FModelliOrarioMW.SelT020AfterPostStep1;
begin
  //Applicazione delle modifiche di T021
  try
    SessioneOracle.ApplyUpdates([selT021PN,selT021PM,selT021STR],False);
  except
    selT020.Edit;
    raise;
  end;
  if (CodiceOld <> CodiceNew) or (DecorrenzaOld <> DecorrenzaNew) then
    CambiaCodiceDecorrenza;
  A000AggiornaFiltroDizionario('MODELLI ORARIO','',selT020.FieldByName('Codice').AsString);
end;

procedure TA006FModelliOrarioMW.SelT020AfterPostStep2;
var S:String;
begin
  if (CodiceOld <> CodiceNew) or (DecorrenzaOld <> DecorrenzaNew) then
  begin
    RegistraLog.SettaProprieta('M','T020_ORARI',Copy(Self.Name,1,4),nil,True);
    if CodiceOld <> CodiceNew  then
      RegistraLog.InserisciDato('CODICE',CodiceOld,CodiceNew);
    if DecorrenzaOld <> DecorrenzaNew  then
      RegistraLog.InserisciDato('DECORRENZA',DateToStr(DecorrenzaOld),DateToStr(DecorrenzaNew));
    RegistraLog.RegistraOperazione;
  end;
  SessioneOracle.Commit;
  //Refresh della tabella solo se lo storico è stato ottimizzato
  if evStoricoOttimizzato then
  begin
    S:=selT020.FieldByName('Codice').AsString;
    selT020.Refresh;
    selT020.SearchRecord('CODICE',S,[srFromBeginning]);
  end
  else
    SelT020fterScroll;
end;

procedure TA006FModelliOrarioMW.SelT020AfterCancel;
begin
  selT021PN.CancelUpdates;
  selT021PM.CancelUpdates;
  selT021STR.CancelUpdates;
end;

function TA006FModelliOrarioMW.SettaTipoOrario(TipoOrario: String):boolean;
{Setta FTipoOrario a seconda dell'input}
begin
  {Tipo Orario}
  Result:=False;
  if (TipoOrario = 'A') and (FTipoOrario <> toA) then
    begin
    FTipoOrario:=toA;
    Result:=True;
    end;
  if (TipoOrario = 'B') and (FTipoOrario <> toB) then
    begin
    FTipoOrario:=toB;
    Result:=True;
    end;
  if (TipoOrario = 'C') and (FTipoOrario <> toC) then
    begin
    FTipoOrario:=toC;
    Result:=True;
    end;
  if (TipoOrario = 'D') and (FTipoOrario <> toD) then
    begin
    FTipoOrario:=toD;
    Result:=True;
    end;
  if (TipoOrario = 'E') and (FTipoOrario <> toE) then
    begin
    FTipoOrario:=toE;
    Result:=True;
    end;
end;

function TA006FModelliOrarioMW.SettaPeriodoLav(PeriodoLav: String):boolean;
{Setta variabile FPeriodoLav}
begin
  Result:=False;
  if (PeriodoLav = 'C') and (FPeriodoLav <> plC) then
    begin
    FPeriodoLav:=plC;
    Result:=True;
    end;
  if (PeriodoLav = 'S') and (FPeriodoLav <> plS) then
    begin
    FPeriodoLav:=plS;
    Result:=True;
    end;
  if (PeriodoLav = 'EU') and (FPeriodoLav <> plEU) then
    begin
    FPeriodoLav:=plEU;
    Result:=True;
    end;
  if (PeriodoLav = 'L') and (FPeriodoLav <> plSpc) then
    begin
    FPeriodoLav:=plSpc;
    Result:=True;
    end;
  if (PeriodoLav = 'T1') and (FPeriodoLav <> plT1) then
    begin
    FPeriodoLav:=plT1;
    Result:=True;
    end;
  if (PeriodoLav = 'T2') and (FPeriodoLav <> plT2) then
    begin
    FPeriodoLav:=plT2;
    Result:=True;
    end;
end;

procedure TA006FModelliOrarioMW.VisualizzaDatiTimbrature(FrazionamentoDebitoNotturno: Boolean);
begin
  //Visualizzazione dati timbrature
  selT021PNROWNUM.Visible:=FTipoOrario in [toE];
  selT021PNORETEOTUR.Visible:=FTipoOrario in [toE];
  selT021PNORETEOTUR2.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]) and (FrazionamentoDebitoNotturno);
  selT021PNSIGLATURNI.Visible:=FTipoOrario in [toE];
  selT021PNMMFLEX.Visible:= FTipoOrario in [toA,toE];
  {Entrate}
  selT021PNTOLLERANZA.Visible:=FTipoOrario in [toA,toB,toE];
  selT021PNARRFLESFASC.Visible:=FTipoOrario in [toA,toC];
  if  FTipoOrario in [toD] then
  begin
    selT021PNMMRITARDO.Visible:=FPeriodoLav in [plSpc];
    selT021PNMMARROTOND.Visible:=FPeriodoLav in [plSpc];
  end
  else
  begin
    selT021PNMMRITARDO.Visible:=FTipoOrario in [toB,toC,toE];
    selT021PNMMARROTOND.Visible:=FTipoOrario in [toB,toC,toE];
  end;
  selT021PNARRRITARDO.Visible:=FTipoOrario in [toA,toB,toE];
  {Uscite}
  selT021PNUSCITA.Visible:=not((FTipoOrario in [toD]) and (FPeriodoLav in [plSpc]));
  selT021PNUSCITA_OBB.Visible:=FTipoOrario in [toC];
  selT021PNENTRATA_OBB.Visible:=FTipoOrario in [toC];
  selT021PNARRUSCANT.Visible:=FTipoOrario in [toA,toB,toE];
  selT021PNMMANTICIPOU.Visible:=FTipoOrario in [toB,toC,toE];
  selT021PNMMARROTONDU.Visible:=FTipoOrario in [toB,toC,toE];
  selT021PNTOLLERANZAU.Visible:=FTipoOrario in [toA,toB];
  selT021PNARRFLESFASCU.Visible:=FTipoOrario in [toA,toC];
  if  FTipoOrario in [toD] then
    selT021PNMMRITARDOU.Visible:=FPeriodoLav in [plEU]
  else
    selT021PNMMRITARDOU.Visible:=FTipoOrario in [toA,toB,toC,toE];
end;

procedure TA006FModelliOrarioMW.PulisciTipoFasciaPMA;
begin
  with selT021PM do
    if SearchRecord('TIPO_FASCIA','PMA',[srFromBeginning]) then
    begin
      Edit;
      FieldByName('ENTRATA').AsString:='00.00';
      FieldByName('OREMINIME').Clear;
      Post;
    end;
end;

procedure TA006FModelliOrarioMW.PopolaD_PerLav;
begin
  D_PerLav[0].Value:='C';
  D_PerLav[1].Value:='S';
  D_PerLav[2].Value:='L';
  D_PerLav[3].Value:='EU';
  D_PerLav[4].Value:='T1';
  D_PerLav[5].Value:='T2';

  D_PerLav[0].Item:='C - Continuato';
  D_PerLav[1].Item:='S - Spezzato';
  D_PerLav[2].Item:='Libero';
  D_PerLav[3].Item:='EU - Libero con uscita';
  D_PerLav[4].Item:='T1 - Turni con cavallo mezzanotte';
  D_PerLav[5].Item:='T2 - Turni senza cavallo mezzanotte';
end;

function TA006FModelliOrarioMW.AggiornaItemsPerLav(Items: TStrings):Integer;
var i:Integer;
begin
    Result:=-3;
    with Items do
      if SelT020.State in [dsEdit,dsInsert] then
      begin  {Inserisco solo i Periodi di quel tipo orario}
        Clear;
        for i := 0 to High(D_PerLav) do
        begin
          D_PerLav[i].Item:='';
          D_PerLav[i].Value:='';
        end;

        case FTipoOrario of
          toA,toB,toC:begin
            Add('C');
            Add('S');
            D_PerLav[0].Value:='C';
            D_PerLav[0].Item:='C - Continuato';
            D_PerLav[1].Value:='S';
            D_PerLav[1].Item:='S - Spezzato';
            end;
          toD:begin
            Add('L');
            Add('EU');
            D_PerLav[0].Value:='L';
            D_PerLav[0].Item:='Libero';
            D_PerLav[1].Value:='EU';
            D_PerLav[1].Item:='EU - Libero con uscita';
            end;
          toE:begin
            Add('T1');
            Add('T2');
            D_PerLav[0].Value:='T1';
            D_PerLav[0].Item:='T1 - Turni con cavallo mezzanotte';
            D_PerLav[1].Value:='T2';
            D_PerLav[1].Item:='T2 - Turni senza cavallo mezzanotte';
            end;
        end;
      end
      else
      begin {Inserisco tutti i Periodi Lavorativi}
        Clear;
        Add('C');
        Add('S');
        Add('L');
        Add('EU');
        Add('T1');
        Add('T2');
        D_PerLav[0].Value:='C';
        D_PerLav[1].Value:='S';
        D_PerLav[2].Value:='L';
        D_PerLav[3].Value:='EU';
        D_PerLav[4].Value:='T1';
        D_PerLav[5].Value:='T2';

        D_PerLav[0].Item:='C - Continuato';
        D_PerLav[1].Item:='S - Spezzato';
        D_PerLav[2].Item:='Libero';
        D_PerLav[3].Item:='EU - Libero con uscita';
        D_PerLav[4].Item:='T1 - Turni con cavallo mezzanotte';
        D_PerLav[5].Item:='T2 - Turni senza cavallo mezzanotte';
        Result:=Items.IndexOf(selT020.FieldByName('PerLav').AsString);
      end;
end;

procedure TA006FModelliOrarioMW.ResetVariabili;
begin
  CodiceOld:='';
  CodiceNew:='';
  DecorrenzaOld:=0;
  DecorrenzaNew:=0;
end;

end.

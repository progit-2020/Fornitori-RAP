unit A131UGestioneAnticipiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000UInterfaccia, C180FunzioniGenerali, A000UMessaggi, Variants, Oracle;

type
  TAnticipiKey = record
    AntId  :String;
    Prog   :integer;
    Cassa  :String;
    Anno   :String;
    Numero :Integer;
    CodiceV:String;
    DataMis:TDate;
    Importo:Real;
    ItaEst:String;
    NSosp:Integer;
  end;

  TA131FGestioneAnticipiMW = class(TR005FDataModuleMW)
    selTAnticipi: TOracleDataSet;
    selTAnticipiCODICE: TStringField;
    selTAnticipiDESCRIZIONE: TStringField;
    dscTAnticipi: TDataSource;
    selM040: TOracleDataSet;
    selM040IDMISSIONI: TStringField;
    selM040PROTOCOLLO: TStringField;
    selM040DATADA: TDateTimeField;
    selM040MESESCARICO: TDateTimeField;
    selM040MESECOMPETENZA: TDateTimeField;
    selM040ORADA: TStringField;
    selM040PROGRESSIVO: TFloatField;
    selM040TIPOREGISTRAZIONE: TStringField;
    selM040DATAA: TDateTimeField;
    selM040ORAA: TStringField;
    selM040TOTALEGG: TFloatField;
    selM040DURATA: TStringField;
    selM040TARIFFAINDINTERA: TFloatField;
    selM040OREINDINTERA: TFloatField;
    selM040IMPORTOINDINTERA: TFloatField;
    selM040TARIFFAINDRIDOTTAH: TFloatField;
    selM040OREINDRIDOTTAH: TFloatField;
    selM040IMPORTOINDRIDOTTAH: TFloatField;
    selM040TARIFFAINDRIDOTTAG: TFloatField;
    selM040OREINDRIDOTTAG: TFloatField;
    selM040IMPORTOINDRIDOTTAG: TFloatField;
    selM040TARIFFAINDRIDOTTAHG: TFloatField;
    selM040OREINDRIDOTTAHG: TFloatField;
    selM040IMPORTOINDRIDOTTAHG: TFloatField;
    selM040FLAG_MODIFICATO: TStringField;
    selM040PARTENZA: TStringField;
    selM040DESTINAZIONE: TStringField;
    selM040NOTE_RIMBORSI: TStringField;
    selM040COMMESSA: TStringField;
    selM040STATO: TStringField;
    selM040ID_MISSIONE: TIntegerField;
    SelM050: TOracleDataSet;
    SelM050DATADA: TDateTimeField;
    SelM050CODICERIMBORSOSPESE: TStringField;
    SelM050DESCRIZIONE: TStringField;
    SelM050PROTOCOLLO: TStringField;
    SelM050IMPORTORIMBORSOSPESE: TFloatField;
    dscM050: TDataSource;
    groupM060: TOracleDataSet;
    groupM060CASSA: TStringField;
    groupM060ANNO_MOVIMENTO: TStringField;
    groupM060NUMERO_SPESO: TFloatField;
    groupM060NUMERO_MOVIMENTO: TFloatField;
    groupM060D_STATO: TStringField;
    groupM060IMPORTO: TFloatField;
    groupM060STATO: TStringField;
    sel2M060: TOracleDataSet;
    sel2M060DATAMISSIONE: TDateTimeField;
    sel2M060CASSA: TStringField;
    sel2M060ANNOMOVIMENTO: TStringField;
    sel2M060COD_VOCE: TStringField;
    sel2M060NUM_MOVIMENTO: TFloatField;
    sel2M060PROGRESSIVO: TFloatField;
    sel2M060IMPORTO: TFloatField;
    sel2M060DATA_MOVIMENTO: TDateTimeField;
    sel2M060QUANTITA: TFloatField;
    sel2M060FLAG_TOTALIZZATORE: TStringField;
    sel2M060STATO: TStringField;
    sel2M060DATA_IMPOSTAZIONE_STATO: TDateTimeField;
    sel2M060NOTE: TStringField;
    sel2M060ITA_EST: TStringField;
    sel2M060NROSOSP: TFloatField;
    SerchM050: TOracleDataSet;
    InsM050: TOracleQuery;
    selMaxM060: TOracleQuery;
    selM010: TOracleDataSet;
    SelM020: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure groupM060CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSelM060_Funzioni: TOracleDataset;
    function AnticipiGestibili: String;
  public
    AntArray:array of TAnticipiKey;
    procedure ImpostaProgressivo;
    procedure selM060NewRecord;
    procedure selM060AfterPost;
    procedure selM060AfterScroll;
    procedure selM060AfterDelete;
    function selM060BeforePost: String;
    procedure CaricaAnticipi;
    function GetIndexAntArray(IndVet: String): Integer;
    procedure SommaRimborsi(IndexAntArray: Integer);
    function FormatDescAnticipo(i: Integer): String;
    function FormatDescAnticipoCompleto(i: Integer): String;
    procedure CreaNumMovimento;
    function CollegaMissioni(LstAnticipiSelezionati: TStringList): TStringList;
    property SelM060_Funzioni: TOracleDataset read FSelM060_Funzioni write FSelM060_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA131FGestioneAnticipiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selTAnticipi.Open;
end;

procedure TA131FGestioneAnticipiMW.selM060AfterDelete;
begin
  //=========================
  //REFRESH DATASET COLLEGATI
  //=========================
  sel2M060.Refresh;
  groupM060.Refresh;
end;

procedure TA131FGestioneAnticipiMW.selM060NewRecord;
begin
  FSelM060_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  FSelM060_Funzioni.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
end;

function TA131FGestioneAnticipiMW.selM060BeforePost: String;
var descStato: String;
begin
  Result:='';
  if FSelM060_Funzioni.FieldByName('CASSA').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_CASSA]));

  if FSelM060_Funzioni.FieldByName('ANNO_MOVIMENTO').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_ANNO_MOVIMENTO]));

  if FSelM060_Funzioni.FieldByName('NUM_MOVIMENTO').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_NUMERO_MOVIMENTO]));

  if FSelM060_Funzioni.FieldByName('DATA_MOVIMENTO').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_DATA_MOVIMENTO]));

  if FSelM060_Funzioni.FieldByName('DATA_MISSIONE').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_DATA_MISSIONE]));

  if FSelM060_Funzioni.FieldByName('COD_VOCE').IsNull then
    Raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A131_MSG_CODICE_VOCE]));

  if (pos(FSelM060_Funzioni.FieldByName('STATO').AsString, Parametri.A131_AnticipiGestibili) = 0) then
  begin
    if (FSelM060_Funzioni.FieldByName('STATO').AsString = 'S') then
      descStato:='Sospeso'
    else if (FSelM060_Funzioni.FieldByName('STATO').AsString = 'P') then
      descStato:='Protocollato'
    else if (FSelM060_Funzioni.FieldByName('STATO').AsString = 'L') then
      descStato:='Liquidato'
    else
      descStato:='Recuperato';

    Result:=Format(A000MSG_A131_DLG_FMT_STATO,[descStato]);
  end;
end;

procedure TA131FGestioneAnticipiMW.selM060AfterScroll;
begin
  //======================================
  //SCORRIMENTO GRIGLIA RIEPILOGO ANTICIPI
  //======================================
  groupM060.SearchRecord('CASSA;ANNO_MOVIMENTO;NUMERO_MOVIMENTO;STATO',
  VarArrayOf([FSelM060_Funzioni.FieldByName('CASSA').AsVariant,
              FSelM060_Funzioni.FieldByName('ANNO_MOVIMENTO').AsVariant,
              FSelM060_Funzioni.FieldByName('NUM_MOVIMENTO').AsVariant,
              FSelM060_Funzioni.FieldByName('STATO').AsVariant]),
              [srFromBeginning]);
end;

procedure TA131FGestioneAnticipiMW.groupM060CalcFields(DataSet: TDataSet);
begin
  inherited;
  with groupM060 do
  begin
    if FieldByName('STATO').AsString = 'S' then
      FieldByName('D_STATO').AsString:='Sospeso';
    if FieldByName('STATO').AsString = 'P' then
      FieldByName('D_STATO').AsString:='Protocollato';
    if FieldByName('STATO').AsString = 'L' then
      FieldByName('D_STATO').AsString:='Liquidato';
    if FieldByName('STATO').AsString = 'R' then
      FieldByName('D_STATO').AsString:='Recuperato';
  end;
end;

procedure TA131FGestioneAnticipiMW.selM060AfterPost;
begin
  groupM060.Close;
  groupM060.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  groupM060.Open;
  sel2M060.Refresh;
end;

procedure TA131FGestioneAnticipiMW.ImpostaProgressivo;
var Progressivo: Integer;
begin
  //Usa parametro progressivo e non FSelAnagrafe perchè in fase di creazione
  //SelAnagrafe non è ancora presente
  Progressivo:=0;
  if (SelAnagrafe <> nil)  then
    Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  FSelM060_Funzioni.Close;
  FSelM060_Funzioni.SetVariable('Progressivo',Progressivo);
  FSelM060_Funzioni.Open;

  groupM060.Close;
  groupM060.SetVariable('Progressivo',Progressivo);
  groupM060.Open;

  selM040.Close;
  selM040.SetVariable('PROGRESSIVO',Progressivo);
  selM040.Open;

  sel2M060.Close;
  sel2M060.SetVariable('PROGRESSIVO',Progressivo);
  sel2M060.Open;

  SelM050.Close;
  SelM050.SetVariable('PROGRESSIVO',Progressivo);
  SelM050.Open;
end;

procedure TA131FGestioneAnticipiMW.CaricaAnticipi;
var i:Integer;
begin
  if selanagrafe = nil then Exit;
  
  //=======================================================
  //PREDISPONGO UN ARRAY PER TENERE IN MEMORIA GLI ANTICIPI
  //=======================================================
  sel2M060.Close;
  sel2M060.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  sel2M060.Open;

  SetLength(AntArray,0);
  SetLength(AntArray,sel2M060.RecordCount);

  i:=0;
  sel2M060.First;
  while Not(sel2M060.Eof) do
  begin
    AntArray[i].AntId:=IntToStr(i);
    AntArray[i].Prog:=sel2M060.FieldByName('PROGRESSIVO').AsInteger;
    AntArray[i].NSosp:=sel2M060.FieldByName('NROSOSP').AsInteger;
    AntArray[i].Cassa:=sel2M060.FieldByName('CASSA').AsString;
    AntArray[i].Anno:=sel2M060.FieldByName('ANNO_MOVIMENTO').AsString;
    AntArray[i].Numero:=sel2M060.FieldByName('NUM_MOVIMENTO').AsInteger;
    AntArray[i].CodiceV:=sel2M060.FieldByName('COD_VOCE').AsString;
    AntArray[i].DataMis:=sel2M060.FieldByName('DATA_MISSIONE').AsDateTime;
    AntArray[i].Importo:=sel2M060.FieldByName('IMPORTO').AsFloat;
    if sel2M060.FieldByName('ITA_EST').AsString = 'I' then
      AntArray[i].ItaEst:='Italia'
    else
      AntArray[i].ItaEst:='Estero';
    sel2M060.Next;
    inc(i);
  end;
end;

procedure TA131FGestioneAnticipiMW.SommaRimborsi(IndexAntArray:Integer);
var NewImp:Double;
begin
  //=================================================================
  //PRENDO IL VECCHIO VALORE DELL'IMPORTO DALLA TABELLA M050_RIMBORSI
  //E LO SOMMO AL NUOVO IMPORTO
  //=================================================================
  SerchM050.Close;
  SerchM050.SQL.Clear;
  SerchM050.SQL.Add('SELECT IMPORTORIMBORSOSPESE,IMPORTOCOSTORIMBORSO');
  SerchM050.SQL.Add('FROM M050_RIMBORSI');
  SerchM050.SQL.Add('WHERE PROGRESSIVO=' + selM040.FieldByName('PROGRESSIVO').AsString);
  SerchM050.SQL.Add('AND MESESCARICO=TO_DATE(''' + selM040.FieldByName('MESESCARICO').AsString + ''',''DD/MM/YYYY'')');
  SerchM050.SQL.Add('AND MESECOMPETENZA=TO_DATE(''' + selM040.FieldByName('MESECOMPETENZA').AsString + ''',''DD/MM/YYYY'')');
  SerchM050.SQL.Add('AND DATADA=TO_DATE(''' + selM040.FieldByName('DATADA').AsString + ''',''DD/MM/YYYY'')');
  SerchM050.SQL.Add('AND ORADA=''' + selM040.FieldByName('ORADA').AsString + '''');
  SerchM050.SQL.Add('AND CODICERIMBORSOSPESE=''' + AntArray[IndexAntArray].CodiceV + '''');
  try
    SerchM050.Open;
  Except end;

  if SerchM050.RecordCount <= 0 then
    Exit;

  //=========================================================
  //FACCIO L'UPDATE DELLA TABELLA CON LA SOMMA DEI DUE VALORI
  //=========================================================
  InsM050.SQL.Clear;
  InsM050.SQL.Add('UPDATE M050_RIMBORSI');
  NewImp:=SerchM050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat + AntArray[IndexAntArray].Importo;
  InsM050.SQL.Add('SET IMPORTORIMBORSOSPESE=' + StringReplace(FloatToStr(NewImp),',','.',[rfReplaceAll]));
  InsM050.SQL.Add('WHERE PROGRESSIVO=' + selM040.FieldByName('PROGRESSIVO').AsString);
  InsM050.SQL.Add('AND MESESCARICO=TO_DATE(''' + selM040.FieldByName('MESESCARICO').AsString + ''',''DD/MM/YYYY'')');
  InsM050.SQL.Add('AND MESECOMPETENZA=TO_DATE(''' + selM040.FieldByName('MESECOMPETENZA').AsString + ''',''DD/MM/YYYY'')');
  InsM050.SQL.Add('AND DATADA=TO_DATE(''' + selM040.FieldByName('DATADA').AsString + ''',''DD/MM/YYYY'')');
  InsM050.SQL.Add('AND ORADA=''' + selM040.FieldByName('ORADA').AsString + '''');
  InsM050.SQL.Add('AND CODICERIMBORSOSPESE=''' + AntArray[IndexAntArray].CodiceV + '''');
  InsM050.Execute;
end;

function TA131FGestioneAnticipiMW.GetIndexAntArray(IndVet:String):Integer;
var Ret:Integer;
begin
  Ret:=Low(AntArray);
  if Length(AntArray) > 0 then
  begin
    while (Trim(IndVet) <> AntArray[Ret].AntId)
      and (Ret <= High(AntArray)) do
        Inc(Ret);
  end;
  if Ret > High(AntArray) then
    Ret:=99999;
  Result:=Ret;
end;

function TA131FGestioneAnticipiMW.FormatDescAnticipoCompleto(i: Integer) :String;
begin
  Result:=Format('%-5s%-15s%-10s%-10s%-10s%-10s',[AntArray[i].AntId,
                                                  DateToStr(AntArray[i].DataMis),
                                                  IntToStr(AntArray[i].NSosp),
                                                  AntArray[i].CodiceV,
                                                  IntToStr(AntArray[i].Numero),
                                                  AntArray[i].ItaEst])
end;

function TA131FGestioneAnticipiMW.FormatDescAnticipo(i: Integer) :String;
begin
  Result:=Format('%-5s%-15s%-10s%-10s',[AntArray[i].AntId,
                                        DateToStr(AntArray[i].DataMis),
                                        IntToStr(AntArray[i].NSosp),
                                        AntArray[i].CodiceV]);
end;

procedure TA131FGestioneAnticipiMW.CreaNumMovimento;
begin
  if FSelM060_Funzioni.State = dsBrowse then
    Exit;
  if FSelM060_Funzioni.FieldByName('NUM_MOVIMENTO').IsNull then
  begin
    selMaxM060.SetVariable('PROGRESSIVO',FSelM060_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selMaxM060.Execute;
    FSelM060_Funzioni.FieldByName('NUM_MOVIMENTO').AsFloat:=selMaxM060.FieldAsFloat('NUM_MOVIMENTO');
  end;
end;

//==========================================
//FUNZIONE CHE ESTRAE GLI ANTICIPI GESTIBILI
//DALLA REGOLA APPLICATA ALLA MISSIONE
//==========================================
function TA131FGestioneAnticipiMW.AnticipiGestibili:String;
var Ret:String;
begin
  Ret:='';
  if selM040.Active then
  begin
    selM010.Close;
    selM010.SetVariable('TIPOMISS',selM040.FieldByName('TIPOREGISTRAZIONE').AsString);
    selM010.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selM010.SetVariable('DATA',selM040.FieldByName('DATADA').AsDateTime);
    selM010.SetVariable('C8_MISSIONI',Parametri.CampiRiferimento.C8_Missione);
    selM010.Open;
    Ret:=selM010.FieldByName('CODICI_RIMBORSI').AsString;
    selM010.Close;
  end;
  Result:=Ret;
end;

function TA131FGestioneAnticipiMW.CollegaMissioni(LstAnticipiSelezionati: TStringList):TStringList;
var MemValori:array of Variant;
    AusImp:String;
    i,j:Integer;
    Stop:Boolean;
begin
  Result:=TStringList.Create;
  for i:=0 to LstAnticipiSelezionati.Count -1 do
  begin
    Stop:=False;
    j:=GetIndexAntArray(LstAnticipiSelezionati[i]);

    if (j < 0) or (j > 9999) then
    begin
      Result.Add(Format(A000MSG_A131_ERR_FMT_COD_ANT,[LstAnticipiSelezionati[i]]));
      Stop:=True;
      //Caratto 22/11/2013 in questo caso uscita altrimenti range check error
      Exit;
    end;

    MemValori:=VarArrayOf([AntArray[j].Prog,
                           AntArray[j].Cassa,
                           AntArray[j].Anno,
                           AntArray[j].Numero,
                           AntArray[j].CodiceV]);
    FSelM060_Funzioni.Locate('PROGRESSIVO;CASSA;ANNO_MOVIMENTO;NUM_MOVIMENTO;COD_VOCE',MemValori,[]);

    if Length(AnticipiGestibili) > 0 then
    begin
      if pos(FSelM060_Funzioni.FieldByName('COD_VOCE').AsString,AnticipiGestibili) = 0 then
      begin
        Result.Add(Format(A000MSG_A131_ERR_FMT_ANT_REGOLA,[FSelM060_Funzioni.FieldByName('COD_VOCE').AsString]));
        Stop:=True;
      end;
    end;

    //==================
    //CONTROLLO COD VOCE
    //==================
    SelM020.SetVariable('COD_VOCE',FSelM060_Funzioni.FieldByName('COD_VOCE').AsString);
    SelM020.Open;
    if SelM020.RecordCount <= 0 then
    begin
      Result.Add(Format(A000MSG_A131_ERR_FMT_ANT_RIMB,[FSelM060_Funzioni.FieldByName('COD_VOCE').AsString]));
      Stop:=True;
    end;
    SelM020.First;
    if SelM020.FieldByName('FLAG_ANTICIPO').AsString = 'N' then
    begin
      Result.Add(Format(A000MSG_A131_ERR_FMT_ANT_NO_ANT,[FSelM060_Funzioni.FieldByName('COD_VOCE').AsString]));
      Stop:=True;
    end;

    //====================
    //INSERT M050_RIMBORSI
    //====================
    if Not(Stop) then
    begin
      SessioneOracle.Commit;
      InsM050.SQL.Clear;
      InsM050.SQL.Add('INSERT INTO M050_RIMBORSI(');
      InsM050.SQL.Add('PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE, IMPORTORIMBORSOSPESE) ');
      InsM050.SQL.Add('VALUES(' + selM040.FieldByName('PROGRESSIVO').AsString + ', ');
      InsM050.SQL.Add('TO_DATE(''' + selM040.FieldByName('MESESCARICO').AsString + ''',''DD/MM/YYYY''), ');
      InsM050.SQL.Add('TO_DATE(''' + selM040.FieldByName('MESECOMPETENZA').AsString + ''',''DD/MM/YYYY''), ');
      InsM050.SQL.Add('TO_DATE(''' + selM040.FieldByName('DATADA').AsString + ''',''DD/MM/YYYY''), ');
      InsM050.SQL.Add('''' + selM040.FieldByName('ORADA').AsString + ''', ');
      InsM050.SQL.Add('''' + AntArray[j].CodiceV + ''', ');
      AusImp:='0';
      if AntArray[j].Importo <> 0 then
        AusImp:=StringReplace(FloatToStr(AntArray[j].Importo), ',','.',[rfReplaceAll]);
      InsM050.SQL.Add(AusImp + ')');
      try
        InsM050.Execute;
      except
        SommaRimborsi(j);
        Result.Add(Format(A000MSG_A131_ERR_FMT_RIMB_GIA_SOMMA,[AntArray[j].CodiceV]));
      end;
      FselM060_Funzioni.Edit;
      FselM060_Funzioni.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
      FselM060_Funzioni.FieldByName('STATO').AsString:='P';
      FselM060_Funzioni.FieldByName('ID_MISSIONE').AsInteger:=selM040.FieldByName('ID_MISSIONE').AsInteger;
      FselM060_Funzioni.Post;
    end;

    sel2M060.Refresh;
    FselM060_Funzioni.Refresh;
    selM050.Refresh;
  end;
  SessioneOracle.Commit;
end;

procedure TA131FGestioneAnticipiMW.DataModuleDestroy(Sender: TObject);
begin
  SetLength(AntArray,0);
  inherited;
end;

end.

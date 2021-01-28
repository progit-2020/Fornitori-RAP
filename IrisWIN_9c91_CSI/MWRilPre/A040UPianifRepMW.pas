unit A040UPianifRepMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, checklst,
  Dialogs, OracleData, DB, DBClient, Oracle, StrUtils, R005UDataModuleMW,
  A000UMessaggi, A000USessione, A000UInterfaccia, C180FunzioniGenerali, DatiBloccati;

type
  T040Dlg = procedure(msg,Chiave:String) of object;
  T040DlgInt = function(msg:String):Integer of object;
  T040DlgFunc = function(msg:String):Boolean of object;
  T040KeyCtrl = function(Chiave:String):Boolean of object;

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  TA040FPianifRepMW = class(TR005FDataModuleMW)
    D350: TDataSource;
    Q350: TOracleDataSet;
    Q350CODICE: TStringField;
    Q350DESCRIZIONE: TStringField;
    Q350ORAINIZIO: TDateTimeField;
    Q350ORAFINE: TDateTimeField;
    Q350TIPOORE: TStringField;
    Q350ORENORMALI: TDateTimeField;
    Q350ORECOMPRESENZA: TDateTimeField;
    Q350TIPOTURNO: TStringField;
    Q350RAGGRUPPAMENTO: TStringField;
    Q350PIANIF_MAX_MESE: TIntegerField;
    Q350PIANIF_MAX_MESE_TURNI_INTERI: TStringField;
    Q350ORE_MIN_INDENNITA: TStringField;
    Q350TURNO_INTERO: TStringField;
    Q350BLOCCA_MAX_MESE: TStringField;
    Q350Opposto: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField3: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    StringField4: TStringField;
    StringField5: TStringField;
    Q270: TOracleDataSet;
    QControllo: TOracleDataSet;
    Q040: TOracleDataSet;
    Q430Contratto: TOracleDataSet;
    selT380a: TOracleDataSet;
    dsrDatoLibero: TDataSource;
    selDatoLibero: TOracleDataSet;
    cdsParametri: TClientDataSet;
    cdsParametriTurno1: TStringField;
    cdsParametriTurno2: TStringField;
    cdsParametriTurno3: TStringField;
    dsrParametri: TDataSource;
    insT380: TOracleQuery;
    delT380: TOracleQuery;
    selT385: TOracleDataSet;
    selSumTurniAtt: TOracleQuery;
    selT380SumTurniMese: TOracleQuery;
    cdsParametriDatoLibero: TStringField;
    selT381: TOracleDataSet;
    selT380b: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet:TDataSet;var Accept:Boolean);
  private
  public
    selT380:TOracleDataSet;
    CodTipologia,sTipo,Filtro,Dipendente,TestoAnomalia:String;
    ProceduraChiamante:Integer;
    Turno1Value,Turno2Value,Turno3Value,DatoLiberoValue:Variant;
    DataInizio,DataFine,DataControllo:TDateTime;
    NonContDipPian,TuttiDip,AssenzaTuttiSi,AssenzaTuttiNo,RegistraForzaturaAssenza,ElaborazioneInterrotta:Boolean;
    ListaGiorniSel:TStringList;
    selDatiBloccati:TDatiBloccati;
    ElencoDate:array [1..31] of TElencoDate;
    evtRichiesta:T040Dlg;
    evtRichiestaRefresh:T040Dlg;
    evtGiornataAssenza:T040DlgInt;
    evtTurnoNonInserito:T040DlgFunc;
    evtLimitiMese:T040Dlg;
    procedure ImpostaTipologiaDataSet;
    procedure VisualizzaCampi;
    procedure AfterPost;
    procedure BeforeDelete;
    procedure BeforeInsert;
    procedure BeforePost;
    procedure NewRecord(Data:TDateTime);
    procedure selT380ValidaData;
    procedure selT380ValidaTurno(Sender:TField);
    procedure selT380ValidaDatoLibero;
    procedure selT380ImpostaTesto(Sender:TField;const Text:String;Lung:Integer);
    function RaggruppamentiAbilitati(Prog:Integer;DataRif:TDateTime):Boolean;
    procedure CercaContratto(Prog:Integer;DataRif:TDateTime);
    function GiornataAssenza(Data:TDateTime;Progressivo:LongInt):Boolean;
    function TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer):Boolean;
    procedure ControlloVincoliIndividuali(Turno:String);
    procedure TurniIntersecati(T1,T2:String);
    procedure RefreshT380;
    procedure CaricaElencoDate;
    procedure TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
    procedure VerificaLimiteMese(const Turni:array of String;DataAttuale:TDateTime;Stato:TDataSetState;RigaID:String;Prog:Integer);
    procedure ImpostaFiltro(Testo:String);
    procedure ImpostaCampiLookup;
    function GetHint(ConsideraDatoLibero:Boolean):String;
    procedure InserisciGestioneMensile;
    procedure CancellaGestioneMensile;
    procedure Controlli(Modo: String);
    function ControlliInd:Boolean;
    function GetDatiDipendente:String;
    function GetPriorita(Progressivo:Integer;Data:TDateTime):Integer;
  end;

implementation

{$R *.dfm}

procedure TA040FPianifRepMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CodTipologia:='R';
  ImpostaTipologiaDataSet;
  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero) then
  begin
    if selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
      selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
    selDatoLibero.Open;
  end;
  cdsParametri.CreateDataSet;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  ListaGiorniSel:=TStringList.Create;
end;

procedure TA040FPianifRepMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ListaGiorniSel.Free;
  selDatiBloccati.Free;
end;

procedure TA040FPianifRepMW.ImpostaTipologiaDataSet;
begin
  R180SetVariable(Q270,'CODINTERNO',IfThen(CodTipologia = 'R','C','D'));
  Q270.Open;
  R180SetVariable(Q350,'TIPOLOGIA',CodTipologia);
  Q350.Open;
  R180SetVariable(Q350Opposto,'TIPOLOGIA',CodTipologia);
  Q350Opposto.Open;
  sTipo:=IfThen(CodTipologia = 'R','reperibilit�','guardia');
end;

procedure TA040FPianifRepMW.VisualizzaCampi;
begin
  selT380.FieldByName('PRIORITA1').Visible:=CodTipologia = 'R';
  selT380.FieldByName('PRIORITA2').Visible:=CodTipologia = 'R';
  selT380.FieldByName('PRIORITA3').Visible:=CodTipologia = 'R';
  selT380.FieldByName('DATOLIBERO').Visible:=A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,selDatoLibero);
end;

procedure TA040FPianifRepMW.AfterPost;
var RowID:String;
begin
  RowID:=selT380.RowID;
  selT380.Refresh;
  selT380.SearchRecord('ROWID',RowID,[srFromBeginning]);
  CaricaElencoDate;
end;

procedure TA040FPianifRepMW.BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(selT380.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT380.FieldByName('DATA').AsDateTime),'T380') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA040FPianifRepMW.BeforeInsert;
begin
  if SelAnagrafe.RecordCount = 0 then Abort;
end;

procedure TA040FPianifRepMW.BeforePost;
var Priorita:Integer;
begin
  ProceduraChiamante:=0;//BeforePost
  AssenzaTuttiSi:=False;
  AssenzaTuttiNo:=False;
  if not RaggruppamentiAbilitati(selT380.FieldByName('PROGRESSIVO').AsInteger,selT380.FieldByName('DATA').AsDateTime) then
    raise Exception.Create(Format(A000MSG_A040_ERR_DLG_FMT_NO_RAGGR,[sTipo,FormatDateTime('DD/MM/YYYY',selT380.FieldByName('DATA').AsDateTime),'']));
  if selDatiBloccati.DatoBloccato(selT380.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT380.FieldByName('DATA').AsDateTime),'T380') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if selT380.FieldByName('TURNO1').AsString = '' then
    raise Exception.Create(A000MSG_A040_ERR_NO_TURNO_1);
  if (selT380.FieldByName('TURNO1').AsString = selT380.FieldByName('TURNO2').AsString) or
     ((selT380.FieldByName('TURNO1').AsString <> '') and
     (selT380.FieldByName('TURNO1').AsString = selT380.FieldByName('TURNO3').AsString)) or
     ((selT380.FieldByName('TURNO2').AsString <> '') and
     (selT380.FieldByName('TURNO2').AsString = selT380.FieldByName('TURNO3').AsString)) then
    raise Exception.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
  if (selT380.FieldByName('TURNO2').AsString = '') and (selT380.FieldByName('TURNO3').AsString <> '') then
    raise Exception.Create(A000MSG_A040_ERR_NO_TURNO_2);
  if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',selT380.RowId,selT380.State,['PROGRESSIVO','DATA','TIPOLOGIA'],[selT380.FieldByName('PROGRESSIVO').AsString,selT380.FieldByName('DATA').AsString,CodTipologia]) then
    raise Exception.Create(Format(A000MSG_A040_ERR_FMT_ESISTE_PIANIF,[selT380.FieldByName('DATA').AsString]));
  if (not GiornataAssenza(selT380.FieldByName('DATA').AsDateTime,selT380.FieldByName('PROGRESSIVO').AsInteger)) or
    ((not NonContDipPian) and (not TurnoNonInserito(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime,selT380.FieldByName('PROGRESSIVO').AsInteger))) then
    Abort;
  if (selT380.State = dsInsert) or
     (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
     (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) or
     (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
  begin
    // controllo vincoli individuali
    R180SetVariable(selT385,'PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT385,'TIPO',CodTipologia);
    R180SetVariable(selT385,'DATA',selT380.FieldByName('DATA').AsDateTime);
    selT385.Open;
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO1').AsString);
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO2').AsString);
    if (selT380.State = dsInsert) or (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      ControlloVincoliIndividuali(selT380.FieldByName('TURNO3').AsString);
    // intersezione turni
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
       (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString);
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO1').medpOldValue <> selT380.FieldByName('TURNO1').Value) or
       (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO3').AsString);
    if (selT380.State = dsInsert) or
       (selT380.FieldByName('TURNO2').medpOldValue <> selT380.FieldByName('TURNO2').Value) or
       (selT380.FieldByName('TURNO3').medpOldValue <> selT380.FieldByName('TURNO3').Value) then
      TurniIntersecati(selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString);
    with selT380a do
    begin
      Close;
      SetVariable('PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selT380.FieldByName('DATA').AsDateTime);
      SetVariable('TIPOLOGIA',CodTipologia);
      Open;
      if RecordCount > 0 then
      begin
        if (selT380.FieldByName('TURNO1').OldValue <> selT380.FieldByName('TURNO1').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO1').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
        if (selT380.FieldByName('TURNO2').OldValue <> selT380.FieldByName('TURNO2').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO2').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
        if (selT380.FieldByName('TURNO3').OldValue <> selT380.FieldByName('TURNO3').Value) then
        begin
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
          TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,selT380.FieldByName('TURNO3').AsString,selT380.FieldByName('DATA').AsDateTime);
        end;
      end;
    end;
    VerificaLimiteMese([selT380.FieldByName('TURNO1').AsString,
                        selT380.FieldByName('TURNO2').AsString,
                        selT380.FieldByName('TURNO3').AsString],
                        selT380.FieldByName('DATA').AsDateTime,
                        selT380.State,selT380.Rowid,
                        selT380.FieldByName('PROGRESSIVO').AsInteger);
  end;
  Priorita:=GetPriorita(selT380.FieldByName('PROGRESSIVO').AsInteger,selT380.FieldByName('DATA').AsDateTime);
  if Priorita <> 0 then
  begin
    if selT380.FieldByName('PRIORITA1').IsNull then
      selT380.FieldByName('PRIORITA1').AsInteger:=Priorita;
    if selT380.FieldByName('PRIORITA2').IsNull then
      selT380.FieldByName('PRIORITA2').AsInteger:=Priorita;
    if selT380.FieldByName('PRIORITA3').IsNull then
      selT380.FieldByName('PRIORITA3').AsInteger:=Priorita;
  end;
  if selT380.FieldByName('TURNO2').IsNull then
    selT380.FieldByName('PRIORITA2').Clear;
  if selT380.FieldByName('TURNO3').IsNull then
    selT380.FieldByName('PRIORITA3').Clear;
end;

procedure TA040FPianifRepMW.NewRecord(Data:TDateTime);
begin
  selT380.FieldByName('DATA').AsDateTime:=Data;
  selT380.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selT380.FieldByName('TIPOLOGIA').AsString:=CodTipologia;
end;

procedure TA040FPianifRepMW.selT380ValidaData;
begin
  if (selT380.FieldByName('DATA').AsDateTime < DataInizio) or
     (selT380.FieldByName('DATA').AsDateTime > DataFine) then
    raise Exception.Create(A000MSG_A040_ERR_DATA_ESTERNA_MESE);
end;

procedure TA040FPianifRepMW.selT380ValidaTurno(Sender:TField);
begin
  if selT380.FieldByName((Sender as TField).FieldName).AsString <> '' then
    if VarToStr(Q350.Lookup('CODICE',selT380.FieldByName((Sender as TField).FieldName).AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[(Sender as TField).DisplayLabel]));
end;

procedure TA040FPianifRepMW.selT380ValidaDatoLibero;
begin
  if selT380.FieldByName('DATOLIBERO').AsString <> '' then
    if VarToStr(selDatoLibero.Lookup('CODICE',selT380.FieldByName('DATOLIBERO').AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('DATOLIBERO').DisplayLabel]));
end;

procedure TA040FPianifRepMW.selT380ImpostaTesto(Sender:TField;const Text:String;Lung:Integer);
begin
  Sender.AsString:=Trim(Copy(Text,1,Lung));
end;

procedure TA040FPianifRepMW.FiltroDizionario(DataSet:TDataSet;var Accept:Boolean);
begin
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
end;

function TA040FPianifRepMW.RaggruppamentiAbilitati(Prog:Integer;DataRif:TDateTime):Boolean;
var i:Integer;
begin
  //Controllo se il dipendente ha delle causali di presenza adeguate abilitate in data
  Result:=False;
  CercaContratto(Prog,DataRif);
  with TStringList.Create do
  begin
    CommaText:=Q430Contratto.FieldByName('AbPresenza1').AsString;
    for i:=0 to Count - 1 do
      if Q270.Locate('Codice',Strings[i],[]) then
      begin
        Result:=True;
        Break;
      end;
    Free;
  end;
end;

procedure TA040FPianifRepMW.CercaContratto(Prog:Integer;DataRif:TDateTime);
begin
  with Q430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;
end;

function TA040FPianifRepMW.GiornataAssenza(Data:TDateTime;Progressivo:LongInt):Boolean;
{Controllo se nel giorno corrente e' presente una giornata di assenza}
var Risposta:Integer;
begin
  Result:=True;
  Risposta:=0;
  with Q040 do
  begin
    Close;
    SetVariable('Progressivo',Progressivo);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
    begin
      if AssenzaTuttiSi then
      begin
        Result:=True;
        exit;
      end
      else if AssenzaTuttiNo then
      begin
        Result:=False;
        exit;
      end
      else
      begin
        RegistraForzaturaAssenza:=False;
        if Assigned(evtGiornataAssenza) then
        begin
          Risposta:=evtGiornataAssenza(GetDatiDipendente +
                                       Format(A000MSG_A040_DLG_FMT_ESISTE_ASSENZA,[DateToStr(Data),FieldByName('Causale').AsString]) +
                                       IfThen((ProceduraChiamante = 1) and TuttiDip,A000MSG_A040_DLG_FMT_ESISTE_ASSENZA_TUTTI));
          AssenzaTuttiSi:=Risposta = mrYesToAll;
          AssenzaTuttiNo:=Risposta = mrNoToAll;
          Result:=Risposta in [mrYes,mrYesToAll];
          RegistraForzaturaAssenza:=Result;
        end;
      end;
    end;
  end;
end;

function TA040FPianifRepMW.TurnoNonInserito(C1,C2,C3:String;Data:TDateTime;Prog:Integer):Boolean;
begin
  Result:=True;
  QControllo.Close;
  QControllo.SetVariable('DATA',Data);
  QControllo.SetVariable('T1',C1);
  QControllo.SetVariable('T2',C2);
  QControllo.SetVariable('T3',C3);
  QControllo.SetVariable('PROGRESSIVO',Prog);
  QControllo.SetVariable('TIPOLOGIA',CodTipologia);
  QControllo.Open;
  Result:=(QControllo.Fields[0].Value = 0);  //Esiste un turno pianificato
  if not Result then
  begin
    if (Trim(C1) <> '') and (Trim(C2) <> '') then
      C1:=C1 + ' o ';
    C1:=C1 + C2;
    if (Trim(C1) <> '') and (Trim(C3) <> '') then
      C1:=C1 + ' o ';
    C1:=C1 + C3;
    if Assigned(evtTurnoNonInserito) then
      Result:=evtTurnoNonInserito(GetDatiDipendente + Format(A000MSG_A040_DLG_FMT_TURNO_PIANIFICATO,[C1,DateToStr(Data)]));
  end;
end;

procedure TA040FPianifRepMW.ControlloVincoliIndividuali(Turno:String);
begin
  if Trim(Turno) = '' then
    Exit;
  //Priorit�: FS/PF - (1..7) - *
  //se il giorno del vincolo � FS e la data pianif. � un festivo
  if (selT385.SearchRecord('GIORNO','FS',[srFromBeginning]) and
     (selT385.FieldByName('DTFESTIVO').AsString = 'S'))
  //se il giorno del vincolo � PF e la data pianif. � un prefestivo
  or (selT385.SearchRecord('GIORNO','PF',[srFromBeginning]) and
     (selT385.FieldByName('DTPREFESTIVO').AsString = 'S'))
  //se il giorno del vincolo � uguale al giorno della data pianif.
  or selT385.SearchRecord('GIORNO',DayOfWeek(selT385.GetVariable('DATA') - 1),[srFromBeginning])
  //se il giorno del vincolo � Tutti
  or selT385.SearchRecord('GIORNO','*',[srFromBeginning]) then
  begin
    if ((selT385.FieldByName('DISPONIBILE').AsString = 'S') and
       (Pos(',' + Turno + ',', ',' + selT385.FieldByName('TURNI').AsString + ',') <= 0)) or
       ((selT385.FieldByName('DISPONIBILE').AsString = 'N') and
       (Pos(',' + Turno + ',', ',' + selT385.FieldByName('TURNI').AsString + ',') > 0)) then
    begin
      TestoAnomalia:=Format(A000MSG_A040_DLG_FMT_TURNO_NON_DISP,[VarToStr(selT385.GetVariable('DATA')),Turno]);
      if selT385.FieldByName('BLOCCA_PIANIF').AsString = 'S' then
        raise exception.Create(TestoAnomalia)
      else
        if Assigned(evtRichiesta) then
          evtRichiesta(GetDatiDipendente + TestoAnomalia + #13#10 + 'Vuoi continuare?','ControlloVincoli ' + Turno);
    end;
  end;
end;

procedure TA040FPianifRepMW.TurniIntersecati(T1,T2:String);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
    ConfigOK:Boolean;
begin
  if (T1 <> '') and (T2 <> '') then
  begin
    try
      ConfigOK:=True;
      I1:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T2,'ORAINIZIO')));
        F2Ori:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T2,'ORAFINE')));
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
      end;
    except
      ConfigOK:=False;
      if Assigned(evtRichiestaRefresh) then
        evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO,['','']) + #13#10 + 'Confermare?','TurniIntersConfigKO ' + T1 + ' ' + T2);
    end;
    if ConfigOK then
      if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
         ((I2 <= I1) and (F2 >= F1)) then
        if Assigned(evtRichiestaRefresh) then
          evtRichiestaRefresh(Format(A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI,['',
                                                                             T1,R180MinutiOre(I1),R180MinutiOre(F1Ori),
                                                                             T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]) + #13#10 + 'Confermare?',
                              'TurniIntersecati ' + T1 + ' ' + T2);
  end;
end;

procedure TA040FPianifRepMW.RefreshT380;
begin
  with selT380 do
  begin
    Close;
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    SetVariable('FILTRO',Filtro);
    SetVariable('TIPOLOGIA',CodTipologia);
    if VariableIndex('DATALAVORO') >= 0 then
      DeleteVariable('DATALAVORO');
    if VariableIndex('C700DATADAL') >= 0 then
      DeleteVariable('C700DATADAL');
    if Pos(':DATALAVORO',UpperCase(Filtro)) > 0 then
      DeclareAndSet('DATALAVORO',otDate,DataFine);
    if Pos(':C700DATADAL',UpperCase(Filtro)) > 0 then
      DeclareAndSet('C700DATADAL',otDate,DataInizio);
    Open;
  end;
  CaricaElencoDate;
end;

procedure TA040FPianifRepMW.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  for i:=1 to 31 do
  begin
    ElencoDate[i].Data:=0;
    ElencoDate[i].Colorata:=False;
  end;
  i:=1;
  with selT380 do
  begin
    { TODO : TEST IW 15 }
    Puntatore:=GetBookmark;
	try
      DisableControls;
      First;
      ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
      inc(i);
      while not Eof do
      begin
        if ElencoDate[i - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
	finally
      FreeBookmark(Puntatore);
	end;
    EnableControls;
  end;
end;

procedure TA040FPianifRepMW.TurniIntersecatiTipologieDiverse(T1,T2:String;DataRif:TDateTime);
var I1,I2,F1,F2,F1Ori,F2Ori:Integer;
  Tipo1,Tipo2:String;
  ConfigOK:Boolean;
begin
  if (T1 <> '') and (T2 <> '') then
  begin
    try
      ConfigOk:=True;
      if CodTipologia = 'R' then
      begin
        Tipo1:='Guardia';
        Tipo2:='Reperibilit�';
      end
      else if CodTipologia = 'G' then
      begin
        Tipo1:='Reperibilit�';
        Tipo2:='Guardia';
      end;
      I1:=R180OreMinuti(VarToDateTime(Q350Opposto.Lookup('CODICE',T1,'ORAINIZIO')));
      F1Ori:=R180OreMinuti(VarToDateTime(Q350Opposto.Lookup('CODICE',T1,'ORAFINE')));
      F1:=F1Ori;
      if F1 <= I1 then
        inc(F1,1440);
      if T2 <> '' then
      begin
        I2:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T2,'ORAINIZIO')));
        F2Ori:=R180OreMinuti(VarToDateTime(Q350.Lookup('CODICE',T2,'ORAFINE')));
        F2:=F2Ori;
        if F2 <= I2 then
          inc(F2,1440);
      end;
    except
      ConfigOK:=False;
      TestoAnomalia:=Format(A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO,['di reperibilit�/guardia','in data ' + FormatDateTime('dd/mm/yyyy',DataRif)]);
      if Assigned(evtRichiestaRefresh) then
        evtRichiestaRefresh(GetDatiDipendente + TestoAnomalia + #13#10 + 'Confermare?','TurniIntersTipiDivConfigKO ' + T1 + ' ' + T2);
    end;
    if ConfigOK then
      if ((I2 >= I1) and (I2 < F1)) or ((F2 > I1) and (F2 <= F1)) or
         ((I2 <= I1) and (F2 >= F1)) then
      begin
        TestoAnomalia:=Format(A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI,['tra Reperibilit� e Guardia in data ' + FormatDateTime('dd/mm/yyyy',DataRif),
                                                                      Tipo1 + ': ' + T1,R180MinutiOre(I1),R180MinutiOre(F1Ori),
                                                                      Tipo2 + ': ' + T2,R180MinutiOre(I2),R180MinutiOre(F2Ori)]);
        if Assigned(evtRichiestaRefresh) then
          evtRichiestaRefresh(GetDatiDipendente + TestoAnomalia + #13#10 + 'Confermare?','TurniIntersTipiDiv ' + T1 + ' ' + T2);
      end;
  end;
end;

procedure TA040FPianifRepMW.VerificaLimiteMese(const Turni:array of String;DataAttuale:TDateTime;Stato:TDataSetState;RigaID:String;Prog:Integer);
var
  i,MaxMese,TotMese:Integer;
  TotMeseTurniInteri: Real;
  BloccaMaxMese:Boolean;
begin
  if (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[0],'PIANIF_MAX_MESE')),0) = 0) and
     (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[1],'PIANIF_MAX_MESE')),0) = 0) and
     (StrToIntDef(VarToStr(Q350.Lookup('CODICE',Turni[2],'PIANIF_MAX_MESE')),0) = 0) then
    exit;
  // 1. considera i turni della riga attuale (in fase di insert / edit)
  with selSumTurniAtt do
  try
    ClearVariables;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('TIPOLOGIA',CodTipologia);
    SetVariable('DATARIF',DataAttuale);
    SetVariable('TURNO1',Turni[0]);
    SetVariable('TURNO2',Turni[1]);
    SetVariable('TURNO3',Turni[2]);
    Execute;

    // incrementa i totali: turni interi / numero turni assoluto
    TotMeseTurniInteri:=FieldAsFloat(0);
    TotMese:=FieldAsInteger(1);
  except
    TotMeseTurniInteri:=0;
    TotMese:=0;
  end;

  // 2. considera i turni del mese, esclusa riga attuale
  with selT380SumTurniMese do
  try
    ClearVariables;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('TIPOLOGIA',CodTipologia);
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    if Stato = dsEdit then
      SetVariable('FILTRO',Format('and    t380.rowid <> ''%s''',[RigaID]));
    Execute;

    // incrementa i totali: turni interi / numero turni assoluto
    TotMeseTurniInteri:=TotMeseTurniInteri + FieldAsFloat(0);
    TotMese:=TotMese + FieldAsInteger(1);
  except
  end;

  // verifica i limiti per i turni
  for i:=0 to High(Turni) do
  begin
    if Trim(Turni[i]) = '' then
      Continue;

    Q350.SearchRecord('CODICE',Turni[i],[srFromBeginning]);
    // se non � specificato un limite passa al prossimo turno
    if Q350.FieldByName('PIANIF_MAX_MESE').IsNull then
      MaxMese:=0
    else
      MaxMese:=Q350.FieldByName('PIANIF_MAX_MESE').AsInteger;
    if MaxMese = 0 then
      Continue;
    BloccaMaxMese:=Q350.FieldByName('BLOCCA_MAX_MESE').AsString = 'S';
    // verifica limiti in base al parametro turni interi
    if Q350.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').AsString = 'S' then
    begin
      if TotMeseTurniInteri > MaxMese then
      begin
        TestoAnomalia:=Format(A000MSG_A040_DLG_FMT_LIMITE_SUPERATO,[Turni[i],
                                                                    'interi',Format('%f',[TotMeseTurniInteri]),
                                                                    'interi',MaxMese]);
        if BloccaMaxMese then
          raise exception.Create(TestoAnomalia)
        else if Assigned(evtLimitiMese) then
          evtLimitiMese(GetDatiDipendente +
                        TestoAnomalia +
                        #13#10 + 'Vuoi continuare?' +
                        IfThen((ProceduraChiamante = 1) and TuttiDip,A000MSG_A040_DLG_FMT_LIMITE_SUPERATO_ESCI),
                        'LimiteMeseTurniInteri ' + Turni[i]);
      end;
    end
    else
    begin
      if TotMese > MaxMese then
      begin
        TestoAnomalia:=Format(A000MSG_A040_DLG_FMT_LIMITE_SUPERATO,[Turni[i],
                                                                    '',Format('%d',[TotMese]),
                                                                    '',MaxMese]);
        if BloccaMaxMese then
          raise Exception.Create(TestoAnomalia)
        else if Assigned(evtLimitiMese) then
          evtLimitiMese(GetDatiDipendente +
                        TestoAnomalia +
                        #13#10 + 'Vuoi continuare?' +
                        IfThen((ProceduraChiamante = 1) and TuttiDip,A000MSG_A040_DLG_FMT_LIMITE_SUPERATO_ESCI),
                        'LimiteMeseTurni ' + Turni[i]);
      end;
    end;
  end; // => end for
end;

procedure TA040FPianifRepMW.ImpostaFiltro(Testo:String);
begin
  Filtro:='';
  if (Testo <> '') and (Pos('ORDER BY',Testo) <> 1) then
    if Pos('ORDER BY',Testo) > 0 then
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Pos('ORDER BY', Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T380.DATA',[rfIgnoreCase,rfReplaceAll])
    else
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Length(Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T380.DATA',[rfIgnoreCase,rfReplaceAll]);
  if Filtro = ' AND ' then
    Filtro:='';
end;

procedure TA040FPianifRepMW.ImpostaCampiLookup;
begin
  selT380.FieldByName('D_MATRICOLA').FieldKind:=fkLookup;
  selT380.FieldByName('D_MATRICOLA').LookupDataSet:=SelAnagrafe;
  selT380.FieldByName('D_MATRICOLA').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_MATRICOLA').LookupResultField:='MATRICOLA';
  selT380.FieldByName('D_MATRICOLA').KeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_BADGE').FieldKind:=fkLookup;
  selT380.FieldByName('D_BADGE').LookupDataSet:=SelAnagrafe;
  selT380.FieldByName('D_BADGE').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_BADGE').LookupResultField:='T430BADGE';
  selT380.FieldByName('D_BADGE').KeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_NOMINATIVO').FieldKind:=fkLookup;
  selT380.FieldByName('D_NOMINATIVO').LookupDataSet:=SelAnagrafe;
  selT380.FieldByName('D_NOMINATIVO').LookupKeyFields:='PROGRESSIVO';
  selT380.FieldByName('D_NOMINATIVO').LookupResultField:='NOMINATIVO';
  selT380.FieldByName('D_NOMINATIVO').KeyFields:='PROGRESSIVO';
end;

function TA040FPianifRepMW.GetHint(ConsideraDatoLibero:Boolean):String;
var DescT1,DescT2,DescT3: String;
  function GetDescrizioneTurno(const CodTurno : String):String;
  begin
    Result:='';
    if Q350.Locate('CODICE',CodTurno,[loCaseInsensitive]) then
      Result:=Q350.FieldByName('DESCRIZIONE').AsString + ': ' +
        FormatDateTime('hh.mm',Q350.FieldByName('OraInizio').AsDateTime) + '-' +
        FormatDateTime('hh.mm',Q350.FieldByName('OraFine').AsDateTime);
  end;
  function GetDescrizioneDatoLibero(const Codice: String):String;
  begin
    Result:='';
    if selDatoLibero.Locate('CODICE',Codice,[loCaseInsensitive]) then
      Result:=selDatoLibero.FieldByName('DESCRIZIONE').AsString;
  end;
begin
  Result:=selT380.FieldByName('D_NOMINATIVO').AsString;
  DescT1:=GetDescrizioneTurno(selT380.FieldByName('Turno1').AsString);
  if DescT1 <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno1').AsString + ': ' + DescT1;
  if not selT380.FieldByName('PRIORITA1').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA1').AsInteger]);
  DescT2:=GetDescrizioneTurno(selT380.FieldByName('Turno2').AsString);
  if DescT2 <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno2').AsString + ': ' + DescT2;
  if not selT380.FieldByName('PRIORITA2').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA2').AsInteger]);
  DescT3:=GetDescrizioneTurno(selT380.FieldByName('Turno3').AsString);
  if GetDescrizioneTurno(selT380.FieldByName('Turno3').AsString) <> '' then
    Result:=Result + #13#10 + selT380.FieldByName('Turno3').AsString + ': ' + DescT3;
  if not selT380.FieldByName('PRIORITA3').IsNull then
    Result:=Result + Format(' (%d)',[selT380.FieldByName('PRIORITA3').AsInteger]);
  if ConsideraDatoLibero and (selT380.FieldByName('DATOLIBERO').AsString <> '') then
    Result:=Result + #13#10 + R180Capitalize(selT380.FieldByName('DATOLIBERO').DisplayLabel) + ' : ' +
            Trim(selT380.FieldByName('DATOLIBERO').AsString) + ' ' +
            GetDescrizioneDatoLibero(selT380.FieldByName('DATOLIBERO').AsString);
end;

procedure TA040FPianifRepMW.InserisciGestioneMensile;
var C1,C2,C3,C4:String;
    i:Integer;
    DataRif:TDateTime;
  procedure SettaQuery(Data:TDateTime);
  var Priorita:Integer;
  begin
    Priorita:=GetPriorita(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataRif);
    insT380.ClearVariables;
    insT380.SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    insT380.SetVariable('Data',Data);
    insT380.SetVariable('Tipologia',CodTipologia);
    insT380.SetVariable('Turno1',C1);
    if Priorita <> 0 then
      insT380.SetVariable('Priorita1',Priorita);
    insT380.SetVariable('Turno2',C2);
    if C2 <> '' then
      if Priorita <> 0 then
        insT380.SetVariable('Priorita2',Priorita);
    insT380.SetVariable('Turno3',C3);
    if C3 <> '' then
      if Priorita <> 0 then
        insT380.SetVariable('Priorita3',Priorita);
    insT380.SetVariable('DatoLibero',C4);
    try
      insT380.Execute;
      RegistraLog.SettaProprieta('I','T380_PIANIFREPERIB',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT380.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(insT380.GetVariable('Data')));
      RegistraLog.InserisciDato('TIPOLOGIA','',CodTipologia);
      RegistraLog.InserisciDato('TURNO1','',VarToStr(insT380.GetVariable('Turno1')));
      if Priorita <> 0 then
        RegistraLog.InserisciDato('PRIORITA1','',VarToStr(insT380.GetVariable('Priorita1')));
      if C2 <> '' then
      begin
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT380.GetVariable('Turno2')));
        if Priorita <> 0 then
          RegistraLog.InserisciDato('PRIORITA2','',VarToStr(insT380.GetVariable('Priorita2')));
      end;
      if C3 <> '' then
      begin
        RegistraLog.InserisciDato('TURNO3','',VarToStr(insT380.GetVariable('Turno3')));
        if Priorita <> 0 then
          RegistraLog.InserisciDato('PRIORITA3','',VarToStr(insT380.GetVariable('Priorita3')));
      end;
      if C4 <> '' then
        RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(insT380.GetVariable('DATOLIBERO')));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
    end;
  end;
begin
  ProceduraChiamante:=1;//InserisciGestioneMensile
  C1:=Turno1Value;
  if Turno2Value <> null then
    C2:=Turno2Value
  else
    C2:='';
  if Turno3Value <> null then
    C3:=Turno3Value
  else
    C3:='';
  if DatoLiberoValue <> null then
    C4:=DatoLiberoValue
  else
    C4:='';
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    DataRif:=StrToDate(Copy(ListaGiorniSel[i],5,10));
    try
      if QueryPK1.EsisteChiave('T380_PIANIFREPERIB',selT380.RowId,selT380.State,['PROGRESSIVO','DATA','TIPOLOGIA'],[SelAnagrafe.FieldByName('Progressivo').AsString,DateToStr(DataRif),CodTipologia]) then
      begin
        TestoAnomalia:=Format(A000MSG_A040_ERR_FMT_ESISTE_PIANIF,[FormatDateTime('dd/mm/yyyy',DataRif)]);
        abort;
      end;
      R180SetVariable(selT385,'PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
      R180SetVariable(selT385,'TIPO',CodTipologia);
      R180SetVariable(selT385,'DATA',DataRif);
      selT385.Open;
      ControlloVincoliIndividuali(C1);
      ControlloVincoliIndividuali(C2);
      ControlloVincoliIndividuali(C3);
      VerificaLimiteMese([C1,C2,C3],DataRif,selT380.State,selT380.Rowid,SelAnagrafe.FieldByName('Progressivo').AsInteger);
      if (GiornataAssenza(DataRif,SelAnagrafe.FieldByName('Progressivo').AsInteger)) and
        (NonContDipPian or (TurnoNonInserito(C1,C2,C3,DataRif,SelAnagrafe.FieldByName('Progressivo').AsInteger))) then
      begin
        if not RaggruppamentiAbilitati(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataRif) then
        begin
          TestoAnomalia:=Format(A000MSG_A040_ERR_DLG_FMT_NO_RAGGR,[sTipo,FormatDateTime('dd/mm/yyyy',DataRif)]);
          if TuttiDip then
          begin
            RegistraMsg.InserisciMessaggio('A',TestoAnomalia,'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
            TestoAnomalia:='';
          end
          else if Assigned(evtRichiesta) then
            evtRichiesta(GetDatiDipendente + TestoAnomalia + #13#10 + 'Proseguire con la pianificazione mensile?','RaggrAbilitati');
        end
        else
        begin
          with selT380a do
          begin
            Close;
            SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
            SetVariable('DATA',DataRif);
            SetVariable('TIPOLOGIA',CodTipologia);
            Open;
            if RecordCount > 0 then
            begin
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO1').AsString,VarToStr(Turno3Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO2').AsString,VarToStr(Turno3Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno1Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno2Value),DataRif);
              TurniIntersecatiTipologieDiverse(FieldByName('TURNO3').AsString,VarToStr(Turno3Value),DataRif);
            end;
          end;
          if (Q040.RecordCount > 0) and RegistraForzaturaAssenza then
            RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A040_MSG_FMT_FORZA_TURNO_ASSENZA,[DateToStr(DataRif),Q040.FieldByName('Causale').AsString]),'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
          SettaQuery(DataRif);
        end;
      end;
    except
      on E:Exception do
      begin
        if TestoAnomalia = '' then
          TestoAnomalia:=E.Message;//Per segnalare eventuali anomalie non previste
        RegistraMsg.InserisciMessaggio('A',TestoAnomalia,'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
        Break;//Uscendo dal ciclo e dalla procedura, TestoAnomalia verr� sicuramente ripulito all'elaborazione del dipendente successivo
      end;
    end;
  end;
end;

procedure TA040FPianifRepMW.CancellaGestioneMensile;
var i:Integer;
    Where:String;
    Aggiorna:Boolean;
begin
  Where:='';
  if VarToStr(Turno1Value) <> '' then
    Where:=' AND TURNO1 = ''' + VarToStr(Turno1Value) + '''';
  if VarToStr(Turno2Value) <> '' then
    Where:=Where + ' AND TURNO2 = ''' + VarToStr(Turno2Value)  + '''';
  if VarToStr(Turno3Value) <> '' then
    Where:=Where + ' AND TURNO3 = ''' + VarToStr(Turno3Value)  + '''';
  if VarToStr(DatoLiberoValue) <> '' then
    Where:=Where + ' AND DATOLIBERO = ''' + VarToStr(DatoLiberoValue)  + '''';
  Aggiorna:=False;
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    delT380.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsString);
    delT380.SetVariable('DATA',StrToDate(Copy(ListaGiorniSel[i],5,10)));
    delT380.SetVariable('TIPOLOGIA',CodTipologia);
    delT380.SetVariable('WHERE',Where);
    delT380.Execute;
    if delT380.RowsProcessed > 0 then
    begin
      RegistraLog.SettaProprieta('C','T380_PIANIFREPERIB',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(delT380.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(delT380.GetVariable('Data')));
      if VarToStr(Turno1Value) <> '' then
        RegistraLog.InserisciDato('TURNO1','',VarToStr(Turno1Value));
      if VarToStr(Turno2Value) <> '' then
        RegistraLog.InserisciDato('TURNO2','',VarToStr(Turno2Value));
      if VarToStr(Turno3Value) <> '' then
        RegistraLog.InserisciDato('TURNO3','',VarToStr(Turno3Value));
      if VarToStr(DatoLiberoValue) <> '' then
        RegistraLog.InserisciDato('DATOLIBERO','',VarToStr(DatoLiberoValue));
      RegistraLog.RegistraOperazione;
      Aggiorna:=True;
    end;
  end;
  if Aggiorna then
    SessioneOracle.Commit;
end;

procedure TA040FPianifRepMW.Controlli(Modo:String);
begin
  if Trim(Dipendente) = '' then
    if (SelAnagrafe.RecordCount = 0) or not TuttiDip then
      raise Exception.Create(A000MSG_ERR_NO_DIP);
  if ListaGiorniSel.Count <= 0 then
    raise Exception.Create(A000MSG_ERR_NO_LISTA_GIORNI);
  if Modo = 'I' then
  begin
    if (Turno1Value = '') or (Turno1Value = null) then
      raise Exception.Create(A000MSG_A040_ERR_NO_TURNO_1);
    if (Turno1Value = Turno2Value) or
       (Turno1Value = Turno3Value) then
      raise Exception.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
    if (Turno2Value <> null) and (Turno2Value <> '') and (Turno2Value = Turno3Value) then
      raise Exception.Create(A000MSG_A040_ERR_TURNO_RIPETUTO);
    if ((Turno3Value <> '') and (Turno3Value <> null)) and
       ((Turno2Value = '') or (Turno2Value = null)) then
      raise Exception.Create(A000MSG_A040_ERR_NO_TURNO_2);
    if (Turno1Value <> '') and (Turno1Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno1Value,'CODICE')) = '' then
        raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO1').DisplayLabel]));
    if (Turno2Value <> '') and (Turno2Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno2Value,'CODICE')) = '' then
        raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO2').DisplayLabel]));
    if (Turno3Value <> '') and (Turno3Value <> null) then
      if VarToStr(Q350.Lookup('CODICE',Turno3Value,'CODICE')) = '' then
        raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('TURNO3').DisplayLabel]));
    if (DatoLiberoValue <> '') and (DatoLiberoValue <> null) then
      if VarToStr(selDatoLibero.Lookup('CODICE',DatoLiberoValue,'CODICE')) = '' then
        raise Exception.Create(Format(A000MSG_A040_ERR_FMT_COD_NON_VALIDO,[selT380.FieldByName('DATOLIBERO').DisplayLabel]));
    TurniIntersecati(VarToStr(Turno1Value),VarToStr(Turno2Value));
    TurniIntersecati(VarToStr(Turno1Value),VarToStr(Turno3Value));
    TurniIntersecati(VarToStr(Turno2Value),VarToStr(Turno3Value));
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_DLG_INSERIMENTO_MASSIVO,'ConfermaInserimento');
  end
  else
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_DLG_CANCELLAZIONE_MASSIVA,'ConfermaCancellazione');
end;

function TA040FPianifRepMW.ControlliInd:Boolean;
begin
  Result:=True;
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataControllo,'T380') then
  begin
    Result:=False;
    TestoAnomalia:=selDatiBloccati.MessaggioLog;
    RegistraMsg.InserisciMessaggio('A',TestoAnomalia,'',SelAnagrafe.FieldByName('Progressivo').AsInteger);
  end;
end;

function TA040FPianifRepMW.GetDatiDipendente:String;
begin
  Result:='';
  if ProceduraChiamante = 1 then
    Result:='Matr. ' + SelAnagrafe.FieldByName('MATRICOLA').AsString + ' ' + SelAnagrafe.FieldByName('NOMINATIVO').AsString + #13#10;
end;

function TA040FPianifRepMW.GetPriorita(Progressivo:Integer;Data:TDateTime):Integer;
begin
  Result:=0;//Priorit� non calcolabile automaticamente
  if CodTipologia <> 'R' then
    exit;
  selT381.Close;
  selT381.SetVariable('Progressivo',Progressivo);
  selT381.SetVariable('Data',Data);
  selT381.Open;
  //Se � stata impostata la priorit�
  if selT381.RecordCount > 0 then
  begin
    //Conto i giorni pianificati compresi...
    selT380b.Close;
    selT380b.SetVariable('Tipologia',CodTipologia);
    selT380b.SetVariable('Progressivo',Progressivo);
    selT380b.SetVariable('DIni',selT381.FieldByName('DATA').AsDateTime); //...tra la data in cui ho impostato la priorit�...
    selT380b.SetVariable('DFin',Data - 1); //...e il giorno precedente a quello che devo pianificare
    selT380b.Open;
    //Ricavo la nuova priorit� (1,2,3)
    Result:=((selT381.FieldByName('PRIORITA').AsInteger + selT380b.FieldByName('N_GG_PIANIF').AsInteger - 1) mod 3) + 1; //-1 e +1 servono per avere il resto 3 al posto di 0
  end;
end;

end.

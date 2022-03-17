unit B021UTurniDM;

interface

uses
  A000UCostanti, A000USessione, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} R014URestDM,
  C200UWebServicesTypes, B021UUtils, C180FunzioniGenerali,
  RegistrazioneLog, SysUtils, StrUtils, Variants, Classes,
  Oracle, DB, OracleData, Math;

type
  TDailyShiftChange = class(TPersistent)
  private
    FNonSo: String;
  end;

  TEmployeeShift = class(TPersistent)
  private
    FDay: TDateTime;
    FOnCall: Boolean;
    FShiftName: String;
    FShiftStart: TDateTime;
    FShiftEnd: TDateTime;
    FShiftBreakStart: TDateTime;
    FShiftBreakEnd: TDateTime;
    FExpectedShiftStart: TDateTime;
    FExpectedShiftEnd: TDateTime;
    FSkill: String;
    FNote: String;
    FPublicHoliday: Boolean;
    FSection: String;
    FDailyShiftChanges: array of TDailyShiftChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddDailyShiftChange(DSC: TDailyShiftChange);
    function ToString: String; override;
  end;

  TShift = class(TPersistent)
  private
    FId: String;
    FSurname: String;
    FName: String;
    FEmployeeShifts: array of TEmployeeShift;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddEmployeeShift(T: TEmployeeShift);
    function ToString: String; override;
  end;

  TTurni = class(TPersistent)
  private
    FStart,
    FEnd: TDateTime;
    FShifts: array of TShift;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddShift(T: TShift);
  end;

  TB021FTurniDM = class(TR014FRestDM)
    updT080: TOracleQuery;
    delT080: TOracleQuery;
    selT080: TOracleDataSet;
    selOrario: TOracleDataSet;
    selT080Ins: TOracleDataSet;
    insT380: TOracleQuery;
  private
    Matricola: String;
    Inizio: TDateTime;
    Fine: TDateTime;
    function GetTurni(Inizio, Fine: TDateTime): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function RevertJSON(PJson: TJSONObject): TPersistent; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    TipoTurni:String;
    function GetDato: TJSONObject; override;
    function AcceptDato: TJSONObject; override;
    function UpdateDato: TJSONObject; override;
    function CancelDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

// classi di supporto
constructor TTurni.Create;
begin
  SetLength(FShifts,0);
end;

destructor TTurni.Destroy;
begin
  SetLength(FShifts,0);
  inherited;
end;

procedure TTurni.AddShift(T: TShift);
begin
  SetLength(FShifts,Length(FShifts) + 1);
  FShifts[High(FShifts)]:=T;
end;

constructor TShift.Create;
begin
  SetLength(FEmployeeShifts,0);
end;

destructor TShift.Destroy;
begin
  SetLength(FEmployeeShifts,0);
  inherited;
end;

procedure TShift.AddEmployeeShift(T: TEmployeeShift);
begin
  SetLength(FEmployeeShifts,Length(FEmployeeShifts) + 1);
  FEmployeeShifts[High(FEmployeeShifts)]:=T;
end;

function TShift.ToString: String;
begin
  Result:=Format('id=%s|surname=%s|name=%s',[FId,FSurname,FName]);
end;

constructor TEmployeeShift.Create;
begin
  SetLength(FDailyShiftChanges,0);
end;

destructor TEmployeeShift.Destroy;
begin
  SetLength(FDailyShiftChanges,0);
  inherited;
end;

procedure TEmployeeShift.AddDailyShiftChange(DSC: TDailyShiftChange);
begin
  SetLength(FDailyShiftChanges,Length(FDailyShiftChanges) + 1);
  FDailyShiftChanges[High(FDailyShiftChanges)]:=DSC;
end;

function TEmployeeShift.ToString: String;
begin
  Result:=Format('day=%s|shiftName=%s',[ConvertiDateStr(FDay),FShiftName]);
end;

//**********************************************************

function TB021FTurniDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  T: TTurni;
  TArr,ETArr,DSCArr: TJSONArray;
  S: TShift;
  ES: TEmployeeShift;
  DSC: TDailyShiftChange;
  i,j,k: Integer;
  sObj,esObj,dscObj: TJSONObject;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  T:=TTurni(PObj);

  Result:=TJSONObject.Create;
  Result.AddPair('start',TJSONString.Create(ConvertiDateStr(T.FStart)));
  Result.AddPair('end',TJSONString.Create(ConvertiDateStr(T.FEnd)));

  // ciclo su array turni
  TArr:=TJSONArray.Create;
  for i:=0 to High(T.FShifts) do
  begin
    S:=T.FShifts[i];

    // crea nuovo oggetto turno
    sObj:=TJSONObject.Create;
    sObj.AddPair('id',TJSONString.Create(S.FId));
    sObj.AddPair('name',TJSONString.Create(S.FName));
    sObj.AddPair('surname',TJSONString.Create(S.FSurname));

    // ciclo su array turni dipendente
    ETArr:=TJSONArray.Create;
    for j:=0 to High(S.FEmployeeShifts) do
    begin
      ES:=S.FEmployeeShifts[j];

      // crea nuovo oggetto turno dip.
      esObj:=TJSONObject.Create;
      esObj.AddPair('day',TJSONString.Create(ConvertiDateStr(ES.FDay)));
      if ES.FOnCall then
        esObj.AddPair('onCall',TJSONTrue.Create)
      else
        esObj.AddPair('onCall',TJSONFalse.Create);
      esObj.AddPair('shiftName',TJSONString.Create(ES.FShiftName));
      esObj.AddPair('shiftStart',TJSONString.Create(ConvertiDateTimeStr(ES.FShiftStart)));
      esObj.AddPair('shiftEnd',TJSONString.Create(ConvertiDateTimeStr(ES.FShiftEnd)));
      esObj.AddPair('expectedShiftStart',TJSONString.Create(ConvertiDateTimeStr(ES.FExpectedShiftStart)));
      esObj.AddPair('expectedShiftEnd',TJSONString.Create(ConvertiDateTimeStr(ES.FExpectedShiftEnd)));
      esObj.AddPair('shiftBreakStart',TJSONString.Create(ConvertiDateTimeStr(ES.FShiftBreakStart)));
      esObj.AddPair('shiftBreakEnd',TJSONString.Create(ConvertiDateTimeStr(ES.FShiftBreakEnd)));
      esObj.AddPair('section',TJSONString.Create(ES.FSection));
      esObj.AddPair('skill',TJSONString.Create(ES.FSkill));
      if ES.FPublicHoliday then
        esObj.AddPair('publicHoliday',TJSONTrue.Create)
      else
        esObj.AddPair('publicHoliday',TJSONFalse.Create);
      esObj.AddPair('note',TJSONString.Create(ES.FNote));

      DSCArr:=TJSONArray.Create;
      for k:=0 to High(ES.FDailyShiftChanges) do
      begin
        DSC:=ES.FDailyShiftChanges[j];

        // crea nuovo oggetto cambi turni giornalieri
        dscObj:=TJSONObject.Create;
        dscObj.AddPair('nonso',TJSONString.Create(DSC.FNonSo));

        DSCArr.Add(dscObj);
      end;
      esObj.AddPair('dailyShiftChanges',DSCArr);

      ETArr.Add(esObj);
    end;
    sObj.AddPair('employeeShifts',ETArr);

    TArr.Add(sObj);
  end;
  Result.AddPair('shifts',TArr);
end;

function TB021FTurniDM.RevertJSON(PJson: TJSONObject): TPersistent;
var
  jPairTurno,jPairShift,jPairEmpShift,jPairDSCShift: TJSONPair;
  jShifts,jEmpShifts,jDSCShifts: TJSONArray;
  jObj,jEmpObj: TJSONObject;
  x,i,i1,j,j1,k: Integer;
  TKey,TVal,SKey,SVal,ESKey,ESVal: String;
begin
  // creazione oggetto turni
  Result:=TTurni.Create;
  try
    with TTurni(Result) do
      for x:=0 to PJson.Size - 1 do
      begin
        // informazioni generiche turni
        jPairTurno:=TJSonPair(PJson.Get(x));
        TKey:=jPairTurno.JsonString.Value;
        TVal:=jPairTurno.JsonValue.Value;

        if TKey = 'start' then
          ConvertiStrDate(TVal,FStart)
        else if TKey = 'end' then
          ConvertiStrDate(TVal,FEnd)
        else if TKey = 'shifts' then
        begin
          // array di TShift
          jShifts:=TJSONArray(jPairTurno.JsonValue);
          SetLength(TTurni(Result).FShifts,jShifts.Size);
          for i:=0 to jShifts.Size - 1 do
          begin
            jObj:=TJSONObject(jShifts.Get(i));
            FShifts[i]:=TShift.Create;
            for i1:=0 to jObj.Size - 1 do
            begin
              // info turno
              jPairShift:=TJSONPair(jObj.Get(i1));
              SKey:=jPairShift.JsonString.Value;
              SVal:=jPairShift.JsonValue.Value;

              if SKey = 'id' then
                FShifts[i].FId:=SVal
              else if SKey = 'surname' then
                FShifts[i].FSurname:=SVal
              else if SKey = 'name' then
                FShifts[i].FName:=SVal
              else if SKey = 'employeeShifts' then
              begin
                jEmpShifts:=TJSONArray(jPairShift.JsonValue);
                SetLength(FShifts[i].FEmployeeShifts,jEmpShifts.Size);
                for j:=0 to jEmpShifts.Size - 1 do
                begin
                  jEmpObj:=TJSONObject(jEmpShifts.Get(j));
                  FShifts[i].FEmployeeShifts[j]:=TEmployeeShift.Create;
                  for j1:=0 to jEmpObj.Size - 1 do
                  begin
                    jPairEmpShift:=TJSONPair(jEmpObj.Get(j1));
                    ESKey:=jPairEmpShift.JsonString.Value;
                    ESVal:=jPairEmpShift.JsonValue.Value;

                    if ESKey = 'day' then
                      ConvertiStrDate(ESVal,FShifts[i].FEmployeeShifts[j].FDay)
                    else if ESKey = 'onCall' then
                      FShifts[i].FEmployeeShifts[j].FOnCall:=(jPairEmpShift.JsonValue is TJSonTrue)
                    else if ESKey = 'shiftName' then
                      FShifts[i].FEmployeeShifts[j].FShiftName:=ESVal
                    else if ESKey = 'shiftStart' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FShiftStart)
                    else if ESKey = 'shiftEnd' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FShiftEnd)
                    else if ESKey = 'expectedShiftStart' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FExpectedShiftStart)
                    else if ESKey = 'expectedShiftEnd' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FExpectedShiftEnd)
                    else if ESKey = 'shiftBreakStart' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FShiftBreakStart)
                    else if ESKey = 'shiftBreakEnd' then
                      ConvertiStrDateTime(ESVal,FShifts[i].FEmployeeShifts[j].FShiftBreakEnd)
                    else if ESKey = 'skill' then
                      FShifts[i].FEmployeeShifts[j].FSkill:=ESVal
                    else if ESKey = 'section' then
                      FShifts[i].FEmployeeShifts[j].FSection:=ESVal
                    else if ESKey = 'note' then
                      FShifts[i].FEmployeeShifts[j].FNote:=ESVal
                    else if ESKey = 'publicHoliday' then
                      FShifts[i].FEmployeeShifts[j].FPublicHoliday:=(jPairEmpShift.JsonValue is TJSonTrue)
                    else if ESKey = 'dailyShiftChanges' then
                    begin
                      // array dei cambi turno giornalieri
                      jDSCShifts:=TJSONArray(jPairEmpShift.JsonValue);
                      SetLength(FShifts[i].FEmployeeShifts[j].FDailyShiftChanges,jDSCShifts.Size);
                      for k:=0 to jDSCShifts.Size - 1 do
                      begin
                        jPairDSCShift:=TJSONPair(jDSCShifts.Get(j));
                        if jPairDSCShift.JsonString.Value = 'nonso' then
                          FShifts[i].FEmployeeShifts[j].FDailyShiftChanges[k].FNonSo:=jPairDSCShift.JsonValue.Value;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
  except
    on E: Exception do
      raise Exception.Create('Errore di conversione: ' + E.Message);
  end;
end;

function TB021FTurniDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';

  if (Operazione = OPER_READ) or (Operazione = OPER_DELETE) then
  begin
    Result:=False;

    if Operazione = OPER_DELETE then
      Matricola:=GetParam('matricola');

    if not ConvertiStrDate(GetParam('inizio'),Inizio) then
    begin
      RErrMsg:='Parametro [inizio] non valido';
      Exit;
    end;

    if not ConvertiStrDate(GetParam('fine'),Fine) then
    begin
      RErrMsg:='Parametro [fine] non valido';
      Exit;
    end;
  end;

  Result:=True;
end;

function TB021FTurniDM.GetTurni(Inizio, Fine: TDateTime): TJSONObject;
var
  OldMatricola: String;
  Turni: TTurni;
  T: TShift;
  ES: TEmployeeShift;
begin
  Result:=nil;

  // apertura dataset
  selT080.Close;
  selT080.SetVariable('INIZIO',Inizio);
  selT080.SetVariable('FINE',Fine);
  try
    selT080.Open;
  except
    on E: Exception do
      raise EC200ExecutionError.Create('Errore durante apertura query turni');
  end;

  Turni:=TTurni.Create;
  try
    try
      Turni.FStart:=Inizio;
      Turni.FEnd:=Fine;
      OldMatricola:='';
      T:=nil;
      while not selT080.Eof do
      begin
        if selT080.FieldByName('MATRICOLA').AsString <> OldMatricola then
        begin
          if Assigned(T) then
            Turni.AddShift(T);

          // crea nuovo oggetto shift
          T:=TShift.Create;
          T.FId:=selT080.FieldByName('MATRICOLA').AsString;
          T.FSurname:=selT080.FieldByName('COGNOME').AsString;;
          T.FName:=selT080.FieldByName('NOME').AsString;;
        end;

        // shift utente
        ES:=TEmployeeShift.Create;
        ES.FDay:=selT080.FieldByName('DATA').AsDateTime;
        ES.FShiftName:=selT080.FieldByName('ORARIO').AsString;
        ES.FShiftStart:=selT080.FieldByName('DATA').AsDateTime + EncodeTime(8,30,0,0);
        ES.FShiftEnd:=selT080.FieldByName('DATA').AsDateTime + EncodeTime(19,45,0,0);
        ES.FExpectedShiftStart:=selT080.FieldByName('DATA').AsDateTime + EncodeTime(8,31,0,0);
        ES.FExpectedShiftStart:=selT080.FieldByName('DATA').AsDateTime + EncodeTime(19,46,0,0);
        ES.FShiftBreakStart:=selT080.FieldByName('DATA').AsDateTime + EncodeTime(12,15,0,0);
        ES.FShiftBreakEnd:=0;
        ES.FSection:='SEZIONE_' + selT080.FieldByName('COGNOME').AsString;
        ES.FSkill:='SKILL_' + selT080.FieldByName('NOME').AsString;
        ES.FNote:='NOTE PER ' + selT080.FieldByName('COGNOME').AsString + ' ' + selT080.FieldByName('NOME').AsString;
        ES.FPublicHoliday:=Trunc(selT080.FieldByName('DATA').AsDateTime) mod 7 = 0;

        T.AddEmployeeShift(ES);
        OldMatricola:=selT080.FieldByName('MATRICOLA').AsString;
        selT080.Next;
      end;

      // ultimo "shift" da aggiungere
      if Assigned(T) then
        Turni.AddShift(T);

      Result:=ConvertJSON(Turni);
    except
      on E: Exception do
        raise EC200ExecutionError.Create('Errore durante estrazione turni');
    end;
  finally
    FreeAndNil(Turni);
  end;
end;

function TB021FTurniDM.GetDato: TJSONObject;
begin
  Result:=GetTurni(Inizio,Fine);
end;

function TB021FTurniDM.AcceptDato: TJSONObject;
var
  Turni: TTurni;
  S: TShift;
  ES: TEmployeeShift;
  i,j,Prog,Turno,EMin,UMin: Integer;
  Orario,OldOrario,Entrata,Uscita,Errori: String;
  CavalloMezzanotte,Found: Boolean;
  Data1, Data2: TDateTime;
  procedure AcceptT080;
  begin
    // determina modello orario in base ai dati del turno
    // ed eventualmente del turno successivo
    R180SetVariable(selOrario,'DATA',ES.FDay);
    selOrario.Open;
    if selOrario.RecordCount = 0 then
      raise Exception.Create('Orario non trovato: progressivo ' + IntTosTr(Prog) + ', data ' + FormatDateTime('dd/mm/yyyy',Es.FDay))
    else
    begin
      if ES.FShiftName = 'L' then
      begin
        Found:=True;
        Orario:=selOrario.FieldByName('ORARIO').AsString;
        Turno:=0;
      end
      else
      begin
        Found:=False;
        OldOrario:='';
        Orario:='';
        Turno:=1;
        selOrario.First;
        while not selOrario.Eof do
        begin
          if selOrario.FieldByName('ORARIO').AsString <> OldOrario then
            Turno:=1;
          if (EMin = R180OreMinutiExt(selOrario.FieldByName('ENTRATA').AsString)) and
             (UMin = R180OreMinutiExt(selOrario.FieldByName('USCITA').AsString)) then
          begin
            Orario:=selOrario.FieldByName('ORARIO').AsString;
            Found:=True;
            Break;
          end;
          OldOrario:=selOrario.FieldByName('ORARIO').AsString;
          inc(Turno);
          selOrario.Next;
        end;
        if not Found then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Orario non trovato: data %s [%s - %s]',[FormatDateTime('dd/mm/yyyy',Es.FDay),Entrata,Uscita]),'',Prog);
          raise Exception.Create('Orario non trovato: progressivo ' + IntTosTr(Prog) +
                                 ', data ' + FormatDateTime('dd/mm/yyyy',Es.FDay) +
                                 ' [' + Entrata + ' - ' + Uscita + ']');
        end;
      end;
    end;

    // effettua inserimento pianificazione
    Data1:=ES.FDay;
    Data2:=ES.FDay + IfThen(CavalloMezzanotte,1);
    selT080Ins.Close;
    selT080Ins.SetVariable('DATA1',Data1);
    selT080Ins.SetVariable('DATA2',Data2);
    selT080Ins.Open;
    if selT080Ins.RecordCount = 0 then
    begin
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Pianificazione %s - %s non esistente - cavallo di mezzanotte: %s',[DateToStr(Data1),DateToStr(Data2),IfThen(CavalloMezzanotte,'si','no')]),'',Prog);
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Inserimento pianificazione per il %s: orario %s, turno %s',[DateToStr(Data1),Orario,IntToStr(Turno)]),'',Prog);
      // nessuna pianificazione esistente
      // pianifica l'orario sul giorno indicato
      selT080Ins.Append;
      selT080Ins.FieldByName('PROGRESSIVO').AsInteger:=Prog;
      selT080Ins.FieldByName('DATA').AsDateTime:=Es.FDay;
      selT080Ins.FieldByName('ORARIO').AsString:=Orario;
      selT080Ins.FieldByName('TURNO1').AsInteger:=Turno;
      if CavalloMezzanotte then
        selT080Ins.FieldByName('TURNO1EU').AsString:='E';
      selT080Ins.Post;
      if CavalloMezzanotte then
      begin
        // pianifica l'orario anche sul giorno successivo
        selT080Ins.Append;
        selT080Ins.FieldByName('PROGRESSIVO').AsInteger:=Prog;
        selT080Ins.FieldByName('DATA').AsDateTime:=Es.FDay + 1;
        selT080Ins.FieldByName('ORARIO').AsString:=Orario;
        selT080Ins.FieldByName('TURNO1').AsInteger:=Turno;
        selT080Ins.FieldByName('TURNO1EU').AsString:='U';
        selT080Ins.Post;
      end;
    end
    else if selT080Ins.RecordCount = 1 then
    begin
      // pianificazione già esistente (turno notturno che scavalca sul giorno successivo)
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Pianificazione %s - %s esistente - cavallo di mezzanotte: %s',[DateToStr(Data1),DateToStr(Data2),IfThen(CavalloMezzanotte,'si','no')]),'',Prog);
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Modifica pianificazione per il %s: turno2 %s',[selT080Ins.FieldByName('DATA').AsString,IntToStr(Turno)]),'',Prog);
      if (Orario = selT080Ins.FieldByName('ORARIO').AsString) and
         (selT080Ins.FieldByName('TURNO2').IsNull) then
      begin
        selT080Ins.Edit;
        selT080Ins.FieldByName('TURNO2').AsInteger:=Turno;
        if CavalloMezzanotte then
          selT080Ins.FieldByName('TURNO2EU').AsString:='E';
        selT080Ins.Post;

        if CavalloMezzanotte then
        begin
          // pianifica l'orario anche sul giorno successivo
          selT080Ins.Append;
          selT080Ins.FieldByName('PROGRESSIVO').AsInteger:=Prog;
          selT080Ins.FieldByName('DATA').AsDateTime:=Es.FDay + 1;
          selT080Ins.FieldByName('ORARIO').AsString:=Orario;
          selT080Ins.FieldByName('TURNO2').AsInteger:=Turno;
          selT080Ins.FieldByName('TURNO2EU').AsString:='U';
          selT080Ins.Post;
        end;
      end;
    end;

    SIW.SessioneOracle.Commit;
    RisultatoStd.AddResultOk;
    TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Inserimento turno',[]),'',Prog);
  end;
  procedure AcceptT380;
  begin
    with insT380 do
    begin
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DATA',ES.FDay);
      SetVariable('INIZIO',EMin);
      SetVariable('FINE',UMin);
      Execute;
      if VarToStr(GetVariable('TURNO')) = '' then
        raise Exception.Create(Format('Turno di reperibilità non trovato: progressivo %d, data %s, inizio %s, fine %s',[Prog,FormatDateTime('dd/mm/yyyy',Es.FDay),Entrata,Uscita]))
      else
        TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Inserimento turno di reperibilità: codice %s, data %s, inizio %s, fine %s',[VarToStr(GetVariable('TURNO')),FormatDateTime('dd/mm/yyyy',Es.FDay),Entrata,Uscita]),'',Prog);
    end;
    SIW.SessioneOracle.Commit;
    RisultatoStd.AddResultOk;
  end;
begin
  Result:=nil;
  Turni:=TTurni(RevertJSON(JObject));
  selProg.ClearVariables;

  TRegistraMsg(SIW.RegistraMsg).SessioneOracleApp:=SIW.SessioneOracle;
  TRegistraMsg(SIW.RegistraMsg).IniziaMessaggio('B021');
  TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('B021FTurni.AcceptDato - Numero turni: %d',[High(Turni.FShifts)]),'');

  // ciclo di inserimento turni
  for i:=0 to High(Turni.FShifts) do
  begin
    S:=Turni.FShifts[i];
    RisultatoStd.Input:=S.ToString;

    selProg.SetVariable('MATRICOLA',S.FId);
    selProg.Execute;
    if selProg.RowCount = 0 then
    begin
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Matricola inesistente: %s',[S.FId]),'');
      raise EC200InvalidParameter.Create('Matricola inesistente: ' + S.FId);
    end
    else
    begin
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Inserimento n. %d turni: inizio',[High(S.FEmployeeShifts)]),'',Prog);
      Prog:=selProg.FieldAsInteger(0);

      if TipoTurni = 'T080' then
      begin
        // controllo blocco riepiloghi pianificazione orari
        if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Turni.FStart),'T080') then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FStart))]),'',Prog);
          raise Exception.Create(Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FStart))]));
        end;
        if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Turni.FEnd),'T080') then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FEnd))]),'',Prog);
          raise Exception.Create(Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FEnd))]));
        end;
        // imposta variabile progressivo sui dataset di supporto
        selOrario.Close;
        selOrario.SetVariable('FILTRO','AND T030.PROGRESSIVO = ' + IntToStr(Prog));

        selT080Ins.Close;
        selT080Ins.SetVariable('PROG',Prog);

        // elimina eventuali pianificazioni esistenti nel periodo
        delT080.SetVariable('PROGRESSIVO',Prog);
        delT080.SetVariable('DATA1',Turni.FStart);
        delT080.SetVariable('DATA2',Turni.FEnd);
        delT080.Execute;
        SIW.SessioneOracle.Commit;
      end
      else if TipoTurni = 'T380' then
      begin
        // controllo blocco riepiloghi pianificazione reperibilità
        if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Turni.FStart),'T380') then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T380] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FStart))]),'',Prog);
          raise Exception.Create(Format('[T380] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FStart))]));
        end;
        if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Turni.FEnd),'T380') then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T380] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FEnd))]),'',Prog);
          raise Exception.Create(Format('[T380] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Turni.FEnd))]));
        end;
      end;


      // inserimento turni per dipendente indicato
      for j:=0 to High(S.FEmployeeShifts) do
      begin
        ES:=S.FEmployeeShifts[j];
        try
          RisultatoStd.Input:=S.ToString + '|' + ES.ToString;

          // salva entrata/uscita in variabili
          EMin:=R180OreMinuti(ES.FShiftStart);
          Entrata:=R180MinutiOre(Emin);
          UMin:=R180OreMinuti(ES.FShiftEnd);
          Uscita:=R180MinutiOre(UMin);

          // determina se il turno è a cavallo di mezzanotte
          CavalloMezzanotte:=UMin < EMin;

          if (TipoTurni = 'T080') and (not ES.FOnCall) then
            AcceptT080
          else if (TipoTurni = 'T380') and ES.FOnCall then //Turno di reperibilità
            AcceptT380;
        except
          on E: Exception do
          begin
            //raise EC200ExecutionError.Create('Errore durante inserimento turni: ' + E.Message);
            Errori:=Errori + 'Errore durante inserimento turni: ' + E.Message + CRLF;
          end;
        end;
      end;
    end;
  end;
  if Errori <> '' then
    raise Exception.Create(Errori);
end;

function TB021FTurniDM.UpdateDato: TJSONObject;
var
  Turni: TTurni;
  S: TShift;
  ES: TEmployeeShift;
  i,j,Prog: Integer;
begin
  Result:=nil;
  Turni:=TTurni(RevertJSON(JObject));
  selProg.ClearVariables;

  // ciclo di update turni
  for i:=0 to High(Turni.FShifts) do
  begin
    S:=Turni.FShifts[i];
    RisultatoStd.Input:=S.ToString;

    selProg.SetVariable('MATRICOLA',S.FId);
    selProg.Execute;
    if selProg.RowCount = 0 then
      raise EC200InvalidParameter.Create('Matricola inesistente: ' + S.FId)
    else
    begin
      Prog:=selProg.FieldAsInteger(0);

      if TipoTurni = 'T080' then
        // update turni per dipendente indicato
        updT080.SetVariable('PROGRESSIVO',Prog);
      for j:=0 to High(S.FEmployeeShifts) do
      begin
        ES:=S.FEmployeeShifts[j];
        if (TipoTurni = 'T080') and (not ES.FOnCall) then
        try
          RisultatoStd.Input:=S.ToString + '|' + ES.ToString;
          updT080.SetVariable('DATA',ES.FDay);
          updT080.SetVariable('ORARIO',ES.FShiftName);
          updT080.SetVariable('TURNO1',null);
          updT080.SetVariable('TURNO2',null);
          updT080.Execute;
          SIW.SessioneOracle.Commit;
          if updT080.RowsProcessed = 0 then
            RisultatoStd.AddWarning('Pianificazione da aggiornare inesistente')
          else
            RisultatoStd.AddResultOk;
        except
          on E: Exception do
          begin
            raise EC200ExecutionError.Create('Errore durante aggiornamento turni: ' + E.Message);
          end;
        end;
      end;
    end;
  end;
end;

function TB021FTurniDM.CancelDato: TJSONObject;
var
  Prog: Integer;
  procedure CancelT080;
  begin
    // controllo blocco riepiloghi
    if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Inizio),'T080') then
    begin
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Inizio))]),'',Prog);
      raise Exception.Create(Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Inizio))]));
    end;
    if selDatiBloccati.DatoBloccato(Prog,R180InizioMese(Fine),'T080') then
    begin
      TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Fine))]),'',Prog);
      raise Exception.Create(Format('[T080] Blocco riepiloghi attivo: %s',[DateToStr(R180InizioMese(Fine))]));
    end;

    try
      // cancellazione
      delT080.SetVariable('PROGRESSIVO',Prog);
      delT080.SetVariable('DATA1',Inizio);
      delT080.SetVariable('DATA2',Fine);
      delT080.Execute;
      SIW.SessioneOracle.Commit;
      if delT080.RowsProcessed = 0 then
      begin
        RisultatoStd.AddWarning('Nessuna pianificazione da eliminare nel periodo ' + ConvertiDateStr(Inizio) +  ' - ' + ConvertiDateStr(Fine));
        TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Cancellazione turni nel periodo %s - %s: nessun turno da eliminare',[DateToStr(Inizio),DateToStr(Fine)]),'',Prog);
      end
      else
      begin
        RisultatoStd.AddResultOk;
        TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Cancellazione turni nel periodo %s - %s eseguita',[DateToStr(Inizio),DateToStr(Fine)]),'',Prog);
      end;
    except
      on E: Exception do
      begin
        TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Errore durante cancellazione turni nel periodo %s - %s: %s',[DateToStr(Inizio),DateToStr(Fine),E.Message]),'',Prog);
        raise EC200ExecutionError.Create('Errore durante cancellazione turni: ' + E.Message);
      end;
    end;
  end;
  procedure CancelT380;
  begin
  end;
begin
  Result:=nil;

  selProg.ClearVariables;
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
  begin
    TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Matricola inesistente: %s',[Matricola]),'');
    raise EC200InvalidParameter.Create('Matricola inesistente: ' + Matricola);
  end
  else
    Prog:=selProg.FieldAsInteger(0);

  if TipoTurni = 'T080' then
    CancelT080
  else if TipoTurni = 'T380' then
    CancelT380;
end;

end.

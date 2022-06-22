unit B021UGiustificativiDM;

interface

uses
  R014URestDM, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione,
  C200UWebServicesTypes, B021UUtils, Math, A004UGiustifAssPresMW,
  C180FunzioniGenerali, SysUtils, Variants, Classes, Controls,
  Oracle, DB, OracleData, RegistrazioneLog;

type
  TGiustificativo = class(TPersistent)
  private
    FRichiesta: Boolean; // True se da T050, False se da T040
    FMatricola: String;
    FCausale: String;
    FDataInizio: TDateTime;
    FDataFine: TDateTime;
    FDalle: String;
    FAlle: String;
    FDataFamiliare: TDateTime;
    FAutorizzatore: String;
  end;

  TAssenze = class(TPersistent)
  private
    FDataInizio,
    FDataFine: TDateTime;
    FGiustificativi: array of TGiustificativo;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddGiustificativo(G: TGiustificativo);
  end;

  TB021FGiustificativiDM = class(TR014FRestDM)
    selGiust: TOracleDataSet;
  private
    Matricola: String;
    Inizio: TDateTime;
    Fine: TDateTime;
    Causale: String;
    function GetGiustificativi(Matricola: String; Inizio,Fine: TDateTime): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function RevertJSON(PJson: TJSONObject): TPersistent; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function AcceptDato: TJSONObject; override;
    function GetDato: TJSONObject; override;
    function CancelDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

constructor TAssenze.Create;
begin
  SetLength(FGiustificativi,0);
end;

destructor TAssenze.Destroy;
begin
  SetLength(FGiustificativi,0);
  inherited;
end;

procedure TAssenze.AddGiustificativo(G: TGiustificativo(*TJustification*));
begin
  SetLength(FGiustificativi,Length(FGiustificativi) + 1);
  FGiustificativi[High(FGiustificativi)]:=G;
end;

//**********************************************************

function TB021FGiustificativiDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  Ass: TAssenze;
  GiustArr: TJSONArray;
  hObj: TJSONObject;
  Giust: TGiustificativo;
  i: Integer;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  Ass:=TAssenze(PObj);

  Result:=TJSONObject.Create;
  Result.AddPair('dataInizio',TJSONString.Create(ConvertiDateStr(Ass.FDataInizio)));
  Result.AddPair('dataFine',TJSONString.Create(ConvertiDateStr(Ass.FDataFine)));
  GiustArr:=TJSONArray.Create;
  for i:=0 to High(Ass.FGiustificativi) do
  begin
    Giust:=Ass.FGiustificativi[i];
    hObj:=TJSONObject.Create;
    if Giust.FRichiesta then
      hObj.AddPair('richiesta',TJSONTrue.Create)
    else
      hObj.AddPair('richiesta',TJSONFalse.Create);
    hObj.AddPair('matricola',TJSONString.Create(Giust.FMatricola));
    hObj.AddPair('causale',TJSONString.Create(Giust.FCausale));
    hObj.AddPair('data',TJSONString.Create(ConvertiDateStr(Giust.FDataInizio)));
    hObj.AddPair('dalle',TJSONString.Create(Giust.FDalle));
    hObj.AddPair('alle',TJSONString.Create(Giust.FAlle));

    GiustArr.Add(hObj);
  end;
  Result.AddPair('giustificativi',GiustArr);
end;

function TB021FGiustificativiDM.RevertJSON(PJson: TJSONObject): TPersistent;
var
  jPairGiust: TJSONPair;
  i: Integer;
begin
  // creazione oggetto Giustificativo
  Result:=TGiustificativo.Create;
  try
    for i:=0 to PJson.Size - 1  do
    begin
      jPairGiust:=TJSONPair(PJson.Get(i));

      if jPairGiust.JsonString.Value = 'richiesta' then
        TGiustificativo(Result).FRichiesta:=jPairGiust.JsonValue is TJSONTrue
      else if jPairGiust.JsonString.Value = 'matricola' then
        TGiustificativo(Result).FMatricola:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'causale' then
        TGiustificativo(Result).FCausale:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'dataInizio' then
        ConvertiStrDate(jPairGiust.JsonValue.Value,TGiustificativo(Result).FDataInizio)
      else if jPairGiust.JsonString.Value = 'dataFine' then
        ConvertiStrDate(jPairGiust.JsonValue.Value,TGiustificativo(Result).FDataFine)
      else if jPairGiust.JsonString.Value = 'dalle' then
        TGiustificativo(Result).FDalle:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'alle' then
        TGiustificativo(Result).FAlle:=jPairGiust.JsonValue.Value
      else if jPairGiust.JsonString.Value = 'dataFamiliare' then
        ConvertiStrDateTime(jPairGiust.JsonValue.Value,TGiustificativo(Result).FDataFamiliare)
      else if jPairGiust.JsonString.Value = 'autorizzatore' then
        TGiustificativo(Result).FAutorizzatore:=jPairGiust.JsonValue.Value;
    end;
  except
    on E: Exception do
      raise EC200UnmarshallingError.Create('Errore di conversione: ' + E.Message);
  end;
end;

function TB021FGiustificativiDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  G: TGiustificativo;
  TempStr: String;
begin
  RErrMsg:='';

  if (Operazione = OPER_READ) or (Operazione = OPER_DELETE) then
  begin
    Result:=False;
    // controllo parametri get
    Matricola:=GetParam('matricola');

    TempStr:=GetParam('inizio');
    if not ConvertiStrDate(TempStr,Inizio) then
    begin
      RErrMsg:='Parametro data inizio non valido: ' + TempStr;
      Exit;
    end;

    TempStr:=GetParam('fine');
    if not ConvertiStrDate(TempStr,Fine) then
    begin
      RErrMsg:='Parametro data fine non valido: ' + TempStr;
      Exit;
    end;

    if Fine < Inizio then
    begin
      RErrMsg:='Parametro data fine (' + ConvertiDateStr(Fine) + ') precedente a parametro data inizio (' + ConvertiDateStr(Inizio) + ')';
      Exit;
    end;

    if Operazione = OPER_DELETE then
    begin
      Causale:=GetParam('causale');
    end;
  end
  else if Operazione = OPER_CREATE then
  begin
    Result:=False;
    // controllo postdata in ingresso
    G:=TGiustificativo(RevertJSON(JObject));
    if G.FMatricola = '' then
    begin
      RErrMsg:='Matricola non indicata';
      Exit;
    end;
    if G.FCausale = '' then
    begin
      RErrMsg:='Causale non indicata';
      Exit;
    end;
    if G.FDataInizio = 0 then
    begin
      RErrMsg:='Data inizio non indicata';
      Exit;
    end;
    if G.FDataFine = 0 then
    begin
      RErrMsg:='Data fine non indicata';
      Exit;
    end;
    if G.FDataFine < G.FDataInizio then
    begin
      RErrMsg:='Periodo inizio - fine indicato non valido';
      Exit;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TB021FGiustificativiDM.GetGiustificativi(Matricola: String; Inizio,Fine: TDateTime): TJSONObject;
var
  Ass: TAssenze;
  NumGG: Integer;
  TG: String;
  Giust: TGiustificativo;
  Progressivo: Integer;
begin
  // verifica esistenza matricola
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
    raise EC200DataNotFoundError.Create(Format('Matricola %s inesistente',[Matricola]))
  else
    Progressivo:=selProg.FieldAsInteger(0);

  selGiust.Close;
  selGiust.SetVariable('PROGRESSIVO',Progressivo);
  selGiust.SetVariable('INIZIO',Inizio);
  selGiust.SetVariable('FINE',Fine);
  NumGG:=Trunc(Fine - Inizio);
  // oltre una certa soglia di giorni il readbuffer è calcolato con un coefficiente basato su una media
  selGiust.ReadBuffer:=IfThen(NumGG > 60,Trunc(NumGG * 0.3),NumGG);
  selGiust.Open;

  Ass:=TAssenze.Create;
  try
    Ass.FDataInizio:=Inizio;
    Ass.FDataFine:=Fine;
    while not selGiust.Eof do
    begin
      Giust:=TGiustificativo.Create;
      Giust.FRichiesta:=selGiust.FieldByName('TIPORECORD').AsString = 'T050';
      Giust.FMatricola:=Matricola;
      Giust.FCausale:=selGiust.FieldByName('CAUSALE').AsString;
      Giust.FDataInizio:=selGiust.FieldByName('DATA').AsDateTime;
      TG:=selGiust.FieldByName('TIPOGIUST').AsString;
      if TG = 'I' then
        Giust.FDalle:=''
      else
      begin
        Giust.FDalle:=FormatDateTime(FIRLAB_TIME_FMT,selGiust.FieldByName('DAORE').AsDateTime);
        if TG = 'D' then
          Giust.FAlle:=FormatDateTime(FIRLAB_TIME_FMT,selGiust.FieldByName('AORE').AsDateTime)
        else
          Giust.FAlle:='';
      end;

      Ass.AddGiustificativo(Giust);
      selGiust.Next;
    end;

    Result:=ConvertJSON(Ass);
  finally
    FreeAndNil(Ass);
  end;
end;

function TB021FGiustificativiDM.GetDato: TJSONObject;
begin
  Result:=GetGiustificativi(Matricola,Inizio,Fine);
end;

function TB021FGiustificativiDM.AcceptDato: TJSONObject;
var
  i,Prog: Integer;
  A004MW: TA004FGiustifAssPresMW;
  G: TGiustificativo;
  Modo: Char;
begin
  Result:=nil;
  G:=TGiustificativo(RevertJSON(JObject));
  Prog:=-1;
  selProg.ClearVariables;

  TRegistraMsg(SIW.RegistraMsg).SessioneOracleApp:=SIW.SessioneOracle;
  TRegistraMsg(SIW.RegistraMsg).IniziaMessaggio('B021');
  TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('B021FGiustificativi.AcceptDato - Matricola:%s - Causale:%s - DataInizio:%s - DataFine:%s - Dalle:%s - Alle:%s - Familiare:%s',[G.FMatricola,G.FCausale,DateToStr(G.FDataInizio),DateToStr(G.FDataFine),G.FDalle,G.FAlle,DateToStr(G.FDataFamiliare)]),'');
  // creazione datamodulo per gestione giustificativi
  A004MW:=TA004FGiustifAssPresMW.Create(SIW);
  try
    try
      if G.FMatricola <> VarToStr(selProg.GetVariable('MATRICOLA')) then
      begin
        selProg.SetVariable('MATRICOLA',G.FMatricola);
        selProg.Execute;
        if selProg.RowCount = 0 then
        begin
          TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Matricola inesistente: %s',[G.FMatricola]),'');
          raise EC200InvalidParameter.Create('Matricola inesistente: ' + G.FMatricola);
        end
        else
          Prog:=selProg.FieldAsInteger(0);
      end;

      with A004MW do
      begin
        // controllo esistenza causale
        if not R600DtM1.Q265.SearchRecord('CODICE',G.FCausale,[srFromBeginning]) then
          raise EC200DataNotFoundError.Create('Causale di assenza inesistente: ' + G.FCausale);

        Q040.Close;
        Q040.SetVariable('PROGRESSIVO',Prog);
        Q040.Open;

        chkNuovoPeriodo:=False;
        GestioneSingolaDM:=True;
        AnomalieInterattive:=False;
        R600DtM1.VisualizzaAnomalie:=False;
        R600DtM1.AnomalieBloccanti:=True;
        R600DtM1.AnomalieNonBloccanti:='1';
        //***ProgressBar:=nil;

        Var_Gestione:=0;
        Var_TipoCaus:=1;//IfThen(TipoCausale = tcAssenza,1,2);
        Var_TipoGiust_Count:=4;//IfThen(TipoCausale = tcAssenza,4,2);
        {
        if sTipo[1] = SelI150.FieldByName('CODICE_TIPOI').AsString then
          Var_TipoGiust:=0
        else if sTipo[1] = SelI150.FieldByName('CODICE_TIPOM').AsString then
          Var_TipoGiust:=1
        else if sTipo[1] = SelI150.FieldByName('CODICE_TIPON').AsString then
          Var_TipoGiust:=2 - IfThen(TipoCausale = tcAssenza,0,2)
        else if sTipo[1] = SelI150.FieldByName('CODICE_TIPOD').AsString then
          Var_TipoGiust:=3 - IfThen(TipoCausale = tcAssenza,0,2);
        }

        //Modo:=R180CarattereDef(G.FTipoGiust);
        if (G.FDalle <> '') and (G.FAlle <> '') then
          Modo:='D'
        else
          Modo:='I';

        if Modo = 'I' then
          Var_TipoGiust:=0
        else if Modo = 'M' then
          Var_TipoGiust:=1
        else if Modo = 'N' then
          Var_TipoGiust:=2
        else
          Var_TipoGiust:=3;

        Var_DaOre:=StringReplace(G.FDalle,':','.',[]); //sOraDa;
        Var_AOre:=StringReplace(G.FAlle,':','.',[]); //sOraA;
        Var_NumGG:=0;
        Var_DaData:=ConvertiDateStr(G.FDataInizio); //sDataDa;
        Var_AData:=ConvertiDateStr(G.FDataFine); //sDataA;
        Var_Causale:=G.FCausale; //sCausale;
        Var_Progressivo:=Prog;

        Giustif.Causale:=G.FCausale;
        Giustif.Inserimento:=True;
        Giustif.Modo:=Modo; //sTipo[1];
        Giustif.DaOre:=Var_DaOre; //sOraDa;
        Giustif.AOre:=Var_AOre; //sOraA;

        DataInizio:=G.FDataInizio; //StrToDate(sDataDa);
        DataFine:=G.FDataFine; //StrToDate(sDataA);
        DataInizioOrig:=G.FDataInizio; //DataInizio;
        B021Autorizzatore:=G.FAutorizzatore;
        Chiamante:='B021'; //????
        {if (SelI150.FieldByName('TIPO_OPERAZIONE').AsString = '') or
           (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'I') then
        }
        if Operazione = OPER_CREATE then
        begin
          InserisciGiustif(False);

          //if R600DtM1.EsistonoAnomalieBloccanti then
          if R600DtM1.ListAnomalie.Count > 0 then
          begin
            for i:=0 to R600DtM1.ListAnomalie.Count - 1 do
            begin
              //Risultato.AddError('ERR',R600DtM1.ListAnomalie[i]);
              TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',R600DtM1.ListAnomalie[i],'',Prog);
            end;
            raise Exception.Create(R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie));
          end
          else
          begin
            RisultatoStd.AddResultOk;
            TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('I',Format('Inserimento giustificativo',[]),'',Prog);
          end;
          {
          for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
            RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
          for I := 0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
            RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[I],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
          }
        end
        {
        else if ((bAnomalia) and (SelI150.FieldByName('ANOMALIE_BLOCCANTI').AsString = 'S')) or
                (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'C') then
        begin
          CancellaGiustif(False,False);
          for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
            RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
        end;
        }
        else if Operazione = OPER_DELETE then
        begin
          CancellaGiustif(False,False);
          RisultatoStd.AddResultOk;
        end;
      end;
    except
      on E: Exception do
      begin
        TRegistraMsg(SIW.RegistraMsg).InserisciMessaggio('A',Format('Inserimento fallito:%s',[E.Message]),'',Prog);
        raise EC200ExecutionError.Create('Errore durante inserimento giustificativi: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(A004MW);
  end;
end;

function TB021FGiustificativiDM.CancelDato: TJSONObject;
var
  Prog: Integer;
  D: TDateTime;
  A004MW: TA004FGiustifAssPresMW;
  Modo: Char;
begin
  Result:=nil;
  selProg.ClearVariables;
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
    raise EC200InvalidParameter.Create('Matricola inesistente: ' + Matricola)
  else
    Prog:=selProg.FieldAsInteger(0);

  // creazione datamodulo per cancellazione giustificativi
  A004MW:=TA004FGiustifAssPresMW.Create(SIW);
  try
    try
      // ciclo di inserimento giustificativi
      D:=Inizio;
      while D <= Fine do
      begin
        with A004MW do
        begin
          Q040.Close;
          Q040.SetVariable('PROGRESSIVO',Prog);
          Q040.Open;

          chkNuovoPeriodo:=False;
          GestioneSingolaDM:=True;
          AnomalieInterattive:=False;
          R600DtM1.VisualizzaAnomalie:=False;
          R600DtM1.AnomalieBloccanti:=True;
          R600DtM1.AnomalieNonBloccanti:='1';
          //***ProgressBar:=nil;

          Var_Gestione:=0;
          Var_TipoCaus:=1;//IfThen(TipoCausale = tcAssenza,1,2);
          Var_TipoGiust_Count:=4;//IfThen(TipoCausale = tcAssenza,4,2);
          {
          if sTipo[1] = SelI150.FieldByName('CODICE_TIPOI').AsString then
            Var_TipoGiust:=0
          else if sTipo[1] = SelI150.FieldByName('CODICE_TIPOM').AsString then
            Var_TipoGiust:=1
          else if sTipo[1] = SelI150.FieldByName('CODICE_TIPON').AsString then
            Var_TipoGiust:=2 - IfThen(TipoCausale = tcAssenza,0,2)
          else if sTipo[1] = SelI150.FieldByName('CODICE_TIPOD').AsString then
            Var_TipoGiust:=3 - IfThen(TipoCausale = tcAssenza,0,2);
          }

          // verificare.ini
          // 1/2 giornata????
          {
          if G.FStart = 0 then
          begin
            Var_TipoGiust:=0;
            Modo:='I';
          end
          else if G.FEnd = 0 then
          begin
            Var_TipoGiust:=2;
            Modo:='N';
          end
          else
          begin
            Var_TipoGiust:=3;
            Modo:='D';
          end;
          }
          Var_TipoGiust:=0;
          Modo:='I';
          // verificare.fine


          Var_DaOre:=''; //sOraDa;
          Var_AOre:=''; //sOraA;
          Var_NumGG:=0;
          Var_DaData:=DateToStr(D); //sDataDa;
          Var_AData:=DateToStr(D); //sDataA;
          Var_Causale:=Causale; //sCausale;
          Var_Progressivo:=Prog;

          //Alberto 07/03/2014: gestione particolare di causale 99001 che ha sempre TIPOGIUST = 'N'
          if Causale = '99001' then
          begin
            Var_TipoGiust:=2;
            Modo:='N';
            Var_DaOre:='00.00';
          end;

          Giustif.Causale:=Causale;
          Giustif.Inserimento:=True;
          Giustif.Modo:=Modo; //sTipo[1];
          Giustif.DaOre:=Var_DaOre; //sOraDa;
          Giustif.AOre:=Var_AOre; //sOraA;

          DataInizio:=D; //StrToDate(sDataDa);
          DataFine:=D; //StrToDate(sDataA);
          DataInizioOrig:=D; //DataInizio;
          Chiamante:='B021';
          {if (SelI150.FieldByName('TIPO_OPERAZIONE').AsString = '') or
             (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'I') then

          begin
            InserisciGiustif(False);
            for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
              RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
            for I := 0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
              RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[I],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
          end
          else if ((bAnomalia) and (SelI150.FieldByName('ANOMALIE_BLOCCANTI').AsString = 'S')) or
                  (selGiustif.FieldByName(SelI150.FieldByName('TIPO_OPERAZIONE').AsString).AsString = 'C') then
          begin
            CancellaGiustif(False,False);
            for I := 0 to R600DtM1.ListAnomalie.Count - 1 do
              RegistraMsg.InserisciMessaggio('A',R600DtM1.ListAnomalie[i],selI090.FieldByName('AZIENDA').AsString,nProgressivo);
          end;
          }
          CancellaGiustif(False,False);
        end;
        D:=D + 1;
      end;
    except
      on E: Exception do
      begin
        raise EC200ExecutionError.Create('Errore durante cancellazione giustificativi: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(A004MW);
  end;
end;

end.

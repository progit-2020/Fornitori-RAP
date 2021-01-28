unit A095UStRiasStrMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, Oracle, DatiBloccati,A000UInterfaccia,
  USelI010, A029ULiquidazione, A029UBudgetDtM1,R450, DBClient, C180FunzioniGenerali,
  A000UMessaggi;

type
  TA095FStRiasStrMW = class(TR005FDataModuleMW)
    selT810: TOracleDataSet;
    selT810VALORE: TStringField;
    selT800_data: TOracleDataSet;
    selT800_dataNOMECAMPO1: TStringField;
    selT800_dataNOMECAMPO2: TStringField;
    selT811: TOracleDataSet;
    selT811VALORE: TStringField;
    selT075: TOracleDataSet;
    selT820: TOracleDataSet;
    selT071: TOracleDataSet;
    selT071_Data: TOracleQuery;
    updT071: TOracleQuery;
    QCols: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure Liquidazione(const PModalitaSimulazione: Boolean; Prog, Liq: Integer; Data: TDateTime; TipoDisponibilita: Integer);
    procedure InserisciRecord(Data: TDateTime; TipoDisponibilita: Integer;bLiquidazione: Boolean);
  public
    DNomeCampo:TStringList;
    DNomeLogico:TStringList;
    INomeCampo:TStringList;
    INomeLogico:TStringList;

    selI010:TselI010;
    A029FLiquidazione: TA029FLiquidazione;
    R450DtM1:TR450DtM1;
    LstCampiIntestazioneAnagrafe,
    LstCampiDettaglioAnagrafe: TStringList;
    selDatiBloccati:TDatiBloccati;
    procedure CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
    procedure SettaVariabiliDataset(Anno, Mese: Integer);
    procedure ElaboraDipendente(Anno, Mese, TipoDisponibilita: Integer; bLiquidazione: Boolean);
    function SettaCampiSelAnagrafe(SqlSelAnagrafe: String; Anno: Integer; LstIntestazione, LstDettaglio: TStringList): String;
    procedure PreparaAggiornaFruitoBudget(Data: TDateTime);
    function ControlloLiquid(selAnag: TOracleDataSet; Anno,Mese: Integer): TDateTime;
    procedure ApriSelT071(DataLiq: TDateTime; Anno, Mese: Integer;bDataDal: boolean);
    procedure ElaboraAnnullaLiquidazione(DataLiq: TDateTime);
  end;

implementation

{$R *.dfm}

procedure TA095FStRiasStrMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  QCols.Open;
  R450DtM1:=TR450DtM1.Create(nil);
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FLiquidazione.R450DtM:=R450DtM1;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  INomeCampo:=TStringList.Create;
  INomeLogico:=TStringList.Create;
  DNomeCampo:=TStringList.Create;
  DNomeLogico:=TStringList.Create;

  LstCampiIntestazioneAnagrafe:=TStringList.Create;
  LstCampiDettaglioAnagrafe:=TStringList.Create;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  with selI010 do
  begin
    while not Eof do
    begin
      if Copy(FieldByname('NOME_CAMPO').AsString,1,6) <> 'T430D_' then
        LstCampiIntestazioneAnagrafe.Add(FieldByname('NOME_LOGICO').AsString);
      LstCampiDettaglioAnagrafe.Add(FieldByname('NOME_LOGICO').AsString);
      Next;
    end;
  end;
end;

//per WebPJ OrdinaDettaglio a True
procedure TA095FStRiasStrMW.CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
var Chiave,D_C:String;
    i,L:Integer;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  Chiave:='';
  for i:=0 to DNomeCampo.Count - 1 do
  begin
    D_C:=DNomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      if OrdinaDettaglio then
      begin
        if Chiave <> '' then
          Chiave:=Chiave + ';';
        Chiave:=Chiave + D_C;
      end;
      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
  end;

  try
    TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('StrLiq',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('MaxLiq',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('MaxRes',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('TotStrF',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('StrIn',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('StrPag',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('EccRes',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Anomalia',ftString,1,False);
  except
  end;

  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      if Chiave <> '' then
        Chiave:=Chiave + ';';
      Chiave:=Chiave + D_C;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
    Insert('D_',D_C,5);
    try
      TabellaStampa.FieldDefs.Add(D_C,ftString,40,False);
    except
    end;
  end;

  if Chiave <> '' then
    Chiave:=Chiave + ';';
  Chiave:=Chiave + 'Cognome;Nome;Matricola';
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Progressivo'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('Secondario',(Chiave),[]);
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
  TabellaStampa.IndexName:='Secondario';

  //display label per webPJ
  for i:=0 to DNomeCampo.Count - 1 do
    try
      TabellaStampa.FieldByName(DNomeCampo[i]).DisplayLabel:=R180Capitalize(DNomeLogico[i]);
    except
    end;
end;

procedure TA095FStRiasStrMW.Liquidazione(const PModalitaSimulazione: Boolean; Prog,Liq:LongInt; Data:TDateTime;TipoDisponibilita:Integer);
{Liquidazione delle ore indicate}
var i,L,j:Integer;
    tliquidabile,tliquidato:array [1..MaxFasce] of LongInt;
begin
  //Salvataggio situazione straordinario
  for j:=1 to MaxFasce do
  begin
    if TipoDisponibilita = 0 then
    begin
      tliquidabile[j]:=R450DtM1.tstrmese[j];
      tliquidato[j]:=R450DtM1.tLiqNelMese[j];
      for i:=0 to High(R450DtM1.RiepPres) do
      begin
        if VarToStr(R450DtM1.selT275.Lookup('CODICE',R450DtM1.RiepPres[i].Causale,'ORENORMALI')) <> 'A' then
          inc(tliquidato[j],R450DtM1.RiepPres[i].LiquidatoMese[j]);
      end;
    end
    else
    begin
      tliquidabile[j]:=R450DtM1.tstrannom[j];
      tliquidato[j]:=R450DtM1.tstrliq[j];
    end;
  end;
  A029FLiquidazione.Q071Liq.SetVariable('Progressivo',Prog);
  with R450DtM1 do
  begin
    for i:=NFasceMese downto 1 do
    begin
      if Liq = 0 then
        Break;
      if TipoDisponibilita = 0 then
      begin
        //Ripristino situazione straordinario
        for j:=1 to MaxFasce do
        begin
          tstrmese[j]:=tliquidabile[j];
          tLiqNelMese[j]:=tliquidato[j];
        end;
        if (tstrmese[i] - tLiqNelMese[i]) > 0 then
        begin
          if (tstrmese[i] - tLiqNelMese[i]) >= Liq then
          begin
            L:=Liq;
            Liq:=0;
          end
          else
          begin
            L:=tstrmese[i] - tLiqNelMese[i];
            dec(Liq,L);
          end;
          A029FLiquidazione.Liquidazione(PModalitaSimulazione,Data,Prog,tmaggioraz[i],L,tfasce[i]);
          if PModalitaSimulazione then
          begin
            // in modalità simulazione carica la struttura dati per calcolare l'importo corrispondente
            A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(TIPOLIQ,tmaggioraz[i],L);
          end
          else
          begin
            // aggiorna la T071 in modalità effettiva
            with updT071 do
            begin
              SetVariable('LIQUIDNELMESE',L);
              SetVariable('PROGRESSIVO',Prog);
              SetVariable('DATA',Data);
              SetVariable('CODFASCIA',tfasce[i]);
              Execute;
            end;
            SessioneOracle.Commit;
          end;
        end;
      end
      else
      begin
        //Ripristino situazione straordinario
        for j:=1 to MaxFasce do
        begin
          tstrannom[j]:=tliquidabile[j];
          tstrliq[j]:=tliquidato[j];
        end;
        if (tstrannom[i] - tstrliq[i]) > 0 then
        begin
          if (tstrannom[i] - tstrliq[i]) >= Liq then
          begin
            L:=Liq;
            Liq:=0;
          end
          else
          begin
            L:=tstrannom[i] - tstrliq[i];
            dec(Liq,L);
          end;
          A029FLiquidazione.Liquidazione(PModalitaSimulazione,Data,Prog,tmaggioraz[i],L,tfasce[i]);
          if PModalitaSimulazione then
          begin
            // in modalità simulazione carica la struttura dati per calcolare l'importo corrispondente
            A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(TIPOLIQ,tmaggioraz[i],L);
          end
          else
          begin
            // aggiorna la T071 in modalità effettiva
            with updT071 do
            begin
              SetVariable('LIQUIDNELMESE',L);
              SetVariable('PROGRESSIVO',Prog);
              SetVariable('DATA',Data);
              SetVariable('CODFASCIA',tfasce[i]);
              Execute;
            end;
            SessioneOracle.Commit;
          end;
        end;
      end;
    end;
  end;
end;

function TA095FStRiasStrMW.SettaCampiSelAnagrafe(SqlSelAnagrafe: String;Anno:Integer; LstIntestazione, LstDettaglio: TStringList): String;
var S,
    CampoLiq1,CampoLiq2,
    CampoRes1,CampoRes2,
    C,D_C:String;
    CambioSelAnagrafe: Boolean;
    i: Integer;
begin
  Result:='';
  CambioSelAnagrafe:=False;
  S:=SqlSelAnagrafe;

  with selT800_Data do
  begin
    // leggo i nomi dei campi di raggruppamento per straordinari liquidabili
    // e residuabili relativi all'anno in esame
    SetVariable('Data',EncodeDate(Anno,1,1));
    SetVariable('Tipo','0');
    Close;
    Open;
    CampoLiq1:=FieldByName('NomeCampo1').AsString;
    if CampoLiq1 <> '' then
       CampoLiq1:='T430'+CampoLiq1;
    CampoLiq2:=FieldByName('NomeCampo2').AsString;
    if CampoLiq2 <> '' then
       CampoLiq2:='T430'+CampoLiq2;

    SetVariable('Tipo','1');
    Close;
    Open;
    CampoRes1:=FieldByName('NomeCampo1').AsString;
    if CampoRes1 <> '' then
      CampoRes1:='T430'+CampoRes1;
    CampoRes2:=FieldByName('NomeCampo2').AsString;
    if CampoRes2 <> '' then
      CampoRes2:='T430'+CampoRes2;
  end;

  if R180InserisciColonna(S,CampoLiq1) then
    CambioSelAnagrafe:=True;
  if R180InserisciColonna(S,CampoLiq2) then
    CambioSelAnagrafe:=True;
  if R180InserisciColonna(S,CampoRes1) then
    CambioSelAnagrafe:=True;
  if R180InserisciColonna(S,CampoRes2) then
    CambioSelAnagrafe:=True;
  INomeCampo.Clear;
  INomeLogico.Clear;
  DNomeCampo.Clear;
  DNomeLogico.Clear;
  for i:=0 to LstIntestazione.Count - 1 do
  begin
    C:=LstIntestazione[i];
    D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
    INomeCampo.Add(D_C);
    INomeLogico.Add(C);
    if R180InserisciColonna(S,D_C) then
      CambioSelAnagrafe:=True;
    Insert('D_',D_C,5);
    if selI010.Locate('NOME_CAMPO',D_C,[]) then
      if R180InserisciColonna(S,D_C) then
        CambioSelAnagrafe:=True;
  end;
  for i:=0 to LstDettaglio.Count - 1 do
  begin
    C:=LstDettaglio[i];
    D_C:=VarToStr(selI010.Lookup('NOME_LOGICO',C,'NOME_CAMPO'));
    DNomeCampo.Add(D_C);
    DNomeLogico.Add(C);
    if R180InserisciColonna(S,D_C) then
      CambioSelAnagrafe:=True;
  end;

  if CambioSelAnagrafe then //se selanagrafe cambiata; restituisco nuova selezione
    Result:=S;
end;

procedure TA095FStRiasStrMW.InserisciRecord(Data:TDateTime; TipoDisponibilita: Integer; bLiquidazione:Boolean);
var D_C,S:string;
    i,StrLiq,SaldoMese,MaxLiq,MaxRes,TotStrF,StrPag,StrIn,EccRes,LiquidatoMese,LiquidatoOri:integer;
    TempDataLiq: TDateTime;
    ImpLiq: Real;
    Esegui: Boolean;
begin
  //Non ci devono essere liquidazioni successive
  if R450DtM1.EsisteLiquidazioneSuccessiva(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data) then
  begin
    MaxRes:=0;
    MaxLiq:=0;
  end
  else
  begin
    A029FLiquidazione.GetOreLiquidate(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data);
    //Limiti mensili
    //MaxLiq:=R450DtM1.StrAutMen + A029FLiquidazione.ResoT074Mese;
    MaxLiq:=R450DtM1.StrAutMen + R450DtM1.OreCausLiqSenzaLimiti;
    MaxRes:=R450DtM1.EccResAutMen;
    //Limite Annuale
    if MaxLiq > (R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno + R450DtM1.LiqNelMese) then
      MaxLiq:=R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno + R450DtM1.LiqNelMese;
    if MaxLiq < 0 then
      MaxLiq:=0;
  end;
  // memorizza limiti massimi
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').Value;
  TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Nome').Value;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Progressivo').Value:=SelAnagrafe.FieldByName('Progressivo').Value;
  TabellaStampa.FieldByName('MaxLiq').Value:=R180MinutiOre(MaxLiq);
  TabellaStampa.FieldByName('MaxRes').Value:=R180MinutiOre(MaxRes);
  TabellaStampa.FieldByName('Anomalia').AsString:='';
  // Sraordinario fatto fuori Centro di Costo
  TotStrF:=R450DtM1.StrEsterno;
  if TipoDisponibilita = 0 then
  //Liquidazione disponibilità mensile
  begin
    //Straordinario disponibile
    StrLiq:=R450DtM1.StrFattoMeseTotale;//(R450DtM1.StrFattoMeseAnno - R450DtM1.LiqNellAnno);
    //Calcolo l'intera eccedenza liquidabile disponibile come il saldo anno
    //all'interno dell'eccedenza liquidabile maturata nel mese
    SaldoMese:=R450DtM1.LiquidabileMensileSenzaLimiti;
    if SaldoMese > R450DtM1.EccedenzaMensile then
      SaldoMese:=R450DtM1.EccedenzaMensile;
    //Calcolo la differenza tra SaldoMese (liquidabile complessivo) e il liquidabile all'interno del budget
    SaldoMese:=SaldoMese - StrLiq;
    if SaldoMese < 0 then
      SaldoMese:=0;
    //Straordinario fatto nel Centro di Costo
    StrIn:=StrLiq - TotStrF;
    //Straordinario già pagato nel mese
    LiquidatoMese:=R450DtM1.LiqNelMese + R450DtM1.totcausliqmm;
    LiquidatoOri:=LiquidatoMese - TotStrF;
    if LiquidatoOri < 0 then
      LiquidatoOri:=0;
    //Tolgo quanto già liquidato dal saldo complessivo e dai saldi Interno/Esterno
    dec(StrLiq,LiquidatoMese);
    if StrLiq < 0 then
      StrLiq:=0;
    if TotStrF > LiquidatoMese then
    begin
      dec(TotStrF,LiquidatoMese);
      LiquidatoMese:=0;
    end
    else
    begin
      dec(LiquidatoMese,TotStrF);
      TotStrF:=0;
    end;
    if StrIn > LiquidatoMese then
      dec(StrIn,LiquidatoMese)
    else
      StrIn:=0;
    //Straordinario liquidabile effettivo
    StrPag:=StrIn;
    if StrPag > (MaxLiq - LiquidatoOri) then
      StrPag:=MaxLiq - LiquidatoOri;
    if StrPag < 0 then
      StrPag:=0;
    inc(StrPag,TotStrF);
    //Registro tutta l'eccedenza liquidabile disponibile, anche fuori budget mensile
    inc(StrLiq,SaldoMese);
    //Eccedenza residua per il mese successivo
    EccRes:=StrLiq - StrPag;
    if EccRes < 0 then
      EccRes:=0
    else if EccRes > MaxRes then
      EccRes:=MaxRes;
  end
  else
  //Liquidazione disponibilità annuale
  begin
    //Straordinario disponibile
    StrLiq:=R450DtM1.StrFattoAnno - R450DtM1.LiqNellAnno;
    StrIn:=StrLiq - TotStrF;
    if StrIn < 0 then
      StrIn:=0;
    //Straordinario liquidabile effettivo
    StrPag:=StrIn;
    //Già liquidato nel mese
    LiquidatoMese:=R450DtM1.LiqNelMese + R450DtM1.totcausliqmm;
    LiquidatoOri:=LiquidatoMese - TotStrF;
    if LiquidatoOri < 0 then
      LiquidatoOri:=0;
    if StrPag > (MaxLiq - LiquidatoOri) then
      StrPag:=MaxLiq - LiquidatoOri;
    if StrPag < 0 then
      StrPag:=0;
    inc(StrPag,TotStrF);
    if StrPag > StrLiq then
      StrPag:=StrLiq;
    //Eccedenza residua per il mese successivo
    EccRes:=StrLiq - StrPag;
    if EccRes < 0 then
      EccRes:=0
    else if EccRes > MaxRes then
      EccRes:=MaxRes;
  end;
  TabellaStampa.FieldByName('StrLiq').Value:=R180MinutiOre(StrLiq);
  TabellaStampa.FieldByName('TotStrF').Value:=R180MinutiOre(TotStrF);
  TabellaStampa.FieldByName('StrIn').Value:=R180MinutiOre(StrIn);
  TabellaStampa.FieldByName('StrPag').Value:=R180MinutiOre(StrPag);
  TabellaStampa.FieldByName('EccRes').Value:=R180MinutiOre(EccRes);
  if (bLiquidazione) and (StrPag > 0) and (not selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,'T071S')) then
  begin
    TempDataLiq:=Data;

    // controlli sul budget
    if Parametri.CampiRiferimento.C2_Facoltativo = '' then
    begin
      Esegui:=True;
    end
    else
    begin
      // simula la liquidazione per calcolare l'importo da confrontare con il budget
      // la funzione carica la struttura dati in A029FBudgetDtM1 per effettuare il calcolo dell'importo
      // richiesto in base alla distribuzione delle ore in fasce
      Liquidazione(True,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,StrPag,TempDataLiq,TipoDisponibilita);
      ImpLiq:=A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,TempDataLiq);

      // controllo sforamento budget
      Esegui:=A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,TempDataLiq,StrPag,ImpLiq);
    end;

    // se è tutto ok effettua la liquidazione
    if Esegui then
    begin
      Liquidazione(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,StrPag,TempDataLiq,TipoDisponibilita);
      RegistraLog.SettaProprieta('M','T071_SCHEDAFASCE',nomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
      RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
      RegistraLog.InserisciDato('LIQUIDNELMESE','',R180MinutiOre(StrPag));
      RegistraLog.RegistraOperazione;
    end
    else
    begin
      // disponibilità non sufficiente: anomalia
      // - segnalare nelal colonna "Anomalia" in stampa con flag = S
      TabellaStampa.FieldByName('Anomalia').AsString:='S';
    end;
  end;

  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    S:=Format('%-*s',[SelAnagrafe.FieldByName(D_C).Size,SelAnagrafe.FieldByName(D_C).AsString]);
    TabellaStampa.FieldByName(D_C).AsString:=S;
    Insert('D_',D_C,5);
    try
      TabellaStampa.FieldByName(D_C).AsString:=SelAnagrafe.FieldByName(D_C).AsString;
    except
    end;
  end;
  for i:=0 to DNomeCampo.Count - 1 do
    TabellaStampa.FieldByName(DNomeCampo[i]).AsString:=SelAnagrafe.FieldByName(DNomeCampo[i]).AsString;
  TabellaStampa.Post;
end;

procedure TA095FStRiasStrMW.ElaboraDipendente(Anno, Mese,TipoDisponibilita: Integer; bLiquidazione:Boolean);
begin
  // eseguo i conteggi del mese
  if (R450DtM1.Progress400 = SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) and (Anno = R450DtM1.Anno400) and (Mese = R450DtM1.Mese400) then
    R450DtM1.ConteggiMese('Generico',Anno,1,0);
  R450DtM1.ConteggiMese('Generico',Anno,Mese,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  if (R450DtM1.ttrovscheda[Mese] = 1) then
    InserisciRecord(EncodeDate(Anno,Mese,1), TipoDisponibilita, bLiquidazione);
end;

procedure TA095FStRiasStrMW.SettaVariabiliDataset(Anno, Mese: Integer);
begin
  selT075.SetVariable('Data',EncodeDate(Anno,Mese,1));
  selT810.SetVariable('Anno',Anno);
  selT810.SetVariable('Mese',Mese);
  selT811.SetVariable('Anno',Anno);
  selT811.SetVariable('Mese',Mese);
  selT820.SetVariable('Anno',Anno);
  selT820.SetVariable('Mese',Mese);
end;

procedure TA095FStRiasStrMW.PreparaAggiornaFruitoBudget(Data: TDateTime);
begin
  //Calcolo il fruito e aggiorno il budget straordinario
  if Parametri.CampiRiferimento.C2_Facoltativo <> '' then
  begin
    A029FLiquidazione.A029FBudgetDtM1.PreparaAggiornaFruitoBudget(Data,'#LIQ#');
    SessioneOracle.Commit;
  end;
end;

function TA095FStRiasStrMW.ControlloLiquid(selAnag: TOracleDataSet;Anno,Mese: Integer): TDateTime;
var S:String;
    P:Integer;
begin
  S:=selAnag.substitutedSQL;
  S:=Copy(S,Pos('FROM',S),Length(S));
  P:=Pos('ORDER BY',S);
  if P > 0 then
    S:=Copy(S,1,P - 1);
  S:=' AND PROGRESSIVO IN (SELECT PROGRESSIVO ' + S + ')';
  if selT071_Data.VariableIndex('C700DATADAL') >= 0 then
    selT071_Data.DeleteVariable('C700DATADAL');
  selT071_Data.SetVariable('FILTRO',S);
  selT071_Data.SetVariable('DATALAVORO',R180FineMese(EncodeDate(Anno,Mese,1)));
  if selAnag.VariableIndex('C700DATADAL') >= 0 then
  begin
    selT071_Data.DeclareVariable('C700DATADAL',otDate);
    selT071_Data.SetVariable('C700DATADAL',R180FineMese(EncodeDate(Anno,Mese,1)));
  end;
  selT071_Data.Execute;
  if selT071_Data.FieldAsDate(0) = 0 then
    raise Exception.Create(A000MSG_A095_ERR_NO_LIQ);
  Result:=selT071_Data.FieldAsDate(0);
end;

procedure TA095FStRiasStrMW.ApriSelT071(DataLiq:TDateTime;Anno,Mese: Integer; bDataDal: boolean);
begin
  selT071.Close;
  selT071.SetVariable('DATA',DataLiq);
  if selT071.VariableIndex('C700DATADAL') >= 0 then
    selT071.DeleteVariable('C700DATADAL');
  selT071.SetVariable('FILTRO',selT071_Data.GetVariable('FILTRO'));
  selT071.SetVariable('DATALAVORO',R180FineMese(EncodeDate(Anno,Mese,1)));
  if bDataDal then
  begin
    selT071.DeclareVariable('C700DATADAL',otDate);
    selT071.SetVariable('C700DATADAL',R180FineMese(EncodeDate(Anno,Mese,1)));
  end;
  selT071.Open;
  selT071.First;
end;

procedure TA095FStRiasStrMW.ElaboraAnnullaLiquidazione(DataLiq: TDateTime);
begin
  R450DtM1.ConteggiMese('Generico',R180Anno(DataLiq),R180Mese(DataLiq),selT071.FieldByName('PROGRESSIVO').AsInteger);
  A029FLiquidazione.Q071Liq.SetVariable('Progressivo',selT071.FieldByName('PROGRESSIVO').AsInteger);
  A029FLiquidazione.Liquidazione(False,DataLiq,selT071.FieldByName('PROGRESSIVO').AsInteger,-1,-selT071.FieldByName('LIQUID').AsInteger,'');
  RegistraLog.SettaProprieta('C','T071_SCHEDAFASCE',NomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',selT071.FieldByName('PROGRESSIVO').AsString,'');
  RegistraLog.InserisciDato('DATA',DateToStr(DataLiq),'');
  RegistraLog.InserisciDato('LIQUIDNELMESE',R180MinutiOre(-selT071.FieldByName('LIQUID').AsInteger),'00.00');
  RegistraLog.RegistraOperazione;
end;

procedure TA095FStRiasStrMW.DataModuleDestroy(Sender: TObject);
begin
  TabellaStampa.Close;
  FreeAndNil(selI010);
  FreeAndNil(LstCampiIntestazioneAnagrafe);
  FreeAndNil(LstCampiDettaglioAnagrafe);
  FreeAndNil(INomeCampo);
  FreeAndNil(INomeLogico);
  FreeAndNil(DNomeCampo);
  FreeAndNil(DNomeLogico);
  FreeAndNil(selDatiBloccati);
  R450DtM1.Free;
  A029FLiquidazione.Free;
  inherited;
end;

end.

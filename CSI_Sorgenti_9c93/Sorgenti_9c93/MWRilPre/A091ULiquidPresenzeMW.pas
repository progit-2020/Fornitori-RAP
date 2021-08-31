unit A091ULiquidPresenzeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000USessione, C180FunzioniGenerali, USelI010,
  A000UInterfaccia, DBClient, R450, A029ULiquidazione, Oracle, Math, DatiBloccati,
  StrUtils;

type
  TA091FLiquidPresenzeMW = class(TR005FDataModuleMW)
    dsrT275: TDataSource;
    selT275: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    QCols: TOracleDataSet;
    insT073: TOracleQuery;
    insT074: TOracleQuery;
    updT073: TOracleQuery;
    updT074: TOracleQuery;
    updT073_T074: TOracleQuery;
    selT074: TOracleQuery;
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selI010:TselI010;
    procedure InserisciRecord(Causale: String; Data: TDateTime; MaxLiq, ArrLiq,
      MaxComp, ArrComp, TipoDisponibilita: Integer; Aggiornamento: Boolean);
  public
    R450DtM1:TR450DtM1;
    A029FLiquidazione: TA029FLiquidazione;
    selDatiBloccati:TDatiBloccati;
    LstCampiAnagrafe: TStringList;
    DNomeCampo:TStringList;
    DNomeLogico:TStringList;
    INomeCampo:TStringList;
    INomeLogico:TStringList;
    function SettaIntestazioneDettaglio(SqlSelAnagrafe: String; LstIntestazione, LstDettaglio: TStringList): String;
    procedure LiquidazionePresenza(const PModalitaSimulazione: Boolean;Progressivo: Integer; Data: TDateTime; Causale: String; Liquidato,Compensabile, TipoDisponibilita: Integer);
    procedure CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
    function DatoBloccato(Progressivo: Integer; Data: TDateTime): Boolean;
    procedure ElaboraDipendente(LstCodCausali: TStringList; Anno, Mese, MaxLiq, ArrLiq, MaxComp, ArrComp, TipoDisponibilita: Integer; Aggiornamento: Boolean);
    procedure PreparaAggiornaFruitoBudget(Data: TDateTime);
    function DataLiquidazioni(DataLavoro: TDateTime;Causale: String; Liquidazioni,Compensazioni:Boolean) :TDateTime;
    procedure ImpostaVarAnnulla(Data: TDateTime; Causale: String; Liquidazioni, Compensazioni: Boolean);
    procedure AnnullaLiquidazione(Data: TDateTime;Causale: String);
  end;

implementation

{$R *.dfm}

procedure TA091FLiquidPresenzeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  selT275.Open;
  QCols.Open;
  R450DtM1:=TR450DtM1.Create(nil);
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FLiquidazione.R450DtM:=R450DtM1;
  selDatiBloccati:=TDatiBloccati.Create(Self);

  INomeCampo:=TStringList.Create;
  INomeLogico:=TStringList.Create;
  DNomeCampo:=TStringList.Create;
  DNomeLogico:=TStringList.Create;
  LstCampiAnagrafe:=TStringList.Create;

  with selI010 do
  begin
    First;
    while not Eof do
    begin
      if (Copy(FieldByname('NOME_CAMPO').AsString,1,6) <> 'T430D_') and
         (FieldByname('NOME_CAMPO').AsString <> 'COGNOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'NOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'MATRICOLA') then
        LstCampiAnagrafe.Add(FieldByname('NOME_LOGICO').AsString);
      Next;
    end;
  end;
end;

procedure TA091FLiquidPresenzeMW.selT275FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

function TA091FLiquidPresenzeMW.SettaIntestazioneDettaglio(SqlSelAnagrafe: String;LstIntestazione, LstDettaglio: TStringList): String;
var C,D_C,S:String;
    i:Integer;
    CambioSelAnagrafe: Boolean;
begin
  Result:='';
  CambioSelAnagrafe:=False;
  S:=SqlSelAnagrafe;
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
    begin
      if R180InserisciColonna(S,D_C) then
        CambioSelAnagrafe:=True;
    end;
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

//per WebPJ OrdinaDettaglio a True
procedure TA091FLiquidPresenzeMW.CreaTabellaStampa(const OrdinaDettaglio:boolean=False);
var Chiave,D_C:String;
    i,L:Integer;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;

  Chiave:='';
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
  //Caratto 08/7/2013 Mettendo prima i campi di dettaglio per griglia web
  //devo aggiungere la gestione di errore in caso il campo sia già presente
  try
    TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('CognomeNome',ftString,60,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  except
  end;
//  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  try
    TabellaStampa.FieldDefs.Add('Liquidabile',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Liquidato',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Residuo',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Compensabile',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Riporto',ftString,8,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Anomalia',ftString,1,False);
  except
  end;
  try
    TabellaStampa.FieldDefs.Add('Causale',ftString,5,False);
  except
  end;


  if Chiave <> '' then
    Chiave:=Chiave + ';';
  Chiave:=Chiave + 'CognomeNome;Matricola;Causale';
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Progressivo;Causale'),[ixUnique]);
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

//TipoDisponibilita 0 = mensile ; 1 = annuale
procedure TA091FLiquidPresenzeMW.LiquidazionePresenza(const PModalitaSimulazione: Boolean; Progressivo:Integer; Data:TDateTime; Causale:String; Liquidato,Compensabile,TipoDisponibilita:Integer);
{Liquidazione delle ore indicate}
var i,k,h,Comodo:Integer;
begin
  if PModalitaSimulazione then
  begin
    // pulisce la struttura dati
    A029FLiquidazione.A029FBudgetDtM1.CtrlLiqClear;
  end
  else
  begin
    // modalità effettiva
    R450DtM1.selT073.Filtered:=False;

    // se non esiste il record su T073 lo aggiunge
    if not R450DtM1.selT073.SearchRecord('Causale;Data',VarArrayOf([Causale,Data]),[srFromBeginning]) then
    begin
      with insT073 do
      begin
        SetVariable('Progressivo',Progressivo);
        SetVariable('Data',Data);
        SetVariable('Causale',Causale);
        Execute;
      end;
      with insT074 do
      begin
        SetVariable('Progressivo',Progressivo);
        SetVariable('Data',Data);
        SetVariable('Causale',Causale);
        for i:=1 to R450DtM1.NFasceMese do
        begin
          SetVariable('Maggiorazione',R450DtM1.tmaggioraz[i]);
          SetVariable('CodFascia',R450DtM1.tfasce[i]);
          try
            Execute;
          except
          end;
        end;
      end;
    end;
  end;

  // indice causale
  k:=R450DtM1.IndiceRiepPres(Causale);

  // compensabile (T073)
  if not PModalitaSimulazione then
  begin
    if Compensabile > 0 then
    begin
      updT073.SetVariable('Progressivo',Progressivo);
      updT073.SetVariable('Data',Data);
      updT073.SetVariable('Causale',Causale);
      updT073.SetVariable('Compensabile',R180MinutiOre(Compensabile + R450DtM1.RiepPres[k].CompensabileMese));
      updT073.Execute;
    end;
  end;

  // liquidato (T074)
  if Liquidato > 0 then
  begin
    if not PModalitaSimulazione then
    begin
      updT074.SetVariable('Progressivo',Progressivo);
      updT074.SetVariable('Data',Data);
      updT074.SetVariable('Causale',Causale);
    end;
    for i:=R450DtM1.NFasceMese downto 1 do
    begin
      if Liquidato = 0 then
        Break;
      if TipoDisponibilita = 0 then
        h:=Max(0,R450DtM1.RiepPres[k].OreReseMese[i] - R450DtM1.RiepPres[k].LiquidatoMese[i])
      else
        h:=Max(0,R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i]);
      if Liquidato > h then
        Comodo:=h
      else
        Comodo:=Liquidato;
      dec(Liquidato,Comodo);
      if Comodo > 0 then
      begin
        if PModalitaSimulazione then
        begin
          // in modalità simulazione carica la struttura dati per calcolare l'importo corrispondente
          A029FLiquidazione.A029FBudgetDtM1.CtrlLiqAdd(Causale,R450DtM1.tmaggioraz[i],Comodo + R450DtM1.RiepPres[k].LiquidatoMese[i]);
        end
        else
        begin
          // aggiorna la T074 in modalità effettiva
          updT074.SetVariable('Maggiorazione',R450DtM1.tmaggioraz[i]);
          updT074.SetVariable('CodFascia',R450DtM1.tfasce[i]);
          updT074.SetVariable('Liquidato',R180MinutiOre(Comodo + R450DtM1.RiepPres[k].LiquidatoMese[i]));
          updT074.Execute;
        end;
      end;
    end;
  end;

  // in modalità effettiva esegue commit e rimuove il filtro al dataset selT073
  if not PModalitaSimulazione then
  begin
    SessioneOracle.Commit;
    R450DtM1.selT073.Filtered:=True;
  end;
end;

function TA091FLiquidPresenzeMW.DatoBloccato(Progressivo: Integer; Data: TDateTime): Boolean;
begin
  Result:=selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(Data),'T074');
end;

procedure TA091FLiquidPresenzeMW.ElaboraDipendente(LstCodCausali: TStringList;Anno,Mese,MaxLiq,ArrLiq,MaxComp,ArrComp,TipoDisponibilita:Integer;Aggiornamento: Boolean);
var
  i,MaxCompCau, ArrCompCau: Integer;
  Data: TDateTime;
begin
  Data:=EncodeDate(Anno,Mese,1);
  for i:=0 to LstCodCausali.Count - 1 do
  begin
    R450DtM1.ConteggiMese('Generico',Anno,Mese,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    if (R450DtM1.ttrovscheda[Mese] = 1) then
    begin
      //Danilo 19/09/2007 Gestione della compensazione se causale esclusa dalle ore normali
      MaxCompCau:=0;
      ArrCompCau:=0;
      if VarToStr(selT275.Lookup('CODICE',Trim(LstCodCausali[i]),'ORENORMALI')) = 'A' then
      begin
        MaxCompCau:=MaxComp;
        ArrCompCau:=ArrComp;
      end;
      InserisciRecord(Trim(LstCodCausali[i]),Data,MaxLiq,ArrLiq,MaxCompCau,ArrCompCau,TipoDisponibilita,Aggiornamento);
    end;
  end;
end;

procedure TA091FLiquidPresenzeMW.InserisciRecord(Causale:String;Data: TDateTime;MaxLiq,ArrLiq,MaxComp,ArrComp,TipoDisponibilita: Integer;Aggiornamento: Boolean);
var D_C,S:string;
    i,k,Liquidabile,Liquidato,LiquidatoMese,
    Residuo,ResiduoTot,Compensabile,
    Riporto: Integer;
    //MaxLiq,MaxComp,ArrLiq,ArrComp:Integer;
    ImpLiq: Real;
    bResiduoBloccato,Esegui: Boolean;
begin
  k:=R450DtM1.IndiceRiepPres(Causale);
  if k = -1 then
    exit;
  
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('CognomeNome').Value:=SelAnagrafe.FieldByName('Cognome').Value+' '+SelAnagrafe.FieldByName('Nome').Value;
  //TabellaStampa.FieldByName('Nome').Value:=C700SelAnagrafe.FieldByName('Nome').Value;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Progressivo').Value:=SelAnagrafe.FieldByName('Progressivo').Value;
  TabellaStampa.FieldByName('Anomalia').AsString:='';
  TabellaStampa.FieldByName('Causale').Value:=Causale;
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

  Liquidabile:=0;
  Liquidato:=0;
  LiquidatoMese:=0;
  Residuo:=0;
  ResiduoTot:=0;
  Compensabile:=0;
  Riporto:=0;
  for i:=1 to R450DtM1.NFasceMese do
  begin
    //Alberto 19/06/2008: Limite della disponibilità al residuo calcolato da R450
    if TipoDisponibilita = 0 then
      inc(Liquidabile,R450DtM1.RiepPres[k].OreReseMese[i] - R450DtM1.RiepPres[k].LiquidatoMese[i])
      //inc(Liquidabile,min(R450DtM1.RiepPres[k].Residuo[i],R450DtM1.RiepPres[k].OreReseMese[i] - R450DtM1.RiepPres[k].LiquidatoMese[i]))
    else
      //inc(Liquidabile,(*R450DtM1.RiepPres[k].Residuo[i]*)R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i]);
      inc(Liquidabile,min(R450DtM1.RiepPres[k].Residuo[i],R450DtM1.RiepPres[k].Liquidabile[i] - R450DtM1.RiepPres[k].Liquidato[i]));
    inc(LiquidatoMese,R450DtM1.RiepPres[k].LiquidatoMese[i]);
    inc(ResiduoTot,R450DtM1.RiepPres[k].Residuo[i]);
  end;
  if TipoDisponibilita = 0 then
    Liquidabile:=min(ResiduoTot,Liquidabile - R450DtM1.RiepPres[k].CompensabileMeseEff);
  Liquidabile:=Max(0,Liquidabile);
  //Alberto 23/02/2006: gestione delle causali incluse nelle normali
  if VarToStr(selT275.Lookup('CODICE',Causale,'ORENORMALI')) <> 'A' then
    Liquidabile:=Min(Liquidabile,R450DtM1.StrResiduoAnno);
  //Non ci devono essere liquidazioni successive
  if R450DtM1.EsistePresenzaLiquidataSuccessiva(Causale) then
  begin
    if Liquidabile > 0 then
      TabellaStampa.FieldByName('Anomalia').AsString:='X';
  end
  else
  begin
    //Liquidabile = ore residue disponibili per la liquidazione/compensazione
    Liquidato:=Max(0,Liquidabile);
    if Liquidato > (MaxLiq - LiquidatoMese) then
      Liquidato:=Max(0,MaxLiq - LiquidatoMese);
    //Controllo straordinario autorizzato annuo se l'uso del budget non è impostato
    //ad 'L'(ossia Libero di sforare) e la causale abbatte il budget
    if (Parametri.CampiRiferimento.C2_Facoltativo <> 'L') and
       (VarToStr(selT275.Lookup('CODICE',Causale,'ABBATTE_BUDGET')) = 'L') then
    begin
      A029FLiquidazione.GetOreLiquidate(SelAnagrafe.FieldByName('Progressivo').AsInteger,Data);
      if Liquidato > (R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno) then
        Liquidato:=Max(0,R450DtM1.EccAutAnno['LIQUIDABILE'] + R450DtM1.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno - A029FLiquidazione.LiqT071Anno - A029FLiquidazione.LiqT070 - A029FLiquidazione.LiqT074Anno - A029FLiquidazione.AssT071Anno);
    end;
    if ArrLiq > 1 then
      Liquidato:=(Liquidato div ArrLiq) * ArrLiq;
    Residuo:=Liquidabile - Liquidato + (Max(0,R450DtM1.RiepPres[k].CompensabileMeseEff - R450DtM1.RiepPres[k].CompensabileMese));
    if VarToStr(selT275.Lookup('CODICE',Causale,'ORENORMALI')) = 'A' then
      Compensabile:=Residuo
    else
      Compensabile:=0;
    if Compensabile > (MaxComp - R450DtM1.RiepPres[k].CompensabileMese) then
      Compensabile:=MaxComp - R450DtM1.RiepPres[k].CompensabileMese;
    if Compensabile < 0 then
      Compensabile:=0;
    if ArrComp > 1 then
      Compensabile:=(Compensabile div ArrComp) * ArrComp;
    Riporto:=Residuo - Compensabile;
  end;
  TabellaStampa.FieldByName('Liquidabile').Value:=R180MinutiOre(Liquidabile);
  TabellaStampa.FieldByName('Liquidato').Value:=R180MinutiOre(Liquidato);
  TabellaStampa.FieldByName('Residuo').Value:=R180MinutiOre(Residuo);
  TabellaStampa.FieldByName('Compensabile').Value:=R180MinutiOre(Compensabile);
  TabellaStampa.FieldByName('Riporto').Value:=R180MinutiOre(Riporto);
  bResiduoBloccato:=DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data);
  if bResiduoBloccato then
    TabellaStampa.FieldByName('Anomalia').AsString:='X';
  if ((Liquidato + Compensabile) = 0) and (TabellaStampa.FieldByName('Anomalia').AsString = '') then
  begin
    TabellaStampa.Cancel;
    exit;
  end;
  //Registro la liquidazione solo se il riepilogo non è bloccato
  if (Aggiornamento) and ((Liquidato + Compensabile) > 0) and (not bResiduoBloccato) then
  begin
    // controlli sul budget
    if (Parametri.CampiRiferimento.C2_Facoltativo = '') or
       (VarToStr(selT275.Lookup('CODICE',Causale,'ABBATTE_BUDGET')) = 'N') then
    begin
      Esegui:=True;
    end
    else
    begin
      // simula la liquidazione per calcolare l'importo da confrontare con il budget
      LiquidazionePresenza(True,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);
      ImpLiq:=A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data);

      // controllo sforamento budget
      Esegui:=A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data,Liquidato,ImpLiq);
    end;

    // se è tutto ok effettua la liquidazione
    if Esegui then
    begin
      LiquidazionePresenza(False,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data,Causale,Liquidato,Compensabile,TipoDisponibilita);
      RegistraLog.SettaProprieta('M','T073_SCHEDACAUSPRES',Copy(Self.Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ),'');
      RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
      RegistraLog.InserisciDato('CAUSALE',Causale,'');
      RegistraLog.RegistraOperazione;
    end
    else
    begin
      // disponibilità non sufficiente: anomalia
      // - segnalare nelal colonna "Anomalia" in stampa con flag = S
      // - annullare questa liquidazione ma proseguire con le succesive
      TabellaStampa.FieldByName('Anomalia').AsString:='S';
    end;
  end;
  TabellaStampa.Post;
end;

//Calcolo il fruito e aggiorno il budget straordinario
procedure TA091FLiquidPresenzeMW.PreparaAggiornaFruitoBudget(Data: TDateTime);
begin
  //Calcolo il fruito e aggiorno il budget straordinario
  if Parametri.CampiRiferimento.C2_Facoltativo <> '' then
  begin
    A029FLiquidazione.A029FBudgetDtM1.PreparaAggiornaFruitoBudget(Data,'#LIQ#');
    SessioneOracle.Commit;
  end;
end;

function TA091FLiquidPresenzeMW.DataLiquidazioni(DataLavoro: TDateTime;Causale: String; Liquidazioni,Compensazioni:Boolean) :TDateTime;
var
  S: String;
  P: Integer;
begin
  Causale:='''' + StringReplace(Causale,',',''',''',[rfReplaceAll]) + '''';
  S:=SelAnagrafe.SubstitutedSQL;
  S:=Copy(S,Pos('FROM',S),Length(S));
  P:=Pos('ORDER BY',S);
  if P > 0 then
    S:=Copy(S,1,P - 1);
  S:=' AND T073.PROGRESSIVO IN (SELECT PROGRESSIVO ' + S + ')';
  if selT074.VariableIndex('C700DATADAL') >= 0 then
    selT074.DeleteVariable('C700DATADAL');
  selT074.SetVariable('FILTRO',S);
  selT074.SetVariable('DATALAVORO',R180FineMese(DataLavoro));
  selT074.SetVariable('CAUSALE',Causale);
  selT074.SetVariable('LIQUIDAZIONI',IfThen(Liquidazioni,'S','N'));
  selT074.SetVariable('COMPENSAZIONI',IfThen(Compensazioni,'S','N'));
  if SelAnagrafe.VariableIndex('C700DATADAL') >= 0 then
  begin
    selT074.DeclareVariable('C700DATADAL',otDate);
    selT074.SetVariable('C700DATADAL',R180InizioMese(DataLavoro));
  end;
  selT074.Execute;
  Result:=selT074.FieldAsDate(0);
end;

procedure TA091FLiquidPresenzeMW.ImpostaVarAnnulla(Data:TDateTime; Causale:String; Liquidazioni,Compensazioni:Boolean);
begin
  Causale:='''' + StringReplace(Causale,',',''',''',[rfReplaceAll]) + '''';
  updT073_T074.SetVariable('LIQUIDAZIONI',IfThen(Liquidazioni,'S','N'));
  updT073_T074.SetVariable('COMPENSAZIONI',IfThen(Compensazioni,'S','N'));
  updT073_T074.SetVariable('DATA',Data);
  updT073_T074.SetVariable('CAUSALE',Causale);
end;

procedure TA091FLiquidPresenzeMW.AnnullaLiquidazione(Data: TDateTime; Causale: String);
begin
  if not DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data) then
  begin
    updT073_T074.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    updT073_T074.Execute;
    RegistraLog.SettaProprieta('C','T073_SCHEDACAUSPRES',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger),'');
    RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
    RegistraLog.InserisciDato('CAUSALE',Causale,'');
    RegistraLog.RegistraOperazione;
  end;
end;
procedure TA091FLiquidPresenzeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  FreeAndNil(INomeCampo);
  FreeAndNil(INomeLogico);
  FreeAndNil(DNomeCampo);
  FreeAndNil(DNomeLogico);
  FreeAndNil(LstCampiAnagrafe);
  TabellaStampa.Close;
  R450DtM1.Free;
  FreeAndNil(A029FLiquidazione);
  FreeAndNil(selDatiBloccati);
  inherited;
end;

end.

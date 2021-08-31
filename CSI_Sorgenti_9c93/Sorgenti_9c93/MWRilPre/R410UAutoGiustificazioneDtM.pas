unit R410UAutoGiustificazioneDtM;

interface

uses
  SysUtils, Classes, DB, OracleData, Oracle, Variants, DateUtils, Math, DBClient,
  A000UInterfaccia, A000UCostanti, A004UGiustifAssPresMW,
  Rp502Pro, R600, C180FunzioniGenerali;

type
  TDalleAlle = record
    Dalle,Alle:Integer;
  end;

  TBancaOreEcc = record
    Data:TDateTime;
    Saldo,SaldoApp:Integer;
    Strao:Integer;
    Abbattimento:Integer;
    MinStrGio:array [1..6] of Integer;
    MinStrSett:array [1..6] of Integer;
  end;

  TBancaOreTOCSI = record
    GestioneSettimanale:Boolean;
    Abbattimento:Integer;
    NumFasce:Integer;
    StrAutorizzato:Integer;
    AbbattimentoStandard:Boolean;
  end;

  TR410FAutoGiustificazioneDtM = class(TDataModule)
    selT100T040: TOracleDataSet;
    delT040CausScorrimento: TOracleQuery;
    insT040: TOracleQuery;
    selT265: TOracleDataSet;
    scrFestiviInfraSett: TOracleQuery;
    selT265FruizMin: TOracleDataSet;
    selT265Familiari: TOracleDataSet;
    selDatanas: TOracleQuery;
    cdsT040StampaA: TClientDataSet;
    selT040StampaA: TOracleDataSet;
    selT020CausScorrimento: TOracleDataSet;
    delT040StampaB: TOracleQuery;
    selT040HMASSENZA: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    Progressivo:Integer;
    R502ProDtM:TR502ProDtM1;
    R600DtM:TR600DtM1;
    SessioneOracleR410:TOracleSession;
    GGBancaOreEcc:array of TBancaOreEcc;
    SettBancaOreEcc:array of TBancaOreEcc;
    procedure AutoGiustificazioneGiornaliera;
    procedure RicalcoloCausaliHMAssenza(Prog:Integer; Data1,Data2:TDateTime; Causale:String);
  public
    { Public declarations }
    BancaOreTOCSI:TBancaOreTOCSI;
    procedure AutoGiustificazione(Prog:Integer; Data1,Data2:TDateTime);
    procedure ResetAbbattimentoBancaOre(Prog:Integer; Data1,Data2:TDateTime);
    procedure AddGGBancaOreEccedente(R502DtM:TR502ProDtM1; Saldo:Integer);
    procedure AddSettBancaOreEccedente(D:TDateTime; Saldo,Strao:Integer);
    procedure TroncaBancaOreEccedente(Prog:Integer; Data1,Data2:TDateTime);
    procedure CercaCausaliHMAssenza(Prog:Integer; Data1,Data2:TDateTime);
  end;

//var R410FAutoGiustificazioneDtM: TR410FAutoGiustificazioneDtM;

implementation

{$R *.dfm}

procedure TR410FAutoGiustificazioneDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  SessioneOracleR410:=SessioneOracle;
  if Self.Owner <> nil then
    if Self.Owner is TOracleSession then
      SessioneOracleR410:=Self.Owner as TOracleSession;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR410;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR410;
    end;
  cdsT040StampaA.CreateDataset;
  cdsT040StampaA.Open;
  cdsT040StampaA.LogChanges:=False;
  BancaOreTOCSI.GestioneSettimanale:=False;
  BancaOreTOCSI.Abbattimento:=0;
  BancaOreTOCSI.AbbattimentoStandard:=False;
end;

procedure TR410FAutoGiustificazioneDtM.AutoGiustificazione(Prog:Integer; Data1,Data2:TDateTime);
{Estrazione dei giorni che presentano già giustificativi auto-giustificati o causali di presenza
 linkate alle assenze}
var D1,D2:TDateTime;
  procedure CancellaGiustificativiStampaA;
  begin
    with selT040StampaA do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',selT100T040.FieldByName('DATA').AsDateTime);
      Close;
      Open;
      while not Eof do
      begin
        //Tengo traccia dei giustificativi già validati, in modo da reimpostare lo stesso flag se vengono reinseriti uguali.
        if FieldByName('SCHEDA').AsString = 'V' then
        begin
          cdsT040StampaA.Append;
          cdsT040StampaA.FieldByName('DATA').Value:=FieldByName('DATA').Value;
          cdsT040StampaA.FieldByName('CAUSALE').Value:=FieldByName('CAUSALE').Value;
          cdsT040StampaA.FieldByName('TIPOGIUST').Value:=FieldByName('TIPOGIUST').Value;
          cdsT040StampaA.FieldByName('DAORE').Value:=FieldByName('DAORE').Value;
          cdsT040StampaA.FieldByName('AORE').Value:=FieldByName('AORE').Value;
          cdsT040StampaA.FieldByName('SCHEDA').Value:=FieldByName('SCHEDA').Value;
          cdsT040StampaA.Post;
        end;
        try
          Delete;
        except
          Next;
        end;
      end;
    end;
  end;
begin
  Progressivo:=Prog;
  selT020CausScorrimento.Open;
  if selT020CausScorrimento.RecordCount > 0 then
  with delT040CausScorrimento do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Data1);
    SetVariable('DATA2',Data2);
    Execute;
  end;
  with selT100T040 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Data1);
    SetVariable('DATA2',Data2);
    Open;
    cdsT040StampaA.EmptyDataset;
    if RecordCount > 0 then
    begin
      if R502ProDtM = nil then
        R502ProDtM:=TR502ProDtM1.Create(SessioneOracleR410);
      D1:=EncodeDate(3999,12,31);
      D2:=0;
      while not Eof do
      begin
        D1:=Min(D1,FieldByName('DATA').AsDateTime);
        D2:=Max(D2,FieldByName('DATA').AsDateTime);
        CancellaGiustificativiStampaA;
        Next;
      end;
      First;
      R502ProDtM.PeriodoConteggi(D1,D2);
      R502ProDtM.Conteggi('APERTURA',0,D1);
      while not Eof do
      begin
        //Torino_Comune: i giorni col ricalcolo del debito devono essere elaborati per ultimi anche per l'auto-giustificazione
        //quindi se il giorno esiste sia come tipo 1 che come tipo 2, l'autogiustificazione viene elaborata solo quando tipo = 2
        if (FieldByName('TIPO').AsInteger = 2) and (Lookup('DATA;TIPO',VarArrayOf([FieldByName('DATA').AsDateTime,1]),'TIPO') = 1) then
        begin
          //ricalcolo del debito (eseguito nei conteggi) AND autogiustificazione
          R502ProDtM.TOCOQuadraturaSettimanale:=False;
          R502ProDtM.Conteggi('Cartolina',Progressivo,FieldByName('DATA').AsDateTime);
          AutoGiustificazioneGiornaliera;
        end;
        R502ProDtM.TOCOQuadraturaSettimanale:=FieldByName('TIPO').AsInteger = 2;
        if (FieldByName('TIPO').AsInteger = 2) or (Lookup('DATA;TIPO',VarArrayOf([FieldByName('DATA').AsDateTime,2]),'TIPO') = null) then
          //ricalcolo del debito (eseguito nei conteggi) oppure autogiustificazione (eseguito alla condizione successiva)
          R502ProDtM.Conteggi('Cartolina',Progressivo,FieldByName('DATA').AsDateTime);
        if (FieldByName('TIPO').AsInteger = 1) and (Lookup('DATA;TIPO',VarArrayOf([FieldByName('DATA').AsDateTime,2]),'TIPO') = null) then
          AutoGiustificazioneGiornaliera;
        SessioneOracleR410.Commit;
        Next;
      end;
    end;
    Close;
  end;
  selT265.Open;
  if selT265.RecordCount > 0 then
  begin
    scrFestiviInfraSett.SetVariable('PROGRESSIVO',Progressivo);
    scrFestiviInfraSett.SetVariable('DADATA',Data1);
    scrFestiviInfraSett.SetVariable('ADATA',Data2);
    scrFestiviInfraSett.SetVariable('CODCAUS',selT265.FieldByName('CODICE').AsString);
    try
      scrFestiviInfraSett.Execute;
    except
    end;
  end;
end;

procedure TR410FAutoGiustificazioneDtM.AutoGiustificazioneGiornaliera;
{Inserimento di giustificativi di assenza in numero ore in corrispondenza di causalizzazioni di presenza}
var i,j,T,TIns,Aggiunta:Integer;
    Residuo,FMin,FArr,App,App1,FOriginale,DiffFruitoReso:Integer;
    Giustif:TGiustificativo;
    FCArr,CausAss:String;
    DalleAlle:array of TDalleAlle;
    DaOre,AOre:TDateTime;
    InsAvvenuto,EsisteCompetenza:Boolean;
begin
  if R502ProDtM.Blocca <> 0 then
    exit;
  InsAvvenuto:=False;
  selT265FruizMin.Open;
  selT265Familiari.Open;
  selDatanas.SetVariable('PROGRESSIVO',Progressivo);
  selDatanas.SetVariable('DATA',R502ProDtM.datacon);
  for i:=1 to R502ProDtM.n_rieppres do
  begin
    CausAss:=VarToStr(R502ProDtM.Q275.Lookup('CODICE',R502ProDtM.triepgiuspres[i].tcauspres,'LINK_ASSENZA'));
    FMin:=StrToIntDef(VarToStr(selT265FruizMin.Lookup('CODICE',CausAss,'FRUIZ_MIN')),0);
    FArr:=StrToIntDef(VarToStr(selT265FruizMin.Lookup('CODICE',CausAss,'FRUIZ_ARR')),0);
    FCArr:=VarToStr(selT265FruizMin.Lookup('CODICE',CausAss,'FRUIZCOMPETENZE_ARR'));
    if not(R180CarattereDef(VarToStr(R502ProDtM.Q275.Lookup('CODICE',R502ProDtM.triepgiuspres[i].tcauspres,'TIPOCONTEGGIO')),1,#0) in ['A','E']) or
       (CausAss = '') then
      Continue;
    SetLength(DalleAlle,0);
    T:=0;
    for j:=1 to R502ProDtM.n_fasce do
      inc(T,R502ProDtM.triepgiuspres[i].tminpres[j]);
    if T = 0 then
      Continue;
    for j:=0 to High(R502ProDtM.triepgiuspres[i].CoppiaEU) do
      if R502ProDtM.triepgiuspres[i].CoppiaEU[j].e < R502ProDtM.triepgiuspres[i].CoppiaEU[j].u then
      begin
        SetLength(DalleAlle,Length(DalleAlle) + 1);
        DalleAlle[high(DalleAlle)].Dalle:=R502ProDtM.triepgiuspres[i].CoppiaEU[j].e;
        DalleAlle[high(DalleAlle)].Alle:=R502ProDtM.triepgiuspres[i].CoppiaEU[j].u;
      end;
    DiffFruitoReso:=0;
    EsisteCompetenza:=False;
    Residuo:=0;
    FOriginale:=0;
    if VarToStr(R502ProDtM.Q275.Lookup('CODICE',R502ProDtM.triepgiuspres[i].tcauspres,'COMPETENZE_AUTOGIUST')) = 'S' then
    begin
      //Valuto la differenza tra fruito e reso - Da farsi solo se le competenze sono da ore rese (e non fruite)
      //Il giustificativ può avere un reso inferiore al fruito per es. per via del raggiungimento del debito, o della pausa mensa, ecc...
      if (R502ProDtM.ValStrT265[CausAss,'TIPOCUMULO'] <> 'H') and (R502ProDtM.ValStrT265[CausAss,'CUMULO_TIPO_ORE'] = '1') then
      try
        //Carico i giustificativi fittizi
        for j:=0 to High(DalleAlle) do
          R502ProDtM.z442_giustcar_esterno(CausAss,
                                            EncodeTime(DalleAlle[j].Dalle div 60,DalleAlle[j].Dalle mod 60,0,0),
                                            EncodeTime(DalleAlle[j].Alle div 60,DalleAlle[j].Alle mod 60,0,0),
                                            'D');
        App:=R502ProDtM.RiepAssenza[CausAss,'HHRESE']; //Situazione del giustificativo prima dell'inserimento fittizio, per considerare giustificativi manuali
        R502ProDtM.esegui_z430:=False;  //Non rileggo i giustificativi da tabella ma lascio quelli letti al conteggio precedente
        R502ProDtM.Conteggi('Cartolina',Progressivo,R502ProDtM.datacon);
        App:=R502ProDtM.RiepAssenza[CausAss,'HHRESE'] - App;  //Situazione del giustificativo con l'inserimento fittizio, al netto dei giustificativi manuali
        DiffFruitoReso:=Max(0,T - App);
        T:=App;
        FOriginale:=App;
      except
      end;
      R502ProDtM.esegui_z430:=True;

      if R600DtM = nil then
        R600DtM:=TR600DtM1.Create(SessioneOracleR410);
      Giustif.Inserimento:=False;
      Giustif.Modo:='I';
      Giustif.Causale:=CausAss;

      // imposta data di nascita familiare, se necessario
      R600DtM.RiferimentoDataNascita.Data:=0;
      if selT265Familiari.SearchRecord('CODICE',CausAss,[srFromBeginning]) then
      begin
        selDatanas.SetVariable('CAUSALE',CausAss);
        selDatanas.Execute;
        if not selDatanas.FieldIsNull(0) then
          R600DtM.RiferimentoDataNascita.Data:=selDatanas.FieldAsDate(0);
      end;

      R600DtM.SettaConteggi(Progressivo,R502ProDtM.datacon,R502ProDtM.datacon,Giustif);
      R600DtM.ValResiduo:=0;
      for j:=1 to High(R600DtM.Competenze) do
        R600DtM.ValResiduo:=R600DtM.ValResiduo + R600DtM.Competenze[j];
      if R600DtM.TipoCumulo = 'H' then
        Residuo:=T
      else if R600DtM.UMisura = 'G' then
        Residuo:=Trunc(R600DtM.ValResiduo * R600DtM.ValenzaGiornaliera)
      else
        Residuo:=Trunc(R600DtM.ValResiduo);
      EsisteCompetenza:=R600DtM.TipoCumulo <> 'H';
      if T > Residuo then
        T:=Max(0,Residuo);
      if T = 0 then
        Continue
      else
      begin
        inc(T,DiffFruitoReso); //Se è da inserire, aggiungo la differenza tra fruito e reso
        //T = Fruizione calcolata al netto dei residui
        //FOriginale = Fruizione originale prima della decurtazione per i residui
        if EsisteCompetenza and (DiffFruitoReso > 0) and (T < FOriginale) and (T > Residuo) then
        begin
          //Applico differenza FOriginale - T alle fruizioni di CausAss
          App:=FOriginale - T;
          with R502ProDtM do
          begin
            for j:=1 to n_giusdaa do
              if (tgius_dallealle[j].PuntGiustR600 = -1) and (tgius_dallealle[j].tcausdaa = CausAss) then
              begin
                App1:=min(App,tgius_dallealle[j].tminutia - tgius_dallealle[j].tminutida);
                dec(App,App1);
                dec(tgius_dallealle[j].tminutia,App1);
              end;
          end;
          R502ProDtM.esegui_z430:=False;  //Non rileggo i giustificativi da tabella ma lascio quelli letti al conteggio precedente
          R502ProDtM.Conteggi('Cartolina',Progressivo,R502ProDtM.datacon);
          R502ProDtM.esegui_z430:=True;
          //Se la fruizione netta è minore del nuovo calcolo, vuol dire che la nuova quantità da inserire na ha più le decurtazioni iniziali (per es. Pausa Mensa)
          //In tal caso la quantità di riferimento è il Residuo ancora disponibile
          if (T - DiffFruitoReso) < R502ProDtM.RiepAssenza[CausAss,'HHRESE'] then
            if R502ProDtM.RiepAssenza[CausAss,'HHRESE'] > Residuo then
              T:=Residuo
        end;
      end;
    end;
    if VarToStr(R502ProDtM.Q275.Lookup('CODICE',R502ProDtM.triepgiuspres[i].tcauspres,'AUTOGIUST_DALLEALLE')) = 'S' then
    begin //Inserimento giustificativi dalle..alle
      //Verifica fruizione minima e arrotondamento
      TIns:=0;
      for j:=0 to High(DalleAlle) do
      try
        inc(TIns,DalleAlle[j].Alle - DalleAlle[j].Dalle);
        if TIns > T then
          dec(DalleAlle[j].Alle,Tins - T);
        if DalleAlle[j].Alle > DalleAlle[j].Dalle then
        begin
          if (FMin > 0) and (FMin > DalleAlle[j].Alle - DalleAlle[j].Dalle) then
          begin
            Aggiunta:=FMin - (DalleAlle[j].Alle - DalleAlle[j].Dalle);
            //Alberto 21/01/2011: se si sforano le competenze (per effetto di fruizione minima/arrotondamenti) non si inserisce il giustificativo
            if EsisteCompetenza and (TIns + Aggiunta > Residuo) then
              Continue
            else
            begin
              inc(TIns,Aggiunta);
              inc(DalleAlle[j].Alle,Aggiunta);
            end;
          end;
          if (FCArr = 'N') and (FArr > 1) then
          begin
            App:=Trunc(R180Arrotonda(DalleAlle[j].Alle - DalleAlle[j].Dalle,FArr,'E'));
            //if App > DalleAlle[j].Alle - DalleAlle[j].Dalle then
            //  inc(DalleAlle[j].Alle,App - (DalleAlle[j].Alle - DalleAlle[j].Dalle));
          end;
          DaOre:=EncodeDateTime(1899,12,30,DalleAlle[j].Dalle div 60,DalleAlle[j].Dalle mod 60,0,0);
          AOre:=EncodeDateTime(1899,12,30,DalleAlle[j].Alle div 60,DalleAlle[j].Alle mod 60,0,0);
          insT040.SetVariable('PROGRESSIVO',Progressivo);
          insT040.SetVariable('DATA',R502ProDtM.datacon);
          insT040.SetVariable('CAUSALE',CausAss);
          insT040.SetVariable('TIPOGIUST','D');
          insT040.SetVariable('DAORE',DaOre);
          insT040.SetVariable('AORE',AOre);
          insT040.SetVariable('STAMPA','A');
          insT040.SetVariable('SCHEDA',null);
          if cdsT040StampaA.Locate('DATA;CAUSALE;TIPOGIUST;DAORE;AORE',VarArrayOf([R502ProDtM.datacon,CausAss,'D',DaOre,AOre]),[]) then
            insT040.SetVariable('SCHEDA','V');
          insT040.Execute;
          InsAvvenuto:=True;
        end;
      except
      end;
    end
    else
    try //Inserimento giustificativi num.ore
      //Verifica fruizione minima e arrotondamento
      if (FMin > 0) and (FMin > T) then
        inc(T,FMin - T);
      if (FCArr = 'N') and (FArr > 1) then
      begin
        App:=Trunc(R180Arrotonda(T,FArr,'E'));
        if App > T then
          inc(T,App - T);
      end;
      //Alberto 21/01/2011: se si sforano le competenze (per effetto di fruizione minima/arrotondamenti) non si inserisce il giustificativo
      if not EsisteCompetenza or (T <= Residuo) then
      begin
        DaOre:=EncodeDateTime(1899,12,30,T div 60,T mod 60,0,0);
        insT040.SetVariable('PROGRESSIVO',Progressivo);
        insT040.SetVariable('DATA',R502ProDtM.datacon);
        insT040.SetVariable('CAUSALE',CausAss);
        insT040.SetVariable('TIPOGIUST','N');
        insT040.SetVariable('DAORE',DaOre);
        insT040.SetVariable('AORE',null);
        insT040.SetVariable('STAMPA','A');
        insT040.SetVariable('SCHEDA',null);
        if cdsT040StampaA.Locate('DATA;CAUSALE;TIPOGIUST;DAORE',VarArrayOf([R502ProDtM.datacon,CausAss,'N',DaOre]),[]) then
          insT040.SetVariable('SCHEDA','V');
        insT040.Execute;
        InsAvvenuto:=True;
      end;
    except
      //...
    end;
  end;
  selT265Familiari.Close;
  if InsAvvenuto then
    R502ProDtM.Q040.Refresh;
end;

procedure TR410FAutoGiustificazioneDtM.ResetAbbattimentoBancaOre(Prog:Integer; Data1,Data2:TDateTime);
{TORINO_CSI Cancellazione causale con Stampa = 'B' (causale TO_CSI_ABB_BANCAORE = 9103)}
begin
  with delT040StampaB do
  begin
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA1',Data1);
    SetVariable('DATA2',Data2);
    Execute;
  end;
  SetLength(GGBancaOreEcc,0);
  SetLength(SettBancaOreEcc,0);
end;

procedure TR410FAutoGiustificazioneDtM.AddGGBancaOreEccedente(R502DtM:TR502ProDtM1; Saldo:Integer);
{TORINO_CSI: registrazione dati giornalieri per valutazione abbattimento}
var idx,i,j:Integer;
begin
  idx:=Length(GGBancaOreEcc);
  SetLength(GGBancaOreEcc,idx + 1);
  GGBancaOreEcc[idx].Data:=R502DtM.datacon;
  GGBancaOreEcc[idx].Saldo:=Saldo;
  GGBancaOreEcc[idx].Strao:=0;
  GGBancaOreEcc[idx].Abbattimento:=0;
  for i:=1 to High(GGBancaOreEcc[idx].MinStrGio) do
  begin
    GGBancaOreEcc[idx].MinStrGio[i]:=0;
    GGBancaOreEcc[idx].MinStrSett[i]:=0;
  end;
  for i:=1 to R502DtM.n_fasce do
  begin
    j:=R502DtM.tfasceorarie[i].tposfasc;
    if (j > 0) and (j <= High(GGBancaOreEcc[idx].MinStrGio)) then
      inc(GGBancaOreEcc[idx].MinStrGio[j],R502DtM.tminstrgio[i]);
  end;
end;

procedure TR410FAutoGiustificazioneDtM.AddSettBancaOreEccedente(D:TDateTime; Saldo,Strao:Integer);
{TORINO_CSI: registrazione dati settimanali per valutazione abbattimento}
var idx,i:Integer;
begin
  idx:=Length(SettBancaOreEcc);
  SetLength(SettBancaOreEcc,idx + 1);
  SettBancaOreEcc[idx].Data:=D;
  SettBancaOreEcc[idx].Saldo:=Saldo;
  SettBancaOreEcc[idx].Strao:=Strao;
  for i:=1 to High(SettBancaOreEcc[idx].MinStrGio) do
  begin
    SettBancaOreEcc[idx].MinStrGio[i]:=0;
    SettBancaOreEcc[idx].MinStrSett[i]:=0;
  end;
end;

procedure TR410FAutoGiustificazioneDtM.TroncaBancaOreEccedente(Prog:Integer; Data1,Data2:TDateTime);
{TORINO_CSI: Viene inserita la causale TO_CSI_ABB_BANCAORE=9103 per abbattere la banca ore eccedente,
 a partire dall'ultimo giorno del cartellino e andando indietro}
const OFFSET_FINESETT = 6;
var D:TDateTime;
    f,i,App,EccFascia:Integer;
  procedure LimitaEccedenzeSettimanali;
  var f,i,j,SaldoSett,App:Integer;
  begin
    //Travaso Saldo in SaldoApp: Saldo viene poi alimentato in base alla disponibilità settimanale
    for i:=0 to High(GGBancaOreEcc) do
    begin
      GGBancaOreEcc[i].SaldoApp:=GGBancaOreEcc[i].Saldo;
      GGBancaOreEcc[i].Saldo:=0;
    end;
    for i:=0 to High(SettBancaOreEcc) do
    begin
      SaldoSett:=SettBancaOreEcc[i].Saldo;
      //Per ogni settimana che ha dell'eccedenza, limito le eccedenze dei singoli gg in modo che il totale non superi l'eccedenza settimanale (lu..sa)
      //!attenzione! Scorro le fasce in ordine crescente per preservare le fasce più basse, che sucessivamente possono essere troncate.
      //for f:=BancaOreTOCSI.NumFasce downto 1 do
      for f:=1 to BancaOreTOCSI.NumFasce do
      begin
        //for j:=0 to High(GGBancaOreEcc) do
        for j:=High(GGBancaOreEcc) downto 0 do
        begin
          if R180Between(GGBancaOreEcc[j].Data,SettBancaOreEcc[i].Data,SettBancaOreEcc[i].Data + OFFSET_FINESETT) then
          begin
            App:=min(GGBancaOreEcc[j].SaldoApp,SaldoSett);
            App:=min(App,GGBancaOreEcc[j].MinStrGio[f]);
            inc(GGBancaOreEcc[j].Saldo,App);
            dec(GGBancaOreEcc[j].SaldoApp,App);
            dec(SaldoSett,App);
          end;
        end;
      end;
    end;
    //Pulizia SaldoApp
    for i:=0 to High(GGBancaOreEcc) do
      GGBancaOreEcc[i].SaldoApp:=0;
  end;

  procedure SetStrSett(Sett:Integer);
  //Cumula le eccedenze giornaliere utili alla liquidazione nella settimana indicata da Sett
  var i,f,s:Integer;
  begin
    for f:=BancaOreTOCSI.NumFasce downto 1 do
      SettBancaOreEcc[Sett].MinStrGio[f]:=0;
    for i:=0 to High(GGBancaOreEcc) do
    begin
      if R180Between(GGBancaOreEcc[i].Data,SettBancaOreEcc[Sett].Data,SettBancaOreEcc[Sett].Data + OFFSET_FINESETT) then
      begin
        s:=GGBancaOreEcc[i].Saldo;
        for f:=BancaOreTOCSI.NumFasce downto 1 do
        begin
          inc(SettBancaOreEcc[Sett].MinStrGio[f],min(GGBancaOreEcc[i].MinStrGio[f],s));
          dec(s,min(GGBancaOreEcc[i].MinStrGio[f],s));
        end;
      end;
    end;
  end;
  procedure PreservaStrLiquidabile(Sett,Fascia:Integer);
  //Resituisce la quantità di eccedenza liquidabile abbattendo le fasce settimanali residue a partire da Fascia e scendendo
  var f,app:Integer;
  begin
    if SettBancaOreEcc[Sett].MinStrGio[Fascia] = 0 then
      exit;
    for f:=Fascia downto 1 do
    begin
      app:=min(BancaOreTOCSI.StrAutorizzato,SettBancaOreEcc[Sett].MinStrGio[f]);
     //Se fascia inferiore a quella di riferimento, considero solo la parte utile a raggiungere la quantità min30arr15
      if f < Fascia then
        app:=app - (max(0,SettBancaOreEcc[Sett].SaldoApp + app - TO_CSI_MIN_STRAOSETT) mod TO_CSI_ARR_STRAOSETT);
      inc(SettBancaOreEcc[Sett].SaldoApp,app);
      dec(BancaOreTOCSI.StrAutorizzato,app);
      dec(SettBancaOreEcc[Sett].MinStrGio[f],app);
      inc(SettBancaOreEcc[Sett].MinStrSett[f],app);
      if (SettBancaOreEcc[Sett].SaldoApp >= TO_CSI_MIN_STRAOSETT) and (SettBancaOreEcc[Sett].SaldoApp mod TO_CSI_ARR_STRAOSETT = 0) then
        Break;
    end;
  end;
  function RecuperaEccedenza(Sett:Integer):Integer;
  var i,f,PesoMax,SettRecupero:Integer;
      PesiStrSett:array of Integer;
  begin
    //Calcolo la settimana che ha lo straordinario più favorevole per il recupero , cioè ha più ore nelle fasce basse
    Result:=0;
    SettRecupero:=-1;
    PesoMax:=0;
    SetLength(PesiStrSett,Length(SettBancaOreEcc));
    for i:=0 to High(SettBancaOreEcc) do
    begin
      if i = Sett then
        Continue;
      if SettBancaOreEcc[i].SaldoApp < TO_CSI_MIN_STRAOSETT + TO_CSI_ARR_STRAOSETT then
        Continue;
      //Per ogni settimana calcolo il 'peso' dello straordinario disponibile, dando peso maggiore alle fasce basse
      PesiStrSett[i]:=0;
      for f:=1 to BancaOreTOCSI.NumFasce do
        inc(PesiStrSett[i],SettBancaOreEcc[i].MinStrSett[f]*(7 - f));
      if PesiStrSett[i] > PesoMax then
      begin
        PesoMax:=PesiStrSett[i];
        SettRecupero:=i;
      end;
    end;
    if SettRecupero >= 0 then
    begin
      dec(SettBancaOreEcc[SettRecupero].SaldoApp,TO_CSI_ARR_STRAOSETT);
      Result:=TO_CSI_ARR_STRAOSETT;
    end;
  end;

  function GetSaldoSett(D:TDateTime):Integer;
  //Restituisce il totale dei saldi giornalieri per la settimana identificata da D
  var i:Integer;
  begin
    Result:=0;
    for i:=0 to High(GGBancaOreEcc) do
    begin
      if R180Between(GGBancaOreEcc[i].Data,D,D + OFFSET_FINESETT) then
        inc(Result,GGBancaOreEcc[i].Saldo);
    end;
  end;
  function GetEccedenza(D:TDateTime; Fascia:Integer; NoStrao:Boolean):Integer;
  {Restituisce l'eccedenza abbattibile per giorno e fascia specifici}
  var i,j:Integer;
      SaldoSett:Integer;
  begin
    Result:=0;
    for i:=0 to High(GGBancaOreEcc) do
      if D = GGBancaOreEcc[i].Data then
      begin
        if BancaOreTOCSI.GestioneSettimanale then
        begin
          //Verifica se il giorno è compreso in una settimana (lu..sa) che ha un'eccedenza
          for j:=0 to High(SettBancaOreEcc) do
            if R180Between(D,SettBancaOreEcc[j].Data,SettBancaOreEcc[j].Data + OFFSET_FINESETT) then
            begin
              Result:=min(GGBancaOreEcc[i].Saldo,GGBancaOreEcc[i].MinStrGio[f]);
              if NoStrao then
                //Considero solo la parte extra Strao
                Result:=min(Result,max(0,SettBancaOreEcc[j].Saldo - SettBancaOreEcc[j].Strao))
              ELSE IF (not BancaOreTOCSI.AbbattimentoStandard) THEN
              BEGIN
                //Verifico che con l'abbattimento la settimana abbia il minimo utile per la liquidazione
                SaldoSett:=GetSaldoSett(SettBancaOreEcc[j].Data);
                Result:=min(Result,max(0,SaldoSett - SettBancaOreEcc[j].SaldoApp));
              END;
              dec(GGBancaOreEcc[i].MinStrGio[f],Result);
              Break;
            end;
          Break;
        end
        else
        begin
          Result:=min(GGBancaOreEcc[i].Saldo,GGBancaOreEcc[i].MinStrGio[f]);
          Break;
        end;
      end;
  end;
  procedure InsAbbattimento;
  {Registro l'abbattimento che verrà inserito successivamente come giustificativo}
  var i:Integer;
  begin
    for i:=0 to High(GGBancaOreEcc) do
      if D = GGBancaOreEcc[i].Data then
      begin
        dec(GGBancaOreEcc[i].Saldo,App);
        inc(GGBancaOreEcc[i].Abbattimento,App);
        Break;
      end;
  end;
begin
  if BancaOreTOCSI.GestioneSettimanale then
  begin
    //Per ogni settimana che ha dell'eccedenza, limito le eccedenze dei singoli gg in modo che il totale non superi l'eccedenza settimanale (lu..sa)
    LimitaEccedenzeSettimanali;
    //primo giro di abbattimento per ogni settimana, dell'eccedenza che non è liquidabile = Saldo - Strao (extra arrotondamenti o sotto il minimo)
    for i:=High(SettBancaOreEcc) downto 0 do
    begin
      //Scorro le fasce in modo da abbattere prima le fasce più basse
      for f:=1 to BancaOreTOCSI.NumFasce do
      begin
        D:=SettBancaOreEcc[i].Data + OFFSET_FINESETT;
        while (D >= SettBancaOreEcc[i].Data) and
              (BancaOreTOCSI.Abbattimento > 0) and
              (SettBancaOreEcc[i].Saldo - SettBancaOreEcc[i].Strao > 0) do
        begin
          App:=GetEccedenza(D,f,True);
          if App > 0 then
          begin
            App:=min(App,BancaOreTOCSI.Abbattimento);
            dec(BancaOreTOCSI.Abbattimento,App);
            dec(SettBancaOreEcc[i].Saldo,App);
            //registro abbattimento
            InsAbbattimento;
          end;
          D:=D - 1;
        end;
        if BancaOreTOCSI.Abbattimento = 0 then
          Break;
      end;
      if BancaOreTOCSI.Abbattimento = 0 then
        Break;
    end;
  end;

  if BancaOreTOCSI.StrAutorizzato = 0 then
    //Forzo la gestione standard dell'abbattimento se non non c'è straordinario autorizzato
    BancaOreTOCSI.AbbattimentoStandard:=True;
  if not BancaOreTOCSI.AbbattimentoStandard then
  begin
    //Applicazione abbattimento banca ore in modo da preservare per ogni settimana una quantità utile alla liquidazione,
    //dando priorità alle settimana che contengono straordinario nelle fasce più alte
    for i:=0 to High(SettBancaOreEcc) do
    begin
      SettBancaOreEcc[i].SaldoApp:=0;
      SetStrSett(i);
    end;

    for f:=BancaOreTOCSI.NumFasce downto 1 do
      for i:=High(SettBancaOreEcc) downto 0 do
        PreservaStrLiquidabile(i,f);

    for i:=0 to High(SettBancaOreEcc) do
      if (SettBancaOreEcc[i].SaldoApp > 0) and (SettBancaOreEcc[i].SaldoApp < TO_CSI_MIN_STRAOSETT) then
        inc(SettBancaOreEcc[i].SaldoApp,RecuperaEccedenza(i));

    //da gestire meglio: se rimane uno spezzone di 15 minuti isolato, si può spostare su settimana che ha dello STESC
    //vedi 2035 aprile 2015
  end;

  //Giro definitivo di abbattimento dell'eccedenza su tutto il mese
  //Scorro le fasce in modo da abbattere prima le fasce più basse
  for f:=1 to BancaOreTOCSI.NumFasce do
  begin
    D:=Data2;
    while (D >= Data1) and (BancaOreTOCSI.Abbattimento > 0) do
    begin
      App:=GetEccedenza(D,f,False);
      if App > 0 then
      begin
        App:=min(App,BancaOreTOCSI.Abbattimento);
        dec(BancaOreTOCSI.Abbattimento,App);
        //registro abbattimento
        InsAbbattimento;
      end;
      D:=D - 1;
    end;
  end;
  //Inserimento effettivo giustificativi
  insT040.SetVariable('PROGRESSIVO',Prog);
  insT040.SetVariable('CAUSALE',TO_CSI_ABB_BANCAORE);
  insT040.SetVariable('TIPOGIUST','N');
  insT040.SetVariable('AORE',null);
  insT040.SetVariable('STAMPA','B');
  insT040.SetVariable('SCHEDA',null);
  for i:=0 to High(GGBancaOreEcc) do
  begin
    if GGBancaOreEcc[i].Abbattimento > 0 then
    begin
      insT040.SetVariable('DATA',GGBancaOreEcc[i].Data);
      insT040.SetVariable('DAORE',EncodeDate(1899,12,30) + GGBancaOreEcc[i].Abbattimento/1440);
      insT040.Execute;
    end;
  end;
  SessioneOracleR410.Commit;
end;

procedure TR410FAutoGiustificazioneDtM.DataModuleDestroy(Sender: TObject);
begin
  if R502ProDtM <> nil then
    FreeAndNil(R502ProDtM);
  if R600DtM <> nil then
    FreeAndNil(R600DtM);
end;

procedure TR410FAutoGiustificazioneDtM.CercaCausaliHMAssenza(Prog:Integer; Data1,Data2:TDateTime);
begin
  with selT040HMASSENZA do
  try
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA1',Data1);
    SetVariable('DATA2',Data2);
    Open;
    while not Eof do
    begin
      if FieldByName('NUMERO').AsInteger > 0 then
      begin
        RicalcoloCausaliHMAssenza(Prog,Data1,Data2,FieldByName('CAUSALE').AsString);
      end;
      Next;
    end;
  finally
    Close;
  end;
end;

procedure TR410FAutoGiustificazioneDtM.RicalcoloCausaliHMAssenza(Prog:Integer; Data1,Data2:TDateTime; Causale:String);
var A004MW:TA004FGiustifAssPresMW;
begin
  A004MW:=TA004FGiustifAssPresMW.Create(SessioneOracleR410);
  try
    A004MW.Var_Progressivo:=Prog;
    with A004MW.Q040 do
    begin
      //Leggo solo pochi record: non interessa leggere tutto il risultato della query
      ReadBuffer:=5;
      QueryAllRecords:=False;
      SetVariable('PROGRESSIVO',Prog);
      Open;
    end;
    //A004MW.Inserimento_CausaleHMAssenza(Prog,Data1,Data2,Causale);
    A004MW.Chek_CausaleHMAssenza(Prog,Data1,Data2,Causale,'N');
    A004MW._InserisciGiustifHMA(False);
  finally
    FreeAndNil(A004MW);
  end;
end;

end.

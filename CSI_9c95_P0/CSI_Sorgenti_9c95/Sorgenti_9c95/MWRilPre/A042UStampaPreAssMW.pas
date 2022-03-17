unit A042UStampaPreAssMW;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, R005UDataModuleMW, USelI010, DB, OracleData, RP502Pro,
  Datasnap.DBClient, C180FunzioniGenerali, StrUtils, R500Lin;

type
  TGiustificativi = Record
    dDataDa:TDateTime;
    dDataA:TDateTime;
    sCausale:string;
    xColore:TColor;
    sTipoGiustificativo:string;
    sPresenzaAssenza:string;  //'P'=Presenza - 'A'=Assenza
  end;

  TProspetto = Record
    sOraEntrata: string;
    sOraUscita: string;
    sTotaleConsecutive: string;
  end;

  TDatiDipendente = Record
    aDatiDipendente:array of TGiustificativi;
    sDescrizione:string;
  end;

  TCausali = Record
    sCodice:string;
    sDescrizione:string;
    xColore:TColor;
    sPresenzaAssenza:string;  //'P'=Presenza - 'A'=Assenza
  end;

  TA42GetColore = function(Codice:String):Integer of object;

  TA042FStampaPreAssMW = class(TR005FDataModuleMW)
    dscT275: TDataSource;
    selT275: TOracleDataSet;
    selT265: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    QTimbrature: TOracleDataSet;
    QTimbraturePROGRESSIVO: TFloatField;
    QTimbratureDATA: TDateTimeField;
    QTimbratureORA: TDateTimeField;
    QTimbratureVERSO: TStringField;
    QTimbratureCAUSALE: TStringField;
    QGiustificativi: TOracleDataSet;
    QGiustificativiPROGRESSIVO: TFloatField;
    QGiustificativiDATA: TDateTimeField;
    QGiustificativiCAUSALE: TStringField;
    QGiustificativiDAORE: TDateTimeField;
    QGiustificativiAORE: TDateTimeField;
    QGiustificativiPROGRCAUSALE: TFloatField;
    QGiustificativiTIPOGIUST: TStringField;
    QGiustificativiCODICE: TStringField;
    QGiustificativiAssenza: TOracleDataSet;
    QGiustificativiAssenzaPROGRESSIVO: TFloatField;
    QGiustificativiAssenzaDATA: TDateTimeField;
    QGiustificativiAssenzaCAUSALE: TStringField;
    QGiustificativiAssenzaTIPOGIUST: TStringField;
    QGiustificativiAssenzaDAORE: TDateTimeField;
    QGiustificativiAssenzaAORE: TDateTimeField;
    QGiustificativiAssenzaDESCRIZIONE: TStringField;
    dscT265: TDataSource;
    SelOrdinaArray: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    tOraDaLimite1, tOraALimite1:TTime;
    tOraDaLimite2, tOraALimite2:TTime;
    DaOra, AOra:String;
    sDaData,sAData:string;
    selI010:TselI010;
    GetColoreA: TA42GetColore;
    GetColoreP: TA42GetColore;
    sPb_CausaleEU: string;
    tPb_Limite1, tPb_Limite2:TTime;
    TimbraturaMezzanotte:Boolean;
    {!Dati passati da form!}
    ChkDescrizioneAssenzeMW:Boolean;
    RgpTipoStampaMW:integer;
    {!====================!}
    bPb_Intervallo1, bPb_Giornata1, bPb_Intervallo2, bPb_Giornata2:boolean;
    bPb_MostraCausaliNonAbbinate:boolean;
    ListaIntestazione, ListaDettaglio:TStringList;
    aPb_DatiDipendentiTimbGiusH: array of TDatiDipendente;
    aPb_DatiDipendentiGiustI: array of TDatiDipendente;
    aPb_DatiDipendentiGiustM: array of TDatiDipendente;
    aPb_LegendaCausali: array of TCausali;
    aPb_CausaliPresenza: array of TCausali;
    aPb_CausaliPresenzaDb: array of TCausali;
    aPb_CausaliAssenza: array of TCausali;
    aPb_CausaliAssenzaDb: array of TCausali;
    aArrayDep: array of TCausali;
    R502ProDtM1:TR502ProDtM1;
    function TimbratureOK:Boolean;
    function GiustificativiOK:Boolean;
    function DipendentePresente(Prog:Integer;Data:TDateTime):Boolean;
    procedure OrdinaArrayCausali(cPb_CodiceOreNonCausalizzate:string);
    procedure AggiornaQGiustificativiAssenza(Progr:Integer;Data:TDateTime);
    procedure AggiornaQTimbrature(Progr:Integer;Data:TDateTime);
    procedure AssegnaGiustificativi(var Giu1,Giu2,Giu3:String);
    procedure AggiornaQGiustificativi(Progr:Integer;Data:TDateTime);
    procedure GestisciAnomaliaBloccante(Progr:Integer;Data:TDateTime);
    procedure CreaTabellaStampa(Tipo:Boolean);
    procedure CreaTabellaStampaProspetto;
    procedure CreaTabellaStampaEUCausalizzate;
    procedure PopolaArrayCausali;
    procedure InserisciDipendente(Progr:Integer;Data:TDateTime);
    procedure InserisciDipendenteProspetto(Progr:Integer;Data:TDateTime);
    procedure InserisciDipendenteTabellaEUCausalizzate(Progr:Integer;Data:TDateTime);
    procedure AggiungiCausale(var aArray: array of TDatiDipendente; sCausale: string; dDataDa, dDataA: TDateTime; sTipoGiustificativo: string; ContatoreDipendente: Integer);
  end;

implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TA042FStampaPreAssMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  dscT265.DataSet:=selT265;
  ListaIntestazione:=TStringList.Create;
  ListaDettaglio:=TStringList.Create;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
end;

procedure TA042FStampaPreAssMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(R502ProDtM1);
  FreeAndNil(ListaDettaglio);
  FreeAndNil(ListaIntestazione);
  FreeAndNil(selI010);
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
end;

procedure TA042FStampaPreAssMW.OrdinaArrayCausali(cPb_CodiceOreNonCausalizzate:string);
var
  i:integer;
  //aArrayDep: array of TCausali; MW
  sDep:string;
begin
  Setlength(aArrayDep,0);
  //Se trovo il codice di ore n.c. lo inserisco per primo...
  for i:=0 to length(aPb_LegendaCausali)-1 do
    if aPb_LegendaCausali[i].sCodice = cPb_CodiceOreNonCausalizzate then
    begin
      setlength(aArrayDep,length(aArrayDep)+1);
      aArrayDep[length(aArrayDep)-1].sCodice:=aPb_LegendaCausali[i].sCodice;
      aArrayDep[length(aArrayDep)-1].sDescrizione:=aPb_LegendaCausali[i].sDescrizione;
      aArrayDep[length(aArrayDep)-1].xColore:=aPb_LegendaCausali[i].xColore;
      aArrayDep[length(aArrayDep)-1].sPresenzaAssenza:=aPb_LegendaCausali[i].sPresenzaAssenza;
    end;

  //Inserisco poi tutte le altre causali di presenza in ordine alfabetico
  SelOrdinaArray.Active:=False;
  SelOrdinaArray.SQL.Clear;
  for i:=0 to length(aPb_LegendaCausali)-1 do
  begin
    if (aPb_LegendaCausali[i].sCodice <> cPb_CodiceOreNonCausalizzate) and
       (aPb_LegendaCausali[i].sPresenzaAssenza = 'P') then
      SelOrdinaArray.SQL.Add('(SELECT ''' + aPb_LegendaCausali[i].sCodice + ''' AS CODICE FROM DUAL) UNION ');
  end;
  sDep:=copy(SelOrdinaArray.SQL.Text,1,length(SelOrdinaArray.SQL.Text)-9);
  if sDep <> '' then
  begin
    SelOrdinaArray.SQL.Clear;
    SelOrdinaArray.SQL.Add(sDep + ' ORDER BY CODICE');
    SelOrdinaArray.Active:=True;
    while not SelOrdinaArray.Eof do
    begin
      for i:=0 to length(aPb_LegendaCausali)-1 do
      begin
        if aPb_LegendaCausali[i].sCodice = SelOrdinaArray.FieldByName('CODICE').asString then
        begin
          setlength(aArrayDep,length(aArrayDep)+1);
          aArrayDep[length(aArrayDep)-1].sCodice:=aPb_LegendaCausali[i].sCodice;
          aArrayDep[length(aArrayDep)-1].sDescrizione:=aPb_LegendaCausali[i].sDescrizione;
          aArrayDep[length(aArrayDep)-1].xColore:=aPb_LegendaCausali[i].xColore;
          aArrayDep[length(aArrayDep)-1].sPresenzaAssenza:=aPb_LegendaCausali[i].sPresenzaAssenza;
        end;
      end;
      SelOrdinaArray.Next;
    end;

    //Inserisco poi tutte le altre causali di presenza in ordine alfabetico
    SelOrdinaArray.Active:=False;
    SelOrdinaArray.SQL.Clear;
    for i:=0 to length(aPb_LegendaCausali)-1 do
    begin
      if aPb_LegendaCausali[i].sPresenzaAssenza = 'A' then
        SelOrdinaArray.SQL.Add('(SELECT ''' + aPb_LegendaCausali[i].sCodice + ''' AS CODICE FROM DUAL) UNION ');
    end;
    sDep:=copy(SelOrdinaArray.SQL.Text,1,length(SelOrdinaArray.SQL.Text)-9);
    if sDep <> '' then
    begin
      SelOrdinaArray.SQL.Clear;
      SelOrdinaArray.SQL.Add(sDep + ' ORDER BY CODICE');
      SelOrdinaArray.Active:=True;
      while not SelOrdinaArray.Eof do
      begin
        for i:=0 to length(aPb_LegendaCausali)-1 do
        begin
          if aPb_LegendaCausali[i].sCodice = SelOrdinaArray.FieldByName('CODICE').asString then
          begin
            setlength(aArrayDep,length(aArrayDep)+1);
            aArrayDep[length(aArrayDep)-1].sCodice:=aPb_LegendaCausali[i].sCodice;
            aArrayDep[length(aArrayDep)-1].sDescrizione:=aPb_LegendaCausali[i].sDescrizione;
            aArrayDep[length(aArrayDep)-1].xColore:=aPb_LegendaCausali[i].xColore;
            aArrayDep[length(aArrayDep)-1].sPresenzaAssenza:=aPb_LegendaCausali[i].sPresenzaAssenza;
          end;
        end;
        SelOrdinaArray.Next;
      end;
    end;
  end;

  //Dopo aver ordinato l'array in uno di appoggio, riporto i dati nella'array di partenza...
  SetLength(aPb_LegendaCausali,0);
  for i :=0 to length(aArrayDep)-1 do
  begin
    setlength(aPb_LegendaCausali,length(aPb_LegendaCausali)+1);
    aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sCodice:=aArrayDep[i].sCodice;
    aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sDescrizione:=aArrayDep[i].sDescrizione;
    aPb_LegendaCausali[length(aPb_LegendaCausali)-1].xColore:=aArrayDep[i].xColore;
    aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sPresenzaAssenza:=aArrayDep[i].sPresenzaAssenza;
  end;

end;

// Controllo se le timbrature ricadono nella fascia richiesta.
function TA042FStampaPreAssMW.TimbratureOK:Boolean;
var
  DaOreMin,AOreMin,TimbMin:Integer;
  EPrec:Boolean;
begin
  Result:=False;
  DaOreMin:=R180OreMinutiExt(DaOra);
  AOreMin:=R180OreMinutiExt(AOra);
  EPrec:=R502ProDtM1.primat_u = 'si';
  QTimbrature.First;
  while not QTimbrature.Eof do
  begin
    TimbMin:=R180OreMinuti(QTimbrature.FieldByName('ORA').AsDateTime);
    if (TimbMin >= DaOreMin) and (TimbMin <= AOreMin) then
      Result:=True;
    if (QTimbrature.FieldByName('VERSO').AsString = 'E') then
      EPrec:=TimbMin < DaOreMin;
    if EPrec and (QTimbrature.FieldByName('VERSO').AsString = 'U') and (TimbMin > AOreMin) then
      Result:=True;
    if Result then
      Break;
    QTimbrature.Next;
  end;
  if (QTimbrature.RecordCount = 0) and
     ((R502ProDtM1.estimbprec = 'si') and (R502ProDtM1.verso_pre = 'E') and (R502ProDtM1.data_pre = R502ProDtM1.datacon - 1)) and
     (((R502ProDtM1.estimbsucc = 'si') and (R502ProDtM1.verso_suc = 'U') and (R502ProDtM1.data_suc = R502ProDtM1.datacon + 1)) or
      (R502ProDtM1.estimbsucc = 'no') or (R502ProDtM1.data_suc > R502ProDtM1.datacon + 1)) then
    Result:=True;
  if (not Result) and EPrec and TimbraturaMezzanotte then
    Result:=True;
end;

// Controllo se le timbrature ricadono nella fascia richiesta.
function TA042FStampaPreAssMW.GiustificativiOK:Boolean;
var
  GDaOre,GAore:TDateTime;
  Prosegui:Boolean;
begin
  Result:=False;
  QGiustificativi.First;
  while not QGiustificativi.EOF  do
  begin
    if QGiustificativi.FieldByName('TipoGiust').AsString = 'D' then
    begin

      Prosegui:=True;
      try
       GDaOre:=QGiustificativi.FieldByName('DaOre').Value;
      except
       Prosegui:=False;
       GDaOre:=StrToTime('00.00');
      end;
      try
       GAOre:=QGiustificativi.FieldByName('AOre').Value;
      except
       Prosegui:=False;
       GAOre:=StrToTime('00.00');
      end;

      if Prosegui then
      begin
        if R180OreMinuti(GDaOre) = R180OreMinutiExt(AOra) then
        begin
          // L' ora di inizio del giustificativo coincide con la fine della fascia
          // scelta e quindi non lo considero presente.
        end
        else if R180OreMinuti(GAOre) = R180OreMinutiExt(DAOra) then
        begin
          // L' ora di fine del giustificativo coincide con l' inizio della fascia
          // scelta e quindi non lo considero presente.
        end
          // giustificativo le cui ore sono comprese nella fascia scelta.
        else if ((R180OreMinuti(GDaOre) >= R180OreMinutiExt(DaOra)) and
                 (R180OreMinuti(GDaOre) <= R180OreMinutiExt(AOra))) or
                ((R180OreMinuti(GAOre) >= R180OreMinutiExt(DaOra)) and
                 (R180OreMinuti(GAOre) <= R180OreMinutiExt(AOra))) or
                ((R180OreMinuti(GDaOre) <= R180OreMinutiExt(DaOra)) and
                 (R180OreMinuti(GAore) >= R180OreMinutiExt(AOra))) then
        begin
          Result:=True;
          Break;
        end;
      end;

    end
    else if QGiustificativi.FieldByName('TipoGiust').AsString = 'N' then
    begin
      //if (DaOraStr='00.00')and(AOraStr='23.59') then
      if (DaOra = '00.00') and (AOra = '23.59') then
      begin
        Result:=True;
        Break;
      end;
    end;
    QGiustificativi.Next;
  end;
end;

procedure TA042FStampaPreAssMW.AggiornaQTimbrature(Progr:Integer;Data:TDateTime);
begin
  QTimbrature.Close;
  QTimbrature.SetVariable('Progressivo',Progr);
  QTimbrature.SetVariable('Data',Data);
  QTimbrature.Open;
end;

// Controllo i giustificativi del dipendente per vedere se era presente.
function TA042FStampaPreAssMW.DipendentePresente(Prog:Integer;Data:TDateTime):Boolean;
begin
  AggiornaQGiustificativi(Prog,Data);
  AggiornaQTimbrature(Prog,Data);
  if TimbratureOK then
    Result:=True
  else
    Result:=GiustificativiOK;
end;

procedure TA042FStampaPreAssMW.AggiornaQGiustificativiAssenza(Progr:Integer;Data:TDateTime);
begin
  QGiustificativiAssenza.Close;
  QGiustificativiAssenza.SetVariable('Progressivo',Progr);
  QGiustificativiAssenza.SetVariable('Data',Data);
  QGiustificativiAssenza.Open;
end;

procedure TA042FStampaPreAssMW.GestisciAnomaliaBloccante(Progr:Integer;Data:TDateTime);
var
  YY,MM,GG,I:Word;
  HH,Min,SS,MS:Word;
  App:String;
  NewTime:TDateTime;
  xx,zz:Integer;
begin
  AggiornaQTimbrature(Progr,Data);
  AggiornaQGiustificativi(Progr,Data);
  AggiornaQGiustificativiAssenza(Progr,Data);

  for xx:=Low(R502ProDtM1.m_tab_timbrature) to High(R502ProDtM1.m_tab_timbrature) do
    for zz:=1 to MaxTimbrature do
    begin
      R502ProDtM1.m_tab_timbrature[xx,zz].tcaustimb:='';
      R502ProDtM1.m_tab_timbrature[xx,zz].tflagtimb:=#0;
      R502ProDtM1.m_tab_timbrature[xx,zz].toratimb:=0;
      R502ProDtM1.m_tab_timbrature[xx,zz].trilevtimb:='';
      R502ProDtM1.m_tab_timbrature[xx,zz].tversotimb:=#0;
    end;

  for xx:=Low(R502ProDtM1.m_tab_giustificativi) to High(R502ProDtM1.m_tab_giustificativi) do
    for zz:=1 to MaxGiustif do
    begin
      R502ProDtM1.m_tab_giustificativi[xx,zz].tallegius:=0;
      R502ProDtM1.m_tab_giustificativi[xx,zz].tcausgius:='';
      R502ProDtM1.m_tab_giustificativi[xx,zz].tdallegius:=0;
      R502ProDtM1.m_tab_giustificativi[xx,zz].tflscheda:=#0;
      R502ProDtM1.m_tab_giustificativi[xx,zz].tproggius:=0;
      R502ProDtM1.m_tab_giustificativi[xx,zz].ttipogius:=#0;
    end;

  QTimbrature.First;
  I:=1;
  DecodeDate(Data,YY,MM,GG);
  while not QTimbrature.EOF do
  begin
    if I <= 20 then
    begin
      R502ProDtM1.m_tab_Timbrature[GG,I].tOraTimb:=QTimbrature.FieldByName('Ora').Value;
      App:=QTimbrature.FieldByName('Verso').AsString;
      try
        R502ProDtM1.m_tab_Timbrature[GG,I].tVersoTimb:=App[1];
      except
      end;
      R502ProDtM1.m_tab_Timbrature[GG,I].tCausTimb:=QTimbrature.FieldByName('Causale').AsString;
    end;
    QTimbrature.Next;
    inc(I);
  end;

  TimbraturaMezzanotte:=True;
  HH:=23;
  Min:=59;
  SS:=00;
  MS:=00;
  NewTime:=EncodeTime(HH,Min,SS,MS);
  R502ProDtM1.m_tab_Timbrature[GG,I].tOraTimb:=NewTime;
  R502ProDtM1.m_tab_Timbrature[GG,I].tVersoTimb:='U';
  R502ProDtM1.m_tab_Timbrature[GG,I].tCausTimb:='';

  I:=1;
  QGiustificativi.First;
  while not(QGiustificativi.EOF) do
  begin
    if I <= 10 then
    begin
      R502ProDtM1.m_tab_Giustificativi[GG,I].tCausGius:=QGiustificativi.FieldByName('Causale').Value;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tDalleGius:=QGiustificativi.FieldByName('DaOre').Value;
      except
      end;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tAlleGius:=QGiustificativi.FieldByName('AOre').Value;
      except
      end;
      App:=QGiustificativi.FieldByName('TipoGiust').AsString;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tTipoGius:=App[1];
      except
        R502ProDtM1.m_tab_Giustificativi[GG,I].tTipoGius:=#0;
      end;
    end;
    QGiustificativi.Next;
    inc(I,1);
  end;

  QGiustificativiAssenza.First;
  while not(QGiustificativiAssenza.EOF) do
  begin
    if I <= 10 then
    begin
      R502ProDtM1.m_tab_Giustificativi[GG,I].tCausGius:=QGiustificativiAssenza.FieldByName('Causale').Value;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tDalleGius:=QGiustificativiAssenza.FieldByName('DaOre').Value;
      except
      end;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tAlleGius:=QGiustificativiAssenza.FieldByName('AOre').Value;
      except
      end;
      App:=QGiustificativiAssenza.FieldByName('TipoGiust').AsString;
      try
        R502ProDtM1.m_tab_Giustificativi[GG,I].tTipoGius:=App[1];
      except
        R502ProDtM1.m_tab_Giustificativi[GG,I].tTipoGius:=#0;
      end;
    end;
    QGiustificativiAssenza.Next;
    inc(I,1);
  end;
end;

procedure TA042FStampaPreAssMW.AggiornaQGiustificativi(Progr:Integer;Data:TDateTime);
begin
  QGiustificativi.Close;
  QGiustificativi.SetVariable('Progressivo',Progr);
  QGiustificativi.SetVariable('Data',Data);
  QGiustificativi.Open;
end;

procedure TA042FStampaPreAssMW.AssegnaGiustificativi(var Giu1,Giu2,Giu3:String);
var
  i:Integer;
  App:String;
  A:Char;
begin
  Giu1:='';
  Giu2:='';
  Giu3:='';
  if RgpTipoStampaMW = 0 then  // giustificativi di presenza
  begin
    I:=1;
    QGiustificativi.First;
    while not QGiustificativi.Eof and (I <= 6) do
    begin
      A:=R180CarattereDef(QGiustificativi.FieldByName('TipoGiust').AsString,1,#0);
      case A of
        'D':begin
              App:=QGiustificativi.FieldByName('Causale').AsString+' da '+
                   FormatDateTime('HH:MM',QGiustificativi.FieldByName('DaOre').Value)+' a '+
                   FormatDateTime('HH:MM',QGiustificativi.FieldByName('AOre').Value)+' ';
            end;
        'N':begin
              App:=QGiustificativi.FieldByName('Causale').AsString + ' ORE ' +
                   FormatDateTime('HH:MM',QGiustificativi.FieldByName('DaOre').Value)+' ';
            end;
      end;
      case I of
        1..2:if Giu1 <> '' then
               Giu1:=Giu1+'- '+App
             else
               Giu1:=App;
        3..4:if Giu2 <> '' then
               Giu2:=Giu2+'- '+App
             else
               Giu2:=App;
        5..6:if Giu3 <> '' then
               Giu3:=Giu3+'- '+App
             else
               Giu3:=App;
      end;
      inc(I,1);
      QGiustificativi.Next;
    end;
  end
  else
  if RgpTipoStampaMW = 1 then // giustificativi di assenza
  begin
    i:=1;
    while not QGiustificativiAssenza.EOF and(I <= 6) do
    begin
      A:=R180CarattereDef(QGiustificativiAssenza.FieldByName('TipoGiust').AsString,1,#0);
      case A of
        'I':begin
              App:=App+QGiustificativiAssenza.FieldByName('Causale').AsString + IfThen(ChkDescrizioneAssenzeMW,'('+QGiustificativiAssenza.FieldByName('Descrizione').AsString+')','') + ' GG  ';
            end;
        'M':begin
              App:=App+QGiustificativiAssenza.FieldByName('Causale').AsString + IfThen(ChkDescrizioneAssenzeMW,'('+QGiustificativiAssenza.FieldByName('Descrizione').AsString+')','') + ' MG  ';
            end;
        'D':begin
              App:=QGiustificativiAssenza.FieldByName('Causale').AsString + IfThen(ChkDescrizioneAssenzeMW,'('+QGiustificativiAssenza.FieldByName('Descrizione').AsString+')','') + ' da '+
                   FormatDateTime('HH:MM',QGiustificativiAssenza.FieldByName('DaOre').Value) + ' a ' +
                   FormatDateTime('HH:MM',QGiustificativiAssenza.FieldByName('AOre').Value) + ' '
            end;
        'N':begin
              App:=QGiustificativiAssenza.FieldByName('Causale').AsString + IfThen(ChkDescrizioneAssenzeMW,'('+QGiustificativiAssenza.FieldByName('Descrizione').AsString+')','') + ' ORE ' +
                   FormatDateTime('HH:MM',QGiustificativiAssenza.FieldByName('DaOre').Value) + ' ';
            end;
      end;
      case I of
        1..2:if Giu1 <> '' then
               Giu1:=Giu1+'- '+App
             else
               Giu1:=App;
        3..4:if Giu2 <> '' then
               Giu2:=Giu2+'- '+App
             else
               Giu2:=App;
        5..6:if Giu3 <> '' then
               Giu3:=Giu3+'- '+App
             else
               Giu3:=App;
      end;
      inc(I,1);
      QGiustificativiAssenza.Next;
    end;
  end;
end;

procedure TA042FStampaPreAssMW.InserisciDipendente(Progr:Integer;Data:TDateTime);
var
  i,j,L:Integer;
  Giust1,Giust2,Giust3,Tim1,Tim2,Tim3,C,S:String;
begin
  //Stampa Presenti-Assenti
  TabellaStampa.Insert;
  S:='';
  for j:=0 to ListaIntestazione.Count - 1 do
  begin
    if Trim(S) <> '' then
      S:=S + ' - ';
    S:=S + VarToStr(selI010.Lookup('NOME_CAMPO',ListaIntestazione.Strings[j],'NOME_LOGICO')) + ' ' +
       SelAnagrafe.FieldByName(ListaIntestazione.Strings[j]).AsString;
  end;
  TabellaStampa.FieldByName('Gruppo').Value:=S;
  S:='';
  for j:=0 to ListaDettaglio.Count -1 do
  begin
    //if Length(ListaDettaglio.Strings[j]) > C700SelAnagrafe.FieldByName(ListaDettaglio.Strings[j]).Size then
    //  L:=Length(ListaDettaglio.Strings[j])
    if Length(VarToStr(selI010.Lookup('NOME_CAMPO',ListaDettaglio.Strings[j],'NOME_LOGICO'))) > SelAnagrafe.FieldByName(ListaDettaglio.Strings[j]).Size then
      L:=Length(VarToStr(selI010.Lookup('NOME_CAMPO',ListaDettaglio.Strings[j],'NOME_LOGICO')))
    else
      L:=SelAnagrafe.FieldByName(ListaDettaglio.Strings[j]).Size;
    S:=S + Format('%-*s',[L+2,Copy(SelAnagrafe.FieldByName(ListaDettaglio.Strings[j]).AsString,1,L)]);
    //Format('testo %*s da restituire %d %*f',[10,'stringa',date,2,34.5678])
  end;
  TabellaStampa.FieldByName('Dettaglio').Value:=S;
  TabellaStampa.FieldByName('Progressivo').Value:=Progr;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').Value;
  TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Nome').Value;
  TabellaStampa.FieldByName('Data').Value:=Data;
  QTimbrature.First;
  I:=1;
  Tim1:='';
  Tim2:='';
  Tim3:='';
  while not QTimbrature.EOF and (I <= 18) do
    begin
      if not QTimbrature.FieldByName('Causale').IsNull then
      begin
        if RgpTipoStampaMW = 3 then
          C:=QTimbrature.FieldByName('Causale').asString
        else
          C:='c';
      end
      else
        C:='';
      case I of
        1..6:begin
               Tim1:=Tim1+QTimbrature.FieldByName('Verso').AsString+
               FormatDateTime('HH:MM',QTimbrature.FieldByName('Ora').Value)+C+' ';
             end;
        7..12:begin
                Tim2:=Tim2+QTimbrature.FieldByName('Verso').AsString+
                FormatDateTime('HH:MM',QTimbrature.FieldByName('Ora').Value)+C+' ';
              end;
        13..18:begin
                 Tim3:=Tim3+QTimbrature.FieldByName('Verso').AsString+
                 FormatDateTime('HH:MM',QTimbrature.FieldByName('Ora').Value)+C+' ';
               end;
      end;
      inc(I,1);
      QTimbrature.Next;
    end;
  TabellaStampa.FieldByName('Timb1').Value:=Tim1+' '+Tim2+' '+Tim3;
  AssegnaGiustificativi(Giust1,Giust2,Giust3);
  TabellaStampa.FieldByName('Giust1').Value:=Giust1;
  if Giust2 <> '' then
    begin
    TabellaStampa.FieldByName('Giust1').Value:=Giust1+'-'+Giust2;
    if Giust3 <> '' then
      TabellaStampa.FieldByName('Giust1').Value:=Giust1+'-'+Giust2+'-'+Giust3;
    end;
  if R502ProDtM1.blocca <> 0 then
    TabellaStampa.FieldByName('Giust1').Value:=R502ProDtM1.DescAnomaliaBloccante;
  TabellaStampa.Post;
end;

procedure TA042FStampaPreAssMW.CreaTabellaStampa(Tipo:Boolean);
begin
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,500,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  if Tipo then //Tabella per stampa tabellare
  begin
    TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('Presenze',ftString,144,False);
    TabellaStampa.IndexDefs.Clear;
    TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Cognome;Nome;Progressivo'),[ixUnique]);
  end
  else  // Stampa Normale
  begin
    TabellaStampa.FieldDefs.Add('Dettaglio',ftString,300,False);
    TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
    TabellaStampa.FieldDefs.Add('Timb1',ftString,144,False);
    //TabellaStampa.FieldDefs.Add('Giust1',ftString,144,False);
    TabellaStampa.FieldDefs.Add('Giust1',ftString,1000,False);
    TabellaStampa.IndexDefs.Clear;
    TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Data;Cognome;Nome;Progressivo'),[ixUnique]);
  end;
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA042FStampaPreAssMW.CreaTabellaStampaProspetto;
begin
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;

  TabellaStampa.FieldDefs.Add('Gruppo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Data',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('OraEntrata',ftString,5,False);
  TabellaStampa.FieldDefs.Add('OraUscita',ftString,5,False);
  //TabellaStampa.FieldDefs.Add('TotaleConsecutive',ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('TotaleConsecutive',ftString,5,False);
  TabellaStampa.FieldDefs.Add('Limite1',ftString,1,False);// Valore:S/N
  TabellaStampa.FieldDefs.Add('Limite2',ftString,1,False);// Valore:S/N
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Data;Gruppo;Nome;Matricola;OraEntrata;OraUscita'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA042FStampaPreAssMW.CreaTabellaStampaEUCausalizzate;
begin
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;

  TabellaStampa.FieldDefs.Add('Gruppo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Data',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('DataUscita',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('OraEntrata',ftString,5,False);
  TabellaStampa.FieldDefs.Add('OraUscita',ftString,5,False);
  TabellaStampa.FieldDefs.Add('NumOre',ftString,5,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Data;OraEntrata;OraUscita;Nome;Matricola'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA042FStampaPreAssMW.InserisciDipendenteTabellaEUCausalizzate(Progr:Integer;Data:TDateTime);

type
  RecCaus = record
    Causale:String;
    ECaus,UCaus:Integer;
    Giustif:Boolean;
  end;

var
  i,j:Integer;
  S:String;
  VetCausEU:array of RecCaus;

  function CalcolaNumOre:String;
  var
    OE,OU,OT:Integer;
  begin
    Result:='00.00';
    OE:=R180OreMinutiExt(TabellaStampa.FieldByName('OraEntrata').AsString);
    OU:=R180OreMinutiExt(TabellaStampa.FieldByName('OraUscita').AsString);
    OT:=OU - OE;
    if TabellaStampa.FieldByName('DataUscita').AsDateTime > TabellaStampa.FieldByName('Data').AsDateTime then
      OT:=OT + 1440;
    Result:=R180MinutiOre(OT);
  end;

  function CheckGiustif(idx:Integer):Boolean;
  {verifico se la timrbatura deriv da un giustificativo dalle..alle}
  var
    i:Integer;
  begin
    Result:=False;
    with R502ProDtM1 do
      for i:=1 to n_giusdaa do
      begin
        if (tgius_dallealle[i].tcausdaa = VetCausEU[idx].Causale) and
           (tgius_dallealle[i].tminutida = VetCausEU[idx].ECaus) and
           (tgius_dallealle[i].tminutia = VetCausEU[idx].UCaus) then
        begin
          Result:=True;
          Break;
        end;
      end;
  end;

begin
  with R502ProDtM1 do
  begin
    if Blocca = 0 then //Significa che uscendo dai conteggi non ci sono anomalie
    begin
      //Uniformo l'inserimento delle causali nel DataSet StampaTabella
      //creando un vettore intermedio
      SetLength(VetCausEU,0);
      if (ValStrT275[sPb_CausaleEU,'TIPOCONTEGGIO'] = 'A') or
         (ValStrT275[sPb_CausaleEU,'TIPOCONTEGGIO'] = 'E') then
      begin
        for i:=1 to n_rieppres do
          for j:=low(triepgiuspres[i].CoppiaEU) to High(triepgiuspres[i].CoppiaEU) do
          begin
            SetLength(VetCausEU,Length(VetCausEU)+1);
            with VetCausEU[High(VetCausEU)] do
            begin
              ECaus:=triepgiuspres[i].CoppiaEU[j].e;
              UCaus:=triepgiuspres[i].CoppiaEU[j].u;
              Causale:=triepgiuspres[i].tcauspres;
              Giustif:=False;
            end;
          end;
      end
      else
        for i:=1 to n_timbrcon do
        begin
          SetLength(VetCausEU,Length(VetCausEU)+1);
          with VetCausEU[High(VetCausEU)] do
          begin
            ECaus:=ttimbraturecon[i].tminutic_e;
            UCaus:=ttimbraturecon[i].tminutic_u;
            Causale:=ttimbraturecon[i].tcaus;
            Giustif:=CheckGiustif(High(VetCausEU)); //se giustif = True, le chiamate vengono mantenute separate anche se fatte con orari contigui
          end;
        end;

      //TIMBRATURE...
      if High(VetCausEU) > -1 then
      begin
        for i:=Low(VetCausEU) to High(VetCausEU) do
        begin
          if VetCausEU[i].Causale = sPb_CausaleEU then
          begin
            //Inserisco il dipendente nella tabella temporanea
            if (not VetCausEU[i].Giustif) and TabellaStampa.Locate('Data;Progressivo;OraEntrata',VarArrayOf([DateToStr(Data),Progr,R180MinutiOre(VetCausEU[i].UCaus)]),[]) then
            begin
              //Esiste già chiamata con Entrata = nuova Uscita
              TabellaStampa.Edit;
              TabellaStampa.FieldByName('OraEntrata').Value:=R180MinutiOre(VetCausEU[i].ECaus);
              try
                TabellaStampa.FieldByName('NumOre').Value:=CalcolaNumOre;
                TabellaStampa.Post;
              except
                TabellaStampa.Cancel;
              end;
              TabellaStampa.Last;
            end
            else if (not VetCausEU[i].Giustif) and TabellaStampa.Locate('Data;Progressivo;OraUscita',VarArrayOf([DateToStr(Data),Progr,R180MinutiOre(VetCausEU[i].ECaus)]),[]) then
            begin
              //Esiste già chiamata con Uscita = nuova Entrata
              TabellaStampa.Edit;
              TabellaStampa.FieldByName('OraUscita').Value:=R180MinutiOre(VetCausEU[i].UCaus);
              try
                TabellaStampa.FieldByName('NumOre').Value:=CalcolaNumOre;
                TabellaStampa.Post;
              except
                TabellaStampa.Cancel;
              end;
              TabellaStampa.Last;
            end
            else if (not VetCausEU[i].Giustif) and (VetCausEU[i].ECaus = 0) and TabellaStampa.Locate('Data;Progressivo;OraUscita',VarArrayOf([DateToStr(Data - 1),Progr,'24.00']),[]) then
            begin
              //Esiste già chiamata con Uscita = '24.00' nel giorno prima, e nuova Entrata = '00.00'
              TabellaStampa.Edit;
              TabellaStampa.FieldByName('OraUscita').Value:=R180MinutiOre(VetCausEU[i].UCaus);
              TabellaStampa.FieldByName('DataUscita').Value:=Data;
              try
                TabellaStampa.FieldByName('NumOre').Value:=CalcolaNumOre;
                TabellaStampa.Post;
              except
                TabellaStampa.Cancel;
              end;
              TabellaStampa.Last;
            end
            else
            begin
              //Nuova chiamata
              TabellaStampa.Insert;
              TabellaStampa.FieldByName('Data').Value:=Data;
              TabellaStampa.FieldByName('DataUscita').Value:=Data;
              TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
              TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Cognome').Value + ' ' + SelAnagrafe.FieldByName('Nome').Value;
              S:='';
              for j:=0 to ListaIntestazione.Count - 1 do
              begin
                if S.Trim <> '' then
                  S:=S + ' - ';
                S:=S + VarToStr(selI010.Lookup('NOME_CAMPO',ListaIntestazione.Strings[j],'NOME_LOGICO')) + ' ' +
                   SelAnagrafe.FieldByName(ListaIntestazione.Strings[j]).AsString;
              end;
              TabellaStampa.FieldByName('Gruppo').Value:=S;
              TabellaStampa.FieldByName('Progressivo').Value:=Progr;
              TabellaStampa.FieldByName('OraEntrata').Value:=R180MinutiOre(VetCausEU[i].ECaus);
              TabellaStampa.FieldByName('OraUscita').Value:=R180MinutiOre(VetCausEU[i].UCaus);
              try
                TabellaStampa.FieldByName('NumOre').Value:=CalcolaNumOre;
                TabellaStampa.Post;
              except
                TabellaStampa.Cancel;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TA042FStampaPreAssMW.InserisciDipendenteProspetto(Progr:Integer;Data:TDateTime);
var
  i,j:Integer;
  tEntrata, tUscita, tOraDa, tOraA:TTime;
  nContaOreConsecutiveLimite1, nContaOreConsecutiveLimite2:Real;
  Array_Prospetto: array of TProspetto;
  bSelezionaLimite1, bSelezionaLimite2: boolean;
  S:String;
begin
  with R502ProDtM1 do
  begin
    if Blocca = 0 then //Significa che uscendo dai conteggi non ci sono anomalie
    begin
      //TIMBRATURE...
      if n_timbrcon > 0 then
      begin

        SetLength(Array_Prospetto,0);
        bSelezionaLimite1:=True;
        bSelezionaLimite2:=False;

        if bPb_Intervallo1 then  //Barrare le ore consecutive minori di x nll'intervallo specificato
        begin
          tOraDaLimite1:=StrToTime(DaOra);
          tOraALimite1:=StrToTime(AOra);
        end
        else
        begin
          tOraDaLimite1:=strtotime('00.00.00');
          tOraALimite1:=strtotime('23.59.59');
        end;

        if bPb_Intervallo2 then  //Barrare le ore consecutive minori di x nll'intervallo specificato
        begin
          tOraDaLimite2:=StrToTime(DaOra);
          tOraALimite2:=StrToTime(AOra);
        end
        else
        begin
          tOraDaLimite2:=strtotime('00.00.00');
          tOraALimite2:=strtotime('23.59.59');
        end;

        //Leggo la prima timbratura
        tEntrata:=strtotime(R180MinutiOre(ttimbraturecon[1].tminutic_e));
        if ttimbraturecon[1].tminutic_u >= 1440 then
          tUscita:=strtotime('23.59.59')
        else
          tUscita:=strtotime(R180MinutiOre(ttimbraturecon[1].tminutic_u));
        for i:=2 to n_timbrcon do
        begin
          //Se la timbratura di uscita = alla timbratura di entrata successiva allora considero il tutto come la medesima timbratura
          if R180OreMinuti(tUscita) = ttimbraturecon[i].tminutic_e then
          begin
            if ttimbraturecon[i].tminutic_u >= 1440 then
              tUscita:=strtotime('23.59.59')
            else
              tUscita:=strtotime(R180MinutiOre(ttimbraturecon[i].tminutic_u));
          end
          else
          begin
            //ELABORO LE TIMBRATURE RELATIVE AL PRIMO INTERVALLO
            nContaOreConsecutiveLimite1:=0;
            tOraDa:=tEntrata;
            tOraA:=tUscita;
            if ((tOraDa < tOraDaLimite1) and ((tOraA >= tOraDaLimite1) and (tOraA <= tOraALimite1))) then
              tOraDa:=tOraDaLimite1;
            if ((tOraA > tOraALimite1) and ((tOraDa >= tOraDaLimite1) and (tOraDa <= tOraALimite1))) then
              tOraA:=tOraALimite1;
            if ((tOraDa < tOraALimite1) and (tOraA > tOraALimite1)) then
            begin
              tOraDa:=tOraDaLimite1;
              tOraA:=tOraALimite1;
            end;
            if (tOraDa>=tOraDaLimite1) and (tOraA<=tOraALimite1) then
              nContaOreConsecutiveLimite1:= R180OreMinuti(tOraA-tOraDa);
            if nContaOreConsecutiveLimite1 >= R180OreMinuti(tPb_Limite1) then
               bSelezionaLimite1:=False;
            //ELABORO LE TIMBRATURE RELATIVE AL SECONDO INTERVALLO
            nContaOreConsecutiveLimite2:=0;
            tOraDa:=tEntrata;
            tOraA:=tUscita;
            if ((tOraDa < tOraDaLimite2) and ((tOraA >= tOraDaLimite2) and (tOraA <= tOraALimite2))) then
              tOraDa:=tOraDaLimite2;
            if ((tOraA > tOraALimite2) and ((tOraDa >= tOraDaLimite2) and (tOraDa <= tOraALimite2))) then
              tOraA:=tOraALimite2;
            if ((tOraDa < tOraALimite2) and (tOraA > tOraALimite2)) then
            begin
              tOraDa:=tOraDaLimite2;
              tOraA:=tOraALimite2;
            end;
            if (tOraDa>=tOraDaLimite2) and (tOraA<=tOraALimite2) then
              nContaOreConsecutiveLimite2:= R180OreMinuti(tOraA-tOraDa);
            if nContaOreConsecutiveLimite2 >= R180OreMinuti(tPb_Limite2) then
               bSelezionaLimite2:=True;
            //VERIFICO SE INSERIRE O MENO LE TIMBRATURE a seconda che cadano nell'intervallo specificato...
            //if (tEntrata >= DaOra) and (tUscita <= AOra) then //Se sono all'interno dell'intervallo inserisco la timbratura
            if (R180OreMinuti(tEntrata) < R180OreMinutiExt(DaOra)) and
               (R180OreMinuti(tUscita) >= R180OreMinutiExt(DaOra)) and
               (R180OreMinuti(tUscita) <= R180OreMinutiExt(AOra)) then
              tEntrata:=StrToTime(DaOra);
            if (R180OreMinuti(tUscita) > R180OreMinutiExt(AOra)) and
               (R180OreMinuti(tEntrata) >= R180OreMinutiExt(DaOra)) and
               (R180OreMinuti(tEntrata) <= R180OreMinutiExt(AOra)) then
              tUscita:=StrToTime(AOra);
            if (R180OreMinuti(tEntrata) < R180OreMinutiExt(AOra)) and
               (R180OreMinuti(tUscita) > R180OreMinutiExt(AOra)) then
            begin
              tEntrata:=StrToTime(DaOra);
              tUscita:=StrToTime(AOra);
            end;
            if (R180OreMinuti(tEntrata) >= R180OreMinutiExt(DaOra)) and
               (R180OreMinuti(tUscita) <= R180OreMinutiExt(AOra)) then
            begin
              //Inserisco il dipendente nel Vettore
              SetLength(Array_Prospetto,Length(Array_Prospetto) + 1);
              Array_Prospetto[Length(Array_Prospetto)-1].sOraEntrata:=FormatDateTime('hh.nn',tEntrata);
              Array_Prospetto[Length(Array_Prospetto)-1].sOraUscita:=FormatDateTime('hh.nn',tUscita);
              Array_Prospetto[Length(Array_Prospetto)-1].sTotaleConsecutive:=FormatDateTime('hh.nn', tUscita - tEntrata);
            end;
            //PROCEDO CON LA LETTURA DELLE TIMBRATURE...
            if ttimbraturecon[i].tminutic_e >= 1440 then
              tEntrata:=strtotime('23.59.59')
            else
              tEntrata:=strtotime(R180MinutiOre(ttimbraturecon[i].tminutic_e));
            if ttimbraturecon[i].tminutic_u >= 1440 then
              tUscita:=strtotime('23.59.59')
            else
              tUscita:=strtotime(R180MinutiOre(ttimbraturecon[i].tminutic_u));
          end;
        end;

        //ELABORO LE TIMBRATURE RELATIVE AL PRIMO INTERVALLO
        nContaOreConsecutiveLimite1:=0;
        tOraDa:=tEntrata;
        tOraA:=tUscita;
        if ((tOraDa < tOraDaLimite1) and ((tOraA >= tOraDaLimite1) and (tOraA <= tOraALimite1))) then
          tOraDa:=tOraDaLimite1;
        if ((tOraA > tOraALimite1) and ((tOraDa >= tOraDaLimite1) and (tOraDa <= tOraALimite1))) then
          tOraA:=tOraALimite1;
        if ((tOraDa < tOraALimite1) and (tOraA > tOraALimite1)) then
        begin
          tOraDa:=tOraDaLimite1;
          tOraA:=tOraALimite1;
        end;
        if (tOraDa>=tOraDaLimite1) and (tOraA<=tOraALimite1) then
          nContaOreConsecutiveLimite1:= R180OreMinuti(tOraA-tOraDa);
        if nContaOreConsecutiveLimite1 >= R180OreMinuti(tPb_Limite1) then
          bSelezionaLimite1:=False;
        //ELABORO LE TIMBRATURE RELATIVE AL SECONDO INTERVALLO
        nContaOreConsecutiveLimite2:=0;
        tOraDa:=tEntrata;
        tOraA:=tUscita;
        if ((tOraDa < tOraDaLimite2) and ((tOraA >= tOraDaLimite2) and (tOraA <= tOraALimite2))) then
          tOraDa:=tOraDaLimite2;
        if ((tOraA > tOraALimite2) and ((tOraDa >= tOraDaLimite2) and (tOraDa <= tOraALimite2))) then
          tOraA:=tOraALimite2;
        if ((tOraDa < tOraALimite2) and (tOraA > tOraALimite2)) then
        begin
          tOraDa:=tOraDaLimite2;
          tOraA:=tOraALimite2;
        end;
        if (tOraDa>=tOraDaLimite2) and (tOraA<=tOraALimite2) then
          nContaOreConsecutiveLimite2:= R180OreMinuti(tOraA-tOraDa);
        if nContaOreConsecutiveLimite2 >= R180OreMinuti(tPb_Limite2) then
           bSelezionaLimite2:=True;
        //VERIFICO SE INSERIRE O MENO LE TIMBRATURE a seconda che cadano nell'intervallo specificato...
        //if (tEntrata >= DaOra) and (tUscita <= AOra) then //Se sono all'interno dell'intervallo inserisco la timbratura
        if (R180OreMinuti(tEntrata) < R180OreMinutiExt(DaOra)) and
           (R180OreMinuti(tUscita) >= R180OreMinutiExt(DaOra)) and
           (R180OreMinuti(tUscita) <= R180OreMinutiExt(AOra)) then
          tEntrata:=StrToTime(DaOra);
        if (R180OreMinuti(tUscita) > R180OreMinutiExt(AOra)) and
           (R180OreMinuti(tEntrata) >= R180OreMinutiExt(DaOra)) and
           (R180OreMinuti(tEntrata) <= R180OreMinutiExt(AOra)) then
          tUscita:=StrToTime(AOra);
        if (R180OreMinuti(tEntrata) < R180OreMinutiExt(AOra)) and
           (R180OreMinuti(tUscita) > R180OreMinutiExt(AOra)) then
        begin
          tEntrata:=StrToTime(DaOra);
          tUscita:=StrToTime(AOra);
        end;
        if (R180OreMinuti(tEntrata) >= R180OreMinutiExt(DaOra)) and
           (R180OreMinuti(tUscita) <= R180OreMinutiExt(AOra)) then
        begin
          //Inserisco il dipendente nel Vettore
          SetLength(Array_Prospetto,Length(Array_Prospetto) + 1);
          Array_Prospetto[Length(Array_Prospetto)-1].sOraEntrata:=FormatDateTime('hh.nn',tEntrata);
          Array_Prospetto[Length(Array_Prospetto)-1].sOraUscita:=FormatDateTime('hh.nn',tUscita);
          Array_Prospetto[Length(Array_Prospetto)-1].sTotaleConsecutive:=FormatDateTime('hh.nn', tUscita - tEntrata);
        end;

        if Length(Array_Prospetto) > 0 then
        begin
          for i:=0 to Length(Array_Prospetto) - 1 do
          begin
            //Inserisco il dipendente nella tabella temporanea
            TabellaStampa.Insert;
            S:='';
            for j:=0 to ListaIntestazione.Count -1 do
            begin
              if Trim(S) <> '' then
                S:=S + ' - ';
              S:=S + VarToStr(selI010.Lookup('NOME_CAMPO',ListaIntestazione.Strings[j],'NOME_LOGICO')) + ' ' +
                 SelAnagrafe.FieldByName(ListaIntestazione.Strings[j]).AsString;
            end;
            TabellaStampa.FieldByName('Gruppo').Value:=S;
            TabellaStampa.FieldByName('Progressivo').Value:=Progr;
            TabellaStampa.FieldByName('Data').Value:=Data;
            TabellaStampa.FieldByName('OraEntrata').Value:=Array_Prospetto[i].sOraEntrata;
            TabellaStampa.FieldByName('OraUscita').Value:=Array_Prospetto[i].sOraUscita;
            TabellaStampa.FieldByName('TotaleConsecutive').Value:=Array_Prospetto[i].sTotaleConsecutive;
            //if i=0 then  //solo sul primo elemento
            begin
              TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
              TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Cognome').Value + ' ' + SelAnagrafe.FieldByName('Nome').Value;
              if bSelezionaLimite1 then
                TabellaStampa.FieldByName('Limite1').Value:='X';
              if bSelezionaLimite2 then
                TabellaStampa.FieldByName('Limite2').Value:='X';
            end;
            TabellaStampa.Post;
          end;
        end
        else  //Se non ho timbrature nell'intervallo specificato, ne ho sicuramente al di fuori
              //di esso, altrimenti n_timbrcon non sarebbe > 0
              //In questo caso inserisco soltanto le X
        begin
          //Inserisco il dipendente nella tabella temporanea
          TabellaStampa.Insert;
          S:='';
          for j:=0 to ListaIntestazione.Count -1 do
          begin
            if Trim(S) <> '' then
              S:=S + ' - ';
            S:=S + VarToStr(selI010.Lookup('NOME_CAMPO',ListaIntestazione.Strings[j],'NOME_LOGICO')) + ' ' +
               SelAnagrafe.FieldByName(ListaIntestazione.Strings[j]).AsString;
          end;
          TabellaStampa.FieldByName('Gruppo').Value:=S;
          TabellaStampa.FieldByName('Progressivo').Value:=Progr;
          TabellaStampa.FieldByName('Data').Value:=Data;
          TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
          TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Cognome').Value + ' ' + SelAnagrafe.FieldByName('Nome').Value;
          if bSelezionaLimite1 then
            TabellaStampa.FieldByName('Limite1').Value:='X';
          if bSelezionaLimite2 then
            TabellaStampa.FieldByName('Limite2').Value:='X';
          TabellaStampa.Post;
        end;
      end;
    end;
  end;
end;

procedure TA042FStampaPreAssMW.PopolaArrayCausali;
begin
  SetLength(aPb_CausaliAssenza,0);
  SetLength(aPb_CausaliPresenza,0);
  SetLength(aPb_CausaliAssenzaDb,0);
  SetLength(aPb_CausaliPresenzaDb,0);

  //Leggo nell'array le causali di assenza...
  selT265.Active:=false;
  selT265.Active:=true;
  while not selT265.Eof do
  begin
    SetLength(aPb_CausaliAssenza,length(aPb_CausaliAssenza)+1);
    aPb_CausaliAssenza[High(aPb_CausaliAssenza)].sCodice:=selT265.FieldByName('CODICE').asString;
    aPb_CausaliAssenza[High(aPb_CausaliAssenza)].sDescrizione:=selT265.FieldByName('DESCRIZIONE').asString;
    aPb_CausaliAssenza[High(aPb_CausaliAssenza)].xColore:=GetColoreA(selT265.FieldByName('CODICE').asString);
    //aPb_CausaliAssenza[High(aPb_CausaliAssenza)].xColore:=strtoint(C004FParamForm.GetParametro('COLOREA_' + selT265.FieldByName('CODICE').asString, inttostr(clWhite)));

    SetLength(aPb_CausaliAssenzaDb,length(aPb_CausaliAssenzaDb)+1);
    aPb_CausaliAssenzaDb[High(aPb_CausaliAssenzaDb)].sCodice:=selT265.FieldByName('CODICE').asString;
    aPb_CausaliAssenzaDb[High(aPb_CausaliAssenzaDb)].sDescrizione:=selT265.FieldByName('DESCRIZIONE').asString;
    aPb_CausaliAssenzaDb[High(aPb_CausaliAssenzaDb)].xColore:=GetColoreA(selT265.FieldByName('CODICE').asString);
    //aPb_CausaliAssenzaDb[High(aPb_CausaliAssenzaDb)].xColore:=strtoint(C004FParamForm.GetParametro('COLOREA_' + selT265.FieldByName('CODICE').asString, inttostr(clWhite)));

    selT265.Next;
  end;
  //Leggo nell'array le causali di presenza...
  selT275.Active:=false;
  selT275.Active:=true;
  while not selT275.Eof do
  begin
    SetLength(aPb_CausaliPresenza,length(aPb_CausaliPresenza)+1);
    aPb_CausaliPresenza[High(aPb_CausaliPresenza)].sCodice:=selT275.FieldByName('CODICE').asString;
    aPb_CausaliPresenza[High(aPb_CausaliPresenza)].sDescrizione:=selT275.FieldByName('DESCRIZIONE').asString;
    aPb_CausaliPresenza[High(aPb_CausaliPresenza)].xColore:=GetColoreP(selT275.FieldByName('CODICE').asString);
    //aPb_CausaliPresenza[High(aPb_CausaliPresenza)].xColore:=strtoint(C004FParamForm.GetParametro('COLOREP_' + selT275.FieldByName('CODICE').asString, inttostr(clWhite)));

    SetLength(aPb_CausaliPresenzaDb,length(aPb_CausaliPresenzaDb)+1);
    aPb_CausaliPresenzaDb[High(aPb_CausaliPresenzaDb)].sCodice:=selT275.FieldByName('CODICE').asString;
    aPb_CausaliPresenzaDb[High(aPb_CausaliPresenzaDb)].sDescrizione:=selT275.FieldByName('DESCRIZIONE').asString;
    aPb_CausaliPresenzaDb[High(aPb_CausaliPresenzaDb)].xColore:=GetColoreP(selT275.FieldByName('CODICE').asString);
    //aPb_CausaliPresenzaDb[High(aPb_CausaliPresenzaDb)].xColore:=strtoint(C004FParamForm.GetParametro('COLOREP_' + selT275.FieldByName('CODICE').asString, inttostr(clWhite)));

    selT275.Next;
  end;
end;

procedure TA042FStampaPreAssMW.AggiungiCausale(var aArray:array of TDatiDipendente; sCausale:string; dDataDa:TDateTime; dDataA:TDateTime; sTipoGiustificativo:string; ContatoreDipendente:Integer);
var i,n,nIndice:integer;
  xColoreCausale:TColor;
  bFound, bFoundCausale:boolean;
begin
  //Aggiungo la causale all'array
  nIndice:=length(aArray[ContatoreDipendente].aDatiDipendente);
  setlength(aArray[ContatoreDipendente].aDatiDipendente,nIndice+1);
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].dDataDa:=dDataDa;
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].dDataA:=dDataA;
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].sCausale:=sCausale;
  xColoreCausale:=clWhite;
  bFound:=false;
  //Cerco tra le causali di presenza...
  for i:=0 to length(aPb_CausaliPresenza)-1 do
    if aPb_CausaliPresenza[i].sCodice = sCausale then
    begin
      xColoreCausale:=aPb_CausaliPresenza[i].xColore;
      bFound:=true;
      bFoundCausale:=false;
      for n:=0 to length(aPb_LegendaCausali)-1 do
        if aPb_LegendaCausali[n].sCodice=sCausale then
          bFoundCausale:=true;
      if not bFoundCausale then
      begin
        SetLength(aPb_LegendaCausali,length(aPb_LegendaCausali)+1);
        aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sCodice:=sCausale;
        aPb_LegendaCausali[length(aPb_LegendaCausali)-1].xColore:=xColoreCausale;
        aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sPresenzaAssenza := 'P';
      end;
    end;
  //Se non la trovo, allora cerco tra le causali di assenza...
  if not bFound then
    for i:=0 to length(aPb_CausaliAssenza)-1 do
      if aPb_CausaliAssenza[i].sCodice = sCausale then
      begin
        xColoreCausale:=aPb_CausaliAssenza[i].xColore;
        bFoundCausale:=false;
        for n:=0 to length(aPb_LegendaCausali)-1 do
          if aPb_LegendaCausali[n].sCodice=sCausale then
            bFoundCausale:=true;
        if not bFoundCausale then
        begin
          SetLength(aPb_LegendaCausali,length(aPb_LegendaCausali)+1);
          aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sCodice:=sCausale;
          aPb_LegendaCausali[length(aPb_LegendaCausali)-1].xColore:=xColoreCausale;
          aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sPresenzaAssenza := 'A';
        end;
     end;
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].xColore:=xColoreCausale;
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].sTipoGiustificativo:=sTipoGiustificativo;
  aArray[ContatoreDipendente].aDatiDipendente[nIndice].sPresenzaAssenza:=aPb_LegendaCausali[length(aPb_LegendaCausali)-1].sPresenzaAssenza;
end;


end.

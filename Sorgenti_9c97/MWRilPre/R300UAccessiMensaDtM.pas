unit R300UAccessiMensaDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, C180FunzioniGenerali, Rp502Pro, A000UInterfaccia, Variants,
  QueryStorico, RegistrazioneLog, DatiBloccati, R350UCalcoloBuoniDtM;

const R300ANOM1  = 'Timbratura di mensa non compresa tra uscita/entrata';
      R300ANOM2  = 'Timbratura di mensa precedente alla prima entrata';
      R300ANOM3  = 'Timbrature di presenza non esistenti';
      R300ANOM4  = 'Anomalia sui conteggi giornalieri';
      R300ANOM5  = 'Pasto non conteggiato. Tempo minimo tra due pasti:';
      R300ANOM6  = 'Pasto maggiorato. Tempo minimo tra due pasti:';
      R300ANOM7  = 'Pausa mensa non prevista dall''orario';
      R300ANOM8  = 'Ore rese insufficienti: minimo';
      R300ANOM9  = 'Orario spezzato non autorizzato alla mensa';
      R300ANOM10 = 'Coppia incompleta';
      R300ANOM11 = 'Causale anomala';
      R300ANOM12 = 'Timbratura di mensa successiva all''ultima uscita';
      R300ANOM13 = 'Timbratura di mensa compresa tra entrata/uscita';
      R300ANOM14 = 'Regole dei buoni pasto non rispettate';
      R300ANOM15 = 'Timbrature di mensa esterne all''intervallo specificato';

type
  TPasti = record
    Causale:String;
    Conv,Interi,
    CenaConv,CenaInteri:Integer;
  end;

  TR300FAccessiMensaDtM = class(TDataModule)
    Q360: TOracleDataSet;
    Q370: TOracleDataSet;
    Q100: TOracleDataSet;
    selT305: TOracleDataSet;
    selT375: TOracleDataSet;
    Q360NUMTIMBPASTO: TStringField;
    Q360DIFFTRA2TIMB: TDateTimeField;
    Q360TIMBDOPOUSCITA: TStringField;
    Q360TIMBANTECENTRATA: TStringField;
    Q360CONTROLLOPRESENZA: TStringField;
    Q360INTERVALLO: TStringField;
    Q360PAUSAMENSAGESTITA: TStringField;
    Q360PRESENZAMINIMA: TStringField;
    Q360VOCEPAGHE1: TStringField;
    Q360VOCEPAGHE2: TStringField;
    Q360ORARIOSPEZZATO: TStringField;
    Q360CAUSALE: TStringField;
    Q360CENA_DALLE: TStringField;
    Q360CENA_ALLE: TStringField;
    Q360MENSA_STIMBRATA: TStringField;
    Q360MENSA_NON_STIMBRATA: TStringField;
    Q360ORE_MINIME: TStringField;
    Q360MENSA_STIMBRATA_INTERO: TStringField;
    Q360MENSA_NON_STIMBRATA_INTERO: TStringField;
    Q360TIMBANTECENTRATA_INTERO: TStringField;
    Q360TIMBDOPOUSCITA_INTERO: TStringField;
    Q360CONTROLLOPRESENZA_INTERO: TStringField;
    Q360ORARIOSPEZZATO_INTERO: TStringField;
    Q360PAUSAMENSAGESTITA_INTERO: TStringField;
    Q360PRESENZAMINIMA_INTERO: TStringField;
    Q360INTERVALLO_INTERO: TStringField;
    Q360ORE_MINIME_INTERO: TStringField;
    Q360CODICE: TStringField;
    Q360MATURA_BUONO: TStringField;
    Q360MATURA_BUONO_INTERO: TStringField;
    Q360MENSA_DALLE: TStringField;
    Q360MENSA_ALLE: TStringField;
    Q360INTERVALLO_PM_INTERO: TStringField;
    QDelete: TOracleQuery;
    QInsert: TOracleQuery;
    selT360: TOracleDataSet;
    QDelT680: TOracleQuery;
    insT680: TOracleQuery;
    procedure R300FAccessiMensaDtMCreate(Sender: TObject);
    procedure R300FAccessimensaDtMDestroy(Sender: TObject);
  private
    { Private declarations }
    Diff,DiffMag:Integer;
    FFiltroRilevatori:String;
    LFiltroRilevatori:TStringList;
    R502ProDtM1:TR502ProDtM1;
    R350DtM:TR350FCalcoloBuoniDtM;
    SPDaData,SPAData:TDateTime;
    SessioneOracleR300:TOracleSession;
    procedure PutFiltroRilevatori(R:String);
    function TimbraturaEsterna(Data:TDateTime; Ora,Prec:Integer; N:String; var VP,VS:String):Boolean;
    function GetTimbraturePresenza(Causale:Boolean):String;
  public
    { Public declarations }
    Anomalie:TStringList;
    PastiInt,PastiCon:Integer;
    AnomaliaBloccante,FiltroRilevT370:Boolean;
    TimbratureMensa:String;
    NumTimbratureMensa:Integer;
    DataConteggio:TDateTime;
    Pasti:array of TPasti;
    PastiTot:array of TPasti;
    QSAccessiMensa:TQueryStorico;
    selDatiBloccati:TDatiBloccati;
    procedure SettaPeriodo(DaData,AData:TDateTime);
    procedure ConteggiaPastiPeriodo(Progressivo:Integer; DataI,DataF:TDateTime; Aggiorna:Boolean);
    procedure ConteggiaPasti(Progressivo:Integer; Data:TDateTime);
    property TimbraturePresenza[Causale:Boolean]:String read GetTimbraturePresenza;
    property FiltroRilevatori:String read FFiltroRilevatori write PutFiltroRilevatori;
  end;

//var
//  R300FAccessiMensaDtM: TR300FAccessiMensaDtM;

implementation

{$R *.DFM}

procedure TR300FAccessiMensaDtM.R300FAccessiMensaDtMCreate(Sender: TObject);
var i:Integer;
begin
  SessioneOracleR300:=SessioneOracle;
  if Self.Owner <> nil then
    if Self.Owner is TOracleSession then
      SessioneOracleR300:=Self.Owner as TOracleSession;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracleR300;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracleR300;
  end;
  Q360.Open;
  selT305.Open;
  (* Alberto 12/11/012: Remmato!!!!!!!!
  Diff:=R180OreMinuti(Q360DiffTra2Timb.AsDateTime);
  DiffMag:=R180OreMinutiExt(Q360Intervallo.AsString);
  *)
  Anomalie:=TStringList.Create;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  QSAccessiMensa:=TQueryStorico.Create(nil);
  R350DtM:=nil;
  QSAccessiMensa.Session:=SessioneOracleR300;
  LFiltroRilevatori:=TStringList.Create;
  FiltroRilevatori:='';
  FiltroRilevT370:=False;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  SPDaData:=0;
  SPAData:=0;
end;

procedure TR300FAccessiMensaDtM.SettaPeriodo(DaData,AData:TDateTime);
begin
  if (DaData = SPDaData) and (AData = SPAData) then
    exit;
  SPDaData:=DaData;
  SPAData:=AData;
  Q100.Close;
  Q370.Close;
  Q100.SetVariable('DaData',DaData - 1);
  Q100.SetVariable('AData',AData + 1);
  Q100.SetVariable('Progressivo',0);
  Q370.SetVariable('DaData',DaData);
  Q370.SetVariable('AData',AData);
  Q370.SetVariable('Progressivo',0);
  selT375.SetVariable('DaData',DaData);
  selT375.SetVariable('AData',AData);
  selT375.SetVariable('Progressivo',0);
  R502ProDtM1.PeriodoConteggi(DaData,AData);
  R502ProDtM1.Conteggi('APERTURA',0,DaData);
end;

procedure TR300FAccessiMensaDtM.PutFiltroRilevatori(R:String);
begin
  LFiltroRilevatori.Clear;
  LFiltroRilevatori.CommaText:=R;
  FFiltroRilevatori:=R;
end;

procedure TR300FAccessiMensaDtM.ConteggiaPastiPeriodo(Progressivo:Integer; DataI,DataF:TDateTime; Aggiorna:Boolean);
var D:TDateTime;
    A,M,G:Word;
    i,buonipasto,ticket:Integer;
begin
  SetLength(PastiTot,0);
  D:=DataI;
  while D <= DataF do
  begin
    ConteggiaPasti(Progressivo,D);
    D:=D + 1;
  end;
  //Registrazione dati su T410
  if Aggiorna and (DataI = R180InizioMese(DataI)) and (DataF = R180FineMese(DataF)) then
  begin
    //Cancello i pasti solo se il riepilogo non è bloccato
    if not selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(DataI),'T410') then
    begin
      DecodeDate(DataI,A,M,G);
      QDelete.SetVariable('Progressivo',Progressivo);
      QDelete.SetVariable('Anno',A);
      QDelete.SetVariable('Mese',M);
      QDelete.Execute;
      QInsert.SetVariable('Progressivo',Progressivo);
      QInsert.SetVariable('Anno',A);
      QInsert.SetVariable('Mese',M);
      // se attivo il flag di Alimenta tabella Buoni Pasto nella A046,
      // aggiorna anche la tabella T680_BUONIMENSILI
      selT360.Open;
      buonipasto:=0;
      ticket:=0;
      if selT360.FieldByName('ALIMENTA_BUONIPASTO').AsString = 'S' then
      begin
        QDelT680.Close;
        QDelT680.SetVariable('PROGRESSIVO',Progressivo);
        QDelT680.SetVariable('ANNO',A);
        QDelT680.SetVariable('MESE',M);
        QDelT680.Execute;
        insT680.Close;
        insT680.SetVariable('PROGRESSIVO',Progressivo);
        insT680.SetVariable('ANNO',A);
        insT680.SetVariable('MESE',M);
      end;
      for i:=0 to High(PastiTot) do
        if (PastiTot[i].Interi > 0) or (PastiTot[i].Conv > 0) then
          with QInsert do
            try
              SetVariable('Causale',PastiTot[i].Causale);
              SetVariable('Pasti',PastiTot[i].Conv);
              SetVariable('Pasti2',PastiTot[i].Interi);
              Execute;
              if selT360.FieldByName('ALIMENTA_BUONIPASTO').AsString = 'S' then
                buonipasto:=PastiTot[i].Conv+PastiTot[i].Interi;
             except
            end;
      if selT360.FieldByName('ALIMENTA_BUONIPASTO').AsString = 'S' then
      begin
        insT680.SetVariable('BUONIPASTO',buonipasto);
        insT680.SetVariable('TICKET',ticket);
        insT680.Execute;
      end;
      selT360.Close;
      try
        RegistraLog.SettaProprieta('I','T410_PASTI','A049',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Progressivo));
        RegistraLog.InserisciDato('DATA','',DateToStr(EncodeDate(A,M,1)));
        RegistraLog.RegistraOperazione;
      except
      end;
      SessioneOracleR300.Commit;
    end;
  end;
end;

procedure TR300FAccessiMensaDtM.ConteggiaPasti(Progressivo:Integer; Data:TDateTime);
var Ora,Prec,NT:Integer;
    Buoni,Ticket:Integer; //Perugia_Regione
    Regola,VP,VS,Causale,Rilevatore:String;
    ObblSuppl,Anom,BPAnom:String; //Perugia_Regione
    Pasto,PastoInt:Boolean;
    procedure AddPastoCaus(C:String; Conv:Boolean; Q:Integer);
    var i:Integer;
        T,Cena:Boolean;
    begin
      if (LFiltroRilevatori.Count > 0) and
         ((Rilevatore <> '') and (LFiltroRilevatori.IndexOf(Rilevatore) = -1) or
          (Rilevatore = '') and (LFiltroRilevatori.IndexOf('**') = -1)) then
        exit;
      Cena:=False;
      if (not Q360Cena_Dalle.IsNull) or (not Q360Cena_Alle.IsNull) then
        Cena:=(Ora >= R180OreMinutiExt(Q360Cena_Dalle.AsString)) and (Ora <= R180OreMinutiExt(Q360Cena_Alle.AsString));
      if Conv then
        inc(PastiCon,Q)
      else
        inc(PastiInt,Q);
      if C = '' then
        C:='*';
      T:=False;
      for i:=0 to High(Pasti) do
        if Pasti[i].Causale = C then
        begin
          T:=True;
          if Conv then
          begin
            inc(Pasti[i].Conv,Q);
            if Cena then
              inc(Pasti[i].CenaConv,Q);
          end
          else
          begin
            inc(Pasti[i].Interi,Q);
            if Cena then
              inc(Pasti[i].CenaInteri,Q);
          end;
          Break;
        end;
      if not T then
      begin
        SetLength(Pasti,High(Pasti) + 2);
        i:=High(Pasti);
        Pasti[i].Causale:=C;
        if Conv then
        begin
          Pasti[i].Conv:=Q;
          if Cena then
            Pasti[i].CenaConv:=Q
          else
            Pasti[i].CenaConv:=0;
        end
        else
        begin
          Pasti[i].Interi:=Q;
          if Cena then
            Pasti[i].CenaInteri:=Q
          else
            Pasti[i].CenaInteri:=0;
        end;
      end;
      T:=False;
      for i:=0 to High(PastiTot) do
        if PastiTot[i].Causale = C then
        begin
          T:=True;
          if Conv then
          begin
            inc(PastiTot[i].Conv,Q);
            if Cena then
              inc(PastiTot[i].CenaConv,Q);
          end
          else
          begin
            inc(PastiTot[i].Interi,Q);
            if Cena then
              inc(PastiTot[i].CenaInteri,Q);
          end;
          Break;
        end;
      if not T then
      begin
        SetLength(PastiTot,High(PastiTot) + 2);
        i:=High(PastiTot);
        PastiTot[i].Causale:=C;
        if Conv then
        begin
          PastiTot[i].Conv:=Q;
          if Cena then
            PastiTot[i].CenaConv:=Q
          else
            PastiTot[i].CenaConv:=0;
        end
        else
        begin
          PastiTot[i].Interi:=Q;
          if Cena then
            PastiTot[i].CenaInteri:=Q
          else
            PastiTot[i].CenaInteri:=0;
        end;
      end;
    end;
begin
  DataConteggio:=Data;
  AnomaliaBloccante:=False;
  Anomalie.Clear;
  PastiCon:=0;
  PastiInt:=0;
  TimbratureMensa:='';
  NumTimbratureMensa:=0;
  Prec:=-1;
  NT:=0;
  PastoInt:=False;
  SetLength(Pasti,0);
  //Alberto 07/02/2007
  if Trim(Parametri.CampiRiferimento.C18_AccessiMensa) <> '' then
  begin
    QSAccessiMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C18_AccessiMensa,Progressivo,R180InizioMese(Data),R180FineMese(Data));
    if QSAccessiMensa.LocDatoStorico(Data) then
      Regola:=QSAccessiMensa.FieldByName('T430' + Parametri.CampiRiferimento.C18_AccessiMensa).AsString
    else
      Regola:='';
  end
  else
    Regola:='<UNICA>';
  if not Q360.SearchRecord('CODICE',Regola,[srFromBeginning]) then
    exit;

  Diff:=R180OreMinuti(Q360DiffTra2Timb.AsDateTime);
  DiffMag:=R180OreMinutiExt(Q360Intervallo.AsString);
  //Alberto 08/02/2007 - Perugia_Regione
  if Q360Matura_Buono.AsString = 'S' then
  begin
    if R350DtM = nil then
      R350DtM:=TR350FCalcoloBuoniDtM.Create(nil);
    R350DtM.R502ProDtM1.PeriodoConteggi(R180InizioMese(Data),R180FineMese(Data));
  end;
  if Data < Q370.GetVariable('DaData') then
  begin
    Q100.SetVariable('DaData',Data);
    Q370.SetVariable('DaData',Data);
    Q100.Close;
    Q370.Close;
  end;
  if Data > Q370.GetVariable('AData') then
  begin
    Q100.SetVariable('AData',Data);
    Q370.SetVariable('AData',Data);
    Q100.Close;
    Q370.Close;
  end;
  if Q370.GetVariable('Progressivo') <> Progressivo then
  begin
    Q100.SetVariable('Progressivo',Progressivo);
    Q370.SetVariable('Progressivo',Progressivo);
    Q100.Close;
    Q370.Close;
  end;
  if not Q100.Active then
    Q100.Open;
  if not Q370.Active then
    Q370.Open;
  with selT375 do
  begin
    if GetVariable('Progressivo') <> Progressivo then
    begin
      Close;
      SetVariable('Progressivo',Progressivo);
    end;
    Open;
    Filtered:=False;
    Filter:='Data = ' + FloatToStr(Data);
    Filtered:=True;
    //Alberto 09/02/2007: Perugia_Regione
    if (RecordCount > 0) and (Q360Matura_Buono.AsString = 'S') then
    begin
      R350DtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Progressivo,R180InizioMese(Data),R180FineMese(Data));
      BPAnom:=R350DtM.CalcolaBuoni(Progressivo,Data,Buoni,Ticket,ObblSuppl,Anom);
      if Buoni + Ticket = 0 then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),'Regola buoni pasto:' + BPAnom]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360Matura_Buono_Intero.AsString = 'S' then
          PastoInt:=True;
      end;
    end;
    while not Eof do
    begin
      if FieldByName('PranzoCena').AsString = 'C' then
        Ora:=R180OreMinutiExt(Q360Cena_Dalle.AsString)
      else
        Ora:=-1;
      Rilevatore:=FieldByName('Rilevatore').AsString;
      AddPastoCaus(FieldByName('Causale').AsString,not PastoInt,FieldByName('Accessi').AsInteger);
      Next;
    end;
  end;
  PastoInt:=False;
  if not Q370.SearchRecord('Data',Data,[srFromBeginning]) then
    exit;
  //Conteggi giornalieri per controlli sulla pausa mensa
  if (Q360PausaMensaGestita.AsString = 'S') or
     (Q360PresenzaMinima.AsString = 'S') or
     (Q360OrarioSpezzato.AsString = 'S') or
     (R180OreMinutiExt(Q360Ore_Minime.AsString) > 0) then
    with R502ProDtM1 do
    begin
      Conteggi('Cartolina',Progressivo,Data);
      if Blocca > 0 then
      begin
        Anomalie.Add(Format('%s %s',[DateToStr(Data),R300ANOM4]));
        AnomaliaBloccante:=True;
      end;
    end;
  repeat
    inc(NT);
    Ora:=R180OreMinuti(Q370.FieldByName('Ora').AsDateTime);
    Rilevatore:=Q370.FieldByName('Rilevatore').AsString;
    Causale:='';
    if FiltroRilevT370 and (LFiltroRilevatori.Count > 0) and (LFiltroRilevatori.IndexOf(Rilevatore) = -1) then
     Continue;
    if Q360Causale.AsString = 'S' then
      Causale:=Q370.FieldByName('Causale').AsString;
    if TimbratureMensa <> '' then
      TimbratureMensa:=TimbratureMensa + ' ';
    TimbratureMensa:=TimbratureMensa + R180MinutiOre(Ora);
    //Una timbratura per pasto
    if Q360NumTimbPasto.AsString = '1' then
    begin
      Pasto:=True;
      //Controllo intervallo minimo tra 2 pasti
      if (Diff > 0) and (NT > 1) and (Ora - Prec < Diff) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM5,R180MinutiOre(Diff)]));
        Prec:=Ora;
        Continue;
      end;
      //1-Controllo intervallo minimo tra 2 pasti convenzionati
      if (DiffMag > 0) and (NT > 1) and (Ora - Prec < DiffMag) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM6,R180MinutiOre(DiffMag)]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360INTERVALLO_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //2-Controllo esistenza di timbrature di presenza
      if (Q360ControlloPresenza.AsString = 'S') and not(Q100.SearchRecord('Data',Data,[srFromBeginning])) then
      begin
        Anomalie.Add(Format('%s %s',[DateToStr(Data),R300ANOM3]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360CONTROLLOPRESENZA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      TimbraturaEsterna(Data,Ora,Prec,'1',VP,VS);
      //3-Controllo che la timbratura di mensa non sia la prima del giorno
      if (Q360TimbAntecEntrata.AsString = 'S') and (VP = '') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM2]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360TIMBANTECENTRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //4-Controllo che la timbratura di mensa non sia l'ultima del giorno
      if (Q360TimbDopoUscita.AsString = 'S') and (VS = '') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM12]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360TIMBDOPOUSCITA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //5-Controllo che sia stata sbollata la presenza prima di accedere in mensa (Prima U e dopo E)
      if (Q360Mensa_Stimbrata.AsString = 'S') and ((VP <> 'U') or (VS <> 'E')) then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM1]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360MENSA_STIMBRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end
      //6-Controllo se la mensa è stata effettuata all'interno di una coppia E/U
      else if (Q360Mensa_Non_Stimbrata.AsString = 'S') and (VP = 'E') and (VS = 'U') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM13]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360MENSA_NON_STIMBRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //7-Controllo gestione Pausa Mensa
      if (not AnomaliaBloccante) and (Q360PausaMensaGestita.AsString = 'S') and (R502ProDtM1.PausaMensa = 'Z') and (R502ProDtM1.PeriodoLavorativo <> 'S') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM7]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360PAUSAMENSAGESTITA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //8-Controllo che le ore rese da presenza siano almeno quanto specificato dalle ore minime nelle regole di mensa
      if (not AnomaliaBloccante) and
         (R502ProDtM1.OreMensaMaturate < R180OreMinutiExt(Q360Ore_Minime.AsString)) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM8,Q360Ore_Minime.AsString]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360ORE_MINIME_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //9-Controllo che le ore rese da presenza siano almeno quanto specificato dal parametro 'Minuti minimi per detrazione automatica'
      if (not AnomaliaBloccante) and (Q360PresenzaMinima.AsString = 'S') and
         (R502ProDtM1.PausaMensa <> 'Z') and (R502ProDtM1.mmMinDetrazMensa > 0) and
         (R502ProDtM1.OreMensaMaturate < R502ProDtM1.mmMinDetrazMensa) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM8,R180MinutiOre(R502ProDtM1.mmMinDetrazMensa)]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360PRESENZAMINIMA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //10-Controllo che l'orario non sia spezzato
      if (not AnomaliaBloccante) and (Q360OrarioSpezzato.AsString = 'S') and (R502ProDtM1.PeriodoLavorativo = 'S') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM9]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360ORARIOSPEZZATO_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Alberto 08/02/2007 - Perugia_Regione
      //11-Controllo che si possa maturare il buono pasto
      if (not AnomaliaBloccante) and (Q360Matura_Buono.AsString = 'S') then
      begin
        R350DtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Progressivo,R180InizioMese(Data),R180FineMese(Data));
        BPAnom:=R350DtM.CalcolaBuoni(Progressivo,Data,Buoni,Ticket,ObblSuppl,Anom);
        if Buoni + Ticket = 0 then
        begin
          Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),'Regola buoni pasto:' + BPAnom]));
          //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
          if Q360Matura_Buono_Intero.AsString = 'S' then
            PastoInt:=True;
        end;
      end;
      if (R180OreMinuti(Q360MENSA_DALLE.AsDateTime) > Ora) or
         (R180OreMinuti(Q360MENSA_ALLE.AsDateTime) < Ora)  then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM15]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360INTERVALLO_PM_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
    end
    else
    //2 timbrature per pasto
    begin
      Pasto:=(NT mod 2) = 0;
      if not Pasto then
        PastoInt:=False;
      //Controllo intervallo minimo tra 2 pasti
      if (not Pasto) and (Diff > 0) and (NT > 1) and (Ora - Prec < Diff) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM5,R180MinutiOre(Diff)]));
        if Q370.SearchRecord('Data',Data,[]) then
        begin
          inc(NT);
          Ora:=R180OreMinuti(Q370.FieldByName('Ora').AsDateTime);
          if TimbratureMensa <> '' then
            TimbratureMensa:=TimbratureMensa + ' ';
          TimbratureMensa:=TimbratureMensa + R180MinutiOre(Ora);
          Prec:=Ora;
        end;
        Continue;
      end;
      //Controllo intervallo minimo tra 2 pasti convenzionati
      if (not Pasto) and (DiffMag > 0) and (NT > 1) and (Ora - Prec < DiffMag) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM6,R180MinutiOre(DiffMag)]));
        //1-Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360INTERVALLO_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo esistenza di timbrature di presenza
      if Pasto and (Q360ControlloPresenza.AsString = 'S') and not(Q100.SearchRecord('Data',Data,[srFromBeginning])) then
      begin
        Anomalie.Add(Format('%s %s',[DateToStr(Data),R300ANOM3]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360CONTROLLOPRESENZA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      TimbraturaEsterna(Data,Ora,Prec,'2',VP,VS);
      //Controllo che la timbratura di mensa non sia la prima del giorno
      if Pasto and (Q360TimbAntecEntrata.AsString = 'S') and (VP = '') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM2]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360TIMBANTECENTRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo che la timbratura di mensa non sia l'ultima del giorno
      if Pasto and (Q360TimbDopoUscita.AsString = 'S') and (VS = '') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM12]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360TIMBDOPOUSCITA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo che sia stata sbollata la presenza prima di accedere in mensa (Prima U e dopo E)
      if Pasto and (Q360TimbDopoUscita.AsString = 'S') and ((VP <> 'U') or (VS <> 'E')) then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM1]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360MENSA_STIMBRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end
      //Controllo se la mensa è stata effettuata all'interno di una coppia E/U
      else if (Q360Mensa_Non_Stimbrata.AsString = 'S') and (VP = 'E') and (VS = 'U') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM13]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360MENSA_NON_STIMBRATA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo gestione Pausa Mensa
      if (not AnomaliaBloccante) and Pasto and (Q360PausaMensaGestita.AsString = 'S') and (R502ProDtM1.PausaMensa = 'Z') and (R502ProDtM1.PeriodoLavorativo <> 'S') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM7]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360PAUSAMENSAGESTITA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo che le ore rese da presenza siano almeno quanto specificato dal parametro 'Minuti minimi per detrazione automatica'
      if (not AnomaliaBloccante) and Pasto and (Q360PresenzaMinima.AsString = 'S') and
         (R502ProDtM1.PausaMensa <> 'Z') and (R502ProDtM1.mmMinDetrazMensa > 0) and
         (R502ProDtM1.OreMensaMaturate < R502ProDtM1.mmMinDetrazMensa) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM8,R180MinutiOre(R502ProDtM1.mmMinDetrazMensa)]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360PRESENZAMINIMA_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo che le ore rese da presenza siano almeno quanto specificato dalle ore minime nelle regole di mensa
      if Pasto and
         (not AnomaliaBloccante) and
         (R502ProDtM1.OreMensaMaturate < R180OreMinutiExt(Q360Ore_Minime.AsString)) then
      begin
        Anomalie.Add(Format('%s %s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM8,Q360Ore_Minime.AsString]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360ORE_MINIME_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Controllo che l'orario non sia spezzato
      if (not AnomaliaBloccante) and Pasto and (Q360OrarioSpezzato.AsString = 'S') and (R502ProDtM1.PeriodoLavorativo = 'S') then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM9]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360ORARIOSPEZZATO_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
      //Alberto 08/02/2007 - Perugia_Regione
      //Controllo che si possa maturare il buono pasto
      if Pasto and (not AnomaliaBloccante) and (Q360Matura_Buono.AsString = 'S') then
      begin
        R350DtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Progressivo,R180InizioMese(Data),R180FineMese(Data));
        BPAnom:=R350DtM.CalcolaBuoni(Progressivo,Data,Buoni,Ticket,ObblSuppl,Anom);
        if Buoni + Ticket = 0 then
        begin
          Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),'Regola buoni pasto:' + BPAnom]));
          //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
          if Q360Matura_Buono_Intero.AsString = 'S' then
            PastoInt:=True;
        end;
      end;
      if (R180OreMinuti(Q360MENSA_DALLE.AsDateTime) > Ora) or
         (R180OreMinuti(Q360MENSA_ALLE.AsDateTime) < Ora)  then
      begin
        Anomalie.Add(Format('%s %s %s',[DateToStr(Data),R180MinutiOre(Ora),R300ANOM15]));
        //Se è spuntato il checkbox di applicazione importo intero allora lo applico...
        if Q360INTERVALLO_PM_INTERO.AsString = 'S' then
          PastoInt:=True;
      end;
    end;
    Prec:=Ora;
    if Pasto then
    begin
      if (Causale <> '') and (Q360Causale.AsString = 'S') then
        if not selT305.SearchRecord('CODICE',Causale,[srFromBeginning]) then
        begin
          PastoInt:=True;
          Anomalie.Add(Format('%s %s(%s) %s',[DateToStr(Data),R180MinutiOre(Ora),Causale,R300ANOM11]));
        end;
      if PastoInt then
        AddPastoCaus(Causale,False,1)
      else
        AddPastoCaus(Causale,True,1);
    end;
    PastoInt:=False;
  until not(Q370.SearchRecord('Data',Data,[]));
  //Controllo timbrature pari se num timb = '2'
  if (Q360NumTimbPasto.AsString = '2') and ((NT mod 2) <> 0) then
    Anomalie.Add(Format('%s %s',[DateToStr(Data),R300ANOM10]));
  if AnomaliaBloccante then
    begin
    PastiInt:=0;
    PastiCon:=0;
    SetLength(Pasti,0)
    end;
  if Q360NumTimbPasto.AsString = '2' then
    NumTimbratureMensa:=NT div 2
  else
    NumTimbratureMensa:=NT;
end;

function TR300FAccessiMensaDtM.TimbraturaEsterna(Data:TDateTime; Ora,Prec:Integer; N:String; var VP,VS:String):Boolean;
{Restituisce True se la timbratura di mensa è la prima o l'ultima del giorno
 Restituisce in VP e VS il verso della timbratura precedente e successiva alla mensa}
begin
  VP:='';
  VS:='';
  if N = '1' then
    Prec:=Ora;
  Result:=True;
  if not Q100.SearchRecord('Data',Data,[srFromBeginning]) then
    exit;
  repeat
    if R180OreMinuti(Q100.FieldByName('Ora').AsDateTime) <= Prec then
      VP:=Q100.FieldByName('Verso').AsString
    else if R180OreMinuti(Q100.FieldByName('Ora').AsDateTime) >= Ora then
      begin
      VS:=Q100.FieldByName('Verso').AsString;
      Break;
      end;
  until not Q100.SearchRecord('Data',Data,[]);
  //Ricerco timbrature a cavallo di mezzanotte
  if VP = '' then
    if Q100.SearchRecord('Data',Data - 1,[srFromEnd]) and (Q100.FieldByName('Verso').AsString = 'E') then
      VP:='E';
  if VS = '' then
    if Q100.SearchRecord('Data',Data + 1,[srFromBeginning]) and (Q100.FieldByName('Verso').AsString = 'U') then
      VS:='U';
  Result:=(VP = '') or (VS = '');
end;

function TR300FAccessiMensaDtM.GetTimbraturePresenza(Causale:Boolean):String;
begin
  Result:='';
  if Q100.SearchRecord('Data',DataConteggio,[srFromBeginning]) then
    repeat
      if Result <> '' then
        Result:=Result + ' ';
      Result:=Result + FormatDateTime('hh.nn',Q100.FieldByName('Ora').AsDateTime);
      if Causale and (not Q100.FieldByName('CAUSALE').IsNull) then
        Result:=Result + Format('(%s)',[Q100.FieldByName('CAUSALE').AsString]);
    until not(Q100.SearchRecord('Data',DataConteggio,[]));
end;

procedure TR300FAccessiMensaDtM.R300FAccessimensaDtMDestroy(Sender: TObject);
begin
  LFiltroRilevatori.Free;
  Anomalie.Free;
  FreeAndNil(R502ProDtM1);
  FreeAndNil(QSAccessiMensa);
  FreeAndNil(selDatiBloccati);
  if R350DtM <> nil then
    FreeAndNil(R350DtM);
end;

end.

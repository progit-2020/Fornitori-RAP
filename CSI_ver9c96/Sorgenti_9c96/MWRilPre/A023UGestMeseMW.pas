unit A023UGestMeseMW;

interface

uses
  SysUtils, Classes, DB, DBClient, StrUtils, Math, Variants,
  R005UDataModuleMW, R500Lin, Rp502Pro, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData
  {$IFNDEF IRISWEB},ComCtrls{$ENDIF}
  ;

type
  TGiorniConteggi = record
    Inizio,
    Fine: TDateTime;
    GiorniConsideratiList: TStringList;
  end;

  TA023FGestMeseMW = class(TR005FDataModuleMW)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    GiorniConteggi:TGiorniConteggi;
    function IsGiornoDaConsiderare(Giorno:TDateTime): Boolean;
    function  CopertoDaTimbratura(Ent,Usc: Integer): Boolean;
    procedure GestGiorno(Giorno: TDateTime; ConteggiEseguiti: Boolean = False);
    procedure AggiungiRiga(Giorno:TDateTime; Tipo:String; TagTimb:String;
      Dalle, Alle:Integer; Causale:String; TotLav,DebitoGG,Scost: Integer);
  public
    Progressivo: Integer;
    AccessoGiust: String;
    EntNomFlex,
    OrarioScorrimento: Boolean;
    {$IFNDEF IRISWEB}
    SB: TStatusBar;
    {$ENDIF}
    R502ProDtM: TR502ProDtM1;
    cdsGestMese: TClientDataSet;
    Q275: TOracleDataSet;
    selAssPres: TOracleDataSet;
    procedure PopolaDataset(Giorno: TDateTime); overload;
    procedure PopolaDataset(Inizio, Fine: TDateTime); overload;
  end;

const
  CAUSALE_MOS = 'MOS'; // per ora è considerata solo in W026 e non A023

{$IFNDEF IRISWEB}
var
  A023FGestMeseMW: TA023FGestMeseMW;
{$ENDIF}

implementation

{$R *.dfm}

procedure TA023FGestMeseMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  // struttura per i giorni da considerare nei conteggi
  with GiorniConteggi do
  begin
    Inizio:=0;
    Fine:=0;
    GiorniConsideratiList:=TStringList.Create;
  end;
  EntNomFlex:=True; // indica se l'entrata nominale deve includere la flessibilità
  OrarioScorrimento:=False; // indica se il dipendente ha un profilo orario con orari a scorrimento
end;

procedure TA023FGestMeseMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(GiorniConteggi.GiorniConsideratiList);
  inherited;
end;

procedure TA023FGestMeseMW.PopolaDataset(Giorno: TDateTime);
// funzione richiamata da W026
begin
  // richiama la gestione giornaliera indicando che i conteggi sono già stati eseguiti
  GestGiorno(Giorno,True);
end;

procedure TA023FGestMeseMW.PopolaDataset(Inizio, Fine: TDateTime);
// popolamento dataset
var
  D: TDateTime;
  {$IFNDEF IRISWEB}
  NumGG: Integer;
  TestoStatus: String;
  {$ENDIF}
begin
  {$IFNDEF IRISWEB}
  // feedback stato elaborazione nella statusbar
  if Assigned(SB) then
  begin
    TestoStatus:='Caricamento dati in corso... %d%%';
    SB.Panels[0].Text:=Format(TestoStatus,[0]);
    SB.Repaint;
  end;
  {$ENDIF}
  D:=Inizio;
  {$IFNDEF IRISWEB}
  NumGG:=Trunc(Fine - Inizio) + 1;
  {$ENDIF}
  try
    R502ProDtM.Resetta;
    R502ProDtM.ResettaProg;
    R502ProDtM.PeriodoConteggi(Inizio,Fine);
    while D <= Fine do
    begin
      if IsGiornoDaConsiderare(D) then
        GestGiorno(D);
      {$IFNDEF IRISWEB}
      // feedback stato elaborazione nella statusbar
      if Assigned(SB) then
      begin
        SB.Panels[0].Text:=Format(TestoStatus,[Trunc((D - Inizio) * 100 / NumGG)]);
        SB.Repaint;
      end;
      {$ENDIF}
      D:=D + 1;
    end;
    {$IFNDEF IRISWEB}
    // feedback stato elaborazione nella statusbar
    if Assigned(SB) then
    begin
      SB.Panels[0].Text:=Format(TestoStatus,[100]);
      SB.Repaint;
    end;
    {$ENDIF}
    // aggiorna il range di giorni considerati nei conteggi
    GiorniConteggi.Inizio:=Inizio;
    GiorniConteggi.Fine:=Fine;
  except
    on E:Exception do
      raise Exception.Create('Attenzione! Si è verificato un errore durante i conteggi del ' +
                             DateToStr(D) + '.' + #13#10 + E.Message);
  end;
end;

function TA023FGestMeseMW.IsGiornoDaConsiderare(Giorno:TDateTime): Boolean;
// Determina se il giorno dato è da considerare nel ricalcolo dei conteggi
// Il giorno è da considerare nei seguenti due casi:
// 1. la data è fuori dal range GiorniConteggi.Inizio - GiorniConteggi.Fine
//    (non si hanno quindi informazioni)
// 2. la data è compresa fra GiorniConteggi.Inizio e GiorniConteggi.Fine e
//    la data è inclusa nella stringlist dei giorni considerati per il ricalcolo:
//    GiorniConteggi.GiorniConsideratiList
begin
  // fuori dal range già valutato -> in assenza di informazioni il giorno viene considerato
  if (Giorno < GiorniConteggi.Inizio) or
     (Giorno > GiorniConteggi.Fine) then
  begin
    Result:=True;
    Exit;
  end;

  // il giorno è compreso nel range -> se è incluso nella stringlist restituisce true
  Result:=GiorniConteggi.GiorniConsideratiList.IndexOf(DateToStr(Giorno)) >= 0;
end;

function TA023FGestMeseMW.CopertoDaTimbratura(Ent,Usc: Integer): Boolean;
// Restituisce True se la timbratura (e/u) specificata è coperta
// da una timbratura effettiva.
var
  i: Integer;
begin
  Result:=False;
  for i:=1 to R502ProDtM.n_timbrdip do
    if (R502ProDtM.ttimbraturedip[i].tminutid_e <= Ent) and
       (R502ProDtM.ttimbraturedip[i].tminutid_u >= Usc) then
    begin
      Result:=True;
      Break;
    end;
end;

procedure TA023FGestMeseMW.GestGiorno(Giorno: TDateTime; ConteggiEseguiti: Boolean = False);
// Gestione giornaliera per verificare tutti i punti di timbratura
var
  i,j,pAss,index: Integer;
  PNConsiderati: TStringList;
  PNAttuale,PuntoNomIntersecato,
  EntNom,UscNom,UltimaUsc,MinutiMensa,
  Im,Fm{,FlexScoperta}: Integer;
  ScartoEccedenza,App,TimbE,TimbU:Integer;
  Tipo,UltimoTag: String;
  Prima: Boolean;
  timbArr, timbArrFiltrato: array of t_ttimbraturedip; // array zero-based!!
  function PosizioneIns(val:Integer): Integer;
  // Restituisce la posizione in cui la timbratura deve essere aggiunta
  // l'array timbArr viene ordinato per tminutid_e
  var
    i,cfr: Integer;
  begin
    Result:=0;

    // correzione dato timbratura se > 6000
    if val >= 6000 then
      val:=val - (6000 + 1440);

    // ciclo per reperire la posizione di inserimento
    for i:=Length(timbArr) - 1 downto 0 do
    begin
      // correzione dato se entrata i-esima > 6000
      cfr:=timbArr[i].tminutid_e - IfThen(timbArr[i].tminutid_e >= 6000,6000 + 1440);

      if val > cfr then
      begin
        Result:=i + 1;
        Break;
      end;
    end;
  end;
  function PosizioneAssPres(idx: Integer; var Tipo: String): Integer;
  // se la coppia dalle/alle è già inserita come giustificativo di assenza o presenza
  //  restituisce l'indice del vettore dei giustificativi, altrimenti -1
  var i: Integer;
  begin
    Result:=-1;
    Tipo:='';
    with R502ProDtM do
    begin
      for i:=1 to n_giusdaa do
      begin
        if (timbArr[idx].tag = 'TG=D') and
           (timbArr[idx].tminutid_e = tgius_dallealle[i].tminutida) and
           (timbArr[idx].tcausale_e.tcaus = tgius_dallealle[i].tcausdaa) then
        begin
          Tipo:='GP';
          Result:=i;
          Break;
        end
        else if (timbArr[idx].tag = 'TG=ASSENZA') and
                (timbArr[idx].tminutid_e = tgius_dallealle[i].tminutida) and
                (tgius_dallealle[i].tassenza) then
        begin
          Tipo:='GA';
          Result:=i;
          Break;
        end
        else if (timbArr[idx].tminutid_e = tgius_dallealle[i].tminutida) and
                (timbArr[idx].tminutid_u = tgius_dallealle[i].tminutia) then
        begin
          Tipo:=IfThen(tgius_dallealle[i].tassenza,'GA','GP');
          Result:=i;
          Break;
        end;
      end;
    end;
  end;
  (*
  function PosizioneAssPres(Dalle,Alle: Integer; var Tipo: String): Integer;
  // se la coppia dalle/alle è già inserita come giustificativo di assenza o presenza
  //  restituisce l'indice del vettore dei giustificativi, altrimenti -1
  var i: Integer;
  begin
    Result:=-1;
    Tipo:='';
    with R502ProDtM do
    begin
      for i:=1 to n_giusdaa do
        if (Dalle = tgius_dallealle[i].tminutida) and
           (Alle = tgius_dallealle[i].tminutia) then
        begin
          Tipo:=IfThen(tgius_dallealle[i].tassenza,'GA','GP');
          Result:=i;
          Break;
        end;
    end;
  end;
  *)
  procedure CreaArrTimbrature;
  // Creazione array di timbrature ordinato in base a tminutid_e
  var
    i,j,x:Integer;
  begin
    with R502ProDtM do
    begin
      SetLength(timbArr,0);
      for i:=1 to n_timbrdip do
      begin
        // esclude entrata/uscita uguali
        if ttimbraturedip[i].tminutid_e = ttimbraturedip[i].tminutid_u then
          Continue;
        // determina la posizione di ttimbraturedip[i] nel nuovo array
        x:=PosizioneIns(ttimbraturedip[i].tminutid_e);
        SetLength(timbArr,Length(timbArr) + 1);
        // spostamento elementi
        for j:=Length(timbArr) - 1 downto x + 1 do
        begin
          timbArr[j].inserita:=timbArr[j-1].inserita;
          timbArr[j].oralegsol:=timbArr[j-1].oralegsol;
          timbArr[j].spezzata:=timbArr[j-1].spezzata;
          timbArr[j].tag:=timbArr[j-1].tag;
          timbArr[j].tcausale_e:=timbArr[j-1].tcausale_e;
          timbArr[j].tcausale_u:=timbArr[j-1].tcausale_u;
          timbArr[j].tflagarr_e:=timbArr[j-1].tflagarr_e;
          timbArr[j].tflagarr_u:=timbArr[j-1].tflagarr_u;
          timbArr[j].tminutid_e:=timbArr[j-1].tminutid_e;
          timbArr[j].tminutid_u:=timbArr[j-1].tminutid_u;
          timbArr[j].tpuntnomin:=timbArr[j-1].tpuntnomin;
          timbArr[j].tpuntnominold:=timbArr[j-1].tpuntnominold;
          timbArr[j].trilev_e:=timbArr[j-1].trilev_e;
          timbArr[j].trilev_u:=timbArr[j-1].trilev_u;
        end;
        // copia elemento
        timbArr[x].inserita:=ttimbraturedip[i].inserita;
        timbArr[x].oralegsol:=ttimbraturedip[i].oralegsol;
        timbArr[x].spezzata:=ttimbraturedip[i].spezzata;
        timbArr[x].tag:=ttimbraturedip[i].tag;
        timbArr[x].tcausale_e:=ttimbraturedip[i].tcausale_e;
        timbArr[x].tcausale_u:=ttimbraturedip[i].tcausale_u;
        timbArr[x].tflagarr_e:=ttimbraturedip[i].tflagarr_e;
        timbArr[x].tflagarr_u:=ttimbraturedip[i].tflagarr_u;
        timbArr[x].tminutid_e:=ttimbraturedip[i].tminutid_e;
        timbArr[x].tminutid_u:=ttimbraturedip[i].tminutid_u;
        timbArr[x].tpuntnomin:=ttimbraturedip[i].tpuntnomin;
        timbArr[x].tpuntnominold:=ttimbraturedip[i].tpuntnominold;
        timbArr[x].trilev_e:=ttimbraturedip[i].trilev_e;
        timbArr[x].trilev_u:=ttimbraturedip[i].trilev_u;
        // verifica se le timbrature sono rif. al giorno precedente
        if timbArr[x].tminutid_e >= 6000 then
        begin
          timbArr[x].tag:='GiornoPrec';
          dec(timbArr[x].tminutid_e,6000);
          dec(timbArr[x].tminutid_u,6000);
        end;
      end;
    end;
  end;
  procedure FiltraArrTimbrature(PuntoNom: Integer);
  // Genera un array delle timbrature filtrato in base al punto nominale
  var
    PuntoNomStr: String;
    i,x: Integer;
  begin
    SetLength(timbArrFiltrato,0);
    x:=0;
    PuntoNomStr:=IntToStr(PuntoNom);
    for i:=0 to Length(timbArr) - 1 do
    begin
      if timbArr[i].tpuntnomin = PuntoNom then
      begin
        SetLength(timbArrFiltrato,x+1);
        timbArrFiltrato[x].inserita:=timbArr[i].inserita;
        timbArrFiltrato[x].oralegsol:=timbArr[i].oralegsol;
        timbArrFiltrato[x].spezzata:=timbArr[i].spezzata;
        timbArrFiltrato[x].tag:=timbArr[i].tag;
        timbArrFiltrato[x].tcausale_e:=timbArr[i].tcausale_e;
        timbArrFiltrato[x].tcausale_u:=timbArr[i].tcausale_u;
        timbArrFiltrato[x].tflagarr_e:=timbArr[i].tflagarr_e;
        timbArrFiltrato[x].tflagarr_u:=timbArr[i].tflagarr_u;
        timbArrFiltrato[x].tminutid_e:=timbArr[i].tminutid_e;
        timbArrFiltrato[x].tminutid_u:=timbArr[i].tminutid_u;
        timbArrFiltrato[x].tpuntnomin:=timbArr[i].tpuntnomin;
        timbArrFiltrato[x].tpuntnominold:=timbArr[i].tpuntnominold;
        timbArrFiltrato[x].trilev_e:=timbArr[i].trilev_e;
        timbArrFiltrato[x].trilev_u:=timbArr[i].trilev_u;
        x:=x + 1;
      end;
    end;
  end;
  function IntersecaPuntoNominale(Ent,Usc: Integer; var PNIntersecato: Integer): Boolean;
  // Restituisce True se la timbratura (e/u) interseca il punto nominale indicato
  var i,EntNom,UscNom:Integer;
  begin
    Result:=False;
    PNIntersecato:=0;
    for i:=1 to R502ProDtM.n_timbrnom do
    begin
      EntNom:=R502ProDtM.ttimbraturenom[i].tminutin_e + R502ProDtM.ttimbraturenom[i].flex;
      UscNom:=R502ProDtM.ttimbraturenom[i].tminutin_u;

      // verifica intersezione dei punti di timbratura con il punto nominale i-esimo
      if Min(UscNom,Usc) - Max(EntNom,Ent) > 0 then
      begin
        Result:=True;
        PNIntersecato:=i;
        Break;
      end;
    end;
  end;
  function IntersecaMensa(T1,T2: Integer; var PeriodoMensaTot: Integer): Boolean;
  // Restituisce True se la timbratura (e/u) specificata interseca una timbratura di mensa
  // Nel contempo, somma nella variabile PeriodoMensaTot il totale dei min. di mensa
  var
    i: Integer;
  begin
    Result:=False;
    if R502ProDtM.paumenges <> 'si' then
      Exit;

    for i:=0 to Length(R502ProDtM.TimbratureMensa) - 1 do
    begin
      if Min(R502ProDtM.TimbratureMensa[i].F,T2) - Max(R502ProDtM.TimbratureMensa[i].I,T1) > 0 then
      begin
        Result:=True;
        PeriodoMensaTot:=PeriodoMensaTot + (T2 - T1);
        Break;
      end;
    end;
  end;
begin
  with R502ProDtM do
  begin
    // effettua i conteggi giornalieri se necessario
    if not ConteggiEseguiti then
      Conteggi('Cartolina',Progressivo,Giorno);

    // daniloc.ini - 10.06.2010
    // non effettua operazioni se il dipendente non è in servizio nel giorno in elaborazione
    // questo evita problemi in caso dipendenti assunti in corso di mese
    if dipinser = 'no' then
      Exit;
    // daniloc.fine

    ScartoEccedenza:=SpezzoniNonCausEccedenti;
    // creazione array di ttimbraturedip per il giorno, ordinato in base a tminutid_e
    CreaArrTimbrature;

    PNConsiderati:=TStringList.Create;
    try
      // 1. ciclo su timbrature dipendente
      for i:=0 to Length(timbArr) - 1 do
      begin
        // straordinario
        if (timbArr[i].tpuntnomin = 0) or (debitogg = 0) then
        begin
          // verifica se la timbratura corrisponde ad un giust. di assenza / presenza
          //pAss:=PosizioneAssPres(timbArr[i].tminutid_e, timbArr[i].tminutid_u,Tipo);
          pAss:=PosizioneAssPres(i,Tipo);
          if (pAss < 0) or (timbArr[i].tpuntnomin > 0) then
          begin
            // straordinario (P)
            //Alberto: modifico eventualmente il punto di Entrata se il totale delle timbrature non appoggiate supera l'eccedenza giornaliera
            TimbE:=timbArr[i].tminutid_e;
            TimbU:=timbArr[i].tminutid_u;
            if (ValStrT275[timbArr[i].tcausale_e.tcaus,'ORENORMALI'] <> 'A') then
            begin
              App:=min(ScartoEccedenza,TimbU - TimbE);
              inc(TimbE,App);
              dec(ScartoEccedenza,App);
            end;
            if ValNumT020['ArrivRang'] > 0 then //Arrotondamento degli spezzoni anticipando la timbratura di uscita
            begin
              App:=TimbU - TimbE;
              App:=Trunc(R180Arrotonda(App,ValNumT020['ArrivRang'],'D'));
              dec(TimbU,TimbU - TimbE - App);
              if TimbU < 0 then
                TimbU:=1440 + TimbU;
            end;
            // SGIULIANOMILANESE_COMUNE.ini
            // per questo cliente occorre controllare che la durata dello spezzone
            // non ecceda il saldo gg (Rp502Pro.scost)
            // se si verifica questo caso occorre spostare in avanti l'inizio
            // dello spezzone per diminuirne la durata
            // es.
            //   - scostamento                 =  60 min. (1 ora)
            //   - spezzone di straordinario   = [16.00 - 18.00] = 120 min. (2 ore)
            //   - 120 > 60 -> l'inizio dello spezzone viene spostato in avanti di
            //     (120 - 60) minuti
            //   - spezzone modificato di str. = [17.00 - 18.00] = 60 min. (1 ora)
            if (Parametri.CampiRiferimento.C90_W026EccedGGTutta = 'N') and
               (ValStrT025['ITER_ECCGG_CHECKSALDO'] = 'S') and
               ((TimbU - TimbE) > scost) then
            begin
              // sposta in avanti l'inizio dello spezzone
              App:=max(0,(TimbU - TimbE) - scost); // garantisce spostamento >= 0
              inc(TimbE,App);
            end;
            // SGIULIANOMILANESE_COMUNE.fine
            AggiungiRiga(Giorno,'P',timbArr[i].tag,TimbE,TimbU,timbArr[i].tcausale_e.tcaus,totlav,debitogg,scost);
          end
          else
          begin
            // timbratura corrisponde a giustificativo di assenza (GA) oppure presenza (GP)
            AggiungiRiga(Giorno,Tipo,timbArr[i].tag,timbArr[i].tminutid_e,timbArr[i].tminutid_u,tgius_dallealle[pAss].tcausdaa,totlav,debitogg,scost);

            // se questa timbratura interseca uno spezzone con punto nominale > 0,
            // allora questo p.n. viene impostato sulla timbratura (che sarà considerata successivamente)
            if IntersecaPuntoNominale(timbArr[i].tminutid_e,timbArr[i].tminutid_u,PuntoNomIntersecato) then
              timbArr[i].tpuntnomin:=PuntoNomIntersecato;
          end;
        end
        else if (debitogg > 0) and (timbArr[i].tpuntnomin > 0) then
        begin
          // salva in una stringlist i punti nominali > 0 (saranno considerati successivamente)
          if not PNConsiderati.Find(IntToStr(timbArr[i].tpuntnomin),index) then
            PNConsiderati.Add(IntToStr(timbArr[i].tpuntnomin));
        end;
      end;

      // 2. ciclo di controllo sui punti nominali > 0
      MinutiMensa:=0;
      UltimaUsc:=-1;
      for i:=0 to PNConsiderati.Count - 1 do
      begin
        Prima:=True;
        PNAttuale:=StrToInt(PNConsiderati[i]);
        EntNom:=ttimbraturenom[PNAttuale].tminutin_e + IfThen(EntNomFlex,ttimbraturenom[PNAttuale].flex);
        UscNom:=ttimbraturenom[PNAttuale].tminutin_u;

        // crea l'array timbArrFiltrato, come filtro di timbArr con le sole timbrature appoggiate al punto nominale considerato
        FiltraArrTimbrature(PNAttuale);

        // ciclo sulle timbrature appoggiate al punto nominale considerato
        for j:=0 to Length(timbArrFiltrato) - 1 do
        begin
          UltimaUsc:=timbArrFiltrato[j].tminutid_u;
          UltimoTag:=timbArrFiltrato[j].tag;
          if Prima then
          begin
            if not CopertoDaTimbratura(EntNom,timbArrFiltrato[j].tminutid_e) then
            begin
              AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,EntNom,timbArrFiltrato[j].tminutid_e,'',totlav,debitogg,scost);
            end;
            Prima:=False;
          end;
          if j < Length(timbArrFiltrato) - 1 then
          begin
            if not CopertoDaTimbratura(timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e) then
            begin
              // verifica intersezione con pausa mensa
              if IntersecaMensa(timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e,MinutiMensa) then
              begin
                // se tot. pausa mensa > consentito, considera i minuti di sforamento come periodo da giustificare
                if MinutiMensa > R502ProDtM.PauMenMinUtilizzata then
                begin
                  Fm:=timbArrFiltrato[j+1].tminutid_e;
                  Im:=Fm - (MinutiMensa - R502ProDtM.PauMenMinUtilizzata);
                  AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,Im,Fm,'',totlav,debitogg,scost);
                end;
              end
              else
                AggiungiRiga(Giorno,'GA',timbArrFiltrato[j].tag,timbArrFiltrato[j].tminutid_u,timbArrFiltrato[j+1].tminutid_e,'',totlav,debitogg,scost);
            end;
          end;
        end;
        // considera l'ultima uscita
        if UltimaUsc >= 0 then
        begin
          if not CopertoDaTimbratura(UltimaUsc,UscNom) then
            AggiungiRiga(Giorno,'GA',UltimoTag,UltimaUsc,UscNom,'',totlav,debitogg,scost);
        end;
      end;
    finally
      SetLength(timbArr,0);
      SetLength(timbArrFiltrato,0);
      FreeAndNil(PNConsiderati);
    end;
  end; //=> end with
end;

procedure TA023FGestMeseMW.AggiungiRiga(Giorno:TDateTime; Tipo:String; TagTimb:String;
  Dalle, Alle:Integer; Causale:String; TotLav,DebitoGG,Scost: Integer);
// Aggiunge al client dataset la riga con i valori indicati
var
  FlagRiga,CavalloMezzanotte: String;
  FlagRigaSubCod: Integer;
  GiornoIns: TDateTime;
  IniOnCalcFields: TOnCalcFields;
begin
  // evita la scrittura di un periodo non valido
  if Dalle >= Alle then
    Exit;

  // gestione MOS.ini - daniloc. 19.01.2012
  // solo per W026 al momento
  if OrarioScorrimento and (Causale <> CAUSALE_MOS) then
    Exit;
  // gestione MOS.fine

  with cdsGestMese do
  begin
    // imposta il tipo di riga (A = automatica, B = bloccata)
    FlagRiga:='A';
    FlagRigaSubCod:=1;
    if Causale <> '' then
    begin
      // se la causale di assenza è di autogiustificazione -> imposta il flag tipo riga a "B" = bloccato
      if Tipo = 'A' then
      begin
        if Q275.SearchRecord('LINK_ASSENZA',Causale,[srFromBeginning]) then
        begin
          FlagRiga:='B';
          FlagRigaSubCod:=1;
        end;
      end;

      // se la causale non è tra quelle ammesse -> imposta il flag tipo riga a "B" = bloccato
      if (not selAssPres.SearchRecord('CODICE',Causale,[srFromBeginning])) and (Causale <> CAUSALE_MOS) then
      begin
        FlagRiga:='B';
        FlagRigaSubCod:=2;
      end;
    end;

    // imposta il tipo riga "B" se la funzione Giustificativi non è attiva in modifica
    if (AccessoGiust <> 'S') and
       ((Tipo = 'GA') or (Tipo = 'GP')) then
    begin
      FlagRiga:='B';
      FlagRigaSubCod:=3;
    end;

    // determina il giorno da inserire nella griglia (può essere diverso da quello dei conteggi)
    GiornoIns:=Giorno;
    // 1. tag 'GiornoPrec' indica timbrature rif. al giorno precedente
    if TagTimb = 'GiornoPrec' then
      GiornoIns:=GiornoIns - 1;
    // 2. timbrature riferite al giorno successivo (periodo inizia dopo le 23.59)
    if (Dalle >= 1440) and (Alle >= 1440) then
    begin
      GiornoIns:=GiornoIns + 1;
      Dalle:=Dalle - 1440;
      Alle:=Alle - 1440;
    end;

    // gestione periodo a cavallo di mezzanotte
    CavalloMezzanotte:=IfThen((Dalle < 1440) and (Alle >= 1440),'S','N');

    // evita riscrittura di record identici
    // (non considera il flag_riga nella locate, in quanto si tratta dell'inserimento iniziale)
    if not Locate('DATA;DALLE_ORIG;ALLE_ORIG;TIPO',VarArrayOf([GiornoIns,Dalle,Alle,Tipo]),[]) then
    begin
      IniOnCalcFields:=OnCalcFields;
      OnCalcFields:=nil;

      // inserisce il record sul client dataset
      Append;
      FieldByName('FLAG_RIGA').AsString:=FlagRiga;
      FieldByName('FLAG_RIGA_SUBCOD').AsInteger:=FlagRigaSubCod;
      FieldByName('DATA').AsDateTime:=GiornoIns;
      FieldByName('DATA_CONTEGGI').AsDateTime:=Giorno;
      FieldByName('TIPO').AsString:=Tipo;
      FieldByName('CAVALLO_MEZZANOTTE').AsString:=CavalloMezzanotte;
      FieldByName('DATA_ORIG').AsDateTime:=GiornoIns;
      FieldByName('DALLE_ORIG').AsInteger:=Dalle;
      FieldByName('ALLE_ORIG').AsInteger:=Alle;
      FieldByName('DALLE_H').AsString:=R180MinutiOre(Dalle);
      FieldByName('ALLE_H').AsString:=R180MinutiOre(IfThen(CavalloMezzanotte ='S',Alle - 1440,Alle)); // corregge il dato "alle" visualizzato
      FieldByName('CAUSALE').AsString:=Causale;
      FieldByName('CAUSALE_ORIG').AsString:=Causale;
      FieldByName('TOTLAV').AsInteger:=TotLav;
      FieldByName('DEBITOGG').AsInteger:=DebitoGG;
      FieldByName('SCOST').AsInteger:=Scost;
      FieldByName('ID_EVENTO_STR').Value:=null;
      FieldByName('SERVIZIO').AsString:='';
      if Causale <> '' then
      begin
        if R502ProDtM.cdsT320.Locate('DATA;DALLE;CAUSALE',VarArrayOf([Giorno,R180MinutiOre(Dalle),Causale]),[]) then
        begin
          FieldByName('ID_EVENTO_STR').Value:=R502ProDtM.cdsT320.FieldByName('ID_EVENTO_STR').AsInteger;
          FieldByName('SERVIZIO').AsString:=R502ProDtM.cdsT320.FieldByName('SERVIZIO').AsString;
          FieldByName('SERVIZIO_ORIG').AsString:=FieldByName('SERVIZIO').AsString;
        end;
      end;
      try
        Post;
      except
        on E: Exception do
        begin
          if not (E is EAbort) then
          begin
            {$IFDEF IRISWEB}
            MsgBox.MessageBox(Format('%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
            {$ELSE}
            R180MessageBox(Format('%s (%s)',[E.Message,E.ClassName]),ESCLAMA);
            {$ENDIF}
          end;
        end;
      end;

      // aggiunge la data alla lista di giorni considerati
      // *** notare che viene utilizzato il giorno su cui sono stati effettuati i conteggi,
      // *** e non quello effettivamente inserito nella griglia
      if GiorniConteggi.GiorniConsideratiList.IndexOf(DateToStr(Giorno)) = -1 then
        GiorniConteggi.GiorniConsideratiList.Add(DateToStr(Giorno));

      OnCalcFields:=IniOnCalcFields;
    end;
  end;
end;

end.

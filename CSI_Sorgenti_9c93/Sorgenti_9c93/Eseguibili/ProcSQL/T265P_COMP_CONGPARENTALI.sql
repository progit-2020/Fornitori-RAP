create or replace procedure T265P_COMP_CONGPARENTALI (
/*
   Questa procedure estrae le variazioni alle competenze iniziali per le causali
   con tipo cumulo 'F' legate ai congedi parentali.

  I dati restituiti sono:
  - P_OFFSET_MAXINDIVIDUALE
      variazione per la fruizione massima individuale
      viene valorizzato solo nel caso di presenza di entrambi i coniugi / conviventi
  - P_OFFSET_MMINTERI
      variazione per i mesi interi fruiti
  - P_OFFSET_MMINTERI_DIP
      variazione per i mesi interi fruiti solo dal dipendente (escludendo il coniuge)
  - P_OFFSET_MMCONT
      variazione per la fruizione dei mesi continuativi necessari definiti sulla causale
  - P_OFFSET_MMCONT_DIP
      variazione per la fruizione di mesi continuativi definiti su causale (escludendo il coniuge)
  - P_OFFSET_GGVUOTI
      variazione per giorni vuoti nel caso di fruizione frazionata

  Concetto di "mese continuativo":
    il mese è considerato continuativo se il periodo di assenza dura almeno
    fino al giorno prima del mese successivo all¿inizio del periodo stesso)

  Concetto di "fruizione frazionata":
    Nel caso in cui il lavoratore, a seguito di un periodo di congedo parentale, fruisca, immediatamente dopo, di giorni di ferie o malattia, e successivamente non riprendendo
    l'attività lavorativa, fruisca di altro congedo parentale, le giornate festive  e i sabati (in caso di settimana corta) cadenti tra il primo periodo di congedo parentale
    e le ferie o la malattia vanno computate  in conto congedo parentale.

*/
  P_PROGRESSIVO           in  integer,   -- progressivo dipendente
  P_DATA                  in  date,      -- data di riferimento per il conteggio delle fruizioni
  P_CAUSALE               in  varchar2,  -- causale da considerare
  P_DATANAS_FAM           in  date,      -- data di nascita familiare di riferimento (oppure null)
  P_INIZIO_CUMULO         in  date,      -- data di inizio cumulo
  P_FINE_CUMULO           in  date,      -- data di fine cumulo

  P_OFFSET_MAXINDIVIDUALE out integer,   -- variazione per la fruizione massima individuale (se presenti entrambi i genitori)
  P_OFFSET_MMINTERI       out integer,   -- variazione per i mesi interi fruiti
  P_OFFSET_MMINTERI_DIP   out integer,   -- variazione per i mesi interi fruiti solo dal dipendente (escludendo il coniuge)
  P_OFFSET_MMCONT         out integer,   -- variazione per la fruizione di mesi continuativi definiti su causale
  P_OFFSET_MMCONT_DIP     out integer,   -- variazione per la fruizione di mesi continuativi definiti su causale (escludendo il coniuge)
  P_OFFSET_GGVUOTI        out integer    -- variazione per giorni non lavorativi buchi tra due periodi di assenza tra i quali non vi è stata ripresa dell'attività lavorativa
)
AS
  -- informazioni estratte dalla causale indicata
  wCodRaggr                     T265_CAUASSENZE.CODRAGGR%TYPE;
  wUMisura                      T265_CAUASSENZE.UMISURA%TYPE;
  wRetr1                        T265_CAUASSENZE.RETRIBUZIONE1%TYPE;
  wCumuloGlobale                T265_CAUASSENZE.CUMULOGLOBALE%TYPE;
  wCompetenza1                  T265_CAUASSENZE.COMPETENZA1%TYPE;
  wCompIndiv_Coniuge_Esistente  T265_CAUASSENZE.COMPINDIV_CONIUGE_ESISTENTE%TYPE;
  wVarComp_FruizMMInteri        T265_CAUASSENZE.VARCOMP_FRUIZMMINTERI%TYPE;     -- competenze alterate dalla fruizione di mesi interi
  wMMCont_VarComp               T265_CAUASSENZE.MMCONT_VARCOMP%TYPE;
  wVarComp_FruizMMCont          T265_CAUASSENZE.VARCOMP_FRUIZMMCONT%TYPE;
  wCopri_GGNonLav               T265_CAUASSENZE.COPRI_GGNONLAV%TYPE;
  wPartFruizMaternita           SG101_FAMILIARI.PART_FRUIZ_MATERNITA%TYPE;

  wAlteraCompetenze             varchar2(1);   -- determina se la causale ha i parametri che alterano le competenze
  wComp1                        integer;       -- competenza in fascia 1 calcolata
  wSesso                        varchar2(1);   -- sesso del dipendente
  wProgrConiuge                 integer;       -- progressivo del coniuge / convivente
  wSessoConiuge                 varchar2(1);   -- sesso del coniuge
  wGGFruiti                     integer;       -- tot. giorni fruiti
  wGGFruitiConiuge              integer;       -- tot. giorni continuativi fruiti dal coniuge
  wMaxMesiContConiuge           integer;       -- non utilizzato (solo per memorizzare valore di ritorno)
  wMaxMesiCont                  integer;       -- max mesi continuativi fruiti
  wOffset30                     integer;       -- tot. degli offset su 30gg
  wOffset30Coniuge              integer;       -- tot. degli offset su 30gg del coniuge
BEGIN
  -- inizializza variabili di ritorno
  P_OFFSET_MAXINDIVIDUALE :=0;
  P_OFFSET_MMINTERI       :=0;
  P_OFFSET_MMINTERI_DIP   :=0;
  P_OFFSET_MMCONT         :=0;
  P_OFFSET_MMCONT_DIP     :=0;
  P_OFFSET_GGVUOTI        :=0;

  -- estrae info sulla causale indicata
  begin
    select codraggr, umisura, competenza1, retribuzione1, nvl(compindiv_coniuge_esistente,competenza1),
           cumuloglobale,
           varcomp_fruizmminteri, mmcont_varcomp,varcomp_fruizmmcont,COPRI_GGNONLAV
    into   wCodRaggr, wUMisura, wCompetenza1, wRetr1, wCompIndiv_Coniuge_Esistente,
           wCumuloGlobale, wVarComp_FruizMMInteri, wMMCont_VarComp, wVarComp_FruizMMCont, wCopri_GGNonLav

    from   t265_cauassenze
    where  codice = P_CAUSALE;
  exception
    when NO_DATA_FOUND THEN
      raise_application_error (-20001,'La causale ' || P_CAUSALE || ' è inesistente!');
  end;

  if wUMisura = 'G' then
    -- competenza in giorni
    begin
      wComp1:=to_number(replace(wCompetenza1,' ',''));
    exception
      when others then
        raise_application_error (-20010,'La competenza in fascia 1 della causale ' || P_CAUSALE || ' non è valida: ' || wCompetenza1);
    end;
  else
    -- competenza in ore non valutata -> termina subito
    return;
  end if;

  -- valuta il caso di genitore unico
  begin
    select nvl(sg101.part_fruiz_maternita,'N'), t030.sesso 
    into   wPartFruizMaternita, wSesso
    from   sg101_familiari sg101, t030_anagrafico t030
    where  sg101.progressivo = P_PROGRESSIVO
    and    nvl(sg101.dataadoz,sg101.datanas) = P_DATANAS_FAM
    and    t030.progressivo = P_PROGRESSIVO;
  exception
    when others then
      raise_application_error (-20012,'Il familiare indicato non è presente in anagrafica!');
  end;
  --wPartFruizMaternita:='N';

  -- imposta variabile che indica se sono attivi i parametri che possono alterare le competenze
  if ((wVarComp_FruizMMInteri = 'S') or (wMMCont_VarComp > 0 and wVarComp_FruizMMCont > 0)) then
    wAlteraCompetenze:='S';
  else
    wAlteraCompetenze:='N';
  end if;

  /*
     1. ricerca coniuge / convivente e sesso (solo se sono attivi i parametri che possono alterare le competenze)
  */
  wProgrConiuge:=null;
  wSessoConiuge:=null;
  if (wCumuloGlobale = 'C') and (wAlteraCompetenze = 'S') and (wPartFruizMaternita = 'N') then
    -- 1a. coniuge presente in anagrafico
    select max(t030.progressivo), max(t030.sesso)
    into   wProgrConiuge, wSessoConiuge
    from   sg101_familiari sg101,
           t030_anagrafico t030,
           sg101_familiari sg101cg
    where  sg101.progressivo = P_PROGRESSIVO
    and    sg101.gradopar in ('CG','AL')
    and    sg101.matricola = t030.matricola
    and    sg101cg.progressivo = t030.progressivo
    and    nvl(sg101cg.dataadoz,sg101cg.datanas) = P_DATANAS_FAM;

    if wProgrConiuge is null then
      -- 1b. coniuge esterno
      select max(sg101.sesso)
      into   wSessoConiuge
      from   sg101_familiari sg101
      where  sg101.progressivo = P_PROGRESSIVO
      and    sg101.gradopar = 'CG';
      -- coniuge presente
      if wSessoConiuge is not null then
        wProgrConiuge:=-1;
      end if;
    end if;

    if wProgrConiuge is not null then
      -- coniuge / convivente presente
      -- sesso del dipendente determinato in base al sesso del coniuge
      if wSessoConiuge is null then
        raise_application_error (-20015,'Il sesso del coniuge non è indicato!');
      elsif wSessoConiuge = 'M' then
        wSesso:='F';
      else
        wSesso:='M';
      end if;
    else
      --forzo l'esistenza del coniuge anche se non è registrato su SG101
      wProgrConiuge:=-1;  
    end if;
  end if;

  /*
     2. Determina le variazioni da applicare alle competenze indicate sulla causale
  */
  wGGFruiti:=0;
  wOffset30:=0;
  wMaxMesiCont:=0;
  wGGFruitiConiuge:=0;
  wOffset30Coniuge:=0;
  wMaxMesiContConiuge:=0;

  -- calcolo periodi se sono indicati i parametri che alterano le competenze
  if wAlteraCompetenze = 'S' then
    t040p_periodi_continuativi('N',p_progressivo,wProgrConiuge,p_data,p_causale,p_datanas_fam,p_inizio_cumulo,p_fine_cumulo,
      wGGFruiti,wOffset30,wMaxMesiCont);
    if wVarComp_FruizMMInteri = 'N' then
      wOffset30:=0;
    end if;
  end if;

  -- gestione cumulo con il coniuge / convivente
  if wProgrConiuge is not null then
    -- calcolo periodi coniuge
    t040p_periodi_continuativi('S',p_progressivo,wProgrConiuge,p_data,p_causale,p_datanas_fam,p_inizio_cumulo,p_fine_cumulo,
      wGGFruitiConiuge,wOffset30Coniuge,wMaxMesiContConiuge);
    if wVarComp_FruizMMInteri = 'N' then
      wOffset30Coniuge:=0;
    end if;
  end if;

  if not wProgrConiuge is null then
    -- entrambi i genitori: 6 mesi ciascuno (wGMaxUnitario) fino a un massimo di 10 complessivi (Competenza1)
    wComp1:=least(wCompIndiv_Coniuge_Esistente + wGGFruitiConiuge - wOffset30Coniuge,wComp1);
  end if;

  P_OFFSET_MMINTERI:=wOffset30 + wOffset30Coniuge;
  P_OFFSET_MMINTERI_DIP:=wOffset30;
  P_OFFSET_MAXINDIVIDUALE:=wComp1 - wCompetenza1;

  /*
     3. causale per il padre (solo in presenza di entrambi i genitori)
        30 giorni se sono stati fruiti almeno 3 mesi continuativi
  */
  if (wProgrConiuge is not null) and
     (wVarComp_FruizMMCont > 0) then
    if (wSesso = 'M') and
       --(wMaxMesiCont >= wMMCont_VarComp) and
       (wGGFruiti >= wMMCont_VarComp * 30) then
      -- padre
      P_OFFSET_MMCONT:=wVarComp_FruizMMCont;
      P_OFFSET_MMCONT_DIP:=wVarComp_FruizMMCont;
    elsif (wSesso = 'F') and
          (wGGFruitiConiuge >= wMMCont_VarComp * 30) then
      -- madre
      P_OFFSET_MMCONT:=wVarComp_FruizMMCont;
      P_OFFSET_MMCONT_DIP:=0;
    end if;    
  end if;
END;
/

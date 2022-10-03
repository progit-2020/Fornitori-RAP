create or replace procedure T265P_COMP_FESTEPARTIC (
/*
  Questa procedure estrae le variazioni alle competenze iniziali per la causale
  di ferie in base alle scelte definitive per le festività particolari.
  
  Il dato restituito è:
  - OFFSET_GGFESTEPARTIC
      variazione per festività particolari con scelta = 'C':Aumenta competenza ferie
*/
  P_PROGRESSIVO           in  integer,   -- progressivo dipendente
  P_CAUSALE               in  varchar2,  -- causale da considerare
  P_INIZIO_CUMULO         in  date,      -- data di inizio cumulo
  P_FINE_CUMULO           in  date,      -- data di fine cumulo

  P_OFFSET_GGFESTEPARTIC  out integer    -- variazione per festività particolari con scelta = 'C':Aumenta competenza ferie
)
AS
  wCausFerie                    varchar2(1);   -- determina se la causale è associata ad un raggruppamento di ferie
BEGIN
  -- inizializza variabili di ritorno
  P_OFFSET_GGFESTEPARTIC:=0;

  -- controlla se la causale è associata ad un raggruppamento di ferie
  begin
    select 'S' 
    into   wCausFerie
    from   T265_CAUASSENZE T265,
           T260_RAGGRASSENZE T260
    where  T265.CODRAGGR = T260.CODICE
    and    T265.CODICE = P_CAUSALE
    and    T260.CODINTERNO = 'A';--congedo ordinario/ferie
  exception
    when NO_DATA_FOUND THEN
      wCausFerie:='N';
  end;

  if P_CAUSALE <> 'FER'||to_char(P_INIZIO_CUMULO,'yy') then
    return;
  end if;	
  	
  if wCausFerie = 'S' then
    -- competenza in giorni
    select count(*)
    into   P_OFFSET_GGFESTEPARTIC
    from   CSI010_FESTIVITA_PARTICOLARI
    where  PROGRESSIVO = P_PROGRESSIVO
    and    DATA_FESTIVITA between P_INIZIO_CUMULO and P_FINE_CUMULO
    and    TIPO_RECORD = 'M'
    and    SCELTA_DEFINITIVA = 'C';
  else
    -- causale non di ferie -> termina subito
    return;
  end if;
END;
/

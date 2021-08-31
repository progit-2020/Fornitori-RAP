create or replace function T851F_LIVELLO_AUTORIZZABILE(p_AZIENDA in varchar2, p_PROFILO in varchar2, p_ITER in varchar2, p_COD_ITER in varchar2, p_ID in integer) return integer as
--restituisce il minimo livello che è autorizzabile dall'operatore corrente per la richiesta COD_ITER + ID
  cursor c1 is
    select I096.LIVELLO,I096.OBBLIGATORIO,I096.DATI_MODIFICABILI,I075.ACCESSO, T851.STATO
    from MONDOEDP.I096_LIVELLI_ITER_AUT I096, MONDOEDP.I075_ITER_AUTORIZZATIVI I075, T851_ITER_AUTORIZZAZIONI T851
    where I096.AZIENDA = p_AZIENDA
    and I096.ITER = p_ITER
    and I096.COD_ITER = p_COD_ITER
    and I075.PROFILO(+) = p_PROFILO
    and I075.AZIENDA(+) = I096.AZIENDA
    and I075.ITER(+) = I096.ITER
    and I075.COD_ITER(+) = I096.COD_ITER
    and I075.LIVELLO(+) = I096.LIVELLO
    and I075.ACCESSO(+) = 'F'
    and T851.ID(+) = p_ID
    and T851.LIVELLO(+) = I096.LIVELLO
    order by I096.LIVELLO;

  result integer;
  maxstatoaut varchar2(1);
  maxlivaut integer;
  minlivnoaut integer;
  miolivobbnoaut integer;
  miolivnoaut integer;
  miomaxlivaut integer;
  livdatimodificabili boolean;
begin
  result:=0;
  maxstatoaut:=null;
  maxlivaut:=0;
  minlivnoaut:=0;
  miolivobbnoaut:=0;
  miolivnoaut:=0;
  miomaxlivaut:=0;
  livdatimodificabili:=false;
  for t1 in c1 loop
    if (T1.STATO is not null) and (T1.OBBLIGATORIO = 'S') then
      maxlivaut:=T1.LIVELLO;
      maxstatoaut:=T1.STATO;
      miolivnoaut:=0;  --resetto mio livello non autorizzato dando per scontato che se c'è autorizzazione a un livello successivo non devo più tornare su livelli precedenti non obbligatori
    end if;
    if (T1.STATO is null) and (T1.OBBLIGATORIO = 'S') and (minlivnoaut = 0) then
      minlivnoaut:=T1.LIVELLO;
    end if;
    if (T1.ACCESSO is not null) and (T1.STATO is null) then
      if (T1.OBBLIGATORIO = 'S') and (miolivobbnoaut = 0) then
        miolivobbnoaut:=T1.LIVELLO;
      elsif (T1.OBBLIGATORIO = 'N') and (miolivnoaut = 0) then
        miolivnoaut:=T1.LIVELLO;
      end if;
    elsif (T1.ACCESSO is not null) and (T1.STATO is not null) /*and (T1.OBBLIGATORIO = 'S')*/ then
      miomaxlivaut:=T1.LIVELLO;
      miolivnoaut:=0;  --resetto mio livello non autorizzato dando per scontato che se ho autorizzato un livello successivo non voglio tornare su livelli precedenti non obbligatori
      livdatimodificabili:=T1.DATI_MODIFICABILI = 'S';
    end if;
  end loop;

  if miolivobbnoaut = 0 then
    miolivobbnoaut:=999;
  end if;
  if minlivnoaut = 0 then
    minlivnoaut:=999;
  end if;
  --autorizzazione non obbligatoria ancora da autorizzare 
  if (miolivnoaut > 0) and (miolivnoaut < miolivobbnoaut) and (miolivnoaut < maxlivaut) then
    --inferiore al prossimo livello obbligatorio già autorizzato: non modificabile
    result:=-miolivnoaut;
  elsif (miolivnoaut > 0) and (miolivnoaut < miolivobbnoaut) and (miolivnoaut < minlivnoaut) then
    --inferiore al prossimo livello obbligatorio ancora da autorizzare: modificabile
    result:=miolivnoaut;
  end if;
  --autorizzazione obbligatoria ancora da autorizzare (successiva all'autorizzazione già esitente)
  if result = 0 then
    if miolivobbnoaut = 999 then
      miolivobbnoaut:=0;
    end if;
    if minlivnoaut = 999 then
      minlivnoaut:=0;
    end if;
    if (miolivobbnoaut > 0) and (miolivobbnoaut between maxlivaut and minlivnoaut) then
      result:=miolivobbnoaut;
    end if;
  end if;
  if result = 0 then
    if miomaxlivaut = maxlivaut then
      --ultima autorizzazione obbigatoria autorizzata con possibilità di modifica
      result:=miomaxlivaut;
    else
      if livdatimodificabili and (maxlivaut < miomaxlivaut) then
        --autorizzazione non obbligatoria successiva a maxlivaut e dati modificabili: si possono continuare a modificare
        result:=miomaxlivaut;
      else
        --autorizzazione precedente o non obbligatoria: non modificabile 
        result:=-miomaxlivaut;
      end if;
    end if;
  end if;
  --se autorizzazione negata o intermedia, non posso restituire un livello successivo
  if (result > maxlivaut) and (maxstatoaut <> 'S') then
    result:=maxlivaut;
    if miomaxlivaut < maxlivaut then
      --autorizzazione precedente o non obbligatoria: non modificabile
      result:=-miomaxlivaut;
    end if;
  end if;

  return result;
end;
/

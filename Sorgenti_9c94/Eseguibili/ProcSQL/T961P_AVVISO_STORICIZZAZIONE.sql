create procedure T961P_AVVISO_STORICIZZAZIONE is
  W_ALLEGATI  integer;
  W_ELIMINATI varchar2(2) := '--'; --stringa di riconoscimento dei documenti eliminati
  W_MSG       varchar2(2000);
  W_MINDATA   date;
  W_MAXDATA   date;
  W_ANNI      integer;
  W_GIORNI    integer;
begin
  W_ANNI   := -1;
  W_GIORNI := -1;
  begin
    select nvl(DATO,-1)
      into W_ANNI
      from MONDOEDP.I091_DATIENTE
     where TIPO = 'C90_CANCELLA_ANNO_ALLEGATI_ITER'
       and AZIENDA = I090F_GETAZIENDACORRENTE;
  
    select nvl(DATO,-1)
      into W_GIORNI
      from MONDOEDP.I091_DATIENTE
     where TIPO = 'C90_GG_PREAVVISO_CANCELLA_ALLEGATI'
       and AZIENDA = I090F_GETAZIENDACORRENTE;
  exception
    when NO_DATA_FOUND then
      null;
  end;

  if (W_ANNI > -1) and (W_GIORNI > -1) then
    --conta gli allegati 
    select count(*), min(DATA_CREAZIONE), max(DATA_CREAZIONE)
      into W_ALLEGATI, W_MINDATA, W_MAXDATA
      from T960_DOCUMENTI_INFO
     where TIPOLOGIA = 'ITER'
       and DATA_CREAZIONE <=
           add_months(trunc(sysdate, 'yyyy'), -12 * W_ANNI) + W_GIORNI
       and PATH_STORAGE <> W_ELIMINATI;
  
    --crea il msg mail su t280
    if W_ALLEGATI > 0 then
      W_MSG := 'Sono presenti ' || W_ALLEGATI ||
               ' allegati in scadenza nel periodo ' ||
               to_char(W_MINDATA, 'dd/mm/yyyy') || ' - ' ||
               to_char(W_MAXDATA, 'dd/mm/yyyy');
      insert into T280_MESSAGGIWEB
        (DATA, MITTENTE, TESTO, TITOLO, FLAG, EMAIL, CATEGORIA)
      values
        (sysdate,
         'SYSMAN',
         w_msg,
         'Avviso cancellazione allegati',
         '3',
         'ufficio@cliente.it',
         'ALLEGATI');
    end if;
  end if;
end;
/
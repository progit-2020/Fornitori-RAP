create function USR_T860F_GETVALIDAZIONI(P_PROGRESSIVO in integer, P_DATA in date, P_VALIDAZIONE in varchar2) return varchar2 as
  wData varchar2(10);
  wUtente varchar2(30);
  wNominativo varchar2(100);
  result varchar2(100);
begin
  result:=null;
  if P_VALIDAZIONE = 'T860A' then
    wData:=substr(T077F_LEGGIVALORE(P_PROGRESSIVO,trunc(P_DATA,'mm'),'BLOCCO_T860A','M'),1,10);
    if wData is not null then
      result:='Validato dal Referente di Segreteria il '||wData;
    end if;
  elsif P_VALIDAZIONE = 'T860' then  
    wData:=substr(T077F_LEGGIVALORE(P_PROGRESSIVO,trunc(P_DATA,'mm'),'BLOCCO_T860','M'),1,10);
    if wData is not null then
      result:='Validato dall''Ufficio Personale il '||wData;
    end if;
  elsif P_VALIDAZIONE in ('T860_LIV1','T860_LIV2') then  
    begin
      select 
        RESPONSABILE,
        I060F_NOMINATIVO(T000F_GETAZIENDACORRENTE,RESPONSABILE),
        to_char(DATA,'dd/mm/yyyy') 
      into wUtente,wNominativo,wData
      from T860_ITER_STAMPACARTELLINI T860, T851_ITER_AUTORIZZAZIONI T851 
      where PROGRESSIVO = P_PROGRESSIVO
      and MESE_CARTELLINO = trunc(P_DATA,'mm')
      and T860.ID = T851.ID 
      and T851.LIVELLO = decode(P_VALIDAZIONE,'T860_LIV1',1,'T860_LIV2',2)
      and T851.STATO = 'S';
      
      if wUtente = wNominativo then
        wNominativo:='Ufficio Personale';
      end if;
      if wData is not null then
        result:='Validato da '||wNominativo||' il '||wData;
      end if;
    exception
      when no_data_found then null;
    end;    
  end if;  
  
  return result;
end;
/
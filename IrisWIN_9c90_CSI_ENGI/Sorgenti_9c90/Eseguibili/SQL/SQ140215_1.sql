--Script nuova gestione progressiva pianificazione turni
alter table T082_PAR_PIANIFORARI add rendi_operativa varchar2(1) default 'N'/*--NOLOG--*/;
comment on column T082_PAR_PIANIFORARI.rendi_operativa
  is 'Abilità il pulsante per rendere operativa una pianificazione';
alter table T082_PAR_PIANIFORARI add assenze_operative VARCHAR2(1) default 'N'/*--NOLOG--*/;
comment on column T082_PAR_PIANIFORARI.assenze_operative
  is 'Permette l''inserimento su tabella T040 delle assenze';
  
declare
  MyValore varchar2(1);
begin  
  select decode(I091.DATO,'OPERATIVA','S','N') into MyValore
    from I091_DATIENTE I091
   where I091.AZIENDA = :AZIENDA
     and I091.TIPO = 'C11_PIANIFORARI_NO_GIUSTIF';  
     
  update T082_PAR_PIANIFORARI T082
     set T082.ASSENZE_OPERATIVE  = MyValore
   where T082.MODALITA_LAVORO = 'N';
	 
  commit;
exception
  when others then null;
end;
/  

-- Allargato filtro dipendenti sulle regole del conto annuale
alter table P552_CONTOANNREGOLE modify filtro_dipendenti VARCHAR2(1500);

-- Allargato descrizione sugli accorpamenti voci
alter table P215_CODICIACCORPAMENTOVOCI modify descrizione VARCHAR2(100);

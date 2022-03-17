update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.8',PATCHDB = 2 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);
	
alter table T020_ORARI add INDFESTIVA_USA_NOTTE_COMPLETA varchar2(1) default 'N';
comment on column T020_ORARI.INDFESTIVA_USA_NOTTE_COMPLETA is 'S=l''indennità festiva valuta anche le intere fasce notturne 22-06 che precedono e seguono il giorno festivo';

update T430_STORICO set CAUSSTRAORD = 'F' where nvl(CAUSSTRAORD,'x') not in ('O','F');

declare
  wDef long;
begin
  select DATA_DEFAULT into wDef from cols where TABLE_NAME = 'T430_STORICO' and COLUMN_NAME = 'CAUSSTRAORD';
  if upper(trim(substr(wDef,1,4))) = 'NULL' then
    execute immediate 'alter table T430_STORICO modify CAUSSTRAORD default ''F''';
  end if;  
end; 
/

alter table T020_ORARI modify XPARAM varchar2(1000);
update T020_ORARI set XPARAM = XPARAM||'<GIUSTIF_TURNO_NOTTURNO>' where XPARAM like '%<TURNO_NOTTURNO>%' and :AZIENDA <> 'CSI';



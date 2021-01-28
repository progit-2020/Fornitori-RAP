UPDATE T910_RIEPILOGO SET IMPOSTAZIONI = IMPOSTAZIONI || DECODE(LENGTH(IMPOSTAZIONI),NULL,'',0,'',',') || 'VALORE_NULLO=S';

-- Create table di pianificazione integrazione con EMK
create table I103_EMK_PIANIF_INTEG
(
  ORA VARCHAR2(5)
)
  tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 20K
    next 16K
    minextents 1
    maxextents 121
    pctincrease 0
  );


create or replace package I000PCK_LOG is
  function INSERT_INFO(P_OPERATORE in varchar2,P_MASCHERA in varchar2,P_TABELLA in varchar2,P_OPERAZIONE in varchar2) return integer;
  procedure INSERT_LOG(P_ID in integer,P_COLONNA in varchar2,P_VALORE_OLD in varchar2,P_VALORE_NEW in varchar2);
end I000PCK_LOG;
/

create or replace package body I000PCK_LOG is
  function INSERT_INFO(P_OPERATORE in varchar2,P_MASCHERA in varchar2,P_TABELLA in varchar2,P_OPERAZIONE in varchar2) return integer as
    wID integer;
  begin
    select I000_ID.nextval into wID from dual;

    insert into I000_LOGINFO (ID, OPERATORE, MASCHERA, TABELLA, OPERAZIONE)
    values (wID,P_OPERATORE,P_MASCHERA,P_TABELLA,P_OPERAZIONE);

    return wID;
  end;

  procedure INSERT_LOG(P_ID in integer,P_COLONNA in varchar2,P_VALORE_OLD in varchar2,P_VALORE_NEW in varchar2) as
  begin
    insert into I001_LOGDATI (ID,COLONNA, VALORE_OLD, VALORE_NEW)
    values (P_ID,P_COLONNA,P_VALORE_OLD,P_VALORE_NEW);
  end;

begin
  -- Initialization
  null;
end I000PCK_LOG;
/
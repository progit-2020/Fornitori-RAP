create or replace procedure I005P_REGISTRAMSG(pAzienda in varchar2, pOperatore in varchar2, pMaschera in varchar2, pTipo in varchar2, pMsg in varchar2, pProgressivo in integer) as
  wId        mondoedp.i005_msginfo.id%type;
  wId_msg    mondoedp.i006_msgdati.id_msg%type;
  wAZIENDA   mondoedp.i005_msginfo.azienda%type;
  wOPERATORE mondoedp.i005_msginfo.operatore%type;
  wHOSTNAME  mondoedp.i005_msginfo.hostname%type;
  wEspr      varchar2(2000);
begin
  begin
    wEspr:='select OSUSER, TERMINAL from V$SESSION where SID = (select SID from V$MYSTAT where ROWNUM = 1)';
    execute immediate wEspr into wOPERATORE, wHOSTNAME;
  exception
    when others then
      wOPERATORE:='';
      wHOSTNAME:='';
  end;
  if pAzienda is null then
    wAZIENDA:=t000f_getaziendacorrente();
  else
    wAZIENDA:=pAzienda;
  end if;
  if pOperatore is not null then
     wOPERATORE:=pOperatore;
  end if;
  select MONDOEDP.I005_ID.NEXTVAL,MONDOEDP.I006_ID_MSG.NEXTVAL into wId,wId_msg from dual;
  insert into MONDOEDP.I005_MSGINFO
    (id, data, maschera, azienda, operatore, hostname)
  values
    (wId, sysdate, pMaschera, wAZIENDA, wOPERATORE, wHOSTNAME);
  insert into MONDOEDP.i006_msgdati
    (id, azienda_msg, data_msg, tipo, msg, progressivo, id_msg)
  values
    (wId, wAZIENDA, sysdate, pTipo, pMsg, pProgressivo, wId_msg);
end;
/
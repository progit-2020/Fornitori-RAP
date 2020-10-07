create or replace package PCK_CONST is
  --identificativi generali
  type REF_CURSOR is ref cursor;
  function DATA_INF return date;
  
  --identificativi degli iter autorizzativi
  function ITER_M140 return varchar2;
  function ITER_T050 return varchar2;
  function ITER_T065 return varchar2;
  function ITER_T105 return varchar2;
  function ITER_T325 return varchar2;
  function ITER_T860 return varchar2;

  --identificativi definiti in MONDOEDP.I011 e usati in T077
  function I011RIENTRIPOM_TEORICI return varchar2;
  function I011RIENTRIPOM_REALI return varchar2;
  function I011RIENTRIPOM_RESI return varchar2;
  function I011RIENTRIPOM_SALDO return varchar2;
  function I011BLOCCO_T860 return varchar2;
  function I011PT_ORE_STR return varchar2;
  function I011PT_ORE_SUPPL return varchar2;
  function I011COMPMM_EFF return varchar2;
end PCK_CONST;
/

create or replace package body PCK_CONST is
  function DATA_INF return date as begin return to_date('31123999','ddmmyyyy'); end;

  function ITER_M140 return varchar2 as begin return 'M140'; end;
  function ITER_T050 return varchar2 as begin return 'T050'; end;
  function ITER_T065 return varchar2 as begin return 'T065'; end;
  function ITER_T105 return varchar2 as begin return 'T105'; end;
  function ITER_T325 return varchar2 as begin return 'T325'; end;
  function ITER_T860 return varchar2 as begin return 'T860'; end;

  function I011RIENTRIPOM_TEORICI return varchar2 as begin return 'RIENTRIPOM_TEORICI'; end;
  function I011RIENTRIPOM_REALI return varchar2 as begin return 'RIENTRIPOM_REALI'; end;
  function I011RIENTRIPOM_RESI return varchar2 as begin return 'RIENTRIPOM_RESI'; end;
  function I011RIENTRIPOM_SALDO return varchar2 as begin return 'RIENTRIPOM_SALDO'; end;
  function I011BLOCCO_T860 return varchar2 as begin return 'BLOCCO_T860'; end;
  function I011PT_ORE_STR return varchar2 as begin return 'PT_ORE_STR'; end;
  function I011PT_ORE_SUPPL return varchar2 as begin return 'PT_ORE_SUPPL'; end;
  function I011COMPMM_EFF return varchar2 as begin return 'COMPMM_EFF'; end;
begin
  null;
end PCK_CONST;
/

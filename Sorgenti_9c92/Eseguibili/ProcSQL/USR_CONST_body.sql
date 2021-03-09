create or replace package body USR_CONST is
  function cHTP   return integer  as begin return 38*60; end; --ore tempo pieno
  function cSTAUT return varchar2 as begin return 'STAUT'; end;
  function cAUTST return varchar2 as begin return 'AUTST'; end;
  function cASSEST_BAO return varchar2 as begin return 'STBO'; end;
  function cTAGLIO_BAO return varchar2 as begin return '9103'; end;
  function cSTRAO_MIN return integer as begin return 30; end;
  function cSTRAO_ARR return integer as begin return 15; end;
  --causali/voci di pagamento
  function cSTBAS return varchar2 as begin return 'STBAS'; end;
  function cSTPAG return varchar2 as begin return 'STPAG'; end;
  function cSTBAO return varchar2 as begin return 'STBAO'; end;
  function cSTMAG return varchar2 as begin return 'STMAG'; end;
  function cHSBAS return varchar2 as begin return 'HSBAS'; end;
  function cHSPAG return varchar2 as begin return 'HSPAG'; end;
  function cHSBAO return varchar2 as begin return 'HSBAO'; end;
  function cHSMAG return varchar2 as begin return 'HSMAG'; end;
  function cMGGNT return varchar2 as begin return 'MGGNT'; end;
  function cSTESC return varchar2 as begin return 'STESC'; end;
  function cSTESB return varchar2 as begin return 'STESB'; end;
  function cSTESP return varchar2 as begin return 'STESP'; end;
  function cSTESM return varchar2 as begin return 'STESM'; end;
  function cSTNNB return varchar2 as begin return 'STNNB'; end;
  function cSTNBP return varchar2 as begin return 'STNBP'; end;

  --identificativi dei riepiloghi giornalieri
  function cRIEPPRESEU return varchar2 as begin return 'RIEPPRES_EU'; end;
  function cSTRAOGG    return varchar2 as begin return 'STRAOGG'; end;
  function cSTRAOSETT  return varchar2 as begin return 'STRAOSETTIMANALE'; end;
  function cSTRAOSETT_ESC return varchar2 as begin return 'STRAOSETT_ESC'; end;

  --identificativi raggruppamenti o causali di assenza
  function cRMAFA   return varchar2 as begin return 'MAFA,MAFAB,MAFAC,'; end; --maternità facoltativa
  function cGRAVID  return varchar2 as begin return '5007';  end;             --gravidanza obbligatoria
  function cADOZ    return varchar2 as begin return '5007C'; end;             --adozione nazionale e internazionale
  function cPREADOZ return varchar2 as begin return '5007D'; end;             --preadozione internazionale
begin
  null;
end USR_CONST;
/
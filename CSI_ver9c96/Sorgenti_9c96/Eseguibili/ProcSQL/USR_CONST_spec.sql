create or replace package USR_CONST is
  -- Public return declarations
  function cHTP   return integer; --ore tempo pieno
  function cSTAUT return varchar2;
  function cAUTST return varchar2;
  function cASSEST_BAO return varchar2;
  function cTAGLIO_BAO return varchar2;
  function cSTRAO_MIN return integer;
  function cSTRAO_ARR return integer;
  --causali/voci di pagamento
  function cSTBAS return varchar2;
  function cSTPAG return varchar2;
  function cSTBAO return varchar2;
  function cSTMAG return varchar2;
  function cHSBAS return varchar2;
  function cHSPAG return varchar2;
  function cHSBAO return varchar2;
  function cHSMAG return varchar2;
  function cMGGNT return varchar2;
  function cSTESC return varchar2;
  function cSTESB return varchar2;
  function cSTESP return varchar2;
  function cSTESM return varchar2;
  function cSTNNB return varchar2;
  function cSTNBP return varchar2;

  --identificativi dei riepiloghi giornalieri
  function cRIEPPRESEU return varchar2;
  function cSTRAOGG    return varchar2;
  function cSTRAOSETT  return varchar2;
  function cSTRAOSETT_ESC return varchar2;
  function cSVFE       return varchar2;

  --identificativi raggruppamenti o causali di assenza
  function cRMAFA return varchar2;
  function cGRAVID  return varchar2;
  function cADOZ    return varchar2;
  function cPREADOZ return varchar2;

  --eccezioni personalizzate
  T065_NON_CONSENTITO_CODE integer := -20001;
  T065_NON_CONSENTITO_MSG varchar2(100) := 'Mese non consentito per la richiesta di autorizzazione';
  
end USR_CONST;
/
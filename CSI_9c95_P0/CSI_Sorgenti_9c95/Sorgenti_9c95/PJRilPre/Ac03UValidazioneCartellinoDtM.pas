unit Ac03UValidazioneCartellinoDtM;

interface

uses
  A000UInterfaccia, A000UCostanti, C017UEmailDtM, DatiBloccati,
  System.SysUtils, System.Classes,
  C018UIterAutDM, medpSendMail, R004UGestStoricoDTM,
  C180FunzioniGenerali, Oracle, OracleData, Data.DB, Variants;

type
  TResultOper = record
    Ok: Boolean;
    Msg: string;
  end;

  TDatiRichiesta = record
    Id: Integer;
    MaxLivAut: Integer;
    AutLiv1: String;
  end;

  TAc03FValidazioneCartellinoDtM = class(TR004FGestStoricoDtM)
    selT860: TOracleDataSet;
    selT860MATRICOLA: TStringField;
    selT860COGNOME: TStringField;
    selT860NOME: TStringField;
    selT860STATO: TStringField;
    selT860C_ITER_DISPONIBILE: TStringField;
    selT860AUT_LIV_1: TStringField;
    selT860AUT_FINALE: TStringField;
    selT860MESE_CARTELLINO: TDateTimeField;
    selT860ESISTE_PDF: TStringField;
    selT860DATA_PDF: TDateTimeField;
    selI060: TOracleDataSet;
    selT860Iter: TOracleDataSet;
    selT860ID: TFloatField;
    selT860ID_REVOCA: TFloatField;
    selT860ID_REVOCATO: TFloatField;
    selT860NOMINATIVO: TStringField;
    StringField1: TStringField;
    selT860COD_ITER: TStringField;
    selT860TIPO_RICHIESTA: TStringField;
    selT860AUTORIZZ_AUTOMATICA: TStringField;
    selT860REVOCABILE: TStringField;
    selT860DATA_RICHIESTA: TDateTimeField;
    selT860LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT860FASE_CORRENTE: TFloatField;
    selT860DATA_AUTORIZZAZIONE: TDateTimeField;
    selT860AUTORIZZAZIONE: TStringField;
    selT860NOMINATIVO_RESP: TStringField;
    selT860NOMINATIVO_RESP2: TStringField;
    selT860AUTORIZZ_UTILE: TStringField;
    selT860AUTORIZZ_REVOCA: TStringField;
    selT860D_RESPONSABILE: TStringField;
    selT860D_AUTORIZZAZIONE: TStringField;
    DateTimeField1: TDateTimeField;
    StringField2: TStringField;
    selT860D_AUTORIZZAZIONE_FINALE: TStringField;
    selT860CF_RIEPILOGHI: TStringField;
    selT070: TOracleDataSet;
    selT860MAX_LIV_AUT: TFloatField;
    selT860ID2: TFloatField;
    selT860PROGRESSIVO2: TFloatField;
    selT860MESE_SCHEDA: TDateTimeField;
    selT860EMAIL: TStringField;
    updT860: TOracleQuery;
    selT860COD_ITER2: TStringField;
    selI075Profilo: TOracleDataSet;
    selT860TIPO_RICHIESTA2: TStringField;
    selT860STATO_T180A: TStringField;
    selT860C_STATO_VALIDAZIONE: TStringField;
    selT860SEDE: TStringField;
    selI070: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT860CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selDatiBloccati: TDatiBloccati;
    medpEMail: TmedpSendMail;
  public
    C018: TC018FIterAutDM;
    function ImpostaDatasetIter(const PFiltroAnag: String): TResultOper;
    function IsBloccoRiepiloghiAttivoT860(const PProg: Integer; const PMeseRif: TDateTime): Boolean;
    function BloccaRiepiloghiT860(const PProg: Integer; const PMeseRif: TDateTime): TResultOper;
    function SbloccaRiepiloghiT860(const PProg: Integer; const PMeseRif: TDateTime): TResultOper;
    function EsisteSchedaRiepilogativa(const PProg: Integer;
      const PMeseRif: TDateTime): Boolean;
    function EsisteRichiesta(const PProg: Integer; const PMeseRif: TDateTime;
      var RIdRichiesta: Integer): Boolean;
    function CreaRichiesta(const PProg: Integer; const PMeseRif: TDateTime; var RRichiesta: TDatiRichiesta): TResultOper;
    function InviaMailADipendente(const PProgDip: Integer; const PMeseRif: TDateTime; PDatiMail: TDatiMail): TResultOper;
    function InviaMailAResponsabile(const PMeseRif: TDateTime; PDatiMail: TDatiMail; const PDestinatari: String): TResultOper;
    function AutorizzaRichiestaLiv1(const PId: Integer): TResultOper;
    function AutorizzaRichiestaLivMax(const PId: Integer): TResultOper;
    function SbloccaValidazioneLivMax(const PId: Integer): TResultOper;
    function GetIndirizziMailResponsabili(const PProgDip: Integer;
      const PMeseRif: TDateTime; const PCodIter, PLivelliDest: String): String;
    function GetLivMaxObbligatorio(const PCodIter: String): Integer;
    function GetLivMax(const PCodIter: String): Integer;
    function CheckPwdSysman(Pwd:String): Boolean;
    function ResetIterRichiesta(const PId: Integer; const PProg: Integer; const PMeseRif: TDateTime): TResultOper;
  end;

var
  Ac03FValidazioneCartellinoDtM: TAc03FValidazioneCartellinoDtM;

implementation

{$R *.dfm}

uses Ac03UValidazioneCartellino;

procedure TAc03FValidazioneCartellinoDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT860,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selDatiBloccati:=TDatiBloccati.Create(nil);
  medpEMail:=TmedpSendMail.Create;

  // gestione iter autorizzativo validazione cartellino
  // determina un profilo con autorizzazione sia al primo che all'ultimo livello obbligatorio
  selI075Profilo.Close;
  selI075Profilo.SetVariable('AZIENDA',Parametri.Azienda);
  selI075Profilo.Open;
  if selI075Profilo.RecordCount = 0 then
    raise Exception.Create('Nessun profilo iter dispone di autorizzazioni al primo e all''ultimo livello!');
  Parametri.ProfiloWebIterAutorizzativi:=selI075Profilo.FieldByName('PROFILO').AsString;
  selI075Profilo.Close;

  C018:=TC018FIterAutDM.Create(Self);
  C018.Iter:=ITER_CARTELLINO;
  C018.AccessoReadOnly:=False;
  C018.PreparaDataSetIter(selT860Iter,tiAutorizzazione);
end;

procedure TAc03FValidazioneCartellinoDtM.DataModuleDestroy(Sender: TObject);
begin
  try FreeAndNil(selDatiBloccati); except end;
  try FreeAndNil(medpEMail); except end;
  // distrugge datamodulo iter
  try FreeAndNil(C018); except end;
  inherited;
end;

procedure TAc03FValidazioneCartellinoDtM.selT860CalcFields(DataSet: TDataSet);
var
  Stato, DescStato: String;
begin
  inherited;
  if selT860.FieldByName('STATO_T180A').AsString = 'A' then
    DescStato:='Prevalidazione mancante'
  else if selT860.FieldByName('STATO').AsString = 'A' then
    DescStato:='No'
  else
    DescStato:='Si';
  selT860.FieldByName('C_ITER_DISPONIBILE').AsString:=DescStato;

  DescStato:='Non validabile';
  if selT860.FieldByName('STATO').AsString = 'C' then
  begin
    if selT860.FieldByName('MAX_LIV_AUT').AsInteger = -1 then
      DescStato:='Validabile dal dipendente'
    else if (selT860.FieldByName('MAX_LIV_AUT').AsInteger = 1) and (selT860.FieldByName('TIPO_RICHIESTA').AsString = T860STATO_INIZIALE) then
      DescStato:='Validato dal dipendente'
    else if (selT860.FieldByName('MAX_LIV_AUT').AsInteger = 1) and (selT860.FieldByName('TIPO_RICHIESTA').IsNull) then
      DescStato:='Validabile dal responsabile'
    else if selT860.FieldByName('AUT_FINALE').AsString <> '' then
      DescStato:='Validato dal responsabile';
  end;
  selT860.FieldByName('C_STATO_VALIDAZIONE').AsString:=DescStato;
end;

function TAc03FValidazioneCartellinoDtM.ImpostaDatasetIter(const PFiltroAnag: String): TResultOper;
begin
  selT860Iter.Close;
  if selT860Iter.VariableIndex('FILTRO_ANAG') >= 0 then
    selT860Iter.SetVariable('FILTRO_ANAG',PFiltroAnag);
  selT860Iter.SetVariable('FILTRO_PERIODO','');
  selT860Iter.SetVariable('FILTRO_VISUALIZZAZIONE','');
  selT860Iter.SetVariable('FILTRO_STRUTTURA','');
  selT860Iter.Open;
end;

function TAc03FValidazioneCartellinoDtM.IsBloccoRiepiloghiAttivoT860(const PProg: Integer;
  const PMeseRif: TDateTime): Boolean;
// restituisce True se per il progressivo e il mese indicati
// il riepilogo T860 risulta bloccato,
// oppure False altrimenti
begin
  Result:=selDatiBloccati.DatoBloccato(PProg,PMeseRif,'T860',True);
end;

function TAc03FValidazioneCartellinoDtM.BloccaRiepiloghiT860(const PProg: Integer;
  const PMeseRif: TDateTime): TResultOper;
// effettua blocco riepiloghi T860 sul progressivo per il mese indicato
begin
  try
    selDatiBloccati.BloccaRiepilogo(PProg,PMeseRif,PMeseRif,'T860',Parametri.Operatore);
    Result.Ok:=True;
    Result.Msg:='';
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Msg:='Blocco riepiloghi non effettuato!';
    end;
  end;
end;

function TAc03FValidazioneCartellinoDtM.SbloccaRiepiloghiT860(const PProg: Integer;
  const PMeseRif: TDateTime): TResultOper;
// effettua sblocco riepiloghi T860 sul progressivo per il mese indicato
begin
  try
    selDatiBloccati.SbloccaRiepilogo(PProg,PMeseRif,PMeseRif,'T860');
    Result.Ok:=True;
    Result.Msg:='';
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Msg:='Sblocco riepiloghi non effettuato!';
    end;
  end;
end;

function TAc03FValidazioneCartellinoDtM.EsisteSchedaRiepilogativa(const PProg: Integer;
  const PMeseRif: TDateTime): Boolean;
begin
  selT070.Close;
  selT070.SetVariable('PROGRESSIVO',PProg);
  selT070.SetVariable('MESERIF',PMeseRif);
  selT070.Open;
  Result:=selT070.RecordCount > 0;
end;

function TAc03FValidazioneCartellinoDtM.EsisteRichiesta(const PProg: Integer;
  const PMeseRif: TDateTime; var RIdRichiesta: Integer): Boolean;
// restituisce True se è presente la richiesta di validazione cartellino
// per il progressivo e il mese indicati
begin
  Result:=selT860.SearchRecord('PROGRESSIVO;MESE_CARTELLINO',VarArrayOf([PProg,PMeseRif]),[srFromBeginning]);
  if Result then
    RIdRichiesta:=selT860.FieldByName('ID').AsInteger
  else
    RIdRichiesta:=-1;
end;

function TAc03FValidazioneCartellinoDtM.CreaRichiesta(const PProg: Integer;
  const PMeseRif: TDateTime; var RRichiesta: TDatiRichiesta): TResultOper;
// crea una nuova richiesta di validazione cartellino su T860
// se è presente la scheda riepilogativa del mese
var
  LNew: Integer;
const
  NOTE_RICHIESTA = 'Richiesta automatica';
begin
  RRichiesta.Id:=-1;
  RRichiesta.MaxLivAut:=-1;

  // inserimento richiesta su T860
  selT860Iter.Append;
  selT860Iter.FieldByName('PROGRESSIVO').AsInteger:=PProg;
  selT860Iter.FieldByName('MESE_CARTELLINO').AsDateTime:=PMeseRif;
  try
    // nota: non considera WarningRichiesta!
    LNew:=C018.InsRichiesta('',NOTE_RICHIESTA,'');
    if C018.MessaggioOperazione <> '' then
    begin
      selT860Iter.Cancel;
      raise Exception.Create(C018.MessaggioOperazione);
    end
    else
    begin
      // rende effettiva l'autorizzazione all'ultimo livello
      if LNew = C018.LivMaxObb then
        BloccaRiepiloghiT860(PProg,PMeseRif);
    end;

    // salva info richiesta
    RRichiesta.Id:=C018.Id;
    RRichiesta.MaxLivAut:=LNew;
    if LNew > 0 then
      RRichiesta.AutLiv1:=C018SI
    else
      RRichiesta.AutLiv1:='';

    // la richiesta è stata creata correttamente
    Result.Ok:=True;
    Result.Msg:='';
  except
    on E:Exception do
    begin
      Result.Msg:=Format('Prog: %d - %s: %s',[PProg,FormatDateTime('mmmm yyyy',PMeseRif),E.Message]);
      Result.Ok:=False;
    end;
  end;
end;

function TAc03FValidazioneCartellinoDtM.InviaMailADipendente(const PProgDip: Integer; const PMeseRif: TDateTime; PDatiMail: TDatiMail): TResultOper;
// invia mail di sollecito al dipendente indicato
var
  Email, IndirizziDest: String;
begin
  Result.Ok:=False;
  Result.Msg:='';

  // controllo parametri
  if PProgDip <= 0 then
  begin
    Result.Msg:=Format('Il progressivo indicato non è valido: %d',[PProgDip]);
    Exit;
  end;

  if PMeseRif = DATE_NULL then
  begin
    Result.Msg:='Il mese di riferimento non è stato indicato';
    Exit;
  end;

  if PDatiMail.Oggetto = '' then
  begin
    Result.Msg:='L''oggetto della mail non è stato indicato!';
    Exit;
  end
  else
    PDatiMail.Oggetto:=StringReplace(PDatiMail.Oggetto,':mese_riferimento',FormatDateTime('mm/yyyy',PMeseRif),[rfReplaceAll,rfIgnoreCase]);


  if PDatiMail.Corpo = '' then
  begin
    Result.Msg:='Il testo della mail non è stato indicato!';
    Exit;
  end
  else
    PDatiMail.Corpo:=StringReplace(PDatiMail.Corpo,':mese_riferimento',FormatDateTime('mm/yyyy',PMeseRif),[rfReplaceAll,rfIgnoreCase]);

  // estrae indirizzo email dipendente da I060
  IndirizziDest:='';
  selI060.Close;
  selI060.SetVariable('PROGRESSIVO',PProgDip);
  selI060.Open;
  while not selI060.Eof do
  begin
    Email:=selI060.FieldByName('EMAIL').AsString;
    if (Email.Trim <> '') and
       (R180CercaParolaIntera(Email,IndirizziDest,';') = 0) then
    begin
      IndirizziDest:=IndirizziDest + Email + ';';
    end;
    selI060.Next;
  end;
  if IndirizziDest <> '' then
    IndirizziDest:=IndirizziDest.Substring(0,IndirizziDest.Length - 1);

  // controllo indirizzi di destinazione
  if IndirizziDest = '' then
  begin
    Result.Msg:='Nessun indirizzo email associato al dipendente!';
    Exit;
  end;

  // connessione smtp
  Result.Msg:=medpEMail.ConnettiSMTP;
  if Result.Msg <> '' then
    Exit;

  // invio mail
  Result.Msg:=medpEMail.Invia(IndirizziDest,PDatiMail.Oggetto,PDatiMail.Corpo);
  if Result.Msg <> '' then
    Exit;

  // invio ok
  Result.Ok:=True;
end;

function TAc03FValidazioneCartellinoDtM.InviaMailAResponsabile(const PMeseRif: TDateTime; PDatiMail: TDatiMail; const PDestinatari: String): TResultOper;
begin
  Result.Ok:=False;
  Result.Msg:='';

  // controllo parametri
  if PMeseRif = DATE_NULL then
  begin
    Result.Msg:='Il mese di riferimento non è stato indicato';
    Exit;
  end;

  if PDatiMail.Oggetto = '' then
  begin
    Result.Msg:='L''oggetto della mail non è stato indicato!';
    Exit;
  end
  else
    PDatiMail.Oggetto:=StringReplace(PDatiMail.Oggetto,':mese_riferimento',FormatDateTime('mm/yyyy',PMeseRif),[rfReplaceAll,rfIgnoreCase]);

  if PDatiMail.Corpo = '' then
  begin
    Result.Msg:='Il testo della mail non è stato indicato!';
    Exit;
  end
  else
    PDatiMail.Corpo:=StringReplace(PDatiMail.Corpo,':mese_riferimento',FormatDateTime('mm/yyyy',PMeseRif),[rfReplaceAll,rfIgnoreCase]);

  if PDestinatari = '' then
  begin
    Result.Msg:='Indicare almeno un destinatario per la mail!';
    Exit;
  end;

  // connessione smtp
  Result.Msg:=medpEMail.ConnettiSMTP;
  if Result.Msg <> '' then
    Exit;

  // invio mail
  Result.Msg:=medpEMail.Invia(PDestinatari,PDatiMail.Oggetto,PDatiMail.Corpo);
  if Result.Msg <> '' then
    Exit;

  // invio ok
  Result.Ok:=True;
end;

function TAc03FValidazioneCartellinoDtM.AutorizzaRichiestaLiv1(const PId: Integer): TResultOper;
const
  NOTE_AUTORIZZAZIONE = 'Autorizzazione d''ufficio';
begin
 Result.Ok:=False;
  Result.Msg:='';

  C018.Id:=PId;
  C018.CodIter:=C018.GetCodIterFromId(PId);
  C018.InsAutorizzazione(1,C018SI,Parametri.Operatore,'',NOTE_AUTORIZZAZIONE);

  // errore durante autorizzazione
  if C018.MessaggioOperazione <> '' then
  begin
    Result.Msg:=C018.MessaggioOperazione;
    Exit
  end;

  // inserimento avvenuto correttamente
  Result.Ok:=True;
end;

function TAc03FValidazioneCartellinoDtM.AutorizzaRichiestaLivMax(const PId: Integer): TResultOper;
const
  NOTE_AUTORIZZAZIONE = 'Autorizzazione d''ufficio';
begin
  Result.Ok:=False;
  Result.Msg:='';

  C018.Id:=PId;
  C018.InsUltimeAutorizzazioni(C018.LivMaxAut + 1,C018SI,Parametri.Operatore,'N',NOTE_AUTORIZZAZIONE,True,False);

  // errore durante autorizzazione
  if C018.MessaggioOperazione <> '' then
  begin
    Result.Msg:=C018.MessaggioOperazione;
    Exit
  end;

  // inserimento avvenuto correttamente
  Result.Ok:=True;
end;


function TAc03FValidazioneCartellinoDtM.SbloccaValidazioneLivMax(const PId: Integer): TResultOper;
// sblocca la validazione all'ultimo livello obbligatorio,
// modificando il tipo della richiesta
// IMPORTANTE:
//   la query degli iter è modificata in modo da considerare
//   solo un determinato tipo richiesta
begin
  try
    // imposta variabili per gestione C018
    C018.Id:=PId;
    C018.CodIter:=C018.GetCodIterFromId(PId);

    // imposta il tipo richiesta in modo che risulti validabile al livello max
    C018.SetTipoRichiesta(T860STATO_VALID_MAXLIV);

    Result.Ok:=True;
    Result.Msg:='';
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Msg:=Format('%s',[E.Message]);
    end;
  end;
end;

function TAc03FValidazioneCartellinoDtM.GetLivMax(const PCodIter: String): Integer;
// restituisce il livello di autorizzazione massimo esistente per la richiesta indicata
begin
  Result:=-1;
  if C018.selI096.Active then
  begin
    if C018.selI096.SearchRecord('COD_ITER',VarArrayOf([PCodIter]),[srFromEnd]) then
      Result:=C018.selI096.FieldByName('LIVELLO').AsInteger;
  end;
end;

function TAc03FValidazioneCartellinoDtM.GetLivMaxObbligatorio(const PCodIter: String): Integer;
// restituisce il livello massimo obbligatorio per la richiesta indicata
begin
  Result:=-1;
  if C018.selI096.Active then
  begin
    if C018.selI096.SearchRecord('COD_ITER;OBBLIGATORIO',VarArrayOf([PCodIter,'S']),[srFromEnd]) then
      Result:=C018.selI096.FieldByName('LIVELLO').AsInteger;
  end;
end;

function TAc03FValidazioneCartellinoDtM.GetIndirizziMailResponsabili(const PProgDip: Integer;
  const PMeseRif: TDateTime; const PCodIter, PLivelliDest: String): String;
// estrae gli indirizzi mail dei responsabili
var
  C017DtM:TC017FEMailDtM;
begin
  C017DtM:=TC017FEMailDtM.Create(nil);
  try
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.DestResponsabile:=True;
      C017DtM.Progressivo:=PProgDip;
      C017DtM.Oggetto:='';
      C017DtM.Testo:='';
      C017DtM.TagFunzione:=442; // validazione cartellino web
      C017DtM.Iter:=ITER_CARTELLINO;
      C017DtM.CodIter:=PCodIter;
      C017DtM.LivelliDest:=PLivelliDest;
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.GetDestinatari;
      Result:=C017DtM.Destinatari;
    except
      //***
    end;
  finally
    C017DtM.Free;
  end;
end;

function TAc03FValidazioneCartellinoDtM.CheckPwdSysman(Pwd:String): Boolean;
begin
  Result:=False;
  with selI070 do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    Open;
    if R180DecriptaI070(FieldByName('PASSWD').AsString) = Pwd then
      Result:=True;
  end;
end;

function TAc03FValidazioneCartellinoDtM.ResetIterRichiesta(const PId: Integer;
  const PProg: Integer; const PMeseRif: TDateTime): TResultOper;
// effettua il reset dell'iter della richiesta di validazione, sbloccando anche il riepilogo T860
{
var
  L: Integer;
}
begin
  try
    // imposta variabili per gestione C018
    C018.Id:=PId;
    C018.CodIter:=C018.GetCodIterFromId(PId);

    // ###################################################################### //
    // v1.
    // modifica la richiesta in modo che sia validabile al primo livello
    {
    // rimuove autorizzazioni fino al primo livello
    for L:=C018.LivMaxAut downto 1 do
      C018.SetStato('',L);

    // riporta tipo_richiesta allo stato iniziale
    C018.SetTipoRichiesta(T860STATO_INIZIALE);

    // elimina info su produzione PDF:
    // imposta T860.ESISTE_PDF a N e T860.DATA_PDF a null
    updT860.SetVariable('ID',PId);
    updT860.Execute;
    }
    // ###################################################################### //



    // ###################################################################### //
    // v2.
    // rimuove la richiesta di validazione cartellino
    C018.EliminaIter;
    // ###################################################################### //

    // rimuove blocco riepiloghi T860
    SbloccaRiepiloghiT860(PProg,PMeseRif);

    // tutto ok
    Result.Ok:=True;
    Result.Msg:='';
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Msg:=Format('%s',[E.Message]);
    end;
  end;
end;

end.

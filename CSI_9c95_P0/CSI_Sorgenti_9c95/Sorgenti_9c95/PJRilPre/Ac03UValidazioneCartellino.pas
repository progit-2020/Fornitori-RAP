unit Ac03UValidazioneCartellino;

interface

uses
  OracleMonitor, A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia,
  A083UMsgElaborazioni, C004UParamForm, C017UEMailDtM,
  C018UIterAutDM, C180FunzioniGenerali, C700USelezioneAnagrafe,
  A003UDataLavoroBis, R450, OracleData, StrUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  R001UGESTTAB, System.Actions, Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus,
  Vcl.ComCtrls, Vcl.ToolWin, SelAnagrafe, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Generics.Collections, System.ImageList, C023UInfoDati;

type
  TDatiTipologieMail = record
    NotificaAttivazioneIter: TDatiMail;
    SollecitoValidazioneDip: TDatiMail;
    NotificaValidazioneDip: TDatiMail;
    NotificaAttivazioneResp: TDatiMail;
    SollecitoValidazioneResp: TDatiMail;
    NotificaValidazioneResp: TDatiMail;
  end;

  TStatoMail = class
  private
    Destinatari: String;
    PrefissoMsg: String;
  end;

  TAc03FValidazioneCartellino = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrdElenco: TDBGrid;
    pmnAzioni: TPopupMenu;
    mnuEsportaExcel1: TMenuItem;
    grpFiltri: TGroupBox;
    mnuValidaLiv1: TMenuItem;
    mnuSbloccaAutLivMax: TMenuItem;
    mnuAttivaIter: TMenuItem;
    rgpStato: TRadioGroup;
    rgpAutorizzazione: TRadioGroup;
    rgpPdf: TRadioGroup;
    grpEmail: TGroupBox;
    memMailCorpo: TMemo;
    pnlMeseRif: TPanel;
    lblMeseRif: TLabel;
    btnMeseRif: TSpeedButton;
    edtMeseRif: TMaskEdit;
    mnuResetIter: TMenuItem;
    actlst1: TActionList;
    actEsportaExcel: TAction;
    actAttivaIter: TAction;
    actAutLiv1: TAction;
    actSbloccaAutLivMax: TAction;
    actResetIter: TAction;
    actSelezionaTutto: TAction;
    actDeselezionaTutto: TAction;
    actInvertiSelezione: TAction;
    N4: TMenuItem;
    pnlAzioni: TPanel;
    btnBloccaRiepT860: TBitBtn;
    btnAutLiv1: TBitBtn;
    btnSbloccaAutLivMax: TBitBtn;
    actInviaMailSollecitoValidLiv1: TAction;
    mnuInviaMailSollecitoValidLiv1: TMenuItem;
    btnMailSollecito: TBitBtn;
    lblMailOggetto: TLabel;
    edtMailOggetto: TEdit;
    lblMailCorpo: TLabel;
    rgpEmail: TRadioGroup;
    btnSalvaDatiMail: TBitBtn;
    actInviaMailSollecitoValidLivMax: TAction;
    mnuInviaMailSollecitoValidLivMax: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    btnInviaMailSollecitoValidLivMax: TBitBtn;
    btnAnomalie: TBitBtn;
    btnRipristinaDatiMail: TBitBtn;
    btnResetIter: TBitBtn;
    actValidaLivMax: TAction;
    mnuValidaLivMax: TMenuItem;
    btnAutLivMax: TBitBtn;
    N7: TMenuItem;
    actInfoRichiesta: TAction;
    Inforichiesta1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnMeseRifClick(Sender: TObject);
    procedure actEsportaExcelExecute(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure actValidaLiv1Execute(Sender: TObject);
    procedure actSbloccaAutLivMaxExecute(Sender: TObject);
    procedure actAttivaIterExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actResetIterExecute(Sender: TObject);
    procedure actSelezionaTuttoExecute(Sender: TObject);
    procedure rgpStatoClick(Sender: TObject);
    procedure rgpAutorizzazioneClick(Sender: TObject);
    procedure rgpPdfClick(Sender: TObject);
    procedure pmnAzioniPopup(Sender: TObject);
    procedure actInviaMailSollecitoValidLiv1Execute(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure edtMailOggettoChange(Sender: TObject);
    procedure rgpEmailClick(Sender: TObject);
    procedure memMailCorpoChange(Sender: TObject);
    procedure btnSalvaDatiMailClick(Sender: TObject);
    procedure actInviaMailSollecitoValidLivMaxExecute(Sender: TObject);
    procedure btnRipristinaDatiMailClick(Sender: TObject);
    procedure actValidaLivMaxExecute(Sender: TObject);
    procedure actInfoRichiestaExecute(Sender: TObject);
  private
    MeseRif: TDateTime;
    DatiMailSalvati: TDatiTipologieMail;
    DatiMailCorrenti: TDatiTipologieMail;
    Disclaimer: String;
    C004Utente: TC004FParamForm;
    C004Mail: TC004FParamForm;
    procedure GetParametriFunzione;
    procedure PutParametriMail;
    procedure PutParametriFunzione;
    procedure CambiaProgressivo;
    procedure ImpostaFiltroVisualizzazione;
    function  AttivaBloccaRiepT860: Boolean;
    function  AttivaMailSollecitoValidazioneLiv1: Boolean;
    function  AttivaValidaLiv1(const PMaxLivAut: Integer): Boolean;
    function  AttivaValidaLivMax(const PMaxLivAut: Integer; const PMaxLiv: Integer): Boolean;
    function  AttivaSbloccaAutLivMax: Boolean;
    function  AttivaResetIter: Boolean;
    function  RimuoviIndirizziMailDuplicati(const PElencoIndirizzi: String): String;
    procedure AbilitaAzioniMassive;
    procedure GestioneAnomalieElaborazione;
    procedure AggiornaVista;
    function  AttivaMailSollecitoValidazioneLivMax: Boolean;
    function  SplitTesto(const PTesto: String; const PMaxLen: Integer): String;
  public
    procedure SetMeseRif(const PMeseRif: TDateTime);
  end;

var
  Ac03FValidazioneCartellino: TAc03FValidazioneCartellino;

const
  MAIL_DISCLAIMER     = #13#10#13#10'Avviso:'#13#10 +
                        'La presente email è stata generata automaticamente dal sistema IrisWIN.'#13#10 +
                        'Si prega di non rispondere a questo indirizzo di posta,'#13#10 +
                        'in quanto non è abilitato alla ricezione di messaggi.%s';

  ERR_MAIL_INCOMPLETA = 'I dati della mail di %s sono incompleti.'#13#10 +
                        'Proseguendo, verrà eseguita l''elaborazione, ' +
                        'ma non sarà inviata la corrispondente mail.'#13#10 +
                        'Vuoi continuare?';
  MAX_LENGTH_MSG      = 55;

procedure OpenAc03FValidazioneCartellino(Prog: Integer; MeseRif: TDateTime);

implementation

{$R *.dfm}

uses Ac03UValidazioneCartellinoDtM;

procedure OpenAc03FValidazioneCartellino(Prog: Integer; MeseRif: TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc03FValidazioneCartellino') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TAc03FValidazioneCartellino,Ac03FValidazioneCartellino);
  C700Progressivo:=Prog;
  Ac03FValidazioneCartellino.SetMeseRif(MeseRif);
  Application.CreateForm(TAc03FValidazioneCartellinoDtM,Ac03FValidazioneCartellinoDtM);
  try
    Screen.Cursor:=crDefault;
    Ac03FValidazioneCartellino.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Ac03FValidazioneCartellino.Free;
    Ac03FValidazioneCartellinoDtM.Free;
  end;
end;

procedure TAc03FValidazioneCartellino.FormShow(Sender: TObject);
begin
  inherited;

  C004Utente:=CreaC004(SessioneOracle,'Ac03',Parametri.Operatore,False);
  C004Mail:=CreaC004(SessioneOracle,'Ac03',-1,False);

  // disclaimer
  Disclaimer:=Format(MAIL_DISCLAIMER,[Format('[versione applicativo: %s(%s)]',[Parametri.VersionePJ,Parametri.BuildPJ])]);

  // estrae i parametri salvati per l'operatore
  GetParametriFunzione;

  // prepara selezione anagrafica
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=R180FineMese(MeseRif);
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.NumRecords;

  // imposta il dataset principale
  DButton.DataSet:=Ac03FValidazioneCartellinoDtM.selT860;

  // apre il dataset delle missioni
  DButton.DataSet.Close;
  (DButton.DataSet as TOracleDataSet).ClearVariables;
  C700MergeSelAnagrafe(DButton.DataSet);
  C700MergeSettaPeriodo(DButton.DataSet,MeseRif,MeseRif);
  rgpStatoClick(nil);
  DButton.DataSet.Open;
  NumRecords;
end;

procedure TAc03FValidazioneCartellino.FormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  C004Utente.Free;
  C004Mail.Free;

  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TAc03FValidazioneCartellino.GetParametriFunzione;
begin
  // mese di riferimento
  MeseRif:=StrToDate(C004Utente.GetParametro('MESERIF',FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro))));
  edtMeseRif.Text:=FormatDateTime('mm/yyyy',MeseRif);

  // filtri record
  rgpStato.ItemIndex:=StrToInt(C004Utente.GetParametro('RGPSTATO_ITEMINDEX','1'));
  rgpAutorizzazione.ItemIndex:=StrToInt(C004Utente.GetParametro('RGPAUTORIZZAZIONE_ITEMINDEX','0'));
  rgpPdf.ItemIndex:=StrToInt(C004Utente.GetParametro('RGPPDF_ITEMINDEX','0'));

  // tipo mail
  rgpEmail.OnClick:=nil;
  rgpEmail.ItemIndex:=StrToInt(C004Utente.GetParametro('RGPEMAIL_ITEMINDEX','0'));
  rgpEmail.OnClick:=rgpEmailClick;

  // dati mail
  DatiMailSalvati.NotificaAttivazioneIter.TipoMail:='Notifica attivazione iter al dipendente';
  DatiMailSalvati.NotificaAttivazioneIter.Oggetto:=C004Mail.GetParametro('NOTIFICAATTIVAZIONEITER_OGGETTO','');
  DatiMailSalvati.NotificaAttivazioneIter.Corpo:=C004Mail.GetParametro('NOTIFICAATTIVAZIONEITER_CORPO','');

  DatiMailSalvati.SollecitoValidazioneDip.TipoMail:='Sollecito validazione al dipendente';
  DatiMailSalvati.SollecitoValidazioneDip.Oggetto:=C004Mail.GetParametro('SOLLECITOVALIDAZIONEDIP_OGGETTO','');
  DatiMailSalvati.SollecitoValidazioneDip.Corpo:=C004Mail.GetParametro('SOLLECITOVALIDAZIONEDIP_CORPO','');

  DatiMailSalvati.NotificaValidazioneDip.TipoMail:='Notifica validazione al dipendente';
  DatiMailSalvati.NotificaValidazioneDip.Oggetto:=C004Mail.GetParametro('NOTIFICAVALIDAZIONEDIP_OGGETTO','');
  DatiMailSalvati.NotificaValidazioneDip.Corpo:=C004Mail.GetParametro('NOTIFICAVALIDAZIONEDIP_CORPO','');

  DatiMailSalvati.NotificaAttivazioneResp.TipoMail:='Notifica attivazione validazione al responsabile';
  DatiMailSalvati.NotificaAttivazioneResp.Oggetto:=C004Mail.GetParametro('NOTIFICAATTIVAZIONERESP_OGGETTO','');
  DatiMailSalvati.NotificaAttivazioneResp.Corpo:=C004Mail.GetParametro('NOTIFICAATTIVAZIONERESP_CORPO','');

  DatiMailSalvati.SollecitoValidazioneResp.TipoMail:='Sollecito validazione al responsabile';
  DatiMailSalvati.SollecitoValidazioneResp.Oggetto:=C004Mail.GetParametro('SOLLECITOVALIDAZIONERESP_OGGETTO','');
  DatiMailSalvati.SollecitoValidazioneResp.Corpo:=C004Mail.GetParametro('SOLLECITOVALIDAZIONERESP_CORPO','');

  DatiMailSalvati.NotificaValidazioneResp.TipoMail:='Notifica validazione al responsabile';
  DatiMailSalvati.NotificaValidazioneResp.Oggetto:=C004Mail.GetParametro('NOTIFICAVALIDAZIONERESP_OGGETTO','');
  DatiMailSalvati.NotificaValidazioneResp.Corpo:=C004Mail.GetParametro('NOTIFICAVALIDAZIONERESP_CORPO','');

  // riporta i dati salvati nei dati correnti
  DatiMailCorrenti:=DatiMailSalvati;

  // visualizza dati mail
  rgpEmailClick(rgpEmail);
end;

procedure TAc03FValidazioneCartellino.PutParametriMail;
begin
  // dati mail
  C004Mail.Cancella001;
  C004Mail.PutParametro('NOTIFICAATTIVAZIONEITER_OGGETTO',DatiMailSalvati.NotificaAttivazioneIter.Oggetto);
  C004Mail.PutParametro('NOTIFICAATTIVAZIONEITER_CORPO',DatiMailSalvati.NotificaAttivazioneIter.Corpo);

  C004Mail.PutParametro('SOLLECITOVALIDAZIONEDIP_OGGETTO',DatiMailSalvati.SollecitoValidazioneDip.Oggetto);
  C004Mail.PutParametro('SOLLECITOVALIDAZIONEDIP_CORPO',DatiMailSalvati.SollecitoValidazioneDip.Corpo);

  C004Mail.PutParametro('NOTIFICAVALIDAZIONEDIP_OGGETTO',DatiMailSalvati.NotificaValidazioneDip.Oggetto);
  C004Mail.PutParametro('NOTIFICAVALIDAZIONEDIP_CORPO',DatiMailSalvati.NotificaValidazioneDip.Corpo);

  C004Mail.PutParametro('NOTIFICAATTIVAZIONERESP_OGGETTO',DatiMailSalvati.NotificaAttivazioneResp.Oggetto);
  C004Mail.PutParametro('NOTIFICAATTIVAZIONERESP_CORPO',DatiMailSalvati.NotificaAttivazioneResp.Corpo);

  C004Mail.PutParametro('SOLLECITOVALIDAZIONERESP_OGGETTO',DatiMailSalvati.SollecitoValidazioneResp.Oggetto);
  C004Mail.PutParametro('SOLLECITOVALIDAZIONERESP_CORPO',DatiMailSalvati.SollecitoValidazioneResp.Corpo);

  C004Mail.PutParametro('NOTIFICAVALIDAZIONERESP_OGGETTO',DatiMailSalvati.NotificaValidazioneResp.Oggetto);
  C004Mail.PutParametro('NOTIFICAVALIDAZIONERESP_CORPO',DatiMailSalvati.NotificaValidazioneResp.Corpo);
  SessioneOracle.Commit;
end;

procedure TAc03FValidazioneCartellino.PutParametriFunzione;
begin
  C004Utente.Cancella001;
  // mese di riferimento
  C004Utente.PutParametro('MESERIF',FormatDateTime('dd/mm/yyyy',MeseRif));

  // filtri record
  C004Utente.PutParametro('RGPSTATO_ITEMINDEX',rgpStato.ItemIndex.ToString);
  C004Utente.PutParametro('RGPAUTORIZZAZIONE_ITEMINDEX',rgpAutorizzazione.ItemIndex.ToString);
  C004Utente.PutParametro('RGPPDF_ITEMINDEX',rgpPdf.ItemIndex.ToString);

  // tipo mail
  C004Utente.PutParametro('RGPEMAIL_ITEMINDEX',rgpEmail.ItemIndex.ToString);
  SessioneOracle.Commit;

  // dati mail
  PutParametriMail;
end;

procedure TAc03FValidazioneCartellino.SetMeseRif(const PMeseRif: TDateTime);
begin
  MeseRif:=PMeseRif;
end;

procedure TAc03FValidazioneCartellino.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700DataLavoro:=R180FineMese(MeseRif);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TAc03FValidazioneCartellino.AggiornaVista;
// aggiorna i filtri e riapre il dataset principale
begin
  // imposta automaticamente il tipo di email da visualizzare
  if rgpStato.ItemIndex < 2 then
  begin
    // iter non ancora disponibile -> attiva notifica attivazione iter
    rgpEmail.ItemIndex:=0;
  end
  else
  begin
    // iter disponibile: valuta il livello della richiesta
    case rgpAutorizzazione.ItemIndex of
      0: rgpEmail.ItemIndex:=1;
      1: rgpEmail.ItemIndex:=3;
      2: rgpEmail.ItemIndex:=4;
      3: begin
           rgpEmail.ItemIndex:=-1;
           rgpEmail.OnClick(rgpEmail); // bug delphi! non scatta se ItemIndex viene impostato a -1!!! ah no, è una feature...(e chi ha detto che doveva scattare? hai fatto click per caso?? e quando usi il mouse riesci a mettere ItemIndex = -1???)
         end;
    end;
  end;

  // aggiornamento dataset
  if DButton.DataSet <> nil then
  begin
    Screen.Cursor:=crHourGlass;
    try
      ImpostaFiltroVisualizzazione;
      DButton.DataSet.Open;
      NumRecords;
      AbilitaAzioniMassive;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TAc03FValidazioneCartellino.rgpStatoClick(Sender: TObject);
begin
  // impostazione radiogroup
  if rgpStato.ItemIndex < 2 then
  begin
    if rgpAutorizzazione.ItemIndex < (rgpAutorizzazione.Items.Count - 1) then
      rgpAutorizzazione.ItemIndex:=0;
    if rgpPdf.ItemIndex < (rgpPdf.Items.Count - 1) then
      rgpPdf.ItemIndex:=0;
  end;
  rgpAutorizzazione.Enabled:=rgpStato.ItemIndex >= 2;
  rgpPdf.Enabled:=rgpStato.ItemIndex >= 2;

  // aggiorna i filtri del dataset se già impostato
  AggiornaVista;
end;

procedure TAc03FValidazioneCartellino.rgpAutorizzazioneClick(Sender: TObject);
begin
  // aggiorna i filtri del dataset se già impostato
  AggiornaVista;
end;

procedure TAc03FValidazioneCartellino.rgpEmailClick(Sender: TObject);
var
  LOggetto: String;
  LCorpo: String;
  AbilModifica: Boolean;
begin
  case rgpEmail.ItemIndex of
    0: // notifica attivazione iter
       begin
         LOggetto:=DatiMailCorrenti.NotificaAttivazioneIter.Oggetto;
         LCorpo:=DatiMailCorrenti.NotificaAttivazioneIter.Corpo;
       end;
    1: // sollecito validazione dipendente
       begin
         LOggetto:=DatiMailCorrenti.SollecitoValidazioneDip.Oggetto;
         LCorpo:=DatiMailCorrenti.SollecitoValidazioneDip.Corpo;
       end;
    2: // notifica validazione al dipendente
       begin
         LOggetto:=DatiMailCorrenti.NotificaValidazioneDip.Oggetto;
         LCorpo:=DatiMailCorrenti.NotificaValidazioneDip.Corpo;
       end;
    3: // notifica attivazione validazione responsabile
       begin
         LOggetto:=DatiMailCorrenti.NotificaAttivazioneResp.Oggetto;
         LCorpo:=DatiMailCorrenti.NotificaAttivazioneResp.Corpo;
       end;
    4: // sollecito attivazione validazione responsabile
       begin
         LOggetto:=DatiMailCorrenti.SollecitoValidazioneResp.Oggetto;
         LCorpo:=DatiMailCorrenti.SollecitoValidazioneResp.Corpo;
       end;
    5: // notifica validazione responsabile
       begin
         LOggetto:=DatiMailCorrenti.NotificaValidazioneResp.Oggetto;
         LCorpo:=DatiMailCorrenti.NotificaValidazioneResp.Corpo;
       end;
  else
    // indice non selezionato o non valido -> svuota i campi e disabilita
    LOggetto:='';
    LCorpo:='';
  end;

  // imposta dati a video
  AbilModifica:=rgpEmail.ItemIndex > -1;
  edtMailOggetto.Enabled:=AbilModifica;
  edtMailOggetto.Text:=LOggetto;
  memMailCorpo.Enabled:=AbilModifica;
  memMailCorpo.Text:=LCorpo;
  btnSalvaDatiMail.Enabled:=AbilModifica and (not SolaLettura);
  if not AbilModifica then
  begin
    btnSalvaDatiMail.Enabled:=AbilModifica;
    btnRipristinaDatiMail.Enabled:=AbilModifica;
  end;
end;

procedure TAc03FValidazioneCartellino.rgpPdfClick(Sender: TObject);
begin
  // aggiorna i filtri del dataset se già impostato
  AggiornaVista;
end;

procedure TAc03FValidazioneCartellino.CambiaProgressivo;
begin
  if Assigned(DButton.DataSet) then
  begin
    Screen.Cursor:=crHourGlass;
    try
      DButton.DataSet.Close;
      C700MergeSelAnagrafe(DButton.DataSet);
      C700MergeSettaPeriodo(DButton.DataSet,R180InizioMese(MeseRif),R180FineMese(MeseRif));
      ImpostaFiltroVisualizzazione;
      DButton.DataSet.Open;
      NumRecords;
      AbilitaAzioniMassive;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TAc03FValidazioneCartellino.edtMailOggettoChange(Sender: TObject);
// salva oggetto mail in struttura dati in memoria
var
  LOggetto: String;
  DatiDifferenti: Boolean;
begin
  LOggetto:=edtMailOggetto.Text;

  case rgpEmail.ItemIndex of
   -1: // nessuna mail
       begin
         DatiDifferenti:=False;
       end;
    0: // notifica attivazione iter
       begin
         DatiMailCorrenti.NotificaAttivazioneIter.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.NotificaAttivazioneIter <> DatiMailSalvati.NotificaAttivazioneIter;
       end;
    1: // sollecito validazione dipendente
       begin
         DatiMailCorrenti.SollecitoValidazioneDip.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.SollecitoValidazioneDip <> DatiMailSalvati.SollecitoValidazioneDip;
       end;
    2: // notifica validazione dipendente
       begin
         DatiMailCorrenti.NotificaValidazioneDip.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.NotificaValidazioneDip <> DatiMailSalvati.NotificaValidazioneDip;
       end;
    3: // notifica attivazione validazione responsabile
       begin
         DatiMailCorrenti.NotificaAttivazioneResp.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.NotificaAttivazioneResp <> DatiMailSalvati.NotificaAttivazioneResp;
       end;
    4: // sollecito attivazione validazione responsabile
       begin
         DatiMailCorrenti.SollecitoValidazioneResp.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.SollecitoValidazioneResp <> DatiMailSalvati.SollecitoValidazioneResp;
       end;
    5: // notifica validazione responsabile
       begin
         DatiMailCorrenti.NotificaValidazioneResp.Oggetto:=LOggetto;
         DatiDifferenti:=DatiMailCorrenti.NotificaValidazioneResp <> DatiMailSalvati.NotificaValidazioneResp;
       end;
  else
    raise Exception.Create(Format('Elemento di indice %d non previsto!',[rgpEmail.ItemIndex]));
  end;

  // abilitazione pulsanti di salvataggio e ripristino dati mail
  btnSalvaDatiMail.Enabled:=DatiDifferenti and (not SolaLettura);
  btnRipristinaDatiMail.Enabled:=DatiDifferenti;
end;

procedure TAc03FValidazioneCartellino.memMailCorpoChange(Sender: TObject);
// salva corpo mail in struttura dati in memoria
var
  LCorpo: String;
  DatiDifferenti: Boolean;
begin
  LCorpo:=memMailCorpo.Text;

  case rgpEmail.ItemIndex of
   -1: // nessuna mail
       begin
         DatiDifferenti:=False;
       end;
    0: // notifica attivazione iter
       begin
         DatiMailCorrenti.NotificaAttivazioneIter.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.NotificaAttivazioneIter <> DatiMailSalvati.NotificaAttivazioneIter;
       end;
    1: // sollecito validazione dipendente
       begin
         DatiMailCorrenti.SollecitoValidazioneDip.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.SollecitoValidazioneDip <> DatiMailSalvati.SollecitoValidazioneDip;
       end;
    2: // notifica validazione dipendente
       begin
         DatiMailCorrenti.NotificaValidazioneDip.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.NotificaValidazioneDip <> DatiMailSalvati.NotificaValidazioneDip;
       end;
    3: // notifica attivazione validazione responsabile
       begin
         DatiMailCorrenti.NotificaAttivazioneResp.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.NotificaAttivazioneResp <> DatiMailSalvati.NotificaAttivazioneResp;
       end;
    4: // sollecito attivazione validazione responsabile
       begin
         DatiMailCorrenti.SollecitoValidazioneResp.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.SollecitoValidazioneResp <> DatiMailSalvati.SollecitoValidazioneResp;
       end;
    5: // notifica validazione responsabile
       begin
         DatiMailCorrenti.NotificaValidazioneResp.Corpo:=LCorpo;
         DatiDifferenti:=DatiMailCorrenti.NotificaValidazioneResp <> DatiMailSalvati.NotificaValidazioneResp;
       end;
  else
    raise Exception.Create(Format('Elemento di indice %d non previsto!',[rgpEmail.ItemIndex]));
  end;

  // abilitazione pulsanti di salvataggio e ripristino dati mail
  btnSalvaDatiMail.Enabled:=DatiDifferenti and (not SolaLettura);
  btnRipristinaDatiMail.Enabled:=DatiDifferenti;
end;

procedure TAc03FValidazioneCartellino.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Ac03','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TAc03FValidazioneCartellino.btnMeseRifClick(Sender: TObject);
begin
  // mese riferimento proposto
  if not TryStrToDate('01/' + edtMeseRif.Text,MeseRif) then
    MeseRif:=R180InizioMese(Parametri.DataLavoro);

  MeseRif:=DataOut(MeseRif,'Mese di riferimento','M');
  MeseRif:=R180FineMese(MeseRif);
  edtMeseRif.Text:=FormatDateTime('mm/yyyy',MeseRif);

  actRefreshExecute(nil);
end;

procedure TAc03FValidazioneCartellino.btnSalvaDatiMailClick(Sender: TObject);
// salva i dati della mail con C004
var
  Messaggio: String;
begin
  if rgpEmail.ItemIndex = -1 then
    Exit;

  // conferma operazione
  Messaggio:=Format('Confermi il salvataggio dei dati della mail'#13#10'di %s?',[rgpEmail.Items[rgpEmail.ItemIndex].ToLower]);
  if R180MessageBox(Messaggio,DOMANDA) = mrNo then
    Exit;

  case rgpEmail.ItemIndex of
    0: // notifica attivazione iter
       DatiMailSalvati.NotificaAttivazioneIter:=DatiMailCorrenti.NotificaAttivazioneIter;
    1: // sollecito validazione dipendente
       DatiMailSalvati.SollecitoValidazioneDip:=DatiMailCorrenti.SollecitoValidazioneDip;
    2: // notifica validazione dipendente
       DatiMailSalvati.NotificaValidazioneDip:=DatiMailCorrenti.NotificaValidazioneDip;
    3: // notifica attivazione validazione responsabile
       DatiMailSalvati.NotificaAttivazioneResp:=DatiMailCorrenti.NotificaAttivazioneResp;
    4: // sollecito attivazione validazione responsabile
       DatiMailSalvati.SollecitoValidazioneResp:=DatiMailCorrenti.SollecitoValidazioneResp;
    5: // notifica validazione responsabile
       DatiMailSalvati.NotificaValidazioneResp:=DatiMailCorrenti.NotificaValidazioneResp;
  end;
  PutParametriMail;
end;

procedure TAc03FValidazioneCartellino.btnRipristinaDatiMailClick(Sender: TObject);
// ripristina i dati di default delle mail
var
  Messaggio: String;
  DatiMail: TDatiMail;
begin
  if rgpEmail.ItemIndex = -1 then
    Exit;

  // conferma operazione
  Messaggio:=Format('Confermi il ripristino dei dati della mail'#13#10'di %s?',[rgpEmail.Items[rgpEmail.ItemIndex].ToLower]);
  if R180MessageBox(Messaggio,DOMANDA) = mrNo then
    Exit;

  case rgpEmail.ItemIndex of
    0: // notifica attivazione iter
       begin
         DatiMailCorrenti.NotificaAttivazioneIter:=DatiMailSalvati.NotificaAttivazioneIter;
         DatiMail:=DatiMailCorrenti.NotificaAttivazioneIter;
       end;
    1: // sollecito validazione dipendente
       begin
         DatiMailCorrenti.SollecitoValidazioneDip:=DatiMailSalvati.SollecitoValidazioneDip;
         DatiMail:=DatiMailCorrenti.SollecitoValidazioneDip;
       end;
    2: // notifica validazione dipendente
       begin
         DatiMailCorrenti.NotificaValidazioneDip:=DatiMailSalvati.NotificaValidazioneDip;
         DatiMail:=DatiMailCorrenti.NotificaValidazioneDip;
       end;
    3: // notifica attivazione validazione responsabile
       begin
         DatiMailCorrenti.NotificaAttivazioneResp:=DatiMailSalvati.NotificaAttivazioneResp;
         DatiMail:=DatiMailCorrenti.NotificaAttivazioneResp;
       end;
    4: // sollecito attivazione validazione responsabile
       begin
         DatiMailCorrenti.SollecitoValidazioneResp:=DatiMailSalvati.SollecitoValidazioneResp;
         DatiMail:=DatiMailCorrenti.SollecitoValidazioneResp;
       end;
    5: // notifica validazione responsabile
       begin
         DatiMailCorrenti.NotificaValidazioneResp:=DatiMailSalvati.NotificaValidazioneResp;
         DatiMail:=DatiMailCorrenti.NotificaValidazioneResp;
       end;
  end;

  // visualizza a video i dati della mail
  edtMailOggetto.Text:=DatiMail.Oggetto;
  memMailCorpo.Text:=DatiMail.Corpo;
end;

procedure TAc03FValidazioneCartellino.AbilitaAzioniMassive;
// imposta le abilitazioni dei pulsanti per le azioni massive
var
  AbilOk: Boolean;
begin
  AbilOk:=(C700SelAnagrafe <> nil) and (C700SelAnagrafe.Active) and (C700SelAnagrafe.RecordCount > 0) and
          (DButton.Dataset <> nil) and (DButton.Dataset.Active) and (DButton.Dataset.RecordCount > 0);
  btnBloccaRiepT860.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 1) and (not SolaLettura);
  btnMailSollecito.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 0);
  btnAutLiv1.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 0) and (not SolaLettura);
  btnSbloccaAutLivMax.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 1) and (not SolaLettura);
  btnInviaMailSollecitoValidLivMax.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 2);
  btnResetIter.Enabled:=(AbilOk) and (not SolaLettura);// and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 2);
  btnAutLivMax.Enabled:=(AbilOk) and (rgpStato.ItemIndex = 2) and (rgpAutorizzazione.ItemIndex = 2) and (not SolaLettura);
end;

function TAc03FValidazioneCartellino.SplitTesto(const PTesto: String; const PMaxLen: Integer): String;
// aggiunge un CRLF alla stringa in PTesto ogni PMaxLen caratteri circa
var
  LTesto: String;
const
  REPLACE_CHAR = '£';
begin
  // bugfix: l'apostrofo non è considerato bene nella wraptext,
  // per cui viene sostituito prima e dopo con un altro carattere
  // ovviamente embarcadero sostiene che non è un bug, ma una feature...
  LTesto:=PTesto.Replace('''',REPLACE_CHAR,[rfReplaceAll]);
  LTesto:=WrapText(LTesto,PMaxLen);
  Result:=LTesto.Replace(REPLACE_CHAR,'''',[rfReplaceAll]);
end;

procedure TAc03FValidazioneCartellino.ImpostaFiltroVisualizzazione;
var
  Filtro: String;
  FiltroRiepiloghi: String;
  FiltroAutorizzazione: String;
  FiltroPdf: String;
begin
  Filtro:='';

  // filtro blocco riepiloghi
  if rgpStato.ItemIndex = 0 then
  begin
    // prevalidazione mancante
    FiltroRiepiloghi:='and    T180F_STATORIEPILOGO(''T860A'',T070.PROGRESSIVO,T070.DATA) = ''A''';
  end
  else
  begin
    // prevalidazione esistente
    if rgpStato.ItemIndex < 3 then
      FiltroRiepiloghi:='and    T180F_STATORIEPILOGO(''T860A'',T070.PROGRESSIVO,T070.DATA) = ''C''';
    if rgpStato.ItemIndex = 1 then
    begin
      // non validabile (aperto / non impostato)
      FiltroRiepiloghi:=FiltroRiepiloghi + 'and    T180F_STATORIEPILOGO(''T860'',T070.PROGRESSIVO,T070.DATA) = ''A''';
    end
    else if rgpStato.ItemIndex = 2 then
    begin
      // validabile (chiuso)
      FiltroRiepiloghi:=FiltroRiepiloghi + 'and    T180F_STATORIEPILOGO(''T860'',T070.PROGRESSIVO,T070.DATA) = ''C''';
    end;
  end;
  Filtro:=Filtro + IfThen(Filtro <> '',#13#10) + FiltroRiepiloghi;

  // filtro autorizzazione
  case rgpAutorizzazione.ItemIndex of
    0: // da validare: max liv aut = -1
       FiltroAutorizzazione:='and    T851F_MAXLIV_AUTORIZZATO(T000F_GETAZIENDACORRENTE,T850.ITER,T850.ID) = -1';
    1: // validato dal dipendente (livello 1)
       FiltroAutorizzazione:=Format('and    T851F_MAXLIV_AUTORIZZATO(T000F_GETAZIENDACORRENTE,T850.ITER,T850.ID) = 1 and T850.TIPO_RICHIESTA = ''%s''',[T860STATO_INIZIALE]);
    2: // validabile dal responsabile dell'ultimo livello
       FiltroAutorizzazione:='and    T851F_MAXLIV_AUTORIZZATO(T000F_GETAZIENDACORRENTE,T850.ITER,T850.ID) = 1 and T850.TIPO_RICHIESTA is null';
    3: // validato dal responsabile dell'ultimo livello
       FiltroAutorizzazione:='and    T850.STATO is not null';
  end;
  Filtro:=Filtro + IfThen(Filtro <> '',#13#10) + FiltroAutorizzazione;

  // filtro pdf
  case rgpPdf.ItemIndex of
    0: // pdf non ancora prodotto
       FiltroPdf:='and    nvl(T860.ESISTE_PDF,''N'') = ''N''';
    1: // pdf già prodotto
       FiltroPdf:='and    T860.ESISTE_PDF = ''S''';
    2: // tutti
       FiltroPdf:='';
  end;
  Filtro:=Filtro + IfThen(Filtro <> '',#13#10) + FiltroPdf;

  // reimposta variabile substitution
  R180SetVariable(TOracleDataSet(DButton.DataSet),'FILTRO',Filtro);
end;

function TAc03FValidazioneCartellino.RimuoviIndirizziMailDuplicati(const PElencoIndirizzi: String): String;
 // rimuove gli indirizzi duplicati dall'elenco di destinatari separati da ";"
var
  Indirizzo: String;
  LstElenco: TStringList;
const
  SEPARATORE_INDIRIZZI = ';';
begin
  // verifica stringa vuota
  if (PElencoIndirizzi.Trim = '') or
     (PElencoIndirizzi.Trim = SEPARATORE_INDIRIZZI) then
  begin
    Result:='';
    Exit;
  end;

  // verifica indirizzo unico
  if not PElencoIndirizzi.Contains(SEPARATORE_INDIRIZZI) then
  begin
    Result:=PElencoIndirizzi;
    Exit;
  end;

  LstElenco:=TStringList.Create;
  try
    LstElenco.Sorted:=True;
    LstElenco.Duplicates:=dupIgnore;
    LstElenco.CaseSensitive:=False;
    for Indirizzo in PElencoIndirizzi.Split([SEPARATORE_INDIRIZZI]) do
    begin
      LstElenco.Add(Indirizzo);
    end;
    LstElenco.Delimiter:=SEPARATORE_INDIRIZZI;
    Result:=LstElenco.DelimitedText;
  finally
    FreeAndNil(LstElenco);
  end;
end;

procedure TAc03FValidazioneCartellino.GestioneAnomalieElaborazione;
// nel caso di presenza anomalie durante l'elaborazione
// richiede all'utente di visualizzarle tramite la relativa maschera
var
  Messaggio: String;
begin
  btnAnomalie.Enabled:=True;
  Messaggio:='Elaborazione terminata con anomalie.'#13#10'Vuoi visualizzarle?';
  if R180MessageBox(Messaggio,DOMANDA,'Anomalie') = mrYes then
  begin
    btnAnomalieClick(nil);
  end;
end;

procedure TAc03FValidazioneCartellino.pmnAzioniPopup(Sender: TObject);
var
  LMaxLivAut,LivMax: Integer;
begin
  mnuAttivaIter.Enabled:=AttivaBloccaRiepT860 and (not SolaLettura);
  mnuResetIter.Enabled:=AttivaResetIter and (not SolaLettura);

  mnuInviaMailSollecitoValidLiv1.Enabled:=AttivaMailSollecitoValidazioneLiv1;

  LMaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;
  mnuValidaLiv1.Enabled:=AttivaValidaLiv1(LMaxLivAut) and (not SolaLettura);

  mnuSbloccaAutLivMax.Enabled:=AttivaSbloccaAutLivMax and (not SolaLettura);
  mnuInviaMailSollecitoValidLivMax.Enabled:=AttivaMailSollecitoValidazioneLivMax;

  LivMax:=Ac03FValidazioneCartellinoDtM.GetLivMax(DButton.DataSet.FieldByName('COD_ITER').AsString);
  mnuValidaLivMax.Enabled:=AttivaValidaLivMax(LMaxLivAut, LivMax) and (not SolaLettura);
end;

procedure TAc03FValidazioneCartellino.actRefreshExecute(Sender: TObject);
var
  OldCursorDefault: Boolean;
begin
  if Assigned(DButton.DataSet) then
  begin
    OldCursorDefault:=Screen.Cursor = crDefault;
    if OldCursorDefault then
      Screen.Cursor:=crHourGlass;
    try
      DButton.DataSet.Close;
      //C700MergeSelAnagrafe(DButton.DataSet);
      C700MergeSettaPeriodo(DButton.DataSet,R180InizioMese(MeseRif),R180FineMese(MeseRif));
      ImpostaFiltroVisualizzazione;
      DButton.DataSet.Open;
      NumRecords;
      AbilitaAzioniMassive;
    except
      on E: Exception do
      begin
        R180MessageBox('Errore durante la visualizzazione dei record:'#13#10 + E.Message,ESCLAMA);
      end;
    end;
    if OldCursorDefault then
      Screen.Cursor:=crDefault;
  end;
end;

procedure TAc03FValidazioneCartellino.actSelezionaTuttoExecute(Sender: TObject);
begin
  dgrdElenco.SelectedRows.Clear;
  dgrdElenco.DataSource.DataSet.DisableControls;
  dgrdElenco.DataSource.DataSet.First;
  try
    while not dgrdElenco.DataSource.DataSet.Eof do
    begin
      if Sender = actSelezionaTutto then
        dgrdElenco.SelectedRows.CurrentRowSelected:=True
      else if Sender = actDeselezionaTutto then
        dgrdElenco.SelectedRows.CurrentRowSelected:=False
      else if Sender = actInvertiSelezione then
        dgrdElenco.SelectedRows.CurrentRowSelected:=not dgrdElenco.SelectedRows.CurrentRowSelected;
      dgrdElenco.DataSource.DataSet.Next;
    end;
  finally
    dgrdElenco.DataSource.DataSet.EnableControls;
  end;
end;

procedure TAc03FValidazioneCartellino.actEsportaExcelExecute(Sender: TObject);
// esporta tabella in formato csv negli appunti di windows
begin
  R180DBGridCopyToClipboard(dgrdElenco,True,False);
end;

// ########################################################################## //
// #######   O P E R A Z I O N I   R E L A T I V E   A L L ' I T E R   ###### //
// ########################################################################## //

function TAc03FValidazioneCartellino.AttivaBloccaRiepT860: Boolean;
var
  StatoT180A,Stato: String;
begin
  // se esiste la prevalidazione (riepilogo T860A chiuso)
  // e lo stato del riepilogo T860 è aperto (A oppure null),
  // effettua il blocco riepiloghi
  StatoT180A:=DButton.DataSet.FieldByName('STATO_T180A').AsString;
  Stato:=DButton.DataSet.FieldByName('STATO').AsString;

  Result:=(StatoT180A = 'C') and (R180In(Stato,['A','']));
end;

procedure TAc03FValidazioneCartellino.actAttivaIterExecute(Sender: TObject);
// effettua blocco del riepilogo T860 per attivare l'iter di validazione del cartellino
// invia contestualmente mail di notifica
var
  BM: TBookmark;
  Prog: Integer;
  MeseScheda: TDateTime;
  Nominativo, MeseSchedaStr, PrefissoMsg, Messaggio: String;
  RecordSingolo,InvioMail: Boolean;
  Risultato: TResultOper;
  DatiMail: TDatiMail;
  selT077:TselT077;
const
  ATTIVITA = 'Attivazione dell''iter di validazione cartellino';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail di notifica
  DatiMail:=DatiMailCorrenti.NotificaAttivazioneIter;
  InvioMail:=True;
  if (DatiMail.Oggetto = '') or
     (DatiMail.Corpo = '') then
  begin
    Messaggio:=Format(ERR_MAIL_INCOMPLETA,[DatiMail.TipoMail.ToLower]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
    InvioMail:=False;
  end;

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuAttivaIter);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi l''%s'#13#10'per i %d cartellini presenti?',
                      [ATTIVITA.ToLower,DButton.DataSet.RecordCount]);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  try
    try
      DButton.DataSet.DisableControls;

      if not RecordSingolo then
        DButton.DataSet.First;

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        Nominativo:=Format('%s %s',[DButton.DataSet.FieldByName('NOME').AsString,DButton.DataSet.FieldByName('COGNOME').AsString]);
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        PrefissoMsg:=Format('%s di %s:',[ATTIVITA,MeseSchedaStr]);

        if AttivaBloccaRiepT860 then
        begin
          // effettua blocco riepiloghi
          Risultato:=Ac03FValidazioneCartellinoDtM.BloccaRiepiloghiT860(Prog,MeseScheda);
          if Risultato.Ok then
          begin
            // commit operazione
            SessioneOracle.Commit;
            Messaggio:=Format('%s effettuata',[PrefissoMsg]);
            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);

            // invio mail di notifica
            if InvioMail then
            begin
              Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailADipendente(Prog,MeseScheda,DatiMail);
              if Risultato.Ok then
                Messaggio:=Format('%s inviata mail di notifica al dipendente',[PrefissoMsg])
              else
                Messaggio:=Format('%s si è verificato un errore durante l''invio mail di notifica al dipendente: %s',[PrefissoMsg,Risultato.Msg]);
              RegistraMsg.InserisciMessaggio(IfThen(Risultato.Ok,'I','A'),Messaggio,Parametri.Azienda,Prog);
            end
            else
            begin
              // mail non prevista
              Messaggio:=Format('%s l''invio mail di notifica non è stato previsto dall''operatore',[PrefissoMsg]);
              RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
            end;
          end
          else
          begin
            // rollback operazione
            SessioneOracle.Rollback;
            Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
            RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
          end;
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    Screen.Cursor:=crDefault;
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

function TAc03FValidazioneCartellino.AttivaResetIter: Boolean;
// reset iter richiesta se:
// - validazione presente almeno al livello 1
var
  LMaxLivAut: Integer;
begin
  // verifica che il max liv autorizzato sia >= 1
  LMaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;
  Result:=(LMaxLivAut >= 1);
end;

procedure TAc03FValidazioneCartellino.actResetIterExecute(Sender: TObject);
// effettua il reset dell'iter di richiesta in modo che sia nuovamente
// disponibile al dipendente per la prima validazione
// contestualmente invia la mail di notifica al dipendente
// riguarda solo dipendenti per cui esiste già la validazione al primo livello (almeno)
var
  BM: TBookmark;
  Id, Prog: Integer;
  MeseScheda: TDateTime;
  Risultato: TResultOper;
  MeseSchedaStr, PrefissoMsg, Messaggio, PwdSysman: String;
  RecordSingolo: Boolean;
const
  ATTIVITA = 'Reset dell''iter di validazione cartellino';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuResetIter);
  if not RecordSingolo then
  begin
    PwdSysman:=InputBox('Reset massivo','Password di SYSMAN:','');
    if not Ac03FValidazioneCartellinoDtM.CheckPwdSysman(PwdSysman) then
      raise exception.Create('Password errata - operazione annullata.');
  end;

  // avvia operazione
  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  try
    try
      DButton.DataSet.DisableControls;
      if not RecordSingolo then
        DButton.DataSet.First;

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Id:=DButton.DataSet.FieldByName('ID').AsInteger;
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        PrefissoMsg:=Format('%s di %s per la richiesta ID = %d:',[ATTIVITA,MeseSchedaStr,Id]);

        if AttivaResetIter then
        begin
          Risultato:=Ac03FValidazioneCartellinoDtM.ResetIterRichiesta(Id,Prog,MeseScheda);
          if Risultato.Ok then
          begin
            // commit operazione
            SessioneOracle.Commit;
            Messaggio:=Format('%s effettuato',[PrefissoMsg]);
          end
          else
          begin
            // errore invio mail
            SessioneOracle.Rollback;
            Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
          end;
          RegistraMsg.InserisciMessaggio(IfThen(Risultato.Ok,'I','A'),Messaggio,Parametri.Azienda,Prog);
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

// ########################################################################## //
// ######   O P E R A Z I O N I   L I V E L L O   D I P E N D E N T E   ##### //
// ########################################################################## //

function TAc03FValidazioneCartellino.AttivaMailSollecitoValidazioneLiv1: Boolean;
// mail di sollecito al dipendente se:
// - riepilogo T860 chiuso
// - validazione al livello 1 mancante (richiesta non presente oppure autorizzazione mancante)
var
  LStato: String;
  LMaxLivAut: Integer;
begin
  // verifica che lol stato del riepilogo T860 sia chiuso
  LStato:=DButton.DataSet.FieldByName('STATO').AsString;

  // verifica che il max liv autorizzato sia minore di 1
  LMaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;

  Result:=(LStato = 'C') and (LMaxLivAut < 1);
end;

procedure TAc03FValidazioneCartellino.actInfoRichiestaExecute(Sender: TObject);
var
  C023: TC023FInfoDati;
begin
  inherited;
  C023:=TC023FInfoDati.Create(nil);
  try
    C023.C018:=Ac03FValidazioneCartellinoDtM.C018;
    C023.MostraInfoRichiesta(DButton.DataSet.FieldByName('ID').AsInteger);
  finally
    FreeAndNil(C023);
  end;
end;

procedure TAc03FValidazioneCartellino.actInviaMailSollecitoValidLiv1Execute(Sender: TObject);
// invia mail di sollecito ai dipendenti che non hanno ancora effettuato
// la validazione del cartellino
var
  BM: TBookmark;
  Prog: Integer;
  MeseScheda: TDateTime;
  Nominativo, MeseSchedaStr, PrefissoMsg, Messaggio: String;
  RecordSingolo: Boolean;
  Risultato: TResultOper;
  DatiMail: TDatiMail;
const
  ATTIVITA = 'Invio della mail di sollecito al dipendente per la validazione del cartellino';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail
  DatiMail:=DatiMailCorrenti.SollecitoValidazioneDip;
  if DatiMail.Oggetto = '' then
    raise Exception.Create('E'' necessario indicare l''oggetto della mail di sollecito al dipendente!');
  if DatiMail.Corpo = '' then
    raise Exception.Create('E'' necessario indicare il testo della mail di sollecito al dipendente!');

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuInviaMailSollecitoValidLiv1);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi l''%s per i %d cartellini presenti?',
                      [ATTIVITA.ToLower,DButton.DataSet.RecordCount]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  try
    try
      DButton.DataSet.DisableControls;

      if not RecordSingolo then
        DButton.DataSet.First;

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        Nominativo:=Format('%s %s',[DButton.DataSet.FieldByName('NOME').AsString,DButton.DataSet.FieldByName('COGNOME').AsString]);
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        PrefissoMsg:=Format('%s di %s:',[ATTIVITA,MeseSchedaStr]);

        // verifica se è necessario inviare il sollecito
        if AttivaMailSollecitoValidazioneLiv1 then
        begin
          // invia mail di sollecito
          Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailADipendente(Prog,MeseScheda,DatiMail);
          if Risultato.Ok then
          begin
            Messaggio:=Format('%s effettuato',[PrefissoMsg]);
            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
          end
          else
          begin
            // errore invio mail
            Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
            RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
          end;
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;
    except
      on E: Exception do
      begin
        Messaggio:=Format('%s: si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    Screen.Cursor:=crDefault;
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

function TAc03FValidazioneCartellino.AttivaValidaLiv1(const PMaxLivAut: Integer): Boolean;
// verifica se la validazione al livello 1 (lato dipendente) è necessaria
// - riepilogo T860 chiuso
// - max liv. autorizzato minore di 1
var
  LStato: String;
begin
  // verifica che lo stato del riepilogo T860 sia chiuso
  LStato:=DButton.DataSet.FieldByName('STATO').AsString;

  Result:=(LStato = 'C') and (PMaxLivAut < 1);
end;

function TAc03FValidazioneCartellino.AttivaValidaLivMax(const PMaxLivAut: Integer;const PMaxLiv: Integer): Boolean;
var
  LStato: String;
begin
  // verifica che lo stato del riepilogo T860 sia chiuso
  LStato:=DButton.DataSet.FieldByName('STATO').AsString;

  Result:=(LStato = 'C') and (PMaxLivAut < PMaxLiv);
end;

procedure TAc03FValidazioneCartellino.actValidaLiv1Execute(Sender: TObject);
// autorizza la richiesta di validazione cartellino al livello 1 (lato dipendente)
// se la richiesta non è ancora presente, la crea
var
  BM: TBookmark;
  Id, Prog, MaxLivAut: Integer;
  MeseScheda: TDateTime;
  AutLiv1,Stato,MeseSchedaStr,FiltroAnag,ElencoProg,
  CurrProg,PrefissoMsg,Messaggio: String;
  RecordSingolo, InvioMail: Boolean;
  Risultato: TResultOper;
  Richiesta: TDatiRichiesta;
  DatiMail: TDatiMail;
const
  ATTIVITA = 'Validazione del cartellino per il dipendente';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail di notifica
  DatiMail:=DatiMailCorrenti.NotificaValidazioneDip;
  InvioMail:=True;
  if (DatiMail.Oggetto = '') or
     (DatiMail.Corpo = '') then
  begin
    Messaggio:=Format(ERR_MAIL_INCOMPLETA,[DatiMail.TipoMail.ToLower]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
    InvioMail:=False;
  end;

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuValidaLiv1);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi la %s'#13#10'per i %d cartellini presenti?',
                      [ATTIVITA.ToLower,DButton.DataSet.RecordCount]);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  try
    try
      DButton.DataSet.DisableControls;

      // in caso di azione massiva esegue un primo ciclo per determinare
      // i progressivi da considerare come filtro anagrafico per il dataset
      // dell'iter autorizzativo
      if RecordSingolo then
      begin
        // filtro sul progressivo singolo
        ElencoProg:=DButton.Dataset.FieldByName('PROGRESSIVO').AsString;
      end
      else
      begin
        // filtro sui progressivi presenti
        ElencoProg:='';
        DButton.DataSet.First;
        while not DButton.DataSet.Eof do
        begin
          CurrProg:=DButton.Dataset.FieldByName('PROGRESSIVO').AsString;
          if R180CercaParolaIntera(CurrProg,ElencoProg,',') = 0 then
            ElencoProg:=ElencoProg + CurrProg + ',';
          DButton.DataSet.Next;
        end;
        if ElencoProg <> '' then
          ElencoProg:=ElencoProg.Substring(0,ElencoProg.Length - 1);
        if ElencoProg.Contains(',') then
          ElencoProg:=Format('(%s)',[ElencoProg]);

        // riporta il dataset sul primo record
        DButton.DataSet.First;
      end;
      FiltroAnag:=Format('and   T030.PROGRESSIVO %s %s',[IfThen(ElencoProg.Contains(','),'in','='),ElencoProg]);

      // impostazione e apertura dataset richieste
      Ac03FValidazioneCartellinoDtM.ImpostaDatasetIter(FiltroAnag);

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Id:=DButton.DataSet.FieldByName('ID').AsInteger;
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        Stato:=DButton.DataSet.FieldByName('STATO').AsString;
        MaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;
        AutLiv1:=DButton.DataSet.FieldByName('AUT_LIV_1').AsString;
        PrefissoMsg:=Format('%s di %s:',[ATTIVITA,MeseSchedaStr]);

        // considera il record solo se lo stato del riepilogo T860 è chiuso
        if Stato = 'C' then
        begin
          // se l'id non è ancora presente crea la richiesta di validazione
          if Id = 0 then
          begin
            Risultato:=Ac03FValidazioneCartellinoDtM.CreaRichiesta(Prog,MeseScheda,Richiesta);
            if Risultato.Ok then
            begin
              Id:=Richiesta.Id;
              MaxLivAut:=Richiesta.MaxLivAut;
              AutLiv1:=Richiesta.AutLiv1;

              Messaggio:=Format('%s è stata creata la richiesta ID = %d',[PrefissoMsg,Id]);
              // committa successivamente
            end
            else
            begin
              Messaggio:=Format('%s si è verificato un errore durante la creazione della richiesta: %s',[PrefissoMsg,Risultato.Msg]);
              // effettua rollback successivamente
            end;
            RegistraMsg.InserisciMessaggio(IfThen(Risultato.Ok,'I','A'),Messaggio,Parametri.Azienda,Prog);
          end;

          if Id > 0 then
          begin
            // verifica se è necessario inserire l'autorizzazione
            if AttivaValidaLiv1(MaxLivAut) then
            begin
              // autorizza la richiesta selezionata al livello 1
              Risultato:=Ac03FValidazioneCartellinoDtM.AutorizzaRichiestaLiv1(Id);
              if Risultato.Ok then
              begin
                SessioneOracle.Commit;
                Messaggio:=Format('%s la richiesta ID = %d è stata autorizzata al livello 1',[PrefissoMsg,Id]);
                RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);

                // invia mail di notifica se prevista
                if InvioMail then
                begin
                  Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailADipendente(Prog,MeseScheda,DatiMail);
                  if Risultato.Ok then
                  begin
                    // invio mail ok
                    Messaggio:=Format('%s inviata mail di notifica al dipendente',[PrefissoMsg]);
                    RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
                  end
                  else
                  begin
                    // errore invio mail
                    Messaggio:=Format('%s si è verificato un errore durante l''invio della mail di notifica al dipendente: %s',[PrefissoMsg,Risultato.Msg]);
                    RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
                  end;
                end
                else
                begin
                  // mail non prevista
                  Messaggio:=Format('%s l''invio mail di notifica al dipendente non è stato previsto dall''operatore',[PrefissoMsg]);
                  RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
                end;
              end
              else
              begin
                SessioneOracle.Rollback;
                Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
                RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
              end;
            end;
          end
          else
          begin
            // richiesta non inserita
            SessioneOracle.Rollback;
          end;
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    Screen.Cursor:=crDefault;
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TAc03FValidazioneCartellino.actValidaLivMaxExecute(Sender: TObject);
// autorizza la richiesta di validazione cartellino al livello 1 (lato dipendente)
// se la richiesta non è ancora presente, la crea
var
  BM: TBookmark;
  Id, Prog, MaxLivAut: Integer;
  MeseScheda: TDateTime;
  //AutLiv1,
  CodIter,Stato,MeseSchedaStr,FiltroAnag,ElencoProg,
  CurrProg,PrefissoMsg,Messaggio: String;
  RecordSingolo, InvioMail: Boolean;
  Risultato: TResultOper;
  DatiMail: TDatiMail;
  DestMail, ElencoDestMail:String;
  LivMax: integer;
const
  ATTIVITA = 'Validazione del cartellino per il responsabile';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail di notifica
  DatiMail:=DatiMailCorrenti.NotificaValidazioneResp;

  InvioMail:=True;
  if (DatiMail.Oggetto = '') or
     (DatiMail.Corpo = '') then
  begin
    Messaggio:=Format(ERR_MAIL_INCOMPLETA,[DatiMail.TipoMail.ToLower]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
    InvioMail:=False;
  end;

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuValidaLivMax);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi la %s'#13#10'per i %d cartellini presenti?',
                      [ATTIVITA.ToLower,DButton.DataSet.RecordCount]);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  try
    try
      DButton.DataSet.DisableControls;

      // in caso di azione massiva esegue un primo ciclo per determinare
      // i progressivi da considerare come filtro anagrafico per il dataset
      // dell'iter autorizzativo
      if RecordSingolo then
      begin
        // filtro sul progressivo singolo
        ElencoProg:=DButton.Dataset.FieldByName('PROGRESSIVO').AsString;
      end
      else
      begin
        // filtro sui progressivi presenti
        ElencoProg:='';
        DButton.DataSet.First;
        while not DButton.DataSet.Eof do
        begin
          CurrProg:=DButton.Dataset.FieldByName('PROGRESSIVO').AsString;
          if R180CercaParolaIntera(CurrProg,ElencoProg,',') = 0 then
            ElencoProg:=ElencoProg + CurrProg + ',';
          DButton.DataSet.Next;
        end;
        if ElencoProg <> '' then
          ElencoProg:=ElencoProg.Substring(0,ElencoProg.Length - 1);
        if ElencoProg.Contains(',') then
          ElencoProg:=Format('(%s)',[ElencoProg]);

        // riporta il dataset sul primo record
        DButton.DataSet.First;
      end;
      FiltroAnag:=Format('and   T030.PROGRESSIVO %s %s',[IfThen(ElencoProg.Contains(','),'in','='),ElencoProg]);

      // impostazione e apertura dataset richieste
      Ac03FValidazioneCartellinoDtM.ImpostaDatasetIter(FiltroAnag);

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Id:=DButton.DataSet.FieldByName('ID').AsInteger;
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        Stato:=DButton.DataSet.FieldByName('STATO').AsString;
        MaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger; //Massimo livello autorizzato per il cartellino corrente
        PrefissoMsg:=Format('%s di %s:',[ATTIVITA,MeseSchedaStr]);
        CodIter:=DButton.DataSet.FieldByName('COD_ITER').AsString;

        // determina l'ultimo livello obbligatorio per il codice iter della richiesta
        LivMax:=Ac03FValidazioneCartellinoDtM.GetLivMax(CodIter);

        // verifica se è necessario inserire l'autorizzazione
        if AttivaValidaLivMax(MaxLivAut, LivMax) then
        begin
          // autorizza la richiesta selezionata al livello massimo
          Risultato:=Ac03FValidazioneCartellinoDtM.AutorizzaRichiestaLivMax(Id);
          if Risultato.Ok then
          begin
            SessioneOracle.Commit;

            Messaggio:=Format('%s la richiesta ID = %d è stata autorizzata al livello ' + IntToStr(LivMax),[PrefissoMsg,Id]);

            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);

            // invia mail di notifica se prevista
            if InvioMail then
            begin
              // determina gli indirizzi email dei responsabili dell'ultimo livello obbligatorio
              DestMail:=Ac03FValidazioneCartellinoDtM.GetIndirizziMailResponsabili(Prog,MeseScheda,CodIter,LivMax.ToString);

              // aggiunge i destinatari all'elenco
              if (DestMail <> '') and
                 (R180CercaParolaIntera(DestMail,ElencoDestMail,';') = 0) then
              begin
                ElencoDestMail:=ElencoDestMail + DestMail + ';';
              end;

              if ElencoDestMail <> '' then
              begin
                if ElencoDestMail.EndsWith(';') then
                  ElencoDestMail:=ElencoDestMail.SubString(0,ElencoDestMail.Length - 1);
                ElencoDestMail:=RimuoviIndirizziMailDuplicati(ElencoDestMail);

                Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailAResponsabile(MeseScheda,DatiMail,ElencoDestMail);
                if Risultato.Ok then
                begin
                  // invio mail ok
                  Messaggio:=Format('%s inviata mail di notifica al dipendente',[PrefissoMsg]);
                  RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
                end
                else
                begin
                  // errore invio mail
                  Messaggio:=Format('%s si è verificato un errore durante l''invio della mail di notifica al dipendente: %s',[PrefissoMsg,Risultato.Msg]);
                  RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
                end;
              end;
            end
            else
            begin
              // mail non prevista
              Messaggio:=Format('%s l''invio mail di notifica al dipendente non è stato previsto dall''operatore',[PrefissoMsg]);
              RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
            end;
          end
          else
          begin
            SessioneOracle.Rollback;
            Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
            RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
          end;
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    Screen.Cursor:=crDefault;
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

// ########################################################################## //
// ####   O P E R A Z I O N I   L I V E L L O   R E S P O N S A B I L E   ### //
// ########################################################################## //

function TAc03FValidazioneCartellino.AttivaSbloccaAutLivMax: Boolean;
// verifica se lo sblocco per l'ultimo livello (lato responsabile) è necessario
var
  LId, LMaxLivAut: Integer;
  LTipoRichiesta: String;
begin
  LId:=DButton.DataSet.FieldByName('ID').AsInteger;
  LMaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;
  LTipoRichiesta:=DButton.DataSet.FieldByName('TIPO_RICHIESTA').AsString;

  if LId = 0 then
  begin
    // richiesta non presente: sblocco impossibile
    Result:=False;
  end
  else
  begin
    // sblocco necessario se il max liv. autorizzato è 1 e il tipo richiesta è T860STATO_INIZIALE
    Result:=(LMaxLivAut = 1) and (LTipoRichiesta = T860STATO_INIZIALE);
  end;
end;

procedure TAc03FValidazioneCartellino.actSbloccaAutLivMaxExecute(Sender: TObject);
// sblocca la richiesta in modo che possa essere validata all'ultimo livello
var
  BM: TBookmark;
  Id, Prog, LivMaxObblig: Integer;
  MeseScheda: TDateTime;
  MeseSchedaStr, ElencoDestMail, DestMail, CodIter,
  PrefissoMsg, Messaggio, Dest: String;
  RecordSingolo, InvioMail: Boolean;
  Risultato: TResultOper;
  DatiMail: TDatiMail;
  StatoMail: TStatoMail;
  StatoMailDict: TObjectDictionary<Integer,TStatoMail>;
const
  ATTIVITA = 'Attivazione della validazione per i responsabili del cartellino';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail di notifica
  DatiMail:=DatiMailCorrenti.NotificaAttivazioneResp;
  InvioMail:=True;
  if (DatiMail.Oggetto = '') or
     (DatiMail.Corpo = '') then
  begin
    Messaggio:=Format(ERR_MAIL_INCOMPLETA,[DatiMail.TipoMail.ToLower]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
    InvioMail:=False;
  end;

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuSbloccaAutLivMax);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi l''%s per le %d richieste presenti?',
                      [ATTIVITA.ToLower,DButton.Dataset.RecordCount]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  StatoMailDict:=TObjectDictionary<Integer,TStatoMail>.Create([doOwnsValues]);
  try
    try
      DButton.DataSet.DisableControls;
      if not RecordSingolo then
        DButton.DataSet.First;

      ElencoDestMail:='';

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Id:=DButton.DataSet.FieldByName('ID').AsInteger;
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        CodIter:=DButton.DataSet.FieldByName('COD_ITER').AsString;
        PrefissoMsg:=Format('%s %s per la richiesta ID = %d:',[ATTIVITA,MeseSchedaStr,Id]);

        // verifica se è necessario inserire l'autorizzazione
        if AttivaSbloccaAutLivMax then
        begin
          // determina l'ultimo livello obbligatorio per il codice iter della richiesta
          LivMaxObblig:=Ac03FValidazioneCartellinoDtM.GetLivMaxObbligatorio(CodIter);

          // sblocca la validazione all'ultimo livello
          Risultato:=Ac03FValidazioneCartellinoDtM.SbloccaValidazioneLivMax(Id);

          if Risultato.Ok then
          begin
            // commit operazione
            SessioneOracle.Commit;
            Messaggio:=Format('%s effettuata per il livello %d',[PrefissoMsg,LivMaxObblig]);
            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);

            // gestione eventuale invio mail ai responsabili
            if InvioMail then
            begin
              // determina gli indirizzi email dei responsabili dell'ultimo livello obbligatorio
              DestMail:=Ac03FValidazioneCartellinoDtM.GetIndirizziMailResponsabili(Prog,MeseScheda,CodIter,LivMaxObblig.ToString);

              // aggiunge i destinatari all'elenco
              if DestMail <> '' then
              begin
                if R180CercaParolaIntera(DestMail,ElencoDestMail,';') = 0 then
                  ElencoDestMail:=ElencoDestMail + DestMail + ';';
              end;

              // prepara info per successivo log per ogni dipendente
              StatoMail:=TStatoMail.Create;
              StatoMail.Destinatari:=DestMail;
              StatoMail.PrefissoMsg:=PrefissoMsg;
              StatoMailDict.Add(Prog,StatoMail);
            end
            else
            begin
              Messaggio:=Format('%s invio mail di notifica non previsto dall''operatore',[PrefissoMsg]);
              RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
            end;
          end
          else
          begin
            // rollback operazione
            SessioneOracle.Rollback;
            Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
            RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
          end;
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;

      // invia mail di notifica sblocco a tutti i responsabili individuati
      if (InvioMail) and (ElencoDestMail <> '') then
      begin
        if ElencoDestMail.EndsWith(';') then
          ElencoDestMail:=ElencoDestMail.SubString(0,ElencoDestMail.Length - 1);
        ElencoDestMail:=RimuoviIndirizziMailDuplicati(ElencoDestMail);
        Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailAResponsabile(MeseRif,DatiMail,ElencoDestMail);

        // genera log di invio mail per ogni dipendente presente
        for Prog in StatoMailDict.Keys do
        begin
          Dest:=StatoMailDict[Prog].Destinatari;
          PrefissoMsg:=StatoMailDict[Prog].PrefissoMsg;
          if Dest = '' then
          begin
            // nessun destinatario per il dipendente
            Messaggio:=Format('%s nessun indirizzo mail associato ai responsabili',[PrefissoMsg]);
            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
          end
          else
          begin
            if Risultato.Ok then
            begin
              // mail ok
              Messaggio:=Format('%s invio mal di notifica effettuato ai seguenti indirizzi: %s',[PrefissoMsg,Dest]);
              RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
            end
            else
            begin
              // errore invio mail
              Messaggio:=Format('%s si è verificato un errore durante l''invio mail di notifica ai responsabili: %s',[PrefissoMsg,Risultato.Msg]);
              RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    Screen.Cursor:=crDefault;
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    FreeAndNil(StatoMailDict);
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

function TAc03FValidazioneCartellino.AttivaMailSollecitoValidazioneLivMax: Boolean;
// mail di sollecito al responsabile se:
// - effettuato sblocco validazione per livello max
var
  LId: Integer;
  LMaxLivAut: Integer;
  LTipoRichiesta: String;
begin
  LId:=DButton.DataSet.FieldByName('ID').AsInteger;
  LMaxLivAut:=DButton.DataSet.FieldByName('MAX_LIV_AUT').AsInteger;
  LTipoRichiesta:=DButton.DataSet.FieldByName('TIPO_RICHIESTA').AsString;

  if LId = 0 then
  begin
    // richiesta non presente: sblocco impossibile
    Result:=False;
  end
  else
  begin
    // sblocco necessario se il max liv. autorizzato è 1 e il tipo richiesta è T860STATO_VALID_MAXLIV
    Result:=(LMaxLivAut = 1) and (LTipoRichiesta = T860STATO_VALID_MAXLIV);
  end;

end;

procedure TAc03FValidazioneCartellino.actInviaMailSollecitoValidLivMaxExecute(Sender: TObject);
// sblocca la richiesta in modo che possa essere validata all'ultimo livello
var
  BM: TBookmark;
  Id, Prog, LivMaxObblig: Integer;
  MeseScheda: TDateTime;
  MeseSchedaStr, ElencoDestMail, Dest, DestMail, CodIter,
  PrefissoMsg, Messaggio: String;
  RecordSingolo: Boolean;
  Risultato: TResultOper;
  DatiMail: TDatiMail;
  StatoMail: TStatoMail;
  StatoMailDict: TObjectDictionary<Integer,TStatoMail>;
const
  ATTIVITA = 'Invio della mail di sollecito al responsabile per la validazione del cartellino';
begin
  // verifica il dataset
  if not DButton.DataSet.Active then
    Exit;

  if DButton.DataSet.RecordCount = 0 then
    Exit;

  // verifica l'impostazione dei dati della mail
  DatiMail:=DatiMailCorrenti.SollecitoValidazioneResp;
  if DatiMail.Oggetto = '' then
    raise Exception.Create('E'' necessario indicare l''oggetto della mail di sollecito ai responsabili!');
  if DatiMail.Corpo = '' then
    raise Exception.Create('E'' necessario indicare il testo della mail di sollecito ai responsabili!');

  // determina se operare su record singolo
  RecordSingolo:=((Sender as TAction).ActionComponent = mnuInviaMailSollecitoValidLivMax);

  // conferma operazione massiva
  if not RecordSingolo then
  begin
    Messaggio:=Format('Confermi l''%s per i %d cartellini presenti?',
                      [ATTIVITA.ToLower,DButton.DataSet.RecordCount]);
    Messaggio:=SplitTesto(Messaggio,MAX_LENGTH_MSG);
    if R180MessageBox(Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  Screen.Cursor:=crHourGlass;

  // inizia messaggio log
  RegistraMsg.IniziaMessaggio('Ac03');
  btnAnomalie.Enabled:=False;

  // inizializzazione variabili
  Prog:=-1;
  ElencoDestMail:='';

  // salva la posizione corrente
  BM:=DButton.DataSet.GetBookmark;
  StatoMailDict:=TObjectDictionary<Integer,TStatoMail>.Create([doOwnsValues]);
  try
    try
      DButton.DataSet.DisableControls;

      if not RecordSingolo then
        DButton.DataSet.First;

      while not DButton.DataSet.Eof do
      begin
        // salva info record
        Id:=DButton.DataSet.FieldByName('ID').AsInteger;
        Prog:=DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
        MeseScheda:=DButton.DataSet.FieldByName('MESE_SCHEDA').AsDateTime;
        MeseSchedaStr:=FormatDateTime('mmmm yyyy',MeseScheda);
        CodIter:=DButton.DataSet.FieldByName('COD_ITER').AsString;
        PrefissoMsg:=Format('%s di %s per la richiesta ID = %d:',[ATTIVITA,MeseSchedaStr,Id]);

        // verifica se è necessario inviare il sollecito
        if AttivaMailSollecitoValidazioneLivMax then
        begin
          // determina l'ultimo livello obbligatorio per il codice iter della richiesta
          LivMaxObblig:=Ac03FValidazioneCartellinoDtM.GetLivMaxObbligatorio(CodIter);

          // determina gli indirizzi email dei responsabili dell'ultimo livello obbligatorio
          DestMail:=Ac03FValidazioneCartellinoDtM.GetIndirizziMailResponsabili(Prog,MeseScheda,CodIter,LivMaxObblig.ToString);

          // aggiunge i destinatari all'elenco
          if (DestMail <> '') and
             (R180CercaParolaIntera(DestMail,ElencoDestMail,';') = 0) then
          begin
            ElencoDestMail:=ElencoDestMail + DestMail + ';';
          end;

          // prepara info per successivo log per ogni dipendente
          StatoMail:=TStatoMail.Create;
          StatoMail.Destinatari:=DestMail;
          StatoMail.PrefissoMsg:=PrefissoMsg;
          StatoMailDict.Add(Prog,StatoMail);
        end;

        if RecordSingolo then
          Break
        else
          DButton.DataSet.Next;
      end;

      // invia mail di  a tutti i responsabili individuati
      if ElencoDestMail <> '' then
      begin
        if ElencoDestMail.EndsWith(';') then
          ElencoDestMail:=ElencoDestMail.SubString(0,ElencoDestMail.Length - 1);
        ElencoDestMail:=RimuoviIndirizziMailDuplicati(ElencoDestMail);
        Risultato:=Ac03FValidazioneCartellinoDtM.InviaMailAResponsabile(MeseRif,DatiMail,ElencoDestMail);

        // genera log di invio mail per ogni dipendente presente
        for Prog in StatoMailDict.Keys do
        begin
          Dest:=StatoMailDict[Prog].Destinatari;
          PrefissoMsg:=StatoMailDict[Prog].PrefissoMsg;
          if Dest = '' then
          begin
            // nessun destinatario per il dipendente
            Messaggio:=Format('%s nessun indirizzo mail associato ai responsabili',[PrefissoMsg]);
            RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
          end
          else
          begin
            if Risultato.Ok then
            begin
              // mail ok
              Messaggio:=Format('%s effettuato ai seguenti indirizzi: %s',[PrefissoMsg,Dest]);
              RegistraMsg.InserisciMessaggio('I',Messaggio,Parametri.Azienda,Prog);
            end
            else
            begin
              // errore invio mail
              Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s',[PrefissoMsg,Risultato.Msg]);
              RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Messaggio:=Format('%s si è verificato un errore durante l''operazione: %s (%s)',[PrefissoMsg,E.Message,E.ClassName]);
        RegistraMsg.InserisciMessaggio('A',Messaggio,Parametri.Azienda,Prog);
      end;
    end;

    DButton.DataSet.Refresh;

    // ritorna al record iniziale
    if DButton.DataSet.BookmarkValid(BM) then
      DButton.DataSet.GotoBookmark(BM);

    // gestione anomalie elaborazione
    if RegistraMsg.ContieneTipoA then
      GestioneAnomalieElaborazione
    else
      R180MessageBox('Elaborazione terminata correttamente!',INFORMA);
  finally
    FreeAndNil(StatoMailDict);
    DButton.DataSet.FreeBookmark(BM);
    DButton.DataSet.EnableControls;
    NumRecords;
    AbilitaAzioniMassive;
    Screen.Cursor:=crDefault;
  end;
end;

end.

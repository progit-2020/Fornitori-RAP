unit S715UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Math, Buttons, DBCtrls, StdCtrls, ExtCtrls, DB, CheckLst, ComCtrls, OracleData,
  StrUtils, Menus, Variants, Mask, SelAnagrafe, RegistrazioneLog,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, A083UMsgElaborazioni,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C012UVisualizzaTesto,
  C013UCheckList, C180FunzioniGenerali, C700USelezioneAnagrafe,
  SynPdf, Types, DateUtils, XSBuiltIns,
  SOAPHTTPClient, SOAPHTTPTrans, WinInet,
  A000UMessaggi, QRPDFFilt;

type
  TS715FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel1: TPanel;
    BtnPrinterSetUp: TBitBtn;
    btnAnomalie: TBitBtn;
    BtnClose: TBitBtn;
    btnEsegui: TBitBtn;
    Panel2: TPanel;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    rgpTipoValutazione: TRadioGroup;
    edtDataDa: TMaskEdit;
    edtDataA: TMaskEdit;
    rgpStatoAvanzamento: TRadioGroup;
    btnStatoAvanzamento: TButton;
    edtStatoAvanzamento: TEdit;
    btnDataDa: TButton;
    btnDataA: TButton;
    Panel3: TPanel;
    chkChiudiScheda: TCheckBox;
    chkRiapriScheda: TCheckBox;
    chkLegendaPunteggi: TCheckBox;
    chkAggiornaIncentivi: TCheckBox;
    btnTipologieQuote: TButton;
    chkStampa: TCheckBox;
    chkAvanzaStato: TCheckBox;
    chkRetrocediStato: TCheckBox;
    chkAggiornaPunteggi: TCheckBox;
    chkAssegnaValutatore: TCheckBox;
    chkPresaVisione: TCheckBox;
    chkSostituisciRegola: TCheckBox;
    chkControllaRegola: TCheckBox;
    chkFilePDF: TCheckBox;
    chkProtocolla: TCheckBox;
    rgpTipoChiusura: TRadioGroup;
    rgpPresaVisione: TRadioGroup;
    rgpSchedeProtocollo: TRadioGroup;
    rgpDipValutabile: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataAExit(Sender: TObject);
    procedure btnTipologieQuoteClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure chkStampaClick(Sender: TObject);
    procedure btnStatoAvanzamentoClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnDataAClick(Sender: TObject);
    procedure edtDataDaDblClick(Sender: TObject);
    procedure edtDataADblClick(Sender: TObject);
  private
    lstLegendaPunteggi,lstPresaVisione: TStringList;
    SoloAggiornamento,AggiornamentoEseguito,PresenzaAnomalie,CalcoloPFP,
    SchedaProtocollata,EsisteStatoProtocollato,EsisteStatoChiuso:Boolean;
    CodTipoQuota:String;
    SchedeProtocollate:Integer;
    FconnectTimeoutMS,FsendTimeoutMS,FreceiveTimeoutMS:Integer;
    { Private declarations }
    function ProprietaArea(CodArea:String;Data:TDateTime;Campo:String):String;
    function FormattaAnomalie(Sender:TCheckBox;Messaggio:String): String;
    function SchedeCollegateAperte(var Msg:String): Boolean;
    function SchedeCollegateChiuse(var Msg:String): Boolean;
    function AnomaliaRangePesoArea(var Msg:String): Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneDipendenti;
    procedure ScorriSchede;
    procedure AssegnaValutatore;
    procedure AggiornaPunteggi;
    procedure AvanzaStato;
    procedure ChiudiScheda;
    procedure RiapriScheda;
    procedure RetrocediStato;
    procedure AggiornaIncentivi;
    procedure Stampa;
    procedure FilePDF;
    procedure Protocolla;
    function GetNomeFilePDF: string;
    procedure configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
  public
    { Public declarations }
    ListaTipologieQuote:String;
    DataRif: TDateTime;
    DocumentoPDF,TipoModulo,MessaggioDCOM: String;
    procedure AbilitaComponenti;
  end;

var
  S715FDialogStampa: TS715FDialogStampa;

procedure OpenS715FStampaValutazioni(Prog:LongInt;DataIni,DataFin:TDateTime;TipoVal:String);

implementation

uses S715UStampaValutazioni, S715UStampaValutazioniDtM, S715UProtocolloService;

{$R *.DFM}
var
  DataI,DataF:TDateTime;

procedure OpenS715FStampaValutazioni(Prog:LongInt;DataIni,DataFin:TDateTime;TipoVal:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS715FStampaValutazioni') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S715FDialogStampa:=TS715FDialogStampa.Create(nil);
  DataI:=DataIni;
  DataF:=DataFin;
  if TipoVal = 'A' then
    S715FDialogStampa.rgpTipoValutazione.ItemIndex:=1
  else
    S715FDialogStampa.rgpTipoValutazione.ItemIndex:=0;
  with S715FDialogStampa do
    try
      C700Progressivo:=Prog;
      S715FStampaValutazioniDtM:=TS715FStampaValutazioniDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      S715FStampaValutazioniDtM.Free;
      Free;
    end;
end;

procedure TS715FDialogStampa.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  S715FStampaValutazioni:=TS715FStampaValutazioni.Create(nil);
  lstLegendaPunteggi:=TStringList.Create;
  lstPresaVisione:=TStringList.Create;
end;

procedure TS715FDialogStampa.FormShow(Sender: TObject);
begin
  chkAssegnaValutatore.Visible:=S715FStampaValutazioniDtM.S715FStampaValutazioniMW.CanAssegnaValutatore;
  chkSostituisciRegola.Visible:=chkAssegnaValutatore.Visible;
  chkProtocolla.Visible:=S715FStampaValutazioniDtM.S715FStampaValutazioniMW.CanProtocolla;
  CreaC004(SessioneOracle,'S715',Parametri.ProgOper);
  GetParametriFunzione;
  //Abilitazioni controlli
  AbilitaComponenti;
  //
  if (DataI = 0) and (DataF = 0) then
  begin
    DataI:=Parametri.DataLavoro;
    DataF:=Parametri.DataLavoro;
    C700DataDal:=Parametri.DataLavoro;
    C700DataLavoro:=Parametri.DataLavoro;
  end
  else
  begin
    C700DataDal:=DataI;
    C700DataLavoro:=DataF;
  end;
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataI);
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataF);
  //TEMPdario da qui .prima ok su cloud

  C700DatiVisualizzati:='MATRICOLA,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + S715FStampaValutazioniDtM.S715FStampaValutazioniMW.CampiAggiuntiviC700(C700CampiBase);
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
  frmSelAnagrafe.VisualizzaDipendente;
  frmSelAnagrafe.NumRecords;
  //
  btnAnomalie.Enabled:=False;
end;

procedure TS715FDialogStampa.FormDestroy(Sender: TObject);
begin
  C004FParamForm.Free;
  FreeAndNil(S715FStampaValutazioni);
  FreeAndNil(lstLegendaPunteggi);
  FreeAndNil(lstPresaVisione);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TS715FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpTipoValutazione.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpTipoValutazione',''),2);
  rgpTipoChiusura.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpTipoChiusura',''),3);
  rgpStatoAvanzamento.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpStatoAvanzamento',''),0);
  edtStatoAvanzamento.Text:=C004FParamForm.GetParametro('edtStatoAvanzamento','');
  rgpPresaVisione.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpPresaVisione',''),3);
  rgpSchedeProtocollo.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpSchedeProtocollo',''),2);
  rgpDipValutabile.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('rgpDipValutabile',''),2);
  chkAssegnaValutatore.Checked:=(C004FParamForm.GetParametro('chkAssegnaValutatore','') = 'S');
  chkControllaRegola.Checked:=(C004FParamForm.GetParametro('chkControllaRegola','') = 'S');
  chkSostituisciRegola.Checked:=(C004FParamForm.GetParametro('chkSostituisciRegola','') = 'S');
  chkAggiornaPunteggi.Checked:=(C004FParamForm.GetParametro('chkAggiornaPunteggi','') = 'S');
  chkAvanzaStato.Checked:=(C004FParamForm.GetParametro('chkAvanzaStato','') = 'S');
  chkChiudiScheda.Checked:=(C004FParamForm.GetParametro('chkChiudiScheda','') = 'S');
  chkRiapriScheda.Checked:=(C004FParamForm.GetParametro('chkRiapriScheda','') = 'S');
  chkRetrocediStato.Checked:=(C004FParamForm.GetParametro('chkRetrocediStato','') = 'S');
  chkAggiornaIncentivi.Checked:=(C004FParamForm.GetParametro('chkAggiornaIncentivi','') = 'S');
  chkStampa.Checked:=(C004FParamForm.GetParametro('chkStampa','') = 'S');
  chkFilePDF.Checked:=(C004FParamForm.GetParametro('chkFilePDF','') = 'S');
  chkProtocolla.Checked:=(C004FParamForm.GetParametro('chkProtocolla','') = 'S');
  chkLegendaPunteggi.Checked:=(C004FParamForm.GetParametro('chkLegendaPunteggi','') = 'S');
  chkPresaVisione.Checked:=(C004FParamForm.GetParametro('chkPresaVisione','') = 'S');
end;

procedure TS715FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('rgpTipoValutazione',IntToStr(rgpTipoValutazione.ItemIndex));
  C004FParamForm.PutParametro('rgpTipoChiusura',IntToStr(rgpTipoChiusura.ItemIndex));
  C004FParamForm.PutParametro('rgpStatoAvanzamento',IntToStr(rgpStatoAvanzamento.ItemIndex));
  C004FParamForm.PutParametro('edtStatoAvanzamento',edtStatoAvanzamento.Text);
  C004FParamForm.PutParametro('rgpPresaVisione',IntToStr(rgpPresaVisione.ItemIndex));
  C004FParamForm.PutParametro('rgpSchedeProtocollo',IntToStr(rgpSchedeProtocollo.ItemIndex));
  C004FParamForm.PutParametro('rgpDipValutabile',IntToStr(rgpDipValutabile.ItemIndex));
  C004FParamForm.PutParametro('chkAssegnaValutatore',IfThen(chkAssegnaValutatore.Checked,'S','N'));
  C004FParamForm.PutParametro('chkControllaRegola',IfThen(chkControllaRegola.Checked,'S','N'));
  C004FParamForm.PutParametro('chkSostituisciRegola',IfThen(chkSostituisciRegola.Checked,'S','N'));
  C004FParamForm.PutParametro('chkAggiornaPunteggi',IfThen(chkAggiornaPunteggi.Checked,'S','N'));
  C004FParamForm.PutParametro('chkAvanzaStato',IfThen(chkAvanzaStato.Checked,'S','N'));
  C004FParamForm.PutParametro('chkChiudiScheda',IfThen(chkChiudiScheda.Checked,'S','N'));
  C004FParamForm.PutParametro('chkRiapriScheda',IfThen(chkRiapriScheda.Checked,'S','N'));
  C004FParamForm.PutParametro('chkRetrocediStato',IfThen(chkRetrocediStato.Checked,'S','N'));
  C004FParamForm.PutParametro('chkAggiornaIncentivi',IfThen(chkAggiornaIncentivi.Checked,'S','N'));
  C004FParamForm.PutParametro('chkStampa',IfThen(chkStampa.Checked,'S','N'));
  C004FParamForm.PutParametro('chkFilePDF',IfThen(chkFilePDF.Checked,'S','N'));
  C004FParamForm.PutParametro('chkProtocolla',IfThen(chkProtocolla.Checked,'S','N'));
  C004FParamForm.PutParametro('chkLegendaPunteggi',IfThen(chkLegendaPunteggi.Checked,'S','N'));
  C004FParamForm.PutParametro('chkPresaVisione',IfThen(chkPresaVisione.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TS715FDialogStampa.AbilitaComponenti;
begin
  edtStatoAvanzamento.Enabled:=rgpStatoAvanzamento.ItemIndex = 1;
  btnStatoAvanzamento.Enabled:=edtStatoAvanzamento.Enabled;
  chkControllaRegola.Enabled:=not chkAggiornaPunteggi.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkAggiornaIncentivi.Checked and not chkProtocolla.Checked and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkControllaRegola.Enabled then
    chkControllaRegola.Checked:=False;
  chkSostituisciRegola.Enabled:=not SolaLettura and chkControllaRegola.Enabled and chkControllaRegola.Checked and chkSostituisciRegola.Visible;
  if not chkSostituisciRegola.Enabled then
    chkSostituisciRegola.Checked:=False;
  chkAggiornaPunteggi.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRetrocediStato.Checked and not chkProtocolla.Checked and (chkAssegnaValutatore.Visible or not R180In(rgpTipoChiusura.ItemIndex,[1,2])) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkAggiornaPunteggi.Enabled then
    chkAggiornaPunteggi.Checked:=False;
  chkAssegnaValutatore.Enabled:=not SolaLettura and chkAggiornaPunteggi.Enabled and chkAggiornaPunteggi.Checked and chkAssegnaValutatore.Visible;
  if not chkAssegnaValutatore.Enabled then
    chkAssegnaValutatore.Checked:=False;
  chkAvanzaStato.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and (not chkAggiornaIncentivi.Checked or chkChiudiScheda.Checked) and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkAvanzaStato.Enabled then
    chkAvanzaStato.Checked:=False;
  chkChiudiScheda.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkChiudiScheda.Enabled then
    chkChiudiScheda.Checked:=False;
  chkRiapriScheda.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkAggiornaIncentivi.Checked and not chkFilePDF.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkRiapriScheda.Enabled then
    chkRiapriScheda.Checked:=False;
  chkRetrocediStato.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkAggiornaPunteggi.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkAggiornaIncentivi.Checked and not chkFilePDF.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkRetrocediStato.Enabled then
    chkRetrocediStato.Checked:=False;
  chkAggiornaIncentivi.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and (rgpTipoValutazione.ItemIndex <> 1) and (not chkAvanzaStato.Checked or chkChiudiScheda.Checked) and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpDipValutabile.ItemIndex <> 1);
  if not chkAggiornaIncentivi.Enabled then
    chkAggiornaIncentivi.Checked:=False;
  btnTipologieQuote.Visible:=chkAggiornaIncentivi.Checked;
  chkStampa.Enabled:=not chkFilePDF.Checked and not chkProtocolla.Checked;
  if not chkStampa.Enabled then
    chkStampa.Checked:=False;
  chkFilePDF.Enabled:=not chkRetrocediStato.Checked and not chkRiapriScheda.Checked and not chkStampa.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]);
  if not chkFilePDF.Enabled then
    chkFilePDF.Checked:=False;
  chkLegendaPunteggi.Visible:=chkStampa.Checked or chkFilePDF.Checked;
  chkPresaVisione.Visible:=chkStampa.Checked or chkFilePDF.Checked;
  chkProtocolla.Enabled:=chkProtocolla.Visible and not SolaLettura and not chkControllaRegola.Checked and not chkAggiornaPunteggi.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkAggiornaIncentivi.Checked and not chkStampa.Checked and not chkFilePDF.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkProtocolla.Enabled then
    chkProtocolla.Checked:=False;
  btnEsegui.Enabled:=chkControllaRegola.Checked or chkSostituisciRegola.Checked or chkAggiornaPunteggi.Checked or chkAssegnaValutatore.Checked or chkAvanzaStato.Checked or chkRetrocediStato.Checked or chkChiudiScheda.Checked or chkRiapriScheda.Checked or chkAggiornaIncentivi.Checked or chkStampa.Checked or chkFilePDF.Checked or chkProtocolla.Checked;
end;

procedure TS715FDialogStampa.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=DataI;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TS715FDialogStampa.edtDataDaDblClick(Sender: TObject);
begin
  edtDataDa.Text:='01/01' + Copy(edtDataDa.Text,6);
end;

procedure TS715FDialogStampa.edtDataDaExit(Sender: TObject);
begin
  try
    DataI:=StrToDate((Sender as TMaskEdit).Text);
    C700DataDal:=DataI;
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create('Indicare una data valida!');
  end;
end;

procedure TS715FDialogStampa.edtDataADblClick(Sender: TObject);
begin
  edtDataA.Text:='31/12' + Copy(edtDataA.Text,6);
end;

procedure TS715FDialogStampa.edtDataAExit(Sender: TObject);
begin
  try
    DataF:=StrToDate((Sender as TMaskEdit).Text);
    C700DataLavoro:=DataF;
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create('Indicare una data valida!');
  end;
end;

procedure TS715FDialogStampa.btnStatoAvanzamentoClick(Sender: TObject);
var
  listSG746: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      listSG746:=S715FStampaValutazioniDtM.S715FStampaValutazioniMW.ListSG746;
      clbListaDati.Items.assign(listSG746.lstDescrizione);

      R180PutCheckList(edtStatoAvanzamento.Text,7,clbListaDati);
      ShowModal;
    end;
  finally
    edtStatoAvanzamento.Text:=Trim(R180GetCheckList(7,C013FCheckList.clbListaDati));
    FreeAndNil(listSG746);
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TS715FDialogStampa.btnTipologieQuoteClick(Sender: TObject);
var
  elencoTipologieQuote: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      clbListaDati.Items.Clear;
      elencoTipologieQuote:=S715FStampaValutazioniDtM.S715FStampaValutazioniMW.ListTipologieQuote;
      clbListaDati.Items.Assign(elencoTipologieQuote.lstDescrizione);
      R180PutCheckList(ListaTipologieQuote,5,clbListaDati);
      ShowModal;
    end;
  finally
    FreeAndNil(elencoTipologieQuote);
    if C013FCheckList.ModalResult = mrOk then
      ListaTipologieQuote:=Trim(R180GetCheckList(5,C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
  AbilitaComponenti;
end;

procedure TS715FDialogStampa.btnDataDaClick(Sender: TObject);
begin
  DataI:=DataOut(StrToDate(edtDataDa.Text),'Dalla data','G');
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataI);
  C700DataDal:=DataI;
end;

procedure TS715FDialogStampa.btnDataAClick(Sender: TObject);
begin
  DataF:=DataOut(StrToDate(edtDataA.Text),'Alla data','G');
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataF);
  C700DataLavoro:=DataF;
end;

procedure TS715FDialogStampa.chkStampaClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TS715FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(S715FStampaValutazioni.QRep);
end;

procedure TS715FDialogStampa.btnEseguiClick(Sender: TObject);
begin
  btnAnomalie.Enabled:=False;

  RegistraMsg.IniziaMessaggio(ifThen(TipoModulo = 'CS','S715','WS715'));
  SoloAggiornamento:=not chkStampa.Checked;
  AggiornamentoEseguito:=False;
  SchedeProtocollate:=0;
  if DataI > DataF then
    raise Exception.Create('La data iniziale deve essere minore o uguale a quella finale!');
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create('Selezionare almeno un dipendente!');
  if chkAggiornaIncentivi.Checked and (ListaTipologieQuote = '') then
    raise Exception.Create(A000MSG_S715_ERR_NO_TIPO_QUOTA);
  if (rgpStatoAvanzamento.ItemIndex = 1) and (edtStatoAvanzamento.Text = '') then
    raise Exception.Create(A000MSG_S715_ERR_NO_STATO_AVANZAMENTO);
  if TipoModulo = 'CS' then
  begin
    if (   chkControllaRegola.Checked
        or chkSostituisciRegola.Checked
        or chkAggiornaPunteggi.Checked
        or chkAssegnaValutatore.Checked
        or chkAvanzaStato.Checked
        or chkChiudiScheda.Checked
        or chkRiapriScheda.Checked
        or chkRetrocediStato.Checked
        or chkAggiornaIncentivi.Checked
        or chkFilePDF.Checked
        or chkProtocolla.Checked)
    and (R180MessageBox(Format(A000MSG_S715_DLG_FMT_CONFERMA_ESEGUI,[IfThen(chkControllaRegola.Checked,CRLF + ' - ' + chkControllaRegola.Caption) +
                                                                    IfThen(chkSostituisciRegola.Checked,CRLF + ' - ' + chkSostituisciRegola.Caption) +
                                                                    IfThen(chkAggiornaPunteggi.Checked,CRLF + ' - ' + chkAggiornaPunteggi.Caption) +
                                                                    IfThen(chkAssegnaValutatore.Checked,CRLF + ' - ' + chkAssegnaValutatore.Caption) +
                                                                    IfThen(chkAvanzaStato.Checked,CRLF + ' - ' + chkAvanzaStato.Caption) +
                                                                    IfThen(chkChiudiScheda.Checked,CRLF + ' - ' + chkChiudiScheda.Caption) +
                                                                    IfThen(chkRiapriScheda.Checked,CRLF + ' - ' + chkRiapriScheda.Caption) +
                                                                    IfThen(chkRetrocediStato.Checked,CRLF + ' - ' + chkRetrocediStato.Caption) +
                                                                    IfThen(chkAggiornaIncentivi.Checked,CRLF + ' - ' + chkAggiornaIncentivi.Caption) +
                                                                    IfThen(chkStampa.Checked,CRLF + ' - ' + chkStampa.Caption) +
                                                                    IfThen(chkFilePDF.Checked,CRLF + ' - ' + chkFilePDF.Caption) +
                                                                    IfThen(chkProtocolla.Checked,CRLF + ' - ' + chkProtocolla.Caption)]),DOMANDA) <> mrYes) then
      exit;
  end;
  if TipoModulo = 'CS' then
    PutParametriFunzione;
  MessaggioDCOM:='';
  ElaborazioneDipendenti;
end;

procedure TS715FDialogStampa.ElaborazioneDipendenti;
var MsgProtocollazione:String;
  Msg:String;
begin
  //Svuoto i ClientDataSet utili alla stampa
  S715FStampaValutazioniDtM.cdsStampaAnagrafico.EmptyDataSet;
  S715FStampaValutazioniDtM.cdsStampaElementi.EmptyDataSet;
  S715FStampaValutazioniDtM.selSG745.Close;
  S715FStampaValutazioniDtM.selSG745.Open;
  Screen.Cursor:=crHourGlass;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
    C700SelAnagrafe.CloseAll;
  C700SelAnagrafe.Open;
  frmSelAnagrafe.VisualizzaDipendente;
  frmSelAnagrafe.NumRecords;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.Eof do
    try
      frmSelAnagrafe.VisualizzaDipendente;
      ScorriSchede;
    finally
      ProgressBar1.StepBy(1);
      C700SelAnagrafe.Next;
    end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if SoloAggiornamento then
  begin
    if chkProtocolla.Checked then
      MsgProtocollazione:=Format('Schede protocollate: %d' + CRLF,[SchedeProtocollate]);
    if btnAnomalie.Enabled then
    begin
      if TipoModulo = 'CS' then
      begin
        if (R180MessageBox(MsgProtocollazione + 'Elaborazione terminata con anomalie. Si desidera visualizzarle?','DOMANDA') = mrYes) then
          btnAnomalieClick(nil);
      end
      else
        MessaggioDCOM:=MsgProtocollazione;
    end
    else if AggiornamentoEseguito then
    begin
      if TipoModulo = 'CS' then
        R180MessageBox(MsgProtocollazione + 'Elaborazione terminata','INFORMA')
      else
        MessaggioDCOM:=MsgProtocollazione;
    end
    else if chkControllaRegola.Checked and not chkSostituisciRegola.Checked then
    begin
      if TipoModulo = 'CS' then
        R180MessageBox('Controllo terminato','INFORMA')
    end
    else
    begin
      Msg:='Non sono stati trovati dati da elaborare in base ai filtri selezionati';
      if TipoModulo = 'CS' then
        R180MessageBox(Msg,'INFORMA')
      else
        raise Exception.Create(Msg);
    end;
  end
  else
  begin
    if S715FStampaValutazioniDtM.cdsStampaAnagrafico.RecordCount > 0 then
    begin
      S715FStampaValutazioniDtM.cdsStampaElementi.Filtered:=True;
      S715FStampaValutazioniDtM.cdsStampaAnagrafico.First;
      S715FStampaValutazioni.LEnte.Caption:=Parametri.RagioneSociale;
      Screen.Cursor:=crDefault;
      if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
      begin
        S715FStampaValutazioni.QRep.ShowProgress:=False;
        S715FStampaValutazioni.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
      end
      else
        S715FStampaValutazioni.QRep.Preview;

      S715FStampaValutazioniDtM.cdsStampaElementi.Filtered:=False;
    end;
    if btnAnomalie.Enabled then
    begin
      Application.ProcessMessages;
      if TipoModulo = 'CS' then
        if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?','DOMANDA') = mrYes) then
          btnAnomalieClick(nil);
    end
    else if S715FStampaValutazioniDtM.cdsStampaAnagrafico.RecordCount = 0 then
    begin
      Application.ProcessMessages;
      msg:='Non sono stati trovati dati da stampare in base ai filtri selezionati';
      if TipoModulo = 'CS' then
        R180MessageBox(Msg,'INFORMA')
      else
        raise Exception.Create(Msg);
    end;
  end;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
end;

procedure TS715FDialogStampa.ScorriSchede;
var
  TipoVal,TipoChiuso,DipValutabile,CampiDaEstrarre,ScalaPnt,Dato:String;
  RegoleTrovate:Boolean;
begin
  if rgpTipoValutazione.ItemIndex = 0 then
    TipoVal:='''V'''
  else if rgpTipoValutazione.ItemIndex = 1 then
    TipoVal:='''A'''
  else if rgpTipoValutazione.ItemIndex = 2 then
    TipoVal:='''A'',''V''';
  if rgpTipoChiusura.ItemIndex = 0 then
    TipoChiuso:='''N'''
  else if rgpTipoChiusura.ItemIndex = 1 then
    TipoChiuso:='''B'''
  else if rgpTipoChiusura.ItemIndex = 2 then
    TipoChiuso:='''S'''
  else if rgpTipoChiusura.ItemIndex = 3 then
    TipoChiuso:='''N'',''B'',''S''';
  if rgpDipValutabile.ItemIndex = 0 then
    DipValutabile:='''S'''
  else if rgpDipValutabile.ItemIndex = 1 then
    DipValutabile:='''N'''
  else if rgpDipValutabile.ItemIndex = 2 then
    DipValutabile:='''S'',''N''';
  with S715FStampaValutazioniDtM do
  begin
    with selSG710 do
    begin
      Close;
      SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('D_INI',DataI);
      SetVariable('D_FIN',DataF);
      SetVariable('TIPO_VAL',TipoVal);
      //Non posso inserire i filtri direttamente nel dataset perché devo spostarmi da uno stato all'altro in caso di avanza stato e retrocedi stato
      Open;
    end;
    //Recupero i campi da estrarre
    CampiDaEstrarre:=',T430INIZIO,T430FINE,';
    if (Parametri.CampiRiferimento.C21_ValutazioniRsp1 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniRsp2 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp2 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp2 + ',';
    if (Parametri.CampiRiferimento.C21_ValutazioniPnt1 <> '')
    and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1 + ',',',' + CampiDaEstrarre) = 0) then
      CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1 + ',';
    if chkAggiornaIncentivi.Checked then
    begin
      if (Parametri.CampiRiferimento.C7_Dato1 <> '')
      and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C7_Dato1 + ',',',' + CampiDaEstrarre) = 0) then
        CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C7_Dato1 + ',';
      if (Parametri.CampiRiferimento.C7_Dato2 <> '')
      and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C7_Dato2 + ',',',' + CampiDaEstrarre) = 0) then
        CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C7_Dato2 + ',';
      if (Parametri.CampiRiferimento.C7_Dato3 <> '')
      and (Pos(',' + 'T430' + Parametri.CampiRiferimento.C7_Dato3 + ',',',' + CampiDaEstrarre) = 0) then
        CampiDaEstrarre:=CampiDaEstrarre + 'T430' + Parametri.CampiRiferimento.C7_Dato3 + ',';
    end;
    if chkStampa.Checked or chkFilePDF.Checked then
      with selSG741 do
      begin
        Close;
        ClearVariables;
        Open;
        while not Eof do
        begin
          if (FieldByName('DATO_STAMPA_1').AsString <> '')
          and (FieldByName('DATO_STAMPA_1').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_1').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_1').AsString + ',';
          if (FieldByName('DESC_LUNGA_1').AsString = 'N')
          and (FieldByName('DATO_STAMPA_2').AsString <> '')
          and (FieldByName('DATO_STAMPA_2').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_2').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_2').AsString + ',';
          if (FieldByName('DATO_STAMPA_3').AsString <> '')
          and (FieldByName('DATO_STAMPA_3').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_3').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_3').AsString + ',';
          if (FieldByName('DESC_LUNGA_3').AsString = 'N')
          and (FieldByName('DATO_STAMPA_4').AsString <> '')
          and (FieldByName('DATO_STAMPA_4').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_4').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_4').AsString + ',';
          if (FieldByName('DATO_STAMPA_5').AsString <> '')
          and (FieldByName('DATO_STAMPA_5').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_5').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_5').AsString + ',';
          if (FieldByName('DESC_LUNGA_5').AsString = 'N')
          and (FieldByName('DATO_STAMPA_6').AsString <> '')
          and (FieldByName('DATO_STAMPA_6').AsString <> OpzioneFirma6)
          and (Pos(',' + FieldByName('DATO_STAMPA_6').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_STAMPA_6').AsString + ',';
          if (FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString <> '')
          and (Pos(',' + FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString + ',';
          Next;
        end;
      end;
    if chkProtocolla.Checked then
      with S715FStampaValutazioniMW.selSG751 do
      begin
        Close;
        ClearVariables;
        Open;
        while not Eof do
        begin
          Dato:=S715FStampaValutazioniMW.GetDatoAnagraficoProtocollo(FieldByName('TIPO').AsString,FieldByName('DATO').AsString);
          if R180In(Copy(Dato,1,4),['T430','P430'])
          and (Pos(',' + Dato + ',',',' + CampiDaEstrarre) = 0) then
            CampiDaEstrarre:=CampiDaEstrarre + Dato + ',';
          Next;
        end;
      end;
    CampiDaEstrarre:=Copy(CampiDaEstrarre,2,Length(CampiDaEstrarre)-2);
    QSGruppoValutatore.GetDatiStorici(CampiDaEstrarre,C700Progressivo,EncodeDate(1900,1,1),EncodeDate(3999,12,31));
    RegoleTrovate:=True;
    while not selSG710.Eof do
    begin
      SchedaProtocollata:=not selSG710.FieldByName('NUMERO_PROTOCOLLO').IsNull
                       or not selSG710.FieldByName('ANNO_PROTOCOLLO').IsNull
                       or not selSG710.FieldByName('DATA_PROTOCOLLO').IsNull;
      //Apro tutti gli stati della scheda //Non uso l'R180SetVariable perché devo avere la situazione aggiornata all'inizio di ogni giro sul nuovo stato
      selSG710c.Close;
      selSG710c.SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      selSG710c.SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      selSG710c.SetVariable('TIPO_VALUTAZIONE',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      selSG710c.Open;
      selSG710c.Last;//Mi posiziono sull'ultimo stato
      EsisteStatoChiuso:=selSG710c.FieldByName('CHIUSO').AsString = 'S';
      EsisteStatoProtocollato:=selSG710c.FieldByName('SCHEDA_PROTOCOLLATA').AsString = 'S';
      //Mi posiziono sul periodo storico corretto
      QSGruppoValutatore.LocDatoStorico(selSG710.FieldByName('DATA').AsDateTime);
      DataRif:=selSG710.FieldByName('DATA').AsDateTime;
      if (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime <> 0)
      and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime < DataRif)
      and (QSGruppoValutatore.FieldByName('T430FINE').AsDateTime >= EncodeDate(R180Anno(DataRif),1,1)) then
        DataRif:=QSGruppoValutatore.FieldByName('T430FINE').AsDateTime;
      QSGruppoValutatore.LocDatoStorico(DataRif);
      //Prelevo le regole delle valutazioni
      RecuperaRegole(DataRif,selSG710.FieldByName('PROGRESSIVO').AsInteger,IfThen(chkControllaRegola.Checked,'',selSG710.FieldByName('CODREGOLA').AsString));
      if (selSG741.RecordCount = 0) and RegoleTrovate then
      begin
        RegoleTrovate:=False;
        RegistraMsg.InserisciMessaggio('A','Scheda ' + FormatDateTime(IfThen(selSG710.FieldByName('DATA').AsDateTime <> EncodeDate(R180Anno(selSG710.FieldByName('DATA').AsDateTime),12,31),'dd/mm/yyyy','yyyy'),selSG710.FieldByName('DATA').AsDateTime) + ': Regole non trovate, Data rif. ' + DateTimeToStr(DataRif),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        selSG710.Next;
        Continue;
      end;
      RegoleTrovate:=True;
      PresenzaAnomalie:=False;
      if selSG710.FieldByName('CODREGOLA').AsString <> selSG741.FieldByName('CODICE').AsString then
      begin
        //Registro la regola sulle schede vecchie o sovrascrivo quelle variate (a meno che la scheda non sia già stata protocollata)
        if ((selSG710.FieldByName('CODREGOLA').AsString = '') or chkSostituisciRegola.Checked)
        and not EsisteStatoProtocollato then
        begin
          selSG710.Edit;
          selSG710.FieldByName('CODREGOLA').AsString:=selSG741.FieldByName('CODICE').AsString;
          selSG710.Post;
          if chkSostituisciRegola.Checked then
            AggiornamentoEseguito:=True;
          SessioneOracle.Commit;
        end
        else if chkControllaRegola.Checked then
          RegistraMsg.InserisciMessaggio('B',FormattaAnomalie(chkControllaRegola,'Regola registrata: ' + selSG710.FieldByName('CODREGOLA').AsString + ', Regola calcolata: ' + selSG741.FieldByName('CODICE').AsString + ', Data rif. ' + DateTimeToStr(DataRif)),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        //In ogni caso mi baso sulla regola registrata in testata
        RecuperaRegole(DataRif,selSG710.FieldByName('PROGRESSIVO').AsInteger,selSG710.FieldByName('CODREGOLA').AsString);
      end;
      //Considero solo le schede...
      //...negli stati richiesti
      if (    (rgpStatoAvanzamento.ItemIndex = 0)
          and (StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo))
      or (    (rgpStatoAvanzamento.ItemIndex = 1)
          and not R180InConcat(selSG710.FieldByName('CODREGOLA').AsString + '.' + IntToStr(selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger),edtStatoAvanzamento.Text))
      //...col tipo chiusura richiesto
      or (    (rgpTipoChiusura.ItemIndex = 0)
          and (selSG710.FieldByName('CHIUSO').AsString <> 'N'))
      or (    (rgpTipoChiusura.ItemIndex = 1)
          and (selSG710.FieldByName('CHIUSO').AsString <> 'B'))
      or (    (rgpTipoChiusura.ItemIndex = 2)
          and (selSG710.FieldByName('CHIUSO').AsString <> 'S'))
      //...con valutabilità del dipendente richiesta
      or (    (rgpDipValutabile.ItemIndex = 0)
          and (selSG710.FieldByName('VALUTABILE').AsString <> 'S'))
      or (    (rgpDipValutabile.ItemIndex = 1)
          and (selSG710.FieldByName('VALUTABILE').AsString <> 'N'))
      //...con presa visione valutato richiesta
      or (    (rgpPresaVisione.ItemIndex = 0)
          and (selSG710.FieldByName('ESITO').AsString <> 'S'))
      or (    (rgpPresaVisione.ItemIndex = 1)
          and (selSG710.FieldByName('ESITO').AsString <> 'N'))
      or (    (rgpPresaVisione.ItemIndex = 2)
          and not selSG710.FieldByName('ESITO').IsNull)
      //...con protocollazione richiesta
      or (    (rgpSchedeProtocollo.ItemIndex = 0)
          and not SchedaProtocollata)
      or (    (rgpSchedeProtocollo.ItemIndex = 1)
          and SchedaProtocollata)
      then
      begin
        selSG710.Next;
        Continue;
      end;
      //Recupero gli stati alla giusta decorrenza
      with S715FStampaValutazioniMW.selSG746 do
      begin
        Close;
        SetVariable('DATARIF',DataRif);
        SetVariable('CAMPI_AGG',', VAL_INTERM_OBBLIGATORIA, CREA_AUTOVALUTAZIONE');
        Open;
      end;
      //Apro il dettaglio degli elementi
      with selSG711 do
      begin
        Close;
        SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
        SetVariable('TIPO_VAL',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
        SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
        Open;
      end;
      //Verifico se la scala dei punteggi concorre al calcolo del Punteggio finale pesato
      if QSGruppoValutatore.LocDatoStorico(DataRif) then
        try
          ScalaPnt:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniPnt1).AsString;
        except
          ScalaPnt:='*';
        end
      else
        ScalaPnt:='*';
      with selSG730 do
      begin
        Close;
        SetVariable('DATA_VAL',DataRif);
        SetVariable('DATO1',ScalaPnt);
        Open;
        if (RecordCount = 0) and (ScalaPnt <> '*') then
        begin
          ScalaPnt:='*';
          Close;
          SetVariable('DATO1',ScalaPnt);
          Open;
        end;
      end;
      CalcoloPFP:=(selSG730.RecordCount > 0) and (selSG730.FieldByName('CALCOLO_PFP').AsString = 'S');
      //Elaboro la scheda
      if chkAssegnaValutatore.Checked
      and not PresenzaAnomalie then
        AssegnaValutatore;
      if chkAggiornaPunteggi.Checked
      and not PresenzaAnomalie then
        AggiornaPunteggi;
      if chkAvanzaStato.Checked
      and not PresenzaAnomalie then
        AvanzaStato;
      if chkChiudiScheda.Checked
      and not PresenzaAnomalie then
        ChiudiScheda;
      if chkRiapriScheda.Checked
      and not PresenzaAnomalie then
        RiapriScheda;
      if chkRetrocediStato.Checked
      and not PresenzaAnomalie then
        RetrocediStato;
      if chkAggiornaIncentivi.Checked
      and not PresenzaAnomalie then
        AggiornaIncentivi;
      if chkStampa.Checked
      and not PresenzaAnomalie then
        Stampa;
      if chkFilePDF.Checked
      and not PresenzaAnomalie then
        FilePDF;
      if chkProtocolla.Checked
      and not PresenzaAnomalie then
        Protocolla;
      selSG710.Next;
    end;
  end;
end;

function TS715FDialogStampa.ProprietaArea(CodArea:String;Data:TDateTime;Campo:String):String;
begin
  Result:='';
  with S715FStampaValutazioniDtM do
  begin
    R180SetVariable(selSG701,'COD_AREA',CodArea);
    R180SetVariable(selSG701,'DATA',Data);
    with selSG701 do
    begin
      Open;
      if RecordCount > 0 then
      begin
        if Campo = 'RANGE_ITEM_PERSONALIZZATI' then
          Result:=IntToStr(FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger) + '#' + IntToStr(FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger)
        else if Campo = 'ITEM_PERSONALIZZATI' then
          Result:=IfThen(FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0,'S','N')
        else if Campo = 'TESTO_ITEM_PERSONALIZZATI' then
          Result:=FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString
        else if Campo = 'PESO_ITEM_MODIFICABILE' then
          Result:=FieldByName('PESO_VARIABILE_ITEMS').AsString
        else if Campo = 'PESO_ITEM_EQUO' then
          Result:=FieldByName('PESO_EQUO_ITEMS').AsString
        else if Campo = 'PUNTEGGI_CON_PERCENTUALE' then
          Result:=IfThen(FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString = '1','S','N')
        else if Campo = 'PUNTEGGI_CON_SOGLIA' then
          Result:=IfThen(FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString = '2','S','N')
        else if Campo = 'PUNTEGGI_ABILITATI' then
          Result:=IfThen(R180InConcat(selSG710.FieldByName('CODREGOLA').AsString + '.' + IntToStr(selSG711.FieldByName('STATO_AVANZAMENTO').AsInteger),FieldByName('STATI_ABILITATI_PUNTEGGI').AsString),'S','N')
        else if Campo = 'ELEMENTI_ABILITATI' then
          Result:=IfThen(R180InConcat(selSG710.FieldByName('CODREGOLA').AsString + '.' + IntToStr(selSG711.FieldByName('STATO_AVANZAMENTO').AsInteger),FieldByName('STATI_ABILITATI_ELEMENTI').AsString),'S','N')
        else if Campo = 'DESCRIZIONE' then
          Result:=FieldByName('DESCRIZIONE').AsString
        else if Campo = 'RANGE_PESO_AREA' then
          Result:=FloatToStr(FieldByName('PESO_PERC_MIN').AsFloat) + '#' + FloatToStr(FieldByName('PESO_PERC_MAX').AsFloat)
        else if Campo = 'PESO_AREA' then
          Result:=FloatToStr(FieldByName('PESO_PERCENTUALE').AsFloat)
        else if Campo = 'ITEM_TUTTI_VALUTABILI' then
          Result:=FieldByName('ITEM_TUTTI_VALUTABILI').AsString
        else if Campo = 'PUNTEGGI_SOLO_ITEM_VALUTABILI' then
          Result:=FieldByName('PUNTEGGI_SOLO_ITEM_VALUTABILI').AsString
        else if Campo = 'LINK_CONVOGLIA' then
          Result:=IfThen(FieldByName('TIPO_LINK_ITEM').AsString = '1','S','N')
        else if Campo = 'LINK_RIPORTA' then
          Result:=IfThen(FieldByName('TIPO_LINK_ITEM').AsString = '2','S','N')
        else if Campo = 'PESO_AREA_BASE_100' then
          Result:=IfThen(FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1','S','N');
      end;
    end;
  end;
end;

function TS715FDialogStampa.FormattaAnomalie(Sender:TCheckBox;Messaggio:String): String;
begin
  PresenzaAnomalie:=True;
  with S715FStampaValutazioniDtM do
    Result:=UpperCase(TCheckBox(Sender).Caption) + '; ' +
            IfThen(selSG710.FieldByName('DATA').AsDateTime <> EncodeDate(R180Anno(selSG710.FieldByName('DATA').AsDateTime),12,31),
                   'Data: ' + FormatDateTime('dd/mm/yyyy',selSG710.FieldByName('DATA').AsDateTime),
                   'Anno: ' + FormatDateTime('yyyy',selSG710.FieldByName('DATA').AsDateTime)) + '; ' +
            'Tipo: ' + IfThen(selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V','Valutazione','Autovalutazione') + '; ' +
            'Stato: ' + selSG710.FieldByName('CODREGOLA').AsString + '.' + selSG710.FieldByName('STATO_AVANZAMENTO').AsString + '; ' +
            IfThen((CodTipoQuota <> '') and (Pos('INCENTIVI',UpperCase(TCheckBox(Sender).Caption)) > 0),'Quota: ' + CodTipoQuota + '; ') +
            Messaggio;
end;

procedure TS715FDialogStampa.AssegnaValutatore;
var Valore,Valore2:String;
    ProgValutatore:Integer;
begin
  with S715FStampaValutazioniDtM do
  begin
    if not selSG710.FieldByName('PROGRESSIVI_VALUTATORI').IsNull then
      exit;
    ProgValutatore:=0;
    //Recupero il valutatore secondo la vecchia struttura SG705/SG706
    if selSG710.FieldByName('TIPO_VALUTAZIONE').AsString <> 'A' then
    begin
      //Estraggo il progressivo del valutatore, così se è diverso da quello dell'operatore ignoro la scheda
      selSG706.Close;
      selSG706.SetVariable('DATA',DataRif);
      selSG706.SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      selSG706.Open;
      if selSG706.RecordCount > 0 then
        ProgValutatore:=selSG706.FieldByName('PROGRESSIVO').AsInteger
      else
      begin
        //Mi posiziono sul periodo storico corretto per estrarre il valore del campo di riferimento
        if QSGruppoValutatore.LocDatoStorico(DataRif) then
        begin
          try
            Valore:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp1).AsString;
          except
            Valore:='';
          end;
          try
            Valore2:=QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C21_ValutazioniRsp2).AsString;
          except
            Valore2:='';
          end;
        end
        else
        begin
          Valore:='';
          Valore2:='';
        end;
        //Cerco il valutatore del dipendente tra gli abbinamenti per dato anagrafico con entrambi i livelli
        selSG705.Close;
        selSG705.SetVariable('DATO',Valore);
        selSG705.SetVariable('DATO2',Valore2);
        selSG705.SetVariable('DATA',DataRif);
        selSG705.Open;
        if selSG705.RecordCount > 0 then
          ProgValutatore:=selSG705.FieldByName('PROGRESSIVO').AsInteger
        else
        begin
          //Cerco il valutatore del dipendente tra gli abbinamenti per dato anagrafico con un livello
          selSG705.Close;
          selSG705.SetVariable('DATO',Valore);
          selSG705.SetVariable('DATO2',' ');
          selSG705.SetVariable('DATA',DataRif);
          selSG705.Open;
          if selSG705.RecordCount > 0 then
            ProgValutatore:=selSG705.FieldByName('PROGRESSIVO').AsInteger;
        end;
      end;
    end;
    selSG710.Edit;
    selSG710.FieldByName('PROGRESSIVI_VALUTATORI').AsString:=IntToStr(IfThen(selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A',selSG710.FieldByName('PROGRESSIVO').AsInteger,ProgValutatore));
    selSG710.Post;
    AggiornamentoEseguito:=True;
    SessioneOracle.Commit;
  end;
end;

procedure TS715FDialogStampa.AggiornaPunteggi;
var nItemSenzaPeso,nPrior,i,nItemValutabili,nDip:Integer;
  CodArea,CodAreaLink,CodItemLink,ElencoProg,Msg:String;
  TotPercArea,PercItem,TotVal,PesoItemNellArea,PunteggioLink:Real;
  wPesoAreaBase100:Boolean;
begin
  if not CalcoloPFP then
    exit;
  with S715FStampaValutazioniDtM do
  begin
    //Aggiorno soltanto le schede provvisorie (ad eccezione dell'utente MONDOEDP o SYSMAN)
    if not chkAssegnaValutatore.Visible then
    begin
      if EsisteStatoChiuso then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaPunteggi,'E'' già stata prodotta la scheda definitiva!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      if selSG710.FieldByName('CHIUSO').AsString = 'B' then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaPunteggi,'La scheda è bloccata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
    end;
    //Aggiorno soltanto le schede non protocollate
    if EsisteStatoProtocollato then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaPunteggi,'La scheda definitiva è già stata protocollata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Aggiorno i pesi e il punteggio pesato degli elementi
    with selSG711 do
    begin
      nItemSenzaPeso:=0;
      First;
      while not Eof do
      begin
        if FieldByName('PERC_VALUTAZIONE').IsNull then
          inc(nItemSenzaPeso);
        if (FieldByName('VALUTABILE').AsString = 'N')
        and (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_SOLO_ITEM_VALUTABILI') = 'S') then
        begin
          Edit;
          FieldByName('PUNTEGGIO').AsString:='';
          FieldByName('COD_PUNTEGGIO').AsString:='';
          FieldByName('NOTE_PUNTEGGIO').AsString:='';
          Post;
        end;
        Next;
      end;
      //Assegno i pesi agli elementi della scheda solo se ne sono tutti privi
      if nItemSenzaPeso = RecordCount then
      begin
        CodArea:='';
        TotPercArea:=0;
        First;
        while not Eof do
        begin
          if CodArea <> FieldByName('COD_AREA').AsString then
          begin
            //Assegno/Recupero il resto della divisione partendo dall'ultimo elemento dell'area
            nPrior:=0;
            while TotPercArea <> 0 do
            begin
              Prior;
              inc(nPrior);
              if FieldByName('VALUTABILE').AsString = 'S' then
              begin
                Edit;
                FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem + (0.00001 * IfThen(TotPercArea < 0,-1,1)),0.00001,'P');
                Post;
                TotPercArea:=R180Arrotonda(TotPercArea + (0.00001 * IfThen(TotPercArea < 0,1,-1)),0.00001,'P');
              end;
            end;
            //Mi riposiziono sul record da analizzare
            for i:=1 to nPrior do
              Next;
          end;
          if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_MODIFICABILE') = 'N' then
          begin
            if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_ITEM_EQUO') = 'S' then
            begin
              if CodArea <> FieldByName('COD_AREA').AsString then
              begin
                //Recupero il numero di elementi valutabili
                nItemValutabili:=0;
                selSG711c.Close;
                selSG711c.SetVariable('DATA',FieldByName('DATA').AsDateTime);
                selSG711c.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
                selSG711c.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
                selSG711c.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
                selSG711c.SetVariable('COD_AREA',FieldByName('COD_AREA').AsString);
                selSG711c.Open;
                while not selSG711c.Eof do
                begin
                  if selSG711c.FieldByName('VALUTABILE').AsString = 'S' then
                    inc(nItemValutabili);
                  selSG711c.Next;
                end;
                TotPercArea:=IfThen(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S',100,StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0));
                PercItem:=0;
                if nItemValutabili > 0 then
                  PercItem:=R180Arrotonda(TotPercArea / nItemValutabili,0.00001,'P')
                else
                  TotPercArea:=0;
              end;
              Edit;
              if FieldByName('VALUTABILE').AsString = 'S' then
              begin
                FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem,0.00001,'P');
                TotPercArea:=R180Arrotonda(TotPercArea - PercItem,0.00001,'P');
              end
              else
                FieldByName('PERC_VALUTAZIONE').AsFloat:=0;
              Post;
            end
            else
            begin
              selSG700.Filtered:=False;
              R180SetVariable(selSG700,'COD_AREA',FieldByName('COD_AREA').AsString);
              R180SetVariable(selSG700,'DATA',DataRif);
              selSG700.Open;
              Edit;
              FieldByName('PERC_VALUTAZIONE').AsFloat:=StrToFloatDef(VarToStr(selSG700.Lookup('COD_VALUTAZIONE',FieldByName('COD_VALUTAZIONE').AsString,'PESO_PERCENTUALE')),0);
              Post;
            end;
          end;
          CodArea:=FieldByName('COD_AREA').AsString;
          Next;
        end;
        //Assegno/Recupero il resto della divisione partendo dall'ultimo elemento dell'area
        while TotPercArea <> 0 do
        begin
          if FieldByName('VALUTABILE').AsString = 'S' then
          begin
            Edit;
            FieldByName('PERC_VALUTAZIONE').AsFloat:=R180Arrotonda(PercItem + (0.00001 * IfThen(TotPercArea < 0,-1,1)),0.00001,'P');
            Post;
            TotPercArea:=R180Arrotonda(TotPercArea + (0.00001 * IfThen(TotPercArea < 0,1,-1)),0.00001,'P');
          end;
          Prior;
        end;
      end;
      //Se la scheda non è già stata passata allo stato successivo, calcolo i punteggi degli elementi pilotati
      if (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'CODICE')) = '')
      and (selSG710.FieldByName('CHIUSO').AsString = 'N') then
      begin
        First;
        while not Eof do
        begin
          //Se ho tutte le condizioni, aggiorno i punteggi degli elementi pilotati
          if (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S')
          or (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S') then
          begin
            Edit;
            //Svuoto il punteggio
            FieldByName('PUNTEGGIO').AsString:='';
            FieldByName('COD_PUNTEGGIO').AsString:='';
            if not SchedeCollegateAperte(Msg) then
            begin
              PunteggioLink:=-1;
              ElencoProg:=',';
              nDip:=0;
              //Recupero gli elementi collegati
              selSG700.Filtered:=False;
              R180SetVariable(selSG700,'COD_AREA',FieldByName('COD_AREA').AsString);
              R180SetVariable(selSG700,'DATA',DataRif);
              selSG700.Open;
              if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then
              begin
                selSG700.Filter:='COD_VALUTAZIONE = ''' + FieldByName('COD_VALUTAZIONE').AsString + '''';
                selSG700.Filtered:=True;
              end;
              selSG700.First;
              //Per ogni elemento collegato...
              while not selSG700.Eof do
              begin
                CodAreaLink:=selSG700.FieldByName('COD_AREA_LINK').AsString;
                CodItemLink:=selSG700.FieldByName('COD_VALUTAZIONE_LINK').AsString;
                //Gestione Tipo link Riporta
                if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then
                begin
                  //...faccio la media dei punteggi assegnati agli altri dipendenti
                  //...e poi la pondero sul peso dell'elemento nell'area del dipendente corrente
                  //Danilo 17/10/2012: Per coerenza dovrebbe funzionare così anche il Tipo link Convoglia, senza il selSG700.Filter, ma ad AOSTA_REGIONE vogliono diversamente
                  selSG711a.Close;
                  selSG711a.SetVariable('DATA',FieldByName('DATA').AsDateTime);
                  //selSG711a.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
                  selSG711a.SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
                  selSG711a.SetVariable('COD_AREA',CodAreaLink);
                  selSG711a.SetVariable('COD_VALUTAZIONE',CodItemLink);
                  selSG711a.Open;
                  if not selSG711a.FieldByName('PUNTEGGIO_MEDIO').IsNull then
                  (*Danilo 17/10/2012 begin
                    if ProprietaArea(Q711.FieldByName('COD_AREA').AsString,DataRif,'LINK_RIPORTA') = 'S' then*)
                      PunteggioLink:=R180Arrotonda(selSG711a.FieldByName('PUNTEGGIO_MEDIO').AsFloat,0.01,'P')
                    (*Danilo 17/10/2012 else
                    begin
                      if PunteggioLink = -1 then
                        PunteggioLink:=0;
                      PunteggioLink:=PunteggioLink + R180Arrotonda(selSG711a.FieldByName('PUNTEGGIO_MEDIO').AsFloat * selSG700.FieldByName('PESO_PERCENTUALE').AsFloat / 100,0.01,'P');
                    end;
                  end;*)
                end
                //Gestione Tipo link Convoglia
                else if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S' then
                begin
                  //...sommo la ponderazione del punteggio sulle schede degli altri dipendenti
                  //...e poi la divido per il numero di dipendenti trovati, senza ponderare ulteriormente
                  //Danilo 17/10/2012: Per coerenza dovrebbe funzionare come il Tipo link Riporta, senza il selSG700.Filter, ma ad AOSTA_REGIONE vogliono diversamente
                  selSG711b.Close;
                  selSG711b.SetVariable('DATA',FieldByName('DATA').AsDateTime);
                  //selSG711b.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
                  selSG711b.SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
                  selSG711b.SetVariable('COD_AREA',CodAreaLink);
                  selSG711b.SetVariable('COD_VALUTAZIONE',CodItemLink);
                  selSG711b.Open;
                  while not selSG711b.Eof do
                  begin
                    if PunteggioLink = -1 then
                      PunteggioLink:=0;
                    PunteggioLink:=PunteggioLink + R180Arrotonda(selSG711b.FieldByName('RAGG').AsFloat,0.01,'P');
                    if not R180InConcat(selSG711b.FieldByName('PROGRESSIVO').AsString,ElencoProg) then
                    begin
                      ElencoProg:=ElencoProg + selSG711b.FieldByName('PROGRESSIVO').AsString + ',';
                      inc(nDip);
                    end;
                    selSG711b.Next;
                  end;
                end;
                selSG700.Next;
              end;
              selSG700.Filtered:=False;
              if PunteggioLink <> -1 then
              begin
                if nDip > 0 then
                  PunteggioLink:=R180Arrotonda(PunteggioLink / nDip,0.01,'P');
                FieldByName('PUNTEGGIO').AsFloat:=PunteggioLink;
              end;
            end;
            Post;
          end;
          Next;
        end;
      end;
      //Aggiorno i punteggi pesati degli elementi
      CodArea:='';
      TotVal:=0;
      First;
      while not Eof do
      begin
        if CodArea <> FieldByName('COD_AREA').AsString then
        begin
          //Calcolo il peso dell'area
          TotPercArea:=0;
          wPesoAreaBase100:=ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S';
          if wPesoAreaBase100 then
            TotPercArea:=StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0)
          else
          begin
            selSG711c.Close;
            selSG711c.SetVariable('DATA',FieldByName('DATA').AsDateTime);
            selSG711c.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
            selSG711c.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
            selSG711c.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
            selSG711c.SetVariable('COD_AREA',FieldByName('COD_AREA').AsString);
            selSG711c.Open;
            while not selSG711c.Eof do
            begin
              TotPercArea:=R180Arrotonda(TotPercArea + selSG711c.FieldByName('PERC_VALUTAZIONE').AsFloat,0.00001,'P');
              selSG711c.Next;
            end;
          end;
        end;
        Edit;
        if (TotPercArea <> 0)
        and (FieldByName('VALUTABILE').AsString = 'S') then
        begin
          PesoItemNellArea:=IfThen(wPesoAreaBase100,FieldByName('PERC_VALUTAZIONE').AsFloat,R180Arrotonda(FieldByName('PERC_VALUTAZIONE').AsFloat * 100 / TotPercArea,0.00001,'P'));
          FieldByName('PUNTEGGIO_PESATO').AsFloat:=R180Arrotonda((FieldByName('PUNTEGGIO').AsFloat * PesoItemNellArea / 100) * TotPercArea / 100,0.00001,'P');
        end
        else
          FieldByName('PUNTEGGIO_PESATO').AsFloat:=0;
        if (FieldByName('PUNTEGGIO_PESATO').AsFloat = 0)
        and FieldByName('PUNTEGGIO').IsNull then
          FieldByName('PUNTEGGIO_PESATO').AsString:='';
        Post;
        TotVal:=TotVal + FieldByName('PUNTEGGIO_PESATO').AsFloat;
        CodArea:=FieldByName('COD_AREA').AsString;
        Next;
      end;
      TotVal:=R180Arrotonda(TotVal,0.01,'P');
    end;
    //Aggiorno il punteggio finale pesato
    with selSG710 do
    begin
      Edit;
      FieldByName('PUNTEGGIO_FINALE_PESATO').AsFloat:=TotVal;
      Post;
      AggiornamentoEseguito:=True;
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TS715FDialogStampa.AvanzaStato;
var CodArea,Msg:String;
    TotPerc:Real;
    bPunteggiVuoti,bNotePunteggiVuote,EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata,Punteggi_Abilitati:Boolean;
begin
  with S715FStampaValutazioniDtM do
  begin
    //Non avanzo lo stato se la scheda è di autovalutazione ed è stata creata duplicandola da una scheda di valutazione
    if (selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S') then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'La struttura è un duplicato della scheda di valutazione!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non avanzo lo stato se non sono previsti stati successivi
    if VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'CODICE')) = '' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Non sono previsti stati successivi!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non avanzo lo stato se esiste una scheda con lo stato successivo
    if StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Esiste già una scheda relativa allo stato successivo!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non avanzo lo stato se la scheda è bloccata
    if selSG710.FieldByName('CHIUSO').AsString = 'B' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'La scheda è bloccata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non avanzo lo stato se la scheda è già chiusa (eventualmente perché il dipendente non è valutabile)
    if selSG710.FieldByName('CHIUSO').AsString = 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'La scheda è già stata chiusa!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non avanzo lo stato se non è stato indicato se il dirigente accetta gli obiettivi
    EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
    FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not selSG710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
    if not FaseAssegnazionePreventivaObiettiviTerminata then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Non è stato indicato se il dirigente accetta gli obiettivi!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Recupero il totale delle aree
    with selSG711 do
    begin
      CodArea:='';
      TotPerc:=0;
      bPunteggiVuoti:=False;
      bNotePunteggiVuote:=False;
      First;
      while not Eof do
      begin
        if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S' then
        begin
          if CodArea <> FieldByName('COD_AREA').AsString then
            TotPerc:=TotPerc + StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0);
        end
        else
          TotPerc:=TotPerc + FieldByName('PERC_VALUTAZIONE').AsFloat;
        CodArea:=FieldByName('COD_AREA').AsString;
        Punteggi_Abilitati:=   ((FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S'))
                            or (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_ABILITATI') = 'S');
        if (FieldByName('VALUTABILE').AsString = 'S')
        and Punteggi_Abilitati
        and FieldByName('COD_PUNTEGGIO').IsNull
        and FieldByName('PUNTEGGIO').IsNull then
          bPunteggiVuoti:=True;
        if (VarToStr(selSG730.Lookup('CODICE',FieldByName('COD_PUNTEGGIO').AsString,'GIUSTIFICA')) = 'S')
        and FieldByName('NOTE_PUNTEGGIO').IsNull then
          bNotePunteggiVuote:=True;
        Next;
      end;
    end;
    if TotPerc <> 100 then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(TotPerc) + ')'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if AnomaliaRangePesoArea(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if SchedeCollegateChiuse(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if bPunteggiVuoti then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Non per tutti gli elementi valutabili è stato indicato il punteggio!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if bNotePunteggiVuote then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Non sono state indicate le note per tutti i punteggi che le prevedono!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    with selSG710 do
    begin
      //Non avanzo lo stato se non è stata indicata la valutazione intermedia obbligatoria
      if (FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = '')
      and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([FieldByName('CODREGOLA').AsString,FieldByName('STATO_AVANZAMENTO').AsInteger]),'VAL_INTERM_OBBLIGATORIA')) = 'S') then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAvanzaStato,'Non è stata indicata la valutazione intermedia!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      EliminaValidazioni;
      //Aggiorno eventualmente la data di compilazione
      updSG710.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','N');
      updSG710.SetVariable('AGGIORNA',selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString);
      updSG710.Execute;
      SessioneOracle.Commit;
      //Duplico la scheda
      insSG710.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      insSG710.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      insSG710.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
      insSG710.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      insSG710.Execute;
      insaSG711.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      insaSG711.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      insaSG711.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
      insaSG711.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      insaSG711.Execute;
      AggiornamentoEseguito:=True;
      SessioneOracle.Commit;
      //Mi sposto sulla scheda appena creata per le eventuali azioni successive
      Refresh;
      SearchRecord('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([insSG710.GetVariable('DATA'),insSG710.GetVariable('TIPO_VALUTAZIONE'),insSG710.GetVariable('STATO_AVANZAMENTO') + 1]),[srFromBeginning]);
    end;
    with selSG711 do
    begin
      Close;
      SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      SetVariable('TIPO_VAL',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
    end;
  end;
end;

procedure TS715FDialogStampa.ChiudiScheda;
var CodArea,Msg:String;
    TotPerc:Real;
    bPunteggiVuoti,bNotePunteggiVuote,EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata,Punteggi_Abilitati:Boolean;
begin
  with S715FStampaValutazioniDtM do
  begin
    //Non chiudo la scheda se sono previsti stati successivi (a meno che la scheda è di autovalutazione ed è stata creata duplicandola da una scheda di valutazione)
    if (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'CODICE')) <> '')
    and not ((selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S')) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Sono previsti stati successivi!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non chiudo la scheda se la scheda è bloccata
    if selSG710.FieldByName('CHIUSO').AsString = 'B' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'La scheda è bloccata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non chiudo la scheda se la scheda è già chiusa (eventualmente perché il dipendente non è valutabile)
    if selSG710.FieldByName('CHIUSO').AsString = 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'La scheda è già stata chiusa!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non chiudo la scheda se non è stato indicato se il dirigente accetta gli obiettivi
    EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
    FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not selSG710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
    if not FaseAssegnazionePreventivaObiettiviTerminata then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Non è stato indicato se il dirigente accetta gli obiettivi!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non chiudo la scheda se ci sono schede collegate chiuse
    if SchedeCollegateChiuse(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Recupero il totale delle aree
    with selSG711 do
    begin
      CodArea:='';
      TotPerc:=0;
      bPunteggiVuoti:=False;
      bNotePunteggiVuote:=False;
      First;
      while not Eof do
      begin
        if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S' then
        begin
          if CodArea <> FieldByName('COD_AREA').AsString then
            TotPerc:=TotPerc + StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0);
        end
        else
          TotPerc:=TotPerc + FieldByName('PERC_VALUTAZIONE').AsFloat;
        CodArea:=FieldByName('COD_AREA').AsString;
        Punteggi_Abilitati:=   ((FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S'))
                            or (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_ABILITATI') = 'S');
        if (FieldByName('VALUTABILE').AsString = 'S')
        and Punteggi_Abilitati
        and FieldByName('COD_PUNTEGGIO').IsNull
        and FieldByName('PUNTEGGIO').IsNull then
          bPunteggiVuoti:=True;
        if (VarToStr(selSG730.Lookup('CODICE',FieldByName('COD_PUNTEGGIO').AsString,'GIUSTIFICA')) = 'S')
        and FieldByName('NOTE_PUNTEGGIO').IsNull then
          bNotePunteggiVuote:=True;
        Next;
      end;
    end;
    if TotPerc <> 100 then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Il totale del peso percentuale delle aree di valutazione deve essere 100! (Attuale: ' + FloatToStr(TotPerc) + ')'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    if AnomaliaRangePesoArea(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    if VarToStr(selSG711.Lookup('VALUTABILE','S','VALUTABILE')) = '' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Nessun elemento valutabile!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if SchedeCollegateAperte(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if bPunteggiVuoti then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Non per tutti gli elementi valutabili è stato indicato il punteggio!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end
    else if bNotePunteggiVuote then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Non sono state indicate le note per tutti i punteggi che le prevedono!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    with selSG710 do
    begin
      //Non chiudo la scheda se non è stata indicata la valutazione intermedia obbligatoria
      if (FieldByName('ESITO_VALUTAZIONE_INTERMEDIA').AsString = '')
      and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([FieldByName('CODREGOLA').AsString,FieldByName('STATO_AVANZAMENTO').AsInteger]),'VAL_INTERM_OBBLIGATORIA')) = 'S') then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Non è stata indicata la valutazione intermedia!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      //Se la scheda prevede la sezione delle Proposte formative e si vuole almeno un'area formativa compilata, verifico che non siano tutte vuote
      if (FieldByName('TIPO_VALUTAZIONE').AsString = 'V')
      and (Pos('P3',selSG741.FieldByName('PAGINE_ABILITATE').AsString) > 0)
      and (selSG741.FieldByName('AREA_FORMATIVA_OBBLIGATORIA').AsString = 'S')
      and FieldByName('PROPOSTE_FORMATIVE_1').IsNull
      and FieldByName('PROPOSTE_FORMATIVE_2').IsNull
      and FieldByName('PROPOSTE_FORMATIVE_3').IsNull then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkChiudiScheda,'Necessaria almeno un''area formativa!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      EliminaValidazioni;
      //Chiudo la scheda
      updSG710.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','S');
      updSG710.SetVariable('AGGIORNA',selSG741.FieldByName('AGGIORNA_DATA_COMPILAZIONE').AsString);
      updSG710.Execute; //Una chiusura parallela viene effettuata anche in TW022FSchedaValutazioniDtM.Q710AfterPost
      AggiornamentoEseguito:=True;
      EsisteStatoChiuso:=True;
      SessioneOracle.Commit;
      RefreshRecord;
    end;
  end;
end;

procedure TS715FDialogStampa.RiapriScheda;
var Msg:String;
begin
  with S715FStampaValutazioniDtM do
  begin
    //Non riapro la scheda se esiste una scheda con lo stato successivo
    if StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRiapriScheda,'Esiste una scheda relativa allo stato successivo!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non riapro la scheda se la scheda è aperta
    if selSG710.FieldByName('CHIUSO').AsString <> 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRiapriScheda,'La scheda è già aperta!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non riapro la scheda se la scheda è già stata protocollata
    if SchedaProtocollata then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRiapriScheda,'La scheda è già stata protocollata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non riapro la scheda se il dipendente non è valutabile
    if selSG710.FieldByName('VALUTABILE').AsString <> 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRiapriScheda,'Il dipendente non è valutabile! Se necessario, riaprire la scheda singolarmente da IrisWeb.'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non riapro la scheda se ci sono schede collegate chiuse
    if SchedeCollegateChiuse(Msg) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRiapriScheda,Msg),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    with selSG710 do
    begin
      //Riapro la scheda
      updSG710.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      updSG710.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      updSG710.SetVariable('TIPO_VAL',FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG710.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG710.SetVariable('CHIUSO','N');
      updSG710.SetVariable('AGGIORNA','N');
      updSG710.Execute;
      //Svuoto gli elementi dipendenti dai collegati
      updSG711a.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      updSG711a.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      updSG711a.SetVariable('TIPO_VAL',FieldByName('TIPO_VALUTAZIONE').AsString);
      updSG711a.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      updSG711a.Execute;
      AggiornamentoEseguito:=True;
      EsisteStatoChiuso:=False;
      SessioneOracle.Commit;
      RefreshRecord;
    end;
    with selSG711 do
    begin
      Close;
      SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      SetVariable('TIPO_VAL',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
    end;
    AggiornaPunteggi;
  end;
end;

procedure TS715FDialogStampa.RetrocediStato;
begin
  with S715FStampaValutazioniDtM do
  begin
    //Non retrocedo lo stato se la scheda è di autovalutazione ed è stata creata duplicandola da una scheda di valutazione
    if (selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S') then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRetrocediStato,'La struttura è un duplicato della scheda di valutazione!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non retrocedo lo stato se non sono previsti stati precedenti
    if VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger - 1]),'CODICE')) = '' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRetrocediStato,'Non sono previsti stati precedenti!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non retrocedo lo stato se esiste una scheda con lo stato successivo
    if StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRetrocediStato,'Esiste una scheda relativa allo stato successivo!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non retrocedo lo stato se la scheda è bloccata
    if selSG710.FieldByName('CHIUSO').AsString = 'B' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRetrocediStato,'La scheda è bloccata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non retrocedo lo stato se la scheda è già chiusa (eventualmente perché il dipendente non è valutabile)
    if selSG710.FieldByName('CHIUSO').AsString = 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkRetrocediStato,'La scheda è già stata chiusa!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    with selSG710 do
    begin
      delSG711.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
      delSG711.SetVariable('DATA',FieldByName('DATA').AsDateTime);
      delSG711.SetVariable('TIPO_VALUTAZIONE',FieldByName('TIPO_VALUTAZIONE').AsString);
      delSG711.SetVariable('STATO_AVANZAMENTO',FieldByName('STATO_AVANZAMENTO').AsInteger);
      delSG711.Execute;
      while selSG745.SearchRecord('DATA;PROGRESSIVO;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',
                                  VarArrayOf([FieldByName('DATA').AsDateTime,
                                              FieldByName('PROGRESSIVO').AsInteger,
                                              FieldByName('TIPO_VALUTAZIONE').AsString,
                                              FieldByName('STATO_AVANZAMENTO').AsInteger]),[srFromBeginning]) do
        selSG745.Delete;
      Delete;
      AggiornamentoEseguito:=True;
      SessioneOracle.Commit;
      //Mi sposto sullo stato precedente a quello della scheda appena eliminata per le eventuali azioni successive
      Refresh;
      SearchRecord('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([delSG711.GetVariable('DATA'),delSG711.GetVariable('TIPO_VALUTAZIONE'),delSG711.GetVariable('STATO_AVANZAMENTO') - 1]),[srFromBeginning]);
    end;
    with selSG711 do
    begin
      Close;
      SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      SetVariable('TIPO_VAL',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
    end;
    AggiornaPunteggi;
  end;
end;

function TS715FDialogStampa.SchedeCollegateAperte(var Msg:String): Boolean;
var svMatricola:String;
begin
  Result:=False;
  Msg:='';
  with S715FStampaValutazioniDtM do
  begin
    svMatricola:='';
    with selSchedeCollegateAperte do
    begin
      Close;
      SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      //SetVariable('TIPO_VALUTAZIONE',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      SetVariable('TIPO_VALUTAZIONE','V');//Fino a diversa segnalazione, nell'autovalutazione considero i punteggi assegnati alle schede di VALUTAZIONE altrui, non di AUTOVALUTAZIONE
      SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
      if RecordCount > 0 then
      begin
        Result:=True;
        Msg:='In attesa della chiusura delle seguenti schede contenenti elementi collegati: ';
      end;
      while not Eof do
      begin
        if FieldByName('MATRICOLA').AsString <> svMatricola then
          Msg:=Msg + CRLF + Format('%s %s',[FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
        Msg:=Msg + CRLF + Format('%4s %5s %5s %s',['',FieldByName('COD_AREA').AsString,FieldByName('COD_VALUTAZIONE').AsString,FieldByName('DESCRIZIONE').AsString]);
        svMatricola:=FieldByName('MATRICOLA').AsString;
        Next;
      end;
    end;
  end;
end;

function TS715FDialogStampa.SchedeCollegateChiuse(var Msg:String): Boolean;
var svMatricola:String;
begin
  Result:=False;
  Msg:='';
  with S715FStampaValutazioniDtM do
  begin
    if selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A' then
      exit;//Fino a diversa segnalazione, influiscono sulle schede altrui solo i punteggi assegnati alle schede di VALUTAZIONE, non di AUTOVALUTAZIONE
    svMatricola:='';
    with selSchedeCollegateChiuse do
    begin
      Close;
      SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      SetVariable('TIPO_VALUTAZIONE',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);//Fino a diversa segnalazione, non blocco l'intervento se ho già chiuso una AUTOVALUTAZIONE collegata
      SetVariable('STATO_AVANZAMENTO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger);
      Open;
      if RecordCount > 0 then
      begin
        Result:=True;
        Msg:='Sono state chiuse le seguenti schede contenenti elementi collegati: ';
      end;
      while not Eof do
      begin
        if FieldByName('MATRICOLA').AsString <> svMatricola then
          Msg:=Msg + CRLF + Format('%s %s',[FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]);
        Msg:=Msg + CRLF + Format('%4s %5s %5s %s',['',FieldByName('COD_AREA').AsString,FieldByName('COD_VALUTAZIONE').AsString,FieldByName('DESCRIZIONE').AsString]);
        svMatricola:=FieldByName('MATRICOLA').AsString;
        Next;
      end;
    end;
  end;
end;

function TS715FDialogStampa.AnomaliaRangePesoArea(var Msg:String): Boolean;
var CodArea,RPA:String;
    TotPercArea,PAMin,PaMax:Real;
begin
  Result:=False;
  Msg:='';
  with S715FStampaValutazioniDtM.selSG711 do
  begin
    //validità peso percentuale area
    First;
    CodArea:=FieldByName('COD_AREA').AsString;
    while not Eof do
    begin
      if FieldByName('COD_AREA').AsString <> CodArea then
      begin
        TotPercArea:=R180Arrotonda(TotPercArea,0.01,'P');//Se metto 5 cifre decimali sballa i confronti con PAMin e PAMax
        if ProprietaArea(CodArea,DataRif,'PESO_ITEM_MODIFICABILE') = 'S' then
        begin
          if ProprietaArea(CodArea,DataRif,'PESO_AREA_BASE_100') = 'S' then
          begin
            PAMin:=100;
            PAMax:=PAMin;
          end
          else
          begin
            RPA:=ProprietaArea(CodArea,DataRif,'RANGE_PESO_AREA');
            PAMin:=StrToFloatDef(Copy(RPA,1,Pos('#',RPA) - 1),0);
            PAMax:=StrToFloatDef(Copy(RPA,Pos('#',RPA) + 1),0);
          end;
          if (TotPercArea < PAMin) or (TotPercArea > PAMax) then
          begin
            Msg:=Msg + IfThen(Msg <> '',CRLF) + 'La somma dei valori indicati in "' + S715FStampaValutazioniDtM.RecuperaEtichetta('PESO_ITEM_C') + '" per l''area ' + CodArea +
                                                 IfThen(PAMin = PAMax,
                                                        ' deve risultare ' + FloatToStr(PAMin),
                                                        ' dev''essere compresa tra ' + FloatToStr(PAMin) + ' e ' + FloatToStr(PAMax)) +
                                                 '! (Attuale: ' + FloatToStr(TotPercArea) + ')';
            Result:=True;
          end;
        end;
        TotPercArea:=0;
        CodArea:=FieldByName('COD_AREA').AsString;
      end;
      TotPercArea:=R180Arrotonda(TotPercArea + FieldByName('PERC_VALUTAZIONE').AsFloat,0.00001,'P');
      Next;
    end;
    TotPercArea:=R180Arrotonda(TotPercArea,0.01,'P');//Se metto 5 cifre decimali sballa i confronti con PAMin e PAMax
    if ProprietaArea(CodArea,DataRif,'PESO_ITEM_MODIFICABILE') = 'S' then
    begin
      if ProprietaArea(CodArea,DataRif,'PESO_AREA_BASE_100') = 'S' then
      begin
        PAMin:=100;
        PAMax:=PAMin;
      end
      else
      begin
        RPA:=ProprietaArea(CodArea,DataRif,'RANGE_PESO_AREA');
        PAMin:=StrToFloatDef(Copy(RPA,1,Pos('#',RPA) - 1),0);
        PAMax:=StrToFloatDef(Copy(RPA,Pos('#',RPA) + 1),0);
      end;
      if (TotPercArea < PAMin) or (TotPercArea > PAMax) then
      begin
        Msg:=Msg + IfThen(Msg <> '',CRLF) + 'La somma dei valori indicati in "' + S715FStampaValutazioniDtM.RecuperaEtichetta('PESO_ITEM_C') + '" per l''area ' + CodArea +
                                             IfThen(PAMin = PAMax,
                                                    ' deve risultare ' + FloatToStr(PAMin),
                                                    ' dev''essere compresa tra ' + FloatToStr(PAMin) + ' e ' + FloatToStr(PAMax)) +
                                             '! (Attuale: ' + FloatToStr(TotPercArea) + ')';
        Result:=True;
      end;
    end;
  end;
end;

procedure TS715FDialogStampa.AggiornaIncentivi;
var
  s,TipoQuota,ValoriT775:String;
  NextDec,SaveDec,DIni,DFin:TDateTime;
  PercIncentivo,PFP:Real;
  Prog:Integer;
label
  QuotaSaltata;
begin
  CodTipoQuota:='';
  with S715FStampaValutazioniDtM do
  begin
    with selSG710 do
    begin
      //Non aggiorno gli incentivi se esiste una scheda con lo stato successivo
      if StrToIntDef(VarToStr(Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([FieldByName('DATA').AsDateTime,FieldByName('TIPO_VALUTAZIONE').AsString,FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Esiste una scheda relativa allo stato successivo!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      //Non aggiorno gli incentivi se la scheda è un'autovalutazione
      if FieldByName('TIPO_VALUTAZIONE').AsString <> 'V' then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Il tipo di valutazione della scheda non è Valutazione!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      //Non aggiorno gli incentivi se la scheda è aperta
      if FieldByName('CHIUSO').AsString <> 'S' then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'La scheda è aperta!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      //Non aggiorno gli incentivi se il dipendente non è valutabile
      if FieldByName('VALUTABILE').AsString <> 'S' then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Il dipendente non è valutabile!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
      //Non aggiorno gli incentivi se la scala dei punteggi non prevede il Calcolo del punteggio finale pesato
      if not CalcoloPFP then
      begin
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'La scala dei punteggi della scheda non concorre al calcolo del Punteggio finale pesato!'),'',FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
    end;
    try
      QSGruppoValutatore.LocDatoStorico(selSG710.FieldByName('AL').AsDateTime);
      Prog:=selSG710.FieldByName('PROGRESSIVO').AsInteger;
      PFP:=selSG710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsFloat;
      s:=ListaTipologieQuote + ',';
      while Pos(',',s) > 0 do
      begin
        CodTipoQuota:=Copy(s,1,Pos(',',s) - 1);
        //Controllo se il dipendente rientra nei gruppi previsti per la quota selezionata
        selT770.Close;
        selT770.SetVariable('CODTIPOQUOTA',CodTipoQuota);
        selT770.SetVariable('DATO1',IfThen(Parametri.CampiRiferimento.C7_Dato1 <> '',QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString));
        selT770.SetVariable('DATO2',IfThen(Parametri.CampiRiferimento.C7_Dato2 <> '',QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString));
        selT770.SetVariable('DATO3',IfThen(Parametri.CampiRiferimento.C7_Dato3 <> '',QSGruppoValutatore.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString));
        selT770.SetVariable('DATARIF',selSG710.FieldByName('AL').AsDateTime);
        selT770.Open;
        if selT770.FieldByName('NUM').AsInteger = 0 then
          GoTo QuotaSaltata;//Attenzione: è una GoTo label!
        //Recupero i parametri per l'aggiornamento
        TipoQuota:=VarToStr(S715FStampaValutazioniMW.selT765.Lookup('CODICE',CodTipoQuota,'TIPOQUOTA'));
        if TipoQuota = 'D' then //Saldo annuale collettivo valutativo
        begin
          //Considero il periodo di valutazione EFFETTIVO
          DIni:=selSG710.FieldByName('DAL').AsDateTime;
          DFin:=selSG710.FieldByName('AL').AsDateTime;
        end
        else
        begin
          //Non aggiorno gli incentivi se esistono schede chiuse successive
          selSG710a.SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
          selSG710a.SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
          selSG710a.SetVariable('TIPO',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
          selSG710a.Execute;
          if StrToIntDef(VarToStr(selSG710a.Field(0)),0) > 0 then
          begin
            RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Esistono schede chiuse successive!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
            GoTo QuotaSaltata;//Attenzione: è una GoTo label!
          end;
          //Considero il periodo di valutazione ESTESO
          selSG710b.SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
          selSG710b.SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
          selSG710b.SetVariable('TIPO',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
          selSG710b.Execute;
          DIni:=selSG710b.Field(0);
          DFin:=selSG710.FieldByName('DATA').AsDateTime;
        end;
        //Recupero la percentuale di incentivo, alla data di valutazione, in base al punteggio finale pesato
        with selSG735 do
        begin
          SetVariable('QUOTA',CodTipoQuota);
          SetVariable('DATA_VAL',selSG710.FieldByName('DATA').AsDateTime);
          SetVariable('PUNTEGGIO',PFP);
          Execute;
          if RowCount > 0 then
            PercIncentivo:=StrToFloatDef(VarToStr(Field(0)),0)
          else
          begin
            RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Il Punteggio finale pesato (' + FloatToStr(PFP) + ') non rientra tra gli scaglioni di assegnazione degli incentivi!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
            GoTo QuotaSaltata;//Attenzione: è una GoTo label!
          end;
        end;
        with selT775 do
        begin
          Close;
          SetVariable('PROGRESSIVO',Prog);
          SetVariable('DATAINIZIO',DIni);
          SetVariable('DATAFINE',DFin);
          SetVariable('CODTIPOQUOTA',CodTipoQuota);
          Open;
          //Creo la quota da inizio a fine periodo di valutazione
          if RecordCount = 0 then
          begin
            insT775.SetVariable('VALORI',IntToStr(Prog) + ',TO_DATE(''' + DateToStr(DIni) + ''',''DD/MM/YYYY''),TO_DATE(''' + DateToStr(DFin) + ''',''DD/MM/YYYY''),''' + CodTipoQuota + ''',-1,' + StringReplace(FloatToStr(PercIncentivo),',','.',[rfReplaceAll]));
            insT775.Execute;
            AggiornamentoEseguito:=True;
          end
          else if (TipoQuota = 'D')
          and (   (FieldByName('DECORRENZA').AsDateTime <> DIni)
               or (FieldByName('SCADENZA').AsDateTime <> DFin)) then
            RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,'Esiste una quota individuale intersecata il cui periodo (' + DateToStr(FieldByName('DECORRENZA').AsDateTime) + '-' + DateToStr(FieldByName('SCADENZA').AsDateTime) + ') è diverso da quello di valutazione (' + DateToStr(DIni) + '-' + DateToStr(DFin) + ')!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger)
          else
            while not Eof do
            begin
              //Creo la quota da inizio anno sul primo periodo
              if (RecNo = 1) and (FieldByName('DEC_PERIODO').AsDateTime > DIni) then
              begin
                insT775.SetVariable('VALORI',IntToStr(Prog) + ',TO_DATE(''' + DateToStr(DIni) + ''',''DD/MM/YYYY''),TO_DATE(''' + DateToStr(FieldByName('DEC_PERIODO').AsDateTime - 1) + ''',''DD/MM/YYYY''),''' + CodTipoQuota + ''',-1,' + StringReplace(FloatToStr(PercIncentivo),',','.',[rfReplaceAll]));
                insT775.Execute;
              end;
              //Creo la quota a fine anno sull'ultimo periodo
              if (RecNo = RecordCount) and (FieldByName('SCAD_PERIODO').AsDateTime < DFin) then
              begin
                insT775.SetVariable('VALORI',IntToStr(Prog) + ',TO_DATE(''' + DateToStr(FieldByName('SCAD_PERIODO').AsDateTime + 1) + ''',''DD/MM/YYYY''),TO_DATE(''' + DateToStr(DFin) + ''',''DD/MM/YYYY''),''' + CodTipoQuota + ''',-1,' + StringReplace(FloatToStr(PercIncentivo),',','.',[rfReplaceAll]));
                insT775.Execute;
              end;
              //Creo la quota nel periodo mancante tra quello corrente e quello successivo
              if (RecNo < RecordCount) then
              begin
                Next;
                NextDec:=FieldByName('DECORRENZA').AsDateTime;
                Prior;
                if (FieldByName('SCADENZA').AsDateTime + 1) <> NextDec then
                begin
                  insT775.SetVariable('VALORI',IntToStr(Prog) + ',TO_DATE(''' + DateToStr(FieldByName('SCADENZA').AsDateTime + 1) + ''',''DD/MM/YYYY''),TO_DATE(''' + DateToStr(NextDec - 1) + ''',''DD/MM/YYYY''),''' + CodTipoQuota + ''',-1,' + StringReplace(FloatToStr(PercIncentivo),',','.',[rfReplaceAll]));
                  insT775.Execute;
                end;
              end;
              if FieldByName('SCAD_PERIODO').AsDateTime < FieldByName('SCADENZA').AsDateTime then
              begin
                //Spezzo il periodo creando quello dopo la scadenza
                ValoriT775:=',' + CampiT775 + ',';
                ValoriT775:=StringReplace(ValoriT775,',DECORRENZA,',',TO_DATE(''' + DateToStr(FieldByName('SCAD_PERIODO').AsDateTime + 1) + ''',''DD/MM/YYYY''),',[rfReplaceAll]);
                ValoriT775:=StringReplace(ValoriT775,',SCADENZA,',',TO_DATE(''' + DateToStr(FieldByName('SCADENZA').AsDateTime) + ''',''DD/MM/YYYY''),',[rfReplaceAll]);
                ValoriT775:=Copy(ValoriT775,2,Length(ValoriT775) - 2);
                insT775a.SetVariable('CAMPI',CampiT775);
                insT775a.SetVariable('VALORI',ValoriT775);
                insT775a.SetVariable('PROGRESSIVO',Prog);
                insT775a.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
                insT775a.SetVariable('CODTIPOQUOTA',CodTipoQuota);
                insT775a.Execute;
                Edit;
                FieldByName('SCADENZA').AsDateTime:=FieldByName('SCAD_PERIODO').AsDateTime;
                Post;
              end;
              if FieldByName('DEC_PERIODO').AsDateTime > FieldByName('DECORRENZA').AsDateTime then
              begin
                SaveDec:=FieldByName('DECORRENZA').AsDateTime;
                Edit;
                FieldByName('DECORRENZA').AsDateTime:=FieldByName('DEC_PERIODO').AsDateTime;
                Post;
                //Spezzo il periodo creando quello della valutazione
                ValoriT775:=',' + CampiT775 + ',';
                ValoriT775:=StringReplace(ValoriT775,',DECORRENZA,',',TO_DATE(''' + DateToStr(SaveDec) + ''',''DD/MM/YYYY''),',[rfReplaceAll]);
                ValoriT775:=StringReplace(ValoriT775,',SCADENZA,',',TO_DATE(''' + DateToStr(FieldByName('DEC_PERIODO').AsDateTime - 1) + ''',''DD/MM/YYYY''),',[rfReplaceAll]);
                ValoriT775:=Copy(ValoriT775,2,Length(ValoriT775) - 2);
                insT775a.SetVariable('CAMPI',CampiT775);
                insT775a.SetVariable('VALORI',ValoriT775);
                insT775a.SetVariable('PROGRESSIVO',Prog);
                insT775a.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
                insT775a.SetVariable('CODTIPOQUOTA',CodTipoQuota);
                insT775a.Execute;
              end;
              //Aggiorno la percentuale sul periodo corrente
              Edit;
              FieldByName('PERC_INDIVIDUALE').AsFloat:=PercIncentivo;
              Post;
              AggiornamentoEseguito:=True;
              //Passo alla quota successiva
              Next;
            end;
        end;
        QuotaSaltata://Attenzione: è una GoTo label!
          s:=Copy(s,Pos(',',s) + 1);
      end;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        SessioneOracle.Rollback;
        RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkAggiornaIncentivi,E.Message),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        Exit;
      end;
    end;
  end;
end;

procedure TS715FDialogStampa.Stampa;
var EsisteFaseAssegnazionePreventivaObiettivi,FaseAssegnazionePreventivaObiettiviTerminata,
    Fase1StampaDirigenzaConObiettivi,Fase2StampaDirigenzaConObiettivi,PunteggiAssegnati:Boolean;
    NomeCampo,DatoStampa1,DatoStampa2,DatoStampa3,DatoStampa4,DatoStampa5,DatoStampa6,DatoValutatoFirma6,
    Valore5,Valore5Old,ProgValutatori,sDal,sAl,sDalAl,sPeriodo,CodArea,Nominativo:String;
    DIni5,DFin5,DIniRap,DFinRap:TDateTime;
    NValutatori,ProgValutatore:Integer;
    TotPercArea,PunteggioArea:Real;
begin
  with S715FStampaValutazioniDtM do
  begin
    with selSG711 do
    begin
      PunteggiAssegnati:=False;
      First;
      while not Eof do
      begin
        if not FieldByName('COD_PUNTEGGIO').IsNull
        or not FieldByName('PUNTEGGIO').IsNull then
        begin
          PunteggiAssegnati:=True;
          Break;
        end;
        Next;
      end;
    end;
    EsisteFaseAssegnazionePreventivaObiettivi:=selSG741.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S';
    FaseAssegnazionePreventivaObiettiviTerminata:=not EsisteFaseAssegnazionePreventivaObiettivi or not selSG710.FieldByName('ACCETTAZIONE_OBIETTIVI').IsNull;
    Fase1StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and not PunteggiAssegnati;
    Fase2StampaDirigenzaConObiettivi:=EsisteFaseAssegnazionePreventivaObiettivi and PunteggiAssegnati;
    with cdsStampaAnagrafico do
    begin
      //Salvo i dati dei dipendenti da stampare
      Append;
      FieldByName('PROG_VALUTATO').AsInteger:=selSG710.FieldByName('PROGRESSIVO').AsInteger;
      FieldByName('DATA_VALUTAZIONE').AsDateTime:=selSG710.FieldByName('DATA').AsDateTime;
      FieldByName('DAL').AsDateTime:=selSG710.FieldByName('DAL').AsDateTime;
      FieldByName('AL').AsDateTime:=selSG710.FieldByName('AL').AsDateTime;
      FieldByName('TIPO_VALUTAZIONE').AsString:=selSG710.FieldByName('TIPO_VALUTAZIONE').AsString;
      FieldByName('CODREGOLA').AsString:=selSG710.FieldByName('CODREGOLA').AsString;
      FieldByName('STATO_AVANZAMENTO').AsInteger:=selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger;
      FieldByName('STATO_SCHEDA').AsString:=IfThen(selSG741.FieldByName('CODICE').IsNull,'Non valutabile: Regole non trovate',
                                            IfThen(selSG710.FieldByName('VALUTABILE').AsString = 'N','Non valutabile: Impostato dall''ufficio',
                                            IfThen(selSG710.FieldByName('CHIUSO').AsString = 'S','Scheda definitiva',
                                            IfThen(selSG710.FieldByName('CHIUSO').AsString = 'B','Scheda bloccata',
                                            IfThen((selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'A') and (VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CREA_AUTOVALUTAZIONE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,'S']),'CREA_AUTOVALUTAZIONE')) = 'S'),'Scheda provvisoria',
                                            VarToStr(S715FStampaValutazioniMW.selSG746.Lookup('CODREGOLA;CODICE',VarArrayOf([selSG710.FieldByName('CODREGOLA').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger]),'DESCRIZIONE')))))));
      FieldByName('ANNO_VALUTAZIONE').AsInteger:=StrToInt(FormatDateTime('yyyy',selSG710.FieldByName('DATA').AsDateTime));
      FieldByName('DATARIF').AsDateTime:=DataRif;
      FieldByName('DATA_COMPILAZIONE').AsDateTime:=selSG710.FieldByName('DATA_COMPILAZIONE').AsDateTime;
      try
        sDalAl:=RecuperaEtichetta('PERIODO_VALUTAZIONE_S');
        while Pos('#',sDalAl) > 0 do
        begin
          sPeriodo:=sPeriodo + Copy(sDalAl,1,Pos('#',sDalAl) - 1);
          sDalAl:=Copy(sDalAl,Pos('#',sDalAl));
          if Pos('#DAL',sDalAl) = 1 then
          begin
            sDal:=Copy(sDalAl,Pos('#DAL',sDalAl) + 4);
            sDal:=Copy(sDal,1,Pos('#',sDal) - 1);
            if sDal = '' then
              sPeriodo:=sPeriodo + FormatDateTime('dd/mm',selSG710.FieldByName('DAL').AsDateTime)
            else
              sPeriodo:=sPeriodo + FormatDateTime(sDal,selSG710.FieldByName('DAL').AsDateTime);
            sDalAl:=Copy(sDalAl,Pos('#DAL'+sDal+'#',sDalAl) + Length('#DAL'+sDal+'#'));
          end
          else if Pos('#AL',sDalAl) = 1 then
          begin
            sAl:=Copy(sDalAl,Pos('#AL',sDalAl) + 3);
            sAl:=Copy(sAl,1,Pos('#',sAl) - 1);
            if sAl = '' then
              sPeriodo:=sPeriodo + FormatDateTime('dd/mm',selSG710.FieldByName('AL').AsDateTime)
            else
              sPeriodo:=sPeriodo + FormatDateTime(sAl,selSG710.FieldByName('AL').AsDateTime);
            sDalAl:=Copy(sDalAl,Pos('#AL'+sAl+'#',sDalAl) + Length('#AL'+sAl+'#'));
          end
          else
          begin
            sPeriodo:=sPeriodo + Copy(sDalAl,1,1);
            sDalAl:=Copy(sDalAl,2);
          end;
        end;
        sPeriodo:=sPeriodo + sDalAl;
        FieldByName('PERIODO_VALUTAZIONE').AsString:=sPeriodo;
      except
      end;
      selStoriaValInterm.SetVariable('DATA',selSG710.FieldByName('DATA').AsDateTime);
      selStoriaValInterm.SetVariable('PROGRESSIVO',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      selStoriaValInterm.SetVariable('TIPO',selSG710.FieldByName('TIPO_VALUTAZIONE').AsString);
      selStoriaValInterm.SetVariable('STATO',selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1);
      selStoriaValInterm.Execute;
      FieldByName('VALUTAZIONE_INTERMEDIA').AsString:=VarToStr(selStoriaValInterm.Field(0));
      FieldByName('VALUTAZIONI_COMPLESSIVE').AsString:=selSG710.FieldByName('VALUTAZIONE_COMPLESSIVE').AsString;
      FieldByName('IMPORTO_INCENTIVO').AsString:=Trim(R180Formatta(selSG710.FieldByName('IMPORTO_INCENTIVO').AsFloat,8,2));
      FieldByName('ORE_INCENTIVO').AsString:=selSG710.FieldByName('ORE_INCENTIVO').AsString;
      FieldByName('ACCETTAZIONE_OBIETTIVI').AsString:=IfThen(selSG710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'N','NO',IfThen(selSG710.FieldByName('ACCETTAZIONE_OBIETTIVI').AsString = 'S','SI',''));
      if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
        FieldByName('OBIETTIVI_PIANIFICATI').AsString:='Quota annuale retribuzione risultato (#): € ' + FieldByName('IMPORTO_INCENTIVO').AsString + '. ' + 'Orario annuale negoziato: h ' + FieldByName('ORE_INCENTIVO').AsString + '.' + CRLF
                                                     + CRLF
                                                     + 'Accettazione degli obiettivi: ' + FieldByName('ACCETTAZIONE_OBIETTIVI').AsString
      else
        FieldByName('OBIETTIVI_PIANIFICATI').AsString:=selSG710.FieldByName('OBIETTIVI_AZIONI').AsString;
      FieldByName('PROPOSTE_FORMATIVE').AsString:=selSG710.FieldByName('PROPOSTE_FORMATIVE').AsString;
      if selSG710.FieldByName('PROPOSTE_FORMATIVE_3').AsString <> '' then
        FieldByName('PROPOSTE_FORMATIVE').AsString:='SPECIFICA (Valorizzazione e manutenzione delle competenze):    ' + VarToStr(selFormaz.Lookup('CODICE',selSG710.FieldByName('PROPOSTE_FORMATIVE_3').AsString,'DESCRIZIONE')) + CRLF + FieldByName('PROPOSTE_FORMATIVE').AsString;
      if selSG710.FieldByName('PROPOSTE_FORMATIVE_2').AsString <> '' then
        FieldByName('PROPOSTE_FORMATIVE').AsString:='ORGANIZZATIVA/GESTIONALE (Competenze trasversali):             ' + VarToStr(selFormaz.Lookup('CODICE',selSG710.FieldByName('PROPOSTE_FORMATIVE_2').AsString,'DESCRIZIONE')) + CRLF + FieldByName('PROPOSTE_FORMATIVE').AsString;
      if selSG710.FieldByName('PROPOSTE_FORMATIVE_1').AsString <> '' then
        FieldByName('PROPOSTE_FORMATIVE').AsString:='ETICA DEONTOLOGICA (Competenze comportamentali e relazionali): ' + VarToStr(selFormaz.Lookup('CODICE',selSG710.FieldByName('PROPOSTE_FORMATIVE_1').AsString,'DESCRIZIONE')) + CRLF + FieldByName('PROPOSTE_FORMATIVE').AsString;
      FieldByName('PROPOSTE_FORMATIVE').AsString:=Trim(FieldByName('PROPOSTE_FORMATIVE').AsString);
      FieldByName('COMMENTI_VALUTATO').AsString:=selSG710.FieldByName('COMMENTI_VALUTATO').AsString;
      FieldByName('NOTE').AsString:=selSG710.FieldByName('NOTE').AsString;
      FieldByName('CALCOLO_PFP').AsString:=IfThen(CalcoloPFP,'S','N');
      if (FieldByName('CALCOLO_PFP').AsString = 'S')
      and not Fase1StampaDirigenzaConObiettivi then
        FieldByName('PUNTEGGIO_FINALE_PESATO').AsString:=FloatToStr(selSG710.FieldByName('PUNTEGGIO_FINALE_PESATO').AsFloat);
      if selSG710.FieldByName('VALUTABILE').AsString = 'N' then
        FieldByName('PUNTEGGIO_FINALE_PESATO').AsString:='N.V.';
      if SchedaProtocollata then
      begin
        FieldByName('NUMEROEANNO_PROTOCOLLO').AsString:='n. ' + IntToStr(selSG710.FieldByName('NUMERO_PROTOCOLLO').AsInteger) + '/' + IntToStr(selSG710.FieldByName('ANNO_PROTOCOLLO').AsInteger);
        FieldByName('DATA_PROTOCOLLO').AsString:='del ' + FormatDateTime('dd/mm/yyyy',selSG710.FieldByName('DATA_PROTOCOLLO').AsDateTime);
      end;
      FieldByName('CHIUSO').AsString:=selSG710.FieldByName('CHIUSO').AsString;
      FieldByName('DATA_CHIUSURA').AsDateTime:=selSG710.FieldByName('DATA_CHIUSURA').AsDateTime;;
      //Firme
      if selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V' then
      begin
        FieldByName('FIRMA_1').AsString:=RecuperaEtichetta('FIRMA_1_S');
        FieldByName('FIRMA_2').AsString:=RecuperaEtichetta('FIRMA_2_S');
        FieldByName('FIRMA_3').AsString:=RecuperaEtichetta('FIRMA_3_S');
        FieldByName('FIRMA_4').AsString:=RecuperaEtichetta('FIRMA_4_S');
        FieldByName('FIRMA_5').AsString:=RecuperaEtichetta('FIRMA_5_S');
        FieldByName('FIRMA_6').AsString:=RecuperaEtichetta('FIRMA_6_S');
      end
      else
        FieldByName('FIRMA_2').AsString:='IL DIRIGENTE';
      //Dati valutato
      FieldByName('MATR_VALUTATO').AsString:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
      FieldByName('NOM_VALUTATO').AsString:=C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + C700SelAnagrafe.FieldByName('NOME').AsString;
      DatoStampa1:=selSG741.FieldByName('DATO_STAMPA_1').AsString;
      DatoStampa2:=IfThen(selSG741.FieldByName('DESC_LUNGA_1').AsString = 'N',selSG741.FieldByName('DATO_STAMPA_2').AsString,'');
      DatoStampa3:=selSG741.FieldByName('DATO_STAMPA_3').AsString;
      DatoStampa4:=IfThen(selSG741.FieldByName('DESC_LUNGA_3').AsString = 'N',selSG741.FieldByName('DATO_STAMPA_4').AsString,'');
      DatoStampa5:=selSG741.FieldByName('DATO_STAMPA_5').AsString;
      DatoStampa6:=IfThen(selSG741.FieldByName('DESC_LUNGA_5').AsString = 'N',selSG741.FieldByName('DATO_STAMPA_6').AsString,'');
      if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
      begin
        if DatoStampa1 = OpzioneFirma6 then
          DatoStampa1:='';
        if DatoStampa2 = OpzioneFirma6 then
          DatoStampa2:='';
        if DatoStampa3 = OpzioneFirma6 then
          DatoStampa3:='';
        if DatoStampa4 = OpzioneFirma6 then
          DatoStampa4:='';
        if DatoStampa5 = OpzioneFirma6 then
          DatoStampa5:='';
        if DatoStampa6 = OpzioneFirma6 then
          DatoStampa6:='';
      end;
      //Prelevo i dati anagrafici da stampare
      if QSGruppoValutatore.LocDatoStorico(selSG710.FieldByName('AL').AsDateTime) then
      begin
        DatoValutatoFirma6:=RecuperaEtichetta('FIRMA_6_S') + ': ' + IfThen(FieldByName('FIRMA_6').AsString = '','NO','SI');
        if DatoStampa1 = OpzioneFirma6 then
          FieldByName('DATO1_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa1 <> '' then
        begin
          FieldByName('DATO1_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa1).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa1,1,4) = 'T430',Copy(DatoStampa1,5),DatoStampa1);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            if selSQL.VariableIndex('DECORRENZA') >= 0 then
              selSQL.SetVariable('DECORRENZA',selSG710.FieldByName('AL').AsDateTime);
            try
              selSQL.Open;
              FieldByName('DATO1_VALUTATO').AsString:=FieldByName('DATO1_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',FieldByName('DATO1_VALUTATO').AsString,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
        end;
        if DatoStampa2 = OpzioneFirma6 then
          FieldByName('DATO2_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa2 <> '' then
        begin
          FieldByName('DATO2_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa2).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa2,1,4) = 'T430',Copy(DatoStampa2,5),DatoStampa2);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            if selSQL.VariableIndex('DECORRENZA') >= 0 then
              selSQL.SetVariable('DECORRENZA',selSG710.FieldByName('AL').AsDateTime);
            try
              selSQL.Open;
              FieldByName('DATO2_VALUTATO').AsString:=FieldByName('DATO2_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',FieldByName('DATO2_VALUTATO').AsString,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
        end;
        if DatoStampa3 = OpzioneFirma6 then
          FieldByName('DATO3_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa3 <> '' then
        begin
          FieldByName('DATO3_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa3).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa3,1,4) = 'T430',Copy(DatoStampa3,5),DatoStampa3);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            if selSQL.VariableIndex('DECORRENZA') >= 0 then
              selSQL.SetVariable('DECORRENZA',selSG710.FieldByName('AL').AsDateTime);
            try
              selSQL.Open;
              FieldByName('DATO3_VALUTATO').AsString:=FieldByName('DATO3_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',FieldByName('DATO3_VALUTATO').AsString,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
        end;
        if DatoStampa4 = OpzioneFirma6 then
          FieldByName('DATO4_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa4 <> '' then
        begin
          FieldByName('DATO4_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa4).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa4,1,4) = 'T430',Copy(DatoStampa4,5),DatoStampa4);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            if selSQL.VariableIndex('DECORRENZA') >= 0 then
              selSQL.SetVariable('DECORRENZA',selSG710.FieldByName('AL').AsDateTime);
            try
              selSQL.Open;
              FieldByName('DATO4_VALUTATO').AsString:=FieldByName('DATO4_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',FieldByName('DATO4_VALUTATO').AsString,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
        end;
        if DatoStampa5 = OpzioneFirma6 then
          FieldByName('DATO5_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa5 <> '' then
        begin
          Valore5Old:='#VALORE#INIZIALE#FITTIZIO#';
          while (QSGruppoValutatore.FieldByName('T430DATAFINE').AsDateTime >= selSG710.FieldByName('DAL').AsDateTime)
          and (QSGruppoValutatore.FieldByName('T430DATADECORRENZA').AsDateTime <= selSG710.FieldByName('AL').AsDateTime) do
          begin
            Valore5:=QSGruppoValutatore.FieldByName(DatoStampa5).AsString;
            NomeCampo:=IfThen(Copy(DatoStampa5,1,4) = 'T430',Copy(DatoStampa5,5),DatoStampa5);
            if A000LookupTabella(NomeCampo,selSQL) then
            begin
              if selSQL.VariableIndex('DECORRENZA') >= 0 then
                selSQL.SetVariable('DECORRENZA',Min(selSG710.FieldByName('AL').AsDateTime,QSGruppoValutatore.FieldByName('T430DATAFINE').AsDateTime));
              try
                selSQL.Open;
                Valore5:=Valore5 + '     ' + VarToStr(selSQL.Lookup('CODICE',Valore5,'DESCRIZIONE'));
              except
              end;
              selSQL.Close;
            end;
            DIniRap:=IfThen(QSGruppoValutatore.FieldByName('T430INIZIO').IsNull,EncodeDate(1900,1,1),QSGruppoValutatore.FieldByName('T430INIZIO').AsDateTime);
            DFinRap:=IfThen(QSGruppoValutatore.FieldByName('T430FINE').IsNull,EncodeDate(3999,12,31),QSGruppoValutatore.FieldByName('T430FINE').AsDateTime);
            DIni5:=Max(selSG710.FieldByName('DAL').AsDateTime,Max(QSGruppoValutatore.FieldByName('T430DATADECORRENZA').AsDateTime,DIniRap));
            DFin5:=Min(selSG710.FieldByName('AL').AsDateTime,Min(QSGruppoValutatore.FieldByName('T430DATAFINE').AsDateTime,DFinRap));
            if Valore5 <> Valore5Old then
            begin
              Valore5Old:=Valore5;
              FieldByName('DATO5_VALUTATO').AsString:=Copy(IfThen(selSG741.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'S','(' + FormatDateTime('dd/mm',DIni5) + '-' + FormatDateTime('dd/mm',DFin5) + ') ') + Valore5,1,98) + IfThen(FieldByName('DATO5_VALUTATO').AsString <> '',CRLF) + FieldByName('DATO5_VALUTATO').AsString;
            end
            else
              FieldByName('DATO5_VALUTATO').AsString:='(' + FormatDateTime('dd/mm',DIni5) + Copy(FieldByName('DATO5_VALUTATO').AsString,7);
            //Esco dal ciclo se non devo stampare le variazioni, altrimenti passo alla decorrenza precedente
            if (selSG741.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'N')
            or (QSGruppoValutatore.RecNo = 1) then
              Break
            else
              QSGruppoValutatore.Prior;
          end;
          QSGruppoValutatore.LocDatoStorico(selSG710.FieldByName('AL').AsDateTime);
        end;
        if DatoStampa6 = OpzioneFirma6 then
          FieldByName('DATO6_VALUTATO').AsString:=DatoValutatoFirma6
        else if DatoStampa6 <> '' then
        begin
          FieldByName('DATO6_VALUTATO').AsString:=QSGruppoValutatore.FieldByName(DatoStampa6).AsString;
          NomeCampo:=IfThen(Copy(DatoStampa6,1,4) = 'T430',Copy(DatoStampa6,5),DatoStampa6);
          if A000LookupTabella(NomeCampo,selSQL) then
          begin
            if selSQL.VariableIndex('DECORRENZA') >= 0 then
              selSQL.SetVariable('DECORRENZA',selSG710.FieldByName('AL').AsDateTime);
            try
              selSQL.Open;
              FieldByName('DATO6_VALUTATO').AsString:=FieldByName('DATO6_VALUTATO').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',FieldByName('DATO6_VALUTATO').AsString,'DESCRIZIONE'));
            except
            end;
            selSQL.Close;
          end;
        end;
      end;
      //Dati valutatori
      NValutatori:=0;
      ProgValutatori:=selSG710.FieldByName('PROGRESSIVI_VALUTATORI').AsString + ',';
      while Pos(',',ProgValutatori) > 0 do
      begin
        inc(NValutatori);
        ProgValutatore:=StrToIntDef(Copy(ProgValutatori,1,Pos(',',ProgValutatori) - 1),-1);
        selT030.Close;
        selT030.SetVariable('PROGRESSIVO',ProgValutatore);
        selT030.Open;
        FieldByName('MATR_VALUTATORE').AsString:=FieldByName('MATR_VALUTATORE').AsString + IfThen(NValutatori > 1,CRLF) + selT030.FieldByName('MATRICOLA').AsString;
        FieldByName('NOM_VALUTATORE').AsString:=FieldByName('NOM_VALUTATORE').AsString + IfThen(NValutatori > 1,CRLF) + selT030.FieldByName('NOMINATIVO').AsString;
        ProgValutatori:=Copy(ProgValutatori,Pos(',',ProgValutatori) + 1);
      end;
      FieldByName('N_VALUTATORI').AsInteger:=NValutatori;
      if chkLegendaPunteggi.Checked then
      begin
        //Legenda punteggi di valutazione
        with selSG730 do
        begin
          lstLegendaPunteggi.Clear;
          First;
          if FieldByName('CALCOLO_PFP').AsString = 'S' then
            lstLegendaPunteggi.Add('Codice  Valore Descrizione')
          else
            lstLegendaPunteggi.Add('Codice  Descrizione');
          while not Eof do
          begin
            if FieldByName('CALCOLO_PFP').AsString = 'S' then
              lstLegendaPunteggi.Add(Format('%-5s = %6.6s %s',[FieldByName('CODICE').AsString,FormatFloat('##0.00',FieldByName('PUNTEGGIO').AsFloat),FieldByName('DESCRIZIONE').AsString]))
            else
              lstLegendaPunteggi.Add(Format('%-5s = %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
            Next;
          end;
        end;
        FieldByName('LEGENDA_PUNTEGGI').AsString:=lstLegendaPunteggi.Text;
      end;
      if chkPresaVisione.Checked then
      begin
        //Elenco prese visioni della scheda
        with selSG745 do
        begin
          lstPresaVisione.Clear;
          Filter:='(PROGRESSIVO = ' + IntToStr(selSG710.FieldByName('PROGRESSIVO').AsInteger) + ')' +
                  ' AND (DATA = ' + FloatToStr(selSG710.FieldByName('DATA').AsDateTime) + ')' +
                  ' AND (TIPO_VALUTAZIONE = ''' + selSG710.FieldByName('TIPO_VALUTAZIONE').AsString + ''')' +
                  ' AND (STATO_AVANZAMENTO = ' + IntToStr(selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger) + ')' +
                  ' AND (TIPO_CONSEGNA = ''PV'')';
          Filtered:=True;
          First;
          while not Eof do
          begin
            if FieldByName('ESITO').AsString = 'S' then
            begin
              R180SetVariable(selT030,'PROGRESSIVO',FieldByName('PROG_UTENTE').AsInteger);
              selT030.Open;
              if selT030.RecordCount > 0 then
                Nominativo:=selT030.FieldByName('NOMINATIVO').AsString
              else
                Nominativo:=FieldByName('UTENTE').AsString;
              lstPresaVisione.Add(Format('%s %s',[FormatDateTime('dd/mm/yyyy hh:nn',FieldByName('DATA_CONSEGNA').AsDateTime),Nominativo]));
            end;
            Next;
          end;
          Filtered:=False;
        end;
        FieldByName('PRESA_VISIONE').AsString:=lstPresaVisione.Text;
      end;
      FieldByName('ACCETTAZIONE_VALUTATO').AsString:=selSG710.FieldByName('ACCETTAZIONE_VALUTATO').AsString;
      if Fase1StampaDirigenzaConObiettivi or Fase2StampaDirigenzaConObiettivi then
        FieldByName('NOTE_INCENTIVO').AsString:='(#) L''ammontare definitivo è subordinato a:' + CRLF
                                              + '    - livello di raggiungimento degli obiettivi affidati alla Struttura anche in rapporto alle altre;' + CRLF
                                              + '    - livello di raggiungimento degli obiettivi individuali prestazionali, qualitativi e comportamentali;' + CRLF
                                              + '    - modifica in corso d''anno della dotazione organica del personale dirigente della Struttura;' + CRLF
                                              + '    - rispetto dell''orario negoziato;' + CRLF
                                              + '    - presenza effettiva nel periodo di riferimento.';
      FieldByName('PUNTEGGI_ASSEGNATI').AsString:=IfThen(PunteggiAssegnati,'S','N');
      FieldByName('VIS_COL_VALUTABILE').AsString:='N';//Valore iniziale, modificato in seguito
      FieldByName('VIS_COL_SOGLIA_PUNTEGGIO').AsString:='N';//Valore iniziale, modificato in seguito
      Post;
    end;
    CodArea:='';
    selSG711.First;
    while not selSG711.Eof do
    begin
      selSG700.Filtered:=False;
      R180SetVariable(selSG700,'COD_AREA',selSG711.FieldByName('COD_AREA').AsString);
      R180SetVariable(selSG700,'DATA',DataRif);
      selSG700.Open;
      with cdsStampaElementi do
      begin
        Append;
        FieldByName('PROG_VALUTATO').AsInteger:=selSG711.FieldByName('PROGRESSIVO').AsInteger;
        FieldByName('DATA_VALUTAZIONE').AsDateTime:=selSG711.FieldByName('DATA').AsDateTime;
        FieldByName('TIPO_VALUTAZIONE').AsString:=selSG711.FieldByName('TIPO_VALUTAZIONE').AsString;
        FieldByName('STATO_AVANZAMENTO').AsInteger:=selSG711.FieldByName('STATO_AVANZAMENTO').AsInteger;
        FieldByName('COD_AREA').AsString:=selSG711.FieldByName('COD_AREA').AsString;
        if selSG700.RecordCount > 0 then
          FieldByName('DESC_AREA').AsString:=selSG700.FieldByName('D_AREA').AsString;
        if CodArea <> FieldByName('COD_AREA').AsString then
        begin
          if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'ITEM_TUTTI_VALUTABILI') <> 'S' then
          begin
            cdsStampaAnagrafico.Edit;
            cdsStampaAnagrafico.FieldByName('VIS_COL_VALUTABILE').AsString:='S';
            cdsStampaAnagrafico.Post;
          end;
          if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_CON_SOGLIA') = 'S' then
          begin
            cdsStampaAnagrafico.Edit;
            cdsStampaAnagrafico.FieldByName('VIS_COL_SOGLIA_PUNTEGGIO').AsString:='S';
            cdsStampaAnagrafico.Post;
          end;
          TotPercArea:=0;
          PunteggioArea:=0;
          selSG711c.Close;
          selSG711c.SetVariable('DATA',selSG711.FieldByName('DATA').AsDateTime);
          selSG711c.SetVariable('PROGRESSIVO',selSG711.FieldByName('PROGRESSIVO').AsInteger);
          selSG711c.SetVariable('TIPO_VALUTAZIONE',selSG711.FieldByName('TIPO_VALUTAZIONE').AsString);
          selSG711c.SetVariable('STATO_AVANZAMENTO',selSG711.FieldByName('STATO_AVANZAMENTO').AsInteger);
          selSG711c.SetVariable('COD_AREA',selSG711.FieldByName('COD_AREA').AsString);
          selSG711c.Open;
          //Calcolo il peso dell'area
          if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') = 'S' then
            TotPercArea:=StrToFloatDef(ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA'),0);
          while not selSG711c.Eof do
          begin
            if ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'PESO_AREA_BASE_100') <> 'S' then
              TotPercArea:=TotPercArea + selSG711c.FieldByName('PERC_VALUTAZIONE').AsFloat;
            PunteggioArea:=PunteggioArea + selSG711c.FieldByName('PUNTEGGIO_PESATO').AsFloat;
            selSG711c.Next;
          end;
        end;
        CodArea:=FieldByName('COD_AREA').AsString;
        FieldByName('PERC_AREA').AsFloat:=R180Arrotonda(TotPercArea,0.001,'P');
        FieldByName('PUNTEGGIO_AREA').AsString:=FloatToStr(R180Arrotonda(PunteggioArea,0.001,'P'));
        FieldByName('COD_VALUTAZIONE').AsString:=selSG711.FieldByName('COD_VALUTAZIONE').AsString;
        FieldByName('ITEM_PERSONALIZZATO').AsString:='N';
        if not selSG711.FieldByName('DESC_VALUTAZIONE_AGG').IsNull then
        begin
          FieldByName('DESC_VALUTAZIONE').AsString:=selSG711.FieldByName('DESC_VALUTAZIONE_AGG').AsString + IfThen(RecuperaEtichetta('ITEM_PERSONALIZZATO_S') <> '',' (*)');
          FieldByName('ITEM_PERSONALIZZATO').AsString:='S';
        end
        else if (ProprietaArea(FieldByName('COD_AREA').AsString,DataRif,'LINK_CONVOGLIA') = 'S') then
        begin
          selSG700.First;
          while not selSG700.Eof do
          begin
            if not R180InConcat(selSG700.FieldByName('DESCRIZIONE').AsString,StringReplace(FieldByName('DESC_VALUTAZIONE').AsString,CRLF,',',[rfReplaceAll])) then
              FieldByName('DESC_VALUTAZIONE').AsString:=FieldByName('DESC_VALUTAZIONE').AsString + IfThen(not FieldByName('DESC_VALUTAZIONE').IsNull,CRLF) + selSG700.FieldByName('DESCRIZIONE').AsString;
            selSG700.Next;
          end;
        end
        else
          FieldByName('DESC_VALUTAZIONE').AsString:=VarToStr(selSG700.Lookup('COD_VALUTAZIONE',FieldByName('COD_VALUTAZIONE').AsString,'DESCRIZIONE'));
        //AsCurrency perché AsFloat rimane sporco quando si usa R180Arrotonda con 5 cifre decimali
        if selSG711.FieldByName('PERC_VALUTAZIONE').AsCurrency <> 0 then
          FieldByName('PERC_VALUTAZIONE').AsString:=FloatToStr(R180Arrotonda(selSG711.FieldByName('PERC_VALUTAZIONE').AsFloat,0.001,'P'));
        FieldByName('SOGLIA_PUNTEGGIO').AsString:=selSG711.FieldByName('SOGLIA_PUNTEGGIO').AsString;
        FieldByName('VALUTABILE').AsString:=selSG711.FieldByName('VALUTABILE').AsString;
        FieldByName('D_PUNTEGGIO').AsString:=IfThen((VarToStr(selSG730.Lookup('CODICE',selSG711.FieldByName('COD_PUNTEGGIO').AsString,'ITEM_GIUDICABILE')) = 'N') or (ProprietaArea(selSG711.FieldByName('COD_AREA').AsString,DataRif,'PUNTEGGI_CON_PERCENTUALE') = 'N'),selSG711.FieldByName('COD_PUNTEGGIO').AsString,selSG711.FieldByName('PUNTEGGIO').AsString);
        FieldByName('NOTE_PUNTEGGIO').AsString:=selSG711.FieldByName('NOTE_PUNTEGGIO').AsString;
        if selSG711.FieldByName('PUNTEGGIO_PESATO').AsFloat <> 0 then
          FieldByName('PUNTEGGIO_PESATO').AsString:=FloatToStr(R180Arrotonda(selSG711.FieldByName('PUNTEGGIO_PESATO').AsFloat,0.001,'P'));
        Post;
      end;
      selSG711.Next;
    end;
  end;
end;

procedure TS715FDialogStampa.FilePDF;
var i:Integer;
    PathPDF,DocumentoPDF:String;
    MF: TMetaFile;
    Pdf: TPdfDocument;
    //spdf: TQRSynPDFDocumentFilter;
begin
  with S715FStampaValutazioniDtM do
  begin
    // 1: Controllo che ci siano le condizioni per l'esportazione
    //Non creo il file PDF se esiste una scheda con lo stato successivo
    if StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkFilePDF,'Esiste una scheda relativa allo stato successivo!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non creo il file PDF se la scheda è aperta
    if selSG710.FieldByName('CHIUSO').AsString <> 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkFilePDF,'La scheda è aperta!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    PathPDF:=selSG741.FieldByName('PATH_FILEPDF').AsString;
    if not DirectoryExists(PathPDF) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkFilePDF,'Directory ''' + PathPDF + ''' inesistente!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    DocumentoPDF:=GetNomeFilePDF;
    PathPDF:=ExtractFileDir(DocumentoPDF);//path con cartella annuale
    if not DirectoryExists(PathPDF) then
      if not CreateDir(PathPDF) then
        if not ForceDirectories(PathPDF) then
        begin
          RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkFilePDF,'Impossibile creare la directory ''' + PathPDF + '''!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
          Exit;
        end;
    if FileExists(DocumentoPDF) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkFilePDF,'File ''' + ExtractFileName(DocumentoPDF) + ''' già esistente!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    // 2: Richiamo la procedura di caricamento dei ClientDataSet per la stampa
    cdsStampaAnagrafico.EmptyDataSet;
    cdsStampaElementi.EmptyDataSet;
    Stampa;
    // 3: Esporto in PDF
    S715FStampaValutazioni.LEnte.Caption:=Parametri.RagioneSociale;
    S715FStampaValutazioniDtM.cdsStampaElementi.Filtered:=True;
    S715FStampaValutazioniDtM.cdsStampaAnagrafico.First;
    S715FStampaValutazioni.QRep.ShowProgress:=False;
    //generazione PDF/A-1
    Pdf:=TPdfDocument.Create;
    try
      Pdf.DefaultPaperSize:=psA4;
      Pdf.pdfa1:=True;
      S715FStampaValutazioni.QRep.Prepare;
      for i:=1 to S715FStampaValutazioni.QRep.QRPrinter.PageCount do
      begin
        Pdf.AddPage;
        MF:=S715FStampaValutazioni.QRep.QRPrinter.GetPage(i);
        try
          // draw the page content
          Pdf.Canvas.RenderMetaFile(MF,1,0,0);
        finally
          MF.Free;
        end;
      end;
      Pdf.SaveToFile(DocumentoPDF);
      AggiornamentoEseguito:=True;
    finally
      Pdf.free;
    end;
    S715FStampaValutazioniDtM.cdsStampaElementi.Filtered:=False;
    {Altri metodi non performanti al 10/04/2013
    //Esportazione in PDF normale
    //S715FStampaValutazioni.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    //Esportazione tramite PDFCreator
    //Settare prima la stampante PDFCreator
    //S715FStampaValutazioni.QRep.Print;
    //S715FStampaValutazioni.QRep.LastPage:=10;//VA IN ERRORE
    //Esportazione in PDF Synopse
    //http://forum.quickreport.co.uk/default.aspx?g=posts&t=589
    //http://synopse.info/forum/viewtopic.php?id=338
    //http://synopse.info/forum/viewtopic.php?pid=1304#p1304
    (*
    spdf:=TQRSynPDFDocumentFilter.Create(DocumentoPDF);
    //tpdfdocument(spdf).pdfa1:=True;//VA IN ERRORE
    S715FStampaValutazioni.QRep.ExportToFilter(spdf);
    spdf.Free;
    *)}
  end;
end;

procedure TS715FDialogStampa.Protocolla;
var PathPDF,NomeFilePDF,DocumentoPDF:String;
    RIO: THTTPRIO;
    PSPT:ProtocolloServicePortType;
    PI:ProtocolInsert;
    PIR:ProtocolInsertResponse;
    //02/07/2013 sl:senderlist;
    sl:senderlist2;//02/07/2013
    //02/07/2013 rl:recipientList;
    rl:recipientList2;//02/07/2013
    //08/11/2013 ol:officeList2;
    ol:officeList4;//08/11/2013
    //08/11/2013 dl:documentList2;
    dl:documentList3;//08/11/2013
    //08/11/2013 fl:filingList2;
    fl:filingList5;//08/11/2013
    //08/11/2013 ml:mnemonicList2;
    ml:mnemonicList3;//08/11/2013
    dataNow,s_app,Dato,Valore:String;
    OraIniProt,OraFinProt,messDurata:String;
    Y,M,D,H,N,S:Word;
  function FileToByteArray(const FileName:string):TByteDynArray;
  const BLOCK_SIZE=1024;
  var BytesRead,BytesToWrite,Count:integer;
      F:File of Byte;
      pTemp:Pointer;
  begin
    AssignFile(F,FileName);
    Reset(F);
    try
     Count:=FileSize(F);
     SetLength(Result,Count);
     pTemp:=@Result[0];
     BytesRead:=BLOCK_SIZE;
     while (BytesRead = BLOCK_SIZE) do
     begin
       BytesToWrite:=Min(Count,BLOCK_SIZE);
       BlockRead(F,pTemp^,BytesToWrite,BytesRead);
       pTemp:=Pointer(LongInt(pTemp) + BLOCK_SIZE);
       Count:=Count - BytesRead;
     end;
    finally
      CloseFile(F);
    end;
  end;
  function GetDatoProtocollo(Tipo:string):string;
  begin
    Result:=VarToStr(S715FStampaValutazioniDtM.S715FStampaValutazioniMW.selSG751.Lookup('TIPO',UpperCase(Tipo),'DATO'));
  end;
begin
  with S715FStampaValutazioniDtM do
  begin
    //Non protocollo la scheda se esiste una scheda con lo stato successivo
    if StrToIntDef(VarToStr(selSG710.Lookup('DATA;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',VarArrayOf([selSG710.FieldByName('DATA').AsDateTime,selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger + 1]),'PROGRESSIVO')),0) = C700Progressivo then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'Esiste una scheda relativa allo stato successivo!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Protocollo soltanto le schede chiuse
    if selSG710.FieldByName('CHIUSO').AsString <> 'S' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'La scheda è aperta!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Non protocollo la scheda se è già stata protocollata
    if SchedaProtocollata then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'La scheda è già stata protocollata!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Protocollo soltanto se la parametrizzazione esiste
    if S715FStampaValutazioniMW.selSG750.RecordCount = 0 then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'La parametrizzazione associata alla regola ' + selSG710.FieldByName('CODREGOLA').AsString + ' non è valida!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Protocollo soltanto se la parametrizzazione è di tipo A (Aosta_regione)
    if S715FStampaValutazioniMW.selSG750.FieldByName('TIPOXML').AsString <> 'A' then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'La parametrizzazione ' + S715FStampaValutazioniMW.selSG750.FieldByName('CODICE').AsString + ' è di un tipo non gestito!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    //Protocollo soltanto se raggiungo il file pdf archiviato
    DocumentoPDF:=GetNomeFilePDF;
    //DocumentoPDF:='C:\ElencoDipendenti.pdf';
    PathPDF:=ExtractFileDir(DocumentoPDF);//path con cartella annuale
    if not DirectoryExists(PathPDF) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'Directory ''' + PathPDF + ''' inesistente!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    NomeFilePDF:=ExtractFileName(DocumentoPDF);
    if not FileExists(DocumentoPDF) then
    begin
      RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'File ''' + NomeFilePDF + ''' inesistente!'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      Exit;
    end;
    QSGruppoValutatore.LocDatoStorico(selSG710.FieldByName('AL').AsDateTime);
    //Richiamo il WebService per la protocollazione
    try
      dataNow:=FormatDateTime('yyyymmddhhnnss',IncMinute(Now,1)); //Attenzione! Se elaborazione notturna gestire: Now + 1 o 2 ore rispetto a UTC per cavallo notturno
      Y:=StrToInt(Copy(dataNow,1,4));
      M:=StrToInt(Copy(dataNow,5,2));
      D:=StrToInt(Copy(dataNow,7,2));
      H:=StrToInt(Copy(dataNow,9,2));
      N:=StrToInt(Copy(dataNow,11,2));
      S:=StrToInt(Copy(dataNow,13,2));
      //DA 14/07/2014 (inizio)
      //vedi: http://stackoverflow.com/questions/2898261/web-service-time-out-errors-in-delphi
      //PSPT:=GetProtocolloServicePortType(False,selSG750.FieldByName('WS_URL').AsString);
      RIO:=THTTPRIO.Create(nil);
      PSPT:=GetProtocolloServicePortType(False,S715FStampaValutazioniMW.selSG750.FieldByName('WS_URL').AsString,RIO);
      FconnectTimeoutMS:=300000;//5 minuti
      FsendTimeoutMS:=300000;//5 minuti
      FreceiveTimeoutMS:=1200000;//20 minuti
      //RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnazione transport.OnBeforePost (1 - inizio)'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      RIO.HTTPWebNode.OnBeforePost:=configureHttpRequest;
      //RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnazione transport.OnBeforePost (2 - fine)'),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
      //DA 14/07/2014 (fine)
      PI:=ProtocolInsert.Create;
      PI.user:=user.Create;
      PI.user.code:=GetDatoProtocollo('user.code');
      PI.user.password:=GetDatoProtocollo('user.password');
      PI.operatingOfficeCode:=GetDatoProtocollo('operatingOfficeCode');
      PI.officeCode:=GetDatoProtocollo('officeCode');
      PI.registerCode:=GetDatoProtocollo('registerCode');
      s_app:=GetDatoProtocollo('direction');
      if Trim(UpperCase(s_app)) = 'A' then
        //08/11/2013 PI.direction:=direction(0)
        PI.direction:=direction2(0)//08/11/2013
      else if Trim(UpperCase(s_app)) = 'P' then
        //08/11/2013 PI.direction:=direction(1);
        PI.direction:=direction2(1);//08/11/2013
      PI.sequenceCode:=GetDatoProtocollo('sequenceCode');
      s_app:=GetDatoProtocollo('subjectDocument');
      s_app:=StringReplace(s_app,'<#>TIPO<#>',IfThen(selSG710.FieldByName('TIPO_VALUTAZIONE').AsString = 'V','valutazione','autovalutazione'),[rfReplaceAll]);
      s_app:=StringReplace(s_app,'<#>DATA<#>',FormatDateTime(IfThen(selSG710.FieldByName('DATA').AsDateTime = EncodeDate(R180Anno(selSG710.FieldByName('DATA').AsDateTime),12,31),'yyyy','dd/mm/yy'),selSG710.FieldByName('DATA').AsDateTime),[rfReplaceAll]);
      s_app:=StringReplace(s_app,'<#>COGNOME<#>',C700SelAnagrafe.FieldByName('COGNOME').AsString,[rfReplaceAll]);
      s_app:=StringReplace(s_app,'<#>NOME<#>',C700SelAnagrafe.FieldByName('NOME').AsString,[rfReplaceAll]);
      s_app:=StringReplace(s_app,'<#>MATRICOLA<#>',C700SelAnagrafe.FieldByName('MATRICOLA').AsString,[rfReplaceAll]);
      PI.subjectDocument:=s_app;
      PI.receptionSendingDate:=TXSDateTime.Create;
      s_app:=GetDatoProtocollo('receptionSendingDate');
      if Trim(UpperCase(s_app)) = 'NOW' then
      begin
        PI.receptionSendingDate.Year:=Y;
        PI.receptionSendingDate.Month:=M;
        PI.receptionSendingDate.Day:=D;
        PI.receptionSendingDate.Hour:=H;
        PI.receptionSendingDate.Minute:=N;
        PI.receptionSendingDate.Second:=S;
      end;
      PI.documentDetails:=documentDetails.Create;
      PI.documentDetails.date:=TXSDateTime.Create;
      s_app:=GetDatoProtocollo('documentDetails.date');
      if Trim(UpperCase(s_app)) = 'NOW' then
      begin
        PI.documentDetails.date.Year:=Y;
        PI.documentDetails.date.Month:=M;
        PI.documentDetails.date.Day:=D;
        PI.documentDetails.date.Hour:=H;
        PI.documentDetails.date.Minute:=N;
        PI.documentDetails.date.Second:=S;
      end;
      PI.documentDetails.documentTypeCode:=GetDatoProtocollo('documentDetails.documentTypeCode');
      (*//senderList
      SetLength(sl,0);
      SetLength(sl,Length(sl) + 1);
      sl[0]:=S715UProtocolloService.sender.Create;
      sl[0].code:=GetDatoProtocollo('senderList.code');
      sl[0].typeCode:=GetDatoProtocollo('senderList.typeCode');
      sl[0].referenceNumber:=GetDatoProtocollo('senderList.referenceNumber');
      PI.senderList:=sl;*)
      //senderList (1°)
      SetLength(sl,0);
      SetLength(sl,Length(sl) + 1);
      sl[0]:=S715UProtocolloService.sender.Create;
      s_app:=GetDatoProtocollo('senderList[0].code');
      Dato:=S715FStampaValutazioniMW.GetDatoAnagraficoProtocollo('senderList[0].code',s_app);
      if R180In(Copy(Dato,1,4),['T430','P430']) then
        Valore:=QSGruppoValutatore.FieldByName(Dato).AsString
      else
        Valore:=C700SelAnagrafe.FieldByName(Dato).AsString;
      sl[0].code:=StringReplace(s_app,'<#>' + Dato + '<#>',Valore,[rfReplaceAll]);
      //02/07/2013 sl[0].typeCode:=GetDatoProtocollo('senderList[0].typeCode');
      //08/11/2013 sl[0].type_:=GetDatoProtocollo('senderList[0].typeCode');//02/07/2013
      sl[0].typeCode:=GetDatoProtocollo('senderList[0].typeCode');//08/11/2013
      sl[0].referenceNumber:=GetDatoProtocollo('senderList[0].referenceNumber');
      //senderList (2°)
      s_app:=GetDatoProtocollo('senderList[1].code');
      Dato:=S715FStampaValutazioniMW.GetDatoAnagraficoProtocollo('senderList[1].code',s_app);
      if R180In(Copy(Dato,1,4),['T430','P430']) then
        Valore:=QSGruppoValutatore.FieldByName(Dato).AsString
      else
        Valore:=C700SelAnagrafe.FieldByName(Dato).AsString;
      //Lo valorizzo solo se la stringa è fissa o se il dato anagrafico collegato è valorizzato
      if (s_app <> '') and ((Dato = '') or (Valore <> '')) then
      begin
        SetLength(sl,Length(sl) + 1);
        sl[1]:=S715UProtocolloService.sender.Create;
        sl[1].code:=StringReplace(s_app,'<#>' + Dato + '<#>',Valore,[rfReplaceAll]);
        //02/07/2013 sl[1].typeCode:=GetDatoProtocollo('senderList[1].typeCode');
        //08/11/2013 sl[1].type_:=GetDatoProtocollo('senderList[1].typeCode');//02/07/2013
        sl[1].typeCode:=GetDatoProtocollo('senderList[1].typeCode');//08/11/2013
        sl[1].referenceNumber:=GetDatoProtocollo('senderList[1].referenceNumber');
      end;
      PI.senderList:=sl;
      //recipientList
      SetLength(rl,0);
      SetLength(rl,Length(rl) + 1);
      rl[0]:=recipient.Create;
      (*s_app:=GetDatoProtocollo('recipientList.code');
      rl[0].code:=StringReplace(s_app,'<#>MATRICOLA<#>',C700SelAnagrafe.FieldByName('MATRICOLA').AsString,[rfReplaceAll]);*)
      rl[0].code:=GetDatoProtocollo('recipientList.code');
      rl[0].referenceDate:=TXSDateTime.Create;
      s_app:=GetDatoProtocollo('recipientList.referenceDate');
      if Trim(UpperCase(s_app)) = 'NOW' then
      begin
        rl[0].referenceDate.Year:=Y;
        rl[0].referenceDate.Month:=M;
        rl[0].referenceDate.Day:=D;
        rl[0].referenceDate.Hour:=H;
        rl[0].referenceDate.Minute:=N;
        rl[0].referenceDate.Second:=S;
      end;
      rl[0].transmissionMode:=GetDatoProtocollo('recipientList.transmissionMode');
      //02/07/2013 rl[0].typeCode:=GetDatoProtocollo('recipientList.typeCode');
      //08/11/2013 rl[0].type_:=GetDatoProtocollo('recipientList.typeCode');//02/07/2013
      rl[0].typeCode:=GetDatoProtocollo('recipientList.typeCode');//08/11/2013
      PI.recipientList:=rl;
      //officeList
      SetLength(ol,0);
      SetLength(ol,Length(ol) + 1);
      ol[0]:=office.Create;
      ol[0].code:=GetDatoProtocollo('officeList.code');
      PI.officeList:=ol;
      //documentlist
      SetLength(dl,0);
      SetLength(dl,Length(dl) + 1);
      dl[0]:=document.Create;
      dl[0].name_:=NomeFilePDF;
      s_app:=GetDatoProtocollo('documentlist.primary');
      dl[0].primary:=Trim(UpperCase(s_app)) = 'TRUE';
      dl[0].file_:=FileToByteArray(DocumentoPDF);
      PI.documentlist:=dl;
      //filingList
      SetLength(fl,0);
      SetLength(fl,Length(fl) + 1);
      fl[0]:=filing.Create;
      fl[0].code:=GetDatoProtocollo('filingList.code');
      PI.filingList:=fl;
      //mnemonicList
      SetLength(ml,0);
      SetLength(ml,Length(ml) + 1);
      ml[0]:=mnemonic.Create;
      ml[0].code:=GetDatoProtocollo('mnemonicList.code');
      ml[0].typeCode:=GetDatoProtocollo('mnemonicList.typeCode');
      PI.mnemonicList:=ml;
      try
        OraIniProt:=FormatDateTime('dd/mm/yyyy hh:nn:ss',Now);
        messDurata:='';
        PIR:=PSPT.protocolInsert(PI);
        if PIR.result then
        begin
          selSG710.Edit;
          with PIR.recordIdentifierList[0] do
          begin
            selSG710.FieldByName('TIPO_PROTOCOLLO').AsString:='A';//Protocollazione automatica
            selSG710.FieldByName('NUMERO_PROTOCOLLO').AsInteger:=number;
            selSG710.FieldByName('ANNO_PROTOCOLLO').AsInteger:=year;
            selSG710.FieldByName('DATA_PROTOCOLLO').AsDateTime:=EncodeDate(registrationDate.Year,registrationDate.Month,registrationDate.Day);
          end;
          selSG710.Post;
          AggiornamentoEseguito:=True;
          inc(SchedeProtocollate);
          SessioneOracle.Commit;
        end
        else
          RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'Param.: ' + S715FStampaValutazioniMW.selSG750.FieldByName('CODICE').AsString + '; Errore nel richiamo al WebService! Codice: ' + PIR.error.code + '; Descrizione: ' + PIR.error.description),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        if PIR <> nil then PIR.Free;
      except
        on E:exception do
        begin
          OraFinProt:=FormatDateTime('dd/mm/yyyy hh:nn:ss',Now);
          if Pos('The operation timed out',E.Message) > 0 then
            messDurata:=' (Invio: ' + OraIniProt + '; TimeOut: ' + OraFinProt + ')';
          RegistraMsg.InserisciMessaggio('A',FormattaAnomalie(chkProtocolla,'Param.: ' + S715FStampaValutazioniMW.selSG750.FieldByName('CODICE').AsString + '; Errore nel richiamo al WebService! ' + E.Message + messDurata),'',selSG710.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
    finally
      if PI <> nil then PI.Free;
    end;
  end;
end;

procedure TS715FDialogStampa.configureHttpRequest(const HTTPReqResp: THTTPReqResp; Data: Pointer);
begin
  //RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnazione Internet options (1 - inizio)'),'',S715FStampaValutazioniDtM.selSG710.FieldByName('PROGRESSIVO').AsInteger);
  InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FconnectTimeoutMS), SizeOf(FconnectTimeoutMS));
  RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnata INTERNET_OPTION_CONNECT_TIMEOUT: ' + IntToStr(FconnectTimeoutMS)),'',S715FStampaValutazioniDtM.selSG710.FieldByName('PROGRESSIVO').AsInteger);
  InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FsendTimeoutMS), SizeOf(FsendTimeoutMS));
  RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnata INTERNET_OPTION_SEND_TIMEOUT: ' + IntToStr(FsendTimeoutMS)),'',S715FStampaValutazioniDtM.selSG710.FieldByName('PROGRESSIVO').AsInteger);
  InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FreceiveTimeoutMS), SizeOf(FreceiveTimeoutMS));
  RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnata INTERNET_OPTION_RECEIVE_TIMEOUT: ' + IntToStr(FreceiveTimeoutMS)),'',S715FStampaValutazioniDtM.selSG710.FieldByName('PROGRESSIVO').AsInteger);
  //RegistraMsg.InserisciMessaggio('I',FormattaAnomalie(chkProtocolla,'Assegnazione Internet options (2 - fine)'),'',S715FStampaValutazioniDtM.selSG710.FieldByName('PROGRESSIVO').AsInteger);
end;

function TS715FDialogStampa.GetNomeFilePDF: string;
begin
  with S715FStampaValutazioniDtM do
    Result:=selSG741.FieldByName('PATH_FILEPDF').AsString                              //directory di partenza
            + '\' + FormatDateTime('yyyy',selSG710.FieldByName('DATA').AsDateTime)     //cartella annuale
            + '\' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString                  //matricola
            + '_' + FormatDateTime('yyyymmdd',selSG710.FieldByName('DATA').AsDateTime) //data
            + '_' + selSG710.FieldByName('TIPO_VALUTAZIONE').AsString                  //tipo
            + '.pdf';
end;

procedure TS715FDialogStampa.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'S715','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

end.

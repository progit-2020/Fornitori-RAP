unit A061UDettAssenze;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali, Math, StrUtils,
  A000UCostanti, A000USessione,A000UInterfaccia, Grids, DBGrids, ExtCtrls,DB,ComCtrls, checklst,
  Menus, RegistrazioneLog, A003UDataLavoroBis, C004UParamForm, QueryStorico,
  Oracle, SelAnagrafe, C005UDatiAnagrafici, C700USelezioneAnagrafe, Variants,
  Mask, C013UCheckList, A150UAccorpamentoCausali, R500Lin, A000UMessaggi, A061UDettAssenzeMW,
  C020UVisualizzaDataSet, Generics.Collections;

type
  TA061FDettAssenze = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnl13: TPanel;
    LstCausali: TCheckListBox;
    pnl2: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnClose: TBitBtn;
    BtnStampa: TBitBtn;
    gpbRegStamp: TGroupBox;
    chkSalvaUltRegStamp: TCheckBox;
    chkSoloAssRegSucc: TCheckBox;
    rgpAssenzeConsiderate: TRadioGroup;
    pnl1: TPanel;
    pnl12: TPanel;
    lblDaData: TLabel;
    edtDaData: TMaskEdit;
    sbtDaData: TSpeedButton;
    lblAData: TLabel;
    edtAData: TMaskEdit;
    sbtAData: TSpeedButton;
    lblDaRegStamp: TLabel;
    edtDaRegStamp: TMaskEdit;
    sbtDaRegStamp: TSpeedButton;
    lblARegStamp: TLabel;
    edtARegStamp: TMaskEdit;
    sbtARegStamp: TSpeedButton;
    gpbTotali: TGroupBox;
    chkTotGenerali: TCheckBox;
    chkTotIndividuali: TCheckBox;
    chkTotRaggrup: TCheckBox;
    chkTotFam: TCheckBox;
    gpbConteggi: TGroupBox;
    lblGGMinCont: TLabel;
    chkRiduzioni: TCheckBox;
    edtGGMinCont: TEdit;
    chkConiuge: TCheckBox;
    chkCausaliCumulate: TCheckBox;
    chkGiorniSignificativi: TCheckBox;
    gpbDati: TGroupBox;
    Label3: TLabel;
    dcmbCampo: TDBLookupComboBox;
    chkSaltoPagIndividuale: TCheckBox;
    chkSaltoPagRaggrup: TCheckBox;
    chkDettGiorn: TCheckBox;
    chkDatiIndividuali: TCheckBox;
    chkDettPer: TCheckBox;
    rgpValidate: TRadioGroup;
    rgpOrdinamento: TRadioGroup;
    chkSoloRiduzioni: TCheckBox;
    lstCodAcc: TCheckListBox;
    PopupMenu2: TPopupMenu;
    Selezionatutto2: TMenuItem;
    Annullatutto2: TMenuItem;
    pnl11: TPanel;
    lblTipoAcc: TLabel;
    dcmbTipoAcc: TDBLookupComboBox;
    dlblTipoAcc: TDBText;
    pnl121: TPanel;
    lblCodAcc: TLabel;
    pnl131: TPanel;
    lblCodCau: TLabel;
    PopupMenu3: TPopupMenu;
    Accedi1: TMenuItem;
    chkConteggiGG: TCheckBox;
    chkStampaNominativo: TCheckBox;
    chkStampaMatricola: TCheckBox;
    chkStampaBadge: TCheckBox;
    chkPeriodoServizio: TCheckBox;
    btnTabella: TBitBtn;
    rgpTipoDataFam: TRadioGroup;
    procedure dcmbCampoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure chkDatiIndividualiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure chkSoloAssRegSuccClick(Sender: TObject);
    procedure edtGGMinContKeyPress(Sender: TObject; var Key: Char);
    procedure dcmbCampoCloseUp(Sender: TObject);
    procedure dcmbCampoKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure LstCausaliClickCheck(Sender: TObject);
    procedure dcmbTipoAccClick(Sender: TObject);
    procedure sbtDaDataClick(Sender: TObject);
    procedure sbtADataClick(Sender: TObject);
    procedure edtDaDataExit(Sender: TObject);
    procedure edtADataExit(Sender: TObject);
    procedure edtDaRegStampExit(Sender: TObject);
    procedure edtARegStampExit(Sender: TObject);
    procedure sbtDaRegStampClick(Sender: TObject);
    procedure sbtARegStampClick(Sender: TObject);
    procedure lstCodAccClickCheck(Sender: TObject);
    procedure Selezionatutto2Click(Sender: TObject);
    procedure Annullatutto2Click(Sender: TObject);
    procedure dcmbTipoAccKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Accedi1Click(Sender: TObject);
    procedure edtADataDblClick(Sender: TObject);
    procedure chkDettGiornClick(Sender: TObject);
    procedure chkDettPerClick(Sender: TObject);
    procedure chkTotFamClick(Sender: TObject);
  private
    SelTutto, SelAcc:Boolean;
    CampoRagg, NomeCampo, ElencoCausali: String;
    procedure ConvChkLstToLst(MyLista:TList<TRecCodDesc>);
    procedure AbilitaAss;
    procedure AbilitaAccorpamenti;
    procedure CaricaListaCausali;
    procedure CaricaListaAccorpamenti;
    procedure ImpostaVariabiliA061MW;
    procedure ScorriQueryAnagrafica;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    A061MW: TA061FDettAssenzaMW;
    DaData, AData, DaRegStamp, ARegStamp: TDateTime;
  end;

var
  A061FDettAssenze: TA061FDettAssenze;

procedure OpenA061DettAssenze(Prog:LongInt);

implementation

uses A061UStampa;

{$R *.DFM}

procedure OpenA061DettAssenze(Prog:LongInt);
{Elenco Assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA061DettAssenze') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
  end;
  A061FDettAssenze:=TA061FDettAssenze.Create(nil);
  with A061FDettAssenze do
    try
      C700Progressivo:=Prog;
      //Massimo: Eliminato DM e lasciato solo MW
      //A061FDettAssenzeDtM1:=TA061FDettAssenzeDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      //A061FDettAssenzeDtM1.Free;
      if A061MW <> nil then
        A061MW.Free;
      Free;
    end;
end;

procedure TA061FDettAssenze.FormCreate(Sender: TObject);
begin
  A061MW:=TA061FDettAssenzaMW.Create(Self);
end;

procedure TA061FDettAssenze.FormShow(Sender: TObject);
begin
  A061FStampa:=TA061FStampa.Create(nil);
  C001SettaQuickReport(A061FStampa.RepR);
  dlblTipoAcc.DataSource:=A061MW.D255;
  dcmbTipoAcc.ListSource:=A061MW.D255;
  dcmbCampo.ListSource:=A061MW.D010;
  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',DaData);
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',AData);
  CaricaListaAccorpamenti; //necessario per avere la lista completa
  GetParametriFunzione;
  CaricaListaAccorpamenti; //necessario per aggiornare i dati dopo il caricamento dei parametri
  AbilitaAss;
  AbilitaAccorpamenti;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A061MW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

procedure TA061FDettAssenze.FormDestroy(Sender: TObject);
begin
  A061FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA061FDettAssenze.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  if chkSalvaUltRegStamp.Checked then
  begin
    //Memorizzo sulla tabella di log se c'é stata memorizzazione della data di ultima registrazione stampata
    RegistraLog.SettaProprieta('M','T044_STORICOGIUSTIFICATIVI',Copy(Self.Name,1,4),nil,True);
    RegistraLog.InserisciDato(' DATA ULTIMA REGISTRAZIONE STAMPATA ','',Format('%s',[DateToStr(ARegStamp)]));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA061FDettAssenze.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A061FStampa.RepR);
end;

procedure TA061FDettAssenze.AbilitaAss;
var i:Integer;
begin
  rgpValidate.Enabled:=False;
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.Checked[i] then
      if VarToStr(A061MW.Q265.Lookup('CODICE',Trim(Copy(LstCausali.Items[i],1,5)),'VALIDAZIONE')) = 'S' then
        rgpValidate.Enabled:=True;
  if Not rgpValidate.Enabled then
    rgpValidate.ItemIndex:=2;
end;

procedure TA061FDettAssenze.Accedi1Click(Sender: TObject);
var
  TipoAcc: String;
begin
  inherited;
  TipoAcc:=dcmbTipoAcc.Text;
  OpenA150AccorpamentoCausali(dcmbTipoAcc.Text,'');
  A061MW.selT255.Refresh;
  dcmbTipoAcc.KeyValue:=TipoAcc;
  AbilitaAccorpamenti;
  SelTutto:=False;
  CaricaListaAccorpamenti;
end;

procedure TA061FDettAssenze.LstCausaliClickCheck(Sender: TObject);
begin
  AbilitaAss;
end;

procedure TA061FDettAssenze.lstCodAccClickCheck(Sender: TObject);
begin
  SelAcc:=lstCodAcc.Checked[lstCodAcc.ItemIndex];
  CaricaListaCausali;
end;

procedure TA061FDettAssenze.ScorriQueryAnagrafica;
var GGMinCont: String;
begin
  //PeriodoConteggi(DaData,AData);  Commentato già prima di MW
  GGMinCont:=edtGGMinCont.Text;
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  if chkConteggiGG.Checked then
    A061MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
  try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      ImpostaVariabiliA061MW;
      A061MW.ImpostaQueryGiustificativi(DaData,AData);
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA061FDettAssenze.ConvChkLstToLst(MyLista:TList<TRecCodDesc>);
var
  i:integer;
  TempRec:TRecCodDesc;
begin
  MyLista.Clear;
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.Checked[i] then
    begin
      TempRec.Codice:=Trim(Copy(LstCausali.Items[i],1,5));
      TempRec.Descrizione:=Trim(Copy(LstCausali.Items[i],7,40));
      MyLista.Add(TempRec);
    end;
end;

procedure TA061FDettAssenze.BtnPreViewClick(Sender: TObject);
var
  App,S:String;
begin
  ConvChkLstToLst(A061MW.A061MW_LstCausali);
  ElencoCausali:=A061MW.GetCausali;
  if (not chkDatiIndividuali.Checked) and (not chkTotGenerali.Checked) then
    raise Exception.Create(A000MSG_A061_ERR_SELEZIONE_MANCANTE);
  if ElencoCausali = '' then
    raise Exception.Create(A000MSG_A061_ERR_CAUSALE);
  if dcmbCampo.KeyValue <> Null then
    App:=dcmbCampo.KeyValue
  else
    App:='';
  if App <> '' then
  begin
    NomeCampo:=dcmbCampo.Text;
    CampoRagg:=App;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,App) then
    begin
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  if not chkSoloAssRegSucc.Checked then
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DaData,AData) then
      C700SelAnagrafe.Close;
  end
  else
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DaRegStamp,ARegStamp) then
      C700SelAnagrafe.Close;
  end;
  C700SelAnagrafe.Open;
  frmSelAnagrafe.Numrecords;
  ImpostaVariabiliA061MW;
  A061MW.CreaTabellaStampa;
  A061MW.CreaSqlGiustificativi(ElencoCausali);
  Screen.Cursor:=crHourGlass;
  ScorriQueryAnagrafica;
  Screen.Cursor:=crDefault;
  if Sender <> btnTabella then
  begin
    A061FStampa.CampoRagg:=CampoRagg;
    A061FStampa.NomeCampo:=NomeCampo;
    A061FStampa.DaData:=DaData;
    A061FStampa.AData:=AData;
    A061FStampa.DaRegStamp:=DaRegStamp;
    A061FStampa.ARegStamp:=ARegStamp;
    A061FStampa.CreaReport(Sender = BtnPreView);
    A061MW.TabellaStampa.Close;
  end
  else
    OpenC020VisualizzaDataSet('<A061> Dettaglio assenze individuali',A061MW.TabellaStampa,1000,400);
end;

procedure TA061FDettAssenze.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to LstCausali.Items.Count - 1 do
    LstCausali.Checked[i]:=True;
  AbilitaAss;
end;

procedure TA061FDettAssenze.Selezionatutto2Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstCodAcc.Items.Count - 1 do
    lstCodAcc.Checked[i]:=True;
  SelTutto:=True;
  CaricaListaCausali;
end;

procedure TA061FDettAssenze.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to LstCausali.Items.Count - 1 do
    LstCausali.Checked[i]:=False;
  AbilitaAss;
end;

procedure TA061FDettAssenze.Annullatutto2Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstCodAcc.Items.Count - 1 do
    lstCodAcc.Checked[i]:=False;
  CaricaListaCausali;
end;

procedure TA061FDettAssenze.chkDatiIndividualiClick(Sender: TObject);
begin
  chkTotIndividuali.Enabled:=chkDatiIndividuali.Checked;
  chkSaltoPagIndividuale.Enabled:=chkDatiIndividuali.Checked;
  chkConiuge.Enabled:=chkDatiIndividuali.Checked;
  chkTotFam.Enabled:=chkDatiIndividuali.Checked;
  chkRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  chkSoloRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  chkStampaNominativo.Enabled:=chkDatiIndividuali.Checked;
  chkStampaMatricola.Enabled:=chkDatiIndividuali.Checked;
  chkStampaBadge.Enabled:=chkDatiIndividuali.Checked;
  if not chkDatiIndividuali.Checked then
  begin
    chkRiduzioni.Checked:=False;
    chkSoloRiduzioni.Checked:=False;
    chkTotIndividuali.Checked:=False;
    chkSaltoPagIndividuale.Checked:=False;
    chkConiuge.Checked:=False;
    chkTotFam.Checked:=False;
  end;
  chkConteggiGG.Enabled:=(chkDatiIndividuali.Checked) and (not chkSoloAssRegSucc.Checked);
  if not chkConteggiGG.Enabled then
    chkConteggiGG.Checked:=False;
  chkDettGiorn.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettGiorn.Enabled then
    chkDettGiorn.Checked:=False;
  chkDettPer.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettPer.Enabled then
    chkDettPer.Checked:=False;
  chkGiorniSignificativi.Enabled:=chkDettPer.Checked;
  if not chkGiorniSignificativi.Enabled then
    chkGiorniSignificativi.Checked:=False;
  edtGGMinCont.Enabled:=chkDettPer.Checked;
  if not edtGGMinCont.Enabled then
    edtGGMinCont.Text:='';
  lblGGMinCont.Enabled:=chkDettPer.Checked;
  chkCausaliCumulate.Enabled:=chkDettPer.Checked;
  if not chkCausaliCumulate.Enabled then
    chkCausaliCumulate.Checked:=False;
  chkSoloRiduzioni.Enabled:=chkRiduzioni.Checked;
  if not chkRiduzioni.Checked then
    chkSoloRiduzioni.Checked:=False;
  chkTotFam.Enabled:=chkTotIndividuali.Checked;
  if not chkTotFam.Enabled then
    chkTotFam.Checked:=False;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  rgpTipoDataFam.Enabled:=chkTotFam.Checked;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TA061FDettAssenze.chkDettGiornClick(Sender: TObject);
begin
  if chkDettGiorn.Checked then
    chkDettPer.Checked:=False;
  chkDatiIndividualiClick(nil);
end;

procedure TA061FDettAssenze.chkDettPerClick(Sender: TObject);
begin
  if chkDettPer.Checked then
    chkDettGiorn.Checked:=False;
  chkDatiIndividualiClick(nil);
end;

procedure TA061FDettAssenze.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
begin
  //Leggo la data ultima registrazione stampata dai parametri con progressivo operatore -1
  CreaC004(SessioneOracle,'A061',-1);
  DaRegStamp:=StrToDate(C004FParamForm.GetParametro('DATAULTREGSTAMP',FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro))) + 1;
  edtDaRegStamp.Text:=FormatDateTime('dd/mm/yyyy',DaRegStamp);
  ARegStamp:=Parametri.DataLavoro;
  edtARegStamp.Text:=FormatDateTime('dd/mm/yyyy',ARegStamp);
  C004FParamForm.Free;
  CreaC004(SessioneOracle,'A061',Parametri.ProgOper);
  dcmbTipoAcc.KeyValue:=C004FParamForm.GetParametro('TIPOACCORPAMENTO',dcmbTipoAcc.Text);
  chkSoloAssRegSucc.Checked:=C004FParamForm.GetParametro('SOLOASSREGSUCC','N') = 'S';
  chkSalvaUltRegStamp.Checked:=C004FParamForm.GetParametro('SALVAULTREGSTAMP','N') = 'S';
  rgpAssenzeConsiderate.ItemIndex:=StrToInt(C004FParamForm.GetParametro('ASSENZECONSIDERATE','0'));
  chkTotIndividuali.Checked:=C004FParamForm.GetParametro('TOTINDIVIDUALI','N') = 'S';
  chkTotRaggrup.Checked:=C004FParamForm.GetParametro('TOTGRUPPO','N') = 'S';
  chkTotGenerali.Checked:=C004FParamForm.GetParametro('TOTGENERALI','N') = 'S';
  chkDatiIndividuali.Checked:=C004FParamForm.GetParametro('DATIINDIVIDUALI','N') = 'S';
  chkStampaNominativo.Checked:=C004FParamForm.GetParametro('STAMPANOMINATIVO','S') = 'S';
  chkStampaMatricola.Checked:=C004FParamForm.GetParametro('STAMPAMATRICOLA','S') = 'S';
  chkStampaBadge.Checked:=C004FParamForm.GetParametro('STAMPABADGE','S') = 'S';
  chkDettPer.Checked:=C004FParamForm.GetParametro('PERIODICO','N') = 'S';
  chkDettGiorn.Checked:=C004FParamForm.GetParametro('DETTAGLIO','N') = 'S';
  chkSaltoPagIndividuale.Checked:=C004FParamForm.GetParametro('SALTOPAGINAIND','N') = 'S';
  dcmbCampo.KeyValue:=C004FParamForm.GetParametro('CAMPORAGGRUPPA',dcmbCampo.Text);
  chkSaltoPagRaggrup.Checked:=C004FParamForm.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  rgpValidate.ItemIndex:=StrToInt(C004FParamForm.GetParametro(UpperCase(rgpValidate.Name),'0'));
  chkGiorniSignificativi.Checked:=C004FParamForm.GetParametro('GGSIGNIFICATIVI','S') = 'S';
  edtGGMinCont.Text:=C004FParamForm.GetParametro('GGMINCONT','0');
  chkCausaliCumulate.Checked:=C004FParamForm.GetParametro('CAUSALICUMULATE','N') = 'S';
  chkPeriodoServizio.Checked:=C004FParamForm.GetParametro('PERIODOSERVIZIO','N') = 'S';
  chkRiduzioni.Checked:=C004FParamForm.GetParametro('CALCOLARIDUZIONI','N') = 'S';
  chkSoloRiduzioni.Checked:=C004FParamForm.GetParametro('SOLORIDUZIONI','N') = 'S';
  chkConteggiGG.Checked:=C004FParamForm.GetParametro('CONTEGGIGG','N') = 'S';
  chkConiuge.Checked:=C004FParamForm.GetParametro('CONTCONIUGE','N') = 'S';
  chkTotFam.Checked:=C004FParamForm.GetParametro('TOTFAMILIARE','N') = 'S';
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  rgpTipoDataFam.Enabled:=chkTotFam.Checked;
  rgpTipoDataFam.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPODATAFAM','0'));
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  rgpOrdinamento.ItemIndex:=StrToInt(C004FParamForm.GetParametro(UpperCase(rgpOrdinamento.Name),'0'));
  rgpAssenzeConsiderate.Enabled:=chkSoloAssRegSucc.Checked;
  lblDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  sbtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblAData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  sbtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  sbtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  lblARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  sbtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  chkSalvaUltRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  if dcmbCampo.Text = '' then
  begin
    dcmbCampo.KeyValue:=null;
    chkTotRaggrup.Enabled:=False;
    chkTotRaggrup.Checked:=False;
    chkSaltoPagRaggrup.Enabled:=False;
    chkSaltoPagRaggrup.Checked:=False;
  end;
  // lettura accorpamenti selezionati
  x:=0; //contatore di paramento
  snome:='LISTAACCORP';
  repeat
  // ciclo sui parametri LISTAACCORP0,LISTAACCORP1,ecc.
    svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Copy(svalore,(y*5)+1,5);
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=lstCodAcc.Items.Count;
          while (i<r) and (e) do
          begin
            if Copy(lstCodAcc.Items[i],1,5)=selemento then
               begin
               lstCodAcc.Checked[i]:=true;
               e:=false;
               end
            else
               if Copy(lstCodAcc.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
          end;
          inc(y);
          end;
      until selemento = '';
      inc(x);
    end;
  until svalore = '';
  // lettura causali selezionate
  x:=0; //contatore di paramento
  snome:='LISTACAUSALI';
  repeat
  // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
    svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Copy(svalore,(y*5)+1,5);
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=LstCausali.Items.Count;
          while (i<r) and (e) do
            begin
            if Copy(LstCausali.Items[i],1,5)=selemento then
            begin
               LstCausali.Checked[i]:=true;
               e:=false;
            end
            else
               if Copy(LstCausali.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
            end;
          inc(y);
          end;
      until selemento = '';
      inc(x);
    end;
  until svalore = '';
  C004FParamForm.Free;
end;

{Scrivo i parametri della form}
procedure TA061FDettAssenze.PutParametriFunzione;
var i,x,y,r:integer;
    svalore,snome:string;
begin
  //Se necessario memorizzo la data ultima registrazione stampata nei parametri con progressivo operatore -1
  if chkSalvaUltRegStamp.Checked then
  try
    CreaC004(SessioneOracle,'A061',-1);
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('DATAULTREGSTAMP',FormatDateTime('dd/mm/yyyy',ARegStamp));
    C004FParamForm.Free;
  except
  end;
  try
    CreaC004(SessioneOracle,'A061',Parametri.ProgOper);
  except
  end;
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('TIPOACCORPAMENTO',VarToStr(dcmbTipoAcc.KeyValue));
  if chkTotIndividuali.Checked then
    C004FParamForm.PutParametro('TOTINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('TOTINDIVIDUALI','N');
  if chkTotRaggrup.Checked then
    C004FParamForm.PutParametro('TOTGRUPPO','S')
  else
    C004FParamForm.PutParametro('TOTGRUPPO','N');
  if chkTotGenerali.Checked then
    C004FParamForm.PutParametro('TOTGENERALI','S')
  else
    C004FParamForm.PutParametro('TOTGENERALI','N');
  if chkSaltoPagIndividuale.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAIND','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAIND','N');
  if chkSaltoPagRaggrup.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','N');
  if chkDettGiorn.Checked then
    C004FParamForm.PutParametro('DETTAGLIO','S')
  else
    C004FParamForm.PutParametro('DETTAGLIO','N');
  if chkDettPer.Checked then
    C004FParamForm.PutParametro('PERIODICO','S')
  else
    C004FParamForm.PutParametro('PERIODICO','N');
  if chkGiorniSignificativi.Checked then
    C004FParamForm.PutParametro('GGSIGNIFICATIVI','S')
  else
    C004FParamForm.PutParametro('GGSIGNIFICATIVI','N');
  C004FParamForm.PutParametro('DATIINDIVIDUALI',IfThen(chkDatiIndividuali.Checked,'S','N'));
  C004FParamForm.PutParametro('STAMPANOMINATIVO',IfThen(chkStampaNominativo.Checked,'S','N'));
  C004FParamForm.PutParametro('STAMPAMATRICOLA',IfThen(chkStampaMatricola.Checked,'S','N'));
  C004FParamForm.PutParametro('STAMPABADGE',IfThen(chkStampaBadge.Checked,'S','N'));
  if chkRiduzioni.Checked then
    C004FParamForm.PutParametro('CALCOLARIDUZIONI','S')
  else
    C004FParamForm.PutParametro('CALCOLARIDUZIONI','N');
  if chkSoloRiduzioni.Checked then
    C004FParamForm.PutParametro('SOLORIDUZIONI','S')
  else
    C004FParamForm.PutParametro('SOLORIDUZIONI','N');
  if chkConteggiGG.Checked then
    C004FParamForm.PutParametro('CONTEGGIGG','S')
  else
    C004FParamForm.PutParametro('CONTEGGIGG','N');
  if chkSalvaUltRegStamp.Checked then
    C004FParamForm.PutParametro('SALVAULTREGSTAMP','S')
  else
    C004FParamForm.PutParametro('SALVAULTREGSTAMP','N');
  if chkSoloAssRegSucc.Checked then
    C004FParamForm.PutParametro('SOLOASSREGSUCC','S')
  else
    C004FParamForm.PutParametro('SOLOASSREGSUCC','N');
  C004FParamForm.PutParametro(UpperCase(rgpValidate.Name),IntToStr(rgpValidate.ItemIndex));
  C004FParamForm.PutParametro('ASSENZECONSIDERATE',IntToStr(rgpAssenzeConsiderate.ItemIndex));
  C004FParamForm.PutParametro('CAMPORAGGRUPPA',VarToStr(dcmbCampo.KeyValue));
  C004FParamForm.PutParametro('GGMINCONT',edtGGMinCont.Text);
  if chkCausaliCumulate.Checked then
    C004FParamForm.PutParametro('CAUSALICUMULATE','S')
  else
    C004FParamForm.PutParametro('CAUSALICUMULATE','N');
  if chkPeriodoServizio.Checked then
    C004FParamForm.PutParametro('PERIODOSERVIZIO','S')
  else
    C004FParamForm.PutParametro('PERIODOSERVIZIO','N');
  if chkConiuge.Checked then
    C004FParamForm.PutParametro('CONTCONIUGE','S')
  else
    C004FParamForm.PutParametro('CONTCONIUGE','N');
  if chkTotFam.Checked then
    C004FParamForm.PutParametro('TOTFAMILIARE','S')
  else
    C004FParamForm.PutParametro('TOTFAMILIARE','N');
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  C004FParamForm.PutParametro('TIPODATAFAM',IntToStr(rgpTipoDataFam.ItemIndex));
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  C004FParamForm.PutParametro(UpperCase(rgpOrdinamento.Name),IntToStr(rgpOrdinamento.ItemIndex));
  // salvo l'elenco degli accorpamenti selezionati
  x:=0; //contatore parametri accorpamenti
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTAACCORP';
  r:=lstCodAcc.Items.Count;
  for i:=1 to r do
  begin
    if lstCodAcc.Checked[i-1] then
    begin
       svalore:=svalore+Copy(lstCodAcc.Items[i-1],1,5);
       inc(y);
       if y=16 then
       begin
          C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
       end;
    end;
  end;
  C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
  // salvo l'elenco delle causali selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTACAUSALI';
  r:=LstCausali.Items.Count;
  for i:=1 to r do
  begin
    if LstCausali.Checked[i-1] then
    begin
       svalore:=svalore+Copy(LstCausali.Items[i-1],1,5);
       inc(y);
       if y=16 then
       begin
          C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
       end;
    end;
  end;
  C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
  try SessioneOracle.Commit; except end;
end;

procedure TA061FDettAssenze.sbtADataClick(Sender: TObject);
begin
  AData:=DataOut(StrToDate(edtAData.Text),A000MSG_A061_MSG_ALLA_DATA,'G');
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',AData);
end;

procedure TA061FDettAssenze.sbtARegStampClick(Sender: TObject);
begin
  ARegStamp:=DataOut(StrToDate(edtARegStamp.Text),A000MSG_A061_MSG_FINE_REGISTRAZIONE,'G');
  edtARegStamp.Text:=FormatDateTime('dd/mm/yyyy',ARegStamp);
end;

procedure TA061FDettAssenze.sbtDaDataClick(Sender: TObject);
begin
  DaData:=DataOut(StrToDate(edtDaData.Text),A000MSG_A061_MSG_DALLA_DATA,'G');
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',DaData);
end;

procedure TA061FDettAssenze.sbtDaRegStampClick(Sender: TObject);
begin
  DaRegStamp:=DataOut(StrToDate(edtDaRegStamp.Text),A000MSG_A061_MSG_INIZIO_REGISTRAZIONE,'G');
  edtDaRegStamp.Text:=FormatDateTime('dd/mm/yyyy',DaRegStamp);
end;

procedure TA061FDettAssenze.chkSoloAssRegSuccClick(Sender: TObject);
begin
  rgpAssenzeConsiderate.Enabled:=chkSoloAssRegSucc.Checked;
  lblDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  sbtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblAData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  sbtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  chkConteggiGG.Enabled:=not chkSoloAssRegSucc.Checked;
  if not chkConteggiGG.Enabled then
    chkConteggiGG.Checked:=False;
  lblDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  sbtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  lblARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  sbtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  chkSalvaUltRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
// chkConiuge.Enabled:=not(chkSoloAssRegSucc.Checked);   Commento presente già prima di MW
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TA061FDettAssenze.chkTotFamClick(Sender: TObject);
begin
  rgpTipoDataFam.Enabled:=chkTotFam.Checked;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TA061FDettAssenze.edtADataDblClick(Sender: TObject);
begin
  edtAData.Text:=DateToStr(R180FineMese(StrToDate(edtDaData.Text)));
end;

procedure TA061FDettAssenze.edtADataExit(Sender: TObject);
begin
  AData:=StrToDate(edtAData.Text);
end;

procedure TA061FDettAssenze.edtARegStampExit(Sender: TObject);
begin
  ARegStamp:=StrToDate(edtARegStamp.Text);
end;

procedure TA061FDettAssenze.edtDaDataExit(Sender: TObject);
begin
  DaData:=StrToDate(edtDaData.Text);
end;

procedure TA061FDettAssenze.edtDaRegStampExit(Sender: TObject);
begin
  DaRegStamp:=StrToDate(edtDaRegStamp.Text);
end;

procedure TA061FDettAssenze.edtGGMinContKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ((Ord(Key) < 48) or (Ord(Key) > 57)) and (Ord(Key) <> 8) then
    Key:=Chr(0);
end;

procedure TA061FDettAssenze.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA061FDettAssenze.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  if not chkSoloAssRegSucc.Checked then
  begin
    C700DataDal:=DaData;
    C700DataLavoro:=AData;
  end
  else
  begin
    C700DataDal:=DaRegStamp;
    C700DataLavoro:=ARegStamp;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA061FDettAssenze.dcmbCampoCloseUp(Sender: TObject);
begin
  if dcmbCampo.Text = '' then
  begin
    dcmbCampo.KeyValue:=null;
    chkTotRaggrup.Enabled:=False;
    chkTotRaggrup.Checked:=False;
    chkSaltoPagRaggrup.Enabled:=False;
    chkSaltoPagRaggrup.Checked:=False;
  end
  else
  begin
    chkTotRaggrup.Enabled:=True;
    chkSaltoPagRaggrup.Enabled:=True;
  end;
end;

procedure TA061FDettAssenze.dcmbCampoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbCampoCloseUp(nil);
end;

procedure TA061FDettAssenze.dcmbTipoAccClick(Sender: TObject);
begin
  AbilitaAccorpamenti;
  CaricaListaAccorpamenti;
end;

procedure TA061FDettAssenze.dcmbTipoAccKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
  AbilitaAccorpamenti;
  CaricaListaAccorpamenti;
end;

procedure TA061FDettAssenze.dcmbCampoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA061FDettAssenze.AbilitaAccorpamenti;
begin
  pnl12.Visible:=dcmbTipoAcc.Text <> '';
  dlblTipoAcc.Visible:=dcmbTipoAcc.Text <> '';
  SelTutto:=dcmbTipoAcc.Text <> '';
end;

procedure TA061FDettAssenze.CaricaListaAccorpamenti;
var S:String;
    i:Integer;
begin
  S:=',';
  for i:=0 to lstCodAcc.Items.Count - 1 do
    if lstCodAcc.Checked[i] then
      S:=S + Copy(lstCodAcc.Items[i],1,5) + ',';
  lstCodAcc.Items.Clear;
  with A061MW.selT256 do
  begin
    Close;
    SetVariable('TIPO_ACC',VarToStr(dcmbTipoAcc.KeyValue));
    Open;
    First;
    while not Eof do
    begin
      lstCodAcc.Items.Add(Format('%-5s %s',[FieldByName('Cod_codiciaccorpcausali').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  for i:=0 to lstCodAcc.Items.Count - 1 do
    if SelTutto or (Pos(',' + Copy(lstCodAcc.Items[i],1,5) + ',',S) > 0) then
      lstCodAcc.Checked[i]:=True;
  CaricaListaCausali;
end;

procedure TA061FDettAssenze.CaricaListaCausali;
var S,S2,C:String;
    i:Integer;
begin
  S:=',';
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.Checked[i] then
      S:=S + Copy(LstCausali.Items[i],1,5) + ',';
  S2:=',';
  for i:=0 to LstCausali.Items.Count - 1 do
    S2:=S2 + Copy(LstCausali.Items[i],1,5) + ',';
  LstCausali.Items.Clear;
  with A061MW.Q265 do
  begin
    Close;
    SetVariable('TIPO_ACC',VarToStr(dcmbTipoAcc.KeyValue));
    for i:=0 to lstCodAcc.Items.Count - 1 do
      if lstCodAcc.Checked[i] then
        C:=C + IfThen(C <> '',',') + '''' + Trim(Copy(lstCodAcc.Items[i],1,5)) + '''';
    SetVariable('COD_ACC',IfThen(C <> '',C,''''''));
    Open;
    First;
    while not Eof do
    begin
      LstCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  for i:=0 to LstCausali.Items.Count - 1 do
    if SelTutto
    or (Pos(',' + Copy(LstCausali.Items[i],1,5) + ',',S) > 0)
    or (SelAcc and (Pos(',' + Copy(LstCausali.Items[i],1,5) + ',',S2) = 0)) then
      LstCausali.Checked[i]:=True;
  SelTutto:=False;
  SelAcc:=False;
  AbilitaAss;
end;

procedure TA061FDettAssenze.ImpostaVariabiliA061MW;
begin
  A061MW.PeriodoServizioChecked:=chkPeriodoServizio.Checked;
  A061MW.SoloAssRegSuccChecked:=chkSoloAssRegSucc.Checked;
  A061MW.DettGiornChecked:=chkDettGiorn.Checked;
  A061MW.RiduzioniChecked:=chkRiduzioni.Checked;
  A061MW.SoloRiduzioniChecked:=chkSoloRiduzioni.Checked;
  A061MW.ConteggiGGChecked:=chkConteggiGG.Checked;
  A061MW.GiorniSignificativiChecked:=ChkGiorniSignificativi.Checked;
  A061MW.CausaliCumulateChecked:=ChkCausaliCumulate.Checked;
  A061MW.ConiugeChecked:=chkConiuge.Checked;
  A061MW.AssenzeConsiderateItemIndex:=RgpAssenzeConsiderate.ItemIndex;
  A061MW.ValidateItemIndex:=RgpValidate.ItemIndex;
  A061MW.OrdinamentoItemIndex:=RgpOrdinamento.ItemIndex;
  A061MW.DaRegStamp:=DaRegStamp;
  A061MW.ARegStamp:=ARegStamp;
  A061MW.GGMinCont:=edtGGMinCont.Text;
  A061MW.CampoRagg:=CampoRagg;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  A061MW.TipoDataFamItemIndex:=rgpTipoDataFam.ItemIndex;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

end.

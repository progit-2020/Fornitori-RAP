unit A029USchedaRiepil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Grids,
  DBGrids, Spin, Mask, DBCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt, A030UResidui, A094USkLimitiStr,
  C001UFiltroTabelleDtM, C001UFiltroTabelle,C001UScegliCampi, C005UDatiAnagrafici,
  C015UElencoValori, C180FunzioniGenerali, C700USelezioneAnagrafe, R450,
  ActnList, ImgList, ToolWin, SelAnagrafe, OracleData, Variants, Math,
  A029USchedaRiepilMW,A029UBudgetDtM1, A029ULiquidazione, A000UMessaggi,
  System.Actions, System.ImageList;

type
  TA029FSchedaRiepil = class(TR001FGestTab)
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    ScrollBox1: TScrollBox;
    ScrollBox3: TScrollBox;
    DBGFasce: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    Label21: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    DBEdit1: TDBEdit;
    EOreLavorate: TEdit;
    EDebitoCompl: TEdit;
    ESaldoMese: TEdit;
    ESaldoAnno: TEdit;
    Label20: TLabel;
    DBEdit18: TDBEdit;
    Label6: TLabel;
    TabSheet4: TTabSheet;
    Panel4: TPanel;
    SGFasce: TStringGrid;
    GroupBox1: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBGStraord: TDBGrid;
    Label11: TLabel;
    EOrePresenza: TEdit;
    HeaderControl1: THeaderControl;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    LData: TLabel;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Panel8: TPanel;
    ScrollBox2: TScrollBox;
    Label19: TLabel;
    DBEdit17: TDBEdit;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label10: TLabel;
    Label30: TLabel;
    DBEdit10: TDBEdit;
    EEccCompAnno: TEdit;
    EEccResidua: TEdit;
    Panel9: TPanel;
    SGStraord: TStringGrid;
    Residuiannoprecedente1: TMenuItem;
    BitBtn1: TBitBtn;
    Label31: TLabel;
    DBEdit4: TDBEdit;
    Label32: TLabel;
    DBEdit5: TDBEdit;
    Situazionebudgetstraordinario1: TMenuItem;
    Label35: TLabel;
    DBEdit8: TDBEdit;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label23: TLabel;
    EDebPOAnno: TEdit;
    Label3: TLabel;
    EResiduoPOAnno: TEdit;
    Label24: TLabel;
    EResoPOMese: TEdit;
    Label36: TLabel;
    ESaldoAnnoPrec: TEdit;
    Label37: TLabel;
    ESaldoAnnoCorr: TEdit;
    Label38: TLabel;
    EMesePrec: TEdit;
    Label39: TLabel;
    EOrePerse: TEdit;
    TabSheet5: TTabSheet;
    GroupBox5: TGroupBox;
    Label44: TLabel;
    Label45: TLabel;
    EStrAutAnn: TEdit;
    EStrAutMen: TEdit;
    Label40: TLabel;
    EOreAddebitate: TEdit;
    Label33: TLabel;
    LPartTime: TLabel;
    LContratto: TLabel;
    Label34: TLabel;
    edtLiquidazioniAnnue: TEdit;
    TabSheet7: TTabSheet;
    DBGrid3: TDBGrid;
    PIndennita: TGroupBox;
    GIndennita: TDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Label46: TLabel;
    cmbCausPresenza: TComboBox;
    lblOreEscluseIncluse: TLabel;
    GroupBox8: TGroupBox;
    Label43: TLabel;
    GroupBox9: TGroupBox;
    grdPresAnnueTot: TStringGrid;
    grdPresLiqTot: TStringGrid;
    grdPresLiq: TDBGrid;
    dedtOreEsclCompMese: TDBEdit;
    Label47: TLabel;
    btnAttivaLiquidazione: TBitBtn;
    edtOreEsclComp: TEdit;
    Label48: TLabel;
    edtOreEsclCompAnno: TEdit;
    edtOreEsclCompAnnoEff: TEdit;
    edtOreEsclCompMeseEff: TEdit;
    grdPresAnnue: TStringGrid;
    lblLiquidazioneBloccata: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    DBEdit9: TDBEdit;
    DBEdit16: TDBEdit;
    lblLiquidStrBloccata: TLabel;
    Label51: TLabel;
    edtOreTroncate: TEdit;
    GroupBox10: TGroupBox;
    DBGrid1: TDBGrid;
    Label42: TLabel;
    Edit2: TEdit;
    Label41: TLabel;
    Edit1: TEdit;
    GroupBox11: TGroupBox;
    Panel7: TPanel;
    grdTotOreCompensabili: TStringGrid;
    grdOreCompensabili: TStringGrid;
    DBGrid2: TDBGrid;
    Label52: TLabel;
    DBEdit20: TDBEdit;
    frmSelAnagrafe: TfrmSelAnagrafe;
    GroupBox12: TGroupBox;
    DBEdit22: TDBEdit;
    Label5: TLabel;
    Label56: TLabel;
    Label4: TLabel;
    edtSaldoRipCom: TEdit;
    Parametridiconteggio1: TMenuItem;
    DBEdit23: TDBEdit;
    Label26: TLabel;
    edtlblLiqOreAnniPrec: TEdit;
    lblLiqOreAnniPrec: TLabel;
    edtlblVariazioneSaldo: TEdit;
    lblVariazioneSaldo: TLabel;
    btnOreLiqAnniPrec: TBitBtn;
    Label25: TLabel;
    EEccResAutMen: TEdit;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    Label57: TLabel;
    EStrEst: TEdit;
    edtOreCausalizzateEsterneLiq: TEdit;
    btnLimitiIndividuali: TButton;
    GroupBox14: TGroupBox;
    Label55: TLabel;
    DBEdit19: TDBEdit;
    Label58: TLabel;
    DBEdit24: TDBEdit;
    lblLIquidCompBloccata: TLabel;
    GroupBox15: TGroupBox;
    Label53: TLabel;
    edtBancaOreLiquidata: TEdit;
    Label54: TLabel;
    edtBancaOreResidua: TEdit;
    Label59: TLabel;
    edtBancaOreRecuperata: TEdit;
    Label60: TLabel;
    edtBancaOreMaturata: TEdit;
    Label61: TLabel;
    edtBancaOreResiduaPrec: TEdit;
    Label62: TLabel;
    edtBancaOreResiduaCorr: TEdit;
    Label63: TLabel;
    edtVarEccLiqAnno: TEdit;
    Label64: TLabel;
    DBEdit25: TDBEdit;
    edtRecuperoAnno: TEdit;
    Label65: TLabel;
    actSaldiMobili: TAction;
    Recuperimobili1: TMenuItem;
    BitBtn2: TBitBtn;
    Label67: TLabel;
    dedtOreInail: TDBEdit;
    Label72: TLabel;
    EEccCompMese: TEdit;
    Label73: TLabel;
    edtBancaOreRecInterna: TEdit;
    edtRiposiNonFruiti: TEdit;
    Label66: TLabel;
    lblRipComFasce: TLabel;
    edtAbbRipComMes: TEdit;
    Label74: TLabel;
    EResoPOAnno: TEdit;
    btnLiquidazioniAnnue: TBitBtn;
    Label75: TLabel;
    edtBancaOreCausEsc: TEdit;
    Label76: TLabel;
    edtBancaOreCausEscAnno: TEdit;
    btnSaldiMobiliCausale: TBitBtn;
    actSaldiMobiliCausale: TAction;
    lblBancaOreLiqVar: TLabel;
    dedtBancaOreLiqVar: TDBEdit;
    Panel10: TPanel;
    GroupBox7: TGroupBox;
    dgrdDatiScheda: TDBGrid;
    Splitter1: TSplitter;
    GroupBox16: TGroupBox;
    DBGrid4: TDBGrid;
    Panel11: TPanel;
    GroupBox17: TGroupBox;
    Label29: TLabel;
    Label27: TLabel;
    Label68: TLabel;
    Label28: TLabel;
    Label69: TLabel;
    dedtFestivIntera: TDBEdit;
    dedtFestivInteraVar: TDBEdit;
    dedtFestivRidotta: TDBEdit;
    dedtFestivRidottaVar: TDBEdit;
    Label77: TLabel;
    dedtRiposiNonFruiti: TDBEdit;
    GroupBox18: TGroupBox;
    LIndennita: TLabel;
    Label8: TLabel;
    Label70: TLabel;
    Label9: TLabel;
    dedtIndTurnoNum: TDBEdit;
    dedtIndTurnoNumVar: TDBEdit;
    dedIndTurnoOre: TDBEdit;
    Label71: TLabel;
    dedIndTurnoOreVar: TDBEdit;
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure DBLookupComboBox1MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TCancClick(Sender: TObject);
    procedure Residuiannoprecedente1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure Situazionebudgetstraordinario1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbCausPresenzaChange(Sender: TObject);
    procedure Creasituazionemensile1Click(Sender: TObject);
    procedure dedtOreEsclCompMeseExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Parametridiconteggio1Click(Sender: TObject);
    procedure btnOreLiqAnniPrecClick(Sender: TObject);
    procedure btnLimitiIndividualiClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure actSaldiMobiliExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLiquidazioniAnnueClick(Sender: TObject);
    procedure grdPresAnnueDblClick(Sender: TObject);
    procedure actSaldiMobiliCausaleExecute(Sender: TObject);
    procedure DBGrid4DblClick(Sender: TObject);
  private
    procedure CambiaProgressivo;
  public
    procedure GetTotaliPresenza;
  end;

var
  A029FSchedaRiepil: TA029FSchedaRiepil;

procedure OpenA029SchedaRiepil(Progressivo:LongInt; Data:TDateTime);

implementation

uses A029USchedaRiepilDtM1, A029URecuperiMobili,  A117UOreLiquidateAnniPrec;

{$R *.DFM}

procedure OpenA029SchedaRiepil(Progressivo:LongInt; Data:TDateTime);
{Scheda riepilogativa}
begin
  if Progressivo <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA029SchedaRiepil') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A029FSchedaRiepil:=TA029FSchedaRiepil.Create(nil);
  C700Progressivo:=Progressivo;
  with A029FSchedaRiepil do
    try
    A029FSchedaRiepilDtM1:=TA029FSchedaRiepilDtM1.Create(nil);
    ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A029FSchedaRiepilDtM1.Free;
      Free;
    end;
end;

procedure TA029FSchedaRiepil.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TA029FSchedaRiepil.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A029FSchedaRiepilDtM1.A029FSchedaRiepilMW,SessioneOracle,StatusBar,2,True);
end;

procedure TA029FSchedaRiepil.FormActivate(Sender: TObject);
{Imposto le misure della griglia}
var i:Byte;
begin
  TabSheet1.Enabled:=Parametri.A029_Saldi = 'S';
  TabSheet3.Enabled:=Parametri.A029_Indennita = 'S';
  TabSheet4.Enabled:=Parametri.A029_Straordinario = 'S';
  TabSheet5.Enabled:=Parametri.A029_Straordinario = 'S';
  TabSheet7.Enabled:=Parametri.A029_CauPresenza = 'S';
  with A029FSchedaRiepilDtM1 do
  begin
//    A029FSchedaRiepilMW.selT162.Open;
//  A029FSchedaRiepilMW.selT275.Open;
//    Q305.Open;
    Q070.Open;
    if not Q070.SearchRecord('Data',R180InizioMese(Parametri.DataLavoro),[srFromBeginning]) then
      Q070.Last;
    A029FSchedaRiepilMW.selT072.Open;
    with SGFasce,DBGFasce do
      begin
      ColCount:=Columns.Count + 1;
      for i:=0 to Columns.Count - 1 do
        ColWidths[i + 1]:=Columns[i].Width;
      end;
    SGFasce.Cells[1,0]:='Totali fasce';
    with SGStraord,DBGStraord do
      begin
      ColCount:=Columns.Count + 1;
      for i:=0 to Columns.Count - 1 do
        ColWidths[i + 1]:=Columns[i].Width;
      end;
    SGStraord.Cells[1,0]:='Totali fasce';
    with grdPresAnnue do
      begin
      ColCount:=9;
      Cells[1,0]:='Fascia';
      Cells[2,0]:='Ore rese';
      Cells[3,0]:='Anno prec.';
      Cells[4,0]:='Liquidabile';
      Cells[5,0]:='Liquidato';
      Cells[6,0]:='Residuo';
      Cells[7,0]:='Ore perse';
      Cells[8,0]:='Banca Ore';
      ColWidths[1]:=50;
      ColWidths[2]:=48;
      ColWidths[3]:=56;
      ColWidths[4]:=56;
      ColWidths[5]:=50;
      ColWidths[6]:=50;
      ColWidths[7]:=48;
      ColWidths[8]:=56;
      end;
    with grdPresAnnueTot do
      begin
      ColCount:=9;
      ColWidths[1]:=50;
      ColWidths[2]:=48;
      ColWidths[3]:=56;
      ColWidths[4]:=56;
      ColWidths[5]:=50;
      ColWidths[6]:=48;
      ColWidths[7]:=50;
      ColWidths[8]:=56;
      Cells[1,0]:='Totali';
      end;
    with grdPresLiq,grdPresLiqTot do
      begin
      ColCount:=Columns.Count + 1;
      for i:=0 to Columns.Count - 1 do
        ColWidths[i + 1]:=Columns[i].Width;
      end;
    grdPresLiqTot.Cells[1,0]:='Totali';
    end;
  inherited;
end;

procedure TA029FSchedaRiepil.DBLookupComboBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
{Visualizzo descrizione delle causali di assestamento nell'Hint del controllo}
begin
  with A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.selT305 do
    (Sender as TControl).Hint:=VarToStr(Lookup('Codice',(Sender as TDBLookupComboBox).Text,'Descrizione'));
end;

procedure TA029FSchedaRiepil.btnOreLiqAnniPrecClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  FreeAndNil(A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.A029FLiquidazione);
  A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.selAnagrafe:=nil;
  OpenA117OreLiquidateAnniPrec(C700Progressivo,A029FSchedaRiepilDtM1.Q070Data.AsDateTime);
  A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.A029FLiquidazione.R450DtM:=A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.R450DtM1;
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  C700OldProgressivo:=-1;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A029FSchedaRiepilDtM1.A029FSchedaRiepilMW);
  A029FSchedaRiepilDtM1.Q070AfterScroll(A029FSchedaRiepilDtM1.Q070);
end;

procedure TA029FSchedaRiepil.BitBtn1Click(Sender: TObject);
{Liquidazione automatica dello straordinario}
var S,Msg:String;
    OreLiq,OreDisponibili:Integer;
    ImpLiq: real;
    Btn:TMsgDlgButtons;
    UsaBudget: Boolean;
begin
  if SolaLettura then
    exit;
  S:=SGStraord.Cells[8,0];
  OreDisponibili:=R180OreMinutiExt(S);
  if InputQuery('Liquidazione automatica per fasce','Ore di straordinario da liquidare:',S) then
  begin
    try
      OreLiq:=R180OreMinutiExt(S);
    except
      raise Exception.Create(A000MSG_A029_ERR_ORE_LIQ);
    end;
  end
  else
    exit;
  if OreLiq = 0 then
    exit;
  //Controllo supero della disponibilità calcolata
  if OreLiq > OreDisponibili then
    raise Exception.Create(A000MSG_A029_ERR_SUPERO_LIQ);
  //Controllo il supero dei limiti annuali e mensili individuali
  with A029FSchedaRiepilDtM1 do
  begin
    Msg:=A029FSchedaRiepilMW.A029FLiquidazione.LimiteIndividualeStraordinario(Q070Progressivo.AsInteger,OreLiq,OreLiq,0,Q070Data.AsDateTime);
    //Caratto 27/05/2013. Spostato MSgbox fuori da funzione per utilizzo anche in web
    if Msg <> '' then
    begin
      if Parametri.LiquidazioneForzata = 'S' then
        Btn:=[mbYes,mbNo]
      else
        Btn:=[mbCancel];

      if Btn <> [mbCancel] then
      Msg:=Msg + #13#13 + 'Confermare?';
      if MessageDlg(Msg,mtConfirmation,Btn,0) <> mrYes then
        Abort;
    end;

    // controlli sul budget
    if A029FSchedaRiepilMW.Budget then
    begin
      // simula la liquidazione per calcolare l'importo da confrontare con il budget
      // la funzione carica la struttura dati in A029FBudgetDtM1 per effettuare il calcolo dell'importo
      // richiesto in base alla distribuzione delle ore in fasce
      A029FSchedaRiepilMW.ImpostaLiquidazione;
      A029FSchedaRiepilMW.A029FLiquidazione.Liquidazione(True,Q070Data.AsDateTime,Q070Progressivo.AsInteger,-1,OreLiq,'');
      ImpLiq:=A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.CtrlLiqGetImporto(Q070Progressivo.AsInteger,Q070Data.AsDateTime);

      if Parametri.CampiRiferimento.C2_Facoltativo = 'N' then
      begin
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,Q070Progressivo.AsInteger,Q070Data.AsDateTime,OreLiq,ImpLiq);
      end
      else if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
      begin
        if R180MessageBox(A000MSG_A029_DLG_GEST_BUDGET,DOMANDA) = mrYes then
          UsaBudget:=True
        else
          UsaBudget:=False;
      end;
    end;

    A029FSchedaRiepilMW.LiquidazioneAutomatica(UsaBudget,OreLiq,ImpLiq);
  end;
end;

procedure TA029FSchedaRiepil.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BitBtn1.Enabled:=(DButton.State = dsBrowse) and (not lblLiquidStrBloccata.Visible) and (not A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT071S);
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  DbGrid1.ReadOnly:=DButton.State in [dsBrowse];
  btnOreLiqAnniPrec.Enabled:=DButton.State in [dsBrowse];
  btnLimitiIndividuali.Enabled:=DButton.State in [dsBrowse];
  btnAttivaLiquidazione.Enabled:=(DButton.State = dsBrowse) and (cmbCausPresenza.Text <> '') and (A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.TipoOreCausalizzate in [tocEscluse,tocIncluse]) and
                                 (A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.selT074.Lookup('Causale',Trim(Copy(cmbCausPresenza.Text,1,5)),'Causale') = null);
end;

procedure TA029FSchedaRiepil.DButtonDataChange(Sender: TObject; Field: TField);
{Imposto il nuovo mese nei conteggi}
begin
  if (Field <> nil) and (Field.FieldKind = fkData) and (DButton.State in [dsInsert,dsEdit]) then
    A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.CalcolaDati;
end;

procedure TA029FSchedaRiepil.TCancClick(Sender: TObject);
begin
  //Provo a eseguire tutte le cancellazioni
  try
    inherited;
  except
    SessioneOracle.RollBack;
    raise;
  end;
end;

procedure TA029FSchedaRiepil.CambiaProgressivo;
var D:TDateTime;
begin
  D:=A029FSchedaRiepilDtM1.Q070Data.AsDateTime;
  if C700OldProgressivo <> C700Progressivo then
  begin
    with A029FSchedaRiepilDtM1.Q070 do
    begin
      Close;
      SetVariable('Progressivo',C700Progressivo);
      Open;
      if not SearchRecord('Data',D,[srFromBeginning]) then
        Last;
      NumRecords;
    end;
  end;
end;

procedure TA029FSchedaRiepil.Residuiannoprecedente1Click(Sender: TObject);
{Visualizzo residui anno precedente}
begin
  with A029FSchedaRiepilDtM1 do
  begin
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA030Residui(C700Progressivo,Q070Data.AsDateTime,False);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe(A029FSchedaRiepilDtM1.A029FSchedaRiepilMW);
    A029FSchedaRiepilDtM1.Q070AfterScroll(A029FSchedaRiepilDtM1.Q070);
  end;
end;

procedure TA029FSchedaRiepil.Situazionebudgetstraordinario1Click(
  Sender: TObject);
{Visualizzazione della situazione budgetaria del mese}
var S: String;
begin
  with A029FSchedaRiepilDtm1 do
  begin
    if Q070.RecordCount > 0 then
    begin
      S:=A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtm1.VisualizzaBudget(Q070Progressivo.AsInteger,Q070Data.AsDateTime);
      R180MessageBox(S,INFORMA);
    end;
  end;
end;

procedure TA029FSchedaRiepil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if R180OreMinutiExt(Edit1.Text) > R180OreMinutiExt(Edit2.Text) then
  begin
    ShowMessage(A000MSG_A029_ERR_STRAORD_EST);
    Action:=caNone;
  end;
end;

procedure TA029FSchedaRiepil.cmbCausPresenzaChange(Sender: TObject);
{Visualizzazione del dettaglio della presenza selezionata}
var
  CodiceCausPresenza,
  OreNormali: String;
begin
  with A029FSchedaRiepilDtM1.A029FSchedaRiepilMW do
  begin
    CodiceCausPresenza:=Trim(Copy(cmbCausPresenza.Text,1,5));
    OreNormali:=CambioCausPresenza(CodiceCausPresenza);

    lblOreEscluseIncluse.Caption:=CaptionOreIncluseEscluse(OreNormali);
    btnSaldiMobiliCausale.Visible:=(OreNormali = 'A') and (selT275.Lookup('Codice',CodiceCausPresenza,'Periodicita_Abbattimento') >= 0);
    lblLiquidazioneBloccata.Visible:=PresenzaLiquidataSuccessiva;
    btnAttivaLiquidazione.Enabled:=LiquidazioneAttiva(CodiceCausPresenza);
    GetTotaliPresenza;
  end;
end;

procedure TA029FSchedaRiepil.GetTotaliPresenza;
{Visualizzazione dati dei conteggi in grdPresAnnue e calcolo dei totali}
var
  i: Integer;
  PresenzeAnnue: TPresenzeAnnue;
begin
  //Lettura ore liquidate e calcolo totale
  PresenzeAnnue:=A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.TotaliPresenza(Trim(Copy(cmbCausPresenza.Text,1,5)),True,dedtOreEsclCompMese.Text);
  if Length(PresenzeAnnue.FascePresenza) = 0 then
    Exit;

  edtOreEsclCompAnno.Text:=R180MinutiOre(PresenzeAnnue.CompensabileAnno);
  edtOreEsclCompAnnoEff.Text:=R180MinutiOre(PresenzeAnnue.CompensabileAnnoEff);
  edtOreEsclCompMeseEff.Text:=R180MinutiOre(PresenzeAnnue.CompensabileMeseEff);
  edtRecuperoAnno.Text:=R180MinutiOre(PresenzeAnnue.RecuperoAnno);

  with grdPresAnnue do
  begin
    RowCount:=Length(PresenzeAnnue.FascePresenza) + 1;
    for i:=0 to Length(PresenzeAnnue.FascePresenza) - 1 do
    begin
      Cells[1,i+1]:=PresenzeAnnue.FascePresenza[i].Fascia;
      Cells[2,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].OreRese);
      Cells[3,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].AnnoPrec);
      Cells[4,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Liquidabile);
      Cells[5,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Liquidato);
      Cells[6,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].Residuo);
      Cells[7,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].OrePerse);
      Cells[8,i+1]:=R180MinutiOre(PresenzeAnnue.FascePresenza[i].BancaOre);
    end;
  end;

  grdPresLiqTot.Cells[2,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.LiquidatoMese);

  with grdPresAnnueTot do
  begin
    Cells[2,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Ore);
    Cells[3,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.AnnoPrec);
    Cells[4,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Liquidabile);
    Cells[5,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Liquidato);
    Cells[6,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Residuo);
    Cells[7,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.Abbattimento);
    Cells[8,0]:=R180MinutiOre(PresenzeAnnue.TotaliPresenza.OreBO);
  end;
end;

procedure TA029FSchedaRiepil.grdPresAnnueDblClick(Sender: TObject);
begin
  actSaldiMobiliCausaleExecute(nil);
end;

procedure TA029FSchedaRiepil.Creasituazionemensile1Click(Sender: TObject);
{Creazione record in T073-T074 per permettere le operazioni di liquidazione/compensazione
anche se non c'è il riepilogo mensile}
begin
  if (DButton.State = dsBrowse) and (cmbCausPresenza.Text <> '') and (A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.TipoOreCausalizzate in [tocEscluse,tocIncluse]) and
     (A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.selT074.Lookup('Causale',Trim(Copy(cmbCausPresenza.Text,1,5)),'Causale') = null) then
  begin
    A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.AttivaLiquidazione(Trim(Copy(cmbCausPresenza.Text,1,5)));
  end;
end;

procedure TA029FSchedaRiepil.dedtOreEsclCompMeseExit(Sender: TObject);
begin
  if dedtOreEsclCompMese.DataSource.State = dsEdit then
    dedtOreEsclCompMese.DataSource.DataSet.Post;
end;

procedure TA029FSchedaRiepil.TfrmSelAnagrafe1btnSelezioneClick(
  Sender: TObject);
begin
  if R180OreMinutiExt(Edit1.Text) > R180OreMinutiExt(Edit2.Text) then
    raise Exception.Create(A000MSG_A029_ERR_STRAORD_EST);
  try
    C700DataLavoro:=A029FSchedaRiepilDtM1.Q070.FieldByName('Data').AsDateTime;
    if C700DataLavoro = 0 then C700DataLavoro:=Parametri.DataLavoro;
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA029FSchedaRiepil.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A029FSchedaRiepilDtM1.Q070.FieldByName('Data').AsDateTime;
    if C005DataVisualizzazione = 0 then C005DataVisualizzazione:=Parametri.DataLavoro;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA029FSchedaRiepil.Parametridiconteggio1Click(Sender: TObject);
begin
  R180MessageBox(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.ParametriConteggio,INFORMA);
end;

procedure TA029FSchedaRiepil.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA029FSchedaRiepil.btnLimitiIndividualiClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA094LimitiStr(C700Progressivo,A029FSchedaRiepilDtM1.Q070.FieldByName('Data').AsDateTime);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  C700OldProgressivo:=-1;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A029FSchedaRiepilDtM1.A029FSchedaRiepilMW);
  A029FSchedaRiepilDtM1.Q070AfterScroll(A029FSchedaRiepilDtM1.Q070);
end;

procedure TA029FSchedaRiepil.btnLiquidazioniAnnueClick(Sender: TObject);
begin
  inherited;
  A029FRecuperiMobili:=TA029FRecuperiMobili.Create(nil);
  with A029FRecuperiMobili do
  try
    Panel1.Visible:=False;
    Caption:='<A029> Riepilogo liquidazioni da inzio anno';
    GroupBox2.Caption:='';
    (*
    lstRecuperiMobili.TitleCaptions.Clear;
    lstRecuperiMobili.TitleCaptions.Add('Tipologia');
    lstRecuperiMobili.TitleCaptions.Add('Ore');
    lstRecuperiMobili.ColWidths[0]:=200;
    lstRecuperiMobili.Strings.Add('Straordinario liquidato=' + R180MinutiOre(A029FLiquidazione.LiqT071Anno));
    lstRecuperiMobili.Strings.Add('Causali di presenza liquidate=' + R180MinutiOre(A029FLiquidazione.LiqT074Anno));
    lstRecuperiMobili.Strings.Add('Banca ore liquidata=' + R180MinutiOre(A029FLiquidazione.LiqT070));
    lstRecuperiMobili.Strings.Add('Causali di assestamento liquidate=' + R180MinutiOre(A029FLiquidazione.AssT071Anno));
    *)
    grdRecuperiMobili.RowCount:=5;
    grdRecuperiMobili.Cells[0,0]:='Tipologia';
    grdRecuperiMobili.Cells[1,0]:='Ore';
    grdRecuperiMobili.ColWidths[0]:=200;
    grdRecuperiMobili.Cells[0,1]:='Straordinario liquidato';
    grdRecuperiMobili.Cells[1,1]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.A029FLiquidazione.LiqT071Anno);
    grdRecuperiMobili.Cells[0,2]:='Causali di presenza liquidate';
    grdRecuperiMobili.Cells[1,2]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.A029FLiquidazione.LiqT074Anno);
    grdRecuperiMobili.Cells[0,3]:='Banca ore liquidata';
    grdRecuperiMobili.Cells[1,3]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.A029FLiquidazione.LiqT070);
    grdRecuperiMobili.Cells[0,4]:='Causali di assestamento liquidate';
    grdRecuperiMobili.Cells[1,4]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.A029FLiquidazione.AssT071Anno);
    A029FRecuperiMobili.ShowModal;
  finally
    Free;
  end;
end;

procedure TA029FSchedaRiepil.PageControl1Change(Sender: TObject);
var S:String;
begin
  S:='';
  StatusBar.Panels[3].Text:='';
  if PageControl1.ActivePage = TabSheet1 then
  begin
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT070 then
      S:=S + 'Scheda';
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT071A then
      S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Assestamento';
  end;
  if PageControl1.ActivePage = TabSheet3 then
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT070 then
      S:=S + 'Scheda';
  if PageControl1.ActivePage = TabSheet4 then
  begin
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT070 then
      S:=S + 'Scheda';
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT071S then
      S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Liquid. straordinario';
  end;
  if PageControl1.ActivePage = TabSheet5 then
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT070 then
      S:=S + 'Scheda';
  if PageControl1.ActivePage = TabSheet7 then
  begin
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT070 then
      S:=S + 'Scheda';
    if A029FSchedaRiepilDtM1.A029FSchedaRiepilMW.BloccoT074 then
      S:=S + StringReplace(R180Spaces('',Min(Length(S),1)),' ',', ',[]) + 'Liquid. ore causalizzate';
  end;
  if S <> '' then
    StatusBar.Panels[3].Text:='Dati bloccati: ' + S;
end;

procedure TA029FSchedaRiepil.actSaldiMobiliCausaleExecute(Sender: TObject);
var i,r:Integer;
    D:TDateTime;
    PrimaRiga:Boolean;
begin
  with TA029FRecuperiMobili.Create(nil) do
  try
    Caption:='Saldi mobili della causale ' + Trim(Copy(cmbCausPresenza.Text,1,5));
    Width:=540;
    grdRecuperiMobili.ColCount:=5;
    grdRecuperiMobili.RowCount:=7;
    grdRecuperiMobili.Cells[0,0]:='Mese';
    grdRecuperiMobili.Cells[1,0]:='Ore recuperate';
    grdRecuperiMobili.Cells[2,0]:='Compensazione';
    grdRecuperiMobili.Cells[3,0]:='Causali assenza';
    grdRecuperiMobili.Cells[4,0]:='Liquidazioni';
    PrimaRiga:=True;
    r:=0;
    for i:=0 to High(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres) do
      if A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Causale = Trim(Copy(cmbCausPresenza.Text,1,5)) then
      begin
        if PrimaRiga then
        begin
          D:=A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Data;
          lblSaldo.Caption:=FormatDateTime('mmmm yyyy',D) + ' - ore abbattibili: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].OreRese);
          lblSaldoAttuale.Caption:=FormatDateTime('mmmm yyyy',A029FSchedaRiepilDtM1.Q070.FieldByName('DATA').AsDateTime) + ' - saldo attuale: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].OreResidue);
          PrimaRiga:=False;
        end
        else
        begin
          D:=R180AddMesi(D,1);
          inc(r);
          grdRecuperiMobili.Cells[0,r]:=FormatDateTime('yyyy mmmm',D);
          grdRecuperiMobili.Cells[1,r]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].OreRecuperate);
          grdRecuperiMobili.Cells[2,r]:=Format('%s(%s)',[R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].CompUsato),R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Compensabile)]);
          grdRecuperiMobili.Cells[3,r]:=Format('%s(%s)',[R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].RecupUsato),R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Recuperato)]);
          grdRecuperiMobili.Cells[4,r]:=Format('%s(%s)',[R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].LiquidUsato),R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Liquidato)]);
          if A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].Data = A029FSchedaRiepilDtM1.Q070.FieldByName('DATA').AsDateTime then
            lblCarenze.Caption:=FormatDateTime('mmmm yyyy',A029FSchedaRiepilDtM1.Q070.FieldByName('DATA').AsDateTime) + ' - ore non recuperate: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.RiepilogoRecuperiRiepPres[i].OrePerse);
        end;
      end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TA029FSchedaRiepil.actSaldiMobiliExecute(Sender: TObject);
var i:Integer;
    D:TDateTime;
begin
  A029FRecuperiMobili:=TA029FRecuperiMobili.Create(nil);
  try
    D:=R180AddMesi(A029FSchedaRiepilDtM1.Q070.FieldByName('DATA').AsDateTime,-A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec);
    A029FRecuperiMobili.lblSaldo.Caption:=FormatDateTime('mmmm yyyy',D) + ' - saldo abbattibile: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.SaldoMobileAbbattibile);
    A029FRecuperiMobili.lblSaldoAttuale.Caption:=FormatDateTime('mmmm yyyy',A029FSchedaRiepilDtM1.Q070.FieldByName('DATA').AsDateTime) + ' - saldo attuale: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.SaldoMobileDisponibile);
    A029FRecuperiMobili.lblcarenze.Caption:=FormatDateTime('mmmm yyyy',D) + ' - negativi non recup.: ' + R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.NegativiNonRecuperati);
    A029FRecuperiMobili.grdRecuperiMobili.RowCount:=A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec + 1;
    A029FRecuperiMobili.grdRecuperiMobili.ColWidths[0]:=100;
    A029FRecuperiMobili.grdRecuperiMobili.ColWidths[1]:=200;
    A029FRecuperiMobili.grdRecuperiMobili.Cells[0,0]:='Mese';
    A029FRecuperiMobili.grdRecuperiMobili.Cells[1,0]:='Recupero';
    for i:=0 to A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec - 1 do
    begin
      D:=R180AddMesi(D,1);
      //A029FRecuperiMobili.lstRecuperiMobili.Strings.Add(FormatDateTime('yyyy mmmm',D) + '=' + R180MinutiOre(R450DtM1.SaldoMobileRecupero[D]));
      A029FRecuperiMobili.grdRecuperiMobili.Cells[0,i + 1]:=FormatDateTime('yyyy mmmm',D);
      A029FRecuperiMobili.grdRecuperiMobili.Cells[1,i + 1]:=R180MinutiOre(A029FSchedaRiepilDtm1.A029FSchedaRiepilMW.R450DtM1.SaldoMobileRecupero[D]);
    end;
    A029FRecuperiMobili.ShowModal;
  finally
    FreeAndNil(A029FRecuperiMobili);
  end;
end;

procedure TA029FSchedaRiepil.DBGrid4DblClick(Sender: TObject);
var vCodice: Variant;
begin
  inherited;
  with A029FSchedaRiepilDtM1.A029FSchedaRiepilMW do
  begin
    if selT072.State <> dsBrowse then
      exit;
    if OpenDettaglioGG then
      OpenC015FElencoValori('','<A029> Dettaglio giornaliero maturazione indennità',selUsrT072.SQL.Text,'',vCodice,selUsrT072,500,350,False);
  end;
end;

procedure TA029FSchedaRiepil.DBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.

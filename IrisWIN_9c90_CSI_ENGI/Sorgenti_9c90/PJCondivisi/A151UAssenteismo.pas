unit A151UAssenteismo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Mask,
  StdCtrls, CheckLst, ExtCtrls, Buttons, DBCtrls, SelAnagrafe, Math, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData, C700USelezioneAnagrafe,
  A003UDataLavoroBis, C180FunzioniGenerali, C013UCheckList, A000UMessaggi,
  A077UGeneratoreStampe, A077UGeneratoreStampeDtM, A150UAccorpamentoCausali, A083UMsgElaborazioni,
  Grids, DBGrids, DBClient, System.Actions, InputPeriodo, System.ImageList;

type
  TA151FAssenteismo = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    Label1: TLabel;
    dcmbTabella: TDBLookupComboBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    lblTipoAccorp: TLabel;
    dcmbTipoAccorp: TDBLookupComboBox;
    btnAccorpamenti: TBitBtn;
    ProgressBar1: TProgressBar;
    pnlPulsanti: TPanel;
    btnEsegui: TBitBtn;
    BitBtn2: TBitBtn;
    btnAnomalie: TBitBtn;
    dedtCodice: TDBEdit;
    Label6: TLabel;
    dedtDescrizione: TDBEdit;
    Label7: TLabel;
    dedtAccorpamenti: TDBEdit;
    drdgAssenze: TDBRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    tabNumDip: TTabSheet;
    tabPresenze: TTabSheet;
    Panel4: TPanel;
    Panel5: TPanel;
    tabAssenze: TTabSheet;
    Panel6: TPanel;
    tabRiepilogo: TTabSheet;
    Panel7: TPanel;
    lstNumDip: TCheckListBox;
    drdgNumDipPeriodo: TDBRadioGroup;
    drdgNumDipArrot: TDBRadioGroup;
    lstPresenze: TCheckListBox;
    dchkPresenzaGGLav: TDBCheckBox;
    drdgPresenzaArrot: TDBRadioGroup;
    lstAssenze: TCheckListBox;
    drdgAssenzaArrot: TDBRadioGroup;
    dchkAssenzaGGLav: TDBCheckBox;
    dchkAssenzaGGInt: TDBCheckBox;
    lstRiepilogo: TCheckListBox;
    drdgRiepilogoArrot: TDBRadioGroup;
    Panel8: TPanel;
    dchkRigheVuote: TDBCheckBox;
    dchkDettaglioDip: TDBCheckBox;
    btnGeneraTabella: TBitBtn;
    dchkAssenzaQM: TDBCheckBox;
    dgrdRighe: TDBGrid;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Accedi1: TMenuItem;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    drdgDebitoGGInt: TDBRadioGroup;
    dchkTotaleGen: TDBCheckBox;
    dedtMaxGG: TDBEdit;
    lblMaxGG: TLabel;
    gpbFruizione: TGroupBox;
    dchkFruizGG: TDBCheckBox;
    dchkFruizMG: TDBCheckBox;
    dchkFruizHH: TDBCheckBox;
    dchkFruizDH: TDBCheckBox;
    Label8: TLabel;
    cmbEsportaXml: TComboBox;
    btnInformazioni: TBitBtn;
    dchkDettaglioFamiliari: TDBCheckBox;
    dchkDettaglioGiustificativi: TDBCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dcmbTabellaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbTabellaCloseUp(Sender: TObject);
    procedure dcmbTabellaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbTipoAccorpCloseUp(Sender: TObject);
    procedure dcmbTipoAccorpKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Accedi1Click(Sender: TObject);
    procedure btnAccorpamentiClick(Sender: TObject);
    procedure dchkDettaglioDipClick(Sender: TObject);
    procedure cmbEsportaXmlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbEsportaXmlCloseUp(Sender: TObject);
    procedure cmbEsportaXmlKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstAssenzeClickCheck(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure dchkAssenzaGGIntClick(Sender: TObject);
    procedure dchkDettaglioGiustificativiClick(Sender: TObject);
    procedure btnGeneraTabellaClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    InterrompiElaborazione:Boolean;
    procedure AssegnaPickList;
    procedure Aggiorna(Colonne:String);
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    procedure CaricaListeColonne;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A151FAssenteismo: TA151FAssenteismo;

procedure OpenA151AssenteismoForzaLav(Prog:Integer);

implementation

uses A151UAssenteismoDtM, A151UGrigliaRisultato;

{$R *.dfm}

procedure OpenA151AssenteismoForzaLav(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA151AssenteismoForzaLav') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A151FAssenteismo:=TA151FAssenteismo.Create(nil);
  with A151FAssenteismo do
  try
    C700Progressivo:=Prog;
    A151FAssenteismoDtM:=TA151FAssenteismoDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A151FAssenteismoDtM.Free;
    Free;
  end;
end;

procedure TA151FAssenteismo.FormShow(Sender: TObject);
begin
  inherited;
  AssegnaPickList;
  with A151FAssenteismoDtM.A151MW do
  begin
    DButton.DataSet:=selT151;
    dcmbTabella.ListSource:=dsrT910;
    dcmbTipoAccorp.ListSource:=dsrT255;
    dgrdRighe.DataSource:=dsrRighe;
    selT151.Open;
  end;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A151FAssenteismoDtM.A151MW,SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  R001LinkC700:=False;
  DataI:= R180InizioMese(Parametri.DataLavoro);
  DataF:= R180FineMese(Parametri.DataLavoro);
  InterrompiElaborazione:=False;
  btnAnomalie.Enabled:=False;
  btnInformazioni.Enabled:=False;
  PageControl1.ActivePage:=tabNumDip;
  lstRiepilogo.Header[7]:=True;
  lstRiepilogo.Header[10]:=True;
  dcmbTipoAccorpCloseUp(nil);
  A151FAssenteismoDtM.A151MW.selT151.First;
end;

procedure TA151FAssenteismo.AssegnaPickList;
var i:Integer;
begin
  with A151FAssenteismoDtM.A151MW do
  begin
    for i:=0 to PLEsportaXML.Count - 1 do
      cmbEsportaXML.Items.Add(PLEsportaXML[i]);
    for i:=0 to lNumDip.Count - 1 do
      lstNumDip.Items.Add(lNumDip[i]);
    for i:=0 to lPres.Count - 1 do
      lstPresenze.Items.Add(lPres[i]);
    for i:=0 to lAss.Count - 1 do
      lstAssenze.Items.Add(lAss[i]);
    for i:=0 to lRiep.Count - 1 do
      lstRiepilogo.Items.Add(lRiep[i]);
  end;
end;

procedure TA151FAssenteismo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    if R180MessageBox(A000MSG_DLG_INTEROMPERE_OPERAZIONE,'DOMANDA') = mrYes then
      InterrompiElaborazione:=True;
  end;
end;

procedure TA151FAssenteismo.FormCreate(Sender: TObject);
begin
  inherited;
  frmInputPeriodo.CaptionDataOutI:= 'Data inizio elaborazione';
  frmInputPeriodo.CaptionDataOutF:= 'Data fine elaborazione';
end;

procedure TA151FAssenteismo.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA151FAssenteismo.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  if (DataI > 0) and (DataF > 0) then
  begin
    C700DataDal:= DataI;
    C700DataLavoro:= DataF;
  end
  else
  begin
    C700DataDal:=Parametri.DataLavoro;
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA151FAssenteismo.DButtonStateChange(Sender: TObject);
begin
  inherited;
  actModifica.Enabled:=DButton.State = dsBrowse; //and not(SolaLettura);
  actConferma.Enabled:=(DButton.State <> dsBrowse) and not(SolaLettura);
  btnGeneraTabella.Enabled:=DButton.State = dsBrowse;
  btnAccorpamenti.Enabled:=DButton.State <> dsBrowse;
  lstNumDip.Enabled:=DButton.State <> dsBrowse;
  lstPresenze.Enabled:=DButton.State <> dsBrowse;
  lstAssenze.Enabled:=DButton.State <> dsBrowse;
  lstRiepilogo.Enabled:=DButton.State <> dsBrowse;
  dgrdRighe.Enabled:=DButton.State <> dsBrowse;
  cmbEsportaXml.Enabled:=DButton.State <> dsBrowse;
end;

procedure TA151FAssenteismo.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA151FAssenteismo.dcmbTabellaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA151FAssenteismo.dcmbTabellaCloseUp(Sender: TObject);
begin
  inherited;
  with A151FAssenteismoDtM.A151MW do
  begin
    CodTabella:=dcmbTabella.Text;
    RecuperaTabella;
    AggiornaCdsRighe;
    Aggiorna(selT151.FieldByName('COLONNE').AsString);
  end;
end;

procedure TA151FAssenteismo.dcmbTabellaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTabellaCloseUp(nil);
end;

procedure TA151FAssenteismo.dcmbTipoAccorpCloseUp(Sender: TObject);
begin
  inherited;
  if A151FAssenteismoDtM.A151MW.selT255.SearchRecord('COD_TIPOACCORPCAUSALI',dcmbTipoAccorp.Text,[srFromBeginning]) then
    lblTipoAccorp.Caption:=A151FAssenteismoDtM.A151MW.selT255.FieldByName('DESCRIZIONE').AsString
  else
    lblTipoAccorp.Caption:='';
  if DButton.State in [dsEdit,dsInsert] then
  begin
    dedtAccorpamenti.Text:='';
    dedtAccorpamenti.Enabled:=Trim(dcmbTipoAccorp.Text) <> '';
    btnAccorpamenti.Enabled:=Trim(dcmbTipoAccorp.Text) <> '';
  end;
end;

procedure TA151FAssenteismo.dcmbTipoAccorpKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoAccorpCloseUp(nil);
end;

procedure TA151FAssenteismo.Accedi1Click(Sender: TObject);
begin
  inherited;
  OpenA150AccorpamentoCausali(dcmbTipoAccorp.Text,'');
end;

procedure TA151FAssenteismo.btnAccorpamentiClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with A151FAssenteismoDtM.A151MW.selT256 do
    begin
      Close;
      SetVariable('TIPO',dcmbTipoAccorp.Text);
      Open;
      C013FCheckList.clbListaDati.Items.Clear;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s',[FieldByName('COD_CODICIACCORPCAUSALI').AsString]) + ' ' + FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
    end;
    R180PutCheckList(A151FAssenteismoDtM.selT151.FieldByName('COD_CODICIACCORPCAUSALI').AsString,5,C013FCheckList.clbListaDati);
    C013FCheckList.ShowModal;
  finally
    A151FAssenteismoDtM.selT151.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=Trim(R180GetCheckList(5,C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA151FAssenteismo.dchkDettaglioDipClick(Sender: TObject);
begin
  inherited;
  dchkDettaglioGiustificativi.Enabled:=(dchkDettaglioDip.Checked);
  if not dchkDettaglioGiustificativi.Enabled then
    dchkDettaglioGiustificativi.Checked:=False;
  dchkDettaglioFamiliari.Enabled:=(dchkDettaglioGiustificativi.Checked);
  if not dchkDettaglioFamiliari.Enabled then
    dchkDettaglioFamiliari.Checked:=False;
end;

procedure TA151FAssenteismo.cmbEsportaXmlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    (Sender as TComboBox).ItemIndex:=-1;
end;

procedure TA151FAssenteismo.cmbEsportaXmlCloseUp(Sender: TObject);
begin
  inherited;
  with A151FAssenteismoDtM.A151MW do
  begin
    EsportaTassiAss:=False;
    EsportaLegge104:=False;
    case cmbEsportaXml.ItemIndex of
      0:EsportaTassiAss:=True;
      1:EsportaLegge104:=True;
    end;
  end;
end;

procedure TA151FAssenteismo.cmbEsportaXmlKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbEsportaXmlCloseUp(nil);
end;

procedure TA151FAssenteismo.lstAssenzeClickCheck(Sender: TObject);
begin
  inherited;
  dchkAssenzaQM.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[3];
  if not dchkAssenzaQM.Enabled then
    dchkAssenzaQM.Checked:=False;
  dchkAssenzaGGInt.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[3];
  if not dchkAssenzaGGInt.Enabled then
    dchkAssenzaGGInt.Checked:=False;
  dchkAssenzaGGLav.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[3] or lstAssenze.Checked[4] or lstAssenze.Checked[5];
  if not dchkAssenzaGGLav.Enabled then
    dchkAssenzaGGLav.Checked:=False;
  dchkDettaglioGiustificativi.Enabled:=(dchkDettaglioDip.Checked) and (lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[4] or lstAssenze.Checked[5]);
  if not dchkDettaglioGiustificativi.Enabled then
    dchkDettaglioGiustificativi.Checked:=False;
  dchkDettaglioFamiliari.Enabled:=(dchkDettaglioGiustificativi.Checked) and (lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[4] or lstAssenze.Checked[5]);
  if not dchkDettaglioFamiliari.Enabled then
    dchkDettaglioFamiliari.Checked:=False;
  dedtMaxGG.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[3] or lstAssenze.Checked[4] or lstAssenze.Checked[5];
  lblMaxGG.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[1] or lstAssenze.Checked[3] or lstAssenze.Checked[4] or lstAssenze.Checked[5];
  drdgAssenzaArrot.Enabled:=lstAssenze.Checked[0] or lstAssenze.Checked[3];
end;

procedure TA151FAssenteismo.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  inherited;
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
end;

procedure TA151FAssenteismo.dchkAssenzaGGIntClick(Sender: TObject);
begin
  inherited;
  drdgDebitoGGInt.Enabled:=dchkAssenzaGGInt.Checked;
end;

procedure TA151FAssenteismo.dchkDettaglioGiustificativiClick(Sender: TObject);
begin
  inherited;
  dchkDettaglioFamiliari.Enabled:=(dchkDettaglioGiustificativi.Checked);
  if not dchkDettaglioFamiliari.Enabled then
    dchkDettaglioFamiliari.Checked:=False;
end;

procedure TA151FAssenteismo.btnGeneraTabellaClick(Sender: TObject);
begin
  inherited;
  A151FAssenteismoDtM.evtRichiesta(A000MSG_A151_DLG_GENERA_TABELLA,'GeneraTabella');
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI, DataF) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  //Richiamare procedura di creazione tabella
  btnInformazioni.Enabled:=False;
  btnAnomalie.Enabled:=False;
  btnEsegui.Enabled:=False;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    A077FGeneratoreStampe:=TA077FGeneratoreStampe.Create(nil);
    with A077FGeneratoreStampe do
      try
        //C700Progressivo:=StrToInt(Prog);
        A077FGeneratoreStampeDtM:=TA077FGeneratoreStampeDtM.Create(nil);
        A077FGeneratoreStampe.FormShow(A077FGeneratoreStampe);
        A077FGeneratoreStampeDtM.Q910.SearchRecord('CODICE',dCmbTabella.Text,[srFromBeginning]);
        A077FGeneratoreStampe.DataI:= DataI;
        A077FGeneratoreStampe.DataF:= DataF;
        //A077FGeneratoreStampe.DocumentoPDF:='A151.pdf';
        A077FGeneratoreStampe.frmSelAnagrafe.SelezionePeriodica:=True;
        A077FGeneratoreStampe.frmSelAnagrafe.btnEreditaSelezioneClick(nil);
        //A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe);
        A077FGeneratoreStampe.btnAnteprimaClick(btnTabella);
      finally
        A077FGeneratoreStampeDtM.Free;
        Free;
      end;
  finally
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe(A151FAssenteismoDtM.A151MW);
    btnEsegui.Enabled:=True;
    with A151FAssenteismoDtM.A151MW do
    begin
      CreaIndice:=True;
      AggiornaCdsRighe;
      Aggiorna(selT151.FieldByName('COLONNE').AsString);
    end;
  end;
end;

procedure TA151FAssenteismo.btnEseguiClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI, DataF) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;

  CaricaListeColonne;
  with A151FAssenteismoDtM.A151MW do
  begin
    CodTabella:=dcmbTabella.Text;
    RecuperaTabella;
    TipoAccorp:=dcmbTipoAccorp.Text;
    ElencoAccorp.CommaText:=dedtAccorpamenti.Text;
    iEsportaXml:=cmbEsportaXML.ItemIndex;
    DettDip:=dchkDettaglioDip.Checked;
    iNumDipPeriodo:=drdgNumDipPeriodo.ItemIndex;
    PresGGLav:=dchkPresenzaGGLav.Checked;
    AssGGLav:=dchkAssenzaGGLav.Checked;
    GGInt:=dchkAssenzaGGInt.Checked;
    iDebitoGGInt:=drdgDebitoGGInt.ItemIndex;
    AssQM:=dchkAssenzaQM.Checked;
    DettGG:=dchkDettaglioGiustificativi.Checked;
    DettFam:=dchkDettaglioFamiliari.Checked;
    FruizGG:=dchkFruizGG.Checked;
    FruizMG:=dchkFruizMG.Checked;
    FruizHH:=dchkFruizHH.Checked;
    FruizDH:=dchkFruizDH.Checked;
    MaxGG:=StrToIntDef(dedtMaxGG.Text,0);
    DaData:= DataI;
    AData:= DataF;
    CaricaElencoColonne;
    CaricaElencoRighe;
    Domande;
    Controlli;
  end;

  btnInformazioni.Enabled:=False;
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio('A151');
  Screen.Cursor:=crHourGlass;
  A151FAssenteismo.KeyPreview:=True;


  with A151FAssenteismoDtM.A151MW do
  begin
    PreparaElaborazione;
    //--------------------------
    //Carica tabella risultato con dati dipendenti e presenza
    //--------------------------
    if OpzioneNumDip or OpzioneRiepilogoDip or OpzionePresenze or OpzioneRiepilogoPres then
    begin
      StatusBar.Panels[3].Text:=A000MSG_A151_MSG_ELAB_PRESENZE;
      StatusBar.Repaint;
      ProgressBar1.Max:=selV430.RecordCount;
      ProgressBar1.Position:=0;
      OldProg:=0;
      while not selV430.Eof do  //ciclo sui dip.selezionati
      begin
        if SelAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
          frmSelAnagrafe.VisualizzaDipendente;
        if not selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_DIP_NON_PRES,[Tabella]),'',selV430.FieldByName('PROGRESSIVO').AsInteger)
        else
        begin
          Application.ProcessMessages;
          if InterrompiElaborazione then
          begin
            InterrompiElaborazione:=False;
            Screen.Cursor:=crDefault;
            ProgressBar1.Position:=0;
            StatusBar.Panels[3].Text:='';
            raise exception.Create(A000MSG_MSG_OPERAZIONE_INTERROTTA);
          end;
          CaricaTabellaRisultato('PRES','');
        end;
        OldProg:=selV430.FieldByName('PROGRESSIVO').AsInteger;
        selV430.Next;
        ProgressBar1.StepBy(1);
      end;
    end;

    //--------------------------
    //Carica tabella risultato con dati di assenza
    //--------------------------
    if OpzioneAssenze or OpzioneAssenzeL104 or OpzioneEventiAssenze or OpzioneRiepilogoAss then
    begin
      StatusBar.Panels[3].Text:=A000MSG_A151_MSG_ELAB_ASSENZE;
      StatusBar.Repaint;
      if OpzioneEventiAssenze and (OpzioneAssenze or OpzioneAssenzeL104 or OpzioneRiepilogoAss) then
        ProgressBar1.Max:=ElencoAccorp.Count * selV430.RecordCount * 2  //Se devo elaborare sia gli eventi che i gg.assenza --> 2 giri
      else
        ProgressBar1.Max:=ElencoAccorp.Count * selV430.RecordCount;
      ProgressBar1.Position:=0;
      //CICLO PER OGNI ACCORPAMENTO DI ASSENZA SELEZIONATO
      for i:=0 to ElencoAccorp.Count - 1 do
      begin
        //--- Carico in tabella risultato i dati degli eventi assenze
        if OpzioneEventiAssenze then
        begin
          OldProg:=0;
          selV430.First;
          while not selV430.Eof do  //ciclo sui dip.selezionati
          begin
            if SelAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              frmSelAnagrafe.VisualizzaDipendente;
            if not selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A151_ERR_FMT_DIP_NON_PRES,[Tabella]),'',selV430.FieldByName('PROGRESSIVO').AsInteger)
            else
            begin
              Application.ProcessMessages;
              if InterrompiElaborazione then
              begin
                InterrompiElaborazione:=False;
                Screen.Cursor:=crDefault;
                ProgressBar1.Position:=0;
                StatusBar.Panels[3].Text:='';
                raise exception.Create(A000MSG_MSG_OPERAZIONE_INTERROTTA);
              end;
              //Registro solo se cambia progressivo
              if (OldProg <> 0) and (OldProg <> selV430.FieldByName('PROGRESSIVO').AsInteger) then
              begin
                cdsRisultato.Edit;
                cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + NumEventi;
                cdsRisultato.FieldByName('ASS10GG').AsFloat:=cdsRisultato.FieldByName('ASS10GG').AsFloat + NumEventi;
                cdsRisultato.Post;
              end;
              CaricaTabellaRisultato('EV',ElencoAccorp.Strings[i]);
            end;
            OldProg:=selV430.FieldByName('PROGRESSIVO').AsInteger;
            selV430.Next;
            ProgressBar1.StepBy(1);
          end;
          //Registro ultimo progressivo
          cdsDettaglio.Post;
          cdsRisultato.Edit;
          cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat:=cdsRisultato.FieldByName('ASS10GG_' + TipoAccorp + '#' + ElencoAccorp.Strings[i]).AsFloat + NumEventi;
          cdsRisultato.FieldByName('ASS10GG').AsFloat:=cdsRisultato.FieldByName('ASS10GG').AsFloat + NumEventi;
          cdsRisultato.Post;
        end;
        //---- Carico in tabella risultato i dati delle assenze (al netto degli eventi dove serve)
        if OpzioneAssenze or OpzioneAssenzeL104 or OpzioneRiepilogoAss then
        begin
          OldProg:=0;
          selV430.First;
          while not selV430.Eof do  //ciclo sui dip.selezionati
          begin
            if SelAnagrafe.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              frmSelAnagrafe.VisualizzaDipendente;
            if selSQL.SearchRecord('PROGRESSIVO',selV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              CaricaTabellaRisultato('ASS',ElencoAccorp.Strings[i]);
            OldProg:=selV430.FieldByName('PROGRESSIVO').AsInteger;
            selV430.Next;
            ProgressBar1.StepBy(1);
          end;
        end;
      end;
    end;

    //--------------------------
    //Totali generali e dati riepilogativi
    //--------------------------
    StatusBar.Panels[3].Text:=A000MSG_A151_MSG_ELAB_TOTALI;
    StatusBar.Repaint;

    TotGen:=dchkTotaleGen.Checked;
    RigheVuote:=dchkRigheVuote.Checked;
    iNumDipArrot:=drdgNumDipArrot.ItemIndex;
    iAssArrot:=drdgAssenzaArrot.ItemIndex;
    iRiepArrot:=drdgRiepilogoArrot.ItemIndex;
    OperazioniFinali;
  end;
  A151FAssenteismo.KeyPreview:=False;
  StatusBar.Panels[3].Text:='';
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
  btnInformazioni.Enabled:=RegistraMsg.ContieneTipoI;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if (RegistraMsg.ContieneTipoA) and
     (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
    btnAnomalieClick(btnAnomalie);
  if (not RegistraMsg.ContieneTipoA) and (RegistraMsg.ContieneTipoI) and
     (R180MessageBox(A000MSG_DLG_ELAB_SEGNALAZIONI_VIS,DOMANDA) = mrYes) then
    btnAnomalieClick(nil);
  OpenA151GrigliaRisultato;
end;

procedure TA151FAssenteismo.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  if Sender = btnAnomalie then
    OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A151','A')
  else
    OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A151','I');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A151FAssenteismoDtM.A151MW);
end;

procedure TA151FAssenteismo.Aggiorna(Colonne:String);
var i:Integer;
begin
  //Caricamento colonne
  for i:=0 to lstNumDip.Count - 1 do
  begin
    lstNumDip.Checked[i]:=False;
    if Pos(',' + Copy(lstNumDip.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstNumDip.Checked[i]:=True;
  end;
  for i:=0 to lstPresenze.Count - 1 do
  begin
    lstPresenze.Checked[i]:=False;
    if Pos(',' + Copy(lstPresenze.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstPresenze.Checked[i]:=True;
  end;
  for i:=0 to lstAssenze.Count - 1 do
  begin
    lstAssenze.Checked[i]:=False;
    if Pos(',' + Copy(lstAssenze.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstAssenze.Checked[i]:=True;
  end;
  for i:=0 to lstRiepilogo.Count - 1 do
  begin
    lstRiepilogo.Checked[i]:=False;
    if (lstRiepilogo.Items[i] <> '') and
       (Pos(',' + Copy(lstRiepilogo.Items[i],2,3) + ',',',' + Colonne + ',') > 0) then
      lstRiepilogo.Checked[i]:=True;
  end;
end;

procedure TA151FAssenteismo.CaricaListeColonne;
var i:Integer;
begin
  with A151FAssenteismoDtM.A151MW do
  begin
    NumDipSel:='';
    for i:=0 to lstNumDip.Count - 1 do
      if lstNumDip.Checked[i] then
        NumDipSel:=NumDipSel + IfThen(Trim(NumDipSel) <> '',',') + Copy(lstNumDip.Items[i],2,3);
    PresenzeSel:='';
    for i:=0 to lstPresenze.Count - 1 do
      if lstPresenze.Checked[i] then
        PresenzeSel:=PresenzeSel + IfThen(Trim(PresenzeSel) <> '',',') + Copy(lstPresenze.Items[i],2,3);
    AssenzeSel:='';
    for i:=0 to lstAssenze.Count - 1 do
      if lstAssenze.Checked[i] then
        AssenzeSel:=AssenzeSel + IfThen(Trim(AssenzeSel) <> '',',') + Copy(lstAssenze.Items[i],2,3);
    RiepilogoSel:='';
    for i:=0 to lstRiepilogo.Count - 1 do
      if lstRiepilogo.Checked[i] then
        RiepilogoSel:=RiepilogoSel + IfThen(Trim(RiepilogoSel) <> '',',') + Copy(lstRiepilogo.Items[i],2,3);
  end;
end;

{ DataI }
function TA151FAssenteismo._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA151FAssenteismo._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ DataI----- }
{ DataF }
function TA151FAssenteismo._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA151FAssenteismo._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ DataF----- }
end.

unit A100UMissioni;

interface

uses
  A100UCheckRimborsi,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, ComCtrls, A000UCostanti, A000USessione,
  A000UInterfaccia, C700USelezioneAnagrafe,
  Menus, C005UDatiAnagrafici, Db, R001UGESTTAB, Grids, DBGrids,
  DBCtrls, ActnList, ImgList, ToolWin, OracleData,
  A002UInterfacciaSt, C001UFiltroTabelle, C001UFiltroTabelleDtM,
  C001UScegliCampi, C180FunzioniGenerali,
  SelAnagrafe, A120UTIPIRIMBORSI, A129UIndennitaKm, Variants, QueryStorico,
  L001Call, C010USelezioneDaElenco, System.UITypes,
  ToolbarFiglio, A023UTimbrature, System.Actions, A100UMissioniMW,
  C020UVisualizzaDataset, A100UElencoRiaperture, System.ImageList;

type
  TA100FMISSIONI = class(TR001FGestTab)
    Panel3: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dedtProtocollo: TDBEdit;
    dedtDataDa: TDBEdit;
    dedtOraDa: TDBEdit;
    dedtDataA: TDBEdit;
    dedtOraA: TDBEdit;
    dedtTotaleGiorni: TDBEdit;
    dedtTotaleOre: TDBEdit;
    Panel4: TPanel;
    PageControl1: TPageControl;
    DatiTrasferta: TTabSheet;
    Panel5: TPanel;
    lblIndTrasfInt: TLabel;
    lblSupOreMasRimbPasto: TLabel;
    Label20: TLabel;
    lblSuperoMaxGiorniMese: TLabel;
    lblSuperoMaxOreGiorni: TLabel;
    Label15: TLabel;
    lblOreGiorni: TLabel;
    Label17: TLabel;
    dedtTariffaIndennitaTrasfertaIntera: TDBEdit;
    dedtOreIndennitaTrasfertaIntera: TDBEdit;
    dedtTariffaSuperoOreMassime: TDBEdit;
    dedtOreSuperoOreMassime: TDBEdit;
    dedtTotaleSuperoOreMassime: TDBEdit;
    dedtTariffaSuperoGiorniMese: TDBEdit;
    dedtOreSuperoGiorniMese: TDBEdit;
    dedtTotaleSuperoGiorniMese: TDBEdit;
    dedtTariffaSuperoOreGiorni: TDBEdit;
    dedtOreSuperoOreGiorni: TDBEdit;
    dedtTotaleSuperoOreGiorni: TDBEdit;
    dedtOreTotaliIndennita: TDBEdit;
    dedtTotaleIndennita: TDBEdit;
    Rimborsi: TTabSheet;
    PmnRimborsi: TPopupMenu;
    dedtPeriodo: TDBEdit;
    Label35: TLabel;
    dChkModifica: TDBCheckBox;
    Panel7: TPanel;
    dedtTotaleMissione: TDBEdit;
    Label21: TLabel;
    Label25: TLabel;
    chkIndennitaSupMaxGG: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    TabSheet1: TTabSheet;
    mnuNuovo: TMenuItem;
    GroupBox1: TGroupBox;
    dgrdRimborsi: TDBGrid;
    Azioni1: TMenuItem;
    Ricalcolarimborsichilometrici1: TMenuItem;
    actRicalcolaIndKm: TAction;
    Label14: TLabel;
    dCmbTipoMissione: TDBLookupComboBox;
    DBText1: TDBText;
    Label26: TLabel;
    CmbCommessa: TComboBox;
    Panel9: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    CmbPartenza: TComboBox;
    Panel6: TPanel;
    Panel8: TPanel;
    Label23: TLabel;
    Label30: TLabel;
    dedtKmTotaliIndennitaKm: TDBEdit;
    dedtImportiTotaliIndennitaKm: TDBEdit;
    DbGrdIndennitaKm: TDBGrid;
    Label22: TLabel;
    dEdtCostoMissione: TDBEdit;
    CmbDestinazione: TComboBox;
    Label2: TLabel;
    DCmbStato: TDBComboBox;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    DCmbLookpCodTariff: TDBLookupComboBox;
    lblCodiceTariffa: TLabel;
    DCmbLookUpCodRiduzione: TDBLookupComboBox;
    lblCodiceRiduzione: TLabel;
    LblCodTariff: TLabel;
    LblCodRiduzione: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    PmnTariffe: TPopupMenu;
    NuovoElemento1: TMenuItem;
    frmToolbarFiglioIndKM: TfrmToolbarFiglio;
    frmToolbarFiglioRimb: TfrmToolbarFiglio;
    actCartellinoInterattivo: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    actImpRimborsiIter: TAction;
    Importarichiestedeidipendenti1: TMenuItem;
    DettaglioGG: TTabSheet;
    dgrdDettGG: TDBGrid;
    frmToolbarFiglioDettGG: TfrmToolbarFiglio;
    rgpRichiestaWeb: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    dlblAnnullata: TDBText;
    dedtTotaleIndennitaTrasfertaIntera: TDBEdit;
    actCheckRimborsi: TAction;
    Controllorimborsi1: TMenuItem;
    PmnServiziAttivi: TPopupMenu;
    mnuAggiornaSerAtt: TMenuItem;
    actRiapriRichiestaMissione: TAction;
    mnuRiapriMissione: TMenuItem;
    dchkMissioneRiaperta: TDBCheckBox;
    N4: TMenuItem;
    actImportRimborsiAgenzia: TAction;
    Importazionerimborsidaagenziaviaggio1: TMenuItem;
    btnDettaglioPercorso: TButton;
    mnuVisualizzaRiaperture: TMenuItem;
    actElencoRiaperture: TAction;
    dmemoNoteRimborsi: TDBMemo;
    dtxtProtocolloManuale: TDBText;
    procedure ToolButton7Click(Sender: TObject);
    procedure dedtOraDaChange(Sender: TObject);
    procedure NuovoElemento2Click(Sender: TObject);
    procedure dCmbTipoMissioneCloseUp(Sender: TObject);
    procedure DCmbLookUpCodRiduzioneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCmbLookpCodTariffKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButton9Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure DCmbStatoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DbGrdIndennitaKmEditButtonClick(Sender: TObject);
    procedure dedtDataDaExit(Sender: TObject);
    procedure dCmbTipoMissioneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dChkModificaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure chkIndennitaSupMaxGGClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure mnuNuovoClick(Sender: TObject);
    procedure actRicalcolaIndKmExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure PmnRimborsiPopup(Sender: TObject);
    procedure dgrdRimborsiEditButtonClick(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure frmToolbarFiglioRimbactTFModificaExecute(Sender: TObject);
    procedure frmToolbarFiglioRimbactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioRimbactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioRimbactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioRimbactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioIndKMactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioIndKMactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioIndKMactTFModificaExecute(Sender: TObject);
    procedure frmToolbarFiglioIndKMactTFInserisciExecute(Sender: TObject);
    procedure dedtDataAExit(Sender: TObject);
    procedure actCartellinoInterattivoExecute(Sender: TObject);
    procedure actImpRimborsiIterExecute(Sender: TObject);
    procedure frmToolbarFiglioDettGGactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioDettGGactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioDettGGactTFModificaExecute(Sender: TObject);
    procedure frmToolbarFiglioDettGGactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioDettGGactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioIndKMactTFCancellaExecute(Sender: TObject);
    procedure actCheckRimborsiExecute(Sender: TObject);
    procedure PmnServiziAttiviPopup(Sender: TObject);
    procedure mnuAggiornaSerAttClick(Sender: TObject);
    procedure actRiapriRichiestaMissioneExecute(Sender: TObject);
    procedure actImportRimborsiAgenziaExecute(Sender: TObject);
    procedure btnDettaglioPercorsoClick(Sender: TObject);
    procedure actElencoRiapertureExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AbilitaCampi(Valore:boolean);
    procedure CambiaProgressivo;
    procedure VerificaRimborsoPasto;
  public
    { Public declarations }
    sPb_CodiceTariffa, sPb_CodiceRimborsoPasto:String;
    //iPb_ImportoRimborsoPasto, iPb_ImportoIndennita:Real;
    procedure GestioneCampi;
  end;

const
     D_Stato:array[0..3] of string = ({D}'Da liquidare',
                                      {G}'Liquidata',
                                      {B}'Parzialmente liquidata',
                                      {C}'Sospesa');

var
  A100FMISSIONI: TA100FMISSIONI;

procedure OpenA100Missioni(Prog:Integer);

implementation

uses A100UMISSIONIDTM, A100URicalcoloIndTrasp, A100UDettaglioRimborsi,
     A100UDistanzeChilometriche, A100UImpRimborsiIter,
     A131UGestioneAnticipi, A133UTariffeMIssioni, Ac05UImportRimborsi;

{$R *.DFM}

procedure OpenA100Missioni(Prog:Integer);
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA100Missioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA100FMISSIONI, A100FMISSIONI);
  C700Progressivo:=Prog;
  Application.CreateForm(TA100FMISSIONIDtM, A100FMISSIONIDtM);
  try
    Screen.Cursor:=crDefault;
    A100FMissioni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A100FMissioni.Free;
    A100FMissioniDtM.Free;
  end;
end;

procedure TA100FMISSIONI.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePageIndex:=0;
  AbilitaCampi(False);
end;

procedure TA100FMISSIONI.FormShow(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C8_Missione = '' then
    R180MessageBox('Regole trasferte non specificate nella maschera <A008> Gestione Aziende.','ERRORE');
  dCmbTipoMissione.ListSource:=A100FMISSIONIdtm.A100FMissioniMW.dsrM011;
  DCmbLookpCodTariff.ListSource:=A100FMISSIONIdtm.A100FMissioniMW.dM065;
  DCmbLookUpCodRiduzione.ListSource:=A100FMISSIONIdtm.A100FMissioniMW.dM066;
  DbGrdIndennitaKm.DataSource:=A100FMISSIONIdtm.A100FMissioniMW.D052;
  dgrdDettGG.DataSource:=A100FMISSIONIdtm.A100FMissioniMW.dsrM043;
  dgrdRimborsi.DataSource:=A100FMISSIONIDTM.D050;
  DButton.DataSet:=A100FMISSIONIDTM.M040;

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A100FMISSIONIDTM.A100FMissioniMW,SessioneOracle,StatusBar,2,True);
  // toolbar indennità km
  frmToolbarFiglioIndKM.TFDButton:=A100FMissioniDtM.A100FMissioniMW.D052;
  frmToolbarFiglioIndKM.TFDBGrid:=dbGrdIndennitaKM;
  SetLength(frmToolbarFiglioIndKM.lstLock,7);
  frmToolbarFiglioIndKM.lstLock[0]:=Panel1;
  frmToolbarFiglioIndKM.lstLock[1]:=File1;
  frmToolbarFiglioIndKM.lstLock[2]:=Strumenti1;
  frmToolbarFiglioIndKM.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglioIndKM.lstLock[4]:=Azioni1;
  frmToolbarFiglioIndKM.lstLock[5]:=frmToolbarFiglioRimb;
  frmToolbarFiglioIndKM.lstLock[6]:=frmToolbarFiglioDettGG;
  frmToolbarFiglioIndKM.AbilitaAzioniTF(nil);
  // toolbar rimborsi
  frmToolbarFiglioRimb.TFDButton:=A100FMissioniDtM.D050;
  frmToolbarFiglioRimb.TFDBGrid:=dgrdRimborsi;
  SetLength(frmToolbarFiglioRimb.lstLock,7);
  frmToolbarFiglioRimb.lstLock[0]:=Panel1;
  frmToolbarFiglioRimb.lstLock[1]:=File1;
  frmToolbarFiglioRimb.lstLock[2]:=Strumenti1;
  frmToolbarFiglioRimb.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglioRimb.lstLock[4]:=Azioni1;
  frmToolbarFiglioRimb.lstLock[5]:=frmToolbarFiglioIndKM;
  frmToolbarFiglioRimb.lstLock[6]:=frmToolbarFiglioDettGG;
  frmToolbarFiglioRimb.AbilitaAzioniTF(nil);
// toolbar dettaglio giornaliero
  frmToolbarFiglioDettGG.TFDButton:=A100FMissioniDtM.A100FMissioniMW.dsrM043;
  frmToolbarFiglioDettGG.TFDBGrid:=dgrdDettGG;
  SetLength(frmToolbarFiglioDettGG.lstLock,7);
  frmToolbarFiglioDettGG.lstLock[0]:=Panel1;
  frmToolbarFiglioDettGG.lstLock[1]:=File1;
  frmToolbarFiglioDettGG.lstLock[2]:=Strumenti1;
  frmToolbarFiglioDettGG.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglioDettGG.lstLock[4]:=Azioni1;
  frmToolbarFiglioDettGG.lstLock[5]:=frmToolbarFiglioIndKM;
  frmToolbarFiglioDettGG.lstLock[6]:=frmToolbarFiglioRimb;
  frmToolbarFiglioDettGG.AbilitaAzioniTF(nil);
  //GIA OK SU CLOUD
  dChkModifica.Visible:=Parametri.CampiRiferimento.C8_GestioneMensile <> 'N';   //Se è prevista la gestione a cavallo di mese non visualizzo il campo
end;

procedure TA100FMISSIONI.GestioneCampi;
begin
//=======================================================
//GESTIONE CAMPI PILOTATI DAL PARAMETRO SELEZIONE TARIFFA
//NELLA MASCHERA DELLE REGOLE
//=======================================================
  with A100FMISSIONIDTM do
  begin
    if C700Progressivo <= 0 then
      Exit;
    if Not(A100FMissioniMW.Q010.Active) then
      A100FMissioniMW.LeggiParametri(m040DATAA.asDatetime,m040TIPOREGISTRAZIONE.AsString);
    if (A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S') then
    begin
      lblSuperoMaxGiorniMese.Visible:=False;
      dedtTariffaSuperoGiorniMese.Visible:=False;
      dedtOreSuperoGiorniMese.Visible:=False;
      dedtTotaleSuperoGiorniMese.Visible:=False;
      lblSuperoMaxOreGiorni.Visible:=False;
      dedtTariffaSuperoOreGiorni.Visible:=False;
      dedtOreSuperoOreGiorni.Visible:=False;
      dedtTotaleSuperoOreGiorni.Visible:=False;
      if DButton.State in [dsEdit,dsInsert] then
      begin
        M040.FieldByName('OREINDRIDOTTAG').Clear;
        M040.FieldByName('IMPORTOINDRIDOTTAG').Clear;
        M040.FieldByName('TARIFFAINDRIDOTTAHG').Clear;
        M040.FieldByName('OREINDRIDOTTAHG').Clear;
        M040.FieldByName('TARIFFAINDRIDOTTAG').Clear;
        M040.FieldByName('IMPORTOINDRIDOTTAHG').Clear;
      end;
      lblIndTrasfInt.Caption:='Quota esente da tassazione';
      lblSupOreMasRimbPasto.Caption:='Quota assoggettata a tassazione';
    end
    else
    begin
      lblSuperoMaxGiorniMese.Visible:=True;
      dedtTariffaSuperoGiorniMese.Visible:=True;
      dedtOreSuperoGiorniMese.Visible:=True;
      dedtTotaleSuperoGiorniMese.Visible:=True;
      lblSuperoMaxOreGiorni.Visible:=True;
      dedtTariffaSuperoOreGiorni.Visible:=True;
      dedtOreSuperoOreGiorni.Visible:=True;
      dedtTotaleSuperoOreGiorni.Visible:=True;
      lblIndTrasfInt.Caption:='Indennità di trasferta intera';
      lblSupOreMasRimbPasto.Caption:='Al supero ore massime/rimborso pasto';
    end;
  end;
end;

procedure TA100FMISSIONI.CambiaProgressivo;
begin
  if (C700OldProgressivo <> C700Progressivo) and (C700Progressivo > 0) then
  begin
    A100fmissionidtm.SettaProgressivo;
    NumRecords;
    A100FMISSIONIDtM.A100FMissioniMW.AggiornaDati;
  end;
end;

procedure TA100FMISSIONI.AbilitaCampi(Valore:boolean);
begin
  //Pannello 1
  dedtTotaleGiorni.enabled:=valore;
  dedtTotaleOre.enabled:=valore;
  //Pannello 2
  dedtTariffaIndennitaTrasfertaIntera.enabled:=valore;
  dedtOreIndennitaTrasfertaIntera.enabled:=valore;
  dedtTariffaSuperoOreMassime.enabled:=valore;
  dedtOreSuperoOreMassime.enabled:=valore;
  dedtTariffaSuperoGiorniMese.enabled:=valore;
  dedtOreSuperoGiorniMese.enabled:=valore;
  dedtTariffaSuperoOreGiorni.enabled:=valore;
  dedtOreSuperoOreGiorni.enabled:=valore;
end;

procedure TA100FMISSIONI.dChkModificaClick(Sender: TObject);
begin
  inherited;
  AbilitaCampi(dChkModifica.Checked);
  A100fmissionidtm.M040DATAAValidate(A100fmissionidtm.M040FLAG_MODIFICATO);
end;

procedure TA100FMISSIONI.VerificaRimborsoPasto;
(*obsoleto??*)
begin
  dgrdRimborsi.Columns[0].PickList.Clear;
  A100fmissionidtm.A100FMissioniMW.VerificaRimborsoPastoEsistente;
end;

procedure TA100FMISSIONI.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then  //Gestione mensile
    chkIndennitaSupMaxGG.Visible:=DButton.State in [dsInsert, dsEdit];
  chkIndennitaSupMaxGG.Checked:=False;
  A100FMISSIONIDTM.A100FMissioniMW.bIndennitaSupMaxGG:=chkIndennitaSupMaxGG.Checked;

  DCmbStato.Enabled:=DButton.State in [dsInsert, dsEdit];
  CmbCommessa.Enabled:=DButton.State in [dsInsert, dsEdit];
  CmbPartenza.Enabled:=DButton.State in [dsInsert, dsEdit];
  CmbDestinazione.Enabled:=DButton.State in [dsInsert, dsEdit];
  if A100fMissioniDtm.M040.RecordCount = 0 then
  begin
    if frmToolbarFiglioIndKM.TFDButton <> nil then
      frmToolbarFiglioIndKM.AbilitaAzioniTF(nil);
    if frmToolbarFiglioRimb.TFDButton <> nil then
      frmToolbarFiglioRimb.AbilitaAzioniTF(nil);
    if frmToolbarFiglioDettGG.TFDButton <> nil then
      frmToolbarFiglioDettGG.AbilitaAzioniTF(nil);
    frmToolbarFiglioIndKM.Enabled:=False;
    frmToolbarFiglioRimb.Enabled:=False;
    frmToolbarFiglioDettGG.Enabled:=False;

    try
      dedtPeriodo.setfocus;
    except
    end;
  end;
end;

procedure TA100FMISSIONI.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Field = nil) then
  begin
    rgpRichiestaWeb.Visible:=not A100FMissioniDtM.M040.FieldByName('FLAG_DESTINAZIONE').IsNull;
    dlblAnnullata.Visible:=not A100FMissioniDtM.M040.FieldByName('D_ANNULLATA').IsNull;
    btnDettaglioPercorso.Enabled:=not A100FMissioniDtM.M040.FieldByName('ID').IsNull;
  end;

//=====================================================================
//CALCOLO DELLA MISSIONE IN BASE ALLE TARIFFE ESTRATTE DALLA M065, M066
//=====================================================================
  with A100FMissioniDtM do
  begin
    if (DButton.State <> dsBrowse) and (Field = A100FMissioniDtM.M040.FieldByName('COD_TARIFFA')) then
    begin
      A100FMissioniMW.selM066.Close;
      A100FMissioniMW.selM066.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
      A100FMissioniMW.selM066.SetVariable('PROGRESSIVO',C700Progressivo);
      A100FMissioniMW.selM066.SetVariable('COD_TARIFF',M040.FieldByName('COD_TARIFFA').AsString);
      A100FMissioniMW.selM066.SetVariable('DATA',M040.FieldByName('DATADA').AsDateTime);
      A100FMissioniMW.selM066.Open;
      A100FMISSIONIDTM.A100FMissioniMW.ElaboraDaTariffe;
    end;
    if (DButton.State <> dsBrowse) and (M040.FieldByName('COD_TARIFFA').AsString <> '') and
       (M040.FieldByName('COD_RIDUZIONE').AsString <> '') and ((Field = A100FMissioniDtM.M040.FieldByName('COD_TARIFFA')) or
       (Field = M040.FieldByName('COD_RIDUZIONE'))) then
      A100FMISSIONIDTM.A100FMissioniMW.ElaboraDaTariffe;
    if A100FMissioniMW.selM065.Active then
      LblCodTariff.Caption:=VarToStr(A100FMissioniMW.selM065.Lookup('COD_TARIFFA',M040.FieldByName('COD_TARIFFA').AsString,'DESCRIZIONE'));
    if A100FMissioniMW.selM066.Active then
      LblCodRiduzione.Caption:=VarToStr(A100FMissioniMW.selM066.Lookup('COD_RIDUZIONE',M040.FieldByName('COD_RIDUZIONE').AsString,'DESCRIZIONE'));
  end;
//=====================================================================

//da qui in poi già OK SU CLOUD

  if DButton.State = dsBrowse then
  begin
    with A100FMissioniDtM do
    begin
      if M040COMMESSA.AsString <> '' then
      begin
        CmbCommessa.Text:= Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',[M040COMMESSA.AsString]);
        if M040DESCCOMMESSA.AsString <> '' then
          CmbCommessa.Text:=CmbCommessa.Text + ' - ' + M040DESCCOMMESSA.AsString;
      end
      else
        CmbCommessa.Text:='';
      if M040PARTENZA.AsString <> '' then
      begin
        CmbPartenza.Text:=Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[M040PARTENZA.AsString]);
        if M040DESCPARTENZA.AsString <> '' then
          CmbPartenza.Text:=CmbPartenza.Text + ' - ' + M040DESCPARTENZA.AsString;
      end
      else
        CmbPartenza.Text:='';
      if M040DESTINAZIONE.AsString <> '' then
        CmbDestinazione.Text:= M040DESTINAZIONE.AsString
      else
        CmbDestinazione.Text:='';
    end;
  end;
end;

procedure TA100FMISSIONI.chkIndennitaSupMaxGGClick(Sender: TObject);
begin
  inherited;
  A100FMISSIONIDTM.A100FMissioniMW.bIndennitaSupMaxGG:=chkIndennitaSupMaxGG.Checked;
  if Not(A100FMISSIONIDTM.A100FMissioniMW.TabTariffe) then
    A100fmissionidtm.A100FMissioniMW.ElaboraMissione
  else
    A100FMISSIONIDTM.A100FMissioniMW.ElaboraDaTariffe;
end;

procedure TA100FMISSIONI.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

// gestione toolbar indennità km
procedure TA100FMISSIONI.frmToolbarFiglioIndKMactTFAnnullaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioIndKM.actTFAnnullaExecute(frmToolbarFiglioIndKM.actTFAnnulla);
  A100FMissioniDtM.A100FMissioniMW.CalcolaTotaliIndennitaKm;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleIndennita(False);
end;

procedure TA100FMISSIONI.frmToolbarFiglioIndKMactTFCancellaExecute(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglioIndKM.actTFCancellaExecute(Sender);
  //Caratto 16/12/2013 non aggiornava totatli se cancellavo record
  A100FMissioniDtM.A100FMissioniMW.CalcolaTotaliIndennitaKm;
end;

procedure TA100FMISSIONI.frmToolbarFiglioIndKMactTFConfermaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioIndKM.actTFConfermaExecute(frmToolbarFiglioIndKM.actTFConferma);
  A100FMissioniDtM.A100FMissioniMW.CalcolaTotaliIndennitaKm;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleIndennita(False);
end;

procedure TA100FMISSIONI.frmToolbarFiglioIndKMactTFInserisciExecute(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleIndennita;
  frmToolbarFiglioIndKM.actTFInserisciExecute(frmToolbarFiglioIndKM.actTFInserisci);
end;

procedure TA100FMISSIONI.frmToolbarFiglioIndKMactTFModificaExecute(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleIndennita;
  frmToolbarFiglioIndKM.actTFModificaExecute(frmToolbarFiglioIndKM.actTFModifica);
end;

// gestione toolbar rimborsi
procedure TA100FMISSIONI.frmToolbarFiglioRimbactTFAnnullaExecute(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FMissioniMW.M051.CancelUpdates;
  A100FMissioniDtM.A100FMissioniMW.M051.ReadOnly:=True;
  frmToolbarFiglioRimb.actTFAnnullaExecute(frmToolbarFiglioRimb.actTFAnnulla);
  A100FMissioniDtM.A100FMissioniMW.CalcolaTotaleRimborsi;
  //MemNoteRimborsi.ReadOnly:=True;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleRimborsi(False);
end;

procedure TA100FMISSIONI.frmToolbarFiglioRimbactTFCancellaExecute(Sender: TObject);
var bSegnalazionePastoOldValue:Boolean;
  Msg:String;
begin
  inherited;
  with A100FMissioniDtM do
  begin
    if DButton.DataSet.RecordCount = 0 then
      exit;
    if MessageDlg('Confermi cancellazione ?', mtInformation, [mbYes, mbNo], 0) = mrYes then
    begin
      dgrdRimborsi.Columns[0].PickList.Clear;
      A100FMissioniMW.VerificaRimborsoPastoEsistente;
      bSegnalazionePastoOldValue:=A100FMissioniMW.bPb_RimborsoPastoEsistente;
      A100FMissioniMW.Q050.ReadOnly:=False;
      A100FMissioniMW.Q050.Delete;
      SessioneOracle.ApplyUpdates([A100FMissioniMW.Q050],True);
      A100FMissioniMW.Q050.ReadOnly:=True;
      A100FMissioniMW.CalcolaTotaleRimborsi;
      Msg:=A100FMissioniMW.RicalcolaDeleteRimborso(bSegnalazionePastoOldValue);
      if Msg <> '' then
        R180MessageBox(Msg, INFORMA);
    end;
  end;
end;

procedure TA100FMISSIONI.frmToolbarFiglioRimbactTFConfermaExecute(Sender: TObject);
var Msg: String;
begin
  inherited;
  with A100FMissioniDtM do
  begin
    SessioneOracle.ApplyUpdates([A100FMissioniMW.Q050],True);
    A100FMissioniMW.Q050.ReadOnly:=True;
    SessioneOracle.ApplyUpdates([A100FMissioniMW.M051],True);
    A100FMissioniMW.M051.ReadOnly:=True;
    A100FMissioniMW.Q050.Refresh;
    //Eseguo l'update sulle missioni per aggiornare le note dei rimborsi...
    (*
    if M040NOTE_RIMBORSI.AsString <> trim(MemNoteRimborsi.Text) then
    begin
      M040.Edit;
      M040NOTE_RIMBORSI.AsString:=trim(MemNoteRimborsi.Text);
      M040.Post;
    end;
    *)
    //MemNoteRimborsi.ReadOnly:=True;
    A100FMissioniMW.CalcolaTotaleRimborsi;
    Msg:=A100FMissioniMW.GestioneMese;
    if Msg <> '' then
      R180MessageBox(Msg, INFORMA);
    A100FMissioniDtM.A100FMissioniMW.FiltraRegoleRimborsi(False);
    frmToolbarFiglioRimb.AbilitaAzioniTF(frmToolbarFiglioRimb.actTFConferma);
  end;
end;

procedure TA100FMISSIONI.frmToolbarFiglioRimbactTFInserisciExecute(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleRimborsi;
  //MemNoteRimborsi.ReadOnly:=False;
  VerificaRimborsoPasto;
  A100FMissioniDtM.A100FMissioniMW.M051.ReadOnly:=False;
  frmToolbarFiglioRimb.actTFInserisciExecute(frmToolbarFiglioRimb.actTFInserisci);
end;

procedure TA100FMISSIONI.frmToolbarFiglioRimbactTFModificaExecute(Sender: TObject);
begin
  inherited;
  A100FMissioniDtM.A100FMissioniMW.FiltraRegoleRimborsi;
  //MemNoteRimborsi.ReadOnly:=False;
  VerificaRimborsoPasto;
  A100FMissioniDtM.A100FMissioniMW.M051.ReadOnly:=False;
  frmToolbarFiglioRimb.actTFModificaExecute(frmToolbarFiglioRimb.actTFModifica);
end;

// gestione toolbar dettaglio giornaliero
procedure TA100FMISSIONI.frmToolbarFiglioDettGGactTFAnnullaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioDettGG.actTFAnnullaExecute(Sender);
end;

procedure TA100FMISSIONI.frmToolbarFiglioDettGGactTFCancellaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioDettGG.actTFCancellaExecute(Sender);
end;

procedure TA100FMISSIONI.frmToolbarFiglioDettGGactTFConfermaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioDettGG.actTFConfermaExecute(Sender);
end;

procedure TA100FMISSIONI.frmToolbarFiglioDettGGactTFInserisciExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioDettGG.actTFInserisciExecute(Sender);
end;

procedure TA100FMISSIONI.frmToolbarFiglioDettGGactTFModificaExecute(Sender: TObject);
begin
  inherited;
  frmToolbarFiglioDettGG.actTFModificaExecute(Sender);
end;

procedure TA100FMISSIONI.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA100FMISSIONI.mnuAggiornaSerAttClick(Sender: TObject);
begin
  inherited;
  with A100FMISSIONIDtM do
  begin
    A100FMissioniMW.AggGiustServiziAttivi;
    if A100FMissioniMW.USR_M050P_CARICA_GIUST_DAITER.GetVariable('AGGIORNA') <> 'E' then
      R180MessageBox('I giustificativi sul cartellino sono stati aggiornati.',informa)
    else
      R180MessageBox('I giustificativi sul cartellino non sono stati aggiornati in quanto bloccati o per anomalia della funzione di aggiornamento.',informa);
  end;
end;

procedure TA100FMISSIONI.mnuNuovoClick(Sender: TObject);
var
  Griglia:TInserisciDLL;
  i:integer;
  sFiltro:string;
begin
  inherited;
  with A100FMISSIONIDtM do
  begin
    if PmnRimborsi.PopupComponent.Name = dgrdRimborsi.Name then
    begin
      try
        if A100FMissioniMW.Q050.RecordCount > 0 then
          OpenA120TipiRimborsi(A100FMissioniMW.Q050.FieldByName('CODICERIMBORSOSPESE').AsString)
        else
          OpenA120TipiRimborsi('');
      finally
        A100FMissioniMW.Q020.Refresh;
      end;
    end
    else if PmnRimborsi.PopupComponent.Name = DbGrdIndennitaKm.Name then
    begin
      try
        if A100FMissioniMW.QM052.RecordCount > 0 then
          OpenA129IndennitaKm(A100FMissioniMW.QM052.FieldByName('CODICE').AsString,A100FMissioniMW.QM052.FieldByName('DECORRENZA').AsDateTime)
        else
          OpenA129IndennitaKm('',0);
      finally
        A100FMissioniMW.QM021.Refresh;
      end;
    end
    else if (PmnRimborsi.PopupComponent.Name = dcmbTipoMissione.Name) then
    begin
      with A100FMISSIONIDtM.SelM011 do
      begin
        sFiltro:='';
        Griglia.NomeTabella:='M011_TIPOMISSIONE';
        Griglia.Titolo:='Tipo trasferta';
        for i:=0 to FieldCount -1 do
        begin
          Griglia.Display[i]:=Fields[i].DisplayLabel;
          Griglia.Size[i]:=Fields[i].DisplayWidth;
        end;
        //Imposto il filtro prima di aprire la tabella
        for i:=0 to High(Parametri.FiltroDizionario) do
        if Parametri.FiltroDizionario[i].Tabella = 'TIPOLOGIA TRASFERTA' then
        begin
          If Parametri.FiltroDizionario[i].Abilitato then
          begin
            if sFiltro<>''then
              sFiltro:=sFiltro + 'OR';
            sFiltro:=sFiltro + '(CODICE=''' + Parametri.FiltroDizionario[i].Codice + ''')';
          end
          else
          begin
            if sFiltro<>''then
              sFiltro:=sFiltro + 'AND';
            sFiltro:=sFiltro + '(CODICE<>''' + Parametri.FiltroDizionario[i].Codice + ''')';
          end
        end;
        Inserisci(Griglia,dcmbTipoMissione.Text,sFiltro);
        A100FMISSIONIDtM.A100FMissioniMW.QM011.Refresh;
      end;
    end;
  end;
end;

// TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
procedure TA100FMISSIONI.actRiapriRichiestaMissioneExecute(Sender: TObject);
var
  BM: TBookmark;
begin
  if A100FMISSIONIDtM.M040.State = dsInactive then
    Exit;

  inherited;

  // conferma operazione
  if R180MessageBox('Confermi la riapertura della richiesta web?',DOMANDA) = mrNo then
    Exit;

  // effettua riapertura richiesta
  A100FMISSIONIDtM.A100FMissioniMW.RiapriRichiestaMissione;

  // aggiorna dataset
  BM:=A100FMISSIONIDtM.M040.GetBookmark;
  try
    A100FMISSIONIDtM.M040.Refresh;
    if A100FMISSIONIDtM.M040.BookmarkValid(BM) then
      A100FMISSIONIDtM.M040.GotoBookmark(BM);
  finally
    A100FMISSIONIDtM.M040.FreeBookmark(BM);
  end;

  R180MessageBox('La richiesta web è stata riaperta.',INFORMA);
end;
// TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine

procedure TA100FMISSIONI.actRicalcolaIndKmExecute(Sender: TObject);
begin
  inherited;
  A100URicalcoloIndTrasp.OpenA100RicalcoloIndTrasp;
end;

procedure TA100FMISSIONI.btnDettaglioPercorsoClick(Sender: TObject);
begin
  A100FMISSIONIDTM.A100FMissioniMW.ApriDatasetPercorso(A100FMISSIONIDTM.M040.FieldByName('ID').AsInteger);
  OpenC020VisualizzaDataSet('Percorso trasferta',A100FMISSIONIDTM.A100FMissioniMW.cdsM141,450,250);
end;

procedure TA100FMISSIONI.actCartellinoInterattivoExecute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA023Timbrature(A100FMISSIONIdtm.M040.FieldByName('PROGRESSIVO').AsInteger,A100FMISSIONIdtm.M040.FieldByName('DATADA').AsDateTime);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A100FMISSIONIDTM.A100FMissioniMW);
end;

procedure TA100FMISSIONI.actCheckRimborsiExecute(Sender: TObject);
var
  A100CheckRimb: TA100FCheckRimborsi;
begin
  inherited;
  A100CheckRimb:=TA100FCheckRimborsi.Create(Self);
  try
    A100CheckRimb.ShowModal;
    // refresh dei dati delle indennità km e dei rimborsi
    if DbGrdIndennitaKm.DataSource.DataSet.Active then
      DbGrdIndennitaKm.DataSource.DataSet.Refresh;
    if dgrdRimborsi.DataSource.DataSet.Active then
      dgrdRimborsi.DataSource.DataSet.Refresh;
  finally
    FreeAndNil(A100CheckRimb);
  end;
end;

procedure TA100FMISSIONI.actElencoRiapertureExecute(Sender: TObject);
begin
  if A100FMISSIONIDtM.M040.State = dsInactive then
    Exit;
  OpenA100ElencoRiaperture(A100FMISSIONIDTM.M040.FieldByName('ID_MISSIONE').AsString);
end;

procedure TA100FMISSIONI.actImportRimborsiAgenziaExecute(Sender: TObject);
var
  lstMatricole: TStringList;
begin
  inherited;
  lstMatricole:=TStringList.Create;
  try
    //registro elenco matricole
    with C700SelAnagrafe do
    begin
      First;
      while not Eof do
      begin
        lstMatricole.Add(FieldByName('MATRICOLA').AsString);
        Next;
      end;
    end;
    OpenAc05ImportRimborsi(lstMatricole);
    actRefreshExecute(nil);
  finally
    lstMatricole.Free;
  end;
end;

procedure TA100FMISSIONI.actImpRimborsiIterExecute(Sender: TObject);
begin
  inherited;
  A100FImpRimborsiIter:=TA100FImpRimborsiIter.Create(nil);
  try
    A100FImpRimborsiIter.ShowModal;
    actRefreshExecute(nil);
  finally
    FreeAndNil(A100FImpRimborsiIter);
  end;
end;

procedure TA100FMISSIONI.actRefreshExecute(Sender: TObject);
begin
  try
    dbgrdIndennitaKm.DataSource.DataSet.DisableControls;
    dgrdRimborsi.DataSource.DataSet.DisableControls;
    dgrdDettGG.DataSource.DataSet.DisableControls;
    inherited;
  finally
    dbgrdIndennitaKm.DataSource.DataSet.EnableControls;
    dgrdRimborsi.DataSource.DataSet.EnableControls;
    dgrdDettGG.DataSource.DataSet.EnableControls;
  end;

  with A100FMissioniDtM do
  begin
    //da qui già ok su cloud
    A100FMissioniMW.AggiornaQueryCombo;

    // COMMESSA
    CmbCommessa.Items.Clear;
    // Carico la combo delle commesse
    While not A100FMissioniMW.QCommessa.Eof do
    begin
      if A100FMissioniMW.QCommessa.FieldByName('DESCRIZIONE').AsString <> '' then
        CmbCommessa.Items.Add (Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',
                  [A100FMissioniMW.QCommessa.FieldByName('CODICE').AsString])
                  + ' - ' + A100FMissioniMW.QCommessa.FieldByName('DESCRIZIONE').AsString)
      else
        CmbCommessa.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',
                  [A100FMissioniMW.QCommessa.FieldByName('CODICE').AsString]));
      A100FMissioniMW.QCommessa.Next;
    end;

    //partenza
    CmbPartenza.Items.Clear;
    While not A100FMissioniMW.QSede.Eof do
    begin
      if A100FMissioniMW.QSede.FieldByName('DESCRIZIONE').AsString <> '' then
        CmbPartenza.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[A100FMissioniMW.QSede.FieldByName('CODICE').AsString])
                               + ' - ' + A100FMissioniMW.QSede.FieldByName('DESCRIZIONE').AsString)
      else
        CmbPartenza.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[A100FMissioniMW.QSede.FieldByName('CODICE').AsString]));
      A100FMissioniMW.QSede.Next;
    end;

    A100FMissioniMW.ImpostaQSourceDestinazione;
    CmbDestinazione.Items.Clear;
    While not A100FMissioniMW.QSource.Eof do
    begin
      CmbDestinazione.Items.Add(A100FMissioniMW.QSource.FieldByName('DESTINAZIONE').AsString);
      A100FMissioniMW.QSource.Next;
    end;

    A100FMissioniMW.AggiornaDati;
  end;
end;

procedure TA100FMISSIONI.PmnRimborsiPopup(Sender: TObject);
begin
  inherited;
  mnuNuovo.Visible:=frmToolbarFiglioIndKM.Enabled and frmToolbarFiglioRimb.Enabled;
end;

procedure TA100FMISSIONI.PmnServiziAttiviPopup(Sender: TObject);
begin
  inherited;
  mnuAggiornaSerAtt.Visible:=frmToolbarFiglioDettGG.Enabled and (DButton.State = dsBrowse);
  if mnuAggiornaSerAtt.Visible then
  begin
    A100FMissioniDtM.A100FMissioniMW.USR_M050P_CARICA_GIUST_DAITER.SetVariable('AGGIORNA', 'N');
    A100FMissioniDtM.A100FMissioniMW.USR_M050P_CARICA_GIUST_DAITER.SetVariable('ID', A100FMissioniDtM.M040.FieldByName('ID_MISSIONE').AsInteger);
    A100FMissioniDtM.A100FMissioniMW.USR_M050P_CARICA_GIUST_DAITER.Execute;
    if (A100FMissioniDtM.A100FMissioniMW.selM043.RecordCount = 0) or
       (A100FMissioniDtM.A100FMissioniMW.USR_M050P_CARICA_GIUST_DAITER.GetVariable('CONTA_PROC') = 0) then
      mnuAggiornaSerAtt.Visible:=False;
  end;
end;

procedure TA100FMISSIONI.dgrdRimborsiEditButtonClick(Sender: TObject);
var Msg: String;
  DettaglioImporti: TCostiDettaglio;
begin
  inherited;
  if dgrdRimborsi.SelectedField = A100FMISSIONIDTM.A100FMissioniMW.Q050CODICERIMBORSOSPESE then
  begin
    C010FSelezioneDaElenco:=TC010FSelezioneDaElenco.Create(nil);
    try
      C010FSelezioneDaElenco.Caption:='Elenco codici rimborsi';
      C010FSelezioneDaElenco.ODS:=A100FMISSIONIDTM.A100FMissioniMW.Q020;
      C010FSelezioneDaElenco.DselDati.DataSet:=C010FSelezioneDaElenco.ODS;
      C010FSelezioneDaElenco.ODS.First;
      C010FSelezioneDaElenco.ODS.SearchRecord('CODICE',A100FMISSIONIDTM.A100FMissioniMW.Q050.FieldByName('CODICERIMBORSOSPESE').AsString,[srFromBeginning]);
      if (C010FSelezioneDaElenco.ShowModal = mrOK) and (A100FMISSIONIDTM.A100FMissioniMW.Q050.State in [dsInsert,dsEdit]) then
        A100FMISSIONIDTM.A100FMissioniMW.Q050.FieldByName('CODICERIMBORSOSPESE').AsString:=A100FMISSIONIDTM.A100FMissioniMW.Q020.FieldByName('CODICE').AsString;
    finally
      FreeAndNil(C010FSelezioneDaElenco);
    end;
  end;
  if (dgrdRimborsi.SelectedField = A100FMISSIONIDTM.A100FMissioniMW.Q050IMPORTORIMBORSOSPESE) or
     (dgrdRimborsi.SelectedField = A100FMISSIONIDTM.A100FMissioniMW.Q050IMPRIMB_VALEST) then
  begin
    Msg:=A100FMISSIONIDTM.A100FMissioniMW.VerificaDettaglioRimborsi;
    if Msg <> '' then
    begin
      R180MessageBox(Msg,ESCLAMA);
      Exit;
    end;
    with A100FMISSIONIDtM do
    begin
      OpenA100DettaglioRimborsi;
      if Not(A100FMissioniMW.M051.Active) then
        exit;
      if (A100FMissioniMW.M051.RecordCount > 0) and Not(A100FMissioniMW.Q050.ReadOnly) then
      begin
        DettaglioImporti:=A100FMissioniMW.CostiDettaglio;

        if DettaglioImporti.nCosto >= 0 then
        begin
          if D050.State = dsBrowse then
          begin
            A100FMissioniMW.Q050.Edit;
            A100FMissioniMW.Q050IMPORTOCOSTORIMBORSO.AsFloat:=DettaglioImporti.nCosto;
            A100FMissioniMW.Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=DettaglioImporti.EstRimborso;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.ReadOnly:=False;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.AsFloat:=DettaglioImporti.nRimborso;
            A100FMissioniMW.Q050.FieldByName('IMPRIMB_VALEST').AsFloat:=DettaglioImporti.EstCosto;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.ReadOnly:=True;
            A100FMissioniMW.Q050.Post;
          end
          else
          begin
            A100FMissioniMW.Q050IMPORTOCOSTORIMBORSO.AsFloat:=DettaglioImporti.nCosto;
            A100FMissioniMW.Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=DettaglioImporti.EstRimborso;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.ReadOnly:=False;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.AsFloat:=DettaglioImporti.nRimborso;
            A100FMissioniMW.Q050.FieldByName('IMPRIMB_VALEST').AsFloat:=DettaglioImporti.EstCosto;
            A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.ReadOnly:=True;
          end;
        end;
      end;
      //su cloud operare su edit
      if A100FMissioniMW.M051.RecordCount <= 0 then
        A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.ReadOnly:=False;
    end;
  end
  else if dgrdRimborsi.SelectedField = A100FMISSIONIDTM.A100FMissioniMW.Q050COD_VALUTA_EST then
  begin
    C010FSelezioneDaElenco:=TC010FSelezioneDaElenco.Create(nil);
    C010FSelezioneDaElenco.Position:=poScreenCenter;
    with A100FMISSIONIDTM do
    begin
      A100FMissioniMW.SelP030.Close;
      A100FMissioniMW.SelP030.SetVariable('DATADA',M040.FieldByName('DATADA').AsDateTime);
      A100FMissioniMW.SelP030.Open;
    end;
    try
      C010FSelezioneDaElenco.dgrdSelezioneDaElenco.DataSource:=A100FMISSIONIDTM.A100FMissioniMW.DSelP030;
      C010FSelezioneDaElenco.Caption:='Elenco Valute';
      C010FSelezioneDaElenco.ODS:=A100FMISSIONIDTM.A100FMissioniMW.SelP030;
      if (C010FSelezioneDaElenco.ShowModal = mrOK) then
        A100FMISSIONIDTM.A100FMissioniMW.Q050.FieldByName('COD_VALUTA_EST').AsString:=
        A100FMISSIONIDTM.A100FMissioniMW.SelP030.FieldByName('COD_VALUTA').AsString;
    finally
      FreeAndNil(C010FSelezioneDaElenco);
    end;
  end;
end;

procedure TA100FMISSIONI.NuovoElemento1Click(Sender: TObject);
var Griglia:TInserisciDLL;
    i:Byte;
begin
  with A100FMISSIONIDtM.A100FMissioniMW.QM011 do
  begin
    Griglia.NomeTabella:='M011_TIPOMISSIONE';
    Griglia.Titolo:='Tipo missione';
    for i:=0 to FieldCount -1 do
    begin
      Griglia.Display[i]:=Fields[i].DisplayLabel;
      Griglia.Size[i]:=Fields[i].DisplayWidth;
    end;
    Inserisci(Griglia,dcmbTipoMissione.Text);
    Refresh;
  end;
end;

procedure TA100FMISSIONI.TGommaClick(Sender: TObject);
begin
  inherited;
  if ActiveControl is TComboBox then
    (ActiveControl as TComboBox).Text:='';
end;

procedure TA100FMISSIONI.TInserClick(Sender: TObject);
begin
  inherited;
  dEdtDataDa.SetFocus;
end;

procedure TA100FMISSIONI.dCmbTipoMissioneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TA100FMISSIONI.dedtDataAExit(Sender: TObject);
begin
  inherited;
  A100FMISSIONIDtM.A100FMissioniMW.CambioDate;
end;

procedure TA100FMISSIONI.dedtDataDaExit(Sender: TObject);
begin
  {if Dbutton.State in [dsInsert, dsEdit] then
  begin
    with A100FMISSIONIDtM.M040 do
      If (FieldByName('DATADA').AsString <> '') and (FieldByName('DATAA').AsString = '') then
        FieldByName('DATAA').AsDateTime:=FieldByName('DATADA').AsDateTime;
    with A100FMISSIONIDtM do
    begin
      QM011.Close;
      QM011.SetVariable('PROGRESSIVO',C700Progressivo);
      QM011.SetVariable('C8_MISSIONI',Parametri.CampiRiferimento.C8_Missione);
      selM065.Close;
      selM065.SetVariable('PROGRESSIVO',C700Progressivo);
      selM065.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
      selM066.Close;
      selM066.SetVariable('DATOLIB',Parametri.CampiRiferimento.C8_Missione);
      selM066.SetVariable('PROGRESSIVO',C700Progressivo);
      selM066.SetVariable('COD_TARIFF',M040.FieldByName('COD_TARIFFA').AsString);
      if M040.FieldByName('DATADA').IsNull then
      begin
        QM011.SetVariable('DATA',Parametri.DataLavoro);
        selM065.SetVariable('DATA',Parametri.DataLavoro);
      end
      else
      begin
        QM011.SetVariable('DATA',M040.FieldByName('DATADA').AsDateTime);
        selM065.SetVariable('DATA',M040.FieldByName('DATADA').AsDateTime);
      end;
      QM011.Open;
      selM065.Open;
      selM066.Open;
    end;
  end;}
end;

procedure TA100FMISSIONI.DbGrdIndennitaKmEditButtonClick(Sender: TObject);
begin
  inherited;
  if A100FMISSIONIDtM.A100FMissioniMW.D052.State = dsBrowse then
    exit;
  OpenA100DistanzeChilometriche;
end;

procedure TA100FMISSIONI.DCmbStatoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Stato[Index]);
end;

procedure TA100FMISSIONI.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.PROGRESSIVO, T1.MESESCARICO, T1.MESECOMPETENZA, T1.DATADA, T1.ORADA, T1.TIPOREGISTRAZIONE, ');
  QueryStampa.Add('T1.PROTOCOLLO, T1.DATAA, T1.ORAA, T1.TOTALEGG, T1.DURATA, T1.TARIFFAINDINTERA, T1.OREINDINTERA, ');
  QueryStampa.Add('T1.IMPORTOINDINTERA, T1.TARIFFAINDRIDOTTAH, T1.OREINDRIDOTTAH, T1.IMPORTOINDRIDOTTAG, ');
  QueryStampa.Add('T1.TARIFFAINDRIDOTTAHG, T1.OREINDRIDOTTAG, T1.IMPORTOINDRIDOTTAHG, T1.TARIFFAINDRIDOTTAHG, ');
  QueryStampa.Add('T1.OREINDRIDOTTAHG, T1.IMPORTOINDRIDOTTAHG, T1.FLAG_MODIFICATO, T1.PARTENZA, T1.DESTINAZIONE, ');
  QueryStampa.Add('T1.NOTE_RIMBORSI, T2.DESCRIZIONE, T1.COMMESSA, T1.STATO ');
  QueryStampa.Add('FROM M040_MISSIONI T1, M011_TIPOMISSIONE T2');
  QueryStampa.Add('WHERE T1.TIPOREGISTRAZIONE=T2.CODICE');
  NomiCampiR001.Add('T1.PROGRESSIVO');
  NomiCampiR001.Add('T1.MESESCARICO');
  NomiCampiR001.Add('T1.MESECOMPETENZA');
  NomiCampiR001.Add('T1.DATADA');
  NomiCampiR001.Add('T1.ORADA');
  NomiCampiR001.Add('T1.TIPOREGISTRAZIONE');
  NomiCampiR001.Add('T1.PROTOCOLLO');
  NomiCampiR001.Add('T1.DATAA');
  NomiCampiR001.Add('T1.ORAA');
  NomiCampiR001.Add('T1.TOTALEGG');
  NomiCampiR001.Add('T1.DURATA');
  NomiCampiR001.Add('T1.TARIFFAINDINTERA');
  NomiCampiR001.Add('T1.OREINDINTERA');
  NomiCampiR001.Add('T1.IMPORTOINDINTERA');
  NomiCampiR001.Add('T1.TARIFFAINDRIDOTTAH');
  NomiCampiR001.Add('T1.OREINDRIDOTTAH');
  NomiCampiR001.Add('T1.IMPORTOINDRIDOTTAG');
  NomiCampiR001.Add('T1.TARIFFAINDRIDOTTAHG');
  NomiCampiR001.Add('T1.OREINDRIDOTTAG');
  NomiCampiR001.Add('T1.IMPORTOINDRIDOTTAHG');
  NomiCampiR001.Add('T1.TARIFFAINDRIDOTTAHG');
  NomiCampiR001.Add('T1.OREINDRIDOTTAHG');
  NomiCampiR001.Add('T1.IMPORTOINDRIDOTTAHG');
  NomiCampiR001.Add('T1.FLAG_MODIFICATO');
  NomiCampiR001.Add('T1.PARTENZA');
  NomiCampiR001.Add('T1.DESTINAZIONE');
  NomiCampiR001.Add('T1.NOTE_RIMBORSI');
  NomiCampiR001.Add('T2.DESCRIZIONE');
  NomiCampiR001.Add('T1.COMMESSA');
  NomiCampiR001.Add('T1.STATO');
  inherited;
end;

procedure TA100FMISSIONI.ToolButton9Click(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA131GestioneAnticipi(C700Progressivo,A100FMissioniDtm.M040.FieldByName('ID_MISSIONE').AsInteger);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A100FMISSIONIDTM.A100FMissioniMW);
  if A100FMissioniDtm.A100FMissioniMW.Q050.Active then
    A100FMissioniDtm.A100FMissioniMW.Q050.Refresh;
end;

procedure TA100FMISSIONI.DCmbLookpCodTariffKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TA100FMISSIONI.DCmbLookUpCodRiduzioneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TA100FMISSIONI.dCmbTipoMissioneCloseUp(Sender: TObject);
begin
  inherited;
//====================================================
//REFRESH SULLA VISUALIZZAZIONE DEL TIPO DELLA TARIFFA
//====================================================
  with A100FMISSIONIDTM do
  begin
    if Not(M040DATAA.IsNull) and (M040TIPOREGISTRAZIONE.AsString <> '') then
      A100FMissioniMW.LeggiParametri(m040DATAA.asDatetime,m040TIPOREGISTRAZIONE.AsString);
    with A100FMISSIONI do
      if A100FMissioniMW.Q010.Active then
      begin
        if A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
        begin
          lblCodiceTariffa.Enabled:=True;
          lblCodiceRiduzione.Enabled:=True;
          DCmbLookpCodTariff.Enabled:=True;
          DCmbLookUpCodRiduzione.Enabled:=True;
        end
        else
        begin
          lblCodiceTariffa.Enabled:=False;
          lblCodiceRiduzione.Enabled:=False;
          DCmbLookpCodTariff.Enabled:=False;
          DCmbLookUpCodRiduzione.Enabled:=False;
          M040.FieldByName('COD_TARIFFA').Clear;
          M040.FieldByName('COD_RIDUZIONE').Clear;
        end;
      end;
  end;
end;

procedure TA100FMISSIONI.NuovoElemento2Click(Sender: TObject);
begin
  inherited;
  OpenA133TariffeMissioni(C700Progressivo);
  A100FMISSIONIDTM.A100FMissioniMW.selM065.Refresh;
end;

procedure TA100FMISSIONI.dedtOraDaChange(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
    if (Trim(TDbEdit(Sender).Text) = '.') or (Trim(TDbEdit(Sender).Text) = ':') then
      TDbEdit(Sender).Field.Clear;
end;

procedure TA100FMISSIONI.ToolButton7Click(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TA100FMISSIONI.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.

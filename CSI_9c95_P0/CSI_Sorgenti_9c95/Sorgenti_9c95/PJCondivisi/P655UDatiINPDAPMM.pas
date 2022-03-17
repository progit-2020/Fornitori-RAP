unit P655UDatiINPDAPMM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Menus, Buttons, Math, StrUtils,
  ExtCtrls, ComCtrls, StdCtrls, DBCtrls,  Mask, ImgList, ToolWin, ActnList,
  C180FUNZIONIGENERALI, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi,
  C005UDatiAnagrafici, Grids, DBGrids, OracleData, Db, SelAnagrafe, Variants,
  ToolbarFiglio, System.Actions;

type
  TP655FDatiINPDAPMM = class(TR001FGestTab)
    pnlTestata: TPanel;
    dchkChiuso: TDBCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    lblDataChiusura: TLabel;
    dedtDataChiusura: TDBEdit;
    sbtDataChiusura: TSpeedButton;
    lblIdINPDAPMM: TLabel;
    dedtIdINPDAPMM: TDBEdit;
    pnlDettaglio: TPanel;
    dgrdDatiINPDAPMM: TDBGrid;
    pnlIntestazioneGriglia: TPanel;
    pnlVisualizzazioneVoci: TPanel;
    rgpTipoRecord: TRadioGroup;
    btnFiltroNumeri: TBitBtn;
    btnFiltroParte: TBitBtn;
    lblDataFinePeriodo: TLabel;
    dedtdataFinePeriodo: TDBEdit;
    sbtDataFinePeriodo: TSpeedButton;
    rgpTipoDati: TRadioGroup;
    frmToolbarFiglio: TfrmToolbarFiglio;
    btnFiltroProgr: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure dgrdDatiINPDAPMMEditButtonClick(Sender: TObject);
    procedure dgrdDatiINPDAPMMColEnter(Sender: TObject);
    procedure btnFiltroNumeriClick(Sender: TObject);
    procedure rgpTipoRecordClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtDataChiusuraClick(Sender: TObject);
    procedure btnFiltroParteClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TCancClick(Sender: TObject);
    procedure sbtDataFinePeriodoClick(Sender: TObject);
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure frmToolbarFiglioactTFCopiaSuExecute(Sender: TObject);
    procedure btnFiltroProgrClick(Sender: TObject);
  private
    procedure CambiaProgressivo;
  public
    //Data fine anno del CUD
    sPb_NomeFlusso:String;
    procedure AbilitazioniComponenti;
  end;

var
  P655FDatiINPDAPMM: TP655FDatiINPDAPMM;

procedure OpenP655FDatiINPDAPMM(Prog:LongInt; sNomeFlusso:string);

implementation

uses P655UDatiINPDAPMMDtM, P655UElencoDatiINPDAPMM, P652UElencoFiltroDatiINPDAPMM, A003UDataLavoroBis;

{$R *.DFM}

procedure OpenP655FDatiINPDAPMM(Prog:LongInt; sNomeFlusso:string);
var
  sInibizioni:string;
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if sNomeFlusso = FLUSSO_INPDAP then
    sInibizioni:='OpenP655FDatiINPDAPMM'
  else if sNomeFlusso = FLUSSO_FLUPER then
    sInibizioni:='OpenP655FDatiFLUPER'
  else if sNomeFlusso = FLUSSO_CREDITI then
    sInibizioni:='OpenP655FDatiFlussoCrediti'
  else
    sInibizioni:='';
  case A000GetInibizioni('Funzione',sInibizioni) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP655FDatiINPDAPMM, P655FDatiINPDAPMM);
  C700Progressivo:=Prog;
  P655FDatiINPDAPMM.sPb_NomeFlusso:=sNomeFlusso;
  Application.CreateForm(TP655FDatiINPDAPMMDtM, P655FDatiINPDAPMMDtM);
  try
    Screen.Cursor:=crDefault;
    P655FDatiINPDAPMM.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P655FDatiINPDAPMM.Free;
    P655FDatiINPDAPMMDtM.Free;
  end;
end;

procedure TP655FDatiINPDAPMM.FormActivate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=P655FDatiINPDAPMMDtM.P662;
  //actInserisci.Enabled:=False;
  //actModifica.Enabled:=False;
  //actStoricizza.Enabled:=False;
  dgrdDatiINPDAPMM.Options:=[dgRowSelect,dgColumnResize,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  dgrdDatiINPDAPMM.SetFocus;
  rgpTipoDati.ItemIndex:=0;
  if sPb_NomeFlusso=FLUSSO_INPDAP then
  begin
    P655FDatiINPDAPMM.Caption:='<P655> Fornitura INPDAP - DMA';
    pnlIntestazioneGriglia.Caption:='Dettaglio dati della fornitura INPDAP - DMA';
    P655FDatiINPDAPMM.HelpContext:=3655000;
    rgpTipoDati.Visible:=True;
  end
  else if sPb_NomeFlusso=FLUSSO_FLUPER then
  begin
    P655FDatiINPDAPMM.Caption:='<P655> Fornitura FLUPER';
    pnlIntestazioneGriglia.Caption:='Dettaglio dati della fornitura FLUPER';
    P655FDatiINPDAPMM.HelpContext:=3655100;
    rgpTipoDati.Visible:=False;
  end
  else if sPb_NomeFlusso=FLUSSO_CREDITI then
  begin
    P655FDatiINPDAPMM.Caption:='<P655> Fornitura flusso crediti';
    pnlIntestazioneGriglia.Caption:='Dettaglio dati della fornitura CREDITI';
    P655FDatiINPDAPMM.HelpContext:=3655200;
    rgpTipoDati.Visible:=False;
  end
  else
    raise exception.Create('Flusso ''' + sPb_NomeFlusso + ''' non riconosciuto.');
end;

procedure TP655FDatiINPDAPMM.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP655FDatiINPDAPMM.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT');
  QueryStampa.Add('T1.progressivo,');
  QueryStampa.Add('T1.parte,');
  QueryStampa.Add('T1.numero,');
  QueryStampa.Add('T1.progressivo_numero,');
  QueryStampa.Add('T1.tipo_record,');
  QueryStampa.Add('T1.valore,');
  QueryStampa.Add('T2.nome_flusso,');
  QueryStampa.Add('T2.data_fine_periodo,');
  QueryStampa.Add('T2.id_flusso,');
  QueryStampa.Add('T2.chiuso,');
  QueryStampa.Add('T2.data_chiusura');
  QueryStampa.Add('FROM p662_flussitestate T2, P663_FLUSSIDATIINDIVIDUALI T1');
  QueryStampa.Add('WHERE T2.NOME_FLUSSO=''DMA''');
  QueryStampa.Add('  AND T1.ID_FLUSSO=T2.ID_FLUSSO');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.progressivo');
  NomiCampiR001.Add('T1.parte');
  NomiCampiR001.Add('T1.numero');
  NomiCampiR001.Add('T1.progressivo_numero');
  NomiCampiR001.Add('T1.tipo_record');
  NomiCampiR001.Add('T1.valore');
  NomiCampiR001.Add('T2.nome_flusso');
  NomiCampiR001.Add('T2.data_fine_periodo');
  NomiCampiR001.Add('T2.id_flusso');
  NomiCampiR001.Add('T2.chiuso');
  NomiCampiR001.Add('T2.data_chiusura');
  inherited;
  P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.SelAnagrafe:=C700SelAnagrafe;
end;

procedure TP655FDatiINPDAPMM.FormCreate(Sender: TObject);
begin
  inherited;
  //solo per test in sviluppo
  //sPb_NomeFlusso:=IfThen(sPb_NomeFlusso <> '',sPb_NomeFlusso,FLUSSO_FLUPER);
end;

procedure TP655FDatiINPDAPMM.FormClose(Sender: TObject;
  var Action: TCloseAction);
{Prima di chiudere controllo che non ci siano modifiche pendenti}
begin
  if not Panel1.Enabled then
    Action:=caNone
  else
  begin
    DButton.DataSet:=nil;
    inherited;
  end;
end;

procedure TP655FDatiINPDAPMM.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ReimpostaDatasetCollegati(sPb_NomeFlusso);
end;

procedure TP655FDatiINPDAPMM.DButtonStateChange(
  Sender: TObject);
begin
  inherited;
  AbilitazioniComponenti;
end;

procedure TP655FDatiINPDAPMM.dgrdDatiINPDAPMMEditButtonClick(
  Sender: TObject);
begin
  with P655FDatiINPDAPMMDtM do
  begin
    if P655FDatiINPDAPMMMW.P663.ReadOnly = True then
      exit;
    if P655FDatiINPDAPMMMW.P663.State = dsBrowse then
      P655FDatiINPDAPMMMW.P663.Edit;
    P655FDatiINPDAPMMMW.P663.UpdateRecord;
    case dgrdDatiINPDAPMM.SelectedIndex of
      0: //Numero dato da elenco
      begin
        P655FElencoDatiINPDAPMM:=TP655FElencoDatiINPDAPMM.Create(nil);
        P655FDatiINPDAPMMMW.selP660.SearchRecord('PARTE;NUMERO',VarArrayOf([P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString,P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString]),[srFromBeginning]);
        P655FElencoDatiINPDAPMM.dgrdElencoCampi.DataSource:=DselP660;
        if P655FElencoDatiINPDAPMM.ShowModal = mrOK then
        begin
          if P655FDatiINPDAPMMMW.P663.State = dsInsert then
          begin
            P655FDatiINPDAPMMMW.P663.OnCalcFields:=nil;
            P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString:=P655FDatiINPDAPMMMW.selP660.FieldByName('PARTE').AsString;
            P655FDatiINPDAPMMMW.P663.OnCalcFields:=P655FDatiINPDAPMMMW.P663CalcFields;
            P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString:=P655FDatiINPDAPMMMW.selP660.FieldByName('NUMERO').AsString;
          end;
        end;
        P655FElencoDatiINPDAPMM.Free;
      end;
    end;
  end;
end;

procedure TP655FDatiINPDAPMM.dgrdDatiINPDAPMMColEnter(
  Sender: TObject);
begin
  if frmToolbarFiglio.actTFAnnulla.Enabled = False then
    exit;
end;

procedure TP655FDatiINPDAPMM.sbtDataFinePeriodoClick(Sender: TObject);
begin
  with P655FDatiINPDAPMMDtM do
  begin
    if P662.FieldByName('DATA_FINE_PERIODO').IsNull then
      P662.FieldByName('DATA_FINE_PERIODO').AsDateTime:=Parametri.DataLavoro;
    P662.FieldByName('DATA_FINE_PERIODO').AsDateTime:=DataOut(P662.FieldByName('DATA_FINE_PERIODO').AsDateTime,'Data fine elaborazione INPDAP','G');
  end;
end;

procedure TP655FDatiINPDAPMM.sbtDataChiusuraClick(Sender: TObject);
begin
  with P655FDatiINPDAPMMDtM do
  begin
    if P662.FieldByName('DATA_CHIUSURA').IsNull then
      P662.FieldByName('DATA_CHIUSURA').AsDateTime:=Parametri.DataLavoro;
    P662.FieldByName('DATA_CHIUSURA').AsDateTime:=DataOut(P662.FieldByName('DATA_CHIUSURA').AsDateTime,'Data chiusura INPDAP','G');
  end;
end;

procedure TP655FDatiINPDAPMM.btnFiltroParteClick(Sender: TObject);
var
  j: integer;
  elencoValoriCheckList: TElencoValoriChecklist;
  //Data fine periodo
begin
  try
    elencoValoriCheckList:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ElencoPartiChecklist(sPb_NomeFlusso);
    P652FElencoFiltroDatiINPDAPMM:=TP652FElencoFiltroDatiINPDAPMM.Create(nil);
    P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Assign(elencoValoriCheckList.lstDescrizione);
    P652FElencoFiltroDatiINPDAPMM.Caption:='<P655> Filtro Parte';
    for j:=0 to P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Count - 1 do
      if Pos(',' + Trim(Copy(P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items[j],1,5)) + ',',',' + P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.PartiSelezionate + ',') > 0 then
        P652FElencoFiltroDatiINPDAPMM.clbListaDati.Checked[j]:=True;
    if P652FElencoFiltroDatiINPDAPMM.ShowModal = mrOK then
    begin
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.DatiSelezionati:='';
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.PartiSelezionate:=R180GetCheckList(5,P652FElencoFiltroDatiINPDAPMM.clbListaDati);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ModificaQuery(spb_NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
    end;
  finally
    FreeAndNil(elencoValoriCheckList);
    P652FElencoFiltroDatiINPDAPMM.Free;
  end;
end;

procedure TP655FDatiINPDAPMM.btnFiltroNumeriClick(Sender: TObject);
var
  j: integer;
  ElencoNumeriChecklist: TElencoValoriCheckList;
begin
  try
    ElencoNumeriChecklist:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ElencoNumeriChecklist(spb_NomeFlusso);
    P652FElencoFiltroDatiINPDAPMM:=TP652FElencoFiltroDatiINPDAPMM.Create(nil);
    P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Assign(ElencoNumeriChecklist.LstDescrizione);
    P652FElencoFiltroDatiINPDAPMM.Caption:='<P655> Filtro Numeri';
    for j:=0 to P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Count - 1 do
      if Pos(',' + Trim(Copy(P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items[j],1,10)) + ',',',' + P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.DatiSelezionati + ',') > 0 then
        P652FElencoFiltroDatiINPDAPMM.clbListaDati.Checked[j]:=True;
    if P652FElencoFiltroDatiINPDAPMM.ShowModal = mrOK then
    begin
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.PartiSelezionate:='';
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.DatiSelezionati:=R180GetCheckList(10,P652FElencoFiltroDatiINPDAPMM.clbListaDati);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ModificaQuery(spb_NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
    end;
  finally
    FreeAndNil(ElencoNumeriChecklist);
    P652FElencoFiltroDatiINPDAPMM.Free;
  end;
end;

procedure TP655FDatiINPDAPMM.btnFiltroProgrClick(Sender: TObject);
var
  sProgr: String;
  j: integer;
  ElencoValoriCheckList: TElencoValoriChecklist;
begin
  try
    ElencoValoriCheckList:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ElencoProgrChecklist(rgpTipoDati.ItemIndex);
    P652FElencoFiltroDatiINPDAPMM:=TP652FElencoFiltroDatiINPDAPMM.Create(nil);
    P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Assign(ElencoValoriCheckList.lstDescrizione);
    P652FElencoFiltroDatiINPDAPMM.Caption:='<P655> Filtro Progressivi';
    for j:=0 to P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items.Count - 1 do
      if Pos(',' + Trim(Copy(P652FElencoFiltroDatiINPDAPMM.clbListaDati.Items[j],1,5)) + ',',',' + P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ProgrSelezionati + ',') > 0 then
        P652FElencoFiltroDatiINPDAPMM.clbListaDati.Checked[j]:=True;
    if P652FElencoFiltroDatiINPDAPMM.ShowModal = mrOK then
    begin
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ProgrSelezionati:=R180GetCheckList(5,P652FElencoFiltroDatiINPDAPMM.clbListaDati);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.ModificaQuery(spb_NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
    end;
  finally
    FreeAndNil(ElencoValoriCheckList);
    P652FElencoFiltroDatiINPDAPMM.Free;
  end;
end;

procedure TP655FDatiINPDAPMM.rgpTipoRecordClick(Sender: TObject);
begin
  P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.LeggoDettaglioINPDAPMM(sPb_NomeFlusso,rgpTipoDati.ItemIndex,rgpTipoRecord.ItemIndex);
  AbilitazioniComponenti;
end;

procedure TP655FDatiINPDAPMM.AbilitazioniComponenti;
//Gestisco le abilitazioni e disabilitazioni di tutti i componenti della form nelle varie circostanza
begin
  with P655FDatiINPDAPMMDtM.P662 do
  begin
    if (RecordCount = 0) or (DButton.State in [dsInsert,dsEdit]) or (rgpTipoRecord.ItemIndex <> 0) or SolaLettura or (FieldByName('CHIUSO').AsString = 'S') or ((rgpTipoDati.ItemIndex = 0) and (C700Progressivo = 0)) then
    begin
      frmToolbarFiglio.actTFCopiaSu.Enabled:=False;
      frmToolbarFiglio.actTFInserisci.Enabled:=False;
      frmToolbarFiglio.actTFModifica.Enabled:=False;
      frmToolbarFiglio.actTFCancella.Enabled:=False;
    end
    else
    begin
      frmToolbarFiglio.actTFCopiaSu.Enabled:=True;
      frmToolbarFiglio.actTFInserisci.Enabled:=True;
      frmToolbarFiglio.actTFModifica.Enabled:=True;
      frmToolbarFiglio.actTFCancella.Enabled:=True;
    end;
  end;
  frmSelAnagrafe.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TP655FDatiINPDAPMM.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  inherited;
  try
    C005DataVisualizzazione:=P655FDatiINPDAPMMDtM.P662.FieldByName('DATA_FINE_PERIODO').AsDateTime;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TP655FDatiINPDAPMM.frmToolbarFiglioactTFCopiaSuExecute(
  Sender: TObject);
var
  ParteOrig,NumeroOrig,ProgressivoOrig,ValoreOrig: String;
begin
  with P655FDatiINPDAPMMDtM do
  begin
    if P655FDatiINPDAPMMMW.D663.DataSet = nil then exit;
    if P655FDatiINPDAPMMMW.D663.State <> dsBrowse then exit;
    if P655FDatiINPDAPMMMW.D663.DataSet.RecordCount < 1 then exit;
    ParteOrig:=P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString;
    NumeroOrig:=P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString;
    ProgressivoOrig:=P655FDatiINPDAPMMMW.P663.FieldByName('PROGRESSIVO_NUMERO').AsString;
    ValoreOrig:=P655FDatiINPDAPMMMW.P663.FieldByName('VALORE').AsString;
    frmToolbarFiglio.actTFInserisciExecute(frmToolbarFiglio.actTFInserisci);
    P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString:=ParteOrig;
    P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString:=NumeroOrig;
    P655FDatiINPDAPMMMW.P663.FieldByName('PROGRESSIVO_NUMERO').AsString:=ProgressivoOrig;
    P655FDatiINPDAPMMMW.P663.FieldByName('VALORE').AsString:=ValoreOrig;
  end;
end;

procedure TP655FDatiINPDAPMM.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  inherited;
  try
    C005DataVisualizzazione:=P655FDatiINPDAPMMDtM.P662.FieldByName('DATA_FINE_PERIODO').AsDateTime;
  except
    C700Datalavoro:=Parametri.DataLavoro;
  end;
  if C700Datalavoro = 0 then
    C700Datalavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP655FDatiINPDAPMM.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.D663;
  frmToolbarFiglio.TFDBGrid:=dgrdDatiINPDAPMM;
  SetLength(frmToolbarFiglio.lstLock,6);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[4]:=pnlVisualizzazioneVoci;
  frmToolbarFiglio.lstLock[5]:=pnlTestata;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW, SessioneOracle, StatusBar,2,True);
  A000SettaVariabiliAmbiente;
  P655FDatiINPDAPMM.WindowState:=wsMaximized;
  dgrdDatiINPDAPMM.DataSource:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.D663;
end;

procedure TP655FDatiINPDAPMM.CambiaProgressivo;
begin
  rgpTipoDatiClick(nil);
end;

procedure TP655FDatiINPDAPMM.TCancClick(Sender: TObject);
var
  NumDip,Msg,sInputConf:String;
begin
  Msg:=P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW.MessaggioCancellazione(NumDip);
  if (R180MessageBox(msg,DOMANDA) = mrNo) then
    exit;
  sInputConf:= InputBox('Cancellazione di ' + NumDip + ' dip.' ,'Inserire il numero di dipendenti che verranno cancellati:', '0');
  if (sInputConf = '0') or (sInputConf <> NumDip) then
  begin
    R180MessageBox('Operazione annullata.',INFORMA);
    exit;
  end;
  inherited;
end;

procedure TP655FDatiINPDAPMM.rgpTipoDatiClick(Sender: TObject);
begin
  with P655FDatiINPDAPMMDtM.P655FDatiINPDAPMMMW do
  begin
    FiltraP660(rgpTipoDati.ItemIndex);
    LeggoDettaglioINPDAPMM(sPb_NomeFlusso,rgpTipoDati.ItemIndex,rgpTipoRecord.ItemIndex);
  end;
  AbilitazioniComponenti;
end;

end.


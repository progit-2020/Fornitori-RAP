unit A172USchedeQuantIndividuali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids, DBGrids,
  ToolbarFiglio, StdCtrls, DBCtrls, Buttons, C600USelAnagrafe, Mask, ExtCtrls,
  A000UInterfaccia, A000UCostanti, A000USessione, A003UDataLavoroBis, C180FunzioniGenerali,
  A083UMsgElaborazioni, C013UCheckList, C005UDatiAnagrafici, Clipbrd, Oracle, OracleData,
  System.Actions, A172USchedeQuantIndividualiMW, Generics.Collections, A000UMessaggi;

type
  TA172FSchedeQuantIndividuali = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dtxtDescrizione: TDBText;
    lblTotOreAccett: TLabel;
    lblTotAccett: TLabel;
    lblTotAssegn: TLabel;
    lblTotOreAssegn: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtFiltroAnagrafe: TDBEdit;
    dcmbTipoQuota: TDBLookupComboBox;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    edtTotOreAccett: TEdit;
    edtTotAccett: TEdit;
    edtMaxImp: TEdit;
    edtMaxOre: TEdit;
    btnAnno: TBitBtn;
    dedtDataRif: TDBEdit;
    btnDataRif: TBitBtn;
    dedtAnno: TDBEdit;
    ProgressBar1: TProgressBar;
    dgrdSchedeInd: TDBGrid;
    PopupMenu1: TPopupMenu;
    mnuDatiAnagrafici: TMenuItem;
    N4: TMenuItem;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    GroupBox1: TGroupBox;
    dedtTolleranza: TDBEdit;
    Label7: TLabel;
    grdPagamenti: TStringGrid;
    Splitter1: TSplitter;
    frmToolbarFiglio: TfrmToolbarFiglio;
    btnAnomalie: TBitBtn;
    lblStato: TLabel;
    dchkSupervisione: TDBCheckBox;
    dcmbSupervisore: TDBLookupComboBox;
    edtNumOreTotale: TEdit;
    edtImpTotale: TEdit;
    mnuObiettivi: TMenuItem;
    btnObiettivi: TBitBtn;
    procedure btnAnnoClick(Sender: TObject);
    procedure btnDataRifClick(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dcmbTipoQuotaCloseUp(Sender: TObject);
    procedure dcmbTipoQuotaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbTipoQuotaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dedtAnnoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dgrdSchedeIndEditButtonClick(Sender: TObject);
    procedure grdPagamentiGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
    procedure mnuDatiAnagraficiClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure dchkSupervisioneClick(Sender: TObject);
    procedure frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFModificaExecute(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure mnuObiettiviClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    { Public declarations }
    function AggiornaTotali:TTOtali;
    procedure Abilitazioni;
  end;

var
  A172FSchedeQuantIndividuali: TA172FSchedeQuantIndividuali;

  procedure OpenA172SchedeQuantIndividuali;

implementation

uses A172USchedeQuantIndividualiDtM, A172USchedeQuantObiettivi;

{$R *.dfm}

procedure OpenA172SchedeQuantIndividuali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA172SchedeQuantIndividuali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA172FSchedeQuantIndividuali, A172FSchedeQuantIndividuali);
  Application.CreateForm(TA172FSchedeQuantIndividualiDtM, A172FSchedeQuantIndividualiDtM);
  try
    Screen.Cursor:=crDefault;
    A172FSchedeQuantIndividuali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A172FSchedeQuantIndividuali.Free;
    A172FSchedeQuantIndividualiDtM.Free;
  end;
end;

procedure TA172FSchedeQuantIndividuali.btnAnnoClick(Sender: TObject);
begin
  inherited;
  DButton.DataSet.FieldByName('ANNO').AsInteger:=StrToIntDef(Copy(DateToStr(DataOut(StrToDate('01/01/' + DButton.DataSet.FieldByName('ANNO').AsString),'Anno elaborazione','A')),7,4),0);
end;

procedure TA172FSchedeQuantIndividuali.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A172','');
end;

procedure TA172FSchedeQuantIndividuali.btnDataRifClick(Sender: TObject);
begin
  inherited;
  DButton.DataSet.FieldByName('DATARIF').AsDateTime:=DataOut(DButton.DataSet.FieldByName('DATARIF').AsDateTime,'Data di riferimento','D');
end;

procedure TA172FSchedeQuantIndividuali.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
  C600frmSelAnagrafe.C600DataLavoro:=A172FSchedeQuantIndividualiDtM.selT767.FieldByName('DATARIF').AsDateTime;
//  inherited;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A172FSchedeQuantIndividualiDtM.selT767.FieldByName('FILTRO_ANAGRAFE').AsString:=S;
  end;
end;

procedure TA172FSchedeQuantIndividuali.Copia2Click(Sender: TObject);
var S:String;
    i:Integer;
begin
  with dgrdSchedeInd.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdSchedeInd.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TA172FSchedeQuantIndividuali.mnuDatiAnagraficiClick(Sender: TObject);
begin
  inherited;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  try
    C005FDatiAnagrafici.ShowDipendente(A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('PROGRESSIVO').AsInteger);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA172FSchedeQuantIndividuali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnAnno.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataRif.Enabled:=DButton.State in [dsEdit,dsInsert];
  grdPagamenti.Enabled:=DButton.State in [dsEdit,dsInsert];
  C600frmSelAnagrafe.Enabled:=DButton.State in [dsEdit,dsInsert];
  frmToolbarFiglio.Enabled:=DButton.State = dsBrowse;
end;

procedure TA172FSchedeQuantIndividuali.dchkSupervisioneClick(Sender: TObject);
begin
  inherited;
  dcmbSupervisore.Enabled:=dchkSupervisione.Checked;
  if (not dchkSupervisione.Checked) and (DButton.State in [dsEdit,dsInsert]) then
    DButton.Dataset.FieldByName('PROG_SUPERVISORE').AsInteger:=0;
end;

procedure TA172FSchedeQuantIndividuali.dcmbTipoQuotaCloseUp(Sender: TObject);
begin
  inherited;
  dtxtDescrizione.Visible:=Trim(dcmbTipoQuota.Text) <> '';
end;

procedure TA172FSchedeQuantIndividuali.dcmbTipoQuotaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TA172FSchedeQuantIndividuali.dcmbTipoQuotaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoQuotaCloseUp(nil);
end;

procedure TA172FSchedeQuantIndividuali.dedtAnnoExit(Sender: TObject);
begin
  inherited;
  if (DButton.State in [dsEdit,dsInsert]) and (DButton.DataSet.FieldByName('ANNO').asString <> '') and
     (DButton.DataSet.FieldByName('DATARIF').IsNull) then
    DButton.DataSet.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + DButton.DataSet.FieldByName('ANNO').asString);
end;

procedure TA172FSchedeQuantIndividuali.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdSchedeInd,'N');
end;

procedure TA172FSchedeQuantIndividuali.dgrdSchedeIndEditButtonClick(Sender: TObject);
var
  elencoFlessibilita: TElencoValoriChecklist;
begin
  inherited;
  if A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('PARTTIME').AsFloat = 100 then
    Exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    elencoFlessibilita:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.getLstFlessibilita;
    C013FCheckList.clbListaDati.Items.Assign(elencoFlessibilita.lstDescrizione);
    FreeAndNil(elencoFlessibilita);

    R180PutCheckList(A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('FLESSIBILITA').AsString,1,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.Edit;
      A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('FLESSIBILITA').AsString:=R180GetCheckList(1,C013FCheckList.clbListaDati);
    end;
  finally
    Release;
  end;
end;

procedure TA172FSchedeQuantIndividuali.FormDestroy(Sender: TObject);
begin
  //16/01/2015 senza distruzione memory leak. NON ha mai funzionato...
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA172FSchedeQuantIndividuali.FormShow(Sender: TObject);
begin
  dgrdSchedeInd.DataSource:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.dsrT768;
  dcmbSupervisore.ListSource:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.dsrValutatori;
  frmToolbarFiglio.TFDButton:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.dsrT768;
  frmToolbarFiglio.TFDBGrid:=dgrdSchedeInd;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
//  frmToolbarFiglio.AbilitaAzioniTF(nil);
  frmToolbarFiglio.actTFRicerca.Enabled:=True;
  frmToolbarFiglio.actTFPrimo.Enabled:=True;
  frmToolbarFiglio.actTFPrec.Enabled:=True;
  frmToolbarFiglio.actTFSucc.Enabled:=True;
  frmToolbarFiglio.actTFUltimo.Enabled:=True;
  frmToolbarFiglio.actTFModifica.Enabled:=True;
  frmToolbarFiglio.actTFConferma.Enabled:=False;
  frmToolbarFiglio.actTFAnnulla.Enabled:=False;
  frmToolbarFiglio.actTFGomma.Enabled:=False;
  inherited;
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
  frmToolbarFiglio.actTFRefresh.Visible:=False;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
//  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  dcmbTipoQuotaCloseUp(nil);
  grdPagamenti.Cells[0,1]:='Max.ore';
  grdPagamenti.Cells[0,2]:='% ore';
  grdPagamenti.Cells[1,0]:='Gennaio';
  grdPagamenti.Cells[2,0]:='Febbraio';
  grdPagamenti.Cells[3,0]:='Marzo';
  grdPagamenti.Cells[4,0]:='Aprile';
  grdPagamenti.Cells[5,0]:='Maggio';
  grdPagamenti.Cells[6,0]:='Giugno';
  grdPagamenti.Cells[7,0]:='Luglio';
  grdPagamenti.Cells[8,0]:='Agosto';
  grdPagamenti.Cells[9,0]:='Settembre';
  grdPagamenti.Cells[10,0]:='Ottobre';
  grdPagamenti.Cells[11,0]:='Novembre';
  grdPagamenti.Cells[12,0]:='Dicembre';
  Abilitazioni;
end;

procedure TA172FSchedeQuantIndividuali.Abilitazioni;
begin
  with A172FSchedeQuantIndividualiDtM do
  begin
    actInserisci.Enabled:=not SolaLettura;
    actModifica.Enabled:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString = 'A');
    actCancella.Enabled:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString = 'A');
    frmToolbarFiglio.actTFModifica.Enabled:=(not SolaLettura) and (selT767.FieldByName('STATO').AsString <> 'C');
  end;
end;

procedure TA172FSchedeQuantIndividuali.frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
begin
//  inherited;
  if A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.State = dsEdit then
    A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.Cancel;
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.ReadOnly:=True;
  dgrdSchedeInd.Options:=[dgColumnResize,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgRowSelect,dgAlwaysShowSelection,dgMultiSelect];
  frmToolbarFiglio.actTFRicerca.Enabled:=True;
  frmToolbarFiglio.actTFPrimo.Enabled:=True;
  frmToolbarFiglio.actTFPrec.Enabled:=True;
  frmToolbarFiglio.actTFSucc.Enabled:=True;
  frmToolbarFiglio.actTFUltimo.Enabled:=True;
  frmToolbarFiglio.actTFModifica.Enabled:=True;
  frmToolbarFiglio.actTFConferma.Enabled:=False;
  frmToolbarFiglio.actTFAnnulla.Enabled:=False;
  frmToolbarFiglio.actTFGomma.Enabled:=False;
  actRefresh.Execute;
end;

function TA172FSchedeQuantIndividuali.AggiornaTotali: TTotali;
var
  Totali: TTotali;
begin
  Totali:=A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.CalcolaTotali;
  edtNumOreTotale.Text:=R180MinutiOre(Totali.TotaleOreAssegn);
  edtImpTotale.Text:=Format('%15.2n',[Totali.TotaleAssegn]);
  edtTotOreAccett.Text:=R180MinutiOre(Totali.TotaleOreAccett);
  edtTotAccett.Text:=Format('%15.2n',[Totali.TotaleAccett]);
  edtMaxOre.Text:=R180MinutiOre(Totali.MaxOre);
  edtMaxImp.Text:=Format('%15.2n',[Totali.MaxImp]);
  edtTotOreAccett.Font.Color:=clBlack;
  edtTotAccett.Font.Color:=clBlack;
  lblTotOreAccett.Font.Color:=clBlack;
  lblTotAccett.Font.Color:=clBlack;
  if (Totali.MaxOre <> 0) and
     (Totali.TotaleOreAccett > Totali.MaxOre) then
  begin
    edtTotOreAccett.Font.Color:=clRed;
    lblTotOreAccett.Font.Color:=clRed;
  end;
  if (Totali.MaxImp <> 0) and
     (R180AzzeraPrecisione(Totali.MaxImp - Totali.TotaleAccett,2) < 0) then
  begin
    edtTotAccett.Font.Color:=clRed;
    lblTotAccett.Font.Color:=clRed;
  end;
  Result:=Totali;
end;

procedure TA172FSchedeQuantIndividuali.frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
var Totali: TTotali;
begin
//  inherited;
  if A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.State = dsEdit then
    A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.Post;
  Totali:=AggiornaTotali;
  if (Totali.MaxImp <> 0) and
     (R180AzzeraPrecisione(Totali.MaxImp - Totali.TotaleAccett,2) < 0) then
    raise exception.Create(A000MSG_A172_ERR_TOT_ORE_ACCETTATE);
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.ReadOnly:=True;
  dgrdSchedeInd.Options:=[dgColumnResize,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgRowSelect,dgAlwaysShowSelection,dgMultiSelect];
  frmToolbarFiglio.actTFRicerca.Enabled:=True;
  frmToolbarFiglio.actTFPrimo.Enabled:=True;
  frmToolbarFiglio.actTFPrec.Enabled:=True;
  frmToolbarFiglio.actTFSucc.Enabled:=True;
  frmToolbarFiglio.actTFUltimo.Enabled:=True;
  frmToolbarFiglio.actTFModifica.Enabled:=True;
  frmToolbarFiglio.actTFConferma.Enabled:=False;
  frmToolbarFiglio.actTFAnnulla.Enabled:=False;
  frmToolbarFiglio.actTFGomma.Enabled:=False;
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768Post(Totali);
  actRefresh.Execute;
end;

procedure TA172FSchedeQuantIndividuali.frmToolbarFiglioactTFModificaExecute(Sender: TObject);
begin
//  inherited;
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.ReadOnly:=False;
  A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.Edit;
  dgrdSchedeInd.Options:=[dgEditing,dgColumnResize,dgAlwaysShowEditor,dgTitles,dgIndicator,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  frmToolbarFiglio.actTFRicerca.Enabled:=False;
  frmToolbarFiglio.actTFPrimo.Enabled:=False;
  frmToolbarFiglio.actTFPrec.Enabled:=False;
  frmToolbarFiglio.actTFSucc.Enabled:=False;
  frmToolbarFiglio.actTFUltimo.Enabled:=False;
  frmToolbarFiglio.actTFModifica.Enabled:=False;
  frmToolbarFiglio.actTFConferma.Enabled:=True;
  frmToolbarFiglio.actTFAnnulla.Enabled:=True;
  frmToolbarFiglio.actTFGomma.Enabled:=True;
end;

procedure TA172FSchedeQuantIndividuali.grdPagamentiGetEditMask(Sender: TObject; ACol, ARow: Integer; var Value: string);
begin
  inherited;
  if grdPagamenti.Enabled and (ARow = 1) then
    Value:='!990:00;1;_';
end;

procedure TA172FSchedeQuantIndividuali.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdSchedeInd,'C');
end;

procedure TA172FSchedeQuantIndividuali.mnuObiettiviClick(Sender: TObject);
begin
  inherited;
  OpenA172SchedeQuantObiettivi(A172FSchedeQuantIndividualiDtM.selT767.FieldByName('ANNO').AsInteger,
                               A172FSchedeQuantIndividualiDtM.A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('PROGRESSIVO').AsInteger);
end;

procedure TA172FSchedeQuantIndividuali.PopupMenu1Popup(Sender: TObject);
var Dato1,Dato2,Dato3,TipoStampaQuant: String;
begin
  inherited;
  //Gli obiettivi dei posizionati sono visibili se la stampa assegnata al dip. in base alle regole è 1 o 2
  with A172FSchedeQuantIndividualiDtM do
  begin
    Dato1:=Copy(A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato1').AsString,1,Pos(' - ',A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato1').AsString)-1);
    Dato2:=Copy(A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato2').AsString,1,Pos(' - ',A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato2').AsString)-1);
    Dato3:=Copy(A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato3').AsString,1,Pos(' - ',A172FSchedeQuantIndividualiMW.cdsT768.FieldByName('Dato3').AsString)-1);

    TipoStampaQuant:=A172FSchedeQuantIndividualiMW.getTipoStampaQuant(Dato1,Dato2,Dato3);
    mnuObiettivi.Visible:=TipoStampaQuant <> '0';
    btnObiettivi.Visible:=TipoStampaQuant <> '0';
  end;
end;

procedure TA172FSchedeQuantIndividuali.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdSchedeInd,'S');
end;

procedure TA172FSchedeQuantIndividuali.TRegisClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

end.

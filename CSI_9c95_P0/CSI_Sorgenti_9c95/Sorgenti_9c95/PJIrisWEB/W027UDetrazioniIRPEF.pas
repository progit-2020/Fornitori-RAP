unit W027UDetrazioniIRPEF;

interface

uses
  IWApplication, IWAppForm, SysUtils, Classes,
  Controls, R012UWEBANAGRAFICO, IWCompLabel,
  IWControl, IWCompListbox, meIWEdit,
  IWCompButton, OracleData, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWCheckBox, Variants,
  IWVCLBaseControl, Forms, IWVCLBaseContainer, IWContainer,
  DB, R010UPaginaWeb, WC012UVisualizzaFileFM,
  StrUtils, DBClient, Math, medpIWDBGrid, IWCompExtCtrls, IWCompGrids,
  meIWLabel, meIWLink, meIWComboBox, meIWButton, meIWRadioGroup, IWDBGrids,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl,
  IWHTMLControls;

type

  TW027FDetrazioniIRPEF = class(TR012FWebAnagrafico)
    grdDetrazioni: TmedpIWDBGrid;
    dsrSG122: TDataSource;
    cdsSG122: TClientDataSet;
    lblDetrazioniDipendente: TmeIWLabel;
    rgpDetrazioniDipendente: TmeIWRadioGroup;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lblTitoloDichiarazione: TmeIWLabel;
    lblUltimoAggiornamento: TmeIWLabel;
    lnkIstrDetr: TmeIWLink;
    btnRipristina: TmeIWButton;
    lblStatoCivile: TmeIWLabel;
    cbxStatoCivile: TmeIWComboBox;
    lblNote: TmeIWLabel;
    lblDetrazioniDipendenteSiNo: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdDetrazioniRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnRipristinaClick(Sender: TObject);
    procedure lnkIstrDetrClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    vData,DataAgg: TDateTime;
    AnnoDichiarazione: Integer;
    CreazioneForm, SvuotamentoForzato, BloccaMessaggio: Boolean;
    ElencoCodiciFiscali,FileIstruzioni: String;
    procedure EventoSbloccaMessaggio(Sender: TObject; EventParams: TStringList);
    //DA 21/02/2013 procedure EstraiUltimaDataAggiornamento;
    procedure CreaComponentiRiga(FN: String);
    procedure AbilitazioneComponenti(i:Integer; Carico:Boolean);
    procedure CognomeExit(Sender: TObject; EventParams: TStringList);
    procedure NomeExit(Sender: TObject; EventParams: TStringList);
    procedure CaricoClick(Sender: TObject);
    procedure PercCaricoClick(Sender: TObject);
    procedure MancaConiugeClick(Sender: TObject);
    procedure PortatoreDiHandicapClick(Sender: TObject);
    procedure DataNasExit(Sender: TObject; EventParams: TStringList);
    procedure CodFiscaleExit(Sender: TObject; EventParams: TStringList);
    function ControlliOK(FN: String): Boolean;
    procedure ApplicaModifiche;
    procedure AggiornaFamiliari;
    procedure ProceduraOK;
  protected
    procedure VisualizzaDipendenteCorrente; override;
    //DA 21/02/2013 procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TW027FDetrazioniIRPEF.InizializzaAccesso:Boolean;
begin
  Result:=True;
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  cmbDipendentiDisponibili.Enabled:=False;
  if CreazioneForm then
  begin
    AnnoDichiarazione:=R180Anno(R180Sysdate(SessioneOracle));
    //DA 21/02/2013 lblTitoloDichiarazione.Caption:=lblTitoloDichiarazione.Caption + IntToStr(AnnoDichiarazione);
    //DA 21/02/2013 EstraiUltimaDataAggiornamento;
    DataAgg:=R180Sysdate(SessioneOracle);
    with WR000DM.insSG122 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA_AGG',DataAgg);
      //DA 21/02/2013 SetVariable('MESSAGGIO','');
      SetVariable('DATA_FISSA',EncodeDate(2013,2,21));//DA 21/02/2013
      Execute;
      //DA 21/02/2013 if VarToStr(GetVariable('MESSAGGIO')) = '' then
        SessioneOracle.Commit
      (*DA 21/02/2013
      else
      begin
        SessioneOracle.Rollback;
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile accedere a questa maschera per il seguente motivo:' + CRLF +
                                   GetVariable('MESSAGGIO') + CRLF +
                                   'Occorre compilare la Dichiarazione relativa alle detrazioni IRPEF direttamente presso gli uffici preposti!');
        abort;
      end;*)
    end;
    CreazioneForm:=False;
  end;
  //aggiorna dati
  VisualizzaDipendenteCorrente;
end;

procedure TW027FDetrazioniIRPEF.EventoSbloccaMessaggio(Sender: TObject; EventParams: TStringList);
begin
  BloccaMessaggio:=False;
end;

(*DA 21/02/2013
procedure TW027FDetrazioniIRPEF.EstraiUltimaDataAggiornamento;
begin
  with WR000DM.selaSG120 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    Open;
    lblUltimoAggiornamento.Caption:='Data ultimo aggiornamento: ' + FormatDateTime('dd/mm/yyyy hh.nn',FieldByName('DATA_AGG').AsDateTime);
    lblUltimoAggiornamento.Visible:=FieldByName('DATA_AGG').AsString <> '';
  end;
end;
*)

procedure TW027FDetrazioniIRPEF.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  (*DA 21/02/2013
  with WR000DM do
  begin
    selP500.Tag:=selP500.Tag + 1;

    selP500.Close;
    selP500.SetVariable('Anno', R180Anno(R180Sysdate(SessioneOracle)));
    selP500.Open;
    if (selP500.RecordCount = 0)
    or (Trunc(R180Sysdate(SessioneOracle)) < selP500.FieldByName('FAM_DATA_DA').AsDateTime)
    or (Trunc(R180Sysdate(SessioneOracle)) > selP500.FieldByName('FAM_DATA_A').AsDateTime) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Non è possibile accedere a questa maschera in quanto la data odierna è esterna al periodo di abilitazione all''accesso web per la Dichiarazione relativa alle detrazioni IRPEF!');
      R180CloseDataSetTag0(WR000DM.selP500);
      abort;
    end
    else
    begin
      lnkIstrDetr.Visible:=selP500.FieldByName('FAM_PATH_ISTRUZIONI').AsString <> '';
      FileIstruzioni:=selP500.FieldByName('FAM_PATH_ISTRUZIONI').AsString;
      lblStatoCivile.Visible:=selP500.FieldByName('FAM_STATO_CIVILE').AsString = 'S';
      cbxStatoCivile.Visible:=lblStatoCivile.Visible;
      selP020.Close;
      selP020.Open;
      while not selP020.Eof do
      begin
        cbxStatoCivile.Items.Add(Format('%-5s %s',[selP020.FieldByName('COD_STATOCIVILE').AsString,selP020.FieldByName('DESCRIZIONE').AsString]));
        selP020.Next;
      end;
      lblNote.Caption:=selP500.FieldByName('FAM_NOTE').AsString;
      lblNote.Visible:=selP500.FieldByName('FAM_NOTE').AsString <> '';
    end;
  end;*)
  //DA 21/02/2013
  SolaLettura:=True;
  lblTitoloDichiarazione.Visible:=False;
  lblUltimoAggiornamento.Visible:=False;
  lnkIstrDetr.Visible:=False;
  lblStatoCivile.Visible:=False;
  cbxStatoCivile.Visible:=False;
  rgpDetrazioniDipendente.Visible:=False;
  lblNote.Visible:=False;
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  btnRipristina.Visible:=False;

  vData:=Parametri.DataLavoro;
  GetDipendentiDisponibili(vData);
  grdDetrazioni.medpPaginazione:=False;//Non gestire la paginazione!
  grdDetrazioni.medpDataSet:=WR000DM.selSG122;
  CreazioneForm:=True;
end;

procedure TW027FDetrazioniIRPEF.VisualizzaDipendenteCorrente;
begin
  inherited;
  grdDetrazioni.medpBrowse:=True;
  //apertura dataset delle testate delle dichiarazioni di detrazioni per familiari a carico
  with WR000DM.selSG120 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA_AGG',DataAgg);
    Open;
    if not Eof then
    begin
      (*DA 21/02/2013
      if not FieldByName('COD_STATOCIVILE').IsNull then
        cbxStatoCivile.ItemIndex:=cbxStatoCivile.Items.IndexOf(Format('%-5s %s',[FieldByName('COD_STATOCIVILE').AsString,VarToStr(WR000DM.selP020.Lookup('COD_STATOCIVILE',FieldByName('COD_STATOCIVILE').AsString,'DESCRIZIONE'))]));
      *)
      lblDetrazioniDipendente.Visible:=not FieldByName('DETRAZ_LAVDIP').IsNull;
      //DA 21/02/2013 rgpDetrazioniDipendente.Visible:=not FieldByName('DETRAZ_LAVDIP').IsNull;
      lblDetrazioniDipendenteSiNo.Visible:=not FieldByName('DETRAZ_LAVDIP').IsNull;//DA 21/02/2013
      if not FieldByName('DETRAZ_LAVDIP').IsNull then
        //DA 21/02/2013 rgpDetrazioniDipendente.ItemIndex:=IfThen(FieldByName('DETRAZ_LAVDIP').AsString = 'S',0,1);
        lblDetrazioniDipendenteSiNo.Caption:=IfThen(FieldByName('DETRAZ_LAVDIP').AsString = 'S','Si','No');//DA 21/02/2013
    end;
  end;
  //apertura dataset del dettaglio delle dichiarazioni di detrazioni per familiari a carico
  with WR000DM.selSG122 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA_AGG',DataAgg);
    Open;
  end;

  grdDetrazioni.medpCreaCDS;
  grdDetrazioni.medpEliminaColonne;
  grdDetrazioni.medpAggiungiColonna('DESC_TIPO_FAM','Familiare','',nil);
  grdDetrazioni.medpAggiungiColonna('COGNOME','Cognome','',nil);
  grdDetrazioni.medpAggiungiColonna('NOME','Nome','',nil);
  grdDetrazioni.medpAggiungiColonna('CARICO','A carico','',nil);
  grdDetrazioni.medpAggiungiColonna('DATA_CARICO_DA','Dalla data','',nil);
  grdDetrazioni.medpAggiungiColonna('DATA_CARICO_A','Alla data','',nil);
  grdDetrazioni.medpAggiungiColonna('PERC_CARICO','% a carico','',nil);
  grdDetrazioni.medpAggiungiColonna('MANCA_CONIUGE','Mancanza coniuge','',nil);
  grdDetrazioni.medpAggiungiColonna('DETR_FIGLIO_HANDICAP','Portatore di handicap','',nil);
  grdDetrazioni.medpAggiungiColonna('DATANAS','Data nascita','',nil);
  grdDetrazioni.medpAggiungiColonna('CODFISCALE','Codice fiscale','',nil);
  grdDetrazioni.medpColonna('CARICO').Visible:=False;//DA 12/02/2013
  grdDetrazioni.medpInizializzaCompGriglia;
  grdDetrazioni.medpCaricaCDS;
  (*DA 21/02/2013
  for i:=0 to High(grdDetrazioni.medpCompGriglia) do
    CreaComponentiRiga(grdDetrazioni.medpCompGriglia[i].RowID);
  *)
end;

procedure TW027FDetrazioniIRPEF.CreaComponentiRiga(FN: String);
var
  i: Integer;
begin
  i:=grdDetrazioni.medpRigaDiCompGriglia(FN);
  //cognome
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'20','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,1,grdDetrazioni.Componenti);
  with (grdDetrazioni.medpCompCella(i,1,0) as TmeIWEdit) do
  begin
    Text:=grdDetrazioni.medpValoreColonna(i,'COGNOME');
    Css:=Css + ' maiuscolo';
    OnAsyncExit:=CognomeExit;
    OnAsyncKeyUp:=EventoSbloccaMessaggio;
    OnAsyncMouseDown:=EventoSbloccaMessaggio;
  end;
  //nome
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'20','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,2,grdDetrazioni.Componenti);
  with (grdDetrazioni.medpCompCella(i,2,0) as TmeIWEdit) do
  begin
    Text:=grdDetrazioni.medpValoreColonna(i,'NOME');
    Css:=Css + ' maiuscolo';
    OnAsyncExit:=NomeExit;
    OnAsyncKeyUp:=EventoSbloccaMessaggio;
    OnAsyncMouseDown:=EventoSbloccaMessaggio;
  end;
  //a carico
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','Si','','','S');
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','No','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,3,grdDetrazioni.Componenti);
  with (grdDetrazioni.medpCompCella(i,3,0) as TmeIWCheckBox) do
  begin
    Checked:=grdDetrazioni.medpValoreColonna(i,'CARICO') = 'S';
    OnClick:=CaricoClick;
  end;
  with (grdDetrazioni.medpCompCella(i,3,1) as TmeIWCheckBox) do
  begin
    Checked:=grdDetrazioni.medpValoreColonna(i,'CARICO') = 'N';
    OnClick:=CaricoClick;
  end;
  //dalla data
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,4,grdDetrazioni.Componenti);
  (grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit).Text:=grdDetrazioni.medpValoreColonna(i,'DATA_CARICO_DA');
  //alla data
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,5,grdDetrazioni.Componenti);
  (grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit).Text:=grdDetrazioni.medpValoreColonna(i,'DATA_CARICO_A');
  //% a carico
  if grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM') <> 'Coniuge' then
  begin
    if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Figlio' then
    begin
      grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','Si','','','S');
      grdDetrazioni.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','No','','','S');
      grdDetrazioni.medpCreaComponenteGenerico(i,6,grdDetrazioni.Componenti);
      with (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox) do
      begin
        Caption:='50';
        Checked:=grdDetrazioni.medpValoreColonna(i,'PERC_CARICO') = '50';
        OnClick:=PercCaricoClick;
      end;
      with (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox) do
      begin
        Caption:='100';
        Checked:=grdDetrazioni.medpValoreColonna(i,'PERC_CARICO') = '100';
        OnClick:=PercCaricoClick;
      end;
    end
    else if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Altro familiare' then
    begin
      grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'10','','','','S');
      grdDetrazioni.medpCreaComponenteGenerico(i,6,grdDetrazioni.Componenti);
      (grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text:=StringReplace(grdDetrazioni.medpValoreColonna(i,'PERC_CARICO'),'.',',',[rfReplaceAll]);
    end;
  end;
  //mancanza coniuge
  if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Figlio' then
  begin
    grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','Si','','','S');
    grdDetrazioni.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','No','','','S');
    grdDetrazioni.medpCreaComponenteGenerico(i,7,grdDetrazioni.Componenti);
    with (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox) do
    begin
      Checked:=grdDetrazioni.medpValoreColonna(i,'MANCA_CONIUGE') = 'S';
      OnClick:=MancaConiugeClick;
    end;
    with (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox) do
    begin
      Checked:=grdDetrazioni.medpValoreColonna(i,'MANCA_CONIUGE') = 'N';
      OnClick:=MancaConiugeClick;
    end;
  end;
  //Portatore di handicap
  if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Figlio' then
  begin
    grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','Si','','','S');
    grdDetrazioni.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','No','','','S');
    grdDetrazioni.medpCreaComponenteGenerico(i,8,grdDetrazioni.Componenti);
    with (grdDetrazioni.medpCompCella(i,8,0) as TmeIWCheckBox) do
    begin
      Checked:=grdDetrazioni.medpValoreColonna(i,'DETR_FIGLIO_HANDICAP') = 'S';
      OnClick:=PortatoreDiHandicapClick;
    end;
    with (grdDetrazioni.medpCompCella(i,8,1) as TmeIWCheckBox) do
    begin
      Checked:=grdDetrazioni.medpValoreColonna(i,'DETR_FIGLIO_HANDICAP') = 'N';
      OnClick:=PortatoreDiHandicapClick;
    end;
  end;
  //data nascita
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,1,DBG_EDT,'ORA2','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,9,grdDetrazioni.Componenti);
  with (grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit) do
  begin
    Text:=Copy(grdDetrazioni.medpValoreColonna(i,'DATANAS'),1,10);
    OnAsyncExit:=DataNasExit;
    OnAsyncKeyUp:=EventoSbloccaMessaggio;
    OnAsyncMouseDown:=EventoSbloccaMessaggio;
  end;
  with (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit) do
  begin
    Text:=grdDetrazioni.medpValoreColonna(i,'ORANAS');
    OnAsyncExit:=DataNasExit;
    OnAsyncKeyUp:=EventoSbloccaMessaggio;
    OnAsyncMouseDown:=EventoSbloccaMessaggio;
  end;
  //codice fiscale
  grdDetrazioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'20','','','','S');
  grdDetrazioni.medpCreaComponenteGenerico(i,10,grdDetrazioni.Componenti);
  with (grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit) do
  begin
    Text:=grdDetrazioni.medpValoreColonna(i,'CODFISCALE');
    OnAsyncExit:=CodFiscaleExit;
    OnAsyncKeyUp:=EventoSbloccaMessaggio;
    OnAsyncMouseDown:=EventoSbloccaMessaggio;
  end;
  if grdDetrazioni.medpValoreColonna(i,'CARICO') <> '' then
    AbilitazioneComponenti(i,grdDetrazioni.medpValoreColonna(i,'CARICO') = 'S');
end;

procedure TW027FDetrazioniIRPEF.AbilitazioneComponenti(i:Integer; Carico:Boolean);
begin
  (grdDetrazioni.medpCompCella(i,3,0) as TmeIWCheckBox).Checked:=Carico;
  (grdDetrazioni.medpCompCella(i,3,1) as TmeIWCheckBox).Checked:=not Carico;
  (grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit).Enabled:=Carico;
  if not Carico then
    (grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit).Text:='01/01/' + IntToStr(AnnoDichiarazione);
  (grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit).Enabled:=Carico;
  if not Carico then
    (grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit).Text:='31/12/' + IntToStr(AnnoDichiarazione);
  if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Figlio' then
  begin
    (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox).Enabled:=Carico;
    (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox).Enabled:=Carico;
    if not Carico then
    begin
      (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox).Checked:=False;
      (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox).Checked:=False;
    end;
  end
  else if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Altro familiare' then
  begin
    (grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Enabled:=Carico;
    if not Carico then
      (grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text:='';
  end;
  if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Figlio' then
  begin
    (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox).Enabled:=Carico;
    (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox).Enabled:=Carico;
    if not Carico then
    begin
      (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox).Checked:=False;
      (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox).Checked:=False;
    end;
  end;
end;

(*DA 21/02/2013
procedure TW027FDetrazioniIRPEF.RefreshPage;
begin
  with WR000DM do
  begin
    selP500.Close;
    selP500.SetVariable('Anno', R180Anno(R180Sysdate(SessioneOracle)));
    selP500.Open;
  end;
end;
*)

procedure TW027FDetrazioniIRPEF.grdDetrazioniRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var NumColonna:Integer;
begin
  inherited;

  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  ACell.Wrap:=True;
  NumColonna:=grdDetrazioni.medpNumColonna(AColumn);

  //DA 21/02/2013
  ACell.Css:=ACell.Css + ' align_center';
  if ARow > 0 then
  begin
    if grdDetrazioni.medpNumColonna(AColumn) = grdDetrazioni.medpIndexColonna('DATA_CARICO_DA') then
      ACell.Text:=IfThen(Copy(ACell.Text,1,5) = '01/01','',ACell.Text);
    if grdDetrazioni.medpNumColonna(AColumn) = grdDetrazioni.medpIndexColonna('DATA_CARICO_A') then
      ACell.Text:=IfThen(Copy(ACell.Text,1,5) = '31/12','',ACell.Text);
    if (grdDetrazioni.medpNumColonna(AColumn) = grdDetrazioni.medpIndexColonna('MANCA_CONIUGE'))
    or (grdDetrazioni.medpNumColonna(AColumn) = grdDetrazioni.medpIndexColonna('DETR_FIGLIO_HANDICAP')) then
      ACell.Text:=IfThen(ACell.Text = 'S','Si','');
    if grdDetrazioni.medpNumColonna(AColumn) = grdDetrazioni.medpIndexColonna('DATANAS') then
      ACell.Text:=Copy(ACell.Text,1,10);
  end;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdDetrazioni.medpCompGriglia) + 1) and (grdDetrazioni.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDetrazioni.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW027FDetrazioniIRPEF.CognomeExit(Sender: TObject; EventParams: TStringList);
var
  FN: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  if FN <> cdsSG122.FieldByName('DBG_ROWID').AsString then
    cdsSG122.Locate('DBG_ROWID',FN,[]);
  if cdsSG122.FieldByName('NUMORD').AsInteger <> -1 then
    if not BloccaMessaggio then
    begin
      if Trim((Sender as TmeIWEdit).Text) = '' then
        GGetWebApplicationThreadVar.ShowMessage('Si avvisa che non sarà possibile confermare la richiesta senza indicare il cognome!' + CRLF +
                                   'Cognome originale: ' + cdsSG122.FieldByName('COGNOME').AsString)
      else if (Trim((Sender as TmeIWEdit).Text) <> cdsSG122.FieldByName('COGNOME').AsString) then
        GGetWebApplicationThreadVar.ShowMessage('Si segnala che il cognome originale (' + cdsSG122.FieldByName('COGNOME').AsString + ') sarà sostituito con ' + Trim((Sender as TmeIWEdit).Text) + '!');
    end;
  BloccaMessaggio:=True;
end;

procedure TW027FDetrazioniIRPEF.NomeExit(Sender: TObject; EventParams: TStringList);
var
  FN: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  if FN <> cdsSG122.FieldByName('DBG_ROWID').AsString then
    cdsSG122.Locate('DBG_ROWID',FN,[]);
  if cdsSG122.FieldByName('NUMORD').AsInteger <> -1 then
    if not BloccaMessaggio then
    begin
      if Trim((Sender as TmeIWEdit).Text) = '' then
        GGetWebApplicationThreadVar.ShowMessage('Si avvisa che non sarà possibile confermare la richiesta senza indicare il nome!' + CRLF +
                                   'Nome originale: ' + cdsSG122.FieldByName('NOME').AsString)
      else if (Trim((Sender as TmeIWEdit).Text) <> cdsSG122.FieldByName('NOME').AsString) then
        GGetWebApplicationThreadVar.ShowMessage('Si segnala che il nome originale (' + cdsSG122.FieldByName('NOME').AsString + ') sarà sostituito con ' + Trim((Sender as TmeIWEdit).Text) + '!');
    end;
  BloccaMessaggio:=True;
end;

procedure TW027FDetrazioniIRPEF.CaricoClick(Sender: TObject);
begin
  if TmeIWCheckBox(Sender).Checked then
    exit;
  AbilitazioneComponenti(grdDetrazioni.medpRigaDiCompGriglia(TmeIWEdit(Sender).FriendlyName),TmeIWCheckBox(Sender).Caption = 'Si');
end;

procedure TW027FDetrazioniIRPEF.PercCaricoClick(Sender: TObject);
var
  Carico50: Boolean;
  i: Integer;
begin
  if (Sender as TmeIWCheckBox).Checked then
    exit;
  i:=grdDetrazioni.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  Carico50:=(Sender as TmeIWCheckBox).Caption = '50';
  (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox).Checked:=Carico50;
  (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox).Checked:=not Carico50;
end;

procedure TW027FDetrazioniIRPEF.MancaConiugeClick(Sender: TObject);
var
  Manca: Boolean;
  i: Integer;
begin
  if (Sender as TmeIWCheckBox).Checked then
    exit;
  i:=grdDetrazioni.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  Manca:=(Sender as TmeIWCheckBox).Caption = 'Si';
  (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox).Checked:=Manca;
  (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox).Checked:=not Manca;
end;

procedure TW027FDetrazioniIRPEF.PortatoreDiHandicapClick(Sender: TObject);
var
  PortatoreDiHandicap: Boolean;
  i: Integer;
begin
  if (Sender as TmeIWCheckBox).Checked then
    exit;
  i:=grdDetrazioni.medpRigaDiCompGriglia((Sender as TmeIWCheckBox{TmeIWEdit}).FriendlyName); // *** non è un edit!!!
  PortatoreDiHandicap:=(Sender as TmeIWCheckBox).Caption = 'Si';
  (grdDetrazioni.medpCompCella(i,8,0) as TmeIWCheckBox).Checked:=PortatoreDiHandicap;
  (grdDetrazioni.medpCompCella(i,8,1) as TmeIWCheckBox).Checked:=not PortatoreDiHandicap;
end;

procedure TW027FDetrazioniIRPEF.DataNasExit(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  FN: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  i:=grdDetrazioni.medpRigaDiCompGriglia(FN);
  if FN <> cdsSG122.FieldByName('DBG_ROWID').AsString then
    cdsSG122.Locate('DBG_ROWID',FN,[]);
  if cdsSG122.FieldByName('NUMORD').AsInteger <> -1 then
    if not BloccaMessaggio then
    begin
      if Trim((grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text + ' ' + (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text) = '' then
        GGetWebApplicationThreadVar.ShowMessage('Si avvisa che non sarà possibile confermare la richiesta senza indicare la data di nascita!' + CRLF +
                                   'Data nascita originale: ' + cdsSG122.FieldByName('DATANAS').AsString)
      else if StrToDateTime(Trim((grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text + ' ' + (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text)) <> cdsSG122.FieldByName('DATANAS').AsDateTime then
        GGetWebApplicationThreadVar.ShowMessage('Si segnala che la data di nascita originale (' + cdsSG122.FieldByName('DATANAS').AsString + ') sarà sostituita con ' + Trim((grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text + ' ' + (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text) + '!');
    end;
  BloccaMessaggio:=True;
end;

procedure TW027FDetrazioniIRPEF.CodFiscaleExit(Sender: TObject; EventParams: TStringList);
var
  FN: String;
begin
  FN:=(Sender as TmeIWEdit).FriendlyName;
  if FN <> cdsSG122.FieldByName('DBG_ROWID').AsString then
    cdsSG122.Locate('DBG_ROWID',FN,[]);
  if cdsSG122.FieldByName('NUMORD').AsInteger <> -1 then
    if not BloccaMessaggio then
    begin
      if Trim((Sender as TmeIWEdit).Text) = '' then
        GGetWebApplicationThreadVar.ShowMessage('Si avvisa che non sarà possibile confermare la richiesta senza indicare il codice fiscale!' + CRLF +
                                   'Codice fiscale originale: ' + cdsSG122.FieldByName('CODFISCALE').AsString)
      else if (Trim((Sender as TmeIWEdit).Text) <> cdsSG122.FieldByName('CODFISCALE').AsString) then
        GGetWebApplicationThreadVar.ShowMessage('Si segnala che il codice fiscale originale (' + cdsSG122.FieldByName('CODFISCALE').AsString + ') sarà sostituito con ' + Trim((Sender as TmeIWEdit).Text) + '!');
    end;
  BloccaMessaggio:=True;
end;

procedure TW027FDetrazioniIRPEF.btnConfermaClick(Sender: TObject);
var
  i: Integer;
begin
  exit;//DA 21/02/2013
  inherited;
  try
    SvuotamentoForzato:=False;
    ElencoCodiciFiscali:=',';
    if cbxStatoCivile.Visible and (cbxStatoCivile.ItemIndex = -1) then
      raise exception.Create('E'' necessario indicare lo stato civile del dichiarante!');
    for i:=0 to High(grdDetrazioni.medpCompGriglia) do
    begin
      (grdDetrazioni.medpCompCella(i,1,0) as TmeIWEdit).Text:=Trim((grdDetrazioni.medpCompCella(i,1,0) as TmeIWEdit).Text);
      (grdDetrazioni.medpCompCella(i,2,0) as TmeIWEdit).Text:=Trim((grdDetrazioni.medpCompCella(i,2,0) as TmeIWEdit).Text);
      if Copy(grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM'),4) = 'Altro familiare' then
        (grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text:=Trim((grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text);
      (grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit).Text:=Trim((grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit).Text);
      ControlliOK(grdDetrazioni.medpCompGriglia[i].RowID);
    end;
    if SvuotamentoForzato then
      raise exception.Create('Attenzione! Sono stati annullati i dati dichiarati per i familiari che non presentano il cognome compilato.'  + CRLF +
                             'Si richiede di controllare la dichiarazione attuale e, se corretta, premere nuovamente il pulsante Conferma.');
    ApplicaModifiche;
    AggiornaFamiliari;
    Messaggio('Termine acquisizione','Dichiarazione acquisita con successo!',ProceduraOK,nil);
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;
end;

function TW027FDetrazioniIRPEF.ControlliOK(FN: String): Boolean;
var
  i,j: Integer;
  Familiare,Cognome,Nome,Carico,DallaData,AllaData,PercCarico,MancaConiuge,PortatoreDiHandicap,DataNas,OraNas,CodFiscale:String;
  DataDa,DataA,DataNascCodFisc:TDateTime;
  PercACarico:Real;
  Acf,Mcf,Gcf,Aex,Mex,Gex: String;
  A,M,G: Word;
begin
  Result:=False;
  i:=grdDetrazioni.medpRigaDiCompGriglia(FN);
  cdsSG122.Locate('DBG_ROWID',FN,[]);
  //Recupero i valori da controllare
  Familiare:=grdDetrazioni.medpValoreColonna(i,'DESC_TIPO_FAM');
  Cognome:=(grdDetrazioni.medpCompCella(i,1,0) as TmeIWEdit).Text;
  Nome:=(grdDetrazioni.medpCompCella(i,2,0) as TmeIWEdit).Text;
  Carico:='';
  if (grdDetrazioni.medpCompCella(i,3,0) as TmeIWCheckBox).Checked then
    Carico:='S'
  else if (grdDetrazioni.medpCompCella(i,3,1) as TmeIWCheckBox).Checked then
    Carico:='N';
  DallaData:=(grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit).Text;
  AllaData:=(grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit).Text;
  PercCarico:='';
  if Copy(Familiare,4) = 'Figlio' then
  begin
    if (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox).Checked then
      PercCarico:='50'
    else if (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox).Checked then
      PercCarico:='100';
  end
  else if Copy(Familiare,4) = 'Altro familiare' then
    PercCarico:=(grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text;
  MancaConiuge:='';
  if Copy(Familiare,4) = 'Figlio' then
  begin
    if (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox).Checked then
      MancaConiuge:='S'
    else if (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox).Checked then
      MancaConiuge:='N';
  end;
  PortatoreDiHandicap:='';
  if Copy(Familiare,4) = 'Figlio' then
  begin
    if (grdDetrazioni.medpCompCella(i,8,0) as TmeIWCheckBox).Checked then
      PortatoreDiHandicap:='S'
    else if (grdDetrazioni.medpCompCella(i,8,1) as TmeIWCheckBox).Checked then
      PortatoreDiHandicap:='N';
  end;
  DataNas:=(grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text;
  OraNas:=(grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text;
  CodFiscale:=(grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit).Text;
  //Se il familiare è legato a SG101 (SG122.NUMORD<>-1)...
  if cdsSG122.FieldByName('NUMORD').AsInteger <> -1 then
    //...non permettere di svuotare Cognome o Nome
    if (Cognome = '') or (Nome = '') then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Non è possibile cancellare il nome o il cognome di un familiare già presente in anagrafica!' + CRLF +
                             '(Originale: ' + cdsSG122.FieldByName('COGNOME').AsString + ' ' + cdsSG122.FieldByName('NOME').AsString +')');
  //Se presente Cognome o Nome...
  if (Cognome <> '') or (Nome <> '') then
  begin
    //...sono obbligatori entrambi
    if (Cognome = '') or (Nome = '') then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Il nome e il cognome sono entrambi obbligatori! Altrimenti cancellarli entrambi!');
    //...e le colonne A carico, Dalla data, Alla data, PortatoreDiHandicap (ove previsto),
    //Data nascita e Codice Fiscale devono essere compilate
    //Se Familiare non è Coniuge, la colonna % a carico deve essere compilata
    //Se 1°-6° Figlio a carico, la colonna Mancanza coniuge deve essere compilata
    if Carico = '' then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Indicare se il familiare è a carico!');
    if DallaData = '' then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Indicare la data di inizio del periodo a carico!');
    if AllaData = '' then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Indicare la data di fine del periodo a carico!');
    if Familiare <> 'Coniuge' then
      if (Carico = 'S') and (PercCarico = '') then
        raise exception.Create(Familiare + ':' + CRLF +
                               'Indicare la percentuale a carico!');
    if Copy(Familiare,4) = 'Figlio' then
      if (Carico = 'S') and (MancaConiuge = '') then
        raise exception.Create(Familiare + ':' + CRLF +
                               'Indicare se adottare la detrazione per coniuge a carico!');
    if Copy(Familiare,4) = 'Figlio' then
      if PortatoreDiHandicap = '' then
        raise exception.Create(Familiare + ':' + CRLF +
                               'Indicare se il familiare è portatore di handicap!');
    if DataNas = '' then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Indicare la data di nascita!');
    if CodFiscale = '' then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Indicare il codice fiscale!');
  end;
  //Se non presente Cognome (e Nome), svuotare tutto
  if Cognome = '' then
  begin
    if not SvuotamentoForzato then
      SvuotamentoForzato:=(Carico <> '') or (DallaData <> '') or (AllaData <> '') or (PercCarico <> '') or
                          (MancaConiuge <> '') or (PortatoreDiHandicap <> '') or (DataNas <> '') or (OraNas <> '') or (CodFiscale <> '');
    //Svuoto e riabilito componenti
    (grdDetrazioni.medpCompCella(i,3,0) as TmeIWCheckBox).Checked:=False;
    (grdDetrazioni.medpCompCella(i,3,1) as TmeIWCheckBox).Checked:=False;
    with (grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit) do
    begin
      Text:='';
      Enabled:=True;
    end;
    with (grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit) do
    begin
      Text:='';
      Enabled:=True;
    end;
    if Copy(Familiare,4) = 'Figlio' then
    begin
      with (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox) do
      begin
        Checked:=False;
        Enabled:=True;
      end;
      with (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox) do
      begin
        Checked:=False;
        Enabled:=True;
      end;
    end
    else if Copy(Familiare,4) = 'Altro familiare' then
    begin
      with (grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit) do
      begin
        Text:='';
        Enabled:=True;
      end;
    end;
    if Copy(Familiare,4) = 'Figlio' then
    begin
      with (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox) do
      begin
        Checked:=False;
        Enabled:=True;
      end;
      with (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox) do
      begin
        Checked:=False;
        Enabled:=True;
      end;
    end;
    if Copy(Familiare,4) = 'Figlio' then
    begin
      (grdDetrazioni.medpCompCella(i,8,0) as TmeIWCheckBox).Checked:=False;
      (grdDetrazioni.medpCompCella(i,8,1) as TmeIWCheckBox).Checked:=False;
    end;
    (grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text:='';
    (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text:='';
    (grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit).Text:='';
    //Svuoto variabili
    Carico:='';
    DallaData:='';
    AllaData:='';
    PercCarico:='';
    MancaConiuge:='';
    PortatoreDiHandicap:='';
    DataNas:='';
    OraNas:='';
    CodFiscale:='';
    Exit;
  end;
  //Controllo formattazione dati
  try
    DataDa:=StrToDate(DallaData);
  except
    raise exception.Create(Familiare + ':' + CRLF +
                           'Indicare una corretta data di inizio del periodo a carico nel formato gg/mm/aaaa!');
  end;
  try
    DataA:=StrToDate(AllaData);
  except
    raise exception.Create(Familiare + ':' + CRLF +
                           'Indicare una corretta data di fine del periodo a carico nel formato gg/mm/aaaa!');
  end;
  if Familiare <> 'Coniuge' then
    if Carico = 'S' then
    begin
      try
        PercACarico:=StrToFloat(PercCarico);
      except
        raise exception.Create(Familiare + ':' + CRLF +
                               'Indicare una corretta percentuale a carico!');
      end;
      if Copy(Familiare,4) = 'Altro familiare' then
        if (Pos(',',PercCarico) > 0)
        and (Length(Copy(PercCarico,Pos(',',PercCarico) + 1)) > 2) then
          raise exception.Create(Familiare + ':' + CRLF +
                                 'Indicare al massimo 2 cifre decimali nella percentuale a carico!');
    end;
  try
    StrToDateTime(DataNas + ' ' + OraNas);
  except
    raise exception.Create(Familiare + ':' + CRLF +
                           'Indicare una corretta data di nascita nel formato gg/mm/aaaa hh.mi!');
  end;
  if Length(CodFiscale) <> 16 then
    raise exception.Create(Familiare + ':' + CRLF +
                           'Il codice fiscale deve essere lungo 16 caratteri!');
  //Dalla data - Alla data devono essere in ordine cronologico e nell’Anno
  if DataDa > DataA then
    raise exception.Create(Familiare + ':' + CRLF +
                           'Le date di inizio e di fine del periodo a carico devono essere in ordine cronologico!');
  if (R180Anno(DataDa) <> AnnoDichiarazione) or (R180Anno(DataA) <> AnnoDichiarazione) then
    raise exception.Create(Familiare + ':' + CRLF +
                           'Le date di inizio e di fine del periodo a carico devono essere interne all''anno della dichiarazione!');
  //Se 1°-6° Figlio a carico...
  if Copy(Familiare,4) = 'Figlio' then
  begin
    //Se Mancanza coniuge = Sì...
    if MancaConiuge = 'S' then
    begin
      //...può essere attivo su un solo figlio
      for j:=1 to i - 1 do
      begin
        if (grdDetrazioni.medpCompCella(j,7,0) as TmeIWCheckBox).Checked then
          raise exception.Create(Familiare + ':' + CRLF +
                                 'La detrazione per coniuge a carico può essere adottata soltanto per un figlio!');
      end;
      //...non deve esserci il coniuge a carico
      if (grdDetrazioni.medpCompCella(0,3,0) as TmeIWCheckBox).Checked then
        raise exception.Create(Familiare + ':' + CRLF +
                               'Non è possibile adottare la detrazione per coniuge a carico per un figlio e allo stesso tempo dichiarare il coniuge a carico!');
      //...la colonna % a carico deve essere 100
      if PercACarico <> 100 then
        raise exception.Create(Familiare + ':' + CRLF +
                               'Se si adotta la detrazione per coniuge a carico, la percentuale a carico deve essere 100!');
    end;
  end;
  //Se 1°-3° Altro familiare a carico, la colonna % a carico deve essere... >=10 e <= 100
  if Copy(Familiare,4) = 'Altro familiare' then
  begin
    if Carico = 'S' then
    begin
      if (PercACarico < 10) or (PercACarico > 100) then
        raise exception.Create(Familiare + ':' + CRLF +
                               'La percentuale a carico deve essere compresa tra 10,00 e 100,00!');
    end;
  end;
  //Controllare coerenza codice fiscale con data nascita
  try
    Acf:=Copy(CodFiscale,7,2);
    Mcf:=Copy(CodFiscale,9,1);
    Gcf:=Copy(CodFiscale,10,2);
    try
      A:=IfThen(((StrToInt(Acf) > 0) or (Acf = '00')) and (StrToInt(Acf) <= StrToInt(Copy(IntToStr(AnnoDichiarazione),3,2))),StrToInt('20' + Acf),StrToInt('19' + Acf));
    except
    end;
    M:=IfThen(Mcf = 'A',1,IfThen(Mcf = 'B',2,IfThen(Mcf = 'C',3,IfThen(Mcf = 'D',4,IfThen(Mcf = 'E',5,
       IfThen(Mcf = 'H',6,IfThen(Mcf = 'L',7,IfThen(Mcf = 'M',8,IfThen(Mcf = 'P',9,IfThen(Mcf = 'R',10,
       IfThen(Mcf = 'S',11,IfThen(Mcf = 'T',12,0))))))))))));
    try
      G:=IfThen(StrToInt(Gcf) > 40,StrToInt(Gcf) - 40,StrToInt(Gcf));
    except
    end;
    DataNascCodFisc:=EncodeDate(A,M,G);
  except
  begin
    try
      Aex:=IntToStr(StrToInt(Acf));
      Aex:=Format('%4.4d',[A]);
    except
      Aex:='____';
    end;
    try
      Mex:=Format('%2.2d',[M]);
      if Mex = '00' then
        raise exception.Create('');
    except
      Mex:='__';
    end;
    try
      Gex:=IntToStr(StrToInt(Gcf));
      Gex:=Format('%2.2d',[G]);
    except
      Gex:='__';
    end;
    raise exception.Create(Familiare + ':' + CRLF +
                           'Il codice fiscale non è corretto in quanto contiene una data di nascita non valida!' + CRLF +
                           '(Data nascita codice fiscale: ' + Copy(CodFiscale,7,5) + ' = ' + Gex + '/' + Mex + '/' + Aex + ')');
  end;
  end;
  if DataNascCodFisc <> StrToDate(DataNas) then
    raise exception.Create(Familiare + ':' + CRLF +
                           'La data di nascita indicata non corrisponde a quella contenuta nel codice fiscale!' + CRLF +
                           '(Data nascita indicata: ' + DataNas + ')' + CRLF +
                           '(Data nascita codice fiscale: ' + Copy(CodFiscale,7,5) + ' = ' + FormatDateTime('dd/mm/yyyy',DataNascCodFisc) + ')');
  //Controllare esistenza in T480 del comune di nascita in base al codice fiscale.
  with WR000DM.selT480 do
  begin
    Close;
    SetVariable('CODCATASTALE',Copy(CodFiscale,12,4));
    Open;
    //Se non trovato, segnalare di controllare l’esattezza del codice fiscale stesso
    //ed eventualmente contattare l’ufficio Trattamento economico
    if Eof then
      raise exception.Create(Familiare + ':' + CRLF +
                             'Il codice fiscale contiene un comune non valido (Codice catastale: ' + Copy(CodFiscale,12,4) + '). Controllarne la correttezza!' + CRLF +
                             'In caso di codice fiscale corretto, contattare l’ufficio Trattamento economico.');
  end;
  //Controllare che non sia ripetuto su più righe lo stesso codice fiscale
  if Pos(',' + CodFiscale + ',',ElencoCodiciFiscali) > 0 then
    raise exception.Create(Familiare + ':' + CRLF +
                           'Non è possibile inserire lo stesso codice fiscale per più familiari!' + CRLF +
                           '(Codice fiscale: ' + CodFiscale + ')');
  ElencoCodiciFiscali:=ElencoCodiciFiscali + CodFiscale + ',';
  Result:=True;
end;

procedure TW027FDetrazioniIRPEF.ApplicaModifiche;
var i: Integer;
begin
  with WR000DM do
  begin
    selSG120.Edit;
    if not selSG120.FieldByName('DETRAZ_LAVDIP').IsNull then
      selSG120.FieldByName('DETRAZ_LAVDIP').AsString:=IfThen(rgpDetrazioniDipendente.ItemIndex = 0,'S','N');
    if cbxStatoCivile.Visible then
      selSG120.FieldByName('COD_STATOCIVILE').AsString:=Trim(Copy(cbxStatoCivile.Text,1,5));
    selSG120.Post;
    selSG122.First;
    for i:=0 to High(grdDetrazioni.medpCompGriglia) do
    begin
      selSG122.Edit;
      selSG122.FieldByName('COGNOME').AsString:=(grdDetrazioni.medpCompCella(i,1,0) as TmeIWEdit).Text;
      selSG122.FieldByName('NOME').AsString:=(grdDetrazioni.medpCompCella(i,2,0) as TmeIWEdit).Text;
      selSG122.FieldByName('CARICO').AsString:='';
      if (grdDetrazioni.medpCompCella(i,3,0) as TmeIWCheckBox).Checked then
        selSG122.FieldByName('CARICO').AsString:='S'
      else if (grdDetrazioni.medpCompCella(i,3,1) as TmeIWCheckBox).Checked then
        selSG122.FieldByName('CARICO').AsString:='N';
      selSG122.FieldByName('DATA_CARICO_DA').AsString:=(grdDetrazioni.medpCompCella(i,4,0) as TmeIWEdit).Text;
      selSG122.FieldByName('DATA_CARICO_A').AsString:=(grdDetrazioni.medpCompCella(i,5,0) as TmeIWEdit).Text;
      selSG122.FieldByName('PERC_CARICO').AsString:='';
      if selSG122.FieldByName('CARICO').AsString = 'S' then
      begin
        if Copy(selSG122.FieldByName('DESC_TIPO_FAM').AsString,4) = 'Figlio' then
        begin
          if (grdDetrazioni.medpCompCella(i,6,0) as TmeIWCheckBox).Checked then
            selSG122.FieldByName('PERC_CARICO').AsFloat:=StrToFloat('50')
          else if (grdDetrazioni.medpCompCella(i,6,1) as TmeIWCheckBox).Checked then
            selSG122.FieldByName('PERC_CARICO').AsFloat:=StrToFloat('100')
        end
        else if Copy(selSG122.FieldByName('DESC_TIPO_FAM').AsString,4) = 'Altro familiare' then
          selSG122.FieldByName('PERC_CARICO').AsFloat:=StrToFloat((grdDetrazioni.medpCompCella(i,6,0) as TmeIWEdit).Text);
      end;
      selSG122.FieldByName('MANCA_CONIUGE').AsString:='';
      if Copy(selSG122.FieldByName('DESC_TIPO_FAM').AsString,4) = 'Figlio' then
      begin
        if (grdDetrazioni.medpCompCella(i,7,0) as TmeIWCheckBox).Checked then
          selSG122.FieldByName('MANCA_CONIUGE').AsString:='S'
        else if (grdDetrazioni.medpCompCella(i,7,1) as TmeIWCheckBox).Checked then
          selSG122.FieldByName('MANCA_CONIUGE').AsString:='N';
      end;
      selSG122.FieldByName('DETR_FIGLIO_HANDICAP').AsString:='';
      if Copy(selSG122.FieldByName('DESC_TIPO_FAM').AsString,4) = 'Figlio' then
      begin
        if (grdDetrazioni.medpCompCella(i,8,0) as TmeIWCheckBox).Checked then
          selSG122.FieldByName('DETR_FIGLIO_HANDICAP').AsString:='S'
        else if (grdDetrazioni.medpCompCella(i,8,1) as TmeIWCheckBox).Checked then
          selSG122.FieldByName('DETR_FIGLIO_HANDICAP').AsString:='N';
      end;
      selSG122.FieldByName('DATANAS').AsString:=Trim((grdDetrazioni.medpCompCella(i,9,0) as TmeIWEdit).Text + ' ' + (grdDetrazioni.medpCompCella(i,9,1) as TmeIWEdit).Text);
      selSG122.FieldByName('CODFISCALE').AsString:=(grdDetrazioni.medpCompCella(i,10,0) as TmeIWEdit).Text;
      selSG122.Post;
      selSG122.Next;
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TW027FDetrazioniIRPEF.AggiornaFamiliari;
  procedure StoricizzazioneTabella(Decorrenza:TDateTime; Tabella,CondWhere:String);
  var S,CampiIns,CampiSel:String;
  begin
    with WR000DM do
    begin
      selCOLS.Close;
      selCOLS.SetVariable('TABELLA',Tabella);
      selCOLS.Open;
      S:=',';
      while not selCOLS.Eof do
      begin
        S:=S + selCOLS.FieldByName('COLUMN_NAME').AsString + ',';
        selCOLS.Next;
      end;
      CampiIns:=Copy(S,2,Length(S) - 2);
      S:=StringReplace(S,',DECORRENZA,',',TO_DATE(''' + DateToStr(Decorrenza) + ''',''DD/MM/YYYY''),',[rfReplaceAll]);
      CampiSel:=Copy(S,2,Length(S) - 2);
      //
      try
        insStorico.SetVariable('Tabella',Tabella);
        insStorico.SetVariable('CampiIns',CampiIns);
        insStorico.SetVariable('CampiSel',CampiSel);
        insStorico.SetVariable('Decorrenza',Decorrenza);
        insStorico.SetVariable('CondWhere',CondWhere);
        insStorico.Execute;
      except
      end;
    end;
  end;
  procedure AppiattimentoPeriodiTabella(Tabella,CondWhere,OrderBy:String);
  var S,NRowidUpdate,ValoreDatiOld:String;
      UltimaDFine:TDateTime;
  begin
    with WR000DM do
    begin
      selCOLS.Close;
      selCOLS.SetVariable('TABELLA',Tabella);
      selCOLS.Open;
      S:='';
      while not selCOLS.Eof do
      begin
        if (selCOLS.FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA')
        and (selCOLS.FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA_FINE') then
          S:=S + selCOLS.FieldByName('COLUMN_NAME').AsString + '||';
        selCOLS.Next;
      end;
      S:=Copy(S,1,Length(S) - 2);
      //
      NRowidUpdate:='';
      ValoreDatiOld:='';
      selStorici.Close;
      selStorici.SetVariable('CampiSel',S);
      selStorici.SetVariable('Tabella',Tabella);
      selStorici.SetVariable('CondWhere',CondWhere);
      selStorici.SetVariable('OrderBy',OrderBy);
      selStorici.Open;
      while not selStorici.Eof do
      begin
        if selStorici.FieldByName('ValoreDati').AsString = ValoreDatiOld then
        begin
          UltimaDFine:=selStorici.FieldByName('Decorrenza_Fine').AsDateTime;
          selStorici.Delete;
          selStorici.SearchRecord('ROWID',NRowidUpdate,[srFromBeginning]);
          selStorici.Edit;
          selStorici.FieldByName('Decorrenza_Fine').AsDateTime:=UltimaDFine;
          selStorici.Post;
        end
        else
        begin
          ValoreDatiOld:=selStorici.FieldByName('ValoreDati').AsString;
          NRowidUpdate:=selStorici.Rowid;
        end;
        selStorici.Next;
      end;
    end;
  end;
var
  MaxNumOrd,GGNas: Integer;
  CondSet: String;
begin
  with WR000DM do
  begin
    //Impostare SG120.CONFERMA=S
    selSG120.Edit;
    selSG120.FieldByName('CONFERMA').AsString:='S';
    selSG120.Post;
    //Impostare P430.DETRAZ_LAVDIP=SG120.DETRAZ_LAVDIP se quest’ultimo non è nullo, con decorrenza 01/01/Anno (o prima decorrenza nell’Anno per i nuovi assunti) e per tutti gli eventuali periodi successivi
    if selSG120.FieldByName('DETRAZ_LAVDIP').AsString <> '' then
    begin
      StoricizzazioneTabella(EncodeDate(AnnoDichiarazione,1,1),
                             'P430_ANAGRAFICO',
                             'progressivo = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
      updP430.SetVariable('CondSet','DETRAZ_LAVDIP = ''' + selSG120.FieldByName('DETRAZ_LAVDIP').AsString + '''');
      updP430.SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      updP430.SetVariable('Decorrenza',EncodeDate(AnnoDichiarazione,1,1));
      updP430.Execute;
    end;
    //Impostare P430.COD_STATOCIVILE=SG120.COD_STATOCIVILE se quest’ultimo non è nullo, con decorrenza 01/01/Anno (o prima decorrenza nell’Anno per i nuovi assunti) e per tutti gli eventuali periodi successivi
    if selSG120.FieldByName('COD_STATOCIVILE').AsString <> '' then
    begin
      StoricizzazioneTabella(EncodeDate(AnnoDichiarazione,1,1),
                             'P430_ANAGRAFICO',
                             'progressivo = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
      updP430.SetVariable('CondSet','COD_STATOCIVILE = ''' + selSG120.FieldByName('COD_STATOCIVILE').AsString + '''');
      updP430.SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      updP430.SetVariable('Decorrenza',EncodeDate(AnnoDichiarazione,1,1));
      updP430.Execute;
    end;
    //Se previsto coniuge (SG122.COGNOME significativo) e SG122.NUMORD=-1,
    //impostare SG122.NUMORD se familiare esiste su SG101 con stesso codice fiscale e grado parentela
    selSG122.First;
    if (selSG122.FieldByName('COGNOME').AsString <> '')
    and (selSG122.FieldByName('NUMORD').AsInteger = -1) then
    begin
      updSG122.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      updSG122.SetVariable('DATA_AGG',DataAgg);
      updSG122.Execute;
      SessioneOracle.Commit;
      selSG122.Close;
      selSG122.Open;
    end;
    //Porre non a carico tutti gli eventuali familiari di SG101 non presenti nella griglia dal 01/01/Anno
    //(sono quelli che hanno SG101.NUMORD non presente in SG122)
    selaSG101.Close;
    selaSG101.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selaSG101.SetVariable('DATA_AGG',DataAgg);
    selaSG101.Open;
    while not selaSG101.Eof do
    begin
      StoricizzazioneTabella(EncodeDate(AnnoDichiarazione,1,1),
                             'SG101_FAMILIARI',
                             'progressivo = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selaSG101.FieldByName('NUMORD').AsString);
      updSG101.SetVariable('CondSet','TIPO_DETRAZIONE = ''ND'', PERC_CARICO = 0');
      updSG101.SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      updSG101.SetVariable('NumOrd',IntToStr(selaSG101.FieldByName('NUMORD').AsInteger));
      updSG101.SetVariable('Decorrenza',EncodeDate(AnnoDichiarazione,1,1));
      updSG101.Execute;
      selaSG101.Next;
    end;
    //Eseguire un primo ciclo per creare gli eventuali nuovi familiari:
    //sono quelli con SG122.COGNOME significativo e SG122.NUMORD=-1.
    //Si imposta, su SG101, NUMORD ad un nuovo valore, DECORRENZA=SG122.DATA_CARICO_DA,
    //COGNOME=SG122.COGNOME, NOME=SG122.NOME, SG101.GRADOPAR (per gli altri familiari è AL).
    //Impostare SG122.NUMORD al nuovo SG101.NUMORD creato
    MaxNumOrd:=1;
    selbSG101.Close;
    selbSG101.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selbSG101.Open;
    if selbSG101.FieldByName('NUMORD').AsString <> '' then
      MaxNumOrd:=selbSG101.FieldByName('NUMORD').AsInteger + 1;
    selSG122.First;
    while not selSG122.Eof do
    begin
      if (selSG122.FieldByName('COGNOME').AsString <> '')
      and (selSG122.FieldByName('NUMORD').AsInteger = -1) then
      begin
        insSG101.SetVariable('PROGRESSIVO',selSG122.FieldByName('PROGRESSIVO').AsInteger);
        insSG101.SetVariable('NUMORD',MaxNumOrd);
        insSG101.SetVariable('DECORRENZA',EncodeDate(AnnoDichiarazione,1,1));
        insSG101.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31));
        insSG101.SetVariable('COGNOME',selSG122.FieldByName('COGNOME').AsString);
        insSG101.SetVariable('NOME',selSG122.FieldByName('NOME').AsString);
        insSG101.SetVariable('GRADOPAR',IfThen(Copy(selSG122.FieldByName('TIPO_FAM').AsString,1,2) = 'FG','FG',
                                        IfThen(Copy(selSG122.FieldByName('TIPO_FAM').AsString,1,2) = 'AL','AL','CG')));
        insSG101.SetVariable('DATANAS_PRESUNTA',selSG122.FieldByName('DATANAS').AsDateTime);
        insSG101.Execute;
        selSG122.Edit;
        selSG122.FieldByName('NUMORD').AsInteger:=MaxNumOrd;
        selSG122.Post;
        MaxNumOrd:=MaxNumOrd + 1;
      end;
      selSG122.Next;
    end;
    //Eseguire un secondo ciclo scorrendo tutti i familiari dichiarati (sono quelli con SG122.NUMORD<>-1) ed effettuare:
    selSG122.First;
    while not selSG122.Eof do
    begin
      if selSG122.FieldByName('NUMORD').AsInteger <> -1 then
      begin
        //Aggiornare, su tutti i periodi storici, SG101.COGNOME, SG101.NOME, SG101.DATANAS, SG101.CODFISCALE
        //Impostare, su tutti i periodi storici, SG101.SESSO e SG101.COMNAS in base a SG101.CODFISCALE
        //Per i familiari non figli impostare, su tutti i periodi storici, SG101.DETR_FIGLIO_HANDICAP=N
        GGNas:=StrToInt(Copy(selSG122.FieldByName('CODFISCALE').AsString,10,2));
        selT480.Close;
        selT480.SetVariable('CODCATASTALE',Copy(selSG122.FieldByName('CODFISCALE').AsString,12,4));
        selT480.Open;
        updSG101.SetVariable('CondSet','COGNOME = ''' + StringReplace(selSG122.FieldByName('COGNOME').AsString,'''','''''',[rfReplaceAll]) + ''', ' +
                                       'NOME = ''' + StringReplace(selSG122.FieldByName('NOME').AsString,'''','''''',[rfReplaceAll]) + ''', ' +
                                       'DATANAS = TO_DATE(''' + FormatDateTime('dd/mm/yyyy hh.nn',selSG122.FieldByName('DATANAS').AsDateTime) + ''',''DD/MM/YYYY HH24.MI''), ' +
                                       'CODFISCALE = ''' + selSG122.FieldByName('CODFISCALE').AsString + ''', ' +
                                       'SESSO = ''' + IfThen(GGNas < 40,'M','F') + ''', ' +
                                       'COMNAS = ''' + selT480.FieldByName('CODICE').AsString + ''', ' +
                                       'DETR_FIGLIO_HANDICAP = DECODE(GRADOPAR,''FG'',DETR_FIGLIO_HANDICAP,''N'')');
        updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
        updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
        updSG101.SetVariable('Decorrenza',EncodeDate(1900,1,1));
        updSG101.Execute;
        //Per i figli, impostare SG101.DETR_FIGLIO_HANDICAP=SG122.DETR_FIGLIO_HANDICAP
        //con decorrenza SG122.DATA_CARICO_DA e per tutti gli eventuali periodi successivi
        if Copy(selSG122.FieldByName('TIPO_FAM').AsString,1,2) = 'FG' then
        begin
          StoricizzazioneTabella(selSG122.FieldByName('DATA_CARICO_DA').AsDateTime,
                                 'SG101_FAMILIARI',
                                 'progressivo = ' + selSG122.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selSG122.FieldByName('NUMORD').AsString);
          updSG101.SetVariable('CondSet','DETR_FIGLIO_HANDICAP = ''' + selSG122.FieldByName('DETR_FIGLIO_HANDICAP').AsString + '''');
          updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
          updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
          updSG101.SetVariable('Decorrenza',selSG122.FieldByName('DATA_CARICO_DA').AsDateTime);
          updSG101.Execute;
        end;
        //Se il familiare non è a carico, porlo in tale situazione da inizio anno
        //e per tutti gli eventuali periodi successivi. Passare al familiare successivo
        if selSG122.FieldByName('CARICO').AsString = 'N' then
        begin
          StoricizzazioneTabella(EncodeDate(AnnoDichiarazione,1,1),
                                 'SG101_FAMILIARI',
                                 'progressivo = ' + selSG122.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selSG122.FieldByName('NUMORD').AsString);
          updSG101.SetVariable('CondSet','TIPO_DETRAZIONE = ''ND'', PERC_CARICO = 0');
          updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
          updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
          updSG101.SetVariable('Decorrenza',EncodeDate(AnnoDichiarazione,1,1));
          updSG101.Execute;
          //
          selSG122.Next;
          Continue;
        end;
        //Se SG122.DATA_CARICO_DA>01/01/Anno porre il familiare in situazione di non carico
        //da 01/01/Anno fino a SG122.DATA_CARICO_DA - 1.
        if selSG122.FieldByName('DATA_CARICO_DA').AsDateTime > EncodeDate(AnnoDichiarazione,1,1) then
        begin
          StoricizzazioneTabella(EncodeDate(AnnoDichiarazione,1,1),
                                 'SG101_FAMILIARI',
                                 'progressivo = ' + selSG122.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selSG122.FieldByName('NUMORD').AsString);
          updSG101.SetVariable('CondSet','TIPO_DETRAZIONE = ''ND'', PERC_CARICO = 0');
          updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
          updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
          updSG101.SetVariable('Decorrenza',EncodeDate(AnnoDichiarazione,1,1));
          updSG101.Execute;
        end;
        //Porre il familiare in situazione di carico da SG122.DATA_CARICO_DA e per tutti gli eventuali periodi successivi
        if selSG122.FieldByName('TIPO_FAM').AsString = 'CG' then
          CondSet:='TIPO_DETRAZIONE = ''DC'', PERC_CARICO = 100'
        else if Copy(selSG122.FieldByName('TIPO_FAM').AsString,1,2) = 'FG' then
          CondSet:='TIPO_DETRAZIONE = ''' + IfThen(selSG122.FieldByName('MANCA_CONIUGE').AsString = 'S','DC','DF') + ''', PERC_CARICO = ' + StringReplace(FloatToStr(selSG122.FieldByName('PERC_CARICO').AsFloat),',','.',[rfReplaceAll])
        else
          CondSet:='TIPO_DETRAZIONE = ''DA'', PERC_CARICO = ' + StringReplace(FloatToStr(selSG122.FieldByName('PERC_CARICO').AsFloat),',','.',[rfReplaceAll]);
        StoricizzazioneTabella(selSG122.FieldByName('DATA_CARICO_DA').AsDateTime,
                               'SG101_FAMILIARI',
                               'progressivo = ' + selSG122.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selSG122.FieldByName('NUMORD').AsString);
        updSG101.SetVariable('CondSet',CondSet);
        updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
        updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
        updSG101.SetVariable('Decorrenza',selSG122.FieldByName('DATA_CARICO_DA').AsDateTime);
        updSG101.Execute;
        //Se SG122.DATA_CARICO_A<31/12/Anno porre il familiare in situazione di non carico
        //da SG122.DATA_CARICO_A + 1 e per tutti gli eventuali periodi successivi
        if selSG122.FieldByName('DATA_CARICO_A').AsDateTime < EncodeDate(AnnoDichiarazione,12,31) then
        begin
          StoricizzazioneTabella(selSG122.FieldByName('DATA_CARICO_A').AsDateTime + 1,
                                 'SG101_FAMILIARI',
                                 'progressivo = ' + selSG122.FieldByName('PROGRESSIVO').AsString + ' and numord = ' + selSG122.FieldByName('NUMORD').AsString);
          updSG101.SetVariable('CondSet','TIPO_DETRAZIONE = ''ND'', PERC_CARICO = 0');
          updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
          updSG101.SetVariable('NumOrd',IntToStr(selSG122.FieldByName('NUMORD').AsInteger));
          updSG101.SetVariable('Decorrenza',selSG122.FieldByName('DATA_CARICO_A').AsDateTime + 1);
          updSG101.Execute;
        end;
      end;
      selSG122.Next;
    end;
    //Al termine, appiattire i periodi storici di SG101 e P430 del progressivo interessato
    AppiattimentoPeriodiTabella('P430_ANAGRAFICO','progressivo = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString,'decorrenza');
    AppiattimentoPeriodiTabella('SG101_FAMILIARI','progressivo = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString,'numord,decorrenza');
    //Impostare SG101.DATA_ULT_FAM_CAR= SG120.DATA_AGG (gg/mm/aaaa) su tutti i periodi storici e su tutti i familiari
    updSG101.SetVariable('CondSet','DATA_ULT_FAM_CAR = TO_DATE(''' + FormatDateTime('dd/mm/yyyy',DataAgg) + ''',''DD/MM/YYYY'')');
    updSG101.SetVariable('Progressivo',selSG122.FieldByName('PROGRESSIVO').AsInteger);
    updSG101.SetVariable('NumOrd','NUMORD');
    updSG101.SetVariable('Decorrenza',EncodeDate(1900,1,1));
    updSG101.Execute;
  end;
  SessioneOracle.Commit;
end;

procedure TW027FDetrazioniIRPEF.btnAnnullaClick(Sender: TObject);
begin
  exit;//DA 21/02/2013
  ClosePage;
end;

procedure TW027FDetrazioniIRPEF.btnRipristinaClick(Sender: TObject);
var i: Integer;
begin
  exit;//DA 21/02/2013
  grdDetrazioni.medpInizializzaCompGriglia;
  grdDetrazioni.medpCaricaCDS;
  for i:=0 to High(grdDetrazioni.medpCompGriglia) do
    CreaComponentiRiga(grdDetrazioni.medpCompGriglia[i].RowID);
  MsgBox.MessageBox('Valori iniziali ripristinati!',INFORMA);
end;

procedure TW027FDetrazioniIRPEF.IWAppFormRender(Sender: TObject);
begin
  inherited;
  btnConferma.Enabled:=not SolaLettura;
  btnAnnulla.Enabled:=btnConferma.Enabled;
  btnRipristina.Enabled:=btnConferma.Enabled;
end;

procedure TW027FDetrazioniIRPEF.lnkIstrDetrClick(Sender: TObject);
var URLDoc:String;
begin
  URLDoc:=ExtractFileName(FileIstruzioni);
  VisualizzaFile(URLDoc,'Istruzioni detrazioni IRPEF',nil,nil,fdGlobal);
end;

procedure TW027FDetrazioniIRPEF.ProceduraOK;
begin
  btnAnnullaClick(nil);
end;

procedure TW027FDetrazioniIRPEF.DistruggiOggetti;
begin
  //deallocazione controlli della griglia
  grdDetrazioni.medpClearCompGriglia;

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selSG122.CloseAll; except end;
    //DA 21/02/2013 R180CloseDataSetTag0(WR000DM.selP500);
  end;
end;

end.

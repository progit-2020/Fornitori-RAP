unit W029UPesatureIndividuali;

interface

uses
  Classes,Graphics,Controls,SysUtils,
  R010UPaginaWeb, R012UWebAnagrafico, IWTemplateProcessorHTML,
  IWControl, IWHTMLControls, IWCompEdit, IWCompButton, IWApplication,
  OracleData,A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWCompListbox, Variants, IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl,Forms,IWVCLComponent,
  Math,StrUtils,Oracle,DB, meIWEdit,
  ActnList,Menus,IWCompMenu,IWDBGrids,medpIWDBGrid,DBClient,
  WC002UDatiAnagraficiFM, A169UCalcoloDtM, meIWLabel, meIWButton, meIWComboBox, meIWGrid,
  IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLink, IWCompLabel;

type
  TDipendenti = record
    Progressivo:String;
    Matricola:String;
    Cognome:String;
    Nome:String;
    Text:String;
  end;

  TRecordChiamata = record
    Operazione:String;
    Data:TDateTime;
    Operatore:String;
    ProgReper:Integer;
    Esito:String;
    Note:String;
  end;

  TW029FPesatureIndividuali = class(TR012FWebAnagrafico)
    dsrT774: TDataSource;
    cdsT774: TClientDataSet;
    grdPesiDip: TmedpIWDBGrid;
    selT774: TOracleDataSet;
    selT773: TOracleDataSet;
    selT773B: TOracleDataSet;
    lblNumDip: TmeIWLabel;
    lblGruppo: TmeIWLabel;
    lblQuota: TmeIWLabel;
    lblAnno: TmeIWLabel;
    btnModifica: TmeIWButton;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    cmbGruppo: TmeIWComboBox;
    cmbQuota: TmeIWComboBox;
    cmbAnno: TmeIWComboBox;
    grdRiepilogo: TmeIWGrid;
    procedure IWAppFormCreate(Sender:TObject);
    procedure grdPesiDipRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
    procedure selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure grdPesiDipAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure cmbGruppoChange(Sender: TObject);
    procedure cmbQuotaChange(Sender: TObject);
    procedure cmbAnnoChange(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    RecordChiamata:TRecordChiamata;
    ArrDipendenti: array of TDipendenti;
    WC002FDatiAnagraficiFM: TWC002FDatiAnagraficiFM;
    Anom:Boolean;
    A169FCalcoloDtM: TA169FCalcoloDtM;
    procedure TrasformaComponenti(FN:String);
    function ModificheRiga(FN:String):Boolean;
    procedure actVariazioneOK;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure CreaComponentiGriglia;
    procedure imgSchedaAnagraficaClick(Sender:TObject);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure GetGruppi;
    procedure GetPesiDip;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

function TW029FPesatureIndividuali.InizializzaAccesso:Boolean;
begin
  Result:=True;
  R180SetVariable(selT774,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT774,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT774,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT774.Open;
  R180SetVariable(selT773B,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT773B,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT773B,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT773B.Open;
  grdRiepilogo.RowCount:=2;
  grdRiepilogo.ColumnCount:=8;
  grdRiepilogo.Cell[0,0].Text:='Min.peso indiv.';
  grdRiepilogo.Cell[0,1].Text:='Max.peso indiv.';
  grdRiepilogo.Cell[0,2].Text:='Peso totale';
  grdRiepilogo.Cell[0,3].Text:='Quota totale';
  grdRiepilogo.Cell[0,4].Text:='Tot.pesi base';
  grdRiepilogo.Cell[0,5].Text:='Tot.quote ass.';
  grdRiepilogo.Cell[0,6].Text:='Tot.pesi calc.';
  grdRiepilogo.Cell[0,7].Text:='Tot.quote calc.';
  grdRiepilogo.Cell[1,0].Text:=selT773B.FieldByName('PESO_IND_MIN').AsString;
  grdRiepilogo.Cell[1,1].Text:=selT773B.FieldByName('PESO_IND_MAX').AsString;
  grdRiepilogo.Cell[1,2].Text:=selT773B.FieldByName('PESO_TOTALE').AsString;
  grdRiepilogo.Cell[1,3].Text:=Format('%-15.2n',[selT773B.FieldByName('QUOTA_TOTALE').AsFloat]);
  A169FCalcoloDtM.AggiornaTotali(selT773B.FieldByName('ANNO').AsInteger,selT773B.FieldByName('CODGRUPPO').AsString,selT773B.FieldByName('CODTIPOQUOTA').AsString);
  grdRiepilogo.Cell[1,4].Text:=FloatToStr(A169FCalcoloDtM.TotalePesi);
  grdRiepilogo.Cell[1,5].Text:=Format('%-15.2n',[A169FCalcoloDtM.TotaleQuote]);
  grdRiepilogo.Cell[1,6].Text:=FloatToStr(A169FCalcoloDtM.TotalePesiCalc);
  grdRiepilogo.Cell[1,7].Text:=Format('%-15.2n',[A169FCalcoloDtM.TotaleQuoteCalc]);
  lblNumDip.Caption:='';
  if A169FCalcoloDtM.TotDip <> grdPesiDip.medpDataSet.RecordCount then
    lblNumDip.Caption:='Dipendenti del gruppo: ' + FloatToStr(A169FCalcoloDtM.TotDip) + ' - Dipendenti visualizzati: ' + IntToStr(grdPesiDip.medpDataSet.RecordCount);
  Anom:=False;
  if (selT773B.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDtM.TotalePesi > selT773B.FieldByName('PESO_TOTALE').AsFloat) then
  begin
    Anom:=True;
    GGetWebApplicationThreadVar.ShowMessage('Attenzione: totale pesi base superiore al peso totale previsto!');
    Exit;
  end;
//  if btnModifica.Visible then
//  begin
    if (selT773B.FieldByName('PESO_TOTALE').AsFloat <> 0) and
       (A169FCalcoloDtM.TotalePesiCalc > selT773B.FieldByName('PESO_TOTALE').AsFloat) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Attenzione: totale pesi calcolati superiore al peso totale previsto!');
      Exit;
    end;
    if (selT773B.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
       (A169FCalcoloDtM.TotaleQuote > selT773B.FieldByName('QUOTA_TOTALE').AsFloat) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Attenzione: totale quote assegnate superiore alla quota totale prevista!');
      Exit;
    end;
    if (selT773B.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
       (A169FCalcoloDtM.TotaleQuoteCalc > selT773B.FieldByName('QUOTA_TOTALE').AsFloat) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Attenzione: totale quote calcolate superiore alla quota totale prevista!');
      Exit;
    end;
//  end;
end;

procedure TW029FPesatureIndividuali.IWAppFormCreate(Sender:TObject);
var i:Integer;
    FiltroRicerca:String;
begin
  inherited;
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneOracle; except end
    else if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneOracle; except end;
  end;

  A169FCalcoloDtM:=TA169FCalcoloDtM.Create(Self);
  FiltroRicerca:=WR000DM.FiltroRicerca;
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATALAVORO','T774.DATAFINE',[rfReplaceAll,rfIgnoreCase]);
  FiltroRicerca:=StringReplace(FiltroRicerca,':DATADAL','T774.DATAFINE',[rfReplaceAll,rfIgnoreCase]);
  selT774.SetVariable('FILTRORICERCA',FiltroRicerca);
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  GetGruppi;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdPesiDip.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdPesiDip.medpEditMultiplo:=True;
  grdPesiDip.medpDataSet:=selT774;
  selT774.Tag:=selT774.Tag + 1;
  WC002FDatiAnagraficiFM:=nil;
end;

procedure TW029FPesatureIndividuali.GetGruppi;
begin
  selT773.Close;
  selT773.SetVariable('DATI','T773.ANNO');
  selT773.Open;
  cmbAnno.Items.Clear;
  while not selT773.Eof do
  begin
    cmbAnno.Items.Add(selT773.FieldByName('ANNO').AsString);
    selT773.Next;
  end;
  cmbAnno.ItemIndex:=R180IndexOf(cmbAnno.Items,Copy(DateToStr(Parametri.DataLavoro),7,4),4);
  selT773.Close;
  selT773.SetVariable('DATI','T773.CODGRUPPO, T773.DESCRIZIONE');
  selT773.Open;
  selT773.Filtered:=True;
  cmbGruppo.Items.Clear;
  while not selT773.Eof do
  begin
    cmbGruppo.Items.Add(Format('%-10s',[selT773.FieldByName('CODGRUPPO').AsString]) + ' ' +
      selT773.FieldByName('DESCRIZIONE').AsString);
    selT773.Next;
  end;
  selT773.Filtered:=False;
  selT773.Close;
  selT773.SetVariable('DATI','T773.CODTIPOQUOTA, T765.DESCRIZIONE');
  selT773.Open;
  cmbQuota.Items.Clear;
  while not selT773.Eof do
  begin
    cmbQuota.Items.Add(Format('%-5s',[selT773.FieldByName('CODTIPOQUOTA').AsString]) + ' ' +
      selT773.FieldByName('DESCRIZIONE').AsString);
    selT773.Next;
  end;
  selT773.Close;
end;

procedure TW029FPesatureIndividuali.RefreshPage;
begin
  GetPesiDip;
  InizializzaAccesso;
end;

procedure TW029FPesatureIndividuali.btnAnnullaClick(Sender: TObject);
begin
  inherited;
  // Annulla: annulla le modifiche apportate nei componenti editabili
  btnModifica.Visible:=(not SolaLettura) and (selT773B.FieldByName('CHIUSO').AsString <> 'S');
  btnConferma.Visible:=False;
  btnAnnulla.Visible:=False;
  cmbAnno.Enabled:=True;
  cmbQuota.Enabled:=True;
  cmbGruppo.Enabled:=True;
  RecordChiamata.Operazione:='';
  TrasformaComponenti('');
  InizializzaAccesso;
  grdPesiDip.medpBrowse:=True;
end;

procedure TW029FPesatureIndividuali.btnConfermaClick(Sender: TObject);
begin
  inherited;
  // modifica - applicazione modifiche
  if (RecordChiamata.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga('') then
    begin
      btnAnnullaClick(Sender);
      Exit;
    end;
    Anom:=False;
    actVariazioneOK;
    // rilegge i dati
    if not Anom then
      InizializzaAccesso;
    if not Anom then
    begin
      SessioneOracle.Commit;
      btnModifica.Visible:=(not SolaLettura) and (selT773B.FieldByName('CHIUSO').AsString <> 'S');
      btnConferma.Visible:=False;
      btnAnnulla.Visible:=False;
      cmbAnno.Enabled:=True;
      cmbQuota.Enabled:=True;
      cmbGruppo.Enabled:=True;
      RecordChiamata.Operazione:='';
      grdPesiDip.medpBrowse:=True;
      GetPesiDip;
    end
    else
      SessioneOracle.Rollback;
  end;
end;

procedure TW029FPesatureIndividuali.btnModificaClick(Sender: TObject);
begin
  inherited;
  // modifica - applicazione modifiche
  if (RecordChiamata.Operazione = 'I') or (RecordChiamata.Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(RecordChiamata.Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  btnModifica.Visible:=False;
  btnConferma.Visible:=True;
  btnAnnulla.Visible:=True;
  cmbAnno.Enabled:=False;
  cmbQuota.Enabled:=False;
  cmbGruppo.Enabled:=False;
  // porta le righe in modifica: trasforma i componenti
  RecordChiamata.Operazione:='M';
  TrasformaComponenti('');
  grdPesiDip.medpBrowse:=False;
end;

procedure TW029FPesatureIndividuali.GetPesiDip;
// caricamento array delle chiamate nel periodo indicato
begin
  R180SetVariable(selT774,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT774,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT774,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT774.Open;
  R180SetVariable(selT773B,'ANNO',StrToIntDef(cmbAnno.Text,0));
  R180SetVariable(selT773B,'GRUPPO',TrimRight(Copy(cmbGruppo.Text,1,10)));
  R180SetVariable(selT773B,'QUOTA',TrimRight(Copy(cmbQuota.Text,1,5)));
  selT773B.Open;

  btnModifica.Visible:=(not SolaLettura) and (selT773B.FieldByName('CHIUSO').AsString <> 'S');
  grdPesiDip.medpCreaCDS;
  grdPesiDip.medpEliminaColonne;
  grdPesiDip.medpAggiungiColonna('DIPENDENTE','Dipendente','',nil);
  grdPesiDip.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdPesiDip.medpAggiungiColonna('DATAINIZIO','Inizio','',nil);
  grdPesiDip.medpAggiungiColonna('DATAFINE','Fine','',nil);
  grdPesiDip.medpAggiungiColonna('GG_SERVIZIO','GG.Serv.','',nil);
  grdPesiDip.medpAggiungiColonna('OBIETTIVI_ASSEGNATI','O.A.','',nil);
  grdPesiDip.medpAggiungiColonna('PESO_INDIVIDUALE','Peso base','',nil);
  grdPesiDip.medpAggiungiColonna('QUOTA_INDIVIDUALE','Quota base','',nil);
  grdPesiDip.medpAggiungiColonna('QUOTA_ASSEGNATA','Quota ass.','',nil);
  grdPesiDip.medpAggiungiColonna('PESO_CALCOLATO','Peso calc.','',nil);
  grdPesiDip.medpAggiungiColonna('QUOTA_CALCOLATA','Quota calc.','',nil);
  grdPesiDip.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdPesiDip.medpInizializzaCompGriglia;
  grdPesiDip.medpPreparaComponenteGenerico('R',1,0,DBG_IMG,'','SCHANAGR','null','');
  grdPesiDip.medpCaricaCDS;
end;

procedure TW029FPesatureIndividuali.cmbAnnoChange(Sender: TObject);
begin
  inherited;
  GetPesiDip;
  InizializzaAccesso;
end;

procedure TW029FPesatureIndividuali.cmbGruppoChange(Sender: TObject);
begin
  inherited;
  GetPesiDip;
  InizializzaAccesso;
end;

procedure TW029FPesatureIndividuali.cmbQuotaChange(Sender: TObject);
begin
  inherited;
  GetPesiDip;
  InizializzaAccesso;
end;

procedure TW029FPesatureIndividuali.imgSchedaAnagraficaClick(Sender:TObject);
var Matr:String;
begin
  Matr:=VarToStr(cdsT774.Lookup('DBG_ROWID',(Sender as TmeIWImageFile).FriendlyName,'DIPENDENTE'));
  Matr:=Trim(Copy(Matr,Pos('(',Matr)+1,Pos(')',Matr)-Pos('(',Matr)-1));
  if Matr <> '' then
  begin
    WC002FDatiAnagraficiFM:=TWC002FDatiAnagraficiFM.Create(Self);
    WC002FDatiAnagraficiFM.ParMatricola:=Matr;
    WC002FDatiAnagraficiFM.VisualizzaScheda;
  end;
end;

procedure TW029FPesatureIndividuali.CreaComponentiGriglia;
var i:Integer;
begin
  //Peso base
  for i:=0 to High(grdPesiDip.medpCompGriglia) do
  begin
    grdPesiDip.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'5','','','','S');
    grdPesiDip.medpCreaComponenteGenerico(i,6,grdPesiDip.Componenti);
    (grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text:='';
  end;
end;

procedure TW029FPesatureIndividuali.TrasformaComponenti(FN:String);
var
  DaTestoAControlli:Boolean;
  i:Integer;
begin
  // pre: not SolaLettura
  DaTestoAControlli:=grdPesiDip.medpCompGriglia[0].CompColonne[6] = nil;
  if DaTestoAControlli then
  begin
    CreaComponentiGriglia;
    for i:=0 to High(grdPesiDip.medpCompGriglia) do
      (grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text:=grdPesiDip.medpValoreColonna(i,'PESO_INDIVIDUALE');
  end
  else
  begin
    // Annullamento componenti
    if grdPesiDip.medpCompGriglia[0].CompColonne[6] <> nil then
    begin
      for i:=0 to High(grdPesiDip.medpCompGriglia) do
      begin
        FreeAndNil(grdPesiDip.medpCompGriglia[i].CompColonne[6]);
      end;
    end;
  end;
end;

function TW029FPesatureIndividuali.ModificheRiga(FN:String):Boolean;
{ Restituisce True/False a seconda che il record sia stato modificato o meno }
var i:Integer;
begin
  Result:=False;
  cdsT774.First;
  i:=0;
  while not cdsT774.Eof do
  begin
    if cdsT774.FieldByName('PESO_INDIVIDUALE').AsString <> (grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text then
    begin
      Result:=True;
      Break;
    end;
    cdsT774.Next;
    i:=i+1;
  end;
end;

procedure TW029FPesatureIndividuali.actVariazioneOK;
// controlli ok -> variazione record di pianificazione
var i:Integer;
begin
  cdsT774.First;
  i:=0;
  while not cdsT774.Eof do
  begin
    if cdsT774.FieldByName('PESO_INDIVIDUALE').AsString <> (grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text then
    begin
      if (cdsT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat > 0) and
        (StrToFloatDef((grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text,0) < selT773B.FieldByName('PESO_IND_MIN').AsFloat) then
      begin
        Anom:=True;
        GGetWebApplicationThreadVar.ShowMessage('Peso inferiore al minimo individuale previsto!');
        Exit;
      end;
      if (selT773B.FieldByName('PESO_IND_MAX').AsFloat <> 0) and
         (StrToFloatDef((grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text,0) > selT773B.FieldByName('PESO_IND_MAX').AsFloat) then
      begin
        Anom:=True;
        GGetWebApplicationThreadVar.ShowMessage('Peso superiore al massimo individuale previsto!');
        Exit;
      end;
    end;
    cdsT774.Next;
    i:=i+1;
  end;
  if Anom then
    Exit;
  cdsT774.First;
  selT774.Refresh;
  i:=0;
  while not cdsT774.Eof do
  begin
    if cdsT774.FieldByName('PESO_INDIVIDUALE').AsString <> (grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text then
    begin
      if selT774.SearchRecord('PROGRESSIVO',cdsT774.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      begin
        selT774.Edit;
        selT774.FieldByName('PESO_INDIVIDUALE').AsFloat:=StrToFloatDef((grdPesiDip.medpCompCella(i,6,0) as TmeIWEdit).Text,0);
        A169FCalcoloDtM.CalcolaQuota('C',selT774.FieldByName('CODTIPOQUOTA').AsString,selT774.FieldByName('PROGRESSIVO').AsInteger,selT774.FieldByName('ANNO').AsInteger,
          selT774.FieldByName('GG_SERVIZIO').AsFloat,selT774.FieldByName('PESO_INDIVIDUALE').AsFloat);
        selT774.FieldByName('PESO_CALCOLATO').AsFloat:=A169FCalcoloDtM.PesoCalcolato;
        selT774.FieldByName('QUOTA_CALCOLATA').AsFloat:=A169FCalcoloDtM.QuotaCalcolata;
        selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat:=R180Arrotonda(selT774.FieldByName('PESO_INDIVIDUALE').AsFloat *
          selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat,0.01,'P');
        selT774.FieldByName('OBIETTIVI_ASSEGNATI').AsString:='S';
        try
          RegistraLog.SettaProprieta('M','T774_PESATUREINDIVIDUALI',medpCodiceForm,nil,True);
          selT774.Post;
          RegistraLog.RegistraOperazione;
        except
          on E:Exception do
            GGetWebApplicationThreadVar.ShowMessage('Variazione della chiamata fallita!' + CRLF + 'Motivo: ' + E.Message);
        end;
      end;
    end;
    cdsT774.Next;
    i:=i + 1;
  end;
end;

procedure TW029FPesatureIndividuali.grdPesiDipAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
begin
  for i:=0 to High(grdPesiDip.medpCompGriglia) do
  begin
    (grdPesiDip.medpCompCella(i,1,0) as TmeIWImageFile).OnClick:=imgSchedaAnagraficaClick;
  end;
end;

procedure TW029FPesatureIndividuali.grdPesiDipRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // assegnazione stili
  if (ARow > 0) and (AColumn = 5) and (ACell.Text = 'N') then  //evidenzio O.A. = 'N'
    ACell.Css:=ACell.Css + ' font_grassetto font_rosso';

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdPesiDip.medpCompGriglia) + 1) and (grdPesiDip.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdPesiDip.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TW029FPesatureIndividuali.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0) and (AColumn in [4,5,6,7]) then
    ACell.Css:='riga_colorata';

  // assegnazione stili
  if (ARow > 0) and (AColumn = 4) and (selT773B.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDtM.TotalePesi > selT773B.FieldByName('PESO_TOTALE').AsFloat) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
  if (ARow > 0) and (AColumn = 5) and (selT773B.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDtM.TotaleQuote > selT773B.FieldByName('QUOTA_TOTALE').AsFloat) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
  if (ARow > 0) and (AColumn = 6) and (selT773B.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDtM.TotalePesiCalc > selT773B.FieldByName('PESO_TOTALE').AsFloat) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
  if (ARow > 0) and (AColumn = 7) and (selT773B.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDtM.TotaleQuoteCalc > selT773B.FieldByName('QUOTA_TOTALE').AsFloat) then
    ACell.Css:=ACell.Css + ' font_grassetto align_center font_rosso';
end;

procedure TW029FPesatureIndividuali.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  inherited;
  cdsT774.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW029FPesatureIndividuali.DistruggiOggetti;
begin
  FreeAndNil(A169FCalcoloDtM);
  grdPesiDip.medpClearCompGriglia;
  R180CloseDataSetTag0(selT774);
  SetLength(ArrDipendenti,0);
end;

procedure TW029FPesatureIndividuali.selT773FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('GRUPPI PESATURE INDIVIDUALI',DataSet.FieldByName('CODGRUPPO').AsString)
end;

end.

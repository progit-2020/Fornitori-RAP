unit W033UProspettoAssenze;

interface

uses
  W010URichiestaAssenze, W010URichiestaAssenzeDM, W010UCancPeriodoFM,
  SysUtils, StrUtils, Classes, Graphics, Controls, IWApplication,
  IWTemplateProcessorHTML, IWCompLabel,
  IWControl, IWHTMLControls, IWCompEdit,
  IWCompButton, Oracle, OracleData, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWVCLComponent, DatiBloccati, ActnList, Menus, IWCompMenu, R012UWebAnagrafico,
  IWDBGrids, medpIWDBGrid, DB, DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, C018UIterAutDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  meIWLabel, meIWEdit, meIWButton,
  meIWImageFile, IWAdvCheckGroup, meTIWAdvCheckGroup, meIWLink, Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion,
  meIWGrid, medpIWTabControl,
  W033UAutorizzazioneAssenzeFM, W033ULegendaAssenzeFM, W033UProspettoAssenzeDM,
  IWCompListbox, meIWComboBox, IWCompGrids, IWCompExtCtrls, IW.Browser.InternetExplorer,
  A000UMessaggi, W000UMessaggi, IWCompCheckbox, meIWCheckBox;

const
  NRIGHEBLOCCATE = 1;
  NCOLONNEBLOCCATE = 2;

type
  TW033FProspettoAssenze = class(TR012FWebAnagrafico)
    W033ParametriRG: TmeIWRegion;
    lblPeriodoDal: TmeIWLabel;
    lblPeriodoAl: TmeIWLabel;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    lblGiustificativi: TmeIWLabel;
    cgpGiustificativi: TmeTIWAdvCheckGroup;
    imgSelezionaTuttoGiustificativi: TmeIWImageFile;
    imgDeselezionaTuttoGiustificativi: TmeIWImageFile;
    imgInvertiSelezioneGiustificativi: TmeIWImageFile;
    lblTipologie: TmeIWLabel;
    cgpTipologie: TmeTIWAdvCheckGroup;
    W033ProspettoRG: TmeIWRegion;
    tpParametri: TIWTemplateProcessorHTML;
    tpProspetto: TIWTemplateProcessorHTML;
    tabProspettoAssenze: TmedpIWTabControl;
    grdProspetto: TmedpIWDBGrid;
    DLista: TDataSource;
    lblParametriOpzionali: TmeIWLabel;
    cgpParametriOpzionali: TmeTIWAdvCheckGroup;
    lnkLegendaColoriGiorni: TmeIWLink;
    cmbDatoRaggr: TmeIWComboBox;
    lblDatoRaggr: TmeIWLabel;
    pmnSeleziona: TPopupMenu;
    mnuSelezionaTutto: TMenuItem;
    mnuDeselezionaTutto: TMenuItem;
    mnuInvertiSelezione: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure imgDeselezionaTuttoGiustificativiClick(Sender: TObject);
    procedure imgInvertiSelezioneGiustificativiClick(Sender: TObject);
    procedure imgSelezionaTuttoGiustificativiClick(Sender: TObject);
    procedure grdProspettoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure lnkCausaleAutClick(Sender: TObject);
    procedure lnkCausaleCancClick(Sender: TObject);
    procedure tabProspettoAssenzeTabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure grdProspettoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure mnuSelezionaTuttoClick(Sender: TObject);
    procedure mnuDeselezionaTuttoClick(Sender: TObject);
    procedure mnuInvertiSelezioneClick(Sender: TObject);
    procedure tpParametriUnknownTag(const AName: string; var VValue: string);
  private
    Dal,Al:TDateTime;
    FiltroDip,ElencoGiust,ElencoTipi:String;
    NRigheCausali:Integer;
    W033DM: TW033FProspettoAssenzeDM;
    W033FAutorizzazioneAssenzeFM: TW033FAutorizzazioneAssenzeFM;
    W010DM: TW010FRichiestaAssenzeDM;
    W010CancPeriodoFM: TW010FCancPeriodoFM;
    W033FLegendaAssenzeFM: TW033FLegendaAssenzeFM;
    C004FParamFormPrv:TC004FParamForm;
    C018,
    C018Canc:TC018FIterAutDM;
    AutorizzazioneRichieste:Boolean;
    MaxLenCaus: Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaboraProspetto;
    procedure CaricaRichiesteAutorizzabili;
    procedure CaricaLista;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    GestioneTipoMezzaGiornata: Boolean;
    function  InizializzaAccesso:Boolean; override;
    procedure VisualizzaGriglia;
  end;

implementation

{$R *.DFM}

function TW033FProspettoAssenze.InizializzaAccesso:Boolean;
begin
  Result:=True;
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);
  GetDipendentiDisponibili(Parametri.DataLavoro);
end;

procedure TW033FProspettoAssenze.IWAppFormCreate(Sender: TObject);
var
  Q: TOracleQuery;
begin
  inherited;

  // inizializza valori
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);

  //C004: gestire il ProgOper per gli utenti web...
  C004FParamFormPrv:=CreaC004(SessioneOracle,'W033',Parametri.Operatore,False);
  //SelezionePeriodica:=True;

  W033DM:=TW033FProspettoAssenzeDM.Create(Self);

  with WR000DM.selT265 do
  begin
    Filtered:=True;  //Filtro Dizionario
    Open;
    Tag:=Tag + 1;
    while not Eof do
    begin
      cgpGiustificativi.Items.Add(StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      Next;
    end;
  end;
  with WR000DM.selT275 do
  begin
    Filtered:=True;  //Filtro Dizionario
    Open;
    Tag:=Tag + 1;
    if Parametri.CampiRiferimento.C90_W010CausPres = 'S' then
      while not Eof do
      begin
        cgpGiustificativi.Items.Add(StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
        Next;
      end;
  end;
  cgpGiustificativi.Items.Sort;
  //cgpTipologie.IsChecked[0]:=True; In alternativa al GetParametriFunzione
  cmbDatoRaggr.Items.Clear;
  with W033DM.selI010 do
  begin
    First;
    cmbDatoRaggr.Items.Add('');
    while not Eof do
    begin
      cmbDatoRaggr.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
    end;
  end;
  GetParametriFunzione;

  // apre dataset per decodifica codici causali
  W033DM.selCausali.Open;

  //Controllo se gestire l'autorizzazione delle richieste
  AutorizzazioneRichieste:=False;
  if not SolaLettura then
  begin
    try
      WR000DM.Responsabile:=True;
      C018:=TC018FIterAutDM.Create(Self);
      C018.Iter:=ITER_GIUSTIF;
      C018.PreparaDataSetIter(W033DM.selaT050,tiAutorizzazione);
      AutorizzazioneRichieste:=True;
    except
      //l'operatore non ha l'abilitazione agli iter: non gestisco l'autorizzazione delle richieste
      WR000DM.Responsabile:=False;
    end;

    // empoli - commessa 2012/102.ini
    // prepara il C018 per la cancellazione periodo
    W010DM:=TW010FRichiestaAssenzeDM.Create(Self);
    C018Canc:=TC018FIterAutDM.Create(Self);
    C018Canc.Iter:=ITER_GIUSTIF;
    C018Canc.PreparaDataSetIter(W010DM.selT050,tiRichiesta);
    // empoli - commessa 2012/102.fine
  end;

  tabProspettoAssenze.AggiungiTab(A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_PARAMETRI), W033ParametriRG);
  tabProspettoAssenze.AggiungiTab(A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_PROSPETTO), W033ProspettoRG);
  tabProspettoAssenze.ActiveTab:=W033ParametriRG;

  grdProspetto.medpPaginazione:=False;
  grdProspetto.medpDataSet:=W033DM.cdsLista;
  grdProspetto.medpTestoNoRecord:='Nessun record';
  //grdProspetto.medpFixedColumns:=1;

  // visualizzazione e posizionamento del radiogroup tipo mezza giornata
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.ReadBuffer:=2;
    Q.SQL.Add('select sum(nvl(CSI_MAX_MGMAT,0) + nvl(CSI_MAX_MGPOM,0)) MAX_MG_TOT ');
    Q.SQL.Add('from   T265_CAUASSENZE ');
    Q.Execute;
    GestioneTipoMezzaGiornata:=Q.FieldAsInteger(0) > 0;
  finally
    FreeAndNil(Q);
  end;
end;

procedure TW033FProspettoAssenze.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  W033FLegendaAssenzeFM:=TW033FLegendaAssenzeFM.Create(Self);
end;

procedure TW033FProspettoAssenze.mnuSelezionaTuttoClick(Sender: TObject);
begin
  imgSelezionaTuttoGiustificativiClick(nil);
end;

procedure TW033FProspettoAssenze.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = W010CancPeriodoFM then
    begin
      // chiusura frame cancellazione periodo
      try
        W010CancPeriodoFM:=nil;
        // aggiorna prospetto
        if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
          btnEseguiClick(nil);
      except
      end;
    end
    else if AComponent = W033FAutorizzazioneAssenzeFM then
    begin
      // chiusura frame autorizzazione richiesta
      try
        W033FAutorizzazioneAssenzeFM:=nil;
        // aggiorna prospetto
        if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
          btnEseguiClick(nil);
      except
      end;
    end;
  end;
end;

procedure TW033FProspettoAssenze.mnuDeselezionaTuttoClick(Sender: TObject);
begin
  imgDeselezionaTuttoGiustificativiClick(nil);
end;

procedure TW033FProspettoAssenze.mnuInvertiSelezioneClick(Sender: TObject);
begin
  imgInvertiSelezioneGiustificativiClick(nil);
end;

procedure TW033FProspettoAssenze.lnkCausaleAutClick(Sender: TObject);
// autorizzazione della richiesta
begin
  W033FAutorizzazioneAssenzeFM:=TW033FAutorizzazioneAssenzeFM.Create(Self);
  FreeNotification(W033FAutorizzazioneAssenzeFM);
  with W033FAutorizzazioneAssenzeFM do
  begin
    W033DM_Aut:=W033DM;
    W001DM_Aut:=WR000DM;
    C018_Aut:=C018;
    CaricaGriglia((Sender as TmeIWLink).FriendlyName);//Nel FriendlyName c'è l'ID della richiesta
  end;
end;

// empoli - commessa 2012/102.ini
procedure TW033FProspettoAssenze.lnkCausaleCancClick(Sender: TObject);
// cancellazione periodo
begin
  if Assigned(W010CancPeriodoFM) then
    FreeAndNil(W010CancPeriodoFM);
  W010CancPeriodoFM:=TW010FCancPeriodoFM.Create(Self);
  FreeNotification(W010CancPeriodoFM);
  W010CancPeriodoFM.W010DM:=W010DM;
  W010CancPeriodoFM.C018:=C018Canc;
  W010CancPeriodoFM.IdOrig:=StrToIntDef((Sender as TmeIWLink).FriendlyName,0);
  W010CancPeriodoFM.DataProposta:=(Sender as TmeIWLink).Tag;
  W010CancPeriodoFM.Visualizza;
end;
// empoli - commessa 2012/102.fine

procedure TW033FProspettoAssenze.GetParametriFunzione;
{Leggo i parametri della form}
var S:String;
    i,j:Integer;
begin
  i:=1;
  while C004FParamFormPrv.GetParametro('cgpCausali' + IntToStr(i),'FINITE') <> 'FINITE' do
  begin
    S:=',' + C004FParamFormPrv.GetParametro('cgpCausali' + IntToStr(i),'') + ',';
    for j:=0 to cgpGiustificativi.Items.Count - 1 do
      if Pos(',' + Copy(cgpGiustificativi.Items[j],1,Pos(' ',cgpGiustificativi.Items[j]) - 1) + ',',S) > 0 then
        cgpGiustificativi.IsChecked[j]:=True;
    inc(i);
  end;
  cgpTipologie.IsChecked[0]:=Pos('I',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[1]:=Pos('M',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[2]:=Pos('N',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[3]:=Pos('D',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpParametriOpzionali.IsChecked[0]:=C004FParamFormPrv.GetParametro('chkTimbrature','N') = 'S';
  cgpParametriOpzionali.IsChecked[1]:=C004FParamFormPrv.GetParametro('chkAssenzaGGIntera','N') = 'S';
  cgpParametriOpzionali.IsChecked[2]:=C004FParamFormPrv.GetParametro('chkEscludiRiposi','N') = 'S';
  cgpParametriOpzionali.IsChecked[3]:=C004FParamFormPrv.GetParametro('chkNominativoSpez','N') = 'S';
  cmbDatoRaggr.ItemIndex:=Max(0,cmbDatoRaggr.Items.IndexOf(VarToStr(W033DM.selI010.Lookup('NOME_CAMPO',C004FParamFormPrv.GetParametro('cmbDatoRaggr',''),'NOME_LOGICO'))));
end;

procedure TW033FProspettoAssenze.PutParametriFunzione;
{Scrivo i parametri della form}
var S:String;
    i:Integer;
begin
  C004FParamFormPrv.Cancella001;
  i:=0;
  S:=StringReplace(ElencoGiust,'''','',[rfReplaceAll]) + ',';
  repeat
    inc(i);
    C004FParamFormPrv.PutParametro('cgpCausali' + IntToStr(i),Copy(S,1,IfThen(Length(S) >= (2000-6),Pos(',',Copy(S,2000-6)),Length(S))));
    S:=Copy(S,IfThen(Length(S) >= (2000-6),Pos(',',Copy(S,2000-6)),Length(S)) + 1);
  until S = '';
  C004FParamFormPrv.PutParametro('cgpTipologie',StringReplace(ElencoTipi,'''','',[rfReplaceAll]));
  C004FParamFormPrv.PutParametro('chkTimbrature',IfThen(cgpParametriOpzionali.IsChecked[0],'S','N'));
  C004FParamFormPrv.PutParametro('chkAssenzaGGIntera',IfThen(cgpParametriOpzionali.IsChecked[1],'S','N'));
  C004FParamFormPrv.PutParametro('chkEscludiRiposi',IfThen(cgpParametriOpzionali.IsChecked[2],'S','N'));
  C004FParamFormPrv.PutParametro('chkNominativoSpez',IfThen(cgpParametriOpzionali.IsChecked[3],'S','N'));
  if cmbDatoRaggr.ItemIndex > 0 then
    C004FParamFormPrv.PutParametro('cmbDatoRaggr',VarToStr(W033DM.selI010.Lookup('NOME_LOGICO',cmbDatoRaggr.Text,'NOME_CAMPO')));
  SessioneOracle.Commit;
end;

procedure TW033FProspettoAssenze.tabProspettoAssenzeTabControlChanging(
  Sender: TObject; var AllowChange: Boolean);
begin
  //Se passo al prospetto senza aver mai cliccato su Esegui, forzo l'esecuzione
  if (Sender as TmedpIWTabControl).TabByIndex(0).Selected then
    if not grdProspetto.DataSource.DataSet.Active then
      btnEseguiClick(nil);
end;

procedure TW033FProspettoAssenze.tpParametriUnknownTag(const AName: string; var VValue: string);
begin
  inherited;
  if UpperCase(AName) = 'LGNPERIODODAELABORARE' then
    VValue:=A000TraduzioneStringhe(A000MSG_W033_MSG_LGNPERIODOELAB);//'Periodo da elaborare';
end;

procedure TW033FProspettoAssenze.ElaboraProspetto;
begin
  CaricaRichiesteAutorizzabili;
  CaricaLista;
  VisualizzaGriglia;
end;

procedure TW033FProspettoAssenze.CaricaRichiesteAutorizzabili;
begin
  if not AutorizzazioneRichieste then
    exit;

  //Cerco le richieste che il mio utente può autorizzare
  with W033DM.selaT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',WR000DM.FiltroRicerca);
    SetVariable('FILTRO_PERIODO','AND T_ITER.DAL <= to_date(''' + FormatDateTime('dd/mm/yyyy',Al) + ''',''dd/mm/yyyy'') AND T_ITER.AL >= to_date(''' + FormatDateTime('dd/mm/yyyy',Dal) + ''',''dd/mm/yyyy'')');
    SetVariable('FILTRO_VISUALIZZAZIONE','and T850.STATO is null and T851.STATO is null');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    Open;
  end;

  // apertura del dataset di supporto per la cancellazione periodo
  with W010DM.selT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',WR000DM.FiltroRicerca);
    SetVariable('FILTRO_PERIODO','AND T_ITER.DAL <= to_date(''' + FormatDateTime('dd/mm/yyyy',Al) + ''',''dd/mm/yyyy'') AND T_ITER.AL >= to_date(''' + FormatDateTime('dd/mm/yyyy',Dal) + ''',''dd/mm/yyyy'')');
    SetVariable('FILTRO_VISUALIZZAZIONE','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    Open;
  end;
end;

procedure TW033FProspettoAssenze.CaricaLista;
var i,n,o,NRigheCausaliTemp,nRighePag,LCaus:Integer;
    Data:TDateTime;
    DatoRaggr,NomeCampo,ValoreRaggrOld:String;
begin
  with W033DM do
  begin
    selT040.Close;
    selT050.Close;
    selT100.Close;
    if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
    begin
      if selT040.VariableIndex('DATALAVORO') = -1 then
      begin
        selT040.DeclareVariable('DATALAVORO',otDate);
        selT050.DeclareVariable('DATALAVORO',otDate);
        selT100.DeclareVariable('DATALAVORO',otDate);
      end;
      selT040.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT100.SetVariable('DATALAVORO',Parametri.DataLavoro);
    end
    else if selT040.VariableIndex('DATALAVORO') > -1 then
    begin
      selT040.DeleteVariable('DATALAVORO');
      selT050.DeleteVariable('DATALAVORO');
      selT100.DeleteVariable('DATALAVORO');
    end;
    selT040.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT040.SetVariable('DAL',Dal);
    selT040.SetVariable('AL',Al);
    selT040.SetVariable('PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT040.Open;
    selT050.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT050.SetVariable('DAL',Dal);
    selT050.SetVariable('AL',Al);
    selT050.SetVariable('PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT050.Open;
    selT100.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT100.SetVariable('DAL',Dal);
    selT100.SetVariable('AL',Al);
    if cgpParametriOpzionali.IsChecked[0] then
      selT100.Open;

    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsLista.FieldDefs.Add('COGNOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOME',ftString,30,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,200,False);
    cdsLista.FieldDefs.Add('DATO_RAGGR',ftString,200,False);
    cdsLista.FieldDefs.Add('ORDINE',ftInteger,0,False);
    for i:=0 to Trunc(Al - Dal) do
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',Dal + i),ftDate,0,False);
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('DATO_RAGGR;ORDINE;COGNOME;NOME;PROGRESSIVO'),[]);
    cdsLista.IndexName:='Ricerca';

    cdsListaTimb.Close;
    cdsListaTimb.FieldDefs.Clear;
    cdsListaTimb.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTimb.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTimb.FieldDefs.Add('LAVORATIVO',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('TIMBRATURE',ftString,1,False);
    cdsListaTimb.CreateDataSet;
    cdsListaTimb.LogChanges:=False;

    cdsListaAss.Close;
    cdsListaAss.FieldDefs.Clear;
    cdsListaAss.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaAss.FieldDefs.Add('CAUSALE',ftString,5,False);
    cdsListaAss.FieldDefs.Add('SIGLA_CAUSALE',ftString,5,False);
    cdsListaAss.FieldDefs.Add('SELEZIONATO',ftString,1,False);
    cdsListaAss.FieldDefs.Add('DEFINITIVO',ftString,1,False);
    cdsListaAss.FieldDefs.Add('FRUIZIONE',ftString,1,False);
    cdsListaAss.FieldDefs.Add('TIPOMG',ftString,1,False);
    cdsListaAss.FieldDefs.Add('D_FRUIZIONE',ftString,15,False);
    cdsListaAss.FieldDefs.Add('ID_AUTORIZZABILE',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('ID_CANCELLABILE',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('TIPO_RICHIESTA',ftString,1,False);
    cdsListaAss.CreateDataSet;
    cdsListaAss.LogChanges:=False;
    cdsListaAss.IndexDefs.Clear;
    cdsListaAss.IndexDefs.Add('Ricerca',('PROGRESSIVO;DATA'),[]);
    cdsListaAss.IndexName:='Ricerca';

    if cmbDatoRaggr.ItemIndex > 0 then
    begin
      DatoRaggr:=VarToStr(selI010.Lookup('NOME_LOGICO',cmbDatoRaggr.Text,'NOME_CAMPO'));
      NomeCampo:=IfThen(Copy(DatoRaggr,1,4) = 'T430',Copy(DatoRaggr,5),DatoRaggr);
      if A000LookupTabella(NomeCampo,selSQL) then
      begin
        if selSQL.VariableIndex('DECORRENZA') >= 0 then
          selSQL.SetVariable('DECORRENZA',Al);
        try
          selSQL.Open;
        except
        end;
      end;
    end;

    MaxLenCaus:=0;
    NRigheCausali:=1;
    selAnagrafeW.First;
    while not selAnagrafeW.Eof do
    begin
      cdsLista.Append;
      cdsLista.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
      cdsLista.FieldByName('COGNOME').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString;
      cdsLista.FieldByName('NOME').AsString:=selAnagrafeW.FieldByName('NOME').AsString;
      cdsLista.FieldByName('NOMINATIVO').AsString:=cdsLista.FieldByName('COGNOME').AsString + IfThen(cgpParametriOpzionali.IsChecked[3],CRLF,' ') + cdsLista.FieldByName('NOME').AsString;
      if cmbDatoRaggr.ItemIndex > 0 then
      begin
        QSGruppo.GetDatiStorici(DatoRaggr,SelAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Dal,Al);
        if QSGruppo.LocDatoStorico(Al) then
        begin
          cdsLista.FieldByName('DATO_RAGGR').AsString:=QSGruppo.FieldByName(DatoRaggr).AsString;
          if selSQL.Active then
            cdsLista.FieldByName('DATO_RAGGR').AsString:=cdsLista.FieldByName('DATO_RAGGR').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsLista.FieldByName('DATO_RAGGR').AsString,'DESCRIZIONE'));
        end;
      end;
      cdsLista.FieldByName('ORDINE').AsInteger:=9999;
      cdsLista.Post;
      for i:=0 to Trunc(Al - Dal) do
      begin
        Data:=Dal + i;
        NRigheCausaliTemp:=0;
        cdsListaTimb.Append;
        cdsListaTimb.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
        cdsListaTimb.FieldByName('DATA').AsDateTime:=Data;
        T010F_GGLAVORATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        T010F_GGLAVORATIVO.SetVariable('DATA',Data);
        T010F_GGLAVORATIVO.Execute;
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(T010F_GGLAVORATIVO.GetVariable('LAVORATIVO'));
        //Presenza timbrature
        if cgpParametriOpzionali.IsChecked[0] then
          cdsListaTimb.FieldByName('TIMBRATURE').AsString:=IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB')),0) > 0,'S','N');
        cdsListaTimb.Post;
        //Cerco le assenze definitive del dipendente
        selT040.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (DATA = ' + FloatToStr(Data) + ')';
        selT040.Filtered:=True;
        selT040.First;
        while not selT040.Eof do
        begin
          if not cgpParametriOpzionali.IsChecked[2]
          or (VarToStr(WR000DM.selT265.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'CODINTERNO')) <> 'H')
          or (selT040.FieldByName('TIPOGIUST').AsString <> 'I') then
          begin
            if (Pos('''' + selT040.FieldByName('CAUSALE').AsString + '''',ElencoGiust) > 0)
            and (Pos('''' + selT040.FieldByName('TIPOGIUST').AsString + '''',ElencoTipi) > 0) then
            begin
              inc(NRigheCausaliTemp);
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('CAUSALE').AsString:=selT040.FieldByName('CAUSALE').AsString;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Max(Length(cdsListaAss.FieldByName('CAUSALE').AsString),Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString));
              if LCaus > MaxLenCaus then
                MaxLenCaus:=LCaus;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='S';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='S';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT040.FieldByName('TIPOGIUST').AsString;
              cdsListaAss.FieldByName('TIPOMG').AsString:=selT040.FieldByName('CSI_TIPO_MG').AsString;
              if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='GG'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 GG'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + ' ore'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + '-' + selT040.FieldByName('AORE').AsString;
              if (selT040.FieldByName('ID_RICHIESTA').AsInteger > 0) and
                 //Cancellazione abilitata
                 (C018 <> nil) and (C018.Revocabile) and
                 (Pos(INI_PAR_T050_CANCELLAZIONE,W000ParConfig.ParametriAvanzati) > 0) then
                 //(StrTipoRichiesta = 'D') and
                 //(IdRevoca <= 0) and // impedisce cancellazione se esiste una revoca
                 //     (TmpAl > TmpDal);
              begin
                cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger:=selT040.FieldByName('ID_RICHIESTA').AsInteger;
              end;
              cdsListaAss.Post;
            end
            else if cgpParametriOpzionali.IsChecked[1]
            //and (selT040.FieldByName('TIPOGIUST').AsString = 'I')
            then
            begin
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString);
              if LCaus > 0 then
                inc(NRigheCausaliTemp);
              if LCaus > MaxLenCaus then
                MaxLenCaus:=LCaus;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='N';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='S';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT040.FieldByName('TIPOGIUST').AsString;
              cdsListaAss.FieldByName('TIPOMG').AsString:=selT040.FieldByName('CSI_TIPO_MG').AsString;
              if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='GG'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 GG'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + ' ore'
              else if selT040.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + '-' + selT040.FieldByName('AORE').AsString;
              cdsListaAss.Post;
            end;
          end;
          selT040.Next;
        end;
        selT040.Filtered:=False;
        //Cerco le assenze richieste del dipendente
        //selT050.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (' + FloatToStr(Data) + ' >= DAL) AND (' + FloatToStr(Data) + ' <= AL)';
        selT050.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (' + FloatToStr(Data) + ' = DATA)';
        selT050.Filtered:=True;
        selT050.First;
        while not selT050.Eof do
        begin
          if (Parametri.CampiRiferimento.C90_W010CausPres = 'S')
          and (VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'CODICE')) = '') then
            T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC','GC')
          else
            T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC',VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'GSIGNIFIC')));
          T010F_GGSIGNIFICATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          T010F_GGSIGNIFICATIVO.SetVariable('DATA',Data);
          T010F_GGSIGNIFICATIVO.Execute;
          if (VarToStr(T010F_GGSIGNIFICATIVO.GetVariable('SIGNIFICATIVO')) = 'S')
          and (   not cgpParametriOpzionali.IsChecked[2]
               or (VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'CODINTERNO')) <> 'H')
               or (selT050.FieldByName('TIPOGIUST').AsString <> 'I')) then
          begin
            if (Pos('''' + selT050.FieldByName('CAUSALE').AsString + '''',ElencoGiust) > 0)
            and (Pos('''' + selT050.FieldByName('TIPOGIUST').AsString + '''',ElencoTipi) > 0) then
            begin
              inc(NRigheCausaliTemp);
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('CAUSALE').AsString:=selT050.FieldByName('CAUSALE').AsString;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Max(Length(cdsListaAss.FieldByName('CAUSALE').AsString),Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString));
              if LCaus > MaxLenCaus then
                MaxLenCaus:=LCaus;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='S';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='N';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT050.FieldByName('TIPOGIUST').AsString;
              cdsListaAss.FieldByName('TIPOMG').AsString:=selT050.FieldByName('CSI_TIPO_MG').AsString;
              if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='GG'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 GG'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + ' ore'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + '-' + selT050.FieldByName('AORE').AsString;

              // chiamata <74473>
              if AutorizzazioneRichieste then
              begin
                if selaT050.Locate('ID',selT050.FieldByName('ID').AsInteger,[]) then
                begin
                  cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger:=selT050.FieldByName('ID').AsInteger;
                  cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString:=selaT050.FieldByName('TIPO_RICHIESTA').AsString;
                end
                else if (not SolaLettura) and
                        (W010DM.selT050.Locate('ID',selT050.FieldByName('ID').AsInteger,[])) and
                        (C018.Revocabile) and
                        (Pos(INI_PAR_T050_CANCELLAZIONE,W000ParConfig.ParametriAvanzati) > 0) and
                        (W010DM.selT050.FieldByName('TIPO_RICHIESTA').AsString = 'D') and
                        (W010DM.selT050.FieldByName('AUTORIZZAZIONE').AsString = 'S') and
                        (W010DM.selT050.FieldByName('ELABORATO').AsString <> 'E') and
                        (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger <= 0) and // impedisce cancellazione se esiste una revoca
                        (W010DM.selT050.FieldByName('AL').AsDateTime > W010DM.selT050.FieldByName('DAL').AsDateTime) then
                begin
                  // cancellazione abilitata
                  cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger:=selT050.FieldByName('ID').AsInteger;
                end;
              end;
              cdsListaAss.Post;
            end
            else if cgpParametriOpzionali.IsChecked[1]
            //and (selT050.FieldByName('TIPOGIUST').AsString = 'I')
            and (selT050.FieldByName('STATO').AsString = 'S')
            then
            begin
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString);
              if LCaus > 0 then
                inc(NRigheCausaliTemp);
              if LCaus > MaxLenCaus then
                MaxLenCaus:=LCaus;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='N';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='N';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT050.FieldByName('TIPOGIUST').AsString;
              cdsListaAss.FieldByName('TIPOMG').AsString:=selT050.FieldByName('CSI_TIPO_MG').AsString;
              if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='GG'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 GG'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + ' ore'
              else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + '-' + selT050.FieldByName('AORE').AsString;
              cdsListaAss.Post;
            end;
          end;
          selT050.Next;
        end;
        selT050.Filtered:=False;
        NRigheCausali:=Max(NRigheCausali,NRigheCausaliTemp);
      end;
      selAnagrafeW.Next;
    end;
    if not selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
      selAnagrafeW.First;
    selSQL.Close;

    //Gestione Dato di raggruppamento
    if cmbDatoRaggr.ItemIndex > 0 then
    begin
      nRighePag:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
      n:=0;
      o:=0;
      ValoreRaggrOld:='#VALORE#INIZIALE#FITTIZIO#';
      cdsLista.First;
      while not cdsLista.Eof do
      begin
        //Inserimento dei record vuoti tra un valore e l'altro
        if (cdsLista.FieldByName('DATO_RAGGR').AsString <> ValoreRaggrOld) //=> valore cambiato
        and (nRighePag > 0) //=> griglia con paginazione
        and (n > 0) //=> titoletto già inserito
        and (n < nRighePag) then //=> righe mancanti nella pagina
        begin
          for i:=1 to (nRighePag - n) do
          begin
            cdsLista.Append;
            cdsLista.FieldByName('PROGRESSIVO').AsInteger:=0;
            cdsLista.FieldByName('COGNOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
            cdsLista.FieldByName('NOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
            cdsLista.FieldByName('DATO_RAGGR').AsString:=ValoreRaggrOld;
            cdsLista.FieldByName('ORDINE').AsInteger:=o;
            cdsLista.Post;
          end;
          cdsLista.Next;
        end;
        //Inserimento del titoletto contenente il valore
        if (cdsLista.FieldByName('DATO_RAGGR').AsString <> ValoreRaggrOld) //=> valore cambiato
        or (    (nRighePag > 0) //=> griglia con paginazione
            and (n = nRighePag)) then //=> pagina completa
        begin
          inc(o);
          ValoreRaggrOld:=cdsLista.FieldByName('DATO_RAGGR').AsString;
          cdsLista.Append;
          cdsLista.FieldByName('PROGRESSIVO').AsInteger:=0;
          cdsLista.FieldByName('NOMINATIVO').AsString:=cmbDatoRaggr.Text + ': ' + IfThen(ValoreRaggrOld = '','vuoto',ValoreRaggrOld);
          cdsLista.FieldByName('DATO_RAGGR').AsString:=ValoreRaggrOld;
          cdsLista.FieldByName('ORDINE').AsInteger:=o;
          cdsLista.Post;
          n:=1;
        end
        else
        //Assegnazione della pagina alle righe dei dipendenti
        begin
          cdsLista.Edit;
          cdsLista.FieldByName('ORDINE').AsInteger:=o;
          cdsLista.Post;
          inc(n);
        end;
        cdsLista.Next;
      end;
      //Gestione righe vuote sull'ultima pagina
      if (nRighePag > 0)
      and (n > 0)
      and (n < nRighePag) then
      begin
        for i:=1 to (nRighePag - n) do
        begin
          cdsLista.Append;
          cdsLista.FieldByName('PROGRESSIVO').AsInteger:=0;
          cdsLista.FieldByName('COGNOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
          cdsLista.FieldByName('NOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
          cdsLista.FieldByName('DATO_RAGGR').AsString:=ValoreRaggrOld;
          cdsLista.FieldByName('ORDINE').AsInteger:=o;
          cdsLista.Post;
        end;
        cdsLista.Next;
      end;
    end;
  end;
end;

procedure TW033FProspettoAssenze.VisualizzaGriglia;
var i:Integer;
    Data:TDateTime;
begin
  grdProspetto.Caption:='Prospetto assenze ' + C190PeriodoStr(Dal,Al); // dal ' + FormatDateTime('dd/mm/yyyy',Dal) + ' al ' + FormatDateTime('dd/mm/yyyy',Al);
  grdProspetto.Summary:=grdProspetto.Caption;
  with W033DM do
  begin
    if cdsLista.RecordCount > 0 then
    begin
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdProspetto.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
    end;
    grdProspetto.medpCreaCDS;
    grdProspetto.medpEliminaColonne;
    for i:=0 to cdsLista.FieldDefs.Count - 1 do
      if not R180In(cdsLista.FieldDefs[i].Name,['DATO_RAGGR','ORDINE','COGNOME','NOME']) then
      begin
        if cdsLista.FieldDefs[i].Name = 'PROGRESSIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Progressivo','',nil)
        else if cdsLista.FieldDefs[i].Name = 'NOMINATIVO' then
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,'Nominativo','',nil)
        else
        begin
          Data:=EncodeDate(StrToInt(Copy(cdsLista.FieldDefs[i].Name,1,4)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,5,2)),StrToInt(Copy(cdsLista.FieldDefs[i].Name,7,2)));
          (*
          FrmData:='dd/mm/yy';
          if R180Anno(Dal) = R180Anno(Al) then
            if R180Mese(Dal) = R180Mese(Al) then
              FrmData:='dd'
            else
              FrmData:='dd/mm';
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,
                                           Copy(FormatDateTime('dddd',Data),1,2) + CRLF + FormatDateTime(FrmData,Data),
                                           '',nil);
          *)
          grdProspetto.medpAggiungiColonna(cdsLista.FieldDefs[i].Name,FormatDateTime('dd/mm/yyyy',Data),'',nil);
        end;
      end;
  end;
  grdProspetto.medpColonna('PROGRESSIVO').Visible:=False;
  grdProspetto.medpInizializzaCompGriglia;
  grdProspetto.medpCaricaCDS;
end;

procedure TW033FProspettoAssenze.grdProspettoAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var i,j,x,Progressivo:Integer;
    Data:TDateTime;
    IdAutorizzabili,IdCancAutorizzabili,Formato:String;
    bLabel:Boolean;
begin
  inherited;
  //Gestione dei link per le richieste autorizzabili
  if AutorizzazioneRichieste then
    for i:=0 to High(grdProspetto.medpCompGriglia) do
      for j:=0 to High(grdProspetto.medpCompGriglia[i].CompColonne) do
        if j >= NCOLONNEBLOCCATE then
          with W033DM do
          begin
            Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(j).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(j).DataField,7,2)));
            Progressivo:=StrToInt(grdProspetto.medpValoreColonna(i,'PROGRESSIVO'));
            IdAutorizzabili:='';
            IdCancAutorizzabili:='';
            //Cerco le richieste autorizzabili
            if cdsListaAss.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]) then
              repeat
                if cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger > 0 then
                begin
                  IdAutorizzabili:=IdAutorizzabili + cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsString + ',';
                  if cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString = 'C' then
                    IdCancAutorizzabili:=IdCancAutorizzabili + cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsString + ',';
                end;
                if cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger > 0 then
                  IdAutorizzabili:=IdAutorizzabili + cdsListaAss.FieldByName('ID_CANCELLABILE').AsString + ',';
                cdsListaAss.Next;
              until cdsListaAss.Eof
              or (cdsListaAss.FieldByName('PROGRESSIVO').AsInteger <> Progressivo)
              or (cdsListaAss.FieldByName('DATA').AsDateTime <> Data);
            //Se ho trovato almeno una richiesta autorizzabile...
            if IdAutorizzabili <> '' then
            begin
              bLabel:=False;
              cdsListaAss.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]);
              x:=0;
              //...preparo tanti componenti quante sono le NRigheCausali
              repeat
                //Non preparo il componente quando il record è relativo ad una causale non selezionata fruita a giornata intera
                if bLabel or (cdsListaAss.FieldByName('CAUSALE').AsString <> '') then
                begin
                  //Link per richieste autorizzabili, altrimenti Label
                  if bLabel or ((cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger = 0) and (cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger = 0)) then
                    grdProspetto.medpPreparaComponenteGenerico('C',0,x,DBG_LBL,'','','','','S',True)
                  else
                  begin
                    Formato:=IfThen(cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger > 0,'cancellazione','');
                    grdProspetto.medpPreparaComponenteGenerico('C',0,x,DBG_LNK,Formato,cdsListaAss.FieldByName('CAUSALE').AsString,'','','S',True);
                  end;
                  //Posiziono i componenti uno sotto l'altro
                  grdProspetto.Componenti[x].Riga:=x;
                  inc(x);
                end;
                //Passo al record successivo
                if not cdsListaAss.Eof then
                  cdsListaAss.Next;
                //Preparo sicuramente una label se il numero di causali è inferiore a NRigheCausali
                if cdsListaAss.Eof
                or (cdsListaAss.FieldByName('PROGRESSIVO').AsInteger <> Progressivo)
                or (cdsListaAss.FieldByName('DATA').AsDateTime <> Data) then
                  bLabel:=True;
              until x > NRigheCausali - 1;
              //Creo i componenti preparati
              grdProspetto.medpCreaComponenteGenerico(i,j,grdProspetto.Componenti);
              //Ciclo sui componenti creati
              for x:=0 to (grdProspetto.medpCompGriglia[i].CompColonne[j] as TmeIWGrid).RowCount - 1 do
                if grdProspetto.medpCompCella(i,j,x) is TmeIWLink then
                begin
                  //Se il componente è un link, sosvrascrivo il FriendlyName con l'id della richiesta
                  with (grdProspetto.medpCompCella(i,j,x) as TmeIWLink) do
                  begin
                    if Pos('cancellazione',Css) = 0 then
                      OnClick:=lnkCausaleAutClick
                    else
                      OnClick:=lnkCausaleCancClick;
                    FriendlyName:=Copy(IdAutorizzabili,1,Pos(',',IdAutorizzabili) - 1);
                    if R180InConcat(FriendlyName,IdCancAutorizzabili) then
                      Font.Style:=[fsBold];
                    Tag:=Trunc(Data);
                  end;
                  IdAutorizzabili:=Copy(IdAutorizzabili,Pos(',',IdAutorizzabili) + 1);
                end;
            end;
          end;
end;

procedure TW033FProspettoAssenze.grdProspettoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var r,c,x,Progressivo{,Cancellabile}:Integer;
    Data:TDateTime;
    Timbrature,Causali,Causale,DCausale,Selezionato,Definitivo,Fruizione,DFruizione,TipoMG,
    TestoOrig,Testo,Spazi,BackgroundColor,FontWeight,Spaziatura:String;
    MezzaGiornata:Boolean;
  function GetData(const S:String):String;
  begin
    Result:=Copy(FormatDateTime('dddd',StrToDate(S)),1,2) + '<br>';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
      begin
        Spaziatura:=DupeString('&nbsp;',MaxLenCaus + 1);
        Result:=Result + Spaziatura + Copy(S,1,2) + Spaziatura;
      end
      else
        Result:=Result + Copy(S,1,5)
    end
    else
      Result:=Result + FormatDateTime('dd/mm/yy',StrToDate(S));
    (*
    if Length(S) <= 2 then
      Result:=EncodeDate(R180Anno(Dal),R180Mese(Dal),StrToInt(S))
    else if Length(S) <= 5 then
      Result:=StrToDate(S + '/' + IntToStr(R180Anno(Dal)))
    else
      Result:=StrToDate(S);
    *)
  end;
begin
  inherited;
  if not grdProspetto.medpRenderCell(ACell, ARow, AColumn, True, True, False) then
    Exit;
  //ACell.RawText:=False; //Danilo A. 30.03.2012: Tolto perché non gestiva bene gli apici del nominativo. A che serviva?
  r:=ARow - 1;
  c:=grdProspetto.medpNumColonna(AColumn);
  if (ARow > 0)
  and (cmbDatoRaggr.ItemIndex > 0)
  and (Pos(cmbDatoRaggr.Text + ': ',grdProspetto.medpValoreColonna(r,'NOMINATIVO')) = 1) then
  begin
    ACell.Css:='riga_rottura';
    if AColumn = 0 then
    begin
      ACell.RawText:=True;
      ACell.Text:='<div style="position:relative; height:100%;">&nbsp;<br><span style="position:absolute; left:0px; top:0px; width:100%; height:100%;">' + grdProspetto.medpValoreColonna(r,'NOMINATIVO') + '</span></div>';
    end;
  end;
  if c >= NCOLONNEBLOCCATE then
    with W033DM do
    begin
      if ARow = 0 then
      begin
        Data:=StrToDate(ACell.Text);
        ACell.RawText:=True;
        ACell.Text:=GetData(ACell.Text);
        if DayOfWeek(Data) = 1 then
          ACell.Css:=ACell.Css + ' font_rosso';
      end
      else if (Length(grdProspetto.medpCompGriglia) > 0) then
      begin
        Data:=EncodeDate(StrToInt(Copy(grdProspetto.medpColonna(c).DataField,1,4)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,5,2)),StrToInt(Copy(grdProspetto.medpColonna(c).DataField,7,2)));
        Progressivo:=StrToInt(grdProspetto.medpValoreColonna(r,'PROGRESSIVO'));
        if cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]) then
        begin
          Timbrature:=cdsListaTimb.FieldByName('TIMBRATURE').AsString;
          if cdsListaTimb.FieldByName('LAVORATIVO').AsString = 'N' then
            ACell.Css:=ACell.Css + ' bg_nonlavorativo';
          //Contenitore esterno in cui inserire gli span con i colori e le causali
          TestoOrig:='<div style="position:relative; height:100%;">';
          //Testo fittizio per dimensionare la cella e far applicare gli span successivi
          TestoOrig:=TestoOrig + '#SPAZI#';
          //Fascia verde per presenza timbrature
          if Timbrature = 'S' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; z-index:7; background-color:#00FF00;">&nbsp;</span>';
          //Azzero le variabili delle assenze
          Causale:='';
          DCausale:='';
          Selezionato:='';
          Definitivo:='';
          Fruizione:='';
          TipoMG:='';
          DFruizione:='';
          //Cancellabile:=0;
          Causali:='';
          MezzaGiornata:=False;
          //Ciclo sulle assenze del giorno del dipendente
          if cdsListaAss.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]) then
            repeat
              Causale:=cdsListaAss.FieldByName('CAUSALE').AsString;
              if Causale <> '' then
              begin
                // chiamata <71723>.ini
                DCausale:=VarToStr(WR000DM.selT265.Lookup('CODICE',Causale,'DESCRIZIONE'));
                if DCausale = '' then
                  DCausale:=VarToStr(WR000DM.selT275.Lookup('CODICE',Causale,'DESCRIZIONE'));
                // chiamata <71723>.fine
              end
              else
              begin
                Causale:=cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString;
                DCausale:='';
              end;
              Selezionato:=cdsListaAss.FieldByName('SELEZIONATO').AsString;
              Definitivo:=cdsListaAss.FieldByName('DEFINITIVO').AsString;
              Fruizione:=cdsListaAss.FieldByName('FRUIZIONE').AsString;
              TipoMG:=cdsListaAss.FieldByName('TIPOMG').AsString;
              DFruizione:=cdsListaAss.FieldByName('D_FRUIZIONE').AsString;
              //Cancellabile:=cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger;
              if Causale <> '' then
              begin
                Causali:=Causali + Causale + ',';
                ACell.Hint:=ACell.Hint + Causale + IfThen(Trim(DCausale) <> '',' ') + DCausale + ': ' + DFruizione + '<br>';
              end;
              BackgroundColor:='transparent';
              if Selezionato = 'N' then
                BackgroundColor:=IfThen(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString <> '','#FF0000','#B1B1B1')  //Rosso se esiste sigla, Grigio se nulla
              else if cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString <> 'C' then
                BackgroundColor:=IfThen(Definitivo = 'N','#FFAAAA','#FF0000')  //Richieste di cancellazione o autorizzazione inserimento
              else if cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger > 0 then
                BackgroundColor:='#F5DEB3';//Autorizzazione alla cancellazione
              //Creo gli span colorati, sovrapponendo gli strati di visualizzazione
              TestoOrig:=TestoOrig + Format('<span style="position:absolute; left:%s; top:0px; width:%s; height:100%%; z-index:%s; background-color:%s;">&nbsp;</span>',
                                               //Left: più di una fruizione a mezza giornata oppure mg pomeriggio: 50% (colora la metà destra)
                                                     //presenza timbrature: 95% (vedi sopra)
                                                     //altri casi: 0px
                                              [IfThen((Fruizione = 'M') and (MezzaGiornata or (TipoMG = 'P')),'50%','0px'),
                                               //Width: fruizione a giornata intera: 100%
                                                      //fruizione a mezza giornata: 50%
                                                      //fruizione ad ore: 25%
                                                      //presenza timbrature: 5% (vedi sopra)
                                                      //testo (causali): 100% (vedi sotto)
                                               IfThen(Fruizione = 'I','100%',IfThen(Fruizione = 'M','50%','25%')),
                                               //Strato: assenza generica a giornata: 0
                                                       //assenza a giornata intera sul cartellino: 1
                                                       //assenza richiesta a giornata intera: 2
                                                       //assenza a mezza giornata sul cartellino: 3
                                                       //assenza richiesta a mezza giornata: 4
                                                       //assenza ad ore sul cartellino: 5
                                                       //assenza richiesta ad ore: 6
                                                       //presenza timbrature: 7 (vedi sopra)
                                                       //testo (causali): 8 (vedi sotto)
                                               IfThen(Selezionato = 'N','0',
                                                                        IfThen(Fruizione = 'I',IfThen(Definitivo = 'N','2','1'),
                                                                                               IfThen(Fruizione = 'M',IfThen(Definitivo = 'N','4','3'),
                                                                                                                      IfThen(Definitivo = 'N','6','5')))),
                                               //Colore: assenza generica a giornata: grigio
                                                       //assenza sul cartellino: rosso
                                                       //assenza richiesta: rosa
                                                       //presenza timbrature: lime (vedi sopra)
                                                       //testo (causali): trasparente (vedi sotto)
                                               //IfThen(Selezionato = 'N','#B1B1B1',IfThen(Definitivo = 'N','#FFAAAA','#FF0000'))]);
                                               BackgroundColor]);
              MezzaGiornata:=Fruizione = 'M';
              cdsListaAss.Next;
            until cdsListaAss.Eof
            or (cdsListaAss.FieldByName('PROGRESSIVO').AsInteger <> Progressivo)
            or (cdsListaAss.FieldByName('DATA').AsDateTime <> Data);
          //Testo con le causali fruite
          if Causali <> '' then
            TestoOrig:=TestoOrig + '<span style="position:absolute; left:0px; top:0px; width:100%; height:100%; z-index:8; background-color:transparent; padding-left:2px;">#CAUSALI#</span>';
          TestoOrig:=TestoOrig + '</div>';
          if ACell.Hint <> '' then
            ACell.Css:=ACell.Css + ' tooltipHtml';
          //Se la cella non contiene richieste autorizzabili...
          if grdProspetto.medpCompGriglia[r].CompColonne[c] = nil then
          begin
            //...gestisco tutto nel testo della cella
            ACell.RawText:=True;
            for x:=1 to NRigheCausali do
              Spazi:=Spazi + '&nbsp;<br>';
            Testo:=StringReplace(TestoOrig,'#SPAZI#',Spazi,[rfReplaceAll]);
            Testo:=StringReplace(Testo,'#CAUSALI#',StringReplace(Causali,',','<br>',[rfReplaceAll]),[rfReplaceAll]);
            ACell.Text:=Testo;
          end
          //Se la cella contiene richieste autorizzabili...
          else
          begin
            //...gestisco tutto nel testo dei componenti della grid della cella
            ACell.Control:=grdProspetto.medpCompGriglia[r].CompColonne[c];
            (ACell.Control as TmeIWGrid).Css:='gridProspetto';
            for x:=0 to (grdProspetto.medpCompGriglia[r].CompColonne[c] as TmeIWGrid).RowCount - 1 do
            begin
              Testo:=StringReplace(TestoOrig,'#SPAZI#','&nbsp;',[rfReplaceAll]);
              if grdProspetto.medpCompCella(r,c,x) is TmeIWLink then
              begin
                FontWeight:='normal';
                if fsBold in (grdProspetto.medpCompCella(r,c,x) as TmeIWLink).Font.Style then
                  FontWeight:='bold';
                //Testo:=StringReplace(Testo,'#CAUSALI#','<u style="color:blue; font-weight:%s;">' + Copy(Causali,1,Pos(',',Causali) - 1) + '</u>',[rfReplaceAll]);
                Testo:=StringReplace(Testo,'#CAUSALI#',Format('<u style="color:blue; font-weight:%s;">%s</u>',[FontWeight,Copy(Causali,1,Pos(',',Causali) - 1)]),[rfReplaceAll]);
                with (grdProspetto.medpCompCella(r,c,x) as TmeIWLink) do
                begin
                  RawText:=True;
                  Text:=Testo;
                  Css:='';
                end;
              end
              else if grdProspetto.medpCompCella(r,c,x) is TmeIWLabel then
              begin
                Testo:=StringReplace(Testo,'#CAUSALI#',Copy(Causali,1,Pos(',',Causali) - 1),[rfReplaceAll]);
                with (grdProspetto.medpCompCella(r,c,x) as TmeIWLabel) do
                begin
                  RawText:=True;
                  Text:=Testo;
                  Css:='';
                end;
              end;
              Causali:=Copy(Causali,Pos(',',Causali) + 1);
            end;
          end;
        end;
      end;
    end;
end;

procedure TW033FProspettoAssenze.imgDeselezionaTuttoGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=False;
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.imgInvertiSelezioneGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=not cgpGiustificativi.IsChecked[i];
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.imgSelezionaTuttoGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=True;
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.btnEseguiClick(Sender: TObject);
var PeriodoCambiato:Boolean;
    i:Integer;
    Caus: String;
begin
  //Tipologie
  ElencoTipi:='';
  for i:=0 to cgpTipologie.Items.Count - 1 do
    if cgpTipologie.IsChecked[i] then
      ElencoTipi:=ElencoTipi + '''' + IfThen(i = 0,'I',IfThen(i = 1,'M',IfThen(i = 2,'N','D'))) + ''',';
  ElencoTipi:=Copy(ElencoTipi,1,Length(ElencoTipi)-1);
  //Giustificativi
  ElencoGiust:='';
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
  begin
    if cgpGiustificativi.IsChecked[i] then
    begin
      Caus:=Copy(cgpGiustificativi.Items[i],1,Pos(' ',cgpGiustificativi.Items[i]) - 1);
      ElencoGiust:=ElencoGiust + '''' + Caus + ''',';
    end;
  end;
  ElencoGiust:=Copy(ElencoGiust,1,Length(ElencoGiust) - 1);
  //Salvo i parametri di esecuzione
  PutParametriFunzione;
  //Se tutte le causali sono deselezionate, allora le considero tutte
  if ElencoGiust = '' then
  begin
    for i:=0 to cgpGiustificativi.Items.Count - 1 do
    begin
      Caus:=Copy(cgpGiustificativi.Items[i],1,Pos(' ',cgpGiustificativi.Items[i]) - 1);
      ElencoGiust:=ElencoGiust + '''' + Caus + ''',';
    end;
  end;
  //Periodo
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtDal.Text)) or (Al <> StrToDate(edtAl.Text));
    Dal:=StrToDate(edtDal.Text);
    Al:=StrToDate(edtAl.Text);
    if Al < Dal then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
    if Al > R180AddMesi(Dal,12) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W033_MSG_PERIODO_MINORE_DI_12));
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;
  if PeriodoCambiato then
  begin
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;
  end;
  FiltroDip:=selAnagrafeW.SubstitutedSql;
  ElaboraProspetto;
  if Sender <> nil then
    tabProspettoAssenze.ActiveTab:=W033ProspettoRG;
end;

procedure TW033FProspettoAssenze.RefreshPage;
begin
  WR000DM.Responsabile:=AutorizzazioneRichieste;

  // se il tab attivo è quello del prospetto, lo aggiorna
  //VisualizzaGriglia;
  if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
    btnEseguiClick(nil);
end;

procedure TW033FProspettoAssenze.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
  end;
  FreeAndNil(C004FParamFormPrv);
  FreeAndNil(W033DM);
  // empoli - commessa 2012/102.ini
  FreeAndNil(W010DM);
  FreeAndNil(C018Canc);
  // empoli - commessa 2012/102.fine
end;

end.

unit P555UContoAnnuale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Menus, Buttons,
  ExtCtrls, ComCtrls, StdCtrls, DBCtrls,  Mask, ImgList, ToolWin, ActnList,
  C180FUNZIONIGENERALI, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi, A003UDataLavoroBis,
  C005UDatiAnagrafici, Grids, DBGrids, OracleData, Db, SelAnagrafe, Variants,C013UCheckList,
  Spin, Oracle, Printers, ToolbarFiglio, C015UElencoValori;

type
  TP555FContoAnnuale = class(TR001FGestTab)
    pnlTestata: TPanel;
    dchkChiuso: TDBCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    lblDataChiusura: TLabel;
    dedtDataChiusura: TDBEdit;
    lblIdINPDAPMM: TLabel;
    dedtIdContoAnn: TDBEdit;
    pnlDettaglio: TPanel;
    dgrdContoAnn: TDBGrid;
    pnlIntestazioneGriglia: TPanel;
    pnlVisualizzazioneVoci: TPanel;
    btnFiltroColonna: TBitBtn;
    btnFiltroRiga: TBitBtn;
    rgpTipoDati: TRadioGroup;
    cmbRicerca: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dedtAnno: TDBEdit;
    DBText1: TDBText;
    mnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    pnlPulsanti: TPanel;
    BChiudi: TBitBtn;
    BSalva: TBitBtn;
    SaveDialog1: TSaveDialog;
    PrinterSetupDialog2: TPrinterSetupDialog;
    dgrdRiepTab: TDBGrid;
    mnuVisDip: TPopupMenu;
    Visualizzadipendenti1: TMenuItem;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure Visualizzadipendenti1Click(Sender: TObject);
    procedure BStampanteClick(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure cmbRicercaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaCloseUp(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dgrdContoAnnEditButtonClick(Sender: TObject);
    procedure btnFiltroColonnaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFiltroRigaClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure frmToolbarFiglioactTFCopiaSuExecute(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    RigSel,ColSel: String;
    Elenco:TStringList;
    SalvaIndex:Integer;
    function LunghezzaCampo(F:TField):Integer;
    procedure CaricaVariabili;
    procedure ElaboraVariabili;
    procedure ElaboraVar;
    procedure TrovaVariabili;

    procedure CambiaProgressivo;
    procedure CostruisciGriglia;
  public
    { Public declarations }
    procedure Aggiorna;
    procedure AggiornaRiepTabellari;
    procedure AbilitazioniComponenti;
  end;

var
  P555FContoAnnuale: TP555FContoAnnuale;

procedure OpenP555FContoAnnuale(Prog:LongInt);

implementation

uses P555UContoAnnualeDtM, P555UElencoDipendenti;

{$R *.DFM}

procedure OpenP555FContoAnnuale(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP555FContoAnnuale') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP555FContoAnnuale, P555FContoAnnuale);
  C700Progressivo:=Prog;
  Application.CreateForm(TP555FContoAnnualeDtM, P555FContoAnnualeDtM);
  try
    Screen.Cursor:=crDefault;
    P555FContoAnnuale.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P555FContoAnnuale.Free;
    P555FContoAnnualeDtM.Free;
  end;
end;

procedure TP555FContoAnnuale.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=P555FContoAnnualeDtM.dsrP555;
  frmToolbarFiglio.TFDBGrid:=dgrdContoAnn;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,6);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[4]:=pnlTestata;
  frmToolbarFiglio.lstLock[5]:=pnlVisualizzazioneVoci;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  A000SettaVariabiliAmbiente;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
  DButton.DataSet:=P555FContoAnnualeDtM.selP554;
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actGomma.Visible:=False;
  rgpTipoDati.ItemIndex:=0;
  P555FContoAnnuale.WindowState:=wsMaximized;
end;

procedure TP555FContoAnnuale.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  try
    C700DataLavoro:=R180FineMese(StrToDate('31/12/'+dedtAnno.Text));
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  if C700DataLavoro = 0 then
    C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP555FContoAnnuale.frmToolbarFiglioactTFCopiaSuExecute(
  Sender: TObject);
var RigaOrig,ColonnaOrig:Integer;
  ValoreOrig:Real;
begin
  with P555FContoAnnualeDtM.selP555 do
  begin
    RigaOrig:=FieldByName('RIGA').AsInteger;
    ColonnaOrig:=FieldByName('COLONNA').AsInteger;
    ValoreOrig:=FieldByName('VALORE').AsFloat;
    frmToolbarFiglio.actTFInserisciExecute(frmToolbarFiglio.actTFInserisci);
    FieldByName('RIGA').AsInteger:=RigaOrig;
    FieldByName('COLONNA').AsInteger:=ColonnaOrig;
    FieldByName('VALORE').AsFloat:=ValoreOrig;
  end;
end;

procedure TP555FContoAnnuale.CambiaProgressivo;
begin
  C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.Aggiorna;
begin
  with P555FContoAnnualeDtM do
  begin
    selP552Riga.Close;
    selP552Riga.SetVariable('COD_TABELLA',selP554.FieldByName('COD_TABELLA').AsString);
    selP552Riga.SetVariable('ANNO',AnnoRegole);
    selP552Riga.Open;
    selP552Col.Close;
    selP552Col.SetVariable('COD_TABELLA',selP554.FieldByName('COD_TABELLA').AsString);
    selP552Col.SetVariable('ANNO',AnnoRegole);
    selP552Col.Open;
    selP555.Close;
    selP555.SetVariable('ANNOREGOLE',AnnoRegole);
    selP555.SetVariable('ID_CONTOANN',selP554.FieldByName('ID_CONTOANN').AsInteger);
    if P555FContoAnnuale.rgpTipoDati.ItemIndex = 0 then
      selP555.SetVariable('PROGRESSIVO',C700Progressivo)
    else
      selP555.SetVariable('PROGRESSIVO',-1);
    selP555.SetVariable('FILTRO',' ');
    selP555.Open;
  end;
end;

procedure TP555FContoAnnuale.cmbRicercaCloseUp(Sender: TObject);
begin
  inherited;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.cmbRicercaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  cmbRicercaCloseUp(nil);
end;


procedure TP555FContoAnnuale.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP555FContoAnnuale.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT');
  QueryStampa.Add('T2.anno,');
  QueryStampa.Add('T2.cod_tabella,');
  QueryStampa.Add('T2.id_contoann,');
  QueryStampa.Add('T2.chiuso,');
  QueryStampa.Add('T2.data_chiusura,');
  QueryStampa.Add('T1.progressivo,');
  QueryStampa.Add('T1.riga,');
  QueryStampa.Add('T1.colonna,');
  QueryStampa.Add('T1.valore');
  QueryStampa.Add('FROM P555_CONTOANNDATIINDIVIDUALI T1, P554_CONTOANNTESTATE T2');
  QueryStampa.Add('WHERE T1.ID_CONTOANN=T2.ID_CONTOANN');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T2.anno');
  NomiCampiR001.Add('T2.cod_tabella');
  NomiCampiR001.Add('T2.id_contoann');
  NomiCampiR001.Add('T2.chiuso');
  NomiCampiR001.Add('T2.data_chiusura');
  NomiCampiR001.Add('T1.progressivo');
  NomiCampiR001.Add('T1.riga');
  NomiCampiR001.Add('T1.colonna');
  NomiCampiR001.Add('T1.valore');
  inherited;
end;

procedure TP555FContoAnnuale.AbilitazioniComponenti;
var Abilita: Boolean;
begin
  if frmToolbarFiglio.TFDButton = nil then
    Exit;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  Abilita:=(P555FContoAnnualeDtM.selP555.ReadOnly) and (not SolaLettura) and (P555FContoAnnualeDtM.selP554.FieldByName('CHIUSO').AsString <> 'S') and (rgpTipoDati.ItemIndex = 0);
  frmToolbarFiglio.actTFCopiaSu.Enabled:=Abilita;
  frmToolbarFiglio.actTFInserisci.Enabled:=Abilita;
  frmToolbarFiglio.actTFModifica.Enabled:=Abilita;
  frmToolbarFiglio.actTFCancella.Enabled:=Abilita;
  frmToolbarFiglio.Visible:=rgpTipoDati.ItemIndex < 2;
  pnlVisualizzazioneVoci.Visible:=rgpTipoDati.ItemIndex < 2;
  dgrdContoAnn.Visible:=rgpTipoDati.ItemIndex < 2;
  dgrdRiepTab.Visible:=rgpTipoDati.ItemIndex = 2;
  pnlPulsanti.Visible:=rgpTipoDati.ItemIndex = 2;
  Visualizzadipendenti1.Enabled:=rgpTipoDati.ItemIndex = 1;
  actCancella.Enabled:=Abilita;
  frmSelAnagrafe.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TP555FContoAnnuale.dgrdContoAnnEditButtonClick(Sender: TObject);
var vCodice:Variant;
begin
  with P555FContoAnnualeDtM do
  begin
    if selP555.ReadOnly then
      exit;
    case dgrdContoAnn.SelectedIndex of
      0: begin          //Numero dato da elenco
           if Trim(selP555.FieldByName('RIGA').AsString) <> '' then
             vCodice:=VarArrayOf([AnnoRegole,selP555.FieldByName('RIGA').AsString])
           else
             vCodice:=VarArrayOf([AnnoRegole,1]);
           OpenC015FElencoValori('P552_CONTOANNREGOLE','<P555> Elenco dati',selP552Riga.SQL.Text,'ANNO;RIGA',vCodice,selP552Riga,500,300);
           if not VarIsClear(vCodice) then
           begin
             selP555.FieldByName('RIGA').AsString:=VarToStr(vCodice[1]);
             selP555.FieldByName('DESC_RIGA').AsString:=VarToStr(selP552Riga.Lookup('ANNO;RIGA',VarArrayOf([AnnoRegole,vCodice[1]]),'DESCRIZIONE'));
           end;
         end;
      3: begin        //Numero dato da elenco
           if Trim(selP555.FieldByName('COLONNA').AsString) <> '' then
             vCodice:=VarArrayOf([AnnoRegole,selP555.FieldByName('COLONNA').AsString])
           else
             vCodice:=VarArrayOf([AnnoRegole,1]);
           OpenC015FElencoValori('P552_CONTOANNREGOLE','<P555> Elenco dati',selP552Col.SQL.Text,'ANNO;COLONNA',vCodice,selP552Col,500,300);
           if not VarIsClear(vCodice) then
           begin
             selP555.FieldByName('COLONNA').AsString:=VarToStr(vCodice[1]);
             selP555.FieldByName('DESC_COLONNA').AsString:=VarToStr(selP552Col.Lookup('ANNO;COLONNA',VarArrayOf([AnnoRegole,vCodice[1]]),'DESCRIZIONE'));
           end;
         end;
    end;
  end;
end;

procedure TP555FContoAnnuale.btnFiltroRigaClick(Sender: TObject);
var C013FCheckListRiga:TC013FCheckList;
  s:String;
begin
  with P555FContoAnnualeDtM do
  begin
    C013FCheckListRiga:=TC013FCheckList.Create(nil);
    try
      C013FCheckListRiga.Caption:='<P555> Filtro Riga';
      C013FCheckListRiga.clbListaDati.Clear;
      selP552Riga.First;
      while not selP552Riga.Eof do
      begin
        C013FCheckListRiga.clbListaDati.Items.Add(Format('%-3s',[selP552Riga.FieldByName('RIGA').AsString]) + ' ' + Format('%-100s',[selP552Riga.FieldByName('DESCRIZIONE').AsString]));
        selP552Riga.Next;
      end;
      R180PutCheckList(RigSel, 3, C013FCheckListRiga.clbListaDati);
      if C013FCheckListRiga.ShowModal = mrOK then
      begin
        //Modifico la query aggiungendo il filtro sulle voci selezionate
        RigSel:=R180GetCheckList(3,C013FCheckListRiga.clbListaDati);
        selP555.Close;
        selP555.SetVariable('ANNOREGOLE',AnnoRegole);
        selP555.SetVariable('ID_CONTOANN',selP554.FieldByName('ID_CONTOANN').AsInteger);
        if rgpTipoDati.ItemIndex = 0 then
          selP555.SetVariable('PROGRESSIVO',C700Progressivo)
        else
          selP555.SetVariable('PROGRESSIVO',-1);
        s:=' ';
        if Trim(RigSel) <> '' then
          s:=s + ' AND P552R.RIGA IN (' + RigSel + ')';
        if Trim(ColSel) <> '' then
          s:=s + ' AND P552C.COLONNA IN (' + ColSel + ')';
        selP555.SetVariable('FILTRO',s);
        selP555.Open;
      end;
    except
      FreeAndNil(C013FCheckListRiga);
    end;
  end;
end;

procedure TP555FContoAnnuale.btnFiltroColonnaClick(Sender: TObject);
var C013FCheckListCol:TC013FCheckList;
  s:String;
begin
  with P555FContoAnnualeDtM do
  begin
    C013FCheckListCol:=TC013FCheckList.Create(nil);
    try
      C013FCheckListCol.Caption:='<P555> Filtro Colonna';
      C013FCheckListCol.clbListaDati.Clear;
      selP552Col.First;
      while not selP552Col.Eof do
      begin
        C013FCheckListCol.clbListaDati.Items.Add(Format('%-3s',[selP552Col.FieldByName('COLONNA').AsString]) + ' ' + Format('%-100s',[selP552Col.FieldByName('DESCRIZIONE').AsString]));
        selP552Col.Next;
      end;
      R180PutCheckList(ColSel, 3, C013FCheckListCol.clbListaDati);
      if C013FCheckListCol.ShowModal = mrOK then
      begin
        ColSel:=R180GetCheckList(3,C013FCheckListCol.clbListaDati);
        //Modifico la query aggiungendo il filtro sulle voci selezionate
        selP555.Close;
        selP555.SetVariable('ANNOREGOLE',AnnoRegole);
        selP555.SetVariable('ID_CONTOANN',selP554.FieldByName('ID_CONTOANN').AsInteger);
        if rgpTipoDati.ItemIndex = 0 then
          selP555.SetVariable('PROGRESSIVO',C700Progressivo)
        else
          selP555.SetVariable('PROGRESSIVO',-1);
        s:=' ';
        if Trim(RigSel) <> '' then
          s:=s + ' AND P552R.RIGA IN (' + RigSel + ')';
        if Trim(ColSel) <> '' then
          s:=s + ' AND P552C.COLONNA IN (' + ColSel + ')';
        selP555.SetVariable('FILTRO',s);
        selP555.Open;
      end;
    except
      FreeAndNil(C013FCheckListCol);
    end;
  end;
end;

procedure TP555FContoAnnuale.TCancClick(Sender: TObject);
var
  sInputConf:String;
begin
  with P555FContoAnnualeDtM do
  begin
    selP555canc.Close;
    selP555canc.SetVariable('IdContoAnn', selP554.FieldByName('ID_CONTOANN').AsInteger);
    selP555canc.Open;
    if (R180MessageBox('Attenzione: la cancellazione comporta l''eliminazione della testata e dei dati elaborati ' + Chr(10) +
     'di ' + selP555canc.FieldByName('NUMDIP').AsString + ' dipendenti. Confermi l''operazione? ',DOMANDA) = mrNo) then
      exit;
    sInputConf:= InputBox('Cancellazione di ' + selP555canc.FieldByName('NUMDIP').AsString + ' dip.' ,'Inserire il numero di dipendenti che verranno cancellati:', '0');
    if (sInputConf = '0') or (sInputConf <> selP555canc.FieldByName('NUMDIP').AsString) then
    begin
      R180MessageBox('Operazione annullata.',INFORMA);
      exit;
    end;
  end;
  inherited;
end;

procedure TP555FContoAnnuale.rgpTipoDatiClick(Sender: TObject);
begin
  if rgpTipoDati.ItemIndex < 2 then
    SalvaIndex:=rgpTipoDati.ItemIndex;
  P555FContoAnnualeDtM.selP554.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsInteger,VarToStr(cmbRicerca.KeyValue)]),[srFromBeginning]);
end;

procedure TP555FContoAnnuale.AggiornaRiepTabellari;
begin
  if P555FContoAnnualeDtM.selP552.SearchRecord('COD_TABELLA',VarToStr(cmbRicerca.KeyValue),[srFromBeginning]) then
  begin
    if P555FContoAnnualeDtM.selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString <> '' then
    begin
      P555FContoAnnualeDtM.selQuery.Close;
      P555FContoAnnualeDtM.selQuery.SQL.Text:='';
      P555FContoAnnualeDtM.selQuery.SQL.Text:=P555FContoAnnualeDtM.selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString;
      CaricaVariabili;
      ElaboraVariabili;
      P555FContoAnnualeDtM.selQuery.Open;
      CostruisciGriglia;
      if P555FContoAnnualeDtM.selQuery.RecordCount > 0 then
        BSalva.Enabled:=True
      else
        BSalva.Enabled:=False;
    end
    else
    begin
      R180MessageBox('Query calcolo manuale inesistente per la tabella selezionata!','ERRORE');
      rgpTipoDati.ItemIndex:=SalvaIndex;
    end;
  end
  else
  begin
    R180MessageBox('Query calcolo manuale inesistente per l''' + 'anno selezionato!', 'ERRORE');
    rgpTipoDati.ItemIndex:=SalvaIndex;
  end;
end;

procedure TP555FContoAnnuale.CostruisciGriglia;
var i:Integer;
    Campi:TStringList;
begin
  with P555FContoAnnualeDtM do
  begin
    Campi:=TStringList.Create;
    Campi.Clear;
    selQuery.GetFieldNames(Campi);
    for i:=0 to Campi.Count - 1 do
    begin
      LungCampi.Close;
      LungCampi.SQL.Text:='';
      LungCampi.SQL.Add('select max(length(' + '"' + Campi[i] + '"' + ')) lunghezza from');
      LungCampi.SQL.Add('(' + selQuery.SQL.Text + ')');
      CaricaVariabili;
      ElaboraVar;
      LungCampi.Open;
      if length(Campi[i]) > LungCampi.FieldByName('LUNGHEZZA').AsInteger then
        selQuery.FieldByName(Campi[i]).DisplayWidth:=length(Campi[i])
      else
        selQuery.FieldByName(Campi[i]).DisplayWidth:=LungCampi.FieldByName('LUNGHEZZA').AsInteger;
    end;
    FreeAndNil(Campi);
  end;
end;

procedure TP555FContoAnnuale.ElaboraVar;
begin
  with P555FContoAnnualeDtM do
  begin
    LungCampi.DeleteVariables;
    if cdsValori.RecordCount = 0 then
      Exit;
    cdsValori.First;
    while not cdsValori.Eof do
    begin
      if cdsValori.FieldByName('VARIABILE').AsString = 'P555' then
        LungCampi.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
      else
        LungCampi.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otString);
      LungCampi.SetVariable(cdsValori.FieldByName('VARIABILE').AsString,cdsValori.FieldByName('VALORE').AsString);
      cdsValori.Next;
    end;
  end;
end;

procedure TP555FContoAnnuale.CaricaVariabili;
var i:Integer;
    Valori:TStringList;
begin
  Elenco:=TStringList.Create;
  Elenco.Clear;
  TrovaVariabili;
  with P555FContoAnnualeDtM.cdsValori do
  begin
    Close;
    CreateDataset;
    Open;
    LogChanges:=False;
    FieldByName('VARIABILE').ReadOnly:=False;
    for i:=0 to Elenco.Count - 1 do
    begin
      Insert;
      FieldByName('VARIABILE').AsString:=Elenco[i];
      if UpperCase(FieldByName('VARIABILE').AsString) ='PROGRESSIVO' then
        FieldByName('VALORE').AsString:='-1'
      else if UpperCase(FieldByName('VARIABILE').AsString) ='CODTABELLA' then
        FieldByName('VALORE').AsString:=VarToStr(cmbRicerca.KeyValue)
      else if UpperCase(FieldByName('VARIABILE').AsString) ='ANNOELABORAZIONE' then
        FieldByName('VALORE').AsString:=P555FContoAnnualeDtM.selP554.FieldByName('ANNO').AsString
      else if UpperCase(FieldByName('VARIABILE').AsString) ='P555' then
        FieldByName('VALORE').AsString:='P555_CONTOANNDATIINDIVIDUALI';
      Post;
    end;
    FieldByName('VARIABILE').ReadOnly:=True;
  end;
  SessioneOracle.Commit;
  FreeAndNil(Elenco);
  FreeAndNil(Valori);
end;

procedure TP555FContoAnnuale.TrovaVariabili;
var Variabile,Stringa:String;
    x:Integer;
begin
  Stringa:=EliminaRitornoACapo(P555FContoAnnualeDtM.selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString);
  while Stringa <> '' do
  begin
    Variabile:='';
    x:=Pos(':',Stringa) + 1;
    if x = 1 then
      Break;
    while (Stringa[x] in ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']) or
      (Stringa[x] in ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']) or
      (Stringa[x] in ['1','2','3','4','5','6','7','8','9','0','_']) do
    begin
      Variabile:=Variabile+Copy(Stringa,x,1);
      x:=x+1;
    end;
    if Elenco.IndexOf(Variabile) = -1 then
      Elenco.Add(Variabile);
    Stringa:=Copy(Stringa,x,Length(Stringa) - x +1);
  end;
  Elenco.Sort;
end;

procedure TP555FContoAnnuale.ElaboraVariabili;
begin
  with P555FContoAnnualeDtM do
  begin
    selQuery.DeleteVariables;
    if cdsValori.RecordCount = 0 then
      Exit;
    cdsValori.First;
    while not cdsValori.Eof do
    begin
      if cdsValori.FieldByName('VARIABILE').AsString = 'P555' then  //Lorena 24/04/2009
        selQuery.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
      else
        selQuery.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otString);
      selQuery.SetVariable(cdsValori.FieldByName('VARIABILE').AsString,cdsValori.FieldByName('VALORE').AsString);
      cdsValori.Next;
    end;
  end;
end;

procedure TP555FContoAnnuale.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'S');
end;

procedure TP555FContoAnnuale.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'N');
end;

procedure TP555FContoAnnuale.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdRiepTab,'C');
end;

procedure TP555FContoAnnuale.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdRiepTab,Sender = CopiaInExcel);
end;

procedure TP555FContoAnnuale.BSalvaClick(Sender: TObject);
var F:TextFile;
    i:Integer;
    S:String;
    Intestazione:Boolean;
begin
  Intestazione:=False;
  if R180MessageBox('Salvare anche l''intestazione delle colonne?','DOMANDA') = mrYes then
    Intestazione:=True;
  if not SaveDialog1.Execute then exit;
  AssignFile(F,SaveDialog1.FileName);
  Rewrite(F);
  with P555FContoAnnualeDtM.selQuery do
  begin
    First;
    DisableControls;
    if Intestazione then
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,Lunghezzacampo(Fields[i]))]);
      writeln(F,S);
    end;
    while not Eof do
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]), Copy(Fields[i].AsString,1,Lunghezzacampo(Fields[i]))]);
      writeln(F,S);
      Next;
    end;
    First;
    EnableControls;
  end;
  CloseFile(F);
end;

procedure TP555FContoAnnuale.BStampanteClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

function TP555FContoAnnuale.LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount then
    inc(Result);
end;

procedure TP555FContoAnnuale.cmbRicercaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    (Sender as TDBLookupComboBox).KeyValue:=P555FContoAnnualeDtM.selP552.FieldByName('COD_TABELLA').AsString;
end;

procedure TP555FContoAnnuale.Visualizzadipendenti1Click(Sender: TObject);
begin
  inherited;
  with P555FContoAnnualeDtM.selP555 do
    OpenP555ElencoDipendenti(StrToIntDef(dedtAnno.Text,0),FieldByName('COLONNA').AsInteger,FieldByName('RIGA').AsInteger,VarToStr(cmbRicerca.KeyValue));
end;

end.


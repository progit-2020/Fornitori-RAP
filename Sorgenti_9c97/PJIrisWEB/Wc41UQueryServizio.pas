unit Wc41UQueryServizio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A000UInterfaccia, OracleData, IWCompListbox, meIWComboBox,
  Wc41UQueryServizioDM, IWCompExtCtrls, meIWImageButton, IWCompGrids, IWDBGrids,
  medpIWDBGrid, meIWDBGrid, db, Vcl.Menus;

type
  TWc41FQueryServizio = class(TR012FWebAnagrafico)
    cmbRaggruppamenti: TmeIWComboBox;
    cmbInterrogazioni: TmeIWComboBox;
    btnEsegui: TmeIWImageButton;
    grdQuery: TmedpIWDBGrid;
    grdVariabili: TmedpIWDBGrid;
    pmnExcel: TPopupMenu;
    EsportainExcel1: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure cmbInterrogazioniChange(Sender: TObject);
    procedure cmbRaggruppamentiChange(Sender: TObject);
    procedure EsportainExcel1Click(Sender: TObject);
  private
    { Private declarations }
    Wc41DM:TWc41FQueryServizioDM;
    procedure CaricaComboInterrogazioni;
    procedure SettaGrdVariabili;
    procedure CaricamentoWc41Query(NomeQuery:string);
    procedure EseguiQueryFiltrata(RefreshC700:Boolean);
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure OnCambiaProgressivo; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    //procedure VisualizzaDipendenteCorrente; override;
  end;

implementation

{$R *.dfm}

procedure TWc41FQueryServizio.btnEseguiClick(Sender: TObject);
var
  r:integer;
begin
  inherited;
  Wc41DM.TuttiDipSelezionato:=TuttiDipSelezionato;
  Wc41DM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  if grdVariabili.medpDataSet.State in [dsInsert,dsEdit] then
    grdVariabili.medpDataSet.Cancel;
  grdVariabili.medpDataSet.Filtered:=True;
  grdVariabili.medpDataSet.First;
  for r:=0 to High(grdVariabili.medpCompGriglia) do
  begin
    grdVariabili.medpDataSet.Edit;
    grdVariabili.medpConferma(r);
    grdVariabili.medpDataSet.Next;
  end;
  grdVariabili.medpDataSet.Filtered:=False;
  Wc41DM.A062MW.EseguiQuery;

  grdQuery.medpAttivaGrid(Wc41DM.A062MW.Q1,False,False);
  EseguiQueryFiltrata(False);
  grdQuery.Visible:=True;
end;

procedure TWc41FQueryServizio.OnCambiaProgressivo;
begin
  inherited;
  Wc41DM.TuttiDipSelezionato:=TuttiDipSelezionato;
  if Not Wc41DM.A062MW.Q1.Active then
    Exit;

  EseguiQueryFiltrata(True);
end;

procedure TWc41FQueryServizio.EseguiQueryFiltrata(RefreshC700:Boolean);
var EsistonoVariabili:Boolean;
begin
  Wc41DM.A062MW.Q1.Filtered:=False;
  Wc41DM.A062MW.Q1.Filter:='';
  EsistonoVariabili:=False;
  if VarToStr(Wc41DM.A062MW.cdsValori.Lookup('VARIABILE','C700SelAnagrafe','VARIABILE')) <> '' then
  begin
    EsistonoVariabili:=True;
    Wc41DM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  end
  else if Wc41DM.A062MW.Q1.FindField('PROGRESSIVO') <> nil then
  begin
    EsistonoVariabili:=True;
    Wc41DM.A062MW.Q1.Filter:='PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    Wc41DM.A062MW.Q1.Filtered:=not TuttiDipSelezionato;
  end
  else if Wc41DM.A062MW.Q1.FindField('MATRICOLA') <> nil then
  begin
    EsistonoVariabili:=True;
    Wc41DM.A062MW.Q1.Filter:='MATRICOLA = ''' + selAnagrafeW.FieldByName('MATRICOLA').AsString + '''';
    Wc41DM.A062MW.Q1.Filtered:=not TuttiDipSelezionato;
  end;

  if EsistonoVariabili then
  begin
    //Rieseguo la query solo se intervengo sulla variabile C700SelAnagrafe (filtro sulla query)
    if (Wc41DM.A062MW.Q1.Filter = '') and (RefreshC700) then
      Wc41DM.A062MW.EseguiQuery;
    grdQuery.medpAggiornaCDS(True);
  end;
end;

procedure TWc41FQueryServizio.EsportainExcel1Click(Sender: TObject);
begin
  //Esporto in excel
  InviaFile('Interrogazione di servizio.xls',grdQuery.ToCsv);
end;

procedure TWc41FQueryServizio.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=not Parametri.InibizioneIndividuale;
  inherited;
  cmbDipendentiDisponibili.ItemIndex:=0;
end;


procedure TWc41FQueryServizio.CaricaComboInterrogazioni;
begin
  if cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex] = 'Tutte le interrogazioni' then
    Wc41DM.A062MW.OpenSelT002(Wc41DM.selT002,'')
  else
    Wc41DM.A062MW.OpenSelT002(Wc41DM.selT002,cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);
  cmbInterrogazioni.Items.Clear;
  Wc41DM.selT002.First;
  while not Wc41DM.selT002.Eof do
  begin
    cmbInterrogazioni.Items.Add(Wc41DM.selT002.FieldByName('NOME').AsString);
    Wc41DM.selT002.Next;
  end;
  cmbInterrogazioni.ItemIndex:=0;
end;

procedure TWc41FQueryServizio.CaricamentoWc41Query(NomeQuery:string);
begin
  Wc41DM.A062MW.SqlNome:=NomeQuery;
  Wc41DM.A062MW.SqlSelezioneList.Clear;
  Wc41DM.A062MW.cdsValori.FieldByName('TIPO').ReadOnly:=False;
  Wc41DM.A062MW.CaricaQuery;
  {Solo per IrisWeb inibisco la modifica del tipo è svuoto il valore}
  Wc41DM.A062MW.cdsValori.FieldByName('TIPO').ReadOnly:=True;
  Wc41DM.A062MW.cdsValori.First;
  while not Wc41DM.A062MW.cdsValori.Eof do
  begin
    Wc41DM.A062MW.cdsValori.Edit;
    Wc41DM.A062MW.cdsValori.FieldByName('VALORE').Clear;
    Wc41DM.A062MW.cdsValori.Post;
    Wc41DM.A062MW.cdsValori.Next;
  end;
end;

procedure TWc41FQueryServizio.cmbInterrogazioniChange(Sender: TObject);
begin
  inherited;
  SettaGrdVariabili;
end;

procedure TWc41FQueryServizio.cmbRaggruppamentiChange(Sender: TObject);
begin
  inherited;
  CaricaComboInterrogazioni;
  SettaGrdVariabili;
end;

procedure TWc41FQueryServizio.SettaGrdVariabili;
begin
  grdVariabili.Visible:=False;
  if cmbInterrogazioni.Items.Count > 0 then
  begin
    CaricamentoWc41Query(cmbInterrogazioni.Items[cmbInterrogazioni.ItemIndex]);
    grdVariabili.medpDataSet.Cancel;
    Wc41DM.A062MW.cdsValori.Filtered:=True;
    grdVariabili.medpAggiornaCDS(True);
    if grdVariabili.medpDataSet.RecordCount > 0 then
      grdVariabili.medpModifica(False);
    grdQuery.Visible:=False;
    Wc41DM.A062MW.Q1.Filter:='';
    Wc41DM.A062MW.Q1.Filtered:=False;
    grdVariabili.Visible:=grdVariabili.medpDataSet.RecordCount > 0;
  end;
end;

function TWc41FQueryServizio.InizializzaAccesso:Boolean;
begin
  Result:=True;
  grdQuery.Visible:=False;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  //Inizializzazione parametri grdQuery
  grdQuery.medpRighePagina:=GetRighePaginaTabella;
  grdQuery.medpDataSet:=Wc41DM.A062MW.cdsValori;
  grdQuery.medpBrowse:=False;

  Wc41DM.A062MW.CaricaCmbRaggruppamenti(cmbRaggruppamenti.Items); //Caricamento valori cmbRaggruppamenti
  cmbRaggruppamenti.ItemIndex:=cmbRaggruppamenti.Items.IndexOf('Tutte le interrogazioni'); //Set Combobox sul primo valore <Tutti i dipendenti>
  CaricaComboInterrogazioni;
  if cmbInterrogazioni.Items.Count > 0 then
  begin
    //Lettura query ed eventuali variabili prima di esecuzione
    CaricamentoWc41Query(cmbInterrogazioni.Items[cmbInterrogazioni.ItemIndex]);
    //Inizializzazione parametri grdVariabili
    Wc41DM.A062MW.cdsValori.Filter:='VARIABILE <> ''C700SelAnagrafe''';
    Wc41DM.A062MW.cdsValori.Filtered:=True;
    grdVariabili.medpPaginazione:=False;
    grdVariabili.medpDataSet:=Wc41DM.A062MW.cdsValori;
    grdVariabili.medpTestoNoRecord:='Nessuna variabile';
    grdVariabili.medpRowSelect:=False;
    grdVariabili.medpPaginazione:=False;
    grdVariabili.medpEditMultiplo:=True;
    grdVariabili.medpAttivaGrid(Wc41DM.A062MW.cdsValori,True,False,False);
    grdVariabili.medpModifica(False);
    grdVariabili.medpNascondiComandi;
    grdVariabili.Visible:=grdVariabili.medpDataSet.RecordCount > 0;
  end;
end;

{procedure TWc41FQueryServizio.VisualizzaDipendenteCorrente;
begin

end;}

procedure TWc41FQueryServizio.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  grdVariabili.Visible:=False;
  Wc41DM:=TWc41FQueryServizioDM.Create(Self); //Creazione DataModulo
end;

end.

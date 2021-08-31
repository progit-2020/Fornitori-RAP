unit W016UAccessiMensa;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, IWApplication,
  R012UWEBANAGRAFICO, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, IWVCLBaseContainer, IWContainer,RegistrazioneLog,
  IWCompListbox, OracleData, A000USessione, A000UInterfaccia,
  IWCompEdit, IWCompButton, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  DB, R010UPAGINAWEB,
  IWVCLComponent, Forms, Windows, DatiBloccati,
  ActnList,
  meIWGrid, meIWImageFile, meIWCheckBox, IWCompExtCtrls, IWCompGrids, meIWLabel,
  meIWLink, meIWRadioGroup, meIWEdit, meIWComboBox, meIWButton;

type
  TVettAccessi = record
    RowID:String;
    Progressivo:Integer;
    Data:String;
    Causale:String;
    Accessi:Integer;
    PranzoCena:String;
    //Rilevatore:String;
  end;

  TW016FAccessiMensa = class(TR012FWebAnagrafico)
    lblData: TmeIWLabel;
    lblCausale: TmeIWLabel;
    lblNumAccessi: TmeIWLabel;
    btnConferma: TmeIWButton;
    cmbCausale: TmeIWComboBox;
    edtData: TmeIWEdit;
    edtNumAccessi: TmeIWEdit;
    lblPeriodoDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    grdAccessiMensa: TmeIWGrid;
    lblPasto: TmeIWLabel;
    rgpPranzoCena: TmeIWRadioGroup;
    procedure btnEseguiClick(Sender: TObject);
    procedure Pulisci;
    procedure btnConfermaClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdAccessiMensaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnCancellaClick(Sender: TObject);
    procedure grdAccessiMensaCellClick(ASender: TObject; const ARow, AColumn: Integer);
  private
    ListaCausali,ListaDipendenti:TStringList;
    Primo:Boolean;
    VettAccessi:array of TVettAccessi;
    RigaSel:Integer;
    function Controlli:Boolean;
    procedure PulisciGrdAccessiMensa;
    procedure GetAccessi;
    procedure CaricaCausali;
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    Dal,Al:TDateTime;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.dfm}

function TW016FAccessiMensa.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  lnkDipendente.Caption:='';
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  lnkDipendente.Caption:=Format('%s %s - MATRICOLA %s - BADGE %s',
                               [selAnagrafeW.FieldByName('COGNOME').AsString,
                                selAnagrafeW.FieldByName('NOME').AsString,
                                selAnagrafeW.FieldByName('MATRICOLA').AsString,
                                selAnagrafeW.FieldByName('T430BADGE').AsString]);
  btnConferma.Visible:=not SolaLettura;
  with WR000DM.selT375 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DAL', Dal);
    SetVariable('AL', Al);
    Open;
  end;
  GetAccessi;
end;

procedure TW016FAccessiMensa.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);
  btnConferma.Visible:=not SolaLettura;
  ListaCausali:=TStringList.Create;
  ListaDipendenti:=TStringList.Create;
  Primo:=True;
  edtData.Text:=FormatDateTime('dd/mm/yyyy',Now);
  WR000DM.selT375.Open;
  Pulisci;
end;

procedure TW016FAccessiMensa.RefreshPage;
begin
  GetAccessi;
end;

procedure TW016FAccessiMensa.Pulisci;
begin
  edtData.Text:=FormatDateTime('dd/mm/yyyy',Now);
  CaricaCausali;
  edtNumAccessi.Text:='1';
  rgpPranzoCena.ItemIndex:=0;
end;

procedure TW016FAccessiMensa.IWAppFormRender(Sender: TObject);
begin
  inherited;
  cmbDipendentiDisponibili.ItemIndex:=ListaDipendenti.IndexOf(selAnagrafeW.FieldByName('MATRICOLA').AsString);
end;

procedure TW016FAccessiMensa.VisualizzaDipendenteCorrente;
begin
  // inherited // verificare perché non è eseguito!!!
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  InizializzaAccesso;
end;

procedure TW016FAccessiMensa.CaricaCausali;
begin
  with WR000DM.selT305 do
  begin
    Open;
    cmbCausale.Items.Clear;
    cmbCausale.Items.Add(StringReplace(Format('%-5s %s',['*','Senza causale']),' ',SPAZIO,[rfReplaceAll]));
    while not Eof do
    begin
      ListaCausali.Add(FieldByName('CODICE').AsString);
      cmbCausale.Items.Add(StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      Next;
    end;
    Close;
  end;
  cmbCausale.ItemIndex:=0;
end;

procedure TW016FAccessiMensa.GetAccessi;
var nr,nc:Integer;
    CB: TmeIWCheckBox;
    GR: TmeIWGrid;
    app:String;
begin
  PulisciGrdAccessiMensa;
  grdAccessiMensa.ColumnCount:=5;
  //Lettura corsi (Data,Causale,Accessi,Pranzo/Cena,Rilevatore)
  with WR000DM do
  begin
    selT375.Close;
    //selT375.SetVariable('CONDIZIONE','where PROGRESSIVO='+selAnagrafeW.FieldByName('PROGRESSIVO').AsString+' order by DATA');
    selT375.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selT375.SetVariable('DAL', Dal);
    selT375.SetVariable('AL', Al);
    selT375.Open;
    while not selT375.Eof do
    begin
      nr:=Length(VettAccessi);
      SetLength(VettAccessi,nr + 1);
      VettAccessi[nr].RowID:=selT375.RowId;
      VettAccessi[nr].Progressivo:=selT375.FieldByName('PROGRESSIVO').AsInteger;
      VettAccessi[nr].Data:=selT375.FieldByName('DATA').AsString;
      app:=selT375.FieldByName('CAUSALE').AsString;
      selT305.Open;
      if selT305.SearchRecord('CODICE',selT375.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
        VettAccessi[nr].Causale:=StringReplace(Format('%-5s %s %s',[selT305.FieldByName('CODICE').AsString,'- ',selT305.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]);
      selT305.Close;
      VettAccessi[nr].Accessi:=selT375.FieldByName('ACCESSI').AsInteger;
      if selT375.FieldByName('PRANZOCENA').AsString = 'P' then
        VettAccessi[nr].PranzoCena:='Pranzo'
      else
        VettAccessi[nr].PranzoCena:='Cena';
//      VettAccessi[nr].Rilevatore:=selT375.FieldByName('RILEVATORE').AsString;
      selT375.Next;
    end;
  end;
  //Popolazione griglia degli accessi mensa
  with grdAccessiMensa do
  begin
    RowCount:=Length(VettAccessi) + 1;
    nc:=0;
    Cell[0,nc].Text:='';  //Intestazione pulsante Cancella
    inc(nc);
    Cell[0,nc].Text:='Data';
    Cell[0,nc + 1].Text:='Accessi';
    Cell[0,nc + 2].Text:='Causale';
    Cell[0,nc + 3].Text:='Pasto';
    //Cell[0,nc + 4].Text:='Rilevatore';
    for nr:=0 to High(VettAccessi) do
    begin
      nc:=0;
      if not SolaLettura then
      begin
        GR:=TmeIWGrid.Create(WR000DM);
        GR.Height:=20;
        GR.Width:=90;
        GR.ColumnCount:=2;
        GR.RowCount:=1;
        GR.FriendlyName:=VettAccessi[nr].RowID;
        GR.Cell[0,1].Control:=CB;
        Cell[nr + 1,nc].Control:=GR;
      end;
      if (VettAccessi[nr].Data <> '')  then
      begin
        Cell[nr + 1,nc].Control:=TmeIWImageFile.Create(WR000DM);
        with (Cell[nr + 1,nc].Control as TmeIWImageFile) do
        begin
          Css:='icona';
          ImageFile.FileName:=fileImgCancella;
          Hint:='Cancella';
          OnClick:=btnCancellaClick;
          Confirmation:='Eliminare l''accesso selezionato?';
          FriendlyName:=VettAccessi[nr].RowID;
        end;
      end;
      inc(nc);
      Cell[nr + 1,nc].Text:=VettAccessi[nr].Data;
      Cell[nr + 1,nc + 1].Text:=IntToStr(VettAccessi[nr].Accessi);
      Cell[nr + 1,nc + 2].Text:=VettAccessi[nr].Causale;
      Cell[nr + 1,nc + 3].Text:=VettAccessi[nr].PranzoCena;
      //Cell[nr + 1,nc + 4].Text:=VettAccessi[nr].Rilevatore;
      Cell[nr + 1,nc].Clickable:=True;
    end;
  end;
end;

procedure TW016FAccessiMensa.btnCancellaClick(Sender: TObject);
var
  Data:TDateTime;
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  Data:=StrToDate(WR000DM.selT375.FieldByName('DATA').AsString);
  if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data),'T375') then
    raise Exception.Create(WR000DM.selDatiBloccati.MessaggioLog);
  with WR000DM.selT375 do
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      RegistraLog.SettaProprieta('C','T375_ACCESSIMENSA',medpCodiceForm,WR000DM.selT375,True);
      Delete;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
  InizializzaAccesso;
end;

procedure TW016FAccessiMensa.DistruggiOggetti;
begin
  if ListaCausali <> nil then
    FreeAndNil(ListaCausali);
  if ListaDipendenti <> nil then
    FreeAndNil(ListaDipendenti);
  PulisciGrdAccessiMensa;

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selT375.CloseAll; except end;
    try WR000DM.selT305.CloseAll; except end;
  end;
end;

procedure TW016FAccessiMensa.PulisciGrdAccessiMensa;
var i:Integer;
    IWC:TIWCustomControl;
begin
  for i:=1 to grdAccessiMensa.RowCount - 1 do
  try
    IWC:=grdAccessiMensa.Cell[i,0].Control;
    grdAccessiMensa.Cell[i,0].Control:=nil;
    FreeAndNil(IWC);
  except end;
  grdAccessiMensa.Clear;
  SetLength(VettAccessi,0);
end;

function TW016FAccessiMensa.Controlli:Boolean;
var D:TDateTime;
begin
  Result:=False;
  try
    D:=StrToDate(edtData.Text);
  except
    GGetWebApplicationThreadVar.ShowMessage('Specificare la data dell''accesso!');
    ActiveControl:=edtData;
    exit;
  end;
  if (D < StrToDate(edtDal.Text)) or (D > StrToDate(edtAl.Text)) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La data dell''accesso deve essere compreso fra ' + Format('%s e %s',[edtDal.Text,edtAl.Text]));
    ActiveControl:=edtData;
    exit;
  end;
  if (edtNumAccessi.Text = '') or (StrToInt(edtNumAccessi.Text) < 0) or (StrToInt(edtNumAccessi.Text) > 9) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Il numero di accessi deve essere compreso tra 1 e 9!');
    ActiveControl:=edtNumAccessi;
    exit;
  end;
  Result:=True;
end;

procedure TW016FAccessiMensa.btnConfermaClick(Sender: TObject);
var Data:TDateTime;
begin
  Data:=StrToDate(edtData.Text);
  if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data),'T375') then
    raise Exception.Create(WR000DM.selDatiBloccati.MessaggioLog);
  if not Controlli then
    exit;
  with WR000DM.selT375 do
  begin
    Append;
    //Progressivo
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    //Data
    FieldByName('DATA').AsDateTime:=StrToDate(edtData.Text);
    //Causale
    FieldByName('CAUSALE').AsString:=Copy(cmbCausale.Text,1,Pos(SPAZIO,cmbCausale.Text) - 1);
    //Numero Accessi
    FieldByName('ACCESSI').AsInteger:=StrToInt(edtNumAccessi.Text);
    //Pranzo/Cena
    if rgpPranzoCena.ItemIndex = 0 then
      FieldByName('PRANZOCENA').AsString:='P'
    else
      FieldByName('PRANZOCENA').AsString:='C';
    //Rilevatore
    //FieldByName('RILEVATORE').AsString:=;

    RegistraLog.SettaProprieta('I','T375_ACCESSIMENSA',medpCodiceForm,WR000DM.selT375,True);
    try
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on e:exception do
      begin
        if Pos('ORA-00001', e.Message) > 0 then
          GGetWebApplicationThreadVar.ShowMessage('Accesso già esistente per la data specificata.')
        else
          GGetWebApplicationThreadVar.ShowMessage('Accesso non inserito: ' + E.Message);
        Cancel;
      end;
    end;
    Close;
  end;
  InizializzaAccesso;
  Pulisci;
end;

procedure TW016FAccessiMensa.GetDipendentiDisponibili(Data:TDateTime);
begin
  inherited;
  ListaDipendenti.Clear;
  with selAnagrafeW do
  begin
    First;
    while not Eof do
    begin
      ListaDipendenti.Add(FieldByName('MATRICOLA').AsString);
      Next;
    end;
  end;
end;

procedure TW016FAccessiMensa.grdAccessiMensaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0) and (ARow = RigaSel) then
    ACell.Css:=ACell.Css + ' riga_selezionata';
end;

procedure TW016FAccessiMensa.grdAccessiMensaCellClick(ASender: TObject; const ARow, AColumn: Integer);
var i,j:Integer;
begin
  inherited;
  RigaSel:=ARow;
  if WR000DM.selT375.State in [dsEdit,dsInsert] then
    WR000DM.selT375.Cancel;
  if grdAccessiMensa.RowCount = 1 then
    exit;
  //Data
  edtData.Text:=Trim(grdAccessiMensa.Cell[ARow,AColumn].Text);
  //Accessi
  edtNumAccessi.Text:=Trim(grdAccessiMensa.Cell[ARow,AColumn + 1].Text);
  //Causale
  with WR000DM do
  begin
    selT305.Open;
    if selT305.SearchRecord('CODICE',Trim(Copy(grdAccessiMensa.Cell[ARow,AColumn + 2].Text,1,Pos(SPAZIO,grdAccessiMensa.Cell[ARow,AColumn + 2].Text)-1)),[srFromBeginning]) then
      cmbCausale.ItemIndex:=ListaCausali.IndexOf(selT305.FieldByName('CODICE').AsString)
    else
      cmbCausale.ItemIndex:=-1;
    selT305.Close;
  end;
  //Pranzo/Cena
  if grdAccessiMensa.Cell[ARow,AColumn + 3].Text = 'Pranzo' then
    rgpPranzoCena.ItemIndex:=0
  else
    rgpPranzoCena.ItemIndex:=1;
  //Label dipendente
  j:=0;
  while Trim(grdAccessiMensa.Cell[ARow - j,1].Text) = '' do
    inc(j);
  i:=ListaDipendenti.IndexOf(grdAccessiMensa.Cell[ARow - j,1].Text);
  cmbDipendentiDisponibili.ItemIndex:=i;
  selAnagrafeW.SearchRecord('MATRICOLA',grdAccessiMensa.Cell[ARow - j,1].Text,[srFromBeginning]);
  lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  GetAccessi;
end;

procedure TW016FAccessiMensa.btnEseguiClick(Sender: TObject);
var PeriodoCambiato:Boolean;
begin
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtDal.Text)) or (Al <> StrToDate(edtAl.Text));
    Dal:=StrToDate(edtDal.Text);
    Al:=StrToDate(edtAl.Text);
    if Al < Dal then
      raise Exception.Create('Il periodo specificato non è corretto!');
    if R180Anno(Dal) <> R180Anno(Al) then
      raise Exception.Create('Le date devono essere riferite allo stesso anno!');
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;
  //Inizializzazione Dipendenti disponibili
  if PeriodoCambiato then
    InizializzaAccesso;
end;

end.

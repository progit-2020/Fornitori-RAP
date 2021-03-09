unit P552UDettaglioRegoleContoAnn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Oracle, OracleData, Buttons,
  C180FunzioniGenerali, C013UCheckList;

type
  TP552FDettaglioRegoleContoAnn = class(TR001FGestTab)
    Panel2: TPanel;
    lblNumero: TLabel;
    dedtNumero: TDBEdit;
    Label1: TLabel;
    dedtDescrizione: TDBEdit;
    dedtValoreCostante: TDBEdit;
    lblValoreCostante: TLabel;
    lblArrotondamento: TLabel;
    Panel3: TPanel;
    lblAnno: TLabel;
    edtTabella: TEdit;
    lblTabella: TLabel;
    edtAnno: TEdit;
    lblCodTabella: TLabel;
    gpbAccorpamento: TGroupBox;
    lblCodAccorpamento: TLabel;
    dedtCodAccorpamento: TDBEdit;
    drdgModalita: TDBRadioGroup;
    gpbTabSostitutive: TGroupBox;
    lblTredicesimaAC: TLabel;
    lblTredicesimaAP: TLabel;
    lblArretratiAC: TLabel;
    lblArretratiAP: TLabel;
    cmbTabTredicesimaAC: TComboBox;
    cmbTabTredicesimaAP: TComboBox;
    cmbTabArretratiAC: TComboBox;
    cmbTabArretratiAP: TComboBox;
    cmbRigheTredicesimaAC: TComboBox;
    cmbRigheTredicesimaAP: TComboBox;
    cmbRigheArretratiAC: TComboBox;
    cmbRigheArretratiAP: TComboBox;
    dmemRegolaManuale: TDBMemo;
    pnlRegole: TPanel;
    Label2: TLabel;
    dchkRegolaModif: TDBCheckBox;
    btnRipristina: TBitBtn;
    dCmbArrotondamento: TDBLookupComboBox;
    btnCodAccorpamento: TBitBtn;
    btnValoreCostante: TBitBtn;
    procedure btnCodAccorpamentoClick(Sender: TObject);
    procedure cmbTabArretratiAPChange(Sender: TObject);
    procedure cmbTabArretratiACChange(Sender: TObject);
    procedure cmbTabTredicesimaAPChange(Sender: TObject);
    procedure cmbTabTredicesimaACChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dchkRegolaModifClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnRipristinaClick(Sender: TObject);
    procedure dCmbArrotondamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TRegisClick(Sender: TObject);
    procedure drdgModalitaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    TipoElab:String;
    NumElab:Integer;
    lstAppoggio:TStringList;
    procedure CaricaComboTabelle;
    procedure CaricaCombo(Tabella:String);
  public
    { Public declarations }
    TabElab,AnnoElab:String;
  end;

var
  P552FDettaglioRegoleContoAnn: TP552FDettaglioRegoleContoAnn;

  procedure OpenP522DettaglioRegoleContoAnn(Numero,Anno:Integer;Tipo,Tabella:String);

implementation

uses P552URegoleContoAnnualeDtM;

{$R *.dfm}

procedure OpenP522DettaglioRegoleContoAnn(Numero,Anno:Integer;Tipo,Tabella:String);
begin
  Application.CreateForm(TP552FDettaglioRegoleContoAnn,P552FDettaglioRegoleContoAnn);
  with P552FDettaglioRegoleContoAnn do
  try
    TipoElab:=Tipo;
    NumElab:=Numero;
    AnnoElab:=IntToStr(Anno);
    TabElab:=Tabella;
    ShowModal;
  finally
    FreeAndNil(P552FDettaglioRegoleContoAnn);
  end;
end;

procedure TP552FDettaglioRegoleContoAnn.FormShow(Sender: TObject);
begin
  inherited;
  with P552FRegoleContoAnnualeDtM do
  begin
    if TipoElab = 'Riga' then
    begin
      DButton.DataSet:=selP552Righe;
      P552FDettaglioRegoleContoAnn.Caption:='<P552> Dettaglio righe';
      P552FDettaglioRegoleContoAnn.HelpContext:=3552100;
      lblNumero.Caption:='Numero riga';
      dedtNumero.DataField:='RIGA';
      lblValoreCostante.Caption:='Codice';
      dedtValoreCostante.Width:=50;
      btnValoreCostante.Visible:=False;
      gpbAccorpamento.Caption:='Accorpamento voci';
      lblCodAccorpamento.Visible:=True;
      dedtCodAccorpamento.Visible:=True;
      btnCodAccorpamento.Visible:=True;
      gpbTabSostitutive.Caption:='Tabella e riga sostitutiva in caso di';
      //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe non faccio vedere dati di Accorp.voci
      if VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) <> '2' then
      begin
        gpbAccorpamento.Visible:=False;
        lblArrotondamento.Visible:=False;
        dCmbArrotondamento.Visible:=False;
        pnlRegole.Visible:=False;
        dmemRegolaManuale.Visible:=False;
      end;
      selP552Righe.SearchRecord('RIGA',NumElab,[srFromBeginning]);
    end
    else if TipoElab = 'Colonna' then
    begin
      DButton.DataSet:=selP552Colonne;
      P552FDettaglioRegoleContoAnn.Caption:='<P552> Dettaglio colonne';
      P552FDettaglioRegoleContoAnn.HelpContext:=3552200;
      lblNumero.Caption:='Numero colonna';
      dedtNumero.DataField:='COLONNA';
      lblValoreCostante.Caption:='Parametro';
      dedtValoreCostante.Width:=525;
      btnValoreCostante.Visible:=True;
      gpbAccorpamento.Caption:='';
      lblCodAccorpamento.Visible:=False;
      dedtCodAccorpamento.Visible:=False;
      btnCodAccorpamento.Visible:=False;
      gpbTabSostitutive.Caption:='Tabella e colonna sostitutiva in caso di';
      //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Colonne non faccio vedere dati di dettaglio
      if VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) = '2' then
      begin
        gpbAccorpamento.Visible:=False;
        lblArrotondamento.Visible:=False;
        dCmbArrotondamento.Visible:=False;
        lblValoreCostante.Visible:=False;
        dedtValoreCostante.Visible:=False;
        btnValoreCostante.Visible:=False;
        pnlRegole.Visible:=False;
        dmemRegolaManuale.Visible:=False;
      end;
      selP552Colonne.SearchRecord('COLONNA',NumElab,[srFromBeginning]);
    end;
    edtAnno.Text:=AnnoElab;
    edtTabella.Text:=TabElab;
    lblTabella.Caption:=VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'DESCRIZIONE'));
    CaricaComboTabelle;
  end;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.CaricaComboTabelle;
var SalvaPos:TBookmark;
begin
  CmbTabTredicesimaAC.Items.Clear;
  CmbTabTredicesimaAP.Items.Clear;
  CmbTabArretratiAC.Items.Clear;
  CmbTabArretratiAP.Items.Clear;
  CmbTabTredicesimaAC.Items.Add(Format('%-10s',['NC']) + '-' + 'Non conteggiare');
  CmbTabTredicesimaAP.Items.Add(Format('%-10s',['NC']) + '-' + 'Non conteggiare');
  CmbTabArretratiAC.Items.Add(Format('%-10s',['NC']) + '-' + 'Non conteggiare');
  CmbTabArretratiAP.Items.Add(Format('%-10s',['NC']) + '-' + 'Non conteggiare');
  with P552FRegoleContoAnnualeDtM.selP552Ricerca do
  begin
    DisableControls;
    SalvaPos:=GetBookmark;
    First;
    while not Eof do
    begin
      CmbTabTredicesimaAC.Items.Add(Format('%-10s',[FieldByName('COD_TABELLA').AsString]) + '-' + FieldByName('DESCRIZIONE').AsString);
      CmbTabTredicesimaAP.Items.Add(Format('%-10s',[FieldByName('COD_TABELLA').AsString]) + '-' + FieldByName('DESCRIZIONE').AsString);
      CmbTabArretratiAC.Items.Add(Format('%-10s',[FieldByName('COD_TABELLA').AsString]) + '-' + FieldByName('DESCRIZIONE').AsString);
      CmbTabArretratiAP.Items.Add(Format('%-10s',[FieldByName('COD_TABELLA').AsString]) + '-' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    GotoBookmark(SalvaPos);
    EnableControls;
  end;
end;

procedure TP552FDettaglioRegoleContoAnn.CaricaCombo(Tabella:String);
begin
  lstAppoggio.Clear;
  with P552FRegoleContoAnnualeDtM.QSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT ' + TipoElab + ',DESCRIZIONE FROM P552_CONTOANNREGOLE');
    SQL.Add(' WHERE COD_TABELLA = ''' + Tabella + '''');
    SQL.Add('   AND ANNO = ' + AnnoElab);
    SQL.Add('   AND ' + TipoElab + ' <> 0');
    Open;
    First;
    while not Eof do
    begin
      lstAppoggio.Add(Format('%-3s',[FieldByName(TipoElab).AsString]) + '-' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TP552FDettaglioRegoleContoAnn.FormCreate(Sender: TObject);
begin
  inherited;
  lstAppoggio:=TStringList.Create;
end;

procedure TP552FDettaglioRegoleContoAnn.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstAppoggio);
end;

procedure TP552FDettaglioRegoleContoAnn.drdgModalitaClick(Sender: TObject);
begin
  inherited;
  gpbTabSostitutive.Visible:=drdgModalita.ItemIndex <> 0;
  //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Righe faccio sempre vedere CodAccorpamento
  if VarToStr(P552FRegoleContoAnnualeDtM.selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) = '2' then
  begin
    lblCodAccorpamento.Visible:=(TipoElab = 'Riga');
    if lblCodAccorpamento.Visible then
      lblCodAccorpamento.Caption:='Parametro';
    dedtCodAccorpamento.Visible:=(TipoElab = 'Riga');
  end
  else  //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe faccio vedere CodAccorpamento se diverso da Nessun accorp.
  begin
    lblCodAccorpamento.Visible:=(TipoElab = 'Riga') and (drdgModalita.ItemIndex <> 0);
    dedtCodAccorpamento.Visible:=(TipoElab = 'Riga') and (drdgModalita.ItemIndex <> 0);
  end;
  btnCodAccorpamento.Visible:=(TipoElab = 'Riga') and (drdgModalita.ItemIndex <> 0);
  btnValoreCostante.Visible:=(TipoElab = 'Colonna') and (drdgModalita.ItemIndex <> 0);
end;

procedure TP552FDettaglioRegoleContoAnn.TRegisClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.dCmbArrotondamentoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TP552FDettaglioRegoleContoAnn.btnRipristinaClick(Sender: TObject);
begin
  inherited;
  if (R180MessageBox('Confermi il ripristino della regola di calcolo originale' + Chr(10)
      + 'sostituendo quella manuale?' ,DOMANDA) = mrYes) then
    DButton.Dataset.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=DButton.Dataset.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
end;

procedure TP552FDettaglioRegoleContoAnn.DButtonStateChange(Sender: TObject);
begin
  inherited;
  gpbTabSostitutive.Enabled:=DButton.State <> dsBrowse;
  btnCodAccorpamento.Enabled:=DButton.State <> dsBrowse;
  btnValoreCostante.Enabled:=DButton.State <> dsBrowse;
  dchkRegolaModifClick(nil);
end;

procedure TP552FDettaglioRegoleContoAnn.dchkRegolaModifClick(Sender: TObject);
begin
  inherited;
  dMemRegolaManuale.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
  btnRipristina.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
end;

procedure TP552FDettaglioRegoleContoAnn.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabTredicesimaACChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabTredicesimaAC) and
     (Trim(Copy(cmbTabTredicesimaAC.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_TREDCORR').AsString)-1)) then
    CmbRigheTredicesimaAC.Text:='';
  CmbRigheTredicesimaAC.Items.Clear;
  if (Trim(CmbTabTredicesimaAC.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAC.Text,1,10)) <> 'NC') then
  begin
    CaricaCombo(TrimRight(Copy(CmbTabTredicesimaAC.Text,1,10)));
    CmbRigheTredicesimaAC.Items.AddStrings(lstAppoggio);
    CmbRigheTredicesimaAC.Enabled:=True;
  end
  else
    CmbRigheTredicesimaAC.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabTredicesimaAPChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabTredicesimaAP) and
     (Trim(Copy(cmbTabTredicesimaAP.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_TREDPREC').AsString)-1)) then
    CmbRigheTredicesimaAP.Text:='';
  CmbRigheTredicesimaAP.Items.Clear;
  if (Trim(CmbTabTredicesimaAP.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAP.Text,1,10)) <> 'NC') then
  begin
    CaricaCombo(TrimRight(Copy(CmbTabTredicesimaAP.Text,1,10)));
    CmbRigheTredicesimaAP.Items.AddStrings(lstAppoggio);
    CmbRigheTredicesimaAP.Enabled:=True;
  end
  else
    CmbRigheTredicesimaAP.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabArretratiACChange(Sender: TObject);
begin
  inherited;
  if (Sender = CmbTabArretratiAC) and
     (Trim(Copy(CmbTabArretratiAC.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_ARRCORR').AsString)-1)) then
    CmbRigheArretratiAC.Text:='';
  CmbRigheArretratiAC.Items.Clear;
  if (Trim(CmbTabArretratiAC.Text) <> '') and (Trim(Copy(CmbTabArretratiAC.Text,1,10)) <> 'NC') then
  begin
    CaricaCombo(TrimRight(Copy(CmbTabArretratiAC.Text,1,10)));
    CmbRigheArretratiAC.Items.AddStrings(lstAppoggio);
    CmbRigheArretratiAC.Enabled:=True;
  end
  else
    CmbRigheArretratiAC.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabArretratiAPChange(Sender: TObject);
begin
  inherited;
  if (Sender = CmbTabArretratiAP) and
     (Trim(Copy(CmbTabArretratiAP.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_ARRPREC').AsString)-1)) then
    CmbRigheArretratiAP.Text:='';
  CmbRigheArretratiAP.Items.Clear;
  if (Trim(CmbTabArretratiAP.Text) <> '') and (Trim(Copy(CmbTabArretratiAP.Text,1,10)) <> 'NC') then
  begin
    CaricaCombo(TrimRight(Copy(CmbTabArretratiAP.Text,1,10)));
    CmbRigheArretratiAP.Items.AddStrings(lstAppoggio);
    CmbRigheArretratiAP.Enabled:=True;
  end
  else
    CmbRigheArretratiAP.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.btnCodAccorpamentoClick(Sender: TObject);
var S:String;
  i:Integer;
begin
  inherited;
  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco accorpamenti';
  with C013FCheckList do
    try
      with P552FRegoleContoAnnualeDtM.selP215 do
      begin
        Open;
        clbListaDati.Items.Clear;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-21s',[FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
        Close;
      end;
      if Sender = btnCodAccorpamento then
        S:=dedtCodAccorpamento.Text
      else if Sender = btnValoreCostante then
        S:=dedtValoreCostante.Text;
      S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
      R180PutCheckList(S,21,clbListaDati);
      for i:=0 to clbListaDati.Count - 1 do
        if clbListaDati.Checked[i] then
        begin
          clbListaDati.ItemIndex:=i;
          Break;
        end;
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(21,clbListaDati);
        if Trim(S) <> '' then
          S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';
      if Sender = btnCodAccorpamento then
//        dedtCodAccorpamento.Text:=S
      begin
        dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:=S;
        dedtCodAccorpamento.Hint:=dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString;
      end
      else if Sender = btnValoreCostante then
//        dedtValoreCostante.Text:=S;
        dButton.Dataset.FieldByName('VALORE_COSTANTE').AsString:=S;
      end;
    finally
      Free;
    end;
end;

end.

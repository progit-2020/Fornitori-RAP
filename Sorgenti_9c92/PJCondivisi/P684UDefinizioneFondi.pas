unit P684UDefinizioneFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A000UCostanti, A000USessione, A000UInterfaccia, ExtCtrls, DBCtrls, StdCtrls, Mask,
  C600USelAnagrafe, Buttons, Oracle, OracleData, A003UDataLavoroBis,
  P680UMacrocategorieFondi, P682URaggruppamentiFondi, Grids, DBGrids,
  C180FunzioniGenerali, C009UCopiaSu, ClipBrd;

type
  TP684FDefinizioneFondi = class(TR001FGestTab)
    pnlRicerca: TPanel;
    PageControl1: TPageControl;
    tabGenerale: TTabSheet;
    tabRisorseGen: TTabSheet;
    tabRisorseDett: TTabSheet;
    tabDestinGen: TTabSheet;
    tabDestinDett: TTabSheet;
    dedtCodFondo: TDBEdit;
    Label5: TLabel;
    dedtDecorrenza: TDBEdit;
    Label3: TLabel;
    dedtScadenza: TDBEdit;
    Label1: TLabel;
    DBText1: TDBText;
    cmbRicerca: TDBLookupComboBox;
    Label2: TLabel;
    cmbDecorrenza: TDBLookupComboBox;
    Label4: TLabel;
    btnDecorrenza: TBitBtn;
    btnScadenza: TBitBtn;
    dmemDescrizione: TDBMemo;
    Label6: TLabel;
    Label7: TLabel;
    dmemFiltroDipendenti: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    btnDataCostituz: TBitBtn;
    dedtDataCostituz: TDBEdit;
    Label8: TLabel;
    dcmbMacroCateg: TDBLookupComboBox;
    Label9: TLabel;
    Label10: TLabel;
    dcmbRaggr: TDBLookupComboBox;
    dtxtMacrocateg: TDBText;
    dtxtRaggr: TDBText;
    PopupMenu1: TPopupMenu;
    Accedi1: TMenuItem;
    dgrdRisorseGen: TDBGrid;
    dgrdDestinGen: TDBGrid;
    dgrdRisorseDett: TDBGrid;
    dgrdDestinDett: TDBGrid;
    gpbMonitoraggio: TGroupBox;
    dedtDataMonitoraggio: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    edtTotRisorse: TEdit;
    edtTotSpeso: TEdit;
    Label13: TLabel;
    edtTotResiduo: TEdit;
    Label14: TLabel;
    Rinumeraordinestampa: TMenuItem;
    N4: TMenuItem;
    Selezionatutto: TMenuItem;
    Deselezionatutto: TMenuItem;
    Invertiselezione: TMenuItem;
    N5: TMenuItem;
    Copia: TMenuItem;
    Copiainexcel: TMenuItem;
    btnVisDettaglio: TBitBtn;
    Modificacodicevoce: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure dcmbMacroCategKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbMacroCategCloseUp(Sender: TObject);
    procedure dcmbMacroCategKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbRaggrCloseUp(Sender: TObject);
    procedure dcmbRaggrKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TPrimoClick(Sender: TObject);
    procedure cmbDecorrenzaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbRicercaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDecorrenzaCloseUp(Sender: TObject);
    procedure cmbRicercaCloseUp(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dedtDecorrenzaExit(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure btnScadenzaClick(Sender: TObject);
    procedure btnDataCostituzClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cmbRicercaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbDecorrenzaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TInserClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure RinumeraordinestampaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SelezionatuttoClick(Sender: TObject);
    procedure DeselezionatuttoClick(Sender: TObject);
    procedure InvertiselezioneClick(Sender: TObject);
    procedure CopiaClick(Sender: TObject);
    procedure btnVisDettaglioClick(Sender: TObject);
    procedure ModificacodicevoceClick(Sender: TObject);
  private
    { Private declarations }
    procedure Aggiorna;
  public
    { Public declarations }
  end;

var
  P684FDefinizioneFondi: TP684FDefinizioneFondi;

  procedure OpenP684DefinizioneFondi;

implementation

uses P684UDefinizioneFondiDtM, P684UGenerale, P684UDettaglioRisorse, P684UDettaglioDestin, P684UGrigliaDett;

{$R *.dfm}

procedure OpenP684DefinizioneFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP684DefinizioneFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP684FDefinizioneFondi,P684FDefinizioneFondi);
  with P684FDefinizioneFondi do
    try
      P684FDefinizioneFondiDtM:=TP684FDefinizioneFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P684FDefinizioneFondiDtM.Free;
      Free;
    end;
end;

procedure TP684FDefinizioneFondi.Accedi1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = dcmbMacroCateg then
  begin
    OpenP680MacrocategorieFondi(dcmbMacroCateg.Text);
    P684FDefinizioneFondiDtM.selP680.Refresh;
  end
  else if PopupMenu1.PopupComponent = dcmbRaggr then
  begin
    OpenP682RaggruppamentiFondi(dcmbRaggr.Text);
    P684FDefinizioneFondiDtM.selP682.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdRisorseGen then
  begin
    OpenP684Generale('R',cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.selP686.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdDestinGen then
  begin
    OpenP684Generale('D',cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.selP686.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdRisorseDett then
  begin
    OpenP684DettaglioRisorse(cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    P684FDefinizioneFondiDtM.selP688R.Refresh;
  end
  else if PopupMenu1.PopupComponent = dgrdDestinDett then
  begin
    C600frmSelAnagrafe.DistruggiSelAnagrafe;
    OpenP684DettaglioDestin(cmbRicerca.Text,StrToDate(cmbDecorrenza.Text));
    C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
    P684FDefinizioneFondiDtM.selP688D.Refresh;
  end;
end;

procedure TP684FDefinizioneFondi.btnDataCostituzClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DATA_COSTITUZ').IsNull then
      selP684.FieldByName('DATA_COSTITUZ').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DATA_COSTITUZ').AsDateTime:=DataOut(selP684.FieldByName('DATA_COSTITUZ').AsDateTime,'Data costituzione','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnDecorrenzaClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DECORRENZA_DA').IsNull then
      selP684.FieldByName('DECORRENZA_DA').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DECORRENZA_DA').AsDateTime:=DataOut(selP684.FieldByName('DECORRENZA_DA').AsDateTime,'Decorrenza','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnScadenzaClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    if selP684.FieldByName('DECORRENZA_A').IsNull then
      selP684.FieldByName('DECORRENZA_A').AsDateTime:=Parametri.DataLavoro;
    selP684.FieldByName('DECORRENZA_A').AsDateTime:=DataOut(selP684.FieldByName('DECORRENZA_A').AsDateTime,'Scadenza','G');
  end;
end;

procedure TP684FDefinizioneFondi.btnVisDettaglioClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    OpenP684GrigliaDett(selP684.FieldByName('COD_FONDO').AsString,'',
      '',selP684.FieldByName('DECORRENZA_DA').AsDateTime);
  end;
end;

procedure TP684FDefinizioneFondi.C600frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
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
  inherited;
  if P684FDefinizioneFondiDtm.selP684.FieldByName('DECORRENZA_A').IsNull then
    C600frmSelAnagrafe.C600DataLavoro:=Date
  else
    C600frmSelAnagrafe.C600DataLavoro:=P684FDefinizioneFondiDtm.selP684.FieldByName('DECORRENZA_A').AsDateTime;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    P684FDefinizioneFondiDtM.selP684.FieldByName('FILTRO_DIPENDENTI').AsString:=TrasformaV430(S);
  end;
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaCloseUp(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP684Ricerca.Close;
    selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
    selP684Ricerca.Open;
    cmbRicerca.KeyValue:=selP684Ricerca.FieldByName('COD_FONDO').AsString;
    cmbRicercaCloseUp(nil);
  end;
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //IL COMBO DEVE SEMPRE ESSERE VALORIZZATO
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=P684FDefinizioneFondiDtM.selP684Dec.FieldByName('DECORRENZA').AsDateTime;
(*    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;*)
  end;
end;

procedure TP684FDefinizioneFondi.cmbDecorrenzaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbDecorrenzaCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.cmbRicercaCloseUp(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TP684FDefinizioneFondi.cmbRicercaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //IL COMBO DEVE SEMPRE ESSERE VALORIZZATO
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=P684FDefinizioneFondiDtM.selP684Ricerca.FieldByName('COD_FONDO').AsString;
(*    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;*)
  end;
end;

procedure TP684FDefinizioneFondi.cmbRicercaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  cmbRicercaCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.CopiaClick(Sender: TObject);
var S:String;
  i:Integer;
  Griglia:TDBGrid;
begin
  inherited;
  Griglia:=nil;
  if PageControl1.ActivePage = tabRisorseGen then
    Griglia:=dgrdRisorseGen
  else if PageControl1.ActivePage = tabDestinGen then
    Griglia:=dgrdDestinGen
  else if PageControl1.ActivePage = tabRisorseDett then
    Griglia:=dgrdRisorseDett
  else if PageControl1.ActivePage = tabDestinDett then
    Griglia:=dgrdDestinDett;
  with Griglia.DataSource.DataSet do
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
        if Griglia.SelectedRows.CurrentRowSelected then
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
  Griglia.Repaint;
end;

procedure TP684FDefinizioneFondi.Copiada1Click(Sender: TObject);
begin
//  inherited;
  if PageControl1.ActivePage = tabGenerale then
  begin
    C009FCopiaSu:=TC009FCopiaSu.Create(nil);
    with C009FCopiaSu do
    try
      SetODS([P684FDefinizioneFondiDtM.selP684]);
      ODS:=P684FDefinizioneFondiDtM.selP684;
      ShowModal;
    finally
      Free;
    end;
    with P684FDefinizioneFondiDtM do
    begin
      selP684Dec.Refresh;
      cmbDecorrenza.KeyValue:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
      with P684FDefinizioneFondiDtM do
      begin
        selP684Ricerca.Close;
        selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
        selP684Ricerca.Open;
      end;
      cmbRicerca.KeyValue:=selP684.FieldByName('COD_FONDO').AsString;
    end;
  end
  else if PageControl1.ActivePage = tabRisorseDett then
  begin
    C009FCopiaSu:=TC009FCopiaSu.Create(nil);
    with C009FCopiaSu do
    try
      SetODS([P684FDefinizioneFondiDtM.selP688R]);
      ODS:=P684FDefinizioneFondiDtM.selP688R;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TP684FDefinizioneFondi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  pnlRicerca.Enabled:=DButton.State = dsBrowse;
  btnVisDettaglio.Enabled:=DButton.State = dsBrowse;
  if PageControl1.ActivePage = tabGenerale then
  begin
    btnDecorrenza.Enabled:=DButton.State in [dsEdit,dsInsert];
    btnScadenza.Enabled:=DButton.State in [dsEdit,dsInsert];
    btnDataCostituz.Enabled:=DButton.State in [dsEdit,dsInsert];
    C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
  end;
end;

procedure TP684FDefinizioneFondi.dcmbMacroCategCloseUp(Sender: TObject);
begin
  inherited;
  dtxtMacrocateg.Visible:=Trim(dcmbMacroCateg.Text) <> '';
end;

procedure TP684FDefinizioneFondi.dcmbMacroCategKeyDown(Sender: TObject;
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

procedure TP684FDefinizioneFondi.dcmbMacroCategKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbMacroCategCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.dcmbRaggrCloseUp(Sender: TObject);
begin
  inherited;
  dtxtRaggr.Visible:=Trim(dcmbRaggr.Text) <> '';
end;

procedure TP684FDefinizioneFondi.dcmbRaggrKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbRaggrCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.dedtDecorrenzaExit(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtm do
  begin
    if (DButton.State in [dsEdit,dsInsert]) and
      (not selP684.FieldByName('DECORRENZA_DA').IsNull) and (selP684.FieldByName('DECORRENZA_A').IsNull) then
      selP684.FieldByName('DECORRENZA_A').AsDateTime:=StrToDate('31/12/' + Copy(selP684.FieldByName('DECORRENZA_DA').AsString,7,4));
  end;
end;

procedure TP684FDefinizioneFondi.DeselezionatuttoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'N');
end;

procedure TP684FDefinizioneFondi.FormCreate(Sender: TObject);
begin
  inherited;
  A000SettaVariabiliAmbiente;
end;

procedure TP684FDefinizioneFondi.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP684FDefinizioneFondi.FormShow(Sender: TObject);
begin
  inherited;
  CopiaDa1.Visible:=True;
  CopiaDa1.Enabled:=True;
  PageControl1.ActivePage:=tabGenerale;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with P684FDefinizioneFondiDtM do
  begin
    DButton.Dataset:=selP684;
    selP684Dec.Open;
    if selP684Dec.RecordCount > 0 then
    begin
      selP684Dec.Last;
      cmbDecorrenza.KeyValue:=selP684Dec.FieldByName('DECORRENZA').AsDateTime;
      cmbDecorrenzaCloseUp(nil);
    end;
  end;
end;

procedure TP684FDefinizioneFondi.InvertiselezioneClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'C');
end;

procedure TP684FDefinizioneFondi.ModificacodicevoceClick(Sender: TObject);
var Vecchio,Nuovo:String;
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    Vecchio:=selP686.FieldByName('COD_VOCE_GEN').AsString;
    Nuovo:=selP686.FieldByName('COD_VOCE_GEN').AsString;
    if InputQuery('Modifica codice voce','Codice voce:',Nuovo) then
    begin
      if Nuovo = Vecchio then
        Exit;
      if selP686.SearchRecord('COD_VOCE_GEN',Nuovo,[srFromBeginning]) then
        raise Exception.Create('Modifica impossibile: codice voce già esistente!');
      ScriptSQL.Lines.Clear;
      ScriptSQL.Output.Clear;
      ScriptSQL.Lines.Add('alter table p688_risdestdet disable constraint P688_FK_P686;');
      ScriptSQL.Lines.Add('alter table p690_fondispeso disable constraint P690_FK_P688;');
      ScriptSQL.Lines.Add('update p686_risdestgen p686 set cod_voce_gen = ''' + Nuovo + '''');
      ScriptSQL.Lines.Add(' where cod_fondo = ''' + cmbRicerca.Text + '''');
      ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + cmbDecorrenza.Text + ''',''dd/mm/yyyy'')');
      ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
      ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + Vecchio + ''';');
      ScriptSQL.Lines.Add('update p688_risdestdet p688 set cod_voce_gen = ''' + Nuovo + '''');
      ScriptSQL.Lines.Add(' where cod_fondo = ''' + cmbRicerca.Text + '''');
      ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + cmbDecorrenza.Text + ''',''dd/mm/yyyy'')');
      ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
      ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + Vecchio + ''';');
      ScriptSQL.Lines.Add('update p690_fondispeso p690 set cod_voce_gen = ''' + Nuovo + '''');
      ScriptSQL.Lines.Add(' where cod_fondo = ''' + cmbRicerca.Text + '''');
      ScriptSQL.Lines.Add('   and decorrenza_da = to_date(''' + cmbDecorrenza.Text + ''',''dd/mm/yyyy'')');
      ScriptSQL.Lines.Add('   and class_voce = ''' + selP686.FieldByName('CLASS_VOCE').AsString + '''');
      ScriptSQL.Lines.Add('   and cod_voce_gen = ''' + Vecchio + ''';');
      ScriptSQL.Lines.Add('alter table p688_risdestdet enable constraint P688_FK_P686;');
      ScriptSQL.Lines.Add('alter table p690_fondispeso enable constraint P690_FK_P688;');
      ScriptSQL.Execute;
      if (Pos('ERR',ScriptSQL.Output.Text) <= 0) and (Pos('ORA-',ScriptSQL.Output.Text) <= 0) then
      begin
        SessioneOracle.Commit;
        selP686.Refresh;
        R180MessageBox('Modifica codice voce terminata correttamente!','INFORMA');
      end
      else
      begin
        SessioneOracle.Rollback;
        R180MessageBox('Modifica codice voce terminata in modo irregolare a causa dei seguenti errori: ' + ScriptSQL.Output.Text,'ERRORE');
      end;
    end;
  end;
end;

procedure TP684FDefinizioneFondi.PageControl1Change(Sender: TObject);
begin
  inherited;
  actInserisci.Enabled:=PageControl1.ActivePage = tabGenerale;
  actModifica.Enabled:=PageControl1.ActivePage = tabGenerale;
  actCancella.Enabled:=PageControl1.ActivePage = tabGenerale;
  actRicerca.Enabled:=PageControl1.ActivePage = tabGenerale;
  actPrimo.Enabled:=PageControl1.ActivePage = tabGenerale;
  actPrecedente.Enabled:=PageControl1.ActivePage = tabGenerale;
  actSuccessivo.Enabled:=PageControl1.ActivePage = tabGenerale;
  actUltimo.Enabled:=PageControl1.ActivePage = tabGenerale;
  actRefresh.Enabled:=PageControl1.ActivePage = tabGenerale;
  actStampa.Enabled:=PageControl1.ActivePage = tabGenerale;
  actCopiaSu.Enabled:=(PageControl1.ActivePage = tabGenerale) or (PageControl1.ActivePage = tabRisorseDett);
  Modificacodicevoce.Visible:=(PageControl1.ActivePage = tabRisorseGen) or (PageControl1.ActivePage = tabDestinGen);
  Rinumeraordinestampa.Visible:=(PageControl1.ActivePage = tabRisorseGen) or (PageControl1.ActivePage = tabDestinGen);
  SelezionaTutto.Visible:=(PageControl1.ActivePage <> tabGenerale);
  DeselezionaTutto.Visible:=(PageControl1.ActivePage <> tabGenerale);
  InvertiSelezione.Visible:=(PageControl1.ActivePage <> tabGenerale);
  Copia.Visible:=(PageControl1.ActivePage <> tabGenerale);
  Copiainexcel.Visible:=(PageControl1.ActivePage <> tabGenerale);
  Aggiorna;
end;

procedure TP684FDefinizioneFondi.RinumeraordinestampaClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  if R180MessageBox('Confermi la rinumerazione dell''ordine di stampa partendo da 10 con incremento di 5?','DOMANDA') <> mrYes then
    Exit;
  //Rinumerazione ORDINE_STAMPA partendo da 10 con incremento di 5
  with P684FDefinizioneFondiDtM do
  begin
    selP686.DisableControls;
    selP686.First;
    i:=0;
    while not selP686.Eof do
    begin
      selP686.Edit;
      selP686.FieldByName('ORDINE_STAMPA').AsInteger:=10 + i;
      selP686.Post;
      i:=i + 5;
      selP686.Next;
    end;
    SessioneOracle.Commit;
    selP686.Refresh;
    selP686.First;
    selP686.EnableControls;
  end;
end;

procedure TP684FDefinizioneFondi.SelezionatuttoClick(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(TDBGrid(Popupmenu1.PopupComponent),'S');
end;

procedure TP684FDefinizioneFondi.Aggiorna;
begin
  with P684FDefinizioneFondiDtM do
  begin
    if PageControl1.ActivePage = tabGenerale then
      selP684.SearchRecord('DECORRENZA_DA;COD_FONDO',VarArrayOf([StrToDateTime(cmbDecorrenza.Text),cmbRicerca.Text]),[srFromBeginning])
    else if PageControl1.ActivePage = tabRisorseGen then
    begin
      selP686.Close;
      selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP686.SetVariable('COD',cmbRicerca.Text);
      selP686.SetVariable('CLASS','R');
      selP686.Open;
    end
    else  if PageControl1.ActivePage = tabDestinGen then
    begin
      selP686.Close;
      selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP686.SetVariable('COD',cmbRicerca.Text);
      selP686.SetVariable('CLASS','D');
      selP686.Open;
    end
    else if PageControl1.ActivePage = tabRisorseDett then
    begin
      selP686.Close;
      selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP686.SetVariable('COD',cmbRicerca.Text);
      selP686.SetVariable('CLASS','R');
      selP686.Open;
      selP688R.Close;
      selP688R.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP688R.SetVariable('COD',cmbRicerca.Text);
      selP688R.Open;
    end
    else  if PageControl1.ActivePage = tabDestinDett then
    begin
      selP686.Close;
      selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP686.SetVariable('COD',cmbRicerca.Text);
      selP686.SetVariable('CLASS','D');
      selP686.Open;
      selP688D.Close;
      selP688D.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
      selP688D.SetVariable('COD',cmbRicerca.Text);
      selP688D.Open;
    end;
  end;
end;

procedure TP684FDefinizioneFondi.TAnnullaClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP684Dec.Refresh;
    cmbDecorrenza.KeyValue:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
    selP684Ricerca.Close;
    selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
    selP684Ricerca.Open;
    cmbRicerca.KeyValue:=selP684.FieldByName('COD_FONDO').AsString;
  end;
end;

procedure TP684FDefinizioneFondi.TCancClick(Sender: TObject);
var R,D:Integer;
begin
//  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP686.Close;
    selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
    selP686.SetVariable('COD',cmbRicerca.Text);
    selP686.SetVariable('CLASS','R');
    selP686.Open;
    R:=selP686.RecordCount;
    selP686.Close;
    selP686.SetVariable('DEC',StrToDateTime(cmbDecorrenza.Text));
    selP686.SetVariable('COD',cmbRicerca.Text);
    selP686.SetVariable('CLASS','D');
    selP686.Open;
    D:=selP686.RecordCount;
    if R180MessageBox('Attenzione: verranno cancellate ' + IntToStr(R) + ' risorse generali e ' + IntToStr(D) + ' destinazioni generali. Confermi cancellazione?','DOMANDA') = mrYes  then
    begin
      DButton.DataSet.Delete;
      NumRecords;
      selP684Dec.Refresh;
      cmbDecorrenza.KeyValue:=P684FDefinizioneFondiDtM.selP684.FieldByName('DECORRENZA_DA').AsDateTime;
      with P684FDefinizioneFondiDtM do
      begin
        selP684Ricerca.Close;
        selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
        selP684Ricerca.Open;
      end;
      cmbRicerca.KeyValue:=P684FDefinizioneFondiDtM.selP684.FieldByName('COD_FONDO').AsString;
    end;
  end;
end;

procedure TP684FDefinizioneFondi.TInserClick(Sender: TObject);
begin
  inherited;
  cmbDecorrenza.KeyValue:=null;
  cmbRicerca.KeyValue:=null;
  dedtCodFondo.SetFocus;
end;

procedure TP684FDefinizioneFondi.TPrimoClick(Sender: TObject);
begin
  inherited;
  cmbDecorrenza.KeyValue:=P684FDefinizioneFondiDtM.selP684.FieldByName('DECORRENZA_DA').AsDateTime;
  with P684FDefinizioneFondiDtM do
  begin
    selP684Ricerca.Close;
    selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
    selP684Ricerca.Open;
  end;
  cmbRicerca.KeyValue:=P684FDefinizioneFondiDtM.selP684.FieldByName('COD_FONDO').AsString;
  cmbRicercaCloseUp(nil);
end;

procedure TP684FDefinizioneFondi.TRegisClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP684Dec.Refresh;
    cmbDecorrenza.KeyValue:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
    selP684Ricerca.Close;
    selP684Ricerca.SetVariable('DEC',selP684Dec.FieldByName('DECORRENZA').AsDateTime);
    selP684Ricerca.Open;
    cmbRicerca.KeyValue:=selP684.FieldByName('COD_FONDO').AsString;
  end;
end;

end.

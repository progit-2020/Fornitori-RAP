unit A062UQueryServizio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids, checklst, Mask, Clipbrd,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, Printers, C005UDatiAnagrafici,
  Menus, A023UTimbrature, Variants, Oracle, OracleData, C700USelezioneAnagrafe,
  SelAnagrafe, StrUtils, RegistrazioneLog, Cestino, Vcl.DBCtrls, Data.DB;

type
  TA062FQueryServizio = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PopupMenu3: TPopupMenu;
    Datianagrafici1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    N1: TMenuItem;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    CopiaInExcel: TMenuItem;
    Copia2: TMenuItem;
    pnlGriglia: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlSelAnagrafe: TPanel;
    Panel5: TPanel;
    btnEsegui: TBitBtn;
    btnCarica: TBitBtn;
    btnSalva: TBitBtn;
    btnElimina: TBitBtn;
    btnPulisci: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Label7: TLabel;
    cmbQuery: TComboBox;
    PopupMenu1: TPopupMenu;
    Inseriscisubquerydallaselezioneanagrafica1: TMenuItem;
    Inseriscijoinconlaselezioneanagrafica1: TMenuItem;
    InseriscisubqueryEXISTSsullaselezioneanagrafica1: TMenuItem;
    Incollatesto1: TMenuItem;
    PanelTop: TPanel;
    Splitter2: TSplitter;
    Memo1: TMemo;
    dGrdVariabili: TDBGrid;
    grpRis: TGroupBox;
    BStampa: TBitBtn;
    BStampante: TBitBtn;
    BSalva: TBitBtn;
    btnCreaTab: TBitBtn;
    lblNomeTab: TLabel;
    edtNomeTab: TEdit;
    BCartellino: TBitBtn;
    prgBar: TProgressBar;
    chkIntestazione: TCheckBox;
    chkNoRitornoACapo: TCheckBox;
    chkProtetta: TCheckBox;
    lblRaggruppamento: TLabel;
    cmbRaggruppamenti: TComboBox;
    ppMnuAccediA101: TPopupMenu;
    Accedi1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure BCartellinoClick(Sender: TObject);
    procedure BStampanteClick(Sender: TObject);
    procedure BStampaClick(Sender: TObject);
    procedure btnCaricaClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure Datianagrafici1Click(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
    procedure cmbQueryDblClick(Sender: TObject);
    procedure btnPulisciClick(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Inseriscisubquerydallaselezioneanagrafica1Click(Sender: TObject);
    procedure Inseriscijoinconlaselezioneanagrafica1Click(Sender: TObject);
    procedure InseriscisubqueryEXISTSsullaselezioneanagrafica1Click(Sender: TObject);
    procedure Incollatesto1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure edtNomeTabChange(Sender: TObject);
    procedure edtNomeTabEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure cmbRaggruppamentiChange(Sender: TObject);
  private
    procedure Pulizia;
    procedure IniDCmbRaggruppamenti;
  public
    { Public declarations }
  end;

var
  A062FQueryServizio: TA062FQueryServizio;

procedure OpenA062QueryServizio(Nome,SQL:String);

implementation

uses A062UQueryServizioDtM1, A062UAccessoDB, A101URaggrInterrogazioni;

{$R *.DFM}

procedure OpenA062QueryServizio(Nome,SQL:String);
{Interrogazioni di servizio}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA062QueryServizio') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A062FQueryServizio:=TA062FQueryServizio.Create(nil);
  A062FAccessoDB:=TA062FAccessoDB.Create(nil);
  try
    A062FQueryServizio.btnSalva.Enabled:=not SolaLettura;
    A062FQueryServizio.btnElimina.Enabled:=not SolaLettura;
    A062FQueryServizioDtM1:=TA062FQueryServizioDtM1.Create(nil);
    A062FQueryServizio.Pulizia;
    if Trim(Nome) <> '' then
    begin
      A062FQueryServizio.cmbQuery.Text:=Nome;
      A062FQueryServizio.btnCaricaClick(nil);
    end
    else if Trim(SQL) <> '' then
      A062FQueryServizio.Memo1.Lines.Add(SQL);
    A062FQueryServizio.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A062FAccessoDB);
    FreeAndNil(A062FQueryServizioDtM1);
    FreeAndNil(A062FQueryServizio);
  end;
end;

procedure TA062FQueryServizio.FormCreate(Sender: TObject);
begin
  //Valori settati qui perchè vengono sempre riportati al defalut all'avvio
  frmSelAnagrafe.Align:=alNone;
  frmSelAnagrafe.Width:=25;
end;

procedure TA062FQueryServizio.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA062FQueryServizio.IniDCmbRaggruppamenti;
begin
  A062FQueryServizioDtm1.A062MW.CaricaCmbRaggruppamenti(CmbRaggruppamenti.items);
  CmbRaggruppamenti.ItemIndex:=0;
  cmbRaggruppamentiChange(cmbRaggruppamenti);
end;

procedure TA062FQueryServizio.FormShow(Sender: TObject);
begin
  chkProtetta.Enabled:=Parametri.ModificaDatiProtetti;
  DBGrid1.DataSource:=A062FQueryServizioDtM1.A062MW.DS1;
  dGrdVariabili.DataSource:=A062FQueryServizioDtM1.A062MW.dsrValori;
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A062FQueryServizioDtM1.A062MW,SessioneOracle, StatusBar1,2,False);
  frmSelAnagrafe.NumRecords;
  Memo1.SetFocus;
  btnCreaTab.Enabled:=Trim(edtNomeTab.Text) <> '';
  A062FQueryServizioDtM1.A062MW.GC700MergeSelAnagrafe:=C700MergeSelAnagrafe;
  A062FQueryServizioDtM1.A062MW.SelAnagrafe:=C700SelAnagrafe;
  IniDCmbRaggruppamenti;
end;

procedure TA062FQueryServizio.btnEseguiClick(Sender: TObject);
var PassWord:String;
begin
  try
    StatusBar1.Panels[1].Text:='Attendere: esecuzione in corso';
    StatusBar1.Repaint;
    Screen.Cursor:=crHourGlass;
    with A062FQueryServizioDtM1.A062MW do
    begin
      Q1.Close;
      SenderIsBtnCreaTab:=Sender = btnCreaTab;
      SqlSelezioneList.Text:=Memo1.Lines.Text;
      SqlNomeTabella:=edtNomeTab.Text;
      ValidaQuery;
      if UpperCase(Copy(Trim(Memo1.Lines.Text) + ' ',1,5)) = 'EXEC ' then
      begin
        PreparaScript;
        if ChiediPswAccessoDB and (selI090.RecordCount > 0) then
        begin
          A062FAccessoDB.edtUserName.Text:=UserName;
          A062FAccessoDB.ShowModal;
          if A062FAccessoDB.ModalResult = mrOk then
            PassWord:=A062FAccessoDB.edtPassWord.Text;
          if R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974) <> PassWord then
          begin
            StatusBar1.Panels[1].Text:='';
            screen.cursor:=crDefault;
            ShowMessage('Accesso negato');
            exit;
          end;
        end;
        S1.Execute;
        ShowMessage(Trim(S1.Output.Text));
        Exit;
      end;
      if SenderIsBtnCreaTab then
      begin
        if EsisteTabella then
        begin
          if R180MessageBox('Attenzione! La tabella T921' + SqlNomeTabella + ' è già esistente e verrà ricreata.' + #13#10 +
                            'I dati contenuti nella tabella precedente andranno persi. Continuare?',DOMANDA) = mrNo then
            Exit;
          DropTableT921;  //Drop tabella
        end;
      end;
      EseguiQuery;
      if SenderIsBtnCreaTab then
      begin
        CreateTableT921(SqlNomeTabella);
        R180MessageBox('I dati sono stati registrati nella tabella T921' + SqlNomeTabella + '.',INFORMA);
      end;
      BStampa.Enabled:=Q1.RecordCount > 0;
      BStampante.Enabled:=Q1.RecordCount > 0;
      BCartellino.Enabled:=(Parametri.Applicazione = 'RILPRE') and (Q1.RecordCount > 0);
      BCartellino.Visible:=A062FQueryServizio.BCartellino.Enabled;
      BSalva.Enabled:=Q1.RecordCount > 0;
      StatusBar1.Panels[0].Text:=IntToStr(Q1.RecordCount) + ' Records';
    end;
  finally
    Screen.Cursor:=crDefault;
    StatusBar1.Panels[1].Text:='';
  end;
end;

procedure TA062FQueryServizio.Accedi1Click(Sender: TObject);
var R,Q:String;
begin
  R:=cmbRaggruppamenti.Text;
  Q:=cmbQuery.Text;
  OpenA101RaggrInterrogazioni(cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);
  A062FQueryServizioDtm1.A062MW.CaricaCmbRaggruppamenti(CmbRaggruppamenti.items);
  CmbRaggruppamenti.ItemIndex:=CmbRaggruppamenti.Items.IndexOf(R);
  cmbRaggruppamentiChange(cmbRaggruppamenti);
  CmbQuery.ItemIndex:=CmbQuery.Items.IndexOf(Q);
end;

procedure TA062FQueryServizio.BCartellinoClick(Sender: TObject);
var Data:TDateTime;
begin
  try
    Data:=A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Data').AsDatetime
  except
    Data:=Parametri.DataLavoro;
  end;
  with A062FQueryServizioDtM1.A062MW.Q1 do
    try
      frmSelAnagrafe.SalvaC00SelAnagrafe;
      C700Distruzione;
      OpenA023Timbrature(FieldByName('Progressivo').AsInteger,Data);
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe(A062FQueryServizioDtM1.A062MW);
    except
      on E:Exception do
        ShowMessage('Per richiamare il cartellino, devono esistere le seguenti colonne: Progressivo,Data' + CRLF + E.Message);
    end;
end;

procedure TA062FQueryServizio.BStampanteClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA062FQueryServizio.BStampaClick(Sender: TObject);
var F:TextFile;
    S,Intestazione:String;
    i,HP,HR,HCorr:Integer;
    procedure SaltoPagina;
    begin
    writeln(F,'');
    writeln(F,'Elenco Interrogazione Tabelle IrisWIN (Pag. ' + IntToStr(Printer.PageNumber)+ ')');
    writeln(F,'');
    writeln(F,Intestazione);
    writeln(F,'');
    HCorr:=HR * 5;
    end;
begin
  AssignPrn(F);
  Rewrite(F);
  Printer.Canvas.Font.Name:='Courier New';
  Printer.Canvas.Font.Size:=7;
  HP:=Printer.PageHeight;
  HR:=Printer.Canvas.TextHeight(' ');
  with A062FQueryServizioDtM1.A062MW.Q1 do
  begin
    First;
    DisableControls;
    S:='';
    for i:=0 to FieldCount - 1 do
      if Fields[i].Visible then
        S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]), Fields[i].FieldName]);
    Intestazione:=S;
    SaltoPagina;
    while not Eof do
    begin
      S:='';
      if HCorr >= (HP - HR*8) then
        begin
        while Printer.PageNumber < 2 do
          writeln(F,'');
        SaltoPagina;
        end;
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]), Fields[i].AsString]);
      writeln(F,S);
      inc(HCorr,HR);
      Next;
    end;
    First;
    EnableControls;
  end;
  CloseFile(F);
end;

procedure TA062FQueryServizio.btnCaricaClick(Sender: TObject);
begin
  with A062FQueryServizioDtM1.A062MW do
  begin
    SqlNome:=cmbQuery.Text;
    if Trim(cmbQuery.Text) = '' then
      Exit;
    if (cmbQuery.Items.IndexOf(cmbQuery.Text) = -1) then
    begin
      R180MessageBox(Format(A000MSG_A062_ERR_QUERY_NON_IN_LISTA,[SqlNome]),ERRORE);
      Exit;
    end;
    Memo1.Clear;
    SqlSelezioneList.Text:=Memo1.Lines.Text;
    chkIntestazioneName:=chkIntestazione.Name;
    chkNoRitornoACapoName:=chkNoRitornoACapo.Name;
    CaricaQuery;
    btnSalva.Enabled:=(not SolaLettura) and (not ChkMWProtetta or Parametri.ModificaDatiProtetti);
    btnElimina.Enabled:=btnSalva.Enabled;
    frmSelAnagrafe.Visible:=EsisteC700;
    chkProtetta.Checked:=ChkMWProtetta;
    Memo1.ReadOnly:=ChkMWProtetta and Not Parametri.ModificaDatiProtetti;
    edtNomeTab.Text:=SqlNomeTabella;
    chkIntestazione.Checked:=chkIntestazioneChecked;
    chkNoRitornoACapo.Checked:=chkNoRitornoACapoChecked;
    Memo1.Text:=SqlSelezioneList.Text;
  end;
end;

procedure TA062FQueryServizio.btnSalvaClick(Sender: TObject);
begin
  if cmbQuery.Text = '' then
    raise Exception.Create(A000MSG_A062_ERR_NOME_QUERY_MANCANTE);

  with A062FQueryServizioDtM1.A062MW do
  begin
    SqlNome:=cmbQuery.Text;
    SqlNomeTabella:=edtNomeTab.Text;
    SqlSelezioneList.Text:=Memo1.Lines.Text;
    chkIntestazioneName:=chkIntestazione.Name;
    chkIntestazioneChecked:=chkIntestazione.Checked;
    chkNoRitornoACapoName:=chkNoRitornoACapo.Name;
    chkNoRitornoACapoChecked:=chkNoRitornoACapo.Checked;
    ChkMWProtetta:=chkProtetta.Checked;
    if not SalvaSql then
      R180MessageBox(Format(A000MSG_A062_ERR_QUERY_ESISTENTE,[SqlNome]),ERRORE)
    else
      frmSelAnagrafe.Visible:=EsisteC700;
  end;
end;

procedure TA062FQueryServizio.Datianagrafici1Click(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Data').AsDateTime;
  except
    C005DataVisualizzazione:=Date;
  end;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  try
    C005FDatiAnagrafici.ShowDipendente(A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Progressivo').AsInteger);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA062FQueryServizio.BSalvaClick(Sender: TObject);
var F:TextFile;
    TestoFile:String;
begin
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp';
  if SaveDialog1.FileName = '' then
    SaveDialog1.FileName:=cmbQuery.Text;
  if not SaveDialog1.Execute then
    exit;
  AssignFile(F,SaveDialog1.FileName);
  Rewrite(F);
  with A062FQueryServizioDtM1.A062MW do
  begin
    chkIntestazioneChecked:=chkIntestazione.Checked;
    chkNoRitornoACapoChecked:=chkNoRitornoACapo.Checked;
    TestoFile:=CreaTestoFile;
  end;
  write(F,TestoFile);
  CloseFile(F);
end;

procedure TA062FQueryServizio.cmbRaggruppamentiChange(Sender: TObject);
begin
  if cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex] = 'Tutte le interrogazioni' then
    A062FQueryServizioDtM1.A062MW.OpenSelT002(A062FQueryServizioDtM1.selT002,'')
  else
    A062FQueryServizioDtM1.A062MW.OpenSelT002(A062FQueryServizioDtM1.selT002,cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);

  cmbQuery.Items.Clear;
  with A062FQueryServizioDtM1 do
  begin
    selT002.First;
    while not selT002.Eof do
    begin
      cmbQuery.Items.Add(selT002.FieldByName('Nome').AsString);
      selT002.Next;
    end;
    if (cmbQuery.Text <> '') and not A062FQueryServizioDtM1.selT002.SearchRecord('NOME',cmbQuery.Text,[srFromBeginning]) then
      cmbQuery.Text:='';
    selT002.Close;
  end;
end;

procedure TA062FQueryServizio.btnEliminaClick(Sender: TObject);
var
  Msg:string;
begin
  if MessageDlg(Format('Eliminare la query "%s" ?',[cmbQuery.Text]),MtWarning,[MbYes,MbNo],0) = MrYes then
    with TCestino.Create(SessioneOracle) do
      try
        Msg:=CancLogica('T002_QUERYPERSONALIZZATE',cmbQuery.Text);
        if Msg <> '' then
          R180MessageBox(Msg,ERRORE)
        else
        begin
          RegistraLog.SettaProprieta('C','T002_QUERYPERSONALIZZATE','A062',nil,True);
          RegistraLog.InserisciDato('NOME',cmbQuery.Text,'');
          RegistraLog.RegistraOperazione;
          Pulizia;
          cmbQuery.Text:='';;
        end;
      finally
        Free;
      end;
end;

procedure TA062FQueryServizio.cmbQueryDblClick(Sender: TObject);
begin
  btnCaricaClick(nil);
end;

procedure TA062FQueryServizio.btnPulisciClick(Sender: TObject);
begin
  Pulizia;
  cmbQuery.Text:='';

end;

procedure TA062FQueryServizio.Pulizia;
begin
  Memo1.Clear;
  with A062FQueryServizioDtM1.A062MW do
  begin
    cdsValori.Close;
    cdsValori.CreateDataSet;
    cdsValori.Open;
    Q1.Close;
    Q1.SQL.Clear;
    BStampa.Enabled:=False;
    BSalva.Enabled:=False;
    BStampante.Enabled:=False;
    BCartellino.Enabled:=False;
    BCartellino.Visible:=BCartellino.Enabled;
    StatusBar1.Panels[0].Text:='0 Records';
  end;
end;

procedure TA062FQueryServizio.PopupMenu1Popup(Sender: TObject);
begin
  IncollaTesto1.Enabled:=Clipboard.AsText <> '';
end;

procedure TA062FQueryServizio.PopupMenu3Popup(Sender: TObject);
var
  i:integer;
  bTrovato:boolean;
begin
  bTrovato:=False;
  for i:=0 to A062FQueryServizioDtM1.A062MW.Q1.FieldCount - 1 do
  begin
    if (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'PROGRESSIVO') or
       (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'T430PROGRESSIVO') or
       (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'T030PROGRESSIVO') then
    begin
      bTrovato:=True;
      break;
    end;
  end;
  Datianagrafici1.Enabled:=bTrovato;
end;

procedure TA062FQueryServizio.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(DBGrid1,'S');
end;

procedure TA062FQueryServizio.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(DBGrid1,'N');
end;

procedure TA062FQueryServizio.edtNomeTabChange(Sender: TObject);
begin
  btnCreaTab.Enabled:=Trim(edtNomeTab.Text) <> '';
end;

procedure TA062FQueryServizio.edtNomeTabEnter(Sender: TObject);
begin
  if (Trim(cmbQuery.Text) <> '') and (edtNomeTab.Text = '') and
     (Trim(Memo1.Lines.Text) <> '') then
    edtNomeTab.Text:=cmbQuery.Text;
  edtNomeTab.SelectAll;
end;

procedure TA062FQueryServizio.Incollatesto1Click(Sender: TObject);
begin
  Memo1.Text:=R180IncollaTestoDaClipboard(Memo1.Text,Memo1.SelStart,Memo1.SelLength);
end;

procedure TA062FQueryServizio.Inseriscijoinconlaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.Inseriscisubquerydallaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.InseriscisubqueryEXISTSsullaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('EXISTS (SELECT ''X'' FROM :C700SelAnagrafe AND T030.PROGRESSIVO =  <tabella>.PROGRESSIVO)',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('EXISTS (SELECT ''X'' FROM :C700SelAnagrafe AND T030.PROGRESSIVO =  <tabella>.PROGRESSIVO)');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(DBGrid1,'C');
end;

procedure TA062FQueryServizio.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(DBGrid1,Sender = CopiaInExcel, True, chkIntestazione.Checked, chkNoRitornoACapo.Checked);
end;

end.

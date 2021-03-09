unit Ac05UImportRimborsi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Oracle, OracleData, OracleMonitor, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Mask, C004UParamForm,
  A000UInterfaccia, A000USessione, A083UMsgElaborazioni, A000UMessaggi, C180FunzioniGenerali,
  Vcl.Buttons, System.ImageList, Ac05UImportRimborsiDM;

type
  TAc05FImportRimborsi = class(TR001FGestTab)
    dgrdInput: TDBGrid;
    Panel2: TPanel;
    dcmbStruttura: TDBLookupComboBox;
    lblStruttura: TLabel;
    btnImportRimborsi: TButton;
    btnCollegaRimborsi: TButton;
    actImportaRimborsi: TAction;
    actCollegaRimborsi: TAction;
    rgpFiltro: TRadioGroup;
    chkSoloDipendenti: TCheckBox;
    btnAnomalie: TBitBtn;
    ProgressBar1: TProgressBar;
    PopupMenu1: TPopupMenu;
    CopiaInExcel: TMenuItem;
    btnNomeFile: TButton;
    lblNomeFile: TLabel;
    edtNomeFile: TEdit;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    dcmbTipoPagamento: TDBLookupComboBox;
    dlblTipoPagamento: TDBText;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnNomeFileClick(Sender: TObject);
    procedure chkSoloDipendentiClick(Sender: TObject);
    procedure rgpFiltroClick(Sender: TObject);
    procedure actImportaRimborsiExecute(Sender: TObject);
    procedure actCollegaRimborsiExecute(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure dgrdInputDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    C004: TC004FParamForm;
    Ac05FImportRimborsiDM: TAc05FImportRimborsiDM;
    procedure evtImpostaStatusBar(Testo:String);
    procedure evtImpostaProgressBar(Max:Integer);
    procedure evtIncrementaProgressBar;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure StrutturaChange;
  public
    { Public declarations }
    lstMatricoleApp:TStringList;
  end;

var
  Ac05FImportRimborsi: TAc05FImportRimborsi;

procedure OpenAc05ImportRimborsi(lstMatricole:TStringList);

implementation

{$R *.dfm}

procedure OpenAc05ImportRimborsi(lstMatricole:TStringList);
begin
  SolaLettura:=False;
  SolaLetturaOriginale:=SolaLettura;
  case A000GetInibizioni('Funzione','OpenAc05ImportRimborsi') of
    'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TAc05FImportRimborsi,Ac05FImportRimborsi);
  Ac05FImportRimborsi.Ac05FImportRimborsiDM.lstMatricole:=lstMatricole;
  //C700Progressivo:=Prog;
  try
    Screen.Cursor:=crDefault;
    Ac05FImportRimborsi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Ac05FImportRimborsi.Free;
  end;
end;

procedure TAc05FImportRimborsi.FormCreate(Sender: TObject);
begin
  inherited;
  Ac05FImportRimborsiDM:=TAc05FImportRimborsiDM.Create(Self);
  Ac05FImportRimborsiDM.evtImpostaStatusBar:=Ac05FImportRimborsi.evtImpostaStatusBar;
  Ac05FImportRimborsiDM.evtImpostaProgressBar:=Ac05FImportRimborsi.evtImpostaProgressBar;
  Ac05FImportRimborsiDM.evtIncrementaProgressBar:=Ac05FImportRimborsi.evtIncrementaProgressBar;
end;

procedure TAc05FImportRimborsi.FormShow(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
  actImportaRimborsi.Enabled:=not SolaLettura;
  actCollegaRimborsi.Enabled:=False;
  try
    C004:=CreaC004(SessioneOracle,AC05,Parametri.ProgOper);
    GetParametriFunzione;
  except
  end;
  Ac05FImportRimborsiDM.IA100DataChange:=StrutturaChange;
end;

procedure TAc05FImportRimborsi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PutParametriFunzione;
end;

procedure TAc05FImportRimborsi.FormDestroy(Sender: TObject);
begin
  Ac05FImportRimborsiDM.Free;
  inherited;
  FreeAndNil(C004);
end;

procedure TAc05FImportRimborsi.GetParametriFunzione;
begin
  Ac05FImportRimborsiDM.cdsIA100.Edit;
  Ac05FImportRimborsiDM.cdsIA100.FieldByName('NOME_STRUTTURA').AsString:=C004.GetParametro('NOME_STRUTTURA','');
  Ac05FImportRimborsiDM.cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString:=C004.GetParametro('CODICE_PAGAMENTO','');
  Ac05FImportRimborsiDM.cdsIA100.Post;
  edtNomeFile.Text:=C004.GetParametro('NOME_FILE','');
end;

procedure TAc05FImportRimborsi.PutParametriFunzione;
begin
  try
    C004.Cancella001;
    C004.PutParametro('NOME_STRUTTURA',Ac05FImportRimborsiDM.cdsIA100.FieldByName('NOME_STRUTTURA').AsString);
    C004.PutParametro('CODICE_PAGAMENTO',Ac05FImportRimborsiDM.cdsIA100.FieldByName('CODICE_PAGAMENTO').AsString);
    C004.PutParametro('NOME_FILE',edtNomeFile.Text);
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TAc05FImportRimborsi.StrutturaChange;
begin
  NumRecords;
  chkSoloDipendenti.Checked:=False;
  rgpFiltro.ItemIndex:=2;
  actCollegaRimborsi.Enabled:=False;
end;

procedure TAc05FImportRimborsi.btnNomeFileClick(Sender: TObject);
var NomeFile:String;
begin
  inherited;
  OpenDialog1.Title:=lblNomeFile.Caption;
  if edtNomeFile.Text <> '' then
    NomeFile:=edtNomeFile.Text
  else
    NomeFile:=Ac05FImportRimborsiDM.selIA100.FieldByName('NOME_FILE').AsString;
  OpenDialog1.FileName:=NomeFile;
  OpenDialog1.InitialDir:=ExtractFilePath(NomeFile);
  if OpenDialog1.Execute then
    edtNomeFile.Text:=OpenDialog1.FileName;
end;

procedure TAc05FImportRimborsi.chkSoloDipendentiClick(Sender: TObject);
begin
  inherited;
  Ac05FImportRimborsiDM.SoloDipendenti:=chkSoloDipendenti.Checked;
  Ac05FImportRimborsiDM.selInputDati.Filtered:=True;
  NumRecords;
end;

procedure TAc05FImportRimborsi.rgpFiltroClick(Sender: TObject);
begin
  inherited;
  Ac05FImportRimborsiDM.Filtro:=rgpFiltro.ItemIndex;
  Ac05FImportRimborsiDM.selInputDati.Filtered:=True;
  actCollegaRimborsi.Enabled:=(rgpFiltro.ItemIndex = 0) and Ac05FImportRimborsiDM.CollegaRimborsi and not SolaLettura;
  NumRecords;
end;

procedure TAc05FImportRimborsi.actImportaRimborsiExecute(Sender: TObject);
begin
  inherited;
  PutParametriFunzione;
  chkSoloDipendenti.Checked:=False;
  rgpFiltro.ItemIndex:=2;
  Ac05FImportRimborsiDM.selInputDati.Filtered:=True;
  try
    Screen.Cursor:=crHourGlass;
    Panel2.Enabled:=False;
    try
      Ac05FImportRimborsiDM.NomeFile:=Trim(edtNomeFile.Text);
      Ac05FImportRimborsiDM.ControlloParametri;
      Ac05FImportRimborsiDM.ImportazioneDati;
      Ac05FImportRimborsiDM.ApriStruttura;
    finally
      NumRecords;
      Screen.Cursor:=crDefault;
      Panel2.Enabled:=True;
      ProgressBar1.Position:=0;
      Ac05FImportRimborsi.StatusBar.Panels[2].Text:='';
      Ac05FImportRimborsi.StatusBar.Repaint;
    end;
    ShowMessage(A000MSG_Ac05_MSG_FINE_IMPORTAZIONE);
  except
    on E:Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TAc05FImportRimborsi.actCollegaRimborsiExecute(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
  rgpFiltro.ItemIndex:=0;
  Ac05FImportRimborsiDM.selInputDati.Filtered:=True;
  try
    Screen.Cursor:=crHourGlass;
    Panel2.Enabled:=False;
    with Ac05FImportRimborsiDM do
      try
        NomeFile:='';//Trim(edtNomeFile.Text);
        ControlloParametri;
        SoloControllo:=True;
        RegistraRimborsi;
        SoloControllo:=False;
        RispostaGen:=mrCancel;
        if nRimbCaricati = 0 then
          RispostaGen:=mrYes
        else if nRimbCaricati > 0 then
          RispostaGen:=R180MessageBox(Format(A000MSG_Ac05_DLG_FMT_REG_RIMB_ESISTENTI,[IntToStr(nRimbCaricati),IntToStr(nRimbCaricabili)]),'DOMANDA_ESCI');
        if RispostaGen = mrCancel then
          raise exception.Create(A000MSG_MSG_OPERAZIONE_ANNULLATA);
        RegistraRimborsi;
      finally
        NumRecords;
        Screen.Cursor:=crDefault;
        Panel2.Enabled:=True;
        ProgressBar1.Position:=0;
        Ac05FImportRimborsi.StatusBar.Panels[2].Text:='';
        Ac05FImportRimborsi.StatusBar.Repaint;
        btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB;
      end;
    if btnAnomalie.Enabled then
    begin
      if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
        btnAnomalieClick(nil)
    end
    else
      ShowMessage(A000MSG_Ac05_MSG_FINE_COLLEGAMENTO);
  except
    on E:Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TAc05FImportRimborsi.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,AC05,'');
end;

procedure TAc05FImportRimborsi.CopiaInExcelClick(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdInput,True,False);
end;

procedure TAc05FImportRimborsi.dgrdInputDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Ac05FImportRimborsiDM.selInputDati.FindField('MEDP_ESISTENTE') <> nil then
  begin
    if Ac05FImportRimborsiDM.selInputDati.FieldByName('MEDP_ESISTENTE').AsString = 'S' then
      if (gdSelected in State) or (TDBGrid(Sender).SelectedRows.CurrentRowSelected) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clHighLight;
        TDBGrid(Sender).Canvas.Font.Color:=clWhite;
      end
      else
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=$00FFFFCC;
        TDBGrid(Sender).Canvas.Font.Color:=clWindowText;
      end;
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;

procedure TAc05FImportRimborsi.evtImpostaStatusBar(Testo:String);
begin
  StatusBar.Panels[2].Text:=Testo;
  StatusBar.Repaint;
end;

procedure TAc05FImportRimborsi.evtImpostaProgressBar(Max:Integer);
begin
  ProgressBar1.Max:=Max;
  ProgressBar1.Position:=0;
end;

procedure TAc05FImportRimborsi.evtIncrementaProgressBar;
begin
  ProgressBar1.StepBy(1);
end;

end.

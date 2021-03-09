unit A173UImportAssestamento;

interface

uses ImgList, Controls, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Classes,
  Variants, StrUtils, Forms, SysUtils, C004UParamForm, C012UVisualizzaTesto,
  A000UInterfaccia, A000UMessaggi, A000USessione, C180FunzioniGenerali,
  A083UMsgElaborazioni, A173UImportAssestamentoMW;

type
  TA173FImportAssestamento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnEsegui: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    edtFile: TEdit;
    btnFile: TBitBtn;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    BtnAnomalie: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    ImageList1: TImageList;
    rgpTipoOperazione: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure BtnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    A173MW:TA173FImportAssestamentoMW;
    procedure RecuperaFile;
    procedure CaricamentoOreAssestamento;
  public
    { Public declarations }
  end;

var
  A173FImportAssestamento: TA173FImportAssestamento;

procedure OpenA173FImportAssestamento;

implementation

{$R *.dfm}

procedure OpenA173FImportAssestamento;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA173FImportAssestamento') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA173FImportAssestamento, A173FImportAssestamento);
  try
    Screen.Cursor:=crDefault;
    A173FImportAssestamento.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A173FImportAssestamento.Free;
  end;
end;

procedure TA173FImportAssestamento.FormCreate(Sender: TObject);
begin
  A173MW:=TA173FImportAssestamentoMW.Create(Self);
  inherited;
end;

procedure TA173FImportAssestamento.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A173',Parametri.ProgOper);
  edtFile.Text:=C004FParamForm.GetParametro('NOMEFILE','');
  BtnAnomalie.Enabled:=False;
end;

procedure TA173FImportAssestamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('NOMEFILE',edtFile.Text);
  C004FParamForm.Free;
end;

procedure TA173FImportAssestamento.FormDestroy(Sender: TObject);
begin
  A173MW.Free;
end;

procedure TA173FImportAssestamento.btnFileClick(Sender: TObject);
var i:Integer;
begin
  OpenDialog1.Title:='Ricerca file';
  if edtFile.Text <> Null then
    for i:=Length(edtFile.Text) downto 1 do
    begin
      if Pos('\',Copy(edtFile.Text,i,1)) > 0 then
      begin
        OpenDialog1.InitialDir:=Copy(edtFile.Text,1,i);
        Break;
      end;
    end;
  if OpenDialog1.Execute then
    edtFile.Text:=OpenDialog1.FileName;
end;

procedure TA173FImportAssestamento.btnVisualizzaFileClick(Sender: TObject);
begin
  OpenC012VisualizzaTesto('<A173> Importazione ore di assestamento',EdtFile.Text,nil,'');
end;

procedure TA173FImportAssestamento.btnEseguiClick(Sender: TObject);
begin
  RecuperaFile;
  CaricamentoOreAssestamento;
end;

procedure TA173FImportAssestamento.RecuperaFile;
begin
  if Length(edtFile.Text) <= 0 then
    raise exception.Create(A000MSG_A173_ERR_NO_FILE);
  if not FileExists(edtFile.Text) then
    raise exception.Create(A000MSG_ERR_FILE_INESISTENTE);
  with A173MW do
  begin
    ApriFile(edtFile.Text);
    RecuperaTotaleRigheFile;
    ApriFile(edtFile.Text);
  end;
end;

procedure TA173FImportAssestamento.CaricamentoOreAssestamento;
begin
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=A173MW.nTotRighe;
  btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio('A173');

  with A173MW do
    try
      nNumRiga:=0;
      while not Eof(FIn) do
      begin
        ProgressBar1.StepBy(1);
        ElaboraRiga(IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C'));
      end;
    finally
      CloseFile(FIn);
      SessioneOracle.Commit;
      Screen.Cursor:=crDefault;
      ProgressBar1.Position:=0;
    end;

  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
end;

procedure TA173FImportAssestamento.BtnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A173','');
end;

end.

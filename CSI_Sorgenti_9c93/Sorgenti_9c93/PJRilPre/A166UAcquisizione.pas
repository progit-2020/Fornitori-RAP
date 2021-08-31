unit A166UAcquisizione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, C004UParamForm,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, Oracle, OracleData,
  A083UMsgElaborazioni, ComCtrls, C012UVisualizzaTesto, C700USelezioneAnagrafe,
  System.Types, A000UMessaggi;

type
  TA166FAcquisizione = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    dcmbTipoQuota: TDBLookupComboBox;
    dTxtDescQuota: TDBText;
    Label6: TLabel;
    edtFile: TEdit;
    Label1: TLabel;
    btnFile: TBitBtn;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    btnVisualizzaFile: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
  private
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  end;

var
  A166FAcquisizione: TA166FAcquisizione;

  procedure OpenA166Acquisizione;

implementation

uses A166UQuoteIndividualiDtM;

{$R *.dfm}

procedure OpenA166Acquisizione;
begin
  Application.CreateForm(TA166FAcquisizione, A166FAcquisizione);
  try
    A166FAcquisizione.ShowModal;
  finally
    A166FAcquisizione.Free;
  end;
end;

procedure TA166FAcquisizione.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A166','');
end;

procedure TA166FAcquisizione.btnEseguiClick(Sender: TObject);
var lstFile: TStringList;
  s:String;
begin
  if Trim(edtFile.Text) = '' then
    raise Exception.Create(A000MSG_ERR_NO_FILE);

  if not FileExists(edtFile.Text) then
    raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE);

  if R180MessageBox(Format(A000MSG_A166_DLG_FMT_ACQUISIZIONE,[dcmbTipoQuota.Text,dtxtDescQuota.Caption,IntToStr(C700SelAnagrafe.RecordCount)]),'DOMANDA') <> mrYes then
    Exit;
  try
    lstFile:=TStringList.Create;
    lstFile.LoadFromFile(edtFile.Text);
  except
    FreeAndNil(lstFile);
    raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE);
  end;
  Screen.Cursor:=crHourGlass;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=lstFile.Count;
  try
    A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.AcquisizioneDaFileInizio;
    if not RegistraMsg.ContieneTipoA then
      for s in lstFile do
      begin
        ProgressBar1.StepBy(1);
        A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.Acquisisci(s,dcmbTipoQuota.Text);
      end;
  finally
    FreeAndNil(lstFile);
    A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.AcquisizioneDaFileFine;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
  end;

  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA166FAcquisizione.btnFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtFile.Text:=OpenDialog1.FileName;
end;

procedure TA166FAcquisizione.btnVisualizzaFileClick(Sender: TObject);
begin
  OpenC012VisualizzaTesto('<A166> Acquisizione quote da file',EdtFile.Text,nil,'');
end;

procedure TA166FAcquisizione.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA166FAcquisizione.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A166',Parametri.ProgOper);
  GetParametriFunzione;
end;

procedure TA166FAcquisizione.GetParametriFunzione;
begin
  edtFile.Text:=C004FParamForm.GetParametro('NOMEFILE','');
  dcmbTipoQuota.KeyValue:=C004FParamForm.GetParametro('QUOTA','');
  if dcmbTipoQuota.KeyValue = '' then
    dcmbTipoQuota.KeyValue:=A166FQuoteIndividualiDtM.A166FQuoteIndividualiMW.selT765.FieldByName('CODICE').AsString;
end;

procedure TA166FAcquisizione.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('QUOTA',VarToStr(dcmbTipoQuota.KeyValue));
  C004FParamForm.PutParametro('NOMEFILE',edtFile.Text);
  try SessioneOracle.Commit; except end;
end;

end.

unit A164UAggGlobale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, C004UParamForm, A083UMsgElaborazioni,
  A000UInterfaccia, A000UCostanti, A000USessione, Oracle, OracleData, A003UDataLavoroBis, C180FunzioniGenerali,
  A164UQuoteIncentiviMW, A000UMessaggi;

type
  TA164FAggGlobale = class(TForm)
    Panel2: TPanel;
    dTxtDescQuota: TDBText;
    Label6: TLabel;
    dcmbTipoQuota: TDBLookupComboBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    ProgressBar1: TProgressBar;
    btnDecorrenza: TSpeedButton;
    Label3: TLabel;
    edtPercentuale: TEdit;
    edtDecorrenza: TMaskEdit;
    lblPercentuale: TLabel;
    rgpVariazione: TRadioGroup;
    edtImporto: TEdit;
    lblImporto: TLabel;
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPercentualeChange(Sender: TObject);
    procedure edtImportoChange(Sender: TObject);
    procedure edtDecorrenzaExit(Sender: TObject);
    procedure edtPercentualeExit(Sender: TObject);
    procedure edtImportoExit(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  A164FAggGlobale: TA164FAggGlobale;

  procedure OpenA164AggGlobale;

implementation

uses A164UQuoteIncentiviDtM;

{$R *.dfm}

procedure OpenA164AggGlobale;
begin
  Application.CreateForm(TA164FAggGlobale, A164FAggGlobale);
  try
    A164FAggGlobale.ShowModal;
  finally
    A164FAggGlobale.Free;
  end;
end;

procedure TA164FAggGlobale.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A164','');
end;

procedure TA164FAggGlobale.btnDecorrenzaClick(Sender: TObject);
begin
  edtDecorrenza.Text:=DateToStr(DataOut(StrToDate(edtDecorrenza.Text),'Data decorrenza','G'));
end;

procedure TA164FAggGlobale.btnEseguiClick(Sender: TObject);
var bOk:Boolean;
  AggGlobale: TAggGlobale;
  sAumDim: string;
begin
  if (Trim(edtPercentuale.Text) = '') and (Trim(edtImporto.Text) = '') then
    raise Exception.Create(A000MSG_A164_ERR_PCT_O_IMP);

  if rgpVariazione.ItemIndex  = 0 then
    sAumDim:='l''aumento'
  else
    sAumDim:='la diminuzione';

  if edtPercentuale.Text = '' then
    sAumDim:=sAumDim + ' di ' + edtImporto.Text + '€'
  else
    sAumDim:=sAumDim + ' del ' + edtPercentuale.Text + '%';

  if R180MessageBox( Format(A000MSG_A164_MSG_FMT_AGG_GLOBALE,[dcmbTipoQuota.Text,dtxtDescQuota.Caption,edtDecorrenza.Text,sAumDim ]),'DOMANDA') <> mrYes then
    Exit;
  Screen.Cursor:=crHourGlass;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=5; //5 passaggi

  AggGlobale.sDecorrenza:=edtDecorrenza.Text;
  AggGlobale.sTipoQuota:=dCmbTipoQuota.Text;
  AggGlobale.TipoVariazione:=rgpVariazione.ItemIndex;
  AggGlobale.sPercentuale:=edtPercentuale.Text;
  AggGlobale.sImporto:=edtImporto.Text;

  ProgressBar1.StepBy(1);
  with A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW do
  begin
    bOk:=AggGlobaleStep1;
    if bOk then
    begin
      ProgressBar1.StepBy(1);
      bOk:=AggGlobaleStep2(AggGlobale);
    end;

    if bOk then
    begin
      ProgressBar1.StepBy(1);
      bOk:=AggGlobaleStep3(AggGlobale);
    end;

    if bOk then
    begin
      ProgressBar1.StepBy(1);
      bOk:=AggGlobaleStep4(AggGlobale);
    end;
    if bOk then
    begin
      ProgressBar1.StepBy(1);
      bOk:=AggGlobaleStep5;
    end;
  end;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA164FAggGlobale.edtDecorrenzaExit(Sender: TObject);
var d:TDateTime;
begin
  try
    d:=StrToDate(edtDecorrenza.Text);
  except
    edtDecorrenza.SetFocus;
    raise Exception.Create('Data non valida!');
  end;
end;

procedure TA164FAggGlobale.edtImportoChange(Sender: TObject);
begin
  lblPercentuale.Enabled:=Trim(edtImporto.Text) = '';
  edtPercentuale.Enabled:=Trim(edtImporto.Text) = '';
end;

procedure TA164FAggGlobale.edtImportoExit(Sender: TObject);
var n:Real;
begin
  if edtImporto.Text <> '' then
    try
      n:=StrToFloat(edtImporto.Text);
    except
      edtImporto.SetFocus;
      raise Exception.Create('Importo non valido!');
    end;
end;

procedure TA164FAggGlobale.edtPercentualeChange(Sender: TObject);
begin
  lblImporto.Enabled:=Trim(edtPercentuale.Text) = '';
  edtImporto.Enabled:=Trim(edtPercentuale.Text) = '';
end;

procedure TA164FAggGlobale.edtPercentualeExit(Sender: TObject);
var n:Real;
begin
  if edtPercentuale.Text <> '' then
    try
      n:=StrToFloat(edtPercentuale.Text);
    except
      edtPercentuale.SetFocus;
      raise Exception.Create('Percentuale non valida!');
    end;
end;

procedure TA164FAggGlobale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA164FAggGlobale.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A164',Parametri.ProgOper);
  GetParametriFunzione;
end;

procedure TA164FAggGlobale.GetParametriFunzione;
begin
  edtDecorrenza.Text:=C004FParamForm.GetParametro('DECORRENZA',DateToStr(Parametri.DataLavoro));
  dcmbTipoQuota.KeyValue:=C004FParamForm.GetParametro('QUOTA','');
  if dcmbTipoQuota.KeyValue = '' then
    dcmbTipoQuota.KeyValue:=A164FQuoteIncentiviDtM.A164FQuoteIncentiviMW.selT765.FieldByName('CODICE').AsString;
end;

procedure TA164FAggGlobale.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('QUOTA',VarToStr(dcmbTipoQuota.KeyValue));
  C004FParamForm.PutParametro('DECORRENZA',edtDecorrenza.Text);
  try SessioneOracle.Commit; except end;
end;


end.

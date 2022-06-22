unit A137UCalcoloSpeseAccesso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, ExtCtrls,DB,checklst, ComCtrls, Menus, Variants,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, {C012UVisualizzaTesto,}
  C180FunzioniGenerali, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia,
  A003UDataLavoroBis, Rp502Pro, QueryStorico, SelAnagrafe, R600, Oracle,
  OracleData, Math, Mask, C013UCheckList, A083UMsgElaborazioni, A137UCalcoloSpeseAccessoMW,
  A000UMessaggi;

type
  TA137FCalcoloSpeseAccesso = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    cbxAggiorna: TCheckBox;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    BtnAnteprima: TBitBtn;
    lblMeseComp: TLabel;
    edtMeseComp: TMaskEdit;
    sbtMeseComp: TSpeedButton;
    lblTipoTrasferta: TLabel;
    dcbxTipoTrasferta: TDBLookupComboBox;
    lblPresenzeEscluse: TLabel;
    edtPresenzeEscluse: TEdit;
    btnPresenzeEscluse: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dcbxTipoTrasfertaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbtMeseCompClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure btnPresenzeEscluseClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    procedure PutParametriFunzione;
    procedure GetParametriFunzione;
  public
    { Public declarations }
    DataComp:TDateTime;
    A137FCalcoloSpeseAccessoMW: TA137FCalcoloSpeseAccessoMW;
    //PercorsoFileAnomalie:String;
  end;

var
  A137FCalcoloSpeseAccesso: TA137FCalcoloSpeseAccesso;
//const
//  NomeFileAnomalie:string = 'ANOMALIE_SPESE_ACCESSO.TXT';

procedure OpenA137FCalcoloSpeseAccesso(Prog:LongInt);

implementation

uses A137UStampaSpeseAccesso;

{$R *.DFM}

procedure OpenA137FCalcoloSpeseAccesso(Prog:LongInt);
{Calcolo delle quote maturate sulla base delle regole}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA137FCalcoloSpeseAccesso') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A137FCalcoloSpeseAccesso:=TA137FCalcoloSpeseAccesso.Create(nil);
  with A137FCalcoloSpeseAccesso do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA137FCalcoloSpeseAccesso.btnAnomalieClick(Sender: TObject);
begin
  {
  try
    OpenC012VisualizzaTesto('<A137> Lista anomalie riscontrate',
                            PercorsoFileAnomalie,nil,
                            'Lista anomalie riscontrate nel calcolo delle spese di accesso del mese di '+
                            FormatDateTime('mmmm',DataComp) + ' ' + FormatDateTime('yyyy',DataComp));
  except
    raise Exception.Create('Impossibile visualizzare il file. File inesistente.');
  end;
  }
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A137','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A137FCalcoloSpeseAccessoMW);
end;

procedure TA137FCalcoloSpeseAccesso.btnPresenzeEscluseClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.clbListaDati.Items.Assign(A137FCalcoloSpeseAccessoMW.lstDescPresenze);
    R180PutCheckList(edtPresenzeEscluse.Text,5,C013FCheckList.clbListaDati);
    if C013FCheckList.ShowModal = mrOK then
      edtPresenzeEscluse.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    C013FCheckList.Free;
  end;
end;

procedure TA137FCalcoloSpeseAccesso.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A137FStampaSpeseAccesso.RepR);
end;

procedure TA137FCalcoloSpeseAccesso.BtnStampaClick(Sender: TObject);
begin
  if dcbxTipoTrasferta.Text = '' then
    raise Exception.Create(A000MSG_A117_ERR_NO_TIPOLOGIA);
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  DataComp:=StrToDate('01/' + edtMeseComp.Text);
  //Cancello il file delle anomalie
  //PercorsoFileAnomalie:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\' + Parametri.Operatore + '_' + NomeFileAnomalie;
  //if FileExists(PercorsoFileAnomalie) then
  //  if not(DeleteFile(PercorsoFileAnomalie)) then
  //    raise exception.create('Impossibile registrare anomalie sul file ''' + PercorsoFileAnomalie + '''.' + chr(13) + 'Verificare che il file non sia in uso.');
  RegistraMsg.IniziaMessaggio('A137');

  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
  A137FCalcoloSpeseAccessoMW.TrovateAnomalie:=False;
  //Preparazione
  A137FStampaSpeseAccesso.SettaDataset;
  C001SettaQuickReport(A137FStampaSpeseAccesso.RepR);
  A137FCalcoloSpeseAccessoMW.CreaTabellaStampa;
  //Elaborazione
  C700SelAnagrafe.First;
  ProgressBar1.Position:=0;
  if C700SelAnagrafe.RecordCount > 0 then
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount - 1
  else
    ProgressBar1.Max:=0;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  while not C700SelAnagrafe.Eof do
  begin
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.StepBy(1);
    A137FCalcoloSpeseAccessoMW.ElaboraElemento(DataComp,C700Progressivo,edtPresenzeEscluse.Text);
    C700SelAnagrafe.Next;
  end;
  frmSelAnagrafe.ElaborazioneInterrompibile:=False;
  Self.Enabled:=True;
  frmSelAnagrafe.VisualizzaDipendente;
  ProgressBar1.Position:=0;

  A137FStampaSpeseAccesso.QRLAzienda.Caption:=Parametri.DAzienda;
  A137FStampaSpeseAccesso.LPeriodo.Caption:='dal ' + FormatDateTime('dd/mm/yyyy',DataComp) + ' al ' + FormatDateTime('dd/mm/yyyy',R180FineMese(DataComp));
  if cbxAggiorna.Checked then
    A137FCalcoloSpeseAccessoMW.RegistraMese(DataComp,dcbxTipoTrasferta.Text);
  if Sender = BtnAnteprima then
    A137FStampaSpeseAccesso.RepR.Preview
  else
    A137FStampaSpeseAccesso.RepR.Print;
  A137FCalcoloSpeseAccessoMW.TabellaStampa.Close;
  btnAnomalie.Enabled:=A137FCalcoloSpeseAccessoMW.TrovateAnomalie;
end;

procedure TA137FCalcoloSpeseAccesso.dcbxTipoTrasfertaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA137FCalcoloSpeseAccesso.FormCreate(Sender: TObject);
begin
  A137FCalcoloSpeseAccessoMW:=TA137FCalcoloSpeseAccessoMW.Create(nil);
  A137FStampaSpeseAccesso:=TA137FStampaSpeseAccesso.Create(nil);
end;

procedure TA137FCalcoloSpeseAccesso.FormShow(Sender: TObject);
var
  DataRif: String;
begin
  CreaC004(SessioneOracle,'A137',Parametri.ProgOper);
  dcbxTipoTrasferta.ListSource:=A137FCalcoloSpeseAccessoMW.DsrM010;
  GetParametriFunzione;
  if edtMeseComp.Text = '  /    ' then
    edtMeseComp.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  DataRif:=edtMeseComp.Text;
  C700DataLavoro:=R180FineMese(EncodeDate(StrToInt(Copy(DataRif,4,4)),StrToInt(Copy(DataRif,1,2)),1));
  C700DataDal:=EncodeDate(StrToInt(Copy(DataRif,4,4)),StrToInt(Copy(DataRif,1,2)),1);
  frmSelAnagrafe.CreaSelAnagrafe(A137FCalcoloSpeseAccessoMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
end;

procedure TA137FCalcoloSpeseAccesso.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
var
  DataRif: String;
begin
  DataRif:=edtMeseComp.Text;
  C700DataLavoro:=R180FineMese(EncodeDate(StrToInt(Copy(DataRif,4,4)),StrToInt(Copy(DataRif,1,2)),1));
  C700DataDal:=EncodeDate(StrToInt(Copy(DataRif,4,4)),StrToInt(Copy(DataRif,1,2)),1);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA137FCalcoloSpeseAccesso.GetParametriFunzione;
{Leggo i parametri della form}
begin
  dcbxTipoTrasferta.KeyValue:=C004FParamForm.GetParametro('TIPOTRASFERTA','');
  edtPresenzeEscluse.Text:=C004FParamForm.GetParametro('PRESENZEESCLUSE','');
end;

procedure TA137FCalcoloSpeseAccesso.PutParametriFunzione;
{Leggo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('TIPOTRASFERTA',Trim(VarToStr(dcbxTipoTrasferta.KeyValue)));
  C004FParamForm.PutParametro('PRESENZEESCLUSE',Trim(VarToStr(edtPresenzeEscluse.Text)));
end;

procedure TA137FCalcoloSpeseAccesso.sbtMeseCompClick(Sender: TObject);
begin
  edtMeseComp.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtMeseComp.Text),'Mese competenza','M'));
end;

procedure TA137FCalcoloSpeseAccesso.FormDestroy(Sender: TObject);
begin
  A137FStampaSpeseAccesso.Release;
  FreeAndNil(A137FCalcoloSpeseAccessoMW);
  frmSelAnagrafe.DistruggiSelAnagrafe;
  PutParametriFunzione;
  C004FParamForm.Free;
end;

end.



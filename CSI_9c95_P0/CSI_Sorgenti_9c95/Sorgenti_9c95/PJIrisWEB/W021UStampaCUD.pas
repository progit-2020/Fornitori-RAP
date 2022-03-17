unit W021UStampaCUD;

interface

uses
  R012UWebAnagrafico, R010UPaginaWeb,
  A000UInterfaccia, A000UCostanti, A000USessione, RegistrazioneLog,
  C180FunzioniGenerali, WC012UVisualizzaFileFM,
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompButton, DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  IWVCLBaseContainer, IWContainer, Forms, IWVCLComponent, ActiveX, MConnect,
  StrUtils, meIWLink, meIWButton, meIWLabel,
  meIWComboBox, meIWImageFile;

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TW021FStampaCUD = class(TR012FWebAnagrafico)
    DCOMConnection1: TDCOMConnection;
    cmbCUD: TmeIWComboBox;
    lblAnnoCUD: TmeIWLabel;
    btnStampa: TmeIWButton;
    lnkIstrCUD: TmeIWLink;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkIstrCUDClick(Sender: TObject);
    procedure cmbCUDChange(Sender: TObject);
  private
    DataSt:String;
    procedure VerificaRicezionePdf;
    procedure ImpostaDataConsegna;
  protected
    procedure OnCambiaProgressivo; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, SyncObjs;

function TW021FStampaCUD.InizializzaAccesso:Boolean;
begin
  Result:=True;
  lnkDipendente.Caption:='';
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  with WR000DM.selP504 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('Progressivo').AsInteger);
    Open;
    cmbCUD.Items.Clear;
    while not Eof do
    begin
      cmbCUD.Items.Add(FieldByName('ANNO').AsString);
      Next;
    end;
  end;
  cmbCUD.RequireSelection:=cmbCUD.Items.Count > 0;
  if cmbCUD.Items.Count > 0 then
    cmbCUD.ItemIndex:=0;
  cmbCUDChange(cmbCUD);
end;

procedure TW021FStampaCUD.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR000DM.selP500.Tag:=WR000DM.selP500.Tag + 1;
  GetDipendentiDisponibili(Date);
  cmbDipendentiDisponibili.ItemIndex:=0;
end;

procedure TW021FStampaCUD.RefreshPage;
begin
  with WR000DM do
  begin
    selP500.Close;
    selP500.SetVariable('Anno',StrToIntDef(cmbCUD.Text,0)-1);
    selP500.Open;
  end;
end;

procedure TW021FStampaCUD.lnkIstrCUDClick(Sender: TObject);
var URLDoc:String;
begin
  URLDoc:=ExtractFileName(WR000DM.selP500.FieldByName('WEB_PATH_ISTRUZIONI').AsString);
  VisualizzaFile(URLDoc,'Istruzioni CUD/CU',nil,nil,fdGlobal);
end;

procedure TW021FStampaCUD.cmbCUDChange(Sender: TObject);
begin
  inherited;
  lnkIstrCUD.Visible:=False;
  with WR000DM.selP500 do
  try
    Close;
    SetVariable('ANNO',StrToIntDef(cmbCUD.Text,0)-1);
    Open;
    if FieldByName('WEB_PATH_ISTRUZIONI').AsString <> '' then
      lnkIstrCUD.Visible:=True;
    DataSt:='01/01/1900';
    if not FieldByName('WEB_DATA_STAMPA').IsNull then
      DataSt:=FieldByName('WEB_DATA_STAMPA').AsString;
  except
  end;
end;

procedure TW021FStampaCUD.OnCambiaProgressivo;
var M:String;
begin
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
  begin
    ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    OpenPage;
  end;
end;

procedure TW021FStampaCUD.btnAggiornamentoClick(Sender: TObject);
var
  Mat,NomeFile: String;
  Progressivo,Azione: Integer;
begin
  lblCommentoCorrente.Caption:='';
  if WR000DM.selP504.RecordCount = 0 then
  begin
    MsgBox.MessageBox('Nessun CUD/CU disponibile',INFORMA,'Attenzione');
    exit;
  end;
  try
    Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    Progressivo:=selAnagrafeW.Lookup('MATRICOLA',Mat,'PROGRESSIVO');
    NomeFile:=GetNomeFile('pdf');
    if not IsLibrary then
      CoInitialize(nil);
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      DCOMConnection1.AppServer.CreaStampa(IntToStr(Progressivo),
                                           IntToStr(StrToIntDef(cmbCUD.Text,0)-1),
                                           DataSt,
                                           NomeFile,
                                           IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'),
                                           Parametri.Operatore,
                                           Parametri.ProfiloWEB,
                                           Parametri.Azienda,
                                           WR000DM.selAnagrafe.Session.LogonDataBase
                                           );
    finally
      DCOMConnection1.Connected:=False;
    end;
    Azione:=0;
    if Parametri.WebRichiestaConsegnaCed = 'S' then
      with WR000DM.selaP504 do
      begin
        Close;
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('ANNO',StrToIntDef(cmbCUD.Text,0)-1);
        Open;
        if (RecordCount > 0) and (FieldByName('DATA_CONSEGNA').AsString = '') then
          Azione:=1;
      end;
    case Azione of
      0: VisualizzaFile(NomeFile,'Anteprima CUD/CU',nil,nil);
      1: VisualizzaFile(NomeFile,'Anteprima CUD/CU',nil,VerificaRicezionePdf);
    end;
    // file inline.fine
  except
    on E:Exception do
    begin
      Log(ERRORE,'Errore durante la creazione della stampa',E);
      MsgBox.MessageBox('Errore in fase di elaborazione della stampa:' + CRLF +
                        E.Message + CRLF +
                        IfThen(E.ClassName <> 'Exception','Tipo: ' + E.ClassName),ESCLAMA);
      Exit;
    end;
  end;
end;

procedure TW021FStampaCUD.VerificaRicezionePdf;
begin
  Messaggio('Conferma','Si conferma l''avvenuta ricezione del modello CUD/CU per l''anno ' + cmbCUD.Text + '?', ImpostaDataConsegna, nil);
end;

procedure TW021FStampaCUD.ImpostaDataConsegna;
begin
  with WR000DM.selaP504 do
  begin
    Edit;
    FieldByName('DATA_CONSEGNA').AsDateTime:=Trunc(R180Sysdate(SessioneOracle));
    Post;
    SessioneOracle.Commit;
  end;
end;

procedure TW021FStampaCUD.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selP500);
  end;
end;

end.

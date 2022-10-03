unit A151UEsportaXml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, C012UVisualizzaTesto, DBCtrls, C004UParamForm,
  A000USessione, A000UInterfaccia, C180FunzioniGenerali, Oracle, OracleData, StrUtils,
  xmldom, XMLIntf, msxmldom, XMLDoc, A083UMsgElaborazioni, A000UMessaggi,
  SelAnagrafe, C700USelezioneAnagrafe;

type
  TA151FEsportaXml = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    btnEsegui: TBitBtn;
    SaveDialog1: TSaveDialog;
    btnAnomalie: TBitBtn;
    Panel2: TPanel;
    edtNomeFileOutput: TEdit;
    lblNomeFileOutput: TLabel;
    sbtNomeFileOutput: TSpeedButton;
    pnlTassiAssenza: TPanel;
    lblDescIdUfficio: TLabel;
    dcmbIdUfficio: TDBLookupComboBox;
    Label2: TLabel;
    dcmbIdMittente: TDBLookupComboBox;
    Label1: TLabel;
    lblDescIdMittente: TLabel;
    pnlLegge104: TPanel;
    edtUsername: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    lblPassword: TLabel;
    edtCodiceEnte: TEdit;
    Label5: TLabel;
    lblURLWS: TLabel;
    edtURLWS: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dcmbIdMittenteCloseUp(Sender: TObject);
    procedure dcmbIdMittenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbIdMittenteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbIdUfficioCloseUp(Sender: TObject);
    procedure dcmbIdUfficioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtNomeFileOutputClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  A151FEsportaXml: TA151FEsportaXml;

  procedure OpenA151EsportaXml;

implementation

uses A151UAssenteismoDtM, A151UAssenteismo, A151UGrigliaRisultato;

{$R *.dfm}

procedure OpenA151EsportaXml;
begin
  A151FEsportaXml:=TA151FEsportaXml.Create(nil);
  with A151FEsportaXml do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TA151FEsportaXml.FormShow(Sender: TObject);
begin
  dcmbIdMittente.ListSource:=A151FAssenteismoDtM.A151MW.dsrI010;
  dcmbIdUfficio.ListSource:=A151FAssenteismoDtM.A151MW.dsrI010B;
  if A151FAssenteismoDtM.A151MW.EsportaTassiAss then
  begin
    A151FEsportaXml.Caption:='Esportazione tassi assenza in formato .XML';
    A151FEsportaXml.Height:=225;
    pnlTassiAssenza.Visible:=True;
    pnlLegge104.Visible:=False;
    pnlTassiAssenza.Align:=alClient;
    lblNomeFileOutput.Visible:=True;
  end
  else if A151FAssenteismoDtM.A151MW.EsportaLegge104 then
  begin
    A151FEsportaXml.Caption:='Invio permessi legge 104/1992 tramite WebService';
    A151FEsportaXml.Height:=275;
    pnlTassiAssenza.Visible:=False;
    pnlLegge104.Visible:=True;
    pnlLegge104.Align:=alClient;
    lblNomeFileOutput.Visible:=False;
  end;
  edtNomeFileOutput.Visible:=lblNomeFileOutput.Visible;
  sbtNomeFileOutput.Visible:=lblNomeFileOutput.Visible;
  btnVisualizzaFile.Visible:=lblNomeFileOutput.Visible;
  lblURLWS.Visible:=not lblNomeFileOutput.Visible;
  edtURLWS.Visible:=not edtNomeFileOutput.Visible;
  lblURLWS.Top:=lblNomeFileOutput.Top;
  edtURLWS.Top:=edtNomeFileOutput.Top;
  CreaC004(SessioneOracle, 'A151', Parametri.ProgOper);
  GetParametriFunzione;
  dcmbIdMittenteCloseUp(nil);
  dcmbIdUfficioCloseUp(nil);
end;

procedure TA151FEsportaXml.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA151FEsportaXml.GetParametriFunzione;
{ Leggo i parametri della form }
begin
  dcmbIdMittente.KeyValue:=C004FParamForm.GetParametro('dcmbIdMittente', '');
  dcmbIdUfficio.KeyValue:=C004FParamForm.GetParametro('dcmbIdUfficio', '');
  edtUsername.Text:=C004FParamForm.GetParametro('edtUsername', '');
  edtPassword.Text:=C004FParamForm.GetParametro('edtPassword', '');
  edtCodiceEnte.Text:=C004FParamForm.GetParametro('edtCodiceEnte', '');
  edtURLWS.Text:=C004FParamForm.GetParametro('edtURLWS', '');
  edtNomeFileOutput.Text:=C004FParamForm.GetParametro('edtNomeFileOutput', '');
end;

procedure TA151FEsportaXml.PutParametriFunzione;
{ Scrivo i parametri della forma }
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('dcmbIdMittente', VarToStr(dcmbIdMittente.KeyValue));
  C004FParamForm.PutParametro('dcmbIdUfficio', VarToStr(dcmbIdUfficio.KeyValue));
  C004FParamForm.PutParametro('edtUsername', edtUsername.Text);
  C004FParamForm.PutParametro('edtPassword', edtPassword.Text);
  C004FParamForm.PutParametro('edtCodiceEnte', edtCodiceEnte.Text);
  C004FParamForm.PutParametro('edtURLWS', edtURLWS.Text);
  C004FParamForm.PutParametro('edtNomeFileOutput', edtNomeFileOutput.Text);
  try
    SessioneOracle.Commit;
  except
  end;
end;

procedure TA151FEsportaXml.dcmbIdMittenteCloseUp(Sender: TObject);
begin
  lblDescIdMittente.Visible:=pnlTassiAssenza.Visible and (dcmbIdMittente.Text <> '');
  if lblDescIdMittente.Visible then
    with A151FAssenteismoDtM.A151MW do
    begin
      if dcmbIdMittente.KeyValue <> VarToStr(selI010.Lookup('NOME_CAMPO',dcmbIdMittente.KeyValue,'NOME_LOGICO')) then
        lblDescIdMittente.Caption:=VarToStr(selI010.Lookup('NOME_CAMPO',dcmbIdMittente.KeyValue,'NOME_LOGICO'));
      if cdsRisultato.FieldByName(dcmbIdMittente.KeyValue).DisplayLabel <> lblDescIdMittente.Caption then
        lblDescIdMittente.Caption:=lblDescIdMittente.Caption + IfThen(lblDescIdMittente.Caption='','',' (Colonna ') +
          cdsRisultato.FieldByName(dcmbIdMittente.KeyValue).DisplayLabel + IfThen(lblDescIdMittente.Caption='','',')');
    end;
end;

procedure TA151FEsportaXml.dcmbIdMittenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
(*    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;*)
  end;
end;

procedure TA151FEsportaXml.dcmbIdMittenteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbIdMittenteCloseUp(nil);
end;

procedure TA151FEsportaXml.dcmbIdUfficioCloseUp(Sender: TObject);
begin
  lblDescIdUfficio.Visible:=pnlTassiAssenza.Visible and (dcmbIdUfficio.Text <> '');
  if lblDescIdUfficio.Visible then
    with A151FAssenteismoDtM.A151MW do
    begin
      if VarToStr(selI010B.Lookup('NOME_CAMPO',dcmbIdUfficio.KeyValue,'NOME_LOGICO')) <> dcmbIdUfficio.KeyValue then
        lblDescIdUfficio.Caption:=VarToStr(selI010B.Lookup('NOME_CAMPO',dcmbIdUfficio.KeyValue,'NOME_LOGICO'));
      if cdsRisultato.FieldByName(dcmbIdUfficio.KeyValue).DisplayLabel <> lblDescIdUfficio.Caption then
        lblDescIdUfficio.Caption:=lblDescIdUfficio.Caption + IfThen(lblDescIdUfficio.Caption='','',' (Colonna ') +
          cdsRisultato.FieldByName(dcmbIdUfficio.KeyValue).DisplayLabel + IfThen(lblDescIdUfficio.Caption='','',')');
    end;
end;

procedure TA151FEsportaXml.dcmbIdUfficioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dcmbIdUfficioCloseUp(nil);
end;

procedure TA151FEsportaXml.sbtNomeFileOutputClick(Sender: TObject);
begin
  SaveDialog1.Title:='Nome file di esportazione';
  if edtNomeFileOutput.Text <> '' then
    SaveDialog1.FileName:=edtNomeFileOutput.Text;
  if SaveDialog1.Execute then
    edtNomeFileOutput.Text:=SaveDialog1.FileName;
end;

procedure TA151FEsportaXml.btnEseguiClick(Sender: TObject);
begin
  btnVisualizzaFile.Enabled:=False;
  with A151FAssenteismoDtM.A151MW do
  begin
    if EsportaTassiAss then
    begin
      if Trim(edtNomeFileOutput.Text) = '' then
        raise Exception.Create(A000MSG_A151_ERR_NO_FILE);
      if FileExists(edtNomeFileOutput.Text) then
        if R180MessageBox(A000MSG_A151_DLG_FILE_ESISTE, DOMANDA) = mrNo then
          Exit
        else if not DeleteFile(edtNomeFileOutput.Text) then
          raise Exception.Create(A000MSG_A151_ERR_FILE_IN_USO);
    end;
    IdUfficioText:=dcmbIdUfficio.Text;
    IdUfficioValue:=VarToStr(dcmbIdUfficio.KeyValue);
    IdMittenteText:=dcmbIdMittente.Text;
    IdMittenteValue:=VarToStr(dcmbIdMittente.KeyValue);
    UserNameText:=edtUsername.Text;
    PasswordText:=edtPassword.Text;
    CodEnteText:=edtCodiceEnte.Text;
    URLWSText:=edtURLWS.Text;
    DettDip:=A151FAssenteismo.dchkDettaglioDip.Checked;
    DettGG:=A151FAssenteismo.dchkDettaglioGiustificativi.Checked;
    DettFam:=A151FAssenteismo.dchkDettaglioFamiliari.Checked;
    if EsportaTassiAss then
      ControlliGeneraXmlTassiAss
    else if EsportaLegge104 then
      ControlliGeneraXmlLegge104;
    cdsRisultato.DisableControls;
    cdsRisultato.First;
    Screen.Cursor:=crHourGlass;
    try
      //Esportazione in xml
      RegistraMsg.IniziaMessaggio('A151');//Posizionato dopo le domande dei controlli
      if EsportaTassiAss then
        try
          GeneraXmlTassiAss;
        finally
          XMLGenerato.SaveToFile(edtNomeFileOutput.Text);
          XMLGenerato.Active:=False;
          cdsRisultato.First;
          cdsRisultato.EnableControls;
          Screen.Cursor:=crDefault;
        end
      else if EsportaLegge104 then
        try
          WSLegge104;
        finally
          cdsRisultato.First;
          cdsRisultato.EnableControls;
          Screen.Cursor:=crDefault;
        end;
    finally //gestito in caso di abort in WSLegge104
      btnVisualizzaFile.Enabled:=True;
      btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
      if RegistraMsg.ContieneTipoA then
      begin
        if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
          btnAnomalieClick(nil);
      end
      else
        R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
    end;
  end;
end;

procedure TA151FEsportaXml.btnVisualizzaFileClick(Sender: TObject);
begin
  try
    OpenC012VisualizzaTesto('<A151> Visualizzazione file di esportazione',
      edtNomeFileOutput.Text, nil, 'Visualizzazione file di esportazione');
  except
    raise Exception.Create(A000MSG_ERR_VISUALIZ_FILE);
  end;
end;

procedure TA151FEsportaXml.btnAnomalieClick(Sender: TObject);
begin
  A151FAssenteismo.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A151','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  A151FAssenteismo.frmSelAnagrafe.RipristinaC00SelAnagrafe(A151FAssenteismoDtM.A151MW);
end;

end.

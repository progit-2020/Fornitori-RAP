unit A169UPesatureIndividuali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Grids, DBGrids, ToolbarFiglio, StdCtrls,
  C600USelAnagrafe, DBCtrls, Buttons, Mask, ExtCtrls, ActnList, ImgList, DB,
  Menus, ComCtrls, ToolWin, A000UInterfaccia, A000UCostanti, A000USessione, A003UDataLavoroBis,
  C180FunzioniGenerali, Oracle, OracleData, QueryStorico, Clipbrd, C013UCheckList,
  A083UMsgElaborazioni, C005UDatiAnagrafici, System.Actions, A169UPesatureIndividualiMW, A169UCalcoloDtM, A000UMessaggi;

type
  TA169FPesatureIndividuali = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dtxtDescrizione: TDBText;
    lblTotPesiCalc: TLabel;
    lblTotQuoteCalc: TLabel;
    lblTotQuote: TLabel;
    lblTotPesi: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtFiltroAnagrafe: TDBEdit;
    dcmbTipoQuota: TDBLookupComboBox;
    dedtPesoTotale: TDBEdit;
    dedtQuotaTotale: TDBEdit;
    dedtPesoIndMin: TDBEdit;
    dedtPesoIndMax: TDBEdit;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    edtTotPesiCalc: TEdit;
    edtTotQuoteCalc: TEdit;
    edtTotQuote: TEdit;
    edtTotPesi: TEdit;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdPesatureInd: TDBGrid;
    Label12: TLabel;
    btnAnno: TBitBtn;
    dedtDataRif: TDBEdit;
    Label13: TLabel;
    btnDataRif: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    dedtAnno: TDBEdit;
    ProgressBar1: TProgressBar;
    Datianagrafici1: TMenuItem;
    N4: TMenuItem;
    dchkChiuso: TDBCheckBox;
    btnAnomalie: TBitBtn;
    procedure btnAnnoClick(Sender: TObject);
    procedure btnDataRifClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dcmbTipoQuotaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbTipoQuotaCloseUp(Sender: TObject);
    procedure dcmbTipoQuotaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure dedtAnnoExit(Sender: TObject);
    procedure dgrdPesatureIndDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Datianagrafici1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    InterrompiElaborazione:Boolean;
  public
    procedure Aggiorna(Msg,Blocca:Boolean);
  end;

var
  A169FPesatureIndividuali: TA169FPesatureIndividuali;

  procedure OpenA169PesatureIndividuali;

implementation

uses A169UPesatureIndividualiDtM;

{$R *.dfm}

procedure OpenA169PesatureIndividuali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA169PesatureIndividuali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA169FPesatureIndividuali, A169FPesatureIndividuali);
  Application.CreateForm(TA169FPesatureIndividualiDtM, A169FPesatureIndividualiDtM);
  try
    Screen.Cursor:=crDefault;
    A169FPesatureIndividuali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A169FPesatureIndividuali.Free;
    A169FPesatureIndividualiDtM.Free;
  end;
end;

procedure TA169FPesatureIndividuali.C600frmSelAnagrafebtnSelezioneClick(
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
  C600frmSelAnagrafe.C600DataLavoro:=A169FPesatureIndividualiDtM.selT773.FieldByName('DATARIF').AsDateTime;
//  inherited;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A169FPesatureIndividualiDtM.selT773.FieldByName('FILTRO_ANAGRAFE').AsString:=S;
  end;
end;

procedure TA169FPesatureIndividuali.Copia2Click(Sender: TObject);
var S:String;
    i:Integer;
begin
  with dgrdPesatureInd.DataSource.DataSet do
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
        if dgrdPesatureInd.SelectedRows.CurrentRowSelected then
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
end;

procedure TA169FPesatureIndividuali.btnAnnoClick(Sender: TObject);
begin
  inherited;
  DButton.DataSet.FieldByName('ANNO').AsInteger:=StrToIntDef(Copy(DateToStr(DataOut(StrToDate('01/01/' + DButton.DataSet.FieldByName('ANNO').AsString),'Anno elaborazione','A')),7,4),0);
end;

procedure TA169FPesatureIndividuali.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A169','');
end;

procedure TA169FPesatureIndividuali.btnDataRifClick(Sender: TObject);
begin
  inherited;
  DButton.DataSet.FieldByName('DATARIF').AsDateTime:=DataOut(DButton.DataSet.FieldByName('DATARIF').AsDateTime,'Data di riferimento','D');
end;

procedure TA169FPesatureIndividuali.Datianagrafici1Click(Sender: TObject);
begin
  inherited;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  try
    C005FDatiAnagrafici.ShowDipendente(A169FPesatureIndividualiDtM.A169FPesatureIndividualiMW.selT774.FieldByName('PROGRESSIVO').AsInteger);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA169FPesatureIndividuali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnAnno.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataRif.Enabled:=DButton.State in [dsEdit,dsInsert];
  C600frmSelAnagrafe.Enabled:=DButton.State in [dsEdit,dsInsert];
  frmToolbarFiglio.Enabled:=DButton.State = dsBrowse;
end;

procedure TA169FPesatureIndividuali.dcmbTipoQuotaCloseUp(Sender: TObject);
begin
  inherited;
  dtxtDescrizione.Visible:=Trim(dcmbTipoQuota.Text) <> '';
end;

procedure TA169FPesatureIndividuali.dcmbTipoQuotaKeyDown(Sender: TObject;
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

procedure TA169FPesatureIndividuali.dcmbTipoQuotaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbTipoQuotaCloseUp(nil);
end;

procedure TA169FPesatureIndividuali.dedtAnnoExit(Sender: TObject);
begin
  inherited;
  if (DButton.State in [dsEdit,dsInsert]) and (DButton.DataSet.FieldByName('ANNO').asString <> '') and
    (DButton.DataSet.FieldByName('DATARIF').IsNull) then
    DButton.DataSet.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + DButton.DataSet.FieldByName('ANNO').asString);
end;

procedure TA169FPesatureIndividuali.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdPesatureInd,'N');
end;

procedure TA169FPesatureIndividuali.dgrdPesatureIndDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if gdFixed in State then exit;
  with A169FPesatureIndividualiDtM do
  begin
    if (A169FPesatureIndividualiMW.A169FCalcoloDtM.lstMatricole <> nil) and (R180IndexOf(A169FPesatureIndividualiMW.A169FCalcoloDtM.lstMatricole,A169FPesatureIndividualiMW.selT774.FieldByName('MATRICOLA').ASString,8) >= 0) then
    begin
      if gdSelected in State then
      begin
        dgrdPesatureInd.Canvas.Brush.Color:=clHighLight;
        dgrdPesatureInd.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        dgrdPesatureInd.Canvas.Brush.Color:=$00FFFF80;
        dgrdPesatureInd.Canvas.Font.Color:=clWindowText;
      end;
      dgrdPesatureInd.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
  end;
end;

procedure TA169FPesatureIndividuali.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #27 then
  begin
    if R180MessageBox(A000MSG_DLG_INTEROMPERE_OPERAZIONE,'DOMANDA') = mrYes then
      InterrompiElaborazione:=True;
  end;
end;

procedure TA169FPesatureIndividuali.FormShow(Sender: TObject);
begin
  dcmbTipoQuota.ListSource:=A169FPesatureIndividualiDtM.A169FPesatureIndividualiMW.dsrT765;
  dtxtDescrizione.DataSource:=A169FPesatureIndividualiDtM.A169FPesatureIndividualiMW.dsrT765;
  frmToolbarFiglio.TFDButton:=A169FPesatureIndividualiDtM.A169FPesatureIndividualiMW.dsrT774;
  frmToolbarFiglio.TFDBGrid:=dgrdPesatureInd;
  frmToolbarFiglio.ConfermaCancella:=False;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  inherited;
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  dcmbTipoQuotaCloseUp(nil);
  InterrompiElaborazione:=False;
end;

procedure TA169FPesatureIndividuali.frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
var SumPI:Real;
begin
  inherited;
  SumPI:=A169FPesatureIndividualiDtM.A169FPesatureIndividualiMW.SumT774PesoIndividuale;
  if (A169FPesatureIndividualiDtM.selT773.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     //(A169FCalcoloDTM.TotalePesi > A169FPesatureIndividualiDtM.selT773.FieldByName('PESO_TOTALE').AsFloat) then
     (SumPI > A169FPesatureIndividualiDtM.selT773.FieldByName('PESO_TOTALE').AsFloat) then
  begin
    edtTotPesi.Text:=FloatToStr(SumPI);
    edtTotPesi.Font.Color:=clRed;
    lblTotPesi.Font.Color:=clRed;
    raise exception.Create(A000MSG_A169_ERR_PESI_BASE);
  end;
  //inherited;
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
  Aggiorna(True,False);
end;

procedure TA169FPesatureIndividuali.frmToolbarFigliobtnTFAnnullaClick(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
end;

procedure TA169FPesatureIndividuali.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdPesatureInd,'C');
end;

procedure TA169FPesatureIndividuali.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdPesatureInd,'S');
end;

procedure TA169FPesatureIndividuali.Aggiorna(Msg,Blocca:Boolean);
begin
  with A169FPesatureIndividualiDtM do
  begin
    A169FPesatureIndividualiMW.A169FCalcoloDtM.AggiornaTotali(selT773.FieldByName('ANNO').AsInteger,selT773.FieldByName('CODGRUPPO').AsString,selT773.FieldByName('CODTIPOQUOTA').AsString);
    Text:=FloatToStr(A169FPesatureIndividualiMW.A169FCalcoloDtM.TotalePesi);
    edtTotPesi.Text:=FloatToStr(A169FPesatureIndividualiMW.A169FCalcoloDtM.TotalePesi);
    edtTotPesiCalc.Text:=FloatToStr(A169FPesatureIndividualiMW.A169FCalcoloDtM.TotalePesiCalc);
    edtTotQuote.Text:=Format('%15.2n',[A169FPesatureIndividualiMW.A169FCalcoloDtM.TotaleQuote]);
    edtTotQuoteCalc.Text:=Format('%15.2n',[A169FPesatureIndividualiMW.A169FCalcoloDtM.TotaleQuoteCalc]);
    edtTotPesi.Font.Color:=clBlack;
    lblTotPesi.Font.Color:=clBlack;
    edtTotPesiCalc.Font.Color:=clBlack;
    lblTotPesiCalc.Font.Color:=clBlack;
    edtTotQuote.Font.Color:=clBlack;
    lblTotQuote.Font.Color:=clBlack;
    edtTotQuoteCalc.Font.Color:=clBlack;
    lblTotQuoteCalc.Font.Color:=clBlack;
    if (selT773.FieldByName('PESO_TOTALE').AsFloat <> 0) and
       (A169FPesatureIndividualiMW.A169FCalcoloDtM.TotalePesi > selT773.FieldByName('PESO_TOTALE').AsFloat) then
    begin
      edtTotPesi.Font.Color:=clRed;
      lblTotPesi.Font.Color:=clRed;
      if Msg then
        if Blocca then
          raise exception.Create(A000MSG_A169_ERR_PESI_BASE)
        else
          R180MessageBox(A000MSG_A169_ERR_PESI_BASE,'ERRORE');
    end;
    if (selT773.FieldByName('PESO_TOTALE').AsFloat <> 0) and
       (A169FPesatureIndividualiMW.A169FCalcoloDtM.TotalePesiCalc > selT773.FieldByName('PESO_TOTALE').AsFloat) then
    begin
      edtTotPesiCalc.Font.Color:=clRed;
      lblTotPesiCalc.Font.Color:=clRed;
      if Msg then
        R180MessageBox(A000MSG_A169_ERR_PESI_CALCOLATI,'ERRORE');
    end;
    if (selT773.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
       (A169FPesatureIndividualiMW.A169FCalcoloDtM.TotaleQuote > selT773.FieldByName('QUOTA_TOTALE').AsFloat) then
    begin
      edtTotQuote.Font.Color:=clRed;
      lblTotQuote.Font.Color:=clRed;
      if Msg then
        R180MessageBox(A000MSG_A169_ERR_QUOTE_ASSEGNATE,'ERRORE');
    end;
    if (selT773.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
       (A169FPesatureIndividualiMW.A169FCalcoloDtM.TotaleQuoteCalc > selT773.FieldByName('QUOTA_TOTALE').AsFloat) then
    begin
      edtTotQuoteCalc.Font.Color:=clRed;
      lblTotQuoteCalc.Font.Color:=clRed;
      if Msg then
        R180MessageBox(A000MSG_A169_ERR_QUOTE_CALCOLATE,'ERRORE');
    end;
  end;
end;

end.

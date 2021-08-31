unit A069UBudgetEsterno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Spin,
  C004UParamForm, Grids, DBGrids, A000UInterfaccia, C180FunzioniGenerali, A069UBudgetEsternoDtm,
  Buttons, SelAnagrafe, C700USelezioneAnagrafe, A000UCostanti, A000USessione, OracleData,
  Mask, A000UMessaggi, System.Actions;

type
  TA069FBudgetEsterno = class(TR001FGestTab)
    pnlTop: TPanel;
    dGrdT710: TDBGrid;
    lblAnno: TLabel;
    btnAcquisisci: TSpeedButton;
    btnVerifica: TSpeedButton;
    pnlAnagrafe: TPanel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    popMnu1: TPopupMenu;
    Copia1: TMenuItem;
    CopiainExcel1: TMenuItem;
    edtData: TMaskEdit;
    SpeedButton1: TSpeedButton;
    actRegistraLiquidazioni: TAction;
    actAcquisisciDati: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure dGrdT710DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnVerificaClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure edtDataChange(Sender: TObject);
    procedure actRegistraLiquidazioniExecute(Sender: TObject);
    procedure actAcquisisciDatiExecute(Sender: TObject);
  private
    { Private declarations }
    procedure PutParametri;
    procedure GetParametri;
    procedure GestButtons(Abilita:Boolean);
  public
    { Public declarations }
  end;

var
  A069FBudgetEsterno: TA069FBudgetEsterno;

procedure OpenA069BudgetEsterno;

implementation

{$R *.dfm}

procedure OpenA069BudgetEsterno;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA069BudgetEsterno') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A069FBudgetEsterno:=TA069FBudgetEsterno.Create(nil);
  with A069FBudgetEsterno do
    try
      A069FBudgetEsternoDtm:=TA069FBudgetEsternoDtm.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      FreeAndNil(A069FBudgetEsternoDtm);
      Free;
    end;
end;

procedure TA069FBudgetEsterno.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.NumRecords;

  A069FBudgetEsternoDtM.OpenSelT710;

  CreaC004(SessioneOracle,'A069',Parametri.ProgOper);
  GetParametri;
  GestButtons(False);
  actInserisci.Visible:=False;
  actAcquisisciDati.Enabled:=not SolaLettura;
  actRegistraLiquidazioni.Enabled:=(not SolaLettura) and (A069FBudgetEsternoDtM.selLiquidazioni.Active);
end;

procedure TA069FBudgetEsterno.GetParametri;
begin
  edtData.Text:=C004FParamForm.GetParametro(UpperCase(edtData.Name), FormatDateTime('mm/yyyy',Parametri.DataLavoro));
end;

procedure TA069FBudgetEsterno.PutParametri;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro(UpperCase(edtData.Name), edtData.Text);
end;

procedure TA069FBudgetEsterno.GestButtons(Abilita:Boolean);
begin
  //SolaLettura:=True;
  {Se in EDIT aggiungo l'opzione "dgEditing" e rimuovo l'opzione "dgRowSelect"
   Se in BROWSE aggiungo l'opzione "dgRowSelect" e rimuovo l'opzione "dgEditing"}
  if Abilita then
    dGrdT710.Options:=[dgEditing,dgTitles,dgIndicator,dgIndicator,dgColumnResize,dgColLines,dgRowLines,
                       dgTabs]
  else
    dGrdT710.Options:=[dgTitles,dgIndicator,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,
                       dgRowSelect,dgMultiSelect];
  actRicerca.Enabled:=not Abilita;
  actPrimo.Enabled:=not Abilita;
  actPrecedente.Enabled:=not Abilita;
  actSuccessivo.Enabled:=not Abilita;
  actUltimo.Enabled:=not Abilita;
  actRefresh.Enabled:=not Abilita;
  actModifica.Enabled:=not Abilita and not SolaLettura;
  actAnnulla.Enabled:=Abilita and not SolaLettura;
  actConferma.Enabled:=Abilita and not SolaLettura;
  actGomma.Enabled:=Abilita and not SolaLettura;
  actStampa.Enabled:=not Abilita;
  edtData.Enabled:=not Abilita;
  btnVerifica.Enabled:=not Abilita;
end;

procedure TA069FBudgetEsterno.actAcquisisciDatiExecute(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  try
    D:=StrToDate('01/' + edtData.Text);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[edtData.Text]));
  end;
  Screen.Cursor:=crHourGlass;
  try
    A069FBudgetEsternoDtm.AcquisizioneBudget(R180Anno(D));
    A069FBudgetEsternoDtm.selLiquidazioni.Close;
  finally
    Screen.Cursor:=crDefault;
    actRegistraLiquidazioni.Enabled:=(not SolaLettura) and (A069FBudgetEsternoDtM.selLiquidazioni.Active);
  end;
end;

procedure TA069FBudgetEsterno.actRegistraLiquidazioniExecute(Sender: TObject);
begin
  inherited;
  Screen.Cursor:=crHourGlass;
  try
    if A069FBudgetEsternoDtM.RegistraLiquidazioni = 'Anomalie' then
      MessageDlg('Sono presenti liquidazioni che superano la quantità impegnata prevista.' + CRLF + 'Lo scarico paghe sarà inibito.',mtInformation,[mbOK],0)
    else
      ShowMessage('Tutte le liquidazioni rientrano nelle quantità impegnate previste.');
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA069FBudgetEsterno.btnVerificaClick(Sender: TObject);
begin
  inherited;
  try
    A069FBudgetEsternoDtm.DataRiferimento:=StrToDate('01/' + edtData.Text);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[edtData.Text]));
  end;
  Screen.Cursor:=crHourGlass;
  try
    with A069FBudgetEsternoDtm do
    begin
      OpenSelLiquidazioni;
      selT710.Refresh;
    end;
  finally
    Screen.Cursor:=crDefault;
    actRegistraLiquidazioni.Enabled:=(not SolaLettura) and (A069FBudgetEsternoDtM.selLiquidazioni.Active);
  end;
end;

procedure TA069FBudgetEsterno.CopiainExcel1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdT710,'S');
  R180DBGridCopyToClipboard(dGrdT710,Sender = CopiaInExcel1, True, False, False);
end;

procedure TA069FBudgetEsterno.DButtonStateChange(Sender: TObject);
begin
  //inherited;// Inibita gestione dei pulsanti del R001
  (*
  if DButton.State in [dsInsert, dsEdit] then
    GestButtons(True);
  *)
end;

procedure TA069FBudgetEsterno.dGrdT710DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var DispVariazione:Real;
begin
  inherited;
  if gdFixed in State then
    exit;
  if gdSelected in State then
  begin
    dGrdT710.Canvas.Brush.Color:=clHighLight;
    dGrdT710.Canvas.Font.Color:=clWhite;
  end
  else
  begin
    with dGrdT710.DataSource do
    begin
      //Sommo un'eventuale variazione alla disponibilità SE
      //il periodo di variazione comprende la data di riferimento
      DispVariazione:=DataSet.FieldByName('DISPONIBILITA').AsFloat;
      if R180Between(A069FBudgetEsternoDtm.DataRiferimento,
                     DataSet.FieldByName('DECORRENZA_VARIAZIONE').AsDateTime,
                     DataSet.FieldByName('SCADENZA_VARIAZIONE').AsDateTime) then
        DispVariazione:=DispVariazione + DataSet.FieldByName('VARIAZIONE').AsFloat;

      if DataSet.FieldByName('C_UTILIZZO').AsFloat > DispVariazione then
      begin
        dGrdT710.Canvas.Brush.Color:=clRed;
        dGrdT710.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        if Not Column.Field.ReadOnly and (Column.Field.FieldKind <> fkCalculated) then
          dGrdT710.Canvas.Brush.Color:=clWhite
        else
          dGrdT710.Canvas.Brush.Color:=cl3DLight;
        dGrdT710.Canvas.Font.Color:=clBlack;
      end;
    end;
  end;
  dGrdT710.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA069FBudgetEsterno.edtDataChange(Sender: TObject);
begin
  inherited;
  if TryStrToDate('01/' + edtData.Text,A069FBudgetEsternoDtm.DataRiferimento) then
  begin
    C700DataDal:=EncodeDate(R180Anno(A069FBudgetEsternoDtm.DataRiferimento),1,1);
    C700DataLavoro:=R180FineMese(A069FBudgetEsternoDtm.DataRiferimento);
    A069FBudgetEsternoDtm.OpenselT710;
  end;
end;

procedure TA069FBudgetEsterno.TAnnullaClick(Sender: TObject);
begin
  inherited;
  GestButtons(False);
  with A069FBudgetEsternoDtm do
    SessioneOracle.CancelUpdates([selT710]);
end;

procedure TA069FBudgetEsterno.TInserClick(Sender: TObject);
begin
  inherited;
  GestButtons(True);
end;

procedure TA069FBudgetEsterno.TModifClick(Sender: TObject);
begin
  inherited;
  GestButtons(True);
end;

procedure TA069FBudgetEsterno.TRegisClick(Sender: TObject);
begin
  //inherited; Inibita gestione dei pulsanti del R001
  with A069FBudgetEsternoDtm do
  begin
    if selT710.State in [dsInsert, dsEdit] then
      selT710.Post;
    SessioneOracle.ApplyUpdates([selT710],True);
  end;
  GestButtons(False);
end;

procedure TA069FBudgetEsterno.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if frmSelAnagrafe.C700ModalResult = mrOK then
  try
    A069FBudgetEsternoDtm.DataRiferimento:=StrToDate('01/' + edtData.Text);
    A069FBudgetEsternoDtm.OpenSelT710;
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[edtData.Text]));
  end;
end;

procedure TA069FBudgetEsterno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  PutParametri;
  FreeAndNil(C004FParamForm);
end;

procedure TA069FBudgetEsterno.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

end.

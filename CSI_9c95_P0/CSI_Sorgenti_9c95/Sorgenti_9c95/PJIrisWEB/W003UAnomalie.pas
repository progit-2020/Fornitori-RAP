unit W003UAnomalie;

interface

uses
  Classes, IWTemplateProcessorHTML, IWForm, IWAppForm, C004UParamForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl, IWApplication,
  SysUtils, IWCompEdit, IWCompButton, IWCompCheckbox, WC012UVisualizzaFileFM,
  OracleData, Graphics, meIWGrid,
  C180FunzioniGenerali, R010UPaginaWeb, A000UInterfaccia, R500Lin,
  A000USessione, Variants, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  Forms, IWVCLBaseContainer, IWContainer, meIWCheckBox, meIWButton,
  meIWEdit, meIWLabel, IWVCLComponent, StrUtils,
  medpIWMessageDlg, IWCompGrids, meIWLink, W003UAnomalieDM;

type
  TW003FAnomalie = class(TR010FPaginaWeb)
    chkLivello1: TmeIWCheckBox;
    chkLivello2: TmeIWCheckBox;
    chkLivello3: TmeIWCheckBox;
    btnEsegui: TmeIWButton;
    lblPeriodoDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    grdAnomalie: TmeIWGrid;
    lblPeriodo: TmeIWLabel;
    lblAnomalie: TmeIWLabel;
    btnEsporta: TmeIWButton;
    procedure btnEseguiClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdAnomalieRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    procedure grdAnomalieCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure btnEsportaClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    Lista:TStringList;
    C004: TC004FParamForm;
    CartellinoAbilitato:Boolean;
    chkLivAnomalieVisible:Boolean;
    W003AnomalieDM:TW003FAnomalieDM;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure VisualizzaAnomalie(VAnom:TVettAnomalie);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    procedure NotificaAutomaticaAnomalie(W003DM:TW003FAnomalieDM);
  end;

implementation

uses W005UCartellino;

{$R *.dfm}

procedure TW003FAnomalie.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  W003AnomalieDM:=TW003FAnomalieDM.Create(nil);
  btnEsporta.Enabled:=False;
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  grdAnomalie.Visible:=False;
  CartellinoAbilitato:=A000GetInibizioni('Funzione','OpenW005Cartellino') <> 'N';
  Lista:=TStringList.Create;
  // gestione parametri operatore
  C004:=CreaC004(SessioneOracle,'W003',Parametri.Operatore,False);
  GetParametriFunzione;
  chkLivAnomalieVisible:=True;
end;

procedure TW003FAnomalie.IWAppFormRender(Sender: TObject);
var S:String;
begin
  inherited;
  //rendo invisibile il groupbox dei livelli delle anomalie
  if not chkLivAnomalieVisible then
  begin
    S:='FindElem("chk_livanomalie").className = "invisibile";';
    AddToInitProc(S);
  end;
end;

procedure TW003FAnomalie.GetParametriFunzione;
var
  SelLiv2, AbilLiv2, SelLiv3, AbilLiv3: Boolean;
  i: Integer;
begin
  // anomalie livello 1
  chkLivello1.Checked:=C004.GetParametro('chkLivello1','S') = 'S';

  // anomalie livello 2
  SelLiv2:=C004.GetParametro('chkLivello2','N') = 'S';
  if SelLiv2 then
  begin
    AbilLiv2:=False;
    for i:=1 to High(tdescanom2) do
    begin
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + IntToStr(i)) then
      begin
        AbilLiv2:=True;
        Break;
      end;
    end;
    SelLiv2:=SelLiv2 and AbilLiv2;
  end;
  chkLivello2.Checked:=SelLiv2;

  // anomalie livello 3
  SelLiv3:=C004.GetParametro('chkLivello3','N') = 'S';
  if SelLiv3 then
  begin
    AbilLiv3:=False;
    for i:=1 to High(tdescanom3) do
    begin
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(i)) then
      begin
        AbilLiv3:=True;
        Break;
      end;
    end;
    SelLiv3:=SelLiv3 and AbilLiv3;
  end;
  chkLivello3.Checked:=SelLiv3;
end;

procedure TW003FAnomalie.PutParametriFunzione;
begin
  C004.Cancella001;
  C004.PutParametro('chkLivello1',IfThen(chkLivello1.Checked,'S','N'));
  C004.PutParametro('chkLivello2',IfThen(chkLivello2.Checked,'S','N'));
  C004.PutParametro('chkLivello3',IfThen(chkLivello3.Checked,'S','N'));
  SessioneOracle.Commit;
end;

procedure TW003FAnomalie.RefreshPage;
begin
  (*
  if btnEsporta.Enabled then
    btnEseguiClick(nil);
  *)
end;

procedure TW003FAnomalie.NotificaAutomaticaAnomalie(W003DM:TW003FAnomalieDM);
begin
  edtDal.Text:=DateToStr(W003DM.DataDal);
  edtAl.Text:=DateToStr(W003DM.DataAl);
  edtDal.Enabled:=False;
  edtAl.Enabled:=False;
  chkLivello1.Checked:=True;
  chkLivello2.Checked:=True;
  chkLivello3.Checked:=True;
  chkLivello1.Editable:=False;
  chkLivello2.Editable:=False;
  chkLivello3.Editable:=False;
  chkLivAnomalieVisible:=False;
  btnEsegui.Visible:=False;
  VisualizzaAnomalie(W003DM.VettAnomalie);
end;

procedure TW003FAnomalie.VisualizzaAnomalie(VAnom:TVettAnomalie);
var
  i:integer;
begin
  // tabella anomalie
  grdAnomalie.RowCount:=Length(VAnom) + 1;
  grdAnomalie.ColumnCount:=5;
  grdAnomalie.Cell[0,0].Text:='Matricola';
  grdAnomalie.Cell[0,1].Text:='Nome';
  grdAnomalie.Cell[0,2].Text:='Data';
  grdAnomalie.Cell[0,3].Text:='Liv.';
  grdAnomalie.Cell[0,4].Text:='Anomalia';
  for i:=0 to High(VAnom) do
  begin
    grdAnomalie.Cell[i + 1,0].Text:=VAnom[i].Matricola;
    grdAnomalie.Cell[i + 1,1].Text:=VAnom[i].Nome;
    grdAnomalie.Cell[i + 1,2].Text:=VAnom[i].Data;
    grdAnomalie.Cell[i + 1,3].Text:=VAnom[i].Livello;
    grdAnomalie.Cell[i + 1,4].Text:=VAnom[i].Anomalia;
    grdAnomalie.Cell[i + 1,4].Clickable:=CartellinoAbilitato;
  end;
  grdAnomalie.Visible:=True;
  btnEsporta.Enabled:=True;
end;

procedure TW003FAnomalie.btnEseguiClick(Sender: TObject);
var
  i:integer;
  Dal,Al:TDateTime;
begin
  Dal:=StrToDate(edtDal.Text);
  Al:=StrToDate(edtAl.Text);
  W003AnomalieDM.SetLivelloAnomalie(chkLivello1.Checked,chkLivello2.Checked,chkLivello3.Checked);
  W003AnomalieDM.InizializzaConteggi(Dal, Al);
  W003AnomalieDM.Anomalie;
  // dopo l'esecuzione salva i parametri per l'operatore
  PutParametriFunzione;
  VisualizzaAnomalie(W003AnomalieDM.VettAnomalie);
end;

procedure TW003FAnomalie.grdAnomalieRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  ACell.Css:='';
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (grdAnomalie.Cell[ARow,3].Text = '1') then
    ACell.Css:=ACell.Css + ' segnalazione';
end;

procedure TW003FAnomalie.btnEsportaClick(Sender: TObject);
var
  NomeFile,Err: String;
begin
  NomeFile:=GeneraFile(fdUser,'xls',grdAnomalie.ToCsv,Err);
  VisualizzaFile(NomeFile,'Elenco anomalie',nil,nil);
  if Err <> '' then
    MsgBox.MessageBox(Err,ESCLAMA,'Esportazione');
end;

procedure TW003FAnomalie.grdAnomalieCellClick(ASender: TObject; const ARow, AColumn: Integer);
var
  M:String;
  D:TDateTime;
  W005: TW005FCartellino;
begin
  try
    M:=grdAnomalie.Cell[ARow,0].Text;
    D:=StrToDate(grdAnomalie.Cell[ARow,2].Text);
  except
    Exit;
  end;
  W005:=TW005FCartellino.Create(GGetWebApplicationThreadVar);
  W005.SetParam('CHIAMANTE','W003');
  W005.SetParam('PROGRESSIVO',W003AnomalieDM.selAnagrafe.Lookup('MATRICOLA',M,'PROGRESSIVO'));
  W005.SetParam('DAL',D - 1);
  W005.SetParam('AL',D + 1);
  W005.SetParam('SINGOLO',True);
  W005.OpenPage;
end;

procedure TW003FAnomalie.DistruggiOggetti;
begin
  if Lista <> nil then
    FreeAndNil(Lista);
  FreeAndNil(C004);
  FreeAndNil(W003AnomalieDM);
end;

end.

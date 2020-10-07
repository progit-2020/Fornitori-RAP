unit A008UAccessi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, System.UITypes,
  ExtCtrls, Grids, DBGrids, OracleData, A000UCostanti, A000USessione,
  A000UInterfaccia, A008UOperatoriDtM1, A008UAzOper, R001UGESTTAB,A000UMessaggi,
  System.Actions;

type
  TA008FAccessi = class(TR001FGestTab)
    dgrdUtenti: TDBGrid;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    dgrdSessioni: TDBGrid;
    actBloccaAccessi: TAction;
    pmnBloccaAccessi: TPopupMenu;
    BloccaTuttiAccessi: TMenuItem;
    actSbloccaAccessi: TAction;
    Sbloccaaccessi1: TMenuItem;
    pmnKill: TPopupMenu;
    actKillSingola: TAction;
    actKillMultipla: TAction;
    Abbattisessioneselezionata1: TMenuItem;
    Abbattituttesessioni1: TMenuItem;
    Azioni1: TMenuItem;
    Bloccaaccessi1: TMenuItem;
    Sbloccaaccessi2: TMenuItem;
    KillSingola1: TMenuItem;
    KillMultipla1: TMenuItem;
    N4: TMenuItem;
    Refresh2: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolBar1: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    Refresh3: TMenuItem;
    procedure actBloccaAccessiExecute(Sender: TObject);
    procedure actSbloccaAccessiExecute(Sender: TObject);
    procedure actKillSingolaExecute(Sender: TObject);
    procedure actKillMultiplaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FAccessi: TA008FAccessi;

implementation

{$R *.dfm}

procedure TA008FAccessi.actBloccaAccessiExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A187_DLG_BLOCCO,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
  with A008FOperatoriDtM1.selI070Accessi do
  begin
    First;
    DisableControls;
    while not Eof do
      begin
        Edit;
        FieldByName('ACCESSO_NEGATO').AsString:='S';
        Post;
        Next;
      end;
    First;
    EnableControls;
  end;
end;

procedure TA008FAccessi.actSbloccaAccessiExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A187_DLG_SBLOCCO,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
  with A008FOperatoriDtM1.selI070Accessi do
  begin
    First;
    DisableControls;
    while not Eof do
      begin
        Edit;
        FieldByName('ACCESSO_NEGATO').AsString:='N';
        Post;
        Next;
      end;
    First;
    EnableControls;
  end;
end;

procedure TA008FAccessi.actKillSingolaExecute(Sender: TObject);
var oper: Integer;
begin
  inherited;
  if MessageDlg(A000MSG_A187_DLG_TERMINA_SESS,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
  with A008FOperatoriDtM1.OperSQL do
  begin
    //try
      SQL.Clear;
      SQL.Add(Format('ALTER SYSTEM KILL SESSION ''%d,%d''',[A008FOperatoriDtM1.selVSESSION.FieldByName('SID').AsInteger,A008FOperatoriDtM1.selVSESSION.FieldByName('SERIAL#').AsInteger]));
      try Execute; except end;
      SessioneOracle.Commit;
      oper:=A008FOperatoriDtM1.dsrVSESSION.DataSet.FieldByName('SID').AsInteger;
      A008FOperatoriDtM1.dsrVSESSION.DataSet.Refresh;
      A008FOperatoriDtM1.selVSESSION.SearchRecord('SID',oper,[srFromBeginning]);
    //except
    //end;
  end;
end;

procedure TA008FAccessi.actKillMultiplaExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A187_DLG_TERMINA_ALL_SESS,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
  with A008FOperatoriDtM1 do
  begin
    selVSESSION.First;
    selVSESSION.DisableControls;
    while not selVSESSION.Eof do
      begin
        OperSQL.SQL.Clear;
        OperSQL.SQL.Add(Format('ALTER SYSTEM KILL SESSION ''%d,%d''',[selVSESSION.FieldByName('SID').AsInteger,selVSESSION.FieldByName('SERIAL#').AsInteger]));
        try OperSQL.Execute; except end;
        selVSESSION.Next;
      end;
    A008FOperatoriDtM1.dsrVSESSION.DataSet.Refresh;
    selVSESSION.First;
    selVSESSION.EnableControls;
  end;
end;

procedure TA008FAccessi.FormCreate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A008FOperatoriDtM1.selI070Accessi;
  A008FOperatoriDtM1.selI070Accessi.Open;
  try
    A008FOperatoriDtM1.selVSESSION.Open;
  except
    on E:Exception do
      ShowMessage(Format(A000MSG_A187_ERR_FMT_V_SESSION,[E.Message]));
  end;
  actBloccaAccessi.Enabled:=Not SolaLettura;
  actSbloccaAccessi.Enabled:=Not SolaLettura;
  actKillSingola.Enabled:=Not SolaLettura;
  actKillMultipla.Enabled:=Not SolaLettura;
end;

procedure TA008FAccessi.FormDestroy(Sender: TObject);
begin
  inherited;
  A008FOperatoriDtM1.selI070Accessi.Close;
  A008FOperatoriDtM1.selVSESSION.Close;
end;

procedure TA008FAccessi.actRefreshExecute(Sender: TObject);
begin
  inherited;
  A008FOperatoriDtM1.dsrVSESSION.DataSet.Refresh;
end;

end.



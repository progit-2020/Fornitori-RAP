unit A099UUtilityDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  StdCtrls, Buttons, ExtCtrls, CheckLst, Menus,
  A000UCostanti, A000USessione, A000UInterfaccia, A099UUtilityDBMW,
  ComCtrls, Variants, Grids, DBGrids, DB, Oracle, Clipbrd,
  A000UMessaggi;

type
  TA099FUtilityDB = class(TForm)
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    PageControl1: TPageControl;
    tabTabelle: TTabSheet;
    Panel1: TPanel;
    btnDeleteStatistics: TBitBtn;
    btnAnalyzeTable: TBitBtn;
    btnAnalyzeColumns: TBitBtn;
    btnAnalyzeIndexes: TBitBtn;
    btnRebuildIndexes: TBitBtn;
    btnTableNoParallel: TBitBtn;
    btnIndexNoParallel: TBitBtn;
    Panel2: TPanel;
    lstTabelle: TCheckListBox;
    rgpSelezioneTabelle: TRadioGroup;
    Splitter1: TSplitter;
    tabOggetti: TTabSheet;
    Panel3: TPanel;
    memoResult: TMemo;
    Panel4: TPanel;
    BitBtn7: TBitBtn;
    Panel5: TPanel;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    treeOggettiDB: TTreeView;
    Panel6: TPanel;
    btnRicompilaTutto: TBitBtn;
    mnuCompilaOggetti: TPopupMenu;
    Ricompila1: TMenuItem;
    btnRicompilaInvalidi: TBitBtn;
    N1: TMenuItem;
    Refresh1: TMenuItem;
    btnDeleteSchemaStats: TBitBtn;
    btnGatherSchemaStats: TBitBtn;
    btnGatherTableStats: TBitBtn;
    btnMoveTablespace: TBitBtn;
    tabQuerySupporto: TTabSheet;
    Panel7: TPanel;
    btnEsegui: TBitBtn;
    Panel8: TPanel;
    rgpQuerySupporto: TRadioGroup;
    dgrdQuerySupporto: TDBGrid;
    dsrQuerySupporto: TDataSource;
    GroupBox1: TGroupBox;
    chkCompileDebug: TCheckBox;
    chkCompileNative: TCheckBox;
    chkCompileInterpreted: TCheckBox;
    chkCompileReuse: TCheckBox;
    btnCopiaTestoQuery: TBitBtn;
    btnShrink: TBitBtn;
    btnV430Storico: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure rgpSelezioneTabelleClick(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure btnDeleteStatisticsClick(Sender: TObject);
    procedure btnRicompilaTuttoClick(Sender: TObject);
    procedure Ricompila1Click(Sender: TObject);
    procedure treeOggettiDBChange(Sender: TObject; Node: TTreeNode);
    procedure Refresh1Click(Sender: TObject);
    procedure treeOggettiDBAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure treeOggettiDBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDeleteSchemaStatsClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkCompileParametersClick(Sender: TObject);
    procedure btnCopiaTestoQueryClick(Sender: TObject);
    procedure btnV430StoricoClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaOggettiDB;
    procedure RicompilaOggetto(Tipo,Oggetto:String);
    function DisegnaNodo(Albero:TTreeView; RectRif: TRect; xFontColor:TColor; xFontStyle:TFontStyles; sTesto:string): TRect;
  public
    { Public declarations }
    A099FUtilityDBMW: TA099FUtilityDBMW;
  end;

var
  A099FUtilityDB: TA099FUtilityDB;

procedure OpenA099UtilityDB;

implementation

uses A099UUtilityDBDtM1;

{$R *.DFM}

procedure OpenA099UtilityDB;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA099UtilityDB') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A099FUtilityDB:=TA099FUtilityDB.Create(nil);
  with A099FUtilityDB do
    try
      A099FUtilityDBDtM1:=TA099FUtilityDBDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A099FUtilityDBDtM1.Free;
      Free;
    end;
end;

procedure TA099FUtilityDB.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex:=0;
  rgpSelezioneTabelle.Items[0]:='Tabelle di ' + Parametri.Username;
  rgpSelezioneTabelle.Items[3]:='Tabelle esterne al tablespace ' + Parametri.TSLavoro;
  rgpSelezioneTabelle.Items[4]:='Tabelle con indici esterni al tablespace ' + Parametri.TSIndici;
  rgpSelezioneTabelleClick(rgpSelezioneTabelle);
  CaricaOggettiDB;
end;

procedure TA099FUtilityDB.rgpSelezioneTabelleClick(Sender: TObject);
begin
  lstTabelle.Items.Clear;
  Screen.Cursor:=crHourGlass;
  with A099FUtilityDBMW.selTabs do
  begin
    Close;
    SQL.Clear;
    case rgpSelezioneTabelle.ItemIndex of
      0:SQL.Add('SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME');
      1:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM IND ORDER BY TABLE_NAME');
      2:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = ''P'' ORDER BY TABLE_NAME');
      3:SQL.Add('SELECT TABLE_NAME FROM TABS WHERE TABLESPACE_NAME <> ''' + Parametri.TSLavoro + ''' ORDER BY TABLE_NAME');
      4:SQL.Add('SELECT DISTINCT TABLE_NAME FROM IND WHERE TABLESPACE_NAME <> ''' + Parametri.TSIndici + ''' ORDER BY TABLE_NAME');
    end;
    Open;
    while not Eof do
    begin
      lstTabelle.Items.Add(FieldByName('TABLE_NAME').AsString);
      Next;
    end;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA099FUtilityDB.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstTabelle.Items.Count - 1 do
    lstTabelle.Checked[i]:=Sender = Selezionatutto1
end;

procedure TA099FUtilityDB.btnCopiaTestoQueryClick(Sender: TObject);
begin
  Clipboard.Clear;
  case rgpQuerySupporto.ItemIndex of
    0:Clipboard.AsText:=A099FUtilityDBMW.selTablespace.SQL.Text;
    1:Clipboard.AsText:=A099FUtilityDBMW.selSortSegment.SQL.Text;
    2:Clipboard.AsText:=A099FUtilityDBMW.selLogMsg.SQL.Text;
  end;
end;

procedure TA099FUtilityDB.btnDeleteSchemaStatsClick(Sender: TObject);
var S:String;
begin
  if Sender = btnGatherSchemaStats then
    S:=Format(A000MSG_A099_DLG_FMT_DB,['GATHER_SCHEMA_STATS',Parametri.Username])
  else
    S:= Format(A000MSG_A099_DLG_FMT_DB,['DELETE_SCHEMA_STATS',Parametri.Username]);
  if MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  Screen.Cursor:=crHourGlass;
  try
    if Sender = btnGatherSchemaStats then
    begin
       memoResult.Lines.AddStrings(A099FUtilityDBMW.GatherSchemaStats);
    end
    else
    begin
       memoResult.Lines.AddStrings(A099FUtilityDBMW.DeleteSchemaStats);
    end
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA099FUtilityDB.btnDeleteStatisticsClick(Sender: TObject);
var S:String;
    i,N:Integer;
begin
  if Sender = btnGatherTableStats then
    S:=Format(A000MSG_A099_DLG_FMT_ESEGUI,['GATHER_TABLE_STATS'])
  else
    S:=Format(A000MSG_A099_DLG_FMT_ESEGUI,[TBitBtn(Sender).Caption]);
  if MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  if (Sender = btnAnalyzeTable) or (Sender = btnAnalyzeColumns) or (Sender = btnAnalyzeIndexes) then
    if MessageDlg(A000MSG_A099_DLG_SCONSIGLIATA ,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  N:=0;
  for i:=0 to lstTabelle.Items.Count - 1 do
    if lstTabelle.Checked[i] then inc(N);
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=N;
  for i:=0 to lstTabelle.Items.Count - 1 do
    if lstTabelle.Checked[i] then
    begin
      ProgressBar1.StepBy(1);
      StatusBar.SimpleText:=lstTabelle.Items[i];
      StatusBar.Repaint;
      if Sender = btnShrink then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.ShrinkTable(lstTabelle.Items[i]));
      end
      else if Sender = btnDeleteStatistics then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.DeleteStatistics(lstTabelle.Items[i]));
      end
      else if Sender = btnTableNoParallel then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.TableNoParallel(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeTable then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeTable(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeColumns then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeColumns(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeIndexes then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeIndexes(lstTabelle.Items[i]));
      end
      else if Sender = btnMoveTablespace then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.MoveTablespace(lstTabelle.Items[i]));
      end
      else if (Sender = btnRebuildIndexes) then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.RebuildIndexes(lstTabelle.Items[i]));
      end
      else if (Sender = btnIndexNoParallel) then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.IndexNoParallel(lstTabelle.Items[i]));
      end
      else if Sender = btnGatherTableStats then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.GatherTableStats(lstTabelle.Items[i]));
      end;
      memoResult.Repaint;
    end;
  Screen.Cursor:=crDefault;
  if (Sender = btnMovetablespace) and (ProgressBar1.Position > 0) then
    ShowMessage(A000MSG_A099_MSG_INDICI);
  ProgressBar1.Position:=0;
  StatusBar.SimpleText:='';
end;

procedure TA099FUtilityDB.btnEseguiClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    case rgpQuerySupporto.ItemIndex of
      0:begin
          A099FUtilityDBMW.selTablespace.Close;
          A099FUtilityDBMW.selTablespace.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selTablespace;
        end;
      1:begin
          A099FUtilityDBMW.selSortSegment.Close;
          A099FUtilityDBMW.selSortSegment.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selSortSegment;
        end;
      2:begin
          A099FUtilityDBMW.selLogMsg.Close;
          A099FUtilityDBMW.selLogMsg.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selLogMsg;
        end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA099FUtilityDB.CaricaOggettiDB;
  procedure AggiungiNodo(Tipo,Oggetto:String);
  var i:Integer;
      Trovato:Boolean;
      Nodo:TTreeNode;
  begin
    i:=0;
    Trovato:=False;
    while i < treeOggettiDB.Items.Count do
    begin
      if UpperCase(Tipo) = UpperCase(treeOggettiDB.Items[i].Text) then
      begin
        Nodo:=treeOggettiDB.Items.AddChild(treeOggettiDB.Items[i],Oggetto);
        Nodo.ImageIndex:=2;
        if Pos('(INVALID)',Oggetto) > 0 then
          Nodo.ImageIndex:=1;
        Trovato:=True;
        Break;
      end;
      inc(i);
    end;
    if not Trovato then
    begin
      Nodo:=treeOggettiDB.Items.Add(nil,Tipo);
      Nodo:=treeOggettiDB.Items.AddChild(Nodo,Oggetto);
      Nodo.ImageIndex:=2;
      if Pos('(INVALID)',Oggetto) > 0 then
        Nodo.ImageIndex:=1;
    end;
  end;
begin
  treeOggettiDB.Items.Clear;
  with A099FUtilityDBMW.selUserObjects do
  begin
    Open;
    while not Eof do
    begin
      AggiungiNodo(FieldByName('OBJECT_TYPE').AsString,FieldByName('OBJECT_NAME').AsString + ' ('+ FieldByName('STATUS').AsString + ')');
      Next;
    end;
    Close;
  end;
end;

procedure TA099FUtilityDB.chkCompileParametersClick(Sender: TObject);
begin
  if (Sender = chkCompileInterpreted) and chkCompileInterpreted.Checked then
    chkCompileNative.Checked:=False;
  if (Sender = chkCompileNative) and chkCompileNative.Checked then
    chkCompileInterpreted.Checked:=False;
  if (Sender = chkCompileReuse) and chkCompileReuse.Checked then
  begin
    chkCompileDebug.Checked:=False;
    chkCompileInterpreted.Checked:=False;
    chkCompileNative.Checked:=False;
  end;
  if (Sender <> chkCompileReuse) and (chkCompileDebug.Checked or chkCompileInterpreted.Checked or chkCompileNative.Checked) then
    chkCompileReuse.Checked:=False;
end;

procedure TA099FUtilityDB.RicompilaOggetto(Tipo,Oggetto:String);
begin
  Oggetto:=Copy(Oggetto,1,Pos('(',Oggetto) - 1);
  StatusBar.SimpleText:=Tipo + ': ' + Oggetto;
  StatusBar.Repaint;
  memoResult.Lines.AddStrings(A099FUtilityDBMW.RicompilaOggetto(Tipo,Oggetto,chkCompileDebug.Checked,chkCompileNative.Checked,chkCompileInterpreted.Checked,chkCompileReuse.Checked));
end;

procedure TA099FUtilityDB.btnRicompilaTuttoClick(Sender: TObject);
var i,j:Integer;
    s:String;
    Nodo:TTreeNode;
begin
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  for i:=0 to treeOggettiDB.Items.Count - 1 do
  begin
    s:=treeOggettiDB.Items[i].Text;
    if s = 'SYNONYM' then
      Continue;
    Nodo:=treeOggettiDB.Items[i];
    for j:=0 to Nodo.Count - 1 do
      if (Sender = btnRicompilaTutto) or (Pos('(INVALID)',Nodo.Item[j].Text) > 0) then
      begin
        RicompilaOggetto(s,Nodo.Item[j].Text);
      end;
  end;
  Screen.Cursor:=crDefault;
  StatusBar.SimpleText:='';
end;

procedure TA099FUtilityDB.btnV430StoricoClick(Sender: TObject);
begin
  A099FUtilityDBMW.CostruisciV430;
end;

procedure TA099FUtilityDB.Ricompila1Click(Sender: TObject);
var Nodo:TTreeNode;
    i:Integer;
begin
  Nodo:=treeOggettiDB.Selected;
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  if Nodo.Parent = nil then
  begin
    for i:=0 to Nodo.Count - 1 do
      RicompilaOggetto(Nodo.Text,Nodo.Item[i].Text);
  end
  else
    RicompilaOggetto(Nodo.Parent.Text,Nodo.Text);
  Screen.Cursor:=crDefault;
  StatusBar.SimpleText:='';
  CaricaOggettiDB;
end;

procedure TA099FUtilityDB.treeOggettiDBChange(Sender: TObject;
  Node: TTreeNode);
var Nodo:TTreeNode;
begin
  Nodo:=treeOggettiDB.Selected;
  Ricompila1.Enabled:=True;
  if Nodo = nil then
    exit
  else if (Nodo.Parent = nil) and (Nodo.Text = 'SYNONYM') then
    Ricompila1.Enabled:=False
  else if (Nodo.Parent <> nil) and (Nodo.Parent.Text = 'SYNONYM') then
    Ricompila1.Enabled:=False;
end;

procedure TA099FUtilityDB.Refresh1Click(Sender: TObject);
begin
  CaricaOggettiDB;
end;

procedure TA099FUtilityDB.treeOggettiDBAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var C:TColor;
begin
  if cdsSelected in State then
  begin
    treeOggettiDB.Canvas.Brush.Color:=clHighLight;
    C:=clHighLightText;
  end
  else
  begin
    treeOggettiDB.Canvas.Brush.Color:=clWindow;
    C:=clWindowText;
  end;
  if Node.ImageIndex = 1 then
    C:=clRed;
  DisegnaNodo(treeOggettiDB, Node.DisplayRect(True), C, [], Node.Text);
end;

function TA099FUtilityDB.DisegnaNodo(Albero:TTreeView; RectRif: TRect; xFontColor:TColor; xFontStyle:TFontStyles; sTesto:string): TRect;
var xNewRect:TRect;
begin
  xNewRect.Left:=RectRif.Left;
  xNewRect.Right:=RectRif.Right;
  xNewRect.Top:=RectRif.Top;
  xNewRect.Bottom:=RectRif.Bottom;
  Albero.Canvas.Font.Color:=xFontColor;
  //Albero.Canvas.Font.Style:=xFontStyle;
  Albero.Canvas.TextRect(xNewRect,xNewRect.left + 1,xNewRect.top + 1,sTesto);
  Albero.Canvas.Refresh;
  Result:=xNewRect;
end;

procedure TA099FUtilityDB.treeOggettiDBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Nodo:TTreeNode;
begin
  Nodo:=treeOggettiDB.GetNodeAt(X,Y);
  if Nodo <> nil then
    treeOggettiDB.Selected:=Nodo;
end;

end.

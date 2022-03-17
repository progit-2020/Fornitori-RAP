unit C012UVisualizzaTesto;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd,
  ToolWin, ActnList, ImgList, RichEdit, ShellAPI, System.Actions;

type
  TC012FVisualizzaTesto = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    Ruler: TPanel;
    FontDialog1: TFontDialog;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    Memo1: TRichEdit;
    StatusBar: TStatusBar;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    FontSize: TEdit;
    ToolButton11: TToolButton;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    ToolbarImages: TImageList;
    ActionList1: TActionList;
    FileNewCmd: TAction;
    FileOpenCmd: TAction;
    FileSaveCmd: TAction;
    FilePrintCmd: TAction;
    FileExitCmd: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Bevel1: TBevel;
    EditCutCmd: TAction;
    EditCopyCmd: TAction;
    EditPasteCmd: TAction;
    EditUndoCmd: TAction;
    EditFontCmd: TAction;
    FileSaveAsCmd: TAction;
    Acapoautomatico1: TMenuItem;
    Panel1: TPanel;
    btnOK: TBitBtn;
    btnAnnulla: TBitBtn;
    procedure Acapoautomatico1Click(Sender: TObject);

    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure SwitchLanguage(Sender: TObject);
    procedure ActionList2Update(Action: TBasicAction;
      var Handled: Boolean);
  private
    NomeFile:String;
    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    function CurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetFileName(const FileName: String);
    //procedure CheckFileSave;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure UpdateCursorPos;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);
  public
    IntestazioneStampaInterna:String;
  end;

var
  C012FVisualizzaTesto: TC012FVisualizzaTesto;

procedure ReinitializeForms;
function LoadNewResourceModule(Locale: LCID): Longint;

//procedure OpenC012VisualizzaTesto(Titolo,NomeFile:String; StringList:TStringList; Intestazione:String='');
procedure OpenC012VisualizzaTesto(Titolo,NomeFile:String; StringList:TStringList; Intestazione:String=''; Bottoni:TMsgDlgButtons = []);

implementation

resourcestring
  sSaveChanges = 'Salvare le modifiche a %s?';
  sOverWrite = 'Sovrascrivere il file %s?';
  sUntitled = 'Sconosciuto';
  sModified = 'Modificato';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  RulerAdj = 4/3;
  GutterWid = 6;

type
  TAsInheritedReader = class(TReader)
  public
    procedure ReadPrefix(var Flags: TFilerFlags; var AChildPos: Integer); override;
  end;

{$R *.dfm}

procedure OpenC012VisualizzaTesto(Titolo,NomeFile:String; StringList:TStringList; Intestazione:String=''; Bottoni:TMsgDlgButtons = []);
begin
  C012FVisualizzaTesto:=TC012FVisualizzaTesto.Create(nil);
  try
    C012FVisualizzaTesto.NomeFile:=NomeFile;
    C012FVisualizzaTesto.Caption:=Titolo;
    C012FVisualizzaTesto.IntestazioneStampaInterna:=Intestazione;
    if StringList <> nil then
    begin
      C012FVisualizzaTesto.Memo1.Lines.Assign(StringList);
      C012FVisualizzaTesto.Memo1.SelStart:=0;
      C012FVisualizzaTesto.NomeFile:='';
    end;
    C012FVisualizzaTesto.btnOK.Enabled:=mbOK in Bottoni;
    C012FVisualizzaTesto.Memo1.ReadOnly:=not (mbOK in Bottoni);
    C012FVisualizzaTesto.btnAnnulla.Enabled:=mbCancel in Bottoni;
    C012FVisualizzaTesto.Panel1.Visible:=C012FVisualizzaTesto.btnOK.Enabled or C012FVisualizzaTesto.btnAnnulla.Enabled;
    C012FVisualizzaTesto.ShowModal;
    if StringList <> nil then
    begin
      if C012FVisualizzaTesto.Panel1.Visible then
      begin
        if C012FVisualizzaTesto.ModalResult = mrOK then
          StringList.Assign(C012FVisualizzaTesto.Memo1.Lines);
      end
      else
        StringList.Assign(C012FVisualizzaTesto.Memo1.Lines);
    end;
  finally
    FreeAndNil(C012FVisualizzaTesto);
  end;
end;

procedure TAsInheritedReader.ReadPrefix(var Flags: TFilerFlags; var AChildPos: Integer);
begin
  inherited ReadPrefix(Flags, AChildPos);
  Include(Flags, ffInherited);
end;

function SetResourceHInstance(NewInstance: Longint): Longint;
var
  CurModule: PLibModule;
begin
  CurModule := LibModuleList;
  Result := 0;
  while CurModule <> nil do
  begin
    if CurModule.Instance = HInstance then
    begin
      if CurModule.ResInstance <> CurModule.Instance then
        FreeLibrary(CurModule.ResInstance);
      CurModule.ResInstance := NewInstance;
      Result := NewInstance;
      Exit;
    end;
    CurModule := CurModule.Next;
  end;
end;

function LoadNewResourceModule(Locale: LCID): Longint;
var
  FileName: array [0..260] of char;
  P: PChar;
  LocaleName: array[0..4] of Char;
  NewInst: Longint;
begin
  GetModuleFileName(HInstance, FileName, SizeOf(FileName));
  GetLocaleInfo(Locale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
  P := PChar(@FileName) + lstrlen(FileName);
  while (P^ <> '.') and (P <> @FileName) do Dec(P);
  NewInst := 0;
  Result := 0;
  if P <> @FileName then
  begin
    Inc(P);
    if LocaleName[0] <> #0 then
    begin
      // Then look for a potential language/country translation
      lstrcpy(P, LocaleName);
      NewInst := LoadLibraryEx(FileName, 0, LOAD_LIBRARY_AS_DATAFILE);
      if NewInst = 0 then
      begin
        // Finally look for a language only translation
        LocaleName[2] := #0;
        lstrcpy(P, LocaleName);
        NewInst := LoadLibraryEx(FileName, 0, LOAD_LIBRARY_AS_DATAFILE);
      end;
    end;
  end;
  if NewInst <> 0 then
    Result := SetResourceHInstance(NewInst)
end;

function InternalReloadComponentRes(const ResName: string; HInst: THandle; var Instance: TComponent): Boolean;
var
  HRsrc: THandle;
  ResStream: TResourceStream;
  AsInheritedReader: TAsInheritedReader;
begin                   { avoid possible EResNotFound exception }
  if HInst = 0 then HInst := HInstance;
  HRsrc := FindResource(HInst, PChar(ResName), RT_RCDATA);
  Result := HRsrc <> 0;
  if not Result then Exit;
  ResStream := TResourceStream.Create(HInst, ResName, RT_RCDATA);
  try
    AsInheritedReader := TAsInheritedReader.Create(ResStream, 4096);
    try
      Instance := AsInheritedReader.ReadRootComponent(Instance);
    finally
      AsInheritedReader.Free;
    end;
  finally
    ResStream.Free;
  end;
  Result := True;
end;

function ReloadInheritedComponent(Instance: TComponent; RootAncestor: TClass): Boolean;

  function InitComponent(ClassType: TClass): Boolean;
  begin
    Result := False;
    if (ClassType = TComponent) or (ClassType = RootAncestor) then Exit;
    Result := InitComponent(ClassType.ClassParent);
    Result := InternalReloadComponentRes(ClassType.ClassName, FindResourceHInstance(
      FindClassHInstance(ClassType)), Instance) or Result;
  end;

begin
  Result := InitComponent(Instance.ClassType);
end;

procedure ReinitializeForms;
var
  Count: Integer;
  I: Integer;
  Form: TForm;
begin
  Count := Screen.FormCount;
  for I := 0 to Count - 1 do
  begin
    Form := Screen.Forms[I];
    ReloadInheritedComponent(Form, TForm);
  end;
end;

procedure TC012FVisualizzaTesto.SelectionChange(Sender: TObject);
begin
  with Memo1.Paragraph do
  try
    FUpdating := True;
    FirstInd.Left := Trunc(FirstIndent*RulerAdj)-4+GutterWid;
    LeftInd.Left := Trunc((LeftIndent+FirstIndent)*RulerAdj)-4+GutterWid;
    RightInd.Left := Ruler.ClientWidth-6-Trunc((RightIndent+GutterWid)*RulerAdj);
    BoldButton.Down := fsBold in Memo1.SelAttributes.Style;
    ItalicButton.Down := fsItalic in Memo1.SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in Memo1.SelAttributes.Style;
    BulletsButton.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(Memo1.SelAttributes.Size);
    FontName.Text := Memo1.SelAttributes.Name;
    case Ord(Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

function TC012FVisualizzaTesto.CurrText: TTextAttributes;
begin
  if Memo1.SelLength > 0 then Result := Memo1.SelAttributes
  else Result := Memo1.DefAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TC012FVisualizzaTesto.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TC012FVisualizzaTesto.SetFileName(const FileName: String);
begin
  FFileName := FileName;
  Caption := Format('%s - %s', [ExtractFileName(FileName), Application.Title]);
end;

(*procedure TC012FVisualizzaTesto.CheckFileSave;
var
  SaveResp: Integer;
begin
  if not Memo1.Modified then Exit;
  SaveResp := MessageDlg(Format(sSaveChanges, [FFileName]),
    mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes: FileSave(Self);
    idNo: {Nothing};
    idCancel: Abort;
  end;
end;*)

procedure TC012FVisualizzaTesto.SetupRuler;
var
  I: Integer;
  S: String;
begin
  SetLength(S, 201);
  I := 1;
  while I < 200 do
  begin
    S[I] := #9;
    S[I+1] := '|';
    Inc(I, 2);
  end;
  Ruler.Caption := S;
end;

procedure TC012FVisualizzaTesto.SetEditRect;
var
  R: TRect;
begin
  with Memo1 do
  begin
    R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;
end;

{ Event Handlers }

procedure TC012FVisualizzaTesto.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
  GetFontNames;
  SetupRuler;
  SelectionChange(Self);

  CurrText.Name := DefFontData.Name;
  CurrText.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
  ACapoAutomatico1.Checked:=False;
  Panel1.Visible:=False;
end;

procedure TC012FVisualizzaTesto.FileNew(Sender: TObject);
begin
  SetFileName(sUntitled);
  Memo1.Lines.Clear;
  Memo1.Modified := False;
  SetModified(False);
end;

procedure TC012FVisualizzaTesto.PerformFileOpen(const AFileName: string);
begin
  Memo1.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Memo1.SetFocus;
  Memo1.Modified := False;
  SetModified(False);
end;

procedure TC012FVisualizzaTesto.FileOpen(Sender: TObject);
begin
  //CheckFileSave;
  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    Memo1.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TC012FVisualizzaTesto.FileSave(Sender: TObject);
var F:TextFile;
    i:Integer;
begin
  if FFileName = sUntitled then
    FileSaveAs(Sender)
  else
  begin
    Screen.Cursor:=crHourGlass;
    if SaveDialog.FilterIndex = 1 then
    begin
      AssignFile(F,SaveDialog.FileName);
      Rewrite(F);
      for i:=0 to Memo1.Lines.Count - 1 do
        Writeln(F,Memo1.Lines[i]);
      CloseFile(F);
    end
    else
      Memo1.Lines.SaveToFile(SaveDialog.FileName);
    Screen.Cursor:=crDefault;
    Memo1.Lines.SaveToFile(FFileName);
    Memo1.Modified := False;
    SetModified(False);
  end;
end;

procedure TC012FVisualizzaTesto.FileSaveAs(Sender: TObject);
var F:TextFile;
    i:Integer;
begin
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> mrYes then Exit;
    Screen.Cursor:=crHourGlass;
    if SaveDialog.FilterIndex = 1 then
    begin
      AssignFile(F,SaveDialog.FileName);
      Rewrite(F);
      for i:=0 to Memo1.Lines.Count - 1 do
        Writeln(F,Memo1.Lines[i]);
      CloseFile(F);
    end
    else
      Memo1.Lines.SaveToFile(SaveDialog.FileName);
    Screen.Cursor:=crDefault;
    SetFileName(SaveDialog.FileName);
    Memo1.Modified := False;
    SetModified(False);
  end;
end;

procedure TC012FVisualizzaTesto.FilePrint(Sender: TObject);
begin
  if PrintDialog.Execute then
    Memo1.Print(FFileName);
end;

procedure TC012FVisualizzaTesto.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TC012FVisualizzaTesto.EditUndo(Sender: TObject);
begin
  with Memo1 do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TC012FVisualizzaTesto.EditCut(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TC012FVisualizzaTesto.EditCopy(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TC012FVisualizzaTesto.EditPaste(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TC012FVisualizzaTesto.SelectFont(Sender: TObject);
begin
  FontDialog1.Font.Assign(Memo1.SelAttributes);
  if FontDialog1.Execute then
    CurrText.Assign(FontDialog1.Font);
  SelectionChange(Self);
  Memo1.SetFocus;
end;

procedure TC012FVisualizzaTesto.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);
end;

procedure TC012FVisualizzaTesto.FormResize(Sender: TObject);
begin
  SetEditRect;
  SelectionChange(Sender);
end;

procedure TC012FVisualizzaTesto.FormPaint(Sender: TObject);
begin
  SetEditRect;
end;

procedure TC012FVisualizzaTesto.BoldButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TC012FVisualizzaTesto.ItalicButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TC012FVisualizzaTesto.FontSizeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TC012FVisualizzaTesto.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Memo1.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TC012FVisualizzaTesto.FontNameChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TC012FVisualizzaTesto.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TC012FVisualizzaTesto.BulletsButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Memo1.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

procedure TC012FVisualizzaTesto.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    //CheckFileSave;
  except
    CanClose := False;
  end;
end;

{ Ruler Indent Dragging }

procedure TC012FVisualizzaTesto.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;
end;

procedure TC012FVisualizzaTesto.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs
end;

procedure TC012FVisualizzaTesto.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Memo1.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TC012FVisualizzaTesto.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Memo1.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-Memo1.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TC012FVisualizzaTesto.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Memo1.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;
  SelectionChange(Sender);
end;

procedure TC012FVisualizzaTesto.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Memo1.Handle, EM_EXLINEFROMCHAR, 0,
    Memo1.SelStart);
  CharPos.X := (Memo1.SelStart - SendMessage(Memo1.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text:=Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TC012FVisualizzaTesto.FormShow(Sender: TObject);
begin
  if C012FVisualizzaTesto.NomeFile <> '' then
    Memo1.Lines.LoadFromFile(C012FVisualizzaTesto.NomeFile);
  if IntestazioneStampaInterna <> '' then
  begin
    Memo1.Lines.Insert(0,IntestazioneStampaInterna);
    Memo1.Lines.Insert(1,'');
  end;
  UpdateCursorPos;
  DragAcceptFiles(Handle, True);
  CurrText.Name := 'Courier New';
  CurrText.Size := 8;
  RichEditChange(nil);
  Memo1.SetFocus;
  { Check if we should load a file from the command line }
  if (ParamCount > 0) and FileExists(ParamStr(1)) then
    PerformFileOpen(ParamStr(1));
end;

procedure TC012FVisualizzaTesto.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      //CheckFileSave;
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TC012FVisualizzaTesto.RichEditChange(Sender: TObject);
begin
  SetModified(Memo1.Modified);
end;

procedure TC012FVisualizzaTesto.SetModified(Value: Boolean);
begin
  if Value then
    StatusBar.Panels[1].Text := sModified
  else
    StatusBar.Panels[1].Text := '';
end;

procedure TC012FVisualizzaTesto.SwitchLanguage(Sender: TObject);
var
  Name : String;
  Size : Integer;
begin
  if LoadNewResourceModule(TComponent(Sender).Tag) <> 0 then
  begin
    Name := FontName.Text;
    Size := StrToInt(FontSize.Text);
    ReinitializeForms;

    CurrText.Name := Name;
    CurrText.Size := Size;
    SelectionChange(Self);
    FontName.SelLength := 0;

    SetupRuler;
    if Visible then Memo1.SetFocus;
  end;
end;

procedure TC012FVisualizzaTesto.ActionList2Update(Action: TBasicAction;
  var Handled: Boolean);
begin
 { Update the status of the edit commands }
  EditCutCmd.Enabled := Memo1.SelLength > 0;
  EditCopyCmd.Enabled := EditCutCmd.Enabled;
  if Memo1.HandleAllocated then
  begin
    EditUndoCmd.Enabled := Memo1.Perform(EM_CANUNDO, 0, 0) <> 0;
    EditPasteCmd.Enabled := Memo1.Perform(EM_CANPASTE, 0, 0) <> 0;
  end;
end;

procedure TC012FVisualizzaTesto.Acapoautomatico1Click(Sender: TObject);
begin
  ACapoAutomatico1.Checked:=not ACapoAutomatico1.Checked;
  Memo1.WordWrap:=ACapoAutomatico1.Checked;
end;

end.



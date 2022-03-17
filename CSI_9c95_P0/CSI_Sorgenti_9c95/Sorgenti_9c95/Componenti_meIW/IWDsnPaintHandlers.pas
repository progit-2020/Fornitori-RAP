(* Questa unit ci è stata fornita da Atozed. Si occupa di disegnare i componenti sull'IDE a design time.
  Sono state effettuate le seguenti modifiche:
  - commentata la direttiva {$R ..\core\IWDB.res}
  - modifica dell'import della unit IWLists con IW.Common.Lists
  A partire da IW 15 se non è specificato alcun paint handler per un componente viene ereditato a design time
  quello della classe ancestor. 
*)

unit IWDsnPaintHandlers;

{PUBDIST}

interface

uses
  Windows,
  Buttons,
  Graphics,
  Classes,
  IWFont, IWDsnPaint, IWColor;

type
  TIWPaintHandlerRadioButton = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerRadioGroup = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerRectangle = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  {TIWPaintHandlerMenu = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;}

  TIWPaintHandlerLabel = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerButton = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerEdit = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerCheckBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerComboBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerListBox = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerMemo = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerLink = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerText = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerImage = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerHRule = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerList = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerDBNavigator = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerProgressBar = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerRegion = class(TIWPainthandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerTabControl = class(TIWPainthandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerTabPage = class(TIWPainthandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerGradButton = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerAudioControl = class(TIWPainthandlerDsn)
  private
    FBmp: TBitmap;
  public
    procedure Paint; override;
    destructor Destroy; override;
  end;

implementation
{$R IWDesign.res}
// {$R ..\core\IWDB.res}

uses
  Controls,
  Math, SysUtils, IW.Common.Lists,
  IW.Common.System,IWBaseControl, IWFormDsn, IWCompGridCommon,
  IWBaseHTMLForm,
  IWCompLabel, IWCompButton, IWCompEdit, IWCompText, IWCompExtCtrls,
  IWCompRectangle, IWHTMLControls, IWCompProgressBar, IWCompGrids,
  IWCompCheckbox, IWCompListbox, IWCompMemo,
  IWCompRadioButton,
  IWBaseHTMLControl,
  IWCompMenu, IWDBStdCtrls,
  IWRegion, IWContainerBorderOptions, IWCompTabControl,
  IWCompGradButton, GraphUtil, IWCompAudio, IWTypes;

function GetBitmapFromResource(const AResourceName: string): TBitmap;
var
  RStream: TResourceStream;
begin
  RStream := TResourceStream.Create(HInstance, UpperCase(AResourceName), RT_RCDATA);
  try
    Result := TBitmap.Create;
    Result.LoadFromStream(RStream);
  finally
    FreeAndNil(RStream);
  end;
end;

{ TIWPaintHandlerRadioGroup }

procedure TIWPaintHandlerRadioGroup.Paint;
var
  i: Integer;
  LHeight: Integer;
  LWidth: Integer;
  LLeft: Integer;
  LRadioGroup: TIWRadioGroup;
  LText: string;
  LTop: Integer;
begin
  LRadioGroup := Control as TIWRadioGroup;
  if LRadioGroup.Items.Count = 0 then begin
    DrawOutline;
  end else begin
    SetTransparent;
    with ControlCanvas do begin
      SetCanvasFont(LRadioGroup.WebFont);
      LLeft := 0;
      LTop := 0;
      if LRadioGroup.Items.Count > 0 then begin
        LText := LRadioGroup.Items.Strings[0];
        LHeight := Max(TextHeight(LText), 12) + 2;
        LWidth := TextWidth(LText) + 18;
        for i := 0 to LRadioGroup.Items.Count - 1 do begin
          DrawResource(iif(LRadioGroup.ItemIndex = i, 'RadioButtonChecked', 'RadioButtonUnchecked')
            , LLeft, LTop);
          TextOut(LLeft + 14, LTop, LRadioGroup.Items.Strings[i]);
          if LRadioGroup.Layout = glVertical then begin
            LTop := LTop + LHeight;
          end else begin
            LLeft := LLeft + LWidth;
          end;
        end;
      end;
    end;
  end;
end;

{ TIWPaintHandlerRectangle }

procedure TIWPaintHandlerRectangle.Paint;
var
  LRect: TIWCustomRectangle;
  LTextRect: TRect;
begin
  LRect := Control as TIWCustomRectangle;
  with ControlCanvas, LRect do begin
    if (BorderOptions.Width > 0) and (toTColor(BorderOptions.Color) <> clNone) and
      (toTColor(BorderOptions.Color) <> clWebTransparent) then begin
      Brush.Style := bsSolid;
      Brush.Color := toTColor(BorderOptions.Color);
      FillRect(Rect(0, 0, Width, Height));

      if (toTColor(WebColor) <> clNone) and (toTColor(WebColor) <> clWebTransparent) then begin
        Brush.COlor := toTColor(WebColor);
      end else begin
        Brush.Color := clWhite;
      end;
      FillRect(Rect(BorderOptions.Width, BorderOptions.Width,
        Width - BorderOptions.Width, Height - BorderOptions.Width));
    end else begin
      if (toTColor(WebColor) = clNone) or (toTColor(WebColor) = clWebTransparent) then begin
        DrawOutline;
      end else begin
        if (toTColor(WebColor) <> clNone) and (toTColor(WebColor) <> clWebTransparent) then begin
          Brush.Color := toTColor(WebColor);
        end else begin
          Brush.Color := clWhite;
        end;

        Brush.Style := bsSolid;
        Pen.Color := toTColor(WebColor);
        FillRect(Rect(0, 0, Width, Height));
      end;
    end;
    SetCanvasFont(WebFont);
    LTextRect := Rect(BorderOptions.Width + 1, BorderOptions.Width + 1, TextWidth(Text), TextHeight(Text));
    case Alignment of
      taRightJustify: begin
          LTextRect.Left := Width - BorderOptions.Width - LTextRect.Right;
        end;
      taCenter: begin
          LTextRect.Left := (Width - BorderOptions.Width - LTextRect.Right) div 2;
        end;
    end;

    case VAlign of
      vaMiddle: LTextRect.Top := (Height - LTextRect.Bottom) div 2;
      vaBottom: LTextRect.Top := Height - BorderOptions.Width - LTextRect.Bottom;
      // vaBaseline: LTextRect.Top := LRect.Height - LTextRect.Bottom;
    end;
    TextOut(LTextRect.Left, LTextRect.Top, Text);
  end;
end;

{ TIWPaintHandlerMenu }
(*
procedure TIWPaintHandlerMenu.Paint;
var
  IDx: integer;
  AutoXY: integer;
  // iWidth, iHeight: integer;
  LMenuControl: TIWMenu;
begin
  AutoXY := 0;
  LMenuControl := FControl as TIWMenu;
  Draw3DBox;
//  ControlCanvas.Font.Assign(Font);
  with LMenuControl do begin
    Canvas.Brush.Color := MenuStyle.Color;
    Canvas.Font.Color := MenuStyle.Font.Color;
    Canvas.Pen.Color := MenuStyle.HighlightColor;
    Canvas.Pen.Width := 2;
    Canvas.Font.Style := MenuStyle.Font.Style;
    Canvas.Font.Size := MenuStyle.Font.Size;
    Canvas.Font.Color := MenuStyle.Font.Color;
    Canvas.Font.Name := MenuStyle.Font.Name;
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end;

  //	Draw the attached menu - top level only
  if Assigned(LMenuControl.AttachedMenu) and (LMenuControl.AttachedMenu.Items.Count > 0) then
  begin
    if LMenuControl.AutoSize <> mnaNone then
    begin
      if LMenuControl.Orientation = iwOHorizontal then
      begin
        if LMenuControl.ItemSpacing = itsEvenlySpaced then
          AutoXY := (LMenuControl.Width div LMenuControl.AttachedMenu.Items.Count)
        else
          AutoXY := (TIWAppForm(LMenuControl.Owner).Width div LMenuControl.AttachedMenu.Items.Count)
      end else
      begin
        if LMenuControl.ItemSpacing = itsEvenlySpaced then
          AutoXY := (LMenuControl.Height div LMenuControl.AttachedMenu.Items.Count)
        else
          AutoXY := (TIWAppForm(LMenuControl.Owner).Height div LMenuControl.AttachedMenu.Items.Count);
      end;
    end;

    for IDX := 0 to LMenuControl.AttachedMenu.Items.Count - 1 do
    begin
      if LMenuControl.Orientation = iwOHorizontal then
      begin
        if LMenuControl.AutoSize <> mnaNone then
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(LMenuControl.TextOffset + (AutoXY * IDx) + 1,
            (LMenuControl.MenuStyle.Height - LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption))) shr 1,
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (AutoXY * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
        end else
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 1,
            (LMenuControl.MenuStyle.Height - LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption))) shr 1,
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
        end;
      end else
      begin
        if LMenuControl.AutoSize <> mnaNone then
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(1, LMenuControl.TextOffset + (AutoXY * IDx) + (LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption)) shr 1),
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          LMenuControl.Canvas.FrameRect(Rect(2, LMenuControl.TextOffset + (AutoXY * IDx) + 2,
            LMenuControl.MenuStyle.Width - 2, LMenuControl.TextOffset + (LMenuControl.MenuStyle.Height * (IDx + 1)) - 2));
        end else
        begin
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.Color;
          LMenuControl.Canvas.TextOut(1, LMenuControl.TextOffset + (LMenuControl.MenuStyle.Height * IDx) +
            (LMenuControl.Canvas.TextHeight(FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption)) shr 1),
            FixCaption(LMenuControl.AttachedMenu.Items[IDX].Caption));
          LMenuControl.Canvas.Brush.Color := LMenuControl.MenuStyle.HighlightColor;
          LMenuControl.Canvas.FrameRect(Rect(LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * IDx) + 2, 2,
            LMenuControl.TextOffset + (LMenuControl.MenuStyle.Width * (IDx + 1)) - 2, LMenuControl.MenuStyle.Height - 2));
        end;
      end;
    end;
    //ControlCanvas.TextOut(4, (Height - ControlCanvas.TextHeight('No Menu')) shr 1, FAttachedMenu.Name);
  end else
    LMenuControl.Canvas.TextOut(4, (LMenuControl.Height - LMenuControl.Canvas.TextHeight('No Menu')) shr 1, 'No menu attached');
end;
*)
{ TIWPaintHandlerLabel }

procedure TIWPaintHandlerLabel.Paint;
var
  LWidth: Integer;
  LLabel: TIWCustomLabel;
  LLeft: Integer;
begin
  LLabel := Control as TIWCustomLabel;
  with LLabel, ControlCanvas do
  begin
    TextFlags := 0;
    if (toTColor(BGColor) <> clNone) and (toTColor(BGColor) <> clWebTransparent) then
    begin
      Brush.Color := ToTColor(BGColor);
      Brush.Style := bsSolid;
      FillRect(Rect(0, 0, Width, Height));
    end else begin
      // Transparent. Do NOT set Brush.Color after this, it will reset this to bsSolid.
      Brush.Style := bsClear;
    end;

    SetCanvasFont(LLabel.WebFont);
    if LLabel.Align = alNone then
    begin
      if LLabel.AutoSize then
      begin
        LWidth := TextWidth(LLabel.Caption);
        if LLabel.Alignment = taLeftJustify then
        begin
          LWidth := Trunc(LWidth * 1.10); { <- it causes wrong size calc at design
                                            if taRightJustify or taLeftJustify. Ivan }
        end;
      end
      else
      begin
        LWidth := LLabel.Width;
      end;
    end
    else
    begin
      LWidth := LLabel.Width;
    end;
    LLeft := 0;
    case LLabel.Alignment of
      taLeftJustify: LLeft := 0;
      taCenter: LLeft := (LWidth div 2) - (TextWidth(LLabel.Caption) div 2);
      taRightJustify: LLeft := LWidth - TextWidth(LLabel.Caption);
    end;
    TextRect(Rect(LLeft, 0, LWidth, TextHeight(LLabel.Caption)), LLeft, 0, LLabel.Caption);
    if (LLabel.Align = alNone) and LLabel.AutoSize then
    begin
      LLabel.Width := LWidth;
      LLabel.Height := TextHeight(LLabel.Caption);
    end;
  end;
end;

procedure TIWPaintHandlerButton.Paint;
var
  LRect: TRect;
  LButton: TIWButton;
begin
  LButton := Control as TIWButton;
  with ControlCanvas do begin
    LRect := DrawButton(Rect(0, 0, LButton.Width - 1, LButton.Height - 1), 1);
    Brush.Style := bsSolid;
    if (toTColor(LButton.WebColor) <> clNone) and (toTColor(LButton.WebColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(LButton.WebColor);
    end else begin
      Brush.Color := clWhite;
    end;
    FillRect(LRect);
    SetCanvasFont(LButton.WebFont);
    TextRect(LRect, Max(0, (LRect.Right - LRect.Left - TextWidth(LButton.Caption)) div 2)
      , Max(0, (LRect.Bottom - LRect.Top - TextHeight(LButton.Caption)) div 2), LButton.Caption);
  end;
end;

{ TIWPaintHandlerEdit }

procedure TIWPaintHandlerEdit.Paint;
var
  LEdit: TIWCustomEdit;
  LLeft: Integer;
  LRect: TRect;
  S: string;
begin
  LEdit := Control as TIWCustomEdit;
  with ControlCanvas do
  begin
    S := LEdit.Text;

    SetCanvasFont(LEdit.WebFont);

    if (toTColor(LEdit.BGColor) <> clNone) and (toTColor(LEdit.BGColor) <> clWebTransparent) then
    begin
      Brush.Color := toTColor(LEdit.BGColor);
    end
    else
    begin
      Brush.Color := clWhite;
    end;

    Pen.Color := clBlack;
    Pen.Width := 1;
    Rectangle(Rect(0, 0, LEdit.Width, LEdit.Height));
    LRect := Rect(0, 0, LEdit.Width - 2, LEdit.Height - 2);
    Draw3DBox(LRect, 1, clSilver, [ssBottom, ssRight]);

    if (toTColor(LEdit.BGColor) <> clNone) and (toTColor(LEdit.BGColor) <> clWebTransparent) then
    begin
      Brush.Color := toTColor(LEdit.BGColor);
    end;

    LLeft := 2;
    case LEdit.Alignment of
      taLeftJustify: LLeft := 2;
      taCenter: LLeft := (LEdit.Width div 2) - (TextWidth(S) div 2) + 2;
      taRightJustify: LLeft := LEdit.Width - TextWidth(S) - 2;
    end;
    TextRect(Rect(LLeft, 2, Min(LEdit.Width - 2, LLeft + TextWidth(S)), LEdit.Height - 2), LLeft, 2, S);
  end;
end;

{ TIWPaintHandlerCheckBox }

procedure TIWPaintHandlerCheckBox.Paint;
var
  LCheckBox: TIWCustomCheckBox;
begin
  LCheckBox := Control as TIWCustomCheckBox;
  with ControlCanvas do begin
    Draw3DBox(Rect(1, 1, 14, 14), 1, clSilver, [ssBottom, ssRight]);
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    Rectangle(3, 3, 13, 13);
    SetCanvasFont(LCheckBox.WebFont);
    Brush.Style := bsClear;
    TextRect(Rect(20, 2, LCheckBox.Width - 1, LCheckBox.Height - 2), 20, 2, LCheckBox.Caption);
    if LCheckBox.Checked then begin
      Pen.Color := clBlack;
      Brush.Color := clBlack;
      Brush.Style := bsSolid;
      Polygon([Point(5, 7),
        Point(5, 9),
               Point(7, 11), Point(11, 7),
               Point(11, 5), Point(7, 9)
        , Point(5, 7)]);
    end;
  end;
end;

{ TIWPaintHandlerComboBox }

procedure TIWPaintHandlerComboBox.Paint;
var
  LRect: TRect;
  LComboBox: TIWCustomComboBox;
begin
  LComboBox := Control as TIWCustomComboBox;
  with ControlCanvas, LComboBox do begin
    Draw3DBox;
    SetCanvasFont(LComboBox.WebFont);

    if (ToTColor(BGColor) = clNone) or (toTColor(BGColor) = clWebTransparent) then begin
      Brush.Color := clWhite;
    end else begin
      Brush.Color := ToTColor(BGColor);
    end;

    if (ItemIndex >= 0) and (ItemIndex < Items.Count) then begin
      TextRect(Rect(2, 2, Width - 18, Height - 2), 2, 2, LComboBox.Text);
    end else begin
      Rectangle(2, 2, Width - 18, Height - 2);
    end;
  //  ControlCanvas.MoveTo(Width - 16, Height -1);
  //  ControlCanvas.LineTo(Width - 16, Height -1);
    LRect := DrawButton(Rect(Width - 17, Height - 18, Width - 2, Height - 2));
    //TODO : Button not EXACTLY the same but will do for now. View under zoom 5:1 to see diff
    DrawArrow(LRect, adDown);
  end;
end;

{ TIWPaintHandlerListBox }

procedure TIWPaintHandlerListBox.Paint;
var
  i, YPos, Bt: Integer;
  LText: string;
  LListBox: TIWCustomListbox;
begin
  LListBox := Control as TIWCustomListbox;
  with ControlCanvas, LListBox do
  begin
    if (ToTColor(BGColor) = clNone) or (toTColor(BGColor) = clWebTransparent) then begin
      Brush.Color := clWhite;
    end else begin
      Brush.Color := ToTColor(BGColor);
    end;
    Brush.Style := bsSolid;
    FillRect(Rect(0, 0, LListBox.Width, LListBox.Height));

    if not(RequireSelection) and not(MultiSelect) and (LListBox.NoSelectionText <> '') then begin
      i := -1;
    end else begin
      i := 0;
    end;
    YPos := 1;
    while (YPos < LListBox.Height - 2) and (i < LListBox.Items.Count) do
    begin
      SetCanvasFont(LListBox.WebFont);
      if (i < 0) then begin
        LText := Trim(LListBox.NoSelectionText);
      end else begin
        if ItemsHaveValues then begin
          LText := Items.Names[i];
        end else begin
          LText := Items.Strings[i];
        end;
      end;

      if LText = '' then begin
        LText := ' ';
      end;

      Bt := YPos + TextHeight(LText);
      if Bt >= LListBox.Height - 2 then
      begin
        Bt := LListBox.Height - 2;
      end;

      if (not LListBox.MultiSelect and (LListBox.ItemIndex = i)) or ((i >= 0) and LListBox.MultiSelect and LListBox.Selected[i]) then begin
        ControlCanvas.Font.Color := clHighlightText;
        ControlCanvas.Brush.Color := clHighlight;
      end else begin
        // Font.Color := LListBox.Font.Color;
        if (ToTColor(BGColor) = clNone) or (toTColor(BGColor) = clWebTransparent) then begin
          Brush.Color := clWhite;
        end else begin
          Brush.Color := ToTColor(BGColor);
        end;
      end;
      { TODO : Fix black marker on line }
      TextRect(Rect(4, YPos + 2, LListBox.Width - 5, Bt), 4, YPos + 2, LText);
      // Font.Color := LListBox.Font.Color;
      Brush.Color := clNone;

      Inc(i);
      YPos := Bt;
    end;
    Draw3DBox;
  end;
end;

{ TIWPaintHandlerMemo }

procedure TIWPaintHandlerMemo.Paint;
var
  LMemo: TIWCustomMemo;
begin
  LMemo := Control as TIWCustomMemo;
  with ControlCanvas, LMemo do begin
    if (toTColor(BGColor) <> clNone) and (toTColor(BGColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(BGColor);
    end else begin
      Brush.Color := clWhite;
    end;
    Draw3DBox;
    Rectangle(Rect(2, 2, Width - 16, Height - 2));
    SetCanvasFont(LMemo.WebFont);
    DrawTextLines(Rect(3, 2, Width - 15, Height - 1), LMemo.Lines, true);
    if LMemo.VertScrollBar then begin
      DrawScrollbar(Rect(Width - 16, 1, Width - 1, Height - 1));
    end;
  end;
end;

{ TIWPaintHandlerLink }

procedure TIWPaintHandlerLink.Paint;
var
  LLink: TIWLinkBase;
begin
  LLink := Control as TIWLinkBase;
  with ControlCanvas do begin
    SetCanvasFont(LLink.WebFont);
    Brush.Style := bsClear;
    if (toTColor(LLink.WebColor) <> clNone) and (toTColor(LLink.WebColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(LLink.WebColor);
    end;
    case LLink.Alignment of
      taLeftJustify: TextOut(0, 0, LLink.Caption);
      taRightJustify: TextOut(ClipRect.Right - TextWidth(LLink.Caption), 0, LLink.Caption);
      taCenter: TextOut((ClipRect.Right - ClipRect.Left - TextWidth(LLink.Caption)) div 2, 0, LLink.Caption);
    end;
  end;
end;

{ TIWPaintHandlerText }

procedure TIWPaintHandlerText.Paint;
var
  LText: TIWCustomText;
begin
  LText := Control as TIWCustomText;
  with ControlCanvas do
  begin
    if LText.Lines.Count = 0 then
    begin
      SetTransparent;
      DrawOutline;
      DrawResource(Control.ClassName, (Control.Width - 24) div 2, (Control.Height - 24) div 2);
    end
    else
    begin
      if (toTColor(LText.BGColor) <> clNone) and (toTColor(LText.BGColor) <> clWebTransparent) then
      begin
        Brush.Color := toTColor(LText.BGColor);
      end
      else
      begin
        Brush.Color := clWhite;
      end;
      Brush.Style := bsSolid;
      Pen.Color := toTColor(LText.BGColor);
      FillRect(Rect(0, 0, LText.Width, LText.Height));

      SetCanvasFont(LText.WebFont);
      DrawTextLines(Rect(1, 1, LText.Width - 2, LText.Height - 2), LText.Lines, true);
    end;
  end;
end;

{ TIWPaintHandlerImage }

procedure TIWPaintHandlerImage.Paint;
var
  LImage: TIWCustomImage;
  LX, LY: Integer;
begin
  LImage := Control as TIWCustomImage;
  LX := 0;
  LY := 0;
  with ControlCanvas, LImage do begin
    // FPicture is nil during initial create at design time for TIWImageFile (inherited Create)
    if (BorderOptions.Width > 0) and (toTColor(BorderOptions.Color) <> clNone)
      and (toTColor(BorderOptions.Color) <> clWebTransparent) then begin
      Brush.Color := toTColor(BorderOptions.Color);
      Brush.Style := bsSolid;
      Pen.Color := toTColor(BorderOptions.Color);
      Rectangle(LX, LY, Width, Height);
      Brush.Color := toTColor(WebColor);
      Brush.Style := bsSolid;
      Pen.Color := toTColor(WebColor);
      Rectangle(BorderOptions.Width, BorderOptions.Width,
        Width - BorderOptions.Width, Height - BorderOptions.Width);
      LX := LX + BorderOptions.Width;
      LY := LY + BorderOptions.Width;
    end;
    if LImage.Picture <> nil then begin
      if LImage.Picture.Graphic <> nil then begin
        if not LImage.RenderSize then begin
          Draw(LX, LY, LImage.Picture.Graphic);
        end else begin
          StretchDraw(Rect(0, 0, LImage.Width, LImage.Height), LImage.Picture.Graphic);
        end;
      end else begin
        DrawOutLine(LX, LY, Width - BorderOptions.Width, Height - BorderOptions.Width);
        DrawResource(ClassName, (Width - 24) div 2, (Height - 24) div 2);
      end;
    end;
  end;
end;

{ TIWPaintHandlerHRule }

procedure TIWPaintHandlerHRule.Paint;
begin
  with ControlCanvas do
  begin
    Brush.Color := TIWHRule(Control).BGColor;
    if Brush.Color = clNone then begin
      Brush.Style := bsClear;
    end else begin
      Brush.Style := bsSolid;
    end;
    Pen.Width := 1;
    Pen.Style := psSolid;
    Pen.Color := TIWHRule(Control).BorderColor;
    Rectangle(0, 0, Control.Width, Control.Height);
  end;
end;

{ TIWPaintHandlerList }

procedure TIWPaintHandlerList.Paint;
var
  i, LHeight: integer;
  s: string;
  LList: TIWList;
begin
  LList := Control as TIWList;
  with ControlCanvas do
  begin
    SetTransparent;
    SetCanvasFont(LList.WebFont);
    if LList.Items.Count > 0 then
    begin
      LHeight := TextHeight(LList.Items.Strings[0]);
      for i := 0 to LList.Items.Count - 1 do
      begin
        s := LList.Items.Strings[i];
        if LList.Numbered then
        begin
          s := IntToStr(i + 1) + ' ' + s;
        end
        else
        begin
          //TODO: Change to a real bullet
          s := '* ' + s;
        end;
        TextOut(0, i * LHeight, s);
      end;
    end
    else
    begin
      DrawOutline;
      DrawResource(Control.ClassName, (Control.Width - 24) div 2, (Control.Height - 24) div 2);
    end;
  end;
end;

{ TIWPaintHandlerDBNavigator }
procedure TIWPaintHandlerDBNavigator.Paint;
const
  LCXOffset = 3;
  LCYOffset = 3;
var
  LLeft, LTop: Integer;
  LDeltaLeft, LDeltaTop: Integer;
  LNavigator: TIWDBNavigator;

  procedure DrawImage(AResourceName: string; var ALeft, ATop : integer; ADeltaLeft, ADeltaTop : integer);
  var
    LBitmap : TBitmap;
  begin
    LBitmap := Graphics.TBitmap.Create;
    try
      LBitmap.LoadFromResourceName(HInstance, UpperCase(AResourceName));
      LBitmap.TransparentColor := LBitmap.Canvas.Pixels[0, 0];
      LBitmap.Transparent := true;
      DrawButton(Rect(ALeft, ATop, ALeft + LBitmap.Width + LCXOffset * 2, ATop + LBitmap.Height + LCYOffset * 2), 0);
      ControlCanvas.Draw(ALeft + LCXOffset, ATop + LCYOffset, LBitmap);
    finally
      FreeAndNil(LBitmap);
    end;

    Inc(ALeft, ADeltaLeft);
    Inc(ATop, ADeltaTop);
  end;

begin
  // Depending on number of buttons do the painting.
  LLeft := 0;
  LTop := 0;
  LDeltaLeft := 0;
  LDeltaTop := 0;

  LNavigator := Control as TIWDBNavigator;

  with LNavigator do
  begin
    case Orientation of
      orHorizontal  : begin
                        LDeltaLeft := ImageWidth + LCXOffset * 2;
                        LDeltaTop := 0;
                      end;
      orVertical    : begin
                        LDeltaLeft := 0;
                        LDeltaTop := ImageHeight + LCYOffset * 2;
                      end;
    end;

    if nbFirst in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_first', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbPrior in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_prior', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbNext in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_next', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbLast in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_last', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbInsert in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_insert', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbDelete in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_delete', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbEdit in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_edit', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbPost in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_post', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbCancel in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_cancel', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if nbRefresh in VisibleButtons then
    begin
      DrawImage('IW_DT_DBNav_refresh', LLeft, LTop, LDeltaLeft, LDeltaTop);
    end;

    if Align = alNone then
    begin
      case Orientation of
        orHorizontal  : Width := LLeft;
        orVertical    : Height := LTop;
      end;
    end;
  end;
end;

{ TIWPaintHandlerProgressBar }
procedure TIWPaintHandlerProgressBar.Paint;
var
  LPBar: TIWProgressBar;
begin
  LPBar := Control as TIWProgressBar;
  with ControlCanvas, LPBar do begin
    if (toTColor(BGColor) <> clNone) and (toTColor(BGColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(BGColor);
    end else begin
      Brush.Color := clWhite;
    end;

    Brush.Style := bsSolid;
    Pen.Color := clBlack;
    Rectangle(0, 0, Width, Height);
    if Percent > 0 then begin
      Brush.Color := toTColor(WebColor);
      Brush.Style := bsSolid;
      Pen.Color := toTColor(WebColor);
      Rectangle(1, 1, (Width * Percent) div 100, Height - 1);
    end;
  end;
end;

{ TIWPaintHandlerRadioButton }

procedure TIWPaintHandlerRadioButton.Paint;
var
  LRadioButton: TIWRadioButton;
  LTop: integer;
begin
  if not (Control is TIWRadioButton) then
  begin
    inherited Paint;
    Exit;
  end;

  LRadioButton := Control as TIWRadioButton;
  with ControlCanvas do begin
    Pen.Color := clBlack;
    Brush.Color := clNone;
    Pen.Style := psSolid;
    Brush.Style := bsClear;
    SetCanvasFont(LRadioButton.WebFont);
    LTop := (LRadioButton.Height - TextHeight('O')) div 2;
    DrawResource(iif(LRadioButton.Checked, 'RadioButtonChecked', 'RadioButtonUnchecked'), 2, LTop);
    TextOut(16, LTop, LRadioButton.Caption);
  end;
end;

{ TIWPaintHandlerRegion }

procedure TIWPaintHandlerRegion.Paint;
var
  LRegion: TIWCustomRegion;
  LRect: TRect;
  LWidth: Integer;
  LBorderColor: TColor;
  LColor: TColor;
begin
  LRegion := Control as TIWCustomRegion;

  LColor := LRegion.WebColor;

  with ControlCanvas do begin
    if (toTColor(LColor) <> clNone) and (toTColor(LColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(LColor);
    end
    else begin
      Brush.Color := clWhite;
    end;
    Brush.Style := bsSolid;
    LRect := LRegion.ClientRect;
    FillRect(LRect);

    if (toTColor(LRegion.BorderOptions.Color) <> clNone) and
      (toTColor(LRegion.BorderOPtions.Color) <> clWebTransparent) then begin
      LBorderColor := toTColor(LRegion.BorderOptions.Color);
    end else begin
      LBorderColor := toTColor(LColor);
    end;

    LWidth := LRegion.BorderOptions.PixelWidth;

    Pen.Width := LWidth;
    Pen.Style := psSolid;
    Pen.Color := LBorderColor;
    LRect := Rect(0, 0, Control.Width, Control.Height);
    InflateRect(LRect, -(LWidth div 2), -(LWidth div 2));
    if Pen.Width > 0 then begin
      case LRegion.BorderOptions.Style of
        // cbsNone: Pen.Style := psClear;
        // cbsHidden: Pen.Style := psClear;
        cbsDotted: begin
            Pen.Style := psDot;
            Rectangle(LRect);
          end;
        cbsDashed: begin
            Pen.Style := psDash;
            Rectangle(LRect);
          end;
        cbsSolid: begin
            Rectangle(LRect);
          end;
        cbsDouble: begin
            Pen.Width := LWidth div 3;
            LRect := Rect(0, 0, Control.Width, Control.Height);
            InflateRect(LRect, -Pen.Width, -Pen.Width);
            Rectangle(LRect);
            LRect := Rect(0, 0, Control.Width, Control.Height);
            InflateRect(LRect, -(LWidth div 3 + 1), -(LWidth div 3 + 1));
            Rectangle(LRect);
          end;
        cbsGroove: begin
            LRect := Rect(0, 0, Control.Width, Control.Height);
            Draw3DBox(LRect, LWidth div 2, LBorderColor, [ssBottom, ssRight]);
            InflateRect(LRect, -(LWidth div 2), -(LWidth div 2));
            Draw3DBox(LRect, LWidth div 2, LBorderColor, [ssTop, ssLeft]);
          end;
        cbsRidge: begin
            LRect := Rect(0, 0, Control.Width, Control.Height);
            Draw3DBox(LRect, LWidth, toTColor(LRegion.BorderOptions.Color));
          end;
        cbsInset: begin
            LRect := Rect(0, 0, Control.Width, Control.Height);
            Draw3DBox(LRect, LWidth, toTColor(LRegion.BorderOptions.Color));
          end;
        cbsOutset: begin
            LRect := Rect(0, 0, Control.Width, Control.Height);
            Draw3DBox(LRect, LWidth, toTColor(LRegion.BorderOptions.Color), [ssBottom, ssRight]);
          end;
      end;
    end;
  end;
end;

{ TIWPaintHandlerTabControl }

procedure TIWPaintHandlerTabControl.Paint;
var
  LTabControl : TIWTabControl;
  f : integer;
  LRect : TRect;
  LTabTitle : string;
  LLastLeft : integer;
  LWidth : integer;
  LTabOrder : TList;
begin
  LTabControl := Control as TIWTabControl;
  with ControlCanvas do begin
    Pen.Width := 1;
    Pen.Style := psSolid;
    Pen.Color := clBlack;

    // Fill the main area
    Brush.Style := bsSolid;
    if (toTColor(LTabControl.WebColor) <> clNone) and
       (toTColor(LTabControl.WebColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(LTabControl.WebColor);
    end else begin
      Brush.Color := clWebSilver;
    end;
    LRect := Rect(0, 0, Control.Width, Control.Height);
    Rectangle(LRect);

    // Paint tab buttons

    // Sort by TabOrder
    LTabOrder := TList.Create;
    try
      for f := 0 to Pred(LTabControl.Pages.Count) do begin
        LTabOrder.Add(TIWTabPage(LTabControl.Pages[f]))
      end;
      MergeSortList(LTabOrder, TabOrderCompare);

      LLastLeft := 1;
      Brush.Color := clWhite;
      for f := 0 to Pred(LTabOrder.Count) do begin
        LTabTitle := TIWTabPage(LTabOrder[f]).Title;

        LWidth := TextWidth(LTabTitle) + 12;
        LRect := Rect(LLastLeft, 0, LLastLeft + LWidth, TAB_ROW_HEIGHT);
        FillRect(LRect);
        with LRect do begin
          MoveTo(LRect.Left, LRect.Bottom);
          LineTo(LRect.Left, LRect.Top);
          LineTo(LRect.Right, LRect.Top);
          LineTo(LRect.Right, LRect.Bottom);
          if LTabControl.ActivePage <> f then begin
            MoveTo(LRect.Left, LRect.Bottom - 1);
            LineTo(LRect.Right, LRect.Bottom - 1);
          end;
          TextOut(LRect.Left + 6, LRect.Top + 2, LTabTitle);
          LLastLeft := LLastLeft + LWidth + 1;
        end;
      end;
    finally
      FreeAndNil(LTabOrder);
    end;
  end;
end;

{ TIWPaintHandlerTabPage }

procedure TIWPaintHandlerTabPage.Paint;
var
  LTabPage : TIWTabPage;
  LRect: TRect;
begin
  LTabPage := Control as TIWTabPage;

  with ControlCanvas do begin
    Pen.Width := 1;
    Pen.Style := psSolid;
    Pen.Color := clBlack;
    Brush.Style := bsSolid;
    if (toTColor(LTabPage.WebColor) <> clNone) and
       (toTColor(LTabPage.WebColor) <> clWebTransparent) then begin
      Brush.Color := toTColor(LTabPage.WebColor);
    end else begin
      Brush.Color := clWhite;
    end;
    LRect := Rect(0, 0, Control.Width, Control.Height);
    ControlCanvas.FillRect(LRect);
    MoveTo(LRect.Left, LRect.Top);
    LineTo(LRect.Left, LRect.Bottom - 1);
    LineTo(LRect.Right - 1, LRect.Bottom - 1);
    LineTo(LRect.Right - 1, LRect.Top);
  end;
end;

{ TIWPaintHandlerGradButton }

procedure TIWPaintHandlerGradButton.Paint;
var
  LButton: TIWGradButton;
  LRect: TRect;
  FromColor, ToColor: TIWColor;
  xFont: TIWFont;
begin
  LButton := Control as TIWGradButton;
  with ControlCanvas do begin
    LRect := Rect(0, 0, LButton.Width, LButton.Height);
    if LButton.Enabled then begin
      FromColor := LButton.Style.Button.FromColor;
      ToColor := LButton.Style.Button.ToColor;
      xFont := LButton.Style.Button.Font;
    end else begin
      FromColor := LButton.Style.ButtonDisabled.FromColor;
      ToColor := LButton.Style.ButtonDisabled.ToColor;
      xFont := LButton.Style.ButtonDisabled.Font;
    end;
    GradientFillCanvas(ControlCanvas,
                       FromColor,
                       ToColor,
                       LRect,
                       gdVertical);
    Brush.Style := bsClear;
    SetCanvasFont(xFont);
    TextRect(LRect, Max(0, (LRect.Right - LRect.Left - TextWidth(LButton.Caption)) div 2)
      , Max(0, (LRect.Bottom - LRect.Top - TextHeight(LButton.Caption)) div 2), LButton.Caption);
  end;
end;

{ TIWPaintHandlerAudioControl }

destructor TIWPaintHandlerAudioControl.Destroy;
begin
  if Assigned(FBmp) then begin
    FreeAndNil(FBmp);
  end;
  inherited;
end;

procedure TIWPaintHandlerAudioControl.Paint;
var
  y: Integer;
begin
  inherited;
  with ControlCanvas do begin
    if TIWAudio(Control).ShowAudioPlayer then begin
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      FillRect(Rect(0, 0, Control.Width, Control.Height));
      if FBmp = nil then begin
        FBmp := GetBitmapFromResource('IW_AUDIO');
      end;
      y := Control.Height - FBmp.Height;
      if y < 0 then begin
        y := 0;
      end;
      Draw(0, y, FBmp);
    end;
  end;
end;

initialization
  IWRegisterPaintHandler('TIWTabControl', TIWPaintHandlerTabControl);
  IWRegisterPaintHandler('TIWTabPage', TIWPaintHandlerTabPage);
  IWRegisterPaintHandler('TIWApplet', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWFlash', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWHTMLFlash', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWGrid', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWTimer', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWTreeView', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWRadioGroup', TIWPaintHandlerRadioGroup);
  IWRegisterPaintHandler('TIWRectangle', TIWPaintHandlerRectangle);
  IWRegisterPaintHandler('TIWHTMLRectangle', TIWPaintHandlerRectangle);
  // IWRegisterPaintHandler('TIWMenu', TIWPaintHandlerMenu);
  IWRegisterPaintHandler('TIWLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TIWButton', TIWPaintHandlerButton);
  IWRegisterPaintHandler('TIWEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWTimeEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TIWLink', TIWPaintHandlerLink);
  IWRegisterPaintHandler('TIWURL', TIWPaintHandlerLink);
  IWRegisterPaintHandler('TIWText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TIWList', TIWPaintHandlerList);
  IWRegisterPaintHandler('TIWHRule', TIWPaintHandlerHRule);
  IWRegisterPaintHandler('TIWImage', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWImageFile', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWImageButton', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWRadioButton', TIWPaintHandlerRadioButton);
  IWRegisterPaintHandler('TIWComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWProgressBar', TIWPaintHandlerProgressBar);
  IWRegisterPaintHandler('TIWDBGrid', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDBEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TIWDBLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TIWDBCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TIWDBComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWDBLookupComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TIWDBListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWDBLookupListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TIWDBText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TIWDBMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TIWDBImage', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TIWDBImage', TIWPaintHandlerComponent);
  IWRegisterPaintHandler('TIWDBNavigator', TIWPaintHandlerDBNavigator);
  IWRegisterPaintHandler('TIWRegion', TIWPaintHandlerRegion);
  IWRegisterPaintHandler('TIWGradButton', TIWPaintHandlerGradButton);
  IWRegisterPaintHandler('TIWAudio', TIWPaintHandlerAudioControl);

end.


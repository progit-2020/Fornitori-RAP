unit meTIWAdvCheckGroup;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWAdvCheckGroup,
  Graphics, Forms, Windows, IWPicCntnr,
  IWTypes, IWFont, IWCompButton, IWColor,
  IWCompEdit, IWCompLabel, IWBaseInterfaces, IWCompCheckbox, IWCompExtCtrls, IWHTMLTag, IWCompListbox,
  IWTMSBase,IWCompRectangle, IWRenderContext,Menus;

type
  TmeTIWAdvCheckGroup = class(TTIWAdvCheckGroup)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;

implementation

uses
  ImgList, ShellAPI, CommCtrl,
  IWApplication, IWServerControllerBase,IWResourceStrings,
  IWAppForm, IWServer,
  IW.Common.Strings, IW.Common.System;

constructor TmeTIWAdvCheckGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RenderSize:=False;
  Font.Enabled:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
    { DONE : TEST IW 14 OK }
    RenderBorder:=False;
  end;
  FContextMenu:=nil;
end;

function TmeTIWAdvCheckGroup.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeTIWAdvCheckGroup.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmeTIWAdvCheckGroup.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  i, j: Integer;
  columnItem, itemCount, itemsPerCol, valueCount: integer;
  tempCount, hiddenChecked, submitclick, ajaxcall: string;
  script, colBorder: string;
begin

  Result := TIWHTMLTag.CreateTag('DIV'); try

    with Result.Contents.AddTag('FIELDSET') do
    begin
      AddStringParam('style',
      iif(BorderColor <> clNone, 'border:' + IntToStr(BorderWidth) + 'px solid ' + ColorToRGBString(BorderColor) + ';','') // daniloc. 25.05.2011
      + iif(BackGroundColor <> clNone, 'background-color:' + ColorToRGBString(BackGroundColor) + ';', '')
      //+ 'width:' + IntToStr(Width) + 'px;height:auto;'); //Modifica Luca rimozione width fissa
      + 'height:auto;');

      if Caption <> EmptyStr then
      begin
        with Contents.AddTag('LEGEND') do
        begin
           if CaptionFont.Enabled then // daniloc. 25.05.2011
             AddStringParam('style',
             'font-family:' + iif(CaptionFont.FontFamily <> EmptyStr, CaptionFont.FontFamily, CaptionFont.FontName + ';')
             + iif(CaptionFont.Color <> clNone, 'color:' + ColorToRGBString(CaptionFont.Color) + ';', '')
             + 'font-size:' + IntToStr(CaptionFont.Size) + 'pt;'
             + iif(fsBold in CaptionFont.Style, 'font-weight:bold;', 'font-weight:normal;')
             + iif(fsItalic in CaptionFont.Style, 'font-style:italic;', 'font-style:normal;')
             );
           Contents.AddText(Caption);
        end;
      end;

      columnItem := 0;
      Contents.AddText('<TABLE cellspacing="0" cellpadding="2" '
        + 'style="'
        + iif(Font.Enabled, // daniloc. 25.05.2011
              ' font-size:' + IntToStr(Font.Size)+ 'pt;'
              + iif(fsBold in Font.Style, 'font-weight:bold;', '')
              + iif(fsItalic in Font.Style, 'font-style:italic;', '')
              + 'font-family:' + iif(Font.FontFamily <> EmptyStr, Font.FontFamily, Font.FontName + ';')
              + 'color:' + ColorToRGBString(Font.Color),
              '')
        + ';width:100%;height:auto;">');


      if Layout = glHorizontal then
      begin

        for i := 0 to Items.Count - 1 do
        begin

          if (columnItem = 0) then
              Contents.AddText('<TR>');

          if (columnItem = Columns - 1) or (ColumnBorderColor = clNone) or (ColumnBorderWidth = 0) then
            colBorder := EmptyStr
          else
            colBorder := 'border-right:' + IntToStr(ColumnBorderWidth)
              + 'px solid ' + ColorToRGBString(ColumnBorderColor) + ';';

          Contents.AddText('<TD style="' + colBorder +'vertical-align:top;width:' + IntToStr(100 div Columns) + '%">');

          if (CheckChecked = EmptyStr) or (CheckUnchecked = EmptyStr)
            or (CheckCheckedDisabled = EmptyStr) or (CheckUncheckedDisabled = EmptyStr) then
            RenderCB(Contents,i)
          else
            RenderCBImage(Contents,i);

          Contents.AddText('</TD>');
          columnItem := columnItem + 1;

          if (columnItem = Columns) then
          begin
            Contents.AddText('</TR>');
            columnItem := 0;
          end;

        end;
      end
      else
      begin

        tempCount := FloatToStr(Items.count div Columns);
        itemCount := StrToInt(tempCount);
        itemsPerCol := (Items.count mod Columns);
        if itemsPerCol > 0 then
          itemCount := itemCount + 1;

        for j := 0 to itemCount - 1 do
        begin

          for i := 0 to Columns - 1 do
          begin

            if (columnItem = 0) then
              Contents.AddText('<TR>');

            if (columnItem = Columns - 1) or (ColumnBorderColor = clNone) or (ColumnBorderWidth = 0) then
              colBorder := EmptyStr
            else
              colBorder := 'border-right:' + IntToStr(ColumnBorderWidth)
                + 'px solid ' + ColorToRGBString(ColumnBorderColor) + ';';

            Contents.AddText('<TD style="' + colBorder + 'vertical-align:top;width:' + IntToStr(100 div Columns) + '%">');

            if (CheckChecked = EmptyStr) or (CheckUnchecked = EmptyStr)
              or (CheckCheckedDisabled = EmptyStr) or (CheckUncheckedDisabled = EmptyStr) then
            begin
              if i = 0 then
                RenderCB(Contents, j)
              else if Items.Count > j+(i*itemCount) then
                RenderCB(Contents, j+(i*itemCount));
            end
            else
            begin
              if i = 0 then
                RenderCBImage(Contents, j)
              else if Items.Count > j+(i*itemCount) then
                RenderCBImage(Contents, j+(i*itemCount));
            end;

            Contents.AddText('</TD>');
            columnItem := columnItem + 1;

            if (columnItem = Columns) then
            begin
              Contents.AddText('</TR>');
              columnItem := 0;
            end;

          end

        end;

      end;

      Contents.AddText('</TABLE>');

    end;
  except FreeAndNil(Result); raise;
  end;

  //Prefill hidden input
  hiddenChecked := EmptyStr;
  for i := 0 to Items.Count - 1 do
  begin
      hiddenChecked := hiddenChecked + IntToStr(Checked.Items[i]);
  end;

  { DONE : TEST IW 14 OK }
  hiddenChecked := hiddenChecked + '|' + IntToStr(FClickedIndex) + '|';

  if Values.Count > 0 then
    valueCount := Values.Count
  else
    valueCount := Items.Count;

  for i := 0 to valueCount - 1 do
  begin
     if i < Values.Count then
       hiddenChecked := hiddenChecked + StringReplace(Values.Strings[i], '"', '''', [rfReplaceAll]);

     if i < valueCount - 1 then
       hiddenChecked := hiddenChecked + '^';
  end;

  //add hidden input
  with Result.Contents.AddTag('INPUT') do
  begin
    AddStringParam('TYPE', 'hidden');
    AddStringParam('NAME', HTMLName);
    AddStringParam('ID', HTMLName + '_INPUT');
    AddStringParam('VALUE', hiddenChecked);
  end;

  submitclick := '';
  ajaxcall := '';
  if Assigned(OnClick) then
    submitclick := 'SubmitClick('#39 + HTMLName + #39','''',false);'#13;

  if Assigned(OnAsyncItemClick) then
  begin
    ajaxcall := 'processAjaxEvent(''onItemClick'', '
      + HTMLControlImplementation.IWCLName
      + ',''' + HTMLName + '.' + 'DoOnAsyncItemClick' + ''','
      + 'true' + ', null, '
      + 'true' + ');';

    submitclick := '';
  end;

  Acontext.WebApplication.RegisterCallBack(HTMLName+'.DoOnAsyncItemClick', DoOnAsyncItemClick);
  //

  if (CheckChecked = EmptyStr) or (CheckUnchecked = EmptyStr)
    or (CheckCheckedDisabled = EmptyStr) or (CheckUncheckedDisabled = EmptyStr) then
    begin
      script := script
       + '<script>'#13
       + 'function ' + HTMLName + 'CheckClick(index,chk,input)'#13
       + '{'#13;

       //{$IFDEF TMSIW9} Luca
       script := script
        + '  if (!containsName("'+HTMLName+'")) {'#13
        + ' 	 window.ChangedControls += "'+HTMLName+',";'#13
        + '}'#13;
      //{$ENDIF TMSIW9} Luca

      script := script
       + '  var ctrl = FindElem(''' + HTMLName + '_CHK_''+(index+1));'#13
       + '  if (input) '#13
       + '    ctrl.checked = true;'#13
       + '  else if (!chk) '#13
       + '    ctrl.checked = !ctrl.checked;'#13
       + ''#13
       + '  var hi = FindElem(''' + HTMLName + '_INPUT'');'#13
       + '  var oldval = hi.value;'#13
       + '  var updval = 1;'#13
       + '  if (ctrl.checked)'
       + '    updval = 0;'#13
       + '  hi.value = oldval.substr(0,index) + updval + oldval.substr(index + 1, oldval.length - index + 1);'#13
       + '  var shi = hi.value.split("|");'#13
       + '  hi.value = shi[0] + "|" + index + "|" + shi[2];'#13
       + ajaxcall
       + submitclick
       + '}'#13
       + '</script>'#13
       ;
    end
    else
    begin
      script := script
       + '<script>'#13
       + 'function ' + HTMLName + 'CheckClick(index,chk,input)'#13
       + '{'#13;

       //{$IFDEF TMSIW9} Luca
       script := script
        + '  if (!containsName("'+HTMLName+'")) {'#13
        + ' 	 window.ChangedControls += "'+HTMLName+',";'#13
        + '}'#13;
      //{$ENDIF TMSIW9} Luca

      script := script
       + '  var ctrl = FindElem(''' + HTMLName +'_CHK_''+(index+1));'#13
       + '  if (ctrl.src.indexOf("' + CheckChecked + '") >= 0)'#13
       + '  {'#13
       + '    if (! input)'#13
       + '      ctrl.src = ctrl.src.replace("' + CheckChecked + '", "' + CheckUnChecked + '");'#13
       + '  }'#13
       + '  else'#13
       + '    ctrl.src = ctrl.src.replace("' + CheckUnChecked + '", "' + CheckChecked + '");'#13
       + ''#13
       + '  var hi = FindElem(''' + HTMLName + '_INPUT'');'#13
       + '  var oldval = hi.value;'#13
       + '  var updval = 1;'#13
       + '  if (ctrl.src.indexOf("' + CheckChecked + '") >= 0)'#13
       + '    updval = 0;'#13
       + '  hi.value = oldval.substr(0,index) + updval + oldval.substr(index + 1, oldval.length - index + 1);'#13
       + '  var shi = hi.value.split("|");'#13
       + '  hi.value = shi[0] + "|" + index + "|" + shi[2];'#13
       + ajaxcall
       + submitclick
       + '}'#13
       + '</script>'#13
       ;
    end;

    script := script
     + '<script>'
     + 'function ' + HTMLNAME + 'SetCustomValues() '#13
     + '{'#13
     + '  var hi = FindElem(''' + HTMLName + '_INPUT'');'#13
     + '  var shi = hi.value.split("|");'#13
     + '  hi.value = shi[0] + "|" + shi[1] + "|";'#13
     + '  for (i = 0; i < ' + IntToStr(valueCount) + '; i++)'#13
     + '  {'#13
     + '    ctrl = FindElem("'+ HTMLName +'VAL" + i);'#13
     + '    if (ctrl)'#13
     + '      hi.value += ctrl.value;'#13
     + '    if (i < ' + IntToStr(valueCount) + ' - 1)'#13
     + '      hi.value += "^";'#13
     + '  }'#13
     + '}'#13
     + '</script>'
     ;

  Result.Contents.AddText(script);

end;

end.

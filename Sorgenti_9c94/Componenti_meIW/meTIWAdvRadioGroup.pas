unit meTIWAdvRadioGroup;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWAdvRadioGroup, IWHTMLTag, IWColor, Graphics,
  Forms, Windows, IWPicCntnr, IWTypes, IWCompButton,
  IWCompEdit, IWCompLabel, IWCompCheckbox, IWCompExtCtrls, IWCompListbox,
  IWCompRectangle, IWTMSBase, IWMarkupLanguageTag;

type
  TmeTIWAdvRadioGroup = class(TTIWAdvRadioGroup)
  private
    function Render(AContext: TIWBaseComponentContext): TIWHTMLTag;
    procedure RenderRBMedp(Contents: TIWHTMLTagCollection; i: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    medpTag: TObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  //{$IFDEF TMSIW6}
  function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;

  //{$ELSE}
  //function RenderHTML: TIWHTMLTag; override;
  //{$ENDIF}
  { Public declarations }
  published
  { Published declarations }
  end;


implementation

uses
  ImgList, ShellAPI, CommCtrl,
  IWApplication, IWServerControllerBase,IWResourceStrings,
  IWAppForm, IWServer
  , IW.Common.Strings, IW.Common.System;

constructor TmeTIWAdvRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderColor:=clWebTransparent;
  BorderWidth:=0;
  CaptionFont.Enabled:=False;
  ColumnBorderWidth:=0;
  Columns:=1;
  Font.Enabled:=False;
  Layout:=glVertical;
  RenderSize:=False;
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
end;

destructor TmeTIWAdvRadioGroup.Destroy;
begin
  if Assigned(medpTag) then
    try FreeAndNil(medpTag); except end;
  inherited Destroy;
end;

function TmeTIWAdvRadioGroup.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText:string;
  Index1:Integer;
  Index2:Integer;
  Temp, Part1, Part2:string;
begin
  Result:=render(AContext);
  HTMLText:=Result.Contents[0].Render;
  Index1:=Pos('fieldset',HTMLText);
  Temp:=Copy(HTMLText,Index1 + 8,Length(HTMLText) - Index1 - 7);
  Index2:=Pos('>',Temp);

  Part1:=Copy(HTMLText,0,Index1 + 7); //7-> caratteri parola "fieldset"
  Part2:=Copy(Temp,Index2, Length(Temp) - Index2 + 1);

  HTMLText:=Part1 + Part2;

  if not CaptionFont.Enabled then
  begin
    Index1:=Pos('legend',HTMLText);
    if (Index1 >0 ) then
    begin
      Temp:=Copy(HTMLText,Index1 + 6,Length(HTMLText) - Index1 - 5);
      Index2:=Pos('>',Temp);

      Part1:=Copy(HTMLText,0,Index1 + 6); //6-> caratteri parola "legend"
      Part2:=Copy(Temp,Index2, Length(Temp) - Index2 + 1);
    end;
  end;

  Part2:=StringReplace(Part2,'cellpadding=4','cellpadding=0',[]);  //per rimuovere spazio tra i radio verticalmente
  HTMLText:=Part1 + Part2;

  Result.Contents.AddText(Part1 + Part2);
  Result.Contents.Exchange(0,Result.Contents.Count - 1);
  Result.Contents[Result.Contents.Count - 1].Free;
  Result.Contents.Delete(Result.Contents.Count - 1);
end;

//Workaround. gli elementi disabilitati in async rimangono clicckabili
//vedi segnalazione wiki 6/8/2013.

procedure TmeTIWAdvRadioGroup.RenderRBMedp(Contents: TIWHTMLTagCollection; i: Integer);
var s: String;
begin
   with Contents.AddTag('INPUT') do
    begin
      AddStringParam('TYPE', 'RADIO');
      Add(iif(ItemIndex = i, ' CHECKED'));
      AddStringParam('NAME', HTMLName + 'CHK');
      AddStringParam('id', HTMLName + '_CHK_'+IntToStr(i+1));
      AddStringParam('VALUE', IntToStr(i));

      Add(iif((not Enabled) or (not Editable) or (EnabledItems.Items[i] = 0) , 'DISABLED'));

      AddStringParam('onClick', HTMLName + 'RadioClick(' + IntToStr(i) + ',true);');
    end;

    with Contents.AddTag('SPAN') do
    begin
      s:='if (document.getElementById(''' + HTMLName +'_CHK_' + IntToStr(i+1) + ''').disabled) { return false;} else { ' +
        HTMLName + 'RadioClick(' + IntToStr(i) + ',false); }';
      AddStringParam('OnClick', s);
      //Contents.AddText(Items.Strings[i]);
      Contents.AddText(ReplaceInput(i));
    end;
end;


function TmeTIWAdvRadioGroup.Render(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  i, j: Integer;
  columnItem, itemCount, valueCount, itemsPerCol: integer;
  tempCount, script, colBorder, startupscript, submitclick, ajaxcall: string;
begin

  Result := TIWHTMLTag.CreateTag('DIV'); try

  with Result.Contents.AddTag('FIELDSET') do
  begin

    AddStringParam('style','border:' + IntToStr(BorderWidth)
    + 'px solid ' + ColorToRGBString(BorderColor) + ';width:'
    + IntToStr(Width) + 'px;height:auto;'
    + iif(BackGroundColor <> clNone, 'background-color:' + ColorToRGBString(BackGroundColor) + ';', ''));

    if Caption <> EmptyStr then
    begin
      with Contents.AddTag('LEGEND') do
      begin
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
    Contents.AddText('<TABLE cellspacing=0 cellpadding=4 style="font-size:' + IntToStr(Font.Size) + 'pt;'
      + iif(fsBold in Font.Style, 'font-weight:bold;', '')
      + iif(fsItalic in Font.Style, 'font-style:italic;', '')
      + 'color:' + ColorToRGBString(Font.Color) + ';width:100%;height:auto;">');

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

        Contents.AddText('<TD style="' + colBorder + 'vertical-align:top;width:' + IntToStr(100 div Columns) + '%">');

        if (RadioChecked = EmptyStr) or (RadioUnchecked = EmptyStr)
          or (RadioCheckedDisabled = EmptyStr) or (RadioUncheckedDisabled = EmptyStr) then
          //Workaround. gli elementi disabilitati in async rimangono clicckabili
          //vedi segnalazione wiki 6/8/2013.
          RenderRBMedp(Contents,i)
        else
          RenderRBImage(Contents,i);

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

          if (RadioChecked = EmptyStr) or (RadioUnchecked = EmptyStr)
            or (RadioCheckedDisabled = EmptyStr) or (RadioUncheckedDisabled = EmptyStr) then
          begin
            //Workaround. gli elementi disabilitati in async rimangono clicckabili
            //vedi segnalazione wiki 6/8/2013.
            if i = 0 then
              RenderRBMedp(Contents, j)
            else if Items.Count > j+(i*itemCount) then
              RenderRBMedp(Contents, j+(i*itemCount));
          end
          else
          begin
            if i = 0 then
              RenderRBImage(Contents, j)
            else if Items.Count > j+(i*itemCount) then
              RenderRBImage(Contents, j+(i*itemCount));
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
  except FreeAndNil(Result); raise; end;

  if Values.Count > 0 then
    valueCount := Values.Count
  else
    valueCount := Items.Count;

  //add hidden input
  with Result.Contents.AddTag('INPUT') do
  begin
    AddStringParam('TYPE', 'hidden');
    AddStringParam('NAME', HTMLName);
    AddStringParam('ID', HTMLName + '_INPUT');
    AddStringParam('VALUE', IntToStr(ItemIndex));
  end;

  submitclick := '';
  ajaxcall := '';
  if Assigned(OnClick) then
    submitclick := 'SubmitClick('#39 + HTMLName + #39','''',false);'#13;

  if Assigned(OnAsyncClick) then
  begin
    ajaxcall := 'processAjaxEvent(''onClick'', '
      + HTMLControlImplementation.IWCLName
      + ',''' + HTMLName + '.' + 'DoOnAsyncClick' + ''','
      + 'true' + ', null, '
      + 'true' + ');';

    submitclick := '';
  end;

  GGetWebApplicationThreadVar.RegisterCallBack(HTMLName+'.DoOnAsyncClick', DoOnAsyncClick);

  if (RadioChecked = EmptyStr) or (RadioUnchecked = EmptyStr)
  or (RadioCheckedDisabled = EmptyStr) or (RadioUncheckedDisabled = EmptyStr) then
  begin
    script := script
     + '<script>'#13
     + 'var ' + HTMLName + 'Index = ' + IntToStr(ItemIndex) + ';'#13
     + 'function ' + HTMLName + 'RadioClick(index,chk)'#13
     + '{'#13;

     script := script
      + '  if (!containsName("'+HTMLName+'")) {'#13
      + ' 	 window.ChangedControls += "'+HTMLName+',";'#13
      + '}'#13;

    script := script
     + '  var ctrl = FindElem(''' + HTMLName + '_CHK_''+(index+1));'#13
     + '  if (!chk) {'#13
//     + '    ctrl.checked = !ctrl.checked;'#13
     + '    ctrl.checked = true;'#13
     + '  }'#13
     + ''#13
     + '  ' + HTMLName + 'Index = index;'#13
     + '  var hi = FindElem(''' + HTMLName + '_INPUT'');'#13
     + '  hi.value = ' + HTMLName +'Index;'#13
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
     + 'var ' + HTMLName + 'Index = ' + IntToStr(ItemIndex) + ';'#13
     + 'function ' + HTMLName + 'RadioClick(index)'#13
     + '{'#13;

     script := script
      + '  if (!containsName("'+HTMLName+'")) {'#13
      + ' 	 window.ChangedControls += "'+HTMLName+',";'#13
      + '}'#13;

    script := script
     + ' if (index != ' + HTMLName + 'Index)'#13
     + ' {'#13
     + '  var ctrl = FindElem(''' + HTMLName +'_CHK_''+(index+1));'#13
     + '  ctrl.src = ctrl.src.replace("' + RadioUnChecked + '", "' + RadioChecked + '");'#13
     + '  if (' + HTMLName + 'Index > -1)'#13
     + '  {'#13
     + '    ctrl = FindElem(''' + HTMLName +'_CHK_''+(' + HTMLName + 'Index+1));'#13
     + '    ctrl.src = ctrl.src.replace("' + RadioChecked + '", "' + RadioUnChecked + '");'#13
     + '  }'#13
     + ''#13
     + '  ' + HTMLName + 'Index = index;'#13
     + '  var hi = FindElem(''' + HTMLName + '_INPUT'');'#13
     + '  hi.value = ' + HTMLName +'Index;'#13
     + ' }'#13
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

   + '  if (hi.value.indexOf("|") > 0)'#13
   + '  {'#13
   + '    var shi = hi.value.split("|");'#13
   + '    hi.value = shi[0];'#13
   + '  }'#13

   + '  hi.value += "|";'#13

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

   startupscript := HTMLName + 'SetCustomValues();';

  TIWComponent40Context(AContext).AddToInitProc(startupscript + EOL);

  Result.Contents.AddText(script);
end;

end.

unit reg_meIW15Components;

interface

uses
  Classes, Graphics, ToolsAPI, SysUtils, IWBaseControl,
  meIWActiveX, meIWApplet, meIWBaseSilverlight, meIWButton, meIWCalendar,
  meIWCheckBox, meIWComboBox, meIWDBCheckBox, meIWDBComboBox, meIWDBEdit,
  meIWDBGrid, meIWDBImage, meIWDBLabel, meIWDBListBox,
  meIWDBLookupComboBox, meIWDBLookupListBox, meIWDBMemo, meIWDBNavigator,
  meIWDBRadioGroup, meIWDBText, meIWEdit, meIWFlash, meIWGrid,
  meIWHRule, meIWImage, meIWImageButton, meIWImageFile, meIWImageList,meIWLabel, meIWLink,
  meIWList, meIWListBox, meIWMemo, meIWMenu, meIWMPEG, meIWOrderedListBox,
  meIWProgressBar, meIWQuickTime, meIWRadioButton, meIWRadioGroup, meIWRectangle,
  meIWRegion, meIWSilverlightVideo, meIWTabControl, meIWText, meIWTimeEdit,
  meIWTimer, meIWTreeView, meIWURL, meIWURLWindow,
  meTIWAdvCheckGroup, meTIWAdvRadioGroup, meTIWCheckListBox,meIWFileUploader,
  meIWImageListCache;

resourcestring
  NOME_PACKAGE = 'Componenti MEDP standard per IW 15.0.17';
  COMPILATO_IL = 'Compilato il %s %s';
  DATA_COMPILAZIONE = '26/11/2018';
  ORA_COMPILAZIONE = '12:10';

procedure AggiungiInSplashScreen;
procedure Register;

implementation

procedure AggiungiInSplashScreen;
var
  Icona:TBitmap;
begin
  Icona:=TBitmap.Create;
  try
    Icona.LoadFromResourceName(HInstance,'ICONA_SPLASH');
    SplashScreenServices.AddPluginBitmap(NOME_PACKAGE,Icona.Handle,False,
                                         Format(COMPILATO_IL,[DATA_COMPILAZIONE,ORA_COMPILAZIONE]));
  finally
    Icona.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('MEdp IW', [TmeIWActiveX]);
  RegisterComponents('MEdp IW', [TmeIWApplet]);
  RegisterComponents('MEdp IW', [TmeIWBaseSilverlight]);
  RegisterComponents('MEdp IW', [TmeIWButton]);
  RegisterComponents('MEdp IW', [TmeIWCalendar]);
  RegisterComponents('MEdp IW', [TmeIWCheckBox]);
  RegisterComponents('MEdp IW', [TmeIWComboBox]);
  RegisterComponents('MEdp IW', [TmeIWDBCheckBox]);
  RegisterComponents('MEdp IW', [TmeIWDBComboBox]);
  RegisterComponents('MEdp IW', [TmeIWDBEdit]);
  RegisterComponents('MEdp IW', [TmeIWDBGrid]);
  RegisterComponents('MEdp IW', [TmeIWDBImage]);
  RegisterComponents('MEdp IW', [TmeIWDBLabel]);
  RegisterComponents('MEdp IW', [TmeIWDBListbox]);
  RegisterComponents('MEdp IW', [TmeIWDBLookupComboBox]);
  RegisterComponents('MEdp IW', [TmeIWDBLookupListBox]);
  RegisterComponents('MEdp IW', [TmeIWDBMemo]);
  RegisterComponents('MEdp IW', [TmeIWDBNavigator]);
  RegisterComponents('MEdp IW', [TmeIWDBRadioGroup]);
  RegisterComponents('MEdp IW', [TmeIWDBText]);
  RegisterComponents('MEdp IW', [TmeIWEdit]);
  RegisterComponents('MEdp IW', [TmeIWFlash]);
  RegisterComponents('MEdp IW', [TmeIWGrid]);
  RegisterComponents('MEdp IW', [TmeIWHRule]);
  RegisterComponents('MEdp IW', [TmeIWImage]);
  RegisterComponents('MEdp IW', [TmeIWImageButton]);
  RegisterComponents('MEdp IW', [TmeIWImageFile]);
  RegisterComponents('MEdp IW', [TmeIWImageList]);
  RegisterComponents('MEdp IW', [TmeIWLabel]);
  RegisterComponents('MEdp IW', [TmeIWLink]);
  RegisterComponents('MEdp IW', [TmeIWList]);
  RegisterComponents('MEdp IW', [TmeIWListbox]);
  RegisterComponents('MEdp IW', [TmeIWMemo]);
  RegisterComponents('MEdp IW', [TmeIWMenu]);
  RegisterComponents('MEdp IW', [TmeIWMPEG]);
  RegisterComponents('MEdp IW', [TmeIWOrderedListbox]);
  RegisterComponents('MEdp IW', [TmeIWProgressBar]);
  RegisterComponents('MEdp IW', [TmeIWQuickTime]);
  RegisterComponents('MEdp IW', [TmeIWRadioButton]);
  RegisterComponents('MEdp IW', [TmeIWRadioGroup]);
  RegisterComponents('MEdp IW', [TmeIWRectangle]);
  RegisterComponents('MEdp IW', [TmeIWRegion]);
  RegisterComponents('MEdp IW', [TmeIWSilverlightVideo]);
  RegisterComponents('MEdp IW', [TmeIWTabControl]);
  RegisterComponents('MEdp IW', [TmeIWText]);
  RegisterComponents('MEdp IW', [TmeIWTimeEdit]);
  RegisterComponents('MEdp IW', [TmeIWTimer]);
  RegisterComponents('MEdp IW', [TmeIWTreeView]);
  RegisterComponents('MEdp IW', [TmeIWURL]);
  RegisterComponents('MEdp IW', [TmeIWURLWindow]);
  RegisterComponents('MEdp IW', [TmeIWFileUploader]);
  RegisterComponents('MEdp IW', [TmeIWImageListCache]);

  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvCheckGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvRadioGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCheckListBox]);
end;

initialization
  AggiungiInSplashScreen;

end.

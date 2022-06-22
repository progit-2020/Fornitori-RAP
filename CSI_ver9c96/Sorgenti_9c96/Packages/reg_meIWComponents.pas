unit reg_meIWComponents;

interface

uses
  Classes, IWDsnPaint, IWDsnPaintHandlers, IWBaseControl,
  meIWActiveX, meIWApplet, meIWBaseSilverlight, meIWButton, meIWCalendar,
  meIWCheckBox, meIWComboBox, meIWDBCheckBox, meIWDBComboBox, meIWDBEdit,
  meIWDBFile, meIWDBGrid, meIWDBImage, meIWDBLabel, meIWDBListBox,
  meIWDBLookupComboBox, meIWDBLookupListBox, meIWDBMemo, meIWDBNavigator,
  meIWDBRadioGroup, meIWDBText, meIWEdit, meIWFile, meIWFlash, meIWGrid,
  meIWHRule, meIWImage, meIWImageButton, meIWImageFile, meIWImageList,meIWLabel, meIWLink,
  meIWList, meIWListBox, meIWMemo, meIWMenu, meIWMPEG, meIWOrderedListBox,
  meIWProgressBar, meIWQuickTime, meIWRadioButton, meIWRadioGroup, meIWRectangle,
  meIWRegion, meIWSilverlightVideo, meIWTabControl, meIWText, meIWTimeEdit,
  meIWTimer, meIWTreeView, meIWURL, meIWURLWindow, meTIWAdvCheckGroup,
  meTIWAdvDateEdit, meTIWAdvDetailWebGrid, meTIWAdvEdit, meTIWAdvImage,
  meTIWAdvImageButton, meTIWAdvLUEdit, meTIWAdvRadioGroup, meTIWAdvSelector,
  meTIWAdvSpinEdit, meTIWAdvTimeEdit, meTIWAdvToolButton, meTIWAdvTreeView,
  meTIWAdvWebGrid, meTIWAutoFormFill, meTIWCalculatingLabel, meTIWCalendar,
  meTIWCaptchaImage, meTIWCCExpEdit, meTIWCCNumEdit, meTIWCheckList,
  meTIWCheckListBox, meTIWClientCode, meTIWClientDebugOut, meTIWClientWatch,
  meTIWClock, meTIWColorComboBox, meTIWColorPicker, meTIWComboListLink,
  meTIWCountryComboBox, meTIWDateLabel, meTIWDatePicker, meTIWDateSelector,
  meTIWDBAdvCheckGroup, meTIWDBAdvDateEdit, meTIWDBAdvDetailWebGrid,
  meTIWDBAdvEdit, meTIWDBAdvLUEdit, meTIWDBAdvRadioGroup, meTIWDBAdvSpinEdit,
  meTIWDBAdvTimeEdit, meTIWDBAdvWebGrid, meTIWDBCalendar, meTIWDBCountryComboBox,
  meTIWDBDatePicker, meTIWDBHTMLEdit, meTIWDBHTMLLabel, meTIWDBScrollPanel,
  meTIWDBSmartPanel, meTIWDBStateComboBox, meTIWDocumentPopupMenu,
  meTIWEditListLink, meTIWEmailEdit, meTIWExchangeBar, meTIWFadeImage,
  meTIWFilePicker, meTIWGradient, meTIWGradientLabel, meTIWHelpTip,
  meTIWHotSpotImage, meTIWHTMLCheckBox, meTIWHTMLEdit, meTIWHTMLLabel,
  meTIWHTMLList, meTIWHTMLRadioGroup, meTIWListLink, meTIWListOrganizer,
  meTIWMainMenu, meTIWMonthPlanner, meTIWNoSpamEmailLabel,
  meTIWOutlookBar, meTIWPaintBox, meTIWPersistentEdit, meTIWPopupMenuButton,
  meTIWPopupMenuLabel, meTIWRadioButton, meTIWScrollBarColors, meTIWScrollBarPersistence,
  meTIWScrollPanel, meTIWSideMenu, meTIWSideNavBar, meTIWSmartPanel, meTIWSmoothGauge,
  meTIWSmoothLabel, meTIWSmoothLEDLabel, meTIWSmoothTimeLine, meTIWStateComboBox,
  meTIWStaticMenu, meTIWTextAreaLimiter, meTIWTickerPanel;

procedure Register;

implementation

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
  RegisterComponents('MEdp IW', [TmeIWDBFile]);
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
  RegisterComponents('MEdp IW', [TmeIWFile]);
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
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvCheckGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvDateEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvDetailWebGrid]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvImage]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvImageButton]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvLUEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvRadioGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvSelector]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvSpinEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvTimeEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvToolButton]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvTreeView]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAdvWebGrid]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWAutoFormFill]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCalculatingLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCalendar]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCaptchaImage]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCCExpEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCCNumEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCheckList]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCheckListBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWClientCode]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWClientDebugOut]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWClientWatch]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWClock]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWColorComboBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWColorPicker]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWComboListLink]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWCountryComboBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDateLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDatePicker]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDateSelector]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvCheckGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvDateEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvDetailWebGrid]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvLUEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvRadioGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvSpinEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvTimeEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBAdvWebGrid]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBCalendar]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBCountryComboBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBDatePicker]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBHTMLEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBHTMLLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBScrollPanel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBSmartPanel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDBStateComboBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWDocumentPopupMenu]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWEditListLink]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWEmailEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWExchangeBar]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWFadeImage]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWFilePicker]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWGradient]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWGradientLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHelpTip]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHotSpotImage]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHTMLCheckBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHTMLEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHTMLLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHTMLList]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWHTMLRadioGroup]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWListLink]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWListOrganizer]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWMainMenu]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWMonthPlanner]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWNoSpamEmailLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWOutlookBar]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWPaintBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWPersistentEdit]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWPopupMenuButton]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWPopupMenuLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWRadioButton]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWScrollBarColors]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWScrollBarPersistence]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWScrollPanel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSideMenu]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSideNavBar]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSmartPanel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSmoothGauge]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSmoothLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSmoothLEDLabel]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWSmoothTimeLine]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWStateComboBox]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWStaticMenu]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWTextAreaLimiter]);
  RegisterComponents('MEdp IW_TMS', [TmeTIWTickerPanel]);
end;

initialization
  IWRegisterPaintHandler('TmeIWButton', TIWPaintHandlerButton);
  IWRegisterPaintHandler('TmeIWCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TmeIWComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TmeIWDBCheckBox', TIWPaintHandlerCheckBox);
  IWRegisterPaintHandler('TmeIWDBComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TmeIWDBEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TmeIWDBFile', TIWPaintHandlerFile);
  IWRegisterPaintHandler('TmeIWDBLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TmeIWDBListbox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TmeIWDBLookupComboBox', TIWPaintHandlerComboBox);
  IWRegisterPaintHandler('TmeIWDBLookupListBox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TmeIWDBMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TmeIWDBNavigator', TIWPaintHandlerDBNavigator);
  //IWRegisterPaintHandler('TmeIWDBRadioGroup', TIWPaintHandlerRadioGroup);
  IWRegisterPaintHandler('TmeIWDBText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TmeIWEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TmeIWFile', TIWPaintHandlerFile);
  IWRegisterPaintHandler('TmeIWHRule', TIWPaintHandlerHRule);
  IWRegisterPaintHandler('TmeIWImage', TIWPaintHandlerImage);
  IWRegisterPaintHandler('TmeIWLabel', TIWPaintHandlerLabel);
  IWRegisterPaintHandler('TmeIWLink', TIWPaintHandlerLink);
  IWRegisterPaintHandler('TmeIWList', TIWPaintHandlerList);
  IWRegisterPaintHandler('TmeIWListbox', TIWPaintHandlerListBox);
  IWRegisterPaintHandler('TmeIWMemo', TIWPaintHandlerMemo);
  IWRegisterPaintHandler('TmeIWProgressBar', TIWPaintHandlerProgressBar);
  IWRegisterPaintHandler('TmeIWRadioButton', TIWPaintHandlerRadioButton);
  IWRegisterPaintHandler('TmeIWRadioGroup', TIWPaintHandlerRadioGroup);
  IWRegisterPaintHandler('TmeIWRectangle', TIWPaintHandlerRectangle);
  IWRegisterPaintHandler('TmeIWRegion', TIWPaintHandlerRegion);
  IWRegisterPaintHandler('TmeIWText', TIWPaintHandlerText);
  IWRegisterPaintHandler('TmeIWTimeEdit', TIWPaintHandlerEdit);
  IWRegisterPaintHandler('TmeIWURL', TIWPaintHandlerLink);

end.

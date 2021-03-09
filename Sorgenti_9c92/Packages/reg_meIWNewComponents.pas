unit reg_meIWNewComponents;

interface

uses
  Classes,
  IWDsnPaint, IWDsnPaintHandlers,
  medpIWDBGrid,
  medpIWTabControl,
  medpIWStatusBar,
  medpIWImageButton,
  medpIWMulticolumnComboBox;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MEdp IW_New', [TmedpIWDBGrid]);
  RegisterComponents('MEdp IW_New', [TmedpIWTabControl]);
  RegisterComponents('MEdp IW_New', [TmedpIWStatusBar]);
  RegisterComponents('MEdp IW_New', [TmedpIWImageButton]);
  RegisterComponents('MEdp IW_New', [TmedpIWMulticolumnComboBox]);

end;

end.

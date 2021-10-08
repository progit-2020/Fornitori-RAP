object A003FDataLavoroBis: TA003FDataLavoroBis
  Left = 389
  Top = 322
  HelpContext = 200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Data di lavoro'
  ClientHeight = 72
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    HelpContext = 200
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 116
    Top = 40
    Width = 75
    Height = 25
    HelpContext = 200
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 8
    Width = 186
    Height = 21
    Date = 36735.000000000000000000
    Time = 36735.000000000000000000
    TabOrder = 0
    OnCloseUp = DateTimePicker1CloseUp
  end
end

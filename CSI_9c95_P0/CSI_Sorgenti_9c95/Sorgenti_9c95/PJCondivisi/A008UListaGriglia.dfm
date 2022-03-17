object A008FListaGriglia: TA008FListaGriglia
  Left = 199
  Top = 45
  BorderIcons = [biSystemMenu]
  ClientHeight = 244
  ClientWidth = 221
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
  object Lista: TListBox
    Left = 0
    Top = 0
    Width = 221
    Height = 211
    Align = alClient
    DoubleBuffered = True
    ExtendedSelect = False
    ItemHeight = 13
    ParentDoubleBuffered = False
    TabOrder = 0
    OnDblClick = ListaDblClick
  end
  object pnlPulsanti: TPanel
    Left = 0
    Top = 211
    Width = 221
    Height = 33
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      221
      33)
    object BitBtn1: TBitBtn
      Left = 17
      Top = 4
      Width = 75
      Height = 25
      Kind = bkOK
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 126
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Kind = bkCancel
      TabOrder = 1
    end
  end
end

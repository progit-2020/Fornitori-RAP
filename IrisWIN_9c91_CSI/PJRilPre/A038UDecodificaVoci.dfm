object A038FDecodificaVoci: TA038FDecodificaVoci
  Left = 330
  Top = 222
  BorderStyle = bsDialog
  Caption = '<A038> Decodifica voci paghe'
  ClientHeight = 373
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 212
    Top = 92
    Width = 86
    Height = 13
    Caption = 'Dal mese di cassa'
  end
  object Label2: TLabel
    Left = 212
    Top = 136
    Width = 79
    Height = 13
    Caption = 'Al mese di cassa'
  end
  object grdVoci: TStringGrid
    Left = 0
    Top = 0
    Width = 201
    Height = 373
    Align = alLeft
    ColCount = 2
    DefaultColWidth = 85
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 212
    Top = 188
    Width = 97
    Height = 25
    Caption = 'Esegui'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
      87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
      330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
      777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
      7777778BBB00007777777778BBB07777777777778BBB07777777}
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 212
    Top = 224
    Width = 97
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 2
  end
  object cmbMeseCassaDa: TComboBox
    Left = 212
    Top = 108
    Width = 97
    Height = 21
    Style = csDropDownList
    TabOrder = 3
  end
  object cmbMeseCassaA: TComboBox
    Left = 212
    Top = 152
    Width = 97
    Height = 21
    Style = csDropDownList
    TabOrder = 4
  end
end

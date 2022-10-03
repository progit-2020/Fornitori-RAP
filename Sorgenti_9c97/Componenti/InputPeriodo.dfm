object frmInputPeriodo: TfrmInputPeriodo
  Left = 0
  Top = 0
  Width = 451
  Height = 40
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object lblInizio: TLabel
    Left = 8
    Top = 12
    Width = 16
    Height = 13
    Caption = 'Dal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblFine: TLabel
    Left = 149
    Top = 12
    Width = 9
    Height = 13
    Caption = 'Al'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtInizio: TMaskEdit
    Left = 33
    Top = 9
    Width = 71
    Height = 21
    Hint = 'Data inizio periodo'
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '  /  /    '
    OnChange = edtDataChange
    OnExit = edtInizioExit
  end
  object edtFine: TMaskEdit
    Left = 164
    Top = 9
    Width = 71
    Height = 21
    Hint = 'Data fine periodo'
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '  /  /    '
    OnChange = edtDataChange
    OnDblClick = edtFineDblClick
  end
  object btnIndietro: TBitBtn
    Left = 282
    Top = 8
    Width = 23
    Height = 22
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00400040004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000400040004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00400040004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnIndietroClick
  end
  object btnAvanti: TBitBtn
    Left = 304
    Top = 8
    Width = 23
    Height = 22
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000401F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040004000401F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00400040004000401F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000400040004000401F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00400040004000401F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040004000401F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C004000401F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnAvantiClick
  end
  object btnDataInizio: TBitBtn
    Left = 104
    Top = 8
    Width = 23
    Height = 22
    Hint = 'Calendario'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FFFFFF
      FFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B
      7BFFFFFFFFFFFF0000000000000000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B00
      00FFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF0000000000007B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B000000000000FFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFF
      FFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF0000000000000000FF
      FFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B
      7B0000FFFFFFFF0000000000007B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B000000000000FFFFFF
      FFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B
      7BFFFFFFFFFFFF0000000000000000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B00
      00FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF0000000000007B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7BFF
      FFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF000000000000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B
      7B0000FFFFFFFF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000FF0000
      FF0000FF0000FF0000FF0000BDBDBDBDBDBDBDBDBDBDBDBDFF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnDataInizioClick
  end
  object btnDataFine: TBitBtn
    Left = 235
    Top = 8
    Width = 23
    Height = 22
    Hint = 'Calendario'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FFFFFF
      FFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B
      7BFFFFFFFFFFFF0000000000000000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B00
      00FFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF0000000000007B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B000000000000FFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFF
      FFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF0000000000000000FF
      FFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B
      7B0000FFFFFFFF0000000000007B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B000000000000FFFFFF
      FFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B
      7BFFFFFFFFFFFF0000000000000000FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B00
      00FFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF0000000000007B7B7B
      7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B7B
      7B7B7B7B7B7B7B000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B7BFF
      FFFFFFFFFF7B7B7BFFFFFFFFFFFF7B7B7BFFFFFFFFFFFF000000000000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF7B7B7B0000FFFFFFFF7B7B7B0000FFFFFFFF7B7B
      7B0000FFFFFFFF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000FF0000
      FF0000FF0000FF0000FF0000BDBDBDBDBDBDBDBDBDBDBDBDFF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnDataFineClick
  end
end

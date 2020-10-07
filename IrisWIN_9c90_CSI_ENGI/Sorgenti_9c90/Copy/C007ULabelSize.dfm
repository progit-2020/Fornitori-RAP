object C007FLabelSize: TC007FLabelSize
  Left = 137
  Top = 174
  BorderStyle = bsDialog
  Caption = 'Dimensioni del dato'
  ClientHeight = 116
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Larghezza:'
  end
  object Label2: TLabel
    Left = 12
    Top = 34
    Width = 37
    Height = 13
    Caption = 'Altezza:'
  end
  object Label3: TLabel
    Left = 12
    Top = 66
    Width = 37
    Height = 13
    Caption = 'Sinistra:'
  end
  object Label4: TLabel
    Left = 12
    Top = 92
    Width = 21
    Height = 13
    Caption = 'Alto:'
  end
  object BitBtn1: TBitBtn
    Left = 188
    Top = 50
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 188
    Top = 84
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object MaskEdit1: TMaskEdit
    Left = 108
    Top = 4
    Width = 57
    Height = 21
    EditMask = '999999;1;_'
    MaxLength = 6
    TabOrder = 2
    Text = '      '
    OnChange = SpinEdit1Change
  end
  object MaskEdit2: TMaskEdit
    Left = 108
    Top = 30
    Width = 57
    Height = 21
    EditMask = '999999;1;_'
    MaxLength = 6
    TabOrder = 3
    Text = '      '
    OnChange = SpinEdit2Change
  end
  object MaskEdit3: TMaskEdit
    Left = 108
    Top = 62
    Width = 57
    Height = 21
    EditMask = '999999;1;_'
    MaxLength = 6
    TabOrder = 4
    Text = '      '
    OnChange = MaskEdit3Change
  end
  object MaskEdit4: TMaskEdit
    Left = 108
    Top = 88
    Width = 57
    Height = 21
    EditMask = '999999;1;_'
    MaxLength = 6
    TabOrder = 5
    Text = '      '
    OnChange = MaskEdit4Change
  end
end

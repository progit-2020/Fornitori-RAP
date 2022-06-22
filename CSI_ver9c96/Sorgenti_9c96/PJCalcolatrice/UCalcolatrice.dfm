object Form1: TForm1
  Left = 233
  Top = 278
  BorderStyle = bsDialog
  Caption = 'SuperCalc'
  ClientHeight = 148
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 92
    Width = 165
    Height = 21
    TabOrder = 0
  end
  object btnAdd: TButton
    Left = 44
    Top = 28
    Width = 25
    Height = 25
    Caption = '+'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnSub: TButton
    Left = 72
    Top = 28
    Width = 25
    Height = 25
    Caption = '-'
    TabOrder = 2
    OnClick = btnSubClick
  end
  object btnUguale: TButton
    Left = 156
    Top = 28
    Width = 25
    Height = 25
    Caption = '='
    TabOrder = 3
    OnClick = btnUgualeClick
  end
  object btnAzzera: TButton
    Left = 16
    Top = 28
    Width = 25
    Height = 25
    Caption = 'C'
    TabOrder = 4
    OnClick = btnAzzeraClick
  end
  object btnMolt: TButton
    Left = 100
    Top = 28
    Width = 25
    Height = 25
    Caption = '*'
    TabOrder = 5
    OnClick = btnMoltClick
  end
  object btnDiv: TButton
    Left = 128
    Top = 28
    Width = 25
    Height = 25
    Caption = '/'
    TabOrder = 6
    OnClick = btnDivClick
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 55
    Width = 165
    Height = 31
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Ore'
      'Decimali')
    TabOrder = 7
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 4
    Width = 133
    Height = 17
    Caption = 'sempre in primo piano'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object edtRisultato: TEdit
    Left = 16
    Top = 120
    Width = 165
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
end

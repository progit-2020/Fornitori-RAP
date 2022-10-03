object C001FSizeStampa: TC001FSizeStampa
  Left = 150
  Top = 210
  Width = 284
  Height = 145
  HelpContext = 1001200
  BorderIcons = [biHelp]
  Caption = '<C001> Dimensionamento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnNo: TButton
    Left = 169
    Top = 84
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annulla'
    ModalResult = 2
    TabOrder = 0
  end
  object Button5: TButton
    Left = 33
    Top = 84
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 137
    Height = 79
    Caption = 'Posizione'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 47
      Height = 13
      Caption = 'Sinistra:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 28
      Top = 52
      Width = 27
      Height = 13
      Caption = 'Alto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditLeft: TEdit
      Left = 56
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 0
      OnChange = EditLeftChange
      OnKeyPress = EditLeftKeyPress
    end
    object EditTop: TEdit
      Left = 56
      Top = 48
      Width = 57
      Height = 21
      TabOrder = 1
      OnChange = EditTopChange
      OnKeyPress = EditLeftKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 138
    Top = 0
    Width = 137
    Height = 79
    Caption = 'Dimensione'
    TabOrder = 3
    object Label3: TLabel
      Left = 6
      Top = 20
      Width = 63
      Height = 13
      Caption = 'Larghezza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 23
      Top = 52
      Width = 46
      Height = 13
      Caption = 'Altezza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditWidth: TEdit
      Left = 70
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 0
      OnChange = EditWidthChange
      OnKeyPress = EditLeftKeyPress
    end
    object EditHeight: TEdit
      Left = 70
      Top = 48
      Width = 57
      Height = 21
      TabOrder = 1
      OnChange = EditHeightChange
      OnKeyPress = EditLeftKeyPress
    end
  end
end

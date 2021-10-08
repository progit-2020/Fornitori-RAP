object A058FValidaAssenze: TA058FValidaAssenze
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = '<A058> Validazione Assenze'
  ClientHeight = 158
  ClientWidth = 181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlue
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBottom: TPanel
    Left = 0
    Top = 117
    Width = 181
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BtnConferma: TSpeedButton
      Left = 8
      Top = 6
      Width = 80
      Height = 27
      Caption = 'Conferma'
      OnClick = BtnConfermaClick
    end
    object BtnAnnulla: TSpeedButton
      Left = 94
      Top = 6
      Width = 80
      Height = 27
      Caption = 'Annulla'
      OnClick = BtnAnnullaClick
    end
  end
  object PnlTop: TPanel
    Left = 0
    Top = 0
    Width = 181
    Height = 117
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 35
      Width = 39
      Height = 13
      Caption = 'Da Data'
    end
    object Label2: TLabel
      Left = 103
      Top = 35
      Width = 33
      Height = 13
      Caption = 'A Data'
    end
    object lblNominativo: TLabel
      Left = 8
      Top = 6
      Width = 63
      Height = 13
      Caption = 'lblNominativo'
    end
    object EdtDataDa: TMaskEdit
      Left = 8
      Top = 49
      Width = 65
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object EdtDataA: TMaskEdit
      Left = 103
      Top = 49
      Width = 65
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 73
      Width = 162
      Height = 38
      Caption = 'Causale'
      TabOrder = 2
      object ChkCaus1: TCheckBox
        Left = 6
        Top = 16
        Width = 97
        Height = 17
        Caption = 'ChkCaus1'
        TabOrder = 0
        OnClick = ChkCaus1Click
      end
      object ChkCaus2: TCheckBox
        Left = 91
        Top = 16
        Width = 67
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 1
        OnClick = ChkCaus2Click
      end
    end
  end
end

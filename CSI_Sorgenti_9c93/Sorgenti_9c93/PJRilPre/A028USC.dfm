object A028FSc: TA028FSc
  Left = 310
  Top = 263
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A028> Conteggi giornalieri'
  ClientHeight = 128
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 54
    Top = 30
    Width = 23
    Height = 13
    Caption = 'Data'
    OnClick = BitBtn1Click
  end
  object EDaData: TMaskEdit
    Left = 54
    Top = 46
    Width = 71
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object BitBtn1: TBitBtn
    Left = 54
    Top = 76
    Width = 85
    Height = 25
    Caption = 'Conteggi'
    Default = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
      73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
      0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
      0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
      0333337F777777737F333308888888880333337F333333337F33330888888888
      03333373FFFFFFFF733333700000000073333337777777773333}
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 334
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 334
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 334
      Height = 24
      ExplicitWidth = 334
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = TfrmSelAnagrafe1btnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = TfrmSelAnagrafe1R003DatianagraficiClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 109
    Width = 334
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object chkRichiesteWeb: TCheckBox
    Left = 167
    Top = 48
    Width = 138
    Height = 17
    Caption = 'Considera richieste web'
    TabOrder = 4
  end
  object BitBtn2: TBitBtn
    Left = 167
    Top = 76
    Width = 85
    Height = 25
    Caption = 'Reset'
    Default = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
      2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
      FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
      FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 5
    OnClick = BitBtn2Click
  end
end

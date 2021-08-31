object A079FAssenzeAuto: TA079FAssenzeAuto
  Left = 504
  Top = 329
  HelpContext = 79000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A079> Inserimento automatico assenze'
  ClientHeight = 149
  ClientWidth = 283
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
  object Label1: TLabel
    Left = 30
    Top = 30
    Width = 19
    Height = 13
    Caption = 'Dal:'
  end
  object Label2: TLabel
    Left = 141
    Top = 30
    Width = 12
    Height = 13
    Caption = 'Al:'
  end
  object BtnEsegui: TBitBtn
    Left = 30
    Top = 80
    Width = 100
    Height = 25
    Caption = '&Esegui'
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BtnEseguiClick
  end
  object BtnClose: TBitBtn
    Left = 141
    Top = 80
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 1
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 114
    Width = 283
    Height = 16
    Align = alBottom
    TabOrder = 2
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 130
    Width = 283
    Height = 19
    Panels = <
      item
        Text = '0 Records'
        Width = 100
      end
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object EDal: TMaskEdit
    Left = 30
    Top = 46
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 4
    Text = '  /  /    '
  end
  object EAl: TMaskEdit
    Left = 141
    Top = 46
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 5
    Text = '  /  /    '
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 283
    Height = 24
    Align = alTop
    TabOrder = 6
    TabStop = True
    ExplicitWidth = 283
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 283
      Height = 24
      ExplicitWidth = 283
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
end

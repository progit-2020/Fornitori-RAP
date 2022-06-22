object B014FViewMemo: TB014FViewMemo
  Left = 348
  Top = 219
  Caption = '<B014> Testo SQL'
  ClientHeight = 265
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 395
    Height = 224
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object pnlAzienda: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 10
      Width = 41
      Height = 13
      Caption = 'Azienda:'
    end
    object dcmbAzienda: TDBLookupComboBox
      Left = 68
      Top = 6
      Width = 145
      Height = 21
      KeyField = 'AZIENDA'
      ListField = 'AZIENDA'
      ListSource = B014FMonitorIntegrazioneDtM.dsrI090
      TabOrder = 0
    end
    object Button1: TButton
      Left = 224
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Visualizza'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end

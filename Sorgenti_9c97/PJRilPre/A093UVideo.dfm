object A093FVideo: TA093FVideo
  Left = 75
  Top = 124
  Caption = '<A093> Visualizzazione log delle operazioni'
  ClientHeight = 396
  ClientWidth = 624
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
  object Splitter2: TSplitter
    Left = 0
    Top = 120
    Width = 624
    Height = 2
    Cursor = crVSplit
    Align = alTop
  end
  object grdAnagra: TDBGrid
    Left = 0
    Top = 0
    Width = 624
    Height = 120
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clGreen
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 122
    Width = 624
    Height = 274
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 365
      Top = 0
      Width = 2
      Height = 274
      Align = alRight
      ExplicitHeight = 281
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 365
      Height = 274
      Align = alClient
      DataSource = A093FOperazioniDtM1.D000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clRed
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object grdDettaglio: TDBGrid
      Left = 367
      Top = 0
      Width = 257
      Height = 274
      Align = alRight
      DataSource = A093FOperazioniDtM1.D001
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 140
    Top = 8
    object Datianagrafici1: TMenuItem
      Caption = 'Dati anagrafici'
      OnClick = Datianagrafici1Click
    end
  end
end

object P555FElencoDipendenti: TP555FElencoDipendenti
  Left = 0
  Top = 0
  Caption = '<P555> Elenco Dipendenti'
  ClientHeight = 382
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 106
  TextHeight = 13
  object DbGrdDipendenti: TDBGrid
    Left = 0
    Top = 80
    Width = 587
    Height = 239
    Align = alClient
    Ctl3D = True
    DataSource = P555FContoAnnualeDtM.dsrDip
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgMultiSelect]
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = MnuDipendenti
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 319
    Width = 587
    Height = 44
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 264
      Top = 9
      Width = 81
      Height = 27
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 587
    Height = 80
    Align = alTop
    TabOrder = 2
    object lblAnno: TLabel
      Left = 11
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblCodTabella: TLabel
      Left = 104
      Top = 14
      Width = 41
      Height = 13
      Caption = 'Tabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 11
      Top = 40
      Width = 28
      Height = 13
      Caption = 'Riga'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 292
      Top = 40
      Width = 45
      Height = 13
      Caption = 'Colonna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblTabella: TLabel
      Left = 216
      Top = 9
      Width = 364
      Height = 28
      AutoSize = False
      Caption = 'lblTabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lblRiga: TLabel
      Left = 46
      Top = 40
      Width = 229
      Height = 28
      AutoSize = False
      Caption = 'lblRiga'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lblColonna: TLabel
      Left = 345
      Top = 40
      Width = 235
      Height = 28
      AutoSize = False
      Caption = 'lblColonna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object edtAnno: TEdit
      Left = 47
      Top = 11
      Width = 46
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtTabella: TEdit
      Left = 152
      Top = 11
      Width = 61
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 363
    Width = 587
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object MnuDipendenti: TPopupMenu
    Left = 392
    Top = 122
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Copia1: TMenuItem
      Caption = 'Copia'
      OnClick = CopiaInExcelClick
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
end

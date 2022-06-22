object A130FOraLegaleSolare: TA130FOraLegaleSolare
  Left = 0
  Top = 0
  HelpContext = 130000
  Caption = '<A130> Cambio ora legale/solare'
  ClientHeight = 373
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 354
    Width = 627
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 205
      end>
    SimpleText = '0 Records'
  end
  object Panel1: TPanel
    Left = 0
    Top = 321
    Width = 627
    Height = 33
    Align = alBottom
    TabOrder = 0
    object btnChiudi: TBitBtn
      Left = 323
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 3
    end
    object btnSalva: TBitBtn
      Left = 210
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Salva su file'
      Enabled = False
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000000000000000E03D
        00001F7C1F7C0000E03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03D
        00001F7C1F7C0000E03DE03D00000000000000000000000000000000E03DE03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E00000000
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000F75E
        00001F7C1F7C0000000000000000000000000000000000000000000000000000
        00001F7C1F7C}
      TabOrder = 2
      OnClick = btnSalvaClick
    end
    object btnVisualizza: TButton
      Left = 10
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Visualizza'
      TabOrder = 0
      OnClick = btnVisualizzaClick
    end
    object btnModifica: TBitBtn
      Left = 96
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Modifica'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 1
      OnClick = btnModificaClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 24
    Width = 627
    Height = 94
    Align = alTop
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 87
      Top = 19
      Width = 15
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 87
      Top = 59
      Width = 15
      Height = 22
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 315
      Top = 19
      Width = 15
      Height = 22
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton3Click
    end
    object Orologi: TLabel
      Left = 186
      Top = 4
      Width = 33
      Height = 13
      Caption = 'Orologi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 26
      Top = 4
      Width = 48
      Height = 13
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 26
      Top = 44
      Width = 41
      Height = 13
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 116
      Top = 4
      Width = 42
      Height = 13
      Caption = 'Dalle ore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 118
      Top = 44
      Width = 35
      Height = 13
      Caption = 'Alle ore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgpLegsol: TRadioGroup
      Left = 336
      Top = 8
      Width = 209
      Height = 81
      Align = alCustom
      Caption = 'Modifica richiesta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Legale -> Solare (un'#39'ora indietro)'
        'Solare -> Legale (un'#39'ora in avanti)')
      ParentFont = False
      TabOrder = 5
      OnClick = edtDatadaChange
    end
    object edtDatada: TMaskEdit
      Left = 24
      Top = 20
      Width = 63
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnChange = edtDatadaChange
    end
    object edtDataa: TMaskEdit
      Left = 24
      Top = 60
      Width = 63
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnChange = edtDatadaChange
    end
    object edtOrada: TMaskEdit
      Left = 116
      Top = 20
      Width = 39
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '00.00'
      OnChange = edtDatadaChange
      OnKeyDown = edtOradaKeyDown
    end
    object edtOraa: TMaskEdit
      Left = 119
      Top = 63
      Width = 38
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 3
      Text = '23.59'
      OnChange = edtDatadaChange
      OnKeyDown = edtOraaKeyDown
    end
    object edtOrologi: TEdit
      Left = 184
      Top = 20
      Width = 130
      Height = 21
      TabOrder = 4
      OnChange = edtDatadaChange
    end
    object rgrpPresMens: TRadioGroup
      Left = 184
      Top = 43
      Width = 146
      Height = 46
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Timbrature di presenza'
        'Timbrature di mensa')
      ParentFont = False
      TabOrder = 6
      OnClick = rgrpPresMensClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 627
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 627
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 627
      Height = 24
      ExplicitWidth = 627
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 118
    Width = 627
    Height = 186
    Align = alClient
    TabOrder = 4
    object dgrdQuery: TDBGrid
      Left = 1
      Top = 1
      Width = 625
      Height = 184
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 304
    Width = 627
    Height = 17
    Align = alBottom
    TabOrder = 5
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 184
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Copia1: TMenuItem
      Caption = 'Copia'
      OnClick = Copiainexcel1Click
    end
    object Copiainexcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copiainexcel1Click
    end
  end
  object svdSalva: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'File testo|*.txt|File excel|*.xls'
    Left = 28
    Top = 284
  end
end

inherited A012FCalendari: TA012FCalendari
  Left = 188
  Top = 143
  HelpContext = 12000
  Caption = '<A012> Calendari'
  ClientHeight = 272
  ClientWidth = 494
  ExplicitWidth = 502
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 254
    Width = 494
    ExplicitTop = 254
    ExplicitWidth = 494
  end
  inherited Panel1: TToolBar
    Width = 494
    ExplicitWidth = 494
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 494
    Height = 225
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 4
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 60
      Top = 4
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 4
      Top = 49
      Width = 63
      Height = 13
      Caption = 'Num. gg lav.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ECodice: TDBEdit
      Left = 4
      Top = 16
      Width = 49
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      TabOrder = 0
    end
    object EDescrizione: TDBEdit
      Left = 60
      Top = 16
      Width = 253
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 69
      Width = 99
      Height = 145
      Caption = 'Giorni lavorativi'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      object DBCheckBox1: TDBCheckBox
        Left = 8
        Top = 16
        Width = 70
        Height = 17
        Caption = 'Luned'#236
        DataField = 'Lunedi'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox2: TDBCheckBox
        Left = 8
        Top = 34
        Width = 70
        Height = 17
        Caption = 'Marted'#236
        DataField = 'Martedi'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox3: TDBCheckBox
        Left = 8
        Top = 52
        Width = 70
        Height = 17
        Caption = 'Mercoled'#236
        DataField = 'Mercoledi'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox4: TDBCheckBox
        Left = 8
        Top = 70
        Width = 70
        Height = 17
        Caption = 'Gioved'#236
        DataField = 'Giovedi'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox5: TDBCheckBox
        Left = 8
        Top = 88
        Width = 70
        Height = 17
        Caption = 'Venerd'#236
        DataField = 'Venerdi'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox6: TDBCheckBox
        Left = 8
        Top = 106
        Width = 70
        Height = 17
        Caption = 'Sabato'
        DataField = 'Sabato'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox7: TDBCheckBox
        Left = 8
        Top = 124
        Width = 70
        Height = 17
        Caption = 'Domenica'
        DataField = 'Domenica'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object GroupBox2: TGroupBox
      Left = 320
      Top = 69
      Width = 163
      Height = 145
      Caption = 'Generazione calendari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 41
        Height = 13
        Caption = 'Da data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 87
        Top = 16
        Width = 34
        Height = 13
        Caption = 'A data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DaData: TMaskEdit
        Left = 8
        Top = 30
        Width = 69
        Height = 21
        EditMask = '!99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
      end
      object AData: TMaskEdit
        Left = 87
        Top = 30
        Width = 69
        Height = 21
        EditMask = '!99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
      end
      object Genera: TBitBtn
        Left = 8
        Top = 82
        Width = 148
        Height = 25
        Caption = '&Genera Calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
          8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
          3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
          FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
          FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
        ParentFont = False
        TabOrder = 2
        OnClick = GeneraClick
      end
      object Visualizza: TBitBtn
        Left = 8
        Top = 112
        Width = 148
        Height = 25
        Caption = '&Visualizza Calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000FFFFFF00
          0000FFFFFF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFF000000FFFFFF000000000000000000FFFFFF0000007B7B7B000000FFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFF00
          0000FFFFFF0000007B7B7B000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFF000000FFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
          0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 3
        OnClick = Visualizza1Click
      end
    end
    object grpFestivitaAggiuntive: TGroupBox
      Left = 110
      Top = 69
      Width = 203
      Height = 145
      Caption = 'Festivit'#224' aggiuntive'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 5
      object grdFestivitaAggiuntive: TDBGrid
        Left = 2
        Top = 15
        Width = 199
        Height = 128
        Align = alClient
        DataSource = A012FCalendariDtM1.dsrT013
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgTitleClick]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object dchkIgnoraFestivita: TDBCheckBox
      Left = 157
      Top = 48
      Width = 156
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Ignora festivit'#224' automatiche'
      DataField = 'IGNORAFEST_AUTO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dedtNGGLav: TDBEdit
      Left = 75
      Top = 45
      Width = 28
      Height = 21
      DataField = 'NUMGG_LAV'
      DataSource = DButton
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 168
    Top = 24
    object Calendario1: TMenuItem
      Caption = 'Ca&lendario'
      object Visualizza1: TMenuItem
        Caption = '&Visualizza'
        OnClick = Visualizza1Click
      end
    end
  end
  inherited DButton: TDataSource
    Left = 256
    Top = 20
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 216
    Top = 24
  end
  object Timer1: TTimer
    Left = 462
  end
end

object C001FFiltroTabelle: TC001FFiltroTabelle
  Left = 179
  Top = 212
  HelpContext = 1001000
  Caption = '<C001> Stampa tabelle'
  ClientHeight = 348
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 753
    Height = 281
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = DBGrid1ColEnter
  end
  object Panel2: TPanel
    Left = 0
    Top = 281
    Width = 753
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOrdineCampiOld: TSpeedButton
      Left = 610
      Top = 1
      Width = 128
      Height = 22
      Hint = 'Filtro sui dati'
      AllowAllUp = True
      GroupIndex = 1
      Caption = '&Impostazione dati'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
        3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
        700077337F3333373777887007333337007733F773F333337733700070333333
        077037773733333F7F37703707333300080737F373333377737F003333333307
        78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
        078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
        70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
        3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
        33337F73FF737773333307800077033333337337773373333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnOrdineCampiOldClick
    end
    object btnStampa: TSpeedButton
      Left = 336
      Top = 1
      Width = 128
      Height = 22
      Caption = 'Stampa'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      OnClick = btnStampaClick
    end
    object btnStampante: TSpeedButton
      Left = 336
      Top = 26
      Width = 128
      Height = 22
      Caption = 'Stampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      OnClick = btnStampanteClick
    end
    object BtnResettaOrdinamenti: TButton
      Left = 473
      Top = 1
      Width = 128
      Height = 22
      Caption = 'Cancella &ordinamenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = BtnResettaOrdinamentiClick
    end
    object BtnResettaIntervalli: TButton
      Left = 473
      Top = 26
      Width = 128
      Height = 22
      Caption = 'Cancella &intervalli'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnResettaIntervalliClick
    end
    object BitBtnOK: TBitBtn
      Left = 610
      Top = 26
      Width = 128
      Height = 22
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 7
    end
    object BitBtn2: TBitBtn
      Left = 61
      Top = 26
      Width = 128
      Height = 22
      Caption = 'Impostazione pagina'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtnCarica: TBitBtn
      Left = 198
      Top = 1
      Width = 128
      Height = 22
      Caption = 'Carica im&postazioni'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C1F7C
        1F7C1F7C1F7C00000000E03DE03DE03DE03DE03DE03DE03DE03DE03D00001F7C
        1F7C1F7C1F7C0000E07F0000E03DE03DE03DE03DE03DE03DE03DE03DE03D0000
        1F7C1F7C1F7C00001F7CE07F0000E03DE03DE03DE03DE03DE03DE03DE03DE03D
        00001F7C1F7C0000E07F1F7CE07F0000E03DE03DE03DE03DE03DE03DE03DE03D
        E03D00001F7C00001F7CE07F1F7CE07F00000000000000000000000000000000
        000000001F7C0000E07F1F7CE07F1F7CE07F1F7CE07F1F7CE07F00001F7C1F7C
        1F7C1F7C1F7C00001F7CE07F1F7CE07F1F7CE07F1F7CE07F1F7C00001F7C1F7C
        1F7C1F7C1F7C0000E07F1F7CE07F00000000000000000000000000001F7C1F7C
        1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C0000
        1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C
        1F7C1F7C1F7C}
      TabOrder = 3
      OnClick = BitBtnCaricaClick
    end
    object BitBtnSalva: TBitBtn
      Left = 198
      Top = 26
      Width = 128
      Height = 22
      Caption = '&Salva impostazioni'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = BitBtnSalvaClick
    end
    inline frmSelAnagrafe: TfrmSelAnagrafe
      Left = 0
      Top = 0
      Width = 47
      Height = 48
      Align = alLeft
      TabOrder = 0
      TabStop = True
      ExplicitWidth = 47
      ExplicitHeight = 48
      inherited pnlSelAnagrafe: TPanel
        Width = 47
        Height = 48
        BevelOuter = bvNone
        ExplicitWidth = 47
        ExplicitHeight = 48
        inherited lblDipendente: TLabel
          Visible = False
        end
        inherited btnSelezione: TBitBtn
          OnClick = frmSelAnagrafebtnSelezioneClick
        end
        inherited btnEreditaSelezione: TBitBtn
          OnClick = frmSelAnagrafebtnEreditaSelezioneClick
        end
      end
      inherited pmnuDatiAnagrafici: TPopupMenu
        inherited R003Datianagrafici: TMenuItem
          Visible = False
        end
      end
    end
    object btnOrdineCampi: TBitBtn
      Left = 61
      Top = 1
      Width = 128
      Height = 22
      Caption = '&Impostazione dati'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000001F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C
        1F7C1F7C1F7C0000FF7F00000000FF7F00000000000000000000FF7F00001F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C
        1F7C1F7C1F7C0000FF7F00000000FF7F00000000000000000000FF7F00001F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7F0000FF7FFF7F00001F7C
        1F7C1F7C1F7C0000FF7F00000000FF7FFF7FFF7F00001F7C0000FF7F00001F7C
        1F7C1F7C1F7C0000FF7F00001F7C0000FF7F00001F7C00001F7C000000000000
        1F7C0F000F000000FF7FFF7F00001F7C00001F7C00001F7C00001F7C1F7C1F7C
        00000F000F00000000000000000000001F7C00001F7C00001F7C1F7C1F7C1F7C
        1F7C0F000F001F7C1F7C1F7C1F7C1F7C00001F7C00001F7C1F7C1F7C1F7C1F7C
        1F7C0F000F001F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C
        00000F000F001F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000000000
        1F7C0F000F001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 1
      OnClick = btnOrdineCampiOldClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 329
    Width = 753
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 100
    Top = 4
    object Impostazionidistampa1: TMenuItem
      Caption = 'Im&postazioni di stampa'
      object Carica1: TMenuItem
        Caption = '&Carica'
        OnClick = Carica1Click
      end
      object Salva1: TMenuItem
        Caption = '&Salva'
        OnClick = Salva1Click
      end
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 712
    Top = 8
  end
end
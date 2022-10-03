object C001FLayoutStampa: TC001FLayoutStampa
  Left = 243
  Top = 202
  HelpContext = 1001200
  Caption = '<C001> Impostazione pagina'
  ClientHeight = 422
  ClientWidth = 612
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
  object PgCtrlStampa: TPageControl
    Left = 0
    Top = 31
    Width = 612
    Height = 291
    ActivePage = TabDettaglio
    Align = alClient
    TabOrder = 0
    object TabDettaglio: TTabSheet
      Caption = 'Dettaglio'
      object ScrBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 604
        Height = 263
        Align = alClient
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Humanst521 BT'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = ScrBox1Enter
        OnDragDrop = ScrBox1DragDrop
        OnDragOver = ScrBox1DragOver
        OnMouseDown = ScrBox1MouseDown
      end
    end
    object TabIntestazione: TTabSheet
      Caption = 'Intestazione'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ScrBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 604
        Height = 270
        Align = alClient
        Color = clYellow
        ParentColor = False
        TabOrder = 0
        OnClick = ScrBox1Enter
        OnDragDrop = ScrBox1DragDrop
        OnDragOver = ScrBox1DragOver
        OnMouseDown = ScrBox2MouseDown
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 322
    Width = 612
    Height = 100
    Align = alBottom
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 480
      Height = 98
      ActivePage = TabSheet1
      Align = alLeft
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Oggetti'
        object LLeft: TLabel
          Left = 2
          Top = 29
          Width = 10
          Height = 13
          Caption = 'X:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LTop: TLabel
          Left = 2
          Top = 43
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object CmbOggetti: TComboBox
          Left = 0
          Top = 2
          Width = 145
          Height = 21
          Style = csDropDownList
          DragMode = dmAutomatic
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
        end
        object BtnAdd: TBitBtn
          Left = 154
          Top = 2
          Width = 70
          Height = 25
          Hint = 'aggiunge l'#39'oggetto alla banda'
          HelpContext = 3306
          Caption = '&Aggiungi'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BtnAddClick
          Glyph.Data = {
            46010000424D460100000000000076000000280000001C0000000D0000000100
            040000000000D000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333300003333333333333333333FFFF333330000333330003333
            3333338333F3333300003333300033333333338333F333330000333330003333
            3333FF3333FFFF3300003300000000033338333333333F330000330000000003
            3338333333333F3300003300000000033338333333333F330000333330003333
            333888833338833300003333300033333333338333F333330000333330003333
            3333338333F33333000033333333333333333388883333330000333333333333
            33333333333333330000}
          NumGlyphs = 2
        end
        object BtnDel: TBitBtn
          Left = 230
          Top = 2
          Width = 70
          Height = 25
          Hint = 'elimina l'#39'oggetto dalla banda'
          Caption = '&Rimuovi'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = BtnDelClick
          Glyph.Data = {
            46010000424D460100000000000076000000280000001C0000000D0000000100
            040000000000D000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333000033333333333333333333333333330000333333333333
            3333333333333333000033333333333333333333333333330000333333333333
            3333333333333333000033000000000033333333333333330000330000000000
            3333333333333333000033000000000033333333333333330000333333333333
            3333333333333333000033333333333333333333333333330000333333333333
            3333333333333333000033333333333333333333333333330000333333333333
            33333333333333330000}
          NumGlyphs = 2
        end
        object BtnFont: TBitBtn
          Left = 306
          Top = 31
          Width = 70
          Height = 25
          Hint = 'imposta il font dell'#39'oggetto'
          Caption = 'Cara&ttere'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Font1Click
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333FFF33FFFFF33333300033000
            00333337773377777333333330333300033333337FF33777F333333330733300
            0333333377FFF777F33333333700000073333333777777773333333333033000
            3333333337FF777F333333333307300033333333377F777F3333333333703007
            33333333377F7773333333333330000333333333337777F33333333333300003
            33333333337777F3333333333337007333333333337777333333333333330033
            3333333333377333333333333333033333333333333733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
        end
        object BitBtn1: TBitBtn
          Left = 383
          Top = 31
          Width = 70
          Height = 25
          Hint = 'imposta il colore dell'#39'oggetto'
          Caption = '&Colore'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Colo1Click
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333330000000000000333000011022077
            0333000011022077033300000000000003330440550660880333044055066088
            033300000000000003330770990AA0BB03330770990AA0BB0333000000000000
            03330CC0DD0EE0FF03330CC0DD0EE0FF03330000000000000333}
        end
        object BtnSize: TBitBtn
          Left = 383
          Top = 2
          Width = 70
          Height = 24
          Hint = 'imposta le dimensioni dell'#39'oggetto'
          Caption = '&Dimensioni'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Size1Click
        end
        object BtnAllinea: TBitBtn
          Left = 306
          Top = 1
          Width = 70
          Height = 25
          Hint = 'allinea l'#39'oggetto con un altro'
          Caption = 'A&llinea...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = BtnAllineaClick
        end
        object BtnFonts: TBitBtn
          Left = 154
          Top = 32
          Width = 146
          Height = 24
          Hint = 'imposta il font dell'#39'intero foglio'
          Caption = 'Carattere &generale'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = BtnFontsClick
          Glyph.Data = {
            5A010000424D5A01000000000000760000002800000017000000130000000100
            040000000000E400000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
            0000000000308774477777777777777770308774477777777777777770308774
            4777777777818777703087744477777777717777703087744777777777717877
            7030877447777777777111777030877444477557777178777030877777777785
            7771778770308777777777757781111770308777777777757777777770308777
            7777775557777777703087777777777577777777703087777777777587777777
            7030877777777777557777777030877777777777777777777030800000000000
            0000000000308F0CCCCCCCCCCCCCC0F0F030888888888888888888888830}
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Impostazioni generali'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object SpeedButton1: TSpeedButton
          Left = 412
          Top = 6
          Width = 22
          Height = 22
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555775777777
            57705557757777775FF7555555555555000755555555555F777F555555555550
            87075555555555F7577F5555555555088805555555555F755F75555555555033
            805555555555F755F75555555555033B05555555555F755F75555555555033B0
            5555555555F755F75555555555033B05555555555F755F75555555555033B055
            55555555F755F75555555555033B05555555555F755F75555555555033B05555
            555555F75FF75555555555030B05555555555F7F7F75555555555000B0555555
            5555F777F7555555555501900555555555557777755555555555099055555555
            5555777755555555555550055555555555555775555555555555}
          NumGlyphs = 2
          OnClick = SpeedButton1Click
        end
        object CheckSingola: TCheckBox
          Left = 91
          Top = 6
          Width = 130
          Height = 17
          Caption = 'Vista globale dett./int.'
          TabOrder = 0
          OnClick = CheckSingolaClick
        end
        object RGrpTipo: TRadioGroup
          Left = 2
          Top = 2
          Width = 84
          Height = 64
          Caption = 'Tipo stampa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Elenco'
            'Scheda')
          ParentFont = False
          TabOrder = 2
          OnClick = RGrpTipoClick
        end
        object CheckSeparate: TCheckBox
          Left = 91
          Top = 50
          Width = 130
          Height = 17
          Caption = 'Salto pagina forzato'
          TabOrder = 1
          OnClick = CheckSeparateClick
        end
        object CkBLineaRec: TCheckBox
          Left = 223
          Top = 6
          Width = 177
          Height = 17
          Caption = 'Linea separatrice fra ogni record'
          Enabled = False
          TabOrder = 3
          OnClick = CkBLineaRecClick
        end
        object CheckSpaziatura: TCheckBox
          Left = 224
          Top = 47
          Width = 159
          Height = 20
          Caption = 'Separazione fra ogni record'
          TabOrder = 4
          OnClick = CheckSpaziaturaClick
        end
        object SpSpaziatura: TSpinEdit
          Left = 388
          Top = 45
          Width = 47
          Height = 22
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 5
          OnChange = SpSpaziaturaChange
        end
      end
      object TabOpzioni: TTabSheet
        Caption = 'Impostazioni raggruppamenti'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object SpeedButton2: TSpeedButton
          Left = 375
          Top = 5
          Width = 22
          Height = 22
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555775777777
            57705557757777775FF7555555555555000755555555555F777F555555555550
            87075555555555F7577F5555555555088805555555555F755F75555555555033
            805555555555F755F75555555555033B05555555555F755F75555555555033B0
            5555555555F755F75555555555033B05555555555F755F75555555555033B055
            55555555F755F75555555555033B05555555555F755F75555555555033B05555
            555555F75FF75555555555030B05555555555F7F7F75555555555000B0555555
            5555F777F7555555555501900555555555557777755555555555099055555555
            5555777755555555555550055555555555555775555555555555}
          NumGlyphs = 2
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 375
          Top = 40
          Width = 22
          Height = 22
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555775777777
            57705557757777775FF7555555555555000755555555555F777F555555555550
            87075555555555F7577F5555555555088805555555555F755F75555555555033
            805555555555F755F75555555555033B05555555555F755F75555555555033B0
            5555555555F755F75555555555033B05555555555F755F75555555555033B055
            55555555F755F75555555555033B05555555555F755F75555555555033B05555
            555555F75FF75555555555030B05555555555F7F7F75555555555000B0555555
            5555F777F7555555555501900555555555557777755555555555099055555555
            5555777755555555555550055555555555555775555555555555}
          NumGlyphs = 2
          OnClick = SpeedButton3Click
        end
        object SpeedButton4: TSpeedButton
          Left = 400
          Top = 4
          Width = 70
          Height = 59
          Caption = 'Impostazioni'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
            1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
            1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
            193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
            11155557F755F777777555000755033305555577755F75F77F55555555503335
            0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
            05555757F75F75557F5505000333555505557F777FF755557F55000000355557
            07557777777F55557F5555000005555707555577777FF5557F55553000075557
            0755557F7777FFF5755555335000005555555577577777555555}
          Layout = blGlyphBottom
          NumGlyphs = 2
          OnClick = SpeedButton4Click
        end
        object CkBLineaSup: TCheckBox
          Left = 209
          Top = 5
          Width = 166
          Height = 17
          Caption = 'Linea separatrice inizio gruppo'
          TabOrder = 0
          OnClick = CkBLineaSupClick
        end
        object CkBLineaInf: TCheckBox
          Left = 209
          Top = 45
          Width = 166
          Height = 17
          Caption = 'Linea separatrice fine gruppo'
          TabOrder = 1
          OnClick = CkBLineaInfClick
        end
        object RGTipoGruppo: TRadioGroup
          Left = 1
          Top = 1
          Width = 204
          Height = 61
          Caption = 'Gestione raggruppamenti:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Un solo raggruppamento'
            'Un raggruppamento per ogni campo')
          ParentFont = False
          TabOrder = 2
          OnClick = RGTipoGruppoClick
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Pagina/Stampante'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object BitBtn4: TBitBtn
          Left = 10
          Top = 7
          Width = 95
          Height = 52
          Caption = 'Rigenera &pagina'
          TabOrder = 0
          OnClick = BitBtn4Click
          Layout = blGlyphBottom
          NumGlyphs = 2
        end
        object BitBtn3: TBitBtn
          Left = 110
          Top = 7
          Width = 105
          Height = 52
          Caption = '&Imposta stampante'
          TabOrder = 1
          OnClick = BitBtn3Click
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
            0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
            070F00000000000007700778888778807070F000000000070700FF0777777770
            7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
            6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
          Layout = blGlyphBottom
        end
      end
    end
    object BitBtn2: TBitBtn
      Left = 539
      Top = 21
      Width = 46
      Height = 78
      Caption = 'C&hiudi'
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      Layout = blGlyphBottom
      NumGlyphs = 2
    end
    object BtnStampa: TBitBtn
      Left = 487
      Top = 21
      Width = 46
      Height = 78
      Caption = '&Stampa'
      TabOrder = 2
      OnClick = BtnStampaClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      Layout = blGlyphBottom
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 612
    Height = 31
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 3
      Top = 8
      Width = 112
      Height = 13
      Caption = 'Titolo della stampa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ETitolo: TEdit
      Left = 117
      Top = 4
      Width = 341
      Height = 21
      TabOrder = 0
      OnChange = ETitoloChange
    end
  end
  object PopMenu: TPopupMenu
    OnPopup = PopMenuPopup
    Left = 232
    Top = 232
    object Font1: TMenuItem
      Caption = '&Carattere'
      OnClick = Font1Click
    end
    object Size1: TMenuItem
      Caption = '&Dimensione'
      OnClick = Size1Click
    end
    object Colo1: TMenuItem
      Caption = 'Co&lore'
      OnClick = Colo1Click
    end
    object Del1: TMenuItem
      Caption = '&Rimuovi'
      OnClick = BtnDelClick
    end
    object Transparent1: TMenuItem
      Caption = '&Trasparente'
      OnClick = trasparente1Click
    end
    object Allinea1: TMenuItem
      Caption = '&Allinea...'
      OnClick = BtnAllineaClick
    end
  end
  object FontDlg: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Device = fdBoth
    Options = [fdAnsiOnly, fdEffects]
    Left = 260
    Top = 232
  end
  object ColorDlg: TColorDialog
    Left = 204
    Top = 232
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 288
    Top = 232
  end
end

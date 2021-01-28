object A032ScarichiPrecedenti: TA032ScarichiPrecedenti
  Left = 0
  Top = 0
  HelpContext = 32100
  Caption = '<A032> Recupero scarichi precedenti'
  ClientHeight = 447
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 491
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblParametrizzazione: TDBText
      Left = 51
      Top = 5
      Width = 97
      Height = 13
      AutoSize = True
      DataField = 'SCARICO'
      DataSource = R200FScaricoTimbratureDtM.DI100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblPrametrizzazionelbl: TLabel
      Left = 9
      Top = 5
      Width = 38
      Height = 13
      Caption = 'Scarico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlFiles: TPanel
    Left = 0
    Top = 80
    Width = 491
    Height = 367
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 207
      Width = 491
      Height = 2
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 94
    end
    object pnlAzioni: TPanel
      Left = 0
      Top = 298
      Width = 491
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        491
        34)
      object btnConferma: TBitBtn
        Left = 324
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Inizia Scarico'
        TabOrder = 0
        OnClick = btnConfermaClick
      end
      object btnChiudi: TBitBtn
        Left = 414
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Chiudi'
        Glyph.Data = {
          06010000424D0601000000000000760000002800000010000000120000000100
          04000000000090000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
          F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
          F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
          F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
          F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
          FFFFFFFFFF000000FFFF}
        TabOrder = 1
        OnClick = btnChiudiClick
      end
    end
    object mmMessaggi: TMemo
      Left = 0
      Top = 209
      Width = 491
      Height = 89
      Align = alBottom
      Color = clBtnFace
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 491
      Height = 207
      Align = alClient
      Caption = 'Files da recuperare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lstFiles: TCheckListBox
        Left = 2
        Top = 97
        Width = 487
        Height = 108
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
        OnMouseUp = lstFilesMouseUp
      end
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 487
        Height = 82
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 6
          Top = 41
          Width = 48
          Height = 13
          Caption = 'Nome file:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDataA: TLabel
          Left = 217
          Top = 41
          Width = 13
          Height = 13
          Caption = 'Al:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDataDa: TLabel
          Left = 107
          Top = 41
          Width = 66
          Height = 13
          Caption = 'Modificati dal:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblPercorsoFile: TLabel
          Left = 6
          Top = -1
          Width = 46
          Height = 13
          Caption = 'Percorso:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtFiltroNome: TEdit
          Left = 6
          Top = 56
          Width = 95
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '*.*'
          OnChange = edtFiltroNomeChange
        end
        object edtDataDa: TMaskEdit
          Left = 107
          Top = 56
          Width = 69
          Height = 21
          EditMask = '!99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          OnExit = edtDataDaExit
        end
        object btnselDataDa: TBitBtn
          Left = 179
          Top = 56
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnselDataDaClick
        end
        object edtDataA: TMaskEdit
          Left = 215
          Top = 56
          Width = 69
          Height = 21
          EditMask = '!99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 3
          Text = '  /  /    '
          OnExit = edtDataAExit
        end
        object btnselDataA: TBitBtn
          Left = 287
          Top = 56
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = btnselDataAClick
        end
        object btnRefresh: TBitBtn
          Left = 322
          Top = 56
          Width = 21
          Height = 21
          Hint = 'Aggiorna lista files'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
            2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
            FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
            FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = btnRefreshClick
        end
        object edtPathTimb: TEdit
          Left = 6
          Top = 13
          Width = 457
          Height = 21
          Enabled = False
          TabOrder = 6
        end
        object btnTimb: TButton
          Left = 469
          Top = 13
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = btnTimbClick
        end
      end
    end
    object stdBar1: TStatusBar
      Left = 0
      Top = 348
      Width = 491
      Height = 19
      Panels = <
        item
          Width = 50
        end>
    end
    object prgBar1: TProgressBar
      Left = 0
      Top = 332
      Width = 491
      Height = 16
      Align = alBottom
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 25
    Width = 491
    Height = 55
    Align = alTop
    Caption = 'Timbrature da considerare'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 183
      Top = 15
      Width = 13
      Height = 13
      Caption = 'Al:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 15
      Width = 19
      Height = 13
      Caption = 'Dal:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 103
      Top = 15
      Width = 22
      Height = 13
      Caption = 'Ore:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 282
      Top = 15
      Width = 22
      Height = 13
      Caption = 'Ore:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtFDataDa: TMaskEdit
      Left = 7
      Top = 30
      Width = 68
      Height = 21
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtFDataDaExit
    end
    object BitBtn1: TBitBtn
      Left = 75
      Top = 30
      Width = 16
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object edtFDataA: TMaskEdit
      Left = 181
      Top = 30
      Width = 69
      Height = 21
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      OnExit = edtFDataDaExit
    end
    object BitBtn2: TBitBtn
      Left = 250
      Top = 30
      Width = 17
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn2Click
    end
    object edtFOraDa: TMaskEdit
      Left = 102
      Top = 30
      Width = 35
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  .  '
      OnExit = edtFOraDaExit
    end
    object edtFOraA: TMaskEdit
      Left = 281
      Top = 30
      Width = 35
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
      Text = '  .  '
      OnExit = edtFOraDaExit
    end
  end
  object dlgPathTimb: TOpenDialog
    Left = 460
    Top = 3
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 240
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullaselezione1: TMenuItem
      Caption = 'Annulla selezione'
      OnClick = Annullaselezione1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
  end
end

object A170FGestioneGruppi: TA170FGestioneGruppi
  Left = 0
  Top = 0
  HelpContext = 170000
  ActiveControl = BitBtn1
  Caption = '<A170> Gruppi pesature/schede'
  ClientHeight = 374
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 293
    Width = 801
    Height = 44
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 419
      Top = 9
      Width = 86
      Height = 27
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnEsegui: TBitBtn
      Left = 204
      Top = 9
      Width = 86
      Height = 27
      Caption = 'Esegui'
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
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 311
      Top = 9
      Width = 86
      Height = 27
      Caption = 'Anomalie'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnAnomalieClick
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 337
    Width = 801
    Height = 18
    Align = alBottom
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 355
    Width = 801
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 801
    Height = 293
    ActivePage = tabSchedeQuant
    Align = alClient
    TabOrder = 3
    object tabPesature: TTabSheet
      Caption = 'Pesature individuali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 200
        Top = 32
        Width = 88
        Height = 13
        Caption = 'Anno elaborazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 200
        Top = 71
        Width = 73
        Height = 13
        Caption = 'Tipologia quota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 200
        Top = 111
        Width = 75
        Height = 13
        Caption = 'Gruppi pesature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dtxtQuota1: TDBText
        Left = 379
        Top = 71
        Width = 280
        Height = 18
        DataField = 'DESCRIZIONE'
        DataSource = A170FGestioneGruppiDtM.dsrT773Quote
      end
      object edtAnno1: TSpinEdit
        Left = 294
        Top = 29
        Width = 57
        Height = 22
        MaxValue = 3999
        MinValue = 1900
        TabOrder = 3
        Value = 1900
        OnChange = edtAnno1Change
      end
      object edtGruppi1: TEdit
        Left = 295
        Top = 108
        Width = 344
        Height = 21
        TabOrder = 5
      end
      object chkChiusura1: TCheckBox
        Left = 10
        Top = 30
        Width = 104
        Height = 19
        Caption = 'Chiusura gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkChiusura1Click
      end
      object chkApertura1: TCheckBox
        Left = 10
        Top = 70
        Width = 134
        Height = 18
        Caption = 'Ri-apertura gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkApertura1Click
      end
      object chkAggiorna1: TCheckBox
        Left = 10
        Top = 110
        Width = 134
        Height = 18
        Caption = 'Aggiornamento gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkAggiorna1Click
      end
      object dcmbQuota1: TDBLookupComboBox
        Left = 295
        Top = 68
        Width = 80
        Height = 21
        DropDownWidth = 200
        KeyField = 'CODTIPOQUOTA'
        ListField = 'CODTIPOQUOTA;DESCRIZIONE'
        ListSource = A170FGestioneGruppiDtM.dsrT773Quote
        TabOrder = 4
        OnCloseUp = dcmbQuota1CloseUp
        OnKeyUp = dcmbQuota1KeyUp
      end
      object btnGruppi1: TBitBtn
        Left = 640
        Top = 105
        Width = 19
        Height = 27
        Caption = '...'
        TabOrder = 6
        OnClick = btnGruppi1Click
      end
    end
    object tabSchedeQuant: TTabSheet
      Caption = 'Schede quantitative individuali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object lblAnno2: TLabel
        Left = 200
        Top = 32
        Width = 88
        Height = 13
        Caption = 'Anno elaborazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 200
        Top = 71
        Width = 73
        Height = 13
        Caption = 'Tipologia quota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblGruppi2: TLabel
        Left = 200
        Top = 111
        Width = 69
        Height = 13
        Caption = 'Gruppi schede'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dtxtQuota2: TDBText
        Left = 380
        Top = 71
        Width = 280
        Height = 18
        DataField = 'DESCRIZIONE'
        DataSource = A170FGestioneGruppiDtM.dsrT767Quote
      end
      object lblDataRif2: TLabel
        Left = 200
        Top = 151
        Width = 85
        Height = 13
        Caption = 'Data di riferimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object edtAnno2: TSpinEdit
        Left = 295
        Top = 29
        Width = 57
        Height = 22
        MaxValue = 3999
        MinValue = 1900
        TabOrder = 4
        Value = 1900
        OnChange = edtAnno2Change
      end
      object edtGruppi2: TEdit
        Left = 295
        Top = 108
        Width = 345
        Height = 21
        TabOrder = 6
      end
      object chkChiusura2: TCheckBox
        Left = 10
        Top = 30
        Width = 104
        Height = 19
        Caption = 'Chiusura gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkAggiorna2Click
      end
      object chkApertura2: TCheckBox
        Left = 10
        Top = 70
        Width = 134
        Height = 18
        Caption = 'Ri-apertura gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkAggiorna2Click
      end
      object dcmbQuota2: TDBLookupComboBox
        Left = 295
        Top = 68
        Width = 80
        Height = 21
        DropDownWidth = 200
        KeyField = 'CODTIPOQUOTA'
        ListField = 'CODTIPOQUOTA;DESCRIZIONE'
        ListSource = A170FGestioneGruppiDtM.dsrT767Quote
        TabOrder = 5
        OnCloseUp = dcmbQuota2CloseUp
        OnKeyUp = dcmbQuota2KeyUp
      end
      object btnGruppi2: TBitBtn
        Left = 640
        Top = 105
        Width = 19
        Height = 27
        Caption = '...'
        TabOrder = 7
        OnClick = btnGruppi2Click
      end
      object chkAggiorna2: TCheckBox
        Left = 10
        Top = 110
        Width = 134
        Height = 18
        Caption = 'Aggiornamento gruppi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkAggiorna2Click
      end
      object chkPassaggioAnno2: TCheckBox
        Left = 10
        Top = 150
        Width = 167
        Height = 18
        Caption = 'Ribaltamento su nuovo anno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chkAggiorna2Click
      end
      object edtDataRif2: TMaskEdit
        Left = 295
        Top = 147
        Width = 65
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 8
        Text = '  /  /    '
        Visible = False
      end
      object btnDataRif2: TBitBtn
        Left = 361
        Top = 144
        Width = 19
        Height = 27
        Caption = '...'
        TabOrder = 9
        Visible = False
        OnClick = btnDataRif2Click
      end
      object gpbPagamenti2: TGroupBox
        Left = 0
        Top = 184
        Width = 793
        Height = 81
        Align = alBottom
        Caption = 'Pagamenti da effettuare sul mese di competenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        Visible = False
        object grdPagamenti: TStringGrid
          Left = 2
          Top = 15
          Width = 789
          Height = 64
          Align = alClient
          ColCount = 13
          DefaultColWidth = 59
          DefaultRowHeight = 18
          RowCount = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
          ParentFont = False
          TabOrder = 0
          OnGetEditMask = grdPagamentiGetEditMask
        end
      end
    end
  end
end

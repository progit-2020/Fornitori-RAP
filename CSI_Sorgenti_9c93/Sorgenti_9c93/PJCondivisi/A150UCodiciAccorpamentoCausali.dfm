inherited A150FCodiciAccorpamentoCausali: TA150FCodiciAccorpamentoCausali
  HelpContext = 150100
  Caption = '<A150> Assenze da accorpare'
  ClientHeight = 262
  ExplicitWidth = 553
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 244
    ExplicitTop = 244
  end
  object pnlPrincipale: TPanel [3]
    Left = 0
    Top = 63
    Width = 537
    Height = 181
    Align = alClient
    TabOrder = 3
    object lblDTipoAccorpCausali: TLabel
      Left = 217
      Top = 31
      Width = 107
      Height = 13
      Caption = 'lblDTipoAccorpCausali'
    end
    object lblTipoAccorpCausali: TLabel
      Left = 12
      Top = 29
      Width = 92
      Height = 13
      Caption = 'Tipo accorpamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodiciAccorpCausali: TLabel
      Left = 12
      Top = 61
      Width = 104
      Height = 13
      Caption = 'Codice accorpamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDCodiciAccorpCausali: TLabel
      Left = 217
      Top = 63
      Width = 115
      Height = 13
      Caption = 'lblDCodiciAccorpCausali'
    end
    object edtCodTipoAccorpCausali: TEdit
      Left = 139
      Top = 28
      Width = 70
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'edtCodTipoAccorpCausali'
    end
    object edtCodCodiciAccorpCausali: TEdit
      Left = 139
      Top = 60
      Width = 70
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'edtCodCodiciAccorpCausali'
    end
    object gpbAccorpamentoVoci: TGroupBox
      Left = 15
      Top = 91
      Width = 506
      Height = 71
      Caption = 'Accorpamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label2: TLabel
        Left = 9
        Top = 20
        Width = 80
        Height = 13
        Caption = 'Causale assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dlblDCausale: TDBText
        Left = 101
        Top = 38
        Width = 259
        Height = 13
        DataField = 'DESCRIZIONE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodiceCausale: TDBEdit
        Left = 9
        Top = 34
        Width = 70
        Height = 21
        DataField = 'COD_CAUSALE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object btnFind1: TButton
        Left = 79
        Top = 34
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnFind1Click
      end
      object btnFiltroVoci: TBitBtn
        Left = 373
        Top = 14
        Width = 123
        Height = 24
        Caption = '&Inserisci causali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777700007777777777770660777777777777066077
          77777777770F707777777777770F707777777777707776077777777706777660
          7777777067F77766077777067F77777660777067FFF777766607700000000000
          0007777777777777777777777777777777777777777777777777}
        ParentFont = False
        TabOrder = 2
        OnClick = btnFiltroVociClick
      end
      object btnElimina: TBitBtn
        Left = 373
        Top = 41
        Width = 123
        Height = 24
        Caption = '&Elimina causali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C10001000100010001000100010001000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7FFF7F104210001000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7F1042100010421000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7FFF7F104210001000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7F1042100010421000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7FFF7F104210421000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C10001000100010001000100010001000
          10421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
          10001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000
          000010001F7C1F7C1F7C1F7C1F7C1F7C100010001F7C1F7C1F7C1F7C1F7C0000
          100010421F7C1F7C1F7C1F7C1F7C1000FF7F000010001F7C1F7C1F7C1F7C1000
          104210001F7C1F7C1F7C1F7C1F7C1000FF7FFF7F00001F7C1F7C1F7C1F7C1042
          100010001F7C1F7C1F7C1F7C1F7C1F7C100010001F7C1F7C1F7C1F7C1F7C1F7C
          10001F7C1F7C1F7C1F7C1F7C10001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000
          10001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        ParentFont = False
        TabOrder = 3
        OnClick = btnEliminaClick
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 368
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 396
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 424
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 452
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 480
    Top = 32
  end
end

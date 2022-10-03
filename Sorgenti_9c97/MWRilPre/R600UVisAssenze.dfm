object R600FVisAssenze: TR600FVisAssenze
  Left = 195
  Top = 194
  HelpContext = 4300
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '<R600> Prospetto assenze'
  ClientHeight = 513
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Grid1: TStringGrid
    Left = 0
    Top = 255
    Width = 626
    Height = 228
    Align = alBottom
    ColCount = 9
    DefaultColWidth = 58
    DefaultRowHeight = 20
    RowCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    TabOrder = 0
    OnDrawCell = Grid1DrawCell
    ColWidths = (
      58
      58
      58
      58
      58
      58
      58
      58
      58)
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 626
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object LNome: TLabel
      Left = 62
      Top = 20
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'LNome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LMatricola: TLabel
      Left = 62
      Top = 4
      Width = 49
      Height = 13
      Caption = 'LMatricola'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 4
      Top = 4
      Width = 57
      Height = 13
      Caption = 'Matricola:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 4
      Top = 20
      Width = 37
      Height = 13
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 4
      Top = 36
      Width = 50
      Height = 13
      Caption = 'Causale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LCausale: TLabel
      Left = 62
      Top = 36
      Width = 44
      Height = 13
      Caption = 'LCausale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 243
      Top = 20
      Width = 106
      Height = 13
      Caption = 'Periodo di cumulo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPeriodoCumulo: TLabel
      Left = 378
      Top = 20
      Width = 81
      Height = 13
      Caption = 'lblPeriodoCumulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFamRif: TLabel
      Left = 243
      Top = 4
      Width = 132
      Height = 13
      Caption = 'Familiare di riferimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataFamRif: TLabel
      Left = 378
      Top = 4
      Width = 62
      Height = 13
      Caption = 'LDataFamRif'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 243
      Top = 36
      Width = 110
      Height = 13
      Caption = 'Numero di fruizioni:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumeroFruizioni: TLabel
      Left = 378
      Top = 36
      Width = 85
      Height = 13
      Caption = 'lblNumeroFruizioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 483
    Width = 626
    Height = 30
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 4
      Top = 3
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnAssCumulate: TBitBtn
      Left = 420
      Top = 3
      Width = 100
      Height = 25
      Caption = 'Assenze cumulate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAssCumulateClick
    end
    object btnPeriodiCumulati: TBitBtn
      Left = 522
      Top = 3
      Width = 100
      Height = 25
      Caption = 'Periodi cumulati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnPeriodiCumulatiClick
    end
    object btnCambiaFineCumulo: TBitBtn
      Left = 270
      Top = 3
      Width = 130
      Height = 25
      Caption = 'Riepilogo al dd/mm/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnCambiaFineCumuloClick
    end
    object btnRiepIndividuale: TBitBtn
      Left = 137
      Top = 3
      Width = 130
      Height = 25
      Caption = 'Riepilogo individuale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnRiepIndividualeClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 51
    Width = 626
    Height = 204
    Align = alClient
    Caption = 'GroupBox1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lblPartTime: TLabel
      Left = 336
      Top = 14
      Width = 111
      Height = 13
      Caption = 'Part-time applicato:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LFruizMinima: TLabel
      Left = 535
      Top = 80
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'LFruizMinima'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFruizMinimaTitolo: TLabel
      Left = 336
      Top = 80
      Width = 161
      Height = 13
      Caption = 'Fruiz. minima anno corrente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object memoPartTime: TMemo
      Left = 336
      Top = 28
      Width = 274
      Height = 47
      BorderStyle = bsNone
      Color = cl3DLight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
    object pnlLeft: TPanel
      Left = 2
      Top = 15
      Width = 328
      Height = 187
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 328
        Height = 103
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Left = 4
          Top = -1
          Width = 189
          Height = 13
          Caption = 'Competenze lorde anno corrente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 4
          Top = 15
          Width = 200
          Height = 13
          Caption = 'Variazione assunzione/cessazione:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 4
          Top = 30
          Width = 230
          Height = 13
          Caption = 'Arrotondamento assunzione/cessazione:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 4
          Top = 45
          Width = 238
          Height = 13
          Caption = 'Variazione da assenze che non maturano:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 4
          Top = 60
          Width = 139
          Height = 13
          Caption = 'Variazione per part-time:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 4
          Top = 74
          Width = 206
          Height = 13
          Caption = 'Variazione per mancata abilitazione:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 4
          Top = 88
          Width = 211
          Height = 13
          Caption = 'Variazione manuale alle competenze:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LDecurtazione: TLabel
          Left = 255
          Top = 88
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LAbilAnagr: TLabel
          Left = 255
          Top = 74
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LPartTime: TLabel
          Left = 255
          Top = 60
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LCompSoloFerie: TLabel
          Left = 255
          Top = 45
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LCompArrotondata: TLabel
          Left = 255
          Top = 30
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LPeriodiRapporto: TLabel
          Left = 255
          Top = 15
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCausale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LCompTotale: TLabel
          Left = 224
          Top = -1
          Width = 75
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCompTotale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pnlCumuloF: TPanel
        Left = 0
        Top = 103
        Width = 328
        Height = 52
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblDescFruizMMInteri: TLabel
          Left = 4
          Top = -1
          Width = 199
          Height = 13
          Caption = 'Variazione per fruizione mesi interi:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblFruizMMInteri: TLabel
          Left = 226
          Top = -1
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblFruizMMInteri'
        end
        object lblDescMaxIndividuale: TLabel
          Left = 4
          Top = 40
          Width = 215
          Height = 13
          Caption = 'Variazione per comp. max individuale:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblMaxIndividuale: TLabel
          Left = 218
          Top = 40
          Width = 81
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblMaxIndividuale'
        end
        object lblDescFruizMMContinuativi: TLabel
          Left = 4
          Top = 13
          Width = 212
          Height = 13
          Caption = 'Variazione per fruizione continuativa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblFruizMMContinuativi: TLabel
          Left = 195
          Top = 13
          Width = 105
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblFruizMMContinuativi'
        end
        object lblDescGGNoLavVuoti: TLabel
          Left = 4
          Top = 27
          Width = 198
          Height = 13
          Caption = 'Variazione per fruizione frazionata:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblGGNoLavVuoti: TLabel
          Left = 217
          Top = 27
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblGGNoLavVuoti'
        end
      end
      object pnlCompFinali: TPanel
        Left = 0
        Top = 171
        Width = 328
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object LCompFinale: TLabel
          Left = 226
          Top = 1
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'LCompFinale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 4
          Top = 1
          Width = 188
          Height = 13
          Caption = 'Competenze finali anno corrente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pnlCodIntA: TPanel
        Left = 0
        Top = 155
        Width = 328
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object lblFestePartic: TLabel
          Left = 236
          Top = 1
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblFestePartic'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescFestePartic: TLabel
          Left = 4
          Top = 1
          Width = 195
          Height = 13
          Caption = 'Variazione per festivit'#224' particolari:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 560
    Top = 48
    object File1: TMenuItem
      Caption = 'File'
      object StampaVideata1: TMenuItem
        Caption = 'Stampa Videata'
        OnClick = StampaVideata1Click
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 528
    Top = 48
  end
end

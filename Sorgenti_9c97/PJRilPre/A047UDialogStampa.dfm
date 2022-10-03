object A047FDialogStampa: TA047FDialogStampa
  Left = 174
  Top = 183
  HelpContext = 47000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A047> Stampa timbrature di mensa'
  ClientHeight = 398
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 107
    Top = 4
    Width = 60
    Height = 15
    AutoSize = False
    Caption = 'Alla data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 9
    Top = 4
    Width = 60
    Height = 15
    AutoSize = False
    Caption = 'Dalla data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 212
    Top = 101
    Width = 36
    Height = 13
    Caption = 'Orologi:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnPrinterSetup: TBitBtn
    Left = 9
    Top = 335
    Width = 88
    Height = 25
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
    TabOrder = 7
    OnClick = BtnPrinterSetupClick
  end
  object BtnStampa: TBitBtn
    Left = 120
    Top = 335
    Width = 88
    Height = 25
    Caption = '&Stampa'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 8
    OnClick = BtnStampaClick
  end
  object EDaData: TMaskEdit
    Left = 9
    Top = 19
    Width = 72
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnChange = EDaDataChange
  end
  object EAData: TMaskEdit
    Left = 107
    Top = 19
    Width = 69
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    OnChange = EADataChange
  end
  object rgpTipoStampa: TRadioGroup
    Left = 207
    Top = 4
    Width = 217
    Height = 37
    Caption = 'Tipo stampa'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Dipendente'
      'Giornaliera')
    ParentFont = False
    TabOrder = 2
    OnClick = rgpTipoStampaClick
  end
  object pnlDipendente: TPanel
    Left = 9
    Top = 47
    Width = 192
    Height = 282
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object chkTimbraturePresenza: TCheckBox
      Left = 3
      Top = 84
      Width = 153
      Height = 17
      Caption = 'Timbrature di presenza'
      TabOrder = 4
      OnClick = chkDatiIndividualiClick
    end
    object chkRilevatori: TCheckBox
      Left = 3
      Top = 181
      Width = 163
      Height = 17
      Caption = 'Raggruppamento per rilevatori'
      TabOrder = 9
      OnClick = chkDatiIndividualiClick
    end
    object chkTotaliIndividuali: TCheckBox
      Left = 3
      Top = 46
      Width = 153
      Height = 17
      Caption = 'Totali Individuali'
      TabOrder = 2
      OnClick = chkDatiIndividualiClick
    end
    object chkDatiIndividuali: TCheckBox
      Left = 3
      Top = 4
      Width = 153
      Height = 17
      Caption = 'Dati Individuali'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkDatiIndividualiClick
    end
    object chkDettaglioGiornaliero: TCheckBox
      Left = 3
      Top = 26
      Width = 153
      Height = 17
      Caption = 'Dettaglio giornaliero'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkDatiIndividualiClick
    end
    object chkSaltoPagina: TCheckBox
      Left = 3
      Top = 221
      Width = 175
      Height = 17
      Caption = 'Salto pagina nomin./rilev./caus.'
      TabOrder = 11
      OnClick = chkDatiIndividualiClick
    end
    object chkAnomalie: TCheckBox
      Left = 3
      Top = 141
      Width = 155
      Height = 17
      Caption = 'Solo anomalie'
      TabOrder = 7
      OnClick = chkDatiIndividualiClick
    end
    object chkCausale: TCheckBox
      Left = 3
      Top = 201
      Width = 163
      Height = 17
      Caption = 'Raggruppamento per causale'
      TabOrder = 10
      OnClick = chkDatiIndividualiClick
    end
    object chkGiustificativiAssenza: TCheckBox
      Left = 3
      Top = 123
      Width = 153
      Height = 17
      Caption = 'Gustificativi di assenza'
      TabOrder = 6
      OnClick = chkDatiIndividualiClick
    end
    object chkSaltoPaginaIndividuale: TCheckBox
      Left = 3
      Top = 65
      Width = 153
      Height = 17
      Caption = 'Salto pagina individuale'
      TabOrder = 3
      OnClick = chkDatiIndividualiClick
    end
    object chkNominativi: TCheckBox
      Left = 3
      Top = 162
      Width = 173
      Height = 17
      Caption = 'Raggruppamento per nominativo'
      TabOrder = 8
      OnClick = chkDatiIndividualiClick
    end
    object chkSaltoPaginaRaggr: TCheckBox
      Left = 3
      Top = 264
      Width = 153
      Height = 17
      Caption = 'Salto pagina'
      TabOrder = 14
      OnClick = chkDatiIndividualiClick
    end
    object chkTimbraturePresenzaCausalizzate: TCheckBox
      Left = 3
      Top = 103
      Width = 153
      Height = 17
      Caption = 'Timbrature con causale'
      TabOrder = 5
      OnClick = chkDatiIndividualiClick
    end
    object edtRaggr: TEdit
      Left = 3
      Top = 242
      Width = 170
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      OnChange = edtRaggrChange
    end
    object btnRaggr: TButton
      Left = 176
      Top = 242
      Width = 16
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = btnRaggrClick
    end
  end
  object pnlGiornaliera: TPanel
    Left = 208
    Top = 47
    Width = 217
    Height = 44
    BevelOuter = bvNone
    Color = clInactiveBorder
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object chkDistinzioneCausale: TCheckBox
      Left = 4
      Top = 4
      Width = 149
      Height = 17
      Caption = 'Distinzione per causale'
      TabOrder = 0
    end
    object chkPranzoCena: TCheckBox
      Left = 4
      Top = 24
      Width = 150
      Height = 17
      Caption = 'Distinzione pranzo/cena'
      TabOrder = 1
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 363
    Width = 433
    Height = 16
    Align = alBottom
    TabOrder = 10
  end
  object btnAnteprima: TBitBtn
    Left = 228
    Top = 335
    Width = 88
    Height = 25
    Caption = '&Anteprima'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    TabOrder = 9
    OnClick = BtnStampaClick
  end
  object BitBtn1: TBitBtn
    Left = 336
    Top = 335
    Width = 88
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 11
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 379
    Width = 433
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object cbxOrologi: TCheckListBox
    Left = 211
    Top = 115
    Width = 212
    Height = 168
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 5
  end
  object chkTuttiOrologi: TCheckBox
    Left = 212
    Top = 289
    Width = 150
    Height = 17
    Caption = 'Seleziona tutto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = chkTuttiOrologiClick
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 341
    Top = 295
  end
end

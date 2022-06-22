object A090FAssenzeAnno: TA090FAssenzeAnno
  Left = 232
  Top = 134
  HelpContext = 90000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A090> Scheda annuale assenze'
  ClientHeight = 541
  ClientWidth = 591
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnPrinterSetUp: TBitBtn
    Left = 44
    Top = 473
    Width = 100
    Height = 25
    Caption = 'S&tampante'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    TabOrder = 4
    OnClick = BtnPrinterSetUpClick
  end
  object BtnPreView: TBitBtn
    Left = 180
    Top = 473
    Width = 100
    Height = 25
    Caption = 'Anteprima'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    TabOrder = 5
    OnClick = BtnPreViewClick
  end
  object BtnClose: TBitBtn
    Left = 452
    Top = 473
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 7
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 522
    Width = 591
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 490
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 506
    Width = 591
    Height = 16
    Align = alBottom
    TabOrder = 9
    ExplicitTop = 474
  end
  object BtnStampa: TBitBtn
    Left = 316
    Top = 473
    Width = 100
    Height = 25
    Caption = '&Stampa'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 6
    OnClick = BtnPreViewClick
  end
  object GroupBox1: TGroupBox
    Left = 303
    Top = 29
    Width = 281
    Height = 196
    Caption = 'Selezione dati anagrafici'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object ListaAnagra: TCheckListBox
      Left = 2
      Top = 15
      Width = 277
      Height = 179
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnMouseDown = ListaAnagraMouseDown
      OnMouseUp = ListaAnagraMouseUp
      ExplicitLeft = 8
      ExplicitTop = 17
      ExplicitWidth = 265
      ExplicitHeight = 139
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 80
    Width = 284
    Height = 387
    Caption = 'Opzioni di stampa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 14
      Top = 37
      Width = 103
      Height = 13
      Caption = 'Caratteri per presenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 362
      Width = 25
      Height = 13
      Caption = 'Firma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox5: TGroupBox
      Left = 12
      Top = 216
      Width = 260
      Height = 136
      TabOrder = 11
      object lblTitolo: TLabel
        Left = 14
        Top = 69
        Width = 26
        Height = 13
        Caption = 'Titolo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkData: TCheckBox
        Left = 12
        Top = 14
        Width = 240
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Data di stampa'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object edtTitolo: TEdit
        Left = 47
        Top = 66
        Width = 205
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object chkAzienda: TCheckBox
        Left = 12
        Top = 48
        Width = 240
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Azienda'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
      object chkNumPagina: TCheckBox
        Left = 12
        Top = 31
        Width = 240
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Numero pagina'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
      object gbxLogo: TGroupBox
        Left = 6
        Top = 88
        Width = 246
        Height = 40
        Caption = 'Dimensioni logo per la stampa (pixel)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object lblLarghezza: TLabel
          Left = 12
          Top = 18
          Width = 49
          Height = 13
          Caption = 'Larghezza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblAltezza: TLabel
          Left = 136
          Top = 18
          Width = 35
          Height = 13
          Caption = 'Altezza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtLogoLarghezza: TEdit
          Left = 68
          Top = 15
          Width = 37
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnExit = edtLogoLarghezzaExit
        end
        object edtLogoAltezza: TEdit
          Left = 179
          Top = 15
          Width = 37
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 1
          OnExit = edtLogoAltezzaExit
        end
      end
    end
    object chkSegnalazPresenza: TCheckBox
      Left = 12
      Top = 14
      Width = 261
      Height = 22
      Alignment = taLeftJustify
      Caption = 'Segnalazione presenze'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = chkSegnalazPresenzaClick
    end
    object edtCaratteri: TEdit
      Left = 226
      Top = 34
      Width = 48
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '*****'
    end
    object chkSecCausaleAss: TCheckBox
      Left = 12
      Top = 55
      Width = 261
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Stampa seconda causale assenza'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object chkRigaValoriz: TCheckBox
      Left = 12
      Top = 72
      Width = 261
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Stampa riga valorizzazione'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
    object chkTotIndiv: TCheckBox
      Left = 12
      Top = 89
      Width = 261
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Totali individuali'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object chkSaltoPag: TCheckBox
      Left = 12
      Top = 123
      Width = 261
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Salto pagina per dipendente'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
    end
    object chkIntestazione: TCheckBox
      Left = 24
      Top = 213
      Width = 118
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Stampa intestazione'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 10
      OnClick = chkIntestazioneClick
    end
    object chkStampaAllDip: TCheckBox
      Left = 12
      Top = 140
      Width = 261
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Stampa dipendenti senza assenze'
      TabOrder = 7
    end
    object chkGGSett: TCheckBox
      Left = 12
      Top = 157
      Width = 261
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Stampa GG settimana'
      TabOrder = 8
    end
    object edtFirma: TEdit
      Left = 47
      Top = 359
      Width = 227
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object chkRiepilogoCompetenze: TCheckBox
      Left = 12
      Top = 106
      Width = 261
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Riepilogo delle competenze'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object rgpRichiesteIrisWEB: TRadioGroup
      Left = 12
      Top = 176
      Width = 260
      Height = 33
      Caption = 'Richieste IrisWEB'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'No'
        'Richieste'
        'Autorizzate')
      TabOrder = 9
    end
  end
  object GroupBox3: TGroupBox
    Left = 303
    Top = 231
    Width = 281
    Height = 235
    Caption = 'Selezione causali di assenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object ListaCausali: TCheckListBox
      Left = 2
      Top = 15
      Width = 277
      Height = 218
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      PopupMenu = PopupMenu1
      Sorted = True
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 17
      ExplicitWidth = 265
      ExplicitHeight = 210
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 29
    Width = 284
    Height = 50
    Caption = 'Selezione periodo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 12
      Top = 22
      Width = 25
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 102
      Top = 22
      Width = 42
      Height = 13
      Caption = 'Da mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 195
      Top = 22
      Width = 35
      Height = 13
      Caption = 'A mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDaAnno: TSpinEdit
      Left = 43
      Top = 19
      Width = 52
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      MaxValue = 2900
      MinValue = 1900
      ParentFont = False
      TabOrder = 0
      Value = 1900
      OnChange = edtDaAnnoChange
    end
    object edtDaMese: TSpinEdit
      Left = 149
      Top = 19
      Width = 39
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      MaxValue = 12
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 1
      OnChange = edtDaMeseChange
    end
    object edtAMese: TSpinEdit
      Left = 236
      Top = 19
      Width = 39
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      MaxValue = 12
      MinValue = 1
      ParentFont = False
      TabOrder = 2
      Value = 1
      OnChange = edtAMeseChange
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 591
    Height = 24
    Align = alTop
    TabOrder = 10
    TabStop = True
    ExplicitWidth = 591
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 591
      Height = 24
      ExplicitWidth = 591
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 188
    Top = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 492
    Top = 8
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end

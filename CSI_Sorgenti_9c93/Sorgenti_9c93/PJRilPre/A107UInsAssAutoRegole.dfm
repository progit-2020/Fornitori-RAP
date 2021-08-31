inherited A107FInsAssAutoRegole: TA107FInsAssAutoRegole
  Left = 274
  Top = 212
  HelpContext = 107000
  Caption = '<A107> Regole compensazione giornaliera'
  ClientHeight = 289
  ClientWidth = 450
  ExplicitWidth = 466
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 271
    Width = 450
    SizeGrip = False
    ExplicitTop = 271
    ExplicitWidth = 450
  end
  inherited Panel1: TToolBar
    Width = 450
    ExplicitWidth = 450
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 450
    Height = 242
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 80
      Height = 13
      Caption = 'Causali utilizzabili'
    end
    object Label2: TLabel
      Left = 132
      Top = 4
      Width = 82
      Height = 13
      Caption = 'Causali disponibili'
    end
    object Label3: TLabel
      Left = 278
      Top = 220
      Width = 90
      Height = 13
      Caption = 'Ore max giornaliere'
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 8
      Top = 181
      Width = 169
      Height = 57
      Caption = 'Debito da coprire'
      DataField = 'DEBITO'
      DataSource = DButton
      Items.Strings = (
        'Debito giornaliero'
        'Punti nominali interni')
      ParentBackground = True
      TabOrder = 4
      Values.Strings = (
        'A'
        'B')
    end
    object lstCausali: TListBox
      Left = 8
      Top = 20
      Width = 85
      Height = 160
      DragMode = dmAutomatic
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = btnTogliClick
      OnDragDrop = lstCausaliDragDrop
      OnDragOver = lstCausaliDragOver
    end
    object btnAggiungi: TBitBtn
      Left = 96
      Top = 68
      Width = 33
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAggiungiClick
    end
    object btnTogli: TBitBtn
      Left = 96
      Top = 100
      Width = 33
      Height = 25
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnTogliClick
    end
    object dlstCausaliDisponibili: TDBLookupListBox
      Left = 132
      Top = 20
      Width = 317
      Height = 160
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      TabOrder = 3
      OnDblClick = btnAggiungiClick
    end
    object dchkGiorniVuoti: TDBCheckBox
      Left = 278
      Top = 199
      Width = 171
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Considera giorni vuoti'
      DataField = 'GIORNI_VUOTI'
      DataSource = DButton
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dedtOreMax: TDBEdit
      Left = 400
      Top = 217
      Width = 49
      Height = 21
      DataField = 'ORE_MAX'
      DataSource = DButton
      TabOrder = 7
    end
    object dchkEliminaGiustificativi: TDBCheckBox
      Left = 278
      Top = 181
      Width = 171
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Elimina giustificativi preesistenti'
      DataField = 'ELIMINA_GIUSTIFICATIVI'
      DataSource = DButton
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 289
    Top = 29
  end
  inherited DButton: TDataSource
    Left = 261
    Top = 29
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 233
    Top = 29
  end
  inherited ImageList1: TImageList
    Left = 317
    Top = 29
  end
  inherited ActionList1: TActionList
    Left = 345
    Top = 29
    inherited actRicerca: TAction
      Visible = False
    end
    inherited actPrimo: TAction
      Visible = False
    end
    inherited actPrecedente: TAction
      Visible = False
    end
    inherited actSuccessivo: TAction
      Visible = False
    end
    inherited actUltimo: TAction
      Visible = False
    end
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
  end
end

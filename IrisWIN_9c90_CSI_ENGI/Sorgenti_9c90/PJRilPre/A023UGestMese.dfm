object A023FGestMese: TA023FGestMese
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A023> Gestione mensile cartellino'
  ClientHeight = 546
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 372
    Width = 734
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 359
    ExplicitWidth = 636
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 131
    Width = 734
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -2
    ExplicitTop = 126
  end
  object dgrdGestMese: TDBGrid
    Left = 0
    Top = 271
    Width = 734
    Height = 101
    Align = alClient
    DataSource = A023FTimbratureDtM1.dscGestMese
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dgrdGestMeseDrawColumnCell
    OnExit = dgrdGestMeseExit
    OnKeyDown = dgrdGestMeseKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'FLAG_RIGA'
        Title.Alignment = taCenter
        Title.Caption = 'T'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 16
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FLAG_RIGA_SUBCOD'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_CONTEGGI'
        Title.Alignment = taCenter
        Title.Caption = 'Data conteggi'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_ORIG'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DALLE_ORIG'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ALLE_ORIG'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DALLE_H'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ALLE_H'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 43
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'C_AUTORIZZATO'
        Title.Alignment = taCenter
        Title.Caption = 'Autorizzato'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAUSALE'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_CAUSALE'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 259
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTLAV'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DEBITOGG'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SCOST'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'C_TOTLAV_H'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'C_DEBITOGG_H'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'C_SCOST_H'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'C_ARROT_RIEPGG'
        Title.Alignment = taCenter
        Title.Caption = 'Arrot_RiepGG'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'C_MODIFICATO'
        Title.Alignment = taCenter
        Title.Caption = 'Mod.'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FLEX'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_EVENTO_STR'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'ID Evento str.'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SERVIZIO'
        Title.Alignment = taCenter
        Title.Caption = 'Servizio'
        Visible = False
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 734
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblDipendente: TLabel
      Left = 10
      Top = 7
      Width = 65
      Height = 13
      Caption = 'lblDipendente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 305
      Top = 7
      Width = 53
      Height = 13
      Caption = 'Periodo dal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 479
      Top = 7
      Width = 8
      Height = 13
      Caption = 'al'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDataDa: TMaskEdit
      Left = 374
      Top = 4
      Width = 73
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object edtDataA: TMaskEdit
      Left = 494
      Top = 4
      Width = 73
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      Text = '  /  /    '
      OnDblClick = edtDataADblClick
    end
    object btnDataDa: TBitBtn
      Left = 452
      Top = 4
      Width = 18
      Height = 21
      Hint = 'Seleziona la data di inizio periodo'
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnDataDaClick
    end
    object btnDataA: TBitBtn
      Left = 572
      Top = 4
      Width = 18
      Height = 21
      Hint = 'Seleziona la data di fine periodo'
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnDataAClick
    end
    object btnSetPeriodo: TBitBtn
      Left = 604
      Top = 3
      Width = 28
      Height = 25
      Hint = 'Aggiorna la griglia in base al periodo indicato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnSetPeriodoClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 527
    Width = 734
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object pnlTop1: TPanel
    Left = 0
    Top = 136
    Width = 734
    Height = 90
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object rgpTipo: TRadioGroup
      Left = 0
      Top = 0
      Width = 176
      Height = 90
      Align = alLeft
      Caption = 'Filtro tipologia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Tutti'
        'Straordinario'
        'Assenza')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpTipoClick
    end
    object grpFiltriVisualizzazione: TGroupBox
      Left = 176
      Top = 0
      Width = 558
      Height = 90
      Align = alClient
      Caption = 'Filtri visualizzazione'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object chkFiltroScost: TCheckBox
        Left = 16
        Top = 18
        Width = 165
        Height = 17
        Caption = 'Filtra giorni con scostamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkFiltroScostClick
      end
      object edtSogliaScost: TMaskEdit
        Left = 293
        Top = 16
        Width = 42
        Height = 21
        EditMask = '!#00:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 2
        Text = ':  .  '
        OnChange = edtSogliaScostChange
        OnExit = edtSogliaScostExit
      end
      object cmbFiltroScost: TComboBox
        Left = 198
        Top = 16
        Width = 89
        Height = 21
        Style = csDropDownList
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Text = 'minore di'
        OnChange = cmbFiltroScostChange
        Items.Strings = (
          'minore di'
          'maggiore di'
          'uguale a')
      end
      object chkFiltroDalleAlle: TCheckBox
        Left = 16
        Top = 43
        Width = 179
        Height = 17
        Caption = 'Filtra periodi dalle-alle maggiori di'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chkFiltroScostClick
      end
      object edtSogliaDalleAlle: TMaskEdit
        Left = 198
        Top = 41
        Width = 37
        Height = 21
        EditMask = '!90:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 4
        Text = '  .  '
        OnChange = edtSogliaDalleAlleChange
        OnExit = edtSogliaDalleAlleExit
      end
      object chkFiltroStraordCaus: TCheckBox
        Left = 16
        Top = 68
        Width = 273
        Height = 17
        Caption = 'Filtra straordinari da autorizzare solo se causalizzati'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = chkFiltroScostClick
      end
    end
  end
  object grpStraordinarioStandard: TGroupBox
    Left = 0
    Top = 226
    Width = 734
    Height = 45
    Align = alTop
    Caption = 'Assegnazione straordinario standard'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 20
      Width = 41
      Height = 13
      Caption = 'Causale:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cmbCausPres: TComboBox
      Left = 58
      Top = 17
      Width = 287
      Height = 21
      Style = csDropDownList
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyDown = cmbCausPresKeyDown
    end
    object btnAssegnaCausStraord: TBitBtn
      Left = 357
      Top = 15
      Width = 67
      Height = 25
      Caption = 'A&ssegna'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAssegnaCausClick
    end
    object chkSovrascrivi: TCheckBox
      Left = 440
      Top = 20
      Width = 156
      Height = 17
      Hint = 
        'Assegna la causale di straordinario anche alle righe gi'#224' imposta' +
        'te'
      Caption = 'Sovrascrivi causali esistenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 377
    Width = 734
    Height = 150
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object pnlPulsanti: TPanel
      Left = 0
      Top = 0
      Width = 734
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        734
        28)
      object btnClose: TBitBtn
        Left = 540
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akTop]
        Caption = '&Chiudi'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
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
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        OnClick = btnCloseClick
      end
      object btnAnnulla: TBitBtn
        Left = 264
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akTop]
        Caption = 'A&nnulla'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C00401F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00401F7C1F7C1F7C1F7C1F7C1F7C
          1F7C007C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C1F7C1F7C1F7C1F7C
          00401F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C007C1F7C1F7C1F7C1F7C007C
          00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C0040007C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C0040007C007C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C004000401F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C007C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C00401F7C1F7C1F7C1F7C0040
          007C1F7C1F7C1F7C1F7C1F7C0040007C0040007C1F7C1F7C1F7C1F7C1F7C1F7C
          0040007C1F7C1F7C1F7C1F7C007C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C0040007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        ParentFont = False
        TabOrder = 0
        OnClick = btnAnnullaClick
      end
      object btnResetPianifCaus: TBitBtn
        Left = 402
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akTop]
        Caption = '&Reset'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFF99999FFFFFFFFF999999999FFFFFF999F707F999FFFF999FF000FF9
          99FFF99FFF707FFF99FF99FFFFFFFFFFF99F99FFFFF0FFFFF99F99FFFF707FFF
          FFFF99FFFF101FFFFFFF99FFFF000F99999FF99FFF000FF9999FF999FF000FFF
          999FFF999F707F99999FFFF999999999FF9FFFFFF99999FFFFFF}
        ParentFont = False
        TabOrder = 1
        OnClick = btnResetPianifCausClick
      end
      object btnConferma: TBitBtn
        Left = 124
        Top = 3
        Width = 80
        Height = 25
        Anchors = [akTop]
        Caption = 'C&onferma'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000200021F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0002000200021F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C00020002E003E00300021F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C0002E003E0031F7CE00300021F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7CE003E0031F7C1F7CE003E00300021F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE0030002
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE003
          00021F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        ModalResult = 1
        ParentFont = False
        TabOrder = 3
        OnClick = btnConfermaClick
      end
    end
    object grpRiepilogoCausali: TGroupBox
      Left = 0
      Top = 28
      Width = 734
      Height = 122
      Align = alClient
      Caption = 'Riepilogo causalizzazioni'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object dgrdBudgetServizi: TDBGrid
        AlignWithMargins = True
        Left = 434
        Top = 31
        Width = 295
        Height = 86
        Align = alClient
        DataSource = A023FTimbratureDtM1.dsrT723
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        OnDrawColumnCell = dgrdBudgetServiziDrawColumnCell
      end
      object pnlTotCaus: TPanel
        Left = 2
        Top = 15
        Width = 730
        Height = 13
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblTotStraord: TLabel
          Left = 101
          Top = 1
          Width = 31
          Height = 13
          Caption = 'hh:mm'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 3
          Top = 1
          Width = 93
          Height = 13
          Caption = 'Totale straordinario:'
        end
        object lblBudgetServizi: TLabel
          Left = 432
          Top = 0
          Width = 90
          Height = 13
          Caption = 'Budget per servizio'
          Visible = False
        end
      end
      object dgrdCausOre: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 31
        Width = 423
        Height = 86
        Align = alLeft
        DataSource = dscCausOre
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = dgrdCausOreDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'CAUSALE'
            ReadOnly = True
            Title.Caption = 'Causale'
            Width = 201
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORE'
            ReadOnly = True
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ORE_H'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AVVISO'
            Title.Caption = 'Avviso'
            Visible = False
          end>
      end
    end
  end
  object grpEventiStraordinari: TGroupBox
    Left = 0
    Top = 28
    Width = 734
    Height = 103
    Align = alTop
    TabOrder = 6
    object dgrdT722: TDBGrid
      Left = 2
      Top = 15
      Width = 730
      Height = 86
      Align = alClient
      DataSource = A023FTimbratureDtM1.dsrT722
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dgrdT722DblClick
    end
    object chkEventiStraordinari: TCheckBox
      Left = 3
      Top = -1
      Width = 201
      Height = 16
      Caption = 'Usa regole Eventi Straordinari'
      TabOrder = 1
      OnClick = chkEventiStraordinariClick
    end
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsTempIdxCausaleData'
        Fields = 'CAUSALE;DATA'
        GroupingLevel = 2
      end>
    IndexName = 'cdsTempIdxCausaleData'
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsTempCalcFields
    Left = 312
    Top = 456
    object cdsTempCAUSALE: TStringField
      FieldName = 'CAUSALE'
    end
    object cdsTempDATA: TDateTimeField
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsTempORE: TIntegerField
      FieldName = 'ORE'
    end
    object cdsTempC_ARROT_RIEPGG: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'C_ARROT_RIEPGG'
      Calculated = True
    end
  end
  object cdsCausOre: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsCausOreIdxCausale'
        Fields = 'CAUSALIZZATO;CAUSALE'
        GroupingLevel = 1
      end>
    IndexName = 'cdsCausOreIdxCausale'
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsCausOreCalcFields
    Left = 384
    Top = 456
    object cdsCausOreCAUSALIZZATO: TIntegerField
      FieldName = 'CAUSALIZZATO'
    end
    object cdsCausOreCAUSALE: TStringField
      FieldName = 'CAUSALE'
    end
    object cdsCausOreORE: TIntegerField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      Visible = False
    end
    object cdsCausOreORE_H: TStringField
      Alignment = taCenter
      DisplayLabel = 'Ore'
      FieldKind = fkCalculated
      FieldName = 'ORE_H'
      Size = 6
      Calculated = True
    end
    object cdsCausOreAVVISO: TStringField
      DisplayWidth = 20
      FieldName = 'AVVISO'
      Size = 50
    end
  end
  object dscCausOre: TDataSource
    DataSet = cdsCausOre
    Left = 448
    Top = 456
  end
  object actlstBase: TActionList
    Images = ImageList1
    Left = 216
    Top = 306
    object actDuplica: TAction
      Caption = '&Duplica'
      ImageIndex = 0
      OnExecute = actDuplicaExecute
    end
    object actInserisci: TAction
      Caption = '&Inserisci'
      ImageIndex = 1
      OnExecute = actInserisciExecute
    end
    object actElimina: TAction
      Caption = '&Elimina'
      ImageIndex = 2
      OnExecute = actEliminaExecute
    end
  end
  object ImageList1: TImageList
    Left = 282
    Top = 306
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400848484008484840000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      0000000000000000000000008400000084008484840084848400000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000084848400000084000000840084848400000000000000
      0000000000008484840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000000000000000000084000000840084848400848484000000
      0000000084000000840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      8400000084000000840000000000848484000000840000008400848484008484
      8400000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000840000008400000084000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000008484840000008400000084000000
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000084848400848484000000840000008400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000008484840000008400000084000000000000000000848484000000
      8400000084008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000084000000840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FC03DFFFFC7C0000FD0BCFF7DC3C0000C1FBC7D5CC390000
      FD0BC3E3C6110000E1FBC181C2030000FD03C3E3C1070000E1D7C7D5C3070000
      FDCFCFF7C4030000E41FDFFFC8C10000FDFFFFFFDFE00000C3FFFFFFFFF90000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    OnPopup = PopupMenu1Popup
    Left = 354
    Top = 306
    object Duplica1: TMenuItem
      Action = actDuplica
    end
    object Nuova1: TMenuItem
      Action = actInserisci
    end
    object Elimina1: TMenuItem
      Action = actElimina
    end
  end
  object cdsGestMeseTemp: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnFilterRecord = cdsGestMeseTempFilterRecord
    Left = 576
    Top = 312
    object cdsGestMeseTempID: TIntegerField
      FieldName = 'ID'
    end
    object cdsGestMeseTempGIORNO: TDateField
      FieldName = 'GIORNO'
    end
    object cdsGestMeseTempDALLE: TIntegerField
      FieldName = 'DALLE'
    end
    object cdsGestMeseTempALLE: TIntegerField
      FieldName = 'ALLE'
    end
  end
end

object A056FTurnazInd: TA056FTurnazInd
  Left = 370
  Top = 259
  HelpContext = 56000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A056> Assegnazione turnazioni'
  ClientHeight = 493
  ClientWidth = 551
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
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 551
    Height = 209
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 7
      Top = 8
      Width = 53
      Height = 13
      Caption = 'Turnazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 56
      Width = 83
      Height = 13
      Caption = 'Punto di partenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 181
      Top = 8
      Width = 143
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 31
      Width = 78
      Height = 13
      Caption = 'Data di partenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 161
      Top = 29
      Width = 18
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object ETurnazione: TDBLookupComboBox
      Left = 95
      Top = 5
      Width = 86
      Height = 21
      DropDownWidth = 400
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      PopupMenu = PopupMenu2
      TabOrder = 0
      OnKeyDown = ETurnazioneKeyDown
    end
    object EPartenza: TSpinEdit
      Left = 95
      Top = 53
      Width = 66
      Height = 22
      MaxLength = 4
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object Button1: TButton
      Left = 161
      Top = 53
      Width = 18
      Height = 23
      Caption = '...'
      TabOrder = 4
      OnClick = Button1Click
    end
    object BInserimento: TBitBtn
      Left = 207
      Top = 177
      Width = 92
      Height = 23
      Caption = 'Inserisci'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000CE0E0000D80E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080000080000080FF
        FFFFFFFFFF800000800000800000800000800000800000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 7
      OnClick = BInserimentoClick
    end
    object BitBtn2: TBitBtn
      Left = 309
      Top = 177
      Width = 92
      Height = 23
      Caption = 'Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF188FFFFF88FF1FFF1188FF
        FF10FF11FF8118FFF81FFF111FF1188F118FFF1111F8118811FFFF11111F1111
        1FFFFF1111FF81118FFFFF111F88111188FFFF11F811FF81188FFF1FFFFFFFF8
        1180FFFFFFFFFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 8
      OnClick = BInserimentoClick
    end
    object chkDipendenteCorrente: TCheckBox
      Left = 7
      Top = 179
      Width = 154
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Esegui per tutti i dipendenti '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkDipendenteCorrenteClick
    end
    object edtDataAss: TMaskEdit
      Left = 95
      Top = 29
      Width = 66
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnExit = edtDataAssExit
    end
    object GrpParInserimento: TGroupBox
      Left = 7
      Top = 77
      Width = 394
      Height = 94
      Caption = 'Parametri inserimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object chkRiposi: TCheckBox
        Left = 11
        Top = 67
        Width = 154
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Verifica turni sui riposi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object chkGGLav: TCheckBox
        Left = 11
        Top = 44
        Width = 154
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Verifica turni sui gg lav.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ChkPianif_da_calendario: TCheckBox
        Left = 11
        Top = 22
        Width = 154
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Pianificazione da calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object GrpBoxInsAutomatico: TGroupBox
        Left = 178
        Top = 13
        Width = 213
        Height = 78
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object GrpControlloMaxMin: TRadioGroup
          Left = 5
          Top = 17
          Width = 204
          Height = 36
          Caption = 'Controllo Max/Min'
          Columns = 2
          Items.Strings = (
            'Squadra'
            'Tipo Operatore')
          TabOrder = 0
        end
        object chkPregresso: TCheckBox
          Left = 6
          Top = 55
          Width = 203
          Height = 18
          Alignment = taLeftJustify
          Caption = 'Considera turnazione pregressa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object chkInsAutomatico: TCheckBox
        Left = 182
        Top = 10
        Width = 183
        Height = 18
        Alignment = taLeftJustify
        Caption = 'Inserimento con controllo Max/Min'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chkInsAutomaticoClick
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 233
    Width = 551
    Height = 225
    Align = alClient
    DataSource = A056FTurnazIndDtM1.D620
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = ppMnuTurniAssegnati
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = DBGrid1EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURNAZIONE'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'PARTENZA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PIANIF_DA_CALENDARIO'
        Width = 137
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VERIFICA_TURNI'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VERIFICA_RIPOSI'
        Width = 64
        Visible = True
      end>
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 474
    Width = 551
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 458
    Width = 551
    Height = 16
    Align = alBottom
    TabOrder = 3
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 551
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 551
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 551
      Height = 24
      ExplicitWidth = 551
      ExplicitHeight = 24
      inherited btnSuccessivo: TSpeedButton
        OnClick = frmSelAnagrafebtnSuccessivoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 240
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 236
    Top = 32
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object ppMnuTurniAssegnati: TPopupMenu
    OnPopup = ppMnuTurniAssegnatiPopup
    Left = 424
    Top = 344
    object Assegnaturnoalladata1: TMenuItem
      Caption = 'Imposta turnazione alla data di partenza indicata'
      OnClick = Assegnaturnoalladata1Click
    end
  end
end

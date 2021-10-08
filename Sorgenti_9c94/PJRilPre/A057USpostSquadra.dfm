object A057FSpostSquadra: TA057FSpostSquadra
  Left = 119
  Top = 140
  HelpContext = 57000
  Caption = '<A057> Spostamenti di squadra'
  ClientHeight = 311
  ClientWidth = 468
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
    Width = 468
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 9
      Top = 37
      Width = 32
      Height = 13
      Caption = 'Label3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 115
      Top = 45
      Width = 28
      Height = 13
      Caption = 'Orario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 270
      Top = 47
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = A057FSpostSquadraDtM1.D020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 115
      Top = 17
      Width = 40
      Height = 13
      Caption = 'Squadra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 270
      Top = 19
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = A057FSpostSquadraDtM1.D600
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTurno1: TLabel
      Left = 115
      Top = 69
      Width = 37
      Height = 13
      Caption = 'Turno 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTurno2: TLabel
      Left = 168
      Top = 69
      Width = 37
      Height = 13
      Caption = 'Turno 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 6
      Top = 11
      Width = 57
      Height = 21
      Caption = 'Data...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object EOrario: TDBLookupComboBox
      Left = 168
      Top = 43
      Width = 93
      Height = 21
      DropDownWidth = 400
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A057FSpostSquadraDtM1.D020
      PopupMenu = PopupMenu2
      TabOrder = 2
      OnKeyDown = ESquadraKeyDown
    end
    object BInserimento: TBitBtn
      Left = 271
      Top = 83
      Width = 87
      Height = 23
      Caption = 'Inserimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = BInserimentoClick
    end
    object ESquadra: TDBLookupComboBox
      Left = 168
      Top = 15
      Width = 92
      Height = 21
      DropDownWidth = 400
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A057FSpostSquadraDtM1.D600
      PopupMenu = PopupMenu2
      TabOrder = 1
      OnKeyDown = ESquadraKeyDown
    end
    object cmbTurno1: TComboBox
      Left = 115
      Top = 84
      Width = 45
      Height = 21
      MaxLength = 2
      TabOrder = 3
      Items.Strings = (
        ''
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object cmbTurno2: TComboBox
      Left = 168
      Top = 84
      Width = 45
      Height = 21
      MaxLength = 2
      TabOrder = 4
      Items.Strings = (
        ''
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 145
    Width = 468
    Height = 147
    Align = alClient
    DataSource = A057FSpostSquadraDtM1.D630
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 468
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 468
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 468
      Height = 24
      ExplicitWidth = 468
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 292
    Width = 468
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 36
    Top = 176
    object Cancella1: TMenuItem
      Caption = 'Cancella'
      OnClick = Cancella1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 300
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end

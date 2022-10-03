object A067FRepSostB: TA067FRepSostB
  Left = 317
  Top = 270
  HelpContext = 67000
  BorderStyle = bsSingle
  Caption = '<A067> Turni di reperibilit'#224' sostitutivi'
  ClientHeight = 144
  ClientWidth = 453
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
  object Label2: TLabel
    Left = 12
    Top = 30
    Width = 38
    Height = 13
    Caption = 'Da data'
  end
  object Label3: TLabel
    Left = 92
    Top = 30
    Width = 31
    Height = 13
    Caption = 'A data'
  end
  object Label1: TLabel
    Left = 171
    Top = 30
    Width = 85
    Height = 13
    Caption = 'Causale correttiva'
  end
  object EDaData: TMaskEdit
    Left = 12
    Top = 46
    Width = 71
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnExit = EDaDataExit
  end
  object EAData: TMaskEdit
    Left = 92
    Top = 46
    Width = 71
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object ECausale: TDBLookupComboBox
    Left = 171
    Top = 46
    Width = 109
    Height = 21
    DropDownWidth = 360
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = A067FRepSostBMW.D265
    TabOrder = 2
    OnKeyDown = ECausaleKeyDown
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 125
    Width = 453
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PB1: TProgressBar
    Left = 0
    Top = 109
    Width = 453
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  object BInserisci: TBitBtn
    Left = 12
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Inserisci'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BInserisciClick
  end
  object BitBtn2: TBitBtn
    Left = 204
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 6
  end
  object BElimina: TBitBtn
    Left = 92
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Elimina'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = BInserisciClick
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 453
    Height = 24
    Align = alTop
    TabOrder = 8
    TabStop = True
    ExplicitWidth = 453
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 453
      Height = 24
      ExplicitWidth = 453
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = TfrmSelAnagrafe1R003DatianagraficiClick
      end
    end
  end
end

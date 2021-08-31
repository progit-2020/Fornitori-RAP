object A052FProprieta: TA052FProprieta
  Left = 399
  Top = 263
  HelpContext = 52100
  Caption = 'Propriet'#224
  ClientHeight = 332
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Totali: TCheckBox
    Left = 18
    Top = 219
    Width = 97
    Height = 17
    Caption = 'Totali'
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 166
    Top = 8
    Width = 225
    Height = 283
    Caption = 'Timbrature'
    TabOrder = 1
    object LAnomOrologio: TLabel
      Left = 16
      Top = 60
      Width = 167
      Height = 13
      Caption = 'Segnalazione orologio non abilitato:'
    end
    object Causale: TRadioGroup
      Left = 8
      Top = 79
      Width = 209
      Height = 87
      Caption = 'Causale'
      ItemIndex = 0
      Items.Strings = (
        'No                   (Ehhmm)'
        'Sigla                (EhhmmX)'
        'Sigla separata (Ehhmm-X)'
        'Codice            (Ehhmm-XXXXX)')
      TabOrder = 3
    end
    object Orologio: TCheckBox
      Left = 16
      Top = 17
      Width = 65
      Height = 17
      Caption = 'Orologio'
      TabOrder = 0
    end
    object EAnomOrologio: TDBEdit
      Left = 189
      Top = 57
      Width = 23
      Height = 21
      DataField = 'ANOMALIA'
      DataSource = A052FParCar.DButton
      MaxLength = 1
      TabOrder = 2
    end
    object btnAnomalie2: TButton
      Left = 48
      Top = 223
      Width = 125
      Height = 25
      Caption = 'Anomalie di 2'#176' livello...'
      TabOrder = 4
      OnClick = btnAnomalie2Click
    end
    object btnANomalie3: TButton
      Left = 48
      Top = 251
      Width = 125
      Height = 25
      Caption = 'Anomalie di 3'#176' livello...'
      TabOrder = 5
      OnClick = btnAnomalie2Click
    end
    object gpbCauPresEscluse: TGroupBox
      Left = 8
      Top = 170
      Width = 209
      Height = 47
      Caption = 'Causali di presenza da non visualizzare'
      TabOrder = 6
      object sbtnCauPresEscluse: TSpeedButton
        Left = 188
        Top = 17
        Width = 17
        Height = 22
        Caption = '...'
        OnClick = btnAnomalie2Click
      end
      object dedtCauPresEscluse: TDBEdit
        Left = 8
        Top = 18
        Width = 177
        Height = 21
        DataField = 'CAUPRES_ESCLUSE'
        DataSource = A052FParCar.DButton
        MaxLength = 1
        ReadOnly = True
        TabOrder = 0
      end
    end
    object dchkTimbratureManuali: TDBCheckBox
      Left = 16
      Top = 37
      Width = 167
      Height = 17
      Caption = 'Evidenzia timbrature manuali'
      DataField = 'TIMBRATURE_MANUALI'
      DataSource = A052FParCar.DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object Giustificativi: TRadioGroup
    Left = 8
    Top = 87
    Width = 156
    Height = 58
    Caption = 'Giustificativi'
    ItemIndex = 0
    Items.Strings = (
      'Codice causale'
      'Descrizione causale')
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 119
    Top = 297
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 204
    Top = 297
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object GiorniMese: TGroupBox
    Left = 8
    Top = 8
    Width = 156
    Height = 73
    Caption = 'Giorni del mese'
    TabOrder = 5
    object DBCheckBox1: TDBCheckBox
      Left = 10
      Top = 15
      Width = 129
      Height = 17
      Caption = 'Domenica e Festivi'
      DataField = 'FESTIVO'
      DataSource = A052FParCar.DButton
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox2: TDBCheckBox
      Left = 10
      Top = 32
      Width = 129
      Height = 17
      Caption = 'Non lavorativi'
      DataField = 'NONLAV'
      DataSource = A052FParCar.DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox3: TDBCheckBox
      Left = 10
      Top = 50
      Width = 141
      Height = 17
      Caption = 'Segnalazione in grassetto'
      DataField = 'GRASSETTO'
      DataSource = A052FParCar.DButton
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object Turno: TRadioGroup
    Left = 8
    Top = 151
    Width = 156
    Height = 58
    Caption = 'Turno'
    ItemIndex = 0
    Items.Strings = (
      'Numero'
      'Sigla')
    TabOrder = 6
  end
end

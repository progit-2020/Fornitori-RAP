inherited A100FTipiPagamento: TA100FTipiPagamento
  Left = 166
  Top = 154
  Caption = '<A100> Modalit'#224' di pagamento'
  ExplicitWidth = 558
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 13
  object GpbModalita: TGroupBox [2]
    Left = 0
    Top = 138
    Width = 542
    Height = 277
    Align = alClient
    Caption = 'Modalit'#224' di pagamento'
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 538
      Height = 260
      Align = alClient
      DataSource = DButton
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODICE'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIZIONE'
          Width = 326
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SOMMA'
          Title.Caption = 'Rimborsare'
          Width = 59
          Visible = True
        end>
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 29
    Width = 542
    Height = 109
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 19
      Top = 11
      Width = 36
      Height = 13
      Caption = 'Codice:'
    end
    object Label2: TLabel
      Left = 19
      Top = 43
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
    end
    object dEdtCodice: TDBEdit
      Left = 80
      Top = 8
      Width = 65
      Height = 21
      DataField = 'CODICE'
      TabOrder = 0
    end
    object dEdtDescrizione: TDBEdit
      Left = 80
      Top = 40
      Width = 377
      Height = 21
      DataField = 'DESCRIZIONE'
      TabOrder = 1
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 81
      Top = 70
      Width = 160
      Height = 34
      Caption = 'Rimborsare al dipendente'
      Columns = 2
      DataField = 'SOMMA'
      Items.Strings = (
        'Si'
        'No')
      TabOrder = 2
      Values.Strings = (
        'S'
        'N')
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 328
    Top = 18
  end
  inherited DButton: TDataSource
    Left = 356
    Top = 18
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 384
    Top = 18
  end
  inherited ImageList1: TImageList
    Left = 412
    Top = 18
  end
  inherited ActionList1: TActionList
    Left = 440
    Top = 18
  end
end

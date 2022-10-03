inherited A172FSchedeQuantObiettivi: TA172FSchedeQuantObiettivi
  HelpContext = 172100
  Caption = '<A172> Obiettivi schede dei posizionati'
  ClientHeight = 354
  ClientWidth = 614
  ExplicitWidth = 630
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  object lblPeso1: TLabel [0]
    Left = 521
    Top = 97
    Width = 33
    Height = 13
    Caption = 'Peso 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblObiettivo1: TLabel [1]
    Left = 8
    Top = 97
    Width = 51
    Height = 13
    Caption = 'Obiettivo 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 155
    Width = 51
    Height = 13
    Caption = 'Obiettivo 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [3]
    Left = 521
    Top = 155
    Width = 33
    Height = 13
    Caption = 'Peso 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [4]
    Left = 8
    Top = 214
    Width = 51
    Height = 13
    Caption = 'Obiettivo 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [5]
    Left = 521
    Top = 214
    Width = 33
    Height = 13
    Caption = 'Peso 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel [6]
    Left = 8
    Top = 275
    Width = 51
    Height = 13
    Caption = 'Obiettivo 4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [7]
    Left = 521
    Top = 275
    Width = 33
    Height = 13
    Caption = 'Peso 4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [8]
    Left = 34
    Top = 68
    Width = 25
    Height = 13
    Caption = 'Anno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel [9]
    Left = 230
    Top = 68
    Width = 78
    Height = 13
    Caption = 'Tipo stampa ind.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited StatusBar: TStatusBar
    Top = 336
    Width = 614
    ExplicitTop = 336
    ExplicitWidth = 614
  end
  inherited Panel1: TToolBar
    Top = 29
    Width = 614
    TabOrder = 9
    ExplicitTop = 29
    ExplicitWidth = 614
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [12]
    Left = 0
    Top = 0
    Width = 614
    Height = 29
    Align = alTop
    TabOrder = 10
    TabStop = True
    ExplicitWidth = 614
    inherited pnlSelAnagrafe: TPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  object dedtPeso1: TDBEdit [13]
    Left = 560
    Top = 94
    Width = 40
    Height = 21
    DataField = 'PESO1'
    DataSource = DButton
    TabOrder = 1
  end
  object dedtPeso2: TDBEdit [14]
    Left = 560
    Top = 152
    Width = 40
    Height = 21
    DataField = 'PESO2'
    DataSource = DButton
    TabOrder = 3
  end
  object dedtPeso3: TDBEdit [15]
    Left = 560
    Top = 211
    Width = 40
    Height = 21
    DataField = 'PESO3'
    DataSource = DButton
    TabOrder = 5
  end
  object dedtPeso4: TDBEdit [16]
    Left = 560
    Top = 272
    Width = 40
    Height = 21
    DataField = 'PESO4'
    DataSource = DButton
    TabOrder = 7
  end
  object dedtAnno: TDBEdit [17]
    Left = 65
    Top = 65
    Width = 40
    Height = 21
    TabStop = False
    Color = cl3DLight
    DataField = 'ANNO'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object edtTipoStampa: TEdit [18]
    Left = 314
    Top = 65
    Width = 200
    Height = 21
    TabStop = False
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
    Text = 'edtTipoStampa'
  end
  object dmemObiettivo1: TDBMemo [19]
    Left = 66
    Top = 94
    Width = 449
    Height = 50
    DataField = 'OBIETTIVO1'
    DataSource = DButton
    MaxLength = 1000
    TabOrder = 0
  end
  object dmemObiettivo2: TDBMemo [20]
    Left = 66
    Top = 152
    Width = 449
    Height = 50
    DataField = 'OBIETTIVO2'
    DataSource = DButton
    MaxLength = 1000
    TabOrder = 2
  end
  object dmemObiettivo3: TDBMemo [21]
    Left = 66
    Top = 211
    Width = 449
    Height = 50
    DataField = 'OBIETTIVO3'
    DataSource = DButton
    MaxLength = 1000
    TabOrder = 4
  end
  object dmemObiettivo4: TDBMemo [22]
    Left = 66
    Top = 272
    Width = 449
    Height = 50
    TabStop = False
    Color = cl3DLight
    DataField = 'OBIETTIVO4'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 1000
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  inherited MainMenu1: TMainMenu [23]
    Left = 392
    Top = 2
  end
  inherited DButton: TDataSource [24]
    Left = 420
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [25]
    Left = 448
    Top = 2
  end
  inherited ImageList1: TImageList [26]
    Left = 476
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 2
  end
end

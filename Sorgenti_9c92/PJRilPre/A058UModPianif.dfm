object A058FModPianif: TA058FModPianif
  Left = 289
  Top = 284
  BorderStyle = bsDialog
  Caption = '<A058> Dati di pianificazione'
  ClientHeight = 287
  ClientWidth = 281
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
  object Label1: TLabel
    Left = 10
    Top = 6
    Width = 31
    Height = 13
    Caption = 'Orario:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 107
    Top = 23
    Width = 42
    Height = 13
    AutoSize = True
    DataField = 'DESCRIZIONE'
    DataSource = D020
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 10
    Top = 46
    Width = 90
    Height = 13
    Caption = 'Num.fascia 1'#176'turno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 157
    Top = 46
    Width = 90
    Height = 13
    Caption = 'Num.fascia 2'#176'turno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblPNT1: TLabel
    Left = 11
    Top = 82
    Width = 72
    Height = 13
    Caption = 'E06.30 U14.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblPNT2: TLabel
    Left = 157
    Top = 82
    Width = 41
    Height = 13
    Caption = '1'#176' Turno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSiglaT1: TLabel
    Left = 111
    Top = 63
    Width = 15
    Height = 13
    Caption = '(M)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSiglaT2: TLabel
    Left = 259
    Top = 63
    Width = 15
    Height = 13
    Caption = '(M)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object EOrario: TDBLookupComboBox
    Left = 10
    Top = 19
    Width = 89
    Height = 21
    DropDownWidth = 400
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = D020
    TabOrder = 0
    OnClick = EOrarioClick
    OnCloseUp = EAssenza1CloseUp
    OnExit = EOrarioExit
    OnKeyDown = EOrarioKeyDown
  end
  object BitBtn1: TBitBtn
    Left = 60
    Top = 254
    Width = 75
    Height = 25
    Caption = 'OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 141
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 2
  end
  object cmbTurno1: TComboBox
    Left = 10
    Top = 59
    Width = 60
    Height = 21
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    TabOrder = 3
    OnChange = cmbTurno1Change
    Items.Strings = (
      '0 - Riposo'
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
  object cmbTurno1EU: TComboBox
    Left = 72
    Top = 59
    Width = 40
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      'E'
      'U')
  end
  object cmbTurno2: TComboBox
    Left = 157
    Top = 59
    Width = 60
    Height = 21
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    TabOrder = 5
    OnChange = cmbTurno1Change
    Items.Strings = (
      '0 - Riposo'
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
  object cmbTurno2EU: TComboBox
    Left = 219
    Top = 59
    Width = 40
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Items.Strings = (
      'E'
      'U')
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 101
    Width = 264
    Height = 138
    Caption = 'Assenze'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object Label2: TLabel
      Left = 10
      Top = 19
      Width = 53
      Height = 13
      Caption = '1'#176'Assenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 11
      Top = 38
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = D265
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 10
      Top = 58
      Width = 53
      Height = 13
      Caption = '2'#176'Assenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 11
      Top = 77
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = D265B
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label4: TLabel
      Left = 11
      Top = 93
      Width = 16
      Height = 13
      Caption = 'Dal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 86
      Top = 93
      Width = 9
      Height = 13
      Caption = 'Al'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EAssenza1: TDBLookupComboBox
      Left = 69
      Top = 15
      Width = 89
      Height = 21
      DropDownWidth = 400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = D265
      ParentFont = False
      TabOrder = 0
      OnCloseUp = EAssenza1CloseUp
      OnKeyDown = EOrarioKeyDown
    end
    object EAssenza2: TDBLookupComboBox
      Left = 69
      Top = 55
      Width = 89
      Height = 21
      DropDownWidth = 400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = D265B
      ParentFont = False
      TabOrder = 1
      OnCloseUp = EAssenza1CloseUp
      OnKeyDown = EOrarioKeyDown
    end
    object edtDaData: TMaskEdit
      Left = 11
      Top = 108
      Width = 68
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
    end
    object edtAData: TMaskEdit
      Left = 86
      Top = 108
      Width = 68
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
    end
  end
  object D020: TDataSource
    DataSet = A058FPianifTurniDtM1.Q020
    OnDataChange = D020DataChange
    Left = 195
    Top = 65535
  end
  object D265: TDataSource
    DataSet = A058FPianifTurniDtM1.Q265
    OnDataChange = D020DataChange
    Left = 140
    Top = 108
  end
  object D265B: TDataSource
    DataSet = A058FPianifTurniDtM1.Q265B
    OnDataChange = D020DataChange
    Left = 142
    Top = 143
  end
end

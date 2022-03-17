object A058FCopiaPianificazione: TA058FCopiaPianificazione
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A058> Copia della pianificazione'
  ClientHeight = 176
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 18
    Width = 75
    Height = 13
    Caption = 'dal dipendente:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 15
    Top = 46
    Width = 69
    Height = 13
    Caption = 'al dipendente:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 43
    Top = 96
    Width = 41
    Height = 13
    Caption = 'da data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 180
    Top = 96
    Width = 35
    Height = 13
    Caption = 'a data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 181
    Top = 18
    Width = 41
    Height = 13
    AutoSize = True
    DataField = 'Nominativo1'
    DataSource = dsrAnagrafiche
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBText2: TDBText
    Left = 199
    Top = 46
    Width = 41
    Height = 13
    AutoSize = True
    DataField = 'Nominativo2'
    DataSource = dsrAnagrafiche
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object rdbSingoloDip: TRadioButton
    Left = 96
    Top = 44
    Width = 33
    Height = 17
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = OnRadioBtnDipClick
  end
  object edtDaData: TMaskEdit
    Left = 88
    Top = 93
    Width = 79
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object edtAData: TMaskEdit
    Left = 219
    Top = 93
    Width = 79
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
  end
  object btnOK: TBitBtn
    Left = 88
    Top = 144
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
    TabOrder = 4
    OnClick = btnOKClick
  end
  object BitBtn2: TBitBtn
    Left = 186
    Top = 144
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
    TabOrder = 5
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 96
    Top = 15
    Width = 79
    Height = 21
    DataField = 'Progressivo1'
    DataSource = dsrAnagrafiche
    DropDownRows = 10
    DropDownWidth = 400
    KeyField = 'PROGRESSIVO'
    ListField = 'MATRICOLA;COGNOME;NOME'
    ListSource = dsrC700
    TabOrder = 0
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 114
    Top = 42
    Width = 79
    Height = 21
    DataField = 'Progressivo2'
    DataSource = dsrAnagrafiche
    DropDownRows = 10
    DropDownWidth = 400
    KeyField = 'PROGRESSIVO'
    ListField = 'MATRICOLA;COGNOME;NOME'
    ListSource = dsrC700
    TabOrder = 1
  end
  object chkRendiDefinitive: TCheckBox
    Left = 9
    Top = 121
    Width = 204
    Height = 17
    Caption = 'Copia anche la turnazione assegnata'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object rdbTuttiDip: TRadioButton
    Left = 96
    Top = 69
    Width = 118
    Height = 17
    Caption = 'Tutti i dipendenti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = OnRadioBtnDipClick
  end
  object dsrC700: TDataSource
    Left = 309
    Top = 50
  end
  object dsrAnagrafiche: TDataSource
    DataSet = cdsAnagrafiche
    Left = 312
  end
  object cdsAnagrafiche: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Progressivo1'
        DataType = ftInteger
      end
      item
        Name = 'Progressivo2'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsAnagraficheCalcFields
    Left = 240
    object cdsAnagraficheProgressivo1: TIntegerField
      FieldName = 'Progressivo1'
    end
    object cdsAnagraficheProgressivo2: TIntegerField
      FieldName = 'Progressivo2'
    end
    object cdsAnagraficheNominativo1: TStringField
      FieldKind = fkCalculated
      FieldName = 'Nominativo1'
      Size = 50
      Calculated = True
    end
    object cdsAnagraficheNominativo2: TStringField
      FieldKind = fkCalculated
      FieldName = 'Nominativo2'
      Size = 50
      Calculated = True
    end
  end
end

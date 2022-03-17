object A103FScaricoGiust: TA103FScaricoGiust
  Left = 268
  Top = 125
  HelpContext = 103000
  Caption = '<A103> Acquisizione giustificativi'
  ClientHeight = 198
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 319
    Height = 198
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 96
      Height = 13
      Caption = 'Tipo di acquisizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 7
      Top = 171
      Width = 46
      Height = 13
      Caption = 'Matricola:'
    end
    object Label2: TLabel
      Left = 7
      Top = 139
      Width = 41
      Height = 13
      Caption = 'Azienda:'
    end
    object lblAzienda: TLabel
      Left = 146
      Top = 139
      Width = 5
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 155
      Width = 34
      Height = 13
      Caption = 'Badge:'
    end
    object lblBadge: TLabel
      Left = 146
      Top = 155
      Width = 5
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 123
      Width = 25
      Height = 13
      Caption = 'Riga:'
    end
    object lblRiga: TLabel
      Left = 146
      Top = 123
      Width = 5
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 7
      Top = 106
      Width = 39
      Height = 13
      Caption = 'Scarico:'
    end
    object lblScarico: TLabel
      Left = 146
      Top = 106
      Width = 5
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblMatricola: TLabel
      Left = 146
      Top = 169
      Width = 5
      Height = 13
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EScarico: TDBLookupComboBox
      Left = 8
      Top = 24
      Width = 145
      Height = 21
      KeyField = 'CODICE'
      ListField = 'CODICE'
      ListSource = dsrI150
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnKeyDown = EScaricoKeyDown
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 74
      Width = 122
      Height = 25
      HelpContext = 103000
      Caption = 'Inizia Acquisizione'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36010000424D3601000000000000760000002800000012000000100000000100
        040000000000C0000000130B0000130B00001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF0F
        FFFFFFFFEFFFFFFFFFFFFF90FFFFFFFFFFFFFFFFFFFFFF990FFFFFFFEFFF0000
        0099999990FFFFFFFFFF0FFFF0999999990FFFFFEFFF0FFFF09999999990FFFF
        FFFF0F00F0999999990FFFFFEFFF0FFFF099999990FFFFFFFFFF0F00FFFFF099
        0FFFFFFFEFFF0FFFFFFFF090FFFFFFFFFFFF0F00F000000FFFFFFFFFEFFF0FFF
        F0FF0FFFFFFFFFFFFFFF0F08F0F0FFFFFFFFFFFFEFFF0FFFF00FFFFFFFFFFFFF
        FFFF000000FFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 245
      Top = 74
      Width = 67
      Height = 25
      Caption = 'Chiudi'
      DoubleBuffered = True
      Kind = bkClose
      ParentDoubleBuffered = False
      TabOrder = 4
    end
    object btnAnomalie: TBitBtn
      Left = 137
      Top = 74
      Width = 99
      Height = 25
      Caption = 'Vis. Anomalie'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 3
      OnClick = btnAnomalieClick
    end
    object chkScarichiAuto: TCheckBox
      Left = 8
      Top = 48
      Width = 161
      Height = 17
      Caption = 'Tutti gli scarichi automatici'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkScarichiAutoClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 238
    Top = 4
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object dsrI150: TDataSource
    DataSet = R250FScaricoGiustificativiDtM.selI150
    Left = 192
    Top = 16
  end
end

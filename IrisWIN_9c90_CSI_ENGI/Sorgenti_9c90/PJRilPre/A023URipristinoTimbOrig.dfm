object A023FRipristinoTimbOrig: TA023FRipristinoTimbOrig
  Left = 0
  Top = 0
  HelpContext = 23400
  Caption = '<A023> Ripristino timbrature originali'
  ClientHeight = 362
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    713
    362)
  PixelsPerInch = 96
  TextHeight = 13
  object grpOperazioni: TGroupBox
    Left = 168
    Top = 2
    Width = 285
    Height = 91
    Caption = 'Operazioni di ripristino'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object chkRipristinaOrig: TCheckBox
      Left = 7
      Top = 20
      Width = 168
      Height = 17
      Caption = 'Ripristina timbrature originali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkRipristinaOrigClick
    end
    object chkCancManuali: TCheckBox
      Left = 7
      Top = 43
      Width = 225
      Height = 17
      Caption = 'Cancella timbrature inserite manualmente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkRipristinaOrigClick
    end
    object chkCancIterWeb: TCheckBox
      Left = 7
      Top = 66
      Width = 274
      Height = 17
      Caption = 'Cancella timbrature inserite da iter autorizzativo web'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkRipristinaOrigClick
    end
  end
  object grpPeriodo: TGroupBox
    Left = 5
    Top = 2
    Width = 159
    Height = 91
    Caption = 'Periodo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblMese: TLabel
      Left = 11
      Top = 21
      Width = 35
      Height = 13
      Caption = 'lblMese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDal: TLabel
      Left = 11
      Top = 53
      Width = 15
      Height = 13
      Caption = 'Dal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblAl: TLabel
      Left = 88
      Top = 53
      Width = 8
      Height = 13
      Caption = 'al'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object sedtDal: TSpinEdit
      Left = 36
      Top = 50
      Width = 41
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 2
      MaxValue = 31
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
      OnChange = sedtDalChange
    end
    object sedtAl: TSpinEdit
      Left = 105
      Top = 50
      Width = 41
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 2
      MaxValue = 31
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 1
      OnChange = sedtAlChange
    end
  end
  object grpAttuale: TGroupBox
    Left = 5
    Top = 94
    Width = 350
    Height = 266
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Situazione attuale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object dgrdAttuale: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 340
      Height = 243
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'FLAG'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VERSO'
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORA'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RILEVATORE'
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAUSALE'
          Width = 60
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'D_WEB'
          Width = 40
          Visible = True
        end>
    end
  end
  object grpSimulazione: TGroupBox
    Left = 358
    Top = 94
    Width = 350
    Height = 266
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Situazione ripristinata'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object dgrdSimulazione: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 340
      Height = 243
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'FLAG_SIM'
          Title.Alignment = taCenter
          Title.Caption = 'Flag'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VERSO'
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORA'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RILEVATORE'
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAUSALE'
          Width = 60
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'D_WEB'
          Width = 40
          Visible = True
        end>
    end
  end
  object grpLegenda: TGroupBox
    Left = 460
    Top = 2
    Width = 141
    Height = 91
    Caption = 'Legenda Flag'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblFlagI: TLabel
      Left = 10
      Top = 19
      Width = 10
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'I'
    end
    object lblFlagM: TLabel
      Left = 10
      Top = 37
      Width = 10
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'M'
    end
    object lblFlagC: TLabel
      Left = 10
      Top = 55
      Width = 10
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'C'
    end
    object lblFlagO: TLabel
      Left = 10
      Top = 74
      Width = 10
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'O'
    end
    object lblFlagCDesc: TLabel
      Left = 23
      Top = 55
      Width = 98
      Height = 13
      Caption = ': originale cancellata'
    end
    object lblFlagMDesc: TLabel
      Left = 23
      Top = 37
      Width = 99
      Height = 13
      Caption = ': originale modificata'
    end
    object lblFlagIDesc: TLabel
      Left = 23
      Top = 19
      Width = 109
      Height = 13
      Caption = ': inserita manualmente'
    end
    object lblFlagODesc: TLabel
      Left = 23
      Top = 74
      Width = 78
      Height = 13
      Caption = ': originale in uso'
    end
  end
  object btnConferma: TBitBtn
    Left = 615
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Esegui'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnConfermaClick
  end
  object btnAnnulla: TBitBtn
    Left = 615
    Top = 58
    Width = 75
    Height = 25
    Caption = 'Chiudi'
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
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 4
  end
end

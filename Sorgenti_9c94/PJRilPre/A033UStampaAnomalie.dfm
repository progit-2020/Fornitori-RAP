object A033FStampaAnomalie: TA033FStampaAnomalie
  Left = 194
  Top = 144
  HelpContext = 33000
  Caption = '<A033> Stampa anomalie'
  ClientHeight = 268
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 249
    Width = 471
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '1 Record'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 233
    Width = 471
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 471
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 471
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 471
      Height = 24
      ExplicitWidth = 471
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
  object pnlPrincipale: TPanel
    Left = 0
    Top = 24
    Width = 471
    Height = 209
    Align = alClient
    TabOrder = 3
    object Label2: TLabel
      Left = 29
      Top = 10
      Width = 38
      Height = 13
      Caption = 'Da data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 139
      Top = 10
      Width = 31
      Height = 13
      Caption = 'A data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 29
      Top = 158
      Width = 85
      Height = 13
      Caption = 'Raggruppamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EDaData: TMaskEdit
      Left = 29
      Top = 26
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = EDaDataExit
    end
    object EAData: TMaskEdit
      Left = 135
      Top = 29
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object btnStampa: TBitBtn
      Left = 329
      Top = 96
      Width = 130
      Height = 25
      Caption = '&Stampa'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      TabOrder = 2
      OnClick = btnStampaClick
    end
    object BitBtn2: TBitBtn
      Left = 329
      Top = 24
      Width = 130
      Height = 25
      Caption = 'S&tampante'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = BitBtn2Click
    end
    object CheckBox1: TCheckBox
      Left = 29
      Top = 56
      Width = 65
      Height = 17
      Caption = '1'#176' Livello'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object CheckBox2: TCheckBox
      Left = 29
      Top = 76
      Width = 65
      Height = 17
      Caption = '2'#176' Livello'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object CheckBox3: TCheckBox
      Left = 29
      Top = 96
      Width = 65
      Height = 17
      Caption = '3'#176' Livello'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
    end
    object CBTimbrat1: TCheckBox
      Left = 104
      Top = 56
      Width = 108
      Height = 17
      Caption = 'Stampa timbrature'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 7
      OnClick = CBTimbrat1Click
    end
    object CBCausali1: TCheckBox
      Left = 219
      Top = 56
      Width = 93
      Height = 17
      Caption = 'Stampa causali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object CBTimbrat2: TCheckBox
      Left = 104
      Top = 76
      Width = 108
      Height = 17
      Caption = 'Stampa timbrature'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 9
      OnClick = CBTimbrat2Click
    end
    object CBCausali2: TCheckBox
      Left = 219
      Top = 76
      Width = 93
      Height = 17
      Caption = 'Stampa causali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object CBTimbrat3: TCheckBox
      Left = 104
      Top = 96
      Width = 108
      Height = 17
      Caption = 'Stampa timbrature'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 11
      OnClick = CBTimbrat3Click
    end
    object CBCausali3: TCheckBox
      Left = 219
      Top = 96
      Width = 93
      Height = 17
      Caption = 'Stampa causali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object Button1: TButton
      Left = 9
      Top = 57
      Width = 17
      Height = 15
      Hint = 'Filtro anomalie 1'#176' livello'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 9
      Top = 77
      Width = 17
      Height = 15
      Hint = 'Filtro anomalie 2'#176' livello'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 9
      Top = 97
      Width = 17
      Height = 15
      Hint = 'Filtro anomalie 3'#176' livello'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      OnClick = Button1Click
    end
    object CkBAggiornaT101: TCheckBox
      Left = 29
      Top = 136
      Width = 177
      Height = 17
      Caption = 'Registra anomalie su archivio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnClick = CkBAggiornaT101Click
    end
    object DBLookupCampo: TDBLookupComboBox
      Left = 29
      Top = 172
      Width = 160
      Height = 21
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      TabOrder = 17
      OnKeyDown = DBLookupCampoKeyDown
    end
    object CheckBox4: TCheckBox
      Left = 219
      Top = 174
      Width = 81
      Height = 17
      Caption = 'Salto pagina'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
    end
    object chkAutoGiustificazione: TCheckBox
      Left = 29
      Top = 116
      Width = 177
      Height = 17
      Caption = 'Elabora auto-giustificazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
    end
    object btnAnteprima: TBitBtn
      Left = 330
      Top = 60
      Width = 130
      Height = 25
      Caption = '&Anteprima'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      TabOrder = 20
      OnClick = btnStampaClick
    end
    object btnAggiornamento: TBitBtn
      Left = 330
      Top = 132
      Width = 130
      Height = 25
      Caption = '&Solo registrazione'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      TabOrder = 21
      OnClick = btnStampaClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 300
    Top = 4
  end
end

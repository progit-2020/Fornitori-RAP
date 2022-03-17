object A027FStampaTesto: TA027FStampaTesto
  Left = 411
  Top = 223
  HelpContext = 27100
  Caption = '<A027> Stampa del cartellino in formato testo'
  ClientHeight = 322
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 385
    Height = 285
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametri'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 16
        Top = 47
        Width = 179
        Height = 13
        Caption = 'Numero totale di righe per ogni pagina'
      end
      object Label4: TLabel
        Left = 16
        Top = 215
        Width = 117
        Height = 13
        Caption = 'File di testo da stampare:'
      end
      object Label5: TLabel
        Left = 16
        Top = 7
        Width = 213
        Height = 13
        Caption = 'Caratteri di controllo da applicare alla stampa:'
      end
      object Label1: TLabel
        Left = 16
        Top = 89
        Width = 173
        Height = 13
        Caption = 'Numero totale di righe di intestazione'
      end
      object Label3: TLabel
        Left = 16
        Top = 131
        Width = 167
        Height = 13
        Caption = 'Numero totale di righe a fine pagina'
      end
      object Label6: TLabel
        Left = 16
        Top = 173
        Width = 225
        Height = 13
        Caption = 'Caratteri prima dei quali applicare il salto pagina:'
      end
      object edtFileTesto: TEdit
        Left = 16
        Top = 230
        Width = 329
        Height = 21
        TabOrder = 0
      end
      object BtnFileTesto: TButton
        Left = 345
        Top = 230
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = BtnFileTestoClick
      end
      object edtInizioPagina: TEdit
        Left = 16
        Top = 20
        Width = 346
        Height = 21
        TabOrder = 2
      end
      object spedtTotaleRighe: TSpinEdit
        Left = 16
        Top = 62
        Width = 57
        Height = 22
        MaxValue = 999
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = spedtTotaleRigheChange
      end
      object spedtRigheHeader: TSpinEdit
        Left = 16
        Top = 104
        Width = 57
        Height = 22
        MaxValue = 999
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
      object spedtRigheFooter: TSpinEdit
        Left = 16
        Top = 146
        Width = 57
        Height = 22
        MaxValue = 999
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object edtSaltoPagina: TEdit
        Left = 16
        Top = 188
        Width = 346
        Height = 21
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Risultato stampa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 377
        Height = 257
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Memo2: TMemo
        Left = 160
        Top = 32
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo2')
        TabOrder = 1
        Visible = False
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 285
    Width = 385
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnStampa: TBitBtn
      Left = 2
      Top = 7
      Width = 75
      Height = 25
      Caption = '&Stampa'
      Default = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BtnStampaClick
    end
    object BtnChiudi: TBitBtn
      Left = 82
      Top = 7
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 1
    end
  end
  object DxPrinter1: TDxPrinter
    Active = False
    Left = 176
    Top = 291
  end
  object OpenDialog1: TOpenDialog
    Filter = 'File di Testo (*.txt)|*.txt|Tutti i files (*.*)|*.*'
    Left = 256
    Top = 208
  end
end

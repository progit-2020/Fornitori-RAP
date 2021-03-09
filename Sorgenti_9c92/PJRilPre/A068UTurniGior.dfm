object A068FTurniGior: TA068FTurniGior
  Left = 467
  Top = 259
  HelpContext = 68000
  BorderStyle = bsDialog
  Caption = '<A068> Situazione giornaliera dei turni'
  ClientHeight = 173
  ClientWidth = 290
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
  object Label1: TLabel
    Left = 88
    Top = 38
    Width = 32
    Height = 13
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblIntestazione: TLabel
    Left = 8
    Top = 68
    Width = 60
    Height = 13
    Caption = 'Intestazione:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 154
    Width = 290
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object BitBtn2: TBitBtn
    Left = 184
    Top = 127
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn3: TBitBtn
    Left = 100
    Top = 127
    Width = 75
    Height = 25
    Caption = '&Stampa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000C40E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
      7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
      0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
      FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 8
    Top = 127
    Width = 84
    Height = 25
    Caption = 'Stampante'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn4Click
  end
  object edtIntestazione: TEdit
    Left = 84
    Top = 64
    Width = 175
    Height = 21
    TabOrder = 5
    Text = 'Settore XXX'
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 290
    Height = 24
    Align = alTop
    TabOrder = 6
    TabStop = True
    ExplicitWidth = 290
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 290
      Height = 24
      ExplicitWidth = 290
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
  object rgpTPianif: TRadioGroup
    Left = 8
    Top = 87
    Width = 251
    Height = 35
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Operativa'
      'Non Operativa')
    ParentFont = False
    TabOrder = 7
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 260
    Top = 28
  end
end

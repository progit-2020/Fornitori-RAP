object A023FCancTimbRiscaricate: TA023FCancTimbRiscaricate
  Left = 380
  Top = 274
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = '<A023> Eliminazione timbrature riscaricate'
  ClientHeight = 127
  ClientWidth = 336
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
  object LblDaData: TLabel
    Left = 53
    Top = 29
    Width = 61
    Height = 13
    Caption = 'LblDaData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 53
    Top = 56
    Width = 14
    Height = 13
    Caption = 'Da'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 56
    Width = 7
    Height = 13
    Caption = 'A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 198
    Top = 32
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
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
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 198
    Top = 72
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object SBDaGG: TSpinEdit
    Left = 72
    Top = 53
    Width = 37
    Height = 22
    MaxLength = 2
    MaxValue = 12
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object SBAGG: TSpinEdit
    Left = 140
    Top = 53
    Width = 37
    Height = 22
    MaxLength = 2
    MaxValue = 12
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object chkTuttiDipendenti: TCheckBox
    Left = 72
    Top = 80
    Width = 105
    Height = 17
    Caption = 'Tutti i dipendenti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  inline frmSelAnagrafe1: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 336
    Height = 24
    Align = alTop
    TabOrder = 5
    TabStop = True
    ExplicitWidth = 336
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 336
      Height = 24
      ExplicitWidth = 336
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 102
    Width = 336
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object StatusBar: TStatusBar
      Left = 0
      Top = 6
      Width = 336
      Height = 19
      Panels = <
        item
          Width = 50
        end>
      SimpleText = '0 Records'
    end
  end
end

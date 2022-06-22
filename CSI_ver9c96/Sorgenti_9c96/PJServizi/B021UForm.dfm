object B021FForm: TB021FForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<B021> Server REST'
  ClientHeight = 219
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpInfoServer: TGroupBox
    Left = 8
    Top = 8
    Width = 233
    Height = 73
    Caption = 'Informazioni server'
    TabOrder = 0
    object lblPortaServer: TLabel
      Left = 11
      Top = 49
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object lblStatoServer: TLabel
      Left = 11
      Top = 22
      Width = 26
      Height = 13
      Caption = 'Stato'
    end
    object edtPortaServer: TEdit
      Left = 68
      Top = 46
      Width = 70
      Height = 21
      TabOrder = 1
    end
    object edtStatoServer: TEdit
      Left = 68
      Top = 19
      Width = 156
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
  end
  object grpGestServer: TGroupBox
    Left = 8
    Top = 87
    Width = 233
    Height = 58
    Caption = 'Gestione server'
    TabOrder = 1
    object btnStart: TButton
      Left = 11
      Top = 20
      Width = 100
      Height = 30
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 124
      Top = 20
      Width = 100
      Height = 30
      Caption = 'Stop'
      Default = True
      TabOrder = 1
      OnClick = btnStopClick
    end
  end
  object grpGestClient: TGroupBox
    Left = 8
    Top = 145
    Width = 233
    Height = 69
    Caption = 'Gestione client'
    TabOrder = 2
    object btnRunClient: TButton
      Left = 11
      Top = 25
      Width = 213
      Height = 30
      Caption = 'Apri B021PTest'
      TabOrder = 0
      OnClick = btnRunClientClick
    end
  end
end

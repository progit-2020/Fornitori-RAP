object A134FAllineamentoClient: TA134FAllineamentoClient
  Left = 0
  Top = 0
  HelpContext = 134000
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '<A134> Allineamento client'
  ClientHeight = 158
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RdGrpApplicativi: TRadioGroup
    Left = 0
    Top = 0
    Width = 218
    Height = 94
    Align = alClient
    Caption = 'Applicativi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'Presenze-Assenze'
      'Stipendi'
      'Stato Giuridico'
      'Missioni')
    ParentFont = False
    TabOrder = 0
    OnClick = RdGrpApplicativiClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 94
    Width = 218
    Height = 64
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    object BtnCreaB012: TSpeedButton
      Left = 5
      Top = 5
      Width = 100
      Height = 25
      Caption = 'Crea B012.INI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = BtnCreaB012Click
    end
    object BtnCopiaFile: TSpeedButton
      Left = 111
      Top = 5
      Width = 100
      Height = 25
      Caption = 'Copia B012.EXE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = BtnCopiaFileClick
    end
    object BtnCollegamento: TButton
      Left = 48
      Top = 33
      Width = 121
      Height = 25
      Caption = 'Crea icona sul desktop'
      TabOrder = 0
      OnClick = BtnCollegamentoClick
    end
  end
end

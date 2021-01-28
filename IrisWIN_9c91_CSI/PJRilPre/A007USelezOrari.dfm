object A007FSelezOrari: TA007FSelezOrari
  Left = 577
  Top = 231
  Width = 371
  Height = 410
  Caption = 'Selezione modelli orario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 357
    Width = 363
    Height = 26
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 80
      Top = 0
      Width = 79
      Height = 25
      Caption = 'Annulla'
      TabOrder = 1
      Kind = bkAbort
    end
  end
  object DBLookupListBox1: TDBLookupListBox
    Left = 0
    Top = 0
    Width = 363
    Height = 355
    Align = alClient
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = A007FProfiliOrariDtM1.D020
    TabOrder = 1
    OnDblClick = DBLookupListBox1DblClick
  end
end

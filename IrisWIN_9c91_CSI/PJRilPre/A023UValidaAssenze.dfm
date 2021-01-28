object A023FValidaAssenze: TA023FValidaAssenze
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = '<A023> Validazione Assenze'
  ClientHeight = 158
  ClientWidth = 180
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlue
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBottom: TPanel
    Left = 0
    Top = 117
    Width = 180
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BtnConferma: TSpeedButton
      Left = 8
      Top = 6
      Width = 80
      Height = 27
      Caption = 'Conferma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = BtnConfermaClick
    end
    object BtnAnnulla: TSpeedButton
      Left = 88
      Top = 6
      Width = 80
      Height = 27
      Caption = 'Annulla'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = BtnAnnullaClick
    end
  end
  object PnlTop: TPanel
    Left = 0
    Top = 0
    Width = 180
    Height = 117
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 35
      Width = 39
      Height = 13
      Caption = 'Da Data'
    end
    object Label2: TLabel
      Left = 103
      Top = 35
      Width = 33
      Height = 13
      Caption = 'A Data'
    end
    object lblNominativo: TLabel
      Left = 8
      Top = 6
      Width = 63
      Height = 13
      Caption = 'lblNominativo'
    end
    object EdtDataDa: TMaskEdit
      Left = 8
      Top = 49
      Width = 65
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object EdtDataA: TMaskEdit
      Left = 103
      Top = 49
      Width = 65
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object ChkLst: TCheckListBox
      Left = 8
      Top = 74
      Width = 160
      Height = 37
      Columns = 2
      ItemHeight = 13
      TabOrder = 2
    end
  end
end

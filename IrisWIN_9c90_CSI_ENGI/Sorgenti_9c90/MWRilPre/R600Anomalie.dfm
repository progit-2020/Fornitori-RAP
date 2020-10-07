object R600FAnomalie: TR600FAnomalie
  Left = 282
  Top = 188
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = '<R600> Messaggio di gestione giustificativi'
  ClientHeight = 107
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 372
    Height = 69
    AutoSize = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 4
    Top = 80
    Width = 70
    Height = 25
    Caption = 'Conferma'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 94
    Top = 80
    Width = 84
    Height = 25
    Caption = 'Annulla giorno'
    ModalResult = 5
    TabOrder = 1
  end
  object Button3: TButton
    Left = 196
    Top = 80
    Width = 182
    Height = 25
    Caption = 'Annulla proseguimento operazione'
    ModalResult = 3
    TabOrder = 2
  end
end

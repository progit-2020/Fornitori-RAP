object A021FAssestAnnuo: TA021FAssestAnnuo
  Left = 331
  Top = 267
  BorderStyle = bsDialog
  Caption = '<A021> Assest. annuo'
  ClientHeight = 166
  ClientWidth = 175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 36
    Width = 163
    Height = 13
    Caption = 'Ordine di abbattimento dei serbatoi'
  end
  object chkAssestAnnuo: TCheckBox
    Left = 4
    Top = 8
    Width = 121
    Height = 17
    Caption = 'Assestamento annuo'
    TabOrder = 0
    OnClick = chkAssestAnnuoClick
  end
  object lstSerbatoi: TListBox
    Left = 4
    Top = 52
    Width = 165
    Height = 77
    Style = lbOwnerDrawFixed
    DragMode = dmAutomatic
    Items.Strings = (
      'CP'
      'LP'
      'CA'
      'LA')
    TabOrder = 1
    OnDragDrop = lstSerbatoiDragDrop
    OnDragOver = lstSerbatoiDragOver
    OnDrawItem = lstSerbatoiDrawItem
    OnStartDrag = lstSerbatoiStartDrag
  end
  object BitBtn1: TBitBtn
    Left = 4
    Top = 136
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 96
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Annulla'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end

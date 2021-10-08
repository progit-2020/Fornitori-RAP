object A124FSuperoCompetenze: TA124FSuperoCompetenze
  Left = 196
  Top = 166
  Caption = 'Supero competenze'
  ClientHeight = 153
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 66
    Width = 357
    Height = 46
    Align = alBottom
    Caption = 'Nuova durata del permesso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblOre: TLabel
      Left = 239
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Ore:'
    end
    object Label3: TLabel
      Left = 39
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Dalle:'
    end
    object Label4: TLabel
      Left = 126
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Alle:'
    end
    object edtOre: TMaskEdit
      Left = 263
      Top = 20
      Width = 36
      Height = 21
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  .  '
      OnChange = edtDalleChange
      OnExit = edtDalleExit
    end
    object edtDalle: TMaskEdit
      Left = 72
      Top = 20
      Width = 36
      Height = 21
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  .  '
      OnChange = edtDalleChange
      OnExit = edtDalleExit
    end
    object edtAlle: TMaskEdit
      Left = 152
      Top = 20
      Width = 38
      Height = 21
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  .  '
      OnChange = edtDalleChange
      OnExit = edtDalleExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 112
    Width = 357
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnConferma: TBitBtn
      Left = 10
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Conferma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfermaClick
    end
    object btnAnnullaDip: TBitBtn
      Left = 91
      Top = 8
      Width = 120
      Height = 25
      Caption = 'Annulla dipendente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnAnnullaDipClick
    end
    object btnAnnullaOp: TBitBtn
      Left = 227
      Top = 8
      Width = 120
      Height = 25
      Caption = 'Annulla operazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnAnnullaOpClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 357
    Height = 66
    Align = alClient
    TabOrder = 2
    object Label2: TLabel
      Left = 25
      Top = 9
      Width = 310
      Height = 13
      Caption = 
        'Sono state superate le competenze del sindacato per la matricola' +
        ':'
      Color = clInfoBk
      ParentColor = False
    end
    object lblNominativo: TLabel
      Left = 25
      Top = 24
      Width = 310
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblNominativo'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label1: TLabel
      Left = 25
      Top = 42
      Width = 241
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'DISPONIBILITA'#39'  RESIDUA: '
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 305
      Top = 42
      Width = 30
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'ORE'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object lblResiduo: TLabel
      Left = 268
      Top = 42
      Width = 36
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '00.00'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsItalic]
      ParentColor = False
      ParentFont = False
    end
  end
end

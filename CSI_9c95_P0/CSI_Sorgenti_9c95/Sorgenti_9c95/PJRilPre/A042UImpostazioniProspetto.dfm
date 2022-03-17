object A042FImpostazioniProspetto: TA042FImpostazioniProspetto
  Left = 216
  Top = 132
  BorderIcons = [biSystemMenu]
  Caption = '<A042> Impostazioni prospetto ore lavorate'
  ClientHeight = 190
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 190
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 393
    ExplicitHeight = 194
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 377
      Height = 72
      TabOrder = 0
      object Label1: TLabel
        Left = 61
        Top = 22
        Width = 207
        Height = 13
        Caption = 'Determinare se le ore consecutive sono < di'
      end
      object RbtIntervallo1: TRadioButton
        Left = 49
        Top = 46
        Width = 133
        Height = 17
        Caption = 'nell'#39'intervallo specificato'
        TabOrder = 0
      end
      object RbtGiornata1: TRadioButton
        Left = 195
        Top = 46
        Width = 123
        Height = 17
        Caption = 'nell'#39'arco della giornata'
        TabOrder = 1
      end
      object MskLimite1: TMaskEdit
        Left = 272
        Top = 19
        Width = 40
        Height = 21
        EditMask = '!90:00;1;_'
        MaxLength = 5
        TabOrder = 2
        Text = '  .  '
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 79
      Width = 377
      Height = 72
      TabOrder = 1
      object Label2: TLabel
        Left = 61
        Top = 22
        Width = 210
        Height = 13
        Caption = 'Determinare se le ore consecutive sono > di '
      end
      object RbtIntervallo2: TRadioButton
        Left = 49
        Top = 46
        Width = 133
        Height = 17
        Caption = 'nell'#39'intervallo specificato'
        TabOrder = 0
      end
      object RbtGiornata2: TRadioButton
        Left = 195
        Top = 46
        Width = 123
        Height = 17
        Caption = 'nell'#39'arco della giornata'
        TabOrder = 1
      end
      object MskLimite2: TMaskEdit
        Left = 272
        Top = 19
        Width = 40
        Height = 21
        EditMask = '!90:00;1;_'
        MaxLength = 5
        TabOrder = 2
        Text = '  .  '
      end
    end
    object BitBtn1: TBitBtn
      Left = 119
      Top = 160
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
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 199
      Top = 160
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 3
    end
  end
end

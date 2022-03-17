object A080FSaldiAbbattuti: TA080FSaldiAbbattuti
  Left = 287
  Top = 124
  HelpContext = 80300
  BorderStyle = bsSingle
  Caption = '<A080> Abbattimento saldi'
  ClientHeight = 275
  ClientWidth = 247
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 247
    Height = 275
    Align = alClient
    DataSource = A080FModConteDtM1.D026
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end

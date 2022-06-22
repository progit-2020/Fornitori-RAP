object A058FDettaglioGiornata: TA058FDettaglioGiornata
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<A058> Dettaglio orario '#39'xxxxx'#39
  ClientHeight = 124
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 265
    Height = 124
    Align = alClient
    DataSource = A058FPianifTurniDtM1.D021
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'numfascia'
        Title.Caption = 'Num.Fascia'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clRed
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NUMTURNO'
        Title.Caption = 'Num.Turno'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLATURNI'
        Title.Caption = 'Sigla'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENTRATA'
        Title.Caption = 'Entrata'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USCITA'
        Title.Caption = 'Uscita'
        Width = 45
        Visible = True
      end>
  end
end

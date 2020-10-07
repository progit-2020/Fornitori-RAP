object A058FDettaglioTipiOperatori: TA058FDettaglioTipiOperatori
  Left = 0
  Top = 0
  Width = 272
  Height = 151
  BorderIcons = [biSystemMenu]
  Caption = '<A058> Dettaglio limiti tipi operatori'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 264
    Height = 117
    Align = alClient
    DataSource = A058FPianifTurniDtM1.dSelQ601
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
        FieldName = 'CODICE'
        Title.Caption = 'TIPO OPE.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MIN1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAX1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MIN2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAX2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MIN3'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAX3'
        Visible = True
      end>
  end
end

inherited B010FSchedulazione: TB010FSchedulazione
  Left = 217
  Top = 57
  HelpContext = 112200
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<B010> Schedulazione'
  ClientHeight = 221
  ClientWidth = 512
  ExplicitWidth = 520
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 203
    Width = 512
    ExplicitTop = 203
    ExplicitWidth = 512
  end
  inherited Panel1: TToolBar
    Width = 512
    ExplicitWidth = 512
  end
  object dGrdSchedulazione: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 512
    Height = 174
    Align = alClient
    DataSource = DButton
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    PopupMenu = mnuSchedulazione
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dGrdSchedulazioneEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'GIORNO'
        PickList.Strings = (
          '1-luned'#236
          '2-marted'#236
          '3-mercoled'#236
          '4-gioved'#236
          '5-venerd'#236
          '6-sabato'
          '7-domenica')
        Title.Caption = 'Giorno Sett.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_GIORNO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATADD'
        Title.Caption = 'Giorno'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAMM'
        Title.Caption = 'Mese'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAYY'
        Title.Caption = 'Anno'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAHH'
        Title.Caption = 'Ora'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'PARAMETRIZZAZIONE'
        Title.Caption = 'Parametrizzazioni'
        Visible = True
      end>
  end
  inherited DButton: TDataSource
    AutoEdit = True
  end
  object mnuSchedulazione: TPopupMenu
    OnPopup = mnuSchedulazionePopup
    Left = 140
    Top = 26
    object Copiaschedulazione1: TMenuItem
      Caption = 'Copia schedulazione...'
      OnClick = Copiaschedulazione1Click
    end
    object Eliminaschedulazione1: TMenuItem
      Caption = 'Elimina schedulazione'
      OnClick = Eliminaschedulazione1Click
    end
  end
end

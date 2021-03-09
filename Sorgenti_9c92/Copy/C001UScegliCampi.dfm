object C001FScegliCampi: TC001FScegliCampi
  Left = 198
  Top = 73
  HelpContext = 1001100
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '<C001> Impostazione dati'
  ClientHeight = 250
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnHide = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 341
    Height = 250
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object LblNonSelezionati: TLabel
      Left = 13
      Top = 16
      Width = 124
      Height = 13
      Caption = 'Campi non selezionati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblSelezionati: TLabel
      Left = 205
      Top = 17
      Width = 99
      Height = 13
      Caption = 'Campi selezionati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 6
      Top = 8
      Width = 327
      Height = 188
    end
    object ListBoxNonScelti: TListBox
      Left = 13
      Top = 39
      Width = 121
      Height = 145
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
      OnClick = ListBoxNonSceltiClick
      OnDblClick = BtnRightClick
      OnMouseDown = ListBoxNonSceltiMouseDown
    end
    object BtnRight: TButton
      Left = 148
      Top = 40
      Width = 41
      Height = 25
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnRightClick
    end
    object BtnAllRight: TButton
      Left = 148
      Top = 80
      Width = 41
      Height = 25
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnAllRightClick
    end
    object BtnAllLeft: TButton
      Left = 148
      Top = 120
      Width = 41
      Height = 25
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BtnAllLeftClick
    end
    object BtnLeft: TButton
      Left = 148
      Top = 160
      Width = 41
      Height = 25
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BtnLeftClick
    end
    object ListBoxScelti: TListBox
      Left = 206
      Top = 39
      Width = 121
      Height = 145
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 5
      OnClick = ListBoxSceltiClick
      OnDblClick = BtnLeftClick
      OnMouseDown = ListBoxSceltiMouseDown
      OnMouseUp = ListBoxSceltiMouseUp
    end
    object Button5: TButton
      Left = 76
      Top = 210
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 6
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 198
      Top = 210
      Width = 75
      Height = 25
      Caption = 'Annulla'
      ModalResult = 2
      TabOrder = 7
      OnClick = Button6Click
    end
  end
  object PageControl1: TPageControl
    Left = 341
    Top = 0
    Width = 197
    Height = 250
    ActivePage = Intervallo
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object Intervallo: TTabSheet
      Caption = 'Intervallo'
      object LblCampoSelezionato: TLabel
        Left = 8
        Top = 8
        Width = 113
        Height = 13
        Caption = 'Campo Selezionato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblSelezionaIntervallo: TLabel
        Left = 8
        Top = 62
        Width = 122
        Height = 13
        Caption = 'Seleziona l'#39'intervallo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblDa: TLabel
        Left = 2
        Top = 101
        Width = 23
        Height = 13
        Caption = 'Da:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object LblA: TLabel
        Left = 3
        Top = 141
        Width = 16
        Height = 13
        Caption = 'A:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object cmbIntervalloDa: TComboBox
        Left = 26
        Top = 97
        Width = 161
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbIntervalloDaChange
        OnCloseUp = cmbIntervalloDaChange
        OnExit = cmbIntervalloDaChange
      end
      object cmbIntervalloA: TComboBox
        Left = 26
        Top = 137
        Width = 161
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbIntervalloAChange
        OnCloseUp = cmbIntervalloAChange
        OnDropDown = cmbIntervalloAChange
      end
    end
    object Ordinamento: TTabSheet
      Caption = 'Ordinamento'
      object LblCampoCorrente: TLabel
        Left = 8
        Top = 8
        Width = 113
        Height = 13
        Caption = 'Campo Selezionato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RdBtnAscendente: TRadioButton
        Left = 11
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Ordine Ascendente'
        Enabled = False
        TabOrder = 0
        OnClick = RdBtnAscendenteClick
      end
      object RdBtnDiscendente: TRadioButton
        Left = 11
        Top = 102
        Width = 121
        Height = 17
        Caption = 'Ordine Discendente'
        Enabled = False
        TabOrder = 1
        OnClick = RdBtnDiscendenteClick
      end
      object RdBtnOrdinato: TRadioButton
        Left = 11
        Top = 133
        Width = 121
        Height = 17
        Caption = 'Non Ordinato'
        Enabled = False
        TabOrder = 2
        OnClick = RdBtnOrdinatoClick
      end
      object CkBGruppo: TCheckBox
        Left = 11
        Top = 163
        Width = 165
        Height = 21
        Caption = 'Campo di raggruppamento'
        Enabled = False
        TabOrder = 3
        OnClick = CkBGruppoClick
      end
    end
    object Intestazioni: TTabSheet
      Caption = 'Intestazioni'
      object LblCorrenteCampo: TLabel
        Left = 8
        Top = 8
        Width = 113
        Height = 13
        Caption = 'Campo Selezionato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 63
        Width = 116
        Height = 13
        Caption = 'Intestazione Campo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EdtIntestazione: TEdit
        Left = 8
        Top = 88
        Width = 169
        Height = 21
        TabOrder = 0
        OnChange = EdtIntestazioneChange
        OnEnter = EdtIntestazioneEnter
      end
    end
  end
end

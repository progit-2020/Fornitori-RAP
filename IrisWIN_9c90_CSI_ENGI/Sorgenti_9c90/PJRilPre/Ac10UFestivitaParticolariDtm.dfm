inherited Ac10FFestivitaParticolariDtm: TAc10FFestivitaParticolariDtm
  OldCreateOrder = True
  Height = 272
  Width = 348
  object selCSI010Master: TOracleDataSet
    SQL.Strings = (
      'select CSI010.*, CSI010.rowid'
      '  from CSI010_FESTIVITA_PARTICOLARI CSI010'
      ' where CSI010.PROGRESSIVO < 0'
      
        ' order by CSI010.DATA_FESTIVITA desc, CSI010.TIPO_FESTIVITA, CSI' +
        '010.INIZIO_SCELTA, CSI010.FINE_SCELTA, CSI010.FILTRO_ANAGRA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    AfterInsert = selCSI010MasterAfterInsert
    BeforePost = BeforePostNoStorico
    AfterScroll = selCSI010MasterAfterScroll
    Left = 32
    Top = 16
    object selCSI010MasterPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selCSI010MasterDATA_FESTIVITA: TDateTimeField
      FieldName = 'DATA_FESTIVITA'
      EditMask = '!99/99/0000;1;_'
    end
    object selCSI010MasterTIPO_FESTIVITA: TStringField
      FieldName = 'TIPO_FESTIVITA'
      Size = 1
    end
    object selCSI010MasterFILTRO_ANAGRA: TStringField
      FieldName = 'FILTRO_ANAGRA'
      Size = 2000
    end
    object selCSI010MasterTIPO_RECORD: TStringField
      FieldName = 'TIPO_RECORD'
      Size = 1
    end
    object selCSI010MasterCODIZIONE_APPLIC: TStringField
      FieldName = 'CONDIZIONE_APPLIC'
      Size = 1
    end
    object selCSI010MasterINIZIO_SCELTA: TDateTimeField
      FieldName = 'INIZIO_SCELTA'
      EditMask = '!99/99/0000;1;_'
    end
    object selCSI010MasterFINE_SCELTA: TDateTimeField
      FieldName = 'FINE_SCELTA'
      EditMask = '!99/99/0000;1;_'
    end
    object selCSI010MasterFLAG_SCELTA: TStringField
      FieldName = 'FLAG_SCELTA'
      Size = 1
    end
    object selCSI010MasterSCELTE_POSSIBILI: TStringField
      DisplayWidth = 50
      FieldName = 'SCELTE_POSSIBILI'
      Size = 100
    end
    object selCSI010MasterSCELTA_EFFETTUATA: TStringField
      FieldName = 'SCELTA_EFFETTUATA'
      Size = 1
    end
    object selCSI010MasterCOMP_NOSCELTA: TStringField
      FieldName = 'COMP_NOSCELTA'
      Size = 1
    end
    object selCSI010MasterCAUS_INSERT: TStringField
      FieldName = 'CAUS_INSERT'
      Size = 5
    end
    object selCSI010MasterCAUS_INCOMP: TStringField
      FieldName = 'CAUS_INCOMP'
      Size = 2000
    end
    object selCSI010MasterCAUS_SOSTIT: TStringField
      FieldName = 'CAUS_SOSTIT'
      Size = 2000
    end
    object selCSI010MasterCOMP_CAUSSOST: TStringField
      FieldName = 'COMP_CAUSSOST'
      Size = 1
    end
  end
  object selCSI010Detail: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, CSI010.*, CSI010.rowid'
      '  from CSI010_FESTIVITA_PARTICOLARI CS0I10, :FILTRO'
      ' order by CSI10.DATA_FESTIVITA desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00050000000000
      000000000000}
    BeforeInsert = selCSI010DetailBeforeInsert
    BeforeDelete = selCSI010DetailBeforeDelete
    Left = 112
    Top = 16
    object selCSI010DetailTIPO_RECORD: TStringField
      DisplayLabel = 'Tipo record'
      FieldName = 'TIPO_RECORD'
      ReadOnly = True
      Size = 1
    end
    object selCSI010DetailCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 30
    end
    object selCSI010DetailNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ReadOnly = True
      Size = 30
    end
    object selCSI010DetailMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selCSI010DetailPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selCSI010DetailDATA_FESTIVITA: TDateTimeField
      DisplayLabel = 'Data festivita'
      DisplayWidth = 10
      FieldName = 'DATA_FESTIVITA'
      ReadOnly = True
    end
    object selCSI010DetailTIPO_FESTIVITA: TStringField
      DisplayLabel = 'Tipo festivita'
      FieldName = 'TIPO_FESTIVITA'
      ReadOnly = True
      Size = 1
    end
    object selCSI010DetailFILTRO_ANAGRA: TStringField
      FieldName = 'FILTRO_ANAGRA'
      ReadOnly = True
      Visible = False
      Size = 2000
    end
    object selCSI010DetailCONDIZIONE_APPLIC: TStringField
      DisplayLabel = 'Condizione applicazione'
      FieldName = 'CONDIZIONE_APPLIC'
      Size = 1
    end
    object selCSI010DetailINIZIO_SCELTA: TDateTimeField
      DisplayLabel = 'Inizio scelta'
      DisplayWidth = 10
      FieldName = 'INIZIO_SCELTA'
      EditMask = '!99/99/0000;1;_'
    end
    object selCSI010DetailFINE_SCELTA: TDateTimeField
      DisplayLabel = 'Fine scelta'
      DisplayWidth = 10
      FieldName = 'FINE_SCELTA'
      EditMask = '!99/99/0000;1;_'
    end
    object selCSI010DetailFLAG_SCELTA: TStringField
      DisplayLabel = 'Flag scelta'
      FieldName = 'FLAG_SCELTA'
      Size = 1
    end
    object selCSI010DetailSCELTE_POSSIBILI: TStringField
      DisplayLabel = 'Scelte possibili'
      DisplayWidth = 20
      FieldName = 'SCELTE_POSSIBILI'
      Size = 50
    end
    object selCSI010DetailSCELTA_EFFETTUATA: TStringField
      DisplayLabel = 'Scelta effettuata'
      FieldName = 'SCELTA_EFFETTUATA'
      ReadOnly = True
      Size = 1
    end
    object selCSI010DetailDATA_SCELTA: TDateTimeField
      DisplayLabel = 'Data scelta'
      DisplayWidth = 10
      FieldName = 'DATA_SCELTA'
      ReadOnly = True
    end
    object selCSI010DetailCOMP_NOSCELTA: TStringField
      DisplayLabel = 'Comportamento no scelta'
      FieldName = 'COMP_NOSCELTA'
      Size = 1
    end
    object selCSI010DetailCAUS_INSERT: TStringField
      DisplayLabel = 'Causale S.P.'
      FieldName = 'CAUS_INSERT'
      Size = 5
    end
    object selCSI010DetailCAUS_INCOMP: TStringField
      DisplayLabel = 'S.P.: Causali non fruibili'
      DisplayWidth = 30
      FieldName = 'CAUS_INCOMP'
      Size = 2000
    end
    object selCSI010DetailCAUS_SOSTIT: TStringField
      DisplayLabel = 'Causali di esclusione'
      DisplayWidth = 30
      FieldName = 'CAUS_SOSTIT'
      Size = 2000
    end
    object selCSI010DetailCOMP_CAUSSOST: TStringField
      DisplayLabel = 'Comportamento causale di esclusione'
      FieldName = 'COMP_CAUSSOST'
      Size = 1
    end
    object selCSI010DetailSCELTA_DEFINITIVA: TStringField
      DisplayLabel = 'Scelta definitiva'
      FieldName = 'SCELTA_DEFINITIVA'
      Size = 1
    end
  end
  object dsrSelCSI10Detail: TDataSource
    AutoEdit = False
    DataSet = selCSI010Detail
    Left = 110
    Top = 70
  end
end

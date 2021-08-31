inherited A124FPermessiSindacaliDtM: TA124FPermessiSindacaliDtM
  OldCreateOrder = True
  Height = 73
  Width = 85
  object selT248: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T248.*, T248.ROWID, '
      
        '  T240.DESCRIZIONE SINDACATO, T240.RSU, T240.RAGGRUPPAMENTO, T24' +
        '0.SINDACATI_RAGGRUPPATI, T245.DESCRIZIONE ORGANISMO'
      'from '
      
        '  T248_PERMESSISINDACALI T248, T240_ORGANIZZAZIONISINDACALI T240' +
        ', T245_ORGANISMISINDACALI T245'
      'where progressivo = :PROGRESSIVO'
      '  and T248.COD_SINDACATO = T240.CODICE'
      '  and T240.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                           FROM T240_ORGANIZZAZIONISINDACALI'
      '                          WHERE CODICE = T240.CODICE'
      '                            AND DECORRENZA < T248.DATA)'
      '  and T248.COD_ORGANISMO = T245.CODICE'
      'order by data desc, cod_sindacato, cod_organismo')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001400000016000000500052004F004700520045005300530049005600
      4F000100000000001A00000043004F0044005F00530049004E00440041004300
      410054004F000100000000000800000044004100540041000100000000001600
      00004E0055004D00450052004F005F00500052004F0054000100000000001200
      000044004100540041005F00500052004F0054000100000000000A0000004400
      41004C004C0045000100000000000800000041004C004C004500010000000000
      060000004F005200450001000000000024000000410042004200410054005400
      45005F0043004F004D0050004500540045004E005A0045000100000000001A00
      000043004F0044005F004F005200470041004E00490053004D004F0001000000
      00000A00000053005400410054004F000100000000001A000000500052004F00
      54005F004D004F004400490046004900430041000100000000001A0000004400
      4100540041005F004D004F004400490046004900430041000100000000001200
      0000530049004E00440041004300410054004F00010000000000060000005200
      530055000100000000001C000000520041004700470052005500500050004100
      4D0045004E0054004F000100000000002A000000530049004E00440041004300
      4100540049005F00520041004700470052005500500050004100540049000100
      00000000120000004F005200470041004E00490053004D004F00010000000000
      1A0000005400490050004F005F005000450052004D004500530053004F000100
      000000001A000000500052004F0047005F005000450052004D00450053005300
      4F00010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT248AfterScroll
    OnNewRecord = selT248NewRecord
    Left = 24
    Top = 16
    object selT248PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT248TIPO_PERMESSO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object selT248DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248NUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      Size = 10
    end
    object selT248DATA_PROT: TDateTimeField
      DisplayLabel = 'Data Prot.'
      DisplayWidth = 10
      FieldName = 'DATA_PROT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      OnValidate = selT248DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      OnValidate = selT248DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      OnValidate = selT248OREValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      Size = 1
    end
    object selT248COD_SINDACATO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 5
      FieldName = 'COD_SINDACATO'
      Required = True
      Size = 10
    end
    object selT248SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 20
      FieldName = 'SINDACATO'
      Size = 40
    end
    object selT248COD_ORGANISMO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_ORGANISMO'
      Required = True
      Size = 5
    end
    object selT248ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      DisplayWidth = 20
      FieldName = 'ORGANISMO'
      Size = 80
    end
    object selT248STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object selT248PROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      Size = 10
    end
    object selT248DATA_MODIFICA: TDateTimeField
      DisplayLabel = 'Data Mod.'
      DisplayWidth = 10
      FieldName = 'DATA_MODIFICA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248RSU: TStringField
      FieldName = 'RSU'
      Visible = False
      Size = 1
    end
    object selT248RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Visible = False
      Size = 1
    end
    object selT248SINDACATI_RAGGRUPPATI: TStringField
      FieldName = 'SINDACATI_RAGGRUPPATI'
      Visible = False
      Size = 200
    end
    object selT248PROG_PERMESSO: TFloatField
      FieldName = 'PROG_PERMESSO'
      Required = True
      Visible = False
    end
  end
end

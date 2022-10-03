inherited S735FPunteggiFasceIncentiviMW: TS735FPunteggiFasceIncentiviMW
  OldCreateOrder = True
  Height = 220
  Width = 383
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select sg735.*, sg735.rowid'
      'from sg735_punteggifasce_incentivi sg735'
      'where tipologia = :tipo'
      'and codquota = :quota'
      'and flessibilita = :flex'
      'and :decorrenza <= decorrenza_fine'
      'and :scadenza >= decorrenza'
      'and (   :punteggio_da between punteggio_da and punteggio_a'
      '     or :punteggio_a between punteggio_da and punteggio_a)'
      'and (:sg735rowid is null or Rowid <> :sg735rowid)')
    Optimize = False
    Variables.Data = {
      0400000008000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000120000003A00530043004100440045004E00
      5A0041000C00000000000000000000001A0000003A00500055004E0054004500
      4700470049004F005F0044004100040000000000000000000000180000003A00
      500055004E00540045004700470049004F005F00410004000000000000000000
      0000160000003A005300470037003300350052004F0057004900440005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      00000C0000003A00510055004F00540041000500000000000000000000000A00
      00003A0046004C0045005800050000000000000000000000}
    Left = 64
    Top = 8
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * from t765_tipoquote T765'
      'where decorrenza = (select max(decorrenza) from t765_tipoquote'
      '                     where codice = T765.codice)'
      'order by codice  '
      '                       ')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F0054004100010000000000140000004400
      450043004F005200520045004E005A0041000100000000002800000043004100
      5500530041004C0045005F0041005300530045005300540041004D0045004E00
      54004F0001000000000012000000560050005F0049004E005400450052004100
      01000000000020000000560050005F00500052004F0050004F0052005A004900
      4F004E0041005400410001000000000010000000560050005F004E0045005400
      5400410001000000000018000000560050005F004E0045005400540041005200
      49005300500001000000000018000000560050005F0052004900530050004100
      52004D0049004F000100000000001C000000560050005F004E004F0052004900
      53005000410052004D0049004F000100000000001E000000560050005F005100
      550041004E00540049005400410054004900560041000100000000000E000000
      4100430043004F004E0054004900010000000000}
    Left = 136
    Top = 8
    object selT765CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT765DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT765TIPOQUOTA: TStringField
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
    object selT765DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT765CAUSALE_ASSESTAMENTO: TStringField
      FieldName = 'CAUSALE_ASSESTAMENTO'
      Size = 5
    end
    object selT765VP_INTERA: TStringField
      FieldName = 'VP_INTERA'
      Size = 6
    end
    object selT765VP_PROPORZIONATA: TStringField
      FieldName = 'VP_PROPORZIONATA'
      Size = 6
    end
    object selT765VP_NETTA: TStringField
      FieldName = 'VP_NETTA'
      Size = 6
    end
    object selT765VP_NETTARISP: TStringField
      FieldName = 'VP_NETTARISP'
      Size = 6
    end
    object selT765VP_RISPARMIO: TStringField
      FieldName = 'VP_RISPARMIO'
      Size = 6
    end
    object selT765VP_NORISPARMIO: TStringField
      FieldName = 'VP_NORISPARMIO'
      Size = 6
    end
    object selT765VP_QUANTITATIVA: TStringField
      FieldName = 'VP_QUANTITATIVA'
      Size = 6
    end
    object selT765ACCONTI: TStringField
      FieldName = 'ACCONTI'
    end
  end
end

unit W035UMessaggisticaDM;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, W000UMessaggi,
  SysUtils, Classes, DB, Oracle, OracleData;

type
  TW035FMessaggisticaDM = class(TDataModule)
    selT282Inviati: TOracleDataSet;
    selT284: TOracleDataSet;
    delT284: TOracleQuery;
    selT283: TOracleDataSet;
    selT282ID: TOracleQuery;
    selT282InviatiID2: TFloatField;
    selT282InviatiSTATO: TStringField;
    selT282InviatiDATA_INVIO: TDateTimeField;
    selT282InviatiMITTENTE: TStringField;
    selT282InviatiOGGETTO: TStringField;
    selT282InviatiTESTO: TStringField;
    selT282InviatiSELEZIONE_ANAGRAFICA: TStringField;
    selT282InviatiD_MITTENTE: TStringField;
    selT282InviatiD_STATO: TStringField;
    insT283: TOracleQuery;
    selT283Allegato: TOracleQuery;
    delT283: TOracleQuery;
    selT282InviatiD_ALLEGATI: TFloatField;
    selT282InviatiD_DEST_LETTI: TFloatField;
    selT282InviatiD_DEST_TOT: TFloatField;
    insT283Dup: TOracleQuery;
    selT282Ricevuti: TOracleDataSet;
    selT282RicevutiD_MITTENTE: TStringField;
    selT282RicevutiD_STATO: TStringField;
    selT282RicevutiDATA_INVIO: TDateTimeField;
    selT282RicevutiOGGETTO: TStringField;
    selT282RicevutiTESTO: TStringField;
    selT282RicevutiID: TFloatField;
    selT282RicevutiSTATO: TStringField;
    selT282RicevutiMITTENTE: TStringField;
    selT282RicevutiDATA_LETTURA: TDateTimeField;
    selT282RicevutiD_ALLEGATI: TFloatField;
    selT282RicevutiSELEZIONE_ANAGRAFICA: TStringField;
    updT284Lettura: TOracleQuery;
    selT282RicevutiPROGRESSIVO: TIntegerField;
    selT282InviatiD_STATO_LETTURA: TStringField;
    selT282InviatiD_PERC_LETTURA: TFloatField;
    selT282RicevutiDATA_RICEZIONE: TDateTimeField;
    updT284Ricezione: TOracleQuery;
    selT282InviatiD_PERC_RICEZIONE: TFloatField;
    selT282InviatiD_DEST_RICEVUTI: TFloatField;
    selT282InviatiD_STATO_RICEZIONE: TStringField;
    selT285: TOracleDataSet;
    selOperatori: TOracleDataSet;
    selT282RicevutiOper: TOracleDataSet;
    DateTimeField1: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    DateTimeField2: TDateTimeField;
    StringField3: TStringField;
    StringField4: TStringField;
    FloatField1: TFloatField;
    StringField5: TStringField;
    FloatField2: TFloatField;
    StringField6: TStringField;
    StringField7: TStringField;
    DateTimeField3: TDateTimeField;
    selT282RicevutiOperUTENTE: TStringField;
    selT282InviatiID_ORIGINALE: TFloatField;
    updT285Lettura: TOracleQuery;
    selI060: TOracleDataSet;
    updT285Ricezione: TOracleQuery;
    selT282RicevutiID_ORIGINALE: TFloatField;
    selT282RicevutiOperID_ORIGINALE: TFloatField;
    selElencoMsg: TOracleDataSet;
    selElencoMsgLEVEL: TFloatField;
    selElencoMsgDATA_INVIO: TDateTimeField;
    selElencoMsgSTATO: TStringField;
    selElencoMsgMITTENTE: TStringField;
    selElencoMsgOGGETTO: TStringField;
    selElencoMsgTESTO: TStringField;
    selElencoMsgID: TFloatField;
    selElencoMsgID_ORIGINALE: TFloatField;
    selElencoMsgD_MITTENTE: TStringField;
    selElencoMsgD_DESTINATARI: TStringField;
    selT282InviatiD_RISPOSTE_TOT: TFloatField;
    selT282RicevutiD_RISPOSTE_TOT: TFloatField;
    selT282RicevutiOperD_RISPOSTE_TOT: TFloatField;
    selT282RicevutiRICEVENTE: TStringField;
    selT282InviatiRICEVENTE: TStringField;
    selT282RicevutiOperRICEVENTE: TStringField;
    selT282InviatiLETTURA_OBBLIGATORIA: TStringField;
    selT282RicevutiLETTURA_OBBLIGATORIA: TStringField;
    selT282RicevutiOperLETTURA_OBBLIGATORIA: TStringField;
    selT282InviatiD_DESTINATARI: TStringField;
    delT285: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT282InviatiAfterScroll(DataSet: TDataSet);
    procedure selT282InviatiAfterOpen(DataSet: TDataSet);
    procedure selT282InviatiCalcFields(DataSet: TDataSet);
    procedure selT282RicevutiAfterOpen(DataSet: TDataSet);
    procedure selT282RicevutiAfterScroll(DataSet: TDataSet);
    procedure selT284AfterOpen(DataSet: TDataSet);
    procedure selT285AfterOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT282InviatiNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses W035UMessaggistica, medpIWDBGrid;

{$R *.dfm}

procedure TW035FMessaggisticaDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
 except
 end;
end;

procedure TW035FMessaggisticaDM.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if Self.Components[i] is TOracleQuery then
      (Self.Components[i] as TOracleQuery).Close;
  end;
 except
 end;
end;

procedure TW035FMessaggisticaDM.selT282InviatiAfterOpen(DataSet: TDataSet);
begin
  (DataSet.FieldByName('DATA_INVIO') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';

  // dopo una open pulisce le variabili dei dataset collegati
  // affinché l'afterscroll effettui una riapertura degli stessi
  delT284.ClearVariables;
  selT284.ClearVariables;
  selT285.ClearVariables;
  selT283.ClearVariables;
end;

procedure TW035FMessaggisticaDM.selT282InviatiAfterScroll(DataSet: TDataSet);
begin
  // destinatari: imposta oraclequery e dataset
  delT284.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
  selT284.Close;
  selT284.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
  selT284.Open;

  // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
  selT285.Close;
  selT285.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
  selT285.Open;
  // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

  // allegati: imposta dataset
  selT283.Close;
  selT283.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
  selT283.Open;

  // aggiornamento dati messaggio
  with (Owner as TW035FMessaggistica) do
  begin
    //if selT282.State = dsBrowse then
    if grdMessaggi.medpStato = msBrowse then
    begin
      LeggiMessaggio;
    end;
  end;
end;

procedure TW035FMessaggisticaDM.selT282InviatiCalcFields(DataSet: TDataSet);
var
  Stato,DStato,DStatoLettura,DStatoRicezione: String;
  DestRicevuti,DestLetti,DestTot: Integer;
begin
  // D_STATO: descrizione stato
  Stato:=DataSet.FieldByName('STATO').AsString;
  if Stato = 'S' then
    DStato:='Sospeso'
  else if Stato = 'I' then
    DStato:='Inviato'
  else if Stato = 'C' then
    DStato:='Cancellato';
  DataSet.FieldByName('D_STATO').AsString:=DStato;

  // solo per invio
  if DataSet = selT282Inviati then
  begin
    // D_STATO_LETTURA: numero di destinatari che hanno letto il messaggio
    // D_STATO_RICEZIONE: numero di destinatari che hanno ricevuto il messaggio
    if Stato = 'S' then
    begin
      DStatoLettura:='';
      DStatoRicezione:='';
    end
    else
    begin
      DestTot:=DataSet.FieldByName('D_DEST_TOT').AsInteger;

      // destinatari che hanno ricevuto il messaggio
      DestRicevuti:=DataSet.FieldByName('D_DEST_RICEVUTI').AsInteger;
      if DestRicevuti = 0 then
        DStatoRicezione:=A000TraduzioneStringhe(A000MSG_W035_MSG_DARICEVERE)
      else if DestRicevuti = DestTot then
        DStatoRicezione:=A000TraduzioneStringhe(A000MSG_W035_MSG_RICEVUTO)
      else
      begin
        if DestRicevuti = 1 then
          DStatoRicezione:=A000TraduzioneStringhe(A000MSG_W035_MSG_RICEVUTOPARZIALMENTE_1)
        else
          DStatoRicezione:=A000TraduzioneStringhe(Format(A000MSG_W035_MSG_FMT_RICEVUTOPARZIALMENTE,[DestRicevuti]));
      end;

      // destinatari che hanno letto il messaggio
      DestLetti:=DataSet.FieldByName('D_DEST_LETTI').AsInteger;
      if DestLetti = 0 then
        DStatoLettura:=A000TraduzioneStringhe(A000MSG_W035_MSG_DALEGGERE)
      else if DestLetti = DestTot then
        DStatoLettura:=A000TraduzioneStringhe(A000MSG_W035_MSG_LETTO)
      else
      begin
        if DestLetti = 1 then
          DStatoLettura:=A000TraduzioneStringhe(A000MSG_W035_MSG_LETTOPARZIALMENTE_1)
        else
          DStatoLettura:=A000TraduzioneStringhe(Format(A000MSG_W035_MSG_FMT_LETTOPARZIALMENTE,[DestLetti]));
      end;
    end;

    DataSet.FieldByName('D_STATO_RICEZIONE').AsString:=DStatoRicezione;
    DataSet.FieldByName('D_STATO_LETTURA').AsString:=DStatoLettura;
  end;
end;

procedure TW035FMessaggisticaDM.selT282InviatiNewRecord(DataSet: TDataSet);
begin
  selT282Inviati.FieldByName('LETTURA_OBBLIGATORIA').AsString:='N';
end;

procedure TW035FMessaggisticaDM.selT282RicevutiAfterOpen(DataSet: TDataSet);
// evento gestito su
//   - selT282Ricevuti
//   - selT282RicevutiOper
begin
  (DataSet.FieldByName('DATA_INVIO') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  (DataSet.FieldByName('DATA_LETTURA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  (DataSet.FieldByName('DATA_RICEZIONE') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';

  // dopo una open pulisce le variabili dei dataset collegati
  // affinché l'afterscroll effettui una riapertura degli stessi
  selT284.ClearVariables;
  selT285.ClearVariables;
  selT283.ClearVariables;
end;

procedure TW035FMessaggisticaDM.selT282RicevutiAfterScroll(DataSet: TDataSet);
// evento gestito su
//   - selT282Ricevuti
//   - selT282RicevutiOper
begin
  if DataSet.RecordCount > 0 then
  begin
    // destinatari: imposta dataset
    selT284.Close;
    selT284.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
    selT284.Open;

    // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.ini
    selT285.Close;
    selT285.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
    selT285.Open;
    // SANGIULIANOMILANESE_COMUNE - commessa 2013/115 - VARIE 1.fine

    // allegati: imposta dataset
    selT283.Close;
    selT283.SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
    selT283.Open;

    with (Owner as TW035FMessaggistica) do
    begin
      LeggiMessaggio;

      // aggiorna stato ricezione se necessario
      CtrlImpostaStatoRicezione(nil);
    end;
  end
  else
  begin
    // pulisce interfaccia
    with (Owner as TW035FMessaggistica) do
    begin
      ClearMessaggio;
    end;
  end;
end;

procedure TW035FMessaggisticaDM.selT284AfterOpen(DataSet: TDataSet);
begin
  (selT284.FieldByName('DATA_LETTURA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  (selT284.FieldByName('DATA_RICEZIONE') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

procedure TW035FMessaggisticaDM.selT285AfterOpen(DataSet: TDataSet);
begin
  (selT285.FieldByName('DATA_LETTURA') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  (selT285.FieldByName('DATA_RICEZIONE') as TDateTimeField).DisplayFormat:='dd/mm/yyyy hhhh.nn';
end;

end.

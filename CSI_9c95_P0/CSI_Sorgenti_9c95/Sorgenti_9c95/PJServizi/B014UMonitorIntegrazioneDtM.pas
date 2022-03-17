unit B014UMonitorIntegrazioneDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBGrids, Oracle, OracleData, A000UInterfaccia, C180FUnzioniGenerali, Variants,
  A000UCostanti, A000USessione;

type
  TB014FMonitorIntegrazioneDtM = class(TDataModule)
    selIA000: TOracleDataSet;
    dsrIA000: TDataSource;
    selIA190: TOracleDataSet;
    dsrIA190: TDataSource;
    selIA190ORA: TStringField;
    selIA190STRUTTURE: TStringField;
    selIA100Nome: TOracleDataSet;
    selIA100: TOracleDataSet;
    selIA110: TOracleDataSet;
    dsrIA100: TDataSource;
    dsrIA110: TDataSource;
    selIADati: TOracleDataSet;
    dsrIADati: TDataSource;
    selIA100NOME_STRUTTURA: TStringField;
    selIA100TIPO_STRUTTURA: TStringField;
    selIA100NOME_FILE: TStringField;
    selIA100FTP_HOST: TStringField;
    selIA100FTP_USER: TStringField;
    selIA100FTP_PASSWORD: TStringField;
    selIA100FTP_PORT: TIntegerField;
    selIA100LOG_ERRORE: TStringField;
    selIA100LOG_ESEGUITO: TStringField;
    selIA100RESET_DATI: TStringField;
    selIA100CANCELLAZIONE: TStringField;
    selIA100B014PERSONALIZZATA: TStringField;
    selIA110NOME_STRUTTURA: TStringField;
    selIA110AZIENDA: TStringField;
    selIA110INTESTAZIONE: TStringField;
    selIA110TABELLA: TStringField;
    selIA110CAMPO: TStringField;
    selIA110POS_DATO: TIntegerField;
    selIA110LUNG_DATO: TIntegerField;
    selIA110NOME_DATO: TStringField;
    selIA110VIRTUALE: TStringField;
    selIA110TIPO_DATO: TStringField;
    selIA110FMT_DATA: TStringField;
    selIA110STORICO: TStringField;
    selI090: TOracleDataSet;
    delIA000: TOracleQuery;
    SessioneAzienda: TOracleSession;
    dsrIA130: TDataSource;
    selIA130: TOracleDataSet;
    selIA130AZIENDA: TStringField;
    selIA130TABELLA: TStringField;
    selIA130TRIGGER_TEXT: TStringField;
    scrTrigger: TOracleScript;
    selUserErrors: TOracleDataSet;
    selIA100DIREZIONE_DATI: TStringField;
    dsrI090: TDataSource;
    insIA120: TOracleQuery;
    selIA100SCRIPT_BEFORE: TStringField;
    selIA100SCRIPT_AFTER: TStringField;
    selSourceB014Personalizzata: TOracleDataSet;
    scrGenerico: TOracleQuery;
    selIA110PROPRIETA: TStringField;
    selIA110TABELLA_DESC: TStringField;
    selIA100LOG_MODIFICA: TStringField;
    procedure selIA110BeforeInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selIA000AfterOpen(DataSet: TDataSet);
    procedure selIA190ORAValidate(Sender: TField);
    procedure selIA110NewRecord(DataSet: TDataSet);
    procedure selIA100BeforeDelete(DataSet: TDataSet);
    procedure selIA100AfterScroll(DataSet: TDataSet);
    procedure selIA100AfterPost(DataSet: TDataSet);
    procedure selIA100AfterOpen(DataSet: TDataSet);
    procedure dsrIA130StateChange(Sender: TObject);
    procedure selIA130BeforeDelete(DataSet: TDataSet);
    procedure scrTriggerError(Sender: TOracleScript);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selIA000BeforeInsert(DataSet: TDataSet);
    procedure selIA000BeforeDelete(DataSet: TDataSet);
    procedure selIA000BeforePost(DataSet: TDataSet);
    procedure selIA000AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    lstErrori:TStringList;
    FlagStorico:String;
    function GetNomeTrigger:String;
  public
    { Public declarations }
    procedure GestisciTriggerIA130(Azione:String);
  end;

var
  B014FMonitorIntegrazioneDtM: TB014FMonitorIntegrazioneDtM;

implementation

uses B014UIntegrazioneAnagrafica;

{$R *.DFM}

procedure TB014FMonitorIntegrazioneDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      if (Components[i] as TOracleQuery).Session = nil then
        (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      if (Components[i] as TOracleDataSet).Session = nil then
        (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  try
    if not SessioneOracle.Connected then
    begin
      SessioneOracle.LogonDatabase:=B014FIntegrazioneAnagrafica.edtDatabase.Text;
      A000LogonDBOracle(SessioneOracle);
    end;
  except
  end;
  lstErrori:=TStringList.Create;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA000AfterOpen(
  DataSet: TDataSet);
var i:Integer;
begin
  for i:=0 to selIA000.FieldCount - 1 do
    if selIA000.Fields[i].DisplayWidth > 20 then
      selIA000.Fields[i].DisplayWidth:=20;
  with B014FIntegrazioneAnagrafica.dgrdIA000 do
    for i:=0 to Columns.Count - 1 do
      if Columns[i].Field.FieldName = 'TESTO_SQL' then
      begin
        Columns[i].ButtonStyle:=cbsEllipsis;
        Break;
      end;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA000AfterScroll(DataSet: TDataSet);
begin
  if B014FIntegrazioneAnagrafica.PageControl1.ActivePage = B014FIntegrazioneAnagrafica.tabModificaLog then
    B014FIntegrazioneAnagrafica.frmToolbarFiglio.actTFModifica.Enabled:=
      (selIA000.FieldByName('STATO').AsString = 'E') or (selIA000.FieldByName('STATO').AsString = 'R');
end;

procedure TB014FMonitorIntegrazioneDtM.selIA000BeforeDelete(DataSet: TDataSet);
begin
  if B014FIntegrazioneAnagrafica.PageControl1.ActivePage = B014FIntegrazioneAnagrafica.tabModificaLog then
    Abort;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA000BeforeInsert(DataSet: TDataSet);
begin
  if B014FIntegrazioneAnagrafica.PageControl1.ActivePage = B014FIntegrazioneAnagrafica.tabModificaLog then
    Abort;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA000BeforePost(DataSet: TDataSet);
begin
  if B014FIntegrazioneAnagrafica.PageControl1.ActivePage = B014FIntegrazioneAnagrafica.tabModificaLog then
  begin
    if (selIA000.FieldByName('STATO').AsString <> 'E') and (selIA000.FieldByName('STATO').AsString <> 'R') then
      raise Exception.Create('Stato non valido!'); 
  end;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA190ORAValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TB014FMonitorIntegrazioneDtM.selIA110NewRecord(
  DataSet: TDataSet);
begin
  if FlagStorico <> 'S' then
    FlagStorico:='N';
  selIA110.FieldByName('NOME_STRUTTURA').AsString:=selIA100.FieldByName('NOME_STRUTTURA').AsString;
  selIA110.FieldByName('STORICO').AsString:=FlagStorico;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA100BeforeDelete(
  DataSet: TDataSet);
{Eliminazione dei dati di dettaglio}
begin
  if MessageDlg('Confermare la cancellazione?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then Abort;
  selIA110.DisableControls;
  try
    selIA110.First;
    while not selIA110.Eof do
      selIA110.Delete;
  finally
    selIA110.EnableControls;
  end
end;

procedure TB014FMonitorIntegrazioneDtM.selIA100AfterScroll(
  DataSet: TDataSet);
{Refresh dei dati di dettaglio}
begin
  selIA110.SetVariable('NOME_STRUTTURA',selIA100.FieldByName('NOME_STRUTTURA').AsString);
  selIA110.Close;
  selIA110.Open;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA100AfterPost(
  DataSet: TDataSet);
{Allineamento modifica del nome stuttura sui dati di dettaglio}
begin
  if selIA100.FieldByName('NOME_STRUTTURA').AsString <> selIA110.FieldByName('NOME_STRUTTURA').AsString then
  begin
    selIA110.DisableControls;
    try
      selIA110.First;
      while not selIA110.Eof do
      begin
        selIA110.Edit;
        selIA110.FieldByName('NOME_STRUTTURA').AsString:=selIA100.FieldByName('NOME_STRUTTURA').AsString;
        selIA110.Post;
        selIA110.Next;
      end;
    finally
      selIA110.EnableControls;
    end;
  end;
  selIA100.Filter:='LOG_MODIFICA = ''S''';
  selIA100.Filtered:=True;
  B014FIntegrazioneAnagrafica.tabModificaLog.TabVisible:=selIA100.RecordCount > 0;
  selIA100.Filter:='';
  selIA100.Filtered:=False;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA100AfterOpen(
  DataSet: TDataSet);
var i:Integer;
begin
  for i:=0 to DataSet.FieldCount - 1 do
    if DataSet.Fields[i].DisplayWidth > 15 then
      DataSet.Fields[i].DisplayWidth:=15;
end;

procedure TB014FMonitorIntegrazioneDtM.dsrIA130StateChange(
  Sender: TObject);
begin
  with B014FIntegrazioneAnagrafica do
  begin
    TInserGriglia.Enabled:=dsrIA130.State = dsBrowse;
    TModifGriglia.Enabled:=dsrIA130.State = dsBrowse;
    TCancGriglia.Enabled:=dsrIA130.State = dsBrowse;
    TAnnullaGriglia.Enabled:=dsrIA130.State <> dsBrowse;
    TRegisGriglia.Enabled:=dsrIA130.State <> dsBrowse;
    TCreaTrigger.Enabled:=dsrIA130.State = dsBrowse;
    TEliminaTrigger.Enabled:=dsrIA130.State = dsBrowse;
  end;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA130BeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Confermare la cancellazione?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then Abort;
  try
    GestisciTriggerIA130('ELIMINA');
  except
  end;
end;

procedure TB014FMonitorIntegrazioneDtM.GestisciTriggerIA130(Azione:String);
begin
  with scrTrigger do
  try
    Output.Clear;
    lstErrori.Clear;
    SessioneAzienda.Logoff;
    SessioneAzienda.LogonDatabase:=SessioneOracle.LogonDatabase;
    SessioneAzienda.LogonUserName:=VarToStr(selI090.Lookup('AZIENDA',selIA130.FieldByName('AZIENDA').AsString,'UTENTE'));
    SessioneAzienda.LogonPassword:=R180Decripta(VarToStr(selI090.Lookup('AZIENDA',selIA130.FieldByName('AZIENDA').AsString,'PAROLACHIAVE')),21041974);
    SessioneAzienda.Logon;
    if Azione = 'CREA' then
      Lines.Text:=selIA130.FieldByName('TRIGGER_TEXT').AsString
    else
      Lines.Text:='DROP TRIGGER ' + GetNomeTrigger + ';';
    Execute;
    selUserErrors.SetVariable('NAME',GetNomeTrigger);
    selUserErrors.Close;
    selUserErrors.Open;
    while not selUserErrors.Eof do
    begin
      scrTrigger.Output.Add(Format('%-5s %-5s %s',[selUserErrors.FieldByName('LINE').AsString,selUserErrors.FieldByName('POSITION').AsString,selUserErrors.FieldByName('TEXT').AsString]));
      selUserErrors.Next;
    end;
    ShowMessage(scrTrigger.Output.Text);
  finally
    SessioneAzienda.Logoff;
  end;
end;

function TB014FMonitorIntegrazioneDtM.GetNomeTrigger:String;
var i,p:Integer;
    S:String;
begin
  Result:='';
  S:=UpperCase(selIA130.FieldByName('TRIGGER_TEXT').AsString);
  p:=Pos('TRIGGER',S);
  if p = 0 then exit;
  for i:=p + 8 to Length(S) do
    if S[i] in [#10,#13,#32] then
    begin
      if Result <> '' then
        Break;
    end
    else
      Result:=Result + S[i];
end;

procedure TB014FMonitorIntegrazioneDtM.scrTriggerError(
  Sender: TOracleScript);
begin
  lstErrori.Add(IntToStr(scrTrigger.CurrentCommand.ErrorCode) + '-' + scrTrigger.CurrentCommand.ErrorMessage);
end;

procedure TB014FMonitorIntegrazioneDtM.DataModuleDestroy(Sender: TObject);
begin
  lstErrori.Free;
end;

procedure TB014FMonitorIntegrazioneDtM.selIA110BeforeInsert(DataSet: TDataSet);
begin
  FlagStorico:=DataSet.FieldByName('STORICO').AsString;
end;

end.

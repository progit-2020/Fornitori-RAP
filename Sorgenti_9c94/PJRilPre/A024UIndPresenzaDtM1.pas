unit A024UIndPresenzaDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, L021Call, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, ControlloVociPaghe,
  A000UMessaggi, A024UIndPresenzaMW;

type
  TA024FIndPresenzaDtM1 = class(TDataModule)
    D160: TDataSource;
    D171: TDataSource;
    D162: TDataSource;
    Q163: TOracleDataSet;
    Q160: TOracleDataSet;
    Q160CODICE: TStringField;
    Q160INDENNITA: TStringField;
    Ins160: TOracleQuery;
    Update160: TOracleQuery;
    Delete160: TOracleQuery;
    Upd160: TOracleQuery;
    Del160: TOracleQuery;
    Q162: TOracleDataSet;
    Q162CODICE: TStringField;
    Q162DESCRIZIONE: TStringField;
    Q162IMPORTO: TFloatField;
    Q162VOCEPAGHE: TStringField;
    Q162TIPO: TStringField;
    Q162NUMTURNI: TFloatField;
    Q162TURNI: TStringField;
    Q162ASSENZE: TStringField;
    Q162CODICE2: TStringField;
    Q171: TOracleDataSet;
    Q171CODICE: TStringField;
    Q171GIORNI: TFloatField;
    Q171ESPRESSIONE: TStringField;
    Del171: TOracleQuery;
    Upd171: TOracleQuery;
    Q265: TOracleDataSet;
    Look162: TOracleDataSet;
    Look162CODICE: TStringField;
    Look162DESCRIZIONE: TStringField;
    selT164: TOracleDataSet;
    dsrT164: TDataSource;
    selT164CODICE: TStringField;
    selT164DECORRENZA: TDateTimeField;
    selT164ESPRESSIONE: TStringField;
    delT164: TOracleQuery;
    updT164: TOracleQuery;
    selI010: TOracleDataSet;
    dsrI010: TDataSource;
    selSQL: TOracleDataSet;
    testSQL: TOracleQuery;
    selT164SCADENZA: TDateTimeField;
    Q162PRIORITA: TIntegerField;
    Q162INDENNITA_INCOMPATIBILI: TStringField;
    selT162Incomp: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    Q162TURNO1: TFloatField;
    Q162TURNO2: TFloatField;
    Q162TURNO3: TFloatField;
    Q162TURNO4: TFloatField;
    Q162COEFFICIENTE: TFloatField;
    Q162ARROTONDAMENTO: TStringField;
    selT275: TOracleDataSet;
    Q160D_INDENNITA: TStringField;
    Q163CODICE: TStringField;
    Q163DESCRIZIONE: TStringField;
    Q160DESCRIZIONE: TStringField;
    SelQ162: TOracleDataSet;
    Q162ASSENZE_ABILITATE: TStringField;
    selT164TIPO_ASSOCIAZIONE: TStringField;
    Q162SUPPL_5GGLAV: TStringField;
    Q162CAUPRES_RIEPORE: TStringField;
    selT275Escluse: TOracleDataSet;
    Q162D_CAUPRES_RIEPORE: TStringField;
    dsrT275Escluse: TDataSource;
    selT275EscluseCODICE: TStringField;
    selT275EscluseDESCRIZIONE: TStringField;
    Q162NMESI_EQUITURNI: TFloatField;
    Q162OFFSET_METADEBITO: TIntegerField;
    Q162MATURA_SABATO: TStringField;
    Q162PIANIF_NOOP: TStringField;
    Q162MIN_TURNI_PRIORITARI: TStringField;
    Q162MIN_TURNI_SECONDARI: TStringField;
    Q162OFFSET_GGPREC: TStringField;
    Q162ESCLUDI_FESTIVI: TStringField;
    Q162MATURAZ_PROP_DEBITOGG: TStringField;
    procedure A024FIndPresenzaDtM1Create(Sender: TObject);
    procedure A024FIndPresenzaDtM1Destroy(Sender: TObject);
    procedure Q163AfterScroll(DataSet: TDataSet);
    procedure Q163AfterPost(DataSet: TDataSet);
    procedure Q163BeforePost(DataSet: TDataSet);
    procedure Q163BeforeDelete(DataSet: TDataSet);
    procedure Q163BeforeEdit(DataSet: TDataSet);
    procedure Q163AfterCancel(DataSet: TDataSet);
    procedure Q163AfterDelete(DataSet: TDataSet);
    procedure Q162AfterCancel(DataSet: TDataSet);
    procedure Q162AfterDelete(DataSet: TDataSet);
    procedure Q162AfterEdit(DataSet: TDataSet);
    procedure Q162AfterPost(DataSet: TDataSet);
    procedure Q162AfterScroll(DataSet: TDataSet);
    procedure Q162BeforeDelete(DataSet: TDataSet);
    procedure Q162BeforePost(DataSet: TDataSet);
    procedure Q171NewRecord(DataSet: TDataSet);
    procedure Q162NewRecord(DataSet: TDataSet);
    procedure BDEQ162CODICEValidate(Sender: TField);
    procedure BDEQ162TIPOValidate(Sender: TField);
    procedure Q163ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure Q160ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure selT164NewRecord(DataSet: TDataSet);
    procedure selT164SCADENZAValidate(Sender: TField);
  private
    { Private declarations }
    selControlloVociPaghe:TControlloVociPaghe;
    A024MW:TA024FIndPresenzaMW;
    procedure GetTurni;
    procedure VerificaSQL(InSQL:String);
  public
    { Public declarations }
  end;

var
  A024FIndPresenzaDtM1: TA024FIndPresenzaDtM1;

implementation

uses A024UIndPresenza, A024URegoleIndennita;

{$R *.DFM}

procedure TA024FIndPresenzaDtM1.VerificaSQL(InSQL:String);
begin
  if Trim(InSQL) = '' then
    Exit;
  InSQL:=StringReplace(InSQL,':PROGRESSIVO','0',[rfIgnoreCase]);
  InSQL:=StringReplace(InSQL,':DATA','SYSDATE',[rfIgnoreCase]);
  InSQL:=StringReplace(InSQL,':GGLAV','5',[rfIgnoreCase]);
  with TOracleQuery.Create(nil) do
  begin
    try
      Session:=SessioneOracle;
      SQL.Add('SELECT ' + InSQL + ' FROM DUAL');
      Execute;
    except
      on E:exception do
      begin
        Free;
        raise Exception.Create(E.Message);
      end;
    end;
    Free;
  end;
end;

procedure TA024FIndPresenzaDtM1.A024FIndPresenzaDtM1Create(
  Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A024MW:=TA024FIndPresenzaMW.Create(Self);
  A024MW.selT162:=Q162;
  Q163.Open;
  selI010.Open;
  selT275Escluse.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA024FIndPresenzaDtM1.A024FIndPresenzaDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  FreeAndNil(selControlloVociPaghe);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  if A024MW <> nil then
    FreeAndNil(A024MW);
end;

//Gestione profili di indennità
procedure TA024FIndPresenzaDtM1.Q163AfterScroll(DataSet: TDataSet);
begin
  Q160.Close;
  Q160.SetVariable('CODICE',Q163.FieldByName('CODICE').AsString);
  Q160.Open;
end;

procedure TA024FIndPresenzaDtM1.Q163BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA024FIndPresenzaDtM1.Q163AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q163],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA024FIndPresenzaDtM1.Q163BeforeEdit(DataSet: TDataSet);
begin
  Q160.CachedUpdates:=True;
end;

procedure TA024FIndPresenzaDtM1.Q163BeforePost(DataSet: TDataSet);
begin
  if QueryPK1.EsisteChiave('T163_CODICIINDENNITA',Q163.RowId,Q163.State,['CODICE'],[Q163.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA024FIndPresenzaDtM1.Q163AfterPost(DataSet: TDataSet);
var C:String;
begin
  C:=Q163.FieldByName('CODICE').AsString;
  RegistraLog.RegistraOperazione;
  if Q160.UpdatesPending then
    SessioneOracle.ApplyUpdates([Q160],True);
  SessioneOracle.ApplyUpdates([Q163],True);
  SessioneOracle.Commit;
  Q160.CachedUpdates:=False;
  Q163.Close;
  Q163.Open;
  Q163.Locate('CODICE',C,[]);
end;

procedure TA024FIndPresenzaDtM1.Q163AfterCancel(DataSet: TDataSet);
begin
  Q163.CancelUpdates;
  Q160.CachedUpdates:=False;
end;

procedure TA024FIndPresenzaDtM1.Q162AfterCancel(DataSet: TDataSet);
begin
  Q162.CancelUpdates;
  if Q171.State in [dsEdit,dsInsert] then
    Q171.Cancel;
  Q171.CachedUpdates:=False;
  selT164.CachedUpdates:=False;
  if selT164.State in [dsEdit,dsInsert] then
    selT164.Cancel;
  GetTurni;
end;

procedure TA024FIndPresenzaDtM1.Q162AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q162],True);
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TA024FIndPresenzaDtM1.Q162AfterEdit(DataSet: TDataSet);
begin
  Q171.CachedUpdates:=True;
  selT164.CachedUpdates:=True;
end;

procedure TA024FIndPresenzaDtM1.Q162AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=Q162Codice.AsString;
  if Q171.CachedUpdates then
  begin
    if selT164.CachedUpdates then
      SessioneOracle.ApplyUpdates([Q162,Q171,selT164],True)
    else
      SessioneOracle.ApplyUpdates([Q162,Q171],True)
  end
  else
  begin
    if selT164.CachedUpdates then
      SessioneOracle.ApplyUpdates([Q162,selT164],True)
    else
      SessioneOracle.ApplyUpdates([Q162],True);
  end;
  Q171.CachedUpdates:=False;
  selT164.CachedUpdates:=False;
  RegistraLog.RegistraOperazione;
  with Q162 do
  begin
    DisableControls;
    Close;
    Open;
    Locate('Codice',S,[]);
    EnableControls;
  end;
end;

procedure TA024FIndPresenzaDtM1.Q162AfterScroll(DataSet: TDataSet);
begin
  GetTurni;
  with Q171 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Open;
    EnableControls;
  end;
  with Look162 do
  begin
    //DisableControls;
    Close;
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Open;
    //EnableControls;
  end;
  with selT164 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Open;
    EnableControls;
  end;
end;

procedure TA024FIndPresenzaDtM1.Q162BeforeDelete(DataSet: TDataSet);
{Cancellazione della sotto-tabella T171}
begin
  with Del171 do
  begin
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Execute;
  end;
  with delT164 do
  begin
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Execute;
  end;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA024FIndPresenzaDtM1.Q162BeforePost(DataSet: TDataSet);
{Controlli sul numero di turni e lettura dei turni selezionati}
var S,VoceOld,sAltraIndennita:String;
begin
  if Q171.State in [dsEdit,dsInsert] then
    Q171.Post;
  if selT164.State in [dsEdit,dsInsert] then
    selT164.Post;
  if QueryPK1.EsisteChiave('T162_INDENNITA',Q162.RowId,Q162.State,['CODICE'],[Q162Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  if Q162Tipo.AsString = 'A' then
    Q162NumTurni.Value:=Trunc(Q162NumTurni.Value)
  else if Q162Tipo.AsString = 'B' then
    if Q162NumTurni.Value > 100 then
      raise Exception.Create(A000MSG_A089_ERR_PROP_TURNI_PCT);
  //Controllo validità SQL dei campi: MIN_TURNI_PRIORITARI,
                                    //MIN_TURNI_SECONDARI,
                                    //CHECK_GGVALIDO
  VerificaSQL(Q162.FieldByName('MIN_TURNI_PRIORITARI').AsString);
  VerificaSQL(Q162.FieldByName('MIN_TURNI_SECONDARI').AsString);
  //VerificaSQL(Q162.FieldByName('CHECK_GGVALIDO').AsString);

  with A024FRegoleIndennita do
  begin
    if (Q162Tipo.AsString = 'E') then
    begin
      if (trim(Q162.FieldByName('TURNI').AsString)='') then
      begin
        dcmbTurno.SetFocus;
        raise Exception.Create('Indicare il tipo di turno da considerare.');
      end
    end
    else
    begin
      S:='';
      if CB5.Checked then
        S:='<'
      else
      begin
        if CB1.Checked then
          S:=S + '1';
        if CB2.Checked then
          S:=S + '2';
        if CB3.Checked then
          S:=S + '3';
        if CB4.Checked then
          S:=S + '4';
      end;
      Q162.FieldByName('TURNI').AsString:=S;
    end;
    if PAltroCodice.Visible then //Se è visibile il pannello che contiene la combo "Se non soddisfatte le regole vedere l'indennità"
    begin
      sAltraIndennita:=Q162.FieldByName('CODICE2').AsString;
      while sAltraIndennita<>'' do
      begin
        if sAltraIndennita=Q162.FieldByName('CODICE').AsString  then
        begin
          dcmbCodice2.SetFocus;
          raise Exception.Create(Format(A000MSG_A089_ERR_FMT_LEGAME_INDENNITA,[dcmbCodice2.KeyValue]));
        end;
        //Verifico che, tra i puntamenti tra le varie indennità, non vi siano cicli ricorsivi...
        SelQ162.Close;
        SelQ162.SetVariable('CODICE', sAltraIndennita);
        SelQ162.Open;
        if SelQ162.RecordCount > 0 then
          sAltraIndennita:=SelQ162.FieldByName('CODICE2').AsString
        else
          sAltraIndennita:='';
      end;
    end;
  end;
  //Controllo voci paghe
  if (DataSet.State = dsInsert) or (Q162.FieldByName('VOCEPAGHE').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=Q162.FieldByName('VOCEPAGHE').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,Q162.FieldByName('VOCEPAGHE').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(Q162.FieldByName('VOCEPAGHE').AsString);
  try
    //Cambio il codice di T171 se è stato cambiato in T170
    if (Q162.State = dsEdit) and (Q162.FieldByName('CODICE').medpOldValue <> Q162.FieldByName('CODICE').Value) then
    begin
      with Upd171 do
      begin
        SetVariable('CODICEOLD',Q162.FieldByName('CODICE').medpOldValue);
        SetVariable('CODICENEW',Q162.FieldByName('CODICE').Value);
        Execute;
      end;
      with updT164 do
      begin
        SetVariable('CODICEOLD',Q162.FieldByName('CODICE').medpOldValue);
        SetVariable('CODICENEW',Q162.FieldByName('CODICE').Value);
        Execute;
      end;
    end;
  except
  end;
  if not (R180CarattereDef(Q162.FieldByName('TIPO').AsString) in ['A','B','P']) or (not Q162.FieldByName('CODICE2').IsNull) then
    Q162.FieldByName('NMESI_EQUITURNI').AsInteger:=1;

  A024MW.selT162BeforePost(DataSet);

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA024FIndPresenzaDtM1.Q171NewRecord(DataSet: TDataSet);
begin
  Q171.FieldByName('CODICE').AsString:=Q162.FieldByName('CODICE').AsString;
end;

procedure TA024FIndPresenzaDtM1.GetTurni;
{Trasformazione del dato TURNI sui CheckBox}
begin
  with A024FRegoleIndennita do
    try
      CB5.Checked:=Q162.FieldByName('TURNI').AsString = '<';
      CB1.Checked:=Pos('1',Q162.FieldByName('TURNI').AsString) > 0;
      CB2.Checked:=Pos('2',Q162.FieldByName('TURNI').AsString) > 0;
      CB3.Checked:=Pos('3',Q162.FieldByName('TURNI').AsString) > 0;
      CB4.Checked:=Pos('4',Q162.FieldByName('TURNI').AsString) > 0;
    except
    end;
end;


procedure TA024FIndPresenzaDtM1.Q162NewRecord(DataSet: TDataSet);
begin
  Q162.FieldByName('TIPO').AsString:='Z';
  Q162.FieldByName('NUMTURNI').AsInteger:=0;
end;

procedure TA024FIndPresenzaDtM1.BDEQ162CODICEValidate(Sender: TField);
begin
  with Look162 do
  begin
    DisableControls;
    Close;
    SetVariable('CODICE',Q162.FieldByName('CODICE').AsString);
    Open;
    EnableControls;
  end;
end;

procedure TA024FIndPresenzaDtM1.BDEQ162TIPOValidate(Sender: TField);
begin
  if not IndennitaTurno then
    if (Sender.AsString <> 'Z') and (Sender.AsString <> 'F') and (Sender.AsString <> 'G') and (Sender.AsString <> 'H') then
      raise Exception.Create(A000MSG_A089_ERR_TIPO_NON_DISPONIBILE);
end;

procedure TA024FIndPresenzaDtM1.Q163ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: String);
begin
  case Action of
    'U':with Upd160 do
        begin
          SetVariable('NEW_CODICE',Q163.FieldByName('CODICE').Value);
          SetVariable('OLD_CODICE',Q163.FieldByName('CODICE').medpOldValue);
          Execute;
        end;
    'D':with Del160 do
        begin
          SetVariable('CODICE',Q163.FieldByName('CODICE').medpOldValue);
          Execute;
        end;
  end;
end;

procedure TA024FIndPresenzaDtM1.Q160ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: String);
begin
  Applied:=True;
  case Action of
    'I':begin
        Ins160.SetVariable('CODICE',Q163.FieldByName('CODICE').AsString);
        Ins160.SetVariable('INDENNITA',Q160.FieldByName('INDENNITA').Value);
        Ins160.Execute;
        RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),Copy(Name,1,4),nil,True);
        RegistraLog.InserisciDato('CODICE','',Q163.FieldByName('CODICE').AsString);
        RegistraLog.InserisciDato('INDENNITA','',Q160.FieldByName('INDENNITA').Value);
        end;
    'U':begin
        Update160.SetVariable('INDENNITA',Q160.FieldByName('INDENNITA').Value);
        Update160.SetVariable('OLD_CODICE',Q160.FieldByName('CODICE').medpOldValue);
        Update160.SetVariable('OLD_INDENNITA',Q160.FieldByName('INDENNITA').medpOldValue);
        Update160.Execute;
        RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
        end;
    'D':begin
        Delete160.SetVariable('OLD_CODICE',Q160.FieldByName('CODICE').medpOldValue);
        Delete160.SetVariable('OLD_INDENNITA',Q160.FieldByName('INDENNITA').medpOldValue);
        Delete160.Execute;
        RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
        end;
  end;
  RegistraLog.RegistraOperazione;
end;

procedure TA024FIndPresenzaDtM1.selT164NewRecord(DataSet: TDataSet);
begin
  selT164.FieldByName('CODICE').AsString:=Q162.FieldByName('CODICE').AsString;
end;

procedure TA024FIndPresenzaDtM1.selT164SCADENZAValidate(Sender: TField);
begin
  if (not selT164.FieldByName('SCADENZA').IsNull) and
     (selT164.FieldByName('SCADENZA').AsDateTime < selT164.FieldByName('DECORRENZA').AsDateTime) then
    raise Exception.Create('Data scadenza non valida!');
end;

end.

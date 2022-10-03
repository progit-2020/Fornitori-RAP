unit ControlloVociPaghe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  Db, OracleData, Oracle, Variants, C180FunzioniGenerali, A000UCostanti, A000UInterfaccia;

type
  TControlloVociPaghe = class(TOracleDataSet)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    MessaggioLog,Funzione:String;
    Storicizzazione:Boolean;
    QueryInsT193: TOracleQuery;
    constructor Create(AOwner:TComponent; F:String);
    destructor Destroy; override;
    function ControlloVociPaghe(VoceOld,VoceNew:String):Boolean;
    function ValutaInserimentoVocePaghe(Voce: String): Boolean;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TControlloVociPaghe]);
end;

constructor TControlloVociPaghe.Create(AOwner:TComponent; F:String);
begin
  inherited Create(AOwner);
  Funzione:=F;
  ReadBuffer:=1;
  Session:=SessioneOracle;
  SQL.Clear;
  SQL.Add('SELECT DISTINCT T193.VOCE_PAGHE_CEDOLINO, T195.COD_INTERNO');
  SQL.Add('  FROM T193_VOCIPAGHE_PARAMETRI T193, T195_VOCIVARIABILI T195');
  SQL.Add(' WHERE T193.VOCE_PAGHE_CEDOLINO = T195.VOCEPAGHE');
  if F = 'A034' then
    SQL.Add('   AND T193.VOCE_PAGHE_CEDOLINO = :VOCE')
  else
    SQL.Add('   AND T193.VOCE_PAGHE = :VOCE');
  DeclareVariable('VOCE',otString);
  MessaggioLog:='';
  Storicizzazione:=False;
  
  // query per inserimento automatico della voce paghe sulla T193 (per ogni interfaccia)
  QueryInsT193:=TOracleQuery.Create(nil);
  try
    with QueryInsT193 do
    begin
      Session:=SessioneOracle;
      DeclareVariable('VOCE_PAGHE', otString);

      SQL.Add('DECLARE');
      SQL.Add('  cursor C1 is');
      SQL.Add('    select distinct CODICE from T190_INTERFACCIAPAGHE;');
      SQL.Add('  NREC number;');
      SQL.Add('BEGIN');
      SQL.Add('  for T1 in C1 LOOP');
      SQL.Add('    select count(*) into NREC from T193_VOCIPAGHE_PARAMETRI');
      SQL.Add('    where COD_INTERFACCIA = T1.CODICE and VOCE_PAGHE = :VOCE_PAGHE;');
      SQL.Add('    if (NREC = 0) then');
      SQL.Add('      insert into T193_VOCIPAGHE_PARAMETRI');
      SQL.Add('       (COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO)');
      SQL.Add('      values');
      SQL.Add('       (T1.CODICE, :VOCE_PAGHE, TO_DATE(''01011900'',''DDMMYYYY''), :VOCE_PAGHE);');
      SQL.Add('    end if;');
      SQL.Add('  end loop;');
      SQL.Add('END;');
    end;
  except
    QueryInsT193:=nil;
  end;
end;

function TControlloVociPaghe.ControlloVociPaghe(VoceOld,VoceNew:String):Boolean;
var S,S1:String;
  i:Integer;
begin
  Result:=True;
  MessaggioLog:='';
  if VoceNew <> VoceOld then
  begin
    if Trim(VoceNew) = '' then
    begin
      //Pulizia voce paga esistente
      Close;
      SetVariable('VOCE',VoceOld);
      Open;
      First;
      S:='';
      while not Eof do
      begin
        if Pos(FieldByName('VOCE_PAGHE_CEDOLINO').AsString,S) <= 0 then
        begin
          if Trim(S) <> '' then
            S:=S + ',';
          S:=S + FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
        end;
        Next;
      end;
      MessaggioLog:='Attenzione: la voce ' + VoceOld + ' ';
      if (Funzione <> 'A034') and (Trim(S) <> '') then
        MessaggioLog:=MessaggioLog + 'corrispondente alle Voci paghe cedolino ' + S + #$D#$A;
      MessaggioLog:=MessaggioLog + 'verrà disattivata e non passerà più alla procedura Paghe.' + #$D#$A + 'Continuare?';
      Result:=False;
    end
    else
    begin
      //Controllo su vecchia voce paga modificata
      if (Trim(VoceOld) <> '') and (not Storicizzazione) then
      begin
        Close;
        SetVariable('VOCE',VoceOld);
        Open;
        First;
        S:='';
        while not Eof do
        begin
          if Pos(FieldByName('VOCE_PAGHE_CEDOLINO').AsString,S) <= 0 then
          begin
            if Trim(S) <> '' then
              S:=S + ',';
            S:=S + FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
          end;
          if Pos(FieldByName('COD_INTERNO').AsString,S1) <= 0 then
          begin
            for i:=1 to High(VettConst) do
              if FieldByName('COD_INTERNO').AsString = VettConst[i].CodInt then
              begin
                S1:=S1 + FieldByName('COD_INTERNO').AsString + ' ' + VettConst[i].Descrizione + #$D#$A;
                Break;
              end;
          end;
          Next;
        end;
        if Trim(S) <> '' then
        begin
          MessaggioLog:='Attenzione: la voce ' + VoceOld + ' ';
          if Funzione <> 'A034' then
            MessaggioLog:=MessaggioLog + 'corrispondente alle Voci paghe cedolino ' + S + #$D#$A;
          MessaggioLog:=MessaggioLog +
                        'è stata usata nello scarico alla procedura Paghe dei seguenti dati: ' + #$D#$A + S1 +
                        'Consigliamo di NON continuare nella modifica e di effettuare la storicizzazione della voce';
          if Funzione <> 'A034' then
            MessaggioLog:=MessaggioLog + ' dall''apposita funzione ''Attivazione voci variabili\Parametri avanzati''';
          MessaggioLog:=MessaggioLog + '.' + #$D#$A + 'Continuare?';
          Result:=False;
          Exit;
        end;
      end;
      //Controllo su nuova voce paga
      Close;
      SetVariable('VOCE',VoceNew);
      Open;
      First;
      S:='';
      S1:='';
      MessaggioLog:='';
      while not Eof do
      begin
        if Pos(FieldByName('VOCE_PAGHE_CEDOLINO').AsString,S) <= 0 then
        begin
          if Trim(S) <> '' then
            S:=S + ',';
          S:=S + FieldByName('VOCE_PAGHE_CEDOLINO').AsString;
        end;
        if Pos(FieldByName('COD_INTERNO').AsString,S1) <= 0 then
        begin
          for i:=1 to High(VettConst) do
            if FieldByName('COD_INTERNO').AsString = VettConst[i].CodInt then
            begin
              S1:=S1 + FieldByName('COD_INTERNO').AsString + ' ' + VettConst[i].Descrizione + #$D#$A;
              Break;
            end;
        end;
        Next;
      end;
      if Trim(S) <> '' then
      begin
        MessaggioLog:='Attenzione: la nuova voce ' + VoceNew + ' è già stata usata nello scarico alla procedura Paghe dei seguenti dati:' + #$D#$A + S1;
        if Funzione <> 'A034' then
          MessaggioLog:=MessaggioLog + 'con le corrispondenti Voci paghe cedolino: ' + S + #$D#$A;
      end;
      if Funzione <> 'A034' then
      begin
        // l'inserimento della nuova voce viene fatto in automatico (solo se non ci sono avvertimenti)
        {
        MessaggioLog:=MessaggioLog +
                      'N.B.: Se si vuole rendere effettiva la nuova voce ' + VoceNew +  ' nello Scarico paghe,' + #$D#$A +
                      'ricordarsi di specificare la corrispondente Voce paga cedolino dall''apposita' + #$D#$A +
                      'funzione ''Attivazione voci variabili\Parametri avanzati.''' + #$D#$A;
        }
        if Trim(MessaggioLog) = '' then
          ValutaInserimentoVocePaghe(VoceNew);
      end;
      if Trim(MessaggioLog) <> '' then
      begin
        MessaggioLog:=MessaggioLog + 'Continuare?';
        Result:=False;
      end;
    end;
  end;
end;

function TControlloVociPaghe.ValutaInserimentoVocePaghe(Voce: String): Boolean;
{ Se la voce paghe non è presente nella tabella T193_VOCIPAGHE_PARAMETRI,
  ne esegue l'inserimento (un record per ogni interfaccia di T190_INTERFACCIAPAGHE) }
var
  Msg: String;
begin
  Result:=False;

  // termina se l'oggetto oraclequery di supporto non è stato creato
  if QueryInsT193 = nil then
    Exit;

  // termina se la voce paghe data è nulla
  if Trim(Voce) = '' then
    Exit;

  // esegue l'inserimento della voce paghe con lo script definito nella oraclequery
  try
    QueryInsT193.SetVariable('VOCE_PAGHE', Voce);
    QueryInsT193.Execute;
    SessioneOracle.Commit;
    Result:=True;
  except
    on E:Exception do
    begin
      Msg:='Anomalia rilevata durante inserimento voce paghe ' + Voce + #13#10 + E.Message;
      {$IFDEF IRISWEB}
      MsgBox.MessageBox(Msg,ESCLAMA);
      {$ELSE}
      R180MessageBox(Msg,ESCLAMA);
      {$ENDIF}
      Result:=False;
    end;
  end;
end;

destructor TControlloVociPaghe.Destroy;
begin
  Close;
  FreeAndNil(QueryInsT193);
  inherited Destroy;
end;

end.
